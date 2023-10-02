/**********************************************************************************

ESMART301: SmartBen EE Demographics (Hometown - 301)

FormatCode:     ESMART301
Project:        SmartBen EE Demographics (Hometown - 301)
Client ID:      GPS1000
Date/time:      2023-10-02 08:43:06.850
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E41
Server:         E4SUP1DB04
Database:       ULTIPRO_GPSHH
Web Filename:   GPS1000_ZLF1J_EEHISTORY_ESMART301_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESMART301_SavePath') IS NOT NULL DROP TABLE dbo.U_ESMART301_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESMART301'


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
WHERE FormatCode = 'ESMART301'
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
WHERE ExpFormatCode = 'ESMART301'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESMART301')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESMART301'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESMART301'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESMART301'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESMART301'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESMART301'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESMART301'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESMART301'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESMART301'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESMART301'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESMART301_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESMART301_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESMART301') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESMART301];
GO
IF OBJECT_ID('U_ESMART301_File') IS NOT NULL DROP TABLE [dbo].[U_ESMART301_File];
GO
IF OBJECT_ID('U_ESMART301_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESMART301_EEList];
GO
IF OBJECT_ID('U_ESMART301_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESMART301_drvTbl];
GO
IF OBJECT_ID('U_ESMART301_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESMART301_AuditFields];
GO
IF OBJECT_ID('U_ESMART301_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESMART301_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESMART301','SmartBen EE Demographics (Hometown - 301)','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ESMART3010Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESMART3010Z0','50','H','01','1',NULL,'UserName',NULL,NULL,'"UserName"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESMART3010Z0','50','H','01','2',NULL,'PayType ID',NULL,NULL,'"PayType ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESMART3010Z0','50','H','01','3',NULL,'Password',NULL,NULL,'"Password"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESMART3010Z0','50','H','01','4',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESMART3010Z0','50','H','01','5',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESMART3010Z0','50','H','01','6',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESMART3010Z0','50','H','01','7',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESMART3010Z0','50','H','01','8',NULL,'Annual Salary',NULL,NULL,'"Annual Salary"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESMART3010Z0','50','H','01','9',NULL,'Static Annual Salary',NULL,NULL,'"Static Annual Salary"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESMART3010Z0','50','H','01','10',NULL,'Facility ID',NULL,NULL,'"Facility ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESMART3010Z0','50','H','01','11',NULL,'Birth Date',NULL,NULL,'"Birth Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESMART3010Z0','50','H','01','12',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESMART3010Z0','50','H','01','13',NULL,'Benefit Date',NULL,NULL,'"Benefit Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESMART3010Z0','50','H','01','14',NULL,'PayType Change Date',NULL,NULL,'"PayType Change Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESMART3010Z0','50','H','01','15',NULL,'Term Date',NULL,NULL,'"Term Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESMART3010Z0','50','H','01','16',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESMART3010Z0','50','H','01','17',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESMART3010Z0','50','H','01','18',NULL,'Address',NULL,NULL,'"Address"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESMART3010Z0','50','H','01','19',NULL,'Apt Unit Ste',NULL,NULL,'"Apt Unit Ste"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESMART3010Z0','50','H','01','20',NULL,'City',NULL,NULL,'"City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESMART3010Z0','50','H','01','21',NULL,'State',NULL,NULL,'"State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESMART3010Z0','50','H','01','22',NULL,'Zip Code',NULL,NULL,'"Zip Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESMART3010Z0','50','H','01','23',NULL,'County',NULL,NULL,'"County"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESMART3010Z0','50','H','01','24',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESMART3010Z0','50','H','01','25',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESMART3010Z0','50','H','01','26',NULL,'Occupation',NULL,NULL,'"Occupation"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESMART3010Z0','50','H','01','27',NULL,'Payroll Code',NULL,NULL,'"Payroll Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESMART3010Z0','50','H','01','28',NULL,'Suffix',NULL,NULL,'"Suffix"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESMART3010Z0','50','D','10','1',NULL,'UserName',NULL,NULL,'"drvUserName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESMART3010Z0','50','D','10','2',NULL,'PayType ID',NULL,NULL,'"drvPayTypeID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESMART3010Z0','50','D','10','3',NULL,'Password',NULL,NULL,'"drvPassword"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESMART3010Z0','50','D','10','4',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESMART3010Z0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESMART3010Z0','50','D','10','6',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESMART3010Z0','50','D','10','7',NULL,'Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESMART3010Z0','50','D','10','8',NULL,'Annual Salary',NULL,NULL,'"drvAnnSalary"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESMART3010Z0','50','D','10','9',NULL,'Static Annual Salary',NULL,NULL,'"drvStaticAnnSalary"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESMART3010Z0','50','D','10','10',NULL,'Facility ID',NULL,NULL,'"drvIDFacility"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESMART3010Z0','50','D','10','11',NULL,'Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESMART3010Z0','50','D','10','12',NULL,'Hire Date',NULL,NULL,'"drvDateOfLastHire"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESMART3010Z0','50','D','10','13',NULL,'Benefit Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESMART3010Z0','50','D','10','14',NULL,'PayType Change Date',NULL,NULL,'"drvPayTypeChangeDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESMART3010Z0','50','D','10','15',NULL,'Term Date',NULL,NULL,'"drvDateTerm"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESMART3010Z0','50','D','10','16',NULL,'Marital Status',NULL,NULL,'"drvStatusMarital"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESMART3010Z0','50','D','10','17',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESMART3010Z0','50','D','10','18',NULL,'Address',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESMART3010Z0','50','D','10','19',NULL,'Apt Unit Ste',NULL,NULL,'"drvAptSte"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESMART3010Z0','50','D','10','20',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESMART3010Z0','50','D','10','21',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESMART3010Z0','50','D','10','22',NULL,'Zip Code',NULL,NULL,'"drvCodeZip"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESMART3010Z0','50','D','10','23',NULL,'County',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESMART3010Z0','50','D','10','24',NULL,'Job Title',NULL,NULL,'"drvTitleJob"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESMART3010Z0','50','D','10','25',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESMART3010Z0','50','D','10','26',NULL,'Occupation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESMART3010Z0','50','D','10','27',NULL,'Payroll Code',NULL,NULL,'"drvCodePayroll"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESMART3010Z0','50','D','10','28',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESMART301_20231002.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','W2VI0',NULL,NULL,NULL,'SmartBen ONDEM 301 Only','202203031','EMPEXPORT','ONDEM_XOE','Mar  3 2022  4:42PM','ESMART301',NULL,NULL,NULL,'202203031','Mar  3 2022 12:00AM','Dec 30 1899 12:00AM','202203031','111','','','202203031',dbo.fn_GetTimedKey(),NULL,'ULTI_GPSHH',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','W2VI0',NULL,NULL,NULL,'SmartBen SCHED 301 Only - Mon','202204079','EMPEXPORT','SCHED_XOE','Jan  5 2022 12:00AM','ESMART301',NULL,NULL,NULL,'202310029','Jan 13 2020 12:00AM','Dec 30 1899 12:00AM','202309251',NULL,'','','202204071',dbo.fn_GetTimedKey(),NULL,'ULTI_GPSHH',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','W2VI0',NULL,NULL,NULL,'SmartBen TEST 301 Only','202203031','EMPEXPORT','TEST_XOE','Mar  3 2022 12:00AM','ESMART301',NULL,NULL,NULL,'202203031','Mar  3 2022 12:00AM','Dec 30 1899 12:00AM','202202241','3277','','','202202241',dbo.fn_GetTimedKey(),NULL,'ULTI_GPSHH',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMART301','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMART301','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMART301','InitialSort','C','drvNameLast');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMART301','SubSort','C','drvNameFirst');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMART301','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMART301','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMART301','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESMART301','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESMART301','D10','dbo.U_ESMART301_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ESMART301_Audit
-----------

IF OBJECT_ID('U_ESMART301_Audit') IS NULL
CREATE TABLE [dbo].[U_ESMART301_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCoID] varchar(255) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audEffectiveDate] datetime NULL
);

-----------
-- Create table U_ESMART301_AuditFields
-----------

IF OBJECT_ID('U_ESMART301_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESMART301_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESMART301_drvTbl
-----------

IF OBJECT_ID('U_ESMART301_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESMART301_drvTbl] (
    [drvUserName] varchar(14) NULL,
    [drvPayTypeID] varchar(5) NULL,
    [drvPassword] varchar(8000) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvAnnSalary] varchar(50) NULL,
    [drvStaticAnnSalary] varchar(50) NULL,
    [drvIDFacility] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvPayTypeChangeDate] datetime NULL,
    [drvDateTerm] datetime NULL,
    [drvStatusMarital] varchar(7) NOT NULL,
    [drvGender] char(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAptSte] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvCodeZip] varchar(50) NULL,
    [drvTitleJob] varchar(150) NULL,
    [drvDepartment] varchar(6) NULL,
    [drvCodePayroll] char(9) NULL,
    [drvSuffix] varchar(30) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL
);

-----------
-- Create table U_ESMART301_EEList
-----------

IF OBJECT_ID('U_ESMART301_EEList') IS NULL
CREATE TABLE [dbo].[U_ESMART301_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESMART301_File
-----------

IF OBJECT_ID('U_ESMART301_File') IS NULL
CREATE TABLE [dbo].[U_ESMART301_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE Procedure [dbo].[dsi_sp_BuildDriverTables_ESMART301]
       @SystemID char(12)
AS

/*___________________________________________________________________________________

Client Name:         GPS Hospitality

Created By:          Guido Pozo
Integration Analyst: Karen Formicone
Create Date:         1/5/2002
Project Number:      GPS1000-2021-00332494

Purpose:             SmartBen Employee Demographics *** FOR COMPANY 301 ONLY(Hometown Hospitality LLC) ***

Revision History
----------------
Update By           Date           Request Num        Desc
N Wetherbee         03/29/2017                        Updated Gender logic
N Wetherbee         05/01/2017                        Updates to drvAnnSalary and drvStaticAnnSalary columns
M Souza             11/14/2017        SF 10008499     Created new Audit Fileds table to increase speed 
Anthony Ramos       01/14/2020        SF 16510290     Corrected audit table to correctly join data



Select * From dbo.U_dsi_Configuration Where FormatCode = 'ESMART301';
Select * From dbo.AscExp Where expFormatCode = 'ESMART301';
Select * From dbo.U_dsi_InterfaceActivityLog Where FormatCode = 'ESMART301' Order BY RunID Desc;

Execute Export
--------------
dbo.dsi_sp_TestSwitchbox_v2 'ESMART301', 'ONDEM_XOE';
dbo.dsi_sp_TestSwitchbox_v2 'ESMART301', 'TEST_XOE';
dbo.dsi_sp_TestSwitchbox_v2 'ESMART301', 'SCHED_XOE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESMART301', @AllObjects = 'Y', @IsWeb = 'Y'
___________________________________________________________________________________*/

