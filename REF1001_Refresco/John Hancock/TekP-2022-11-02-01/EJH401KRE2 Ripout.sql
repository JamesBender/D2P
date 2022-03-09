/**********************************************************************************

EJH401KRE2: John Hancock 401K TEST

FormatCode:     EJH401KRE2
Project:        John Hancock 401K TEST
Client ID:      REF1001
Date/time:      2022-03-07 19:43:53.780
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_RBUS
ExportPath:    \\us.saas\E4\Public\REF1001\Exports\JohnHancock\
TestPath:      \\us.saas\E4\Public\REF1001\Exports\JohnHancock\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EJH401KRE2_SavePath') IS NOT NULL DROP TABLE dbo.U_EJH401KRE2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EJH401KRE2'


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
WHERE FormatCode = 'EJH401KRE2'
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
WHERE ExpFormatCode = 'EJH401KRE2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EJH401KRE2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EJH401KRE2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EJH401KRE2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EJH401KRE2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EJH401KRE2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EJH401KRE2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EJH401KRE2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EJH401KRE2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EJH401KRE2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EJH401KRE2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEJH401KRE2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEJH401KRE2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EJH401KRE2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EJH401KRE2];
GO
IF OBJECT_ID('U_EJH401KRE2_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_PTaxHist];
GO
IF OBJECT_ID('U_EJH401KRE2_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_PEarHist];
GO
IF OBJECT_ID('U_EJH401KRE2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_PDedHist];
GO
IF OBJECT_ID('U_EJH401KRE2_File') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_File];
GO
IF OBJECT_ID('U_EJH401KRE2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_EEList];
GO
IF OBJECT_ID('U_EJH401KRE2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_drvTbl];
GO
IF OBJECT_ID('U_EJH401KRE2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_DedList];
GO
IF OBJECT_ID('U_EJH401KRE2_CompYTD') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_CompYTD];
GO
IF OBJECT_ID('U_EJH401KRE2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_AuditFields];
GO
IF OBJECT_ID('U_EJH401KRE2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EJH401KRE2_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EJH401KRE2','John Hancock 401K TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','E6KIFR000020','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E6KIFR000020','6','D','10','1',NULL,'Plan Alias',NULL,NULL,'"drvPlanNum"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E6KIFR000020','30','D','10','2',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E6KIFR000020','9','D','10','3',NULL,'Social Security #',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E6KIFR000020','50','D','10','4',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E6KIFR000020','30','D','10','5',NULL,'Address #1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E6KIFR000020','30','D','10','6',NULL,'Address #2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E6KIFR000020','30','D','10','7',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E6KIFR000020','2','D','10','8',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E6KIFR000020','30','D','10','9',NULL,'Province',NULL,NULL,'"drvAddressProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E6KIFR000020','30','D','10','10',NULL,'Country',NULL,NULL,'"drvAddressCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E6KIFR000020','15','D','10','11',NULL,'Zip Code',NULL,NULL,'"drvAddressZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E6KIFR000020','8','D','10','12',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E6KIFR000020','8','D','10','13',NULL,'Original Date of Hire',NULL,NULL,'"drvDateOfOriginalHire"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E6KIFR000020','8','D','10','14',NULL,'Date of Termination',NULL,NULL,'"drvDateOfTermination"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E6KIFR000020','8','D','10','15',NULL,'Date of Rehire',NULL,NULL,'"drvDateOfLastHire"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E6KIFR000020','1','D','10','16',NULL,'Excludable Code',NULL,NULL,'"drvExcludCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E6KIFR000020','1','D','10','17',NULL,'Hourly/Salary Code',NULL,NULL,'"drvHourlySalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E6KIFR000020','4','D','10','18',NULL,'Status',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E6KIFR000020','1','D','10','19',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E6KIFR000020','6','D','10','20',NULL,'Payroll frequency',NULL,NULL,'"drvPayrollFreq"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E6KIFR000020','1','D','10','21',NULL,'Language',NULL,NULL,'"drvLanguage"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E6KIFR000020','30','D','10','22',NULL,'Employees Corporate Email Address',NULL,NULL,'"drvWorkEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E6KIFR000020','10','D','10','23',NULL,'Emplouees Corporate Phone Number',NULL,NULL,'"drvWorkPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','E6KIFR000020','16','D','10','24',NULL,'Total plan YTD gross compensation',NULL,NULL,'"drvTotPlanYTDGrossComp"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','E6KIFR000020','16','D','10','25',NULL,'Total PTD gross compensation',NULL,NULL,'"drvPTDGrossComp"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','E6KIFR000020','16','D','10','26',NULL,'Total plan YTD plan compensation',NULL,NULL,'"drvTotPlanYTDPlanComp"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','E6KIFR000020','16','D','10','27',NULL,'Total PTD plan compensation',NULL,NULL,'"drvTotPTDPlanComp"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','E6KIFR000020','16','D','10','28',NULL,'Total Managed Account Annualized comp',NULL,NULL,'"drvTotMngedAcctAnnualComp"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','E6KIFR000020','16','D','10','29',NULL,'Total PTD 401(k) contributions',NULL,NULL,'"drvTotPTD401KContrib"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','E6KIFR000020','16','D','10','30',NULL,'Total PTD match contributions',NULL,NULL,'"drvTotPTDMatchContrib"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','E6KIFR000020','16','D','10','31',NULL,'Total PTD profit sharing contributions',NULL,NULL,'"drvTotPTDProfShrContrib"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','E6KIFR000020','16','D','10','32',NULL,'Total PTD catch-up contributions',NULL,NULL,'"drvTotPTDCatchUpContrib"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','E6KIFR000020','16','D','10','33',NULL,'Total PTD Roth 401(k) contributions',NULL,NULL,'"drvTotPTDRothContrib"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','E6KIFR000020','16','D','10','34',NULL,'Total PTD Roth catch up contributions',NULL,NULL,'"drvTotPTDRothCUContrib"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','E6KIFR000020','16','D','10','35',NULL,'Total PTD loan repayments sum',NULL,NULL,'"drvTotPTDLoanRepaySum"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','E6KIFR000020','8','D','10','36',NULL,'Hours, YTD',NULL,NULL,'"drvYTDHours"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','E6KIFR000020','1','D','10','37',NULL,'Deferral %, Pre-tax',NULL,NULL,'"drvDefPretax"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','E6KIFR000020','8','D','10','38',NULL,'Deferral %, Pre-tax, Addl',NULL,NULL,'"drvDefPretaxAddl"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','E6KIFR000020','30','D','10','39',NULL,'Deferral %, Roth',NULL,NULL,'"drvDefRoth"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','E6KIFR000020','8','D','10','40',NULL,'Deferral %, Roth Catchup',NULL,NULL,'"drvDefRothCU"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','E6KIFR000020','10','D','10','41',NULL,'Employer Base Match',NULL,NULL,'"drvEmployerBaseMatch"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','E6KIFR000020','16','D','10','42',NULL,'Eligible Plan Compensation YTD',NULL,NULL,'"drvTotPlanYTDProfitShrComp"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','E6KIFR000020','1','D','10','43',NULL,'Union Code',NULL,NULL,'"drvUnionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','E6KIFR000020','16','D','10','44',NULL,'Total YTD match compensation',NULL,NULL,'"drvTotYTDMatchComp"','(''UNT2''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','E6KIFR000020','16','D','10','45',NULL,'Year tp date pensionable hours',NULL,NULL,'"drvYTDPensionableHrs"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','E6KIFR000020','16','D','10','46',NULL,'Total YTD match compensation',NULL,NULL,'"drvParollPeriodEndDate"','(''UDMDY''=''T,'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'John Hancock 401K Export','202110079','EMPEXPORT','ONDEMAND','Feb 28 2019 12:51PM','EJH401KRE2',NULL,NULL,NULL,'202110079','Feb 28 2019 12:00AM','Mar  2 2019 12:00AM','202108121','3125',NULL,NULL,'202108121',dbo.fn_GetTimedKey(),NULL,'ULTI_RBUS',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is  Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Export','202203031','EMPEXPORT','SCHEDULED','Mar  3 2022  6:15AM','EJH401KRE2',NULL,NULL,NULL,'202203031','Oct  8 2018 12:00AM','Dec 30 1899 12:00AM','202202242','6123',NULL,NULL,'202202242',dbo.fn_GetTimedKey(),NULL,'ULTI_RBUS',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\E4\Public\REF1001\Exports\JohnHancock\EJH401KRE2_TEST_20220305.txt',NULL,NULL,NULL,'DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'For Testing JH 401K','202201131','EMPEXPORT','TEST','Mar  4 2022  4:42PM','EJH401KRE2',NULL,NULL,NULL,'202201131','Jan 13 2022 12:00AM','Jan 15 2022 12:00AM','202201072','3984',NULL,NULL,'202201072',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','ExportPath','V','\\us.saas\E4\Public\REF1001\Exports\JohnHancock\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','TestPath','V','\\us.saas\E4\Public\REF1001\Exports\JohnHancock\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','UDESPath','V','\\us.saas\E0\data_exchange\REF1001\Exports\UDES\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EJH401KRE2','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EJH401KRE2','D10','dbo.U_EJH401KRE2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EJH401KRE2_Audit
-----------

IF OBJECT_ID('U_EJH401KRE2_Audit') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_Audit] (
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
-- Create table U_EJH401KRE2_AuditFields
-----------

IF OBJECT_ID('U_EJH401KRE2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EJH401KRE2_CompYTD
-----------

IF OBJECT_ID('U_EJH401KRE2_CompYTD') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_CompYTD] (
    [YTDEeID] char(12) NOT NULL,
    [YTDCurInclInDefCompAmt] numeric NULL
);

-----------
-- Create table U_EJH401KRE2_DedList
-----------

IF OBJECT_ID('U_EJH401KRE2_DedList') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EJH401KRE2_drvTbl
-----------

IF OBJECT_ID('U_EJH401KRE2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvPlanNum] varchar(6) NOT NULL,
    [drvDivision] varchar(3) NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(203) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressProvince] varchar(1) NOT NULL,
    [drvAddressCountry] varchar(1) NOT NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvExcludCode] varchar(1) NOT NULL,
    [drvHourlySalary] char(1) NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvPayrollFreq] char(1) NULL,
    [drvLanguage] varchar(1) NOT NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvTotPlanYTDGrossComp] money NOT NULL,
    [drvPTDGrossComp] numeric NOT NULL,
    [drvTotPlanYTDPlanComp] numeric NOT NULL,
    [drvTotPTDPlanComp] numeric NOT NULL,
    [drvTotMngedAcctAnnualComp] money NULL,
    [drvTotPTD401KContrib] numeric NOT NULL,
    [drvTotPTDMatchContrib] numeric NOT NULL,
    [drvTotPTDProfShrContrib] numeric NOT NULL,
    [drvTotPTDCatchUpContrib] numeric NOT NULL,
    [drvTotPTDRothContrib] numeric NOT NULL,
    [drvTotPTDRothCUContrib] numeric NOT NULL,
    [drvTotPTDLoanRepaySum] numeric NOT NULL,
    [drvYTDHours] decimal NOT NULL,
    [drvDefPretax] varchar(1) NOT NULL,
    [drvDefPretaxAddl] varchar(1) NOT NULL,
    [drvDefRoth] varchar(1) NOT NULL,
    [drvDefRothCU] varchar(1) NOT NULL,
    [drvEmployerBaseMatch] varchar(1) NOT NULL,
    [drvTotPlanYTDProfitShrComp] numeric NOT NULL,
    [drvUnionCode] varchar(1) NOT NULL,
    [drvTotYTDMatchComp] numeric NOT NULL,
    [drvYTDPensionableHrs] nvarchar(4000) NULL,
    [drvParollPeriodEndDate] datetime NULL,
    [drvInitialSort] char(11) NULL
);

-----------
-- Create table U_EJH401KRE2_EEList
-----------

IF OBJECT_ID('U_EJH401KRE2_EEList') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EJH401KRE2_File
-----------

IF OBJECT_ID('U_EJH401KRE2_File') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EJH401KRE2_PDedHist
-----------

IF OBJECT_ID('U_EJH401KRE2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt401KCP] numeric NULL,
    [PdhEECurAmtMatchCP] numeric NULL,
    [PdhEECurAmtPShareCP] numeric NULL,
    [PdhEECurAmtPtaxCUCP] numeric NULL,
    [PdhEECurAmtRothCP] numeric NULL,
    [PdhEECurAmtRothCUCP] numeric NULL,
    [PdhEECurAmtLoanCP] numeric NULL,
    [PdhEECurAmt401K] numeric NULL,
    [PdhEECurAmtMatch] numeric NULL,
    [PdhEECurAmtPShare] numeric NULL,
    [PdhEECurAmtPtaxCU] numeric NULL,
    [PdhEECurAmtRoth] numeric NULL,
    [PdhEECurAmtRothCU] numeric NULL,
    [PdhEECurAmtLoan] numeric NULL
);

-----------
-- Create table U_EJH401KRE2_PEarHist
-----------

IF OBJECT_ID('U_EJH401KRE2_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPeriodEndDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurInclInDefCompAmt] numeric NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] numeric NULL
);

-----------
-- Create table U_EJH401KRE2_PTaxHist
-----------

IF OBJECT_ID('U_EJH401KRE2_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EJH401KRE2_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthGrossAmt] money NULL,
    [PthGrossAmtCP] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EJH401KRE2]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Refresco

Created By: Alexei Burgoa
Business Analyst: Emily Gaddy
Create Date: 10/11/2018
Service Request Number: SR-2018-00210432

Purpose: John Hancock 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
Bryan Heid          04/07/2020     SR-2020-00264686   Adjust calculations for YTD plan comp, period plan comp, YTD Eligible comp and match comp calculations
Rishabh Verma       08/25/2021     SR-2021-00324083   Updated DrvUnionCode Fields and drvName Field
TekPartners         11/10/2021     no SR              Updated Excludable Code field and added Year to date pensionable hours and Payroll period end date fields
Darren Collard      12/30/2021     no SR              Exclude where YTD is 0 hours or $0.00 compensation, delete termed EEs based on start period, not run date.
Darren Collard      03/05/2022     no SR              Include terms keyed during the reporting period range
Darren Collard      03/05/2022     TekP-2022-11-02-01 Update logic for sending drvDateOfLastHire

SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EJH401KRE2';
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EJH401KRE2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EJH401KRE2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EJH401KRE2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode like 'EJH401KRE%' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJH401KRE2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJH401KRE2', 'SCHEDULED';

EXEC dbo.dsi_sp_UpdateConfig 'EJH401KRE2', 'ExportPath','V',  '\\us.saas\E4\Public\REF1001\Exports\JohnHancock\';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EJH401KRE2', 'TEST';
EXEC dbo.dsi_sp_UpdateConfig 'EJH401KRE2', 'ExportPath','V',  '\\us.saas\E0\data_exchange\REF1001\Exports\UDES\';

EXEC dbo.dsi_bdm_sp_errorcheck 'EJH401KRE2';


EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EJH401KRE2', @AllObjects = 'Y' , @IsWeb = 'N'

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
    SELECT @FormatCode = 'EJH401KRE2';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    DECLARE @PlanYearStart DATETIME;
    
    SET @PlanYearStart = DATEADD(yy, DATEDIFF(yy, 0, @EndDate), 0);




    --Audit Table
    IF OBJECT_ID('U_EJH401KRE2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_AuditFields;
    CREATE TABLE dbo.U_EJH401KRE2_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EJH401KRE2_AuditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EJH401KRE2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_Audit;
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
    INTO dbo.U_EJH401KRE2_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EJH401KRE2_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EJH401KRE2_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND CAST(adrProcessedDateTime AS DATE) BETWEEN @StartDate AND @EndDate
      AND ISNULL(adfNewData,'')='T';
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EJH401KRE2_Audit ON dbo.U_EJH401KRE2_Audit (audKey1Value, audKey2Value);


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EJH401KRE2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EJH401KRE2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --All employees, regardless of plan eligibility and employment status, should be included in the file.  Do not exclude terminated employees until the Plan Year has expired.

    DELETE dbo.U_EJH401KRE2_EEList
    FROM dbo.U_EJH401KRE2_EEList A
    INNER JOIN dbo.EmpComp B
        ON A.xEEID = B.EecEEID
        AND A.xCOID = B.EecCoID
        AND EecEmplStatus  = 'T' AND EecDateOfTermination < DATEADD(yy, DATEDIFF(yy, 0, @StartDate), 0)
    WHERE NOT EXISTS (SELECT 1 FROM dbo.pdedhist WITH (NOLOCK) WHERE pdhEEID = A.xEEID AND PdhPayDate >= DATEADD(yy, DATEDIFF(yy,0,@StartDate), 0))   --do not delete if they have a deduction in or after the start pay period control year
    AND NOT EXISTS (SELECT 1 FROM dbo.U_EJH401KRE2_Audit WITH (NOLOCK) WHERE AudKey1Value = A.xEEID)  --Include any terms keyed between @StartDate and @EndDate  

    
    /*DELETE FROM dbo.U_EJH401KRE2_EEList
    WHERE xEEID IN
    (SELECT EecEEID FROM EmpComp A WHERE EecEmplStatus = 'T' AND EecDateOfTermination < DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) AND NOT EXISTS (SELECT 1 EecEEID FROM EmpComp B WHERE EecEmplStatus <> 'T' AND A.EecEEID = B.EecEEID));
    */

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401K,401K1,4CU1,4CU,401KM,401SB,SBPSM,4L1,4L2,ROTH,ROTH1,RCU,RCU1';

    IF OBJECT_ID('U_EJH401KRE2_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EJH401KRE2_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EJH401KRE2_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_PDedHist;
    SELECT DISTINCT
         PdhEEID
        --,PdhPerControl = LEFT(PdhPerControl,8)
        -- Current Payroll Amounts
        --,PdhEECurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhERCurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhEECurAmt401KCP = SUM(CASE WHEN PdhDedCode IN ('401K','401K1') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtMatchCP = SUM(CASE WHEN PdhDedCode NOT IN ('SBPSM') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtPShareCP = SUM(CASE WHEN PdhDedCode IN ('SBPSM') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtPtaxCUCP = SUM(CASE WHEN PdhDedCode IN ('4CU','4CU1') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtRothCP = SUM(CASE WHEN PdhDedCode IN ('ROTH','ROTH1') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtRothCUCP = SUM(CASE WHEN PdhDedCode IN ('RCU','RCU1') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtLoanCP = SUM(CASE WHEN PdhDedCode IN ('4L1','4L2') AND  PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        -- YTD Payroll Amounts
        --,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        --,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhEECurAmt401K = SUM(CASE WHEN PdhDedCode IN ('401K','401K1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtMatch = SUM(CASE WHEN PdhDedCode IN ('401KM','SBPSM') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtPShare = SUM(CASE WHEN PdhDedCode IN ('SNPSM') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtPtaxCU = SUM(CASE WHEN PdhDedCode IN ('4CU','4CU1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtRoth = SUM(CASE WHEN PdhDedCode IN ('ROTH','ROTH1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtRothCU = SUM(CASE WHEN PdhDedCode IN ('RCU','RCU1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhEECurAmtLoan = SUM(CASE WHEN PdhDedCode IN ('4L1','4L2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EJH401KRE2_PDedHist
    FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_EJH401KRE2_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    GROUP BY PdhEEID--, LEFT(PdhPerControl,8)
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    ;

    -----------------------------PehCurInclInDefCompAmt
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EJH401KRE2_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_PEarHist;
    SELECT DISTINCT
         PehEEID
        --,PrgPayDate          = MAX(PrgPayDate)
        ,PrgPeriodEndDate    = MAX(PrgPeriodEndDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt           = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs         = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- Current Deferred Payroll Amount/Hours
        ,PehCurInclInDefCompAmt           = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN
                                                     CASE WHEN (PehPayGroup='SANBE' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '682') OR 
                                                     (PehPayGroup='STLOU' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '688')
                                                          THEN CASE WHEN PehEarnCode IN ('REG','REGDL') THEN PehCurAmt 
                                                          ELSE 0.00 END 
                                                     WHEN PehInclInDefComp = 'Y' THEN PehCurAmt
                                                     ELSE 0.00 END
                                                ELSE 0.00 END)
        --,PehCurInclInDefCompHrs           = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehInclInDefComp = 'Y' THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        --,PehCurAmtYTD        = SUM(PehCurAmt)
        ,PehCurHrsYTD        = SUM(CASE WHEN PehExclInTotalHours = 'N' THEN PehCurHrs END)  --Updated 2/6 to include PehExclInTotalHours
        -- Include Deferred Comp Amount/Hours
        ,PehInclInDefComp    = SUM(CASE WHEN (PehPayGroup='SANBE' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '682') OR 
                                             (PehPayGroup='STLOU' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '688')
                                        THEN CASE WHEN PehEarnCode IN ('REG','REGDL') THEN PehCurAmt 
                                        ELSE 0.00 END 
                               WHEN PehInclInDefComp = 'Y' THEN PehCurAmt
                               ELSE 0.00 
                               END)
        --,PehInclInDefCompHrs = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EJH401KRE2_PEarHist
    FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.EmpComp ON EecEEID = xEEID AND EecCOID = xCOID AND EecPayGroup = PehPayGroup
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    --HAVING (SUM(PehCurAmt) <> 0.00 OR SUM(PehCurHrs) <> 0.00) ;



        -----------------------------
    -- Working Table - PTaxHist 
    -----------------------------
    IF OBJECT_ID('U_EJH401KRE2_PTaxHist','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_PTaxHist;
    SELECT DISTINCT
         PthEEID 
        ,PthGrossAmt           = SUM(PthCurGrossWages) 
        ,PthGrossAmtCP           = SUM(CASE WHEN PthPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PthCurGrossWages ELSE 0.00 END)
    INTO dbo.U_EJH401KRE2_PTaxHist
    FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PthGenNumber = PrgGenNumber
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl AND PthTaxCode = 'USFUTA'
    GROUP BY PthEEID;
   -- HAVING SUM(PehCurAmt) <> 0.00;




   -----------------------------
-- Working Table - CompensationYTD
-----------------------------
IF OBJECT_ID('U_EJH401KRE2_CompYTD','U') IS NOT NULL
    DROP TABLE dbo.U_EJH401KRE2_CompYTD;
SELECT DISTINCT
     YTDEeID = PehEEID
    ,YTDCurInclInDefCompAmt = SUM(CASE WHEN (PehPayGroup='SANBE' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '682') OR 
                                               (PehPayGroup='STLOU' AND EecSalaryOrHourly='H' AND ISNULL(EecUnionLocal,'') = '688') THEN 
                                               CASE WHEN PehPerControl BETWEEN CONVERT(CHAR(8), dbo.dsi_fnGetMinMaxDates('MAX',@PlanYearStart, EedBenStartDate),112) + '1' AND @EndPerControl THEN 
                                                    CASE WHEN PehEarnCode IN ('REG','REGDL') THEN PehCurAmt 
                                                    ELSE 0.00 
                                                    END
                                               ELSE 0.00
                                               END
                                       WHEN PehPerControl BETWEEN CONVERT(CHAR(8), dbo.dsi_fnGetMinMaxDates('MAX',@PlanYearStart, EecDateOfOriginalHire),112) + '1' AND @EndPerControl THEN            
                                            CASE WHEN ErnInclInDefComp = 'Y' THEN PehCurAmt
                                            ELSE 0.00 
                                            END
                                  ELSE 0.00 
                                  END)
INTO dbo.U_EJH401KRE2_CompYTD
FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
JOIN dbo.EmpComp WITH (NOLOCK)
    ON EecEEID = xEEID
    AND EecCOID = xCOID
JOIN dbo.PEarHist WITH (NOLOCK)
    ON PehEeid = xEeid
JOIN dbo.EarnCode WITH (NOLOCK)
    ON ErnEarncode = PehEarnCode
    AND (ErnInclInDefComp = 'Y' OR ErnEarnCode IN ('REG','REGDL'))
LEFT JOIN (SELECT EedEeid,EedCoid,min(EedBenStartDate) EedBenstartDate 
        FROM dbo.EmpDed WITH (NOLOCK) 
        JOIN dbo.U_EJH401KRE2_DedList WITH (NOLOCK)
          ON DedCode = EedDedCode
    GROUP BY EedEeid,EedCoid) eed 
    ON EedEeid = xEeid
    AND EedCoid = xCoid
WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
AND PehPerControl <= @EndPerControl
GROUP BY PehEEID
;
 --  ---------------------------
 --    Working Table - CompensationYTD
 --   ---------------------------
 --   IF OBJECT_ID('U_EJH401KRE2_CompYTD','U') IS NOT NULL
 --       DROP TABLE dbo.U_EJH401KRE2_CompYTD;
 --   SELECT DISTINCT
 --        YTDEeID  = PehEeid
 --       ,YTDCurInclInDefCompAmt    =  SUM(CASE WHEN CONVERT(VARCHAR(8), PehPerControl) BETWEEN  dbo.dsi_fnGetMinMaxDates('MAX',Eedbenstartdate, EecDateofBenefitSeniority) AND @EndDate THEN PehCurAmt ELSE 0.00 END)  --SUM(CASE WHEN PehInclInDefComp = 'Y' AND CONVERT(Varchar( 8 ), PehPerControl) BETWEEN CONVERT(VARCHAR, MAX (eecDateOfBenefitSeniority),112) AND CONVERT(VARCHAR , @EndDate, 112) THEN PehCurAmt ELSE 0.00 END)
 --   INTO dbo.U_EJH401KRE2_CompYTD
 --   FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
 --   JOIN dbo.EmpComp WITH (NOLOCK)
 --       ON EecEEID = xEEID
    --    AND EecCOID = xCOID
 --   JOIN dbo.PEarHist WITH (NOLOCK)
 --       ON PehEeid = xEeid
    --JOIN dbo.EarnCode WITH (NOLOCK)
    --    ON ErnEarncode = PehEarnCode
    --    AND ErnInclInDefComp = 'Y'
    --JOIN dbo.EmpDed WITH (NOLOCK) 
    --    ON EedEeid = xEeid
    --    AND EedCoid = xCoid
 --   WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
 --   AND PehPerControl <= @EndPerControl
 --   GROUP BY PehEeid


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EJH401KRE2_drvTbl
    ---------------------------------

    IF OBJECT_ID('U_EJH401KRE2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EJH401KRE2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvPlanNum = 'CO45SL'
        ,drvDivision = CASE WHEN EecUnionLocal NOT IN ('830','Y','N') THEN SUBSTRING(EecUnionLocal,1,3) ELSE 'REF' END
  --      ,drvPayrollCompCode = 'CAOF'
        ,drvSSN = eepSSN
        ,drvName = '"' + RTRIM(EepNameLast) + ',' + RTRIM(EepNameFirst) + '"' -- RTRIM(EepNameLast)  +',' + RTRIM(EepNameFirst)   -- Updated buy Rishabh Verma SR-2021-00324083
        ,drvAddressLine1 = REPLACE(EepAddressLine1,',','')
        ,drvAddressLine2 = REPLACE(EepAddressLine2,',','')
        ,drvAddressCity = REPLACE(EepAddressCity,',','')
        ,drvAddressState = EepAddressState
        ,drvAddressProvince = ''
        ,drvAddressCountry = ''  -- EepAddressCountry -- CSASE EepAddressCountry WHEN 'USA' THEN 'US' ELSE '' END --client confirmed US only emps
        ,drvAddressZip = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
-- 20200327
--        ,drvDateOfLastHire =     CASE WHEN EecDateOfLastHire <> EecDateofOriginalHire AND EecJoBChangeReason ='101' THEN ISNULL(EecDateofLastHire,'')  END
        ,drvDateOfLastHire =     
            CASE WHEN EecEEType NOT IN ( 'REG', 'EXE','HS') OR EecDedGroupCode IN ('CNCDU') OR EecUnionLocal = 'PAW22000' THEN NULL
                 WHEN EecDateOfLastHire <> EecDateofOriginalHire AND EecJoBChangeReason ='101' THEN EecDateofLastHire
                 ELSE NULL
            END
        
        --CASE WHEN EecDateOfLastHire <> EecDateofOriginalHire THEN 
  --                                                              CASE WHEN EecJoBChangeReason IN ('101','102') THEN EecDateofLastHire ELSE '' END
  --                                       END
        ,drvExcludCode = CASE WHEN EecEEType NOT IN ( 'REG', 'EXE','HS') OR EecDedGroupCode IN ('CNCDU') OR EecUnionLocal = 'PAW22000' THEN 'X' ELSE '' END 
        ,drvHourlySalary = EecSalaryOrHourly
        ,drvStatus = CASE WHEN EecEmplStatus = 'A' THEN 'A'
-- 20200327
                          WHEN EecEmplStatus = 'S' THEN 'A'
                          WHEN EecEmplStatus = 'L' THEN 'L'
                          WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'D'
                          ELSE 'T' END 
        ,drvGender = EepGender
        ,drvPayrollFreq = EecPayPeriod
        ,drvLanguage =''-- EepLanguage
        ,drvWorkEmail = EepAddressEMail
        ,drvWorkPhone = EepPhoneHomeNumber 
        ,drvTotPlanYTDGrossComp = ISNULL(PthGrossAmt,0)  --ISNULL(PehCurAmtYTD,0)
        ,drvPTDGrossComp = ISNULL(PthGrossAmtCP,0)  --ISNULL(PehCurAmt,0)
        ,drvTotPlanYTDPlanComp = ISNULL(PehInclInDefComp ,0)--ISNULL(PehCurAmtYTD,0) --ISNULL(PehInclInDefComp,0)
        ,drvTotPTDPlanComp = ISNULL(PehCurInclInDefCompAmt,0) -- ISNULL(PehCurInclInDefCompAmt,0)
        ,drvTotMngedAcctAnnualComp = EecAnnSalary
        ,drvTotPTD401KContrib = ISNULL(PdhEECurAmt401KCP,0)
        ,drvTotPTDMatchContrib = ISNULL(PdhEECurAmtMatchCP,0)
        ,drvTotPTDProfShrContrib = ISNULL(PdhEECurAmtPshareCP,0)
        ,drvTotPTDCatchUpContrib = ISNULL(PdhEECurAmtPtaxCUCP,0)
        ,drvTotPTDRothContrib = ISNULL(PdhEECurAmtRothCP,0)
        ,drvTotPTDRothCUContrib = ISNULL(PdhEECurAmtRothCUCP,0)
        ,drvTotPTDLoanRepaySum = ISNULL(PdhEECurAmtLoanCP,0)
        ,drvYTDHours = ISNULL(PehCurHrsYTD,0)
        ,drvDefPretax = ''
        ,drvDefPretaxAddl = ''
        ,drvDefRoth = ''
        ,drvDefRothCU = ''
        ,drvEmployerBaseMatch = ''
        ,drvTotPlanYTDProfitShrComp = ISNULL(YTDCurInclInDefCompAmt ,0)
        ,drvUnionCode = Case WHEN ISNULL(EecUnionLocal, 'N') <> 'N'  THEN 'U'         --Updated buy Rishabh Verma SR-2021-00324083
                              WHEN EecUnionLocal <> 'N' THEN 'U'
                              ELSE '' END
        
        
        /*CASE
                             WHEN ISNULL(EecUnionNational,'N') <> 'N' THEN 'U' 
                             WHEN ISNULL(EecUnionLocal, 'N') <> 'N'  THEN 'U'
                             WHEN EecUnionLocal <> 'N' THEN 'U'
                             WHEN EecUnionNational <> 'N' THEN 'U'  ELSE '' END */ 
        ,drvTotYTDMatchComp = ISNULL(PehInclInDefComp,0) 
        ,drvYTDPensionableHrs = CASE WHEN LEFT(EecUnionLocal,3) IN ('TRU','PAW') THEN FORMAT(PehCurHrsYTD, '#0.00') END
        ,drvParollPeriodEndDate = CASE WHEN LEFT(EecUnionLocal,3) IN ('TRU','PAW') THEN PrgPeriodEndDate END
        ,drvInitialSort = EepSSN 
    INTO dbo.U_EJH401KRE2_drvTbl
    FROM dbo.U_EJH401KRE2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EJH401KRE2_PEarHist
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EJH401KRE2_PTaxHist WITH (NOLOCK)
        ON PthEEID = xeeId
    LEFT JOIN dbo.U_EJH401KRE2_CompYTD WITH (NOLOCK)
        ON YTDEeid = xeeid
    LEFT JOIN U_EJH401KRE2_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN (
            SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PrgPayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                FROM dbo.PgPayPer WITH (NOLOCK)
                WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                --AND PgpPeriodType = 'R'
                GROUP BY PgpPayGroup) AS Prg
        ON EecPayGroup = PgpPayGroup
    WHERE ISNULL(PthGrossAmtCP,0) <> 0 
       OR ISNULL(PehCurHrsYTD,0) <> 0  --DLC 12/30/2021 
       OR EXISTS (SELECT 1 FROM dbo.U_EJH401KRE2_Audit WITH (NOLOCK) WHERE AudKey1Value = xEEID);  --Include anyone with a term keyed between start/end date



      ---------------------------------
  --  -- TRAILER RECORD
  --  ---------------------------------
  --  IF OBJECT_ID('U_EJH401KRE2_TrailerTbl','U') IS NOT NULL
  --      DROP TABLE dbo.U_EJH401KRE2_TrailerTbl;
  --  SELECT DISTINCT
  --      drvPlanNumT = ''
  --      ,drvDivisionT = ''
  ----      ,drvPayrollCompCode = 'CAOF'
  --      ,drvSSNT = ''
  --      ,drvNameT = ''
  --      ,drvAddressLine1T = ''
  --      ,drvAddressLine2T = ''
  --      ,drvAddressCityT = ''
  --      ,drvAddressStateT = ''
  --      ,drvAddressProvinceT = ''
  --      ,drvAddressCountryT ='' -- CASE EepAddressCountry WHEN 'USA' THEN 'US' ELSE '' END --client confirmed US only emps
  --      ,drvAddressZipT = ''
  --      ,drvDateOfBirthT = ''
  --      ,drvDateOfOriginalHireT = ''
  --      ,drvDateOfTerminationT = ''
  --      ,drvDateOfLastHireT =     ''
  --      ,drvExcludCodeT = ''
  --      ,drvHourlySalaryT =''
  --      ,drvStatusT =''
  --      ,drvGenderT = ''
  --      ,drvPayrollFreqT = ''
  --      ,drvLanguageT =''
  --      ,drvWorkEmailT = ''
  --      ,drvWorkPhoneT = ''
  --      ,drvTotPlanYTDGrossCompT = (Select sum (drvTotPlanYTDGrossComp) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvPTDGrossCompT = (Select sum (drvPTDGrossComp) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPlanYTDPlanCompT = (Select sum( drvTotPlanYTDPlanComp) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDPlanCompT = (Select sum( drvTotPTDPlanComp) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotMngedAcctAnnualCompT =''
  --      ,drvTotPTD401KContribT =(Select sum( drvTotPTD401KContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDMatchContribT = (Select sum( drvTotPTDMatchContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDProfShrContribT = (Select sum( drvTotPTDProfShrContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDCatchUpContribT = (Select sum(drvTotPTDCatchUpContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDRothContribT = (Select sum( drvTotPTDRothContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDRothCUContribT = (Select sum( drvTotPTDRothCUContrib) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvTotPTDLoanRepaySumT = (Select sum( drvTotPTDLoanRepaySum) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvYTDHoursT = ''
  --      ,drvDefPretaxT = ''
  --      ,drvDefPretaxAddlT = ''
  --      ,drvDefRothT = ''
  --      ,drvDefRothCUT = ''
  --      ,drvEmployerBaseMatchT = ''
  --      ,drvTotPlanYTDProfitShrCompT = (Select sum( drvTotPlanYTDProfitShrComp) from dbo.U_EJH401KRE2_drvTbl)
  --      ,drvUnionCodeT = ''
  --      ,drvTotYTDMatchCompT = (Select sum(drvTotYTDMatchComp) from dbo.U_EJH401KRE2_drvTbl)
  --  INTO dbo.U_EJH401KRE2_TrailerTbl
--    FROM (SELECT COUNT(*) dtlcount FROM U_EBENWLTENR_FSAdrvTbl) cnt
  --  WHERE @EXPORTCODE LIKE '%FSA%'
    


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'CO45SL_' +  SUBSTRING(@EndPercontrol,5,4) + SUBSTRING(@EndPercontrol,1,4)+ '_Test.csv'
                                  WHEN @ExportCode like '%test%' THEN 'CO45SL_' +  SUBSTRING(@EndPercontrol,5,4) + SUBSTRING(@EndPercontrol,1,4)+ '_Test.csv'
                                  ELSE 'CO45SL_' +  SUBSTRING(@EndPercontrol,5,4) + SUBSTRING(@EndPercontrol,1,4) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEJH401KRE2_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EJH401KRE2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EJH401KRE2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202111011'
       ,expStartPerControl     = '202111011'
       ,expLastEndPerControl   = '202111159'
       ,expEndPerControl       = '202111159'
WHERE expFormatCode = 'EJH401KRE2';

UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201072'
       ,expStartPerControl     = '202201072'
       ,expLastEndPerControl   = '202201131'
       ,expEndPerControl       = '202201131'
       ,expCOIDList            = 'DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX'
       ,expAscFileName         = CONCAT('\\us.saas\E4\Public\REF1001\Exports\JohnHancock\'
                                 ,RTRIM(expFormatCode),'_',RTRIM(expExportCode),'_',CONVERT(varchar, GETDATE(),112),'.txt')
WHERE expFormatCode = 'EJH401KRE2' And expExportCode = 'TEST';

**********************************************************************************/
GO
Create View dbo.dsi_vwEJH401KRE2_Export as
                            select top 200000000 Data from dbo.U_EJH401KRE2_File with (nolock)
                            order by substring(RecordSet,2,2), InitialSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EJH401KRE2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EJH401KRE2'
   AND rpoParmType = 'expSystemID'


-- End ripout