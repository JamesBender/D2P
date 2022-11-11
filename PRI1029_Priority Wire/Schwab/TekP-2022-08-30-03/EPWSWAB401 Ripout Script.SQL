/**********************************************************************************

EPWSWAB401: Charles Schwab TPA 401K

FormatCode:     EPWSWAB401
Project:        Charles Schwab TPA 401K
Client ID:      PRI1029
Date/time:      2022-11-10 13:29:01.097
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB03
Database:       ULTIPRO_WPPWC
Web Filename:   PRI1029_3Y7VH_EEHISTORY_EPWSWAB401_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPWSWAB401_SavePath') IS NOT NULL DROP TABLE dbo.U_EPWSWAB401_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPWSWAB401'


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
WHERE FormatCode = 'EPWSWAB401'
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
WHERE ExpFormatCode = 'EPWSWAB401'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPWSWAB401')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPWSWAB401'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPWSWAB401'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPWSWAB401'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPWSWAB401'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPWSWAB401'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPWSWAB401'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPWSWAB401'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPWSWAB401'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPWSWAB401'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPWSWAB401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPWSWAB401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPWSWAB401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPWSWAB401];
GO
IF OBJECT_ID('U_EPWSWAB401_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EPWSWAB401_Trailer];
GO
IF OBJECT_ID('U_EPWSWAB401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPWSWAB401_PEarHist];
GO
IF OBJECT_ID('U_EPWSWAB401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPWSWAB401_PDedHist];
GO
IF OBJECT_ID('U_EPWSWAB401_File') IS NOT NULL DROP TABLE [dbo].[U_EPWSWAB401_File];
GO
IF OBJECT_ID('U_EPWSWAB401_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPWSWAB401_EEList];
GO
IF OBJECT_ID('U_EPWSWAB401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPWSWAB401_drvTbl];
GO
IF OBJECT_ID('U_EPWSWAB401_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPWSWAB401_DedList];
GO
IF OBJECT_ID('U_EPWSWAB401_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPWSWAB401_AuditFields];
GO
IF OBJECT_ID('U_EPWSWAB401_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPWSWAB401_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EPWSWAB401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPWSWAB401];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EPWSWAB401','Charles Schwab TPA 401K','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EPWSWAB401Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPWSWAB401Z0','3','D','10','1',NULL,'Record ID',NULL,NULL,'"drvRecordID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPWSWAB401Z0','3','D','10','4',NULL,'Plan ID',NULL,NULL,'"drvPlanID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPWSWAB401Z0','11','D','10','7',NULL,'Social Security Number',NULL,NULL,'"drvSocialSecurityNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPWSWAB401Z0','32','D','10','18',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPWSWAB401Z0','12','D','10','50',NULL,'Pretax',NULL,NULL,'"drvPretax"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPWSWAB401Z0','12','D','10','62',NULL,'Roth Bonus',NULL,NULL,'"drvRothBonus1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPWSWAB401Z0','12','D','10','74',NULL,'Pre-Tax Bonus',NULL,NULL,'"drvPreTaxBonus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPWSWAB401Z0','12','D','10','86',NULL,'Roth Bonus',NULL,NULL,'"drvRothBonus2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPWSWAB401Z0','12','D','10','98',NULL,'Contribution Source 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPWSWAB401Z0','12','D','10','110',NULL,'Contribution Source 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPWSWAB401Z0','12','D','10','122',NULL,'Contribution Source 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPWSWAB401Z0','12','D','10','134',NULL,'Contribution Source 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPWSWAB401Z0','12','D','10','146',NULL,'Contribution Source 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPWSWAB401Z0','12','D','10','158',NULL,'Contribution Source 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPWSWAB401Z0','12','D','10','170',NULL,'Loan Payment #1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPWSWAB401Z0','12','D','10','182',NULL,'Loan Payment #2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPWSWAB401Z0','12','D','10','194',NULL,'Loan Payment #3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPWSWAB401Z0','12','D','10','206',NULL,'Loan Payment #4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPWSWAB401Z0','12','D','10','218',NULL,'Loan Payment #5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPWSWAB401Z0','12','D','10','230',NULL,'Pay Period Deferral Eligible Compensation',NULL,NULL,'"drvPayPeriodDeferralEligComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPWSWAB401Z0','12','D','10','242',NULL,'Pay Period Plan Testing Compensation',NULL,NULL,'"drvPayPeriodPlanTestComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPWSWAB401Z0','12','D','10','254',NULL,'Pay Period Gross/Total Compensation',NULL,NULL,'"drvPayPeriodGrossTotalComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPWSWAB401Z0','12','D','10','266',NULL,'Pay Period Additional Compensation',NULL,NULL,'"drvPayPeriodAdditionalComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPWSWAB401Z0','4','D','10','278',NULL,'Pay Period Hours Paid',NULL,NULL,'"drvPayPeriodHoursPaid"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPWSWAB401Z0','12','D','10','282',NULL,'YTD Pre-Tax',NULL,NULL,'"drvYTDPreTax"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPWSWAB401Z0','12','D','10','294',NULL,'YTD Roth',NULL,NULL,'"drvYTDRoth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPWSWAB401Z0','12','D','10','306',NULL,'YTD Pre-tax Bonus',NULL,NULL,'"drvYTDPretaxBonus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPWSWAB401Z0','12','D','10','318',NULL,'Roth Bonus',NULL,NULL,'"drvRothBonusYTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPWSWAB401Z0','12','D','10','330',NULL,'Plan YTD Contribution Source 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPWSWAB401Z0','12','D','10','342',NULL,'Plan YTD Contribution Source 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPWSWAB401Z0','12','D','10','354',NULL,'Plan YTD Contribution Source 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPWSWAB401Z0','12','D','10','366',NULL,'Plan YTD Contribution Source 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPWSWAB401Z0','12','D','10','378',NULL,'Plan YTD Contribution Source 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPWSWAB401Z0','12','D','10','390',NULL,'Plan YTD Contribution Source 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPWSWAB401Z0','12','D','10','402',NULL,'YTD Deferral Eligible Compensation',NULL,NULL,'"drvYTDDeferralEligibleComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPWSWAB401Z0','12','D','10','414',NULL,'YTD Plan Testing Compensation',NULL,NULL,'"drvYTDPlanTestComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPWSWAB401Z0','12','D','10','426',NULL,'YTD Gross/Total Compensation',NULL,NULL,'"drvYTDGrossTotalComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPWSWAB401Z0','12','D','10','438',NULL,'YTD Additional Compensation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPWSWAB401Z0','12','D','10','450',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPWSWAB401Z0','4','D','10','462',NULL,'Plan YTD Hours Paid',NULL,NULL,'"drvPlanYTDHoursPaid"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPWSWAB401Z0','1','D','10','466',NULL,'Pay Frequency',NULL,NULL,'"drvPayFrequency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPWSWAB401Z0','40','D','10','467',NULL,'Primary Address Line #1',NULL,NULL,'"drvPrimaryAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPWSWAB401Z0','40','D','10','507',NULL,'Primary Address Line #2',NULL,NULL,'"drvPrimaryAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPWSWAB401Z0','80','D','10','547',NULL,'Primary City',NULL,NULL,'"drvPrimaryCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPWSWAB401Z0','2','D','10','627',NULL,'Primary State',NULL,NULL,'"drvPrimaryState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPWSWAB401Z0','10','D','10','629',NULL,'Primary Zip Code',NULL,NULL,'"drvPrimaryZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPWSWAB401Z0','30','D','10','639',NULL,'Primary Country',NULL,NULL,'"drvPrimaryCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPWSWAB401Z0','1','D','10','669',NULL,'Foreign Address Indicator',NULL,NULL,'"drvForeignAddressIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPWSWAB401Z0','8','D','10','670',NULL,'Birth Date',NULL,NULL,'"drvBirthDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPWSWAB401Z0','8','D','10','678',NULL,'Hire Date (original)',NULL,NULL,'"drvHireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPWSWAB401Z0','8','D','10','686',NULL,'Plan Entry Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPWSWAB401Z0','8','D','10','694',NULL,'Plan Entry Date (for another source with different',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPWSWAB401Z0','8','D','10','702',NULL,'Plan Entry Date (for another source with different',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPWSWAB401Z0','8','D','10','710',NULL,'Plan Entry Date (for another source with different',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPWSWAB401Z0','8','D','10','718',NULL,'Termination Date (if applicable)',NULL,NULL,'"drvTerminationDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EPWSWAB401Z0','8','D','10','726',NULL,'Rehire Date (date of most recent rehire)',NULL,NULL,'"drvRehireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EPWSWAB401Z0','8','D','10','734',NULL,'Alternate Vesting Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EPWSWAB401Z0','1','D','10','742',NULL,'Restricted Status (officer status field)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EPWSWAB401Z0','5','D','10','743',NULL,'Loan Restriction',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EPWSWAB401Z0','1','D','10','748',NULL,'Collective Bargaining Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EPWSWAB401Z0','1','D','10','749',NULL,'Payroll Status',NULL,NULL,'"drvPayrollStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EPWSWAB401Z0','1','D','10','750',NULL,'Highly Compensated Status (HCE)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EPWSWAB401Z0','1','D','10','751',NULL,'Ineligible Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EPWSWAB401Z0','15','D','10','752',NULL,'Pay Location',NULL,NULL,'"drvPayLocation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EPWSWAB401Z0','5','D','10','767',NULL,'Reporting Division',NULL,NULL,'"drvReportingDivision"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EPWSWAB401Z0','15','D','10','772',NULL,'Alternate Key #1',NULL,NULL,'"drvAlternateKey1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EPWSWAB401Z0','15','D','10','787',NULL,'Alternate Key #2',NULL,NULL,'"drvAlternateKey2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EPWSWAB401Z0','5','D','10','802',NULL,'Transfer Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EPWSWAB401Z0','15','D','10','807',NULL,'Work/Home Telephone Number',NULL,NULL,'"drvWorkHomeTelephoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EPWSWAB401Z0','50','D','10','822',NULL,'E-mail Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EPWSWAB401Z0','1','D','10','872',NULL,'Language Preference Code',NULL,NULL,'"drvLanguagePreferenceCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EPWSWAB401Z0','1','D','10','873',NULL,'Gender Code',NULL,NULL,'"drvGenderCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EPWSWAB401Z0','1','D','10','874',NULL,'Marital Status – Taxable',NULL,NULL,'"drvMaritalStatusTaxable"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EPWSWAB401Z0','2','D','10','875',NULL,'Federal Exemptions',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EPWSWAB401Z0','1','D','10','877',NULL,'Job Code Indicator',NULL,NULL,'"drvJobCodeIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EPWSWAB401Z0','8','D','10','878',NULL,'Leave of Absence – Start Date',NULL,NULL,'"drvLeaveofAbsenceStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EPWSWAB401Z0','8','D','10','886',NULL,'Leave of Absence – End Date',NULL,NULL,'"drvLeaveofAbsenceEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EPWSWAB401Z0','1','D','10','894',NULL,'Leave of Absence Indicator',NULL,NULL,'"drvLeaveofAbsenceIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EPWSWAB401Z0','8','D','10','895',NULL,'Retirement Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EPWSWAB401Z0','8','D','10','903',NULL,'Death Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EPWSWAB401Z0','40','D','10','911',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPWSWAB401Z0','3','T','90','1',NULL,'Record ID',NULL,NULL,'"101"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPWSWAB401Z0','3','T','90','4',NULL,'Plan ID',NULL,NULL,'"PCH"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPWSWAB401Z0','43','T','90','7',NULL,'Pay Period Ending Date',NULL,NULL,'"drvPayPeriodEndingDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPWSWAB401Z0','12','T','90','50',NULL,'Contribution Source 1 Total',NULL,NULL,'"drvContributionSource1Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPWSWAB401Z0','12','T','90','62',NULL,'Contribution Source 2 Total',NULL,NULL,'"drvContributionSource2Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPWSWAB401Z0','12','T','90','74',NULL,'Contribution Source 3 Total',NULL,NULL,'"drvContributionSource3Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPWSWAB401Z0','12','T','90','86',NULL,'Contribution Source 4 Total',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPWSWAB401Z0','12','T','90','98',NULL,'Contribution Source 5 Total',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPWSWAB401Z0','12','T','90','110',NULL,'Contribution Source 6 Total',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPWSWAB401Z0','12','T','90','122',NULL,'Contribution Source 7 Total',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPWSWAB401Z0','12','T','90','134',NULL,'Contribution Source 8 Total',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPWSWAB401Z0','12','T','90','146',NULL,'Contribution Source 9 Total',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPWSWAB401Z0','12','T','90','158',NULL,'Contribution Source 10 Total',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPWSWAB401Z0','12','T','90','170',NULL,'Loan Payment #1 Total',NULL,NULL,'"drvLoanPaymentTotal"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPWSWAB401Z0','12','T','90','182',NULL,'Loan Payment #2 Total',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPWSWAB401Z0','12','T','90','194',NULL,'Loan Payment #3 Total',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPWSWAB401Z0','12','T','90','206',NULL,'Loan Payment #4 Total',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPWSWAB401Z0','12','T','90','218',NULL,'Loan Payment #5 Total',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPWSWAB401_20221110.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Charles Schwab TPA 401K','202211019','EMPEXPORT','ONDEM_XOE',NULL,'EPWSWAB401',NULL,NULL,NULL,'202211019','Nov  1 2022  2:56PM','Nov  1 2022  2:56PM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Charles Schwab TPA 401K-Sched','202211019','EMPEXPORT','SCH_EPWSWA',NULL,'EPWSWAB401',NULL,NULL,NULL,'202211019','Nov  1 2022  2:56PM','Nov  1 2022  2:56PM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Charles Schwab TPA 401K-Test','202211019','EMPEXPORT','TEST_XOE',NULL,'EPWSWAB401',NULL,NULL,NULL,'202211019','Nov  1 2022  2:56PM','Nov  1 2022  2:56PM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWSWAB401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWSWAB401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWSWAB401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWSWAB401','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWSWAB401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWSWAB401','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPWSWAB401','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPWSWAB401','D10','dbo.U_EPWSWAB401_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPWSWAB401','T90','dbo.U_EPWSWAB401_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EPWSWAB401
-----------

IF OBJECT_ID('U_dsi_BDM_EPWSWAB401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPWSWAB401] (
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
-- Create table U_EPWSWAB401_Audit
-----------

IF OBJECT_ID('U_EPWSWAB401_Audit') IS NULL
CREATE TABLE [dbo].[U_EPWSWAB401_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
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
-- Create table U_EPWSWAB401_AuditFields
-----------

IF OBJECT_ID('U_EPWSWAB401_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPWSWAB401_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EPWSWAB401_DedList
-----------

IF OBJECT_ID('U_EPWSWAB401_DedList') IS NULL
CREATE TABLE [dbo].[U_EPWSWAB401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPWSWAB401_drvTbl
-----------

IF OBJECT_ID('U_EPWSWAB401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPWSWAB401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvRecordID] varchar(3) NOT NULL,
    [drvPlanID] varchar(3) NOT NULL,
    [drvSocialSecurityNumber] varchar(13) NULL,
    [drvEmployeeName] varchar(206) NULL,
    [drvPretax] nvarchar(4000) NULL,
    [drvRothBonus1] nvarchar(4000) NULL,
    [drvPreTaxBonus] nvarchar(4000) NULL,
    [drvRothBonus2] nvarchar(4000) NULL,
    [drvPayPeriodDeferralEligComp] nvarchar(4000) NULL,
    [drvPayPeriodPlanTestComp] nvarchar(4000) NULL,
    [drvPayPeriodGrossTotalComp] nvarchar(4000) NULL,
    [drvPayPeriodAdditionalComp] nvarchar(4000) NULL,
    [drvPayPeriodHoursPaid] nvarchar(4000) NULL,
    [drvYTDPreTax] nvarchar(4000) NULL,
    [drvYTDRoth] nvarchar(4000) NULL,
    [drvYTDPretaxBonus] nvarchar(4000) NULL,
    [drvRothBonusYTD] nvarchar(4000) NULL,
    [drvYTDDeferralEligibleComp] nvarchar(4000) NOT NULL,
    [drvYTDPlanTestComp] nvarchar(4000) NOT NULL,
    [drvYTDGrossTotalComp] nvarchar(4000) NOT NULL,
    [drvSalary] nvarchar(4000) NOT NULL,
    [drvPlanYTDHoursPaid] nvarchar(4000) NULL,
    [drvPayFrequency] varchar(1) NULL,
    [drvPrimaryAddressLine1] varchar(6000) NULL,
    [drvPrimaryAddressLine2] varchar(6000) NULL,
    [drvPrimaryCity] varchar(6000) NULL,
    [drvPrimaryState] varchar(6000) NULL,
    [drvPrimaryZipCode] varchar(50) NULL,
    [drvPrimaryCountry] char(3) NULL,
    [drvForeignAddressIndicator] varchar(1) NOT NULL,
    [drvBirthDate] varchar(8000) NULL,
    [drvHireDate] varchar(8000) NULL,
    [drvTerminationDate] varchar(8000) NULL,
    [drvRehireDate] varchar(8000) NULL,
    [drvPayrollStatus] char(1) NULL,
    [drvPayLocation] char(6) NULL,
    [drvReportingDivision] varchar(10) NULL,
    [drvAlternateKey1] char(5) NULL,
    [drvAlternateKey2] char(9) NULL,
    [drvWorkHomeTelephoneNumber] varchar(12) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvLanguagePreferenceCode] char(2) NOT NULL,
    [drvGenderCode] char(1) NULL,
    [drvMaritalStatusTaxable] char(1) NULL,
    [drvJobCodeIndicator] char(1) NULL,
    [drvLeaveofAbsenceStartDate] varchar(8000) NULL,
    [drvLeaveofAbsenceEndDate] varchar(8000) NULL,
    [drvLeaveofAbsenceIndicator] varchar(1) NULL
);

-----------
-- Create table U_EPWSWAB401_EEList
-----------

IF OBJECT_ID('U_EPWSWAB401_EEList') IS NULL
CREATE TABLE [dbo].[U_EPWSWAB401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPWSWAB401_File
-----------

IF OBJECT_ID('U_EPWSWAB401_File') IS NULL
CREATE TABLE [dbo].[U_EPWSWAB401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EPWSWAB401_PDedHist
-----------

IF OBJECT_ID('U_EPWSWAB401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPWSWAB401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401EE] numeric NULL,
    [PdhRothEE] numeric NULL,
    [Pdh401FBEE] numeric NULL,
    [Pdh401PBEE] numeric NULL,
    [Pdh81EE] numeric NULL,
    [Pdh82EE] numeric NULL,
    [PdhRothFBEE] numeric NULL,
    [PdhRothPBEE] numeric NULL,
    [Pdh401ER] numeric NULL,
    [PdhRothER] numeric NULL,
    [Pdh401FBER] numeric NULL,
    [Pdh401PBER] numeric NULL,
    [Pdh81ER] numeric NULL,
    [Pdh82ER] numeric NULL,
    [PdhRothFBER] numeric NULL,
    [PdhRothPBER] numeric NULL,
    [Pdh401TotalEE] numeric NULL,
    [PdhEmpCatch] numeric NULL,
    [PdhROTHTotalER] numeric NULL,
    [pdhLoan] numeric NULL
);

-----------
-- Create table U_EPWSWAB401_PEarHist
-----------

IF OBJECT_ID('U_EPWSWAB401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPWSWAB401_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehCurAmtErnCodes] money NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EPWSWAB401_Trailer
-----------

IF OBJECT_ID('U_EPWSWAB401_Trailer') IS NULL
CREATE TABLE [dbo].[U_EPWSWAB401_Trailer] (
    [drvPayPeriodEndingDate] varchar(8000) NULL,
    [drvContributionSource1Total] numeric NULL,
    [drvContributionSource2Total] numeric NULL,
    [drvContributionSource3Total] numeric NULL,
    [drvLoanPaymentTotal] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPWSWAB401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Priority Wire & Cable 

Created By: Marie Waters
Business Analyst: Cheryl Petitti/Kim Ephraim
Create Date: 11/01/2022
Service Request Number: TekP-2022-08-30-03

Purpose: Charles Schwab TPA 401K

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPWSWAB401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPWSWAB401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPWSWAB401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPWSWAB401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPWSWAB401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPWSWAB401', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPWSWAB401', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPWSWAB401', 'SCH_EPWSWA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPWSWAB401';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPWSWAB401', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPWSWAB401';

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
    DELETE FROM dbo.U_EPWSWAB401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPWSWAB401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EPWSWAB401_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPWSWAB401_AuditFields;
    CREATE TABLE dbo.U_EPWSWAB401_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EPWSWAB401_AuditFields VALUES ('EmpComp','EecDateofTermination');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EPWSWAB401_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPWSWAB401_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EPWSWAB401_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EPWSWAB401_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EPWSWAB401_Audit ON dbo.U_EPWSWAB401_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EPWSWAB401_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EPWSWAB401_Audit WHERE audEEID = xEEID AND audRowNo = 1);

         --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401,401FB,401PB,81.82,ROT,RTHFB,RTHPB,401F,401CF,401P,401CP,ROTH,401M,401L,401L2';

    IF OBJECT_ID('U_EPWSWAB401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPWSWAB401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPWSWAB401_DedList
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

    ---- Required OE parameters
    --IF @ExportCode LIKE '%PASSIVE'
    --BEGIN
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    --END;

    --IF @ExportCode LIKE '%ACTIVE'
    --BEGIN
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    --END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EPWSWAB401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPWSWAB401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401EE     = SUM(CASE WHEN PdhDedCode IN ('401') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRothEE     = SUM(CASE WHEN PdhDedCode IN ('ROT') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401FBEE     = SUM(CASE WHEN PdhDedCode IN ('401FB') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN  ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,Pdh401PBEE     = SUM(CASE WHEN PdhDedCode IN ('401PB') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,Pdh81EE     = SUM(CASE WHEN PdhDedCode IN ('81') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,Pdh82EE    = SUM(CASE WHEN PdhDedCode IN ('82') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhRothFBEE   = SUM(CASE WHEN PdhDedCode IN ('RTHFB') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhRothPBEE   = SUM(CASE WHEN PdhDedCode IN ('RTHPB') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)

        ,Pdh401ER     = SUM(CASE WHEN PdhDedCode IN ('401') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhRothER     = SUM(CASE WHEN PdhDedCode IN ('ROT') THEN PdhERCurAmt ELSE 0.00 END)
        ,Pdh401FBER     = SUM(CASE WHEN PdhDedCode IN ('401FB') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,Pdh401PBER     = SUM(CASE WHEN PdhDedCode IN ('401PB') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,Pdh81ER     = SUM(CASE WHEN PdhDedCode IN ('81') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,Pdh82ER    = SUM(CASE WHEN PdhDedCode IN ('82') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PdhRothFBER   = SUM(CASE WHEN PdhDedCode IN ('RTHFB') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PdhRothPBER   = SUM(CASE WHEN PdhDedCode IN ('RTHPB') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,Pdh401TotalEE = SUM(CASE WHEN PdhDedCode IN  ('401F','401CF', '401P', '401CP') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END) 
        ,PdhEmpCatch = SUM(CASE WHEN PdhDedCode IN  ('ROTH') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END) 
        ,PdhROTHTotalER = SUM(CASE WHEN PdhDedCode IN  ('401M','401F','401CF', '401P', '401CP') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,pdhLoan = SUM(CASE WHEN PdhDedCode IN  ('401L', '401L2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EPWSWAB401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPWSWAB401_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EPWSWAB401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPWSWAB401_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPeriodEndDate       = Max(PrgPeriodEndDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PehCurAmtErnCodes = SUM( CASE WHEN PehEarnCode in ('BEREV', 'CASIC', 'FCRAC', 'FCRAS', 'HOL', 'JURY', 'PERS', 'PTO', 'PVW', 'REG', 'RETRO', 'SICK', 'VAC') then PehCurAmt END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EPWSWAB401_PEarHist
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
    -- DETAIL RECORD - U_EPWSWAB401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPWSWAB401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPWSWAB401_drvTbl;
 SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordID = '100'
        ,drvPlanID = 'PCS'
        ,drvSocialSecurityNumber = Stuff(stuff(eepSSN,6,0,'-'),4,0,'-')
        ,drvEmployeeName = UPPER(CASE WHEN isnull(EepNameMiddle, '') <> '' THEN '"'+Ltrim(rtrim(EepNameLast)) +', ' + ltrim(rtrim(EepNameFirst)) + ' ' + Left(EepNameMiddle, 1)+ '"'
                                ELSE '"'+Ltrim(rtrim(EepNameLast)) +', ' + ltrim(rtrim(EepNameFirst)) + '"' 
                            END)
                        
        ,drvPretax = CASE WHEN (Pdh81EE + Pdh401EE) < 0.00 THEN FORMAT(Pdh81EE + Pdh401EE,'-00000000.00') ELSE ISNULL(FORMAT(Pdh81EE + Pdh401EE,'000000000.00'),'000000000.00') END
        ,drvRothBonus1 = CASE WHEN (Pdh82EE + PdhRothEE) < 0.00 THEN FORMAT(Pdh82EE + PdhRothEE,'-00000000.00') ELSE ISNULL(FORMAT(Pdh82EE + PdhRothEE,'000000000.00'),'000000000.00') END
        ,drvPreTaxBonus = CASE WHEN (Pdh401FBEE + Pdh401PBEE) < 0.00 THEN FORMAT(Pdh401FBEE +Pdh401PBEE,'-00000000.00') ELSE ISNULL(FORMAT(Pdh401FBEE +Pdh401PBEE,'000000000.00'),'000000000.00') END
        ,drvRothBonus2 = CASE WHEN (PdhRothFBEE + PdhRothPBEE)< 0.00 THEN FORMAT(PdhRothFBEE + PdhRothPBEE,'-00000000.00') ELSE  ISNULL(FORMAT(PdhRothFBEE + PdhRothPBEE,'000000000.00'),'000000000.00') END
        ,drvPayPeriodDeferralEligComp =CASE WHEN PehInclInDefComp < 0.00 THEN FORMAT(PehInclInDefComp,'-00000000.00') ELSE  ISNULL( FORMAT(PehInclInDefComp,'000000000.00'),'000000000.00') END
        ,drvPayPeriodPlanTestComp = CASE WHEN PehInclInDefComp < 0.00 THEN FORMAT(PehInclInDefComp,'-00000000.00') ELSE ISNULL(FORMAT(PehInclInDefComp,'000000000.00'),'000000000.00') END 
        ,drvPayPeriodGrossTotalComp = CASE WHEN PehInclInDefComp < 0.00 THEN FORMAT(PehInclInDefComp,'-00000000.00') ELSE ISNULL(FORMAT(PehInclInDefComp,'000000000.00'),'000000000.00') END
        ,drvPayPeriodAdditionalComp = CASE WHEN PehInclInDefComp < 0.00 THEN FORMAT(PehInclInDefComp,'-00000000.00') ELSE ISNULL(FORMAT(PehInclInDefComp,'000000000.00'),'000000000.00') END
        ,drvPayPeriodHoursPaid = FORMAT(PehCurHrs,'0000') 
        ,drvYTDPreTax = CASE WHEN (Pdh401ER + Pdh81ER) < 0.00 THEN FORMAT(Pdh401ER + Pdh81ER,'-00000000.00') ELSE ISNULL(FORMAT(Pdh401ER + Pdh81ER,'000000000.00'),'000000000.00') END
        ,drvYTDRoth = CASE WHEN (Pdh82ER + PdhRothER) < 0.00 THEN FORMAT(Pdh82ER + PdhRothER,'-00000000.00') ELSE ISNULL(FORMAT(Pdh82ER + PdhRothER,'000000000.00'),'000000000.00') END
        ,drvYTDPretaxBonus = CASE WHEN (Pdh401FBER +Pdh401PBER) < 0.00 THEN FORMAT(Pdh401FBER +Pdh401PBER,'-00000000.00') ELSE ISNULL(FORMAT(Pdh401FBER +Pdh401PBER,'000000000.00'),'000000000.00') END
        ,drvRothBonusYTD = CASE WHEn (PdhRothFBER + PdhRothPBER) < 0.00 THEN FORMAT(PdhRothFBER + PdhRothPBER,'-00000000.00') ELSE ISNULL(FORMAT(PdhRothFBER + PdhRothPBER,'000000000.00'),'000000000.00') END
        ,drvYTDDeferralEligibleComp = ISNULL(FORMAT(PehCurAmtErnCodes,'000000000.00'),'000000000.00')
        ,drvYTDPlanTestComp = ISNULL(FORMAT(PehCurAmtErnCodes,'000000000.00'),'000000000.00')
        ,drvYTDGrossTotalComp = ISNULL(FORMAT(PehCurAmtErnCodes,'000000000.00'),'000000000.00')
        ,drvSalary = ISNULL(FORMAT(EecAnnSalary,'000000000.00'),'000000000.00')
        ,drvPlanYTDHoursPaid = FORMAT(PehCurHrsYTD,'0000')
        ,drvPayFrequency = CASE WHEN PgrPayFrequency = 'W' THEN 'W'
                                WHEN PgrPayFrequency = 'M' THEN 'M'
                                WHEN PgrPayFrequency = 'B' THEN 'B'
                                WHEN PgrPayFrequency = 'S' THEN 'S'
                                WHEN PgrPayFrequency = 'Q' THEN 'Q'
                            END
        ,drvPrimaryAddressLine1 = UPPER(dbo.dsi_fnRemoveChars(',',EepAddressLine1))
        ,drvPrimaryAddressLine2 = UPPER(dbo.dsi_fnRemoveChars(',',EepAddressLine2))
        ,drvPrimaryCity = UPPER(dbo.dsi_fnRemoveChars(',',EepAddressCity))
        ,drvPrimaryState = UPPER(dbo.dsi_fnRemoveChars(',',EepAddressState))
        ,drvPrimaryZipCode = EepAddressZipCode
        ,drvPrimaryCountry = EepAddressCountry
        ,drvForeignAddressIndicator = ''
        ,drvBirthDate = replace(convert(char(10), EepDateOfBirth, 101), '/', '')
        ,drvHireDate = replace(convert(char(10), EecDateOfOriginalHire, 101), '/', '') 
        ,drvTerminationDate =replace(convert(char(10), EecDateOfTermination, 101), '/', '') 
        ,drvRehireDate = replace(convert(char(10), EecDateOfLastHire, 101), '/', '') 
        ,drvPayrollStatus = eecemplstatus                                
        ,drvPayLocation = EecPayGroup
        ,drvReportingDivision = Eecorglvl4
        ,drvAlternateKey1 = CmpCompanyCode
        ,drvAlternateKey2 = EecEmpNo
        ,drvWorkHomeTelephoneNumber = CASE WHEN ISNULL(EecPhoneBusinessNumber,'') <> ''  THEN LEFT(EecPhoneBusinessNumber, 3) + '-' + SUBSTRING(EecPhoneBusinessNumber, 3, 3) + '-' + RIGHT(EecPhoneBusinessNumber, 4)  ELSE '501-372-5444' END
        ,drvEmailAddress = EepAddressEMailAlternate
        ,drvLanguagePreferenceCode = EecLanguageCode
        ,drvGenderCode = EepGender
        ,drvMaritalStatusTaxable = CAse WHEN eepMaritalStatus IN ('S', 'M') THEN eepMaritalStatus END
        ,drvJobCodeIndicator = EecFullTimeOrPartTime
        ,drvLeaveofAbsenceStartDate = CASE WHEN EecEmplStatus IN ('L') THEN  replace(convert(char(10), EecEmplStatusStartDate, 101), '/', '') END
        ,drvLeaveofAbsenceEndDate = CASE WHEN EecEmplStatus IN ('A') and EshEmplStatus = 'L' THEN replace(convert(char(10), EshStatusStopDate, 101), '/', '')   END
        ,drvLeaveofAbsenceIndicator = CASE WHEN EecEmplStatus IN ('L') THEN 'L' END
    INTO dbo.U_EPWSWAB401_drvTbl
    FROM dbo.U_EPWSWAB401_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
   JOIN dbo.U_dsi_BDM_EPWSWAB401 WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EPWSWAB401_PEarHist WITH (NOLOCK) 
        ON  peheeid = xeeid
    LEFT JOIN  dbo.U_EPWSWAB401_PDedHist WITH (NOLOCK) 
        ON  pdheeid = xeeid
    LEFT JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN dbo.company WITH (NOLOCK)
        ON CmpCompanyCode = EecCoID
    LEFT JOIN (
                SELECT EshEEID, EshCOID,  EshEmplStatus, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
        
    LEFT JOIN dbo.U_EPWSWAB401_Audit WITH (NOLOCK)
        ON  audeeid = xeeid
        AND audCoID = xCoID
        WHERE eecEEtype <> 'TES'
         AND ( EecEmplstatus <> 'T' OR (EecEmplStatus = 'T' AND  EecDateOfTermination BETWEEN  @StartDate AND @EndDate or (PehCurAmt > 0.00 or PdhEECurAmt > 0.00) )) 
    
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPWSWAB401_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EPWSWAB401_Trailer;
   SELECT DISTINCT
         drvPayPeriodEndingDate = replace(convert(char(10), PrgPeriodEndDate, 101), '/', '')
        ,drvContributionSource1Total = Format(Pdh401TotalEE, '000000000.00')
        ,drvContributionSource2Total = Format(PdhEmpCatch, '000000000.00')
        ,drvContributionSource3Total = Format(PdhRothTotalER, '000000000.00')
        ,drvLoanPaymentTotal = Format(pdhLoan, '000000000.00')
    INTO dbo.U_EPWSWAB401_Trailer
    FROM dbo.U_EPWSWAB401_EEList
    JOIN dbo.U_EPWSWAB401_PDedHist WITH (NOLOCK) 
        ON  pdheeid = xeeid
    JOIN dbo.U_EPWSWAB401_PEarHist WITH (NOLOCK) 
        ON  peheeid = xeeid
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
ALTER VIEW dbo.dsi_vwEPWSWAB401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPWSWAB401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EPWSWAB401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202210151'
       ,expStartPerControl     = '202210151'
       ,expLastEndPerControl   = '202211019'
       ,expEndPerControl       = '202211019'
WHERE expFormatCode = 'EPWSWAB401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPWSWAB401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPWSWAB401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPWSWAB401' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPWSWAB401'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPWSWAB401'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPWSWAB401', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPWSWAB401', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPWSWAB401', 'UseFileName', 'V', 'Y'


-- End ripout