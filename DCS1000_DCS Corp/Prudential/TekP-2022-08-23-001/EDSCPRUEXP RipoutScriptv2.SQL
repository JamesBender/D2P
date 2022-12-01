/**********************************************************************************

EDSCPRUEXP: Prudential Life/Illness/Accident/Hospital Export

FormatCode:     EDSCPRUEXP
Project:        Prudential Life/Illness/Accident/Hospital Export
Client ID:      DCS1000
Date/time:      2022-12-01 17:46:18.100
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB01
Database:       ULTIPRO_WPDCSC
Web Filename:   DCS1000_A6BD0_EEHISTORY_EDSCPRUEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDSCPRUEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EDSCPRUEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDSCPRUEXP'


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
WHERE FormatCode = 'EDSCPRUEXP'
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
WHERE ExpFormatCode = 'EDSCPRUEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDSCPRUEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDSCPRUEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDSCPRUEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDSCPRUEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDSCPRUEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDSCPRUEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDSCPRUEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDSCPRUEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDSCPRUEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDSCPRUEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDSCPRUEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDSCPRUEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDSCPRUEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDSCPRUEXP];
GO
IF OBJECT_ID('U_EDSCPRUEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_Trailer];
GO
IF OBJECT_ID('U_EDSCPRUEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_Header];
GO
IF OBJECT_ID('U_EDSCPRUEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_File];
GO
IF OBJECT_ID('U_EDSCPRUEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_EEList];
GO
IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_EMP') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_drvTbl_EMP];
GO
IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_DEP') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_drvTbl_DEP];
GO
IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_COV') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_drvTbl_COV];
GO
IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_AST') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_drvTbl_AST];
GO
IF OBJECT_ID('U_EDSCPRUEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_DedList];
GO
IF OBJECT_ID('U_EDSCPRUEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_AuditFields];
GO
IF OBJECT_ID('U_EDSCPRUEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EDSCPRUEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EDSCPRUEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDSCPRUEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDSCPRUEXP','Prudential Life/Illness/Accident/Hospital Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EDSCPRUEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDSCPRUEXPZ0','3','H','01','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDSCPRUEXPZ0','32','H','01','2',NULL,'Transmission GUID',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDSCPRUEXPZ0','14','H','01','3',NULL,'Creation Date Time',NULL,NULL,'"drvCreationDateTime"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDSCPRUEXPZ0','10','H','01','4',NULL,'Client Control Number',NULL,NULL,'"drvClientControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDSCPRUEXPZ0','80','H','01','5',NULL,'Client Name',NULL,NULL,'"drvClientName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDSCPRUEXPZ0','6','H','01','6',NULL,'SchemaVersionIdentifier',NULL,NULL,'"drvSchemaVersionIdentifier"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDSCPRUEXPZ0','80','H','01','7',NULL,'Sender Name',NULL,NULL,'"drvSenderName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDSCPRUEXPZ0','80','H','01','8',NULL,'Sender Platform Name',NULL,NULL,'"drvSenderPlatformName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDSCPRUEXPZ0','10','H','01','9',NULL,'Test Production Code',NULL,NULL,'"drvTestProductionCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDSCPRUEXPZ0','12','H','01','10',NULL,'Transmission Type Code',NULL,NULL,'"drvTransmissionTypeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDSCPRUEXPZ0','14','H','01','11',NULL,'Activity Start Date Time',NULL,NULL,'"drvActivityStartDateTime"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDSCPRUEXPZ0','14','H','01','12',NULL,'Activity End Date Time',NULL,NULL,'"drvActivityEndDateTime"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDSCPRUEXPZ0','3','D','10','1',NULL,'Record Type',NULL,NULL,'"AST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDSCPRUEXPZ0','10','D','10','2',NULL,'Client Control Number',NULL,NULL,'"drvClientControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDSCPRUEXPZ0','32','D','10','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDSCPRUEXPZ0','9','D','10','4',NULL,'Associate Social Security Number',NULL,NULL,'"drvAssociateSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDSCPRUEXPZ0','25','D','10','5',NULL,'Associate Gender Code',NULL,NULL,'"drvAssociateGenderCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDSCPRUEXPZ0','8','D','10','6',NULL,'Associate Date of Birth',NULL,NULL,'"drvAssociateDateofBirth"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDSCPRUEXPZ0','8','D','10','7',NULL,'Associate Date of Death',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDSCPRUEXPZ0','25','D','10','8',NULL,'Associate Smoker Status Code',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDSCPRUEXPZ0','30','D','10','9',NULL,'Associate Marital Status Code',NULL,NULL,'"drvAssociateMaritalStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDSCPRUEXPZ0','30','D','10','10',NULL,'Associate Prefix Title Code',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDSCPRUEXPZ0','30','D','10','11',NULL,'Associate Suffix',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDSCPRUEXPZ0','80','D','10','12',NULL,'Associate Last Name',NULL,NULL,'"drvAssociateLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDSCPRUEXPZ0','50','D','10','13',NULL,'Associate First Name',NULL,NULL,'"drvAssociateFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDSCPRUEXPZ0','50','D','10','14',NULL,'Associate Middle Name',NULL,NULL,'"drvAssociateMiddleName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDSCPRUEXPZ0','25','D','10','15',NULL,'Associate Address Type Code 1',NULL,NULL,'"drvAssociateAddressTypeCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDSCPRUEXPZ0','64','D','10','16',NULL,'Associate Address Line 1 Text 1',NULL,NULL,'"drvAssociateAddressLine1Text1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDSCPRUEXPZ0','64','D','10','17',NULL,'Associate Address Line 2 Text 1',NULL,NULL,'"drvAssociateAddressLine2Text1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDSCPRUEXPZ0','64','D','10','18',NULL,'Associate Address Line 3 Text 1',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDSCPRUEXPZ0','50','D','10','19',NULL,'Associate City Name 1',NULL,NULL,'"drvAssociateCityName1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDSCPRUEXPZ0','2','D','10','20',NULL,'Associate State Province Code 1',NULL,NULL,'"drvAssociateState1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDSCPRUEXPZ0','12','D','10','21',NULL,'Associate Postal Code 1',NULL,NULL,'"drvAssociatePostalCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDSCPRUEXPZ0','35','D','10','22',NULL,'Associate Country Code 1',NULL,NULL,'"drvAssociateCountryCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDSCPRUEXPZ0','25','D','10','23',NULL,'Associate Address Type Code 2',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDSCPRUEXPZ0','64','D','10','24',NULL,'Associate Address Line 1 Text 2',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EDSCPRUEXPZ0','64','D','10','25',NULL,'Associate Address Line 2 Text 2',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EDSCPRUEXPZ0','64','D','10','26',NULL,'Associate Address Line 3 Text 2',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EDSCPRUEXPZ0','50','D','10','27',NULL,'Associate City Name 2',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EDSCPRUEXPZ0','2','D','10','28',NULL,'Associate State Province Code 2',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EDSCPRUEXPZ0','12','D','10','29',NULL,'Associate Postal Code 2',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EDSCPRUEXPZ0','35','D','10','30',NULL,'Associate Country Code 2',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EDSCPRUEXPZ0','25','D','10','31',NULL,'Associate Address Type Code 3',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EDSCPRUEXPZ0','64','D','10','32',NULL,'Associate Address Line 1 Text 3',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EDSCPRUEXPZ0','64','D','10','33',NULL,'Associate Address Line 2 Text 3',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EDSCPRUEXPZ0','64','D','10','34',NULL,'Associate Address Line 3 Text 3',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EDSCPRUEXPZ0','50','D','10','35',NULL,'Associate City Name 3',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EDSCPRUEXPZ0','2','D','10','36',NULL,'Associate State Province Code 3',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EDSCPRUEXPZ0','12','D','10','37',NULL,'Associate Postal Code 3',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EDSCPRUEXPZ0','35','D','10','38',NULL,'Associate Country Code 3',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EDSCPRUEXPZ0','30','D','10','39',NULL,'Associate Telephone Type Code 1',NULL,NULL,'"drvAssociateTelephoneType1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EDSCPRUEXPZ0','20','D','10','40',NULL,'Associate Telephone Number 1',NULL,NULL,'"drvAssociateTelephoneNumber1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EDSCPRUEXPZ0','10','D','10','41',NULL,'Associate Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EDSCPRUEXPZ0','30','D','10','42',NULL,'Telephone Type Code 2',NULL,NULL,'"drvTelephoneTypeCode2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EDSCPRUEXPZ0','20','D','10','43',NULL,'Associate Telephone Number 2',NULL,NULL,'"drvAssociateTelephoneNumber2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EDSCPRUEXPZ0','10','D','10','44',NULL,'Associate Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EDSCPRUEXPZ0','30','D','10','45',NULL,'Associate Telephone Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EDSCPRUEXPZ0','20','D','10','46',NULL,'Associate Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EDSCPRUEXPZ0','10','D','10','47',NULL,'Associate Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EDSCPRUEXPZ0','25','D','10','48',NULL,'Associate Email Address Type Code 1',NULL,NULL,'"drvAssociateEmailAddressType1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EDSCPRUEXPZ0','350','D','10','49',NULL,'Associate Email Address Text 1',NULL,NULL,'"drvAssociateEmailAddressText1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EDSCPRUEXPZ0','25','D','10','50',NULL,'Associate Email Address Type Code 2',NULL,NULL,'"drvAssociateEmailAddressType2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EDSCPRUEXPZ0','350','D','10','51',NULL,'Associate Email Address Text 2',NULL,NULL,'"drvAssociateEmailAddressText2"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDSCPRUEXPZ0','3','D','20','1',NULL,'Record Type',NULL,NULL,'"EMP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDSCPRUEXPZ0','10','D','20','2',NULL,'Client Control Number',NULL,NULL,'"drvClientControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDSCPRUEXPZ0','32','D','20','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDSCPRUEXPZ0','32','D','20','4',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDSCPRUEXPZ0','8','D','20','5',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDSCPRUEXPZ0','8','D','20','6',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDSCPRUEXPZ0','8','D','20','7',NULL,'Retirement Date',NULL,NULL,'"drvRetirementDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDSCPRUEXPZ0','8','D','20','8',NULL,'Employment Termination Date',NULL,NULL,'"drvEmploymentTerminationDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDSCPRUEXPZ0','25','D','20','9',NULL,'Employment Termination Reason Code',NULL,NULL,'"drvEmploymentTermReasonCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDSCPRUEXPZ0','8','D','20','10',NULL,'Adjusted Service Date',NULL,NULL,'"drvAdjustedServiceDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDSCPRUEXPZ0','8','D','20','11',NULL,'Last Active Service Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDSCPRUEXPZ0','30','D','20','12',NULL,'Employment Status Code',NULL,NULL,'"drvEmploymentStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDSCPRUEXPZ0','8','D','20','13',NULL,'Employment Status Effective Date',NULL,NULL,'"drvEmploymentStatusEffDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDSCPRUEXPZ0','30','D','20','14',NULL,'Employment Status Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDSCPRUEXPZ0','30','D','20','15',NULL,'Job Title Text',NULL,NULL,'"drvJobTitleText"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDSCPRUEXPZ0','30','D','20','16',NULL,'Occupation Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDSCPRUEXPZ0','25','D','20','17',NULL,'OSHA Job Classification Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDSCPRUEXPZ0','25','D','20','18',NULL,'Occupation Class Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDSCPRUEXPZ0','25','D','20','19',NULL,'Work Status Code',NULL,NULL,'"drvWorkStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDSCPRUEXPZ0','5','D','20','20',NULL,'Weekly Scheduled Hours',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDSCPRUEXPZ0','5','D','20','21',NULL,'Daily Hours Worked',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDSCPRUEXPZ0','25','D','20','22',NULL,'Hourly Salary Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDSCPRUEXPZ0','30','D','20','23',NULL,'Earnings Type Code 1',NULL,NULL,'"drvEarningsTypeCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDSCPRUEXPZ0','17','D','20','24',NULL,'Earnings Amount 1',NULL,NULL,'"drvEarningsAmount1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EDSCPRUEXPZ0','30','D','20','25',NULL,'Earnings Frequency Code 1',NULL,NULL,'"drvEarningsFrequencyCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EDSCPRUEXPZ0','8','D','20','26',NULL,'Earnings Effective Date 1',NULL,NULL,'"drvEarningsEffectiveDate1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EDSCPRUEXPZ0','30','D','20','27',NULL,'Earnings Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EDSCPRUEXPZ0','17','D','20','28',NULL,'Earnings Amount 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EDSCPRUEXPZ0','30','D','20','29',NULL,'Earnings Frequency Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EDSCPRUEXPZ0','8','D','20','30',NULL,'Earnings Effective Date 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EDSCPRUEXPZ0','30','D','20','31',NULL,'Earnings Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EDSCPRUEXPZ0','17','D','20','32',NULL,'Earnings Amount 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EDSCPRUEXPZ0','30','D','20','33',NULL,'Earnings Frequency Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EDSCPRUEXPZ0','8','D','20','34',NULL,'Earnings Effective Date 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EDSCPRUEXPZ0','25','D','20','35',NULL,'W4 Filing Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EDSCPRUEXPZ0','4','D','20','36',NULL,'W4 Exemptions Number',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EDSCPRUEXPZ0','17','D','20','37',NULL,'W4 Additional Withholding Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EDSCPRUEXPZ0','2','D','20','38',NULL,'W4 Withholding State Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EDSCPRUEXPZ0','2','D','20','39',NULL,'W4 Withholding State Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EDSCPRUEXPZ0','2','D','20','40',NULL,'W4 Withholding State Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EDSCPRUEXPZ0','12','D','20','41',NULL,'W4 Work Location Postal Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EDSCPRUEXPZ0','5','D','20','42',NULL,'Union Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EDSCPRUEXPZ0','25','D','20','43',NULL,'Local Bargaining Unit Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EDSCPRUEXPZ0','25','D','20','44',NULL,'Member Group Code',NULL,NULL,'"001"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EDSCPRUEXPZ0','25','D','20','45',NULL,'Bill Group Code',NULL,NULL,'"DCS Corporation"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EDSCPRUEXPZ0','30','D','20','46',NULL,'Payroll Frequency Code',NULL,NULL,'"MNTHLY_1ST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EDSCPRUEXPZ0','25','D','20','47',NULL,'District Location Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EDSCPRUEXPZ0','30','D','20','48',NULL,'Employment Location',NULL,NULL,'"001"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EDSCPRUEXPZ0','10','D','20','49',NULL,'Regional Unit',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EDSCPRUEXPZ0','20','D','20','50',NULL,'Employer Information',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EDSCPRUEXPZ0','80','D','20','51',NULL,'Group',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EDSCPRUEXPZ0','2','D','20','52',NULL,'Work Location State Code',NULL,NULL,'"drvWorkLocationStateCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EDSCPRUEXPZ0','256','D','20','53',NULL,'Comments',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EDSCPRUEXPZ0','17','D','20','54',NULL,'Year to Date Earnings',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EDSCPRUEXPZ0','8','D','20','55',NULL,'Earnings As of Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDSCPRUEXPZ0','3','D','30','1',NULL,'Record Type',NULL,NULL,'"COV"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDSCPRUEXPZ0','10','D','30','2',NULL,'Client Control Number',NULL,NULL,'"drvClientControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDSCPRUEXPZ0','32','D','30','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDSCPRUEXPZ0','25','D','30','4',NULL,'Product Code',NULL,NULL,'"drvProductCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDSCPRUEXPZ0','25','D','30','5',NULL,'Coverage Tier Code',NULL,NULL,'"drvCoverageTierCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDSCPRUEXPZ0','25','D','30','6',NULL,'Product Plan Code',NULL,NULL,'"drvProductPlanCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDSCPRUEXPZ0','5','D','30','7',NULL,'Coverage Buy Up Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDSCPRUEXPZ0','17','D','30','8',NULL,'Coverage Amount',NULL,NULL,'"drvCoverageAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDSCPRUEXPZ0','8','D','30','9',NULL,'Coverage Effective Date',NULL,NULL,'"drvCoverageEffectiveDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDSCPRUEXPZ0','8','D','30','10',NULL,'Coverage End Date',NULL,NULL,'"drvCoverageEndDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDSCPRUEXPZ0','25','D','30','11',NULL,'Coverage Status Code',NULL,NULL,'"drvCoverageStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDSCPRUEXPZ0','8','D','30','12',NULL,'Coverage Status Effective Date',NULL,NULL,'"drvCoverageStatusEffDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDSCPRUEXPZ0','25','D','30','13',NULL,'Coverage Status Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDSCPRUEXPZ0','30','D','30','14',NULL,'Coverage Termination Reduction Type Code',NULL,NULL,'"drvCoverageTermReductionCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDSCPRUEXPZ0','17','D','30','15',NULL,'Coverage Termination Reduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDSCPRUEXPZ0','5','D','30','16',NULL,'Flat Benefit Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDSCPRUEXPZ0','50','D','30','17',NULL,'Claim Branch Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDSCPRUEXPZ0','25','D','30','18',NULL,'EOB Correspondence Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDSCPRUEXPZ0','5','D','30','19',NULL,'Assignment Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDSCPRUEXPZ0','8','D','30','20',NULL,'Original LTD Coverage Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDSCPRUEXPZ0','25','D','30','21',NULL,'Partner Product Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDSCPRUEXPZ0','25','D','30','22',NULL,'Partner Short Benefit Description',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDSCPRUEXPZ0','8','D','30','23',NULL,'Client Coverage Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDSCPRUEXPZ0','2','D','30','24',NULL,'Benefit Option Identifier',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EDSCPRUEXPZ0','5','D','30','25',NULL,'Coverage Increase Within 2 years Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EDSCPRUEXPZ0','3','D','30','26',NULL,'Issuance Age',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EDSCPRUEXPZ0','25','D','30','27',NULL,'Voluntary Basis',NULL,NULL,'"drvVoluntaryBasis"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EDSCPRUEXPZ0','8','D','30','28',NULL,'Applicant Eligibility Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EDSCPRUEXPZ0','17','D','30','29',NULL,'Applicant Inforce Benefit Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EDSCPRUEXPZ0','17','D','30','30',NULL,'Applicant Additional Benefit Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EDSCPRUEXPZ0','35','D','30','31',NULL,'Applicant Relationship Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EDSCPRUEXPZ0','5','D','30','32',NULL,'Applicant EOI Branch Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EDSCPRUEXPZ0','35','D','30','33',NULL,'Deduction Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EDSCPRUEXPZ0','17','D','30','34',NULL,'Deduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EDSCPRUEXPZ0','30','D','30','35',NULL,'Deduction Frequency Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EDSCPRUEXPZ0','2','D','30','36',NULL,'Deduction Withholding State',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EDSCPRUEXPZ0','30','D','30','37',NULL,'Payroll Deduction Frequency Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EDSCPRUEXPZ0','17','D','30','38',NULL,'Payroll Deduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EDSCPRUEXPZ0','32','D','30','39',NULL,'Coverage Event ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EDSCPRUEXPZ0','40','D','30','40',NULL,'Coverage Event Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EDSCPRUEXPZ0','8','D','30','41',NULL,'Coverage Event Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EDSCPRUEXPZ0','8','D','30','42',NULL,'Coverage Marriage Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EDSCPRUEXPZ0','8','D','30','43',NULL,'Coverage Divorce Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDSCPRUEXPZ0','3','D','40','1',NULL,'Record Type',NULL,NULL,'"DEP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDSCPRUEXPZ0','10','D','40','2',NULL,'Client Control Number',NULL,NULL,'"drvClientControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDSCPRUEXPZ0','32','D','40','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDSCPRUEXPZ0','32','D','40','4',NULL,'DependentID',NULL,NULL,'"drvDependentID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDSCPRUEXPZ0','35','D','40','5',NULL,'Dependent Relationship Type Code',NULL,NULL,'"drvDepRelationshipCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDSCPRUEXPZ0','9','D','40','6',NULL,'Dependent Social Security Number',NULL,NULL,'"drvDepSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDSCPRUEXPZ0','25','D','40','7',NULL,'Dependent Gender Code',NULL,NULL,'"drvDepGender"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDSCPRUEXPZ0','8','D','40','8',NULL,'Dependent Date of Birth',NULL,NULL,'"drvDepDateOfBirth"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDSCPRUEXPZ0','8','D','40','9',NULL,'Dependent Date of Death',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDSCPRUEXPZ0','25','D','40','10',NULL,'Dependent Smoker Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDSCPRUEXPZ0','30','D','40','11',NULL,'Dependent Marital Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDSCPRUEXPZ0','30','D','40','12',NULL,'Dependent Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDSCPRUEXPZ0','30','D','40','13',NULL,'Dependent Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDSCPRUEXPZ0','80','D','40','14',NULL,'Dependent Last Name',NULL,NULL,'"drvDepLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDSCPRUEXPZ0','50','D','40','15',NULL,'Dependent First Name',NULL,NULL,'"drvDepFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDSCPRUEXPZ0','50','D','40','16',NULL,'Dependent Middle Name',NULL,NULL,'"drvDepMiddleName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDSCPRUEXPZ0','25','D','40','17',NULL,'Dependent Address Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDSCPRUEXPZ0','64','D','40','18',NULL,'DependentAddress Line 1 Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDSCPRUEXPZ0','64','D','40','19',NULL,'Dependent Address Line 2 Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDSCPRUEXPZ0','64','D','40','20',NULL,'DependentAddress Line 3 Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDSCPRUEXPZ0','50','D','40','21',NULL,'Dependent City Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDSCPRUEXPZ0','2','D','40','22',NULL,'Dependent State Province Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDSCPRUEXPZ0','12','D','40','23',NULL,'DependentPostal Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDSCPRUEXPZ0','35','D','40','24',NULL,'Dependent Country Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EDSCPRUEXPZ0','30','D','40','25',NULL,'Dependent Telephone Type Code 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EDSCPRUEXPZ0','20','D','40','26',NULL,'Dependent Telephone Number 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EDSCPRUEXPZ0','10','D','40','27',NULL,'Dependent Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EDSCPRUEXPZ0','30','D','40','28',NULL,'Dependent Telephone Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EDSCPRUEXPZ0','20','D','40','29',NULL,'Dependent Telephone Number 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EDSCPRUEXPZ0','10','D','40','30',NULL,'Dependent Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EDSCPRUEXPZ0','30','D','40','31',NULL,'Dependent Telephone Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EDSCPRUEXPZ0','20','D','40','32',NULL,'Dependent Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EDSCPRUEXPZ0','10','D','40','33',NULL,'Dependent Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EDSCPRUEXPZ0','25','D','40','34',NULL,'Dependent Email Address Type Code 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EDSCPRUEXPZ0','350','D','40','35',NULL,'Dependent Email Address Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EDSCPRUEXPZ0','25','D','40','36',NULL,'Dependent Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EDSCPRUEXPZ0','350','D','40','37',NULL,'Dependent Email Address Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EDSCPRUEXPZ0','25','D','40','38',NULL,'Dependent Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EDSCPRUEXPZ0','25','D','40','39',NULL,'Dependent Delete Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EDSCPRUEXPZ0','25','D','40','40',NULL,'Student Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EDSCPRUEXPZ0','1','D','40','41',NULL,'Incapacitated Dependent Clause Certification Indic',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EDSCPRUEXPZ0','8','D','40','42',NULL,'Incapacitated Dependent Clause Certification Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EDSCPRUEXPZ0','32','D','40','43',NULL,'Dependent Event ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EDSCPRUEXPZ0','40','D','40','44',NULL,'Dependent Event Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EDSCPRUEXPZ0','8','D','40','45',NULL,'Dependent Event Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EDSCPRUEXPZ0','8','D','40','46',NULL,'Dependent Marriage Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EDSCPRUEXPZ0','8','D','40','47',NULL,'Dependent Divorce Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EDSCPRUEXPZ0','32','D','40','48',NULL,'Dependent PreferenceID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EDSCPRUEXPZ0','25','D','40','49',NULL,'Dependent CorrespondenceTypeCode',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EDSCPRUEXPZ0','50','D','40','50',NULL,'Dependent Preferred Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EDSCPRUEXPZ0','32','D','40','51',NULL,'Dependent Preferred Language',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDSCPRUEXPZ0','3','T','90','1',NULL,'Record Type',NULL,NULL,'"TRL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDSCPRUEXPZ0','32','T','90','2',NULL,'Audit ID',NULL,NULL,'"drvAuditID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDSCPRUEXPZ0','9','T','90','3',NULL,'Absence Related Employment Information Record Quan',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDSCPRUEXPZ0','9','T','90','4',NULL,'Associate Record Quantity',NULL,NULL,'"drvAssociateRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDSCPRUEXPZ0','9','T','90','5',NULL,'Beneficiary Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDSCPRUEXPZ0','9','T','90','6',NULL,'Coverage Record Quantity',NULL,NULL,'"drvCoverageRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDSCPRUEXPZ0','9','T','90','7',NULL,'Dependent Record Quantity',NULL,NULL,'"drvDependentRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDSCPRUEXPZ0','9','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDSCPRUEXPZ0','9','T','90','9',NULL,'Employment Information Record Quantity',NULL,NULL,'"drvEmploymentInfoRecordQty"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDSCPRUEXPZ0','9','T','90','10',NULL,'Event Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDSCPRUEXPZ0','9','T','90','11',NULL,'Preference Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDSCPRUEXPZ0','9','T','90','12',NULL,'Custom Characteristics Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDSCPRUEXPZ0','17','T','90','13',NULL,'Total Coverage Amount',NULL,NULL,'"drvTotalCoverageAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDSCPRUEXPZ0','9','T','90','14',NULL,'Total Record Quantity',NULL,NULL,'"drvTotalRecordQuantity"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDSCPRUEXP_20221201.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202210219','EMPEXPORT','OEACTIVE',NULL,'EDSCPRUEXP',NULL,NULL,NULL,'202210219','Oct 21 2022  1:34PM','Oct 21 2022  1:34PM','202210211',NULL,'','','202210211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202210219','EMPEXPORT','OEPASSIVE',NULL,'EDSCPRUEXP',NULL,NULL,NULL,'202210219','Oct 21 2022  1:34PM','Oct 21 2022  1:34PM','202210211',NULL,'','','202210211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Life/Illness/Accide','202210219','EMPEXPORT','ONDEM_XOE',NULL,'EDSCPRUEXP',NULL,NULL,NULL,'202210219','Oct 21 2022  1:34PM','Oct 21 2022  1:34PM','202210211',NULL,'','','202210211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',U6X8D',NULL,NULL,NULL,'Prudential Life/Illness/-Sched','202210219','EMPEXPORT','SCH_EDSCPR',NULL,'EDSCPRUEXP',NULL,NULL,NULL,'202210219','Oct 21 2022  1:34PM','Oct 21 2022  1:34PM','202210211',NULL,'','','202210211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Prudential Life/Illness/-Test','202109309','EMPEXPORT','TEST_XOE','Nov 30 2022  6:41PM','EDSCPRUEXP',NULL,NULL,NULL,'202109309','Sep 30 2021 12:00AM','Dec 30 1899 12:00AM','202109011','9464','','','202109011',dbo.fn_GetTimedKey(),NULL,'us3kEpDCS1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSCPRUEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSCPRUEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSCPRUEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSCPRUEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSCPRUEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSCPRUEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDSCPRUEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSCPRUEXP','H01','dbo.U_EDSCPRUEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSCPRUEXP','D10','dbo.U_EDSCPRUEXP_drvTbl_AST',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSCPRUEXP','D20','dbo.U_EDSCPRUEXP_drvTbl_EMP',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSCPRUEXP','D30','dbo.U_EDSCPRUEXP_drvTbl_COV',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSCPRUEXP','D40','dbo.U_EDSCPRUEXP_drvTbl_DEP',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDSCPRUEXP','T90','dbo.U_EDSCPRUEXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EDSCPRUEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EDSCPRUEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDSCPRUEXP] (
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
-- Create table U_EDSCPRUEXP_Audit
-----------

IF OBJECT_ID('U_EDSCPRUEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_Audit] (
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
-- Create table U_EDSCPRUEXP_AuditFields
-----------

IF OBJECT_ID('U_EDSCPRUEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EDSCPRUEXP_DedList
-----------

IF OBJECT_ID('U_EDSCPRUEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EDSCPRUEXP_drvTbl_AST
-----------

IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_AST') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_drvTbl_AST] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvClientControlNumber] varchar(5) NOT NULL,
    [drvAssociateID] char(9) NULL,
    [drvAssociateSSN] char(11) NULL,
    [drvAssociateGenderCode] varchar(7) NOT NULL,
    [drvAssociateDateofBirth] varchar(8) NULL,
    [drvAssociateMaritalStatusCode] varchar(8) NOT NULL,
    [drvAssociateLastName] varchar(100) NULL,
    [drvAssociateFirstName] varchar(100) NULL,
    [drvAssociateMiddleName] varchar(1) NULL,
    [drvAssociateAddressTypeCode1] varchar(4) NOT NULL,
    [drvAssociateAddressLine1Text1] varchar(255) NULL,
    [drvAssociateAddressLine2Text1] varchar(255) NULL,
    [drvAssociateCityName1] varchar(255) NULL,
    [drvAssociateState1] varchar(255) NULL,
    [drvAssociatePostalCode1] varchar(50) NULL,
    [drvAssociateCountryCode1] varchar(3) NOT NULL,
    [drvAssociateTelephoneType1] varchar(4) NOT NULL,
    [drvAssociateTelephoneNumber1] varchar(50) NULL,
    [drvTelephoneTypeCode2] varchar(6) NOT NULL,
    [drvAssociateTelephoneNumber2] varchar(50) NULL,
    [drvAssociateEmailAddressType2] varchar(8) NOT NULL,
    [drvAssociateEmailAddressText2] varchar(50) NULL
);

-----------
-- Create table U_EDSCPRUEXP_drvTbl_COV
-----------

IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_COV') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_drvTbl_COV] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvClientControlNumber] varchar(5) NOT NULL,
    [drvAssociateID] char(9) NULL,
    [drvProductCode] varchar(4) NULL,
    [drvCoverageTierCode] varchar(2) NULL,
    [drvProductPlanCode] varchar(4) NULL,
    [drvCoverageAmount] nvarchar(4000) NULL,
    [drvCoverageEffectiveDate] varchar(8) NULL,
    [drvCoverageEndDate] varchar(8) NULL,
    [drvCoverageStatusCode] varchar(10) NULL,
    [drvCoverageStatusEffDate] varchar(8) NULL,
    [drvCoverageTermReductionCode] varchar(11) NULL,
    [drvVoluntaryBasis] varchar(9) NULL
);

-----------
-- Create table U_EDSCPRUEXP_drvTbl_DEP
-----------

IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_DEP') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_drvTbl_DEP] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvClientControlNumber] varchar(5) NOT NULL,
    [drvAssociateID] varchar(9) NULL,
    [drvDependentID] nvarchar(4000) NULL,
    [drvDepRelationshipCode] varchar(16) NULL,
    [drvDepSSN] char(11) NULL,
    [drvDepGender] varchar(7) NOT NULL,
    [drvDepDateOfBirth] varchar(8) NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepMiddleName] varchar(1) NULL
);

-----------
-- Create table U_EDSCPRUEXP_drvTbl_EMP
-----------

IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_EMP') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_drvTbl_EMP] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvClientControlNumber] varchar(5) NOT NULL,
    [drvAssociateID] char(9) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvHireDate] varchar(8) NULL,
    [drvRehireDate] varchar(8) NULL,
    [drvRetirementDate] varchar(8) NULL,
    [drvEmploymentTerminationDate] varchar(8) NULL,
    [drvEmploymentTermReasonCode] varchar(10) NULL,
    [drvAdjustedServiceDate] varchar(8) NULL,
    [drvEmploymentStatusCode] varchar(16) NOT NULL,
    [drvEmploymentStatusEffDate] varchar(8) NULL,
    [drvJobTitleText] char(8) NOT NULL,
    [drvWorkStatusCode] varchar(9) NULL,
    [drvEarningsTypeCode1] varchar(8) NOT NULL,
    [drvEarningsAmount1] money NULL,
    [drvEarningsFrequencyCode1] varchar(6) NOT NULL,
    [drvEarningsEffectiveDate1] varchar(8) NULL,
    [drvWorkLocationStateCode] varchar(255) NULL
);

-----------
-- Create table U_EDSCPRUEXP_EEList
-----------

IF OBJECT_ID('U_EDSCPRUEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDSCPRUEXP_File
-----------

IF OBJECT_ID('U_EDSCPRUEXP_File') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EDSCPRUEXP_Header
-----------

IF OBJECT_ID('U_EDSCPRUEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_Header] (
    [drvCreationDateTime] nvarchar(4000) NULL,
    [drvClientControlNumber] varchar(5) NOT NULL,
    [drvClientName] varchar(8) NOT NULL,
    [drvSchemaVersionIdentifier] varchar(3) NOT NULL,
    [drvSenderName] varchar(8) NOT NULL,
    [drvSenderPlatformName] varchar(3) NOT NULL,
    [drvTestProductionCode] varchar(10) NOT NULL,
    [drvTransmissionTypeCode] varchar(9) NOT NULL,
    [drvActivityStartDateTime] varchar(8) NULL,
    [drvActivityEndDateTime] varchar(36) NULL
);

-----------
-- Create table U_EDSCPRUEXP_Trailer
-----------

IF OBJECT_ID('U_EDSCPRUEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EDSCPRUEXP_Trailer] (
    [drvAuditID] varchar(8) NULL,
    [drvAssociateRecordQuantity] nvarchar(4000) NULL,
    [drvCoverageRecordQuantity] nvarchar(4000) NULL,
    [drvDependentRecordQuantity] nvarchar(4000) NULL,
    [drvEmploymentInfoRecordQty] nvarchar(4000) NULL,
    [drvTotalCoverageAmount] money NULL,
    [drvTotalRecordQuantity] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDSCPRUEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: DCS Corporation

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 10/21/2022
Service Request Number: TekP-2022-08-23-001

Purpose: Prudential Life/Illness/Accident/Hospital Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDSCPRUEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDSCPRUEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDSCPRUEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDSCPRUEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDSCPRUEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSCPRUEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSCPRUEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSCPRUEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSCPRUEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDSCPRUEXP', 'SCH_EDSCPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDSCPRUEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EDSCPRUEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EDSCPRUEXP';
    SELECT @FileMinCovDate = '1/1/2023';

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
    DELETE FROM dbo.U_EDSCPRUEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDSCPRUEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EDSCPRUEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EDSCPRUEXP_AuditFields;
    CREATE TABLE dbo.U_EDSCPRUEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
     INSERT INTO dbo.U_EDSCPRUEXP_AuditFields VALUES ('EmpComp','EecDateofTermination');
     INSERT INTO dbo.U_EDSCPRUEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EDSCPRUEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EDSCPRUEXP_Audit;
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
    INTO dbo.U_EDSCPRUEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EDSCPRUEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EDSCPRUEXP_Audit ON dbo.U_EDSCPRUEXP_Audit (audEEID,audKey2);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EDSCPRUEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EDSCPRUEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ACCHI,ACCLO,CR10E,CR30E,CRITE,CR10S,CR30S,CRITS,CR10C,CR30C,CRITC,CR10F,CR30F,CRITF,GLIFC,GLIFE,GLIFX.HOSHI,HOSLO,LIFE1,LIFE2,LIFE3,LIFE4,LIFE5,,LIFE6,LIFEC,LIFES,ACCHI,ACCHI'; -- Client removed these CIC10,CIC15,CIC5,CIE10,CIE20,CIE30,CIS10,CIS15,CIS5

    IF OBJECT_ID('U_EDSCPRUEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDSCPRUEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDSCPRUEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');



    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS, DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','DIS, CHL, DPC, STC');

    

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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDSCPRUEXP_drvTbl_AST
    ---------------------------------
    IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_AST','U') IS NOT NULL
        DROP TABLE dbo.U_EDSCPRUEXP_drvTbl_AST;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2-' + eepSSN
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvClientControlNumber = '47449'
        ,drvAssociateID = EecEmpNo
        ,drvAssociateSSN = eepSSN
        ,drvAssociateGenderCode = CASE WHEN EepGender = 'F' THEN 'FEMALE'
                                        WHEN EepGender = 'M' THEN 'MALE'
                                        ELSE 'UNKNOWN'
                                    END
        ,drvAssociateDateofBirth = CONVERT(VARCHAR(8),EepDateOfBirth,112)
        ,drvAssociateMaritalStatusCode = CASE WHEN EepMaritalStatus = 'S' THEN 'SINGLE'
                                            WHEN EepMaritalStatus = 'M' THEN 'MARRIED'
                                            WHEN EepMaritalStatus = 'D' THEN 'DIVORCED'
                                            WHEN EepMaritalStatus = 'W' THEN 'WIDOWED'
                                            ELSE 'UNKNOWN'
                                        END
        ,drvAssociateLastName = EepNameLast
        ,drvAssociateFirstName = EepNameFirst
        ,drvAssociateMiddleName = LEFT(EepNameMiddle,1)
        ,drvAssociateAddressTypeCode1 = 'HOME'
        ,drvAssociateAddressLine1Text1 = EepAddressLine1
        ,drvAssociateAddressLine2Text1 = EepAddressLine2
        ,drvAssociateCityName1 = EepAddressCity
        ,drvAssociateState1 = EepAddressState
        ,drvAssociatePostalCode1 = CASE WHEN len(EepAddressZipCode) > 5 THEN substring(EepAddressZipCode,1,5) + '-' + substring(EepAddressZipCode,6,4)   
                                    ELSE EepAddressZipCode   
                                END
        ,drvAssociateCountryCode1 = 'USA'
        ,drvAssociateTelephoneType1 = CASE WHEN ISNULL(eepPhoneHomeNumber, '') <> '' THEN 'HOME' ELSE '' END
        ,drvAssociateTelephoneNumber1 = eepPhoneHomeNumber
        ,drvTelephoneTypeCode2 =  CASE WHEN ISNULL(efoPhoneNumber, '') <> '' THEN 'MOBILE' ELSE '' END
        ,drvAssociateTelephoneNumber2 = efoPhoneNumber
        ----,drvAssociateEmailAddressType1 = CASE WHEN ISNULL(EepAddressEMail, '') <> '' THEN 'PERSONAL' ELSE '' END
        ----,drvAssociateEmailAddressText1 = EepAddressEMail
        ,drvAssociateEmailAddressType2 =  CASE WHEN ISNULL(eepAddressEMailAlternate, '') <> '' THEN 'PERSONAL' ELSE '' END
        ,drvAssociateEmailAddressText2 = eepAddressEMailAlternate
    INTO dbo.U_EDSCPRUEXP_drvTbl_AST
    FROM dbo.U_EDSCPRUEXP_EEList WITH (NOLOCK)
     JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDSCPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
       LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN 
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
             ON EfoEEID = xEEID
    LEFT JOIN  dbo.U_EDSCPRUEXP_Audit WITH (NOLOCK)
        ON xEEID = audEEID
        and xcoid = audKey2
     WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)
    ;
    
    ---------------------------------
    -- DETAIL RECORD - U_EDSCPRUEXP_EMP_drvTbl_EMP
    ---------------------------------
    IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_EMP','U') IS NOT NULL
        DROP TABLE dbo.U_EDSCPRUEXP_drvTbl_EMP;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
         ,drvInitialSort = '2-' + eepSSN
        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvClientControlNumber = '47449'
        ,drvAssociateID = EecEmpNo
        ,drvEmployeeID = EecEmpNo
        ,drvHireDate = CONVERT(VARCHAR(8),EecDateOfOriginalHire, 112)
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire AND (EecJobChangeReason = '101' OR EecHireSource = 'REHIRE') THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112) END
        ,drvRetirementDate = CASE WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','RET') THEN CONVERT(VARCHAR(8),EecDateOfTermination,112) END
        ,drvEmploymentTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN CONVERT(VARCHAR(8),EecDateOfTermination,112) END
        ,drvEmploymentTermReasonCode = CASE WHEN  EecEmplStatus = 'T' AND  EecTermReason IN ('202','RET') THEN 'RETIRED'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DECEASED'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN  ('202','RET','203') THEN 'TERMINATED'
                                      
                                    END
        ,drvAdjustedServiceDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112) END
        ,drvEmploymentStatusCode = CASE WHEN  EecEmplStatus = 'T' AND  EecTermReason IN ('202','RET') THEN 'RETIRED'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DECEASED'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN  ('202','RET','203') THEN 'TERMINATED'
                                        WHEN EecEmplStatus = 'L' THEN 'LEAVE OF ABSENCE'
                                        ELSE 'ACTIVE'
                                    END
        ,drvEmploymentStatusEffDate = CONVERT(VARCHAR(8),EecEmplStatusStartDate, 112)
        ,drvJobTitleText =JbcJobCode
        ,drvWorkStatusCode = CASE WHEN EecFulltimeorParttime = 'F' THEN 'FULL TIME'  
                                  WHEN  EecFulltimeorParttime = 'P' THEN 'PART TIME'
                                END
        ,drvEarningsTypeCode1 = 'BASE PAY'
        ,drvEarningsAmount1 = EecAnnSalary
        ,drvEarningsFrequencyCode1 = 'ANNUAL'
        ,drvEarningsEffectiveDate1 = CONVERT(VARCHAR(8),dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire),112)
        ,drvWorkLocationStateCode = LOCAddressState
    INTO dbo.U_EDSCPRUEXP_drvTbl_EMP
    FROM dbo.U_EDSCPRUEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDSCPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN  dbo.U_EDSCPRUEXP_Audit WITH (NOLOCK)
        ON xEEID = audEEID
        and xcoid = audKey2
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)
    ;

  
    ---------------------------------
    -- DETAIL RECORD - U_EDSCPRUEXP_drvTbl_COV
    ---------------------------------
    IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_COV','U') IS NOT NULL
        DROP TABLE dbo.U_EDSCPRUEXP_drvTbl_COV;
    SELECT DISTINCT a.* 
     INTO dbo.U_EDSCPRUEXP_drvTbl_COV  
     FROM (
         SELECT DISTINCT
             drvEEID = xEEID
            ,drvCoID = xCoID
            ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
            ,drvInitialSort = '2-' + eepSSN
            ,drvSubSort = '4'
            -- standard fields above and additional driver fields below
            ,drvClientControlNumber = '47449'
            ,drvAssociateID = EecEmpNo
            ,drvProductCode = CASE -- WHEN BdmDedCode IN ('GLIFE','GLIFC','GLIFX') THEN 'BGL' 
                                    --WHEN BdmDedCode IN ('LIFE1','LIFE2','LIFE3','LIFE4','LIFE5','LIFE6') THEN 'OGL'
                                    --WHEN Bdmdedcode IN  ('LIFES','LIFEC') THEN 'ODGL'
                                    WHEN Bdmdedcode IN  ('GLIFE','GLIFC','GLIFX') THEN 'BADD'
                                    --WHEN Bdmdedcode IN  ('ACCHI','ACCLO') THEN 'VACC' 
                                    --WHEN Bdmdedcode IN ('HOSHI','HOSLO') THEN 'VHIP'
                                    --WHEN Bdmdedcode IN ('CR30C','CR30E','CR30F','CR30S','CR10C','CR10E','CR10F','CR10S','CRITC','CRITE','CRITF','CRITS') THEN 'VCI'

                                END
                        
            ,drvCoverageTierCode = CASE WHEN BdmDedCode IN ('GLIFE','GLIFC','GLIFX') THEN 'EE' 
                                        --WHEN BdmDedCode IN ('CR10E','CR30E','CRITE') THEN 'EE'
             --                           WHEN BdmDedCode IN ('LIFES','CR10S','CR30S','CRITS') THEN 'SP' --AND BdmBenOption = 'EES'
             --                           WHEN BdmDedCode IN ('LIFEC','CR10C','CR30C','CRITC') THEN 'CH' --AND BdmBenOption = 'EEC'
                                        --WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EE' THEN 'EE'
             --                           WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EES' THEN 'ES'
             --                           WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EEC' THEN 'EC'
             --                           WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EEF' THEN 'FM' --AND BdmBenOption = 'EEF'
                                        --WHEN BdmDedCode IN ('CR10F','CR30F','CRITF') THEN 'FM'
                                    END
            ,drvProductPlanCode = ''
                                    --CASE WHEN BdmDedCode IN ('CR30C','CR30E','CR30F','CR30S','CR10C','CR10E','CR10F','CR10S','CRITC','CRITE','CRITF','CRITS') THEN '6166'
            --                            WHEN BdmDedCode IN ('ACCHI') THEN '6162'
            --                            WHEN BdmDedCode IN ('ACCLO') THEN '6163'
            --                            WHEN Bdmdedcode IN ('HOSHI') THEN '6164'
            --                            WHEN Bdmdedcode IN ('HOSLO') THEN '6165'
            --                        END
            
            ,drvCoverageAmount =   FORMAT(CASE WHEN BdmDedCode IN ('GLIFE','GLIFC','GLIFX') AND BdmBenStatus = 'T' THEN EedBenAmt
                                              -- WHEN eedDedCode IN ('CR10E','CR30E','CRITE') and EedBenAmt Between  10000.00 AND  30000.00 THEN EedBenAmt
                                              -- WHEN eedDedCode IN ('CR10S','CR30S','CRITS') and EedBenAmt between 5000.00 AND 15000.00 THEN EedBenAmt
                                              -- WHEN eedDedCode IN ('CR10C','CR30C','CRITC') and EedBenAmt Between 5000.00 AND 15000.00 THEN EedBenAmt
                                              END , '0.00') 
            ,drvCoverageEffectiveDate = CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate), 112)
            ,drvCoverageEndDate = CONVERT(VARCHAR(8),BdmBenStopDate, 112)
            ,drvCoverageStatusCode = CASE WHEN  BdmBenStatus = 'A' THEN 'ACTIVE' 
                                          WHEN  BdmBenStatus = 'T' THEN 'TERMINATED'
                                        END
            ,drvCoverageStatusEffDate = CONVERT(VARCHAR(8),BdmBenStartDate, 112)
            ,drvCoverageTermReductionCode  = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                                  WHEN Bdmbenstatus = 'T' and EecTermType = 'V' THEN 'CANCELLED'
                                                  WHEN Bdmbenstatus = 'T' and EecTermType = 'I' THEN 'INVOLUNTARY'
                                                 -- WHEN BdmChangeReason = '204' THEN 'DIVORCE' 
                                                  WHEN BdmChangeReason = '204' AND Bdmdedcode NOT IN ('ACCHI','ACCLO') THEN 'DIVORCE'
                                                  WHEN BdmChangeReason = '201' THEN 'AGE'
                                                END
            ,drvVoluntaryBasis = ''--CASE WHEN Bdmdedcode IN  ('ACCHI','ACCLO') THEN 'TREATMENT' END
       -- INTO dbo.U_EDSCPRUEXP_drvTbl_COV
        FROM dbo.U_EDSCPRUEXP_EEList WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EDSCPRUEXP WITH (NOLOCK)
            ON BdmEEID = xEEID 
           AND BdmCoID = xCoID
        JOIN dbo.EmpDed WITH(NOLOCK)
            ON EedEEID = xEEID
            AND EedDedCode = BdmDedCode
         JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
            ON EecEEID = xEEID 
            AND EecCoID = xCoID
         JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
         LEFT JOIN  dbo.U_EDSCPRUEXP_Audit WITH (NOLOCK)
            ON xEEID = audEEID
            and xcoid = audKey2
         WHERE BdmDedCode IN ('GLIFE','GLIFC','GLIFX')
       and EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)

    Union

     SELECT DISTINCT
             drvEEID = xEEID
            ,drvCoID = xCoID
            ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
            ,drvInitialSort = '2-' + eepSSN
            ,drvSubSort = '4'
            -- standard fields above and additional driver fields below
            ,drvClientControlNumber = '47449'
            ,drvAssociateID = EecEmpNo
            ,drvProductCode = CASE WHEN BdmDedCode IN ('GLIFE','GLIFC','GLIFX') THEN 'BGL' 
                                    WHEN BdmDedCode IN ('LIFE1','LIFE2','LIFE3','LIFE4','LIFE5','LIFE6') THEN 'OGL'
                                    WHEN Bdmdedcode IN  ('LIFES','LIFEC') THEN 'ODGL'
                                    WHEN Bdmdedcode IN  ('GLIFE','GLIFC','GLIFX') THEN 'BADD'
                                    WHEN Bdmdedcode IN  ('ACCHI','ACCLO') THEN 'VACC' 
                                    WHEN Bdmdedcode IN ('HOSHI','HOSLO') THEN 'VHIP'
                                    WHEN Bdmdedcode IN ('CR30C','CR30E','CR30F','CR30S','CR10C','CR10E','CR10F','CR10S','CRITC','CRITE','CRITF','CRITS') THEN 'VCI'

                                END
                        
            ,drvCoverageTierCode = CASE WHEN BdmDedCode IN ('GLIFE','GLIFC','GLIFX','LIFE1','LIFE2','LIFE3','LIFE4','LIFE5','LIFE6','CR10E','CR30E','CRITE') THEN 'EE' 
                                        --WHEN BdmDedCode IN ('CR10E','CR30E','CRITE') THEN 'EE'
                                        WHEN BdmDedCode IN ('LIFES','CR10S','CR30S','CRITS') THEN 'SP' --AND BdmBenOption = 'EES'
                                        WHEN BdmDedCode IN ('LIFEC','CR10C','CR30C','CRITC') THEN 'CH' --AND BdmBenOption = 'EEC'
                                        WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EE' THEN 'EE'
                                        WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EES' THEN 'ES'
                                        WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EEC' THEN 'EC'
                                        WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EEF' THEN 'FM' --AND BdmBenOption = 'EEF'
                                        WHEN BdmDedCode IN ('CR10F','CR30F','CRITF') THEN 'FM'
                                    END
            ,drvProductPlanCode = CASE WHEN BdmDedCode IN ('CR30C','CR30E','CR30F','CR30S','CR10C','CR10E','CR10F','CR10S','CRITC','CRITE','CRITF','CRITS') THEN '6166'
                                        WHEN BdmDedCode IN ('ACCHI') THEN '6162'
                                        WHEN BdmDedCode IN ('ACCLO') THEN '6163'
                                        WHEN Bdmdedcode IN ('HOSHI') THEN '6164'
                                        WHEN Bdmdedcode IN ('HOSLO') THEN '6165'
                                    END
            
            ,drvCoverageAmount =   FORMAT(CASE WHEN eedDedCode IN ('GLIFE','GLIFC','GLIFX','LIFE1','LIFE2','LIFE3','LIFE4','LIFE5','LIFE6','LIFES','LIFEC') AND BdmBenStatus = 'T' THEN EedBenAmt
                                               WHEN eedDedCode IN ('CR10E','CR30E','CRITE') and EedBenAmt Between  10000.00 AND  30000.00 THEN EedBenAmt
                                               WHEN eedDedCode IN ('CR10S','CR30S','CRITS') and EedBenAmt between 5000.00 AND 15000.00 THEN EedBenAmt
                                               WHEN eedDedCode IN ('CR10C','CR30C','CRITC') and EedBenAmt Between 5000.00 AND 15000.00 THEN EedBenAmt
                                              END , '0.00') 
            ,drvCoverageEffectiveDate = CONVERT(VARCHAR(8),BdmBenStartDate, 112)
            ,drvCoverageEndDate = CONVERT(VARCHAR(8),BdmBenStopDate, 112)
            ,drvCoverageStatusCode = CASE WHEN  BdmBenStatus = 'A' THEN 'ACTIVE' 
                                          WHEN  BdmBenStatus = 'T' THEN 'TERMINATED'
                                        END
            ,drvCoverageStatusEffDate = CONVERT(VARCHAR(8),dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate), 112)
            ,drvCoverageTermReductionCode  = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                                  WHEN Bdmbenstatus = 'T' and EecTermType = 'V' THEN 'CANCELLED'
                                                  WHEN Bdmbenstatus = 'T' and EecTermType = 'I' THEN 'INVOLUNTARY'
                                                 -- WHEN BdmChangeReason = '204' THEN 'DIVORCE' 
                                                  WHEN BdmChangeReason = '204' AND Bdmdedcode NOT IN ('ACCHI','ACCLO') THEN 'DIVORCE'
                                                  WHEN BdmChangeReason = '201' THEN 'AGE'
                                                END
            ,drvVoluntaryBasis = CASE WHEN Bdmdedcode IN  ('ACCHI','ACCLO') THEN 'TREATMENT' END
   
        FROM dbo.U_EDSCPRUEXP_EEList WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_EDSCPRUEXP WITH (NOLOCK)
            ON BdmEEID = xEEID 
           AND BdmCoID = xCoID
        JOIN dbo.EmpDed WITH(NOLOCK)
            ON EedEEID = xEEID
            AND EedDedCode = BdmDedCode
         JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
            ON EecEEID = xEEID 
            AND EecCoID = xCoID
         JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
         LEFT JOIN  dbo.U_EDSCPRUEXP_Audit WITH (NOLOCK)
            ON xEEID = audEEID
            and xcoid = audKey2
         WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)
        ) a


 --  SELECT DISTINCT
 --        drvEEID = xEEID
 --       ,drvCoID = xCoID
 --       ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
 --       ,drvInitialSort = '2-' + eepSSN
 --       ,drvSubSort = '4'
 --       -- standard fields above and additional driver fields below
 --       ,drvClientControlNumber = '47449'
 --       ,drvAssociateID = EecEmpNo
 --       ,drvProductCode = CASE WHEN BdmDedCode IN ('GLIFE','GLIFC','GLIFX') THEN 'BGL' 
 --                               WHEN BdmDedCode IN ('LIFE1','LIFE2','LIFE3','LIFE4','LIFE5','LIFE6') THEN 'OGL'
 --                               WHEN Bdmdedcode IN  ('LIFES','LIFEC') THEN 'ODGL'
 --                               WHEN Bdmdedcode IN  ('GLIFE','GLIFC','GLIFX') THEN 'BADD'
 --                               WHEN Bdmdedcode IN  ('ACCHI','ACCLO') THEN 'VACC' 
 --                               WHEN Bdmdedcode IN ('HOSHI','HOSLO') THEN 'VHIP'
 --                               WHEN Bdmdedcode IN ('CR30C','CR30E','CR30F','CR30S','CR10C','CR10E','CR10F','CR10S','CRITC','CRITE','CRITF','CRITS') THEN 'VCI'

 --                           END
                        
 --       ,drvCoverageTierCode = CASE WHEN BdmDedCode IN ('GLIFE','GLIFC','GLIFX','LIFE1','LIFE2','LIFE3','LIFE4','LIFE5','LIFE6','CR10E','CR30E','CRITE') THEN 'EE' 
    --                                --WHEN BdmDedCode IN ('CR10E','CR30E','CRITE') THEN 'EE'
 --                                   WHEN BdmDedCode IN ('LIFES','CR10S','CR30S','CRITS') THEN 'SP' --AND BdmBenOption = 'EES'
 --                                   WHEN BdmDedCode IN ('LIFEC','CR10C','CR30C','CRITC') THEN 'CH' --AND BdmBenOption = 'EEC'
    --                                WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EE' THEN 'EE'
 --                                   WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EES' THEN 'ES'
 --                                   WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EEC' THEN 'EC'
 --                                   WHEN BdmDedCode IN ('ACCHI','ACCLO','HOSHI','HOSLO') AND BdmBenOption = 'EEF' THEN 'FM' --AND BdmBenOption = 'EEF'
    --                                WHEN BdmDedCode IN ('CR10F','CR30F','CRITF') THEN 'FM'
 --                               END
 --       ,drvProductPlanCode = CASE WHEN BdmDedCode IN ('CR30C','CR30E','CR30F','CR30S','CR10C','CR10E','CR10F','CR10S','CRITC','CRITE','CRITF','CRITS') THEN '6166'
 --                                   WHEN BdmDedCode IN ('ACCHI') THEN '6162'
 --                                   WHEN BdmDedCode IN ('ACCLO') THEN '6163'
 --                                   WHEN Bdmdedcode IN ('HOSHI') THEN '6164'
 --                                   WHEN Bdmdedcode IN ('HOSLO') THEN '6165'
 --                               END
            
 --       ,drvCoverageAmount =   FORMAT(CASE WHEN eedDedCode IN ('GLIFE','GLIFC','GLIFX','LIFE1','LIFE2','LIFE3','LIFE4','LIFE5','LIFE6','LIFES','LIFEC') AND BdmBenStatus = 'T' THEN EedBenAmt
 --                                          WHEN eedDedCode IN ('CR10E','CR30E','CRITE') and EedBenAmt Between  10000.00 AND  30000.00 THEN EedBenAmt
 --                                          WHEN eedDedCode IN ('CR10S','CR30S','CRITS') and EedBenAmt between 5000.00 AND 15000.00 THEN EedBenAmt
 --                                          WHEN eedDedCode IN ('CR10C','CR30C','CRITC') and EedBenAmt Between 5000.00 AND 15000.00 THEN EedBenAmt
 --                                         END , '0.00') 
 --       ,drvCoverageEffectiveDate = CONVERT(VARCHAR(8),BdmBenStartDate, 112)
 --       ,drvCoverageEndDate = CONVERT(VARCHAR(8),BdmBenStopDate, 112)
 --       ,drvCoverageStatusCode = CASE WHEN  BdmBenStatus = 'A' THEN 'ACTIVE' 
 --                                     WHEN  BdmBenStatus = 'T' THEN 'TERMINATED'
 --                                   END
 --       ,drvCoverageStatusEffDate = CONVERT(VARCHAR(8),BdmBenStartDate, 112)
 --       ,drvCoverageTermReductionCode  = CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
    --                                          WHEN Bdmbenstatus = 'T' and EecTermType = 'V' THEN 'CANCELLED'
    --                                          WHEN Bdmbenstatus = 'T' and EecTermType = 'I' THEN 'INVOLUNTARY'
    --                                         -- WHEN BdmChangeReason = '204' THEN 'DIVORCE' 
    --                                          WHEN BdmChangeReason = '204' AND Bdmdedcode <> ('ACCHI','ACCLO') THEN 'DIVORCE'
    --                                          WHEN BdmChangeReason = '201' THEN 'AGE'
    --                                        END
 --       ,drvVoluntaryBasis = CASE WHEN Bdmdedcode IN  ('ACCHI','ACCLO') THEN 'TREATMENT' END
 --   INTO dbo.U_EDSCPRUEXP_drvTbl_COV
 --   FROM dbo.U_EDSCPRUEXP_EEList WITH (NOLOCK)
 --   JOIN dbo.U_dsi_BDM_EDSCPRUEXP WITH (NOLOCK)
 --       ON BdmEEID = xEEID 
 --      AND BdmCoID = xCoID
    --JOIN dbo.EmpDed WITH(NOLOCK)
 --       ON EedEEID = xEEID
 --       AND EedDedCode = BdmDedCode
 --    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
 --       ON EecEEID = xEEID 
 --       AND EecCoID = xCoID
 --    JOIN dbo.EmpPers WITH (NOLOCK)
 --       ON EepEEID = xEEID
 --    LEFT JOIN  dbo.U_EDSCPRUEXP_Audit WITH (NOLOCK)
 --       ON xEEID = audEEID
 --       and xcoid = audKey2
 --     WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)
 --   ;
   
    ---------------------------------
    -- DETAIL RECORD - U_EDSCPRUEXP_drvTbl_DEP
    ---------------------------------
    IF OBJECT_ID('U_EDSCPRUEXP_drvTbl_DEP','U') IS NOT NULL
        DROP TABLE dbo.U_EDSCPRUEXP_drvTbl_DEP;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
         ,drvInitialSort = '2-' + eepSSN
        ,drvSubSort = '5'
        -- standard fields above and additional driver fields below
        ,drvClientControlNumber = '47449'
        ,drvAssociateID = RTRIM(EecEmpNo)
        ,drvDependentID = RTRIM(EecEmpNo) + FORMAT(ConDepNo, '00')
        ,drvDepRelationshipCode = CASE WHEN ConRelationship IN ('DP') THEN 'DOMESTIC PARTNER'
                                        WHEN ConRelationship IN ('SPS') THEN 'SPOUSE'
                                        WHEN ConRelationship IN ('ACH','CHL','STC') THEN 'CHILD'
                                    END
        ,drvDepSSN = ConSSN
        ,drvDepGender = CASE WHEN ConGender = 'F' THEN 'FEMALE'
                                        WHEN ConGender = 'M' THEN 'MALE'
                                        ELSE 'UNKNOWN'
                                    END
        ,drvDepDateOfBirth = CONVERT(VARCHAR(8),ConDateOfBirth,112)
        ,drvDepLastName = ConNameLast
        ,drvDepFirstName = ConNameFirst
        ,drvDepMiddleName = LEFT(ConNameMiddle,1)
    INTO dbo.U_EDSCPRUEXP_drvTbl_DEP
    FROM dbo.U_EDSCPRUEXP_EEList WITH (NOLOCK)
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EDSCPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN (
            SELECT DISTINCT ConEEID
                ,ConSystemID
                ,ConNameFirst
                ,ConNameMiddle
                ,ConNameLast
                ,ConRelationship
                ,ConSSN
                ,ConAddressLine1
                ,ConAddressLIne2
                ,ConAddressCity
                ,ConAddressState
                ,ConAddressZipCode
                ,ConGender 
                ,ConDateOfBirth 
                ,ConDeathDate
                ,ConIsSmoker
                ,ConNameSuffix
                ,ConIsDisabled
                ,ConDepNo = ROW_NUMBER() OVER (PARTITION BY RTRIM(ConEEID) ORDER BY CONVERT(VARCHAR(8),conDateOfBirth,112) ASC) + 1
              FROM dbo.Contacts WITH (NOLOCK)
              JOIN (
                        SELECT DISTINCT BdmEEID, BdmDepRecID
                        FROM dbo.U_dsi_BDM_EDSCPRUEXP WITH (NOLOCK)) AS SpsChld
                ON ConEEID = BdmEEID
                AND ConSystemID = BdmDepRecId
             WHERE ConRelationship IN ('CH','CHL','DPC','STC')             
            UNION
            SELECT DISTINCT ConEEID
                ,ConSystemID
                ,ConNameFirst
                ,ConNameMiddle
                ,ConNameLast
                ,ConRelationship
                ,ConSSN 
                ,ConAddressLine1
                ,ConAddressLIne2
                ,ConAddressCity
                ,ConAddressState
                ,ConAddressZipCode
                ,ConGender 
                ,ConDateOfBirth 
                ,ConDeathDate
                ,ConIsSmoker
                ,ConNameSuffix
                ,ConIsDisabled
                ,ConDepNo = 1
              FROM dbo.Contacts WITH (NOLOCK)
              JOIN (
                        SELECT DISTINCT BdmEEID, BdmDepRecID
                        FROM dbo.U_dsi_BDM_EDSCPRUEXP WITH (NOLOCK)) AS BdmChld
                ON ConEEID = BdmEEID
                AND ConSystemID = BdmDepRecId
             WHERE ConRelationship IN ('SPS','DP')) AS Con
            ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
     LEFT JOIN  dbo.U_EDSCPRUEXP_Audit WITH (NOLOCK)
        ON xEEID = audEEID
        and xcoid = audKey2
      WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)
 
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
        IF OBJECT_ID('U_EDSCPRUEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDSCPRUEXP_Header;
    SELECT DISTINCT
         drvCreationDateTime = FORMAT(GETDATE(),'yyyyMMddHHmmss')
        ,drvClientControlNumber = '47449'
        ,drvClientName = 'DCS Corp'
        ,drvSchemaVersionIdentifier = '1.0'
        ,drvSenderName = 'DCS Corp'
        ,drvSenderPlatformName = 'UKG'
        ,drvTestProductionCode = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'Test' ELSE 'Production' END
        ,drvTransmissionTypeCode = 'FULL FILE'
        ,drvActivityStartDateTime = CONVERT(VARCHAR(8),DATEADD(d, -6,Getdate()),112)
        ,drvActivityEndDateTime =  CONVERT(VARCHAR,Getdate(),112) + LEFT(REPLACE(CONVERT(VARCHAR,Getdate(),114),':',''),6)
    INTO dbo.U_EDSCPRUEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDSCPRUEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDSCPRUEXP_Trailer;
    SELECT DISTINCT
         drvAuditID = CONVERT(VARCHAR(8),DATEADD(d, -6,Getdate()),112)
        ,drvAssociateRecordQuantity = FORMAT((SELECT COUNT(*) FROM dbo.U_EDSCPRUEXP_drvTbl_AST), '#0')
        ,drvCoverageRecordQuantity = FORMAT((SELECT COUNT(*) FROM dbo.U_EDSCPRUEXP_drvTbl_COV), '#0')
        ,drvDependentRecordQuantity = FORMAT((SELECT COUNT(*) FROM dbo.U_EDSCPRUEXP_drvTbl_DEP), '#0')
        ,drvEmploymentInfoRecordQty = FORMAT((SELECT COUNT(*) FROM dbo.U_EDSCPRUEXP_drvTbl_EMP), '#0')
        ,drvTotalCoverageAmount = (SELECT SUM(CAST(drvCoverageAmount AS MONEY)) FROM dbo.U_EDSCPRUEXP_drvTbl_COV)
        ,drvTotalRecordQuantity = FORMAT(
                                            (SELECT COUNT(*) FROM dbo.U_EDSCPRUEXP_drvTbl_AST)
                                            + (SELECT COUNT(*) FROM dbo.U_EDSCPRUEXP_drvTbl_COV)
                                            + (SELECT COUNT(*) FROM dbo.U_EDSCPRUEXP_drvTbl_DEP)
                                            + (SELECT COUNT(*) FROM dbo.U_EDSCPRUEXP_drvTbl_EMP)
                                    , '#0')
    INTO dbo.U_EDSCPRUEXP_Trailer
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
ALTER VIEW dbo.dsi_vwEDSCPRUEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDSCPRUEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EDSCPRUEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110141'
       ,expStartPerControl     = '202110141'
       ,expLastEndPerControl   = '202210219'
       ,expEndPerControl       = '202210219'
WHERE expFormatCode = 'EDSCPRUEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDSCPRUEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDSCPRUEXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDSCPRUEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDSCPRUEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDSCPRUEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDSCPRUEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDSCPRUEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDSCPRUEXP', 'UseFileName', 'V', 'Y'


-- End ripout