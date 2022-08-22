/**********************************************************************************

ETIAASPRKE: TIAA SPARK Def Comp Export

FormatCode:     ETIAASPRKE
Project:        TIAA SPARK Def Comp Export
Client ID:      GIF1000
Date/time:      2022-08-16 06:36:59.360
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E31
Server:         E3SUP1DB02
Database:       ULTIPRO_GMCI
Web Filename:   GIF1000_79471_EEHISTORY_ETIAASPRKE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ETIAASPRKE_SavePath') IS NOT NULL DROP TABLE dbo.U_ETIAASPRKE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ETIAASPRKE'


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
WHERE FormatCode = 'ETIAASPRKE'
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
WHERE ExpFormatCode = 'ETIAASPRKE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ETIAASPRKE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ETIAASPRKE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ETIAASPRKE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ETIAASPRKE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ETIAASPRKE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ETIAASPRKE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ETIAASPRKE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ETIAASPRKE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ETIAASPRKE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ETIAASPRKE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwETIAASPRKE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETIAASPRKE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETIAASPRKE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETIAASPRKE];
GO
IF OBJECT_ID('U_ETIAASPRKE_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ETIAASPRKE_Trailer];
GO
IF OBJECT_ID('U_ETIAASPRKE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETIAASPRKE_PEarHist];
GO
IF OBJECT_ID('U_ETIAASPRKE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETIAASPRKE_PDedHist];
GO
IF OBJECT_ID('U_ETIAASPRKE_Header') IS NOT NULL DROP TABLE [dbo].[U_ETIAASPRKE_Header];
GO
IF OBJECT_ID('U_ETIAASPRKE_File') IS NOT NULL DROP TABLE [dbo].[U_ETIAASPRKE_File];
GO
IF OBJECT_ID('U_ETIAASPRKE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETIAASPRKE_EEList];
GO
IF OBJECT_ID('U_ETIAASPRKE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETIAASPRKE_drvTbl];
GO
IF OBJECT_ID('U_ETIAASPRKE_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETIAASPRKE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ETIAASPRKE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETIAASPRKE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETIAASPRKE','TIAA SPARK Def Comp Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','7000','S','N','ETIAASPRKEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETIAASPRKEZ0','50','H','01','1',NULL,'RECORD TYPE',NULL,NULL,'"SPARKH"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETIAASPRKEZ0','50','H','01','2',NULL,'DATA TYPE',NULL,NULL,'"04"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETIAASPRKEZ0','50','H','01','3',NULL,'DATA SOURCE',NULL,NULL,'"drvDataSource"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETIAASPRKEZ0','50','H','01','4',NULL,'CREATION DATE / TIME',NULL,NULL,'"drvCreationDateTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETIAASPRKEZ0','50','H','01','5',NULL,'CONTACT',NULL,NULL,'"Kevin Conroy -- 8027282103"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ETIAASPRKEZ0','50','H','01','6',NULL,'SENDER',NULL,NULL,'"UKG Pro"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ETIAASPRKEZ0','50','H','01','7',NULL,'SPARK VERSION',NULL,NULL,'"2.00"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ETIAASPRKEZ0','50','H','01','8',NULL,'AS OF DATE',NULL,NULL,'"drvAsOfDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ETIAASPRKEZ0','50','H','01','9',NULL,'Filler',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ETIAASPRKEZ0','50','H','01','10',NULL,'PAYROLL FUNDING',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETIAASPRKEZ0','50','D','10','1',NULL,'DETAIL RECORD ID',NULL,NULL,'"D"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETIAASPRKEZ0','50','D','10','2',NULL,'EMPLOYER NAME',NULL,NULL,'"drvEmployerName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETIAASPRKEZ0','50','D','10','3',NULL,'EMPLOYER EIN',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETIAASPRKEZ0','50','D','10','4',NULL,'EMPLOYER PLAN ID',NULL,NULL,'"drvEmployerPlanId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETIAASPRKEZ0','50','D','10','5',NULL,'EMPLOYER SUB PLAN ID',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ETIAASPRKEZ0','50','D','10','6',NULL,'ORIGINATING VENDOR PLAN ID',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ETIAASPRKEZ0','50','D','10','7',NULL,'ORIGINATING VENDOR SUB PLAN ID',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ETIAASPRKEZ0','50','D','10','8',NULL,'RECIPIENT VENDOR PLAN ID',NULL,NULL,'"drvRecipientVendorPlanId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ETIAASPRKEZ0','50','D','10','9',NULL,'RECIPIENT VENDOR SUB PLAN ID',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ETIAASPRKEZ0','50','D','10','10',NULL,'TYPE OF ACCOUNT',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ETIAASPRKEZ0','50','D','10','11',NULL,'PAYROLL FREQUENCY',NULL,NULL,'"drvPayrollFrequency"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ETIAASPRKEZ0','50','D','10','12',NULL,'EMPLOYEE SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ETIAASPRKEZ0','50','D','10','13',NULL,'EMPLOYEE ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ETIAASPRKEZ0','50','D','10','14',NULL,'EMPLOYEE TITLE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ETIAASPRKEZ0','50','D','10','15',NULL,'EMPLOYEE FIRST NAME',NULL,NULL,'"drvEmployeeNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ETIAASPRKEZ0','50','D','10','16',NULL,'EMPLOYEE MIDDLE NAME',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ETIAASPRKEZ0','50','D','10','17',NULL,'EMPLOYEE LAST NAME',NULL,NULL,'"drvEmployeeNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ETIAASPRKEZ0','50','D','10','18',NULL,'ADDRESS LINE1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ETIAASPRKEZ0','50','D','10','19',NULL,'ADDRESS LINE2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ETIAASPRKEZ0','50','D','10','20',NULL,'ADDRESS LINE3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ETIAASPRKEZ0','50','D','10','21',NULL,'CITY',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ETIAASPRKEZ0','50','D','10','22',NULL,'STATE',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ETIAASPRKEZ0','50','D','10','23',NULL,'Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ETIAASPRKEZ0','50','D','10','24',NULL,'COUNTRY CODE',NULL,NULL,'"drvAddressCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ETIAASPRKEZ0','50','D','10','25',NULL,'RESIDENCY CODE',NULL,NULL,'"drvResidencyCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ETIAASPRKEZ0','50','D','10','26',NULL,'DATE OF BIRTH',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ETIAASPRKEZ0','50','D','10','27',NULL,'GENDER ID',NULL,NULL,'"drvGenderId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ETIAASPRKEZ0','50','D','10','28',NULL,'MARITAL STATUS',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ETIAASPRKEZ0','50','D','10','29',NULL,'PHONE NUMBER1',NULL,NULL,'"drvPhoneNumber1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ETIAASPRKEZ0','50','D','10','30',NULL,'PHONE NUMBER TYPE1',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ETIAASPRKEZ0','50','D','10','31',NULL,'PHONE EXTENSION1',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ETIAASPRKEZ0','50','D','10','32',NULL,'PHONE NUMBER2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ETIAASPRKEZ0','50','D','10','33',NULL,'PHONE NUMBER TYPE2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ETIAASPRKEZ0','50','D','10','34',NULL,'PHONE EXTENSION2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ETIAASPRKEZ0','50','D','10','35',NULL,'EMAIL ADDRESS',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ETIAASPRKEZ0','50','D','10','36',NULL,'PERSONAL EMAIL ADDRESS',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ETIAASPRKEZ0','50','D','10','37',NULL,'PAYROLL DATE',NULL,NULL,'"drvPayrollDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ETIAASPRKEZ0','50','D','10','38',NULL,'CONTRIBUTION SOURCE CODE1',NULL,NULL,'"drvContributionSourceCode1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ETIAASPRKEZ0','50','D','10','39',NULL,'CONTRIBUTION SOURCE AMOUNT1',NULL,NULL,'"drvContributionSourceAmount1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ETIAASPRKEZ0','50','D','10','40',NULL,'CONTRIBUTION SOURCE CODE2',NULL,NULL,'"drvContributionSourceCode2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ETIAASPRKEZ0','50','D','10','41',NULL,'CONTRIBUTION SOURCE AMOUNT2',NULL,NULL,'"drvContributionSourceAmount2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ETIAASPRKEZ0','50','D','10','42',NULL,'CONTRIBUTION SOURCE CODE3',NULL,NULL,'"drvContributionSourceCode3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ETIAASPRKEZ0','50','D','10','43',NULL,'CONTRIBUTION SOURCE AMOUNT3',NULL,NULL,'"drvContributionSourceAmount3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ETIAASPRKEZ0','50','D','10','44',NULL,'CONTRIBUTION SOURCE CODE4',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ETIAASPRKEZ0','50','D','10','45',NULL,'CONTRIBUTION SOURCE AMOUNT4',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ETIAASPRKEZ0','50','D','10','46',NULL,'CONTRIBUTION SOURCE CODE5',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ETIAASPRKEZ0','50','D','10','47',NULL,'CONTRIBUTION SOURCE AMOUNT5',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ETIAASPRKEZ0','50','D','10','48',NULL,'CONTRIBUTION SOURCE CODE6',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ETIAASPRKEZ0','50','D','10','49',NULL,'CONTRIBUTION SOURCE AMOUNT6',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ETIAASPRKEZ0','50','D','10','50',NULL,'CONTRIBUTION SOURCE CODE7',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ETIAASPRKEZ0','50','D','10','51',NULL,'CONTRIBUTION SOURCE AMOUNT7',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ETIAASPRKEZ0','50','D','10','52',NULL,'CONTRIBUTION SOURCE CODE8',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ETIAASPRKEZ0','50','D','10','53',NULL,'CONTRIBUTION SOURCE AMOUNT8',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ETIAASPRKEZ0','50','D','10','54',NULL,'Final Contribution Indicator',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ETIAASPRKEZ0','50','D','10','55',NULL,'LOAN NUMBER 1',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ETIAASPRKEZ0','50','D','10','56',NULL,'LOAN REPAYMENT AMOUNT1',NULL,NULL,'"drvLoanRepaymentAmount1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ETIAASPRKEZ0','50','D','10','57',NULL,'LOAN NUMBER 2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ETIAASPRKEZ0','50','D','10','58',NULL,'LOAN REPAYMENT AMOUNT2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ETIAASPRKEZ0','50','D','10','59',NULL,'LOAN NUMBER 3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ETIAASPRKEZ0','50','D','10','60',NULL,'LOAN REPAYMENT AMOUNT3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ETIAASPRKEZ0','50','D','10','61',NULL,'LOAN NUMBER 4',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ETIAASPRKEZ0','50','D','10','62',NULL,'LOAN REPAYMENT AMOUNT4',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ETIAASPRKEZ0','50','D','10','63',NULL,'LOAN NUMBER 5',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ETIAASPRKEZ0','50','D','10','64',NULL,'LOAN REPAYMENT AMOUNT5',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ETIAASPRKEZ0','50','D','10','65',NULL,'LOCATION CODE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ETIAASPRKEZ0','50','D','10','66',NULL,'HR SUB AREA',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ETIAASPRKEZ0','50','D','10','67',NULL,'DATE OF HIRE',NULL,NULL,'"drvDateOfHire"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ETIAASPRKEZ0','50','D','10','68',NULL,'ADJUSTED DATE OF HIRE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ETIAASPRKEZ0','50','D','10','69',NULL,'EMPLOYMENT STATUS',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ETIAASPRKEZ0','50','D','10','70',NULL,'Employment Sub-type',NULL,NULL,'"drvEmploymentSubType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ETIAASPRKEZ0','50','D','10','71',NULL,'EMPLOYMENT STATUS DATE',NULL,NULL,'"drvEmploymentStatusDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ETIAASPRKEZ0','50','D','10','72',NULL,'EMPLOYEE TYPE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ETIAASPRKEZ0','50','D','10','73',NULL,'PAYROLL MODE',NULL,NULL,'"100"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ETIAASPRKEZ0','50','D','10','74',NULL,'YEARS OF SERVICE',NULL,NULL,'"drvYearsOfService"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ETIAASPRKEZ0','50','D','10','75',NULL,'MONTHS OF SERVICE',NULL,NULL,'"drvMonthsOfService"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ETIAASPRKEZ0','50','D','10','76',NULL,'ANNUAL SALARY',NULL,NULL,'"drvAnnualSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ETIAASPRKEZ0','50','D','10','77',NULL,'ADDITIONAL COMPENSATION',NULL,NULL,'"drvAnnualCompensation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ETIAASPRKEZ0','50','D','10','78',NULL,'PER PAY COMPENSATION',NULL,NULL,'"drvPerPayCompensation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ETIAASPRKEZ0','50','D','10','79',NULL,'PER PAY HOURS WORKED',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ETIAASPRKEZ0','50','D','10','80',NULL,'YEAR TO DATE TYPE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ETIAASPRKEZ0','50','D','10','81',NULL,'YEAR TO DATE BASE COMPENSATION',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ETIAASPRKEZ0','50','D','10','82',NULL,'YEAR TO DATE TOTAL COMPENSATION',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ETIAASPRKEZ0','50','D','10','83',NULL,'YEAR TO DATE HOURS WORKED',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ETIAASPRKEZ0','50','D','10','84',NULL,'HCE FLAG',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ETIAASPRKEZ0','50','D','10','85',NULL,'KEY EMPLOYEE FLAG',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ETIAASPRKEZ0','50','D','10','86',NULL,'AE EXCLUSION FLAG',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ETIAASPRKEZ0','50','D','10','87',NULL,'EMPLOYEE PLAN STATUS',NULL,NULL,'"drvEmployeePlanStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ETIAASPRKEZ0','50','D','10','88',NULL,'PLAN ENTRY DATE',NULL,NULL,'" "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ETIAASPRKEZ0','50','D','10','89',NULL,'VESTED DATE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ETIAASPRKEZ0','50','D','10','90',NULL,'ADJUSTMENT END DATE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ETIAASPRKEZ0','50','D','10','91',NULL,'VESTING SOURCE CODE 1',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ETIAASPRKEZ0','50','D','10','92',NULL,'VESTING PERCENTAGE 1',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','ETIAASPRKEZ0','50','D','10','93',NULL,'VESTING SOURCE CODE 2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','ETIAASPRKEZ0','50','D','10','94',NULL,'VESTING PERCENTAGE 2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','ETIAASPRKEZ0','50','D','10','95',NULL,'VESTING SOURCE CODE 3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','ETIAASPRKEZ0','50','D','10','96',NULL,'VESTING PERCENTAGE 3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','ETIAASPRKEZ0','50','D','10','97',NULL,'CONTRIBUTION SOURCE CODE1',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','ETIAASPRKEZ0','50','D','10','98',NULL,'DEFERRAL PERCENTAGE - CS1',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','ETIAASPRKEZ0','50','D','10','99',NULL,'PAY PER DEFERRAL AMOUNT - CS1',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','ETIAASPRKEZ0','50','D','10','100',NULL,'CONTRIBUTION SOURCE CODE2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','ETIAASPRKEZ0','50','D','10','101',NULL,'DEFERRAL PERCENTAGE - CS2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','ETIAASPRKEZ0','50','D','10','102',NULL,'PAY PER DEFERRAL AMOUNT - CS2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','ETIAASPRKEZ0','50','D','10','103',NULL,'CONTRIBUTION SOURCE CODE3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','ETIAASPRKEZ0','50','D','10','104',NULL,'DEFERRAL PERCENTAGE - CS3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','ETIAASPRKEZ0','50','D','10','105',NULL,'PAY PER DEFERRAL AMOUNT - CS3',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','ETIAASPRKEZ0','50','D','10','106',NULL,'PLAN ANNUAL SALARY',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','ETIAASPRKEZ0','50','D','10','107',NULL,'Employer Contribution Eligibility Source1',NULL,NULL,'"drvEEContributionEligSource1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','ETIAASPRKEZ0','50','D','10','108',NULL,'EMPLOYER CONTRIBUTION ELIGIBILITY DATE1',NULL,NULL,'"drvEEContributionEligDate1"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','ETIAASPRKEZ0','50','D','10','109',NULL,'EMPLOYER CONTRIBUTION ELIGIBILITY SOURCE2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','ETIAASPRKEZ0','50','D','10','110',NULL,'EMPLOYER CONTRIBUTION ELIGIBILITY DATE2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','ETIAASPRKEZ0','50','D','10','111',NULL,'AUTOMATIC DEFERRAL INCREASE TYPE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','ETIAASPRKEZ0','50','D','10','112',NULL,'AUTOMATIC DEFERRAL INCREASE ELECTION DATE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','ETIAASPRKEZ0','50','D','10','113',NULL,'AUTOMATIC DEFERRAL INCREASE NEXT INCREASE DATE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','ETIAASPRKEZ0','50','D','10','114',NULL,'AUTOMATIC DEFERRAL INCREASE END DATE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','ETIAASPRKEZ0','50','D','10','115',NULL,'AUTOMATIC DEFERRAL INCREASE FREQUENCY',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','ETIAASPRKEZ0','50','D','10','116',NULL,'AUTOMATIC DEFERRAL INCREASE AMOUNT',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','ETIAASPRKEZ0','50','D','10','117',NULL,'AUTOMATIC DEFERRAL INCREASE AMOUNT MAXIMUM',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','ETIAASPRKEZ0','50','D','10','118',NULL,'AUTOMATIC DEFERRAL INCREASE PERCENTAGE',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','ETIAASPRKEZ0','50','D','10','119',NULL,'AUTOMATIC DEFERRAL INCREASE PERCENTAGE MAXIMUM',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ETIAASPRKEZ0','50','T','90','1',NULL,'RECORD TYPE',NULL,NULL,'"SPARKTR"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ETIAASPRKEZ0','50','T','90','2',NULL,'RECORD COUNT',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ETIAASPRKEZ0','50','T','90','3',NULL,'REMITTANCE AMOUNT TOTAL',NULL,NULL,'"drvRemittanceAmountTotal"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ETIAASPRKEZ0','50','T','90','4',NULL,'LOAN AMOUNT TOTAL',NULL,NULL,'"drvLoanAmountTotal"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ETIAASPRKEZ0','50','T','90','5',NULL,'FILLER',NULL,NULL,'""','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ETIAASPRKE_20220816.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202208049','EMPEXPORT','OEACTIVE',NULL,'ETIAASPRKE',NULL,NULL,NULL,'202208049','Aug  4 2022  8:31AM','Aug  4 2022  8:31AM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202208049','EMPEXPORT','OEPASSIVE',NULL,'ETIAASPRKE',NULL,NULL,NULL,'202208049','Aug  4 2022  8:31AM','Aug  4 2022  8:31AM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'TIAA SPARK Def Comp Export','202208049','EMPEXPORT','ONDEM_XOE',NULL,'ETIAASPRKE',NULL,NULL,NULL,'202208049','Aug  4 2022  8:31AM','Aug  4 2022  8:31AM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'TIAA SPARK Def Comp Expo-Sched','202208049','EMPEXPORT','SCH_ETIAAS',NULL,'ETIAASPRKE',NULL,NULL,NULL,'202208049','Aug  4 2022  8:31AM','Aug  4 2022  8:31AM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,'TIAA SPARK Def Comp Expo-Test','202208049','EMPEXPORT','TEST_XOE',NULL,'ETIAASPRKE',NULL,NULL,NULL,'202208049','Aug  4 2022  8:31AM','Aug  4 2022  8:31AM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETIAASPRKE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETIAASPRKE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETIAASPRKE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETIAASPRKE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETIAASPRKE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETIAASPRKE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETIAASPRKE','H01','dbo.U_ETIAASPRKE_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETIAASPRKE','D10','dbo.U_ETIAASPRKE_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETIAASPRKE','T90','dbo.U_ETIAASPRKE_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ETIAASPRKE
-----------

IF OBJECT_ID('U_dsi_BDM_ETIAASPRKE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETIAASPRKE] (
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
-- Create table U_ETIAASPRKE_DedList
-----------

IF OBJECT_ID('U_ETIAASPRKE_DedList') IS NULL
CREATE TABLE [dbo].[U_ETIAASPRKE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ETIAASPRKE_drvTbl
-----------

IF OBJECT_ID('U_ETIAASPRKE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETIAASPRKE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvEmployerName] varchar(40) NULL,
    [drvEmployerPlanId] varchar(6) NOT NULL,
    [drvRecipientVendorPlanId] varchar(6) NOT NULL,
    [drvPayrollFrequency] char(1) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeNameFirst] varchar(100) NULL,
    [drvEmployeeNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvResidencyCode] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGenderId] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvPhoneNumber1] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPayrollDate] datetime NULL,
    [drvContributionSourceCode1] varchar(1) NULL,
    [drvContributionSourceAmount1] nvarchar(4000) NULL,
    [drvContributionSourceCode2] varchar(1) NULL,
    [drvContributionSourceAmount2] nvarchar(4000) NULL,
    [drvContributionSourceCode3] varchar(1) NULL,
    [drvContributionSourceAmount3] nvarchar(4000) NULL,
    [drvLoanRepaymentAmount1] nvarchar(4000) NULL,
    [drvDateOfHire] datetime NULL,
    [drvEmploymentStatus] varchar(1) NULL,
    [drvEmploymentSubType] varchar(1) NULL,
    [drvEmploymentStatusDate] datetime NULL,
    [drvYearsOfService] int NULL,
    [drvMonthsOfService] int NULL,
    [drvAnnualSalary] nvarchar(4000) NULL,
    [drvAnnualCompensation] nvarchar(4000) NULL,
    [drvPerPayCompensation] char(1) NULL,
    [drvEmployeePlanStatus] varchar(1) NULL,
    [drvEEContributionEligSource1] varchar(1) NULL,
    [drvEEContributionEligDate1] datetime NULL
);

-----------
-- Create table U_ETIAASPRKE_EEList
-----------

IF OBJECT_ID('U_ETIAASPRKE_EEList') IS NULL
CREATE TABLE [dbo].[U_ETIAASPRKE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ETIAASPRKE_File
-----------

IF OBJECT_ID('U_ETIAASPRKE_File') IS NULL
CREATE TABLE [dbo].[U_ETIAASPRKE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_ETIAASPRKE_Header
-----------

IF OBJECT_ID('U_ETIAASPRKE_Header') IS NULL
CREATE TABLE [dbo].[U_ETIAASPRKE_Header] (
    [drvDataSource] varchar(40) NULL,
    [drvCreationDateTime] varchar(14) NULL,
    [drvAsOfDate] datetime NOT NULL
);

-----------
-- Create table U_ETIAASPRKE_PDedHist
-----------

IF OBJECT_ID('U_ETIAASPRKE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETIAASPRKE_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPayDate] datetime NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSrc1P1] numeric NULL,
    [PdhSrc1P2] numeric NULL,
    [Pdhsrc2P1a] numeric NULL,
    [Pdhsrc2P1b] numeric NULL,
    [PdhROTH] numeric NULL,
    [Pdh403L] numeric NULL
);

-----------
-- Create table U_ETIAASPRKE_PEarHist
-----------

IF OBJECT_ID('U_ETIAASPRKE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETIAASPRKE_PEarHist] (
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
    [PehAmtBonusNonDisc] numeric NULL
);

-----------
-- Create table U_ETIAASPRKE_Trailer
-----------

IF OBJECT_ID('U_ETIAASPRKE_Trailer') IS NULL
CREATE TABLE [dbo].[U_ETIAASPRKE_Trailer] (
    [drvRecordCount] int NULL,
    [drvRemittanceAmountTotal] varchar(1) NOT NULL,
    [drvLoanAmountTotal] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETIAASPRKE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Gifford Medical Center

Created By: James Bender
Business Analyst: Julie Reardon
Create Date: 08/04/2022
Service Request Number: TekP-2022-03-02-04

Purpose: TIAA SPARK Def Comp Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETIAASPRKE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETIAASPRKE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETIAASPRKE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETIAASPRKE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETIAASPRKE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETIAASPRKE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETIAASPRKE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETIAASPRKE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETIAASPRKE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETIAASPRKE', 'SCH_ETIAAS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETIAASPRKE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ETIAASPRKE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETIAASPRKE';

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
    DELETE FROM dbo.U_ETIAASPRKE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETIAASPRKE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '403,403CU,403L,403M,403PD,457,457CU,ROTH';

    IF OBJECT_ID('U_ETIAASPRKE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETIAASPRKE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETIAASPRKE_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ETIAASPRKE_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETIAASPRKE_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PdhPayDate = MAX(PdhPayDate)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSrc1P1     = SUM(CASE WHEN PdhDedCode IN ('403') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSrc1P2     = SUM(CASE WHEN PdhDedCode IN ('457','457CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdhsrc2P1a     = SUM(CASE WHEN PdhDedCode IN ('403CU','403M','403PD') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdhsrc2P1b     = SUM(CASE WHEN PdhDedCode IN ('403M') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhROTH        = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)        
        ,Pdh403L        = SUM(CASE WHEN PdhDedCode IN ('403L') THEN PdhEECurAmt ELSE 0.00 END)        
    INTO dbo.U_ETIAASPRKE_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETIAASPRKE_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ETIAASPRKE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETIAASPRKE_PEarHist;
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
        ,PehAmtBonusNonDisc        = SUM(CASE WHEN PehIsBonusNonDisc = 'Y' THEN PehCurAmt ELSE 0.00 END)
    INTO dbo.U_ETIAASPRKE_PEarHist
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
    -- DETAIL RECORD - U_ETIAASPRKE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETIAASPRKE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETIAASPRKE_drvTbl;
    -- Starting Union
    SELECT * INTO dbo.U_ETIAASPRKE_drvTbl FROM (
    SELECT DISTINCT drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvEmployerName = (SELECT TOP 1 CmmCompanyName from dbo.CompMast WITH (NOLOCK))
        ,drvEmployerPlanId =    --CASE WHEN BdmDedCode IN ('403','403CU','403M','403PD','ROTH') THEN 
                                '408326'
                                --WHEN BdmDedCode IN ('457','457CU') THEN '408330'
                                --END
        ,drvRecipientVendorPlanId =    --CASE WHEN BdmDedCode IN ('403','403CU','403M','403PD','ROTH') THEN 
                                    '408326'
                                    --WHEN BdmDedCode IN ('457','457CU') THEN '408330'
                                    --END
        ,drvPayrollFrequency = PgrPayFrequency
        ,drvEmployeeSSN = EepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeNameFirst = EepNameFirst
        ,drvEmployeeNameLast = EepNameLast
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = EepAddressCountry
        ,drvResidencyCode = CASE WHEN EepI9WorkAuth IN ('U','P','C') THEN 'U' END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGenderId = EepGender
        ,drvMaritalStatus = CASE WHEN EepMaritalStatus IN ('C','M','P') THEN 'M' ELSE 'S' END
        ,drvPhoneNumber1 = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvPayrollDate = PdhPayDate
        ,drvContributionSourceCode1 = CASE WHEN DedCode_403 IS NOT NULL THEN 'F' END
        ,drvContributionSourceAmount1 =    CASE WHEN DedCode_403 IS NOT NULL THEN FORMAT(PdhSrc1P1, '#0.00') END
        ,drvContributionSourceCode2 = CASE WHEN DedCode_403x IS NOT NULL THEN 'E' END
        ,drvContributionSourceAmount2 = CASE WHEN DedCode_403x IS NOT NULL THEN FORMAT(Pdhsrc2P1a + Pdhsrc2P1b, '#0.00') END
        ,drvContributionSourceCode3 = CASE WHEN DedCode_ROTH IS NOT NULL THEN '2' END
        ,drvContributionSourceAmount3 = CASE WHEN DedCode_ROTH IS NOT NULL THEN FORMAT(PdhROTH, '#0.00') END
        ,drvLoanRepaymentAmount1 = CASE WHEN DedCode_403l IS NOT NULL THEN FORMAT(Pdh403L, '#0.00') END
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'A' THEN 'E' ELSE EecEmplStatus END
        ,drvEmploymentSubType =    CASE WHEN EecEmplStatus = 'A' AND EecDateOfLastHire = EecDateOfOriginalHire THEN 'O'
                                WHEN EecEmplStatus = 'A' AND EecDateOfLastHire <> EecDateOfOriginalHire THEN 'R'
                                WHEN EecEmplStatus = 'T' THEN ''
                                WHEN EecEmplStatus = 'L' THEN 'A'
                                END
        ,drvEmploymentStatusDate = EshStatusStartDate
        ,drvYearsOfService = DATEDIFF(YEAR, EecDateOfBenefitSeniority,GETDATE())
        ,drvMonthsOfService = DATEDIFF(MONTH, EecDateOfBenefitSeniority,GETDATE())
        ,drvAnnualSalary = FORMAT(EecAnnSalary, '#0.00')
        ,drvAnnualCompensation = FORMAT(PehAmtBonusNonDisc, '#0.00')
        ,drvPerPayCompensation = EecPayPeriod
        ,drvEmployeePlanStatus =    CASE WHEN (DedCode_403x IS NOT NULL OR DedCode_ROTH IS NOT NULL) AND DedCode_403x_StopDate IS NULL THEN 'P'
                                    WHEN (DedCode_403x IS NOT NULL OR DedCode_ROTH IS NOT NULL) AND DedCode_403x_StopDate IS NOT NULL THEN 'E'
                                    ELSE 'E'
                                    END
        ,drvEEContributionEligSource1 = CASE WHEN DedCode_403 IS NOT NULL THEN 'F' END
        ,drvEEContributionEligDate1 = CASE WHEN DedCode_403 IS NOT NULL THEN EecDateOfBenefitSeniority END
    --INTO dbo.U_ETIAASPRKE_drvTbl
    FROM dbo.U_ETIAASPRKE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETIAASPRKE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID            
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    JOIN dbo.U_ETIAASPRKE_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN (
                SELECT BdmEEID AS BdmP1EEID, BdmCOID AS BdmP1COID
                    ,MAX(CASE WHEN BdmDedCode = '403' THEN BdmDedCode END) AS DedCode_403
                    ,MAX(CASE WHEN BdmDedCode IN ('403CU','403M','403PD') THEN BdmDedCode END) AS DedCode_403x
                    ,MAX(CASE WHEN BdmDedCode IN ('403CU','403M','403PD') THEN BdmBenStopDate END) AS DedCode_403x_StopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('ROTH') THEN BdmDedCode END) AS DedCode_ROTH
                    ,MAX(CASE WHEN BdmDedCode IN ('403L') THEN BdmDedCode END) AS DedCode_403l
                FROM dbo.U_dsi_BDM_ETIAASPRKE WITH (NOLOCK)
                WHERE BdmDedCode IN ('403','403CU','403M','403PD','ROTH')
                GROUP BY BdmEEID, BdmCOID) AS PlanOneBdm
        ON BdmP1EEID = xEEID
        AND BdmP1COID = xCOID
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) ) AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    JOIN dbo.U_ETIAASPRKE_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    WHERE BdmDedCode IN ('403','403CU','403M','403PD','ROTH','403L')

    UNION ALL

    SELECT DISTINCT drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvEmployerName = (SELECT TOP 1 CmmCompanyName from dbo.CompMast WITH (NOLOCK))
        ,drvEmployerPlanId =    --CASE WHEN BdmDedCode IN ('403','403CU','403M','403PD','ROTH') THEN '408326'
        --                        WHEN BdmDedCode IN ('457','457CU') THEN 
                                '408330'
                                --END
        ,drvRecipientVendorPlanId =    --CASE WHEN BdmDedCode IN ('403','403CU','403M','403PD','ROTH') THEN '408326'
                                    --WHEN BdmDedCode IN ('457','457CU') THEN 
                                    '408330'
                                    --END
        ,drvPayrollFrequency = PgrPayFrequency
        ,drvEmployeeSSN = EepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeNameFirst = EepNameFirst
        ,drvEmployeeNameLast = EepNameLast
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = EepAddressCountry
        ,drvResidencyCode = CASE WHEN EepI9WorkAuth IN ('U','P','C') THEN 'U' END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGenderId = EepGender
        ,drvMaritalStatus = CASE WHEN EepMaritalStatus IN ('C','M','P') THEN 'M' ELSE 'S' END
        ,drvPhoneNumber1 = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvPayrollDate = PdhPayDate
        ,drvContributionSourceCode1 =    CASE WHEN DedCode_457 IS NOT NULL THEN 'E' END
        ,drvContributionSourceAmount1 =    CASE WHEN DedCode_457 IS NOT NULL THEN FORMAT(PdhSrc1P2, '#0.00') END
        ,drvContributionSourceCode2 = ''
        ,drvContributionSourceAmount2 = ''
        ,drvContributionSourceCode3 = ''
        ,drvContributionSourceAmount3 = ''
        ,drvLoanRepaymentAmount1 = ''
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'A' THEN 'E' ELSE EecEmplStatus END
        ,drvEmploymentSubType =    CASE WHEN EecEmplStatus = 'A' AND EecDateOfLastHire = EecDateOfOriginalHire THEN 'O'
                                WHEN EecEmplStatus = 'A' AND EecDateOfLastHire <> EecDateOfOriginalHire THEN 'R'
                                WHEN EecEmplStatus = 'T' THEN ''
                                WHEN EecEmplStatus = 'L' THEN 'A'
                                END
        ,drvEmploymentStatusDate = EshStatusStartDate
        ,drvYearsOfService = DATEDIFF(YEAR, EecDateOfBenefitSeniority,GETDATE())
        ,drvMonthsOfService = DATEDIFF(MONTH, EecDateOfBenefitSeniority,GETDATE())
        ,drvAnnualSalary = FORMAT(EecAnnSalary, '#0.00')
        ,drvAnnualCompensation = FORMAT(PehAmtBonusNonDisc, '#0.00')
        ,drvPerPayCompensation = EecPayPeriod
        ,drvEmployeePlanStatus =    CASE WHEN EecDedGroupCode IN ('PHYSF','PHYSP') AND DedCode_457 IS NOT NULL AND DedCode_457_StopDate IS NULL THEN 'P'
                                    WHEN EecDedGroupCode IN ('PHYSF','PHYSP') AND DedCode_457 IS NOT NULL AND DedCode_457_StopDate IS NOT NULL THEN 'E'
                                    WHEN EecDedGroupCode IN ('PHYSF','PHYSP') AND DedCode_457 IS NULL THEN 'E'
                                    END
        ,drvEEContributionEligSource1 = ''
        ,drvEEContributionEligDate1 = ''
    --INTO dbo.U_ETIAASPRKE_drvTbl
    FROM dbo.U_ETIAASPRKE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETIAASPRKE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID            
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    JOIN dbo.U_ETIAASPRKE_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN (
                SELECT BdmEEID AS BdmP1EEID, BdmCOID AS BdmP1COID
                    ,MAX(CASE WHEN BdmDedCode IN ('457','457CU') THEN BdmDedCode END) AS DedCode_457
                    ,MAX(CASE WHEN BdmDedCode IN ('457','457CU') THEN BdmBenStopDate END) AS DedCode_457_StopDate
                    --,MAX(CASE WHEN BdmDedCode IN ('403CU','403M','403PD') THEN BdmDedCode END) AS DedCode_403x
                    --,MAX(CASE WHEN BdmDedCode IN ('ROTH') THEN BdmDedCode END) AS DedCode_ROTH
                FROM dbo.U_dsi_BDM_ETIAASPRKE WITH (NOLOCK)
                WHERE BdmDedCode IN ('457','457CU')
                GROUP BY BdmEEID, BdmCOID) AS PlanOneBdm
        ON BdmP1EEID = xEEID
        AND BdmP1COID = xCOID
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) ) AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    JOIN dbo.U_ETIAASPRKE_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    WHERE BdmDedCode NOT IN ('403','403CU','403M','403PD','ROTH')
    ) as drv
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------

    DECLARE @CurrentDate VARCHAR(8)
        ,@CurrentTime VARCHAR(6);

    SELECT @CurrentDate = FORMAT(GETDATE(), 'yyyyMMdd');
    SELECT @CurrentTime = FORMAT(GETDATE(), 'HHmmss');

    IF OBJECT_ID('U_ETIAASPRKE_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ETIAASPRKE_Header;
    SELECT DISTINCT
         drvDataSource = (SELECT TOP 1 CmmCompanyName from dbo.CompMast WITH (NOLOCK))
        ,drvCreationDateTime = @CurrentDate + @CurrentTime
        ,drvAsOfDate = GETDATE()
    INTO dbo.U_ETIAASPRKE_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ETIAASPRKE_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ETIAASPRKE_Trailer;
    SELECT DISTINCT
         drvRecordCount = (SELECT COUNT(*) FROM dbo.U_ETIAASPRKE_drvTbl)
        ,drvRemittanceAmountTotal = ''
        ,drvLoanAmountTotal = ''
    INTO dbo.U_ETIAASPRKE_Trailer
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
ALTER VIEW dbo.dsi_vwETIAASPRKE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETIAASPRKE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ETIAASPRKE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107281'
       ,expStartPerControl     = '202107281'
       ,expLastEndPerControl   = '202208049'
       ,expEndPerControl       = '202208049'
WHERE expFormatCode = 'ETIAASPRKE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETIAASPRKE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETIAASPRKE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ETIAASPRKE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ETIAASPRKE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ETIAASPRKE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETIAASPRKE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ETIAASPRKE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ETIAASPRKE', 'UseFileName', 'V', 'Y'


-- End ripout