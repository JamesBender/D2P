/**********************************************************************************

ESNAPRUDE: Prudential Eligibility

FormatCode:     ESNAPRUDE
Project:        Prudential Eligibility
Client ID:      SNA1001
Date/time:      2022-01-19 10:53:51.667
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP5DB01
Database:       ULTIPRO_WPSNAGA
Web Filename:   SNA1001_M21GY_EEHISTORY_ESNAPRUDE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESNAPRUDE_SavePath') IS NOT NULL DROP TABLE dbo.U_ESNAPRUDE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESNAPRUDE'


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
WHERE FormatCode = 'ESNAPRUDE'
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
WHERE ExpFormatCode = 'ESNAPRUDE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESNAPRUDE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESNAPRUDE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESNAPRUDE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESNAPRUDE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESNAPRUDE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESNAPRUDE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESNAPRUDE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESNAPRUDE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESNAPRUDE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESNAPRUDE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESNAPRUDE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESNAPRUDE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESNAPRUDE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESNAPRUDE];
GO
IF OBJECT_ID('U_ESNAPRUDE_trTbl') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_trTbl];
GO
IF OBJECT_ID('U_ESNAPRUDE_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_hdrTbl];
GO
IF OBJECT_ID('U_ESNAPRUDE_File') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_File];
GO
IF OBJECT_ID('U_ESNAPRUDE_EMP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_EMP_drvTbl];
GO
IF OBJECT_ID('U_ESNAPRUDE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_EEList];
GO
IF OBJECT_ID('U_ESNAPRUDE_DEP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_DEP_drvTbl];
GO
IF OBJECT_ID('U_ESNAPRUDE_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_DedList];
GO
IF OBJECT_ID('U_ESNAPRUDE_COV_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_COV_drvTbl];
GO
IF OBJECT_ID('U_ESNAPRUDE_CON_trTbl') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_CON_trTbl];
GO
IF OBJECT_ID('U_ESNAPRUDE_CCH_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_CCH_drvTbl];
GO
IF OBJECT_ID('U_ESNAPRUDE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_AuditFields];
GO
IF OBJECT_ID('U_ESNAPRUDE_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_Audit];
GO
IF OBJECT_ID('U_ESNAPRUDE_AST_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESNAPRUDE_AST_drvTbl];
GO
IF OBJECT_ID('U_dsi_BDM_ESNAPRUDE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESNAPRUDE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESNAPRUDE','Prudential Eligibility','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ESNAPRUDE0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESNAPRUDE0Z0','50','H','01','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESNAPRUDE0Z0','50','H','01','2',NULL,'Transmission GUID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESNAPRUDE0Z0','50','H','01','3',NULL,'Creation Date Time',NULL,NULL,'"drvCreationDateTime"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESNAPRUDE0Z0','50','H','01','4',NULL,'Client Control Number',NULL,NULL,'"70809"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESNAPRUDE0Z0','50','H','01','5',NULL,'Client Name',NULL,NULL,'"snagajob.com"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESNAPRUDE0Z0','50','H','01','6',NULL,'SchemaVersionIdentifier',NULL,NULL,'"1"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESNAPRUDE0Z0','50','H','01','7',NULL,'Sender Name',NULL,NULL,'"UKG"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESNAPRUDE0Z0','50','H','01','8',NULL,'Sender Platform Name',NULL,NULL,'"Ultipro"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESNAPRUDE0Z0','50','H','01','9',NULL,'Test Production Code',NULL,NULL,'"TEST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESNAPRUDE0Z0','50','H','01','10',NULL,'Transmission Type Code',NULL,NULL,'"FULL FILE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESNAPRUDE0Z0','50','H','01','11',NULL,'Activity Start Date Time',NULL,NULL,'"drvActivityStartDT"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESNAPRUDE0Z0','50','H','01','12',NULL,'Activity End Date Time',NULL,NULL,'"drvActivityEndDT"','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESNAPRUDE0Z0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"AST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESNAPRUDE0Z0','50','D','10','2',NULL,'Client Control Number',NULL,NULL,'"70809"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESNAPRUDE0Z0','50','D','10','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESNAPRUDE0Z0','50','D','10','4',NULL,'Associate Social Security Number',NULL,NULL,'"drvAssSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESNAPRUDE0Z0','50','D','10','5',NULL,'Associate Gender Code',NULL,NULL,'"drvAssGenderCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESNAPRUDE0Z0','50','D','10','6',NULL,'Associate Date of Birth',NULL,NULL,'"drvAssDateofBirth "','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESNAPRUDE0Z0','50','D','10','7',NULL,'Associate Smoker Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESNAPRUDE0Z0','50','D','10','8',NULL,'Associate Marital Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESNAPRUDE0Z0','50','D','10','9',NULL,'Associate Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESNAPRUDE0Z0','50','D','10','10',NULL,'Associate Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESNAPRUDE0Z0','80','D','10','11',NULL,'Associate Last Name',NULL,NULL,'"drvAssLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESNAPRUDE0Z0','50','D','10','12',NULL,'Associate First Name',NULL,NULL,'"drvAssFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESNAPRUDE0Z0','50','D','10','13',NULL,'Associate Middle Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESNAPRUDE0Z0','50','D','10','14',NULL,'Associate Address Type Code 1',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESNAPRUDE0Z0','64','D','10','15',NULL,'Associate Address Line 1 Text 1',NULL,NULL,'"drvAssAddressLine1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESNAPRUDE0Z0','50','D','10','16',NULL,'Associate Address Line 2 Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESNAPRUDE0Z0','50','D','10','17',NULL,'Associate Address Line 3 Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESNAPRUDE0Z0','50','D','10','18',NULL,'Associate City Name 1',NULL,NULL,'"drvAssCityName1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESNAPRUDE0Z0','50','D','10','19',NULL,'Associate State Province Code 1',NULL,NULL,'"drvAssStateProvinceCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESNAPRUDE0Z0','50','D','10','20',NULL,'Associate Postal Code 1',NULL,NULL,'"drvAssPostalCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESNAPRUDE0Z0','50','D','10','21',NULL,'Associate Country Code 1',NULL,NULL,'"drvAssCountryCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESNAPRUDE0Z0','50','D','10','22',NULL,'Associate Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESNAPRUDE0Z0','50','D','10','23',NULL,'Associate Address Line 1 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESNAPRUDE0Z0','50','D','10','24',NULL,'Associate Address Line 2 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESNAPRUDE0Z0','50','D','10','25',NULL,'Associate Address Line 3 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESNAPRUDE0Z0','50','D','10','26',NULL,'Associate City Name 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESNAPRUDE0Z0','50','D','10','27',NULL,'Associate State Province Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESNAPRUDE0Z0','50','D','10','28',NULL,'Associate Postal Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESNAPRUDE0Z0','50','D','10','29',NULL,'Associate Country Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESNAPRUDE0Z0','50','D','10','30',NULL,'Associate Address Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESNAPRUDE0Z0','50','D','10','31',NULL,'Associate Address Line 1 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESNAPRUDE0Z0','50','D','10','32',NULL,'Associate Address Line 2 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESNAPRUDE0Z0','50','D','10','33',NULL,'Associate Address Line 3 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESNAPRUDE0Z0','50','D','10','34',NULL,'Associate City Name 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESNAPRUDE0Z0','50','D','10','35',NULL,'Associate State Province Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESNAPRUDE0Z0','50','D','10','36',NULL,'Associate Postal Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESNAPRUDE0Z0','50','D','10','37',NULL,'Associate Country Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESNAPRUDE0Z0','50','D','10','38',NULL,'Associate Telephone Type Code 1',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESNAPRUDE0Z0','50','D','10','39',NULL,'Associate Telephone Number 1',NULL,NULL,'"drvAssTelephoneNo1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESNAPRUDE0Z0','50','D','10','40',NULL,'Associate Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESNAPRUDE0Z0','50','D','10','41',NULL,'Telephone Type Code 2',NULL,NULL,'"MOBILE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESNAPRUDE0Z0','50','D','10','42',NULL,'Associate Telephone Number 2',NULL,NULL,'"drvAssTelephoneNo2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESNAPRUDE0Z0','50','D','10','43',NULL,'Associate Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESNAPRUDE0Z0','50','D','10','44',NULL,'Associate Telephone  Type Code 3',NULL,NULL,'"BUSINESS"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESNAPRUDE0Z0','50','D','10','45',NULL,'Associate Telephone Number 3',NULL,NULL,'"drvAssTelephoneNo3"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESNAPRUDE0Z0','50','D','10','46',NULL,'Associate Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESNAPRUDE0Z0','50','D','10','47',NULL,'Associate Email Address Type Code 1',NULL,NULL,'"PERSONAL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESNAPRUDE0Z0','50','D','10','48',NULL,'Associate Email Address Text 1',NULL,NULL,'"drvAssEmailAddress1 "','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESNAPRUDE0Z0','50','D','10','49',NULL,'Associate Email Address Type Code 2',NULL,NULL,'"WORK"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESNAPRUDE0Z0','50','D','10','50',NULL,'Associate Email Address Text 2',NULL,NULL,'"drvAssEmailAddress2 "','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESNAPRUDE0Z0','50','D','20','1',NULL,'Record Type',NULL,NULL,'"EMP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESNAPRUDE0Z0','50','D','20','2',NULL,'Client Control Number',NULL,NULL,'"70809"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESNAPRUDE0Z0','50','D','20','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESNAPRUDE0Z0','50','D','20','4',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESNAPRUDE0Z0','50','D','20','5',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESNAPRUDE0Z0','50','D','20','6',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESNAPRUDE0Z0','50','D','20','7',NULL,'Retirement Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESNAPRUDE0Z0','50','D','20','8',NULL,'Employment Termination Date',NULL,NULL,'"drvEmpTermDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESNAPRUDE0Z0','50','D','20','9',NULL,'Employment Termination Reason Code',NULL,NULL,'"drvEmpTermReasonCd"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESNAPRUDE0Z0','50','D','20','10',NULL,'Adjusted Service Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESNAPRUDE0Z0','50','D','20','11',NULL,'Employment Status Code',NULL,NULL,'"drvEmpStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESNAPRUDE0Z0','50','D','20','12',NULL,'Employment Status Effective Date',NULL,NULL,'"drvEmpStatusEffDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESNAPRUDE0Z0','50','D','20','13',NULL,'Employment Status Reason Code',NULL,NULL,'"drvEmpStatusReasonCd"','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESNAPRUDE0Z0','50','D','20','14',NULL,'Job Title Text',NULL,NULL,'"drvJobTitleText "','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESNAPRUDE0Z0','50','D','20','15',NULL,'Occupation Text',NULL,NULL,'"drvOccupationText"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESNAPRUDE0Z0','50','D','20','16',NULL,'OSHA Job Classification Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESNAPRUDE0Z0','50','D','20','17',NULL,'Occupation Class Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESNAPRUDE0Z0','50','D','20','18',NULL,'Work Status Code',NULL,NULL,'"drvWorkStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESNAPRUDE0Z0','50','D','20','19',NULL,'Weekly Scheduled Hours',NULL,NULL,'"drvWeeklySchedHrs"','(''UNT2''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESNAPRUDE0Z0','50','D','20','20',NULL,'Daily Hours Worked',NULL,NULL,'"drvDailyHrsWorked"','(''UNT2''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESNAPRUDE0Z0','50','D','20','21',NULL,'Hourly Salary Code',NULL,NULL,'"drvHourlySalCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESNAPRUDE0Z0','50','D','20','22',NULL,'Earnings Type  Code 1',NULL,NULL,'"BASE PAY"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESNAPRUDE0Z0','50','D','20','23',NULL,'Earnings  Amount 1',NULL,NULL,'"drvEarningsAmt1"','(''UNT2''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESNAPRUDE0Z0','50','D','20','24',NULL,'Earnings Frequency Code 1',NULL,NULL,'"ANNUAL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESNAPRUDE0Z0','50','D','20','25',NULL,'Earnings Effective  Date 1',NULL,NULL,'"drvEarningsEffDate1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESNAPRUDE0Z0','50','D','20','26',NULL,'Earnings Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESNAPRUDE0Z0','50','D','20','27',NULL,'Earnings Amount 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESNAPRUDE0Z0','50','D','20','28',NULL,'Earnings Frequency  Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESNAPRUDE0Z0','50','D','20','29',NULL,'Earnings Effective Date 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESNAPRUDE0Z0','50','D','20','30',NULL,'Earnings Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESNAPRUDE0Z0','50','D','20','31',NULL,'Earnings Amount 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESNAPRUDE0Z0','50','D','20','32',NULL,'Earnings Frequency Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESNAPRUDE0Z0','50','D','20','33',NULL,'Earnings Effective Date 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESNAPRUDE0Z0','50','D','20','34',NULL,'W4 Filing Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESNAPRUDE0Z0','50','D','20','35',NULL,'W4 Exemptions Number',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESNAPRUDE0Z0','50','D','20','36',NULL,'W4 Additional Withholding Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESNAPRUDE0Z0','50','D','20','37',NULL,'W4 Withholding State Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESNAPRUDE0Z0','50','D','20','38',NULL,'W4 Withholding State Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESNAPRUDE0Z0','50','D','20','39',NULL,'W4 Withholding State Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESNAPRUDE0Z0','50','D','20','40',NULL,'W4 Work Location Postal Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESNAPRUDE0Z0','50','D','20','41',NULL,'Local Bargaining Unit Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESNAPRUDE0Z0','50','D','20','42',NULL,'Member Group Code',NULL,NULL,'"drvMemGroupCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESNAPRUDE0Z0','50','D','20','43',NULL,'Bill Group Code',NULL,NULL,'"Snagajob.com "','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESNAPRUDE0Z0','50','D','20','44',NULL,'Payroll Frequency Code',NULL,NULL,'"MNTHLY_1ST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESNAPRUDE0Z0','50','D','20','45',NULL,'Employment Location',NULL,NULL,'"drvEmpLocation"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESNAPRUDE0Z0','50','D','20','46',NULL,'Work Location State Code',NULL,NULL,'"drvWorkLocStateCd"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESNAPRUDE0Z0','50','D','20','47',NULL,'Comments',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESNAPRUDE0Z0','50','D','30','1',NULL,'Record Type',NULL,NULL,'"COV"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESNAPRUDE0Z0','50','D','30','2',NULL,'Client Control Number',NULL,NULL,'"70809"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESNAPRUDE0Z0','50','D','30','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESNAPRUDE0Z0','50','D','30','4',NULL,'Product Code',NULL,NULL,'"drvProdCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESNAPRUDE0Z0','50','D','30','5',NULL,'Coverage Tier Code',NULL,NULL,'"drvCovTierCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESNAPRUDE0Z0','50','D','30','6',NULL,'Product Plan Code',NULL,NULL,'"drvProdPlanCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESNAPRUDE0Z0','50','D','30','7',NULL,'Coverage Buy Up Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESNAPRUDE0Z0','50','D','30','8',NULL,'Coverage Amount',NULL,NULL,'"drvCovAmount"','(''UNT2''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESNAPRUDE0Z0','50','D','30','9',NULL,'Coverage  Effective Date',NULL,NULL,'"drvCovEffDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESNAPRUDE0Z0','50','D','30','10',NULL,'Coverage  End Date',NULL,NULL,'"drvCovEndDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESNAPRUDE0Z0','50','D','30','11',NULL,'Coverage Status Code',NULL,NULL,'"drvCovStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESNAPRUDE0Z0','50','D','30','12',NULL,'Coverage Status Effective Date',NULL,NULL,'"drvCovStatusEfDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESNAPRUDE0Z0','50','D','30','13',NULL,'Flat Benefit Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESNAPRUDE0Z0','50','D','30','14',NULL,'Claim Branch Code',NULL,NULL,'"drvClaimBranchCd"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESNAPRUDE0Z0','50','D','30','15',NULL,'Assignment Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESNAPRUDE0Z0','50','D','30','16',NULL,'Issuance Age',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESNAPRUDE0Z0','50','D','30','17',NULL,'Voluntary Basis',NULL,NULL,'"drvVoluntaryBasis"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESNAPRUDE0Z0','50','D','30','18',NULL,'Applicant Eligibility Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESNAPRUDE0Z0','50','D','30','19',NULL,'Applicant Inforce Benefit Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESNAPRUDE0Z0','50','D','30','20',NULL,'Applicant Additional Benefit Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESNAPRUDE0Z0','50','D','30','21',NULL,'Applicant Relationship Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESNAPRUDE0Z0','50','D','30','22',NULL,'Applicant EOI Branch Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESNAPRUDE0Z0','50','D','30','23',NULL,'Deduction Type  Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESNAPRUDE0Z0','50','D','30','24',NULL,'Deduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESNAPRUDE0Z0','50','D','30','25',NULL,'Deduction Frequency Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESNAPRUDE0Z0','50','D','30','26',NULL,'Deduction Withholding State',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESNAPRUDE0Z0','50','D','40','1',NULL,'Record Type',NULL,NULL,'"DEP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESNAPRUDE0Z0','50','D','40','2',NULL,'Client Control Number',NULL,NULL,'"70809"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESNAPRUDE0Z0','50','D','40','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESNAPRUDE0Z0','50','D','40','4',NULL,'DependentID',NULL,NULL,'"drvDependentID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESNAPRUDE0Z0','50','D','40','5',NULL,'Dependent Relationship Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESNAPRUDE0Z0','50','D','40','6',NULL,'Dependent Social Security Number',NULL,NULL,'"drvDependentSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESNAPRUDE0Z0','50','D','40','7',NULL,'Dependent Gender Code',NULL,NULL,'"drvDepGenderCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESNAPRUDE0Z0','50','D','40','8',NULL,'Dependent Date of Birth',NULL,NULL,'"drvDepDateofBirth "','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESNAPRUDE0Z0','50','D','40','9',NULL,'Dependent Date of Death',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESNAPRUDE0Z0','50','D','40','10',NULL,'Dependent Smoker Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESNAPRUDE0Z0','50','D','40','11',NULL,'Dependent Marital Status Code',NULL,NULL,'"drvDepMaritalStatusCd"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESNAPRUDE0Z0','50','D','40','12',NULL,'Dependent Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESNAPRUDE0Z0','50','D','40','13',NULL,'Dependent Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESNAPRUDE0Z0','50','D','40','14',NULL,'Dependent Last Name',NULL,NULL,'"drvDepLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESNAPRUDE0Z0','50','D','40','15',NULL,'Dependent First Name',NULL,NULL,'"drvDepFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESNAPRUDE0Z0','50','D','40','16',NULL,'Dependent Middle Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESNAPRUDE0Z0','50','D','40','17',NULL,'Dependent Address Type Code',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESNAPRUDE0Z0','50','D','40','18',NULL,'DependentAddress Line 1 Text',NULL,NULL,'"drvDepAddressLine1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESNAPRUDE0Z0','50','D','40','19',NULL,'Dependent Address Line 2 Text',NULL,NULL,'"drvDepAddressLine2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESNAPRUDE0Z0','50','D','40','20',NULL,'DependentAddress Line 3 Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESNAPRUDE0Z0','50','D','40','21',NULL,'Dependent City Name',NULL,NULL,'"drvDepCityName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESNAPRUDE0Z0','50','D','40','22',NULL,'Dependent State Province Code',NULL,NULL,'"drvDepStateProvinceCd"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESNAPRUDE0Z0','50','D','40','23',NULL,'DependentPostal Code',NULL,NULL,'"drvDepPostalCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESNAPRUDE0Z0','50','D','40','24',NULL,'Dependent Country Code',NULL,NULL,'"drvDepCountryCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESNAPRUDE0Z0','50','D','40','25',NULL,'Dependent Telephone Type Code 1',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESNAPRUDE0Z0','50','D','40','26',NULL,'Dependent Telephone Number 1',NULL,NULL,'"drvDepTelephoneNo1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESNAPRUDE0Z0','50','D','40','27',NULL,'Dependent Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESNAPRUDE0Z0','50','D','40','28',NULL,'Dependent Telephone Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESNAPRUDE0Z0','50','D','40','29',NULL,'Dependent Telephone Number 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESNAPRUDE0Z0','50','D','40','30',NULL,'Dependent Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESNAPRUDE0Z0','50','D','40','31',NULL,'Dependent Telephone  Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESNAPRUDE0Z0','50','D','40','32',NULL,'Dependent Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESNAPRUDE0Z0','50','D','40','33',NULL,'Dependent Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESNAPRUDE0Z0','50','D','40','34',NULL,'Dependent Email Address Type Code 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESNAPRUDE0Z0','50','D','40','35',NULL,'Dependent Email Address Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESNAPRUDE0Z0','50','D','40','36',NULL,'Dependent Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESNAPRUDE0Z0','50','D','40','37',NULL,'Dependent Email Address Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESNAPRUDE0Z0','50','D','40','38',NULL,'Dependent Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESNAPRUDE0Z0','50','D','40','39',NULL,'Dependent Delete Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESNAPRUDE0Z0','50','D','40','40',NULL,'Student Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESNAPRUDE0Z0','50','D','40','41',NULL,'Incapacitated Dependent Clause Certification Indic',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESNAPRUDE0Z0','50','D','40','42',NULL,'Incapacitated Dependent Clause Certification Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESNAPRUDE0Z0','50','D','40','43',NULL,'Dependent Event ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESNAPRUDE0Z0','50','D','40','44',NULL,'Dependent Event Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESNAPRUDE0Z0','50','D','40','45',NULL,'Dependent Event Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESNAPRUDE0Z0','50','D','40','46',NULL,'Dependent Marriage Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESNAPRUDE0Z0','50','D','40','47',NULL,'Dependent Divorce Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESNAPRUDE0Z0','50','D','40','48',NULL,'Dependent  PreferenceID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESNAPRUDE0Z0','50','D','40','49',NULL,'Dependent  CorrespondenceTypeCode',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESNAPRUDE0Z0','50','D','40','50',NULL,'Dependent  Preferred Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESNAPRUDE0Z0','50','D','40','51',NULL,'Dependent  Preferred Language',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESNAPRUDE0Z0','50','D','50','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESNAPRUDE0Z0','50','D','50','2',NULL,'Client Control Number',NULL,NULL,'"70809"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESNAPRUDE0Z0','50','D','50','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESNAPRUDE0Z0','50','D','50','4',NULL,'Custom Characteristic Code',NULL,NULL,'"drvCustomCharacCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESNAPRUDE0Z0','50','D','50','5',NULL,'Custom Characteristic Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESNAPRUDE0Z0','50','D','50','6',NULL,'Custom Characteristic Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESNAPRUDE0Z0','50','D','50','7',NULL,'Custom Characteristic Percent',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESNAPRUDE0Z0','50','D','50','8',NULL,'Custom Characteristic Value Text',NULL,NULL,'"drvCustomCharacValue"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESNAPRUDE0Z0','50','D','60','1',NULL,'Record Type',NULL,NULL,'"CON"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESNAPRUDE0Z0','50','D','60','2',NULL,'Client Control Number',NULL,NULL,'"70809"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESNAPRUDE0Z0','50','D','60','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESNAPRUDE0Z0','50','D','60','4',NULL,'Employment Contact ID',NULL,NULL,'"drvEmpContactID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESNAPRUDE0Z0','50','D','60','5',NULL,'Employment Contact Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESNAPRUDE0Z0','50','D','60','6',NULL,'Employment Contact First Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESNAPRUDE0Z0','50','D','60','7',NULL,'Employment Contact Last Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESNAPRUDE0Z0','50','D','60','8',NULL,'Employment Contact Middle Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESNAPRUDE0Z0','50','D','60','9',NULL,'Employment Contact Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESNAPRUDE0Z0','50','D','60','10',NULL,'Employment Contact Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESNAPRUDE0Z0','50','D','60','11',NULL,'Employment Contact Telephone Type Code 1',NULL,NULL,'"BUSINESS"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESNAPRUDE0Z0','50','D','60','12',NULL,'Employment Contact Telephone Number 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESNAPRUDE0Z0','50','D','60','13',NULL,'Employment Contact Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESNAPRUDE0Z0','50','D','60','14',NULL,'Employment Contact Telephone Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESNAPRUDE0Z0','50','D','60','15',NULL,'Employment Contact Telephone Number 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESNAPRUDE0Z0','50','D','60','16',NULL,'Employment Contact Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESNAPRUDE0Z0','50','D','60','17',NULL,'Employment Contact Telephone  Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESNAPRUDE0Z0','50','D','60','18',NULL,'Employment Contact Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESNAPRUDE0Z0','50','D','60','19',NULL,'Employment Contact Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESNAPRUDE0Z0','50','D','60','20',NULL,'Employment Contact Email Address Type Code 1',NULL,NULL,'"WORK"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESNAPRUDE0Z0','50','D','60','21',NULL,'Employment Contact Email Address Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESNAPRUDE0Z0','50','D','60','22',NULL,'Employment Contact Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESNAPRUDE0Z0','50','D','60','23',NULL,'Employment Contact Email Address Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESNAPRUDE0Z0','50','D','60','24',NULL,'Employment Contact SSN',NULL,NULL,'"drvEmpContactSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESNAPRUDE0Z0','50','D','60','25',NULL,'Employment Contact Employee ID',NULL,NULL,'"drvEmpContactEmpID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESNAPRUDE0Z0','50','D','60','26',NULL,'Employment Contact DOB',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESNAPRUDE0Z0','50','T','90','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESNAPRUDE0Z0','50','T','90','2',NULL,'Audit ID',NULL,NULL,'"drvAuditID"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESNAPRUDE0Z0','50','T','90','3',NULL,'Absence Related Employment Information Record Quan',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESNAPRUDE0Z0','50','T','90','4',NULL,'Associate Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESNAPRUDE0Z0','50','T','90','5',NULL,'Beneficiary Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESNAPRUDE0Z0','50','T','90','6',NULL,'Coverage Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESNAPRUDE0Z0','50','T','90','7',NULL,'Dependent Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESNAPRUDE0Z0','50','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESNAPRUDE0Z0','50','T','90','9',NULL,'Employment Information Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESNAPRUDE0Z0','50','T','90','10',NULL,'Event Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESNAPRUDE0Z0','50','T','90','11',NULL,'Preference Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESNAPRUDE0Z0','50','T','90','12',NULL,'Custom Characteristics Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESNAPRUDE0Z0','50','T','90','13',NULL,'Total Coverage Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESNAPRUDE0Z0','50','T','90','14',NULL,'Total Record Quantity',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESNAPRUDE_20220119.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Hospital Indemnity Export with','202201199','EMPEXPORT','ONDEM_XOE',NULL,'ESNAPRUDE',NULL,NULL,NULL,'202201199','Jan 19 2022 10:41AM','Jan 19 2022 10:41AM','202201191',NULL,'','','202201191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Hospital Indemnity Expor-Sched','202201199','EMPEXPORT','SCH_ESNAPR',NULL,'ESNAPRUDE',NULL,NULL,NULL,'202201199','Jan 19 2022 10:41AM','Jan 19 2022 10:41AM','202201191',NULL,'','','202201191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Hospital Indemnity Expor-Test','202201199','EMPEXPORT','TEST_XOE',NULL,'ESNAPRUDE',NULL,NULL,NULL,'202201199','Jan 19 2022 10:41AM','Jan 19 2022 10:41AM','202201191',NULL,'','','202201191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESNAPRUDE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESNAPRUDE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESNAPRUDE','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESNAPRUDE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESNAPRUDE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESNAPRUDE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESNAPRUDE','H01','dbo.U_ESNAPRUDE_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESNAPRUDE','D10','dbo.U_ESNAPRUDE_AST_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESNAPRUDE','D20','dbo.U_ESNAPRUDE_EMP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESNAPRUDE','D30','dbo.U_ESNAPRUDE_COV_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESNAPRUDE','D40','dbo.U_ESNAPRUDE_DEP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESNAPRUDE','D50','dbo.U_ESNAPRUDE_CCH_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESNAPRUDE','D60','dbo.U_ESNAPRUDE_CON_trTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESNAPRUDE','T90','dbo.U_ESNAPRUDE_trTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ESNAPRUDE
-----------

IF OBJECT_ID('U_dsi_BDM_ESNAPRUDE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESNAPRUDE] (
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
-- Create table U_ESNAPRUDE_AST_drvTbl
-----------

IF OBJECT_ID('U_ESNAPRUDE_AST_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_AST_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvAssociateID] varchar(1) NOT NULL,
    [drvAssSSN] char(11) NULL,
    [drvAssGenderCode] varchar(1) NOT NULL,
    [drvAssDateofBirth] varchar(1) NOT NULL,
    [drvAssLastName] varchar(100) NULL,
    [drvAssFirstName] varchar(100) NULL,
    [drvAssAddressLine1] varchar(255) NULL,
    [drvAssCityName1] varchar(255) NULL,
    [drvAssStateProvinceCode1] varchar(255) NULL,
    [drvAssPostalCode1] varchar(50) NULL,
    [drvAssCountryCode1] char(3) NULL,
    [drvAssTelephoneNo1] varchar(1) NOT NULL,
    [drvAssTelephoneNo] varchar(1) NOT NULL,
    [drvAssTelephoneNo3] varchar(1) NOT NULL,
    [drvAssEmailAddress1] varchar(255) NULL,
    [drvAssEmailAddress2] varchar(255) NULL
);

-----------
-- Create table U_ESNAPRUDE_Audit
-----------

IF OBJECT_ID('U_ESNAPRUDE_Audit') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_Audit] (
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
-- Create table U_ESNAPRUDE_AuditFields
-----------

IF OBJECT_ID('U_ESNAPRUDE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESNAPRUDE_CCH_drvTbl
-----------

IF OBJECT_ID('U_ESNAPRUDE_CCH_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_CCH_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvRecordType] varchar(1) NOT NULL,
    [drvAssociateID] varchar(1) NOT NULL,
    [drvCustomCharacCode] varchar(1) NOT NULL,
    [drvCustomCharacValue] varchar(1) NOT NULL
);

-----------
-- Create table U_ESNAPRUDE_CON_trTbl
-----------

IF OBJECT_ID('U_ESNAPRUDE_CON_trTbl') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_CON_trTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvAssociateID] varchar(1) NOT NULL,
    [drvEmpContactID] varchar(1) NOT NULL,
    [drvEmpContactSSN] char(11) NULL,
    [drvEmpContactEmpID] varchar(1) NOT NULL
);

-----------
-- Create table U_ESNAPRUDE_COV_drvTbl
-----------

IF OBJECT_ID('U_ESNAPRUDE_COV_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_COV_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvAssociateID] varchar(1) NOT NULL,
    [drvProdCode] varchar(1) NOT NULL,
    [drvCovTierCode] varchar(1) NOT NULL,
    [drvProdPlanCode] varchar(1) NOT NULL,
    [drvCovAmount] varchar(1) NOT NULL,
    [drvCovEffDate] varchar(1) NOT NULL,
    [drvCovEndDate] varchar(1) NOT NULL,
    [drvCovStatusCode] varchar(1) NOT NULL,
    [drvCovStatusEfDate] varchar(1) NOT NULL,
    [drvClaimBranchCd] varchar(1) NOT NULL,
    [drvVoluntaryBasis] varchar(1) NOT NULL
);

-----------
-- Create table U_ESNAPRUDE_DedList
-----------

IF OBJECT_ID('U_ESNAPRUDE_DedList') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESNAPRUDE_DEP_drvTbl
-----------

IF OBJECT_ID('U_ESNAPRUDE_DEP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_DEP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvAssociateID] varchar(1) NOT NULL,
    [drvDependentID] varchar(1) NOT NULL,
    [drvDependentSSN] char(11) NULL,
    [drvDepGenderCode] varchar(1) NOT NULL,
    [drvDepDateofBirth] varchar(1) NOT NULL,
    [drvDepMaritalStatusCd] varchar(1) NOT NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepAddressLine1] varchar(255) NULL,
    [drvDepAddressLine2] varchar(255) NULL,
    [drvDepCityName] varchar(255) NULL,
    [drvDepStateProvinceCd] varchar(255) NULL,
    [drvDepPostalCode] varchar(50) NULL,
    [drvDepCountryCode] char(3) NULL,
    [drvDepTelephoneNo1] varchar(1) NOT NULL
);

-----------
-- Create table U_ESNAPRUDE_EEList
-----------

IF OBJECT_ID('U_ESNAPRUDE_EEList') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESNAPRUDE_EMP_drvTbl
-----------

IF OBJECT_ID('U_ESNAPRUDE_EMP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_EMP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] varchar(1) NOT NULL,
    [drvAssociateID] varchar(1) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvEmpTermDate] datetime NULL,
    [drvEmpTermReasonCd] char(6) NULL,
    [drvEmpStatusCode] varchar(1) NOT NULL,
    [drvEmpStatusEffDate] varchar(1) NOT NULL,
    [drvJobTitleText] varchar(1) NOT NULL,
    [drvOccupationText] varchar(1) NOT NULL,
    [drvWorkStatusCode] varchar(1) NOT NULL,
    [drvWeeklySchedHrs] varchar(1) NOT NULL,
    [drvDailyHrsWorked] varchar(1) NOT NULL,
    [drvHourlySalCode] varchar(1) NOT NULL,
    [drvEarningsAmt1] varchar(1) NOT NULL,
    [drvEarningsEffDate1] varchar(1) NOT NULL,
    [drvMemGroupCode] varchar(1) NOT NULL,
    [drvEmpLocation] char(6) NULL,
    [drvWorkLocStateCd] varchar(255) NULL
);

-----------
-- Create table U_ESNAPRUDE_File
-----------

IF OBJECT_ID('U_ESNAPRUDE_File') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ESNAPRUDE_hdrTbl
-----------

IF OBJECT_ID('U_ESNAPRUDE_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_hdrTbl] (
    [drvCreationDateTime] varchar(1) NOT NULL,
    [drvActivityStartDT] varchar(1) NOT NULL,
    [drvActivityEndDT] varchar(1) NOT NULL
);

-----------
-- Create table U_ESNAPRUDE_trTbl
-----------

IF OBJECT_ID('U_ESNAPRUDE_trTbl') IS NULL
CREATE TABLE [dbo].[U_ESNAPRUDE_trTbl] (
    [drvRecordType] varchar(1) NOT NULL,
    [drvAuditID] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESNAPRUDE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Prudential Eligibility

Created By: Marie Thomerson
Business Analyst: Richard Vars
Create Date: 01/10/2022
Service Request Number: TekP-2021-09-21-0003 

Purpose: Prudential Eligibility

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESNAPRUDE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESNAPRUDE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESNAPRUDE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESNAPRUDE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESNAPRUDE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESNAPRUDE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESNAPRUDE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESNAPRUDE', 'SCH_ESNAPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESNAPRUDE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESNAPRUDE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESNAPRUDE';

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
    DELETE FROM dbo.U_ESNAPRUDE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESNAPRUDE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESNAPRUDE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_AuditFields;
    CREATE TABLE dbo.U_ESNAPRUDE_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ESNAPRUDE_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ESNAPRUDE_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ESNAPRUDE_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESNAPRUDE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_Audit;
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
    INTO dbo.U_ESNAPRUDE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESNAPRUDE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESNAPRUDE_Audit ON dbo.U_ESNAPRUDE_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_ESNAPRUDE_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ESNAPRUDE_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_ESNAPRUDE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESNAPRUDE_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','STD, LTD, VLAC, VLCIA, VLC01, VLC02, VLC03, VLCIB, VLC04, VLC05, VLC06, VLCIC, VLC07, VLC08, VCL09, VLE, VLS, VLC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','EES');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','EEC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','EEDP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDPChild','EEDPC');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESNAPRUDE_AST_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESNAPRUDE_AST_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_AST_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID =  EecEmpNo
        ,drvAssSSN = eepSSN
        ,drvAssGenderCode = EepGender
        ,drvAssDateofBirth = EepDateofBirth
        ,drvAssLastName = EepNameLast
        ,drvAssFirstName = EepNameFirst
        ,drvAssAddressLine1 = EepAddressLine1
        ,drvAssCityName1 = EepAddressCity
        ,drvAssStateProvinceCode1 = EepAddressState
        ,drvAssPostalCode1 = EepAddressZipCode
        ,drvAssCountryCode1 = EepAddressCountry
        ,drvAssTelephoneNo1 = EepPhoneHomeNumber
        ,drvAssTelephoneNo2 = CASE WHEN efoPhoneType = 'CEL' THEN CONCAT('1',efoPhoneNumber) END
        ,drvAssTelephoneNo3 = EecPhoneBusinessNumber 
        ,drvAssEmailAddress1 = eepAddressEMailAlternate
        ,drvAssEmailAddress2 = eepAddressEMail
    INTO dbo.U_ESNAPRUDE_AST_drvTbl
    FROM dbo.U_ESNAPRUDE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ESNAPRUDE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESNAPRUDE_EMP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESNAPRUDE_EMP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_EMP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvEmployeeID = EecEmpNo
        ,drvHireDate = EecDateOfOriginalHire
        ,drvRehireDate = EecDateOfLastHire
        ,drvEmpTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmpTermReasonCd = CASE WHEN EecEmplStatus = 'T' THEN CASE 
																	WHEN EecTermReason = '202' THEN 'RETIRED' 
																	WHEN EecTermReason = '203' THEN 'DECEASED' 
																	ELSE 'TERMINATED'
																  END
															END
        ,drvEmpStatusCode =  CASE	WHEN EecEmplStatus = 'T' THEN 'TERMINATED' 
									WHEN EecEmplStatus = 'A' THEN 'ACTIVE'
									WHEN EecEmplStatus = 'L' THEN 'LEAVE OF ABSENCE'
							 END
        ,drvEmpStatusEffDate = EecEmplStatusStartDate
        ,drvJobTitleText = JbcDesc 
        ,drvOccupationText = JbcDesc 
        ,drvWorkStatusCode = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'FULL TIME' else 'PART TIME' END
        ,drvWeeklySchedHrs = EecScheduledWorkHrs 
        ,drvDailyHrsWorked = EecScheduledWorkHrs/5 
        ,drvHourlySalCode = CASE WHEN EecSalaryOrHourly = 'H' THEN 'HOURLY' else 'SALARIED' END
        ,drvEarningsAmt1 = EecAnnSalary
        ,drvEarningsEffDate1 =[dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate] (EecEEID, EecCOID, '01/01/2022',EecDateOfLastHire) 
        ,drvMemGroupCode = '001'
        ,drvEmpLocation = '001'
        ,drvWorkLocStateCd = LocAddressState
    INTO dbo.U_ESNAPRUDE_EMP_drvTbl
    FROM dbo.U_ESNAPRUDE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_ESNAPRUDE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	LEFT JOIN Location WITH (NOLOCK)
		ON LocCode = EecLocation
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESNAPRUDE_COV_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESNAPRUDE_COV_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_COV_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvProdCode = CASE WHEN BdmDedcode =  'STD' THEN 'WDI'
							WHEN BdmDedcode =  'LTD' THEN 'LTD'
							WHEN BdmDedcode =  'VLAC' THEN 'VACC'
							WHEN BdmDedcode in ('VLCIA', 'VLC01', 'VLC02', 'VLC03', 'VLCIB', 'VLC04', 'VLC05', 'VLC06', 'VLCIC', 'VLC07', 'VLC08', 'VCL09') THEN 'VCI'
							WHEN BdmDedcode =  'VLE' THEN 'OGL'
							WHEN BdmDedcode in ('VLS', 'VLC') THEN 'ODGL'
							END
        ,drvCovTierCode = CASE	WHEN BdmBenOption = 'EE' and Bdmdedcode =  'STD' THEN 'EE'
								WHEN BdmBenOption = 'EE' and Bdmdedcode =  'LTD' THEN 'EE'
								WHEN BdmBenOption in ( 'EE', 'EES', 'EEC', 'EEDP', 'EEF') and Bdmdedcode =  'VLAC' THEN BdmBenOption
								--tier code (corresponding code: EE, ES, EC, FM)
								WHEN BdmBenOption in ( 'EE', 'EES', 'EEC', 'EEDP', 'EEF') and Bdmdedcode in ('VLCIA', 'VLC01', 'VLC02', 'VLC03', 'VLCIB', 'VLC04', 'VLC05', 'VLC06', 'VLCIC', 'VLC07', 'VLC08', 'VCL09') THEN BdmBenOption
								WHEN BdmBenOption in ( 'EE') and Bdmdedcode =  'VLE' THEN 'EE'
								WHEN BdmBenOption in ( 'EES', 'EEDP') and Bdmdedcode in ( 'VLS', 'VLC') THEN 'SP'
							END
        ,drvProdPlanCode = CASE WHEN Bdmdedcode = 'VLAC' THEN '5156'
								WHEN Bdmdedcode in ('VLCIA', 'VLC01', 'VLC02', 'VLC03', 'VLCIB', 'VLC04', 'VLC05', 'VLC06', 'VLCIC', 'VLC07', 'VLC08', 'VCL09','VCI')  THEN '5157'
								END
        ,drvCovAmount = CASE WHEN BdmDedCode in ('VLCIA', 'VLC01', 'VLC02', 'VLC03', 'VLCIB', 'VLC04', 'VLC05', 'VLC06', 'VLCIC', 'VLC07', 'VLC08', 'VCL09') THEN BdmEEAmt else null END
		---?EedBenAmt
        ,drvCovEffDate = CASE WHEN BdmDedCode in ('STD', 'LTD', 'VLE', 'VLS', 'VLC') THEN BdmBenStartDate ELSE 
									CASE WHEN BdmBenStartDate < 2021-01-01 THEN '1/1/2021' ELSE BdmBenStartDate 
									END 
								END
        ,drvCovEndDate = BdmBenStopDate
        ,drvCovStatusCode = CASE	WHEN BdmBenStatus  = 'A' THEN 'ACTIVE'
									WHEN BdmBenStatus = 'W' THEN 'CANCELLED'
									else 'TERMINATED' 
							END
        ,drvCovStatusEfDate = CASE	WHEN BdmBenStatus  = 'A' THEN BdmBenStopDate
									WHEN BdmBenStatus = 'W' THEN BdmBenStopDate
								END
        ,drvClaimBranchCd = ''
        ,drvVoluntaryBasis = CASE WHEN Bdmdedcode = 'VLAC' THEN 'TREATMENT'else NULL END
    INTO dbo.U_ESNAPRUDE_COV_drvTbl
    FROM dbo.U_ESNAPRUDE_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESNAPRUDE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESNAPRUDE_DEP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESNAPRUDE_DEP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_DEP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvDependentID = EecEmpNo + 1
		--- Plus number of dependents
        ,drvDependentSSN = conSSN 
        ,drvDepGenderCode = CASE	WHEN ConGender = 'M' THEN 'MALE'
									WHEN ConGender = 'F' THEN 'FEMALE'
									else 'UNKNOWN' 
								END
        ,drvDepDateofBirth = ConDateOfBirth
        ,drvDepMaritalStatusCd = CASE	WHEN conrelationship = 'SPS' THEN 'MARRIED'
										WHEN conrelationship = 'DP' THEN 'DOMESTIC PARTNER'
										else 'SINGLE'
								  END
        ,drvDepLastName = ConNameLast
        ,drvDepFirstName = ConNameFirst
        ,drvDepAddressLine1 = ConAddressLine1
        ,drvDepAddressLine2 = ConAddressLine2
        ,drvDepCityName = ConAddressCity
        ,drvDepStateProvinceCd = ConAddressState
        ,drvDepPostalCode = ConAddressZipCode
        ,drvDepCountryCode = ConAddressCountry
        ,drvDepTelephoneNo1 = ConPhoneHomeNumber
    INTO dbo.U_ESNAPRUDE_DEP_drvTbl
    FROM dbo.U_ESNAPRUDE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESNAPRUDE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
	LEFT JOIN Contacts WITH (NOLOCK)
		ON ConEEID = xEEID 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESNAPRUDE_CCH_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESNAPRUDE_CCH_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_CCH_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'CCH'
        ,drvAssociateID = ''
--	Always Required - this field is used to join all applicable record types to the same associate
--Do not value with Employee SSN
--If customer has EE ID value with EE ID
--If customer does not have an EE ID - value with system generated ID that is unique for each employee
        ,drvCustomCharacCode = ''
--		Label for corresponding value which is sent in Amount; Date; Percent or Text fields.
--- For Disability: Value Reporting Coden (where n is a number from 1-20)
--- For EOI: Value EOI
--Not required but can be provided when customer requires additional repotting needs

--Up to 20 reporting codes can be accommodated per employee.

--Value Reporting Code1, which represents the...

        ,drvCustomCharacValue = ''
--		For Disability:  This will be the valid values defined by the customer - example '113'; '456'
--For EOI:  This will be the valid value defined by the customer and Prudential - example 'SouthTerr'; 'NorthTerr'

--For Reporting Code1, value the 
    INTO dbo.U_ESNAPRUDE_CCH_drvTbl
    FROM dbo.U_ESNAPRUDE_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESNAPRUDE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESNAPRUDE_CON_trTbl
    ---------------------------------
    IF OBJECT_ID('U_ESNAPRUDE_CON_trTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_CON_trTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = ''
        -- standard fields above and additional driver fields below
        ,drvAssociateID = ''
        ,drvEmpContactID = ''
        ,drvEmpContactSSN = eepSSN
        ,drvEmpContactEmpID = ''
    INTO dbo.U_ESNAPRUDE_CON_trTbl
    FROM dbo.U_ESNAPRUDE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESNAPRUDE WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESNAPRUDE_hdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_hdrTbl;
    SELECT DISTINCT
         drvCreationDateTime = GetDate()
        ,drvActivityStartDT = GetDate()
        ,drvActivityEndDT = GetDate()
    INTO dbo.U_ESNAPRUDE_hdrTbl
    FROM dbo.U_ESNAPRUDE_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESNAPRUDE_trTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESNAPRUDE_trTbl;
    SELECT DISTINCT
         drvRecordType = 'TRL'
        ,drvAuditID = GetDate()
		---Format = CCYYMMDD
    INTO dbo.U_ESNAPRUDE_trTbl
    FROM dbo.U_ESNAPRUDE_EEList WITH (NOLOCK)
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN '70809_TEST_ClientEligibilty_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE '70809_ClientEligibilty_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESNAPRUDE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESNAPRUDE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ESNAPRUDE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101121'
       ,expStartPerControl     = '202101121'
       ,expLastEndPerControl   = '202201199'
       ,expEndPerControl       = '202201199'
WHERE expFormatCode = 'ESNAPRUDE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESNAPRUDE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESNAPRUDE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESNAPRUDE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESNAPRUDE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESNAPRUDE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESNAPRUDE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESNAPRUDE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESNAPRUDE', 'UseFileName', 'V', 'Y'


-- End ripout