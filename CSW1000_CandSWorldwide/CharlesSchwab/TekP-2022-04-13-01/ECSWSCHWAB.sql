/**********************************************************************************

ECSWSCHWAB: Charles Schwab 401k Export

FormatCode:     ECSWSCHWAB
Project:        Charles Schwab 401k Export
Client ID:      CSW1000
Date/time:      2022-07-08 16:31:30.500
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP2DB02
Database:       ULTIPRO_WPCSW
Web Filename:   CSW1000_92378_EEHISTORY_ECSWSCHWAB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECSWSCHWAB_SavePath') IS NOT NULL DROP TABLE dbo.U_ECSWSCHWAB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECSWSCHWAB'


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
WHERE FormatCode = 'ECSWSCHWAB'
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
WHERE ExpFormatCode = 'ECSWSCHWAB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECSWSCHWAB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECSWSCHWAB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECSWSCHWAB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECSWSCHWAB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECSWSCHWAB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECSWSCHWAB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECSWSCHWAB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECSWSCHWAB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECSWSCHWAB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECSWSCHWAB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECSWSCHWAB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECSWSCHWAB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECSWSCHWAB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECSWSCHWAB];
GO
IF OBJECT_ID('U_ECSWSCHWAB_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECSWSCHWAB_Trailer];
GO
IF OBJECT_ID('U_ECSWSCHWAB_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECSWSCHWAB_PEarHist];
GO
IF OBJECT_ID('U_ECSWSCHWAB_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECSWSCHWAB_PDedHist];
GO
IF OBJECT_ID('U_ECSWSCHWAB_File') IS NOT NULL DROP TABLE [dbo].[U_ECSWSCHWAB_File];
GO
IF OBJECT_ID('U_ECSWSCHWAB_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECSWSCHWAB_EEList];
GO
IF OBJECT_ID('U_ECSWSCHWAB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECSWSCHWAB_drvTbl];
GO
IF OBJECT_ID('U_ECSWSCHWAB_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECSWSCHWAB_DedList];
GO
IF OBJECT_ID('U_ECSWSCHWAB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECSWSCHWAB_AuditFields];
GO
IF OBJECT_ID('U_ECSWSCHWAB_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECSWSCHWAB_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECSWSCHWAB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECSWSCHWAB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECSWSCHWAB','Charles Schwab 401k Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ECSWSCHWABZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECSWSCHWABZ0','3','D','10','1',NULL,'Record ID',NULL,NULL,'"100"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECSWSCHWABZ0','3','D','10','4',NULL,'Plan ID',NULL,NULL,'"CSW"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECSWSCHWABZ0','11','D','10','7',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECSWSCHWABZ0','32','D','10','18',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECSWSCHWABZ0','12','D','10','50',NULL,'Pretax',NULL,NULL,'"drvContribSrc1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECSWSCHWABZ0','12','D','10','62',NULL,'Roth',NULL,NULL,'"drvContribSrc2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECSWSCHWABZ0','12','D','10','74',NULL,'Match',NULL,NULL,'"drvContribSrc3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECSWSCHWABZ0','12','D','10','86',NULL,'Contribution Source 4',NULL,NULL,'"drvContribSrc4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECSWSCHWABZ0','12','D','10','98',NULL,'Contribution Source 5',NULL,NULL,'"drvContribSrc5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECSWSCHWABZ0','12','D','10','110',NULL,'Contribution Source 6',NULL,NULL,'"drvContribSrc6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECSWSCHWABZ0','12','D','10','122',NULL,'Contribution Source 7',NULL,NULL,'"drvContribSrc7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECSWSCHWABZ0','12','D','10','134',NULL,'Contribution Source 8',NULL,NULL,'"drvContribSrc8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECSWSCHWABZ0','12','D','10','146',NULL,'Contribution Source 9',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECSWSCHWABZ0','12','D','10','158',NULL,'Contribution Source 10',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECSWSCHWABZ0','12','D','10','170',NULL,'Loan Payment #1',NULL,NULL,'"drvLoanPayment1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECSWSCHWABZ0','12','D','10','182',NULL,'Loan Payment #2',NULL,NULL,'"drvLoanPayment2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECSWSCHWABZ0','12','D','10','194',NULL,'Loan Payment #3',NULL,NULL,'"drvLoanPayment3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECSWSCHWABZ0','12','D','10','206',NULL,'Loan Payment #4',NULL,NULL,'"drvLoanPayment4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECSWSCHWABZ0','12','D','10','218',NULL,'Loan Payment #5',NULL,NULL,'"drvLoanPayment5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECSWSCHWABZ0','12','D','10','230',NULL,'Pay Period Deferral/Allocation Compensation',NULL,NULL,'"drvPayPerDefAllComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECSWSCHWABZ0','12','D','10','242',NULL,'Pay Period Plan Testing Compensation',NULL,NULL,'"drvPayPerTestingComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECSWSCHWABZ0','12','D','10','254',NULL,'Pay Period Total Compensation',NULL,NULL,'"drvPayPerTotalComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECSWSCHWABZ0','12','D','10','266',NULL,'Pay Period Additional Compensation',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECSWSCHWABZ0','4','D','10','278',NULL,'Pay Period Hours Paid',NULL,NULL,'"drvPayPerHoursPaid"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECSWSCHWABZ0','12','D','10','282',NULL,'Plan YTD Contribution Source 1',NULL,NULL,'"drvPlanYTDConSrc1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECSWSCHWABZ0','12','D','10','294',NULL,'Plan YTD Contribution Source 2',NULL,NULL,'"drvPlanYTDConSrc2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECSWSCHWABZ0','12','D','10','306',NULL,'Plan YTD Contribution Source 3',NULL,NULL,'"drvPlanYTDConSrc3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECSWSCHWABZ0','12','D','10','318',NULL,'Plan YTD Contribution Source 4',NULL,NULL,'"drvPlanYTDConSrc4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECSWSCHWABZ0','12','D','10','330',NULL,'Plan YTD Contribution Source 5',NULL,NULL,'"drvPlanYTDConSrc5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECSWSCHWABZ0','12','D','10','342',NULL,'Plan YTD Contribution Source 6',NULL,NULL,'"drvPlanYTDConSrc6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECSWSCHWABZ0','12','D','10','354',NULL,'Plan YTD Contribution Source 7',NULL,NULL,'"drvPlanYTDConSrc7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECSWSCHWABZ0','12','D','10','366',NULL,'Plan YTD Contribution Source 8',NULL,NULL,'"drvPlanYTDConSrc8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECSWSCHWABZ0','12','D','10','378',NULL,'Plan YTD Contribution Source 9',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECSWSCHWABZ0','12','D','10','390',NULL,'Plan YTD Contribution Source 10',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECSWSCHWABZ0','12','D','10','402',NULL,'Plan YTD Deferral/Allocation Compensation',NULL,NULL,'"drvYTDDefAllocComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECSWSCHWABZ0','12','D','10','414',NULL,'YTD Plan Testing Compensation',NULL,NULL,'"drvYTDPlanTestComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECSWSCHWABZ0','12','D','10','426',NULL,'Plan YTD Total Compensation',NULL,NULL,'"drvYTDPlanTotalComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECSWSCHWABZ0','12','D','10','438',NULL,'YTD Additional Compensation',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECSWSCHWABZ0','12','D','10','450',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECSWSCHWABZ0','4','D','10','462',NULL,'Plan YTD Hours Paid',NULL,NULL,'"drvPlanYTDHoursPaid"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECSWSCHWABZ0','1','D','10','466',NULL,'Pay Frequency',NULL,NULL,'"drvPayFrequency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECSWSCHWABZ0','40','D','10','467',NULL,'Primary Address Line #1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECSWSCHWABZ0','40','D','10','507',NULL,'Primary Address Line #2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECSWSCHWABZ0','80','D','10','547',NULL,'Primary City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECSWSCHWABZ0','2','D','10','627',NULL,'Primary State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECSWSCHWABZ0','10','D','10','629',NULL,'Primary Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECSWSCHWABZ0','30','D','10','639',NULL,'Primary Country',NULL,NULL,'"drvAddressCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECSWSCHWABZ0','1','D','10','669',NULL,'Foreign Address Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECSWSCHWABZ0','8','D','10','670',NULL,'Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECSWSCHWABZ0','8','D','10','678',NULL,'Hire Date (original)',NULL,NULL,'"drvHireDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECSWSCHWABZ0','8','D','10','686',NULL,'Plan Entry Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECSWSCHWABZ0','8','D','10','694',NULL,'Plan Entry Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECSWSCHWABZ0','8','D','10','702',NULL,'Plan Entry Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECSWSCHWABZ0','8','D','10','710',NULL,'Plan Entry Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECSWSCHWABZ0','8','D','10','718',NULL,'Termination Date (if applicable)',NULL,NULL,'"drvTerminationDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECSWSCHWABZ0','8','D','10','726',NULL,'Rehire Date (date of most recent rehire)',NULL,NULL,'"drvRehireDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECSWSCHWABZ0','8','D','10','734',NULL,'Alternate Vesting Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECSWSCHWABZ0','1','D','10','742',NULL,'Restricted Status (officer status field)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECSWSCHWABZ0','5','D','10','743',NULL,'Loan Restriction',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECSWSCHWABZ0','1','D','10','748',NULL,'Collective Bargaining Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECSWSCHWABZ0','1','D','10','749',NULL,'Payroll Status',NULL,NULL,'"drvPayrollStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECSWSCHWABZ0','1','D','10','750',NULL,'Highly Compensated Status (HCE)',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ECSWSCHWABZ0','1','D','10','751',NULL,'Ineligible Status',NULL,NULL,'"drvIneligibleStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ECSWSCHWABZ0','15','D','10','752',NULL,'Pay Location',NULL,NULL,'"drvPayLocation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ECSWSCHWABZ0','5','D','10','767',NULL,'Reporting Division',NULL,NULL,'"drvReportingDivision"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ECSWSCHWABZ0','15','D','10','772',NULL,'Alternate Key #1',NULL,NULL,'"drvAlternateKey1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ECSWSCHWABZ0','15','D','10','787',NULL,'Alternate Key #2',NULL,NULL,'"drvAlternateKey2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ECSWSCHWABZ0','5','D','10','802',NULL,'Transfer Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ECSWSCHWABZ0','15','D','10','807',NULL,'Work/Home Telephone Number',NULL,NULL,'"drvWorkHomePhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ECSWSCHWABZ0','50','D','10','822',NULL,'E-mail Address',NULL,NULL,'"drvAddressEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ECSWSCHWABZ0','1','D','10','872',NULL,'Language Preference Code',NULL,NULL,'"drvLanguageCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ECSWSCHWABZ0','1','D','10','873',NULL,'Gender Code',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ECSWSCHWABZ0','1','D','10','874',NULL,'Marital Status – Taxable',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ECSWSCHWABZ0','2','D','10','875',NULL,'Federal Exemptions',NULL,NULL,'"drvFederalExemptions"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ECSWSCHWABZ0','1','D','10','877',NULL,'Job Code Indicator',NULL,NULL,'"drvJobCodeIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ECSWSCHWABZ0','8','D','10','878',NULL,'Leave of Absence – Start Date',NULL,NULL,'"drvLOAStartDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ECSWSCHWABZ0','8','D','10','886',NULL,'Leave of Absence – End Date',NULL,NULL,'"drvLOAEndDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ECSWSCHWABZ0','1','D','10','894',NULL,'Leave of Absence Indicator',NULL,NULL,'"drvLOAIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ECSWSCHWABZ0','8','D','10','895',NULL,'Retirement Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ECSWSCHWABZ0','8','D','10','903',NULL,'Death Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ECSWSCHWABZ0','40','D','10','911',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECSWSCHWABZ0','3','T','90','1',NULL,'Record ID',NULL,NULL,'"101"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECSWSCHWABZ0','3','T','90','4',NULL,'Plan ID',NULL,NULL,'"CSW"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECSWSCHWABZ0','11','T','90','7',NULL,'Pay Period Ending Date',NULL,NULL,'"drvPayPeriodEndDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECSWSCHWABZ0','49','T','90','18',NULL,'FILLER',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECSWSCHWABZ0','12','T','90','50',NULL,'Contribution Source 1 Total',NULL,NULL,'"drvContribSrc1Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECSWSCHWABZ0','12','T','90','62',NULL,'Contribution Source 2 Total',NULL,NULL,'"drvContribSrc2Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECSWSCHWABZ0','12','T','90','74',NULL,'Contribution Source 3 Total',NULL,NULL,'"drvContribSrc3Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECSWSCHWABZ0','12','T','90','86',NULL,'Contribution Source 4 Total',NULL,NULL,'"drvContribSrc4Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECSWSCHWABZ0','12','T','90','98',NULL,'Contribution Source 5 Total',NULL,NULL,'"drvContribSrc5Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECSWSCHWABZ0','12','T','90','110',NULL,'Contribution Source 6 Total',NULL,NULL,'"drvContribSrc6Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECSWSCHWABZ0','12','T','90','122',NULL,'Contribution Source 7 Total',NULL,NULL,'"drvContribSrc7Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECSWSCHWABZ0','12','T','90','134',NULL,'Contribution Source 8 Total',NULL,NULL,'"drvContribSrc8Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECSWSCHWABZ0','12','T','90','146',NULL,'Contribution Source 9 Total',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECSWSCHWABZ0','12','T','90','158',NULL,'Contribution Source 10 Total',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECSWSCHWABZ0','12','T','90','170',NULL,'Loan Payment #1 Total',NULL,NULL,'"drvLoanPaymentTotal1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECSWSCHWABZ0','12','T','90','182',NULL,'Loan Payment #2 Total',NULL,NULL,'"drvLoanPaymentTotal2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECSWSCHWABZ0','12','T','90','194',NULL,'Loan Payment #3 Total',NULL,NULL,'"drvLoanPaymentTotal3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECSWSCHWABZ0','12','T','90','206',NULL,'Loan Payment #4 Total',NULL,NULL,'"drvLoanPaymentTotal4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECSWSCHWABZ0','12','T','90','218',NULL,'Loan Payment #5 Total',NULL,NULL,'"drvLoanPaymentTotal5"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECSWSCHWAB_20220708.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202207099','EMPEXPORT','OEACTIVE',NULL,'ECSWSCHWAB',NULL,NULL,NULL,'202207099','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202007091',NULL,'','','202007091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202207099','EMPEXPORT','OEPASSIVE',NULL,'ECSWSCHWAB',NULL,NULL,NULL,'202207099','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202007091',NULL,'','','202007091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Charles Schwab 401k Export','202207099','EMPEXPORT','ONDEMAND',NULL,'ECSWSCHWAB',NULL,NULL,NULL,'202207099','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202007091',NULL,'','','202007091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202207099','EMPEXPORT','SCH_CHAEX',NULL,'ECSWSCHWAB',NULL,NULL,NULL,'202207099','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202007091',NULL,'','','202007091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','08G50',NULL,NULL,NULL,'Test Purposes Only','202207099','EMPEXPORT','TEST','Apr 27 2022  6:57PM','ECSWSCHWAB',NULL,NULL,NULL,'202207099','Apr 25 2022 12:00AM','Apr 15 2022 12:00AM','202007091','2198514','eecPayGroup','SQAH,CORP,IR,LIFE,PH,SQRX,SENIR','202007091',dbo.fn_GetTimedKey(),NULL,'us3lKiSEL1005',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSWSCHWAB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSWSCHWAB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSWSCHWAB','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSWSCHWAB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSWSCHWAB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSWSCHWAB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSWSCHWAB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSWSCHWAB','D10','dbo.U_ECSWSCHWAB_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSWSCHWAB','T90','dbo.U_ECSWSCHWAB_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECSWSCHWAB
-----------

IF OBJECT_ID('U_dsi_BDM_ECSWSCHWAB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECSWSCHWAB] (
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
-- Create table U_ECSWSCHWAB_Audit
-----------

IF OBJECT_ID('U_ECSWSCHWAB_Audit') IS NULL
CREATE TABLE [dbo].[U_ECSWSCHWAB_Audit] (
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
-- Create table U_ECSWSCHWAB_AuditFields
-----------

IF OBJECT_ID('U_ECSWSCHWAB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECSWSCHWAB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECSWSCHWAB_DedList
-----------

IF OBJECT_ID('U_ECSWSCHWAB_DedList') IS NULL
CREATE TABLE [dbo].[U_ECSWSCHWAB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECSWSCHWAB_drvTbl
-----------

IF OBJECT_ID('U_ECSWSCHWAB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECSWSCHWAB_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] varchar(11) NULL,
    [drvName] varchar(284) NULL,
    [drvContribSrc1] nvarchar(12) NULL,
    [drvContribSrc2] nvarchar(12) NULL,
    [drvContribSrc3] nvarchar(12) NULL,
    [drvContribSrc4] varchar(12) NOT NULL,
    [drvContribSrc5] varchar(12) NOT NULL,
    [drvContribSrc6] varchar(12) NOT NULL,
    [drvContribSrc7] varchar(12) NOT NULL,
    [drvContribSrc8] varchar(12) NOT NULL,
    [drvLoanPayment1] nvarchar(12) NULL,
    [drvLoanPayment2] varchar(12) NOT NULL,
    [drvLoanPayment3] varchar(12) NOT NULL,
    [drvLoanPayment4] varchar(12) NOT NULL,
    [drvLoanPayment5] varchar(12) NOT NULL,
    [drvPayPerDefAllComp] nvarchar(12) NULL,
    [drvPayPerTestingComp] nvarchar(12) NULL,
    [drvPayPerTotalComp] nvarchar(12) NULL,
    [drvPayPerHoursPaid] nvarchar(4) NULL,
    [drvPlanYTDConSrc1] nvarchar(12) NULL,
    [drvPlanYTDConSrc2] nvarchar(12) NULL,
    [drvPlanYTDConSrc3] nvarchar(12) NULL,
    [drvPlanYTDConSrc4] varchar(12) NOT NULL,
    [drvPlanYTDConSrc5] varchar(12) NOT NULL,
    [drvPlanYTDConSrc6] varchar(12) NOT NULL,
    [drvPlanYTDConSrc7] varchar(12) NOT NULL,
    [drvPlanYTDConSrc8] varchar(12) NOT NULL,
    [drvYTDDefAllocComp] nvarchar(12) NULL,
    [drvYTDPlanTestComp] nvarchar(12) NULL,
    [drvYTDPlanTotalComp] nvarchar(12) NULL,
    [drvSalary] nvarchar(12) NULL,
    [drvPlanYTDHoursPaid] nvarchar(4) NULL,
    [drvPayFrequency] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvPayrollStatus] char(1) NULL,
    [drvIneligibleStatus] varchar(1) NOT NULL,
    [drvPayLocation] char(6) NULL,
    [drvReportingDivision] varchar(1) NOT NULL,
    [drvAlternateKey1] char(9) NULL,
    [drvAlternateKey2] char(5) NULL,
    [drvWorkHomePhone] varchar(25) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvLanguageCode] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvFederalExemptions] varchar(1) NOT NULL,
    [drvJobCodeIndicator] varchar(1) NULL,
    [drvLOAStartDate] datetime NULL,
    [drvLOAEndDate] datetime NULL,
    [drvLOAIndicator] varchar(1) NULL
);

-----------
-- Create table U_ECSWSCHWAB_EEList
-----------

IF OBJECT_ID('U_ECSWSCHWAB_EEList') IS NULL
CREATE TABLE [dbo].[U_ECSWSCHWAB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECSWSCHWAB_File
-----------

IF OBJECT_ID('U_ECSWSCHWAB_File') IS NULL
CREATE TABLE [dbo].[U_ECSWSCHWAB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_ECSWSCHWAB_PDedHist
-----------

IF OBJECT_ID('U_ECSWSCHWAB_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECSWSCHWAB_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [prgpaygroup] char(6) NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401CFAmt] numeric NULL,
    [Pdh401CPAmt] numeric NULL,
    [PdhPreTaxAmt] numeric NULL,
    [PdhYTD401KAmt] numeric NULL,
    [PdhMatchAmt] numeric NULL,
    [PdhYTDPlan3Amt] numeric NULL,
    [PdhRothAmt] numeric NULL,
    [PdhYTDRothAmt] numeric NULL,
    [PdhLoan1Amt] numeric NULL
);

-----------
-- Create table U_ECSWSCHWAB_PEarHist
-----------

IF OBJECT_ID('U_ECSWSCHWAB_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECSWSCHWAB_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehPayPerDefAllComp] numeric NULL,
    [PehPayPerTestingComp] numeric NULL,
    [PehPayPerTotalComp] numeric NULL,
    [PehYTDDefAllocComp] numeric NULL,
    [PehYTDPlanTestComp] numeric NULL,
    [PehYTDPlanTotalComp] numeric NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_ECSWSCHWAB_Trailer
-----------

IF OBJECT_ID('U_ECSWSCHWAB_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECSWSCHWAB_Trailer] (
    [drvPayPeriodEndDate] datetime NULL,
    [drvContribSrc1Total] nvarchar(12) NULL,
    [drvContribSrc2Total] nvarchar(12) NULL,
    [drvContribSrc3Total] nvarchar(12) NULL,
    [drvContribSrc4Total] varchar(12) NULL,
    [drvContribSrc5Total] varchar(12) NULL,
    [drvContribSrc6Total] varchar(12) NULL,
    [drvContribSrc7Total] varchar(12) NULL,
    [drvContribSrc8Total] varchar(12) NULL,
    [drvLoanPaymentTotal1] nvarchar(12) NULL,
    [drvLoanPaymentTotal2] varchar(12) NULL,
    [drvLoanPaymentTotal3] varchar(12) NULL,
    [drvLoanPaymentTotal4] varchar(12) NULL,
    [drvLoanPaymentTotal5] varchar(12) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECSWSCHWAB]
    @SystemID char(12)
AS
SET NOCOUNT ON;

/**********************************************************************************
Client Name: C & S Worldwide Holdings, Inc. 
Created By: Marie Thomerson
Business Analyst: Lea King
Create Date: 06/02/2022
Service Request Number: TekP-2022-04-13-01 
Purpose: Charles Schwab 401k Export

Revision History
----------------
Update By           Date           Request Num        Descf
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECSWSCHWAB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECSWSCHWAB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECSWSCHWAB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECSWSCHWAB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECSWSCHWAB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSWSCHWAB', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSWSCHWAB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSWSCHWAB', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSWSCHWAB', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECSWSCHWAB';

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007091'
       ,expStartPerControl     = '202007091'
       ,expLastEndPerControl   = '202207099'
       ,expEndPerControl       = '202207099'
WHERE expFormatCode = 'ECSWSCHWAB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECSWSCHWAB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECSWSCHWAB';

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
    DELETE FROM dbo.U_ECSWSCHWAB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECSWSCHWAB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --DELETE FROM dbo.U_ECSWSCHWAB_EEList
    --WHERE  xEEID IN (SELECT eepeeid FROM dbo.EmpPers where eepssn in ('999999999','000000002','000000001','123456789' ));

        --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECSWSCHWAB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECSWSCHWAB_AuditFields;
    CREATE TABLE dbo.U_ECSWSCHWAB_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ECSWSCHWAB_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ECSWSCHWAB_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECSWSCHWAB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECSWSCHWAB_Audit;
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
    INTO dbo.U_ECSWSCHWAB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECSWSCHWAB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime  >= DATEADD(yy, DATEDIFF(yy, 0, @StartDate), 0) AND audDateTime <= @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECSWSCHWAB_Audit ON dbo.U_ECSWSCHWAB_Audit (audEEID,audKey2);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401CF,401CP,401F,401P,401L,401L2,401M';

    IF OBJECT_ID('U_ECSWSCHWAB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECSWSCHWAB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECSWSCHWAB_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','401CF,401CP,401F,401P,401L,401L2,401M');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

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

    IF OBJECT_ID('U_ECSWSCHWAB_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECSWSCHWAB_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,prgpaygroup = MAX(PdhPayGroup)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401CFAmt    = SUM(CASE WHEN PdhDedCode IN ('401CF') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401CPAmt    = SUM(CASE WHEN PdhDedCode IN ('401CP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhPreTaxAmt   = SUM(CASE WHEN PdhDedCode IN ('401F','401CF', '401P', '401CP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhYTD401KAmt  = SUM(CASE WHEN PdhDedCode IN ('401F','401CF', '401P', '401CP ') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhMatchAmt    = SUM(CASE WHEN PdhDedCode IN ('401M', '401F','401CF', '401P', '401CP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhYTDPlan3Amt = SUM(CASE WHEN PdhDedCode IN ('401M', '401F','401CF', '401P', '401CP') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhRothAmt     = SUM(CASE WHEN PdhDedCode IN ('ROTH') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhYTDRothAmt  = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoan1Amt    = SUM(CASE WHEN PdhDedCode IN ('401L', '401L2') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ECSWSCHWAB_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECSWSCHWAB_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4) AND
     PdhPerControl <= @EndPerControl
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    )

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECSWSCHWAB_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECSWSCHWAB_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PehPayPerDefAllComp    = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  ) AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehPayPerTestingComp   = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  ) AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehPayPerTotalComp     = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  ) AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehYTDDefAllocComp     = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  )  THEN PehCurAmt ELSE 0.00 END)
        ,PehYTDPlanTestComp     = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  ) THEN PehCurAmt ELSE 0.00 END)
        ,PehYTDPlanTotalComp    = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  ) THEN PehCurAmt ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND  PehPerControl >= @StartPerControl THEN PehCurAmt END)        
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' AND ErnEarnCode NOT IN ('HOLBO','SEV') THEN PehCurAmt END) -- marco version
        --,PehInclInDefCompYTD  = SUM(CASE WHEN ErnInclInPensionAccum = 'Y' AND ErnEarnCode NOT IN ('HOLBO') THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND ErnEarnCode NOT IN ('HOLBO','SEV') THEN PehCurHrs END)
    INTO dbo.U_ECSWSCHWAB_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECSWSCHWAB_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECSWSCHWAB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECSWSCHWAB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' --FORMAT(PehCurHrsYTD, '#0.00') --BdmDedCode
        -- standard fields above and additional driver fields below
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(REPLACE(EepSSN, ' ', ''), 4)
        ,drvName = UPPER(EepNameLast + CASE WHEN EepNameSuffix IS NOT NULL AND REPLACE(EepNameSuffix, ' ', '') <> '' THEN  ' ' + EepNameSuffix ELSE '' END + ', ' + EepNameFirst + ' ' + ISNULL(EepNameMiddle, ''))
        ,drvContribSrc1 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhPreTaxAmt*100, '#0'), ''), 12)
        ,drvContribSrc2 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhRothAmt*100, '#0'), ''), 12)
        ,drvContribSrc3 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhMatchAmt*100, '#0'), ''), 12)
        ,drvContribSrc4 = '000000000000'
        ,drvContribSrc5 = '000000000000'
        ,drvContribSrc6 = '000000000000'
        ,drvContribSrc7 = '000000000000'
        ,drvContribSrc8 = '000000000000'
        ,drvLoanPayment1 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhLoan1Amt*100, '#0'), ''), 12)
        ,drvLoanPayment2 = '000000000000'
        ,drvLoanPayment3 = '000000000000'
        ,drvLoanPayment4 = '000000000000'
        ,drvLoanPayment5 = '000000000000'
        ,drvPayPerDefAllComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefComp > 0  THEN PehInclInDefComp*100 ELSE 0 END, '#0'), ''), 12)
        ,drvPayPerTestingComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefComp > 0  THEN PehInclInDefComp*100 ELSE 0 END, '#0'), ''), 12) 
        ,drvPayPerTotalComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefComp > 0  THEN PehInclInDefComp*100 ELSE 0 END, '#0'), ''), 12)
        ,drvPayPerHoursPaid = RIGHT(REPLICATE('0', 4) + ISNULL(FORMAT(CASE WHEN PehCurHrs > 0 then 95 ELSE 0 END, '#0'), ''), 4)
        ,drvPlanYTDConSrc1 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhYTD401KAmt*100, '#0'), ''),12)
        ,drvPlanYTDConSrc2 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhYTDRothAmt*100, '#0'), ''), 12)
        ,drvPlanYTDConSrc3 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhYTDPlan3Amt*100, '#0'), ''), 12)
        ,drvPlanYTDConSrc4 = '000000000000'
        ,drvPlanYTDConSrc5 = '000000000000'
        ,drvPlanYTDConSrc6 = '000000000000'
        ,drvPlanYTDConSrc7 = '000000000000'
        ,drvPlanYTDConSrc8 = '000000000000'
        ,drvYTDDefAllocComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefCompYTD > 0  THEN PehInclInDefCompYTD*100 END, '#0'), ''), 12)
        ,drvYTDPlanTestComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefCompYTD > 0  THEN PehInclInDefCompYTD*100 END, '#0'), ''), 12)
        ,drvYTDPlanTotalComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefCompYTD > 0  THEN PehInclInDefCompYTD*100 END, '#0'), ''), 12)
        ,drvSalary = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(EecAnnSalary*100, '#0'), ''), 12)
        ,drvPlanYTDHoursPaid = RIGHT(REPLICATE('0', 4) + ISNULL(FORMAT(PehCurHrsYTD, '#0'), ''), 4)             
        ,drvPayFrequency =   'B' 
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = EepAddressCountry
        ,drvDateOfBirth = EepDateOfBirth
        ,drvHireDate = EecDateOfOriginalHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire < EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvPayrollStatus = EecEmplStatus
        ,drvIneligibleStatus = CASE when EecEEType  not in ('PEG','PRJ','INT') THEN 'N' Else '' END
        ,drvPayLocation = prgpaygroup
        ,drvReportingDivision = ''
        ,drvAlternateKey1 = eecempno
        ,drvAlternateKey2 = cmpcompanycode
        ,drvWorkHomePhone = [dbo].[fn_FormatPhoneNumber](EecPhoneBusinessNumber, '###-###-####') 
        ,drvAddressEmail = EepAddressEMail
        ,drvLanguageCode = ''
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'M' THEN 'M' ELSE 'S' END
        ,drvFederalExemptions = ''
        ,drvJobCodeIndicator = CASE WHEN eecEEtype = 'INT' THEN 'I' else  EecFullTimeOrPartTime END
        ,drvLOAStartDate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate  END
        ,drvLOAEndDate = CASE WHEN EecEmplStatus = 'A' and EshStatusStopDate is not null THEN EshStatusStopDate END
        ,drvLOAIndicator = CASE WHEN EecEmplStatus = 'L' THEN 'L' END
    INTO dbo.U_ECSWSCHWAB_drvTbl
    FROM dbo.U_ECSWSCHWAB_EEList WITH (NOLOCK) 
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    --LEFT JOIN dbo.U_ECSWSCHWAB_Audit WITH (NOLOCK)
    --    ON audKey1Value = xEEID
    --    AND audKey2Value = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_dsi_BDM_ECSWSCHWAB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ECSWSCHWAB_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID     
    LEFT JOIN dbo.U_ECSWSCHWAB_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup   
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L'
                    ) AS LOA_Dates 
                WHERE RN = 1
            ) AS Leave_StartEnd_Date
        ON EshEEID = xEEID
        AND EshCOID = xCOID
    Join dbo.company WITH (NOLOCK) 
        on cmpcoid = xcoid

    ----------------------------------------
    -- DETAIL RECORD - U_ECSWSCHWAB_Trailer
    ----------------------------------------

    IF OBJECT_ID('U_ECSWSCHWAB_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECSWSCHWAB_Trailer;
    SELECT DISTINCT
         drvPayPeriodEndDate = (SELECT distinct MAX(PgpPeriodEndDate) PrgPeriodEnd 
                                FROM dbo.PgPayPer WITH (NOLOCK)
                                WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl) 
        ,drvContribSrc1Total  = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(SUM(CAST(drvContribSrc1 AS DECIMAL)), '#0'), ''), 12)
        ,drvContribSrc2Total  = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(SUM(CAST(drvContribSrc2 AS DECIMAL)), '#0'), ''), 12)
        ,drvContribSrc3Total  = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(SUM(CAST(drvContribSrc3 AS DECIMAL)), '#0'), ''), 12)
        ,drvContribSrc4Total  = RIGHT(REPLICATE('0', 12), 12)
        ,drvContribSrc5Total  = RIGHT(REPLICATE('0', 12), 12)
        ,drvContribSrc6Total  = RIGHT(REPLICATE('0', 12), 12)
        ,drvContribSrc7Total  = RIGHT(REPLICATE('0', 12), 12)
        ,drvContribSrc8Total  = RIGHT(REPLICATE('0', 12), 12)
        ,drvLoanPaymentTotal1 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(SUM(CAST(drvLoanPayment1 AS DECIMAL)), '#0'), ''), 12)
        ,drvLoanPaymentTotal2 = RIGHT(REPLICATE('0', 12), 12)
        ,drvLoanPaymentTotal3 = RIGHT(REPLICATE('0', 12), 12)
        ,drvLoanPaymentTotal4 = RIGHT(REPLICATE('0', 12), 12)
        ,drvLoanPaymentTotal5 = RIGHT(REPLICATE('0', 12), 12)
    INTO dbo.U_ECSWSCHWAB_Trailer
    FROM dbo.U_ECSWSCHWAB_drvTbl
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
ALTER VIEW dbo.dsi_vwECSWSCHWAB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECSWSCHWAB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;
--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECSWSCHWAB%'
ORDER BY AdfSetNumber, AdfFieldNumber;
--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107091'
       ,expStartPerControl     = '202107091'
       ,expLastEndPerControl   = '202107099'
       ,expEndPerControl       = '202107099'
WHERE expFormatCode = 'ECSWSCHWAB';
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECSWSCHWAB_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECSWSCHWAB_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECSWSCHWAB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECSWSCHWAB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECSWSCHWAB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECSWSCHWAB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECSWSCHWAB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECSWSCHWAB', 'UseFileName', 'V', 'Y'


-- End ripout