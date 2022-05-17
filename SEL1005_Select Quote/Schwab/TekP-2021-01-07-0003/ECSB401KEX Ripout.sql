/**********************************************************************************

ECSB401KEX: Charles Schwab 401k Export

FormatCode:     ECSB401KEX
Project:        Charles Schwab 401k Export
Client ID:      SEL1005
Date/time:      2022-05-11 05:32:00.657
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP2DB02
Database:       ULTIPRO_WPSQINC
Web Filename:   SEL1005_M1PWM_EEHISTORY_ECSB401KEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECSB401KEX_SavePath') IS NOT NULL DROP TABLE dbo.U_ECSB401KEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECSB401KEX'


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
WHERE FormatCode = 'ECSB401KEX'
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
WHERE ExpFormatCode = 'ECSB401KEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECSB401KEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECSB401KEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECSB401KEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECSB401KEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECSB401KEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECSB401KEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECSB401KEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECSB401KEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECSB401KEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECSB401KEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECSB401KEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECSB401KEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECSB401KEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECSB401KEX];
GO
IF OBJECT_ID('U_ECSB401KEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_Trailer];
GO
IF OBJECT_ID('U_ECSB401KEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_PEarHist];
GO
IF OBJECT_ID('U_ECSB401KEX_PDedHist_FY') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_PDedHist_FY];
GO
IF OBJECT_ID('U_ECSB401KEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_PDedHist];
GO
IF OBJECT_ID('U_ECSB401KEX_File') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_File];
GO
IF OBJECT_ID('U_ECSB401KEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_EEList];
GO
IF OBJECT_ID('U_ECSB401KEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_drvTbl];
GO
IF OBJECT_ID('U_ECSB401KEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_DedList];
GO
IF OBJECT_ID('U_ECSB401KEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_AuditFields];
GO
IF OBJECT_ID('U_ECSB401KEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECSB401KEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECSB401KEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECSB401KEX','Charles Schwab 401k Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ECSB401KEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECSB401KEXZ0','3','D','10','1',NULL,'Record ID',NULL,NULL,'"100"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECSB401KEXZ0','3','D','10','4',NULL,'Plan ID',NULL,NULL,'"SQI"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECSB401KEXZ0','11','D','10','7',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECSB401KEXZ0','32','D','10','18',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECSB401KEXZ0','12','D','10','50',NULL,'Contribution Source 1',NULL,NULL,'"drvContribSrc1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECSB401KEXZ0','12','D','10','62',NULL,'Contribution Source 2',NULL,NULL,'"drvContribSrc2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECSB401KEXZ0','12','D','10','74',NULL,'Contribution Source 3',NULL,NULL,'"drvContribSrc3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECSB401KEXZ0','12','D','10','86',NULL,'Contribution Source 4',NULL,NULL,'"drvContribSrc4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECSB401KEXZ0','12','D','10','98',NULL,'Contribution Source 5',NULL,NULL,'"drvContribSrc5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECSB401KEXZ0','12','D','10','110',NULL,'Contribution Source 6',NULL,NULL,'"drvContribSrc6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECSB401KEXZ0','12','D','10','122',NULL,'Contribution Source 7',NULL,NULL,'"drvContribSrc7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECSB401KEXZ0','12','D','10','134',NULL,'Contribution Source 8',NULL,NULL,'"drvContribSrc8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECSB401KEXZ0','12','D','10','146',NULL,'Contribution Source 9',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECSB401KEXZ0','12','D','10','158',NULL,'Contribution Source 10',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECSB401KEXZ0','12','D','10','170',NULL,'Loan Payment #1',NULL,NULL,'"drvLoanPayment1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECSB401KEXZ0','12','D','10','182',NULL,'Loan Payment #2',NULL,NULL,'"drvLoanPayment2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECSB401KEXZ0','12','D','10','194',NULL,'Loan Payment #3',NULL,NULL,'"drvLoanPayment3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECSB401KEXZ0','12','D','10','206',NULL,'Loan Payment #4',NULL,NULL,'"drvLoanPayment4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECSB401KEXZ0','12','D','10','218',NULL,'Loan Payment #5',NULL,NULL,'"drvLoanPayment5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECSB401KEXZ0','12','D','10','230',NULL,'Pay Period Deferral/Allocation Compensation',NULL,NULL,'"drvPayPerDefAllComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECSB401KEXZ0','12','D','10','242',NULL,'Pay Period Plan Testing Compensation',NULL,NULL,'"drvPayPerTestingComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECSB401KEXZ0','12','D','10','254',NULL,'Pay Period Total Compensation',NULL,NULL,'"drvPayPerTotalComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECSB401KEXZ0','12','D','10','266',NULL,'Pay Period Additional Compensation',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECSB401KEXZ0','4','D','10','278',NULL,'Pay Period Hours Paid',NULL,NULL,'"drvPayPerHoursPaid"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECSB401KEXZ0','12','D','10','282',NULL,'Plan YTD Contribution Source 1',NULL,NULL,'"drvPlanYTDConSrc1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECSB401KEXZ0','12','D','10','294',NULL,'Plan YTD Contribution Source 2',NULL,NULL,'"drvPlanYTDConSrc2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECSB401KEXZ0','12','D','10','306',NULL,'Plan YTD Contribution Source 3',NULL,NULL,'"drvPlanYTDConSrc3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECSB401KEXZ0','12','D','10','318',NULL,'Plan YTD Contribution Source 4',NULL,NULL,'"drvPlanYTDConSrc4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECSB401KEXZ0','12','D','10','330',NULL,'Plan YTD Contribution Source 5',NULL,NULL,'"drvPlanYTDConSrc5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECSB401KEXZ0','12','D','10','342',NULL,'Plan YTD Contribution Source 6',NULL,NULL,'"drvPlanYTDConSrc6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECSB401KEXZ0','12','D','10','354',NULL,'Plan YTD Contribution Source 7',NULL,NULL,'"drvPlanYTDConSrc7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECSB401KEXZ0','12','D','10','366',NULL,'Plan YTD Contribution Source 8',NULL,NULL,'"drvPlanYTDConSrc8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECSB401KEXZ0','12','D','10','378',NULL,'Plan YTD Contribution Source 9',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECSB401KEXZ0','12','D','10','390',NULL,'Plan YTD Contribution Source 10',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECSB401KEXZ0','12','D','10','402',NULL,'Plan YTD Deferral/Allocation Compensation',NULL,NULL,'"drvYTDDefAllocComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECSB401KEXZ0','12','D','10','414',NULL,'YTD Plan Testing Compensation',NULL,NULL,'"drvYTDPlanTestComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECSB401KEXZ0','12','D','10','426',NULL,'Plan YTD Total Compensation',NULL,NULL,'"drvYTDPlanTotalComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECSB401KEXZ0','12','D','10','438',NULL,'YTD Additional Compensation',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECSB401KEXZ0','12','D','10','450',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECSB401KEXZ0','4','D','10','462',NULL,'Plan YTD Hours Paid',NULL,NULL,'"drvPlanYTDHoursPaid"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECSB401KEXZ0','1','D','10','466',NULL,'Pay Frequency',NULL,NULL,'"drvPayFrequency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECSB401KEXZ0','40','D','10','467',NULL,'Primary Address Line #1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECSB401KEXZ0','40','D','10','507',NULL,'Primary Address Line #2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECSB401KEXZ0','80','D','10','547',NULL,'Primary City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECSB401KEXZ0','2','D','10','627',NULL,'Primary State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECSB401KEXZ0','10','D','10','629',NULL,'Primary Zip Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECSB401KEXZ0','30','D','10','639',NULL,'Primary Country',NULL,NULL,'"drvAddressCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECSB401KEXZ0','1','D','10','669',NULL,'Foreign Address Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECSB401KEXZ0','8','D','10','670',NULL,'Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECSB401KEXZ0','8','D','10','678',NULL,'Hire Date (original)',NULL,NULL,'"drvHireDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECSB401KEXZ0','8','D','10','686',NULL,'Plan Entry Date',NULL,NULL,'"drvPlanEntryDate1"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECSB401KEXZ0','8','D','10','694',NULL,'Plan Entry Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECSB401KEXZ0','8','D','10','702',NULL,'Plan Entry Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECSB401KEXZ0','8','D','10','710',NULL,'Plan Entry Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECSB401KEXZ0','8','D','10','718',NULL,'Termination Date (if applicable)',NULL,NULL,'"drvTerminationDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECSB401KEXZ0','8','D','10','726',NULL,'Rehire Date (date of most recent rehire)',NULL,NULL,'"drvRehireDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECSB401KEXZ0','8','D','10','734',NULL,'Alternate Vesting Date',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECSB401KEXZ0','1','D','10','742',NULL,'Restricted Status (officer status field)',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECSB401KEXZ0','5','D','10','743',NULL,'Loan Restriction',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECSB401KEXZ0','1','D','10','748',NULL,'Collective Bargaining Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECSB401KEXZ0','1','D','10','749',NULL,'Payroll Status',NULL,NULL,'"drvPayrollStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECSB401KEXZ0','1','D','10','750',NULL,'Highly Compensated Status (HCE)',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ECSB401KEXZ0','1','D','10','751',NULL,'Ineligible Status',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ECSB401KEXZ0','15','D','10','752',NULL,'Pay Location',NULL,NULL,'"drvPayLocation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ECSB401KEXZ0','5','D','10','767',NULL,'Reporting Division',NULL,NULL,'"drvReportingDivision"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ECSB401KEXZ0','15','D','10','772',NULL,'Alternate Key #1',NULL,NULL,'"drvAlternateKey1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ECSB401KEXZ0','15','D','10','787',NULL,'Alternate Key #2',NULL,NULL,'"drvAlternateKey2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ECSB401KEXZ0','5','D','10','802',NULL,'Transfer Indicator',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ECSB401KEXZ0','15','D','10','807',NULL,'Work/Home Telephone Number',NULL,NULL,'"drvWorkHomePhone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ECSB401KEXZ0','50','D','10','822',NULL,'E-mail Address',NULL,NULL,'"drvAddressEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ECSB401KEXZ0','1','D','10','872',NULL,'Language Preference Code',NULL,NULL,'"drvLanguageCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ECSB401KEXZ0','1','D','10','873',NULL,'Gender Code',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ECSB401KEXZ0','1','D','10','874',NULL,'Marital Status – Taxable',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ECSB401KEXZ0','2','D','10','875',NULL,'Federal Exemptions',NULL,NULL,'"drvFederalExemptions"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ECSB401KEXZ0','1','D','10','877',NULL,'Job Code Indicator',NULL,NULL,'"drvJobCodeIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ECSB401KEXZ0','8','D','10','878',NULL,'Leave of Absence – Start Date',NULL,NULL,'"drvLOAStartDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ECSB401KEXZ0','8','D','10','886',NULL,'Leave of Absence – End Date',NULL,NULL,'"drvLOAEndDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ECSB401KEXZ0','1','D','10','894',NULL,'Leave of Absence Indicator',NULL,NULL,'"drvLOAIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ECSB401KEXZ0','8','D','10','895',NULL,'Retirement Date',NULL,NULL,'"drvDateOfRetirement"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ECSB401KEXZ0','8','D','10','903',NULL,'Death Date',NULL,NULL,'"drvDateOfDeath"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ECSB401KEXZ0','40','D','10','911',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECSB401KEXZ0','3','T','90','1',NULL,'Record ID',NULL,NULL,'"101"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECSB401KEXZ0','3','T','90','4',NULL,'Plan ID',NULL,NULL,'"SQI"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECSB401KEXZ0','11','T','90','7',NULL,'Pay Period Ending Date',NULL,NULL,'"drvPayPeriodEndDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECSB401KEXZ0','32','T','90','18',NULL,'FILLER',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECSB401KEXZ0','12','T','90','30',NULL,'Contribution Source 1 Total',NULL,NULL,'"drvContribSrc1Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECSB401KEXZ0','12','T','90','42',NULL,'Contribution Source 2 Total',NULL,NULL,'"drvContribSrc2Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECSB401KEXZ0','12','T','90','54',NULL,'Contribution Source 3 Total',NULL,NULL,'"drvContribSrc3Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECSB401KEXZ0','12','T','90','66',NULL,'Contribution Source 4 Total',NULL,NULL,'"drvContribSrc4Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECSB401KEXZ0','12','T','90','78',NULL,'Contribution Source 6 Total',NULL,NULL,'"drvContribSrc5Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECSB401KEXZ0','12','T','90','90',NULL,'Contribution Source 7 Total',NULL,NULL,'"drvContribSrc6Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECSB401KEXZ0','12','T','90','102',NULL,'Contribution Source 8 Total',NULL,NULL,'"drvContribSrc7Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECSB401KEXZ0','12','T','90','114',NULL,'Contribution Source 9 Total',NULL,NULL,'"drvContribSrc8Total"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECSB401KEXZ0','12','T','90','126',NULL,'Contribution Source 10 Total',NULL,NULL,'"000000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECSB401KEXZ0','12','T','90','138',NULL,'Loan Payment #1 Total',NULL,NULL,'"drvLoanPaymentTotal1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECSB401KEXZ0','12','T','90','150',NULL,'Loan Payment #2 Total',NULL,NULL,'"drvLoanPaymentTotal2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECSB401KEXZ0','12','T','90','162',NULL,'Loan Payment #3 Total',NULL,NULL,'"drvLoanPaymentTotal3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECSB401KEXZ0','12','T','90','174',NULL,'Loan Payment #4 Total',NULL,NULL,'"drvLoanPaymentTotal4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECSB401KEXZ0','12','T','90','186',NULL,'Loan Payment #5 Total',NULL,NULL,'"drvLoanPaymentTotal5"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECSB401KEX_20220511.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202107099','EMPEXPORT','OEACTIVE',NULL,'ECSB401KEX',NULL,NULL,NULL,'202107099','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202107091',NULL,'','','202107091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202107099','EMPEXPORT','OEPASSIVE',NULL,'ECSB401KEX',NULL,NULL,NULL,'202107099','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202107091',NULL,'','','202107091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Charles Schwab 401k Export','202107099','EMPEXPORT','ONDEMAND',NULL,'ECSB401KEX',NULL,NULL,NULL,'202107099','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202107091',NULL,'','','202107091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202107099','EMPEXPORT','SCH_CHAEX',NULL,'ECSB401KEX',NULL,NULL,NULL,'202107099','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202107091',NULL,'','','202107091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','08G50',NULL,NULL,NULL,'Test Purposes Only','202204251','EMPEXPORT','TEST','Apr 27 2022  6:57PM','ECSB401KEX',NULL,NULL,NULL,'202204251','Apr 25 2022 12:00AM','Apr 15 2022 12:00AM','202204251','2198514','eecPayGroup','SQAH,CORP,IR,LIFE,PH,SQRX,SENIR','202204251',dbo.fn_GetTimedKey(),NULL,'us3lKiSEL1005',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSB401KEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSB401KEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSB401KEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSB401KEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSB401KEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSB401KEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSB401KEX','D10','dbo.U_ECSB401KEX_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSB401KEX','T90','dbo.U_ECSB401KEX_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECSB401KEX
-----------

IF OBJECT_ID('U_dsi_BDM_ECSB401KEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECSB401KEX] (
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
-- Create table U_ECSB401KEX_Audit
-----------

IF OBJECT_ID('U_ECSB401KEX_Audit') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_Audit] (
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
-- Create table U_ECSB401KEX_AuditFields
-----------

IF OBJECT_ID('U_ECSB401KEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_ECSB401KEX_DedList
-----------

IF OBJECT_ID('U_ECSB401KEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECSB401KEX_drvTbl
-----------

IF OBJECT_ID('U_ECSB401KEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] varchar(11) NULL,
    [drvName] varchar(284) NULL,
    [drvContribSrc1] nvarchar(12) NULL,
    [drvContribSrc2] nvarchar(12) NULL,
    [drvContribSrc3] nvarchar(12) NULL,
    [drvContribSrc1Raw] numeric NULL,
    [drvContribSrc2Raw] numeric NULL,
    [drvContribSrc3Raw] numeric NULL,
    [drvContribSrc4] varchar(12) NOT NULL,
    [drvContribSrc5] varchar(12) NOT NULL,
    [drvContribSrc6] varchar(12) NOT NULL,
    [drvContribSrc7] varchar(12) NOT NULL,
    [drvContribSrc8] varchar(12) NOT NULL,
    [drvLoanPayment1Raw] numeric NULL,
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
    [drvPlanYTDHoursPaid] varchar(1) NOT NULL,
    [drvPayFrequency] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] varchar(3) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvPlanEntryDate1] date NULL,
    [drvTerminationDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvPayrollStatus] varchar(1) NULL,
    [drvPayLocation] varchar(15) NULL,
    [drvReportingDivision] varchar(2) NULL,
    [drvAlternateKey1] char(5) NULL,
    [drvAlternateKey2] char(9) NULL,
    [drvWorkHomePhone] varchar(25) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvLanguageCode] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvFederalExemptions] varchar(1) NOT NULL,
    [drvJobCodeIndicator] char(1) NULL,
    [drvLOAStartDate] datetime NULL,
    [drvLOAEndDate] datetime NULL,
    [drvLOAIndicator] varchar(1) NULL,
    [drvDateOfRetirement] varchar(1) NOT NULL,
    [drvDateOfDeath] varchar(1) NOT NULL
);

-----------
-- Create table U_ECSB401KEX_EEList
-----------

IF OBJECT_ID('U_ECSB401KEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECSB401KEX_File
-----------

IF OBJECT_ID('U_ECSB401KEX_File') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_ECSB401KEX_PDedHist
-----------

IF OBJECT_ID('U_ECSB401KEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401FAmt] numeric NULL,
    [Pdh401FAmtYTD2] numeric NULL,
    [Pdh401CAmt] numeric NULL,
    [Pdh401CAmtYTD] numeric NULL,
    [PdhRothAmt] numeric NULL,
    [PdhMatchAmt] numeric NULL,
    [Pdh401L1Amt] numeric NULL,
    [PdhDedCalcBasisAmt] numeric NULL
);

-----------
-- Create table U_ECSB401KEX_PDedHist_FY
-----------

IF OBJECT_ID('U_ECSB401KEX_PDedHist_FY') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_PDedHist_FY] (
    [PdhFyEEID] char(12) NOT NULL,
    [Pdh401FAmtYTD] numeric NULL,
    [PdhRothAmtYTD] numeric NULL,
    [PdhMatchAmtYTD] numeric NULL
);

-----------
-- Create table U_ECSB401KEX_PEarHist
-----------

IF OBJECT_ID('U_ECSB401KEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_PEarHist] (
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
-- Create table U_ECSB401KEX_Trailer
-----------

IF OBJECT_ID('U_ECSB401KEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_Trailer] (
    [drvPayPeriodEndDate] datetime NULL,
    [drvContribSrc1Total] nvarchar(12) NULL,
    [drvContribSrc2Total] nvarchar(12) NULL,
    [drvContribSrc3Total] nvarchar(12) NULL,
    [drvContribSrc4Total] nvarchar(12) NULL,
    [drvContribSrc5Total] nvarchar(12) NULL,
    [drvContribSrc6Total] nvarchar(12) NULL,
    [drvContribSrc7Total] nvarchar(12) NULL,
    [drvContribSrc8Total] nvarchar(12) NULL,
    [drvLoanPaymentTotal1] nvarchar(12) NULL,
    [drvLoanPaymentTotal2] nvarchar(12) NULL,
    [drvLoanPaymentTotal3] nvarchar(12) NULL,
    [drvLoanPaymentTotal4] nvarchar(12) NULL,
    [drvLoanPaymentTotal5] nvarchar(12) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECSB401KEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: SelectQuote

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 03/02/2021
Service Request Number: TekP-2021-01-07-0003

Purpose: Charles Schwab 401k Export

Revision History
----------------
Update By           Date           Request Num        Descf
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECSB401KEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECSB401KEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECSB401KEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECSB401KEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECSB401KEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSB401KEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSB401KEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSB401KEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSB401KEX', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECSB401KEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECSB401KEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECSB401KEX';

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
    DELETE FROM dbo.U_ECSB401KEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECSB401KEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECSB401KEX_EEList
    WHERE  xEEID IN (SELECT eepeeid FROM dbo.EmpPers where eepssn in ('999999999','000000002','000000001','123456789' ));


    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '700,701,703,704,MATCH,764,765,766,767,768,769,771,775,PROSH';

    IF OBJECT_ID('U_ECSB401KEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECSB401KEX_DedList
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

    IF OBJECT_ID('U_ECSB401KEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401FAmt        = SUM(CASE WHEN PdhDedCode IN ('700','701') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        --,Pdh401FAmtYTD    = SUM(CASE WHEN PdhDedCode IN ('700','701')  AND PdhPerControl >=  CAST( (YEAR(@StartDate)) as varchar) + '07011'  THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401FAmtYTD2    = SUM(CASE WHEN PdhDedCode IN ('700','701')  THEN PdhEECurAmt ELSE 0.00 END)

        ,Pdh401CAmt        = SUM(CASE WHEN PdhDedCode IN ('401C') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl  THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401CAmtYTD    = SUM(CASE WHEN PdhDedCode IN ('401C')   AND PdhPerControl >=  CAST( (YEAR(@StartDate) ) as varchar) + '07011' THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRothAmt     = SUM(CASE WHEN PdhDedCode IN ('703','704') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)        
        --,PdhRothAmtYTD    = SUM(CASE WHEN PdhDedCode IN ('703','704')   AND PdhPerControl >=  CAST( (YEAR(@StartDate) ) as varchar) + '07011' THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhMatchAmt   = SUM(CASE WHEN PdhDedCode IN ('MATCH') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        --,PdhMatchAmtYTD    = SUM(CASE WHEN PdhDedCode IN ('MATCH')  AND PdhPerControl >=  CAST( (YEAR(@StartDate)) as varchar) + '07011' THEN PdhERCurAmt ELSE 0.00 END)
        ,Pdh401L1Amt     = SUM(CASE WHEN PdhDedCode IN ('764','765', '766', '767', '768', '769', '771', '775') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhDedCalcBasisAmt =  SUM(CASE WHEN PdhDedCode IN ('700','701','703','704','MATCH') AND PdhPerControl > CAST( (YEAR(@StartDate) ) as varchar) + '07011' THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ECSB401KEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECSB401KEX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE --LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
     PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --)
    
    ;


    DECLARE @FiscYearStartPerControl VARCHAR(9)
        ,@FiscYearEndPerControl VARCHAR(9)
        ;


    SELECT @FiscYearStartPerControl =  CASE WHEN DATEPART(MONTH, @EndDate) < 7  THEN CAST((DATEPART(YEAR, @EndDate) - 1) AS VARCHAR) + '07011' ELSE CAST(DATEPART(YEAR, @EndDate) AS VARCHAR) + '07011' END
            ,@FiscYearEndPerControl =  CASE WHEN DATEPART(MONTH, @EndDate) < 7 THEN CAST(DATEPART(YEAR, @EndDate) AS VARCHAR) + '06309' ELSE CAST(DATEPART(YEAR, @EndDate) + 1 AS VARCHAR) + '06309' END 

    IF OBJECT_ID('U_ECSB401KEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_PDedHist_FY;
    SELECT DISTINCT
         PdhFyEEID = PdhEEID
        ,Pdh401FAmtYTD    = SUM(CASE WHEN PdhDedCode IN ('700','701') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRothAmtYTD    = SUM(CASE WHEN PdhDedCode IN ('703','704') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhMatchAmtYTD    = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)
    INTO dbo.U_ECSB401KEX_PDedHist_FY
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECSB401KEX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE --LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
     --PdhPerControl <= @EndPerControl
     PdhPerControl BETWEEN @FiscYearStartPerControl AND @FiscYearEndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECSB401KEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_PEarHist;
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
        ,PehPayPerTestingComp    = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  ) AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehPayPerTotalComp        = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  ) AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehYTDDefAllocComp        = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  )  THEN PehCurAmt ELSE 0.00 END)
        ,PehYTDPlanTestComp        = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  ) THEN PehCurAmt ELSE 0.00 END)
        ,PehYTDPlanTotalComp    = SUM(CASE WHEN ErnEarnCode IN ('ANMIP','ANNU' ,'BEREV','BONUS','CMP','COMHR','COMM','COMOT','CONT' ,'DT','FLHOL','HOL','HOLBO','HRLY' ,'INF','JURY' ,'LIAMC','MBO'  ,'MISC' ,'MOVE' ,'OT','PSST','PTO'  ,'PTOPY','QTRLY','REF','REG'  ,'REGFL','RETRO','SEN','SHIFT','SIGN' ,'SMINC','SPOT' ,'SSTIP','STIP','TRAIN','YEI'  ) THEN PehCurAmt ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND ErnEarnCode NOT IN ('HOLBO','SEV') AND PehPerControl >= @StartPerControl THEN PehCurAmt END)        
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND ErnEarnCode NOT IN ('HOLBO','SEV') AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' AND ErnEarnCode NOT IN ('HOLBO','SEV') THEN PehCurAmt END) -- marco version
        --,PehInclInDefCompYTD    = SUM(CASE WHEN ErnInclInPensionAccum = 'Y' AND ErnEarnCode NOT IN ('HOLBO') THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND ErnEarnCode NOT IN ('HOLBO','SEV') THEN PehCurHrs END)
    INTO dbo.U_ECSB401KEX_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    WHERE PehPerControl BETWEEN CASE WHEN @EndDate < '7/1/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) THEN CAST(DATEPART(YEAR, GETDATE())-1 AS VARCHAR) + '07011' ELSE CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) + '07011' END AND @EndPerControl
    --WHERE PehPerControl > CAST( (YEAR(@StartDate) - 1 ) as varchar) + '07011'
    and 
    PehPerControl <= @EndPerControl
    --AND PrgCheckAddMode <> 'T'
    GROUP BY PehEEID
    --HAVING SUM(PehCurAmt) <> 0.00;

     


    --======

    IF OBJECT_ID('U_ECSB401KEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_AuditFields;
    CREATE TABLE dbo.U_ECSB401KEX_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ECSB401KEX_AuditFields VALUES ('EmpComp','eecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ECSB401KEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_Audit;
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
    INTO dbo.U_ECSB401KEX_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ECSB401KEX_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ECSB401KEX_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate - 365 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECSB401KEX_Audit ON dbo.U_ECSB401KEX_Audit (audKey1Value, audKey2Value);
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECSB401KEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECSB401KEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' --FORMAT(PehCurHrsYTD, '#0.00') --BdmDedCode
        -- standard fields above and additional driver fields below
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(REPLACE(EepSSN, ' ', ''), 4)
        ,drvName = UPPER(EepNameLast + CASE WHEN EepNameSuffix IS NOT NULL AND REPLACE(EepNameSuffix, ' ', '') <> '' THEN  ' ' + EepNameSuffix ELSE '' END + ', ' + EepNameFirst + ' ' + ISNULL(EepNameMiddle, ''))
        ,drvContribSrc1 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(Pdh401FAmt*100, '#0'), ''), 12)
        ,drvContribSrc2 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhRothAmt*100, '#0'), ''), 12)
        ,drvContribSrc3 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhMatchAmt*100, '#0'), ''), 12)
        ,drvContribSrc1Raw = Pdh401FAmt
        ,drvContribSrc2Raw = PdhRothAmt
        ,drvContribSrc3Raw = PdhMatchAmt
        -- RIGHT(SPACE(12) + FORMAT(PdhRothAmt*100, '#0'), 12)
        ,drvContribSrc4 = '000000000000'

        ,drvContribSrc5 = '000000000000'
        ,drvContribSrc6 = '000000000000'
        ,drvContribSrc7 = '000000000000'
        ,drvContribSrc8 = '000000000000'
        ,drvLoanPayment1Raw = Pdh401L1Amt

        ,drvLoanPayment1 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(Pdh401L1Amt*100, '#0'), ''), 12)
        ,drvLoanPayment2 = '000000000000'
        ,drvLoanPayment3 = '000000000000'
        ,drvLoanPayment4 = '000000000000'
        ,drvLoanPayment5 = '000000000000'
        ,drvPayPerDefAllComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefComp > 0  THEN PehInclInDefComp*100 ELSE 0 END, '#0'), ''), 12)
        --,drvPayPerDefAllComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefComp > 0  THEN PehInclInDefComp*100 ELSE 0 END, '#0'), ''), 12)
        --,drvPayPerTestingComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefComp > 0  THEN PehInclInDefComp*100 ELSE 0 END, '#0'), ''), 12) -- JCB
        ,drvPayPerTestingComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN SalaryAmount > 0  THEN SalaryAmount*100 ELSE 0 END, '#0'), ''), 12)
        --,drvPayPerTotalComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefComp > 0  THEN PehInclInDefComp*100 ELSE 0 END, '#0'), ''), 12)
        ,drvPayPerTotalComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN SalaryAmount > 0  THEN SalaryAmount*100 ELSE 0 END, '#0'), ''), 12)
        ,drvPayPerHoursPaid = RIGHT(REPLICATE('0', 4) + ISNULL(FORMAT(CASE WHEN PehCurHrs > 0 then 95 ELSE 0 END, '#0'), ''), 4)
        ,drvPlanYTDConSrc1 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(Pdh401FAmtYTD*100, '#0'), ''),12)
        ,drvPlanYTDConSrc2 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhRothAmtYTD*100, '#0'), ''), 12)
        ,drvPlanYTDConSrc3 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(PdhMatchAmtYTD*100, '#0'), ''), 12)
        ,drvPlanYTDConSrc4 = '000000000000'

        ,drvPlanYTDConSrc5 = '000000000000'
        ,drvPlanYTDConSrc6 = '000000000000'
        ,drvPlanYTDConSrc7 = '000000000000'
        ,drvPlanYTDConSrc8 = '000000000000'

        ,drvYTDDefAllocComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefCompYTD > 0  THEN PehInclInDefCompYTD*100 END, '#0'), ''), 12)--ELSE PdhDedCalcBasisAmt*100 END, '#0'), ''), 12)
        --,drvYTDPlanTestComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefCompYTD > 0  THEN PehInclInDefCompYTD*100 END, '#0'), ''), 12)--ELSE PdhDedCalcBasisAmt*100 END, '#0'), ''), 12)
        --,drvYTDPlanTotalComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN PehInclInDefCompYTD > 0  THEN PehInclInDefCompYTD*100 END, '#0'), ''), 12)--ELSE PdhDedCalcBasisAmt*100 END, '#0'), ''), 12)

        ,drvYTDPlanTestComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN YtdSalaryAmount > 0  THEN YtdSalaryAmount*100 END, '#0'), ''), 12)--ELSE PdhDedCalcBasisAmt*100 END, '#0'), ''), 12)
        ,drvYTDPlanTotalComp = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(CASE WHEN YtdSalaryAmount > 0  THEN YtdSalaryAmount*100 END, '#0'), ''), 12)--ELSE PdhDedCalcBasisAmt*100 END, '#0'), ''), 12)

        ,drvSalary = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(EecAnnSalary*100, '#0'), ''), 12)
        ,drvPlanYTDHoursPaid = ''--RIGHT(REPLICATE('0', 4) + ISNULL(FORMAT(PehCurHrsYTD, '#0'), ''), 4)                        --- JCB
            --RIGHT(REPLICATE('0', 4) + ISNULL(FORMAT(EeeYTDHrs*100, '#0'), ''), 4)                        --- JCB
        ,drvPayFrequency =    CASE WHEN PgrPayFrequency = 'W' THEN 'W'
                                WHEN PgrPayFrequency = 'M' THEN 'M'
                                WHEN PgrPayFrequency = 'B' THEN 'B'
                                WHEN PgrPayFrequency = 'S' THEN 'S'
                                WHEN PgrPayFrequency = 'Q' THEN 'Q'
                            END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = 'USA'
        ,drvDateOfBirth = EepDateOfBirth
        ,drvHireDate = EecDateOfOriginalHire
        ,drvPlanEntryDate1 = DateAdd(day,1,eomonth(DateAdd(day,30,EecDateOfOriginalHire)))
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire < EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvPayrollStatus = CASE WHEN EecEmplStatus = 'L' THEN 'A' ELSE EecEmplStatus END 
        ,drvPayLocation = CASE WHEN eecpaygroup = 'LIFE' THEN 'Life'
                               WHEN eecpaygroup = 'SQAH' THEN 'Auto-Home'
                               WHEN eecpaygroup = 'CORP' THEN 'Corp'
                               WHEN eecpaygroup = 'IR' THEN 'Inside Response'
                               WHEN eecpaygroup = 'SENIR' THEN 'Senior'
                               WHEN eecpaygroup = 'SQRX ' THEN 'SelectRx'
                               WHEN eecpaygroup = 'PH ' THEN 'Pop Health'
                          END
        ,drvReportingDivision = CASE WHEN eecpaygroup = 'LIFE' THEN '01'
                               WHEN eecpaygroup = 'SQAH' THEN '02'
                               WHEN eecpaygroup = 'CORP' THEN '03'
                               WHEN eecpaygroup = 'IR' THEN '04'
                               WHEN eecpaygroup = 'SENIR' THEN '05'
                               WHEN eecpaygroup = 'SQRX ' THEN '06'
                               WHEN eecpaygroup = 'PH ' THEN '07'
                          END
        ,drvAlternateKey1 = cmpcompanycode
        ,drvAlternateKey2 = eecempno
        ,drvWorkHomePhone = CASE WHEN EecPhoneBusinessNumber  is not null then [dbo].[fnFormatPhoneNumber](EecPhoneBusinessNumber)  else [dbo].[fnFormatPhoneNumber](eepphonehomenumber)  END
        ,drvAddressEmail = EepAddressEMail
        ,drvLanguageCode = ''
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'M' THEN 'M'
                                 WHEN eepMaritalStatus = 'S' THEN 'S'
                            END
        ,drvFederalExemptions = ''
        ,drvJobCodeIndicator = EecFullTimeOrPartTime
        ,drvLOAStartDate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate  END
        ,drvLOAEndDate = CASE WHEN EecEmplStatus = 'A' and EshStatusStopDate is not null THEN EshStatusStopDate END
        ,drvLOAIndicator = CASE WHEN EecEmplStatus = 'L' THEN 'L' END
        ,drvDateOfRetirement = ''
        ,drvDateOfDeath = ''
    INTO dbo.U_ECSB401KEX_drvTbl
    FROM dbo.U_ECSB401KEX_EEList WITH (NOLOCK) 
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_ECSB401KEX_Audit WITH (NOLOCK)
        ON audKey1Value = xEEID
        AND audKey2Value = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_dsi_BDM_ECSB401KEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ECSB401KEX_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID    
    LEFT JOIN dbo.U_ECSB401KEX_PDedHist_FY WITH (NOLOCK)
        ON PdhFyEEID = xEEID    
    LEFT JOIN dbo.U_ECSB401KEX_PEarHist WITH (NOLOCK)
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
    LEFT JOIN (
            SELECT distinct PthEEID AS SalPthEEID, PthCurGrossWages AS SalaryAmount
            FROM dbo.PTaxHist WITH (NOLOCK)
            WHERE PthPerControl BETWEEN @StartPerControl AND @EndPerControl
                AND PthIsTaxReconAdjustment <> 'Y'
            ) AS TotalSal            
        ON SalPthEEID = xEEID
    LEFT JOIN (
            SELECT PehEEID AS SalYtdPehEEID, sum(PehCurAmt) AS YtdSalaryAmount
            FROM dbo.PEarHist WITH (NOLOCK)
            WHERE PehPerControl BETWEEN CASE WHEN @EndDate < '7/1/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) THEN CAST(DATEPART(YEAR, GETDATE())-1 AS VARCHAR) + '07011' ELSE CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) + '07011' END AND @EndPerControl
            GROUP BY PehEEID) AS TotalYtdSal
        ON SalYtdPehEEID = xEEID
    WHERE eecemplstatus <> 'T'
        OR (
                (eecemplstatus = 'T' AND eectermreason <> 'TRO' AND audNewValue = 'T')
                OR
                (eecemplstatus = 'T' and /*eectermreason <> 'TRO'  and*/ (Pdh401FAmt > 0.00 or PdhRothAmt > 0.00 or Pdh401L1Amt > 0.00))    
        )


