/**********************************************************************************

EMCPVOYAXP: VOYA 401K Census Export

FormatCode:     EMCPVOYAXP
Project:        VOYA 401K Census Export
Client ID:      MOU1003
Date/time:      2023-01-05 12:51:53.867
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB01
Database:       ULTIPRO_WPMCPL
Web Filename:   MOU1003_6O5TG_EEHISTORY_EMCPVOYAXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMCPVOYAXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EMCPVOYAXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMCPVOYAXP'


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
WHERE FormatCode = 'EMCPVOYAXP'
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
WHERE ExpFormatCode = 'EMCPVOYAXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMCPVOYAXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMCPVOYAXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMCPVOYAXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMCPVOYAXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMCPVOYAXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMCPVOYAXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMCPVOYAXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMCPVOYAXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMCPVOYAXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMCPVOYAXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMCPVOYAXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMCPVOYAXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMCPVOYAXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMCPVOYAXP];
GO
IF OBJECT_ID('U_EMCPVOYAXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMCPVOYAXP_PEarHist];
GO
IF OBJECT_ID('U_EMCPVOYAXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMCPVOYAXP_PDedHist];
GO
IF OBJECT_ID('U_EMCPVOYAXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMCPVOYAXP_File];
GO
IF OBJECT_ID('U_EMCPVOYAXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMCPVOYAXP_EEList];
GO
IF OBJECT_ID('U_EMCPVOYAXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMCPVOYAXP_drvTbl];
GO
IF OBJECT_ID('U_EMCPVOYAXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMCPVOYAXP_DedList];
GO
IF OBJECT_ID('U_EMCPVOYAXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMCPVOYAXP_AuditFields];
GO
IF OBJECT_ID('U_EMCPVOYAXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMCPVOYAXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMCPVOYAXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMCPVOYAXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMCPVOYAXP','VOYA 401K Census Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EMCPVOYAXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMCPVOYAXPZ0','7','D','10','1',NULL,'RECORD TYPE',NULL,NULL,'"INGWIN6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMCPVOYAXPZ0','6','D','10','2',NULL,'EMPLOYER ID',NULL,NULL,'"774162"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMCPVOYAXPZ0','1','D','10','3',NULL,'PAYROLL CYCLE',NULL,NULL,'"drvPayrollCycle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMCPVOYAXPZ0','8','D','10','4',NULL,'PAY DATE',NULL,NULL,'"drvPayDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMCPVOYAXPZ0','4','D','10','5',NULL,'IRS CODE',NULL,NULL,'"401K"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMCPVOYAXPZ0','9','D','10','6',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMCPVOYAXPZ0','10','D','10','7',NULL,'EMPLOYEE NUMBER',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMCPVOYAXPZ0','10','D','10','8',NULL,'DEPARTMENT CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMCPVOYAXPZ0','4','D','10','9',NULL,'LOCATION CODE',NULL,NULL,'"drvLocationCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMCPVOYAXPZ0','20','D','10','10',NULL,'LAST NAME',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMCPVOYAXPZ0','15','D','10','11',NULL,'FIRST NAME',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMCPVOYAXPZ0','1','D','10','12',NULL,'MI',NULL,NULL,'"drvMI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMCPVOYAXPZ0','25','D','10','13',NULL,'ADDRESS LINE 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMCPVOYAXPZ0','25','D','10','14',NULL,'ADDRESS LINE 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMCPVOYAXPZ0','20','D','10','15',NULL,'CITY',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMCPVOYAXPZ0','2','D','10','16',NULL,'STATE',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMCPVOYAXPZ0','5','D','10','17',NULL,'ZIP CODE',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMCPVOYAXPZ0','4','D','10','18',NULL,'ZIP EXTENSION',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMCPVOYAXPZ0','1','D','10','19',NULL,'GENDER',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMCPVOYAXPZ0','20','D','10','20',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMCPVOYAXPZ0','1','D','10','21',NULL,'MARITAL STATUS',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMCPVOYAXPZ0','1','D','10','22',NULL,'EMPLOYEE STATUS CODE',NULL,NULL,'"drvEmployeeStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMCPVOYAXPZ0','8','D','10','23',NULL,'DATE OF BIRTH',NULL,NULL,'"drvDateOfBirth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMCPVOYAXPZ0','8','D','10','24',NULL,'DATE OF ORIGINAL HIRE',NULL,NULL,'"drvDateOfOriginalHire"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMCPVOYAXPZ0','8','D','10','25',NULL,'DATE OF TERMINATION',NULL,NULL,'"drvDateOfTermination"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMCPVOYAXPZ0','8','D','10','26',NULL,'DATE OF REHIRE',NULL,NULL,'"drvDateOfRehire"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMCPVOYAXPZ0','8','D','10','27',NULL,'LEAVE OF ABSENCE START DATE',NULL,NULL,'"drvLeaveOfAbsenceStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMCPVOYAXPZ0','8','D','10','28',NULL,'LEAVE OF ABSENCE END DATE',NULL,NULL,'"drvLeaveOfAbsenceEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMCPVOYAXPZ0','4','D','10','29',NULL,'PLAN YTD HOURS',NULL,NULL,'"drvPlanYtdHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMCPVOYAXPZ0','4','D','10','30',NULL,'CURRENT PERIOD HOURS',NULL,NULL,'"drvCurrentPeriodHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMCPVOYAXPZ0','4','D','10','31',NULL,'ANNIVERSARY HOURS',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMCPVOYAXPZ0','1','D','10','32',NULL,'SOURCE CODE 1',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMCPVOYAXPZ0','9','D','10','33',NULL,'CONTRIBUTION AMOUNT SOURCE # 1',NULL,NULL,'"drvContributionAmountSource1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMCPVOYAXPZ0','1','D','10','34',NULL,'SOURCE CODE 2',NULL,NULL,'"G"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMCPVOYAXPZ0','9','D','10','35',NULL,'CONTRIBUTION AMOUNT SOURCE # 2',NULL,NULL,'"drvContributionAmountSource2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMCPVOYAXPZ0','1','D','10','36',NULL,'SOURCE CODE 3',NULL,NULL,'"D"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMCPVOYAXPZ0','9','D','10','37',NULL,'CONTRIBUTION AMOUNT SOURCE # 3',NULL,NULL,'"drvContributionAmountSource3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMCPVOYAXPZ0','1','D','10','38',NULL,'SOURCE CODE 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMCPVOYAXPZ0','9','D','10','39',NULL,'CONTRIBUTION AMOUNT SOURCE # 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMCPVOYAXPZ0','1','D','10','40',NULL,'SOURCE CODE 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMCPVOYAXPZ0','9','D','10','41',NULL,'CONTRIBUTION AMOUNT SOURCE # 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMCPVOYAXPZ0','1','D','10','42',NULL,'SOURCE CODE 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMCPVOYAXPZ0','9','D','10','43',NULL,'CONTRIBUTION AMOUNT SOURCE # 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMCPVOYAXPZ0','3','D','10','44',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMCPVOYAXPZ0','9','D','10','45',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMCPVOYAXPZ0','3','D','10','46',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMCPVOYAXPZ0','9','D','10','47',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMCPVOYAXPZ0','3','D','10','48',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMCPVOYAXPZ0','9','D','10','49',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMCPVOYAXPZ0','3','D','10','50',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMCPVOYAXPZ0','9','D','10','51',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMCPVOYAXPZ0','3','D','10','52',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMCPVOYAXPZ0','9','D','10','53',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EMCPVOYAXPZ0','3','D','10','54',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EMCPVOYAXPZ0','9','D','10','55',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EMCPVOYAXPZ0','1','D','10','56',NULL,'UNION MEMBER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EMCPVOYAXPZ0','1','D','10','57',NULL,'EMPLOYEE ELIGIBILITY CODE',NULL,NULL,'"drvEmployeeEligibilityCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EMCPVOYAXPZ0','8','D','10','58',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EMCPVOYAXPZ0','11','D','10','59',NULL,'YTD GROSS COMPENSATION',NULL,NULL,'"drvYtdGrossCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EMCPVOYAXPZ0','11','D','10','60',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EMCPVOYAXPZ0','11','D','10','61',NULL,'YTD TEST (ADP/ACP) COMPENSATION',NULL,NULL,'"drvYtdTestAdpAcpCompensation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EMCPVOYAXPZ0','11','D','10','62',NULL,'YTD ALLOCATION/BENEFIT COMPENSATION',NULL,NULL,'"drvYtdAllocationBenefitComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EMCPVOYAXPZ0','11','D','10','63',NULL,'RESERVED',NULL,NULL,'"drvReserved"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EMCPVOYAXPZ0','11','D','10','64',NULL,'ANNUAL SALARY',NULL,NULL,'"drvAnnualSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EMCPVOYAXPZ0','11','D','10','65',NULL,'MISCELLANEOUS COMPENSATION',NULL,NULL,'"drvMisComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EMCPVOYAXPZ0','1','D','10','66',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EMCPVOYAXPZ0','9','D','10','67',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EMCPVOYAXPZ0','1','D','10','68',NULL,'KEY EMPLOYEE INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EMCPVOYAXPZ0','1','D','10','69',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EMCPVOYAXPZ0','5','D','10','70',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EMCPVOYAXPZ0','1','D','10','71',NULL,'HIGHLY COMPENSATED EMPLOYEE',NULL,NULL,'"drvHighlyCompensatedEmployee"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EMCPVOYAXPZ0','1','D','10','72',NULL,'NON-RESIDENT ALIEN?',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EMCPVOYAXPZ0','1','D','10','73',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EMCPVOYAXPZ0','40','D','10','74',NULL,'EMAIL ADDRESS',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EMCPVOYAXPZ0','4','D','10','75',NULL,'TIER GROUP',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EMCPVOYAXPZ0','10','D','10','76',NULL,'CLIENT DATA 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EMCPVOYAXPZ0','8','D','10','77',NULL,'CLIENT DATE 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EMCPVOYAXPZ0','10','D','10','78',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMCPVOYAXP_20230105.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'VOYA 401K Census Export','202212319','EMPEXPORT','ONDEM_XOE',NULL,'EMCPVOYAXP',NULL,NULL,NULL,'202212319','Jan  5 2023 10:19AM','Jan  5 2023 10:19AM','202211011',NULL,'','','202211011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'VOYA 401K Census Export-Sched','202212319','EMPEXPORT','SCH_EMCPVO',NULL,'EMCPVOYAXP',NULL,NULL,NULL,'202212319','Jan  5 2023 10:19AM','Jan  5 2023 10:19AM','202211011',NULL,'','','202211011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'VOYA 401K Census Export-Test','202212319','EMPEXPORT','TEST_XOE',NULL,'EMCPVOYAXP',NULL,NULL,NULL,'202212319','Jan  5 2023 10:19AM','Jan  5 2023 10:19AM','202211011',NULL,'','','202211011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPVOYAXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPVOYAXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPVOYAXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPVOYAXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPVOYAXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMCPVOYAXP','D10','dbo.U_EMCPVOYAXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMCPVOYAXP
-----------

IF OBJECT_ID('U_dsi_BDM_EMCPVOYAXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMCPVOYAXP] (
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
-- Create table U_EMCPVOYAXP_Audit
-----------

IF OBJECT_ID('U_EMCPVOYAXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EMCPVOYAXP_Audit] (
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
-- Create table U_EMCPVOYAXP_AuditFields
-----------

IF OBJECT_ID('U_EMCPVOYAXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMCPVOYAXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EMCPVOYAXP_DedList
-----------

IF OBJECT_ID('U_EMCPVOYAXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EMCPVOYAXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMCPVOYAXP_drvTbl
-----------

IF OBJECT_ID('U_EMCPVOYAXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMCPVOYAXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPayrollCycle] varchar(1) NULL,
    [drvPayDate] varchar(8) NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [EecFullTimeOrPartTime] char(1) NULL,
    [EecOrgLvl3] varchar(10) NULL,
    [drvLocationCode] varchar(4) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMI] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvEmployeeStatusCode] varchar(1) NULL,
    [drvDateOfBirth] varchar(8) NULL,
    [drvDateOfOriginalHire] varchar(8) NULL,
    [drvDateOfTermination] varchar(8) NULL,
    [drvDateOfRehire] varchar(8) NULL,
    [drvLeaveOfAbsenceStartDate] varchar(8) NULL,
    [drvLeaveOfAbsenceEndDate] varchar(8) NULL,
    [drvPlanYtdHours] nvarchar(4000) NULL,
    [drvCurrentPeriodHours] nvarchar(4000) NULL,
    [drvContributionAmountSource1] varchar(24) NULL,
    [drvContributionAmountSource2] varchar(24) NULL,
    [drvContributionAmountSource3] varchar(24) NULL,
    [drvLoanNumber1] varchar(3) NOT NULL,
    [drvEmployeeLoanPayment1] varchar(24) NULL,
    [drvLoanNumber2] varchar(3) NOT NULL,
    [drvEmployeeLoanPayment2] varchar(24) NULL,
    [drvLoanNumber3] varchar(3) NOT NULL,
    [drvEmployeeLoanPayment3] varchar(1) NOT NULL,
    [drvLoanNumber4] varchar(3) NOT NULL,
    [drvEmployeeLoanPayment4] varchar(1) NOT NULL,
    [drvLoanNumber5] varchar(3) NOT NULL,
    [drvEmployeeLoanPayment5] varchar(1) NOT NULL,
    [drvLoanNumber6] varchar(3) NOT NULL,
    [drvEmployeeLoanPayment6] varchar(1) NOT NULL,
    [drvEmployeeEligibilityCode] varchar(1) NULL,
    [drvYtdGrossCompensation] varchar(24) NULL,
    [drvYtdTestAdpAcpCompensation] varchar(11) NOT NULL,
    [drvYtdAllocationBenefitComp] varchar(11) NOT NULL,
    [drvReserved] varchar(11) NOT NULL,
    [drvAnnualSalary] varchar(24) NULL,
    [drvMisComp] varchar(11) NOT NULL,
    [drvHighlyCompensatedEmployee] char(1) NULL,
    [drvEmailAddress] varchar(50) NULL
);

-----------
-- Create table U_EMCPVOYAXP_EEList
-----------

IF OBJECT_ID('U_EMCPVOYAXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMCPVOYAXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMCPVOYAXP_File
-----------

IF OBJECT_ID('U_EMCPVOYAXP_File') IS NULL
CREATE TABLE [dbo].[U_EMCPVOYAXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EMCPVOYAXP_PDedHist
-----------

IF OBJECT_ID('U_EMCPVOYAXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMCPVOYAXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401k] numeric NULL,
    [PdhRoth] numeric NULL,
    [Pdh401KM] numeric NULL,
    [Pdh401CU] numeric NULL,
    [PdhRTHCU] numeric NULL,
    [Pdh401KL] numeric NULL,
    [Pdh401KL2] numeric NULL
);

-----------
-- Create table U_EMCPVOYAXP_PEarHist
-----------

IF OBJECT_ID('U_EMCPVOYAXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMCPVOYAXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMCPVOYAXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Mountain Capital Partners

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 01/05/2023
Service Request Number: TekP-2022-09-27-04

Purpose: VOYA 401K Census Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMCPVOYAXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMCPVOYAXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMCPVOYAXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMCPVOYAXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMCPVOYAXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPVOYAXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPVOYAXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPVOYAXP', 'SCH_EMCPVO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMCPVOYAXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMCPVOYAXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMCPVOYAXP';

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
    DELETE FROM dbo.U_EMCPVOYAXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMCPVOYAXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    ----==========================================
    ---- Audit Section
    ----==========================================
    ---- Get data from audit fields table. Add fields here if auditing
    --IF OBJECT_ID('U_EMCPVOYAXP_AuditFields','U') IS NOT NULL
    --    DROP TABLE dbo.U_EMCPVOYAXP_AuditFields;
    --CREATE TABLE dbo.U_EMCPVOYAXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    ---- Create audit table based on fields defined above
    --IF OBJECT_ID('U_EMCPVOYAXP_Audit','U') IS NOT NULL
    --    DROP TABLE dbo.U_EMCPVOYAXP_Audit;
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
    --INTO dbo.U_EMCPVOYAXP_Audit
    --FROM dbo.vw_AuditData WITH (NOLOCK) 
    --JOIN dbo.U_EMCPVOYAXP_AuditFields WITH (NOLOCK) 
    --    ON audTableName = aTableName
    --    AND audFieldName = aFieldName
    --WHERE audDateTime BETWEEN @StartDate AND @EndDate
    --AND audAction <> 'DELETE';

    ---- Create Index
    --CREATE CLUSTERED INDEX CDX_U_EMCPVOYAXP_Audit ON dbo.U_EMCPVOYAXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EMCPVOYAXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMCPVOYAXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList =  '401K,ROTH,401KM,401CU,RTHCU,401L,401L2';

    IF OBJECT_ID('U_EMCPVOYAXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPVOYAXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMCPVOYAXP_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMCPVOYAXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPVOYAXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401k     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRoth    = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401KM     = SUM(CASE WHEN PdhDedCode IN ('401KM') THEN PdhERCurAmt ELSE 0.00 END)        
        ,Pdh401CU     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRTHCU     = SUM(CASE WHEN PdhDedCode IN ('RTHCU') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401KL     = SUM(CASE WHEN PdhDedCode IN ('401KL') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,Pdh401KL2     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        --,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EMCPVOYAXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMCPVOYAXP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
  --  AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EMCPVOYAXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPVOYAXP_PEarHist;
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
    INTO dbo.U_EMCPVOYAXP_PEarHist
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
    -- DETAIL RECORD - U_EMCPVOYAXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMCPVOYAXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPVOYAXP_drvTbl;
 SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPayrollCycle = CASE EecPayPeriod 
                                WHEN 'M' THEN '4'
                                WHEN 'S' THEN '5'
                                WHEN 'B' THEN '6'
                                WHEN 'W' THEN '7'
                            END
        ,drvPayDate = CONVERT(VARCHAR(8),PrgPayDate, 112)
        ,drvSSN = eepSSN
        ,drvEmployeeNumber = EecEmpNo
        ,EecFullTimeOrPartTime
        ,EecOrgLvl3 
        ,drvLocationCode = CASE WHEN EecFullTimeOrPartTime = 'F' THEN
                                CASE EecOrgLvl3 
                                        WHEN 'PRM'  THEN '1001'
                                        WHEN 'MCP'  THEN '1002'
                                        WHEN 'AZSB' THEN '1003'
                                        WHEN 'PAJ'  THEN '1004'
                                        WHEN 'SIP'  THEN '1005'
                                        WHEN 'HES' THEN '1006'
                                        WHEN 'NVR' THEN '1007'
                                        WHEN 'EAGL' THEN '1008'
                                        WHEN 'DMC' THEN '1010' 
                                        WHEN 'BHR' THEN '1011'  
                                        WHEN 'SJR' THEN ''
                                        WHEN 'KML' THEN ''
                                        WHEN 'ELK'  THEN ''
                                        WHEN 'MTL'  THEN ''
                                    END
                                    ELSE
                                CASE WHEN EecFullTimeOrPartTime = 'P' THEN 
                                    CASE EecOrgLvl3
                                        WHEN 'PRM'  THEN '2001'
                                        WHEN 'MCP'  THEN '2002'
                                        WHEN 'AZSB' THEN '2003'
                                        WHEN 'PAJ'  THEN '2004'
                                        WHEN 'SIP'  THEN '2005'
                                        WHEN 'HES' THEN '2006'
                                        WHEN 'NVR' THEN '2007'
                                        WHEN 'EAGL' THEN '2008'
                                        WHEN 'DMC' THEN '2010' 
                                        WHEN 'BHR' THEN '2011' 
                                        WHEN 'SJR' THEN ''
                                        WHEN 'KML' THEN ''
                                        WHEN 'ELK'  THEN ''
                                        WHEN 'MTL'  THEN ''
                                    END
                                 END
                                END
        ,drvLastName = UPPER(EepNameLast)
        ,drvFirstName = UPPER(EepNameFirst)
        ,drvMI = UPPER(Left(EepNameMiddle,1))
        ,drvAddressLine1 = UPPER(EepAddressLine1)
        ,drvAddressLine2 = UPPER(EepAddressLine2)
        ,drvCity = UPPER(EepAddressCity)
        ,drvState = UPPER(EepAddressState)
        ,drvZipCode = EepAddressZipCode
        ,drvGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvEmployeeStatusCode =  CASE WHEN EecEmplStatus IN ('A','L') THEN 'A'
                                       WHEN EecEmplStatus IN ('T') THEN 'T'
                                       END
        ,drvDateOfBirth = CONVERT(VARCHAR(8),EepDateOfBirth , 112)
        ,drvDateOfOriginalHire = CONVERT(VARCHAR(8),EecDateOfOriginalHire , 112)
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN CONVERT(VARCHAR(8),EecDateOfTermination  , 112) END
        ,drvDateOfRehire = CONVERT(VARCHAR(8),CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire AND (EecJobChangeReason = '101' OR EecHireSource = 'REHIRE') then EecDateOfLastHire Else EecDateOfOriginalHire END, 112)
        ,drvLeaveOfAbsenceStartDate = CASE WHEN EecEmplStatus = 'L' THEN CONVERT(VARCHAR(8),EecEmplStatusStartDate, 112) END
        ,drvLeaveOfAbsenceEndDate =  CASE WHEN EecEmplStatus = 'A' and  EshEmplStatus = 'L' THEN CONVERT(VARCHAR(8),EshStatusStopDate, 112) END
        ,drvPlanYtdHours = FORMaT(PehCurHrsYTD, '0000')
        ,drvCurrentPeriodHours = FORMaT(PehCurHrs, '0000')
        ,drvContributionAmountSource1 = Case when isnull(dbo.dsi_fnPadZero(REPLACE(Pdh401k + Pdh401CU, '.',''),9, 0), '' ) <> '' THEN  dbo.dsi_fnPadZero(REPLACE(Pdh401k + Pdh401CU, '.',''),9, 0) ELSE dbo.dsi_fnPadZero('',9, 0) END
        ,drvContributionAmountSource2 = CASE WHEn ISNULL(dbo.dsi_fnPadZero(REPLACE(PdhROTH + PdhRTHCU, '.',''),9,0), '' ) <> '' THEN dbo.dsi_fnPadZero(REPLACE(PdhROTH + PdhRTHCU, '.',''),9,0) ELSE dbo.dsi_fnPadZero('',9, 0) END
        ,drvContributionAmountSource3 = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(Pdh401KM, '.',''),9,0), '') <> '' THEn dbo.dsi_fnPadZero(REPLACE(Pdh401KM, '.',''),9,0) ELSE dbo.dsi_fnPadZero('',9, 0) END
        ,drvLoanNumber1 = '001'
        ,drvEmployeeLoanPayment1 = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(Pdh401KL, '.',''),9,0), '') <> '' THEN dbo.dsi_fnPadZero(REPLACE(Pdh401KL, '.',''),9,0) ELSE dbo.dsi_fnPadZero('',9, 0) END
        ,drvLoanNumber2 = '002'
        ,drvEmployeeLoanPayment2 = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(Pdh401KL2, '.',''),9,0), '') <> '' THEN dbo.dsi_fnPadZero(REPLACE(Pdh401KL2, '.',''),9,0) ELSE dbo.dsi_fnPadZero('',9, 0) END
        ,drvLoanNumber3 = '000'
        ,drvEmployeeLoanPayment3 = ''
        ,drvLoanNumber4 = '000'
        ,drvEmployeeLoanPayment4 = ''
        ,drvLoanNumber5 = '000'
        ,drvEmployeeLoanPayment5 = ''
        ,drvLoanNumber6 = '000'
        ,drvEmployeeLoanPayment6 = ''
        ,drvEmployeeEligibilityCode = CASE WHEN  EecEmplStatus = 'A' AND BdmBenstatus = 'A' THEN 'Y'
                                           WHEN EecEEType IN ('CON','INT','SUM','TMP','VOL') or EecEmplStatus = 'T' THEN 'I' 
                                         END
        ,drvYtdGrossCompensation = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(PehCurAmtYTD, '.',''),11,0), '') <> '' THEN dbo.dsi_fnPadZero(REPLACE(PehCurAmtYTD, '.',''),11,0) ELSE dbo.dsi_fnPadZero('',11, 0) END
        ,drvYtdTestAdpAcpCompensation = '00000000000'
        ,drvYtdAllocationBenefitComp = '00000000000'
        ,drvReserved = '00000000000'
        ,drvAnnualSalary = CASE WHEN ISNULL(dbo.dsi_fnPadZero(REPLACE(EecAnnSalary, '.',''),11,0), '') <> '' THEn dbo.dsi_fnPadZero(REPLACE(EecAnnSalary, '.',''),11,0)  ELSE dbo.dsi_fnPadZero('',11, 0) END
        ,drvMisComp = '00000000000'
        ,drvHighlyCompensatedEmployee = EecIsHighlyComp
        ,drvEmailAddress = EepAddressEMail
    INTO dbo.U_EMCPVOYAXP_drvTbl
    FROM dbo.U_EMCPVOYAXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EMCPVOYAXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIn dbo.U_EMCPVOYAXP_PEarHist WITH (NOLOCK)
        ON PehEEID = XEEID
    LEFT JOIN dbo.U_EMCPVOYAXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
     LEFT JOIN (
                SELECT EshEEID, EshCOID,  EshEmplStatus, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    WHERE EecEEType NOT IN ('CON','INT','SUM','TMP','VOL','TES')
    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND (Pdh401CU  > 0  OR Pdh401k > 0 OR PdhRTHCU > 0 OR  PdhRoth > 0 OR PehCurHrsYTD > 0 OR PehCurAmt > 0)) OR (EecEmplStatus = 'T' AND ( EecDateOfTermination Between @StartDate and @EndDate)))
    ;


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
ALTER VIEW dbo.dsi_vwEMCPVOYAXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMCPVOYAXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EMCPVOYAXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202211011'
       ,expStartPerControl     = '202211011'
       ,expLastEndPerControl   = '202212319'
       ,expEndPerControl       = '202212319'
WHERE expFormatCode = 'EMCPVOYAXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMCPVOYAXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMCPVOYAXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMCPVOYAXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMCPVOYAXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMCPVOYAXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMCPVOYAXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMCPVOYAXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMCPVOYAXP', 'UseFileName', 'V', 'Y'


-- End ripout