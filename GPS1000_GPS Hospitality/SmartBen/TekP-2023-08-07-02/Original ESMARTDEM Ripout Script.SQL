/**********************************************************************************

ESMARTDEM: SmartBen Employee Demographics Export

FormatCode:     ESMARTDEM
Project:        SmartBen Employee Demographics Export
Client ID:      GPS1000
Date/time:      2023-10-02 11:37:21.070
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    E41
Server:         E4SUP1DB04
Database:       ULTIPRO_GPSHH
ExportPath:    \\us.saas\E0\data_exchange\GPS1000\Exports\
TestPath:      \\us.saas\e4\Public\GPS1000\Exports\SmartBen\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESMARTDEM_SavePath') IS NOT NULL DROP TABLE dbo.U_ESMARTDEM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESMARTDEM'


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
WHERE FormatCode = 'ESMARTDEM'
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
WHERE ExpFormatCode = 'ESMARTDEM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESMARTDEM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESMARTDEM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESMARTDEM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESMARTDEM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESMARTDEM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESMARTDEM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESMARTDEM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESMARTDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESMARTDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESMARTDEM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESMARTDEM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESMARTDEM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESMARTDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESMARTDEM];
GO
IF OBJECT_ID('U_ESMARTDEM_File') IS NOT NULL DROP TABLE [dbo].[U_ESMARTDEM_File];
GO
IF OBJECT_ID('U_ESMARTDEM_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESMARTDEM_EEList];
GO
IF OBJECT_ID('U_ESMARTDEM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESMARTDEM_drvTbl];
GO
IF OBJECT_ID('U_ESMARTDEM_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESMARTDEM_AuditFields];
GO
IF OBJECT_ID('U_ESMARTDEM_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESMARTDEM_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESMARTDEM','SmartBen Employee Demographics Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ESMARTDEM0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESMARTDEM0Z0','50','H','01','1',NULL,'UserName',NULL,NULL,'"UserName"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESMARTDEM0Z0','50','H','01','2',NULL,'PayType ID',NULL,NULL,'"PayType ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESMARTDEM0Z0','50','H','01','3',NULL,'Password',NULL,NULL,'"Password"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESMARTDEM0Z0','50','H','01','4',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESMARTDEM0Z0','50','H','01','5',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESMARTDEM0Z0','50','H','01','6',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESMARTDEM0Z0','50','H','01','7',NULL,'Middle Name',NULL,NULL,'"Middle Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESMARTDEM0Z0','50','H','01','8',NULL,'Annual Salary',NULL,NULL,'"Annual Salary"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESMARTDEM0Z0','50','H','01','9',NULL,'Static Annual Salary',NULL,NULL,'"Static Annual Salary"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESMARTDEM0Z0','50','H','01','10',NULL,'Facility ID',NULL,NULL,'"Facility ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESMARTDEM0Z0','50','H','01','11',NULL,'Birth Date',NULL,NULL,'"Birth Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESMARTDEM0Z0','50','H','01','12',NULL,'Hire Date',NULL,NULL,'"Hire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESMARTDEM0Z0','50','H','01','13',NULL,'Benefit Date',NULL,NULL,'"Benefit Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESMARTDEM0Z0','50','H','01','14',NULL,'PayType Change Date',NULL,NULL,'"PayType Change Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESMARTDEM0Z0','50','H','01','15',NULL,'Term Date',NULL,NULL,'"Term Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESMARTDEM0Z0','50','H','01','16',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESMARTDEM0Z0','50','H','01','17',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESMARTDEM0Z0','50','H','01','18',NULL,'Address',NULL,NULL,'"Address"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESMARTDEM0Z0','50','H','01','19',NULL,'Apt Unit Ste',NULL,NULL,'"Apt Unit Ste"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESMARTDEM0Z0','50','H','01','20',NULL,'City',NULL,NULL,'"City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESMARTDEM0Z0','50','H','01','21',NULL,'State',NULL,NULL,'"State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESMARTDEM0Z0','50','H','01','22',NULL,'Zip Code',NULL,NULL,'"Zip Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESMARTDEM0Z0','50','H','01','23',NULL,'County',NULL,NULL,'"County"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESMARTDEM0Z0','50','H','01','24',NULL,'Job Title',NULL,NULL,'"Job Title"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESMARTDEM0Z0','50','H','01','25',NULL,'Department',NULL,NULL,'"Department"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESMARTDEM0Z0','50','H','01','26',NULL,'Occupation',NULL,NULL,'"Occupation"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESMARTDEM0Z0','50','H','01','27',NULL,'Payroll Code',NULL,NULL,'"Payroll Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESMARTDEM0Z0','50','H','01','28',NULL,'Suffix',NULL,NULL,'"Suffix"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESMARTDEM0Z0','50','D','10','1',NULL,'UserName',NULL,NULL,'"drvUserName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESMARTDEM0Z0','50','D','10','2',NULL,'PayType ID',NULL,NULL,'"drvPayTypeID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESMARTDEM0Z0','50','D','10','3',NULL,'Password',NULL,NULL,'"drvPassword"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESMARTDEM0Z0','50','D','10','4',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESMARTDEM0Z0','50','D','10','5',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESMARTDEM0Z0','50','D','10','6',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESMARTDEM0Z0','50','D','10','7',NULL,'Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESMARTDEM0Z0','50','D','10','8',NULL,'Annual Salary',NULL,NULL,'"drvAnnSalary"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESMARTDEM0Z0','50','D','10','9',NULL,'Static Annual Salary',NULL,NULL,'"drvStaticAnnSalary"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESMARTDEM0Z0','50','D','10','10',NULL,'Facility ID',NULL,NULL,'"drvIDFacility"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESMARTDEM0Z0','50','D','10','11',NULL,'Birth Date',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESMARTDEM0Z0','50','D','10','12',NULL,'Hire Date',NULL,NULL,'"drvDateOfLastHire"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESMARTDEM0Z0','50','D','10','13',NULL,'Benefit Date',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESMARTDEM0Z0','50','D','10','14',NULL,'PayType Change Date',NULL,NULL,'"drvPayTypeChangeDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESMARTDEM0Z0','50','D','10','15',NULL,'Term Date',NULL,NULL,'"drvDateTerm"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESMARTDEM0Z0','50','D','10','16',NULL,'Marital Status',NULL,NULL,'"drvStatusMarital"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESMARTDEM0Z0','50','D','10','17',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESMARTDEM0Z0','50','D','10','18',NULL,'Address',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESMARTDEM0Z0','50','D','10','19',NULL,'Apt Unit Ste',NULL,NULL,'"drvAptSte"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESMARTDEM0Z0','50','D','10','20',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESMARTDEM0Z0','50','D','10','21',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESMARTDEM0Z0','50','D','10','22',NULL,'Zip Code',NULL,NULL,'"drvCodeZip"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESMARTDEM0Z0','50','D','10','23',NULL,'County',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESMARTDEM0Z0','50','D','10','24',NULL,'Job Title',NULL,NULL,'"drvTitleJob"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESMARTDEM0Z0','50','D','10','25',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESMARTDEM0Z0','50','D','10','26',NULL,'Occupation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESMARTDEM0Z0','50','D','10','27',NULL,'Payroll Code',NULL,NULL,'"drvCodePayroll"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESMARTDEM0Z0','50','D','10','28',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''Q'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('FileName Is Auto Generated',NULL,NULL,NULL,'LGV2C,HJVZI,HJXM6,HJY4F,HJXPJ,HJWP4',NULL,NULL,NULL,'OnDemand Session','202201101','EMPEXPORT','ONDEMAND','Jan 13 2022  3:56PM','ESMARTDEM',NULL,NULL,NULL,'202201101','Jan 10 2022 12:00AM','Jan  9 2022 12:00AM','202201101','3053','','','202201101',dbo.fn_GetTimedKey(),NULL,'CNORRIS01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('FileName Is Auto Generated',NULL,NULL,NULL,'LGV2C,HJVZI,HJXM6,HJY4F,HJXPJ,HJWP4',NULL,NULL,NULL,'Scheduled Session','202001139','EMPEXPORT','SCHEDULED','Jan 14 2020 12:00AM','ESMARTDEM',NULL,NULL,NULL,'202001139','Jan 13 2020 12:00AM','Dec 30 1899 12:00AM','20200113',NULL,'','','20200113',dbo.fn_GetTimedKey(),NULL,'CNORRIS01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('FileName Is Auto Generated',NULL,NULL,NULL,'HJWS7,LGV2C,HJVZI,HJXM6,HJY4F,HJXT5,HJXPJ,HJWP4',NULL,NULL,NULL,'Test Purposes Only','202001139','EMPEXPORT','TEST','Jan 14 2020 12:00AM','ESMARTDEM',NULL,NULL,NULL,'202001139','Jan 13 2020 12:00AM','Dec 30 1899 12:00AM','202001061','3277','','','202001061',dbo.fn_GetTimedKey(),NULL,'ULTI_GPSHH',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMARTDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMARTDEM','ExportPath','V','\\us.saas\E0\data_exchange\GPS1000\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMARTDEM','InitialSort','C','drvNameLast');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMARTDEM','SubSort','C','drvNameFirst');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMARTDEM','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMARTDEM','TestPath','V','\\us.saas\e4\Public\GPS1000\Exports\SmartBen\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMARTDEM','UDESPath','C','\\us.saas\E0\data_exchange\GPS1000\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESMARTDEM','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESMARTDEM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESMARTDEM','D10','dbo.U_ESMARTDEM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ESMARTDEM_Audit
-----------

IF OBJECT_ID('U_ESMARTDEM_Audit') IS NULL
CREATE TABLE [dbo].[U_ESMARTDEM_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCoID] varchar(255) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audEffectiveDate] datetime NULL
);

-----------
-- Create table U_ESMARTDEM_AuditFields
-----------

IF OBJECT_ID('U_ESMARTDEM_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESMARTDEM_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESMARTDEM_drvTbl
-----------

IF OBJECT_ID('U_ESMARTDEM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESMARTDEM_drvTbl] (
    [drvUserName] varchar(14) NULL,
    [drvPayTypeID] char(5) NULL,
    [drvPassword] varchar(8000) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvAnnSalary] varchar(50) NULL,
    [drvStaticAnnSalary] varchar(50) NULL,
    [drvIDFacility] varchar(4) NULL,
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
-- Create table U_ESMARTDEM_EEList
-----------

IF OBJECT_ID('U_ESMARTDEM_EEList') IS NULL
CREATE TABLE [dbo].[U_ESMARTDEM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESMARTDEM_File
-----------

IF OBJECT_ID('U_ESMARTDEM_File') IS NULL
CREATE TABLE [dbo].[U_ESMARTDEM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE Procedure [dbo].[dsi_sp_BuildDriverTables_ESMARTDEM]
       @SystemID char(12)
AS

/*___________________________________________________________________________________

Client Name:         GPS Hospitality

Created By:          Mayu Kanakalingam - TekPartners
Integration Analyst: Patrick Clare
Create Date:         02/23/2017
Project Number:      SR-2017-00147332

Purpose:             SmartBen Employee Demographics Export

Revision History
----------------
Update By           Date           Request Num        Desc
N Wetherbee         03/29/2017                        Updated Gender logic
N Wetherbee         05/01/2017                        Updates to drvAnnSalary and drvStaticAnnSalary columns
M Souza                11/14/2017        SF 10008499          Created new Audit Fileds table to increase speed 
Anthony Ramos        01/14/2020        SF 16510290          Corrected audit table to correctly join data
Lisa Marcus            09/21/2022        SR-2022-00370937  Adding "Continuous year" logic per Christy Wasdin


Select * From dbo.U_dsi_Configuration Where FormatCode = 'ESMARTDEM';
Select * From dbo.AscExp Where expFormatCode = 'ESMARTDEM';
Select * From dbo.U_dsi_InterfaceActivityLog Where FormatCode = 'ESMARTDEM' Order BY RunID Desc;

Execute Export
--------------
dbo.dsi_sp_TestSwitchbox_v2 'ESMARTDEM', 'ONDEMAND';
dbo.dsi_sp_TestSwitchbox_v2 'ESMARTDEM', 'TEST';
dbo.dsi_sp_TestSwitchbox_v2 'ESMARTDEM', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESMARTDEM', @AllObjects = 'Y', @IsWeb = 'N'
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
 Where Exportcode = 'SCHEDULED' and FormatCode = 'ESMARTDEM'

 Select
         @StartDate       = Cast(substring(StartPerControl,1,8) as datetime)
        ,@EndDate         = Cast(substring(EndPerControl,1,8) as datetime)
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    From dbo.U_dsi_Parameters WITH (NOLOCK)
   Where FormatCode = 'ESMARTDEM';


-- Clean EE List 
-- Caution: Careful of cleaning EE List if including paycheck data
-- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company

Delete 
  From dbo.U_ESMARTDEM_EELIST 
 Where xCOID <> dbo.dsi_fn_GetCurrentCOID(xEEID)
   and xEEID in (Select xEEID From dbo.U_ESMARTDEM_EELIST Group by xEEID Having Count(*) > 1);


/*___________________________________________________________________________________*/

-- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('dbo.U_ESMARTDEM_AuditFields','U') IS NOT NULL
    DROP TABLE dbo.U_ESMARTDEM_AuditFields;
    CREATE TABLE dbo.U_ESMARTDEM_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ESMARTDEM_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ESMARTDEM_AuditFields VALUES ('EmpComp','EecDedGroupCode');

    If object_id('U_ESMARTDEM_Audit') is not null
    Drop table dbo.U_ESMARTDEM_Audit

Select 
   audEEID          = audKey1Value
  ,audCoID          = audKey2Value
  ,audFieldName     = audFieldName
  ,audEffectiveDate = max(audProcessedDateTime)
 INTO dbo.U_ESMARTDEM_Audit

 --From dbo.U_ESMARTDEM_EEList with (nolock) --AR SF 16510290
from dbo.dsi_vw_AuditData with (nolock)--on xEEID = audKey1Value and xCOID = audKey2Value
 --JOIN dbo.U_ESMARTDEM_AuditFields WITH (NOLOCK) 
 --       ON audTableName = aTableName
 --       AND audFieldName = aFieldName
Where audAction = 'Update' 
  and (
      (audNewValue = 'T' and audFieldName = 'EecEmplStatus' and audProcessedDateTime between @StartDate and @EndDate) or 
      (audFieldName = 'EecDedGroupCode' and audProcessedDateTime <= @EndDate)
       )
