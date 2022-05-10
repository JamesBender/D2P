/**********************************************************************************

ECWEXCOBRA: COBRA Newly Eligible Beneficiaries

FormatCode:     ECWEXCOBRA
Project:        COBRA Newly Eligible Beneficiaries
Client ID:      USG1000
Date/time:      2022-05-06 11:01:10.987
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_ECWEXCOBRA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECWEXCOBRA_SavePath') IS NOT NULL DROP TABLE dbo.U_ECWEXCOBRA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECWEXCOBRA'


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
WHERE FormatCode = 'ECWEXCOBRA'
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
WHERE ExpFormatCode = 'ECWEXCOBRA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECWEXCOBRA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECWEXCOBRA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECWEXCOBRA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECWEXCOBRA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECWEXCOBRA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECWEXCOBRA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECWEXCOBRA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECWEXCOBRA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECWEXCOBRA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECWEXCOBRA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECWEXCOBRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECWEXCOBRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECWEXCOBRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECWEXCOBRA];
GO
IF OBJECT_ID('U_ECWEXCOBRA_File') IS NOT NULL DROP TABLE [dbo].[U_ECWEXCOBRA_File];
GO
IF OBJECT_ID('U_ECWEXCOBRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECWEXCOBRA_EEList];
GO
IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATE') IS NOT NULL DROP TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATE];
GO
IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBDEPENDENTPLAN') IS NOT NULL DROP TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QBDEPENDENTPLAN];
GO
IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QB];
GO
IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_ECWEXCOBRA_drvTbl_NPM];
GO
IF OBJECT_ID('U_ECWEXCOBRA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECWEXCOBRA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECWEXCOBRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECWEXCOBRA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECWEXCOBRA','COBRA Newly Eligible Beneficiaries','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ECWEXCOBRAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECWEXCOBRAZ0','50','H','01','1',NULL,'Version Header',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECWEXCOBRAZ0','50','H','01','2',NULL,'Version Number',NULL,NULL,'"1.1"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECWEXCOBRAZ0','50','D','10','1',NULL,'QB Indicator',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECWEXCOBRAZ0','50','D','10','2',NULL,'Client Name ',NULL,NULL,'"Coalfire Systems Inc 43264"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECWEXCOBRAZ0','50','D','10','3',NULL,'Client Division Name',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECWEXCOBRAZ0','50','D','10','4',NULL,'Salutation ',NULL,NULL,'""','(SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECWEXCOBRAZ0','50','D','10','5',NULL,'First Name ',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECWEXCOBRAZ0','50','D','10','6',NULL,'Middle Initial ',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECWEXCOBRAZ0','50','D','10','7',NULL,'Last Name ',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECWEXCOBRAZ0','50','D','10','8',NULL,'SSN ',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECWEXCOBRAZ0','50','D','10','9',NULL,'Individual ID ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECWEXCOBRAZ0','50','D','10','10',NULL,'Email ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECWEXCOBRAZ0','50','D','10','11',NULL,'Phone ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECWEXCOBRAZ0','50','D','10','12',NULL,'Phone 2 ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECWEXCOBRAZ0','50','D','10','13',NULL,'Address 1 ',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECWEXCOBRAZ0','50','D','10','14',NULL,'Address 2 ',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECWEXCOBRAZ0','50','D','10','15',NULL,'City ',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECWEXCOBRAZ0','50','D','10','16',NULL,'State or Province ',NULL,NULL,'"drvStateorProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECWEXCOBRAZ0','50','D','10','17',NULL,'Postal Code ',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECWEXCOBRAZ0','50','D','10','18',NULL,'Country ',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECWEXCOBRAZ0','50','D','10','19',NULL,'Premium Address Same As Primary ',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECWEXCOBRAZ0','50','D','10','20',NULL,'Premium Address 1 ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECWEXCOBRAZ0','50','D','10','21',NULL,'Premium Address 2 ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECWEXCOBRAZ0','50','D','10','22',NULL,'Premium City ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECWEXCOBRAZ0','50','D','10','23',NULL,'Premium State Or Province ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECWEXCOBRAZ0','50','D','10','24',NULL,'Premium Postal Code ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECWEXCOBRAZ0','50','D','10','25',NULL,'Premium Country ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECWEXCOBRAZ0','50','D','10','26',NULL,'Sex ',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECWEXCOBRAZ0','50','D','10','27',NULL,'DOB ',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECWEXCOBRAZ0','50','D','10','28',NULL,'Tobacco Use ',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECWEXCOBRAZ0','50','D','10','29',NULL,'Employee Type ',NULL,NULL,'"FTE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECWEXCOBRAZ0','50','D','10','30',NULL,'Employee Payroll Type ',NULL,NULL,'"drvEmployeePayrollType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECWEXCOBRAZ0','50','D','10','31',NULL,'Years of Service ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECWEXCOBRAZ0','50','D','10','32',NULL,'Premium Coupon Type ',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECWEXCOBRAZ0','50','D','10','33',NULL,'Uses HCTC ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECWEXCOBRAZ0','50','D','10','34',NULL,'Active ',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECWEXCOBRAZ0','50','D','10','35',NULL,'Allow Member SSO ',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECWEXCOBRAZ0','50','D','10','36',NULL,'Benefit Group ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECWEXCOBRAZ0','50','D','10','37',NULL,'Account Structure ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECWEXCOBRAZ0','50','D','10','38',NULL,'Client Specific Data ',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECWEXCOBRAZ0','50','D','20','1',NULL,'QB Event Indicator',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECWEXCOBRAZ0','50','D','20','2',NULL,'Event Type',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECWEXCOBRAZ0','50','D','20','3',NULL,'Event Date',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECWEXCOBRAZ0','50','D','20','4',NULL,'Enrollment Date ',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECWEXCOBRAZ0','50','D','20','5',NULL,'Employee SSN ',NULL,NULL,'"drvEmployeeSSN "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECWEXCOBRAZ0','50','D','20','6',NULL,'Employee Name ',NULL,NULL,'"drvEmployeeName "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECWEXCOBRAZ0','50','D','20','7',NULL,'Second Event Original FDOC ',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECWEXCOBRAZ0','50','D','30','1',NULL,'QB Plan Indicator',NULL,NULL,'"[QBPLAN]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECWEXCOBRAZ0','50','D','30','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECWEXCOBRAZ0','50','D','30','3',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECWEXCOBRAZ0','51','D','30','4',NULL,'End Date',NULL,NULL,'""','(SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECWEXCOBRAZ0','52','D','30','5',NULL,'Coverage Level',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECWEXCOBRAZ0','53','D','30','6',NULL,'First Day Of COBRA',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECWEXCOBRAZ0','54','D','30','7',NULL,'Last Day Of COBRA',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECWEXCOBRAZ0','55','D','30','8',NULL,'COBRA Duration Months',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECWEXCOBRAZ0','56','D','30','9',NULL,'Days To Elect',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECWEXCOBRAZ0','57','D','30','10',NULL,'Days To Make 1st Payment',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECWEXCOBRAZ0','58','D','30','11',NULL,'Days To Make Subsequent Payments',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECWEXCOBRAZ0','59','D','30','12',NULL,'Election Postmark Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECWEXCOBRAZ0','60','D','30','13',NULL,'Last Date Rates Notified',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECWEXCOBRAZ0','61','D','30','14',NULL,'Number Of Units',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECWEXCOBRAZ0','62','D','30','15',NULL,'Send Plan Change Letter For Legacy',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECWEXCOBRAZ0','63','D','30','16',NULL,'Plan Bundle Name',NULL,NULL,'"drvPlanBundleName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECWEXCOBRAZ0','64','D','40','1',NULL,'QB Dependent',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECWEXCOBRAZ0','65','D','40','2',NULL,'SSN ',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECWEXCOBRAZ0','66','D','40','3',NULL,'Relationship ',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECWEXCOBRAZ0','67','D','40','4',NULL,'Salutation ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECWEXCOBRAZ0','68','D','40','5',NULL,'First Name ',NULL,NULL,'"drvConFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECWEXCOBRAZ0','69','D','40','6',NULL,'Middle Initial ',NULL,NULL,'"drvConNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECWEXCOBRAZ0','70','D','40','7',NULL,'Last Name ',NULL,NULL,'"drvConNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECWEXCOBRAZ0','71','D','40','8',NULL,'Email ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECWEXCOBRAZ0','72','D','40','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECWEXCOBRAZ0','73','D','40','10',NULL,'Phone 2 ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECWEXCOBRAZ0','74','D','40','11',NULL,'Address Same As QB ',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECWEXCOBRAZ0','75','D','40','12',NULL,'Address 1 ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECWEXCOBRAZ0','76','D','40','13',NULL,'Address 2 ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECWEXCOBRAZ0','77','D','40','14',NULL,'City ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECWEXCOBRAZ0','78','D','40','15',NULL,'State Or Province ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECWEXCOBRAZ0','79','D','40','16',NULL,'Postal Code ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECWEXCOBRAZ0','80','D','40','17',NULL,'Country ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECWEXCOBRAZ0','81','D','40','18',NULL,'Enrollment Date ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECWEXCOBRAZ0','82','D','40','19',NULL,'Sex ',NULL,NULL,'"drvConGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECWEXCOBRAZ0','83','D','40','20',NULL,'DOB ',NULL,NULL,'"drvConDateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECWEXCOBRAZ0','84','D','40','21',NULL,'Is QMCSO ',NULL,NULL,'"FALSE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECWEXCOBRAZ0','85','D','50','1',NULL,'QB Dependent Plan',NULL,NULL,'"[QBDEPENDENTPLAN]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECWEXCOBRAZ0','86','D','50','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECWEXCOBRAZ0','87','D','50','3',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECWEXCOBRAZ0','88','D','50','4',NULL,'End Date',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECWEXCOBRAZ0','89','D','50','5',NULL,'Uses FDOC',NULL,NULL,'"TRUE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECWEXCOBRAZ0','90','D','60','1',NULL,'QB Pan Member Specific Rate',NULL,NULL,'"[QBPLANMEMBERSPECIFICRATE]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECWEXCOBRAZ0','91','D','60','2',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECWEXCOBRAZ0','92','D','60','3',NULL,'Start Date ',NULL,NULL,'"drvStartDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECWEXCOBRAZ0','93','D','60','4',NULL,'End Date ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECWEXCOBRAZ0','94','D','60','5',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECWEXCOBRAZ0','95','D','70','1',NULL,'NPM Indicator',NULL,NULL,'" [NPM] "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECWEXCOBRAZ0','96','D','70','2',NULL,'SSN ',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECWEXCOBRAZ0','97','D','70','3',NULL,'Individual Identifier ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECWEXCOBRAZ0','98','D','70','4',NULL,'Client Name ',NULL,NULL,'"Coalfire Systems Inc 43264"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECWEXCOBRAZ0','99','D','70','5',NULL,'Client Division Name ',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECWEXCOBRAZ0','100','D','70','6',NULL,'First Name ',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECWEXCOBRAZ0','101','D','70','7',NULL,'Middle Initial ',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECWEXCOBRAZ0','102','D','70','8',NULL,'Last Name ',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECWEXCOBRAZ0','103','D','70','9',NULL,'Salutation ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECWEXCOBRAZ0','104','D','70','10',NULL,'Email ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECWEXCOBRAZ0','105','D','70','11',NULL,'Phone ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECWEXCOBRAZ0','106','D','70','12',NULL,'Phone 2 ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECWEXCOBRAZ0','107','D','70','13',NULL,'Address 1 ',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECWEXCOBRAZ0','108','D','70','14',NULL,'Address 2 ',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECWEXCOBRAZ0','109','D','70','15',NULL,'City ',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECWEXCOBRAZ0','110','D','70','16',NULL,'State Or Province ',NULL,NULL,'"drvStateOrProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECWEXCOBRAZ0','111','D','70','17',NULL,'Postal Code ',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECWEXCOBRAZ0','112','D','70','18',NULL,'Country ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECWEXCOBRAZ0','113','D','70','19',NULL,'Sex ',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECWEXCOBRAZ0','114','D','70','20',NULL,'Uses Family In Address ',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECWEXCOBRAZ0','115','D','70','21',NULL,'Has Waived All Coverage ',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECWEXCOBRAZ0','116','D','70','22',NULL,'Send GR Notice ',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECWEXCOBRAZ0','117','D','70','23',NULL,'Hire Date ',NULL,NULL,'"drvHireDate"','(''UD101''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECWEXCOBRA_20220506.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202205059','EMPEXPORT','OEACTIVE',NULL,'ECWEXCOBRA',NULL,NULL,NULL,'202205059','May  5 2022 12:05PM','May  5 2022 12:05PM','201004281',NULL,'','','201004281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202205059','EMPEXPORT','OEPASSIVE',NULL,'ECWEXCOBRA',NULL,NULL,NULL,'202205059','May  5 2022 12:05PM','May  5 2022 12:05PM','201004281',NULL,'','','201004281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'COBRA Newly Eligible Beneficia','202205059','EMPEXPORT','ONDEM_XOE',NULL,'ECWEXCOBRA',NULL,NULL,NULL,'202205059','May  5 2022 12:05PM','May  5 2022 12:05PM','201004281',NULL,'','','201004281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'COBRA Newly Eligible Ben-Sched','202205059','EMPEXPORT','SCH_ECWEXC',NULL,'ECWEXCOBRA',NULL,NULL,NULL,'202205059','May  5 2022 12:05PM','May  5 2022 12:05PM','201004281',NULL,'','','201004281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'COBRA Newly Eligible Ben-Test','202205059','EMPEXPORT','TEST_XOE',NULL,'ECWEXCOBRA',NULL,NULL,NULL,'202205059','May  5 2022 12:05PM','May  5 2022 12:05PM','201004281',NULL,'','','201004281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECWEXCOBRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECWEXCOBRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECWEXCOBRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECWEXCOBRA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECWEXCOBRA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECWEXCOBRA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECWEXCOBRA','D10','dbo.U_ECWEXCOBRA_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECWEXCOBRA','D20','dbo.U_ECWEXCOBRA_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECWEXCOBRA','D30','dbo.U_ECWEXCOBRA_drvTbl_QBPLAN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECWEXCOBRA','D40','dbo.U_ECWEXCOBRA_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECWEXCOBRA','D50','dbo.U_ECWEXCOBRA_drvTbl_QBDEPENDENTPLAN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECWEXCOBRA','D60','dbo.U_ECWEXCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECWEXCOBRA','D70','dbo.U_ECWEXCOBRA_drvTbl_NPM',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECWEXCOBRA
-----------

IF OBJECT_ID('U_dsi_BDM_ECWEXCOBRA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECWEXCOBRA] (
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
-- Create table U_ECWEXCOBRA_DedList
-----------

IF OBJECT_ID('U_ECWEXCOBRA_DedList') IS NULL
CREATE TABLE [dbo].[U_ECWEXCOBRA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECWEXCOBRA_drvTbl_NPM
-----------

IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_ECWEXCOBRA_drvTbl_NPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvClientDivisionName] varchar(20) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL
);

-----------
-- Create table U_ECWEXCOBRA_drvTbl_QB
-----------

IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvClientDivisionName] varchar(20) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateorProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvDOB] datetime NULL,
    [drvEmployeePayrollType] varchar(6) NOT NULL
);

-----------
-- Create table U_ECWEXCOBRA_drvTbl_QBDEPENDENT
-----------

IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvConFirstName] varchar(100) NULL,
    [drvConNameMiddle] varchar(1) NULL,
    [drvConNameLast] varchar(100) NULL,
    [drvConGender] varchar(1) NOT NULL,
    [drvConDateofBirth] datetime NULL
);

-----------
-- Create table U_ECWEXCOBRA_drvTbl_QBDEPENDENTPLAN
-----------

IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBDEPENDENTPLAN') IS NULL
CREATE TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QBDEPENDENTPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(31) NULL,
    [drvStartDate] datetime NULL
);

-----------
-- Create table U_ECWEXCOBRA_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL
);

-----------
-- Create table U_ECWEXCOBRA_drvTbl_QBPLAN
-----------

IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QBPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(31) NULL,
    [drvStartDate] datetime NULL,
    [drvEndDate] varchar(1) NOT NULL,
    [drvCoverageLevel] varchar(11) NOT NULL,
    [drvPlanBundleName] varchar(34) NULL
);

-----------
-- Create table U_ECWEXCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATE
-----------

IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATE') IS NULL
CREATE TABLE [dbo].[U_ECWEXCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(7) NULL,
    [drvStartDate] datetime NULL,
    [drvRate] money NULL
);

-----------
-- Create table U_ECWEXCOBRA_EEList
-----------

IF OBJECT_ID('U_ECWEXCOBRA_EEList') IS NULL
CREATE TABLE [dbo].[U_ECWEXCOBRA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECWEXCOBRA_File
-----------

IF OBJECT_ID('U_ECWEXCOBRA_File') IS NULL
CREATE TABLE [dbo].[U_ECWEXCOBRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECWEXCOBRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Coalfire Systems, Inc

Created By: Marie Waters
Business Analyst: Cheryl Petitti
Create Date: 05/05/2022
Service Request Number: TekP-2022-04-07-001

Purpose: COBRA Newly Eligible Beneficiaries

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECWEXCOBRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECWEXCOBRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECWEXCOBRA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECWEXCOBRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECWEXCOBRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECWEXCOBRA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECWEXCOBRA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECWEXCOBRA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECWEXCOBRA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECWEXCOBRA', 'SCH_ECWEXC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECWEXCOBRA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECWEXCOBRA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECWEXCOBRA';

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
    DELETE FROM dbo.U_ECWEXCOBRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECWEXCOBRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DNTH, DNTL, VISHP, VISON, MPPOM, MHDHP, MPPO, FSA, FSAL';

    IF OBJECT_ID('U_ECWEXCOBRA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECWEXCOBRA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECWEXCOBRA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================

    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- NPM parameters

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y' for types listed above

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','2'); -- All new enrollees where no previous plan exists

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file

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


    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
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


 
        
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y'); -- only used for NPM/QB combined files

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then BDMChangeReason. Include CHGRP for elig. ben groups – 

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – 

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); 

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee WHEN Cobra Reason is a dependent PQB reason – 
    
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee WHEN Cobra Reason is "Death".  

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used WHEN clients have Platform Configurable fields.  Client doesn’t use PCF fields.

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); --- update to the spouse relationship code

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH, DPC,STC');  -- update to the child relationship codes

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); --- update to the domestic partner relationship code
    
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard'); --- same for all files


       -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECWEXCOBRA_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_ECWEXCOBRA_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvClientDivisionName = CASE WHEN BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'Veris Group LLC'
                                      WHEN BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'Coalfire Systems Inc'
                                     END

        ,drvNameFirst     = CASE WHEN  BDMChangeReason IN ( '201', 'LEVNT3', '204', '210', 'LEVNT4')  THEN ConNamefirst ELSE EepNameFirst END
        ,drvNameMiddle    = CASE WHEN  BDMChangeReason IN ( '201', 'LEVNT3', '204', '210', 'LEVNT4')  THEN LEFT(Connamemiddle,1) ELSE LEFT(EepNameMiddle,1) END
        ,drvNameLast      = CASE WHEN  BDMChangeReason IN ( '201', 'LEVNT3', '204', '210', 'LEVNT4')  THEN ConnameLast ELSE  EepNameLast END
        ,drvSSN = eepSSN
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvStateorProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountry = EepAddressCountry
        ,drvGender = CASE WHEN  BDMChangeReason  IN ( '201', 'LEVNT3', '204', '210', 'LEVNT4') AND Congender = 'M' THEN 'M' 
                          WHEN  BDMChangeReason IN ( '201', 'LEVNT3', '204', '210', 'LEVNT4') AND Congender = 'F' THEN 'F' 
                          WHEN  BDMChangeReason IN ( '201', 'LEVNT3', '204', '210', 'LEVNT4') AND Congender NOT IN ( 'M', 'F') THEN 'U' 
                          ELSE 
                          CASE WHEN EepGender = 'M' THEN 'M' 
                               WHEN EepGender = 'F' THEN 'F'
                               Else 'U'
                            END
                        END
        ,drvDOB = CASE WHEN  BDMChangeReason IN ( '201', 'LEVNT3', '204', '210', 'LEVNT4') THEN condateofbirth ELSE EepDateOfBirth END
        ,drvEmployeePayrollType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'SALARY' ELSE 'HOURLY' END
    INTO dbo.U_ECWEXCOBRA_drvTbl_QB
    FROM dbo.U_ECWEXCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
            JOIN dbo.EmpComp WITH (NOLOCK)
        ON EEcEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECWEXCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'QB'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
        AND ConSystemID = BdmDepRecId
     ;
    ---------------------------------
    -- DETAIL RECORD - U_ECWEXCOBRA_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_ECWEXCOBRA_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEventType = CASE WHEN BDMChangeReason IN ('204' , 'LEVNT4')  THEN 'DIVORCELEGALSEPARATION'
                             WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DEATH' 
                             WHEN BDMChangeReason = '205' THEN 'MEDICARE'
                             WHEN BDMChangeReason IN ('201' , 'LEVNT3') THEN 'INELIGIBLEDEPENDENT' 
                             WHEN EecEmplStatus = 'T' and EecTermReason NOT IN ('202' , '203') and Eectermtype = 'V' THEN 'TERMINATION' 
                             WHEN (BDMChangeReason = '208' OR EecEmplStatus = 'T') AND EecTermReason = '202' THEN 'RETIREMENT'
                             WHEN BDMChangeReason IN ( '203' , '202') THEN 'REDUCTIONINHOURS-STATUSCHANGE' 
                             WHEN BDMChangeReason = '206' THEn 'REDUCTIONINHOURS-ENDOFLEAVE'
                             WHEN EecEmplStatus = 'T' AND Eectermtype = 'I' THEN 'INVOLUNTARYTERMINATION' 
                            END
        ,drvEventDate = CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ( '202', '203') THEN EecDateOfTermination
                             WHEN EecEmplStatus = 'T' AND EecTermReason IN ( '202', '203') AND (BdmDateOfCOBRAEvent = '' OR BdmDateOfCOBRAEvent is NULL) THEn EecDateOfTermination
                             WHEN BDMChangeReason IN  ( 'LEVNT3', 'LEVNT4', '204', '210', '201') THEN BdmBenStartDate
                             ELSE BdmDateOfCOBRAEvent
                            END
        ,drvEnrollmentDate = CASE WHEN BDMChangeReason IN  ( 'LEVNT3', 'LEVNT4', '204', '210', '201') THEN MAX(BdmBenStartDate)
                                  ELSE MAX( BdmBenStartDate)
                                 END
        ,drvEmployeeSSN  = Eepssn 
        ,drvEmployeeName  =  (Eepnamefirst + ' ' + Eepnamelast)
    INTO dbo.U_ECWEXCOBRA_drvTbl_QBEVENT
    FROM dbo.U_ECWEXCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECWEXCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    Group by xEEID
            ,xCoID
            ,BDMChangeReason
            ,EecEmplStatus
            ,EecTermReason
            ,EecTermType
            ,EecDateOfTermination
            ,BDMDateOfCOBRAEvent
            ,BdmBenStartDate
            ,eepSSN
            ,(Eepnamefirst + ' ' + Eepnamelast)

    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECWEXCOBRA_drvTbl_QBPLAN
    ---------------------------------
    IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_ECWEXCOBRA_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE WHEN BDMDedCode = 'DNTH' THEN 'Delta Dental CO Dental High'
                            WHEN BDMDedCode = 'DNTL' THEN 'Delta Dental CO Dental Low'
                            WHEN BDMDedCode = 'VISHP' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'VSP Vision High'
                            WHEN BDMDedCode = 'VISON' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'VSP Vision Low'
                            WHEN BDMDedCode = 'VISHP' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'VSP Vision High Veris'
                            WHEN BDMDedCode = 'VISON' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'VSP Vision Low Veris'
                            WHEN BDMDedCode = 'MPPOM' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'UHC Medical $1500 PPO Coalfire'
                            WHEN BDMDedCode = 'MHDHP' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'UHC Medical $3000 HDHP Coalfire'
                            WHEN BDMDedCode =' MPPO' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'UHC Medical $500 PPO Coalfire'
                            WHEN BDMDedCode = 'MPPOM' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'UHC Medical $1500 PPO Veris'
                            WHEN BDMDedCode = 'MHDHP' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'UHC Medical $3000 HDHP Veris'
                            WHEN BDMDedCode = 'MPPO' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'UHC Medical $500 PPO Veris'
                            WHEN BDMDedCode IN ('FSA', 'FSAL') THEN 'WEX FSA'
                        END


        ,drvStartDate = bdmbenstopdate + 1 
        ,drvEndDate = ''
        ,drvCoverageLevel = CASE WHEN BdmDedCode IN ( 'DNTH', 'DNTL', 'VISHP', 'VISON', 'MPPOM', 'MHDHP', 'MPPO')AND bdmBenOption = 'EE' THEN 'EE'
                                 WHEN BdmBenOption = 'EEC' THEN 'EE+CHILDREN'
                                 WHEN BdmBenOption IN('EEF', 'EEDPF') THEN 'EE+FAMILY'
                                 WHEN BdmDedCode IN ('FSA', 'FSAL') THEN 'EE'
                                 WHEN BDMChangeReason IN ( '204', 'LEVNT4', '201', 'LEVNT3', '210') AND bdmrelationship IN( 'DP', 'SPS') AND bdmrelationship  IN ( 'CHL', 'DCH', 'DPC', 'STC') THEN 'EE+CHILD' -- ??? bdmrelationship = DP, SPS and more than 1 CHL, DCH, DPC, STC THEN EE+CHILDREN
                                 WHEN bdmrelationship IN( 'DP', 'SPS') AND bdmrelationship  IN ( 'CHL', 'DCH', 'DPC', 'STC') THEN 'EE+CHILDREN'   ---?? more than 1 CHL, DCH, DPC, STC THEN EE+CHILDREN
                                 WHEN bdmrelationship IN ( 'CHL', 'DCH', 'DPC', 'STC') THEN 'EE+CHILDREN' --??   more than 1 CHL, DIS, DPC, STC THEN EE+CHILDREN
                                 ELSE 'EE'
                            END

        ,drvPlanBundleName = CASE WHEN BDMDedCode = 'MPPOM' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'UHC Med $1500 PPO/ESI Rx Coalfire'
                                  WHEN BDMDedCode = 'MHDHP' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'UHC Med $3000 HDHP/ESI Rx Coalfire'
                                  WHEN BDMDedCode = 'MPPO' AND  BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'UHC Med $500 PPO/ESI Rx Coalfire'
                                  WHEN BdmDedCode = 'MPPOM' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'UHC Med $1500 PPO/ESI Rx Veris'
                                  WHEN BDMDedCode = 'MHDHP' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'UHC Med $3000 HDHP/ESI Rx Veris'
                                  WHEN BDMDedCode = 'MPPO' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'UHC Med $500 PPO/ESI Rx Veris'
                                END
    INTO dbo.U_ECWEXCOBRA_drvTbl_QBPLAN
    FROM dbo.U_ECWEXCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECWEXCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECWEXCOBRA_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_ECWEXCOBRA_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = conssn 
        ,drvRelationship = CASE WHEN conrelationship in( 'CHL', 'DCH', 'DPC', 'STC') THEN 'CHILD'
                                WHEN conrelationship = 'SPS' THEN 'SPOUSE'
                                WHEN conrelationship = 'DP' THEN 'DOMESTICPARTNER'
                            END

        ,drvConFirstName = ConNameFirst
        ,drvConNameMiddle = LEFT(ConNameMiddle,1)
        ,drvConNameLast = ConNameLast
        ,drvConGender = CASE WHEN ConGender = 'M' THEn 'M'
                             WHEN ConGender = 'F' THEN 'F'
                             Else 'U'
                            END

        ,drvConDateofBirth = Condateofbirth
    INTO dbo.U_ECWEXCOBRA_drvTbl_QBDEPENDENT
    FROM dbo.U_ECWEXCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECWEXCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECWEXCOBRA_drvTbl_QBDEPENDENTPLAN
    ---------------------------------
    IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBDEPENDENTPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_ECWEXCOBRA_drvTbl_QBDEPENDENTPLAN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName =  CASE WHEN BDMDedCode = 'DNTH' THEN 'Delta Dental CO Dental High'
                             WHEN BDMDedCode = 'DNTL' THEN 'Delta Dental CO Dental Low'
                             WHEN BDMDedCode = 'VISHP' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'VSP Vision High'
                             WHEN BDMDedCode = 'VISON' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'VSP Vision Low'
                             WHEN BDMDedCode = 'VISHP' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'VSP Vision High Veris'
                             WHEN BDMDedCode = 'VISON' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'VSP Vision Low Veris'
                             WHEN BDMDedCode = 'MPPOM' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'UHC Medical $1500 PPO Coalfire'
                             WHEN BDMDedCode = 'MHDHP' AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'UHC Medical $3000 HDHP Coalfire'
                             WHEN BDMDedCode = 'MPPO'  AND BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'UHC Medical $500 PPO Coalfire'
                             WHEN BDMDedCode = 'MPPOM' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'UHC Medical $1500 PPO Veris'
                             WHEN BDMDedCode = 'MHDHP' AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'UHC Medical $3000 HDHP Veris'
                             WHEN BDMDedCode = 'MPPO'  AND BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'UHC Medical $500 PPO Veris'
                         END

        ,drvStartDate = Bdmbenstopdate + 1 
    INTO dbo.U_ECWEXCOBRA_drvTbl_QBDEPENDENTPLAN
    FROM dbo.U_ECWEXCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECWEXCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECWEXCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATE
    ---------------------------------
    IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATE','U') IS NOT NULL
        DROP TABLE dbo.U_ECWEXCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE WHEn BdmDedCode IN ('FSA', 'FSAL') THEN  'WEX FSA' END
        ,drvStartDate = Bdmbenstopdate + 1
        ,drvRate = CASE WHEN Bdmdedcode IN ('FSA', 'FSAL') THEN (BdmEEAmt * 24)/12  END ---multiplied by 24 (weeks) and divided by 12 (months) 

    INTO dbo.U_ECWEXCOBRA_drvTbl_QBPLANMEMBERSPECIFICRATE
    FROM dbo.U_ECWEXCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECWEXCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECWEXCOBRA_drvTbl_NPM
    ---------------------------------
    IF OBJECT_ID('U_ECWEXCOBRA_drvTbl_NPM','U') IS NOT NULL
        DROP TABLE dbo.U_ECWEXCOBRA_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = EepSSN
        ,drvClientDivisionName = CASE WHEN BdmCoID = 'T6L7H (Coalfire Federal)' THEN 'Veris Group LLC' 
                                      WHEN BdmCoID = 'T6LB7 (Coalfire Systems)' THEN 'Coalfire Systems Inc'
                                    END

        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvStateOrProvince = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvGender = CASE WHEN (Eepgender = 'M'  or ConGender = 'M' )  THEN 'M'
                          WHEN (Eepgender = 'F'  or ConGender = 'F' ) THEN 'F'
                          Else  'U'
                          END

        ,drvHireDate = EecDateOfLastHire
    INTO dbo.U_ECWEXCOBRA_drvTbl_NPM
    FROM dbo.U_ECWEXCOBRA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECWEXCOBRA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'NPM'
        LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
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
ALTER VIEW dbo.dsi_vwECWEXCOBRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECWEXCOBRA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECWEXCOBRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201004281'
       ,expStartPerControl     = '201004281'
       ,expLastEndPerControl   = '202205059'
       ,expEndPerControl       = '202205059'
WHERE expFormatCode = 'ECWEXCOBRA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECWEXCOBRA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECWEXCOBRA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECWEXCOBRA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECWEXCOBRA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECWEXCOBRA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECWEXCOBRA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECWEXCOBRA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECWEXCOBRA', 'UseFileName', 'V', 'Y'


-- End ripout