/*    
    FROM dbo.U_ECSB401KEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
          --and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
          --                              and EXISTS(select 1 from dbo.U_ECSB401KEX_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    --==========================================
    -- update to pull in termination not captured in audit
          and eecemplstatus <> 'T' 
          OR  (eecemplstatus = 'T' and eectermreason <> 'TRO' 
                                        and EXISTS(select 1 from dbo.U_ECSB401KEX_Audit where audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')
                                        OR (eecemplstatus = 'T' and eectermreason <> 'TRO' and
                                        EXISTS(SELECT 1 from U_ECSB401KEX_PDedHist where pdheeid = xeeid and (Pdh401FAmt > 0.00 or PdhRothAmt > 0.00 or Pdh401L1Amt > 0.00) )))
    --==========================================
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_dsi_BDM_ECSB401KEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ECSB401KEX_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID    
    LEFT JOIN dbo.U_ECSB401KEX_PDedHist_FY WITH (NOLOCK)
        ON PdhFyEEID = xEEID    
    LEFT JOIN dbo.U_ECSB401KEX_PEarHist WITH (NOLOCK)
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
    LEFT JOIN (
            SELECT PthEEID AS SalPthEEID, PthCurGrossWages AS SalaryAmount
            --SELECT PthEEID AS SalPthEEID, SUM(PthCurTaxableWages) AS SalaryAmount
            FROM dbo.PTaxHist WITH (NOLOCK)
            WHERE PthPerControl BETWEEN @StartPerControl AND @EndPerControl
                AND PthIsTaxReconAdjustment <> 'Y'
            ) AS TotalSal
                --AND PthTaxCode = 'USFIT'
            --GROUP BY PthEEID) AS TotalSal
            
        ON SalPthEEID = xEEID
    LEFT JOIN (
            SELECT PehEEID AS SalYtdPehEEID, sum(PehCurAmt) AS YtdSalaryAmount
            FROM dbo.PEarHist WITH (NOLOCK)
            WHERE PehPerControl BETWEEN CASE WHEN @EndDate < '7/1/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) THEN CAST(DATEPART(YEAR, GETDATE())-1 AS VARCHAR) + '07011' ELSE CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) + '07011' END AND @EndPerControl
            GROUP BY PehEEID) AS TotalYtdSal
        ON SalYtdPehEEID = xEEID
        
        --SELECT PthEEID AS SalYtdPthEEID, SUM(PthCurTaxableWages) AS YtdSalaryAmount
        --    FROM dbo.PTaxHist WITH (NOLOCK)
  --          WHERE PthPerControl BETWEEN CASE WHEN @EndDate < '7/1/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) THEN CAST(DATEPART(YEAR, GETDATE())-1 AS VARCHAR) + '07011' ELSE CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) + '07011' END AND @EndPerControl
  --           AND PthTaxCode = 'USFIT'
  --          GROUP BY PthEEID) AS TotalYtdSal
  --      ON SalYtdPthEEID = xEEID

    --WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND PdhDedCalcBasisAmt > 0) --- DATEPART(YEAR, EecDateOfTermination) = DATEPART(YEAR, @ENDDATE))
    ;
*/
    
    Update dbo.U_ECSB401KEX_drvTbl set drvLoanPayment1Raw = 0 , drvLoanPayment1 = '000000000000' where drvLoanPayment1Raw  < 0

    Delete  from dbo.U_ECSB401KEX_drvTbl where YEAR(drvTerminationdate) <  YEAR(@EndDate) and drvPlanYTDHoursPaid = '0000'
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------

    DECLARE @Contrib1 AS DECIMAL
        ,@Contrib2 AS DECIMAL
        ,@Contrib3 AS DECIMAL
        ,@Contrib4 AS DECIMAL

        ,@Contrib5 AS INTEGER
        ,@Contrib6 AS INTEGER
        ,@Contrib7 AS INTEGER
        ,@Contrib8 AS INTEGER

        ,@Payment1 AS DECIMAL
        ,@Payment2 AS INTEGER
        ,@Payment3 AS INTEGER
        ,@Payment4 AS INTEGER
        ,@Payment5 AS INTEGER;

    SET @Contrib1 = (SELECT SUM(CAST(drvContribSrc1Raw AS DECIMAL)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Contrib2 = (SELECT SUM(CAST(drvContribSrc2Raw AS DECIMAL)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Contrib3 = (SELECT SUM(CAST(drvContribSrc3Raw AS DECIMAL)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Contrib4 = 0

    SET @Contrib5 = 0
    SET @Contrib6 = 0
    SET @Contrib7 = 0
    SET @Contrib8 = 0

    SET @Payment1 = (SELECT SUM(CAST(drvContribSrc1Raw AS DECIMAL)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Payment2 = 0
    SET @Payment3 = 0
    SET @Payment4 = 0
    SET @Payment5 = 0

    IF OBJECT_ID('U_ECSB401KEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_Trailer;
    SELECT DISTINCT
         drvPayPeriodEndDate = (SELECT distinct MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   AND PgpPayGroup NOT IN ('HRONLY')
                   --AND prgcheckaddmode <> 'T'
                   --GROUP BY PgpPayGroup
                   ) -- JCB
        -- ,drvContribSrc1 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(Pdh401FAmt*100, '#0'), ''), 12)
        ,drvContribSrc1Total = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Contrib1, '#0'), ''), 12)
        --RIGHT(SPACE(12) + CASE WHEN @Contrib1 > 0 THEN FORMAT(@Contrib1, '#') ELSE '0' END, 12)
        ,drvContribSrc2Total = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Contrib2, '#0'), ''), 12)
        --RIGHT(SPACE(12) + CASE WHEN @Contrib2 > 0 THEN FORMAT(@Contrib2, '#') ELSE '0' END, 12)
        ,drvContribSrc3Total = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Contrib3, '#0'), ''), 12)
        --RIGHT(SPACE(12) + CASE WHEN @Contrib3 > 0 THEN FORMAT(@Contrib3, '#') ELSE '0' END, 12)
        ,drvContribSrc4Total = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Contrib4, '#0'), ''), 12)

        ,drvContribSrc5Total = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Contrib5, '#0'), ''), 12)
        ,drvContribSrc6Total = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Contrib6, '#0'), ''), 12)
        ,drvContribSrc7Total = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Contrib7, '#0'), ''), 12)
        ,drvContribSrc8Total = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Contrib8, '#0'), ''), 12)

        --RIGHT(SPACE(12) + CASE WHEN @Contrib4 > 0 THEN FORMAT(@Contrib4, '#') ELSE '0' END, 12)
        ,drvLoanPaymentTotal1 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Payment1, '#0'), ''), 12)
        --RIGHT(SPACE(12) + CASE WHEN @Payment1 > 0 THEN FORMAT(@Payment1, '#') ELSE '0' END, 12)
        ,drvLoanPaymentTotal2 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Payment2, '#0'), ''), 12)
        --RIGHT(SPACE(12) + CASE WHEN @Payment2 > 0 THEN FORMAT(@Payment2, '#') ELSE '0' END, 12)
        ,drvLoanPaymentTotal3 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Payment3, '#0'), ''), 12)
        --RIGHT(SPACE(12) + CASE WHEN @Payment3 > 0 THEN FORMAT(@Payment3, '#') ELSE '0' END, 12)
        ,drvLoanPaymentTotal4 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Payment4, '#0'), ''), 12)
        --RIGHT(SPACE(12) + CASE WHEN @Payment4 > 0 THEN FORMAT(@Payment4, '#') ELSE '0' END, 12)
        ,drvLoanPaymentTotal5 = RIGHT(REPLICATE('0', 12) + ISNULL(FORMAT(@Payment5, '#0'), ''), 12)
        --RIGHT(SPACE(12) + CASE WHEN @Payment5 > 0 THEN FORMAT(@Payment5, '#') ELSE '0' END, 12)
    INTO dbo.U_ECSB401KEX_Trailer
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
ALTER VIEW dbo.dsi_vwECSB401KEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECSB401KEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECSB401KEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107091'
       ,expStartPerControl     = '202107091'
       ,expLastEndPerControl   = '202107099'
       ,expEndPerControl       = '202107099'
WHERE expFormatCode = 'ECSB401KEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECSB401KEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECSB401KEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECSB401KEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECSB401KEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECSB401KEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECSB401KEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECSB401KEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECSB401KEX', 'UseFileName', 'V', 'Y'


-- End ripout