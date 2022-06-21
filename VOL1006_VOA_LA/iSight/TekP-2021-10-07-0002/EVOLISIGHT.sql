/**********************************************************************************

EVOLISIGHT: iSight Export

FormatCode:     EVOLISIGHT
Project:        iSight Export
Client ID:      VOL1006
Date/time:      2022-06-15 10:32:41.690
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N11
Server:         N1SUP1DB52
Database:       ULTIPRO_VOALA
Web Filename:   VOL1006_35E84_EEHISTORY_EVOLISIGHT_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EVOLISIGHT_SavePath') IS NOT NULL DROP TABLE dbo.U_EVOLISIGHT_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EVOLISIGHT'


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
WHERE FormatCode = 'EVOLISIGHT'
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
WHERE ExpFormatCode = 'EVOLISIGHT'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EVOLISIGHT')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EVOLISIGHT'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EVOLISIGHT'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EVOLISIGHT'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EVOLISIGHT'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EVOLISIGHT'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EVOLISIGHT'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EVOLISIGHT'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EVOLISIGHT'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EVOLISIGHT'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEVOLISIGHT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVOLISIGHT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVOLISIGHT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOLISIGHT];
GO
IF OBJECT_ID('U_EVOLISIGHT_File') IS NOT NULL DROP TABLE [dbo].[U_EVOLISIGHT_File];
GO
IF OBJECT_ID('U_EVOLISIGHT_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVOLISIGHT_EEList];
GO
IF OBJECT_ID('U_EVOLISIGHT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVOLISIGHT_drvTbl];
GO
IF OBJECT_ID('U_EVOLISIGHT_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EVOLISIGHT_AuditFields];
GO
IF OBJECT_ID('U_EVOLISIGHT_Audit') IS NOT NULL DROP TABLE [dbo].[U_EVOLISIGHT_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EVOLISIGHT','iSight Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EVOLISIGHTZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVOLISIGHTZ0','50','H','01','1',NULL,'CompanyName',NULL,NULL,'"Company Name','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVOLISIGHTZ0','50','H','01','2',NULL,'Manager',NULL,NULL,'"Manager','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVOLISIGHTZ0','50','H','01','3',NULL,'PositionTitle',NULL,NULL,'"Position Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EVOLISIGHTZ0','50','H','01','4',NULL,'EmploymentStatus',NULL,NULL,'"Employment Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EVOLISIGHTZ0','50','H','01','5',NULL,'FirstName',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EVOLISIGHTZ0','50','H','01','6',NULL,'PreferredFirstName',NULL,NULL,'"Preferred First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EVOLISIGHTZ0','50','H','01','7',NULL,'MiddleInitial',NULL,NULL,'"Middle Initial"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EVOLISIGHTZ0','50','H','01','8',NULL,'LastName',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EVOLISIGHTZ0','50','H','01','9',NULL,'EmailAddress',NULL,NULL,'"Email - Work"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EVOLISIGHTZ0','50','H','01','10',NULL,'PrimaryPhoneNumber',NULL,NULL,'"Work Phone Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EVOLISIGHTZ0','50','H','01','11',NULL,'SecondaryPhoneNumber',NULL,NULL,'"Home Phone Number"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EVOLISIGHTZ0','50','H','01','12',NULL,'Address',NULL,NULL,'"Address"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EVOLISIGHTZ0','50','H','01','13',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EVOLISIGHTZ0','50','H','01','14',NULL,'StateProvince',NULL,NULL,'"State/Province"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EVOLISIGHTZ0','50','H','01','15',NULL,'Country',NULL,NULL,'"Country"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EVOLISIGHTZ0','50','H','01','16',NULL,'ZipCodePostalCode',NULL,NULL,'"Zip Code/Postal Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EVOLISIGHTZ0','50','H','01','17',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EVOLISIGHTZ0','50','H','01','18',NULL,'OtherGender',NULL,NULL,'"Other Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EVOLISIGHTZ0','50','H','01','19',NULL,'DateOfBirth',NULL,NULL,'"Date Of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EVOLISIGHTZ0','50','H','01','20',NULL,'DateOfHire',NULL,NULL,'"Date of Hire"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EVOLISIGHTZ0','50','H','01','21',NULL,'Status',NULL,NULL,'"Status"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EVOLISIGHTZ0','50','H','01','22',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EVOLISIGHTZ0','50','H','01','23',NULL,'ServiceGroup',NULL,NULL,'"Service Group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EVOLISIGHTZ0','50','H','01','24',NULL,'Program',NULL,NULL,'"Program"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EVOLISIGHTZ0','50','H','01','25',NULL,'EmailPersonal',NULL,NULL,'"Email Personal"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EVOLISIGHTZ0','50','H','01','26',NULL,'EmployeeID',NULL,NULL,'"Employee ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EVOLISIGHTZ0','50','H','01','27',NULL,'EmployeeType',NULL,NULL,'"Employee Type"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EVOLISIGHTZ0','50','H','01','28',NULL,'FullTimePartTime',NULL,NULL,'"FullTime PartTime"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EVOLISIGHTZ0','50','H','01','29',NULL,'SeniorLeader',NULL,NULL,'"Senior Leader"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EVOLISIGHTZ0','50','H','01','30',NULL,'Race',NULL,NULL,'"Race"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EVOLISIGHTZ0','50','D','10','1',NULL,'CompanyName',NULL,NULL,'"drvCompanyName','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EVOLISIGHTZ0','50','D','10','2',NULL,'Manager',NULL,NULL,'"drvManager','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EVOLISIGHTZ0','50','D','10','3',NULL,'PositionTitle',NULL,NULL,'"drvPositionTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EVOLISIGHTZ0','50','D','10','4',NULL,'EmploymentStatus',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EVOLISIGHTZ0','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EVOLISIGHTZ0','50','D','10','6',NULL,'PreferredFirstName',NULL,NULL,'"drvPreferredFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EVOLISIGHTZ0','50','D','10','7',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EVOLISIGHTZ0','50','D','10','8',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EVOLISIGHTZ0','50','D','10','9',NULL,'EmailAddress',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EVOLISIGHTZ0','50','D','10','10',NULL,'PrimaryPhoneNumber',NULL,NULL,'"drvPrimaryPhoneNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EVOLISIGHTZ0','50','D','10','11',NULL,'SecondaryPhoneNumber',NULL,NULL,'"drvSecondaryPhoneNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EVOLISIGHTZ0','50','D','10','12',NULL,'Address',NULL,NULL,'"drvAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EVOLISIGHTZ0','50','D','10','13',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EVOLISIGHTZ0','50','D','10','14',NULL,'StateProvince',NULL,NULL,'"drvStateProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EVOLISIGHTZ0','50','D','10','15',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EVOLISIGHTZ0','50','D','10','16',NULL,'ZipCodePostalCode',NULL,NULL,'"drvZipCodePostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EVOLISIGHTZ0','50','D','10','17',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EVOLISIGHTZ0','50','D','10','18',NULL,'OtherGender',NULL,NULL,'"drvOtherGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EVOLISIGHTZ0','50','D','10','19',NULL,'DateOfBirth',NULL,NULL,'"drvDateOfBirth"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EVOLISIGHTZ0','50','D','10','20',NULL,'DateOfHire',NULL,NULL,'"drvDateofHire"','(''UDMDY''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EVOLISIGHTZ0','50','D','10','21',NULL,'Status',NULL,NULL,'"drvStatus"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EVOLISIGHTZ0','50','D','10','22',NULL,'Division',NULL,NULL,'"drvDivision"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EVOLISIGHTZ0','50','D','10','23',NULL,'ServiceGroup',NULL,NULL,'"drvServiceGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EVOLISIGHTZ0','50','D','10','24',NULL,'Program',NULL,NULL,'"drvProgram"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EVOLISIGHTZ0','50','D','10','25',NULL,'EmailPersonal',NULL,NULL,'"drvEmailPersonal"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EVOLISIGHTZ0','50','D','10','26',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EVOLISIGHTZ0','50','D','10','27',NULL,'EmployeeType',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EVOLISIGHTZ0','50','D','10','28',NULL,'FullTimePartTime',NULL,NULL,'"drvFullTimePartTime"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EVOLISIGHTZ0','50','D','10','29',NULL,'SeniorLeader',NULL,NULL,'"drvSeniorLeader"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EVOLISIGHTZ0','50','D','10','30',NULL,'Race',NULL,NULL,'"drvRace"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EVOLISIGHT_20220615.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'iSight Export','202204069','EMPEXPORT','ONDEM_XOE',NULL,'EVOLISIGHT',NULL,NULL,NULL,'202204069','Apr  6 2022  9:02AM','Apr  6 2022  9:02AM','202204061',NULL,'','','202204061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'iSight Export-Sched','202204069','EMPEXPORT','SCH_EVOLIS','Apr  7 2022  9:43AM','EVOLISIGHT',NULL,NULL,NULL,'202204069','Apr  6 2022 12:00AM','Dec 30 1899 12:00AM','202204061','2811','','','202204061',dbo.fn_GetTimedKey(),NULL,'us3mThVOL1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'iSight Export-Test','202205279','EMPEXPORT','TEST_XOE','May 27 2022  9:11AM','EVOLISIGHT',NULL,NULL,NULL,'202205279','May 27 2022 12:00AM','Dec 30 1899 12:00AM','202205131','2843','','','202205131',dbo.fn_GetTimedKey(),NULL,'us3lKiVOL1006',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOLISIGHT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOLISIGHT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOLISIGHT','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOLISIGHT','IsUTF8','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOLISIGHT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOLISIGHT','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOLISIGHT','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOLISIGHT','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOLISIGHT','D10','dbo.U_EVOLISIGHT_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EVOLISIGHT_Audit
-----------

IF OBJECT_ID('U_EVOLISIGHT_Audit') IS NULL
CREATE TABLE [dbo].[U_EVOLISIGHT_Audit] (
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
-- Create table U_EVOLISIGHT_AuditFields
-----------

IF OBJECT_ID('U_EVOLISIGHT_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EVOLISIGHT_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EVOLISIGHT_drvTbl
-----------

IF OBJECT_ID('U_EVOLISIGHT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVOLISIGHT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] char(9) NULL,
    [drvCompanyName] char(5) NULL,
    [drvManager] varchar(8000) NULL,
    [drvPositionTitle] varchar(8000) NULL,
    [drvEmploymentStatus] varchar(6) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvPreferredFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPrimaryPhoneNumber] varchar(50) NULL,
    [drvSecondaryPhoneNumber] varchar(50) NULL,
    [drvAddress] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvStateProvince] varchar(255) NULL,
    [drvCountry] char(3) NULL,
    [drvZipCodePostalCode] varchar(50) NULL,
    [drvGender] varchar(6) NULL,
    [drvOtherGender] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateofHire] datetime NULL,
    [drvStatus] char(1) NULL,
    [drvDivision] varchar(25) NULL,
    [drvServiceGroup] varchar(25) NULL,
    [drvProgram] varchar(36) NULL,
    [drvEmailPersonal] varchar(50) NULL,
    [drvEmployeeID] varchar(8000) NULL,
    [drvEmployeeType] nvarchar(1000) NULL,
    [drvFullTimePartTime] char(1) NULL,
    [drvSeniorLeader] char(12) NULL,
    [drvRace] varchar(45) NULL
);

-----------
-- Create table U_EVOLISIGHT_EEList
-----------

IF OBJECT_ID('U_EVOLISIGHT_EEList') IS NULL
CREATE TABLE [dbo].[U_EVOLISIGHT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EVOLISIGHT_File
-----------

IF OBJECT_ID('U_EVOLISIGHT_File') IS NULL
CREATE TABLE [dbo].[U_EVOLISIGHT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOLISIGHT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: VOA of LA

Created By: Marie Thomerson
Business Analyst: Richard Vars
Create Date: 04/06/2022
Service Request Number: TekP-2021-10-07-0002

Purpose: iSight Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVOLISIGHT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVOLISIGHT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVOLISIGHT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVOLISIGHT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVOLISIGHT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOLISIGHT', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOLISIGHT', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOLISIGHT', 'SCH_EVOLIS';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EVOLISIGHT', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EVOLISIGHT';

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
    DELETE FROM dbo.U_EVOLISIGHT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EVOLISIGHT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EVOLISIGHT_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EVOLISIGHT_AuditFields;
    CREATE TABLE dbo.U_EVOLISIGHT_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EVOLISIGHT_AuditFields VALUES ('Empcomp','eecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EVOLISIGHT_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EVOLISIGHT_Audit;
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
    INTO dbo.U_EVOLISIGHT_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EVOLISIGHT_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EVOLISIGHT_Audit ON dbo.U_EVOLISIGHT_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EVOLISIGHT_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EVOLISIGHT_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EVOLISIGHT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EVOLISIGHT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVOLISIGHT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = dbo.vw_int_EmpComp.EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvCompanyName = cmpcompanycode
        ,drvManager = REPLACE(dbo.dsi_fnlib_GetSupervisorField_v2('', dbo.vw_int_EmpComp.EecEEID, 'NameFirst Last') , ',', '') 
        ,drvPositionTitle = REPLACE(JbcDesc, ',','')
        ,drvEmploymentStatus = CASE WHEN dbo.vw_int_EmpComp.EecEmplStatus = 'A' THEN 'Active' WHEN dbo.vw_int_EmpComp.EecEmplStatus = 'L' THEN 'LOA' ELSE 'Termed' END
        ,drvFirstName = EepNameFirst
        ,drvPreferredFirstName = EepNamepreferred
        ,drvMiddleInitial = LEFT(EepNameMiddle,1) 
        ,drvLastName = EepNameLast
        ,drvEmailAddress = EepAddressEMail
        ,drvPrimaryPhoneNumber = dbo.vw_int_EmpComp.EecPhoneBusinessNumber
        ,drvSecondaryPhoneNumber = EepPhoneHomeNumber
        --,drvPreferredContactMethod = ''
        ,drvAddress = REPLACE(Eepaddressline1 +' ' +Eepaddressline2, ',','')
        ,drvCity = REPLACE(EepAddressCity, ',','')
        ,drvStateProvince = EepAddressState
        ,drvCountry = EepAddressCountry
        ,drvZipCodePostalCode = EepAddressZipCode
        ,drvGender = CASE WHEN EepGender = 'M' THEN 'MALE' WHEN EepGender = 'F' THEN 'FEMALE' END
        ,drvOtherGender = ''
        ,drvDateOfBirth = eepdateofbirth
        ,drvDateofHire = dbo.vw_int_EmpComp.eecdateoflasthire
        ,drvStatus = dbo.vw_int_EmpComp.eecemplstatus
        ,drvDivision = OL1.OrgDesc
        ,drvServiceGroup = OL2.OrgDesc
        ,drvProgram = OL3.OrgDesc + ' '+ OL3.OrgCode
        ,drvEmailPersonal = eepAddressEMailalternate
        ,drvEmployeeID = [dbo].[dsi_fnlib_AddDoubleQuotes] (dbo.vw_int_EmpComp.eecempno)
        ,drvEmployeeType = FNEC.EETypeDesc
        ,drvFullTimePartTime = dbo.vw_int_EmpComp.EecFullTimeOrPartTime
        ,drvSeniorLeader = MGR.EecEmpNo
        ,drvRace = ETH.CodDesc
    INTO dbo.U_EVOLISIGHT_drvTbl
    FROM dbo.U_EVOLISIGHT_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecPayGroup <> 'TEST'
                    and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                    and EXISTS(select 1 from dbo.U_EVOLISIGHT_Audit where audEEID = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.codes ETH WITH (NOLOCK)
        ON ETH.CodCode = EepEthnicID
        AND codTable = 'ETHNICCODE'
    LEFT JOIN dbo.OrgLevel OL1 WITH (NOLOCK)
        ON OL1.OrgCode = dbo.vw_int_EmpComp.EecOrgLvl1
        AND OL1.OrgLvl = 1
    LEFT JOIN dbo.OrgLevel OL2 WITH (NOLOCK)
        ON OL2.OrgCode = dbo.vw_int_EmpComp.EecOrgLvl2
        AND OL2.OrgLvl = 2
    LEFT JOIN dbo.OrgLevel OL3 WITH (NOLOCK)
        ON OL3.OrgCode = dbo.vw_int_EmpComp.EecOrgLvl3
        AND OL3.OrgLvl = 3
    LEFT JOIN dbo.vw_int_EmpComp MGR WITH (NOLOCK)
        ON OL3.OrgManagerID = MGR.EecEEID
    JOIN fn_BI_EmpComp ('en') FNEC
        ON FNEC.EecCoID = xCoID
        AND FNEC.EecEEID = xEEID
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
ALTER VIEW dbo.dsi_vwEVOLISIGHT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EVOLISIGHT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EVOLISIGHT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201011'
       ,expStartPerControl     = '202201011'
       ,expLastEndPerControl   = '202204069'
       ,expEndPerControl       = '202204069'
WHERE expFormatCode = 'EVOLISIGHT';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEVOLISIGHT_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EVOLISIGHT_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EVOLISIGHT' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EVOLISIGHT'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EVOLISIGHT'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EVOLISIGHT', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EVOLISIGHT', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EVOLISIGHT', 'UseFileName', 'V', 'Y'


-- End ripout