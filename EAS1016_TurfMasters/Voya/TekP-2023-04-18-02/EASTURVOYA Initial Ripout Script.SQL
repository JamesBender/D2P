/**********************************************************************************

EASTUFVOYA: Voya 401k Combined Export

FormatCode:     EASTUFVOYA
Project:        Voya 401k Combined Export
Client ID:      USG1000
Date/time:      2023-08-01 16:49:29.030
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_EASTUFVOYA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EASTUFVOYA_SavePath') IS NOT NULL DROP TABLE dbo.U_EASTUFVOYA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EASTUFVOYA'


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
WHERE FormatCode = 'EASTUFVOYA'
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
WHERE ExpFormatCode = 'EASTUFVOYA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EASTUFVOYA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EASTUFVOYA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EASTUFVOYA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EASTUFVOYA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EASTUFVOYA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EASTUFVOYA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EASTUFVOYA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EASTUFVOYA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EASTUFVOYA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EASTUFVOYA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEASTUFVOYA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEASTUFVOYA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EASTUFVOYA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASTUFVOYA];
GO
IF OBJECT_ID('U_EASTUFVOYA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EASTUFVOYA_PEarHist];
GO
IF OBJECT_ID('U_EASTUFVOYA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EASTUFVOYA_PDedHist];
GO
IF OBJECT_ID('U_EASTUFVOYA_File') IS NOT NULL DROP TABLE [dbo].[U_EASTUFVOYA_File];
GO
IF OBJECT_ID('U_EASTUFVOYA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EASTUFVOYA_EEList];
GO
IF OBJECT_ID('U_EASTUFVOYA_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EASTUFVOYA_drvTbl];
GO
IF OBJECT_ID('U_EASTUFVOYA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EASTUFVOYA_DedList];
GO
IF OBJECT_ID('U_EASTUFVOYA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EASTUFVOYA_AuditFields];
GO
IF OBJECT_ID('U_EASTUFVOYA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EASTUFVOYA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EASTUFVOYA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EASTUFVOYA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EASTUFVOYA','Voya 401k Combined Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EASTUFVOYAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EASTUFVOYAZ0','7','D','10','1',NULL,'RECORD TYPE',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EASTUFVOYAZ0','6','D','10','2',NULL,'EMPLOYER ID',NULL,NULL,'"drvEmployerId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EASTUFVOYAZ0','1','D','10','3',NULL,'PAYROLL CYCLE',NULL,NULL,'"drvPayrollCycle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EASTUFVOYAZ0','8','D','10','4',NULL,'PAY DATE',NULL,NULL,'"drvPayDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EASTUFVOYAZ0','4','D','10','5',NULL,'IRS CODE',NULL,NULL,'"drvIrsCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EASTUFVOYAZ0','9','D','10','6',NULL,'SSN',NULL,NULL,'"drvSsn"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EASTUFVOYAZ0','10','D','10','7',NULL,'EMPLOYEE NUMBER',NULL,NULL,'"drvEmployeeNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EASTUFVOYAZ0','10','D','10','8',NULL,'DEPARTMENT CODE',NULL,NULL,'"drvDepartmentCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EASTUFVOYAZ0','4','D','10','9',NULL,'LOCATION CODE',NULL,NULL,'"drvLocationCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EASTUFVOYAZ0','20','D','10','10',NULL,'LAST NAME',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EASTUFVOYAZ0','15','D','10','11',NULL,'FIRST NAME',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EASTUFVOYAZ0','1','D','10','12',NULL,'MI',NULL,NULL,'"drvMi"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EASTUFVOYAZ0','25','D','10','13',NULL,'ADDRESS LINE 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EASTUFVOYAZ0','25','D','10','14',NULL,'ADDRESS LINE 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EASTUFVOYAZ0','20','D','10','15',NULL,'CITY',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EASTUFVOYAZ0','2','D','10','16',NULL,'STATE',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EASTUFVOYAZ0','5','D','10','17',NULL,'ZIP CODE',NULL,NULL,'"drvZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EASTUFVOYAZ0','4','D','10','18',NULL,'ZIP EXTENSION',NULL,NULL,'"drvZipExtension"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EASTUFVOYAZ0','1','D','10','19',NULL,'GENDER',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EASTUFVOYAZ0','20','D','10','20',NULL,'RESERVED',NULL,NULL,'"drvReserved"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EASTUFVOYAZ0','1','D','10','21',NULL,'MARITAL STATUS',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EASTUFVOYAZ0','1','D','10','22',NULL,'EMPLOYEE STATUS CODE',NULL,NULL,'"drvEmployeeStatusCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EASTUFVOYAZ0','8','D','10','23',NULL,'DATE OF BIRTH',NULL,NULL,'"drvDateOfBirth"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EASTUFVOYAZ0','8','D','10','24',NULL,'DATE OF ORIGINAL HIRE',NULL,NULL,'"drvDateOfOriginalHire"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EASTUFVOYAZ0','8','D','10','25',NULL,'DATE OF TERMINATION',NULL,NULL,'"drvDateOfTermination"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EASTUFVOYAZ0','8','D','10','26',NULL,'DATE OF REHIRE',NULL,NULL,'"drvDateOfRehire"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EASTUFVOYAZ0','8','D','10','27',NULL,'LEAVE OF ABSENCE START DATE',NULL,NULL,'"drvLeaveOfAbsenceStartDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EASTUFVOYAZ0','8','D','10','28',NULL,'LEAVE OF ABSENCE END DATE',NULL,NULL,'"drvLeaveOfAbsenceEndDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EASTUFVOYAZ0','4','D','10','29',NULL,'PLAN YTD HOURS',NULL,NULL,'"drvPlanYtdHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EASTUFVOYAZ0','4','D','10','30',NULL,'CURRENT PERIOD HOURS',NULL,NULL,'"drvCurrentPeriodHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EASTUFVOYAZ0','4','D','10','31',NULL,'ANNIVERSARY HOURS',NULL,NULL,'"drvAnniversaryHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EASTUFVOYAZ0','1','D','10','32',NULL,'SOURCE CODE 1',NULL,NULL,'"drvSourceCode1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EASTUFVOYAZ0','9','D','10','33',NULL,'CONTRIBUTION AMOUNT SOURCE # 1',NULL,NULL,'"drvContributionAmountSource1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EASTUFVOYAZ0','1','D','10','34',NULL,'SOURCE CODE 2',NULL,NULL,'"drvSourceCode2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EASTUFVOYAZ0','9','D','10','35',NULL,'CONTRIBUTION AMOUNT SOURCE # 2',NULL,NULL,'"drvContributionAmountSource2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EASTUFVOYAZ0','1','D','10','36',NULL,'SOURCE CODE 3',NULL,NULL,'"drvSourceCode3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EASTUFVOYAZ0','9','D','10','37',NULL,'CONTRIBUTION AMOUNT SOURCE # 3',NULL,NULL,'"drvContributionAmountSource3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EASTUFVOYAZ0','1','D','10','38',NULL,'SOURCE CODE 4',NULL,NULL,'"drvSourceCode4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EASTUFVOYAZ0','9','D','10','39',NULL,'CONTRIBUTION AMOUNT SOURCE # 4',NULL,NULL,'"drvContributionAmountSource4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EASTUFVOYAZ0','1','D','10','40',NULL,'SOURCE CODE 5',NULL,NULL,'"drvSourceCode5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EASTUFVOYAZ0','9','D','10','41',NULL,'CONTRIBUTION AMOUNT SOURCE # 5',NULL,NULL,'"drvContributionAmountSource5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EASTUFVOYAZ0','1','D','10','42',NULL,'SOURCE CODE 6',NULL,NULL,'"drvSourceCode6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EASTUFVOYAZ0','9','D','10','43',NULL,'CONTRIBUTION AMOUNT SOURCE # 6',NULL,NULL,'"drvContributionAmountSource6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EASTUFVOYAZ0','3','D','10','44',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EASTUFVOYAZ0','9','D','10','45',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EASTUFVOYAZ0','3','D','10','46',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EASTUFVOYAZ0','9','D','10','47',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EASTUFVOYAZ0','3','D','10','48',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EASTUFVOYAZ0','9','D','10','49',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EASTUFVOYAZ0','3','D','10','50',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EASTUFVOYAZ0','9','D','10','51',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EASTUFVOYAZ0','3','D','10','52',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EASTUFVOYAZ0','9','D','10','53',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EASTUFVOYAZ0','3','D','10','54',NULL,'LOAN NUMBER',NULL,NULL,'"drvLoanNumber5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EASTUFVOYAZ0','9','D','10','55',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL,'"drvEmployeeLoanPayment6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EASTUFVOYAZ0','1','D','10','56',NULL,'UNION MEMBER',NULL,NULL,'"drvUnionMember6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EASTUFVOYAZ0','1','D','10','57',NULL,'EMPLOYEE ELIGIBILITY CODE',NULL,NULL,'"drvEmployeeEligibilityCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EASTUFVOYAZ0','8','D','10','58',NULL,'RESERVED',NULL,NULL,'"drvReserved1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EASTUFVOYAZ0','11','D','10','59',NULL,'YTD GROSS COMPENSATION (415 COMPENSATION)',NULL,NULL,'"drvYtdGrossCompensationComp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EASTUFVOYAZ0','11','D','10','60',NULL,'ER MATCH ELIGIBLE COMPENSATION',NULL,NULL,'"drvERMatchEligibleComp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EASTUFVOYAZ0','11','D','10','61',NULL,'YTD TEST (ADP/ACP) COMPENSATION',NULL,NULL,'"drvYtdTestAdpAcpCompensation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EASTUFVOYAZ0','11','D','10','62',NULL,'YTD ALLOCATION/BENEFIT COMPENSATION',NULL,NULL,'"drvYtdAllocationBenefitComp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EASTUFVOYAZ0','11','D','10','63',NULL,'PLAN ELIGIBLE COMPENSATION',NULL,NULL,'"drvPlanEligibleCompensation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EASTUFVOYAZ0','11','D','10','64',NULL,'ANNUAL SALARY',NULL,NULL,'"drvAnnualSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EASTUFVOYAZ0','11','D','10','65',NULL,'NON-ELECTIVE (PROFIT SHARING) ELIGIBLE COMPENSATIO',NULL,NULL,'"drvNonElectivePSEligibleComp"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EASTUFVOYAZ0','1','D','10','66',NULL,'RESERVED',NULL,NULL,'"drvReserved2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EASTUFVOYAZ0','9','D','10','67',NULL,'RESERVED',NULL,NULL,'"drvReserved3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EASTUFVOYAZ0','1','D','10','68',NULL,'KEY EMPLOYEE INDICATOR',NULL,NULL,'"drvKeyEmployeeIndicator"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EASTUFVOYAZ0','1','D','10','69',NULL,'RESERVED',NULL,NULL,'"drvReserved4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EASTUFVOYAZ0','5','D','10','70',NULL,'NON-QUALIFIED PLAN IDENTIFIER',NULL,NULL,'"drvNonQualifiedPlanIdentifier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EASTUFVOYAZ0','1','D','10','71',NULL,'HIGHLY COMPENSATED EMPLOYEE',NULL,NULL,'"drvHighlyCompensatedEmployee"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EASTUFVOYAZ0','1','D','10','72',NULL,'NON-RESIDENT ALIEN?',NULL,NULL,'"drvNonResidentAlien"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EASTUFVOYAZ0','1','D','10','73',NULL,'RESERVED',NULL,NULL,'"drvReserved5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EASTUFVOYAZ0','40','D','10','74',NULL,'EMAIL ADDRESS',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EASTUFVOYAZ0','4','D','10','75',NULL,'TIER GROUP',NULL,NULL,'"drvTierGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EASTUFVOYAZ0','10','D','10','76',NULL,'CLIENT DATA 1',NULL,NULL,'"drvClientData1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EASTUFVOYAZ0','8','D','10','77',NULL,'CLIENT DATE 1',NULL,NULL,'"drvClientDate1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EASTUFVOYAZ0','10','D','10','78',NULL,'FILLER',NULL,NULL,'"drvFiller"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EASTUFVOYA_20230801.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya 401k Combined Export','202308019','EMPEXPORT','ONDEM_XOE',NULL,'EASTUFVOYA',NULL,NULL,NULL,'202308019','Aug  1 2023  4:48PM','Aug  1 2023  4:48PM','202308011',NULL,'','','202308011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya 401k Combined Expor-Sched','202308019','EMPEXPORT','SCH_EASTUF',NULL,'EASTUFVOYA',NULL,NULL,NULL,'202308019','Aug  1 2023  4:48PM','Aug  1 2023  4:48PM','202308011',NULL,'','','202308011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya 401k Combined Expor-Test','202308019','EMPEXPORT','TEST_XOE',NULL,'EASTUFVOYA',NULL,NULL,NULL,'202308019','Aug  1 2023  4:48PM','Aug  1 2023  4:48PM','202308011',NULL,'','','202308011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUFVOYA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUFVOYA','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUFVOYA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUFVOYA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUFVOYA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUFVOYA','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASTUFVOYA','D10','dbo.U_EASTUFVOYA_drvTbl',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_EASTUFVOYA
-----------

IF OBJECT_ID('U_dsi_BDM_EASTUFVOYA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EASTUFVOYA] (
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
-- Create table U_EASTUFVOYA_Audit
-----------

IF OBJECT_ID('U_EASTUFVOYA_Audit') IS NULL
CREATE TABLE [dbo].[U_EASTUFVOYA_Audit] (
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
-- Create table U_EASTUFVOYA_AuditFields
-----------

IF OBJECT_ID('U_EASTUFVOYA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EASTUFVOYA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EASTUFVOYA_DedList
-----------

IF OBJECT_ID('U_EASTUFVOYA_DedList') IS NULL
CREATE TABLE [dbo].[U_EASTUFVOYA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EASTUFVOYA_drvTbl
-----------

IF OBJECT_ID('U_EASTUFVOYA_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EASTUFVOYA_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordType] varchar(1) NOT NULL,
    [drvEmployerId] varchar(1) NOT NULL,
    [drvPayrollCycle] varchar(1) NOT NULL,
    [drvPayDate] varchar(1) NOT NULL,
    [drvIrsCode] varchar(1) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvEmployeeNumber] varchar(1) NOT NULL,
    [drvDepartmentCode] varchar(1) NOT NULL,
    [drvLocationCode] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMi] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvZipExtension] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvReserved] varchar(1) NOT NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvEmployeeStatusCode] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvDateOfRehire] varchar(1) NOT NULL,
    [drvLeaveOfAbsenceStartDate] varchar(1) NOT NULL,
    [drvLeaveOfAbsenceEndDate] varchar(1) NOT NULL,
    [drvPlanYtdHours] varchar(1) NOT NULL,
    [drvCurrentPeriodHours] varchar(1) NOT NULL,
    [drvAnniversaryHours] varchar(1) NOT NULL,
    [drvSourceCode1] varchar(1) NOT NULL,
    [drvContributionAmountSource1] varchar(1) NOT NULL,
    [drvSourceCode2] varchar(1) NOT NULL,
    [drvContributionAmountSource2] varchar(1) NOT NULL,
    [drvSourceCode3] varchar(1) NOT NULL,
    [drvContributionAmountSource3] varchar(1) NOT NULL,
    [drvSourceCode4] varchar(1) NOT NULL,
    [drvContributionAmountSource4] varchar(1) NOT NULL,
    [drvSourceCode5] varchar(1) NOT NULL,
    [drvContributionAmountSource5] varchar(1) NOT NULL,
    [drvSourceCode6] varchar(1) NOT NULL,
    [drvContributionAmountSource6] varchar(1) NOT NULL,
    [drvLoanNumber] varchar(1) NOT NULL,
    [drvEmployeeLoanPayment1] varchar(1) NOT NULL,
    [drvLoanNumber1] varchar(1) NOT NULL,
    [drvEmployeeLoanPayment2] varchar(1) NOT NULL,
    [drvLoanNumber2] varchar(1) NOT NULL,
    [drvEmployeeLoanPayment3] varchar(1) NOT NULL,
    [drvLoanNumber3] varchar(1) NOT NULL,
    [drvEmployeeLoanPayment4] varchar(1) NOT NULL,
    [drvLoanNumber4] varchar(1) NOT NULL,
    [drvEmployeeLoanPayment5] varchar(1) NOT NULL,
    [drvLoanNumber5] varchar(1) NOT NULL,
    [drvEmployeeLoanPayment6] varchar(1) NOT NULL,
    [drvUnionMember6] varchar(1) NOT NULL,
    [drvEmployeeEligibilityCode] varchar(1) NOT NULL,
    [drvReserved1] varchar(1) NOT NULL,
    [drvYtdGrossCompensationComp] varchar(1) NOT NULL,
    [drvERMatchEligibleComp] varchar(1) NOT NULL,
    [drvYtdTestAdpAcpCompensation] varchar(1) NOT NULL,
    [drvYtdAllocationBenefitComp] varchar(1) NOT NULL,
    [drvPlanEligibleCompensation] varchar(1) NOT NULL,
    [drvAnnualSalary] varchar(1) NOT NULL,
    [drvNonElectivePSEligibleComp] varchar(1) NOT NULL,
    [drvReserved2] varchar(1) NOT NULL,
    [drvReserved3] varchar(1) NOT NULL,
    [drvKeyEmployeeIndicator] varchar(1) NOT NULL,
    [drvReserved4] varchar(1) NOT NULL,
    [drvNonQualifiedPlanIdentifier] varchar(1) NOT NULL,
    [drvHighlyCompensatedEmployee] char(1) NULL,
    [drvNonResidentAlien] varchar(1) NOT NULL,
    [drvReserved5] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvTierGroup] varchar(1) NOT NULL,
    [drvClientData1] varchar(1) NOT NULL,
    [drvClientDate1] varchar(1) NOT NULL,
    [drvFiller] varchar(1) NOT NULL
);

-----------
-- Create table U_EASTUFVOYA_EEList
-----------

IF OBJECT_ID('U_EASTUFVOYA_EEList') IS NULL
CREATE TABLE [dbo].[U_EASTUFVOYA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EASTUFVOYA_File
-----------

IF OBJECT_ID('U_EASTUFVOYA_File') IS NULL
CREATE TABLE [dbo].[U_EASTUFVOYA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EASTUFVOYA_PDedHist
-----------

IF OBJECT_ID('U_EASTUFVOYA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EASTUFVOYA_PDedHist] (
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
-- Create table U_EASTUFVOYA_PEarHist
-----------

IF OBJECT_ID('U_EASTUFVOYA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EASTUFVOYA_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASTUFVOYA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Turfmasters Brands

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 08/01/2023
Service Request Number: TekP-2023-04-18-02

Purpose: Voya 401k Combined Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EASTUFVOYA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EASTUFVOYA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EASTUFVOYA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EASTUFVOYA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EASTUFVOYA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASTUFVOYA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASTUFVOYA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASTUFVOYA', 'SCH_EASTUF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EASTUFVOYA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EASTUFVOYA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EASTUFVOYA';

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
    DELETE FROM dbo.U_EASTUFVOYA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EASTUFVOYA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EASTUFVOYA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUFVOYA_AuditFields;
    CREATE TABLE dbo.U_EASTUFVOYA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EASTUFVOYA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUFVOYA_Audit;
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
    INTO dbo.U_EASTUFVOYA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EASTUFVOYA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EASTUFVOYA_Audit ON dbo.U_EASTUFVOYA_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_EASTUFVOYA_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EASTUFVOYA_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EASTUFVOYA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUFVOYA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EASTUFVOYA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
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
    IF OBJECT_ID('U_EASTUFVOYA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUFVOYA_PDedHist;
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
    INTO dbo.U_EASTUFVOYA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EASTUFVOYA_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EASTUFVOYA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUFVOYA_PEarHist;
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
    INTO dbo.U_EASTUFVOYA_PEarHist
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
    -- DETAIL RECORD - U_EASTUFVOYA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EASTUFVOYA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUFVOYA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = ''
        ,drvEmployerId = ''
        ,drvPayrollCycle = ''
        ,drvPayDate = ''
        ,drvIrsCode = ''
        ,drvSsn = eepSSN
        ,drvEmployeeNumber = ''
        ,drvDepartmentCode = ''
        ,drvLocationCode = ''
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMi = ''
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvZipExtension = ''
        ,drvGender = EepGender
        ,drvReserved = ''
        ,drvMaritalStatus = eepMaritalStatus
        ,drvEmployeeStatusCode = ''
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDateOfRehire = ''
        ,drvLeaveOfAbsenceStartDate = ''
        ,drvLeaveOfAbsenceEndDate = ''
        ,drvPlanYtdHours = ''
        ,drvCurrentPeriodHours = ''
        ,drvAnniversaryHours = ''
        ,drvSourceCode1 = ''
        ,drvContributionAmountSource1 = ''
        ,drvSourceCode2 = ''
        ,drvContributionAmountSource2 = ''
        ,drvSourceCode3 = ''
        ,drvContributionAmountSource3 = ''
        ,drvSourceCode4 = ''
        ,drvContributionAmountSource4 = ''
        ,drvSourceCode5 = ''
        ,drvContributionAmountSource5 = ''
        ,drvSourceCode6 = ''
        ,drvContributionAmountSource6 = ''
        ,drvLoanNumber = ''
        ,drvEmployeeLoanPayment1 = ''
        ,drvLoanNumber1 = ''
        ,drvEmployeeLoanPayment2 = ''
        ,drvLoanNumber2 = ''
        ,drvEmployeeLoanPayment3 = ''
        ,drvLoanNumber3 = ''
        ,drvEmployeeLoanPayment4 = ''
        ,drvLoanNumber4 = ''
        ,drvEmployeeLoanPayment5 = ''
        ,drvLoanNumber5 = ''
        ,drvEmployeeLoanPayment6 = ''
        ,drvUnionMember6 = ''
        ,drvEmployeeEligibilityCode = ''
        ,drvReserved1 = ''
        ,drvYtdGrossCompensationComp = ''
        ,drvERMatchEligibleComp = ''
        ,drvYtdTestAdpAcpCompensation = ''
        ,drvYtdAllocationBenefitComp = ''
        ,drvPlanEligibleCompensation = ''
        ,drvAnnualSalary = ''
        ,drvNonElectivePSEligibleComp = ''
        ,drvReserved2 = ''
        ,drvReserved3 = ''
        ,drvKeyEmployeeIndicator = ''
        ,drvReserved4 = ''
        ,drvNonQualifiedPlanIdentifier = ''
        ,drvHighlyCompensatedEmployee = EecIsHighlyComp
        ,drvNonResidentAlien = ''
        ,drvReserved5 = ''
        ,drvEmailAddress = EepAddressEMail
        ,drvTierGroup = ''
        ,drvClientData1 = ''
        ,drvClientDate1 = ''
        ,drvFiller = ''
    INTO dbo.U_EASTUFVOYA_drvTbl
    FROM dbo.U_EASTUFVOYA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EASTUFVOYA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
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
ALTER VIEW dbo.dsi_vwEASTUFVOYA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EASTUFVOYA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EASTUFVOYA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307251'
       ,expStartPerControl     = '202307251'
       ,expLastEndPerControl   = '202308019'
       ,expEndPerControl       = '202308019'
WHERE expFormatCode = 'EASTUFVOYA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEASTUFVOYA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EASTUFVOYA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EASTUFVOYA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EASTUFVOYA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EASTUFVOYA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EASTUFVOYA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EASTUFVOYA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EASTUFVOYA', 'UseFileName', 'V', 'Y'


-- End ripout