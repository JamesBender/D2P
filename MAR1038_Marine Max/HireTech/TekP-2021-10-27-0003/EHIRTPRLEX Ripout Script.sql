/**********************************************************************************

EHIRTPRLEX: HireTech Payroll Export

FormatCode:     EHIRTPRLEX
Project:        HireTech Payroll Export
Client ID:      MAR1038
Date/time:      2022-07-22 08:17:44.483
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP6DB01
Database:       ULTIPRO_WPMAMI
Web Filename:   MAR1038_HNG12_EEHISTORY_EHIRTPRLEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EHIRTPRLEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EHIRTPRLEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EHIRTPRLEX'


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
WHERE FormatCode = 'EHIRTPRLEX'
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
WHERE ExpFormatCode = 'EHIRTPRLEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EHIRTPRLEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EHIRTPRLEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EHIRTPRLEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EHIRTPRLEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EHIRTPRLEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EHIRTPRLEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EHIRTPRLEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EHIRTPRLEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EHIRTPRLEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EHIRTPRLEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEHIRTPRLEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHIRTPRLEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHIRTPRLEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHIRTPRLEX];
GO
IF OBJECT_ID('U_EHIRTPRLEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHIRTPRLEX_PEarHist];
GO
IF OBJECT_ID('U_EHIRTPRLEX_File') IS NOT NULL DROP TABLE [dbo].[U_EHIRTPRLEX_File];
GO
IF OBJECT_ID('U_EHIRTPRLEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHIRTPRLEX_EEList];
GO
IF OBJECT_ID('U_EHIRTPRLEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHIRTPRLEX_drvTbl];
GO
IF OBJECT_ID('U_EHIRTPRLEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EHIRTPRLEX_AuditFields];
GO
IF OBJECT_ID('U_EHIRTPRLEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHIRTPRLEX_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHIRTPRLEX','HireTech Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EHIRTPRLEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHIRTPRLEXZ0','50','H','01','1',NULL,'Payroll Location ID',NULL,NULL,'"Payroll Location ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHIRTPRLEXZ0','50','H','01','2',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHIRTPRLEXZ0','50','H','01','3',NULL,'FEIN',NULL,NULL,'"FEIN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHIRTPRLEXZ0','50','H','01','4',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHIRTPRLEXZ0','50','H','01','5',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHIRTPRLEXZ0','50','H','01','6',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHIRTPRLEXZ0','50','H','01','7',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHIRTPRLEXZ0','50','H','01','8',NULL,'Home Address (1)',NULL,NULL,'"Home Address (1)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHIRTPRLEXZ0','50','H','01','9',NULL,'Home Address (2)',NULL,NULL,'"Home Address (2)"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHIRTPRLEXZ0','50','H','01','10',NULL,'Home City',NULL,NULL,'"Home City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHIRTPRLEXZ0','50','H','01','11',NULL,'Home State',NULL,NULL,'"Home State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHIRTPRLEXZ0','50','H','01','12',NULL,'Home Zip',NULL,NULL,'"Home Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHIRTPRLEXZ0','50','H','01','13',NULL,'Original Hire Date',NULL,NULL,'"Original Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHIRTPRLEXZ0','50','H','01','14',NULL,'Most Recent Hire Date',NULL,NULL,'"Most Recent Hire Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHIRTPRLEXZ0','50','H','01','15',NULL,'Term Date',NULL,NULL,'"Term Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHIRTPRLEXZ0','50','H','01','16',NULL,'Most Recent Term Date',NULL,NULL,'"Most Recent Term Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHIRTPRLEXZ0','50','H','01','17',NULL,'Employment Status',NULL,NULL,'"Employment Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHIRTPRLEXZ0','50','H','01','18',NULL,'Employment Type',NULL,NULL,'"Employment Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHIRTPRLEXZ0','50','H','01','19',NULL,'Separation Code',NULL,NULL,'"Separation Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHIRTPRLEXZ0','50','H','01','20',NULL,'Separation Reason',NULL,NULL,'"Separation Reason"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHIRTPRLEXZ0','50','H','01','21',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHIRTPRLEXZ0','50','H','01','22',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHIRTPRLEXZ0','50','H','01','23',NULL,'Check Date',NULL,NULL,'"Check Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHIRTPRLEXZ0','50','H','01','24',NULL,'Pay Start Date',NULL,NULL,'"Pay Start Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHIRTPRLEXZ0','50','H','01','25',NULL,'Pay End Date',NULL,NULL,'"Pay End Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHIRTPRLEXZ0','50','H','01','26',NULL,'Gross Hours',NULL,NULL,'"Gross Hours"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHIRTPRLEXZ0','50','H','01','27',NULL,'Gross Wages',NULL,NULL,'"Gross Wages"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHIRTPRLEXZ0','50','H','01','28',NULL,'Regular Wages',NULL,NULL,'"Regular Wages"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHIRTPRLEXZ0','50','H','01','29',NULL,'Overtime Wages',NULL,NULL,'"Overtime Wages"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHIRTPRLEXZ0','50','H','01','30',NULL,'Bonus Wages',NULL,NULL,'"Bonus Wages"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHIRTPRLEXZ0','50','H','01','31',NULL,'Commission Wages',NULL,NULL,'"Commission Wages"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHIRTPRLEXZ0','50','H','01','32',NULL,'Tip Income',NULL,NULL,'"Tip Income"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHIRTPRLEXZ0','50','H','01','33',NULL,'Other Wages',NULL,NULL,'"Other Wages"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHIRTPRLEXZ0','50','H','01','34',NULL,'Pay Rate',NULL,NULL,'"Pay Rate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHIRTPRLEXZ0','50','H','01','35',NULL,'Pay Rate Frequency',NULL,NULL,'"Pay Rate Frequency"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHIRTPRLEXZ0','50','H','01','36',NULL,'Pay Frequency',NULL,NULL,'"Pay Frequency"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EHIRTPRLEXZ0','50','D','10','1',NULL,'Payroll Location ID',NULL,NULL,'"drvPayrollLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EHIRTPRLEXZ0','50','D','10','2',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EHIRTPRLEXZ0','50','D','10','3',NULL,'FEIN',NULL,NULL,'"drvFEIN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EHIRTPRLEXZ0','50','D','10','4',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EHIRTPRLEXZ0','50','D','10','5',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EHIRTPRLEXZ0','50','D','10','6',NULL,'Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EHIRTPRLEXZ0','50','D','10','7',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EHIRTPRLEXZ0','50','D','10','8',NULL,'Home Address (1)',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EHIRTPRLEXZ0','50','D','10','9',NULL,'Home Address (2)',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EHIRTPRLEXZ0','50','D','10','10',NULL,'Home City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EHIRTPRLEXZ0','50','D','10','11',NULL,'Home State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EHIRTPRLEXZ0','50','D','10','12',NULL,'Home Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EHIRTPRLEXZ0','50','D','10','13',NULL,'Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EHIRTPRLEXZ0','50','D','10','14',NULL,'Most Recent Hire Date',NULL,NULL,'"drvMostRecentHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EHIRTPRLEXZ0','50','D','10','15',NULL,'Term Date',NULL,NULL,'"drvTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EHIRTPRLEXZ0','50','D','10','16',NULL,'Most Recent Term Date',NULL,NULL,'"drvMostRecentTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EHIRTPRLEXZ0','50','D','10','17',NULL,'Employment Status',NULL,NULL,'"drvEmployementStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EHIRTPRLEXZ0','50','D','10','18',NULL,'Employment Type',NULL,NULL,'"drvEmploymentType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EHIRTPRLEXZ0','50','D','10','19',NULL,'Separation Code',NULL,NULL,'"drvSeperationCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EHIRTPRLEXZ0','50','D','10','20',NULL,'Separation Reason',NULL,NULL,'"drvSeperationReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EHIRTPRLEXZ0','50','D','10','21',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EHIRTPRLEXZ0','50','D','10','22',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EHIRTPRLEXZ0','50','D','10','23',NULL,'Check Date',NULL,NULL,'"drvCheckDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EHIRTPRLEXZ0','50','D','10','24',NULL,'Pay Start Date',NULL,NULL,'"drvPayStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EHIRTPRLEXZ0','50','D','10','25',NULL,'Pay End Date',NULL,NULL,'"drvPayEndDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EHIRTPRLEXZ0','50','D','10','26',NULL,'Gross Hours',NULL,NULL,'"drvGrossHours"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EHIRTPRLEXZ0','50','D','10','27',NULL,'Gross Wages',NULL,NULL,'"drvGrossWages"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EHIRTPRLEXZ0','50','D','10','28',NULL,'Regular Wages',NULL,NULL,'"drvRegularWages"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EHIRTPRLEXZ0','50','D','10','29',NULL,'Overtime Wages',NULL,NULL,'"drvOvertimeWages"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EHIRTPRLEXZ0','50','D','10','30',NULL,'Bonus Wages',NULL,NULL,'"drvBonusWages"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EHIRTPRLEXZ0','50','D','10','31',NULL,'Commission Wages',NULL,NULL,'"drvCommissionWages"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EHIRTPRLEXZ0','50','D','10','32',NULL,'Tip Income',NULL,NULL,'"drvTipIncome"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EHIRTPRLEXZ0','50','D','10','33',NULL,'Other Wages',NULL,NULL,'"drvOtherWages"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EHIRTPRLEXZ0','50','D','10','34',NULL,'Pay Rate',NULL,NULL,'"drvPayRate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EHIRTPRLEXZ0','50','D','10','35',NULL,'Pay Rate Frequency',NULL,NULL,'"drvPayRateFrequency"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EHIRTPRLEXZ0','50','D','10','36',NULL,'Pay Frequency',NULL,NULL,'"drvPayFrequency"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EHIRTPRLEX_20220722.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'HireTech Payroll Export','202202259','EMPEXPORT','ONDEM_XOE','Mar  4 2022  3:34AM','EHIRTPRLEX',NULL,NULL,NULL,'202202259','Feb 25 2022  9:47AM','Feb 25 2022  9:47AM','202202251','1088','','','202202251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'HireTech Payroll Export-Sched','202202259','EMPEXPORT','SCH_EHIRTP','Mar  4 2022  3:35AM','EHIRTPRLEX',NULL,NULL,NULL,'202202259','Feb 25 2022  9:47AM','Feb 25 2022  9:47AM','202202251','1088','','','202202251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',V6QVS',NULL,NULL,NULL,'HireTech Payroll Export-Test','202207069','EMPEXPORT','TEST_XOE','Apr 22 2022 12:25PM','EHIRTPRLEX',NULL,NULL,NULL,'202207069','Apr 22 2022 12:00AM','Dec 30 1899 12:00AM','202204081','2215','','','202204081',dbo.fn_GetTimedKey(),NULL,'us3lKiMAR1038',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIRTPRLEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIRTPRLEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIRTPRLEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIRTPRLEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIRTPRLEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHIRTPRLEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHIRTPRLEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHIRTPRLEX','D10','dbo.U_EHIRTPRLEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EHIRTPRLEX_Audit
-----------

IF OBJECT_ID('U_EHIRTPRLEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EHIRTPRLEX_Audit] (
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
-- Create table U_EHIRTPRLEX_AuditFields
-----------

IF OBJECT_ID('U_EHIRTPRLEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EHIRTPRLEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EHIRTPRLEX_drvTbl
-----------

IF OBJECT_ID('U_EHIRTPRLEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHIRTPRLEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(6) NULL,
    [drvPayrollLocation] char(6) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvFEIN] varchar(9) NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvMostRecentHireDate] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvMostRecentTermDate] datetime NULL,
    [drvEmployementStatus] char(1) NULL,
    [drvEmploymentType] varchar(9) NULL,
    [drvSeperationCode] char(6) NULL,
    [drvSeperationReason] char(6) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvCheckDate] datetime NULL,
    [drvPayStartDate] datetime NULL,
    [drvPayEndDate] datetime NULL,
    [drvGrossHours] nvarchar(4000) NULL,
    [drvGrossWages] nvarchar(4000) NULL,
    [drvRegularWages] nvarchar(4000) NULL,
    [drvOvertimeWages] nvarchar(4000) NULL,
    [drvBonusWages] nvarchar(4000) NULL,
    [drvCommissionWages] nvarchar(4000) NULL,
    [drvTipIncome] nvarchar(4000) NULL,
    [drvOtherWages] nvarchar(4000) NULL,
    [drvPayRate] nvarchar(4000) NULL,
    [drvPayRateFrequency] varchar(6) NOT NULL,
    [drvPayFrequency] varchar(12) NULL
);

-----------
-- Create table U_EHIRTPRLEX_EEList
-----------

IF OBJECT_ID('U_EHIRTPRLEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EHIRTPRLEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EHIRTPRLEX_File
-----------

IF OBJECT_ID('U_EHIRTPRLEX_File') IS NULL
CREATE TABLE [dbo].[U_EHIRTPRLEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EHIRTPRLEX_PEarHist
-----------

IF OBJECT_ID('U_EHIRTPRLEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHIRTPRLEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL,
    [PehCurAmtReg] numeric NULL,
    [PehCurAmtOT] numeric NULL,
    [PehCurAmtBon] numeric NULL,
    [PehCurAmtCom] numeric NULL,
    [PehCurAmtTip] numeric NULL,
    [PehCurAmtOth] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHIRTPRLEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Marine Max

Created By: James Bender
Business Analyst: Curlin Beck
Create Date: 02/25/2022
Service Request Number: TekP-2021-10-27-0003

Purpose: HireTech Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHIRTPRLEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHIRTPRLEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHIRTPRLEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHIRTPRLEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHIRTPRLEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHIRTPRLEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHIRTPRLEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHIRTPRLEX', 'SCH_EHIRTP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EHIRTPRLEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EHIRTPRLEX';

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
    DELETE FROM dbo.U_EHIRTPRLEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHIRTPRLEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE dbo.U_EHIRTPRLEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES','CON')
    )

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EHIRTPRLEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EHIRTPRLEX_AuditFields;
    CREATE TABLE dbo.U_EHIRTPRLEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EHIRTPRLEX_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EHIRTPRLEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHIRTPRLEX_Audit;
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
    INTO dbo.U_EHIRTPRLEX_Audit
    FROM dbo.U_EHIRTPRLEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EHIRTPRLEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND audNewValue = 'T' 
    ;


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EHIRTPRLEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHIRTPRLEX_PEarHist;
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
        -- Custom
        ,PehCurAmtReg              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnReportCategory = 'REG' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtOT               = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnReportCategory = 'OT' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtBon              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnReportCategory = 'BON' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtCom              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnReportCategory = 'COM' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtTip              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnReportCategory = 'TIP' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtOth              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND ErnReportCategory = 'OTH' THEN PehCurAmt ELSE 0.00 END)
    INTO dbo.U_EHIRTPRLEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
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
    -- DETAIL RECORD - U_EHIRTPRLEX_drvTbl
    ---------------------------------

    DECLARE @FedTaxId VARCHAR(9) = (SELECT CmmFedTaxId FROM CompMast);

    IF OBJECT_ID('U_EHIRTPRLEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHIRTPRLEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecPayGroup
        -- standard fields above and additional driver fields below
        ,drvPayrollLocation = EecLocation
        ,drvEmployeeID = EecEmpNo
        ,drvFEIN = @FedTaxId
        ,drvSSN = eepSSN        
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',','')
        ,drvAddressLine2 = REPLACE(EepAddressLine2, ',','')
        ,drvAddressCity = REPLACE(EepAddressCity, ',','')
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvMostRecentHireDate = EecDateOfLastHire
        ,drvTermDate = EjhJobEffDate
        ,drvMostRecentTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmployementStatus = EecEmplStatus
        ,drvEmploymentType =    CASE EecEEType
                                    WHEN 'REG' THEN 'Regular'
                                    WHEN 'EXC' THEN 'Executive'
                                    WHEN 'TMP' THEN 'Temporary'
                                END
        ,drvSeperationCode = EecTermReason
        ,drvSeperationReason = EecTermType
        ,drvDateOfBirth = EepDateOfBirth
        ,drvJobTitle = REPLACE(JbcDesc, ',', '')
        ,drvCheckDate = PrgPayDate
        ,drvPayStartDate = PrgPeriodStart
        ,drvPayEndDate = PrgPeriodEnd
        ,drvGrossHours = FORMAT(PehCurHrs, '#0.00')
        ,drvGrossWages = FORMAT(PehCurAmt, '#0.00')
        ,drvRegularWages = FORMAT(PehCurAmtReg, '#0.00')
        ,drvOvertimeWages = FORMAT(PehCurAmtOt, '#0.00')
        ,drvBonusWages = FORMAT(PehCurAmtBon, '#0.00')
        ,drvCommissionWages = FORMAT(PehCurAmtCom, '#0.00')
        ,drvTipIncome = FORMAT(PehCurAmtTip, '#0.00')
        ,drvOtherWages = FORMAT(PehCurAmtOth, '#0.00')
        ,drvPayRate =    FORMAT(
                        CASE WHEN EecPayPeriod = 'W' AND EecSalaryOrHourly <> 'H' THEN EecAnnSalary/52
                        WHEN EecPayPeriod = 'B' AND EecSalaryOrHourly <> 'H' THEN EecAnnSalary/26
                        WHEN EecPayPeriod = 'S' AND EecSalaryOrHourly <> 'H' THEN EecAnnSalary/24
                        WHEN EecPayPeriod = 'M' AND EecSalaryOrHourly <> 'H' THEN EecAnnSalary/12
                        ELSE EecHourlyPayRate
                        END
                        , '#0.00')
        ,drvPayRateFrequency = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Salary' ELSE 'Hourly' END
        ,drvPayFrequency = CASE WHEN EecPayPeriod = 'W' THEN 'Weekly'
                        WHEN EecPayPeriod = 'B' THEN 'Bi-Weekly'
                        WHEN EecPayPeriod = 'S' THEN 'Semi-monthly'
                        WHEN EecPayPeriod = 'M' THEN 'Monthly'
                        WHEN EecPayPeriod = 'A' THEN 'Annually'
                        END
    INTO dbo.U_EHIRTPRLEX_drvTbl
    FROM dbo.U_EHIRTPRLEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhEmplStatus, MIN(EjhJobEffDate) AS EjhJobEffDate
                FROM dbo.EmpHJob WITH (NOLOCK)
                WHERE EjhEmplStatus = 'T'
                GROUP BY EjhEEID, EjhCOID, EjhEmplStatus) AS FirstTerm
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    LEFT JOIN dbo.U_EHIRTPRLEX_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audCOID = xCOID
    JOIN dbo.U_EHIRTPRLEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN (SELECT PgpPayGroup, CAST( LEFT(MAX(PgpPeriodControl),8) as datetime) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as PayGRP
        on PayGRP.PgpPayGroup =  eecpaygroup
    WHERE --EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND 
            --                        (
                                        PehCurHrs > 0.00
                                        OR PehCurAmt > 0.00
                                        OR PehCurAmtReg > 0.00
                                        OR PehCurAmtOt > 0.00
                                        OR PehCurAmtBon > 0.00
                                        OR PehCurAmtCom > 0.00
                                        OR PehCurAmtTip > 0.00
                                        OR PehCurAmtOth > 0.00
              --                      )
                --                )
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
ALTER VIEW dbo.dsi_vwEHIRTPRLEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHIRTPRLEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EHIRTPRLEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202202181'
       ,expStartPerControl     = '202202181'
       ,expLastEndPerControl   = '202202259'
       ,expEndPerControl       = '202202259'
WHERE expFormatCode = 'EHIRTPRLEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHIRTPRLEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHIRTPRLEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EHIRTPRLEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EHIRTPRLEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EHIRTPRLEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHIRTPRLEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EHIRTPRLEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EHIRTPRLEX', 'UseFileName', 'V', 'Y'


-- End ripout