Group by audKey1Value,audKey2Value,audFieldName 



/*___________________________________________________________________________________*/

-- Build Employee Data and the driver tables

-- Detail Record for U_ESMARTDEM_drvTbl

If Object_ID('U_ESMARTDEM_drvTbl') is Not Null
   Drop Table dbo.U_ESMARTDEM_drvTbl;

Select Distinct                
       drvUserName          = 'GPS' + eepSSN
      ,drvPayTypeID         = EecDedGroupCode
      ,drvPassword          = replace(convert(varchar(10),eepDateOfBirth,101),'/','')
      ,drvSSN               = EepSSN
      ,drvNameLast          = EepNameLast
      ,drvNameFirst         = EepNameFirst
      ,drvNameMiddle        = eepNameMiddle
      ,drvAnnSalary         = Convert(varchar(50),Convert(decimal(12,2),(Case When EecJobCode in ('RAM','RAMT') Then EecHourlyPayRate * 2845.00 Else EecAnnSalary End)))
      ,drvStaticAnnSalary   = Convert(varchar(50),Convert(decimal(12,2),(Case When EecJobCode in ('RAM','RAMT') Then EecHourlyPayRate * 2845.00 Else EecAnnSalary End)))
      ,drvIDFacility        = case when CmpCompanyCode = '101' then '3139'
                                   when CmpCompanyCode = '102' then '3140'
                                   when CmpCompanyCode = '103' then '3141'
                                   when CmpCompanyCode = '104' then '3142'
                                   when CmpCompanyCode = '105' then '3143'
                                   when CmpCompanyCode = '106' then '4256'
                                   when CmpCompanyCode = '201' then '3144'
                                end
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
  INTO dbo.U_ESMARTDEM_drvTbl

  From dbo.U_ESMARTDEM_EEList with (nolock)
 Inner Join dbo.EmpComp with (nolock) on EecEEID = xEEID and EecCoID = xCoID
 Inner Join dbo.EmpPers with (nolock) on EepEEID = xEEID
 Left Outer Join dbo.Company with (nolock) on EecCoID = CmpCoID
 Left Outer JOin dbo.JobCode with (nolock) on EecJobCode = JbcJobCode
 Left Outer Join dbo.U_ESMARTDEM_Audit AudStat with (nolock) on xEEID = AudStat.audEEID and xCoID = AudStat.audCoID and AudStat.audFieldName  ='EecEmplStatus'
 Left Outer Join dbo.U_ESMARTDEM_Audit AudDed with (nolock) on xEEID = AudDed.audEEID and xCoID = AudDed.audCoID and AudDed.audFieldName = 'EecDedGroupCode'
 Where isnull(EecDedGroupCode,'') <> '17347'
   and (isnull(EecEmplStatus,'') <> 'T' or AudStat.audEEID is not Null)
 ;


