/**********************************************************************************

EMSHEDEMX3: Morneau Shepell Demograpic Export V3

FormatCode:     EMSHEDEMX3
Project:        Morneau Shepell Demograpic Export V3
Client ID:      REF1001
Date/time:      2022-02-23 10:13:44.443
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E43
Server:         E4SUP3DB01
Database:       ULTIPRO_RBUS
Web Filename:   REF1001_XAC7C_EEHISTORY_EMSHEDEMX3_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMSHEDEMX3_SavePath') IS NOT NULL DROP TABLE dbo.U_EMSHEDEMX3_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMSHEDEMX3'


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
WHERE FormatCode = 'EMSHEDEMX3'
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
WHERE ExpFormatCode = 'EMSHEDEMX3'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMSHEDEMX3')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMSHEDEMX3'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMSHEDEMX3'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMSHEDEMX3'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMSHEDEMX3'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMSHEDEMX3'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMSHEDEMX3'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMSHEDEMX3'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMSHEDEMX3'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMSHEDEMX3'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMSHEDEMX3_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMSHEDEMX3_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMSHEDEMX3') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMSHEDEMX3];
GO
IF OBJECT_ID('U_EMSHEDEMX3_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMSHEDEMX3_Trailer];
GO
IF OBJECT_ID('U_EMSHEDEMX3_File') IS NOT NULL DROP TABLE [dbo].[U_EMSHEDEMX3_File];
GO
IF OBJECT_ID('U_EMSHEDEMX3_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMSHEDEMX3_EEList];
GO
IF OBJECT_ID('U_EMSHEDEMX3_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMSHEDEMX3_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMSHEDEMX3','Morneau Shepell Demograpic Export V3','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EMSHEDEMX3Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMSHEDEMX3Z0','50','H','01','1',NULL,'EmployeeNo',NULL,NULL,'"EmployeeNo"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMSHEDEMX3Z0','50','H','01','2',NULL,'SocialNo',NULL,NULL,'"SocialNo"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMSHEDEMX3Z0','50','H','01','3',NULL,'FirstName',NULL,NULL,'"FirstName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMSHEDEMX3Z0','50','H','01','4',NULL,'LastName',NULL,NULL,'"LastName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMSHEDEMX3Z0','50','H','01','5',NULL,'Gender*',NULL,NULL,'"Gender*"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMSHEDEMX3Z0','50','H','01','6',NULL,'BirthDate',NULL,NULL,'"BirthDate"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMSHEDEMX3Z0','50','H','01','7',NULL,'Language',NULL,NULL,'"Language"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMSHEDEMX3Z0','50','H','01','8',NULL,'PhoneNumber',NULL,NULL,'"PhoneNumber"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMSHEDEMX3Z0','50','H','01','9',NULL,'AltNumber',NULL,NULL,'"AltNumber"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMSHEDEMX3Z0','50','H','01','10',NULL,'WorkPhone Number',NULL,NULL,'"WorkPhone Number"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMSHEDEMX3Z0','50','H','01','11',NULL,'EmployeeEmail',NULL,NULL,'"EmployeeEmail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMSHEDEMX3Z0','50','H','01','12',NULL,'WorkEmail',NULL,NULL,'"WorkEmail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMSHEDEMX3Z0','50','H','01','13',NULL,'WorkplaceLocation',NULL,NULL,'"WorkplaceLocation"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMSHEDEMX3Z0','50','H','01','14',NULL,'WorkplaceLocationAddress1',NULL,NULL,'"WorkplaceLocationAddress1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMSHEDEMX3Z0','50','H','01','15',NULL,'WorkplaceLocationAddress2',NULL,NULL,'"WorkplaceLocationAddress2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMSHEDEMX3Z0','50','H','01','16',NULL,'WorkplaceLocationCity',NULL,NULL,'"WorkplaceLocationCity"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMSHEDEMX3Z0','50','H','01','17',NULL,'WorkplaceLocationProvince',NULL,NULL,'"WorkplaceLocationProvince"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMSHEDEMX3Z0','50','H','01','18',NULL,'WorkplaceLocationPostal',NULL,NULL,'"WorkplaceLocationPostal"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMSHEDEMX3Z0','50','H','01','19',NULL,'WorkplaceLocationCountry',NULL,NULL,'"WorkplaceLocationCountry"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMSHEDEMX3Z0','50','H','01','20',NULL,'EmployeeAddress1',NULL,NULL,'"EmployeeAddress1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMSHEDEMX3Z0','50','H','01','21',NULL,'EmployeeAddress2',NULL,NULL,'"EmployeeAddress2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMSHEDEMX3Z0','50','H','01','22',NULL,'EmployeeCity',NULL,NULL,'"EmployeeCity"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMSHEDEMX3Z0','50','H','01','23',NULL,'EmployeeProvince',NULL,NULL,'"EmployeeProvince"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMSHEDEMX3Z0','50','H','01','24',NULL,'EmployeePostal',NULL,NULL,'"EmployeePostal"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMSHEDEMX3Z0','50','H','01','25',NULL,'EmployeeCountry',NULL,NULL,'"EmployeeCountry"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMSHEDEMX3Z0','50','H','01','26',NULL,'DateofHire',NULL,NULL,'"DateofHire"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMSHEDEMX3Z0','50','H','01','27',NULL,'EmployeeType',NULL,NULL,'"EmployeeType"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMSHEDEMX3Z0','50','H','01','28',NULL,'EmpWageCode',NULL,NULL,'"EmpWageCode"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMSHEDEMX3Z0','50','H','01','29',NULL,'EmpWage',NULL,NULL,'"EmpWage"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMSHEDEMX3Z0','50','H','01','30',NULL,'EmployeeUnion',NULL,NULL,'"EmployeeUnion"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMSHEDEMX3Z0','50','H','01','31',NULL,'JobTitleDesc',NULL,NULL,'"JobTitleDesc"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMSHEDEMX3Z0','50','H','01','32',NULL,'ARNotifyEmail',NULL,NULL,'"ARNotifyEmail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMSHEDEMX3Z0','50','H','01','33',NULL,'WCNotifyEmail',NULL,NULL,'"WCNotifyEmail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMSHEDEMX3Z0','50','H','01','34',NULL,'WCPayrollEmail',NULL,NULL,'"WCPayrollEmail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMSHEDEMX3Z0','50','H','01','35',NULL,'DMNotifyEmail',NULL,NULL,'"DMNotifyEmail"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMSHEDEMX3Z0','50','H','01','36',NULL,'ManagerEmployee ID',NULL,NULL,'"ManagerEmployee ID"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMSHEDEMX3Z0','50','H','01','37',NULL,'ManagerFirstName',NULL,NULL,'"ManagerFirstName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMSHEDEMX3Z0','50','H','01','38',NULL,'ManagerLastName',NULL,NULL,'"ManagerLastName"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMSHEDEMX3Z0','50','H','01','39',NULL,'ManagerPhone',NULL,NULL,'"ManagerPhone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMSHEDEMX3Z0','50','H','01','40',NULL,'ManagerEmail',NULL,NULL,'"ManagerEmail"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMSHEDEMX3Z0','50','D','10','1',NULL,'EmployeeNo',NULL,NULL,'"drvEmployeeNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMSHEDEMX3Z0','50','D','10','2',NULL,'SocialNo',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMSHEDEMX3Z0','50','D','10','3',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMSHEDEMX3Z0','50','D','10','4',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMSHEDEMX3Z0','50','D','10','5',NULL,'Gender*',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMSHEDEMX3Z0','50','D','10','6',NULL,'BirthDate',NULL,NULL,'"drvDateOfBirth"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMSHEDEMX3Z0','50','D','10','7',NULL,'Language',NULL,NULL,'"drvLanguage"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMSHEDEMX3Z0','50','D','10','8',NULL,'PhoneNumber',NULL,NULL,'"drvPhoneNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMSHEDEMX3Z0','50','D','10','9',NULL,'AltNumber',NULL,NULL,'"drvAltNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMSHEDEMX3Z0','50','D','10','10',NULL,'WorkPhone Number',NULL,NULL,'"drvWorkPhoneNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMSHEDEMX3Z0','50','D','10','11',NULL,'EmployeeEmail',NULL,NULL,'"drvEmployeeEmail1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMSHEDEMX3Z0','50','D','10','12',NULL,'EmployeeEmail',NULL,NULL,'"drvEmployeeEmail2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMSHEDEMX3Z0','50','D','10','13',NULL,'WorkplaceLocation',NULL,NULL,'"drvWorkplaceLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMSHEDEMX3Z0','50','D','10','14',NULL,'WorkplaceLocationAddress1',NULL,NULL,'"drvWorkAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMSHEDEMX3Z0','50','D','10','15',NULL,'WorkplaceLocationAddress2',NULL,NULL,'"drvWorkAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMSHEDEMX3Z0','50','D','10','16',NULL,'WorkplaceLocationCity',NULL,NULL,'"drvWorkAddressCit"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMSHEDEMX3Z0','50','D','10','17',NULL,'WorkplaceLocationProvince',NULL,NULL,'"drvWorkAddressProvince"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMSHEDEMX3Z0','50','D','10','18',NULL,'WorkplaceLocationPostal',NULL,NULL,'"drvWorkAddressPostal"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMSHEDEMX3Z0','50','D','10','19',NULL,'WorkplaceLocationCountry',NULL,NULL,'"drvWorkAddressCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMSHEDEMX3Z0','50','D','10','20',NULL,'EmployeeAddress1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMSHEDEMX3Z0','50','D','10','21',NULL,'EmployeeAddress2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMSHEDEMX3Z0','50','D','10','22',NULL,'EmployeeCity',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMSHEDEMX3Z0','50','D','10','23',NULL,'EmployeeProvince',NULL,NULL,'"drvAddressProvince"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMSHEDEMX3Z0','50','D','10','24',NULL,'EmployeePostal',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMSHEDEMX3Z0','50','D','10','25',NULL,'EmployeeCountry',NULL,NULL,'"drvAddressCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMSHEDEMX3Z0','50','D','10','26',NULL,'DateofHire',NULL,NULL,'"drvDateOfHire"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMSHEDEMX3Z0','50','D','10','27',NULL,'EmployeeType',NULL,NULL,'"drvEmployeeType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMSHEDEMX3Z0','50','D','10','28',NULL,'EmpWageCode',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMSHEDEMX3Z0','50','D','10','29',NULL,'EmpWage',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMSHEDEMX3Z0','50','D','10','30',NULL,'EmployeeUnion',NULL,NULL,'"drvEmployeeUnion"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMSHEDEMX3Z0','50','D','10','31',NULL,'JobTitleDesc',NULL,NULL,'"drvJobTitleDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMSHEDEMX3Z0','50','D','10','32',NULL,'ARNotifyEmail',NULL,NULL,'"drvARNotifyEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMSHEDEMX3Z0','50','D','10','33',NULL,'WCNotifyEmail',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMSHEDEMX3Z0','50','D','10','34',NULL,'WCPayrollEmail',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMSHEDEMX3Z0','50','D','10','35',NULL,'DMNotifyEmail',NULL,NULL,'"drvDMNotifyEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMSHEDEMX3Z0','50','D','10','36',NULL,'ManagerEmployee ID',NULL,NULL,'"drvMangerEmployeID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMSHEDEMX3Z0','50','D','10','37',NULL,'ManagerFirstName',NULL,NULL,'"drvManagerFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMSHEDEMX3Z0','50','D','10','38',NULL,'ManagerLastName',NULL,NULL,'"drvManagerLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMSHEDEMX3Z0','50','D','10','39',NULL,'ManagerPhone',NULL,NULL,'"drvManagerPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMSHEDEMX3Z0','50','D','10','40',NULL,'ManagerEmail',NULL,NULL,'"drvManagerEmail"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMSHEDEMX3Z0','50','T','90','1',NULL,'TrailerTag',NULL,NULL,'"TRL"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMSHEDEMX3Z0','50','T','90','2',NULL,'Run Date of the file',NULL,NULL,'"drvRunDateOfFile"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMSHEDEMX3Z0','50','T','90','3',NULL,'RecordCountTotal',NULL,NULL,'"drvRecordCountTotal"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMSHEDEMX3_20220223.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Morneau Shepell Demo Export','202201249','EMPEXPORT','ONDEM_XOE','Jan 24 2022 12:00AM','EMSHEDEMX3',NULL,NULL,NULL,'202201249','Jan 24 2022 12:00AM','Dec 30 1899 12:00AM','202201101',NULL,'','','202201101',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',CMCOX',NULL,NULL,NULL,'Morneau Shepell Demo-Wed 11pm','202011229','EMPEXPORT','SCH_EMSHED','Dec  3 2020 12:00AM','EMSHEDEMX3',NULL,NULL,NULL,'202111109','Nov 22 2020 12:00AM','Dec 30 1899 12:00AM','202111031',NULL,'','','202011221',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','CMCOX',NULL,NULL,NULL,'Morneau Shepell Demo Exp-Test','202201249','EMPEXPORT','TEST_XOE','Jan 24 2022  4:43PM','EMSHEDEMX3',NULL,NULL,NULL,'202201249','Jan 24 2022 12:00AM','Dec 30 1899 12:00AM','202201101','431','','','202201101',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMX3','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMX3','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMX3','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMX3','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMX3','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMSHEDEMX3','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMSHEDEMX3','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMSHEDEMX3','D10','dbo.U_EMSHEDEMX3_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMSHEDEMX3','T90','dbo.U_EMSHEDEMX3_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EMSHEDEMX3_drvTbl
-----------

IF OBJECT_ID('U_EMSHEDEMX3_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMSHEDEMX3_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(11) NOT NULL,
    [drvEmployeeNo] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvLanguage] char(2) NOT NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvAltNumber] varchar(50) NULL,
    [drvWorkPhoneNumber] varchar(50) NULL,
    [drvEmployeeEmail1] varchar(50) NULL,
    [drvEmployeeEmail2] varchar(50) NULL,
    [drvWorkplaceLocation] varchar(25) NULL,
    [drvWorkAddressLine1] varchar(255) NULL,
    [drvWorkAddressLine2] varchar(255) NULL,
    [drvWorkAddressCit] varchar(255) NULL,
    [drvWorkAddressProvince] varchar(255) NULL,
    [drvWorkAddressPostal] varchar(50) NULL,
    [drvWorkAddressCountry] varchar(3) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressProvince] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] varchar(3) NULL,
    [drvDateOfHire] datetime NULL,
    [drvEmployeeType] varchar(9) NULL,
    [drvEmployeeUnion] varchar(3) NOT NULL,
    [drvJobTitleDesc] varchar(25) NOT NULL,
    [drvARNotifyEmail] varchar(41) NULL,
    [drvDMNotifyEmail] varchar(50) NULL,
    [drvMangerEmployeID] char(9) NULL,
    [drvManagerFirstName] varchar(100) NULL,
    [drvManagerLastName] varchar(100) NULL,
    [drvManagerPhone] varchar(50) NULL,
    [drvManagerEmail] varchar(50) NULL
);

-----------
-- Create table U_EMSHEDEMX3_EEList
-----------

IF OBJECT_ID('U_EMSHEDEMX3_EEList') IS NULL
CREATE TABLE [dbo].[U_EMSHEDEMX3_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMSHEDEMX3_File
-----------

IF OBJECT_ID('U_EMSHEDEMX3_File') IS NULL
CREATE TABLE [dbo].[U_EMSHEDEMX3_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EMSHEDEMX3_Trailer
-----------

IF OBJECT_ID('U_EMSHEDEMX3_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMSHEDEMX3_Trailer] (
    [drvRunDateOfFile] datetime NOT NULL,
    [drvRecordCountTotal] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMSHEDEMX3]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco

Created By: James Bender
Business Analyst: Lea King/Richard Vars
Create Date: 11/22/2020
Service Request Number: TekP-2020-11-02-0001

Purpose: Morneau Shepell Demograpic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMSHEDEMX3';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMSHEDEMX3';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMSHEDEMX3';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMSHEDEMX3';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMSHEDEMX3' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSHEDEMX3', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSHEDEMX3', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMSHEDEMX3', 'SCH_EMSHED';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMSHEDEMX3', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMSHEDEMX3';

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
    DELETE FROM dbo.U_EMSHEDEMX3_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMSHEDEMX3_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_EMSHEDEMX3_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEmplStatus NOT IN ('A','L','O','S','R')
    )

    DELETE FROM dbo.U_EMSHEDEMX3_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType NOT IN ('EXE','HS','REG','SEA')
    )

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMSHEDEMX3_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMSHEDEMX3_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMSHEDEMX3_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ISNULL(EMPC.EecLocation, '') + ' :: ' + ISNULL(EMPC.EecSalaryOrHourly, '')
        -- standard fields above and additional driver fields below
        ,drvEmployeeNo = EMPC.EecEmpNo
        ,drvNameFirst = EMPP.EepNameFirst
        ,drvNameLast = EMPP.EepNameLast
        ,drvGender = EMPP.EepGender
        ,drvDateOfBirth = EMPP.EepDateOfBirth
        ,drvLanguage = EMPC.EecLanguageCode
        ,drvPhoneNumber = EMPP.EepPhoneHomeNumber
        ,drvAltNumber = EfoPhoneNumber
        ,drvWorkPhoneNumber = EMPC.EecPhoneBusinessNumber
        ,drvEmployeeEmail1 = EMPP.EepAddressEMailAlternate
        ,drvEmployeeEmail2 = EMPP.EepAddressEMail
        ,drvWorkplaceLocation = LocDesc
        ,drvWorkAddressLine1 = LocAddressLine1
        ,drvWorkAddressLine2 = LocAddressLine2
        ,drvWorkAddressCit = LocAddressCity
        ,drvWorkAddressProvince = LocAddressState
        ,drvWorkAddressPostal = LocAddressZipCode
        ,drvWorkAddressCountry = CASE WHEN LocAddressCountry = 'CAN' THEN 'CA' ELSE LocAddressCountry END
        ,drvAddressLine1 = EMPP.EepAddressLine1
        ,drvAddressLine2 = EMPP.EepAddressLine2
        ,drvAddressCity = EMPP.EepAddressCity
        ,drvAddressProvince = EMPP.EepAddressState
        ,drvAddressZipCode = EMPP.EepAddressZipCode
        ,drvAddressCountry = CASE WHEN EMPP.EepAddressCountry = 'CAN' THEN 'CA' ELSE EMPP.EepAddressCountry END
        ,drvDateOfHire = EMPC.EecDateOfOriginalHire
        ,drvEmployeeType =    CASE WHEN EMPC.EecEEType = 'CON' THEN 'Contract'
                                WHEN EMPC.EecEEType = 'TMP' AND EMPC.EecFullTimeOrPartTime = 'F' THEN 'Full Time'
                                WHEN EMPC.EecEEType = 'TMP' AND EMPC.EecFullTimeOrPartTime = 'P' THEN 'Part Time'
                                WHEN EMPC.EecEEType = 'REG' AND EMPC.EecSalaryOrHourly = 'S' THEN 'Salary'
                                WHEN EMPC.EecEEType = 'REG' AND EMPC.EecSalaryOrHourly = 'H' THEN 'Unionized'
                                ELSE EMPC.EecEEType
                            END
        ,drvEmployeeUnion =   -- CASE WHEN EMPC.EecSalaryOrHourly = 'H' THEN 
                                CASE WHEN EMPC.EecLocation = 'PTC' AND EMPC.EecSalaryOrHourly = 'H' THEN '144'
                                    WHEN EMPC.EecLocation = 'SUR' AND EMPC.EecSalaryOrHourly = 'H' THEN '178'
                                    WHEN EMPC.EecLocation = 'CAL' AND EMPC.EecSalaryOrHourly = 'H' THEN '14'
                                    WHEN EMPC.EecLocation = 'VIS' AND EMPC.EecSalaryOrHourly = 'H' THEN 
                                        CASE WHEN EMPC.EecSalaryOrHourly = 'H' THEN '307' ELSE '93' END
                                    ELSE '93'
                                END
                            --END
        ,drvJobTitleDesc = JbcDesc
        ,drvARNotifyEmail =    CASE WHEN EMPC.EecLocation = 'SUR' AND EMPC.EecSalaryOrHourly = 'H' THEN 'CAN-PhoneDL-SurreySickLine@refresco.com'
                                WHEN EMPC.EecLocation = 'PTC' AND EMPC.EecSalaryOrHourly = 'H' THEN 'CAN-PhoneDL-PtClaireSickLine@refresco.com'
                                WHEN EMPC.EecLocation = 'CAL' AND EMPC.EecSalaryOrHourly = 'H' THEN 'CAN-PhoneDL-CalgarySickLine@refresco.com'
                                WHEN EMPC.EecLocation = 'VIS' AND EMPC.EecSalaryOrHourly = 'H' THEN 'CAN-PhoneDL-ViscountSickLine@refresco.com'
                                WHEN EMPC.EecSalaryOrHourly = 'S' THEN 'HRAbsenceReporting.CAN@refresco.com'
                            END
        ,drvDMNotifyEmail = (SELECT TOP 1 EepAddressEmail FROM dbo.EmpPers WITH (NOLOCK)  JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON EecEEID = EepEEID WHERE Coddesc= EecempNo AND EepAddressEmail IS NOT NULL)
        ,drvMangerEmployeID = SUPC.EecEmpNo
        ,drvManagerFirstName = SUPP.EepNameFirst
        ,drvManagerLastName = SUPP.EepNameLast
        ,drvManagerPhone = SUPC.EecPhoneBusinessNumber
        ,drvManagerEmail = SUPP.EepAddressEMail
    INTO dbo.U_EMSHEDEMX3_drvTbl
    FROM dbo.U_EMSHEDEMX3_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EMPC WITH (NOLOCK)
        ON EMPC.EecEEID = xEEID 
        AND EMPC.EecCoID = xCoID
    JOIN dbo.EmpPers EMPP WITH (NOLOCK)
        ON EMPP.EepEEID = xEEID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY AuditKey DESC) AS RN
                        FROM dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL'
                        ) AS CP
                WHERE RN = 1
            ) AS Cel
        ON EfoEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EMPC.EecJobCode
    JOIN dbo.vw_int_EmpComp SUPC WITH (NOLOCK)
        ON SUPC.EecEEID = EMPC.EecSupervisorId
        --AND SUPC.EecCOID = xCOID
    JOIN dbo.EmpPers SUPP WITH (NOLOCK)
        ON SUPP.EepEEID = EMPC.EecSupervisorId
    JOIN dbo.Codes WITH (NOLOCK)
        ON EMPC.EecLocation = CodCode
        AND codtable = 'CO_HRMANAGERBYLOCATI'
    WHERE LocAddressCountry = 'CAN'
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EMSHEDEMX3_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EMSHEDEMX3_Trailer;
    SELECT DISTINCT
         drvRunDateOfFile = GETDATE()
         ,drvRecordCountTotal = (SELECT COUNT(*) FROM dbo.U_EMSHEDEMX3_drvTbl)
    INTO dbo.U_EMSHEDEMX3_Trailer
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
ALTER VIEW dbo.dsi_vwEMSHEDEMX3_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMSHEDEMX3_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMSHEDEMX3%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202011151'
       ,expStartPerControl     = '202011151'
       ,expLastEndPerControl   = '202011229'
       ,expEndPerControl       = '202011229'
WHERE expFormatCode = 'EMSHEDEMX3';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMSHEDEMX3_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMSHEDEMX3_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMSHEDEMX3' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMSHEDEMX3'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMSHEDEMX3'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMSHEDEMX3', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMSHEDEMX3', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMSHEDEMX3', 'UseFileName', 'V', 'Y'


-- End ripout