Begin

-- Declare variables

Declare  @FormatCode       VARCHAR(10)
        ,@ExportCode       VARCHAR(10)
        ,@StartDate        DATETIME
        ,@EndDate          DATETIME;


-- Declare dates from Parameter file

Update U_dsi_Parameters 
   Set StartPerControl = Convert(Char(8),DateAdd(dd,-7,getdate()),112)+'1',
       EndPerControl   = Convert(Char(8),GetDate(),112)+'9'
 Where Exportcode = 'SCHEDULED' and FormatCode = 'ESMART301'

 Select
         @StartDate       = Cast(substring(StartPerControl,1,8) as datetime)
        ,@EndDate         = Cast(substring(EndPerControl,1,8) as datetime)
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    From dbo.U_dsi_Parameters WITH (NOLOCK)
   Where FormatCode = 'ESMART301';


-- Clean EE List 
-- Caution: Careful of cleaning EE List if including paycheck data
-- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company

Delete 
  From dbo.U_ESMART301_EELIST 
 Where xCOID <> dbo.dsi_fn_GetCurrentCOID(xEEID)
   and xEEID in (Select xEEID From dbo.U_ESMART301_EELIST Group by xEEID Having Count(*) > 1);


/*___________________________________________________________________________________*/

-- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('dbo.U_ESMART301_AuditFields','U') IS NOT NULL
    DROP TABLE dbo.U_ESMART301_AuditFields;
    CREATE TABLE dbo.U_ESMART301_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ESMART301_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ESMART301_AuditFields VALUES ('EmpComp','EecDedGroupCode');

    If object_id('U_ESMART301_Audit') is not null
    Drop table dbo.U_ESMART301_Audit