/*___________________________________________________________________________________*/


-- Set FileName

If (dbo.dsi_fnVariable('ESMARTDEM','UseFileName') = 'N')
Begin
        Update dbo.U_dsi_Parameters
           Set ExportFile = 'GPSHospitality_SmartBenDemo_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
       Where FormatCode = 'ESMARTDEM';
End

End;


/*___________________________________________________________________________________

Select * From dbo.U_dsi_Configuration Where FormatCode = 'ESMARTDEM';
dbo.dsi_sp_TestSwitchbox_v2 'ESMARTDEM', 'ONDEMAND';
dbo.dsi_sp_TestSwitchbox_v2 'ESMARTDEM', 'TEST';

--Alter the View

Alter View dbo.dsi_vwESMARTDEM_Export as
    Select Top 20000000 Data From dbo.U_ESMARTDEM_File with (nolock)
    Order by Right(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF

Select * From dbo.AscDefF
Where AdfHeaderSystemID like 'ESMARTDEM%'
Order by AdfSetNumber, AdfFieldNumber;


Select * from U_ESMARTDEM_drvTbl where drvSuffix is not null




-- Update Dates

Update dbo.AscExp
   Set ExpLastStartPerControl = '201702161'
       ,ExpLastEndPerControl   = '201702239'
 Where ExpFormatCode = 'ESMARTDEM';

Select * From dbo.AscDefH Where adhFormatCode = 'ESMARTDEM';
Select * From dbo.AscExp Where expFormatCode = 'ESMARTDEM';
Select * From dbo.u_dsi_sqlclauses Where FormatCode = 'ESMARTDEM';

___________________________________________________________________________________*/
GO
Create View dbo.dsi_vwESMARTDEM_Export as
                            select top 200000000 Data from dbo.U_ESMARTDEM_File with (nolock)
                            order by substring(RecordSet,2,2), InitialSort, SubSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESMARTDEM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESMARTDEM'
   AND rpoParmType = 'expSystemID'


-- End ripout