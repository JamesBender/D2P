/**********************************************************************************

EQFCUEMPEX: Salary.com Employee File Export

FormatCode:     EQFCUEMPEX
Project:        Salary.com Employee File Export
Client ID:      QUO1000
Date/time:      2023-05-17 07:04:50.660
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP1DB01
Database:       ULTIPRO_WPQFCU
Web Filename:   QUO1000_E1214_EEHISTORY_EQFCUEMPEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EQFCUEMPEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EQFCUEMPEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EQFCUEMPEX'


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
WHERE FormatCode = 'EQFCUEMPEX'
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
WHERE ExpFormatCode = 'EQFCUEMPEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EQFCUEMPEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EQFCUEMPEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EQFCUEMPEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EQFCUEMPEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EQFCUEMPEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EQFCUEMPEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EQFCUEMPEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EQFCUEMPEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EQFCUEMPEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EQFCUEMPEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEQFCUEMPEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEQFCUEMPEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EQFCUEMPEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQFCUEMPEX];
GO
IF OBJECT_ID('U_EQFCUEMPEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EQFCUEMPEX_PEarHist];
GO
IF OBJECT_ID('U_EQFCUEMPEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EQFCUEMPEX_PDedHist];
GO
IF OBJECT_ID('U_EQFCUEMPEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EQFCUEMPEX_Header];
GO
IF OBJECT_ID('U_EQFCUEMPEX_File') IS NOT NULL DROP TABLE [dbo].[U_EQFCUEMPEX_File];
GO
IF OBJECT_ID('U_EQFCUEMPEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EQFCUEMPEX_EEList];
GO
IF OBJECT_ID('U_EQFCUEMPEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EQFCUEMPEX_drvTbl];
GO
IF OBJECT_ID('U_EQFCUEMPEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EQFCUEMPEX_DedList];
GO
IF OBJECT_ID('U_EQFCUEMPEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EQFCUEMPEX_AuditFields];
GO
IF OBJECT_ID('U_EQFCUEMPEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EQFCUEMPEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EQFCUEMPEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EQFCUEMPEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EQFCUEMPEX','Salary.com Employee File Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','6000','S','N','EQFCUEMPEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQFCUEMPEXZ0','50','H','01','1',NULL,'EmployeeID',NULL,NULL,'"EmployeeID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQFCUEMPEXZ0','50','H','01','2',NULL,'EmployeeStateCode',NULL,NULL,'"EmployeeStateCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQFCUEMPEXZ0','50','H','01','3',NULL,'EmployeeZipCode',NULL,NULL,'"EmployeeZipCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQFCUEMPEXZ0','50','H','01','4',NULL,'EmployeeCountryCode',NULL,NULL,'"EmployeeCountryCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQFCUEMPEXZ0','50','H','01','5',NULL,'CompanyJobCode',NULL,NULL,'"CompanyJobCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQFCUEMPEXZ0','50','H','01','6',NULL,'TierCode',NULL,NULL,'"TierCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQFCUEMPEXZ0','50','H','01','7',NULL,'StructureCode',NULL,NULL,'"StructureCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQFCUEMPEXZ0','50','H','01','8',NULL,'SalaryPlanCode',NULL,NULL,'"SalaryPlanCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQFCUEMPEXZ0','50','H','01','9',NULL,'BaseSalary',NULL,NULL,'"BaseSalary"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQFCUEMPEXZ0','50','H','01','10',NULL,'CurrencyCode',NULL,NULL,'"CurrencyCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQFCUEMPEXZ0','50','H','01','11',NULL,'IsSalaried',NULL,NULL,'"IsSalaried"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQFCUEMPEXZ0','50','H','01','12',NULL,'EntityID',NULL,NULL,'"EntityID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQFCUEMPEXZ0','50','H','01','13',NULL,'IsExempt',NULL,NULL,'"IsExempt"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQFCUEMPEXZ0','50','H','01','14',NULL,'BonusTargetPercent',NULL,NULL,'"BonusTargetPercent"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQFCUEMPEXZ0','50','H','01','15',NULL,'Bonus',NULL,NULL,'"Bonus"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQFCUEMPEXZ0','50','H','01','16',NULL,'AnnualWorkHours',NULL,NULL,'"AnnualWorkHours"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQFCUEMPEXZ0','50','H','01','17',NULL,'HireDate',NULL,NULL,'"HireDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQFCUEMPEXZ0','50','H','01','18',NULL,'FirstName',NULL,NULL,'"FirstName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQFCUEMPEXZ0','50','H','01','19',NULL,'LastName',NULL,NULL,'"LastName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQFCUEMPEXZ0','50','H','01','20',NULL,'BirthDate',NULL,NULL,'"BirthDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQFCUEMPEXZ0','50','H','01','21',NULL,'GenderCode',NULL,NULL,'"GenderCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQFCUEMPEXZ0','50','H','01','22',NULL,'EthnicityCode',NULL,NULL,'"EthnicityCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQFCUEMPEXZ0','50','H','01','23',NULL,'EmployeeCity',NULL,NULL,'"EmployeeCity"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQFCUEMPEXZ0','50','H','01','24',NULL,'DepartmentID',NULL,NULL,'"DepartmentID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQFCUEMPEXZ0','50','H','01','25',NULL,'EmploymentStatusCode',NULL,NULL,'"EmploymentStatusCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EQFCUEMPEXZ0','50','H','01','26',NULL,'ReportToEmployeeID',NULL,NULL,'"ReportToEmployeeID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EQFCUEMPEXZ0','50','H','01','27',NULL,'SiteCode',NULL,NULL,'"SiteCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EQFCUEMPEXZ0','50','H','01','28',NULL,'TotalDirectCompensation',NULL,NULL,'"TotalDirectCompensation"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EQFCUEMPEXZ0','50','H','01','29',NULL,'FixedPay',NULL,NULL,'"FixedPay"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EQFCUEMPEXZ0','50','H','01','30',NULL,'Allow',NULL,NULL,'"Allow"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EQFCUEMPEXZ0','50','H','01','31',NULL,'TGP',NULL,NULL,'"TGP"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EQFCUEMPEXZ0','50','H','01','32',NULL,'AVP',NULL,NULL,'"AVP"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EQFCUEMPEXZ0','50','H','01','33',NULL,'TVP',NULL,NULL,'"TVP"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EQFCUEMPEXZ0','50','H','01','34',NULL,'TEC',NULL,NULL,'"TEC"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EQFCUEMPEXZ0','50','H','01','35',NULL,'LTI1',NULL,NULL,'"LTI1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EQFCUEMPEXZ0','50','H','01','36',NULL,'LTI2',NULL,NULL,'"LTI2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EQFCUEMPEXZ0','50','H','01','37',NULL,'LTI3',NULL,NULL,'"LTI3"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EQFCUEMPEXZ0','50','H','01','38',NULL,'LTI4',NULL,NULL,'"LTI4"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EQFCUEMPEXZ0','50','H','01','39',NULL,'LTI5',NULL,NULL,'"LTI5"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EQFCUEMPEXZ0','50','H','01','40',NULL,'LTI6',NULL,NULL,'"LTI6"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EQFCUEMPEXZ0','50','H','01','41',NULL,'LTI7',NULL,NULL,'"LTI7"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EQFCUEMPEXZ0','50','H','01','42',NULL,'LTI8',NULL,NULL,'"LTI8"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EQFCUEMPEXZ0','50','H','01','43',NULL,'LTI9',NULL,NULL,'"LTI9"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EQFCUEMPEXZ0','50','H','01','44',NULL,'ShiftCode',NULL,NULL,'"ShiftCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EQFCUEMPEXZ0','50','H','01','45',NULL,'IsOTEligible',NULL,NULL,'"IsOTEligible"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EQFCUEMPEXZ0','50','H','01','46',NULL,'DateStartedJob',NULL,NULL,'"DateStartedJob"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EQFCUEMPEXZ0','50','H','01','47',NULL,'TerminationDate',NULL,NULL,'"TerminationDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EQFCUEMPEXZ0','50','H','01','48',NULL,'SigningBonus',NULL,NULL,'"SigningBonus"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EQFCUEMPEXZ0','50','H','01','49',NULL,'PerfRatingScaleCode',NULL,NULL,'"PerfRatingScaleCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EQFCUEMPEXZ0','50','H','01','50',NULL,'PerformanceNum',NULL,NULL,'"PerformanceNum"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EQFCUEMPEXZ0','50','H','01','51',NULL,'PerfRangeNum',NULL,NULL,'"PerfRangeNum"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EQFCUEMPEXZ0','50','H','01','52',NULL,'LastReviewDate',NULL,NULL,'"LastReviewDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EQFCUEMPEXZ0','50','H','01','53',NULL,'NextReviewDate',NULL,NULL,'"NextReviewDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EQFCUEMPEXZ0','50','H','01','54',NULL,'TotalLTIValue',NULL,NULL,'"TotalLTIValue"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EQFCUEMPEXZ0','50','H','01','55',NULL,'Notes',NULL,NULL,'"Notes"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EQFCUEMPEXZ0','50','H','01','56',NULL,'IsActive',NULL,NULL,'"IsActive"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EQFCUEMPEXZ0','50','H','01','57',NULL,'LTIValuationType',NULL,NULL,'"LTIValuationType"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EQFCUEMPEXZ0','50','H','01','58',NULL,'OptionValue',NULL,NULL,'"OptionValue"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EQFCUEMPEXZ0','50','H','01','59',NULL,'RestStockValue',NULL,NULL,'"RestStockValue"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EQFCUEMPEXZ0','50','H','01','60',NULL,'PhantStockValue',NULL,NULL,'"PhantStockValue"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EQFCUEMPEXZ0','50','H','01','61',NULL,'SARValue',NULL,NULL,'"SARValue"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EQFCUEMPEXZ0','50','H','01','62',NULL,'PerfUnitValue',NULL,NULL,'"PerfUnitValue"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EQFCUEMPEXZ0','50','H','01','63',NULL,'PerfShareValue',NULL,NULL,'"PerfShareValue"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EQFCUEMPEXZ0','50','H','01','64',NULL,'LTCashValue',NULL,NULL,'"LTCashValue"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EQFCUEMPEXZ0','50','H','01','65',NULL,'OtherLTIValue',NULL,NULL,'"OtherLTIValue"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EQFCUEMPEXZ0','50','H','01','66',NULL,'TargetLTIValue',NULL,NULL,'"TargetLTIValue"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EQFCUEMPEXZ0','50','H','01','67',NULL,'LTIPercentBase',NULL,NULL,'"LTIPercentBase"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EQFCUEMPEXZ0','50','H','01','68',NULL,'MedicalEE',NULL,NULL,'"MedicalEE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EQFCUEMPEXZ0','50','H','01','69',NULL,'DentalEE',NULL,NULL,'"DentalEE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EQFCUEMPEXZ0','50','H','01','70',NULL,'VisionEE',NULL,NULL,'"VisionEE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EQFCUEMPEXZ0','50','H','01','71',NULL,'LifeEE',NULL,NULL,'"LifeEE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EQFCUEMPEXZ0','50','H','01','72',NULL,'ADDEE',NULL,NULL,'"ADDEE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EQFCUEMPEXZ0','50','H','01','73',NULL,'STDEE',NULL,NULL,'"STDEE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EQFCUEMPEXZ0','50','H','01','74',NULL,'LTDEE',NULL,NULL,'"LTDEE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EQFCUEMPEXZ0','50','H','01','75',NULL,'FourZeroOneKEE',NULL,NULL,'"FourZeroOneKEE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EQFCUEMPEXZ0','50','H','01','76',NULL,'FICATaxSocialEE',NULL,NULL,'"FICATaxSocialEE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EQFCUEMPEXZ0','50','H','01','77',NULL,'FICATaxMedicareEE',NULL,NULL,'"FICATaxMedicareEE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EQFCUEMPEXZ0','50','H','01','78',NULL,'MedicalER',NULL,NULL,'"MedicalER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EQFCUEMPEXZ0','50','H','01','79',NULL,'DentalER',NULL,NULL,'"DentalER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EQFCUEMPEXZ0','50','H','01','80',NULL,'VisionER',NULL,NULL,'"VisionER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EQFCUEMPEXZ0','50','H','01','81',NULL,'LifeER',NULL,NULL,'"LifeER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EQFCUEMPEXZ0','50','H','01','82',NULL,'ADDER',NULL,NULL,'"ADDER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EQFCUEMPEXZ0','50','H','01','83',NULL,'STDER',NULL,NULL,'"STDER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EQFCUEMPEXZ0','50','H','01','84',NULL,'LTDER',NULL,NULL,'"LTDER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EQFCUEMPEXZ0','50','H','01','85',NULL,'FourZeroOneKER',NULL,NULL,'"FourZeroOneKER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EQFCUEMPEXZ0','50','H','01','86',NULL,'TuitionReimbER',NULL,NULL,'"TuitionReimbER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EQFCUEMPEXZ0','50','H','01','87',NULL,'PhoneReimbER',NULL,NULL,'"PhoneReimbER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EQFCUEMPEXZ0','50','H','01','88',NULL,'FICATaxSocialER',NULL,NULL,'"FICATaxSocialER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EQFCUEMPEXZ0','50','H','01','89',NULL,'FICATaxMedicareER',NULL,NULL,'"FICATaxMedicareER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EQFCUEMPEXZ0','50','H','01','90',NULL,'OtherRewards',NULL,NULL,'"OtherRewards"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EQFCUEMPEXZ0','50','H','01','91',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EQFCUEMPEXZ0','50','H','01','92',NULL,'Race',NULL,NULL,'"Race"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EQFCUEMPEXZ0','50','H','01','93',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EQFCUEMPEXZ0','50','H','01','94',NULL,'YearsOfPriorRelatedExp',NULL,NULL,'"YearsOfPriorRelatedExp"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EQFCUEMPEXZ0','50','H','01','95',NULL,'EducationCode',NULL,NULL,'"EducationCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EQFCUEMPEXZ0','50','H','01','96',NULL,'IsRemoteWorker',NULL,NULL,'"IsRemoteWorker"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EQFCUEMPEXZ0','50','H','01','97',NULL,'IsUnion',NULL,NULL,'"IsUnion"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EQFCUEMPEXZ0','50','H','01','98',NULL,'CertificationsLicenses',NULL,NULL,'"CertificationsLicenses"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EQFCUEMPEXZ0','50','H','01','99',NULL,'Skills',NULL,NULL,'"Skills"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EQFCUEMPEXZ0','50','H','01','100',NULL,'PENotes',NULL,NULL,'"PENotes"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EQFCUEMPEXZ0','50','H','01','101',NULL,'IsExcludedByPEA',NULL,NULL,'"IsExcludedByPEA"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EQFCUEMPEXZ0','75','H','01','102',NULL,'Annualized Employer Sponsored Medical Dental',NULL,NULL,'"drvAnnEmplyrSponMedDenVisBen"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EQFCUEMPEXZ0','50','H','01','103',NULL,'Split Dollar',NULL,NULL,'"Split Dollar"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EQFCUEMPEXZ0','50','H','01','104',NULL,'Defered Comp',NULL,NULL,'"Defered Comp"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EQFCUEMPEXZ0','50','H','01','105',NULL,'HRA',NULL,NULL,'"HRA"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EQFCUEMPEXZ0','50','H','01','106',NULL,'DeffComPd',NULL,NULL,'"DeffComPd"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EQFCUEMPEXZ0','50','H','01','107',NULL,'Commission',NULL,NULL,'"Commission"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EQFCUEMPEXZ0','50','H','01','108',NULL,'TotalComp',NULL,NULL,'"TotalComp"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EQFCUEMPEXZ0','50','H','01','109',NULL,'Target Success Share',NULL,NULL,'"Target Success Share"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EQFCUEMPEXZ0','50','H','01','110',NULL,'Maximum 401k Match',NULL,NULL,'"Maximum 401k Match"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EQFCUEMPEXZ0','50','H','01','111',NULL,'Rank Score Name',NULL,NULL,'"Rank Score Name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EQFCUEMPEXZ0','50','H','01','112',NULL,'End',NULL,NULL,'"End"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EQFCUEMPEXZ0','50','D','10','1',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EQFCUEMPEXZ0','50','D','10','2',NULL,'EmployeeStateCode',NULL,NULL,'"drvEmployeeStateCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EQFCUEMPEXZ0','50','D','10','3',NULL,'EmployeeZipCode',NULL,NULL,'"drvEmployeeZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EQFCUEMPEXZ0','50','D','10','4',NULL,'EmployeeCountryCode',NULL,NULL,'"drvEmployeeCountryCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EQFCUEMPEXZ0','50','D','10','5',NULL,'CompanyJobCode',NULL,NULL,'"drvCompanyJobCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EQFCUEMPEXZ0','50','D','10','6',NULL,'TierCode',NULL,NULL,'"drvTierCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EQFCUEMPEXZ0','50','D','10','7',NULL,'StructureCode',NULL,NULL,'"drvStructureCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EQFCUEMPEXZ0','50','D','10','8',NULL,'SalaryPlanCode',NULL,NULL,'"drvSalaryPlanCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EQFCUEMPEXZ0','50','D','10','9',NULL,'BaseSalary',NULL,NULL,'"drvBaseSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EQFCUEMPEXZ0','50','D','10','10',NULL,'CurrencyCode',NULL,NULL,'"USD"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EQFCUEMPEXZ0','50','D','10','11',NULL,'IsSalaried',NULL,NULL,'"drvIsSalaried"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EQFCUEMPEXZ0','50','D','10','12',NULL,'EntityID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EQFCUEMPEXZ0','50','D','10','13',NULL,'IsExempt',NULL,NULL,'"drvIsExempt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EQFCUEMPEXZ0','50','D','10','14',NULL,'BonusTargetPercent',NULL,NULL,'"drvBonusTargetPercent"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EQFCUEMPEXZ0','50','D','10','15',NULL,'Bonus',NULL,NULL,'"drvBonus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EQFCUEMPEXZ0','50','D','10','16',NULL,'AnnualWorkHours',NULL,NULL,'"drvAnnualWorkHours"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EQFCUEMPEXZ0','50','D','10','17',NULL,'HireDate',NULL,NULL,'"drvHireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EQFCUEMPEXZ0','50','D','10','18',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EQFCUEMPEXZ0','50','D','10','19',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EQFCUEMPEXZ0','50','D','10','20',NULL,'BirthDate',NULL,NULL,'"drvBirthDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EQFCUEMPEXZ0','50','D','10','21',NULL,'GenderCode',NULL,NULL,'"drvGenderCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EQFCUEMPEXZ0','50','D','10','22',NULL,'EthnicityCode',NULL,NULL,'"drvEthnicityCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EQFCUEMPEXZ0','50','D','10','23',NULL,'EmployeeCity',NULL,NULL,'"drvEmployeeCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EQFCUEMPEXZ0','50','D','10','24',NULL,'DepartmentID',NULL,NULL,'"drvDepartmentID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EQFCUEMPEXZ0','50','D','10','25',NULL,'EmploymentStatusCode',NULL,NULL,'"drvEmploymentStatusCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EQFCUEMPEXZ0','50','D','10','26',NULL,'ReportToEmployeeID',NULL,NULL,'"drvReportToEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EQFCUEMPEXZ0','50','D','10','27',NULL,'SiteCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EQFCUEMPEXZ0','50','D','10','28',NULL,'TotalDirectCompensation',NULL,NULL,'"drvTotalDirectCompensation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EQFCUEMPEXZ0','50','D','10','29',NULL,'FixedPay',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EQFCUEMPEXZ0','50','D','10','30',NULL,'Allow',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EQFCUEMPEXZ0','50','D','10','31',NULL,'TGP',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EQFCUEMPEXZ0','50','D','10','32',NULL,'AVP',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EQFCUEMPEXZ0','50','D','10','33',NULL,'TVP',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EQFCUEMPEXZ0','50','D','10','34',NULL,'TEC',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EQFCUEMPEXZ0','50','D','10','35',NULL,'LTI1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EQFCUEMPEXZ0','50','D','10','36',NULL,'LTI2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EQFCUEMPEXZ0','50','D','10','37',NULL,'LTI3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EQFCUEMPEXZ0','50','D','10','38',NULL,'LTI4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EQFCUEMPEXZ0','50','D','10','39',NULL,'LTI5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EQFCUEMPEXZ0','50','D','10','40',NULL,'LTI6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EQFCUEMPEXZ0','50','D','10','41',NULL,'LTI7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EQFCUEMPEXZ0','50','D','10','42',NULL,'LTI8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EQFCUEMPEXZ0','50','D','10','43',NULL,'LTI9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EQFCUEMPEXZ0','50','D','10','44',NULL,'ShiftCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EQFCUEMPEXZ0','50','D','10','45',NULL,'IsOTEligible',NULL,NULL,'"drvIsOTEligible"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EQFCUEMPEXZ0','50','D','10','46',NULL,'DateStartedJob',NULL,NULL,'"drvDateStartedJob"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EQFCUEMPEXZ0','50','D','10','47',NULL,'TerminationDate',NULL,NULL,'"drvTerminationDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EQFCUEMPEXZ0','50','D','10','48',NULL,'SigningBonus',NULL,NULL,'"drvSigningBonus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EQFCUEMPEXZ0','50','D','10','49',NULL,'PerfRatingScaleCode',NULL,NULL,'"drvPerfRatingScaleCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EQFCUEMPEXZ0','50','D','10','50',NULL,'PerformanceNum',NULL,NULL,'"drvPerformanceNum"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EQFCUEMPEXZ0','50','D','10','51',NULL,'PerfRangeNum',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EQFCUEMPEXZ0','50','D','10','52',NULL,'LastReviewDate',NULL,NULL,'"drvLastReviewDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EQFCUEMPEXZ0','50','D','10','53',NULL,'NextReviewDate',NULL,NULL,'"drvNextReviewDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EQFCUEMPEXZ0','50','D','10','54',NULL,'TotalLTIValue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EQFCUEMPEXZ0','50','D','10','55',NULL,'Notes',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EQFCUEMPEXZ0','50','D','10','56',NULL,'IsActive',NULL,NULL,'"drvIsActive"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EQFCUEMPEXZ0','50','D','10','57',NULL,'LTIValuationType',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EQFCUEMPEXZ0','50','D','10','58',NULL,'OptionValue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EQFCUEMPEXZ0','50','D','10','59',NULL,'RestStockValue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EQFCUEMPEXZ0','50','D','10','60',NULL,'PhantStockValue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EQFCUEMPEXZ0','50','D','10','61',NULL,'SARValue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EQFCUEMPEXZ0','50','D','10','62',NULL,'PerfUnitValue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EQFCUEMPEXZ0','50','D','10','63',NULL,'PerfShareValue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EQFCUEMPEXZ0','50','D','10','64',NULL,'LTCashValue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EQFCUEMPEXZ0','50','D','10','65',NULL,'OtherLTIValue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EQFCUEMPEXZ0','50','D','10','66',NULL,'TargetLTIValue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EQFCUEMPEXZ0','50','D','10','67',NULL,'LTIPercentBase',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EQFCUEMPEXZ0','50','D','10','68',NULL,'MedicalEE',NULL,NULL,'"drvMedicalEE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EQFCUEMPEXZ0','50','D','10','69',NULL,'DentalEE',NULL,NULL,'"drvDentalEE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EQFCUEMPEXZ0','50','D','10','70',NULL,'VisionEE',NULL,NULL,'"drvVisionEE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EQFCUEMPEXZ0','50','D','10','71',NULL,'LifeEE',NULL,NULL,'"drvLifeEE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EQFCUEMPEXZ0','50','D','10','72',NULL,'ADDEE',NULL,NULL,'"drvADDEE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EQFCUEMPEXZ0','50','D','10','73',NULL,'STDEE',NULL,NULL,'"drvSTDEE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EQFCUEMPEXZ0','50','D','10','74',NULL,'LTDEE',NULL,NULL,'"drvLTDEE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EQFCUEMPEXZ0','50','D','10','75',NULL,'FourZeroOneKEE',NULL,NULL,'"drvFourZeroOneKEE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EQFCUEMPEXZ0','50','D','10','76',NULL,'FICATaxSocialEE',NULL,NULL,'"drvFICATaxSocialEE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EQFCUEMPEXZ0','50','D','10','77',NULL,'FICATaxMedicareEE',NULL,NULL,'"drvFICATaxMedicareEE"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EQFCUEMPEXZ0','50','D','10','78',NULL,'MedicalER',NULL,NULL,'"drvMedicalER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EQFCUEMPEXZ0','50','D','10','79',NULL,'DentalER',NULL,NULL,'"drvDentalER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EQFCUEMPEXZ0','50','D','10','80',NULL,'VisionER',NULL,NULL,'"drvVisionER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EQFCUEMPEXZ0','50','D','10','81',NULL,'LifeER',NULL,NULL,'"drvLifeER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EQFCUEMPEXZ0','50','D','10','82',NULL,'ADDER',NULL,NULL,'"drvADDER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EQFCUEMPEXZ0','50','D','10','83',NULL,'STDER',NULL,NULL,'"drvSTDER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EQFCUEMPEXZ0','50','D','10','84',NULL,'LTDER',NULL,NULL,'"drvLTDER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EQFCUEMPEXZ0','50','D','10','85',NULL,'FourZeroOneKER',NULL,NULL,'"drvFourZeroOneKER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EQFCUEMPEXZ0','50','D','10','86',NULL,'TuitionReimbER',NULL,NULL,'"drvTuitionReimbER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EQFCUEMPEXZ0','50','D','10','87',NULL,'PhoneReimbER',NULL,NULL,'"drvPhoneReimbER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EQFCUEMPEXZ0','50','D','10','88',NULL,'FICATaxSocialER',NULL,NULL,'"drvFICATaxSocialER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EQFCUEMPEXZ0','50','D','10','89',NULL,'FICATaxMedicareER',NULL,NULL,'"drvFICATaxMedicareER"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EQFCUEMPEXZ0','50','D','10','90',NULL,'OtherRewards',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EQFCUEMPEXZ0','50','D','10','91',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EQFCUEMPEXZ0','50','D','10','92',NULL,'Race',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EQFCUEMPEXZ0','50','D','10','93',NULL,'Location',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EQFCUEMPEXZ0','50','D','10','94',NULL,'YearsOfPriorRelatedExp',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EQFCUEMPEXZ0','50','D','10','95',NULL,'EducationCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EQFCUEMPEXZ0','50','D','10','96',NULL,'IsRemoteWorker',NULL,NULL,'"drvIsRemoteWorker"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EQFCUEMPEXZ0','50','D','10','97',NULL,'IsUnion',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EQFCUEMPEXZ0','50','D','10','98',NULL,'CertificationsLicenses',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EQFCUEMPEXZ0','50','D','10','99',NULL,'Skills',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EQFCUEMPEXZ0','50','D','10','100',NULL,'PENotes',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EQFCUEMPEXZ0','50','D','10','101',NULL,'IsExcludedByPEA',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EQFCUEMPEXZ0','50','D','10','102',NULL,'Annualized Employer Sponsored Medical Dental',NULL,NULL,'"drvAnnEmplyrSponMedDenVisBen"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EQFCUEMPEXZ0','50','D','10','103',NULL,'Split Dollar Compensation',NULL,NULL,'"drvSplitDollarCompensation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EQFCUEMPEXZ0','50','D','10','104',NULL,'Deferred Compensation',NULL,NULL,'"drvDeferredCompensation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EQFCUEMPEXZ0','50','D','10','105',NULL,'HRA Used YTD',NULL,NULL,'"drvHRAUsedYTD"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EQFCUEMPEXZ0','50','D','10','106',NULL,'401K Employer Match',NULL,NULL,'"drv401KEmployerMatch"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EQFCUEMPEXZ0','50','D','10','107',NULL,'Commission',NULL,NULL,'"drvCommission"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EQFCUEMPEXZ0','50','D','10','108',NULL,'Total Compensation and Benefits',NULL,NULL,'"drvTotalCompandBenefits"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EQFCUEMPEXZ0','50','D','10','109',NULL,'Target Success Share',NULL,NULL,'"drvTargetSuccessShare"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EQFCUEMPEXZ0','50','D','10','110',NULL,'Maximum 401k Match',NULL,NULL,'"drvMaximum401kMatch"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EQFCUEMPEXZ0','50','D','10','111',NULL,'Rank Score Name',NULL,NULL,'"drvRankScoreName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EQFCUEMPEXZ0','50','D','10','112',NULL,'End',NULL,NULL,'"x"','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EQFCUEMPEX_20230517.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Salary.com Employee File Expor','202212169','EMPEXPORT','ONDEM_XOE',NULL,'EQFCUEMPEX',NULL,NULL,NULL,'202212169','Nov 16 2022  1:46PM','Nov 16 2022  1:46PM','202212011',NULL,'','','202212011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',IAGFG',NULL,NULL,NULL,'Salary.com Employee File-Sched','202302079','EMPEXPORT','SCH_EQFCUE',NULL,'EQFCUEMPEX',NULL,NULL,NULL,'202305129','Nov 16 2022  1:46PM','Nov 16 2022  1:46PM','202304281',NULL,'','','202302071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','IAGFG',NULL,NULL,NULL,'Salary.com Employee File-Test','202305121','EMPEXPORT','TEST_XOE','May 12 2023 12:13PM','EQFCUEMPEX',NULL,NULL,NULL,'202305121','May 12 2023 12:00AM','May  5 2023 12:00AM','202304281','147','','','202304281',dbo.fn_GetTimedKey(),NULL,'us3cPeQUO1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQFCUEMPEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQFCUEMPEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQFCUEMPEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQFCUEMPEX','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQFCUEMPEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQFCUEMPEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EQFCUEMPEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQFCUEMPEX','H01','dbo.U_EQFCUEMPEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EQFCUEMPEX','D10','dbo.U_EQFCUEMPEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EQFCUEMPEX
-----------

IF OBJECT_ID('U_dsi_BDM_EQFCUEMPEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EQFCUEMPEX] (
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
-- Create table U_EQFCUEMPEX_Audit
-----------

IF OBJECT_ID('U_EQFCUEMPEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EQFCUEMPEX_Audit] (
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
-- Create table U_EQFCUEMPEX_AuditFields
-----------

IF OBJECT_ID('U_EQFCUEMPEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EQFCUEMPEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EQFCUEMPEX_DedList
-----------

IF OBJECT_ID('U_EQFCUEMPEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EQFCUEMPEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EQFCUEMPEX_drvTbl
-----------

IF OBJECT_ID('U_EQFCUEMPEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EQFCUEMPEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeStateCode] varchar(255) NULL,
    [drvEmployeeZipCode] varchar(50) NULL,
    [drvEmployeeCountryCode] char(3) NULL,
    [drvCompanyJobCode] char(8) NULL,
    [drvTierCode] varchar(10) NULL,
    [drvStructureCode] varchar(1) NOT NULL,
    [drvSalaryPlanCode] varchar(1) NOT NULL,
    [drvBaseSalary] nvarchar(4000) NULL,
    [drvIsSalaried] varchar(1) NULL,
    [drvIsExempt] varchar(1) NOT NULL,
    [drvBonusTargetPercent] varchar(8000) NULL,
    [drvBonus] nvarchar(4000) NULL,
    [drvAnnualWorkHours] nvarchar(4000) NULL,
    [drvHireDate] varchar(10) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvBirthDate] varchar(10) NULL,
    [drvGenderCode] varchar(1) NULL,
    [drvEthnicityCode] varchar(45) NULL,
    [drvEmployeeCity] varchar(255) NULL,
    [drvDepartmentID] varchar(25) NULL,
    [drvEmploymentStatusCode] varchar(4) NOT NULL,
    [drvReportToEmployeeID] varchar(256) NULL,
    [drvTotalDirectCompensation] nvarchar(4000) NULL,
    [drvIsOTEligible] varchar(1) NULL,
    [drvDateStartedJob] varchar(10) NULL,
    [drvTerminationDate] varchar(10) NULL,
    [drvSigningBonus] nvarchar(4000) NULL,
    [drvPerfRatingScaleCode] varchar(1) NOT NULL,
    [drvPerformanceNum] varchar(1) NOT NULL,
    [drvLastReviewDate] varchar(10) NULL,
    [drvNextReviewDate] varchar(10) NULL,
    [drvIsActive] varchar(1) NOT NULL,
    [drvMedicalEE] nvarchar(4000) NULL,
    [drvDentalEE] nvarchar(4000) NULL,
    [drvVisionEE] nvarchar(4000) NULL,
    [drvLifeEE] nvarchar(4000) NULL,
    [drvADDEE] nvarchar(4000) NULL,
    [drvSTDEE] nvarchar(4000) NULL,
    [drvLTDEE] nvarchar(4000) NULL,
    [drvFourZeroOneKEE] nvarchar(4000) NULL,
    [drvFICATaxSocialEE] nvarchar(4000) NULL,
    [drvFICATaxMedicareEE] nvarchar(4000) NULL,
    [drvMedicalER] nvarchar(4000) NULL,
    [drvDentalER] nvarchar(4000) NULL,
    [drvVisionER] nvarchar(4000) NULL,
    [drvLifeER] nvarchar(4000) NULL,
    [drvADDER] nvarchar(4000) NULL,
    [drvSTDER] nvarchar(4000) NULL,
    [drvLTDER] nvarchar(4000) NULL,
    [drvFourZeroOneKER] nvarchar(4000) NULL,
    [drvTuitionReimbER] nvarchar(4000) NULL,
    [drvPhoneReimbER] nvarchar(4000) NULL,
    [drvFICATaxSocialER] nvarchar(4000) NULL,
    [drvFICATaxMedicareER] nvarchar(4000) NULL,
    [drvEmail] varchar(50) NULL,
    [drvIsRemoteWorker] varchar(1) NOT NULL,
    [drvAnnEmplyrSponMedDenVisBen] nvarchar(4000) NULL,
    [drvSplitDollarCompensation] nvarchar(4000) NULL,
    [drvDeferredCompensation] nvarchar(4000) NULL,
    [drvHRAUsedYTD] nvarchar(4000) NULL,
    [drv401KEmployerMatch] nvarchar(4000) NULL,
    [drvCommission] nvarchar(4000) NULL,
    [drvTotalCompandBenefits] nvarchar(4000) NULL,
    [drvTargetSuccessShare] nvarchar(4000) NULL,
    [drvMaximum401kMatch] nvarchar(4000) NULL,
    [drvRankScoreName] varchar(8000) NULL
);

-----------
-- Create table U_EQFCUEMPEX_EEList
-----------

IF OBJECT_ID('U_EQFCUEMPEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EQFCUEMPEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EQFCUEMPEX_File
-----------

IF OBJECT_ID('U_EQFCUEMPEX_File') IS NULL
CREATE TABLE [dbo].[U_EQFCUEMPEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EQFCUEMPEX_Header
-----------

IF OBJECT_ID('U_EQFCUEMPEX_Header') IS NULL
CREATE TABLE [dbo].[U_EQFCUEMPEX_Header] (
    [drvAnnEmplyrSponMedDenVisBen] varchar(14) NOT NULL
);

-----------
-- Create table U_EQFCUEMPEX_PDedHist
-----------

IF OBJECT_ID('U_EQFCUEMPEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EQFCUEMPEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhERDED] numeric NULL,
    [PdhMEDAmt] numeric NULL,
    [PdhDENAmt] numeric NULL,
    [PdhVISAmt] numeric NULL,
    [PdhLIFEAmt] numeric NULL,
    [PdhADDAmt] numeric NULL,
    [PdhSTDAmt] numeric NULL,
    [PdhLTDAmt] numeric NULL,
    [Pdh401KAmt] numeric NULL,
    [Pdh401KLoan] numeric NULL,
    [PdhMEDERAmt] numeric NULL,
    [PdhDENERAmt] numeric NULL,
    [PdhVISERAmt] numeric NULL,
    [PdhLIFEERAmt] numeric NULL,
    [PdhADDERAmt] numeric NULL,
    [PdhSTDERAmt] numeric NULL,
    [PdhLTDERAmt] numeric NULL,
    [Pdh401KERAmt] numeric NULL,
    [PdhDeffComPd] numeric NULL,
    [Pdh401KEmpMatchRolling12] numeric NULL
);

-----------
-- Create table U_EQFCUEMPEX_PEarHist
-----------

IF OBJECT_ID('U_EQFCUEMPEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EQFCUEMPEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAMTX] numeric NULL,
    [PehBonus] numeric NULL,
    [PehBonso] numeric NULL,
    [PehTUTAmt] numeric NULL,
    [PehPHRAmt] numeric NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehCOMM] numeric NULL,
    [PehCommRolling12] numeric NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EQFCUEMPEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Quorum Federal Credit Union

Created By: Marie Waters
Business Analyst: Cheryl Petitti
Create Date: 11/16/2022
Service Request Number: TekP-2022-07-14-05

Purpose: Salary.com Employee File Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        04/14/2023      TekP-2022-07-14-05 New column 'Rank Score Name' added, coding changed for PerfRatingScaleCode and changed to send blanks for StructureCode, SalaryPlanCode and PerformanceNum 
Marie Waters        04/14/2023      TekP-2022-07-14-05 Updated logic for remote worker,  TotalDirectCompensation. LifeEE,AnnualizedERPD, DeffComPd, DeffComPd and TotalComp
Marie Waters        05/17/2023      TekP-2022-07-14-05 Updated the gender to send 'U' instead of '' and added PehBonus to totalcomp field
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EQFCUEMPEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EQFCUEMPEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EQFCUEMPEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EQFCUEMPEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EQFCUEMPEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQFCUEMPEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQFCUEMPEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EQFCUEMPEX', 'SCH_EQFCUE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EQFCUEMPEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EQFCUEMPEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EQFCUEMPEX';

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
    DELETE FROM dbo.U_EQFCUEMPEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EQFCUEMPEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EQFCUEMPEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EQFCUEMPEX_AuditFields;
    CREATE TABLE dbo.U_EQFCUEMPEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EQFCUEMPEX_AuditFields VALUES ('EmpComp','EecEmplStatus');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EQFCUEMPEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EQFCUEMPEX_Audit;
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
    INTO dbo.U_EQFCUEMPEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EQFCUEMPEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EQFCUEMPEX_Audit ON dbo.U_EQFCUEMPEX_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EQFCUEMPEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EQFCUEMPEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED,MED1,MED2,MED3,MED3,MEDK1,DEN,DENBK,DENG,DENK1,DENKG,DENL,VIS,GTL,LIFEE,LIFEC,LIFES,ADDCO,GLIFE,GTACC,ADDCH,ADDEE,ADDSP,STDER,STDNJ,STDNY,LTD,LTD2 ,401L,401CP,401KR,401M,,401P,401RC,457B,CELLR,TUITN,TUITT';

    IF OBJECT_ID('U_EQFCUEMPEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EQFCUEMPEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EQFCUEMPEX_DedList
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
    IF OBJECT_ID('U_EQFCUEMPEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EQFCUEMPEX_PDedHist;
    
 SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        --,PdhERDED       = SUM(CASE WHEN ltrim(rtrim(PdhDedType))IN ('MED','DEN','VIS') and PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhERDED       = SUM(CASE WHEN ltrim(rtrim(PdhDedType))IN ('MED','DEN','VIS')  THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhMEDAmt       = SUM(CASE WHEN ltrim(rtrim(PdhDedType)) IN ('MED') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhDENAmt       = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('DEN') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhVISAmt       = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('VIS') THEN PdhEECurAmt ELSE 0.00 END)        
        ,PdhLIFEAmt      = SUM(CASE WHEN PdhDedCode IN ( 'LIFEE', 'LIFEC', 'LIFES') THEN PdhEECurAmt ELSE 0.00 END)--'GTL',
        ,PdhADDAmt       = SUM(CASE WHEN PdhDedCode IN ('ADDCH', 'ADDEE', 'ADDSP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSTDAmt       = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('STD') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhLTDAmt       = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('LTD') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,Pdh401KAmt      = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('DEF')  THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,Pdh401KLoan     = SUM(CASE WHEN PdhDedCode IN ('401L') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhMEDERAmt     = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('MED') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhDENERAmt     = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('DEN') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhVISERAmt     = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('VIS') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhLIFEERAmt    = SUM(CASE WHEN PdhDedCode IN ('GLIFE', 'LIFEE', 'LIFEC', 'LIFES') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhADDERAmt     = SUM(CASE WHEN PdhDedCode IN ('ADDCH', 'ADDEE', 'ADDSP', 'ADDCO') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhSTDERAmt     = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('STD') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PdhLTDERAmt     = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('LTD') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,Pdh401KERAmt    = SUM(CASE WHEN Ltrim(rtrim(PdhDedType)) IN ('DEF') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PdhDeffComPd    = SUM(CASE WHEN PdhDedType IN ('DEF')  THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        --,PdhTUTAmt     = SUM(CASE WHEN PdhDedCode IN ('TUITN', 'TUITT') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        --,PdhPHRAmt     = SUM(CASE WHEN PdhDedCode IN ('CELLR') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,Pdh401KEmpMatchRolling12  = SUM(CASE WHEN PdhDedType IN ('DEF') AND left(PdhPerControl,8) >= DATEADD(DAY, -365, Left(@StartPerControl, 8)) THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EQFCUEMPEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EQFCUEMPEX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    --and pdheeid ='9U6ZT20000K0'
   -- AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


      -----------------------------
    -- Working Table - YTD FICA Withholdings
    -----------------------------
    IF OBJECT_ID('U_EEQFCUEMPEX_PTaxHist','U') IS NOT NULL
        DROP TABLE dbo.U_EEQFCUEMPEX_PTaxHist;
    SELECT DISTINCT
         PthEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- YTD Payroll Amount/Hours
        ,PthFICAEE =SUM(CASE WHEN PthTaxCode IN ('USSOCEE') THEN PthCurTaxAmt ELSE 0.00 END)
        ,PthFICAER =SUM(CASE WHEN PthTaxCode IN ('USSOCER') THEN PthCurTaxAmt ELSE 0.00 END)
        ,PthMEDTaxEE =SUM(CASE WHEN PthTaxCode IN ('USMEDEE') THEN PthCurTaxAmt ELSE 0.00 END)
        ,PthMEDTaxER =SUM(CASE WHEN PthTaxCode IN ('USMEDER') THEN PthCurTaxAmt ELSE 0.00 END)
    INTO dbo.U_EEQFCUEMPEX_PTaxHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PthGenNumber = PrgGenNumber
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl
    AND PthTaxCode IN ('USSOCEE','USMEDEE', 'USSOCER','USMEDER')
    GROUP BY PthEEID
    HAVING SUM(PthCurTaxAmt) <> 0.00;

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EQFCUEMPEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EQFCUEMPEX_PEarHist;
     SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAMTX             = SUM(CASE WHEN PehEarnCode NOT In ('BONUS', 'SPLIT') THEN PehCurAmt ELSE 0.00 END)--addd 'BONUS'
        ,PehBonus               = SUM(CASE WHEN PehEarnCode = 'Bonus' THEN PehCurAmt ELSE 0.00 END)
        ,PehBonso               = SUM(CASE WHEN PehEarnCode = 'Bonso' THEN PehCurAmt ELSE 0.00 END)
        ,PehTUTAmt                = SUM(CASE WHEN PehEarncode IN ('TUITN', 'TUITT') THEN ISNULL(PehCurAmt, 0) ELSE 0.00 END)
        ,PehPHRAmt                = SUM(CASE WHEN PehEarncode IN ('CELLR') THEN ISNULL(PehCurAmt, 0) ELSE 0.00 END)
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PehCOMM                = SUM(CASE WHEN  PehEarnCode in ('COMM') THEN PehCurAmt ELSE 0.00 END)
        ,PehCommRolling12       = SUM(CASE WHEN  PehEarnCode in ('COMM') and left(PehPerControl,8) >= DATEADD(DAY, -365, Left(@StartPerControl, 8)) THEN PehCurAmt ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EQFCUEMPEX_PEarHist
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
    -- DETAIL RECORD - U_EQFCUEMPEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EQFCUEMPEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EQFCUEMPEX_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeStateCode = LocAddressState
        ,drvEmployeeZipCode = LocAddressZipCode
        ,drvEmployeeCountryCode = LocAddressCountry
        ,drvCompanyJobCode = EecJobCode
        ,drvTierCode = EecOrgLvl3
        ,drvStructureCode = '' -- CASE WHEN JbcFLSAType = 'N' THEN 'NE' ELSE JbcFLSAType END -- MW Updated 3/24/2023 --4/14/2023 Client requested to send blank
        ,drvSalaryPlanCode = ''-- SlgDesc --EjhSalaryGrade  -- MW Updated 3/24/2023 --4/14/2023 Client requested to send blank
        ,drvBaseSalary = CASE WHEN EecSalaryOrHourly = 'S' THEN Format(eecannsalary, '0.00') else Format(EecHourlyPayRate, '0.00') END
        ,drvIsSalaried = CASE WHEN EecSalaryOrHourly = 'S' THEN '1' WHEN EecSalaryOrHourly = 'H' THEN '0' END
        ,drvIsExempt =  CASE WHEN EecOrgLvl2 = 'SAL' THEN  '1' ELSE '0' END
        ,drvBonusTargetPercent = OrgDesc14
        ,drvBonus = CASE WHEN FORMAT(PehBonus, '0.00') > '0.00' THEN FORMAT(PehBonus, '0.00') ELSE '0.00' END
        ,drvAnnualWorkHours = CASE WHEN FORMAT(EecScheduledWorkHrs * 26, '0.00') > '0.00' THEn FORMAT(EecScheduledWorkHrs * 26, '0.00') ELSE '0.00' END
        ,drvHireDate = CONVERT(VARCHAR(10),EecDateOfLastHire,101)
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvBirthDate = CONVERT(VARCHAR(10),EepDateOfBirth,101)
        ,drvGenderCode = CASE WHEN EepGender IN ( 'M', 'F') THEN EepGender ELSE 'U' END -- 5/17/23 MW added the 'U' instead of ''
        ,drvEthnicityCode = CodDesc
        ,drvEmployeeCity = LocAddressCity
        ,drvDepartmentID = OrgDesc1
        ,drvEmploymentStatusCode = CASE WHEn EecFullTimeOrPartTime = 'F' THEN 'ES01' Else 'ES02' END
        ,drvReportToEmployeeID = sup.SupervisorID   
        ,drvTotalDirectCompensation = CASE WHEN FORMAT(PehCurAMTX,'0.00') > '0.00' THEN FORMAT(PehCurAMTX,'0.00') ELSE '0.00' END
        ,drvIsOTEligible = CASE WHEN EecSalaryOrHourly = 'S' THEN '0' WHEN  EecSalaryOrHourly = 'H' THEN '1' END
        ,drvDateStartedJob = CONVERT(VARCHAR(10),EecDateInJob,101)
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN CONVERT(VARCHAR(10),EecDateOfTermination,101) END
        ,drvSigningBonus = CASE WHEN FORMAT(PehBonso, '0.00') > '0.00' THEN FORMAT(PehBonso, '0.00') ELSE '0.00' END
        ,drvPerfRatingScaleCode = ''--CASE WHEN Replace(RatingCodeDesc, '(%)', '') is not null then 'Performance Review' END --4/14/2023 Client requested to send 'Performance Review' when Replace(RatingCodeDesc, '(%)', '') is not null -- 4/18/2023 send blanks
        ,drvPerformanceNum = ''-- ManGoalRatingCode --4/14/2023 Client requested to send blank
        ,drvLastReviewDate = CONVERT(VARCHAR(10),EecDateOfLastPerfReview,101)
        ,drvNextReviewDate = CONVERT(VARCHAR(10),EecDateOfNextPerfReview,101)
        ,drvIsActive = CASE WHEN EecEmplStatus IN ( 'A', 'L') THEN '1'  ELSE '0' END
        ,drvMedicalEE = CASE WHEN FORMAT(PdhMedAmt, '0.00') > '0.00' THEN FORMAT(PdhMedAmt, '0.00') ELSE '0.00' END
        ,drvDentalEE = CASE WHEN FORMAT(PdhDENAmt, '0.00') > '0.00' THEN FORMAT(PdhDENAmt, '0.00') ELSE '0.00' END
        ,drvVisionEE = CASE WHEN FORMAT(PdhVISAmt, '0.00') > '0.00' THEN FORMAT(PdhVISAmt, '0.00') ELSE '0.00' END
        ,drvLifeEE = CASE WHEN FORMAT(PdhLIFEAmt, '0.00') > '0.00' THEN FORMAT(PdhLIFEAmt, '0.00') ELSE '0.00' END
        ,drvADDEE = CASE WHEN FORMAT(PdhADDAmt, '0.00') > '0.00' THEN FORMAT(PdhADDAmt, '0.00') ELSE '0.00' END
        ,drvSTDEE = CASE WHEN FORMAT(PdhSTDAmt, '0.00') > '0.00' THEN  FORMAT(PdhSTDAmt, '0.00') ELSE '0.00' END
        ,drvLTDEE = CASE WHEN FORMAT(PdhLTDAmt, '0.00') > '0.00' THEN FORMAT(PdhLTDAmt, '0.00') ELSE '0.00' END
        ,drvFourZeroOneKEE = CASE WHEN FORMAT(Pdh401KLoan +Pdh401KAmt , '0.00') > '0.00' THEN FORMAT(Pdh401KLoan +Pdh401KAmt , '0.00') ELSE '0.00' END
        ,drvFICATaxSocialEE = CASE WHEN FORMAT(PthFICAEE, '0.00') > '0.00' THEN FORMAT(PthFICAEE, '0.00') ELSE '0.00' END
        ,drvFICATaxMedicareEE = CASE WHEN FORMAT(PthMEDTaxEE, '0.00') > '0.00' THEn FORMAT(PthMEDTaxEE, '0.00') ELSE '0.00' END
        ,drvMedicalER = CASE WHEN FORMAT(PdhMedERAmt, '0.00') > '0.00' THEN FORMAT(PdhMedERAmt, '0.00') ELSE '0.00' END
        ,drvDentalER = CASE WHEN FORMAT(PdhDENERAmt, '0.00') > '0.00' THEN FORMAT(PdhDENERAmt, '0.00') ELSE '0.00' END
        ,drvVisionER = CASE WHEN FORMAT(PdhVISERAmt, '0.00') > '0.00' THEN FORMAT(PdhVISERAmt, '0.00') ELSE '0.00' END
        ,drvLifeER = CASE WHEN FORMAT(PdhLIFEERAmt, '0.00') > '0.00' THEN FORMAT(PdhLIFEERAmt, '0.00') ELSE '0.00' END
        ,drvADDER = CASE WHEN FORMAT(PdhADDERAmt, '0.00') > '0.00' THEN FORMAT(PdhADDERAmt, '0.00') ELSE '0.00' END
        ,drvSTDER = CASE WHEN FORMAT(PdhSTDERAmt, '0.00') > '0.00' THEN FORMAT(PdhSTDERAmt, '0.00') ELSE '0.00' END
        ,drvLTDER = CASE WHEN FORMAT(PdhLTDERAmt, '0.00') > '0.00' THEN FORMAT(PdhLTDERAmt, '0.00') ELSE '0.00' END
        
        ,drvFourZeroOneKER = CASE WHEN FORMAT(Pdh401KERAmt , '0.00') > '0.00' THEN FORMAT(Pdh401KERAmt, '0.00') ELSE '0.00' END
        ,drvTuitionReimbER = CASE WHEN FORMAT(PehTUTAmt , '0.00') > '0.00' THEN FORMAT(PehTUTAmt , '0.00') ELSE '0.00' END
        ,drvPhoneReimbER = CASE WHEN FORMAT(PehPHRAmt, '0.00') > '0.00' THEN FORMAT(PehPHRAmt , '0.00') ELSE '0.00' END
        ,drvFICATaxSocialER = CASE WHEN FORMAT(PthFICAER, '0.00') > '0.00' THEN FORMAT(PthFICAER, '0.00') ELSE '0.00' END
        ,drvFICATaxMedicareER = CASE WHEn FORMAT(PthMEDTaxER, '0.00') > '0.00' THEN FORMAT(PthMEDTaxER, '0.00') ELSE '0.00' END
        ,drvEmail = EepAddressEMail
        ,drvIsRemoteWorker = CASE WHEN RemoteWork IS not null THEN '1' ELSE '0' END
        ,drvAnnEmplyrSponMedDenVisBen = CASE WHEN FORMAT(((PdhERDED )),'0.00') > '0.00' THEN FORMAT(((PdhERDED)),'0.00') ELSE '0.00' END --(PdhERDED * 26 )
        ,drvSplitDollarCompensation = CASE WHEN FORMAT(EECUDFIELD19, '0.00') > '0.00' THEN FORMAT(EECUDFIELD19, '0.00')  ELSE '0.00' END
        ,drvDeferredCompensation = CASE WHEN FORMAT(EECUDFIELD10 , '0.00') > '0.00' THEN FORMAT(EECUDFIELD10 , '0.00')  ELSE '0.00' END 
        ,drvHRAUsedYTD = CASE WHEN FORMAT(EECUDFIELD20, '0.00') > '0.00' THEN FORMAT(EECUDFIELD20, '0.00')  ELSE '0.00' END
        ,drv401KEmployerMatch = CASE WHEN FORMAT(Pdh401KEmpMatchRolling12,'0.00') > '0.00' THEN FORMAT(Pdh401KEmpMatchRolling12,'0.00')  ELSE '0.00' END
        ,drvCommission = CASE WHEN FORMAT(PehCommRolling12 ,'0.00') > '0.00' THEN FORMAT(PehCommRolling12 ,'0.00')  ELSE '0.00' END
        ,drvTotalCompandBenefits = CASE WHEN FORMAT( (isnull(PehBonus, 0.00))+(isnull(PehCurAMTX, 0.00))+(isnull(PdhERDED, 0.00)) + ( (isnull(EECUDFIELD19, 0.00) + isnull(EECUDFIELD10,0.00)   + isnull(EECUDFIELD20,0.00) + isnull(Pdh401KEmpMatchRolling12, 0.00) +  isnull(PehCommRolling12, 0.00) ) ), '0.00')> '0.00' THEN --5/17/23 MW added (isnull(PehBonus, 0.00)) --+EecAnnSalary--(PdhERDED * 26 )
                                            FORMAT( (isnull(PehBonus, 0.00))+(isnull(PehCurAMTX, 0.00))+(isnull(PdhERDED, 0.00)) + ( (isnull(EECUDFIELD19, 0.00) + isnull(EECUDFIELD10,0.00)   + isnull(EECUDFIELD20,0.00) + isnull(Pdh401KEmpMatchRolling12, 0.00) +  isnull(PehCommRolling12, 0.00) ) ), '0.00') --5/17/23 MW added (isnull(PehBonus, 0.00))--+EecAnnSalary--(PdhERDED * 26 )
                                        ELSE '0.00' 
                                    END
        ,drvTargetSuccessShare = CASE WHEN FORMAT(EecAnnSalary * OrgDesc14 ,'0.00') >'0.00' THEn FORMAT(EecAnnSalary * OrgDesc14 ,'0.00') ELSE '0.00' END
    
        ,drvMaximum401kMatch = CASE WHEN ((PehBonus + EecAnnSalary) * .06)  > 18300.00 THEN '18300.00' ELSE FORMAT(((PehBonus + EecAnnSalary) * .06),'0.00') END -- 4/14/2023 Client requested new column
        ,drvRankScoreName = Replace(RatingCodeDesc, '(%)', '')
    INTO dbo.U_EQFCUEMPEX_drvTbl
    FROM dbo.U_EQFCUEMPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIn dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
   LEFT JOIN dbo.U_dsi_BDM_EQFCUEMPEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
   JOIN dbo.Codes WITH (NOLOCK)
            ON codcode = eepEthnicID
            AND CodTable = 'ETHNICCODE'
   LEFT JOIN (SELECT DISTINCT OrgCode,OrgDesc as OrgDesc1
          FROM dbo.OrgLevel WITH (NOLOCK)
          Where OrgLvl = '1'
          GROUP BY OrgCode,OrgDesc)OL1
          ON OL1.OrgCode = EecOrgLvl1
    LEFT JOIN (SELECT DISTINCT OrgCode,OrgDesc as OrgDesc12
          FROM dbo.OrgLevel WITH (NOLOCK)
          Where OrgLvl = '2'
          GROUP BY OrgCode,OrgDesc)OL2
          ON OL2.OrgCode = EecOrgLvl2
    LEFT JOIN (SELECT DISTINCT OrgCode, OrgDesc as OrgDesc13
          FROM dbo.OrgLevel WITH (NOLOCK)
          Where OrgLvl = '3'
          GROUP BY OrgCode,OrgDesc )OL3
        ON EecOrgLvl3 = OL3.OrgCode
   LEFT JOIN (SELECT DISTINCT Ltrim(rTrim(OrgCode)) as OrgCode14  
          ,CASE WHEN Len(Replace( OrgDesc, 'SS','.')) > 2 THEN Replace( OrgDesc, 'SS','.') ELSE Replace( OrgDesc, 'SS','.0') 
             END AS OrgDesc14
          FROM dbo.OrgLevel WITH (NOLOCK)
          Where OrgLvl = '4'
          GROUP BY OrgCode,OrgDesc)OL4
          ON OL4.OrgCode14 = EecOrgLvl4
     LEFT JOIN (    SELECT     
                 EecEEID     
                ,SupervisorID = dbo.dsi_fnlib_GetSupervisorField('',EecEEID , 'Empno') 
                ,SupervisorName = dbo.dsi_fnlib_GetSupervisorField('',EecEEID , 'NameLast, First')     
                FROM dbo.EmpComp WITH (NOLOCK)
                
                ) SUP
                on sup.EecEEID  = Xeeid
     
    LEFT JOIN (
            SELECT EjhEEID, EjhSalaryGrade
            FROM (
                SELECT EjhEEID, EjhSalaryGrade, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID ORDER BY EjhJobEffDate DESC) AS RN
                FROM EmpHJob  WITH (NOLOCK)) AS SG
            WHERE RN = 1
        ) AS SalGrades
        ON EjhEEID = xEEID
  LEFT JOIN dbo.SalGrade  WITH (NOLOCK)  -- MW Updated 3/24/2023
        ON slgsalgrade = EjhSalaryGrade
   LEFT  JOIN (Select Eeid, CoId, Jobcode, RatingCode, RatingCodeDesc, Score, format(Score, '0.00') AS ManGoalRatingCode , ROW_NUMBER() OVER(PARTITION BY EEID ORDER BY CreateDate DESC) RowNumber from EmpReview 
            Where RatingCodeDesc is not null)r
        ON r.EEID  = xEEID
        and  r.rownumber = 1
     LEFT JOIN dbo.U_EEQFCUEMPEX_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    LEFT JOIN dbo.U_EQFCUEMPEX_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_EQFCUEMPEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    Left JOIN (Select EttEEID, EttTestCode, CodDesc As RemoteWork
                     FROM EmpTest WITH (NOLOCK)
                    JOIN dbo.U_EQFCUEMPEX_EEList
                    ON EttEEID = XEEID
                    JOIN codes WITH (NOLOCK)
                    ON  EttTestCode = CodCode
                    where codtable = 'TESTS'  
                    --And CodDesc Like '%Remote%'
                    And CodDesc = 'Permanently Remote'
         ) CAR
        ON EttEEID = XEEID
    LEFT JOIn dbo.U_EQFCUEMPEX_Audit WITH (NOLOCK)
        ON audEEID = XEEID
        AND audCOID = XCOID
   WHERE EecEEType IN ('REG') 
    AND (EecEmplStatus IN ('A', 'L') OR EecEmplStatus = 'T' and audDateTime between @StartDate  AND @EndDate  )
    ;



     ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EQFCUEMPEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EQFCUEMPEX_Header;
    SELECT DISTINCT
         drvAnnEmplyrSponMedDenVisBen = 'AnnualizedERPD'
   
    INTO dbo.U_EQFCUEMPEX_Header
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
ALTER VIEW dbo.dsi_vwEQFCUEMPEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EQFCUEMPEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EQFCUEMPEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202212011'
       ,expStartPerControl     = '202212011'
       ,expLastEndPerControl   = '202212169'
       ,expEndPerControl       = '202212169'
WHERE expFormatCode = 'EQFCUEMPEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEQFCUEMPEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EQFCUEMPEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EQFCUEMPEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EQFCUEMPEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EQFCUEMPEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQFCUEMPEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EQFCUEMPEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EQFCUEMPEX', 'UseFileName', 'V', 'Y'


-- End ripout