Select 
   audEEID          = audKey1Value
  ,audCoID          = audKey2Value
  ,audFieldName     = audFieldName
  ,audEffectiveDate = max(audProcessedDateTime)
 INTO dbo.U_ESMART301_Audit

 --From dbo.U_ESMART301_EEList with (nolock) --AR SF 16510290
from dbo.dsi_vw_AuditData with (nolock)--on xEEID = audKey1Value and xCOID = audKey2Value
 --JOIN dbo.U_ESMART301_AuditFields WITH (NOLOCK) 
 --       ON audTableName = aTableName
 --       AND audFieldName = aFieldName
Where audAction = 'Update' 
  and (
      (audNewValue = 'T' and audFieldName = 'EecEmplStatus' and audProcessedDateTime between @StartDate and @EndDate) or 
      (audFieldName = 'EecDedGroupCode' and audProcessedDateTime <= @EndDate)
       )
Group by audKey1Value,audKey2Value,audFieldName 


-- Include only: W2VI0 - 301      853384761 - Hometown Hospitality LLC
DELETE FROM  dbo.U_ESMART301_EELIST  WHERE xCOID <> 'W2VI0'




/*___________________________________________________________________________________*/

-- Build Employee Data and the driver tables

-- Detail Record for U_ESMART301_drvTbl

