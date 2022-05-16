/**********************************************************************************

EPORPRUDEX: Prudential FLMA-STD-LTD

FormatCode:     EPORPRUDEX
Project:        Prudential FLMA-STD-LTD
Client ID:      TRA1016
Date/time:      2022-05-10 09:33:03.443
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N14
Server:         N1SUP4DB52
Database:       ULTIPRO_POC
Web Filename:   TRA1016_67757_EEHISTORY_EPORPRUDEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPORPRUDEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EPORPRUDEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPORPRUDEX'


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
WHERE FormatCode = 'EPORPRUDEX'
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
WHERE ExpFormatCode = 'EPORPRUDEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPORPRUDEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPORPRUDEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPORPRUDEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPORPRUDEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPORPRUDEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPORPRUDEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPORPRUDEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPORPRUDEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPORPRUDEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPORPRUDEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPORPRUDEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPORPRUDEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPORPRUDEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPORPRUDEX];
GO
IF OBJECT_ID('U_EPORPRUDEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_Trailer];
GO
IF OBJECT_ID('U_EPORPRUDEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_PEarHist];
GO
IF OBJECT_ID('U_EPORPRUDEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_PDedHist];
GO
IF OBJECT_ID('U_EPORPRUDEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_Header];
GO
IF OBJECT_ID('U_EPORPRUDEX_File') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_File];
GO
IF OBJECT_ID('U_EPORPRUDEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_EEList];
GO
IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Employment') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_drvTbl_Employment];
GO
IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Dependent') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_drvTbl_Dependent];
GO
IF OBJECT_ID('U_EPORPRUDEX_drvTbl_CustomChars') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_drvTbl_CustomChars];
GO
IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Coverage') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_drvTbl_Coverage];
GO
IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Contact') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_drvTbl_Contact];
GO
IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Associate') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_drvTbl_Associate];
GO
IF OBJECT_ID('U_EPORPRUDEX_drvTbl_AbsenceInformation') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_drvTbl_AbsenceInformation];
GO
IF OBJECT_ID('U_EPORPRUDEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPORPRUDEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EPORPRUDEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPORPRUDEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPORPRUDEX','Prudential FLMA-STD-LTD','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EPORPRUDEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPORPRUDEXZ0','50','H','01','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPORPRUDEXZ0','50','H','01','2',NULL,'Transmission GUID',NULL,NULL,'"drvTransmissionGuid"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPORPRUDEXZ0','50','H','01','3',NULL,'Creation Date Time',NULL,NULL,'"drvCreationDateTime"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPORPRUDEXZ0','50','H','01','4',NULL,'Client Control Number',NULL,NULL,'"62424"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPORPRUDEXZ0','50','H','01','5',NULL,'Client Name',NULL,NULL,'"Trail Blazers, Inc"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPORPRUDEXZ0','50','H','01','6',NULL,'SchemaVersionIdentifier',NULL,NULL,'"1.0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPORPRUDEXZ0','50','H','01','7',NULL,'Sender Name',NULL,NULL,'"Rose Quarter"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPORPRUDEXZ0','50','H','01','8',NULL,'Sender Platform Name',NULL,NULL,'"UKG"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPORPRUDEXZ0','50','H','01','9',NULL,'Test Production Code',NULL,NULL,'"drvTestProductionCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPORPRUDEXZ0','50','H','01','10',NULL,'Transmission Type Code',NULL,NULL,'"Full FILE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPORPRUDEXZ0','50','H','01','11',NULL,'Activity Start Date Time',NULL,NULL,'"drvActivityStartDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPORPRUDEXZ0','50','H','01','12',NULL,'Activity End Date Time',NULL,NULL,'"drvActivityEndDate"','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPORPRUDEXZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"AST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPORPRUDEXZ0','50','D','10','2',NULL,'Client Control Number',NULL,NULL,'"62424"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPORPRUDEXZ0','50','D','10','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPORPRUDEXZ0','50','D','10','4',NULL,'Associate Social Security Number',NULL,NULL,'"drvEepSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPORPRUDEXZ0','50','D','10','5',NULL,'Associate Gender Code',NULL,NULL,'"UNKNOWN"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPORPRUDEXZ0','50','D','10','6',NULL,'Associate Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPORPRUDEXZ0','50','D','10','7',NULL,'Associate Date of Death',NULL,NULL,'"UNKNOWN"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPORPRUDEXZ0','50','D','10','8',NULL,'Associate Smoker Status Code',NULL,NULL,'"UNKNOWN"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPORPRUDEXZ0','50','D','10','9',NULL,'Associate Marital Status Code',NULL,NULL,'"UNKNOWN"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPORPRUDEXZ0','50','D','10','10',NULL,'Associate Prefix Title Code',NULL,NULL,'"drvAssociatePrefixTitleCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPORPRUDEXZ0','50','D','10','11',NULL,'Associate Suffix',NULL,NULL,'"drvAssociateSuffix"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPORPRUDEXZ0','50','D','10','12',NULL,'Associate Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPORPRUDEXZ0','50','D','10','13',NULL,'Associate First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPORPRUDEXZ0','50','D','10','14',NULL,'Associate Middle Name',NULL,NULL,'"drvNameMiddle"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPORPRUDEXZ0','50','D','10','15',NULL,'Associate Address Type Code 1',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPORPRUDEXZ0','50','D','10','16',NULL,'Associate Address Line 1 Text 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPORPRUDEXZ0','50','D','10','17',NULL,'Associate Address Line 2 Text 1',NULL,NULL,'"drvAddressLine2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPORPRUDEXZ0','50','D','10','18',NULL,'Associate Address Line 3 Text 1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPORPRUDEXZ0','50','D','10','19',NULL,'Associate City Name 1',NULL,NULL,'"drvAddressCity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPORPRUDEXZ0','50','D','10','20',NULL,'Associate State Province Code 1',NULL,NULL,'"drvAddressState"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPORPRUDEXZ0','50','D','10','21',NULL,'Associate Postal Code 1',NULL,NULL,'"drvAddressZipcode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPORPRUDEXZ0','50','D','10','22',NULL,'Associate Country Code 1',NULL,NULL,'"USA"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPORPRUDEXZ0','50','D','10','23',NULL,'Associate Address Type Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPORPRUDEXZ0','50','D','10','24',NULL,'Associate Address Line 1 Text 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPORPRUDEXZ0','50','D','10','25',NULL,'Associate Address Line 2 Text 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPORPRUDEXZ0','50','D','10','26',NULL,'Associate Address Line 3 Text 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPORPRUDEXZ0','50','D','10','27',NULL,'Associate City Name 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPORPRUDEXZ0','50','D','10','28',NULL,'Associate State Province Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPORPRUDEXZ0','50','D','10','29',NULL,'Associate Postal Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPORPRUDEXZ0','50','D','10','30',NULL,'Associate Country Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPORPRUDEXZ0','50','D','10','31',NULL,'Associate Address Type Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPORPRUDEXZ0','50','D','10','32',NULL,'Associate Address Line 1 Text 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPORPRUDEXZ0','50','D','10','33',NULL,'Associate Address Line 2 Text 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPORPRUDEXZ0','50','D','10','34',NULL,'Associate Address Line 3 Text 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPORPRUDEXZ0','50','D','10','35',NULL,'Associate City Name 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPORPRUDEXZ0','50','D','10','36',NULL,'Associate State Province Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPORPRUDEXZ0','50','D','10','37',NULL,'Associate Postal Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPORPRUDEXZ0','50','D','10','38',NULL,'Associate Country Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPORPRUDEXZ0','50','D','10','39',NULL,'Associate Telephone Type Code 1',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPORPRUDEXZ0','50','D','10','40',NULL,'Associate Telephone Number 1',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPORPRUDEXZ0','50','D','10','41',NULL,'Associate Telephone Number Extension 1',NULL,NULL,'"UNKNOWN"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPORPRUDEXZ0','50','D','10','42',NULL,'Telephone Type Code 2',NULL,NULL,'"BUSINESS"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPORPRUDEXZ0','50','D','10','43',NULL,'Associate Telephone Number 2',NULL,NULL,'"drvPhoneBusinessNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPORPRUDEXZ0','50','D','10','44',NULL,'Associate Telephone Number Extension 2',NULL,NULL,'"UNKNOWN"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPORPRUDEXZ0','50','D','10','45',NULL,'Associate Telephone  Type Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPORPRUDEXZ0','50','D','10','46',NULL,'Associate Telephone Number 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPORPRUDEXZ0','50','D','10','47',NULL,'Associate Telephone Number Extension 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPORPRUDEXZ0','50','D','10','48',NULL,'Associate Email Address Type Code 1',NULL,NULL,'"WORK"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPORPRUDEXZ0','50','D','10','49',NULL,'Associate Email Address Text 1',NULL,NULL,'"drvAddressEmail"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPORPRUDEXZ0','50','D','10','50',NULL,'Associate Email Address Type Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPORPRUDEXZ0','50','D','10','51',NULL,'Associate Email Address Text 2',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPORPRUDEXZ0','50','D','20','1',NULL,'Record Type',NULL,NULL,'"EMP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPORPRUDEXZ0','50','D','20','2',NULL,'Client Control Number',NULL,NULL,'"62424"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPORPRUDEXZ0','50','D','20','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPORPRUDEXZ0','50','D','20','4',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPORPRUDEXZ0','50','D','20','5',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPORPRUDEXZ0','50','D','20','6',NULL,'Rehire Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPORPRUDEXZ0','50','D','20','7',NULL,'Retirement Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPORPRUDEXZ0','50','D','20','8',NULL,'Employment Termination Date',NULL,NULL,'"drvEmploymentTerminationDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPORPRUDEXZ0','50','D','20','9',NULL,'Employment Termination Reason Code',NULL,NULL,'"drvEETerminationReasonCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPORPRUDEXZ0','50','D','20','10',NULL,'Adjusted Service Date',NULL,NULL,'"drvAdjustedServiceDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPORPRUDEXZ0','50','D','20','11',NULL,'Last Active Service Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPORPRUDEXZ0','50','D','20','12',NULL,'Employment Status Code',NULL,NULL,'"drvEmploymentStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPORPRUDEXZ0','50','D','20','13',NULL,'Employment Status Effective Date',NULL,NULL,'"drvEEStatusEffectiveDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPORPRUDEXZ0','50','D','20','14',NULL,'Employment Status Reason Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPORPRUDEXZ0','50','D','20','15',NULL,'Job Title Text',NULL,NULL,'"drvJobTitleText"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPORPRUDEXZ0','50','D','20','16',NULL,'Occupation Text',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPORPRUDEXZ0','50','D','20','17',NULL,'OSHA Job Classification Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPORPRUDEXZ0','50','D','20','18',NULL,'Occupation Class Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPORPRUDEXZ0','50','D','20','19',NULL,'Work Status Code',NULL,NULL,'"drvWorkStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPORPRUDEXZ0','50','D','20','20',NULL,'Weekly Scheduled Hours',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPORPRUDEXZ0','50','D','20','21',NULL,'Daily Hours Worked',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPORPRUDEXZ0','50','D','20','22',NULL,'Hourly Salary Code',NULL,NULL,'"drvHourlySatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPORPRUDEXZ0','50','D','20','23',NULL,'Earnings Type  Code 1',NULL,NULL,'"BASE PAY"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPORPRUDEXZ0','50','D','20','24',NULL,'Earnings  Amount 1',NULL,NULL,'"drvEarningsAmount1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPORPRUDEXZ0','50','D','20','25',NULL,'Earnings Frequency Code 1',NULL,NULL,'"ANNUAL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPORPRUDEXZ0','50','D','20','26',NULL,'Earnings Effective  Date 1',NULL,NULL,'"drvEarningsEffectiveDate1"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPORPRUDEXZ0','50','D','20','27',NULL,'Earnings Type Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPORPRUDEXZ0','50','D','20','28',NULL,'Earnings Amount 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPORPRUDEXZ0','50','D','20','29',NULL,'Earnings Frequency  Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPORPRUDEXZ0','50','D','20','30',NULL,'Earnings Effective Date 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPORPRUDEXZ0','50','D','20','31',NULL,'Earnings Type Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPORPRUDEXZ0','50','D','20','32',NULL,'Earnings Amount 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPORPRUDEXZ0','50','D','20','33',NULL,'Earnings Frequency Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPORPRUDEXZ0','50','D','20','34',NULL,'Earnings Effective Date 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPORPRUDEXZ0','50','D','20','35',NULL,'W4 Filing Status Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPORPRUDEXZ0','50','D','20','36',NULL,'W4 Exemptions Number',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPORPRUDEXZ0','50','D','20','37',NULL,'W4 Additional Withholding Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPORPRUDEXZ0','50','D','20','38',NULL,'W4 Withholding State Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPORPRUDEXZ0','50','D','20','39',NULL,'W4 Withholding State Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPORPRUDEXZ0','50','D','20','40',NULL,'W4 Withholding State Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPORPRUDEXZ0','50','D','20','41',NULL,'W4 Work Location Postal Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPORPRUDEXZ0','50','D','20','42',NULL,'Union Indicator',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPORPRUDEXZ0','50','D','20','43',NULL,'Local Bargaining Unit Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPORPRUDEXZ0','50','D','20','44',NULL,'Member Group Code',NULL,NULL,'"001"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPORPRUDEXZ0','50','D','20','45',NULL,'Bill Group Code',NULL,NULL,'"Trail Blazers, Inc"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPORPRUDEXZ0','50','D','20','46',NULL,'Payroll Frequency Code',NULL,NULL,'"MNTHLY_1ST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPORPRUDEXZ0','50','D','20','47',NULL,'District Location Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPORPRUDEXZ0','50','D','20','48',NULL,'Employment Location',NULL,NULL,'"drvEmploymentLocation"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPORPRUDEXZ0','50','D','20','49',NULL,'Regional Unit',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPORPRUDEXZ0','50','D','20','50',NULL,'Employer Information',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPORPRUDEXZ0','50','D','20','51',NULL,'Group',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPORPRUDEXZ0','50','D','20','52',NULL,'Work Location State Code',NULL,NULL,'"drvWorkLocationStateCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPORPRUDEXZ0','50','D','20','53',NULL,'Comments',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPORPRUDEXZ0','50','D','20','54',NULL,'Year to Date Earnings',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPORPRUDEXZ0','50','D','20','55',NULL,'Earnings As of Date',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPORPRUDEXZ0','50','D','30','1',NULL,'Record Type',NULL,NULL,'"CON"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPORPRUDEXZ0','50','D','30','2',NULL,'Client Control Number',NULL,NULL,'"62424"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPORPRUDEXZ0','50','D','30','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPORPRUDEXZ0','50','D','30','4',NULL,'Employment Contact ID',NULL,NULL,'"drvEmploymentContactID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPORPRUDEXZ0','50','D','30','5',NULL,'Employment Contact Type Code',NULL,NULL,'"drvEmploymentContactTypeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPORPRUDEXZ0','50','D','30','6',NULL,'Employment Contact First Name',NULL,NULL,'"drvEmploymentContactFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPORPRUDEXZ0','50','D','30','7',NULL,'Employment Contact Last Name',NULL,NULL,'"drvEmploymentContactLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPORPRUDEXZ0','50','D','30','8',NULL,'Employment Contact Middle Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPORPRUDEXZ0','50','D','30','9',NULL,'Employment Contact Prefix Title Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPORPRUDEXZ0','50','D','30','10',NULL,'Employment Contact Suffix',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPORPRUDEXZ0','50','D','30','11',NULL,'Employment Contact Telephone Type Code 1',NULL,NULL,'"BUSINESS"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPORPRUDEXZ0','50','D','30','12',NULL,'Employment Contact Telephone Number 1',NULL,NULL,'"drvEEContactTelephoneNumber1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPORPRUDEXZ0','50','D','30','13',NULL,'Employment Contact Telephone Number Extension 1',NULL,NULL,'"drvEETelephoneNumberExt1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPORPRUDEXZ0','50','D','30','14',NULL,'Employment Contact Telephone Type Code 2',NULL,NULL,'"drvEETelephoneTypeCode2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPORPRUDEXZ0','50','D','30','15',NULL,'Employment Contact Telephone Number 2',NULL,NULL,'"drvEEContactTelephoneNumber2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPORPRUDEXZ0','50','D','30','16',NULL,'Employment Contact Telephone Number Extension 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPORPRUDEXZ0','50','D','30','17',NULL,'Employment Contact Telephone  Type Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPORPRUDEXZ0','50','D','30','18',NULL,'Employment Contact Telephone Number 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPORPRUDEXZ0','50','D','30','19',NULL,'Employment Contact Telephone Number Extension 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPORPRUDEXZ0','50','D','30','20',NULL,'Employment Contact Email Address Type Code 1',NULL,NULL,'"WORK"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPORPRUDEXZ0','50','D','30','21',NULL,'Employment Contact Email Address Text 1',NULL,NULL,'"drvEEContactEmailAddressText1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPORPRUDEXZ0','50','D','30','22',NULL,'Employment Contact Email Address Type Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPORPRUDEXZ0','50','D','30','23',NULL,'Employment Contact Email Address Text 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPORPRUDEXZ0','50','D','30','24',NULL,'Employment Contact SSN',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPORPRUDEXZ0','50','D','30','25',NULL,'Employment Contact Employee ID',NULL,NULL,'"drvEEContactEmployeeID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPORPRUDEXZ0','50','D','30','26',NULL,'Employment Contact DOB',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPORPRUDEXZ0','50','D','40','1',NULL,'Record Type',NULL,NULL,'"DEP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPORPRUDEXZ0','50','D','40','2',NULL,'Client Control Number',NULL,NULL,'"62424"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPORPRUDEXZ0','50','D','40','4',NULL,'DependentID',NULL,NULL,'"drvDependentID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPORPRUDEXZ0','50','D','40','5',NULL,'Dependent Relationship Type Code',NULL,NULL,'"UNKNOWN"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPORPRUDEXZ0','50','D','40','6',NULL,'Dependent Social Security Number',NULL,NULL,'"drvDependentSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPORPRUDEXZ0','50','D','40','7',NULL,'Dependent Gender Code',NULL,NULL,'"UNKNOWN"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPORPRUDEXZ0','50','D','40','8',NULL,'Dependent Date of Birth',NULL,NULL,'"drvDependentDateOfBirth"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPORPRUDEXZ0','50','D','40','9',NULL,'Dependent Date of Death',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPORPRUDEXZ0','50','D','40','10',NULL,'Dependent Smoker Status Code',NULL,NULL,'"drvDependentSmokerStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPORPRUDEXZ0','50','D','40','11',NULL,'Dependent Marital Status Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPORPRUDEXZ0','50','D','40','12',NULL,'Dependent Prefix Title Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPORPRUDEXZ0','50','D','40','13',NULL,'Dependent Suffix',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPORPRUDEXZ0','50','D','40','14',NULL,'Dependent Last Name',NULL,NULL,'"drvDependentLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPORPRUDEXZ0','50','D','40','15',NULL,'Dependent First Name',NULL,NULL,'"drvDependentFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPORPRUDEXZ0','50','D','40','16',NULL,'Dependent Middle Name',NULL,NULL,'"drvDependentMiddleName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPORPRUDEXZ0','50','D','40','17',NULL,'Dependent Address Type Code',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPORPRUDEXZ0','50','D','40','18',NULL,'DependentAddress Line 1 Text',NULL,NULL,'"drvDepAddressLine1Text"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPORPRUDEXZ0','50','D','40','19',NULL,'Dependent Address Line 2 Text',NULL,NULL,'"drvDepAddressLine2Text"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPORPRUDEXZ0','50','D','40','20',NULL,'DependentAddress Line 3 Text',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPORPRUDEXZ0','50','D','40','21',NULL,'Dependent City Name',NULL,NULL,'"drvDependentCityName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPORPRUDEXZ0','50','D','40','22',NULL,'Dependent State Province Code',NULL,NULL,'"drvDependentStateProvinceCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPORPRUDEXZ0','50','D','40','23',NULL,'DependentPostal Code',NULL,NULL,'"drvDependentPostalCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPORPRUDEXZ0','50','D','40','24',NULL,'Dependent Country Code',NULL,NULL,'"USA"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPORPRUDEXZ0','50','D','40','25',NULL,'Dependent Telephone Type Code 1',NULL,NULL,'"MOBILE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPORPRUDEXZ0','50','D','40','26',NULL,'Dependent Telephone Number 1',NULL,NULL,'"drvDepTelephoneNumber1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPORPRUDEXZ0','50','D','40','27',NULL,'Dependent Telephone Number Extension 1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPORPRUDEXZ0','50','D','40','28',NULL,'Dependent Telephone Type Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPORPRUDEXZ0','50','D','40','29',NULL,'Dependent Telephone Number 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPORPRUDEXZ0','50','D','40','30',NULL,'Dependent Telephone Number Extension 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPORPRUDEXZ0','50','D','40','31',NULL,'Dependent Telephone  Type Code 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPORPRUDEXZ0','50','D','40','32',NULL,'Dependent Telephone Number 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPORPRUDEXZ0','50','D','40','33',NULL,'Dependent Telephone Number Extension 3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPORPRUDEXZ0','50','D','40','34',NULL,'Dependent Email Address Type Code 1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPORPRUDEXZ0','50','D','40','35',NULL,'Dependent Email Address Text 1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPORPRUDEXZ0','50','D','40','36',NULL,'Dependent Email Address Type Code 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPORPRUDEXZ0','50','D','40','37',NULL,'Dependent Email Address Text 2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPORPRUDEXZ0','50','D','40','38',NULL,'Dependent Status Code',NULL,NULL,'"drvDependentStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPORPRUDEXZ0','50','D','40','39',NULL,'Dependent Delete Reason Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPORPRUDEXZ0','50','D','40','40',NULL,'Student Status Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPORPRUDEXZ0','50','D','40','41',NULL,'Incapacitated Dependent Clause Certification Indic',NULL,NULL,'"N"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPORPRUDEXZ0','50','D','40','42',NULL,'Incapacitated Dependent Clause Certification Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPORPRUDEXZ0','50','D','40','43',NULL,'Dependent Event ID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPORPRUDEXZ0','50','D','40','44',NULL,'Dependent Event Type Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPORPRUDEXZ0','50','D','40','45',NULL,'Dependent Event Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPORPRUDEXZ0','50','D','40','46',NULL,'Dependent Marriage Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPORPRUDEXZ0','50','D','40','47',NULL,'Dependent Divorce Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPORPRUDEXZ0','50','D','40','48',NULL,'Dependent  PreferenceID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPORPRUDEXZ0','50','D','40','49',NULL,'Dependent  CorrespondenceTypeCode',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPORPRUDEXZ0','50','D','40','50',NULL,'Dependent  Preferred Name',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPORPRUDEXZ0','50','D','40','51',NULL,'Dependent  Preferred Language',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPORPRUDEXZ0','50','D','50','1',NULL,'Record Type',NULL,NULL,'"ABS"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPORPRUDEXZ0','50','D','50','2',NULL,'Client Control Number',NULL,NULL,'"62424"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPORPRUDEXZ0','50','D','50','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPORPRUDEXZ0','50','D','50','4',NULL,'FMLA Branch Code',NULL,NULL,'"00001"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPORPRUDEXZ0','50','D','50','5',NULL,'FMLA Work Location Code',NULL,NULL,'"Trail Blazers, Inc"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPORPRUDEXZ0','50','D','50','6',NULL,'Hours Worked in Last 12 Months',NULL,NULL,'"0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPORPRUDEXZ0','50','D','50','7',NULL,'As of Date Hours Worked in Last 12 Months',NULL,NULL,'"drvDateHoursWorkedLast12"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPORPRUDEXZ0','50','D','50','8',NULL,'Hours Worked Since Last File',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPORPRUDEXZ0','50','D','50','9',NULL,'Other Hours Worked in Last 12 Months',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPORPRUDEXZ0','50','D','50','10',NULL,'As of Date Other Hours Worked in Last 12 Months',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPORPRUDEXZ0','50','D','50','11',NULL,'Employment Sector',NULL,NULL,'"PRIVATE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPORPRUDEXZ0','50','D','50','12',NULL,'Employment Type',NULL,NULL,'"PRIVATE BUSINESS EMPLOYER"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPORPRUDEXZ0','50','D','50','13',NULL,'Key EE Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPORPRUDEXZ0','50','D','50','14',NULL,'Standard Work Schedule',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPORPRUDEXZ0','50','D','50','15',NULL,'Share Leave Relationship Code_1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPORPRUDEXZ0','50','D','50','16',NULL,'Shared Leave Relationship SSN_1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPORPRUDEXZ0','50','D','50','17',NULL,'Shared Leave Relationship Prefix Code_1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPORPRUDEXZ0','50','D','50','18',NULL,'Shared Leave Relationship First Name_1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPORPRUDEXZ0','50','D','50','19',NULL,'Shared Leave Relationship Middle Name_1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPORPRUDEXZ0','50','D','50','20',NULL,'Shared Leave Relationship Last Name_1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPORPRUDEXZ0','50','D','50','21',NULL,'Shared Leave Relationship Suffix Code_1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPORPRUDEXZ0','50','D','50','22',NULL,'Shared Leave Relationship EE ID_1',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPORPRUDEXZ0','50','D','50','23',NULL,'Share Leave Relationship Code_2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPORPRUDEXZ0','50','D','50','24',NULL,'Shared Leave Relationship SSN_2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPORPRUDEXZ0','50','D','50','25',NULL,'Shared Leave Relationship Prefix Code_2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPORPRUDEXZ0','50','D','50','26',NULL,'Shared Leave Relationship First Name_2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPORPRUDEXZ0','50','D','50','27',NULL,'Shared Leave Relationship Middle Name_2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPORPRUDEXZ0','50','D','50','28',NULL,'Shared Leave Relationship Last Name_2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPORPRUDEXZ0','50','D','50','29',NULL,'Shared Leave Relationship Suffix Code_2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPORPRUDEXZ0','50','D','50','30',NULL,'Shared Leave Relationship EE ID_2',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPORPRUDEXZ0','50','D','50','31',NULL,'Share Leave Relationship Code_3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPORPRUDEXZ0','50','D','50','32',NULL,'Shared Leave Relationship SSN_3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPORPRUDEXZ0','50','D','50','33',NULL,'Shared Leave Relationship Prefix Code_3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPORPRUDEXZ0','50','D','50','34',NULL,'Shared Leave Relationship First Name_3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPORPRUDEXZ0','50','D','50','35',NULL,'Shared Leave Relationship Middle Name_3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPORPRUDEXZ0','50','D','50','36',NULL,'Shared Leave Relationship Last Name_3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPORPRUDEXZ0','50','D','50','37',NULL,'Shared Leave Relationship Suffix Code_3',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPORPRUDEXZ0','50','D','50','38',NULL,'Shared Leave Relationship EE ID_3',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPORPRUDEXZ0','50','D','60','1',NULL,'Record Type',NULL,NULL,'"COV"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPORPRUDEXZ0','50','D','60','2',NULL,'Client Control Number',NULL,NULL,'"62424"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPORPRUDEXZ0','50','D','60','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPORPRUDEXZ0','50','D','60','4',NULL,'Product Code',NULL,NULL,'"drvProductCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPORPRUDEXZ0','50','D','60','5',NULL,'Coverage Tier Code',NULL,NULL,'"drvCoverageTierCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPORPRUDEXZ0','50','D','60','6',NULL,'Product Plan Code',NULL,NULL,'"drvProductPlanCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPORPRUDEXZ0','50','D','60','7',NULL,'Coverage Buy Up Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPORPRUDEXZ0','50','D','60','8',NULL,'Coverage Amount',NULL,NULL,'"drvCoverageAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPORPRUDEXZ0','50','D','60','9',NULL,'Coverage  Effective Date',NULL,NULL,'"drvCoverageEffectiveDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPORPRUDEXZ0','50','D','60','10',NULL,'Coverage  End Date',NULL,NULL,'"drvCoverageEndDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPORPRUDEXZ0','50','D','60','11',NULL,'Coverage Status Code',NULL,NULL,'"drvCoverageStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPORPRUDEXZ0','50','D','60','12',NULL,'Coverage Status Effective Date',NULL,NULL,'"drvCoverageStatusEffDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPORPRUDEXZ0','50','D','60','13',NULL,'Coverage Status Reason Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPORPRUDEXZ0','50','D','60','14',NULL,'Coverage Termination Reduction Type Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPORPRUDEXZ0','50','D','60','15',NULL,'Coverage Termination Reduction Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPORPRUDEXZ0','50','D','60','16',NULL,'Flat Benefit Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPORPRUDEXZ0','50','D','60','17',NULL,'Claim Branch Code',NULL,NULL,'"drvClaimBranchCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPORPRUDEXZ0','50','D','60','18',NULL,'EOB Correspondence Type Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPORPRUDEXZ0','50','D','60','19',NULL,'Assignment Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPORPRUDEXZ0','50','D','60','20',NULL,'Original LTD Coverage Effective Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPORPRUDEXZ0','50','D','60','21',NULL,'Partner Product Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPORPRUDEXZ0','50','D','60','22',NULL,'Partner Short Benefit Description',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPORPRUDEXZ0','50','D','60','23',NULL,'Client Coverage Effective Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPORPRUDEXZ0','50','D','60','24',NULL,'Benefit Option Identifier',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPORPRUDEXZ0','50','D','60','25',NULL,'Coverage Increase Within 2 years Indicator',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPORPRUDEXZ0','50','D','60','26',NULL,'Issuance Age',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPORPRUDEXZ0','50','D','60','27',NULL,'Voluntary Basis',NULL,NULL,'"drvVoluntaryBasis"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPORPRUDEXZ0','50','D','60','28',NULL,'Applicant Eligibility Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPORPRUDEXZ0','50','D','60','29',NULL,'Applicant Inforce Benefit Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPORPRUDEXZ0','50','D','60','30',NULL,'Applicant Additional Benefit Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPORPRUDEXZ0','50','D','60','31',NULL,'Applicant Relationship Type Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPORPRUDEXZ0','50','D','60','32',NULL,'Applicant EOI Branch Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPORPRUDEXZ0','50','D','60','33',NULL,'Deduction Type  Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPORPRUDEXZ0','50','D','60','34',NULL,'Deduction Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPORPRUDEXZ0','50','D','60','35',NULL,'Deduction Frequency Type Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPORPRUDEXZ0','50','D','60','36',NULL,'Deduction Withholding State',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPORPRUDEXZ0','50','D','60','37',NULL,'Payroll Deduction Frequency Type Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPORPRUDEXZ0','50','D','60','38',NULL,'Payroll Deduction Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPORPRUDEXZ0','50','D','60','39',NULL,'Coverage Event ID',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPORPRUDEXZ0','50','D','60','40',NULL,'Coverage Event Type Code',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPORPRUDEXZ0','50','D','60','41',NULL,'Coverage Event Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPORPRUDEXZ0','50','D','60','42',NULL,'Coverage Marriage Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPORPRUDEXZ0','50','D','60','43',NULL,'Coverage Divorce Date',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPORPRUDEXZ0','50','D','70','1',NULL,'Record Type',NULL,NULL,'"CCH"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPORPRUDEXZ0','50','D','70','2',NULL,'Client Control Number',NULL,NULL,'"62424"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPORPRUDEXZ0','50','D','70','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPORPRUDEXZ0','50','D','70','4',NULL,'Custom Characteristic Code',NULL,NULL,'"Trail Blazers, Inc"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPORPRUDEXZ0','50','D','70','5',NULL,'Custom Characteristic Amount',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPORPRUDEXZ0','50','D','70','6',NULL,'Custom Characteristic Date',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPORPRUDEXZ0','50','D','70','7',NULL,'Custom Characteristic Percent',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPORPRUDEXZ0','50','D','70','8',NULL,'Custom Characteristic Value Text',NULL,NULL,'"drvCustCharValueText"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPORPRUDEXZ0','50','T','90','1',NULL,'Record Type',NULL,NULL,'"TRL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPORPRUDEXZ0','50','T','90','2',NULL,'Audit ID',NULL,NULL,'"drvAuditID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPORPRUDEXZ0','50','T','90','3',NULL,'Absence Related Employment Information Record Quan',NULL,NULL,'"drvAbsenceRelatedInfRecQty"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPORPRUDEXZ0','50','T','90','4',NULL,'Associate Record Quantity',NULL,NULL,'"drvAssociateRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPORPRUDEXZ0','50','T','90','5',NULL,'Beneficiary Record Quantity',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPORPRUDEXZ0','50','T','90','6',NULL,'Coverage Record Quantity',NULL,NULL,'"drvCoverageRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPORPRUDEXZ0','50','T','90','7',NULL,'Dependent Record Quantity',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPORPRUDEXZ0','50','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL,'"drvEmpContactRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPORPRUDEXZ0','50','T','90','9',NULL,'Employment Information Record Quantity',NULL,NULL,'"drvEEInformationRecordQty"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPORPRUDEXZ0','50','T','90','10',NULL,'Event Record Quantity',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPORPRUDEXZ0','50','T','90','11',NULL,'Preference Record Quantity',NULL,NULL,'""','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPORPRUDEXZ0','50','T','90','12',NULL,'Custom Characteristics Record Quantity',NULL,NULL,'"drvCustomCharRecordQty"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPORPRUDEXZ0','50','T','90','13',NULL,'Total Coverage Amount',NULL,NULL,'"drvTotalCoverageAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPORPRUDEXZ0','50','T','90','14',NULL,'Total Record Quantity',NULL,NULL,'"drvTotalRecordQuantity"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPORPRUDEX_20220510.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202204299','EMPEXPORT','OEACTIVE',NULL,'EPORPRUDEX',NULL,NULL,NULL,'202204299','Apr 29 2022 10:12AM','Apr 29 2022 10:12AM','202204291',NULL,'','','202204291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202204299','EMPEXPORT','OEPASSIVE',NULL,'EPORPRUDEX',NULL,NULL,NULL,'202204299','Apr 29 2022 10:12AM','Apr 29 2022 10:12AM','202204291',NULL,'','','202204291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'Prudential FLMA-STD-LTD','202204299','EMPEXPORT','ONDEM_XOE',NULL,'EPORPRUDEX',NULL,NULL,NULL,'202204299','Apr 29 2022 10:12AM','Apr 29 2022 10:12AM','202204291',NULL,'','','202204291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,'Prudential FLMA-STD-LTD-Sched','202204299','EMPEXPORT','SCH_EPORPR',NULL,'EPORPRUDEX',NULL,NULL,NULL,'202204299','Apr 29 2022 10:12AM','Apr 29 2022 10:12AM','202204291',NULL,'','','202204291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,'Prudential FLMA-STD-LTD-Test','202204299','EMPEXPORT','TEST_XOE',NULL,'EPORPRUDEX',NULL,NULL,NULL,'202204299','Apr 29 2022 10:12AM','Apr 29 2022 10:12AM','202204291',NULL,'','','202204291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPORPRUDEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPORPRUDEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPORPRUDEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPORPRUDEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPORPRUDEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPORPRUDEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPORPRUDEX','H01','dbo.U_EPORPRUDEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPORPRUDEX','D10','dbo.U_EPORPRUDEX_drvTbl_Associate',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPORPRUDEX','D20','dbo.U_EPORPRUDEX_drvTbl_Employment',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPORPRUDEX','D30','dbo.U_EPORPRUDEX_drvTbl_Contact',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPORPRUDEX','D40','dbo.U_EPORPRUDEX_drvTbl_Dependent',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPORPRUDEX','D50','dbo.U_EPORPRUDEX_drvTbl_AbsenceInformation',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPORPRUDEX','D60','dbo.U_EPORPRUDEX_drvTbl_Coverage',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPORPRUDEX','D70','dbo.U_EPORPRUDEX_drvTbl_CustomChars',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPORPRUDEX','T90','dbo.U_EPORPRUDEX_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EPORPRUDEX
-----------

IF OBJECT_ID('U_dsi_BDM_EPORPRUDEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPORPRUDEX] (
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
-- Create table U_EPORPRUDEX_DedList
-----------

IF OBJECT_ID('U_EPORPRUDEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPORPRUDEX_drvTbl_AbsenceInformation
-----------

IF OBJECT_ID('U_EPORPRUDEX_drvTbl_AbsenceInformation') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_drvTbl_AbsenceInformation] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvAssociateID] char(9) NULL,
    [drvDateHoursWorkedLast12] nvarchar(4000) NULL
);

-----------
-- Create table U_EPORPRUDEX_drvTbl_Associate
-----------

IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Associate') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_drvTbl_Associate] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvAssociateID] char(9) NULL,
    [drvEepSSN] char(11) NULL,
    [drvDateofBirth] datetime NULL,
    [drvAssociatePrefixTitleCode] varchar(1) NOT NULL,
    [drvAssociateSuffix] varchar(1) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipcode] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvPhoneBusinessNumber] varchar(50) NULL,
    [drvAddressEmail] varchar(50) NULL
);

-----------
-- Create table U_EPORPRUDEX_drvTbl_Contact
-----------

IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Contact') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_drvTbl_Contact] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvAssociateID] char(9) NULL,
    [drvEmploymentContactID] char(9) NULL,
    [drvEmploymentContactTypeCode] varchar(1) NOT NULL,
    [drvEmploymentContactFirstName] varchar(100) NULL,
    [drvEmploymentContactLastName] varchar(100) NULL,
    [drvEEContactTelephoneNumber1] varchar(50) NULL,
    [drvEETelephoneNumberExt1] varchar(10) NULL,
    [drvEETelephoneTypeCode2] varchar(1) NOT NULL,
    [drvEEContactTelephoneNumber2] varchar(1) NOT NULL,
    [drvEEContactEmailAddressText1] varchar(50) NULL,
    [drvEEContactEmployeeID] char(9) NULL
);

-----------
-- Create table U_EPORPRUDEX_drvTbl_Coverage
-----------

IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Coverage') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_drvTbl_Coverage] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvAssociateID] char(9) NULL,
    [drvProductCode] varchar(4) NULL,
    [drvCoverageTierCode] varchar(2) NULL,
    [drvProductPlanCode] varchar(4) NOT NULL,
    [drvCoverageAmount] money NULL,
    [drvCoverageEffectiveDate] datetime NULL,
    [drvCoverageEndDate] datetime NULL,
    [drvCoverageStatusCode] varchar(10) NOT NULL,
    [drvCoverageStatusEffDate] datetime NULL,
    [drvClaimBranchCode] varchar(5) NULL,
    [drvVoluntaryBasis] varchar(9) NOT NULL
);

-----------
-- Create table U_EPORPRUDEX_drvTbl_CustomChars
-----------

IF OBJECT_ID('U_EPORPRUDEX_drvTbl_CustomChars') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_drvTbl_CustomChars] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvAssociateID] char(9) NULL,
    [drvCustCharValueText] char(10) NULL
);

-----------
-- Create table U_EPORPRUDEX_drvTbl_Dependent
-----------

IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Dependent') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_drvTbl_Dependent] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvDependentID] varchar(14) NULL,
    [drvDependentSSN] char(11) NULL,
    [drvDependentDateOfBirth] datetime NULL,
    [drvDependentSmokerStatusCode] varchar(10) NOT NULL,
    [drvDependentLastName] varchar(100) NULL,
    [drvDependentFirstName] varchar(100) NULL,
    [drvDependentMiddleName] varchar(50) NULL,
    [drvDepAddressLine1Text] varchar(255) NULL,
    [drvDepAddressLine2Text] varchar(255) NULL,
    [drvDependentCityName] varchar(255) NULL,
    [drvDependentStateProvinceCode] varchar(255) NULL,
    [drvDependentPostalCode] varchar(50) NULL,
    [drvDepTelephoneNumber1] varchar(50) NULL,
    [drvDependentStatusCode] varchar(7) NULL
);

-----------
-- Create table U_EPORPRUDEX_drvTbl_Employment
-----------

IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Employment') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_drvTbl_Employment] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvAssociateID] char(9) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvHireDate] datetime NULL,
    [drvEmploymentTerminationDate] datetime NULL,
    [drvEETerminationReasonCode] varchar(10) NULL,
    [drvAdjustedServiceDate] datetime NULL,
    [drvEmploymentStatusCode] varchar(10) NOT NULL,
    [drvEEStatusEffectiveDate] datetime NULL,
    [drvJobTitleText] varchar(150) NULL,
    [drvWorkStatusCode] varchar(9) NOT NULL,
    [drvHourlySatusCode] varchar(8) NOT NULL,
    [drvEarningsAmount1] money NULL,
    [drvEarningsEffectiveDate1] datetime NULL,
    [drvEmploymentLocation] varchar(19) NOT NULL,
    [drvWorkLocationStateCode] varchar(2) NULL
);

-----------
-- Create table U_EPORPRUDEX_EEList
-----------

IF OBJECT_ID('U_EPORPRUDEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPORPRUDEX_File
-----------

IF OBJECT_ID('U_EPORPRUDEX_File') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EPORPRUDEX_Header
-----------

IF OBJECT_ID('U_EPORPRUDEX_Header') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_Header] (
    [drvTransmissionGuid] varchar(1) NOT NULL,
    [drvCreationDateTime] datetime NOT NULL,
    [drvTestProductionCode] varchar(10) NOT NULL,
    [drvActivityStartDate] datetime NULL,
    [drvActivityEndDate] datetime NOT NULL
);

-----------
-- Create table U_EPORPRUDEX_PDedHist
-----------

IF OBJECT_ID('U_EPORPRUDEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_PDedHist] (
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
-- Create table U_EPORPRUDEX_PEarHist
-----------

IF OBJECT_ID('U_EPORPRUDEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_PEarHist] (
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

-----------
-- Create table U_EPORPRUDEX_Trailer
-----------

IF OBJECT_ID('U_EPORPRUDEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_EPORPRUDEX_Trailer] (
    [drvAuditID] datetime NOT NULL,
    [drvAbsenceRelatedInfRecQty] int NOT NULL,
    [drvAssociateRecordQuantity] int NULL,
    [drvCoverageRecordQuantity] int NULL,
    [drvEmpContactRecordQuantity] int NULL,
    [drvEEInformationRecordQty] int NULL,
    [drvCustomCharRecordQty] int NULL,
    [drvTotalCoverageAmount] money NULL,
    [drvTotalRecordQuantity] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPORPRUDEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Portland trail Blazers

Created By: Roger Bynum
Business Analyst: Curlin Beck
Create Date: 04/29/2022
Service Request Number: TekP-2022-2-22-01

Purpose: Prudential FLMA-STD-LTD

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPORPRUDEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPORPRUDEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPORPRUDEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPORPRUDEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPORPRUDEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPORPRUDEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPORPRUDEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPORPRUDEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPORPRUDEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPORPRUDEX', 'SCH_EPORPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPORPRUDEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPORPRUDEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPORPRUDEX';

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
    DELETE FROM dbo.U_EPORPRUDEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPORPRUDEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTD,STD,ACID,CRIT1,CRIT2,CRIT3,ACCID';

    IF OBJECT_ID('U_EPORPRUDEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPORPRUDEX_DedList
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

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EPORPRUDEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_PDedHist;
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
    INTO dbo.U_EPORPRUDEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPORPRUDEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EPORPRUDEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_PEarHist;
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
    INTO dbo.U_EPORPRUDEX_PEarHist
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
    ---------------------------------
    -- DETAIL RECORD - U_EPORPRUDEX_drvTbl_Associate
    ---------------------------------
    IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Associate','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_drvTbl_Associate;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvEepSSN = eepSSN
        ,drvDateofBirth = EepDateOfBirth
        ,drvAssociatePrefixTitleCode = ''
        ,drvAssociateSuffix = ''
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipcode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvPhoneBusinessNumber = EecPhoneBusinessNumber
        ,drvAddressEmail = EepAddressEMail
    INTO dbo.U_EPORPRUDEX_drvTbl_Associate
    FROM dbo.U_EPORPRUDEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EPORPRUDEX WITH(NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPORPRUDEX_drvTbl_Employment
    ---------------------------------
    IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Employment','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_drvTbl_Employment;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvEmployeeID = EecEmpNo
        ,drvHireDate = EecDateOfLastHire
        ,drvEmploymentTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEETerminationReasonCode = CASE WHEN EecEmplStatus = 'T'THEN 'TERMINATED' END
        ,drvAdjustedServiceDate = EecDateOfSeniority
        ,drvEmploymentStatusCode = CASE WHEN EecEmplStatus = 'T'THEN 'Terminated' ELSE 'Active' END
        ,drvEEStatusEffectiveDate = EecEmplStatusStartDate
        ,drvJobTitleText = EecJobTitle
        ,drvWorkStatusCode = CASE WHEN EecFullTimeORPartTime = 'F' then 'FULL TIME'
                                  WHEN  EecFullTimeOrPartTime = 'P' Then 'PART TIME'
                                  ELSE 'UNKNOWN'
                             END 
        ,drvHourlySatusCode = CASE WHEN EecSalaryOrHourly = 'S' THEN 'SALARIED' ELSE 'HOURLY' END    
        ,drvEarningsAmount1 = EecAnnSalary
        ,drvEarningsEffectiveDate1 = EecDateOfLastSalReview
        ,drvEmploymentLocation = CASE WHEN EecCoID = 'PRT' THEN 'Trail Blazers, Inc' ELSE 'Rip City Management' END
        ,drvWorkLocationStateCode = LEFT(EecStateSUI,2)
    INTO dbo.U_EPORPRUDEX_drvTbl_Employment
    FROM dbo.U_EPORPRUDEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_EPORPRUDEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPORPRUDEX_drvTbl_Contact
    ---------------------------------
    IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Contact','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_drvTbl_Contact;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 3'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvEmploymentContactID = EecEmpNo
        ,drvEmploymentContactTypeCode = ''                        ---ToDo: Need to add 2nd rows for ContactTypeCode, First and Last name?
        ,drvEmploymentContactFirstName = EepNameFirst
        ,drvEmploymentContactLastName = EepNameLast
        ,drvEEContactTelephoneNumber1 = EecPhoneBusinessNumber
        ,drvEETelephoneNumberExt1 = EecPhoneBusinessExt
        ,drvEETelephoneTypeCode2 = ''
        ,drvEEContactTelephoneNumber2 = ''
        ,drvEEContactEmailAddressText1 = EepAddressEMail
        ,drvEEContactEmployeeID = EecEmpNo
    INTO dbo.U_EPORPRUDEX_drvTbl_Contact
    FROM dbo.U_EPORPRUDEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EPORPRUDEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPORPRUDEX_drvTbl_Dependent
    ---------------------------------
    IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Dependent','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_drvTbl_Dependent;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 4'
        -- standard fields above and additional driver fields below        --Todo - NEED column for AssociateID - EecEmpNo
        ,drvDependentID = EecEmpNo + '_' + RIGHT(ConSSN,4)
        ,drvDependentSSN = ConSSN
        ,drvDependentDateOfBirth = ConDateOfBirth
        ,drvDependentSmokerStatusCode = CASE WHEN ConIsSmoker = 'Y' THEN 'SMOKER' ELSE 'NON SMOKER' END
        ,drvDependentLastName = ConNameLast
        ,drvDependentFirstName = ConNameFirst
        ,drvDependentMiddleName = ConNameMiddle
        ,drvDepAddressLine1Text = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressLine1 ELSE EepAddressLine1 END
        ,drvDepAddressLine2Text = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressLine2 ELSE EepAddressLine2 END
        ,drvDependentCityName = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressCity ELSE EepAddressCity END
        ,drvDependentStateProvinceCode = CASE WHEN ConAddressIsDifferent = 'Y' THEN  ConAddressState ELSE EepAddressState END
        ,drvDependentPostalCode = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvDepTelephoneNumber1 = ConPhoneHomeNumber
        ,drvDependentStatusCode = CASE WHEN BdmBenOption IN ('EEC','EDP','EES') THEN 'ACTIVE' WHEN BdmBenOption = 'EE' then 'REMOVED' END
    INTO dbo.U_EPORPRUDEX_drvTbl_Dependent
    FROM dbo.U_EPORPRUDEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
    JOIN dbo.U_dsi_BDM_EPORPRUDEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = xEEID
        AND BdmDepRecId = ConSystemId
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPORPRUDEX_drvTbl_AbsenceInformation
    ---------------------------------
    IF OBJECT_ID('U_EPORPRUDEX_drvTbl_AbsenceInformation','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_drvTbl_AbsenceInformation;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 5'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvDateHoursWorkedLast12 = FORMAT(PehCurHrs, '#0.00')
    INTO dbo.U_EPORPRUDEX_drvTbl_AbsenceInformation
    FROM dbo.U_EPORPRUDEX_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPORPRUDEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
    JOIN dbo.U_EPORPRUDEX_PEarHist WITH(NOLOCK)
        ON pehEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPORPRUDEX_drvTbl_Coverage
    ---------------------------------
    IF OBJECT_ID('U_EPORPRUDEX_drvTbl_Coverage','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_drvTbl_Coverage;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 6'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvProductCode = CASE  WHEN BdmDedCode = 'LTD' THEN 'LTD'   
                                WHEN BdmDedCode = 'STD' THEN 'STD'
                                WHEN BdmDedCode = 'ACID' THEN 'VACC'
                                WHEN BdmDedCode IN ('CRIT1','CRIT2','CRIT3') THEN 'VCI'
                          END
        ,drvCoverageTierCode = CASE WHEN BdmBenOption = 'EE' THEN 'EE'
                                    WHEN BdmBenOption = 'EEC' THEN 'EC'
                                    WHEN BdmBenOption IN ('EDP', 'EES') THEN 'ES'  
                                    WHEN BdmBenOption = 'EEF' THEN 'EF'
                               END
        ,drvProductPlanCode = CASE WHEN BdmDedCode = 'ACCID' THEN '5385'
                                   WHEN BdmDedCode IN ('CRIT1','CRIT2','CRIT3') THEN '5387' 
                                   ELSE  ''
                              END
        ,drvCoverageAmount = CASE WHEN BdmDedCode = 'ACCID' AND BdmBenOption = 'EE' THEN BdmEEAmt   
                                  WHEN BdmDedCode = 'CRIT1' THEN BdmEEAmt 
                                  WHEN BdmDedCode = 'CRIT2' and ConRelationship IN ('DP','SPS') THEN BdmEEAmt
                             END
        ,drvCoverageEffectiveDate = BdmBenStartDate
        ,drvCoverageEndDate = BdmBenStopDate
        ,drvCoverageStatusCode = CASE WHEN BdmBenStatus = 'A' AND BdmBenStopDate IS NULL THEN 'ACTIVE' ELSE 'TERMINATED' END
        ,drvCoverageStatusEffDate = CASE WHEN BdmDedCode = 'ACCID' AND BdmBenOption = 'EE' THEN BdmBenStartDate 
                                         WHEN BdmDedCode = 'CRIT1' THEN BdmBenStartDate 
                                         WHEN BdmDedCode = 'CRIT2' and ConRelationship IN ('DP','SPS') THEN BdmBenStartDate 
                                         WHEN BdmDedCode = 'CRIT3' THEN BdmBenStartDate 
                                         ELSE  ''
                                    END
        ,drvClaimBranchCode = CASE WHEN EecJobCode IN ('PRESCEO','PRESGM','PRES','GM','INTGM','PRESBBO') AND EecCOID = 'PTB' AND BdmDedCode = 'STD' THEN '00001'
                                   WHEN EecJobCode NOT IN ('PRESCEO','PRESGM','PRES','GM','INTGM','PRESBBO') AND EecCOID = 'PTB' AND BdmDedCode = 'STD' THEN  '00002'
                                   WHEN EecJobCode IN ('PRESCEO','PRESGM','PRES','GM','INTGM','PRESBBO') AND EecCOID = 'RIP' AND BdmDedCode = 'STD'   THEN '00003'
                                   When EecJobCode NOT IN ('PRESCEO','PRESGM','PRES','GM','INTGM','PRESBBO') AND EecCOID = 'RIP' AND BdmDedCode = 'STD' THEN  '00004'
                                   When EecJobCode IN ('PRESCEO','PRESGM','PRES','GM','INTGM','PRESBBO') AND EecCOID = 'PTB' AND BdmDedCode = 'LTD' THEN '00001'
                                   When EecJobCode NOT IN ('PRESCEO','PRESGM','PRES','GM','INTGM','PRESBBO') AND EecCOID = 'PTB' AND BdmDedCode = 'LTD' THEN '00003' 
                                   When EecJobCode IN ('PRESCEO','PRESGM','PRES','GM','INTGM','PRESBBO') AND EecCOID = 'RIP' AND BdmDedCode = 'LTD' THEN '00005' 
                                   When EecJobCode NOT IN ('PRESCEO','PRESGM','PRES','GM','INTGM','PRESBBO') AND EecCOID = 'RIP' AND BdmDedCode = 'LTD' THEN'00007'
                              END
        ,drvVoluntaryBasis = CASE WHEN BdmDedCode = 'ACCID' THEN 'TREATMENT' ELSE '' END
    INTO dbo.U_EPORPRUDEX_drvTbl_Coverage
    FROM dbo.U_EPORPRUDEX_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPORPRUDEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPORPRUDEX_drvTbl_CustomChars
    ---------------------------------
    IF OBJECT_ID('U_EPORPRUDEX_drvTbl_CustomChars','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_drvTbl_CustomChars;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 7'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvCustCharValueText = EecOrgLvl2
    INTO dbo.U_EPORPRUDEX_drvTbl_CustomChars
    FROM dbo.U_EPORPRUDEX_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPORPRUDEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPORPRUDEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_Header;
    SELECT DISTINCT
         drvTransmissionGuid = ''
        ,drvCreationDateTime = FORMAT(GETDATE(),'yyyyMMddHHmmss')
        ,drvTestProductionCode = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'TEST' ELSE 'PRODUCTION' END
        ,drvActivityStartDate = DATEADD(DAY, -6, GETDATE())
        ,drvActivityEndDate = GETDATE()
    INTO dbo.U_EPORPRUDEX_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPORPRUDEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EPORPRUDEX_Trailer;
    SELECT DISTINCT
         drvAuditID = GETDATE()                    
        ,drvAbsenceRelatedInfRecQty = 0 
        ,drvAssociateRecordQuantity = (SELECT COUNT(1) FROM dbo.U_EPORPRUDEX_drvTbl_Associate)
        ,drvCoverageRecordQuantity = (SELECT COUNT(1) FROM dbo.U_EPORPRUDEX_drvTbl_Coverage)
        ,drvEmpContactRecordQuantity = (SELECT COUNT(1) FROM dbo.U_EPORPRUDEX_drvTbl_Contact)
        ,drvEEInformationRecordQty = (SELECT COUNT(1) FROM dbo.U_EPORPRUDEX_drvTbl_Employment)
        ,drvCustomCharRecordQty = (SELECT COUNT(1) FROM U_EPORPRUDEX_drvTbl_CustomChars)
        ,drvTotalCoverageAmount = (SELECT SUM(CAST(drvCoverageAmount AS Money)) FROM dbo.U_EPORPRUDEX_drvTbl_Coverage)
        ,drvTotalRecordQuantity = ''
    INTO dbo.U_EPORPRUDEX_Trailer
    ;
    DECLARE @TotalCount INT
    SELECT @TotalCount = drvAssociateRecordQuantity + drvCoverageRecordQuantity + drvEmpContactRecordQuantity + drvEEInformationRecordQty + drvCustomCharRecordQty 
    FROM dbo.U_EPORPRUDEX_Trailer WITH(NOLOCK)
    UPDATE dbo.U_EPORPRUDEX_Trailer
    SET drvTotalRecordQuantity = @TotalCount

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
ALTER VIEW dbo.dsi_vwEPORPRUDEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPORPRUDEX_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EPORPRUDEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202204221'
       ,expStartPerControl     = '202204221'
       ,expLastEndPerControl   = '202204299'
       ,expEndPerControl       = '202204299'
WHERE expFormatCode = 'EPORPRUDEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPORPRUDEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPORPRUDEX_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPORPRUDEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPORPRUDEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPORPRUDEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPORPRUDEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPORPRUDEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPORPRUDEX', 'UseFileName', 'V', 'Y'


-- End ripout