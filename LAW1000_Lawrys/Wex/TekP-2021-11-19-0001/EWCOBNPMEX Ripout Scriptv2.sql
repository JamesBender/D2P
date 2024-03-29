/**********************************************************************************

EWCOBNPMEX: Wex Cobra/Npm Export

FormatCode:     EWCOBNPMEX
Project:        Wex Cobra/Npm Export
Client ID:      LAW1000
Date/time:      2023-01-10 12:18:18.293
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP3DB03
Database:       ULTIPRO_WPLAWRY
Web Filename:   LAW1000_79183_EEHISTORY_EWCOBNPMEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EWCOBNPMEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EWCOBNPMEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EWCOBNPMEX'


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
WHERE FormatCode = 'EWCOBNPMEX'
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
WHERE ExpFormatCode = 'EWCOBNPMEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EWCOBNPMEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EWCOBNPMEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EWCOBNPMEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EWCOBNPMEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EWCOBNPMEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EWCOBNPMEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EWCOBNPMEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EWCOBNPMEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EWCOBNPMEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EWCOBNPMEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEWCOBNPMEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWCOBNPMEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWCOBNPMEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWCOBNPMEX];
GO
IF OBJECT_ID('U_EWCOBNPMEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_PEarHist];
GO
IF OBJECT_ID('U_EWCOBNPMEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_PDedHist];
GO
IF OBJECT_ID('U_EWCOBNPMEX_File') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_File];
GO
IF OBJECT_ID('U_EWCOBNPMEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_EEList];
GO
IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL];
GO
IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QB];
GO
IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_drvTbl_NPM];
GO
IF OBJECT_ID('U_EWCOBNPMEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_DedList];
GO
IF OBJECT_ID('U_EWCOBNPMEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_AuditFields];
GO
IF OBJECT_ID('U_EWCOBNPMEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EWCOBNPMEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EWCOBNPMEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EWCOBNPMEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EWCOBNPMEX','Wex Cobra/Npm Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EWCOBNPMEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWCOBNPMEXZ0','50','H','01','1',NULL,'Field Header',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWCOBNPMEXZ0','50','H','01','2',NULL,'Version Number',NULL,NULL,'"1.1"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWCOBNPMEXZ0','50','D','10','1',NULL,'Field Header',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWCOBNPMEXZ0','50','D','10','2',NULL,'Client Name',NULL,NULL,'"Lawrys Restaurants Inc 42801"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWCOBNPMEXZ0','50','D','10','3',NULL,'Client Division Name',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWCOBNPMEXZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWCOBNPMEXZ0','50','D','10','5',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWCOBNPMEXZ0','50','D','10','6',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWCOBNPMEXZ0','50','D','10','7',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWCOBNPMEXZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWCOBNPMEXZ0','50','D','10','9',NULL,'Individual ID',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWCOBNPMEXZ0','50','D','10','10',NULL,'Email',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWCOBNPMEXZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWCOBNPMEXZ0','50','D','10','12',NULL,'Phone 2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWCOBNPMEXZ0','50','D','10','13',NULL,'Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWCOBNPMEXZ0','50','D','10','14',NULL,'Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWCOBNPMEXZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWCOBNPMEXZ0','50','D','10','16',NULL,'State or Province',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWCOBNPMEXZ0','50','D','10','17',NULL,'Postal Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWCOBNPMEXZ0','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWCOBNPMEXZ0','50','D','10','19',NULL,'Premium Address Same As Primary',NULL,NULL,'"True"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWCOBNPMEXZ0','50','D','10','20',NULL,'Premium Address 1',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWCOBNPMEXZ0','50','D','10','21',NULL,'Premium Address 2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EWCOBNPMEXZ0','50','D','10','22',NULL,'Premium City',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EWCOBNPMEXZ0','50','D','10','23',NULL,'Premium State Or Province',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EWCOBNPMEXZ0','50','D','10','24',NULL,'Premium Postal Code',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EWCOBNPMEXZ0','50','D','10','25',NULL,'Premium Country',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EWCOBNPMEXZ0','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EWCOBNPMEXZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EWCOBNPMEXZ0','50','D','10','28',NULL,'Tobacco Use',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EWCOBNPMEXZ0','50','D','10','29',NULL,'Employee Type',NULL,NULL,'"FTE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EWCOBNPMEXZ0','50','D','10','30',NULL,'Employee Payroll Type',NULL,NULL,'"drvEmployeePayrollType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EWCOBNPMEXZ0','50','D','10','31',NULL,'Years of Service',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EWCOBNPMEXZ0','50','D','10','32',NULL,'Premium Coupon Type',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EWCOBNPMEXZ0','50','D','10','33',NULL,'Uses HCTC',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EWCOBNPMEXZ0','50','D','10','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EWCOBNPMEXZ0','50','D','10','35',NULL,'Allow Member SSO',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EWCOBNPMEXZ0','50','D','10','36',NULL,'Benefit Group',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EWCOBNPMEXZ0','50','D','10','37',NULL,'Account Structure',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EWCOBNPMEXZ0','50','D','10','38',NULL,'Client Specific Data',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EWCOBNPMEXZ0','50','D','10','39',NULL,'Client Specific Data',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWCOBNPMEXZ0','50','D','20','1',NULL,'Field Header',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWCOBNPMEXZ0','50','D','20','2',NULL,'Event Type',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWCOBNPMEXZ0','50','D','20','3',NULL,'Event Date',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWCOBNPMEXZ0','50','D','20','4',NULL,'Enrollment Date',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWCOBNPMEXZ0','50','D','20','5',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWCOBNPMEXZ0','50','D','20','6',NULL,'Employee Name',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWCOBNPMEXZ0','50','D','20','7',NULL,'Second Event Original FDOC',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWCOBNPMEXZ0','50','D','30','1',NULL,'Field Header',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWCOBNPMEXZ0','50','D','30','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWCOBNPMEXZ0','50','D','30','3',NULL,'Coverage Level',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWCOBNPMEXZ0','50','D','30','4',NULL,'Number Of Units',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWCOBNPMEXZ0','50','D','40','1',NULL,'Field Header',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWCOBNPMEXZ0','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWCOBNPMEXZ0','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWCOBNPMEXZ0','50','D','40','4',NULL,'Salutation',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWCOBNPMEXZ0','50','D','40','5',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWCOBNPMEXZ0','50','D','40','6',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWCOBNPMEXZ0','50','D','40','7',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWCOBNPMEXZ0','50','D','40','8',NULL,'Email',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWCOBNPMEXZ0','50','D','40','9',NULL,'Phone',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWCOBNPMEXZ0','50','D','40','10',NULL,'Phone 2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWCOBNPMEXZ0','50','D','40','11',NULL,'Address Same As QB',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWCOBNPMEXZ0','50','D','40','12',NULL,'Address 1',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWCOBNPMEXZ0','50','D','40','13',NULL,'Address 2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWCOBNPMEXZ0','50','D','40','14',NULL,'City',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWCOBNPMEXZ0','50','D','40','15',NULL,'State Or Province',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWCOBNPMEXZ0','50','D','40','16',NULL,'Postal Code',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWCOBNPMEXZ0','50','D','40','17',NULL,'Country',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWCOBNPMEXZ0','50','D','40','18',NULL,'Enrollment Date',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWCOBNPMEXZ0','50','D','40','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWCOBNPMEXZ0','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWCOBNPMEXZ0','50','D','40','21',NULL,'Is QMCSO',NULL,NULL,'"FALSE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWCOBNPMEXZ0','50','D','50','1',NULL,'Field Header',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWCOBNPMEXZ0','50','D','50','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWCOBNPMEXZ0','50','D','60','1',NULL,'Field Header',NULL,NULL,'"drvFieldHeader"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWCOBNPMEXZ0','50','D','60','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWCOBNPMEXZ0','50','D','60','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EWCOBNPMEXZ0','50','D','70','1',NULL,'Field Header',NULL,NULL,'"[NPM]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EWCOBNPMEXZ0','50','D','70','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EWCOBNPMEXZ0','50','D','70','3',NULL,'Individual Identifier',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EWCOBNPMEXZ0','50','D','70','4',NULL,'Client Name',NULL,NULL,'"Lawrys Restaurants Inc 42801"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EWCOBNPMEXZ0','50','D','70','5',NULL,'Client DivisionName',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EWCOBNPMEXZ0','50','D','70','6',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EWCOBNPMEXZ0','50','D','70','7',NULL,'Middle Initial',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EWCOBNPMEXZ0','50','D','70','8',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EWCOBNPMEXZ0','50','D','70','9',NULL,'Salutation',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EWCOBNPMEXZ0','50','D','70','10',NULL,'Email',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EWCOBNPMEXZ0','50','D','70','11',NULL,'Phone',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EWCOBNPMEXZ0','50','D','70','12',NULL,'Phone 2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EWCOBNPMEXZ0','50','D','70','13',NULL,'Address 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EWCOBNPMEXZ0','50','D','70','14',NULL,'Address 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EWCOBNPMEXZ0','50','D','70','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EWCOBNPMEXZ0','50','D','70','16',NULL,'State Or Province',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EWCOBNPMEXZ0','50','D','70','17',NULL,'Postal Code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EWCOBNPMEXZ0','50','D','70','18',NULL,'Country',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EWCOBNPMEXZ0','50','D','70','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EWCOBNPMEXZ0','50','D','70','20',NULL,'Uses Family In Address',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EWCOBNPMEXZ0','50','D','70','21',NULL,'Has Waived All Coverage',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EWCOBNPMEXZ0','50','D','70','22',NULL,'Send GR Notice',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EWCOBNPMEXZ0','50','D','70','23',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EWCOBNPMEX_20230110.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202209029','EMPEXPORT','OEACTIVE','May 12 2021  2:35PM','EWCOBNPMEX',NULL,NULL,NULL,'202209029','May 11 2021  3:59PM','May 11 2021  3:59PM','202201011','300','','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202209029','EMPEXPORT','OEPASSIVE','May 12 2021  2:36PM','EWCOBNPMEX',NULL,NULL,NULL,'202209029','May 11 2021  3:59PM','May 11 2021  3:59PM','202201011','300','','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Discovery QB and NPM Export','202209029','EMPEXPORT','ONDEM_XOE','May 12 2021  2:37PM','EWCOBNPMEX',NULL,NULL,NULL,'202209029','May 11 2021  3:59PM','May 11 2021  3:59PM','202201011','300','','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',QFQBY,QFOKB,QFQEM',NULL,NULL,NULL,'Wex Cobra/Npm Export','202301109','EMPEXPORT','SCH_EWCOBN','May 12 2021  2:38PM','EWCOBNPMEX',NULL,NULL,NULL,'202301109','May 11 2021  3:59PM','May 11 2021  3:59PM','202301101','300','','','202301101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','QFQEM,QFQBY,QFOKB',NULL,NULL,NULL,'Discovery QB and NPM Exp-Test','202301101','EMPEXPORT','TEST_XOE','Jan 10 2023 12:00AM','EWCOBNPMEX',NULL,NULL,NULL,'202301101','Jan 10 2023 12:00AM','Jan  3 2023 12:00AM','202212011','5','','','202212011',dbo.fn_GetTimedKey(),NULL,'us3cPeLAW1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWCOBNPMEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWCOBNPMEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWCOBNPMEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWCOBNPMEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWCOBNPMEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWCOBNPMEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWCOBNPMEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWCOBNPMEX','D10','dbo.U_EWCOBNPMEX_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWCOBNPMEX','D20','dbo.U_EWCOBNPMEX_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWCOBNPMEX','D30','dbo.U_EWCOBNPMEX_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWCOBNPMEX','D40','dbo.U_EWCOBNPMEX_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWCOBNPMEX','D50','dbo.U_EWCOBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWCOBNPMEX','D60','dbo.U_EWCOBNPMEX_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWCOBNPMEX','D70','dbo.U_EWCOBNPMEX_drvTbl_NPM',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EWCOBNPMEX
-----------

IF OBJECT_ID('U_dsi_BDM_EWCOBNPMEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EWCOBNPMEX] (
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
-- Create table U_EWCOBNPMEX_Audit
-----------

IF OBJECT_ID('U_EWCOBNPMEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_Audit] (
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
-- Create table U_EWCOBNPMEX_AuditFields
-----------

IF OBJECT_ID('U_EWCOBNPMEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EWCOBNPMEX_DedList
-----------

IF OBJECT_ID('U_EWCOBNPMEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EWCOBNPMEX_drvTbl_NPM
-----------

IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_drvTbl_NPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvSSN] char(11) NULL,
    [drvClientDivisionName] varchar(10) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvHireDate] datetime NULL
);

-----------
-- Create table U_EWCOBNPMEX_drvTbl_QB
-----------

IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvClientDivisionName] varchar(10) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvSex] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvEmployeePayrollType] varchar(6) NOT NULL
);

-----------
-- Create table U_EWCOBNPMEX_drvTbl_QBDEPENDENT
-----------

IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(31) NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSex] char(1) NULL,
    [drvDateOfBirth] datetime NULL
);

-----------
-- Create table U_EWCOBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL
-----------

IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(30) NULL,
    [drvPlanName] varchar(30) NULL
);

-----------
-- Create table U_EWCOBNPMEX_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL
);

-----------
-- Create table U_EWCOBNPMEX_drvTbl_QBPLANINITIAL
-----------

IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanName] varchar(30) NULL,
    [drvCoverageLevel] varchar(18) NULL
);

-----------
-- Create table U_EWCOBNPMEX_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
-----------

IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvFieldHeader] varchar(33) NOT NULL,
    [drvPlanName] varchar(7) NULL,
    [drvRate] nvarchar(4000) NULL
);

-----------
-- Create table U_EWCOBNPMEX_EEList
-----------

IF OBJECT_ID('U_EWCOBNPMEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EWCOBNPMEX_File
-----------

IF OBJECT_ID('U_EWCOBNPMEX_File') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EWCOBNPMEX_PDedHist
-----------

IF OBJECT_ID('U_EWCOBNPMEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_PDedHist] (
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
-- Create table U_EWCOBNPMEX_PEarHist
-----------

IF OBJECT_ID('U_EWCOBNPMEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EWCOBNPMEX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWCOBNPMEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Lawry's

Created By: James Bender
Business Analyst: Julie Reardon
Create Date: 6/1/2022
Service Request Number: TekP-2021-11-19-0001

Purpose: @FixedFormatName1

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        12/06/2022     TekP-2021-11-19-0001  Update code for Death scenario

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWCOBNPMEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWCOBNPMEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWCOBNPMEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWCOBNPMEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWCOBNPMEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWCOBNPMEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWCOBNPMEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWCOBNPMEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWCOBNPMEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWCOBNPMEX', 'SCH_EWCOBN';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWCOBNPMEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EWCOBNPMEX', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCde        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCde = 'EWCOBNPMEX';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCde;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EWCOBNPMEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWCOBNPMEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);



     --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EWCOBNPMEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_AuditFields;
    CREATE TABLE dbo.U_EWCOBNPMEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    
    INSERT INTO dbo.U_EWCOBNPMEX_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EWCOBNPMEX_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EWCOBNPMEX_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_EWCOBNPMEX_AuditFields VALUES ('EmpDed','eedBenStartDate');
    INSERT INTO dbo.U_EWCOBNPMEX_AuditFields VALUES ('EmpDed','eedBenOption');
    INSERT INTO dbo.U_EWCOBNPMEX_AuditFields VALUES ('EmpDed','eedDedCode');


    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EWCOBNPMEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_Audit;
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
    INTO dbo.U_EWCOBNPMEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EWCOBNPMEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN dateadd(D, -14, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EWCOBNPMEX_Audit ON dbo.U_EWCOBNPMEX_Audit (audEEID,audKey2);
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN,DPPO,MEDCA,MEDNV,MEDT2,MEDKB,125V,MFSA';

    IF OBJECT_ID('U_EWCOBNPMEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EWCOBNPMEX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCde;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'BuildConsolidatedTable','Standard');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)


    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'RelationshipsChild', 'CHL,DA,DPC,STC'); -- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'RelationshipsDomPartner','DP'); -- update to the domestic partner relationship code


    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCde;

    
    --==========================================
    --NPM Section
    --==========================================

    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCde;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCde,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'AddToPreviousRun','Y');  -- only used for NPM/QB combined files
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCde, 'GetChangeReason', 'Y')

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCde,'OEType','ACTIVE');
    END;


    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCde;



    ---==========================================
 --   -- Insert into BDM Reason code 201 and 204
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EWCOBNPMEX]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
    )
    Select rectype = 'DEP'
        ,DbnCoid
        ,DbnEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 204 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,DbnDedCode
        ,DbnBenOption
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,DbnBenStatusDate
        ,DbnBenStatusDate
        ,'204'
        ,'204'
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,'Y'
    FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    JOIN dbo.emphded WITH (NOLOCK)
        ON dbneeid = edheeid 
    WHERE edhChangeReason IN ('204') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND dbnformatcode = 'EWCOBNPMEX'

    INSERT INTO [dbo].[U_dsi_BDM_EWCOBNPMEX]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
    )
    Select rectype = 'DEP'
        ,DbnCoid
        ,DbnEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,DbnDedCode
        ,DbnBenOption
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,DbnBenStatusDate
        ,DbnBenStatusDate
        ,'201'
        ,'201'
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,'Y'
    FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    JOIN dbo.emphded WITH (NOLOCK)
        ON dbneeid = edheeid 
    WHERE edhChangeReason IN ('201') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
        AND dbnformatcode = 'EWCOBNPMEX'



        --====================================================
 --   -- Insert into BDM Reason  (Death)
 --            SPS or 1st child is EMP
 --=====================================================
        
        INSERT INTO [dbo].[U_dsi_BDM_EWCOBNPMEX]
        (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmIsCobraCovered]
           ,[BdmSessionID]
        )
        Select Distinct 
         rectype = CASE WHEN ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEEID, EdhDedCode, ConRelationship desc) = 1 THEN 'EMP' ELSE 'DEP' END
            ,EdhCoid
            ,EdhEEID
            ,BdmDepRecID = consystemID
            ,consystemID
            ,BdmRunID = 'QB'
            ,BdmDedRowStatus='Data Inserted for 200/203 (Death)'
            ,ConRelationship
            ,ConDateOfBirth
            ,EdhDedCode
            ,EdhBenOption
            ,EdhBenStatus
            ,EdhBenStartDate
            ,EdhBenStopDate
            ,EdhBenStatusDate
            ,EecDateofTermination
            ,BdmChangeReason ='210' 
            ,BdmCobraReason ='203'
            ,BdmStartDate =EdhStartDate 
            ,BdmStopDate =EdhBenStopDate
            ,BdmIsPQB ='Y'
            ,BdmIsCobraCovered='Y'
            , BdmSessionID = ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEEID, EdhDedCode, ConRelationship desc)
            FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EWCOBNPMEX'
        AND edhChangeReason IN ('200')
        AND dbnValidForExport = 'N'
    JOIN dbo.U_EWCOBNPMEX_Audit WITH (NOLOCK)
        ON audEEID = dbneeid
        AND audKey2 = DbnCoID
        AND audFieldName = 'EecDateofTermination'
        AND audNewValue is not null
        and audDateTime BETWEEN @startdate AND @enddate
    JOIN EmpComp WITH (NOLOCK)
        ON dbnEEID = EecEEID
        AND EecTermReason IN ('203', '0803', '210')
        AND DbnBenStatus = 'T'
        AND EecEmplStatus = 'T'
    JOIN dbo.contacts WITH (NOLOCK)
            ON ConEEID = edheeid 
            AND ConRelationship in ('CHL','DIS', 'DPC','STC','DP','SPS')
        Order by dbo.EmpHDed.EdhEEID, dbo.EmpHDed.EdhDedCode, dbo.contacts.ConRelationship desc

    Delete from dbo.U_dsi_BDM_EWCOBNPMEX where bdmdedcode not in (Select dedcode from U_EWCOBNPMEX_DedList)


    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EWCOBNPMEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_PDedHist;
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
    INTO dbo.U_EWCOBNPMEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EWCOBNPMEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EWCOBNPMEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_PEarHist;
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
    INTO dbo.U_EWCOBNPMEX_PEarHist
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

    DELETE dbo.U_dsi_BDM_EWCOBNPMEX 
    WHERE BdmRunId = 'QB'
        AND BdmBenStatus = 'C'
    ---------------------------------
    -- DETAIL RECORD - U_EWCOBNPMEX_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = bdmDepRecId--CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 1'--EdhChangeReason + ' ' + ConNameFirst -- '1 ' + xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvClientDivisionName =    CASE WHEN EecCOID = 'QFQEM' THEN 'Nevada'
                                    WHEN EecCOID = 'QFQBY' THEN 'Texas'
                                    WHEN EecCOID = 'QFOKB' THEN 'California'
                                    END
        ,drvNameFirst = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' ) THEN ConNameFirst 
                             WHEN Bdmrelationship = 'EMP' THEN EepNameFirst END
        ,drvNameMiddle = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' ) THEN LEFT(ConNameMiddle,1) 
                              WHEN Bdmrelationship = 'EMP' THEN    LEFT(EepNameMiddle,1) END
        ,drvNameLast = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' )  THEN ConNameLast 
                            WHEN Bdmrelationship = 'EMP' THEN    EepNameLast END
        ,drvSSN = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' ) THEN ConSSN 
                       WHEN Bdmrelationship = 'EMP' THEN  eepSSN END
        ,drvAddressLine1 = REPLACE(CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' )THEN ConAddressLine1 WHEN Bdmrelationship = 'EMP' THEN   EepAddressLine1 END, ',', '')
        ,drvAddressLine2 = REPLACE(CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' )THEN ConAddressLine2 WHEN Bdmrelationship = 'EMP' THEN   EepAddressLine2 END, ',','')
        ,drvAddressCity = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' )THEN ConAddressCity WHEN Bdmrelationship = 'EMP' THEN   EepAddressCity END
        ,drvAddressState = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' )THEN ConAddressState WHEN Bdmrelationship = 'EMP' THEN   EepAddressState END
        ,drvAddressZipCode = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' )THEN ConAddressZipCode WHEN Bdmrelationship = 'EMP' THEN   EepAddressZipCode END
        ,drvSex =    CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' )THEN 
                        CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
                    ELSE CASE WHEN Bdmrelationship = 'EMP' and EepGender IN ('M','F') THEN EepGender ELSE 'U' END
                    END
        ,drvDateOfBirth = CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' )THEN ConDateOfBirth WHEN Bdmrelationship = 'EMP' THEN EepDateOfBirth END
        ,drvEmployeePayrollType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'SALARY' ELSE 'HOURLY' END
    INTO dbo.U_EWCOBNPMEX_drvTbl_QB
    FROM dbo.U_EWCOBNPMEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EWCOBNPMEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        AND BdmIsPQB = 'Y'
        --AND BdmBenStatus <> 'C'
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable(@DedList)) 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    Where (CASE WHEN EdhChangeReason IN ('201','302','LEVNT4','204','210','LEVNT3') OR (BdmCobraReason IN ('203','0803') and BdmSessionID = '1' ) THEN ConNameFirst 
                             WHEN BdmRecType = 'EMP' and Bdmrelationship = 'EMP' THEN EepNameFirst END is not null)
                                AND (Left(eepssn, 3) Not in ('999','888')  or  Left(conssn, 3) Not in ('999','888'))
                             
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWCOBNPMEX_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvEventType =    CASE WHEN BchIsCobraQualifiedEvent = 'Y' THEN
                            CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') AND EecTermType = 'V' THEN 'TERMINATION'
                            WHEN EecEmplStatus ='T' AND EecTermReason IN ('203', '0803') THEN 'DEATH'
                            WHEN EdhChangeReason = '208' OR (EecEmplStatus = 'T' AND EecTermReason IN ('202','0619','0801')) THEN 'RETIREMENT'
                            WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'INVOLUNTARYTERMINATION'
                            WHEN EdhChangeReason = '205' THEN 'MEDICARE'
                            WHEN EdhChangeReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                            WHEN EdhChangeReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                            WHEN EdhChangeReason IN ('203','202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                            WHEN EdhChangeReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'                            
                            END
                        END
        ,drvEventDate =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN EecDateOfTermination
                        WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') AND ISNULL(EepDateOfCOBRAEvent, '') = '' THEN EecDateOfTermination
                        WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') THEN EdhEffDate
                        ELSE eepDateOfCOBRAEvent
                        --EdhChangeReason IN ('LEVNT3','LEVNT4','204','201') THEN EdhEffDate
                        --ELSE EepDateOfCOBRAEvent
                        END
        ,drvEnrollmentDate = BdmBenStartDate 
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeName = EepNameFirst + ' ' + EepNameLast
    INTO dbo.U_EWCOBNPMEX_drvTbl_QBEVENT
    FROM dbo.U_EWCOBNPMEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN (
            SELECT
                 BdmEEID
                ,BdmCoID
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
              FROM dbo.U_dsi_BDM_EWCOBNPMEX WITH (NOLOCK)
              WHERE BdmRunId = 'QB'
              GROUP BY BdmEEID, BdmCoID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID        
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable(@DedList)) 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID
        Where     Left(eepssn, 3) Not in ('999','888')  
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWCOBNPMEX_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_drvTbl_QBPLANINITIAL;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 3'
        -- standard fields above and additional driver fields below

        ,drvPlanName =    CASE WHEN BdmDedCode = 'DEN' THEN 'Aetna Dental DHMO'
                        WHEN BdmDedCode = 'DPPO' THEN 'Aetna Dental DPPO'                        
                        WHEN BdmDedCode = 'MEDCA' AND BdmBenOption IN ('AHPSL1','AHPSL2','AHPSL3','AHPSL4','AHPSL5','AHPSL6','AHPSL7','APOHR6','APOSL1','APOSL2','APOSL3','APOSL4','APOSL5','APOSL6') THEN 'Aetna Med OA PPO HDHP CA/IL/NV'
                        WHEN BdmDedCode = 'MEDCA' AND BdmBenOption IN ('AHMCH1','AHMCH2','AHMCH3','AHMCH4','AHMCH5','AHMCH6','AHMCH7','AHMCS1','AHMCS2','AHMCS3','AHMCS4','AHMCS5','AHMCS6') THEN 'Aetna Med HMO CA'
                        WHEN BdmDedCode = 'MEDNV' AND BdmBenOption IN ('HHMOH1','HHMOH2','HHMOH3','HHMOH4','HHMOH5','HHMOH6','HHMOH7','HHMOS1','HHMOS2','HHMOS3','HHMOS4','HHMOS5','HHMOS6','HHMOS7') THEN 'Aetna Med HMO IL/NV'
                        WHEN BdmDedCode = 'MEDNV' AND BdmBenOption IN ('HPONH1','HPONH2','HPONH3','HPONH4','HPONH5','HPONH6','HPONH7','HPONS1','HPONS2','HPONS3','HPONS4','HPONS5','HPONS6','HPONS7') THEN 'Aetna Med OA PPO HDHP CA/IL/NV'                        
                        WHEN BdmDedCode = 'MEDT2' THEN 'Aetna Med OA PPO HDHP TX'
                        WHEN BdmDedCode = 'MEDKB' THEN 'Kaiser CA Med HSA HMO 4500 CA'
                        WHEN BdmDedCode = '125V' THEN 'VSP Vision'
                        WHEN BdmDedCode = 'MFSA' THEN 'Wex FSA'
                        END
         ,drvCoverageLevel =    CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                WHEN bdmChangeReason IN ('204','LEVNT4','201','LEVNT3','210')  THEN 
                                CASE WHEN bdmChangeReason IN ('204','LEVNT4','201','LEVNT3','210') and (SELECT  COUNT(distinct BdmDepRecID) FROM dbo.U_dsi_BDM_EWCOBNPMEX B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('SPS')) = 1 AND (SELECT COUNT(distinct BdmDepRecID) FROM dbo.U_dsi_BDM_EWCOBNPMEX B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID  AND B.BdmRelationship IN ('CHL','DPC','STC','DCH')) = 1 THEN 'EE+CHILD'
                                WHEN bdmChangeReason IN ('204','LEVNT4','201','LEVNT3','210') AND (SELECT COUNT(distinct BdmDepRecID) FROM dbo.U_dsi_BDM_EWCOBNPMEX B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('SPS')) = 1 AND (SELECT  COUNT(distinct BdmDepRecID) FROM dbo.U_dsi_BDM_EWCOBNPMEX B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN'
                                WHEN bdmChangeReason IN ('204','LEVNT4','201','LEVNT3','210') AND  (SELECT  COUNT(distinct BdmDepRecID) FROM dbo.U_dsi_BDM_EWCOBNPMEX B WITH (NOLOCK) WHERE A.BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('CHL','DPC','STC','DCH')) > 1 THEN 'EE+CHILDREN'
                                ELSE 'EE'
                                END
                            ELSE
                                CASE WHEN BdmBenOption IN ('EE','ADMEE','ADPEE','NDMEE','NDPEE','AHMCH1','AHMCS1','AHPSL1','APOHR1','APOSL1','KABZ1','HHMOH1','HHMOS1','HPONH1','HPONS1') THEN 'EE'
                                WHEN BdmBenOption IN ('EE1','ADMEE1','ADPEE1','NDMEE1','NDPEE1','AHMCH3','AHMCH4','AHMCH7','AHMCS3','AHMCS4','AHMCS5','AHPSL3','AHPSL4','APOHR3','APOHR4','APOSL3','APOSL4','KABZ2','HHMOH2','HHMOH4','HHMOS2','HHMOS4','HPONH2','HPONH4','HPONS2','HPONS4') THEN 'EE+1'
                                WHEN BdmBenOption IN ('EEC') THEN 'EE+CHILDREN'
                                WHEN BdmBenOption IN ('EEDP') THEN 'EE+DOMESTICPARTNER'
                                WHEN BdmBenOption IN ('EEDPC','EEDPDC','EEF','ADMEEF','ADPEEF','NDMEE2','NDPEEF','AHMCH2','AHMCH5','AHMCH6','AHMCS2','AHMCS6','AHPSL2','AHPSL5','AHPSL6','APOHR2','APOHR5','APOHR6','APOSL2','APOSL5','APOSL6','KABZ3','HHMOH3','HHMOH5','HHMOH6','HHMOS3','HHMOS5','HHMOS6','HPONH3','HPONH5','HPONH6','HPONS3','HPONS5','HPONS6') THEN 'EE+FAMILY'
                                END
                            END
    INTO dbo.U_EWCOBNPMEX_drvTbl_QBPLANINITIAL
    FROM dbo.U_EWCOBNPMEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EWCOBNPMEX A WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
    LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('DEN,DPPO,MEDCA,MEDNV,MEDT2,MEDKB,125V,MFSA')) 
                        AND edhChangeReason IN ('208','204','LEVNT4','205','201','302','LEVNT3', '203','202','206','200')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID 
        Where      Left(eepssn, 3) Not in ('999','888') 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWCOBNPMEX_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 4 ' +  + BdmDepRecID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvSSN = ConSSN
        ,drvRelationship =    CASE WHEN ConRelationship IN ('CHL','CHD','DPC','STC') THEN 'CHILD'
                                WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                            END
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvNameLast = ConNameLast
        ,drvSex = ConGender -- CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvDateOfBirth = ConDateOfBirth
    INTO dbo.U_EWCOBNPMEX_drvTbl_QBDEPENDENT
    FROM dbo.U_EWCOBNPMEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EWCOBNPMEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = bdmEEID
        AND ConSystemID = BdmDepRecID
    Where ltrim(rtrim(isnull(bdmDepRecId,''))) not in (Select ltrim(rtrim(ISNULL(drvDepRecID,''))) from  dbo.U_EWCOBNPMEX_drvTbl_QB )
        AND (Left(eepssn, 3) Not in ('999','888')  or  Left(conssn, 3) Not in ('999','888'))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWCOBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 4 ' + BdmDepRecID + '2'
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode = 'DEN' THEN 'Aetna Dental DHMO'
                        WHEN BdmDedCode = 'DPPO' THEN 'Aetna Dental DPPO'
                        WHEN BdmDedCode = 'MEDCA' AND BdmBenOption IN ('AHPSL1','AHPSL2','AHPSL3','AHPSL4','AHPSL5','AHPSL6','AHPSL7','APOHR6','APOSL1','APOSL2','APOSL3','APOSL4','APOSL5','APOSL6') THEN 'Aetna Med HMO CA'
                        WHEN BdmDedCode = 'MEDCA' AND BdmBenOption IN ('AHMCH1','AHMCH2','AHMCH3','AHMCH4','AHMCH5','AHMCH6','AHMCH7','AHMCS1','AHMCS2','AHMCS3','AHMCS4','AHMCS5','AHMCS6') THEN 'Aetna Med OA PPO HDHP CA/IL/NV'
                        WHEN BdmDedCode = 'MEDNV' AND BdmBenOption IN ('HHMOH1','HHMOH2','HHMOH3','HHMOH4','HHMOH5','HHMOH6','HHMOH7','HHMOS1','HHMOS2','HHMOS3','HHMOS4','HHMOS5','HHMOS6','HHMOS7') THEN 'Aetna Med HMO IL/NV'
                        WHEN BdmDedCode = 'MEDNV' AND BdmBenOption IN ('HPONH1','HPONH2','HPONH3','HPONH4','HPONH5','HPONH6','HPONH7','HPONS1','HPONS2','HPONS3','HPONS4','HPONS5','HPONS6','HPONS7') THEN 'Aetna Med OA PPO HDHP CA/IL/NV'                        
                        WHEN BdmDedCode = 'MEDT2' THEN 'Aetna Med OA PPO HDHP TX'
                        WHEN BdmDedCode = 'MEDKB' THEN 'Kaiser CA Med HSA HMO 4500 CA'
                        WHEN BdmDedCode = '125V' THEN 'VSP Vision'
                        WHEN BdmDedCode = 'MFSA' THEN 'Wex FSA'
                        END
    INTO dbo.U_EWCOBNPMEX_drvTbl_QBDEPENDENTPLANINITIAL
    FROM dbo.U_EWCOBNPMEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EWCOBNPMEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        AND BdmDedCode NOT IN ('FSA')
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmRecType = 'DEP'

             AND BdmCobraReason NOT IN ('201', 'LEVNT3')
           and ltrim(rtrim(isnull(bdmDepRecId,''))) not in (Select ltrim(rtrim(ISNULL(drvDepRecID,''))) from  dbo.U_EWCOBNPMEX_drvTbl_QB )
              AND (Left(eepssn, 3) Not in ('999','888')  or  Left(conssn, 3) Not in ('999','888'))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWCOBNPMEX_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1 ' + xEEID + ' 6'
        -- standard fields above and additional driver fields below
        ,drvFieldHeader = '[QBPLANMEMBERSPECIFICRATEINITIAL]'
        ,drvPlanName =    CASE WHEN BdmDedCode = 'MFSA' THEN 'Wex FSA' END
        ,drvRate =  CASE WHEN BdmDedCode IN ('MFSA') THEN FORMAT(BdmEEAmt, '#0.00') END
    INTO dbo.U_EWCOBNPMEX_drvTbl_QBPLANMEMBERSPECIFICRATEINITIAL
    FROM dbo.U_EWCOBNPMEX_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EWCOBNPMEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        --AND BdmDedCode IN ('FSA')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    WHERE BdmDedCode = 'MFSA'
        AND Left(eepssn, 3) Not in ('999','888')  
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EWCOBNPMEX_drvTbl_NPM
    ---------------------------------
    IF OBJECT_ID('U_EWCOBNPMEX_drvTbl_NPM','U') IS NOT NULL
        DROP TABLE dbo.U_EWCOBNPMEX_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID 
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvClientDivisionName =    CASE WHEN EecCOID = 'QFQEM' THEN 'Nevada'
                                    WHEN EecCOID = 'QFQBY' THEN 'Texas'
                                    WHEN EecCOID = 'QFOKB' THEN 'California'
                                    END
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvSex = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvHireDate = EecDateOfLastHire
    INTO dbo.U_EWCOBNPMEX_drvTbl_NPM
    FROM dbo.U_EWCOBNPMEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EWCOBNPMEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'NPM'
        AND BdmRelationship IN ('Emp','SPS','DP')
    --WHERE BdmBenStartDate BETWEEN @StartDate AND @EndDate
    Where  Left(eepssn, 3) Not in ('999','888')  
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCde,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCde,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCde;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEWCOBNPMEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWCOBNPMEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EWCOBNPMEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106291'
       ,expStartPerControl     = '202106291'
       ,expLastEndPerControl   = '202107309'
       ,expEndPerControl       = '202107309'
WHERE expFormatCode = 'EWCOBNPMEX'
AND ExpExportCode = 'TEST_XOE'
;

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWCOBNPMEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWCOBNPMEX_File (NOLOCK)
    ORDER BY  InitialSort, SubSort, RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EWCOBNPMEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EWCOBNPMEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EWCOBNPMEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWCOBNPMEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EWCOBNPMEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWCOBNPMEX', 'UseFileName', 'V', 'Y'


-- End ripout