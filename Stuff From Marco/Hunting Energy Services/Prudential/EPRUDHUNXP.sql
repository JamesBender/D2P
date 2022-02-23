/**********************************************************************************

EPRUDHUNXP: Prudential Vol Accident

FormatCode:     EPRUDHUNXP
Project:        Prudential Vol Accident
Client ID:      HUN1010
Date/time:      2021-12-12 17:49:20.630
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP4DB01
Database:       ULTIPRO_WPHUNTE
Web Filename:   HUN1010_G7W9W_EEHISTORY_EPRUDHUNXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPRUDHUNXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EPRUDHUNXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPRUDHUNXP'


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
WHERE FormatCode = 'EPRUDHUNXP'
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
WHERE ExpFormatCode = 'EPRUDHUNXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPRUDHUNXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPRUDHUNXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPRUDHUNXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPRUDHUNXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPRUDHUNXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPRUDHUNXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPRUDHUNXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPRUDHUNXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPRUDHUNXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPRUDHUNXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPRUDHUNXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRUDHUNXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRUDHUNXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDHUNXP];
GO
IF OBJECT_ID('U_EPRUDHUNXP_Headerl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_Headerl];
GO
IF OBJECT_ID('U_EPRUDHUNXP_File') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_File];
GO
IF OBJECT_ID('U_EPRUDHUNXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_EEList];
GO
IF OBJECT_ID('U_EPRUDHUNXP_drvTrailer') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_drvTrailer];
GO
IF OBJECT_ID('U_EPRUDHUNXP_drvEmpTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_drvEmpTbl];
GO
IF OBJECT_ID('U_EPRUDHUNXP_drvDepTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_drvDepTbl];
GO
IF OBJECT_ID('U_EPRUDHUNXP_drvCovTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_drvCovTbl];
GO
IF OBJECT_ID('U_EPRUDHUNXP_drvAstTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_drvAstTbl];
GO
IF OBJECT_ID('U_EPRUDHUNXP_drvAbsTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_drvAbsTbl];
GO
IF OBJECT_ID('U_EPRUDHUNXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_DedList];
GO
IF OBJECT_ID('U_EPRUDHUNXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_AuditFields];
GO
IF OBJECT_ID('U_EPRUDHUNXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPRUDHUNXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EPRUDHUNXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPRUDHUNXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPRUDHUNXP','Prudential Vol Accident','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EPRUDHUNXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDHUNXPZ0','3','H','01','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDHUNXPZ0','4','H','01','2',NULL,'Transmission GUID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDHUNXPZ0','14','H','01','3',NULL,'File Creation Date Time',NULL,NULL,'"drvFileCreationDateTime"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDHUNXPZ0','10','H','01','4',NULL,'Control Number',NULL,NULL,'"drvControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDHUNXPZ0','50','H','01','50',NULL,'Client Name',NULL,NULL,'"drvClientName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDHUNXPZ0','50','H','01','6',NULL,'File Type Version',NULL,NULL,'"drvFileTypeVersion"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDHUNXPZ0','50','H','01','50',NULL,'Sender Name',NULL,NULL,'"drvSenderName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDHUNXPZ0','50','H','01','7',NULL,'Sender Platform Name',NULL,NULL,'"drvSenderPlatformName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDHUNXPZ0','50','H','01','7',NULL,'Test Production Code',NULL,NULL,'"drvTestProdCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDHUNXPZ0','12','H','01','2',NULL,'Transmission GUID',NULL,NULL,'"drvFileType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDHUNXPZ0','14','H','01','6',NULL,'Activity Start Date Time',NULL,NULL,'"drvActivityDateTime"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDHUNXPZ0','14','H','01','7',NULL,'Activity End Date Time',NULL,NULL,'"drvActivityEndDateTime"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDHUNXPZ0','3','D','10','1',NULL,'Record Type',NULL,NULL,'"AST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDHUNXPZ0','10','D','10','2',NULL,'Control Number',NULL,NULL,'"53027"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDHUNXPZ0','32','D','10','3',NULL,'Associate Identifier',NULL,NULL,'"drvASTAssociateId"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDHUNXPZ0','9','D','10','4',NULL,'Social Security Number',NULL,NULL,'"drvASTSSNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDHUNXPZ0','25','D','10','5',NULL,'Gender Code',NULL,NULL,'"drvASTGendeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDHUNXPZ0','8','D','10','6',NULL,'Date of Birth',NULL,NULL,'"drvASTDateOfBirth"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDHUNXPZ0','8','D','10','7',NULL,'Date of Death',NULL,NULL,'"drvASTDateofDeath"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDHUNXPZ0','25','D','10','8',NULL,'Smoker Status Code',NULL,NULL,'"drvASTSmokerStatus"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDHUNXPZ0','30','D','10','9',NULL,'Marital Status Code',NULL,NULL,'"drvASTMaritalStatus"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDHUNXPZ0','30','D','10','10',NULL,'Prefix Title Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDHUNXPZ0','30','D','10','10',NULL,'Suffix Title Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDHUNXPZ0','50','D','10','11',NULL,'First Name',NULL,NULL,'"drvASTLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDHUNXPZ0','50','D','10','12',NULL,'Middle Name',NULL,NULL,'"drvASTFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDHUNXPZ0','80','D','10','13',NULL,'Last Name',NULL,NULL,'"drvASTMiddleName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDHUNXPZ0','25','D','10','15',NULL,'Address Type Code 1',NULL,NULL,'"drvAddressTypeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDHUNXPZ0','64','D','10','16',NULL,'Address Line 1 Text 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDHUNXPZ0','64','D','10','17',NULL,'Address Line 2 Text 1',NULL,NULL,'"drvAddressLine2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRUDHUNXPZ0','64','D','10','18',NULL,'Address Line 3 Text 1',NULL,NULL,'"drvAddressLine3"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRUDHUNXPZ0','50','D','10','19',NULL,'City Name 1',NULL,NULL,'"drvCity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRUDHUNXPZ0','2','D','10','20',NULL,'State Province Code 1',NULL,NULL,'"drvStateProvinceCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRUDHUNXPZ0','12','D','10','21',NULL,'Postal Code 1',NULL,NULL,'"drvPostalCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRUDHUNXPZ0','35','D','10','22',NULL,'Country Code 1',NULL,NULL,'"drvCountryCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRUDHUNXPZ0','25','D','10','23',NULL,'Address Type Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRUDHUNXPZ0','64','D','10','24',NULL,'Address Line 1 Text 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRUDHUNXPZ0','64','D','10','25',NULL,'Address Line 2 Text 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRUDHUNXPZ0','64','D','10','26',NULL,'Address Line 3 Text 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRUDHUNXPZ0','50','D','10','27',NULL,'City Name 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRUDHUNXPZ0','2','D','10','28',NULL,'State Province Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRUDHUNXPZ0','12','D','10','29',NULL,'Postal Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRUDHUNXPZ0','35','D','10','30',NULL,'Country Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRUDHUNXPZ0','25','D','10','23',NULL,'Address Type Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRUDHUNXPZ0','64','D','10','24',NULL,'Address Line 1 Text 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRUDHUNXPZ0','64','D','10','25',NULL,'Address Line 2 Text 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRUDHUNXPZ0','64','D','10','26',NULL,'Address Line 3 Text 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRUDHUNXPZ0','50','D','10','27',NULL,'City Name 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRUDHUNXPZ0','2','D','10','28',NULL,'State Province Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRUDHUNXPZ0','12','D','10','29',NULL,'Postal Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRUDHUNXPZ0','35','D','10','30',NULL,'Country Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRUDHUNXPZ0','30','D','10','31',NULL,'Telephone Type Code 1',NULL,NULL,'"drvPhoneTypeCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRUDHUNXPZ0','20','D','10','32',NULL,'Telephone Number 1',NULL,NULL,'"drvPhoneNumber1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRUDHUNXPZ0','10','D','10','33',NULL,'Telephone Number Extension 1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRUDHUNXPZ0','30','D','10','34',NULL,'Telephone Type Code 2',NULL,NULL,'"drvPhoneTypeCode2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRUDHUNXPZ0','20','D','10','35',NULL,'Telephone Number 2',NULL,NULL,'"drvPhoneNumber2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRUDHUNXPZ0','10','D','10','36',NULL,'Telephone Number Extension 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRUDHUNXPZ0','30','D','10','34',NULL,'Telephone Type Code 3',NULL,NULL,'"drvPhoneTypeCode3"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRUDHUNXPZ0','20','D','10','35',NULL,'Telephone Number 3',NULL,NULL,'"drvPhoneNumber3"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPRUDHUNXPZ0','10','D','10','36',NULL,'Telephone Number Extension 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPRUDHUNXPZ0','25','D','10','37',NULL,'Email Address Type Code 1',NULL,NULL,'"drvEmailTypeCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPRUDHUNXPZ0','350','D','10','38',NULL,'Email Address Text 1',NULL,NULL,'"drvEmail1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPRUDHUNXPZ0','25','D','10','39',NULL,'Email Address Type Code 2',NULL,NULL,'"drvEmailTypeCode2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPRUDHUNXPZ0','350','D','10','40',NULL,'Email Address Text 2',NULL,NULL,'"drvEmail2"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDHUNXPZ0','3','D','15','1',NULL,'Record Type',NULL,NULL,'"EMP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDHUNXPZ0','10','D','15','2',NULL,'Control Number',NULL,NULL,'"53027"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDHUNXPZ0','32','D','15','3',NULL,'Associate Identifier',NULL,NULL,'"drvEmpAssociateId"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDHUNXPZ0','32','D','15','4',NULL,'Employee Identifier',NULL,NULL,'"drvEmpIdentifier"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDHUNXPZ0','8','D','15','5',NULL,'Hire Date',NULL,NULL,'"drvDateOfOriginalHire"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDHUNXPZ0','8','D','15','6',NULL,'Rehire Date',NULL,NULL,'"drvDateofLastHire"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDHUNXPZ0','8','D','15','7',NULL,'Retirement Date',NULL,NULL,'"drvDateOfRetirement"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDHUNXPZ0','8','D','15','8',NULL,'Employment Termination Date',NULL,NULL,'"drvDateOfTermination"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDHUNXPZ0','25','D','15','9',NULL,'Employment Termination Reason Code',NULL,NULL,'"drvTerminationReasonCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDHUNXPZ0','8','D','15','10',NULL,'Adjusted Service Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDHUNXPZ0','30','D','15','11',NULL,'Employment Status Code',NULL,NULL,'"drvEmpStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDHUNXPZ0','8','D','15','13',NULL,'Employment Status Effective Date',NULL,NULL,'"drvEmpStatusEffectiveDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDHUNXPZ0','30','D','15','14',NULL,'Employment Status Reason Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDHUNXPZ0','30','D','15','15',NULL,'Job Title Text',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDHUNXPZ0','30','D','15','16',NULL,'Occupation Text',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDHUNXPZ0','30','D','15','16',NULL,'OSHA Job Classification Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRUDHUNXPZ0','25','D','15','18',NULL,'Occupation Class Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRUDHUNXPZ0','25','D','15','19',NULL,'Work Status Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRUDHUNXPZ0','5','D','15','20',NULL,'Weekly Scheduled Hours Number',NULL,NULL,'"drvWeeklySchedHours"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRUDHUNXPZ0','5','D','15','20',NULL,'Daily Hours Worked',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRUDHUNXPZ0','25','D','15','22',NULL,'Hourly Salary Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRUDHUNXPZ0','30','D','15','23',NULL,'Earnings Type  Code 1',NULL,NULL,'"drvEarningTypeCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRUDHUNXPZ0','8','D','15','24',NULL,'Earnings Effective  Date 1',NULL,NULL,'"drvEarningEffectiveDate1"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRUDHUNXPZ0','17','D','15','25',NULL,'Earnings  Amount 1',NULL,NULL,'"drvEarningAmount1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRUDHUNXPZ0','30','D','15','26',NULL,'Earnings Frequency Code 1',NULL,NULL,'"drvEarningFrequencyCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRUDHUNXPZ0','30','D','15','27',NULL,'Earnings Type Code 2',NULL,NULL,'"drvEarningTypeCode2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRUDHUNXPZ0','8','D','15','28',NULL,'Earnings Effective Date 2',NULL,NULL,'"drvEarningEffectiveDate2"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRUDHUNXPZ0','17','D','15','29',NULL,'Earnings Amount 2',NULL,NULL,'"drvEarningAmount2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRUDHUNXPZ0','30','D','15','30',NULL,'Earnings Frequency  Code 2',NULL,NULL,'"drvEarningFrequencyCode2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRUDHUNXPZ0','30','D','15','27',NULL,'Earnings Type Code 3',NULL,NULL,'"drvEarningTypeCode3"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRUDHUNXPZ0','8','D','15','28',NULL,'Earnings Effective Date 3',NULL,NULL,'"drvEarningEffectiveDate3"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRUDHUNXPZ0','17','D','15','29',NULL,'Earnings Amount 3',NULL,NULL,'"drvEarningAmount3"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRUDHUNXPZ0','30','D','15','30',NULL,'Earnings Frequency  Code 3',NULL,NULL,'"drvEarningFrequencyCode3"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRUDHUNXPZ0','30','D','15','30',NULL,'W4 Filing Status Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRUDHUNXPZ0','30','D','15','30',NULL,'W4 Exemptions Number Earnings',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRUDHUNXPZ0','30','D','15','30',NULL,'W4 Additional Withholding Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRUDHUNXPZ0','30','D','15','30',NULL,'W4 Withholding State Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRUDHUNXPZ0','30','D','15','30',NULL,'W4 Withholding State Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRUDHUNXPZ0','30','D','15','30',NULL,'W4 Withholding State Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRUDHUNXPZ0','30','D','15','30',NULL,'W4 Work Location Postal Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRUDHUNXPZ0','1','D','15','37',NULL,'Union Indicator',NULL,NULL,'"drvUnionIndicator"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRUDHUNXPZ0','25','D','15','38',NULL,'Local Bargaining Unit Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRUDHUNXPZ0','25','D','15','39',NULL,'Member Group Code',NULL,NULL,'"drvMemberGroupCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRUDHUNXPZ0','25','D','15','40',NULL,'Bill Group Code',NULL,NULL,'"drvBillGroupCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRUDHUNXPZ0','30','D','15','41',NULL,'Payroll Frequency Code',NULL,NULL,'"drvPayrollFreqCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPRUDHUNXPZ0','25','D','15','42',NULL,'District Location Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPRUDHUNXPZ0','30','D','15','43',NULL,'Employment Location',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPRUDHUNXPZ0','10','D','15','44',NULL,'Regional Unit',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPRUDHUNXPZ0','20','D','15','45',NULL,'Employer Information',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPRUDHUNXPZ0','80','D','15','46',NULL,'Group',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPRUDHUNXPZ0','80','D','15','46',NULL,'Work Location State Code',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPRUDHUNXPZ0','80','D','15','46',NULL,'Comments',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPRUDHUNXPZ0','80','D','15','46',NULL,'Year to Date Earnings',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPRUDHUNXPZ0','80','D','15','46',NULL,'Earnings As of Date',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDHUNXPZ0','3','D','25','1',NULL,'Record Type',NULL,NULL,'"COV"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDHUNXPZ0','10','D','25','2',NULL,'Control Number',NULL,NULL,'"53027"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDHUNXPZ0','32','D','25','3',NULL,'Associate Identifier',NULL,NULL,'"drvCovEmpNo"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDHUNXPZ0','25','D','25','4',NULL,'Product Code',NULL,NULL,'"drvCovProductCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDHUNXPZ0','25','D','25','5',NULL,'Coverage Tier Code',NULL,NULL,'"drvCovProductTier"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDHUNXPZ0','25','D','25','6',NULL,'Product Plan Code',NULL,NULL,'"drvCovProdPlanCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDHUNXPZ0','25','D','25','6',NULL,'Coverage Buy Up Indicator',NULL,NULL,'"False"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDHUNXPZ0','17','D','25','8',NULL,'Coverage Amount',NULL,NULL,'"drvCovProdCovAmt"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDHUNXPZ0','8','D','25','9',NULL,'Coverage  Effective Date',NULL,NULL,'"drvCovEffectiveDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDHUNXPZ0','8','D','25','10',NULL,'Coverage  End Date',NULL,NULL,'"drvCovEndDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDHUNXPZ0','25','D','25','11',NULL,'Coverage Status Code',NULL,NULL,'"drvCovStatusCode"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDHUNXPZ0','8','D','25','12',NULL,'Coverage Status Effective Date',NULL,NULL,'"drvCovStatusEffectiveDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDHUNXPZ0','25','D','25','13',NULL,'Coverage Status Reason Code',NULL,NULL,'"drvCovStatusReasonCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDHUNXPZ0','30','D','25','14',NULL,'Coverage Termination Reduction Type Code',NULL,NULL,'"drvCobRedTypeCode"','(''Ua''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDHUNXPZ0','17','D','25','15',NULL,'Coverage Termination Reduction Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDHUNXPZ0','17','D','25','15',NULL,'Flat Benefit Indicator',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDHUNXPZ0','17','D','25','15',NULL,'Claim Branch Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRUDHUNXPZ0','17','D','25','15',NULL,'EOB Correspondence Type Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRUDHUNXPZ0','10','D','25','19',NULL,'Assignment Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRUDHUNXPZ0','1','D','25','19',NULL,'Original LTD Coverage Effective Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRUDHUNXPZ0','1','D','25','19',NULL,'Partner Product Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRUDHUNXPZ0','1','D','25','19',NULL,'Partner Short Benefit Description',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRUDHUNXPZ0','1','D','25','19',NULL,'Client Coverage Effective Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRUDHUNXPZ0','1','D','25','19',NULL,'Benefit Option Identifier',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRUDHUNXPZ0','1','D','25','19',NULL,'Coverage Increase Within 2 years Indicator',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRUDHUNXPZ0','3','D','25','26',NULL,'Issuance Age',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRUDHUNXPZ0','25','D','25','27',NULL,'Voluntary Basis',NULL,NULL,'"drvVoluntaryBasis"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRUDHUNXPZ0','25','D','25','27',NULL,'Applicant Eligibility Date',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRUDHUNXPZ0','25','D','25','27',NULL,'Applicant Inforce Benefit Amount',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRUDHUNXPZ0','25','D','25','27',NULL,'Applicant Additional Benefit Amount',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRUDHUNXPZ0','25','D','25','27',NULL,'Applicant Relationship Type Code',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRUDHUNXPZ0','25','D','25','27',NULL,'Applicant EOI Branch Code',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRUDHUNXPZ0','25','D','25','27',NULL,'Deduction Type  Code',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRUDHUNXPZ0','25','D','25','27',NULL,'Deduction Amount',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRUDHUNXPZ0','25','D','25','27',NULL,'Deduction Frequency Type Code',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRUDHUNXPZ0','25','D','25','27',NULL,'Deduction Withholding State',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRUDHUNXPZ0','25','D','25','27',NULL,'Payroll Deduction Frequency Type Code',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRUDHUNXPZ0','25','D','25','27',NULL,'Payroll Deduction Amount',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRUDHUNXPZ0','25','D','25','27',NULL,'Coverage Event ID',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRUDHUNXPZ0','25','D','25','27',NULL,'Coverage Event Type Code',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRUDHUNXPZ0','25','D','25','27',NULL,'Coverage Event Date',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRUDHUNXPZ0','25','D','25','27',NULL,'Coverage Marriage Date',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRUDHUNXPZ0','25','D','25','27',NULL,'Coverage Divorce Date',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDHUNXPZ0','3','T','90','1',NULL,'Record Type',NULL,NULL,'"TRL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDHUNXPZ0','8','T','90','2',NULL,'File Creation Date',NULL,NULL,'"drvFileCreationDateTrailer"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDHUNXPZ0','9','T','90','4',NULL,'Absence Related Employment Information Record',NULL,NULL,'"0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDHUNXPZ0','9','T','90','5',NULL,'Associate Record Count',NULL,NULL,'"drvASTCount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDHUNXPZ0','9','T','90','17',NULL,'Beneficiary Record Count',NULL,NULL,'"0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDHUNXPZ0','9','T','90','13',NULL,'Coverage Record Count',NULL,NULL,'"drvCOVCount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDHUNXPZ0','9','T','90','16',NULL,'Dependent Record Count',NULL,NULL,'"drvDEPCount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDHUNXPZ0','10','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL,'"0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDHUNXPZ0','9','T','90','6',NULL,'Employment Record Count',NULL,NULL,'"drvEMPRecordCount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDHUNXPZ0','9','T','90','6',NULL,'Event Record Quantity',NULL,NULL,'"0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDHUNXPZ0','9','T','90','6',NULL,'Preference Record Quantity',NULL,NULL,'"0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDHUNXPZ0','9','T','90','6',NULL,'Custom Characteristics Record Quantity',NULL,NULL,'"0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDHUNXPZ0','9','T','90','6',NULL,'Total Coverage Amount',NULL,NULL,'"drvCoverageAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDHUNXPZ0','9','T','90','6',NULL,' Total Record Quantity',NULL,NULL,'"drvRecordCount"','(''UA''=''T~'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPRUDHUNXP_20211212.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202001319','EMPEXPORT','OEACTIVE','Dec 19 2019  9:02AM','EPRUDHUNXP',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','2968','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202001319','EMPEXPORT','OEPASSIVE','Dec 27 2019  5:03PM','EPRUDHUNXP',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','3827','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Vol Acc ONDEMAND','201910239','EMPEXPORT','ONDEMAND','Feb 20 2021 12:00AM','EPRUDHUNXP',NULL,NULL,NULL,'201910239','Oct 23 2019 12:00AM','Dec 30 1899 12:00AM','201910231',NULL,'','','201910231',dbo.fn_GetTimedKey(),NULL,'us3lKiSTO1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',0FSQ5',NULL,NULL,NULL,'Prudential Vol Accident','202002059','EMPEXPORT','SCH_PRUDX','Feb 20 2021 12:00AM','EPRUDHUNXP',NULL,NULL,NULL,'202002059','Feb  5 2020 12:00AM','Dec 30 1899 12:00AM','202001291',NULL,'','','202001291',dbo.fn_GetTimedKey(),NULL,'us3lKiSTO1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','ABDEC,5QSEN,X3SM9,NDVDM,AO0II,4KEYF,VM47V,VM3YR,A9DHZ,Z768Q',NULL,NULL,NULL,'Prudential Vol Acc-Test','202111291','EMPEXPORT','TEST','Nov 29 2021  3:18PM','EPRUDHUNXP',NULL,NULL,NULL,'202111291','Nov 29 2021 12:00AM','Dec 30 1899 12:00AM','202111011','6658','','','202111011',dbo.fn_GetTimedKey(),NULL,'us3jReHUN1010',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDHUNXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDHUNXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDHUNXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDHUNXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDHUNXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDHUNXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDHUNXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDHUNXP','H01','dbo.U_EPRUDHUNXP_Headerl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDHUNXP','D10','dbo.U_EPRUDHUNXP_drvAstTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDHUNXP','D15','dbo.U_EPRUDHUNXP_drvEmpTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDHUNXP','D25','dbo.U_EPRUDHUNXP_drvCovTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDHUNXP','T90','dbo.U_EPRUDHUNXP_drvTrailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EPRUDHUNXP
-----------

IF OBJECT_ID('U_dsi_BDM_EPRUDHUNXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPRUDHUNXP] (
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
-- Create table U_EPRUDHUNXP_Audit
-----------

IF OBJECT_ID('U_EPRUDHUNXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EPRUDHUNXP_AuditFields
-----------

IF OBJECT_ID('U_EPRUDHUNXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EPRUDHUNXP_DedList
-----------

IF OBJECT_ID('U_EPRUDHUNXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPRUDHUNXP_drvAbsTbl
-----------

IF OBJECT_ID('U_EPRUDHUNXP_drvAbsTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_drvAbsTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvAbsEmpNo] char(9) NULL,
    [drvReportingCode1] char(6) NULL,
    [drvHRRepNameLast] varchar(6) NOT NULL,
    [drvContactEmail] varchar(31) NOT NULL,
    [drvEmploymentType] varchar(5) NOT NULL,
    [drvEmploymentSector] varchar(5) NOT NULL,
    [drvFMLABranchCode] varchar(5) NOT NULL,
    [drvFMLAWorkLocationCode] varchar(10) NOT NULL,
    [drvEEIndicator] varchar(1) NOT NULL,
    [drvStandardWorkSchedule] varchar(1) NOT NULL,
    [drvHoursWorkLast12Months] varchar(4) NOT NULL,
    [drvAsOfDateHoursLast12Months] datetime NOT NULL
);

-----------
-- Create table U_EPRUDHUNXP_drvAstTbl
-----------

IF OBJECT_ID('U_EPRUDHUNXP_drvAstTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_drvAstTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(14) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvASTAssociateId] char(9) NULL,
    [drvASTSSNumber] char(11) NULL,
    [drvASTGendeCode] varchar(7) NOT NULL,
    [drvASTDateOfBirth] datetime NULL,
    [drvASTDateofDeath] datetime NULL,
    [drvASTSmokerStatus] varchar(10) NOT NULL,
    [drvASTMaritalStatus] varchar(8) NOT NULL,
    [drvASTPrefix] varchar(30) NULL,
    [drvASTSuffix] varchar(30) NULL,
    [drvASTLastName] varchar(100) NULL,
    [drvASTFirstName] varchar(100) NULL,
    [drvASTMiddleName] varchar(50) NULL,
    [drvAddressTypeCode] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateProvinceCode] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountryCode] varchar(3) NOT NULL,
    [drvPhoneTypeCode1] varchar(6) NOT NULL,
    [drvPhoneNumber1] varchar(50) NULL,
    [drvPhoneTypeCode2] varchar(4) NOT NULL,
    [drvPhoneNumber2] varchar(50) NULL,
    [drvPhoneTypeCode3] varchar(1) NOT NULL,
    [drvPhoneNumber3] varchar(1) NOT NULL,
    [drvEmailTypeCode1] varchar(8) NOT NULL,
    [drvEmail1] varchar(50) NULL,
    [drvEmailTypeCode2] varchar(1) NOT NULL,
    [drvEmail2] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRUDHUNXP_drvCovTbl
-----------

IF OBJECT_ID('U_EPRUDHUNXP_drvCovTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_drvCovTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(14) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCovEmpNo] char(9) NULL,
    [drvCovProductCode] varchar(4) NULL,
    [drvCovProductTier] varchar(2) NULL,
    [drvCovProdPlanCode] varchar(1) NOT NULL,
    [drvCovBuyUpIndc] varchar(1) NOT NULL,
    [drvCovProdCovAmt] varchar(12) NULL,
    [drvCovProdCovAmtRaw] money NULL,
    [drvCovEffectiveDate] datetime NULL,
    [drvCovEndDate] datetime NULL,
    [drvCovStatusCode] varchar(11) NULL,
    [drvCovStatusEffectiveDate] varchar(1) NOT NULL,
    [drvCovStatusReasonCode] varchar(1) NOT NULL,
    [drvVoluntaryBasis] varchar(1) NOT NULL,
    [drvCobRedTypeCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRUDHUNXP_drvDepTbl
-----------

IF OBJECT_ID('U_EPRUDHUNXP_drvDepTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_drvDepTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(14) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepEmpNo] char(9) NULL,
    [drvDepIdentifier] varchar(24) NULL,
    [drvConSSN] char(11) NULL,
    [drvDepRelationshipTypeCode] varchar(16) NULL,
    [drvDEPSSN] char(11) NULL,
    [drvConGender] varchar(7) NOT NULL,
    [drvDateConBirthDate] datetime NULL,
    [drvDepEffDate] datetime NULL,
    [drvDateConDeathDate] varchar(1) NOT NULL,
    [drvConDrvStatusCode] varchar(7) NOT NULL,
    [drvConMaritalStatusCode] varchar(7) NOT NULL,
    [drvDepPrefix] varchar(1) NOT NULL,
    [drvDepSuffixName] varchar(1) NOT NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepMiddleName] varchar(50) NULL,
    [drvDepAddressTypeCode] varchar(4) NOT NULL,
    [drvDepAddressLine1] varchar(1) NOT NULL,
    [drvDepAddressLine2] varchar(1) NOT NULL,
    [drvDepCity] varchar(1) NOT NULL,
    [drvDepState] varchar(1) NOT NULL,
    [drvDepZipCode] varchar(1) NOT NULL,
    [drvDepTelephoneType1] varchar(1) NOT NULL,
    [drvDepTelephoneNumber1] varchar(1) NOT NULL,
    [drvDepEmailAddressType1] varchar(1) NOT NULL,
    [drvDepEmailAddress1] varchar(1) NOT NULL,
    [drvDisabledDep] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRUDHUNXP_drvEmpTbl
-----------

IF OBJECT_ID('U_EPRUDHUNXP_drvEmpTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_drvEmpTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(14) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpAssociateId] char(9) NULL,
    [drvEmpIdentifier] char(9) NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateofLastHire] datetime NULL,
    [drvDateOfRetirement] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvTerminationReasonCode] varchar(16) NULL,
    [drvEmpStatusCode] varchar(1) NOT NULL,
    [drvEmpStatusEffectiveDate] varchar(1) NOT NULL,
    [drvWeeklySchedHours] varchar(1) NOT NULL,
    [drvDailyHoursWorked] varchar(1) NOT NULL,
    [drvEarningTypeCode1] varchar(8) NOT NULL,
    [drvEarningEffectiveDate1] datetime NULL,
    [drvEarningAmount1] varchar(30) NULL,
    [drvEarningFrequencyCode1] varchar(6) NOT NULL,
    [drvEarningTypeCode2] varchar(1) NOT NULL,
    [drvEarningEffectiveDate2] varchar(1) NOT NULL,
    [drvEarningAmount2] varchar(1) NOT NULL,
    [drvEarningFrequencyCode2] varchar(1) NOT NULL,
    [drvEarningTypeCode3] varchar(1) NOT NULL,
    [drvEarningEffectiveDate3] varchar(1) NOT NULL,
    [drvEarningAmount3] varchar(1) NOT NULL,
    [drvEarningFrequencyCode3] varchar(1) NOT NULL,
    [drvWorkState] varchar(1) NOT NULL,
    [drvUnionIndicator] varchar(1) NOT NULL,
    [drvMemberGroupCode] varchar(1) NOT NULL,
    [drvBillGroupCode] varchar(1) NOT NULL,
    [drvPayrollFreqCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EPRUDHUNXP_drvTrailer
-----------

IF OBJECT_ID('U_EPRUDHUNXP_drvTrailer') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_drvTrailer] (
    [drvFileCreationDateTrailer] nvarchar(30) NULL,
    [drvRecordCount] varchar(12) NULL,
    [drvASTCount] varchar(12) NULL,
    [drvEMPRecordCount] varchar(12) NULL,
    [drvCOVCount] varchar(12) NULL,
    [drvDEPCount] varchar(1) NOT NULL,
    [drvCoverageAmount] varchar(12) NULL
);

-----------
-- Create table U_EPRUDHUNXP_EEList
-----------

IF OBJECT_ID('U_EPRUDHUNXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPRUDHUNXP_File
-----------

IF OBJECT_ID('U_EPRUDHUNXP_File') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EPRUDHUNXP_Headerl
-----------

IF OBJECT_ID('U_EPRUDHUNXP_Headerl') IS NULL
CREATE TABLE [dbo].[U_EPRUDHUNXP_Headerl] (
    [drvRecordType] varchar(3) NOT NULL,
    [drvFileType] varchar(8) NOT NULL,
    [drvFileTypeVersion] varchar(3) NOT NULL,
    [drvControlNumber] varchar(5) NOT NULL,
    [drvClientName] varchar(23) NOT NULL,
    [drvSenderName] varchar(23) NOT NULL,
    [drvSenderPlatformName] varchar(3) NOT NULL,
    [drvTestProdCode] varchar(10) NOT NULL,
    [drvFileCreationDateTime] nvarchar(4000) NULL,
    [drvActivityDateTime] nvarchar(4000) NULL,
    [drvActivityEndDateTime] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDHUNXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Synovos, Inc

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/06/2020
Service Request Number: SR-2020-00298075

Purpose: Prudential Vol Accident

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRUDHUNXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRUDHUNXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRUDHUNXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRUDHUNXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRUDHUNXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDHUNXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDHUNXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDHUNXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDHUNXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRUDHUNXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPRUDHUNXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@FileMinCovDate    DATETIME
            ,@FileDateStart as VARCHAR(14)
            ,@FileDateStartSevenDays as VARCHAR(14);

 
    -- Set FormatCode
    SELECT @FormatCode = 'EPRUDHUNXP';
    Select @FileDateStartSevenDays = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar, DATEADD(DAY,-6,GETDATE()), 120),'-',''),':',''),' ','');
    Select @FileDateStart = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar, GETDATE(), 120),'-',''),':',''),' ','');

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('1/1/2021' as DateTime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List
   -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EPRUDHUNXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRUDHUNXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

     DELETE FROM dbo.U_EPRUDHUNXP_EEList
    WHERE  xEEID IN (SELECT eepeeid FROM dbo.EmpPers where eepssn = '123455679');


    DELETE FROM dbo.U_EPRUDHUNXP_EEList WHERE xEEID IN ( -- ABC
        SELECT DISTINCT eecEEID from EmpComp WHERE EecEEType IN ('TES', 'CON', 'INT')
    )

/*
    DELETE FROM dbo.U_EPRUDHUNXP_EEList WHERE xEEID IN ( -- ABC
        SELECT DISTINCT eecEEID from EmpComp WHERE EecEmplStatus IN ('T')
    )
*/
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ADD,GLIFE,LIFEE,LIFEG,LIFES,LIFSG,LIFEC';

    IF OBJECT_ID('U_EPRUDHUNXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDHUNXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPRUDHUNXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

 
    --==========================================
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_EPRUDHUNXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDHUNXP_AuditFields;
    CREATE TABLE dbo.U_EPRUDHUNXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EPRUDHUNXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    -- Create audit table
    IF OBJECT_ID('U_EPRUDHUNXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDHUNXP_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EPRUDHUNXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EPRUDHUNXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EPRUDHUNXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EPRUDHUNXP_Audit ON dbo.U_EPRUDHUNXP_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');

    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse', 'SPS')
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild', 'DIS,STC,CHL')
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDomPartner', 'DP')
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDPChild', 'DPC')

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

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

 
 
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDHUNXP_drvAstTbl

    IF OBJECT_ID('U_EPRUDHUNXP_drvAstTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDHUNXP_drvAstTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2-' + xeeid
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvASTAssociateId = EecEmpNo
        ,drvASTSSNumber = eepSSN
        ,drvASTGendeCode = CASE WHEN EepGender = 'F' then 'FEMALE'
                                WHEN EepGender = 'M' then 'MALE'
                                ELSE 'UNKNOWN'
                            END
        ,drvASTDateOfBirth = EepDateOfBirth
        ,drvASTDateofDeath = CASE WHEN eecemplstatus = 'T' and eecTermReason in ('203','DECEAS') THEN eecdateoftermination END
        ,drvASTSmokerStatus = CASE WHEN eepIsSmoker = 'Y' THEN 'SMOKER'
                                   WHEN eepIsSmoker = 'N' THEN 'NON SMOKER'
                                   ELSE 'UNKNOWN'
                               END
        ,drvASTMaritalStatus = CASE WHEN eepMaritalStatus = 'S' THEN 'SINGLE'
                                    WHEN eepMaritalStatus = 'M' THEN 'MARRIED'
                                    WHEN eepMaritalStatus = 'D' THEN 'DIVORCED'
                                    WHEN eepMaritalStatus = 'W' THEN 'WIDOWED'
                                    ELSE 'UNKNOWN'
                             END
        ,drvASTPrefix = eepNamePrefix
        ,drvASTSuffix = eepNameSuffix
        ,drvASTLastName = EepNameLast
        ,drvASTFirstName = EepNameFirst
        ,drvASTMiddleName = LTRIM(RTRIM(EepNameMiddle))
        ,drvAddressTypeCode = 'HOME'
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = EepAddressLine3
        ,drvCity = EepAddressCity
        ,drvStateProvinceCode = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountryCode = 'USA'
        ,drvPhoneTypeCode1 = 'MOBILE'  
        ,drvPhoneNumber1 = (select top 1 efoPhoneNumber from EmpMPhon (NOLOCK) where efoPhoneType = 'CEL' and efoEEID in (xEEID) )
        ,drvPhoneTypeCode2 = 'HOME'
        ,drvPhoneNumber2 = EepPhoneHomeNumber
             ,drvPhoneTypeCode3 = ''
        ,drvPhoneNumber3 = ''
        ,drvEmailTypeCode1 = 'PERSONAL'
        ,drvEmail1 = CASE WHEN eepAddressEmail not like '%@hunting%' THEN eepAddressEmail ELSE EepAddressEMailAlternate END
        ,drvEmailTypeCode2 = ''
        ,drvEmail2 = ''
    INTO dbo.U_EPRUDHUNXP_drvAstTbl
    FROM dbo.U_EPRUDHUNXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EPRUDHUNXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDHUNXP_drvEmpTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUDHUNXP_drvEmpTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDHUNXP_drvEmpTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2-' + xeeid
        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvEmpAssociateId = EecEmpNo
        ,drvEmpIdentifier = EecEmpNo
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateofLastHire = EecDateOfLastHire--CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire and EecDateOfLastHire >= CAST('01/01/2021' as datetime) THEN EecDateOfLastHire END
        ,drvDateOfRetirement = CASE WHEN  EecEmplStatus = 'T' and  EecTermReason = '202' THEN EecDateOfTermination END
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationReasonCode = CASE WHEN EecEmplStatus = 'T' THEN     
                                        CASE WHEN eecTermReason = '202' then 'RETIRED'
                                             WHEN eecTermReason  in ('203') THEN 'DECEASED'
                                             WHEN eecTermReason  in ('107') THEN 'DISABILITY'
                                             WHEN eecTermReason  in ('108') THEN 'LEAVE OF ABSENCE'
                                             ELSE 'TERMINATED'
                                        END
                                    END
        ,drvEmpStatusCode = ''/*(CASE WHEN EecEmplStatus = 'T' THEN     
                                        CASE WHEN eecTermReason = '202' then 'RETIRED'
                                             WHEN eecTermReason In ('203','DECEAS') THEN 'DECEASED'
                                             WHEN eecTermReason NOT IN  ('202','203') THEN 'TERMINATED'
                                        END
                                 WHEN EecEmplStatus = 'L' THEN 'LEAVE OF ABSENCE'
                                 ELSE 'ACTIVE'
                            END*/
        ,drvEmpStatusEffectiveDate =  ''/*CASE WHEN eecemplstatus = 'T' THEN eecdateoftermination
                                           WHEN eecemplstatus = 'L' THEN EecEmplStatusStartDate
                                           ELSE eecdateoflasthire
                                      END*/

        ,drvWeeklySchedHours = ''
        ,drvDailyHoursWorked =  ''
        ,drvEarningTypeCode1 = 'BASE PAY'
        ,drvEarningEffectiveDate1 = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETDATE(),EecDateOfLastHire)
        ,drvEarningAmount1 = CAST( EecAnnSalary + ISNULL(EepUDField03,0) as varchar)
        ,drvEarningFrequencyCode1 = 'ANNUAL'
        ,drvEarningTypeCode2 = ''
        ,drvEarningEffectiveDate2 = ''
        ,drvEarningAmount2 = ''
        ,drvEarningFrequencyCode2 = ''
        ,drvEarningTypeCode3 = ''
        ,drvEarningEffectiveDate3 = ''
        ,drvEarningAmount3 = ''
        ,drvEarningFrequencyCode3 = ''
        ,drvWorkState = ''--(Select Top 1 LocAddressState from Location where LocCode in (EEcLocation))
        ,drvUnionIndicator = ''--CASE WHEN EecUnionLocal is not null then 'Y' ELSE 'N' END
        ,drvMemberGroupCode = ''--CASE WHEN EepAddressState  = 'WA' THEN '001' ELSE '002' END
        ,drvBillGroupCode = ''
        ,drvPayrollFreqCode = ''
    INTO dbo.U_EPRUDHUNXP_drvEmpTbl
    FROM dbo.U_EPRUDHUNXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EPRUDHUNXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate))
    ;
    
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDHUNXP_drvCovTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUDHUNXP_drvCovTbl','U') IS NOT NULL -- ABC drvCovProdCovAmtRaw
        DROP TABLE dbo.U_EPRUDHUNXP_drvCovTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2-' + xeeid
        ,drvSubSort = '5'
        -- standard fields above and additional driver fields below
        ,drvCovEmpNo = EecEmpNo
        ,drvCovProductCode = CASE WHEN eedDedCode = 'GLIFE' THEN 'BGL'
                                  WHEN eedDedCode = 'ADD' THEN 'BADD'
                                  WHEN eedDedCode in ('LIFEE','LIFEG') THEN 'BADD'
                                  WHEN eedDedCode in ('LIFES','LIFSG','LIFEC') THEN 'ODGL'
                            END
     
        ,drvCovProductTier = CASE WHEN eedDedCode IN ('GLIFE','ADD','LIFEE','LIFEG') THEN 'EE'
                                  WHEN eedDedCode IN ('LIFES','LIFSG') THEN 'SP'
                                  WHEN eedDedCode in ('LIFEC') THEN 'CH'
                                  
                                  WHEN ExISTS (Select * from U_dsi_BDM_EmpDeductions A where A.eedeeid = eedeeid and A.eedFormatCode   = 'EPRUDHUNXP') THEN 'SP'
                             END
        ,drvCovProdPlanCode = ''
        ,drvCovBuyUpIndc = 'N'
        ,drvCovProdCovAmt = CAST(EedBenAmt as VARCHAR(12))
        ,drvCovProdCovAmtRaw = EedBenAmt
        ,drvCovEffectiveDate = eedBenStartDate --CASE WHEN eedDedCode in ('GRPA1','GRPA2') THEN dbo.dsi_fnGetMinMaxDates('MAX',eedBenStartDate, @FileMinCovDate) END 
        ,drvCovEndDate = eedBenStopDate
        ,drvCovStatusCode = CASE WHEN eedchangereason  in ('LEVNT4','204') then 'DIVORCE' 
                                 WHEN eedchangereason in ('202','203','206','210','211','300') then 'INVOLUNTARY'
                                 WHEN eedchangereason = '201' then 'AGE'
                                 WHEN eedchangereason in ('200','208','209','301','302,','303','304','401','LEVNT3','LEVNT5','OE') then 'CANCELLED'
                                END
        ,drvCovStatusEffectiveDate = ''
        ,drvCovStatusReasonCode = ''
        ,drvVoluntaryBasis = ''
        /*
        'If EdhChangeReason in ('LEVNT4','204') then 'DIVORCE'

Else if EdhChangeReason in ('202','203','206','210','211','300') then 'INVOLUNTARY'

Else if EdhChangeReason='201' then 'AGE'

Else if EdhChangeReason in ('200','208','209','301','302,',303','304','401','LEVNT3,',LEVNT5,'OE') then 'CANCELLED'
        */
        ,drvCobRedTypeCode = ''
    INTO dbo.U_EPRUDHUNXP_drvCovTbl
    FROM dbo.U_EPRUDHUNXP_EEList WITH (NOLOCK)
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'  
    WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EPRUDHUNXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate))  
 
            --Include employee U_EPRUDHUNXP_drvCovTbl only have YTD earnings
    /*DELETE FROM dbo.U_EPRUDHUNXP_drvCovTbl WHERE drvEEID NOT IN (
            SELECT DISTINCT
                 PehEEID
            FROM dbo.PayReg WITH (NOLOCK)
            JOIN dbo.PEarHist WITH (NOLOCK)
                ON PehGenNumber = PrgGenNumber
            WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
            AND PehPerControl <= @EndPerControl
            GROUP BY PehEEID
            HAVING SUM(PehCurAmt) <> 0.00
    );*/

    Delete from U_EPRUDHUNXP_drvCovTbl where drvCovProductCode = 'BADD' and drvCovProdCovAmt = '0.00'
 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDHUNXP_drvDepTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUDHUNXP_drvDepTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDHUNXP_drvDepTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =  '2-' + xeeid
        ,drvSubSort = '6'
        -- standard fields above and additional driver fields below
        ,drvDepEmpNo = EecEmpNo
        ,drvDepIdentifier = dbo.dsi_fnPadZero(Dep_Number + 1,2,0)
        ,drvConSSN = ConSSN

        ,drvDepRelationshipTypeCode = CASE WHEN ConRelationship = 'DP' THEN 'DOMESTIC PARTNER'
                                           WHEN ConRelationship IN ('SPS','HUS','WIF') THEN 'SPOUSE'    
                                           WHEN ConRelationship In ('DIS', 'STC', 'SON','DAU','LDP','CHL') THEN 'CHILD'
                                      END
        ,drvDEPSSN = ConSSN -- eepSSN
        ,drvConGender = CASE WHEN ConGender = 'F' THEN 'FEMALE'
                             WHEN ConGender = 'M' THEN 'MALE'
                             ELSE 'UNKNOWN'
                        END
        ,drvDateConBirthDate = ConDateOfBirth
        ,drvDepEffDate  = CASE WHEN dbnDedCode in ('GRPA1','GRPA2') THEN dbo.dsi_fnGetMinMaxDates('MAX',DbnBenStartDate, @FileMinCovDate) END --DbnBenStartDate
        ,drvDateConDeathDate = ''
        ,drvConDrvStatusCode = 'UNKNOWN'
        ,drvConMaritalStatusCode = CASE WHEN eepMaritalStatus = 'M' AND ConRelationship IN ('SPS','HUS','WIF') THEN 'MARRIED'
                                    ELSE 'UNKNOWN'
                             END
        ,drvDepPrefix = ''
        ,drvDepSuffixName = ''
        ,drvDepLastName = ConNameLast
        ,drvDepFirstName = ConNameFirst
        ,drvDepMiddleName = ConNameMiddle
        ,drvDepAddressTypeCode = 'HOME'
        ,drvDepAddressLine1 = ''
        ,drvDepAddressLine2 = ''
        ,drvDepCity = ''
        ,drvDepState = ''
        ,drvDepZipCode = ''
        ,drvDepTelephoneType1 = ''
        ,drvDepTelephoneNumber1 = ''
        ,drvDepEmailAddressType1 = ''
        ,drvDepEmailAddress1 = ''
        ,drvDisabledDep = CASE WHEN ConIsDisabled = 'Y' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EPRUDHUNXP_drvDepTbl
    FROM dbo.U_EPRUDHUNXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnCoID = xCoID
        AND DbnFormatCode = @FormatCode
        AND DbnValidForExport = 'Y'
        AND DbnDedCode in ('GRPA1', 'GRPA2')
    LEFT JOIN (
                select ConEEID, 
                       ConNameLast, 
                       ConNameFirst, 
                       ConSSN, 
                       ConDateOfBirth, 
                       ConRelationship,
                       ConSystemID,
                       ConGender,
                       ConIsSmoker,
                       ConNameMiddle,
                       ConNameSuffix,
                       ConIsDisabled,
                       ROW_NUMBER()  OVER
                        (PARTITION BY ConEEID ORDER BY ConImportID,ConDateOfBirth, 
                            CASE WHEN ConRelationship in ('SPS','DP') THEN 1 ELSE 2 END ) AS 'Dep_Number'
                from dbo.Contacts Where ConIsDependent = 'Y' ) as Contacts
        ON ConEEID = xEEID
        AND ConSystemID = DbnDepRecID
    WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EPRUDHUNXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate))
   
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPRUDHUNXP_Headerl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDHUNXP_Headerl;
    SELECT DISTINCT

         drvRecordType = 'HDR'
        ,drvFileType = 'FULLFILE'
        ,drvFileTypeVersion = '1.0'
        ,drvControlNumber = '53027'
        ,drvClientName = 'Hunting Energy Services'
        ,drvSenderName = 'Hunting Energy Services'
        ,drvSenderPlatformName = 'UKG'
        ,drvTestProdCode = CASE WHEN @ExportCode LIKE '%TEST' THEN 'TEST' ELSE 'PRODUCTION' END
        ,drvFileCreationDateTime = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar,GETDATE(), 120),'-',''),':',''),' ','')
        ,drvActivityDateTime = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar,GETDATE() + 1, 120),'-',''),':',''),' ','')
        ,drvActivityEndDateTime = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar,GETDATE(), 120),'-',''),':',''),' ','')
    INTO dbo.U_EPRUDHUNXP_Headerl
    ;

 
    --Remove ABS coverage without AST EMP or ABS Line
    Delete from U_EPRUDHUNXP_drvCovTbl where  drvCovProductCode = 'ABS' and  drveeid  not in (select drveeid from U_EPRUDHUNXP_drvAstTbl)

    --Update Suffix to '' for 'Z'
    Update U_EPRUDHUNXP_drvDepTbl set drvDepSuffixName = '' where drvDepSuffixName = 'Z'
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPRUDHUNXP_drvTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDHUNXP_drvTrailer;
    SELECT DISTINCT
         drvFileCreationDateTrailer =  CONVERT(nvarchar, GETDATE(), 112)
        ,drvRecordCount = CAST (
                            (Select count(*) from dbo.U_EPRUDHUNXP_drvAstTbl (NOLOCK))  +  (Select count(*) from dbo.U_EPRUDHUNXP_drVEMPTbl (NOLOCK)) + (Select count(*) from dbo.U_EPRUDHUNXP_drvABSTbl (NOLOCK)) +
                            (Select count(*) from dbo.U_EPRUDHUNXP_drvCOVTbl (NOLOCK)) + (Select count(*) from dbo.U_EPRUDHUNXP_drvDEPTbl (NOLOCK)) as VARCHAR(12))

        ,drvASTCount = CAST ((Select count(*) from dbo.U_EPRUDHUNXP_drvAstTbl (NOLOCK)) as varchar(12))
        ,drvEMPRecordCount = CAST ((Select count(*) from dbo.U_EPRUDHUNXP_drVEMPTbl (NOLOCK)) as varchar(12))
        ,drvCOVCount = CAST ((Select count(*) from dbo.U_EPRUDHUNXP_drvCOVTbl (NOLOCK)) as varchar(12))
        ,drvDEPCount = '0'--CAST ((Select count(*) from dbo.U_EPRUDHUNXP_drvDEPTbl (NOLOCK)) as varchar(12)) -- ABC
        ,drvCoverageAmount = CAST ((Select SUM(drvCovProdCovAmtRaw) from dbo.U_EPRUDHUNXP_drvCOVTbl (NOLOCK)) as varchar(12))  
    INTO dbo.U_EPRUDHUNXP_drvTrailer
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
ALTER VIEW dbo.dsi_vwEPRUDHUNXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPRUDHUNXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPRUDHUNXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201910161'
       ,expStartPerControl     = '201910161'
       ,expLastEndPerControl   = '201910239'
       ,expEndPerControl       = '201910239'
WHERE expFormatCode = 'EPRUDHUNXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPRUDHUNXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPRUDHUNXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPRUDHUNXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPRUDHUNXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPRUDHUNXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPRUDHUNXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPRUDHUNXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPRUDHUNXP', 'UseFileName', 'V', 'Y'


-- End ripout