If Object_ID('U_ESMART301_drvTbl') is Not Null
   Drop Table dbo.U_ESMART301_drvTbl;

Select Distinct                
       drvUserName          = 'HTH' + eepSSN
      ,drvPayTypeID         = CASE WHEN EecDedGroupCode = '17541' THEN '25956'        --GP-New Changes_v1
                                    WHEN EecDedGroupCode = '17542' THEN '25957'
                                    WHEN EecDedGroupCode = '17543' THEN '25958'
                                    WHEN EecDedGroupCode = '17544' THEN '25959'
                                    WHEN EecDedGroupCode = '17545' THEN '25960'
                                    WHEN EecDedGroupCode = '17546' THEN '25961'
                                    WHEN EecDedGroupCode = '17347' THEN '25962'
                                    WHEN EecDedGroupCode = '18397' THEN '25963'
                                END
      ,drvPassword          = replace(convert(varchar(10),eepDateOfBirth,101),'/','')
      ,drvSSN               = EepSSN
      ,drvNameLast          = EepNameLast
      ,drvNameFirst         = EepNameFirst
      ,drvNameMiddle        = eepNameMiddle
      
      ,drvAnnSalary         = Convert(varchar(50),Convert(decimal(12,2),(Case When EecJobCode in ('RAM','RAMT') Then EecHourlyPayRate * 2845.00 Else EecAnnSalary End)))
      ,drvStaticAnnSalary   = Convert(varchar(50),Convert(decimal(12,2),(Case When EecJobCode in ('RAM','RAMT') Then EecHourlyPayRate * 2845.00 Else EecAnnSalary End)))

      --,drvAnnSalary         = Convert(varchar(50),Convert(decimal(12,2),(EecAnnSalary)))
      --,drvStaticAnnSalary   = Convert(varchar(50),Convert(decimal(12,2),(EecAnnSalary)))

      ,drvIDFacility        = ''

      ,drvDateOfBirth       = EepDateOfBirth
      ,drvDateOfLastHire    = EecDateOfLastHire
      ,drvPayTypeChangeDate = AudDed.audEffectiveDate
      ,drvDateTerm          = case when eecEmplStatus = 'T' then eecDateOfTermination End
      ,drvStatusMarital     = case when eepMaritalStatus = 'M' then 'Married'Else 'Single' end
      ,drvGender            = case when EepGender in ('F','M') Then EepGender End
      ,drvAddressLine1      = EepAddressLine1
      ,drvAptSte            = eepAddressLine2
      ,drvCity              = EepAddressCity
      ,drvState             = EepAddressState
      ,drvCodeZip           = eepAddressZipCode
      ,drvTitleJob          = jbcLongDesc
      ,drvDepartment        = right('000000' + rtrim(ltrim(EecLocation)),6)
      ,drvCodePayroll       = EecEmpNo
      ,drvSuffix            = NULLIF(EepNameSuffix,'Z')
      ,drvEEID              = xEEID
      ,drvCoID              = xCoID
  INTO dbo.U_ESMART301_drvTbl

  From dbo.U_ESMART301_EEList with (nolock)
 Inner Join dbo.EmpComp with (nolock) on EecEEID = xEEID and EecCoID = xCoID
 Inner Join dbo.EmpPers with (nolock) on EepEEID = xEEID
 Left Outer Join dbo.Company with (nolock) on EecCoID = CmpCoID
 Left Outer JOin dbo.JobCode with (nolock) on EecJobCode = JbcJobCode
 Left Outer Join dbo.U_ESMART301_Audit AudStat with (nolock) on xEEID = AudStat.audEEID and xCoID = AudStat.audCoID and AudStat.audFieldName  ='EecEmplStatus'
 Left Outer Join dbo.U_ESMART301_Audit AudDed with (nolock) on xEEID = AudDed.audEEID and xCoID = AudDed.audCoID and AudDed.audFieldName = 'EecDedGroupCode'
 Where isnull(EecDedGroupCode,'') <> '17347'
   and (isnull(EecEmplStatus,'') <> 'T' or AudStat.audEEID is not Null)
 ;


