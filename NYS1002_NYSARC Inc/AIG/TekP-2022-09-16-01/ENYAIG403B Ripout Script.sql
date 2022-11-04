/**********************************************************************************

ENYAIG403B: AIG 403b Combined Export

FormatCode:     ENYAIG403B
Project:        AIG 403b Combined Export
Client ID:      NYS1002
Date/time:      2022-11-03 16:04:13.783
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E42
Server:         E4SUP2DB04
Database:       ULTIPRO_NYAR
Web Filename:   NYS1002_JHH1U_EEHISTORY_ENYAIG403B_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ENYAIG403B_SavePath') IS NOT NULL DROP TABLE dbo.U_ENYAIG403B_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ENYAIG403B'


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
WHERE FormatCode = 'ENYAIG403B'
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
WHERE ExpFormatCode = 'ENYAIG403B'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ENYAIG403B')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ENYAIG403B'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ENYAIG403B'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ENYAIG403B'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ENYAIG403B'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ENYAIG403B'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ENYAIG403B'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ENYAIG403B'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ENYAIG403B'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ENYAIG403B'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwENYAIG403B_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENYAIG403B_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENYAIG403B') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENYAIG403B];
GO
IF OBJECT_ID('U_ENYAIG403B_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ENYAIG403B_PEarHist];
GO
IF OBJECT_ID('U_ENYAIG403B_PDedHistTotals') IS NOT NULL DROP TABLE [dbo].[U_ENYAIG403B_PDedHistTotals];
GO
IF OBJECT_ID('U_ENYAIG403B_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ENYAIG403B_PDedHist];
GO
IF OBJECT_ID('U_ENYAIG403B_File') IS NOT NULL DROP TABLE [dbo].[U_ENYAIG403B_File];
GO
IF OBJECT_ID('U_ENYAIG403B_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENYAIG403B_EEList];
GO
IF OBJECT_ID('U_ENYAIG403B_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENYAIG403B_drvTbl];
GO
IF OBJECT_ID('U_ENYAIG403B_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENYAIG403B_DedList];
GO
IF OBJECT_ID('U_ENYAIG403B_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ENYAIG403B_AuditFields];
GO
IF OBJECT_ID('U_ENYAIG403B_Audit') IS NOT NULL DROP TABLE [dbo].[U_ENYAIG403B_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ENYAIG403B') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENYAIG403B];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ENYAIG403B','AIG 403b Combined Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','7000','S','N','ENYAIG403BZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENYAIG403BZ0','50','H','01','1',NULL,'Format Code',NULL,NULL,'"Format Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENYAIG403BZ0','50','H','01','2',NULL,'Paygroup ID',NULL,NULL,'"Paygroup ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENYAIG403BZ0','50','H','01','3',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENYAIG403BZ0','50','H','01','4',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENYAIG403BZ0','50','H','01','5',NULL,'Participant First Name',NULL,NULL,'"Participant First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENYAIG403BZ0','50','H','01','6',NULL,'Participant Middle Name',NULL,NULL,'"Participant Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENYAIG403BZ0','50','H','01','7',NULL,'Participant Last Name',NULL,NULL,'"Participant Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENYAIG403BZ0','50','H','01','8',NULL,'Address 1',NULL,NULL,'"Address 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENYAIG403BZ0','50','H','01','9',NULL,'Address 2',NULL,NULL,'"Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENYAIG403BZ0','50','H','01','10',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENYAIG403BZ0','50','H','01','11',NULL,'State/Country Code',NULL,NULL,'"State/Country Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENYAIG403BZ0','50','H','01','12',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENYAIG403BZ0','50','H','01','13',NULL,'Payroll Frequency Code',NULL,NULL,'"Payroll Frequency Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENYAIG403BZ0','50','H','01','14',NULL,'Payroll Date',NULL,NULL,'"Payroll Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENYAIG403BZ0','50','H','01','15',NULL,'EE Elective Pre-Tax (CS 6)',NULL,NULL,'"EE Elective Pre-Tax (CS 6)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENYAIG403BZ0','50','H','01','16',NULL,'ER Non-Matching( CS 8)',NULL,NULL,'"ER Non-Matching (CS 8)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENYAIG403BZ0','50','H','01','17',NULL,'ER Matching (CS 9)',NULL,NULL,'"ER Matching (CS 9)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENYAIG403BZ0','50','H','01','18',NULL,'Roth (CS M)',NULL,NULL,'"Roth (CS M)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENYAIG403BZ0','50','H','01','19',NULL,'Loan Payments payroll-deducted)',NULL,NULL,'"Loan Payments payroll-deducted)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENYAIG403BZ0','50','H','01','20',NULL,'Loan ID 1',NULL,NULL,'"Loan ID 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENYAIG403BZ0','50','H','01','21',NULL,'Birth Date',NULL,NULL,'"Birth Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENYAIG403BZ0','50','H','01','22',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENYAIG403BZ0','50','H','01','23',NULL,'Phone',NULL,NULL,'"Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENYAIG403BZ0','50','H','01','24',NULL,'Address 3',NULL,NULL,'"Address 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENYAIG403BZ0','50','H','01','25',NULL,'Gender ID',NULL,NULL,'"Gender ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENYAIG403BZ0','50','H','01','26',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENYAIG403BZ0','50','H','01','27',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENYAIG403BZ0','50','H','01','28',NULL,'Employment Status Change Date',NULL,NULL,'"Employment Status Change Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENYAIG403BZ0','50','H','01','29',NULL,'Location Code',NULL,NULL,'"Location Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENYAIG403BZ0','50','H','01','30',NULL,'HR Sub Area',NULL,NULL,'"HR Sub Area"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENYAIG403BZ0','50','H','01','31',NULL,'Employee Job Type (Payroll Status Code)',NULL,NULL,'"Employee Job Type (Payroll Status Code)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENYAIG403BZ0','50','H','01','32',NULL,'Annual Base Salary',NULL,NULL,'"Annual Base Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENYAIG403BZ0','50','H','01','33',NULL,'Year-To-Date (YTD) Hours',NULL,NULL,'"Year-To-Date (YTD) Hours"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENYAIG403BZ0','50','H','01','34',NULL,'Email Address',NULL,NULL,'"Email Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENYAIG403BZ0','50','H','01','35',NULL,'Agent Code(TPA Field)',NULL,NULL,'"Agent Code(TPA Field)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENYAIG403BZ0','50','H','01','36',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENYAIG403BZ0','50','H','01','37',NULL,'e-Delivery Flag',NULL,NULL,'"e-Delivery Flag"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENYAIG403BZ0','50','H','01','38',NULL,'Employee Classification Code',NULL,NULL,'"Employee Classification Code "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ENYAIG403BZ0','50','H','01','39',NULL,'Employee Classification Code Effective Date',NULL,NULL,'"Employee Classification Code Effective Date "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ENYAIG403BZ0','50','H','01','40',NULL,'Employee Pay Type',NULL,NULL,'"Employee Pay Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ENYAIG403BZ0','50','H','01','41',NULL,'Employee Type',NULL,NULL,'"Employee Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ENYAIG403BZ0','50','H','01','42',NULL,'Employment Status Location',NULL,NULL,'"Employment Status Location"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ENYAIG403BZ0','50','H','01','43',NULL,'Employment Sub Type',NULL,NULL,'"Employment Sub Type "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ENYAIG403BZ0','50','H','01','44',NULL,'Excluded Class Type',NULL,NULL,'"Excluded Class Type "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ENYAIG403BZ0','50','H','01','45',NULL,'Highly Compensated Code',NULL,NULL,'"Highly Compensated Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ENYAIG403BZ0','50','H','01','46',NULL,'HR Area',NULL,NULL,'"HR Area"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ENYAIG403BZ0','50','H','01','47',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ENYAIG403BZ0','50','H','01','48',NULL,'Key Employee Code',NULL,NULL,'"Key Employee Code "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ENYAIG403BZ0','50','H','01','49',NULL,'Non Resident Alien',NULL,NULL,'"Non Resident Alien"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ENYAIG403BZ0','50','H','01','50',NULL,'Officer Code',NULL,NULL,'"Officer Code "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ENYAIG403BZ0','50','H','01','51',NULL,'Owner Code',NULL,NULL,'"Owner Code  "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ENYAIG403BZ0','50','H','01','52',NULL,'Owner Percent',NULL,NULL,'"Owner Percent "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ENYAIG403BZ0','50','H','01','53',NULL,'Original Hire Date',NULL,NULL,'"Original Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ENYAIG403BZ0','50','H','01','54',NULL,'Plan Participant Status',NULL,NULL,'"Plan Participant Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ENYAIG403BZ0','50','H','01','55',NULL,'Plan Participant Status Date',NULL,NULL,'"Plan Participant Status Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ENYAIG403BZ0','50','H','01','56',NULL,'Prior EID',NULL,NULL,'"Prior EID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ENYAIG403BZ0','50','H','01','57',NULL,'Provider ID',NULL,NULL,'"Provider ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ENYAIG403BZ0','50','H','01','58',NULL,'Relationship to Owner',NULL,NULL,'"Relationship to Owner"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ENYAIG403BZ0','50','H','01','59',NULL,'Spouse Date of Birth',NULL,NULL,'"Spouse Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ENYAIG403BZ0','50','H','01','60',NULL,'Sub Group',NULL,NULL,'"Sub Group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ENYAIG403BZ0','50','H','01','61',NULL,'Union Effective Date',NULL,NULL,'"Union Effective Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ENYAIG403BZ0','50','H','01','62',NULL,'Union ID',NULL,NULL,'"Union ID "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ENYAIG403BZ0','50','H','01','63',NULL,'Union Indicator',NULL,NULL,'"Union Indicator"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ENYAIG403BZ0','50','H','01','64',NULL,'Accumulated Months of Service',NULL,NULL,'"Accumulated Months of Service "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ENYAIG403BZ0','50','H','01','65',NULL,'Adjusted Service Date',NULL,NULL,'"Adjusted Service Date "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ENYAIG403BZ0','50','H','01','66',NULL,'Date of Disability',NULL,NULL,'"Date of Disability"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ENYAIG403BZ0','50','H','01','67',NULL,'Date of Termination',NULL,NULL,'"Date of Termination"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ENYAIG403BZ0','50','H','01','68',NULL,'FTE(Full Time Equivalent)',NULL,NULL,'"FTE(Full Time Equivalent) "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ENYAIG403BZ0','50','H','01','69',NULL,'Per Pay Period Hours',NULL,NULL,'"Per Pay Period Hours "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ENYAIG403BZ0','50','H','01','70',NULL,'Plan Compensation End Date',NULL,NULL,'"Plan Compensation End Date "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ENYAIG403BZ0','50','H','01','71',NULL,'Plan Eligibility Date',NULL,NULL,'"Plan Eligibility Date "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ENYAIG403BZ0','50','H','01','72',NULL,'Plan Participation Date',NULL,NULL,'"Plan Participation Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ENYAIG403BZ0','50','H','01','73',NULL,'Plan Vesting Date',NULL,NULL,'"Plan Vesting Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ENYAIG403BZ0','50','H','01','74',NULL,'Date of Rehire',NULL,NULL,'"Date of Rehire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ENYAIG403BZ0','50','H','01','75',NULL,'Years of Service',NULL,NULL,'"Years of Service"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ENYAIG403BZ0','50','H','01','76',NULL,'415 Compensation',NULL,NULL,'"415 Compensation "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ENYAIG403BZ0','50','H','01','77',NULL,'415 Compensation End Date',NULL,NULL,'"415 Compensation End Date "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ENYAIG403BZ0','50','H','01','78',NULL,'Catch up Contribution Rate',NULL,NULL,'"Catch up Contribution Rate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ENYAIG403BZ0','50','H','01','79',NULL,'Class CS 1(Excluded EE)',NULL,NULL,'"Class CS 1(Excluded EE) "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ENYAIG403BZ0','50','H','01','80',NULL,'Class CS 2(Excluded EE)',NULL,NULL,'"Class CS 2(Excluded EE) "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ENYAIG403BZ0','50','H','01','81',NULL,'Class CS 3(Excluded EE)',NULL,NULL,'"Class CS 3(Excluded EE) "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ENYAIG403BZ0','50','H','01','82',NULL,'Class CS 4(Excluded EE)',NULL,NULL,'"Class CS 4(Excluded EE) "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ENYAIG403BZ0','50','H','01','83',NULL,'Class CS 5(Excluded EE)',NULL,NULL,'"Class CS 5(Excluded EE) "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ENYAIG403BZ0','50','H','01','84',NULL,'Contribution Type',NULL,NULL,'"Contribution Type "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ENYAIG403BZ0','50','H','01','85',NULL,'Defined Benefit Compensation',NULL,NULL,'"Defined Benefit Compensation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ENYAIG403BZ0','50','H','01','86',NULL,'Defined Benefit Compensation (Bonus)',NULL,NULL,'"Defined Benefit Compensation (Bonus)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ENYAIG403BZ0','50','H','01','87',NULL,'Defined Benefit Hours',NULL,NULL,'"Defined Benefit Hours"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ENYAIG403BZ0','50','H','01','88',NULL,'Cont Eligibility Source 1',NULL,NULL,'"Contribution Eligibility Source 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ENYAIG403BZ0','50','H','01','89',NULL,'Cont Eligibility Date 1',NULL,NULL,'"Contribution Eligibility Date 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ENYAIG403BZ0','50','H','01','90',NULL,'Cont Eligibility Status Source 1',NULL,NULL,'"Contribution Eligibility Status Source 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ENYAIG403BZ0','50','H','01','91',NULL,'Cont Eligibility Source 2',NULL,NULL,'"Contribution Eligibility Source 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ENYAIG403BZ0','50','H','01','92',NULL,'Cont Eligibility Date 2',NULL,NULL,'"Contribution Eligibility Date 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ENYAIG403BZ0','50','H','01','93',NULL,'Cont Eligibility Status Source 2',NULL,NULL,'"Contribution Eligibility Status Source 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ENYAIG403BZ0','50','H','01','94',NULL,'Cont Eligibility Source 3',NULL,NULL,'"Contribution Eligibility Source 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ENYAIG403BZ0','50','H','01','95',NULL,'Cont Eligibility Date 3',NULL,NULL,'"Contribution Eligibility Date 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ENYAIG403BZ0','50','H','01','96',NULL,'Cont Eligibility Status Source 3',NULL,NULL,'"Contribution Eligibility Status Source 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ENYAIG403BZ0','50','H','01','97',NULL,'Cont Eligibility Source 4',NULL,NULL,'"Contribution Eligibility Source 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ENYAIG403BZ0','50','H','01','98',NULL,'Cont Eligibility Date 4',NULL,NULL,'"Contribution Eligibility Date 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ENYAIG403BZ0','50','H','01','99',NULL,'Cont Eligibility Status Source 4',NULL,NULL,'"Contribution Eligibility Status Source 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ENYAIG403BZ0','50','H','01','100',NULL,'Cont Eligibility Source 5',NULL,NULL,'"Contribution Eligibility Source 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ENYAIG403BZ0','50','H','01','101',NULL,'Cont Eligibility Date 5',NULL,NULL,'"Contribution Eligibility Date 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ENYAIG403BZ0','50','H','01','102',NULL,'Cont Eligibility Status Source 5',NULL,NULL,'"Contribution Eligibility Status Source 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ENYAIG403BZ0','50','H','01','103',NULL,'Employer Contribution Rate',NULL,NULL,'"Employer Contribution Rate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ENYAIG403BZ0','50','H','01','104',NULL,'Gross Compensation',NULL,NULL,'"Gross Compensation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ENYAIG403BZ0','50','H','01','105',NULL,'Loan Repayment Amount 1',NULL,NULL,'"Loan Repayment Amount 1 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ENYAIG403BZ0','50','H','01','106',NULL,'Loan ID 2',NULL,NULL,'"Loan ID 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ENYAIG403BZ0','50','H','01','107',NULL,'Loan Repayment Amount 2',NULL,NULL,'"Loan Repayment Amount 2 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ENYAIG403BZ0','50','H','01','108',NULL,'Loan ID 3',NULL,NULL,'"Loan ID 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ENYAIG403BZ0','50','H','01','109',NULL,'Loan Repayment Amount 3',NULL,NULL,'"Loan Repayment Amount 3 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','ENYAIG403BZ0','50','H','01','110',NULL,'Loan ID 4',NULL,NULL,'"Loan ID 4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','ENYAIG403BZ0','50','H','01','111',NULL,'Loan Repayment Amount 4',NULL,NULL,'"Loan Repayment Amount 4 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','ENYAIG403BZ0','50','H','01','112',NULL,'Loan ID 5',NULL,NULL,'"Loan ID 5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','ENYAIG403BZ0','50','H','01','113',NULL,'Loan Repayment Amount 5',NULL,NULL,'"Loan Repayment Amount 5 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','ENYAIG403BZ0','50','H','01','114',NULL,'Payroll Period Ending Date',NULL,NULL,'"Payroll Period Ending Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','ENYAIG403BZ0','50','H','01','115',NULL,'Pension Benefit Start Age',NULL,NULL,'"Pension Benefit Start Age "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','ENYAIG403BZ0','50','H','01','116',NULL,'Pension Monthly Benefits',NULL,NULL,'"Pension Monthly Benefits "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','ENYAIG403BZ0','50','H','01','117',NULL,'Plan Compensation',NULL,NULL,'"Plan Compensation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','ENYAIG403BZ0','50','H','01','118',NULL,'Plan Excluded Compensation',NULL,NULL,'"Plan Excluded Compensation "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','ENYAIG403BZ0','50','H','01','119',NULL,'Vesting Source Name 1',NULL,NULL,'"Vesting Source Name 1 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','ENYAIG403BZ0','50','H','01','120',NULL,'Vested Source Name Date 1',NULL,NULL,'"Vested Source Name Date 1 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','ENYAIG403BZ0','50','H','01','121',NULL,'Vesting Percentage 1',NULL,NULL,'"Vesting Percentage 1 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','ENYAIG403BZ0','50','H','01','122',NULL,'Vesting Source Name 2',NULL,NULL,'"Vesting Source Name 2 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','ENYAIG403BZ0','50','H','01','123',NULL,'Vested Source Name Date 2',NULL,NULL,'"Vested Source Name Date 2 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','ENYAIG403BZ0','50','H','01','124',NULL,'Vesting Percentage 2',NULL,NULL,'"Vesting Percentage 2 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','ENYAIG403BZ0','50','H','01','125',NULL,'Vesting Source Name 3',NULL,NULL,'"Vesting Source Name 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','ENYAIG403BZ0','50','H','01','126',NULL,'Vested Source Name Date 3',NULL,NULL,'"Vested Source Name Date 3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','ENYAIG403BZ0','50','H','01','127',NULL,'Vesting Percentage 3',NULL,NULL,'"Vesting Percentage 3 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','ENYAIG403BZ0','50','H','01','128',NULL,'Vesting Source Name 4',NULL,NULL,'"Vesting Source Name 4 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','ENYAIG403BZ0','50','H','01','129',NULL,'Vested Source Name Date 4',NULL,NULL,'"Vested Source Name Date 4 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','ENYAIG403BZ0','50','H','01','130',NULL,'Vesting Percentage 4',NULL,NULL,'"Vesting Percentage 4 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','ENYAIG403BZ0','50','H','01','131',NULL,'Vesting Source Name 5',NULL,NULL,'"Vesting Source Name 5 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','ENYAIG403BZ0','50','H','01','132',NULL,'Vested Source Name Date 5',NULL,NULL,'"Vested Source Name Date 5 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','ENYAIG403BZ0','50','H','01','133',NULL,'Vesting Percentage 5',NULL,NULL,'"Vesting Percentage 5 "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','ENYAIG403BZ0','50','H','01','134',NULL,'Primary Location Code',NULL,NULL,'"Primary Location Code"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ENYAIG403BZ0','50','D','10','1',NULL,'Format Code',NULL,NULL,'"PSDI"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ENYAIG403BZ0','50','D','10','2',NULL,'Paygroup ID',NULL,NULL,'"7259414403BN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ENYAIG403BZ0','50','D','10','3',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ENYAIG403BZ0','50','D','10','4',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ENYAIG403BZ0','50','D','10','5',NULL,'Participant First Name',NULL,NULL,'"drvParticipantFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ENYAIG403BZ0','50','D','10','6',NULL,'Participant Middle Name',NULL,NULL,'"drvParticipantMiddleName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ENYAIG403BZ0','50','D','10','7',NULL,'Participant Last Name',NULL,NULL,'"drvParticipantLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ENYAIG403BZ0','50','D','10','8',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ENYAIG403BZ0','50','D','10','9',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ENYAIG403BZ0','50','D','10','10',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ENYAIG403BZ0','50','D','10','11',NULL,'State/Country Code',NULL,NULL,'"drvStateCountryCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ENYAIG403BZ0','50','D','10','12',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ENYAIG403BZ0','50','D','10','13',NULL,'Payroll Frequency Code',NULL,NULL,'"drvPayrollFrequencycode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ENYAIG403BZ0','50','D','10','14',NULL,'Payroll Date',NULL,NULL,'"drvPayrolDate"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ENYAIG403BZ0','50','D','10','15',NULL,'EE Elective Pre-Tax(CS 6)',NULL,NULL,'"drvEEElectivePretax"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ENYAIG403BZ0','50','D','10','16',NULL,'ER Non-Matching(CS 8)',NULL,NULL,'"drvERNonMatching"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ENYAIG403BZ0','50','D','10','17',NULL,'ER Matching(CS 9)',NULL,NULL,'"drvERMatching"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ENYAIG403BZ0','50','D','10','18',NULL,'Roth(CS M)',NULL,NULL,'"drvRoth"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ENYAIG403BZ0','50','D','10','19',NULL,'Loan Payments payroll-deducted)',NULL,NULL,'"drvLoanPayments"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ENYAIG403BZ0','50','D','10','20',NULL,'Loan ID 1',NULL,NULL,'"00"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ENYAIG403BZ0','50','D','10','21',NULL,'Birth Date',NULL,NULL,'"drvBirthdate"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ENYAIG403BZ0','50','D','10','22',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ENYAIG403BZ0','50','D','10','23',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ENYAIG403BZ0','50','D','10','24',NULL,'Address 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ENYAIG403BZ0','50','D','10','25',NULL,'Gender ID',NULL,NULL,'"drvGenderID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ENYAIG403BZ0','50','D','10','26',NULL,'Marital Status',NULL,NULL,'"drvMaritalstatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ENYAIG403BZ0','50','D','10','27',NULL,'Employment Status',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ENYAIG403BZ0','50','D','10','28',NULL,'Employment Status Change Date',NULL,NULL,'"drvEmploymentStatusChangDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ENYAIG403BZ0','50','D','10','29',NULL,'Location Code',NULL,NULL,'"drvLocationCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ENYAIG403BZ0','50','D','10','30',NULL,'HR Sub Area',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ENYAIG403BZ0','50','D','10','31',NULL,'Employee Job Type (Payroll Status Code)',NULL,NULL,'"drvEmployeeJobType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ENYAIG403BZ0','50','D','10','32',NULL,'Annual Base Salary',NULL,NULL,'"drvAnnualBaseSalary"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ENYAIG403BZ0','50','D','10','33',NULL,'Year-To-Date (YTD) Hours',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ENYAIG403BZ0','50','D','10','34',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ENYAIG403BZ0','50','D','10','35',NULL,'Agent Code(TPA Field)',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ENYAIG403BZ0','50','D','10','36',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ENYAIG403BZ0','50','D','10','37',NULL,'e-Delivery Flag',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ENYAIG403BZ0','50','D','10','38',NULL,'Employee Classification Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ENYAIG403BZ0','50','D','10','39',NULL,'Employee Classification Code Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ENYAIG403BZ0','50','D','10','40',NULL,'Employee Pay Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ENYAIG403BZ0','50','D','10','41',NULL,'Employee Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ENYAIG403BZ0','50','D','10','42',NULL,'Employment Status Location',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ENYAIG403BZ0','50','D','10','43',NULL,'Employment Sub Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ENYAIG403BZ0','50','D','10','44',NULL,'Excluded Class Type',NULL,NULL,'"drvExcludedClassType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ENYAIG403BZ0','50','D','10','45',NULL,'Highly Compensated Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ENYAIG403BZ0','50','D','10','46',NULL,'HR Area',NULL,NULL,'"drvHRArea"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ENYAIG403BZ0','50','D','10','47',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ENYAIG403BZ0','50','D','10','48',NULL,'Key Employee Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ENYAIG403BZ0','50','D','10','49',NULL,'Non Resident Alien',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ENYAIG403BZ0','50','D','10','50',NULL,'Officer Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ENYAIG403BZ0','50','D','10','51',NULL,'Owner Code',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ENYAIG403BZ0','50','D','10','52',NULL,'Owner Percent',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ENYAIG403BZ0','50','D','10','53',NULL,'Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ENYAIG403BZ0','50','D','10','54',NULL,'Plan Participant Status',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ENYAIG403BZ0','50','D','10','55',NULL,'Plan Participant Status Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ENYAIG403BZ0','50','D','10','56',NULL,'Prior EID',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ENYAIG403BZ0','50','D','10','57',NULL,'Provider ID',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ENYAIG403BZ0','50','D','10','58',NULL,'Relationship to Owner',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ENYAIG403BZ0','50','D','10','59',NULL,'Spouse Date of Birth',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ENYAIG403BZ0','50','D','10','60',NULL,'Sub Group',NULL,NULL,'"drvSubGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ENYAIG403BZ0','50','D','10','61',NULL,'Union Effective Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ENYAIG403BZ0','50','D','10','62',NULL,'Union ID',NULL,NULL,'"drvUnionID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ENYAIG403BZ0','50','D','10','63',NULL,'Union Indicator',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ENYAIG403BZ0','50','D','10','64',NULL,'Accumulated Months of Service',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ENYAIG403BZ0','50','D','10','65',NULL,'Adjusted Service Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ENYAIG403BZ0','50','D','10','66',NULL,'Date of Disability',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ENYAIG403BZ0','50','D','10','67',NULL,'Date of Termination',NULL,NULL,'"drvDateOfTermination"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ENYAIG403BZ0','50','D','10','68',NULL,'FTE(Full Time Equivalent)',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ENYAIG403BZ0','50','D','10','69',NULL,'Per Pay Period Hours',NULL,NULL,'"drvPayPeriodHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ENYAIG403BZ0','50','D','10','70',NULL,'Plan Compensation End Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ENYAIG403BZ0','50','D','10','71',NULL,'Plan Eligibility Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ENYAIG403BZ0','50','D','10','72',NULL,'Plan Participation Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ENYAIG403BZ0','50','D','10','73',NULL,'Plan Vesting Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ENYAIG403BZ0','50','D','10','74',NULL,'Date of Rehire',NULL,NULL,'"drvDateOfRehire"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ENYAIG403BZ0','50','D','10','75',NULL,'Years of Service',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ENYAIG403BZ0','50','D','10','76',NULL,'415 Compensation',NULL,NULL,'"drv415Compensation"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ENYAIG403BZ0','50','D','10','77',NULL,'415 Compensation End Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ENYAIG403BZ0','50','D','10','78',NULL,'Catch up Contribution Rate',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ENYAIG403BZ0','50','D','10','79',NULL,'Class CS 1(Excluded EE)',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ENYAIG403BZ0','50','D','10','80',NULL,'Class CS 2(Excluded EE)',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ENYAIG403BZ0','50','D','10','81',NULL,'Class CS 3(Excluded EE)',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ENYAIG403BZ0','50','D','10','82',NULL,'Class CS 4(Excluded EE)',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ENYAIG403BZ0','50','D','10','83',NULL,'Class CS 5(Excluded EE)',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ENYAIG403BZ0','50','D','10','84',NULL,'Contribution Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ENYAIG403BZ0','50','D','10','85',NULL,'Defined Benefit Compensation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ENYAIG403BZ0','50','D','10','86',NULL,'Defined Benefit Compensation (Bonus)',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ENYAIG403BZ0','50','D','10','87',NULL,'Defined Benefit Hours',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ENYAIG403BZ0','50','D','10','88',NULL,'Cont Eligibility Source 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ENYAIG403BZ0','50','D','10','89',NULL,'Cont Eligibility Date 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ENYAIG403BZ0','50','D','10','90',NULL,'Cont Eligibility Status Source 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ENYAIG403BZ0','50','D','10','91',NULL,'Cont Eligibility Source 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ENYAIG403BZ0','50','D','10','92',NULL,'Cont Eligibility Date 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ENYAIG403BZ0','50','D','10','93',NULL,'Cont Eligibility Status Source 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ENYAIG403BZ0','50','D','10','94',NULL,'Cont Eligibility Source 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ENYAIG403BZ0','50','D','10','95',NULL,'Cont Eligibility Date 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ENYAIG403BZ0','50','D','10','96',NULL,'Cont Eligibility Status Source 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ENYAIG403BZ0','50','D','10','97',NULL,'Cont Eligibility Source 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ENYAIG403BZ0','50','D','10','98',NULL,'Cont Eligibility Date 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ENYAIG403BZ0','50','D','10','99',NULL,'Cont Eligibility Status Source 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ENYAIG403BZ0','50','D','10','100',NULL,'Cont Eligibility Source 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ENYAIG403BZ0','50','D','10','101',NULL,'Cont Eligibility Date 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ENYAIG403BZ0','50','D','10','102',NULL,'Cont Eligibility Status Source 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ENYAIG403BZ0','50','D','10','103',NULL,'Employer Contribution Rate',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ENYAIG403BZ0','50','D','10','104',NULL,'Gross Compensation',NULL,NULL,'"drvGrossCompensation"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ENYAIG403BZ0','50','D','10','105',NULL,'Loan Repayment Amount 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ENYAIG403BZ0','50','D','10','106',NULL,'Loan ID 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ENYAIG403BZ0','50','D','10','107',NULL,'Loan Repayment Amount 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ENYAIG403BZ0','50','D','10','108',NULL,'Loan ID 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ENYAIG403BZ0','50','D','10','109',NULL,'Loan Repayment Amount 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','ENYAIG403BZ0','50','D','10','110',NULL,'Loan ID 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','ENYAIG403BZ0','50','D','10','111',NULL,'Loan Repayment Amount 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','ENYAIG403BZ0','50','D','10','112',NULL,'Loan ID 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','ENYAIG403BZ0','50','D','10','113',NULL,'Loan Repayment Amount 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','ENYAIG403BZ0','50','D','10','114',NULL,'Payroll Period Ending Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','ENYAIG403BZ0','50','D','10','115',NULL,'Pension Benefit Start Age',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','ENYAIG403BZ0','50','D','10','116',NULL,'Pension Monthly Benefits',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','ENYAIG403BZ0','50','D','10','117',NULL,'Plan Compensation',NULL,NULL,'"drvPlanCompensation"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','ENYAIG403BZ0','50','D','10','118',NULL,'Plan Excluded Compensation',NULL,NULL,'"drvPlanExcludedCompensation"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','ENYAIG403BZ0','50','D','10','119',NULL,'Vesting Source Name 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','ENYAIG403BZ0','50','D','10','120',NULL,'Vested Source Name Date 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','ENYAIG403BZ0','50','D','10','121',NULL,'Vesting Percentage 1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','ENYAIG403BZ0','50','D','10','122',NULL,'Vesting Source Name 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','ENYAIG403BZ0','50','D','10','123',NULL,'Vested Source Name Date 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','ENYAIG403BZ0','50','D','10','124',NULL,'Vesting Percentage 2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','ENYAIG403BZ0','50','D','10','125',NULL,'Vesting Source Name 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','ENYAIG403BZ0','50','D','10','126',NULL,'Vested Source Name Date 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','ENYAIG403BZ0','50','D','10','127',NULL,'Vesting Percentage 3',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','ENYAIG403BZ0','50','D','10','128',NULL,'Vesting Source Name 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','ENYAIG403BZ0','50','D','10','129',NULL,'Vested Source Name Date 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','ENYAIG403BZ0','50','D','10','130',NULL,'Vesting Percentage 4',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','ENYAIG403BZ0','50','D','10','131',NULL,'Vesting Source Name 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','ENYAIG403BZ0','50','D','10','132',NULL,'Vested Source Name Date 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','ENYAIG403BZ0','50','D','10','133',NULL,'Vesting Percentage 5',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','ENYAIG403BZ0','50','D','10','134',NULL,'Primary Location Code',NULL,NULL,'"Y"','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ENYAIG403B_20221103.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'AIG 403b Combined Export','202210149','EMPEXPORT','ONDEM_XOE',NULL,'ENYAIG403B',NULL,NULL,NULL,'202210149','Oct 24 2022  1:44PM','Oct 24 2022  1:44PM','202210141',NULL,'','','202210141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202210149','EMPEXPORT','SCH_BIWKLY',NULL,'ENYAIG403B',NULL,NULL,NULL,'202210149','Oct 24 2022  1:44PM','Oct 24 2022  1:44PM','202210141',NULL,'','','202210141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202210149','EMPEXPORT','SCH_WKLY',NULL,'ENYAIG403B',NULL,NULL,NULL,'202210149','Oct 24 2022  1:44PM','Oct 24 2022  1:44PM','202210141',NULL,'','','202210141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','202210149','EMPEXPORT','TEST_XOE',NULL,'ENYAIG403B',NULL,NULL,NULL,'202210149','Oct 24 2022  1:44PM','Oct 24 2022  1:44PM','202210141',NULL,'','','202210141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYAIG403B','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYAIG403B','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYAIG403B','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYAIG403B','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYAIG403B','UDESPath','C','\\us.saas\0\data_exchange\\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENYAIG403B','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENYAIG403B','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENYAIG403B','D10','dbo.U_ENYAIG403B_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ENYAIG403B
-----------

IF OBJECT_ID('U_dsi_BDM_ENYAIG403B') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ENYAIG403B] (
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
-- Create table U_ENYAIG403B_Audit
-----------

IF OBJECT_ID('U_ENYAIG403B_Audit') IS NULL
CREATE TABLE [dbo].[U_ENYAIG403B_Audit] (
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
-- Create table U_ENYAIG403B_AuditFields
-----------

IF OBJECT_ID('U_ENYAIG403B_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ENYAIG403B_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ENYAIG403B_DedList
-----------

IF OBJECT_ID('U_ENYAIG403B_DedList') IS NULL
CREATE TABLE [dbo].[U_ENYAIG403B_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ENYAIG403B_drvTbl
-----------

IF OBJECT_ID('U_ENYAIG403B_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ENYAIG403B_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvParticipantFirstName] varchar(100) NULL,
    [drvParticipantMiddleName] varchar(50) NULL,
    [drvParticipantLastName] varchar(100) NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvStateCountryCode] varchar(255) NULL,
    [EepAddressZipCode] varchar(50) NULL,
    [drvZip] nvarchar(4000) NULL,
    [drvPayrollFrequencycode] varchar(2) NOT NULL,
    [drvPayrolDate] datetime NULL,
    [drvEEElectivePretax] varchar(30) NULL,
    [drvERNonMatching] varchar(30) NULL,
    [drvERMatching] varchar(30) NULL,
    [drvRoth] varchar(30) NULL,
    [drvLoanPayments] varchar(30) NULL,
    [drvBirthdate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvPhone] varchar(50) NULL,
    [drvGenderID] char(1) NULL,
    [drvMaritalstatus] char(1) NULL,
    [drvEmploymentStatus] varchar(1) NULL,
    [drvEmploymentStatusChangDate] nvarchar(4000) NULL,
    [drvLocationCode] varchar(4) NOT NULL,
    [drvEmployeeJobType] varchar(2) NOT NULL,
    [drvAnnualBaseSalary] varchar(30) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvExcludedClassType] varchar(5) NOT NULL,
    [drvHRArea] varchar(4) NOT NULL,
    [drvJobTitle] varchar(25) NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvSubGroup] varchar(4) NOT NULL,
    [drvUnionID] varchar(12) NULL,
    [drvDateOfTermination] datetime NULL,
    [drvPayPeriodHours] varchar(30) NULL,
    [drvDateOfRehire] nvarchar(4000) NULL,
    [drv415Compensation] varchar(30) NULL,
    [drvGrossCompensation] varchar(30) NULL,
    [drvPlanCompensation] varchar(30) NULL,
    [drvPlanExcludedCompensation] varchar(30) NULL
);

-----------
-- Create table U_ENYAIG403B_EEList
-----------

IF OBJECT_ID('U_ENYAIG403B_EEList') IS NULL
CREATE TABLE [dbo].[U_ENYAIG403B_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ENYAIG403B_File
-----------

IF OBJECT_ID('U_ENYAIG403B_File') IS NULL
CREATE TABLE [dbo].[U_ENYAIG403B_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_ENYAIG403B_PDedHist
-----------

IF OBJECT_ID('U_ENYAIG403B_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ENYAIG403B_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh403BNEECurAMT] numeric NULL,
    [Pdh403BUEECurAMT] numeric NULL,
    [Pdh403NDEECurAMT] numeric NULL,
    [Pdh403UDEECurAMT] numeric NULL,
    [Pdh403BDEECurAMT] numeric NULL,
    [Pdh403DDEECurAMT] numeric NULL,
    [Pdh403BVEECurAMT] numeric NULL,
    [Pdh403VDEECurAMT] numeric NULL,
    [Pdh403BHEECurAMT] numeric NULL,
    [Pdh403HDEECurAMT] numeric NULL,
    [Pdh403BCEECurAMT] numeric NULL,
    [Pdh403SHERCurAMT] numeric NULL,
    [PdhKPERCurAMT] numeric NULL,
    [Pdh403MERCurAMT] numeric NULL,
    [Pdh403MUERCurAMT] numeric NULL,
    [Pdh403RFEECurAMT] numeric NULL,
    [Pdh403RPEECurAMT] numeric NULL,
    [Pdh403RCEECurAMT] numeric NULL,
    [Pdh403RUEECurAMT] numeric NULL,
    [PdhRPLN1EECurAMT] numeric NULL,
    [PdhRPLN2EECurAMT] numeric NULL,
    [PdhRPLN3EECurAMT] numeric NULL,
    [PdhRPLN4EECurAMT] numeric NULL,
    [PdhRPLN5EECurAMT] numeric NULL,
    [PdhRPLU1EECurAMT] numeric NULL,
    [PdhRPLU2EECurAMT] numeric NULL,
    [PdhRPLU3EECurAMT] numeric NULL,
    [PdhRPLU5EECurAMT] numeric NULL,
    [PdhRPLU4EECurAMT] numeric NULL
);

-----------
-- Create table U_ENYAIG403B_PDedHistTotals
-----------

IF OBJECT_ID('U_ENYAIG403B_PDedHistTotals') IS NULL
CREATE TABLE [dbo].[U_ENYAIG403B_PDedHistTotals] (
    [PdhTEEID] char(12) NOT NULL,
    [PdtEETotals] numeric NULL,
    [PdtERTtotals] numeric NULL
);

-----------
-- Create table U_ENYAIG403B_PEarHist
-----------

IF OBJECT_ID('U_ENYAIG403B_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ENYAIG403B_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPayFrequency] char(1) NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENYAIG403B]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: NYSARC Inc

Created By: Roger Bynum
Business Analyst: Lea King
Create Date: 10/24/2022
Service Request Number: SR-2016-00012345

Purpose: AIG 403b Combined Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENYAIG403B';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENYAIG403B';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENYAIG403B';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENYAIG403B';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENYAIG403B' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENYAIG403B', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENYAIG403B', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENYAIG403B', 'SCH_WKLY';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENYAIG403B', 'SCH_BI-WKLY';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENYAIG403B';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ENYAIG403B', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ENYAIG403B';

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
    DELETE FROM dbo.U_ENYAIG403B_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENYAIG403B_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Cleans EE List of Test Employees
    DELETE FROM dbo.U_ENYAIG403B_EEList 
    WHERE xEEID IN
    (SELECT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES','INT','VOL','BOD'))


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ENYAIG403B_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ENYAIG403B_AuditFields;
    CREATE TABLE dbo.U_ENYAIG403B_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ENYAIG403B_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ENYAIG403B_Audit;
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
    INTO dbo.U_ENYAIG403B_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ENYAIG403B_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ENYAIG403B_Audit ON dbo.U_ENYAIG403B_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_ENYAIG403B_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ENYAIG403B_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '403BN, 403BU,403ND, 403UD,403BD,403DD,403BV,403VD,403BH,403HD,403BC,403SH,KP,403M,403MU,403RF,403RP,403RC,403RU,RPLN1, RPLN2, RPLN3, RPLN4, RPLN5, RPLU1, RPLU2, RPLU3, RPLU5, RPLU4';

    IF OBJECT_ID('U_ENYAIG403B_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENYAIG403B_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ENYAIG403B_DedList
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
    IF OBJECT_ID('U_ENYAIG403B_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENYAIG403B_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        --Elective Pre-tax
        ,Pdh403BNEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403BN') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403BUEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403BU') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403NDEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403ND') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403UDEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403UD') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403BDEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403BD') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403DDEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403DD') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403BVEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403BV') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403VDEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403VD') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403BHEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403BH') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403HDEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403HD') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403BCEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403BC') THEN PdhEECurAmt ELSE 0.00 END)
        --ER NON-Matching
        ,Pdh403SHERCurAMT    = SUM(CASE WHEN PdhDedCode IN ('403SH') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhKPERCurAMT         = SUM(CASE WHEN PdhDedCode IN ('KP') THEN PdhERCurAmt ELSE 0.00 END)
        --Matching
        ,Pdh403MERCurAMT    = SUM(CASE WHEN PdhDedCode IN ('403M') THEN PdhERCurAmt ELSE 0.00 END)
        ,Pdh403MUERCurAMT    = SUM(CASE WHEN PdhDedCode IN ('403MU') THEN PdhERCurAmt ELSE 0.00 END)
        --Roth
        ,Pdh403RFEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403RF') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403RPEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403RP') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403RCEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403RC') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403RUEECurAMT    = SUM(CASE WHEN PdhDedCode IN ('403RU') THEN PdhEECurAmt ELSE 0.00 END)
        --Loan Payments
        ,PdhRPLN1EECurAMT    = SUM(CASE WHEN PdhDedCode IN ('RPLN1') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRPLN2EECurAMT    = SUM(CASE WHEN PdhDedCode IN ('RPLN2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRPLN3EECurAMT    = SUM(CASE WHEN PdhDedCode IN ('RPLN3') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRPLN4EECurAMT    = SUM(CASE WHEN PdhDedCode IN ('RPLN4') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRPLN5EECurAMT    = SUM(CASE WHEN PdhDedCode IN ('RPLN5') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRPLU1EECurAMT    = SUM(CASE WHEN PdhDedCode IN ('RPLU1') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRPLU2EECurAMT    = SUM(CASE WHEN PdhDedCode IN ('RPLU2') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRPLU3EECurAMT    = SUM(CASE WHEN PdhDedCode IN ('RPLU3') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRPLU5EECurAMT    = SUM(CASE WHEN PdhDedCode IN ('RPLU5') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRPLU4EECurAMT    = SUM(CASE WHEN PdhDedCode IN ('RPLU4') THEN PdhEECurAmt ELSE 0.00 END)

    INTO dbo.U_ENYAIG403B_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ENYAIG403B_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

        -----------------------------
    -- Working Table - PDedHistTotals
    -----------------------------
    IF OBJECT_ID('U_ENYAIG403B_PDedHistTotals','U') IS NOT NULL
        DROP TABLE dbo.U_ENYAIG403B_PDedHistTotals;
    SELECT DISTINCT 
    PdhEEID AS PdhTEEID, 
    Pdh403BNEECurAMT + 
    Pdh403BUEECurAMT +
    Pdh403NDEECurAMT +
    Pdh403UDEECurAMT +
    Pdh403BDEECurAMT +
    Pdh403DDEECurAMT +
    Pdh403BVEECurAMT +
    Pdh403VDEECurAMT +
    Pdh403BHEECurAMT +
    Pdh403HDEECurAMT +
    Pdh403BCEECurAMT +
    Pdh403RFEECurAMT +
    Pdh403RPEECurAMT +
    Pdh403RCEECurAMT +
    Pdh403RUEECurAMT +
    PdhRPLN1EECurAMT +
    PdhRPLN2EECurAMT +
    PdhRPLN3EECurAMT +
    PdhRPLN4EECurAMT +
    PdhRPLN5EECurAMT +
    PdhRPLU1EECurAMT +
    PdhRPLU2EECurAMT +
    PdhRPLU3EECurAMT +
    PdhRPLU5EECurAMT +
    PdhRPLU4EECurAMT
    AS PdtEETotals,

    Pdh403SHERCurAMT +
    PdhKPERCurAMT    +
    Pdh403MERCurAMT  +
    Pdh403MUERCurAMT
    AS PdtERTtotals
    INTO dbo.U_ENYAIG403B_PDedHistTotals
    FROM dbo.U_ENYAIG403B_PDedHist WITH (NOLOCK);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ENYAIG403B_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENYAIG403B_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPayFrequency        = MAX(PgrPayFrequency)
        -- Current Payroll Amount/Hours
        --,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        --,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnInclInDefCompHrs = 'Y' THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnInclInDefCompHrs = 'Y' THEN PehCurHrs ELSE 0.00 END)


        ,PehCurAmt              = SUM(CASE WHEN ErnInclInDefCompHrs = 'Y' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs                = SUM(CASE WHEN ErnInclInDefCompHrs = 'Y' THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ENYAIG403B_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.Earncode WITH (NOLOCK)
        ON PehEarnCode = ErnEarnCode
    JOIN dbo.PayGroup WITH(NOLOCK)
        ON PrgPayGroup = PgrPayGroup
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ENYAIG403B_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ENYAIG403B_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENYAIG403B_drvTbl;
 SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvParticipantFirstName = EepNameFirst
        ,drvParticipantMiddleName = EepNameMiddle-- LEFT(EepNameMiddle,1)
        ,drvParticipantLastName = EepNameLast
        ,drvAddress1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddress2 = REPLACE(EepAddressLine2, ',', '')
        ,drvCity = REPLACE(EepAddressCity, ',', '')
        ,drvStateCountryCode = EepAddressState
        ,EepAddressZipCode
        ,drvZip = FORMAT(CAST(EepAddressZipCode AS INT), '000000000')
        ,drvPayrollFrequencycode = CASE WHEN PrgPayFrequency = 'B' THEN 'BW' ELSE 'WE' END
        ,drvPayrolDate = CASE WHEN Prgpaydate BETWEEN @StartDate AND @EndDate THEN Prgpaydate
                              ELSE (SELECT PgrPayDate FROM PayGroup WITH (NOLOCK) WHERE PgrPayGroup = EecPayGroup)    
                         END
        ,drvEEElectivePretax = CASE WHEN ElectiveCurAmt IS NOT NULL THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (ElectiveCurAmt as money) *100,7,0)) ELSE '0000000' END
        ,drvERNonMatching = CASE WHEN ERNonMatchAmt IS NOT NULL THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (ERNonMatchAmt as money )*100,7,0)) ELSE '0000000' END
        ,drvERMatching = CASE WHEN ERMatchAmt IS NOT NULL THEN  CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (ERMatchAmt as money )*100,7,0)) ELSE '0000000' END
        ,drvRoth = CASE WHEN RothAmt IS NOT NULL THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST(RothAmt as money )* 100, 7, 0)) ELSE '0000000' END 
        ,drvLoanPayments = CASE WHEN LoanCurAmt IS NOT NULL THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST(LoanCurAmt as money )*100,7,0)) ELSE '0000000' END
        ,drvBirthdate = EepDateOfBirth
        ,drvHireDate = EecDateOfLastHire
        ,drvPhone = EepPhoneHomeNumber
        ,drvGenderID = EepGender
        ,drvMaritalstatus = eepMaritalStatus
        ,drvEmploymentStatus = CASE WHEN  eecemplstatus IN ('T','L') THEN eecemplstatus ELSE 'A' END
        ,drvEmploymentStatusChangDate = CASE WHEN eecemplstatus = 'T' THEN FORMAT(eecdateoftermination, 'MMddyyyy')
                                             WHEN ejhreason = '101' AND EecDateOfOriginalHire <> EecDateOfLastHire  AND EecDateOfLastHire BETWEEN @StartDate and @EndDate THEN FORMAT(EecDateOfLastHire, 'MMddyyyy')
                                             ELSE ''
                                        END
        ,drvLocationCode = CASE WHEN  EecUnionLocal IS NOT NULL OR  EecUnionNational IS NOT NULL THEN '0002' ELSE '0001' END
        ,drvEmployeeJobType = CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' ELSE 'FT' END
        ,drvAnnualBaseSalary = CASE WHEN EecAnnSalary IS NOT NULL THEN CONVERT(VARCHAR,dbo.dsi_fnPadZero(EecAnnSalary*100,10,0))  ELSE '0000000' END
        ,drvEmailAddress = CASE WHEN ISNULL(eepAddressEMail,'') <> '' THEN eepAddressEMail ELSE  eepAddressEMailalternate END
        ,drvExcludedClassType = CASE WHEN EecEEType = 'DLR' THEN 'NBENE' ELSE '' END
        ,drvHRArea = CASE WHEN EecUnionLocal IS NULL OR EecUnionNational IS NOT NULL THEN '0002' ELSE '0001' END
        ,drvJobTitle = (SELECT JbcDesc FROM dbo.JobCode WITH (NOLOCK)  WHERE JbcJobCode = EecJobCode)
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvSubGroup = CASE WHEN EecUnionLocal IS NOT NULL OR EecUnionNational IS NOT NULL THEN '0002' ELSE '0001' END
        ,drvUnionID = CASE WHEN  EecUnionLocal IS NOT NULL THEN EecUnionLocal WHEN EecUnionNational IS NOT NULL THEN EecUnionNational ELSE '' END
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvPayPeriodHours = CONVERT(VARCHAR,dbo.dsi_fnPadZero(PehInclInDefCompHrs*100,7,0))
        ,drvDateOfRehire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN FORMAT(EecDateOfLastHire, 'MMddyyyy') ELSE '' END
        ,drv415Compensation = CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (PehCurAmt as money)*100,10,0))
        ,drvGrossCompensation = CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (PehCurAmt as money)*100,10,0))
        ,drvPlanCompensation = CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (PehCurAmt as money)*100,10,0))
        ,drvPlanExcludedCompensation = CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (PehCurAmt as money)*100,10,0))
    INTO dbo.U_ENYAIG403B_drvTbl
    FROM dbo.U_ENYAIG403B_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    --JOIN dbo.U_dsi_BDM_ENYAIG403B WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    --JOIN dbo.PayGroup WITH (NOLOCK)
    --    ON PgrPayGroup = EecPayGroup
    LEFT JOIN (SELECT PdhEEID AS EaEEID, 
                CAST(Pdh403BNEECurAMT
                + Pdh403BUEECurAMT
                + Pdh403NDEECurAMT
                + Pdh403UDEECurAMT
                + Pdh403BDEECurAMT
                + Pdh403DDEECurAMT
                + Pdh403BVEECurAMT
                + Pdh403VDEECurAMT
                + Pdh403BHEECurAMT
                + Pdh403HDEECurAMT
                + Pdh403BCEECurAMT AS VARCHAR)AS ElectiveCurAmt
                FROM dbo.U_ENYAIG403B_PDedHist) AS PdhElectFlattened
        ON EaEEID = xEEID
    LEFT JOIN (SELECT PdhEEID AS NMEEID, 
                CAST(Pdh403SHERCurAMT + PdhKPERCurAMT
                 AS VARCHAR)AS ERNonMatchAmt
                FROM dbo.U_ENYAIG403B_PDedHist) AS PdhNonMatchFlattened
        ON NMEEID = xEEID
    LEFT JOIN (SELECT PdhEEID AS MEEID, 
                CAST(Pdh403MERCurAMT + Pdh403MUERCurAMT
                 AS VARCHAR) AS ERMatchAmt
                FROM dbo.U_ENYAIG403B_PDedHist) AS PdhMatchFlattened
        ON MEEID = xEEID
    LEFT JOIN (SELECT PdhEEID AS RoEEID, 
                CAST(Pdh403RFEECurAmt
                + Pdh403RPEECurAMT
                + Pdh403RCEECurAMT
                + Pdh403RUEECurAMT
                 AS VARCHAR)AS RothAmt
                FROM dbo.U_ENYAIG403B_PDedHist) AS PdhRothflattened
        ON RoEEID = xEEID
    LEFT JOIN (SELECT PdhEEID AS LpEEID, 
                CAST(PdhRPLN1EECurAmt
                + PdhRPLN2EECurAMT
                + PdhRPLN3EECurAMT
                + PdhRPLN4EECurAMT
                + PdhRPLN5EECurAMT
                + PdhRPLU1EECurAMT
                + PdhRPLU2EECurAMT
                + PdhRPLU3EECurAMT
                + PdhRPLU5EECurAMT
                + PdhRPLU4EECurAMT
                 AS VARCHAR)AS LoanCurAmt
                FROM dbo.U_ENYAIG403B_PDedHist) AS PdhLoanPFlattened
        ON LpEEID = xEEID
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK) 
        ON EjhEEID = xEEID 
    LEFT JOIN dbo.U_ENYAIG403B_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_ENYAIG403B_PDedHistTotals WITH (NOLOCK)
        ON PdhTEEID = xEEID
    WHERE EecEmplStatus <> 'T' 
          OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate            
          OR ISNULL(pdtEETotals,0.00) <> 0.00 OR ISNULL(PdtERTtotals,0.00) <> 0.00 )  -- Do not exclude if terms with Deductions
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwENYAIG403B_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENYAIG403B_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ENYAIG403B%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202210141'
       ,expStartPerControl     = '202210141'
       ,expLastEndPerControl   = '202210149'
       ,expEndPerControl       = '202210149'
WHERE expFormatCode = 'ENYAIG403B';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENYAIG403B_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENYAIG403B_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ENYAIG403B' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ENYAIG403B'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ENYAIG403B'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENYAIG403B', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ENYAIG403B', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ENYAIG403B', 'UseFileName', 'V', 'Y'


-- End ripout