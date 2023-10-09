/**********************************************************************************

EPNQDCDEM2: Principal NQDC Demographic TEST

FormatCode:     EPNQDCDEM2
Project:        Principal NQDC Demographic TEST
Client ID:      EMP1013
Date/time:      2023-10-05 11:42:31.093
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    N34
Server:         N3SUP4DB01
Database:       ULTIPRO_EMPBR
ExportPath:    \\us.saas\N0\data_exchange\EMP1013\Exports\
TestPath:      \\us.saas\N3\Public\EMP1013\Exports\PrincipalNQDCDemo\

NOTE:          MultFile is set to Y, meaning Switchbox doesn't directly write the file.
               The file(s) are probably created by an AfterCollect.


**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPNQDCDEM2_SavePath') IS NOT NULL DROP TABLE dbo.U_EPNQDCDEM2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPNQDCDEM2'


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
WHERE FormatCode = 'EPNQDCDEM2'
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
WHERE ExpFormatCode = 'EPNQDCDEM2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPNQDCDEM2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPNQDCDEM2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPNQDCDEM2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPNQDCDEM2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPNQDCDEM2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPNQDCDEM2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPNQDCDEM2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPNQDCDEM2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPNQDCDEM2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPNQDCDEM2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPNQDCDEM2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPNQDCDEM2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPNQDCDEM2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPNQDCDEM2];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_EPNQDCDEM2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_EPNQDCDEM2];
GO
IF OBJECT_ID('U_EPNQDCDEM2_File') IS NOT NULL DROP TABLE [dbo].[U_EPNQDCDEM2_File];
GO
IF OBJECT_ID('U_EPNQDCDEM2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPNQDCDEM2_EEList];
GO
IF OBJECT_ID('U_EPNQDCDEM2_drvTblCLOSED') IS NOT NULL DROP TABLE [dbo].[U_EPNQDCDEM2_drvTblCLOSED];
GO
IF OBJECT_ID('U_EPNQDCDEM2_drvTblACTIVE') IS NOT NULL DROP TABLE [dbo].[U_EPNQDCDEM2_drvTblACTIVE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPNQDCDEM2','Principal NQDC Demographic TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','8000','S','N','EPNQDCDEM220','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPNQDCDEM220','50','H','01','1',NULL,'Contract ID',NULL,NULL,'"Contract ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPNQDCDEM220','50','H','01','2',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPNQDCDEM220','50','H','01','3',NULL,'Company Provided ID',NULL,NULL,'"Company Provided ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPNQDCDEM220','50','H','01','4',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPNQDCDEM220','50','H','01','5',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPNQDCDEM220','50','H','01','6',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPNQDCDEM220','50','H','01','7',NULL,'Street Address 1',NULL,NULL,'"Street Address 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPNQDCDEM220','50','H','01','8',NULL,'Street Address 2',NULL,NULL,'"Street Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPNQDCDEM220','50','H','01','9',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPNQDCDEM220','50','H','01','10',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPNQDCDEM220','50','H','01','11',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPNQDCDEM220','50','H','01','12',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPNQDCDEM220','50','H','01','13',NULL,'Home Phone',NULL,NULL,'"Home Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPNQDCDEM220','50','H','01','14',NULL,'Day Phone',NULL,NULL,'"Day Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPNQDCDEM220','50','H','01','15',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPNQDCDEM220','50','H','01','17',NULL,'Plan Eligibility Date',NULL,NULL,'"Plan Eligibility Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPNQDCDEM220','50','H','01','18',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPNQDCDEM220','50','H','01','19',NULL,'Title',NULL,NULL,'"Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPNQDCDEM220','50','H','01','20',NULL,'Salary',NULL,NULL,'"Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPNQDCDEM220','50','H','01','21',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPNQDCDEM220','50','H','01','22',NULL,'Designation',NULL,NULL,'"Designation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPNQDCDEM220','50','H','02','1',NULL,'Contract ID',NULL,NULL,'"Contract ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPNQDCDEM220','50','H','02','2',NULL,'SSN',NULL,NULL,'"SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPNQDCDEM220','50','H','02','3',NULL,'Company Provided ID',NULL,NULL,'"Company Provided ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPNQDCDEM220','50','H','02','4',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPNQDCDEM220','50','H','02','5',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPNQDCDEM220','50','H','02','6',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPNQDCDEM220','50','H','02','7',NULL,'Street Address 1',NULL,NULL,'"Street Address 1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPNQDCDEM220','50','H','02','8',NULL,'Street Address 2',NULL,NULL,'"Street Address 2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPNQDCDEM220','50','H','02','9',NULL,'City',NULL,NULL,'"City"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPNQDCDEM220','50','H','02','10',NULL,'State',NULL,NULL,'"State"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPNQDCDEM220','50','H','02','11',NULL,'Zip',NULL,NULL,'"Zip"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPNQDCDEM220','50','H','02','12',NULL,'Email',NULL,NULL,'"Email"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPNQDCDEM220','50','H','02','13',NULL,'Home Phone',NULL,NULL,'"Home Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPNQDCDEM220','50','H','02','14',NULL,'Day Phone',NULL,NULL,'"Day Phone"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPNQDCDEM220','50','H','02','15',NULL,'Date of Birth',NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPNQDCDEM220','50','H','02','17',NULL,'Plan Eligibility Date',NULL,NULL,'"Plan Eligibility Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPNQDCDEM220','50','H','02','18',NULL,'Termination Date',NULL,NULL,'"Termination Date"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPNQDCDEM220','50','H','02','19',NULL,'Title',NULL,NULL,'"Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPNQDCDEM220','50','H','02','20',NULL,'Salary',NULL,NULL,'"Salary"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPNQDCDEM220','50','H','02','21',NULL,'Location',NULL,NULL,'"Location"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPNQDCDEM220','50','H','02','22',NULL,'Designation',NULL,NULL,'"Designation"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPNQDCDEM220','50','D','10','1',NULL,'Contract ID',NULL,NULL,'"drvContractID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPNQDCDEM220','50','D','10','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPNQDCDEM220','50','D','10','3',NULL,'Company Provided ID',NULL,NULL,'"drvCompanyProvidedID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPNQDCDEM220','50','D','10','4',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPNQDCDEM220','50','D','10','5',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPNQDCDEM220','50','D','10','6',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPNQDCDEM220','50','D','10','7',NULL,'Street Address 1',NULL,NULL,'"drvStreetAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPNQDCDEM220','50','D','10','8',NULL,'Street Address 2',NULL,NULL,'"drvStreetAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPNQDCDEM220','50','D','10','9',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPNQDCDEM220','50','D','10','10',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPNQDCDEM220','50','D','10','11',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPNQDCDEM220','50','D','10','12',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPNQDCDEM220','50','D','10','13',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPNQDCDEM220','50','D','10','14',NULL,'Day Phone',NULL,NULL,'"drvDayPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPNQDCDEM220','50','D','10','15',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPNQDCDEM220','50','D','10','17',NULL,'Plan Eligibility Date',NULL,NULL,'"drvPlanEligibilityDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPNQDCDEM220','50','D','10','18',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPNQDCDEM220','50','D','10','19',NULL,'Title',NULL,NULL,'"drvTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPNQDCDEM220','50','D','10','20',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPNQDCDEM220','50','D','10','21',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPNQDCDEM220','50','D','10','22',NULL,'Designation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPNQDCDEM220','50','D','20','1',NULL,'Contract ID',NULL,NULL,'"drvContractID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPNQDCDEM220','50','D','20','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPNQDCDEM220','50','D','20','3',NULL,'Company Provided ID',NULL,NULL,'"drvCompanyProvidedID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPNQDCDEM220','50','D','20','4',NULL,'Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPNQDCDEM220','50','D','20','5',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPNQDCDEM220','50','D','20','6',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPNQDCDEM220','50','D','20','7',NULL,'Street Address 1',NULL,NULL,'"drvStreetAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPNQDCDEM220','50','D','20','8',NULL,'Street Address 2',NULL,NULL,'"drvStreetAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPNQDCDEM220','50','D','20','9',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPNQDCDEM220','50','D','20','10',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPNQDCDEM220','50','D','20','11',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPNQDCDEM220','50','D','20','12',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPNQDCDEM220','50','D','20','13',NULL,'Home Phone',NULL,NULL,'"drvHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPNQDCDEM220','50','D','20','14',NULL,'Day Phone',NULL,NULL,'"drvDayPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPNQDCDEM220','50','D','20','15',NULL,'Date of Birth',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPNQDCDEM220','50','D','20','17',NULL,'Plan Eligibility Date',NULL,NULL,'"drvPlanEligibilityDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPNQDCDEM220','50','D','20','18',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPNQDCDEM220','50','D','20','19',NULL,'Title',NULL,NULL,'"drvTitle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPNQDCDEM220','50','D','20','20',NULL,'Salary',NULL,NULL,'"drvSalary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPNQDCDEM220','50','D','20','21',NULL,'Location',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPNQDCDEM220','50','D','20','22',NULL,'Designation',NULL,NULL,'""','(''SS''=''T,'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Principal NQDC Demographic Exp','201908021','EMPEXPORT','ONDEMAND','Aug  7 2019  9:54AM','EPNQDCDEM2',NULL,NULL,NULL,'201908021','Aug  2 2019 12:00AM','Jul 28 2019 12:00AM','201908021','618',NULL,NULL,'201908021',dbo.fn_GetTimedKey(),NULL,'TGRAY',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201905209','EMPEXPORT','SCHEDULED','Oct  4 2023  8:30PM','EPNQDCDEM2',NULL,NULL,NULL,'202310049','May 20 2019  9:04AM','May 20 2019  9:04AM','202310041',NULL,NULL,NULL,'201905201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202310021','EMPEXPORT','TEST','Oct  2 2023 10:33AM','EPNQDCDEM2',NULL,NULL,NULL,'202310021','Oct  2 2023 12:00AM','Dec 30 1899 12:00AM','202309251','216',NULL,NULL,'202309251',dbo.fn_GetTimedKey(),NULL,'us3kEpEMP1013',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNQDCDEM2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNQDCDEM2','ExportPath','V','\\us.saas\N0\data_exchange\EMP1013\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNQDCDEM2','InitialSort','C','drvNameLast');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNQDCDEM2','MultFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNQDCDEM2','SubSort','C','drvNameFirst');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNQDCDEM2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNQDCDEM2','TestPath','V','\\us.saas\N3\Public\EMP1013\Exports\PrincipalNQDCDemo\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNQDCDEM2','UDESPath','C','\\us.saas\N0\data_exchange\EMP1013\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNQDCDEM2','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPNQDCDEM2','D10','dbo.U_EPNQDCDEM2_drvTblACTIVE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPNQDCDEM2','D20','dbo.U_EPNQDCDEM2_drvTblCLOSED',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EPNQDCDEM2_drvTblACTIVE
-----------

IF OBJECT_ID('U_EPNQDCDEM2_drvTblACTIVE') IS NULL
CREATE TABLE [dbo].[U_EPNQDCDEM2_drvTblACTIVE] (
    [drvEEID] char(12) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvContractID] varchar(6) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvCompanyProvidedID] char(9) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvStreetAddress1] varchar(8000) NULL,
    [drvStreetAddress2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvEmail] nvarchar(4000) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvDayPhone] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvPlanEligibilityDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvTitle] varchar(8000) NULL,
    [drvSalary] nvarchar(4000) NULL,
    [drvLocation] varchar(8000) NULL
);

-----------
-- Create table U_EPNQDCDEM2_drvTblCLOSED
-----------

IF OBJECT_ID('U_EPNQDCDEM2_drvTblCLOSED') IS NULL
CREATE TABLE [dbo].[U_EPNQDCDEM2_drvTblCLOSED] (
    [drvEEID] char(12) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvContractID] varchar(6) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvCompanyProvidedID] char(9) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvStreetAddress1] varchar(8000) NULL,
    [drvStreetAddress2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvEmail] nvarchar(4000) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvDayPhone] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvPlanEligibilityDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvTitle] varchar(8000) NULL,
    [drvSalary] nvarchar(4000) NULL,
    [drvLocation] varchar(8000) NULL
);

-----------
-- Create table U_EPNQDCDEM2_EEList
-----------

IF OBJECT_ID('U_EPNQDCDEM2_EEList') IS NULL
CREATE TABLE [dbo].[U_EPNQDCDEM2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPNQDCDEM2_File
-----------

IF OBJECT_ID('U_EPNQDCDEM2_File') IS NULL
CREATE TABLE [dbo].[U_EPNQDCDEM2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EPNQDCDEM2]
AS
SET NOCOUNT ON;
/************************************************************
Client: EmployBridge, LLC.

Created By: Ozzie Vazquez
Create Date: 05/20/2019

Purpose: GENERATE MULTIPLE FILES WITH CUSTOM BCP STATEMENT

Revision History
----------------
Update By    Date    Request Num    Desc
Marie Waters 10/5/2023 
XXXX         XX/XX/19    SR-2019-00XXXXXX    XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPNQDCDEM2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPNQDCDEM2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPNQDCDEM2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EPNQDCDEM2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPNQDCDEM2' ORDER BY RunID DESC;

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPNQDCDEM2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPNQDCDEM2', 'TEST';
************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE @FormatCode      VARCHAR(10)
        ,@ExportCode         VARCHAR(10)
        ,@ExportPath         VARCHAR(500)
        ,@dbName             VARCHAR(50)
        ,@NoEmpty            CHAR(1)
        ,@sCmd               VARCHAR(1000)
        ,@QueryInfo          VARCHAR(1000)
        ,@RowCount           INT
        ,@TestPrefix         VARCHAR(5);

    -- Set variables
    SET @FormatCode = 'EPNQDCDEM2';
    SET @TestPrefix = CASE WHEN (@ExportCode LIKE '%TEST%' OR @ExportCode LIKE '%TST%' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y') THEN 'TEST_' ELSE '' END

    SELECT @ExportCode = ExportCode
       ,@ExportPath = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'IsUTF8') = 'Y' THEN dbo.dsi_fnVariable(@FormatCode,'UTF8Path') -- If using UTF8 Converter, then use UTF8Path instead of ExportPath
                           WHEN (@ExportCode LIKE '%TEST%' OR @ExportCode LIKE '%TST%' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y') AND dbo.dsi_fnVariable(@FormatCode,'TestPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'TestPath')
                           WHEN @ExportCode LIKE '%OE%' AND dbo.dsi_fnVariable(@FormatCode,'OEPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'OEPath')
                           WHEN @ExportCode IN ('ONDEMAND','ON_DEMAND') AND dbo.dsi_fnVariable(@FormatCode,'OnDemandPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'OnDemandPath')
                           ELSE dbo.dsi_fnVariable(@FormatCode,'ExportPath')
                      END
       ,@dbName     = RTRIM(DB_NAME())
       ,@NoEmpty    = dbo.dsi_fnVariable(FormatCode,'NoEmpty')
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    -- =================================================
    -- Define Filenames By Header & Detail ID in File
    -- =================================================

    DECLARE @FilesOut AS TABLE
    (
         RowID                INT IDENTITY(1,1)
        ,RecordSetGroup      VARCHAR(100)
        ,CustomFileName      VARCHAR(1000)
    );

    INSERT INTO @FilesOut (RecordSetGroup, CustomFileName)
    SELECT RecordSetGroup = 'H01,D10', CustomFileName = '517308_TEST' + FORMAT(GETDATE(),'MMddyyyy') + '.csv'   -- FILE# 1
    UNION ALL
    SELECT RecordSetGroup = 'H02,D20', CustomFileName = '463914_TEST' + FORMAT(GETDATE(),'MMddyyyy') + '.csv'   -- FILE# 2

    SET @RowCount = (SELECT COUNT(*) FROM @FilesOut);

    -- ==================================================    
    -- Generate Multiple Files via Custom BCP statement:
    -- ==================================================    
    -- Declare variables
    DECLARE  @RecordSetGroup  VARCHAR(100)
        ,@FileName            VARCHAR(100)
        ,@LoopCount           INT;

    SET @LoopCount = 1;

    -- Begin Process of Exporting Multiple Files
    WHILE @LoopCount <= @RowCount
    BEGIN

    -- Set FileName to Export Based On Record Set Group (Header,Detail,Trailer Records)
    SELECT 
         @RecordSetGroup = RecordSetGroup
        ,@FileName = CustomFileName
    FROM @FilesOut
    WHERE RowID = @LoopCount;

    -- Set Query To Be Exported
    SET @QueryInfo = '"SELECT TOP 2000000 Data FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File WITH (NOLOCK) '
                        + 'WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''') '
                        + 'ORDER BY RIGHT(RECORDSET,2), InitialSort, SubSort"';

    -- Set Custom BCP Statement
    SELECT @sCmd = 'BCP ' + @QueryInfo + ' QUERYOUT "' + @ExportPath + @TestPrefix + @FileName +'"' + 
              ' -S"' + RTRIM(@@SERVERNAME) + '" -T -c';
    
    IF (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y')
    BEGIN
        PRINT 'Custom BCP For File# ' + CONVERT(VARCHAR(2),@LoopCount) + ': ' + ISNULL(@FileName,'');
        PRINT 'Custom BCP Statement: ' + ISNULL(@sCmd,'');
    END;

    -- Get Record Count
    DECLARE @RecordCnt INT, @Query NVARCHAR(1000);
    SET @Query = N'SELECT @RecordCount = COUNT(*) FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File WITH (NOLOCK) WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''')';
    EXECUTE master.dbo.sp_executesql @Query, N'@RecordCount INT OUTPUT',  @RecordCount = @RecordCnt OUTPUT;

    IF @RecordCnt = 0 AND @NoEmpty = 'Y'
    BEGIN
        IF (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y')
        BEGIN
            PRINT 'There are no records in the file, so no file will be created.'
        END
    END ELSE BEGIN
        -- Output File
        EXEC master.dbo.xp_cmdshell @sCmd, NO_OUTPUT;
    END;

    -- Get Next FileName
    SET @LoopCount = @LoopCount + 1;

    END;

END;
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPNQDCDEM2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: EmployBridge, LLC.

Created By: Ozzie Vazquez
Business Analyst: Kate Elliott
Create Date: 05/20/2019
Service Request Number: SR-2019-00233236

Purpose: Principal NQDC Demographic TEST

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX
Willie Chong        08/18/2022        SR-2022-00349578    Update contract number
Marie Waters        10/05/2023      TekP-2023-09-12-03    Update to remove hire and rehire date fields  


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPNQDCDEM2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPNQDCDEM2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPNQDCDEM2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPNQDCDEM2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPNQDCDEM2' ORDER BY RunID DESC;

Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPNQDCDEM2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPNQDCDEM2', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPNQDCDEM2', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPNQDCDEM2', @AllObjects = 'Y', @IsWeb = 'N'

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
    SELECT @FormatCode = 'EPNQDCDEM2';

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
    DELETE FROM dbo.U_EPNQDCDEM2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPNQDCDEM2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPNQDCDEM2_drvTblACTIVE
    ---------------------------------
    IF OBJECT_ID('U_EPNQDCDEM2_drvTblACTIVE','U') IS NOT NULL
        DROP TABLE dbo.U_EPNQDCDEM2_drvTblACTIVE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        -- standard fields above and additional driver fields below
        ,drvContractID = '727271' --'517308' --8/18/22 WC
        ,drvSSN = EepSSN
        ,drvCompanyProvidedID = EMP.EecEmpNo
        ,drvLastName = REPLACE(EepNameLast,',','')
        ,drvFirstName = REPLACE(EepNameFirst,',','')
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvStreetAddress1 = REPLACE(EepAddressLine1,',','')
        ,drvStreetAddress2 = REPLACE(EepAddressLine2,',','')
        ,drvCity = REPLACE(EepAddressCity,',','')
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvEmail = (SELECT REPLACE(Employee_WorkEmail,',','') FROM dbo.fn_mp_customfields_emppers_export (null,null,null,null) WHERE EEID = xEEID)
        ,drvHomePhone = CASE EepPhoneHomeNumber
                            WHEN '0000000000' THEN ''
                            ELSE EepPhoneHomeNumber
                        END
        ,drvDayPhone = CASE EecPhoneBusinessNumber
                           WHEN '0000000000' THEN ''                        
                           ELSE EecPhoneBusinessNumber
                       END
        ,drvDateOfBirth = EepDateOfBirth
       -- ,drvDateOfHire = EMP.EecDateOfLastHire
        ,drvPlanEligibilityDate = (SELECT DATEADD(yy, DATEDIFF(yy,0,MAX(Employment_NonQualifiedEligible))+1, 0) FROM dbo.fn_mp_customfields_empcomp_export (null,null,null,null) WHERE EecEEID = xEEID)
        ,drvTerminationDate = CASE WHEN EMP.EecEmplStatus = 'T' THEN EMP.EecDateOfTermination END
        ,drvTitle = REPLACE(JbcDesc,',','')
        ,drvSalary = FORMAT(EMP.EecAnnSalary,'0.00')
        ,drvLocation = REPLACE(EMP.EecLocation,',','')
        --,drvRehireDate = CASE 
        --                     WHEN EMP.EecDateOfOriginalHire <> EMP.EecDateOfLastHire
        --                         THEN EMP.EecDateOfLastHire
        --                     ELSE NULL
        --                 END
    INTO dbo.U_EPNQDCDEM2_drvTblACTIVE
    FROM dbo.U_EPNQDCDEM2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp EMP WITH (NOLOCK)
        ON EMP.EecEEID = xEEID 
        AND EMP.EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON EMP.EecJobCode = JbcJobCode
    LEFT JOIN dbo.fn_mp_customfields_empcomp_export (null,null,null,null) PCF
        ON PCF.EecEEID = xEEID
    WHERE PCF.Employment_SSDeferredCompParticipant = '0'
        AND PCF.Employment_NonQualifiedEligible IS NOT NULL
        AND PCF.EecCoID = EepHomeCoID
        AND (EMP.EecEmplStatus <> 'T'
            OR (EMP.EecEmplStatus = 'T' AND EMP.EecDateOfTermination BETWEEN @StartDate AND @EndDate AND EMP.EecTermReason NOT IN ('TRI','TRO')))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPNQDCDEM2_drvTblCLOSED
    ---------------------------------
    IF OBJECT_ID('U_EPNQDCDEM2_drvTblCLOSED','U') IS NOT NULL
        DROP TABLE dbo.U_EPNQDCDEM2_drvTblCLOSED;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        -- standard fields above and additional driver fields below
        ,drvContractID = '463914'
        ,drvSSN = EepSSN
        ,drvCompanyProvidedID = EMP.EecEmpNo
        ,drvLastName = REPLACE(EepNameLast,',','')
        ,drvFirstName = REPLACE(EepNameFirst,',','')
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvStreetAddress1 = REPLACE(EepAddressLine1,',','')
        ,drvStreetAddress2 = REPLACE(EepAddressLine2,',','')
        ,drvCity = REPLACE(EepAddressCity,',','')
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvEmail = (SELECT REPLACE(Employee_WorkEmail,',','') FROM dbo.fn_mp_customfields_emppers_export (null,null,null,null) WHERE EEID = xEEID)
        ,drvHomePhone = CASE EepPhoneHomeNumber
                            WHEN '0000000000' THEN ''
                            ELSE EepPhoneHomeNumber
                        END
        ,drvDayPhone = CASE EecPhoneBusinessNumber
                           WHEN '0000000000' THEN ''                        
                           ELSE EecPhoneBusinessNumber
                       END
        ,drvDateOfBirth = EepDateOfBirth
       -- ,drvDateOfHire = EMP.EecDateOfLastHire
        ,drvPlanEligibilityDate = (SELECT DATEADD(yy, DATEDIFF(yy,0,MAX(Employment_NonQualifiedEligible))+1, 0) FROM dbo.fn_mp_customfields_empcomp_export (null,null,null,null) WHERE EecEEID = xEEID)
        ,drvTerminationDate = CASE WHEN EMP.EecEmplStatus = 'T' THEN EMP.EecDateOfTermination END
        ,drvTitle = REPLACE(JbcDesc,',','')
        ,drvSalary = FORMAT(EMP.EecAnnSalary,'0.00')
        ,drvLocation = REPLACE(EMP.EecLocation,',','')
        --,drvRehireDate = CASE 
        --                     WHEN EMP.EecDateOfOriginalHire <> EMP.EecDateOfLastHire
        --                         THEN EMP.EecDateOfLastHire
        --                     ELSE NULL
        --                 END
    INTO dbo.U_EPNQDCDEM2_drvTblCLOSED
    FROM dbo.U_EPNQDCDEM2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp EMP WITH (NOLOCK)
        ON EMP.EecEEID = xEEID 
        AND EMP.EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON EMP.EecJobCode = JbcJobCode
    LEFT JOIN dbo.fn_mp_customfields_empcomp_export (null,null,null,null) PCF
        ON PCF.EecEEID = xEEID
        AND PCF.EecCoID = EepHomeCoID
    WHERE PCF.Employment_SSDeferredCompParticipant = '1'
        --AND PCF.Employment_NonQualifiedEligible IS NOT NULL
        AND (EMP.EecEmplStatus <> 'T'
            OR (EMP.EecEmplStatus = 'T' AND EMP.EecDateOfTermination BETWEEN @StartDate AND @EndDate AND EMP.EecTermReason NOT IN ('TRI','TRO')))
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'Set in AfterCollect'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEPNQDCDEM2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPNQDCDEM2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPNQDCDEM2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201905131'
       ,expStartPerControl     = '201905131'
       ,expLastEndPerControl   = '201905209'
       ,expEndPerControl       = '201905209'
WHERE expFormatCode = 'EPNQDCDEM2';



    --------JOB NAME: Principal NQDC Demographic TEST (EPNQDCDEM2) - Bi-Weekly, Wednesday, 8:30pm ET--------
    --Copy and paste this in environment to create job script

    BEGIN TRANSACTION
    DECLARE @ReturnCode INT, @JobName varchar(100), @dbName varchar(50)
    SELECT @ReturnCode = 0
    SELECT @JobName = RTRIM(REPLACE(DB_NAME(),'ULTIPRO_','')) + ' - Principal NQDC Demographic TEST (EPNQDCDEM2) - Bi-Weekly, Wednesday, 8:30pm ET'
    SELECT @dbname = RTRIM(DB_NAME())

    -- Job Params
    IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
    BEGIN
    EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    END

    DECLARE @jobId BINARY(16)
    EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
            @enabled=0,
            @notify_level_eventlog=0, 
            @notify_level_email=0, 
            @notify_level_netsend=0, 
            @notify_level_page=0, 
            @delete_level=0, 
            @description=N'No description available.', 
            @category_name=N'[Uncategorized (Local)]', 
            @job_id = @jobId OUTPUT
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step [Run]
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Update AscExp'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update AscExp Start/End Date (EPNQDCDEM2)', 
            @step_id=1, 
            @cmdexec_success_code=0, 
            @on_success_action=3, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'DECLARE @StartPerControl char(9), 
        @EndPerControl char(9), 
        @RunDate datetime; 

    SELECT @StartPerControl = CONVERT(char(8),GETDATE()-14,112) + ''1''; 
    SELECT @EndPerControl = CONVERT(char(8),GETDATE()-1,112) + ''9''; 
    SELECT @RunDate = GETDATE(); 

UPDATE dbo.AscExp
SET    expStartPerControl = @StartPerControl,
    expLastStartPerControl = @StartPerControl,
    expEndPerControl = @EndPerControl,
    expLastEndPerControl = @EndPerControl,
    expExported = @RunDate
WHERE expFormatCode = ''EPNQDCDEM2''
  AND expExportCode = ''SCHEDULED'';',
            @database_name=@dbName,
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Run SP'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Export File (EPNQDCDEM2)', 
            @step_id=2, 
            @cmdexec_success_code=0, 
            @on_success_action=1, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'EXEC dbo.dsi_sp_TestSwitchbox_v2 ''EPNQDCDEM2'', ''SCHEDULED'';', 
            @database_name=@dbName, 
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Bi-Weekly, Wednesday, 8:30pm ET',
            @enabled=1, 
            @freq_type=8, 
            @freq_interval=8,  
            @freq_subday_type=1, 
            @freq_subday_interval=0, 
            @freq_relative_interval=0,
            @freq_recurrence_factor=2,
            @active_start_date=20190520,
            @active_end_date=99991231,
            @active_start_time=203000,
            @active_end_time=235959;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC msdb..usg_set_job_owner @job_id = @jobId, @set_owner_to_self = 0;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    COMMIT TRANSACTION
    GOTO EndSave;
    QuitWithRollback:
        IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
    EndSave:

    GO
    --------END JOB SCRIPT--------
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPNQDCDEM2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPNQDCDEM2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPNQDCDEM2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPNQDCDEM2'
   AND rpoParmType = 'expSystemID'


-- End ripout