/*___________________________________________________________________________________*/


-- Set FileName

If (dbo.dsi_fnVariable('ESMART301','UseFileName') = 'N')
Begin
        Update dbo.U_dsi_Parameters
           Set ExportFile = 'GPSHospitality_SmartBen301_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
       Where FormatCode = 'ESMART301';
End

End;


/*___________________________________________________________________________________

Select * From dbo.U_dsi_Configuration Where FormatCode = 'ESMART301';
dbo.dsi_sp_TestSwitchbox_v2 'ESMART301', 'ONDEMAND';
dbo.dsi_sp_TestSwitchbox_v2 'ESMART301', 'TEST';

--Alter the View

Alter View dbo.dsi_vwESMART301_Export as
    Select Top 20000000 Data From dbo.U_ESMART301_File with (nolock)
    Order by Right(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF

Select * From dbo.AscDefF
Where AdfHeaderSystemID like 'ESMART301%'
Order by AdfSetNumber, AdfFieldNumber;


Select * from U_ESMART301_drvTbl where drvSuffix is not null




-- Update Dates

Update dbo.AscExp
   Set ExpLastStartPerControl = '201702161'
       ,ExpLastEndPerControl   = '201702239'
 Where ExpFormatCode = 'ESMART301';

Select * From dbo.AscDefH Where adhFormatCode = 'ESMART301';
Select * From dbo.AscExp Where expFormatCode = 'ESMART301';
Select * From dbo.u_dsi_sqlclauses Where FormatCode = 'ESMART301';

___________________________________________________________________________________*/
GO
Create View dbo.dsi_vwESMART301_Export as
                            select top 200000000 Data from dbo.U_ESMART301_File with (nolock)
                            order by substring(RecordSet,2,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESMART301' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESMART301'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESMART301'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESMART301', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESMART301', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESMART301', 'UseFileName', 'V', 'Y'


-- End ripout