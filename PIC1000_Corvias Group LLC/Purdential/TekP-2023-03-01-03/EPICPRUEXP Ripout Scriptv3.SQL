/**********************************************************************************

EPICPRUEXP: Prudential Voluntary Life Export

FormatCode:     EPICPRUEXP
Project:        Prudential Voluntary Life Export
Client ID:      PIC1000
Date/time:      2023-05-25 14:08:03.780
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW1WUP2DB01
Database:       ULTIPRO_WPPMH
Web Filename:   PIC1000_27863_EEHISTORY_EPICPRUEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPICPRUEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EPICPRUEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPICPRUEXP'


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
WHERE FormatCode = 'EPICPRUEXP'
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
WHERE ExpFormatCode = 'EPICPRUEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPICPRUEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPICPRUEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPICPRUEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPICPRUEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPICPRUEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPICPRUEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPICPRUEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPICPRUEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPICPRUEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPICPRUEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPICPRUEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPICPRUEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPICPRUEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPICPRUEXP];
GO
IF OBJECT_ID('U_EPICPRUEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_Trailer];
GO
IF OBJECT_ID('U_EPICPRUEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_PEarHist];
GO
IF OBJECT_ID('U_EPICPRUEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_Header];
GO
IF OBJECT_ID('U_EPICPRUEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_File];
GO
IF OBJECT_ID('U_EPICPRUEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_EEList];
GO
IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Employment') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_drvTbl_Employment];
GO
IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Custom') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_drvTbl_Custom];
GO
IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Cov') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_drvTbl_Cov];
GO
IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Contact') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_drvTbl_Contact];
GO
IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Associate') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_drvTbl_Associate];
GO
IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Absence') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_drvTbl_Absence];
GO
IF OBJECT_ID('U_EPICPRUEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_DedList];
GO
IF OBJECT_ID('U_EPICPRUEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_AuditFields];
GO
IF OBJECT_ID('U_EPICPRUEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPICPRUEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EPICPRUEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPICPRUEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPICPRUEXP','Prudential Voluntary Life Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EPICPRUEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPICPRUEXPZ0','3','H','01','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPICPRUEXPZ0','32','H','01','2',NULL,'Transmission GUID',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPICPRUEXPZ0','14','H','01','3',NULL,'Creation Date Time',NULL,NULL,'"drvCurrentTime"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPICPRUEXPZ0','10','H','01','4',NULL,'Client Control Number',NULL,NULL,'"71102"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPICPRUEXPZ0','80','H','01','5',NULL,'Client Name',NULL,NULL,'"Corvias"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPICPRUEXPZ0','6','H','01','6',NULL,'SchemaVersionIdentifier',NULL,NULL,'"1.0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPICPRUEXPZ0','80','H','01','7',NULL,'Sender Name',NULL,NULL,'"Corvias"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPICPRUEXPZ0','80','H','01','8',NULL,'Sender Platform Name',NULL,NULL,'"UKG"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPICPRUEXPZ0','10','H','01','9',NULL,'Test Production Code',NULL,NULL,'"drvTestorProdCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPICPRUEXPZ0','12','H','01','10',NULL,'Transmission Type Code',NULL,NULL,'"FULL FILE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPICPRUEXPZ0','14','H','01','11',NULL,'Activity Start Date Time',NULL,NULL,'"drvActivityStartTime"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPICPRUEXPZ0','14','H','01','12',NULL,'Activity End Date Time',NULL,NULL,'"drvActivityEndTime"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPICPRUEXPZ0','3','D','10','1',NULL,'Record Type',NULL,NULL,'"AST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPICPRUEXPZ0','10','D','10','2',NULL,'Client Control Number',NULL,NULL,'"71102"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPICPRUEXPZ0','32','D','10','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPICPRUEXPZ0','9','D','10','4',NULL,'Associate Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPICPRUEXPZ0','25','D','10','5',NULL,'Associate Gender Code',NULL,NULL,'"drvGender"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPICPRUEXPZ0','8','D','10','6',NULL,'Associate Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPICPRUEXPZ0','8','D','10','7',NULL,'Associate Date of Death',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPICPRUEXPZ0','25','D','10','8',NULL,'Associate Smoker Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPICPRUEXPZ0','30','D','10','9',NULL,'Associate Marital Status Code',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPICPRUEXPZ0','30','D','10','10',NULL,'Associate Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPICPRUEXPZ0','30','D','10','11',NULL,'Associate Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPICPRUEXPZ0','80','D','10','12',NULL,'Associate Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPICPRUEXPZ0','50','D','10','13',NULL,'Associate First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPICPRUEXPZ0','50','D','10','14',NULL,'Associate Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPICPRUEXPZ0','25','D','10','15',NULL,'Associate Address Type Code 1',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPICPRUEXPZ0','64','D','10','16',NULL,'Associate Address Line 1 Text 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPICPRUEXPZ0','64','D','10','17',NULL,'Associate Address Line 2 Text 1',NULL,NULL,'"drvAddressLine2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPICPRUEXPZ0','64','D','10','18',NULL,'Associate Address Line 3 Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPICPRUEXPZ0','50','D','10','19',NULL,'Associate City Name 1',NULL,NULL,'"drvAddressCity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPICPRUEXPZ0','2','D','10','20',NULL,'Associate State Province Code 1',NULL,NULL,'"drvAddressState"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPICPRUEXPZ0','12','D','10','21',NULL,'Associate Postal Code 1',NULL,NULL,'"drvAddressPostalCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPICPRUEXPZ0','35','D','10','22',NULL,'Associate Country Code 1',NULL,NULL,'"USA"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPICPRUEXPZ0','25','D','10','23',NULL,'Associate Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPICPRUEXPZ0','64','D','10','24',NULL,'Associate Address Line 1 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPICPRUEXPZ0','64','D','10','25',NULL,'Associate Address Line 2 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPICPRUEXPZ0','64','D','10','26',NULL,'Associate Address Line 3 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPICPRUEXPZ0','50','D','10','27',NULL,'Associate City Name 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPICPRUEXPZ0','2','D','10','28',NULL,'Associate State Province Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPICPRUEXPZ0','12','D','10','29',NULL,'Associate Postal Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPICPRUEXPZ0','35','D','10','30',NULL,'Associate Country Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPICPRUEXPZ0','25','D','10','31',NULL,'Associate Address Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPICPRUEXPZ0','64','D','10','32',NULL,'Associate Address Line 1 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPICPRUEXPZ0','64','D','10','33',NULL,'Associate Address Line 2 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPICPRUEXPZ0','64','D','10','34',NULL,'Associate Address Line 3 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPICPRUEXPZ0','50','D','10','35',NULL,'Associate City Name 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPICPRUEXPZ0','2','D','10','36',NULL,'Associate State Province Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPICPRUEXPZ0','12','D','10','37',NULL,'Associate Postal Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPICPRUEXPZ0','35','D','10','38',NULL,'Associate Country Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPICPRUEXPZ0','30','D','10','39',NULL,'Associate Telephone Type Code 1',NULL,NULL,'"drvHomeTelephoneCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPICPRUEXPZ0','20','D','10','40',NULL,'Associate Telephone Number 1',NULL,NULL,'"drvHomeTelehoneNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPICPRUEXPZ0','10','D','10','41',NULL,'Associate Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPICPRUEXPZ0','30','D','10','42',NULL,'Telephone Type Code 2',NULL,NULL,'"drvMobleCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPICPRUEXPZ0','20','D','10','43',NULL,'Associate Telephone Number 2',NULL,NULL,'"drvMobileNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPICPRUEXPZ0','10','D','10','44',NULL,'Associate Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPICPRUEXPZ0','30','D','10','45',NULL,'Associate Telephone Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPICPRUEXPZ0','20','D','10','46',NULL,'Associate Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPICPRUEXPZ0','10','D','10','47',NULL,'Associate Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPICPRUEXPZ0','25','D','10','48',NULL,'Associate Email Address Type Code 1',NULL,NULL,'"drvEmailCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPICPRUEXPZ0','350','D','10','49',NULL,'Associate Email Address Text 1',NULL,NULL,'"drvEmail"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPICPRUEXPZ0','25','D','10','50',NULL,'Associate Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPICPRUEXPZ0','350','D','10','51',NULL,'Associate Email Address Text 2',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPICPRUEXPZ0','3','D','20','1',NULL,'Record Type',NULL,NULL,'"EMP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPICPRUEXPZ0','10','D','20','2',NULL,'Client Control Number',NULL,NULL,'"71102"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPICPRUEXPZ0','32','D','20','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPICPRUEXPZ0','32','D','20','4',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPICPRUEXPZ0','8','D','20','5',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPICPRUEXPZ0','8','D','20','6',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPICPRUEXPZ0','8','D','20','7',NULL,'Retirement Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPICPRUEXPZ0','8','D','20','8',NULL,'Employment Termination Date',NULL,NULL,'"drvTerminationDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPICPRUEXPZ0','25','D','20','9',NULL,'Employment Termination Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPICPRUEXPZ0','8','D','20','10',NULL,'Adjusted Service Date',NULL,NULL,'"drvAdjServiceDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPICPRUEXPZ0','8','D','20','11',NULL,'Last Active Service Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPICPRUEXPZ0','30','D','20','12',NULL,'Employment Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPICPRUEXPZ0','8','D','20','13',NULL,'Employment Status Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPICPRUEXPZ0','30','D','20','14',NULL,'Employment Status Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPICPRUEXPZ0','30','D','20','15',NULL,'Job Title Text',NULL,NULL,'"drvJobTitleText"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPICPRUEXPZ0','30','D','20','16',NULL,'Occupation Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPICPRUEXPZ0','25','D','20','17',NULL,'OSHA Job Classification Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPICPRUEXPZ0','25','D','20','18',NULL,'Occupation Class Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPICPRUEXPZ0','25','D','20','19',NULL,'Work Status Code',NULL,NULL,'"drvWorkStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPICPRUEXPZ0','5','D','20','20',NULL,'Weekly Scheduled Hours',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPICPRUEXPZ0','5','D','20','21',NULL,'Daily Hours Worked',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPICPRUEXPZ0','25','D','20','22',NULL,'Hourly Salary Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPICPRUEXPZ0','30','D','20','23',NULL,'Earnings Type Code 1',NULL,NULL,'"drvEarningsTypeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPICPRUEXPZ0','17','D','20','24',NULL,'Earnings Amount 1',NULL,NULL,'"drvEarningsAmt"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPICPRUEXPZ0','30','D','20','25',NULL,'Earnings Frequency Code 1',NULL,NULL,'"drvEarningsFrequecyCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPICPRUEXPZ0','8','D','20','26',NULL,'Earnings Effective Date 1',NULL,NULL,'"drvEarningsEffectiveDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPICPRUEXPZ0','30','D','20','27',NULL,'Earnings Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPICPRUEXPZ0','17','D','20','28',NULL,'Earnings Amount 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPICPRUEXPZ0','30','D','20','29',NULL,'Earnings Frequency Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPICPRUEXPZ0','8','D','20','30',NULL,'Earnings Effective Date 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPICPRUEXPZ0','30','D','20','31',NULL,'Earnings Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPICPRUEXPZ0','17','D','20','32',NULL,'Earnings Amount 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPICPRUEXPZ0','30','D','20','33',NULL,'Earnings Frequency Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPICPRUEXPZ0','8','D','20','34',NULL,'Earnings Effective Date 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPICPRUEXPZ0','25','D','20','35',NULL,'W4 Filing Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPICPRUEXPZ0','4','D','20','36',NULL,'W4 Exemptions Number',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPICPRUEXPZ0','17','D','20','37',NULL,'W4 Additional Withholding Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPICPRUEXPZ0','2','D','20','38',NULL,'W4 Withholding State Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPICPRUEXPZ0','2','D','20','39',NULL,'W4 Withholding State Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPICPRUEXPZ0','2','D','20','40',NULL,'W4 Withholding State Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPICPRUEXPZ0','12','D','20','41',NULL,'W4 Work Location Postal Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPICPRUEXPZ0','5','D','20','42',NULL,'Union Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPICPRUEXPZ0','25','D','20','43',NULL,'Local Bargaining Unit Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPICPRUEXPZ0','25','D','20','44',NULL,'Member Group Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPICPRUEXPZ0','25','D','20','45',NULL,'Bill Group Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPICPRUEXPZ0','30','D','20','46',NULL,'Payroll Frequency Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPICPRUEXPZ0','25','D','20','47',NULL,'District Location Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPICPRUEXPZ0','30','D','20','48',NULL,'Employment Location',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPICPRUEXPZ0','10','D','20','49',NULL,'Regional Unit',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPICPRUEXPZ0','20','D','20','50',NULL,'Employer Information',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPICPRUEXPZ0','80','D','20','51',NULL,'Group',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPICPRUEXPZ0','2','D','20','52',NULL,'Work Location State Code',NULL,NULL,'"drvWorkLocationStateCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPICPRUEXPZ0','256','D','20','53',NULL,'Comments',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPICPRUEXPZ0','17','D','20','54',NULL,'Year to Date Earnings',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPICPRUEXPZ0','8','D','20','55',NULL,'Earnings As of Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPICPRUEXPZ0','3','D','30','1',NULL,'Record Type',NULL,NULL,'"COV"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPICPRUEXPZ0','10','D','30','2',NULL,'Client Control Number',NULL,NULL,'"71102"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPICPRUEXPZ0','32','D','30','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPICPRUEXPZ0','25','D','30','4',NULL,'Product Code',NULL,NULL,'"drvProductCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPICPRUEXPZ0','25','D','30','5',NULL,'Coverage Tier Code',NULL,NULL,'"EE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPICPRUEXPZ0','25','D','30','6',NULL,'Product Plan Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPICPRUEXPZ0','5','D','30','7',NULL,'Coverage Buy Up Indicator',NULL,NULL,'"false"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPICPRUEXPZ0','17','D','30','8',NULL,'Coverage Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPICPRUEXPZ0','8','D','30','9',NULL,'Coverage Effective Date',NULL,NULL,'"drvCoverageEffDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPICPRUEXPZ0','8','D','30','10',NULL,'Coverage End Date',NULL,NULL,'"drvCoverageEndDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPICPRUEXPZ0','25','D','30','11',NULL,'Coverage Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPICPRUEXPZ0','8','D','30','12',NULL,'Coverage Status Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPICPRUEXPZ0','25','D','30','13',NULL,'Coverage Status Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPICPRUEXPZ0','30','D','30','14',NULL,'Coverage Termination Reduction Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPICPRUEXPZ0','17','D','30','15',NULL,'Coverage Termination Reduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPICPRUEXPZ0','5','D','30','16',NULL,'Flat Benefit Indicator',NULL,NULL,'"false"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPICPRUEXPZ0','50','D','30','17',NULL,'Claim Branch Code',NULL,NULL,'"drvClaimBranchCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPICPRUEXPZ0','25','D','30','18',NULL,'EOB Correspondence Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPICPRUEXPZ0','5','D','30','19',NULL,'Assignment Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPICPRUEXPZ0','8','D','30','20',NULL,'Original LTD Coverage Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPICPRUEXPZ0','25','D','30','21',NULL,'Partner Product Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPICPRUEXPZ0','25','D','30','22',NULL,'Partner Short Benefit Description',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPICPRUEXPZ0','8','D','30','23',NULL,'Client Coverage Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPICPRUEXPZ0','2','D','30','24',NULL,'Benefit Option Identifier',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPICPRUEXPZ0','5','D','30','25',NULL,'Coverage Increase Within 2 years Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPICPRUEXPZ0','3','D','30','26',NULL,'Issuance Age',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPICPRUEXPZ0','25','D','30','27',NULL,'Voluntary Basis',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPICPRUEXPZ0','8','D','30','28',NULL,'Applicant Eligibility Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPICPRUEXPZ0','17','D','30','29',NULL,'Applicant Inforce Benefit Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPICPRUEXPZ0','17','D','30','30',NULL,'Applicant Additional Benefit Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPICPRUEXPZ0','35','D','30','31',NULL,'Applicant Relationship Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPICPRUEXPZ0','5','D','30','32',NULL,'Applicant EOI Branch Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPICPRUEXPZ0','35','D','30','33',NULL,'Deduction Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPICPRUEXPZ0','17','D','30','34',NULL,'Deduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPICPRUEXPZ0','30','D','30','35',NULL,'Deduction Frequency Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPICPRUEXPZ0','2','D','30','36',NULL,'Deduction Withholding State',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPICPRUEXPZ0','30','D','30','37',NULL,'Payroll Deduction Frequency Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPICPRUEXPZ0','17','D','30','38',NULL,'Payroll Deduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPICPRUEXPZ0','32','D','30','39',NULL,'Coverage Event ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPICPRUEXPZ0','40','D','30','40',NULL,'Coverage Event Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPICPRUEXPZ0','8','D','30','41',NULL,'Coverage Event Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPICPRUEXPZ0','8','D','30','42',NULL,'Coverage Marriage Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPICPRUEXPZ0','8','D','30','43',NULL,'Coverage Divorce Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPICPRUEXPZ0','3','D','40','1',NULL,'Record Type',NULL,NULL,'"ABS"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPICPRUEXPZ0','10','D','40','2',NULL,'Client Control Number',NULL,NULL,'"71102"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPICPRUEXPZ0','32','D','40','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPICPRUEXPZ0','50','D','40','4',NULL,'FMLA Branch Code',NULL,NULL,'"drvFMLABranchCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPICPRUEXPZ0','30','D','40','5',NULL,'FMLA Work Location Code',NULL,NULL,'"Corvias"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPICPRUEXPZ0','45','D','40','6',NULL,'Hours Worked in Last 12 Months',NULL,NULL,'"drvHrsWorkedLast12Mts"','(''UNT2''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPICPRUEXPZ0','45','D','40','7',NULL,'As of Date Hours Worked in Last 12 Months',NULL,NULL,'"drvFileRunDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPICPRUEXPZ0','45','D','40','8',NULL,'Hours Worked Since Last File',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPICPRUEXPZ0','45','D','40','9',NULL,'Other Hours Worked in Last 12 Months',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPICPRUEXPZ0','45','D','40','10',NULL,'As of Date Other Hours Worked in Last 12 Months',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPICPRUEXPZ0','45','D','40','11',NULL,'Employment Sector',NULL,NULL,'"PRIVATE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPICPRUEXPZ0','45','D','40','12',NULL,'Employment Type',NULL,NULL,'"PRIVATE BUSINESS EMPLOYER"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPICPRUEXPZ0','45','D','40','13',NULL,'Key EE Indicator',NULL,NULL,'"false"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPICPRUEXPZ0','45','D','40','14',NULL,'Standard Work Schedule',NULL,NULL,'"false"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPICPRUEXPZ0','45','D','40','15',NULL,'Share Leave Relationship Code_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPICPRUEXPZ0','45','D','40','16',NULL,'Shared Leave Relationship SSN_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPICPRUEXPZ0','45','D','40','17',NULL,'Shared Leave Relationship Prefix Code_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPICPRUEXPZ0','45','D','40','18',NULL,'Shared Leave Relationship First Name_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPICPRUEXPZ0','45','D','40','19',NULL,'Shared Leave Relationship Middle Name_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPICPRUEXPZ0','45','D','40','20',NULL,'Shared Leave Relationship Last Name_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPICPRUEXPZ0','45','D','40','21',NULL,'Shared Leave Relationship Suffix Code_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPICPRUEXPZ0','45','D','40','22',NULL,'Shared Leave Relationship EE ID_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPICPRUEXPZ0','45','D','40','23',NULL,'Share Leave Relationship Code_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPICPRUEXPZ0','45','D','40','24',NULL,'Shared Leave Relationship SSN_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPICPRUEXPZ0','45','D','40','25',NULL,'Shared Leave Relationship Prefix Code_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPICPRUEXPZ0','45','D','40','26',NULL,'Shared Leave Relationship First Name_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPICPRUEXPZ0','45','D','40','27',NULL,'Shared Leave Relationship Middle Name_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPICPRUEXPZ0','45','D','40','28',NULL,'Shared Leave Relationship Last Name_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPICPRUEXPZ0','45','D','40','29',NULL,'Shared Leave Relationship Suffix Code_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPICPRUEXPZ0','45','D','40','30',NULL,'Shared Leave Relationship EE ID_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPICPRUEXPZ0','45','D','40','31',NULL,'Share Leave Relationship Code_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPICPRUEXPZ0','45','D','40','32',NULL,'Shared Leave Relationship SSN_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPICPRUEXPZ0','45','D','40','33',NULL,'Shared Leave Relationship Prefix Code_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPICPRUEXPZ0','45','D','40','34',NULL,'Shared Leave Relationship First Name_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPICPRUEXPZ0','45','D','40','35',NULL,'Shared Leave Relationship Middle Name_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPICPRUEXPZ0','45','D','40','36',NULL,'Shared Leave Relationship Last Name_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPICPRUEXPZ0','45','D','40','37',NULL,'Shared Leave Relationship Suffix Code_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPICPRUEXPZ0','45','D','40','38',NULL,'Shared Leave Relationship EE ID_3',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPICPRUEXPZ0','3','D','50','1',NULL,'Record Type',NULL,NULL,'"CCH"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPICPRUEXPZ0','10','D','50','2',NULL,'Client Control Number',NULL,NULL,'"71102"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPICPRUEXPZ0','32','D','50','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPICPRUEXPZ0','25','D','50','4',NULL,'Custom Characteristic Code',NULL,NULL,'"drvReportingCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPICPRUEXPZ0','17','D','50','5',NULL,'Custom Characteristic Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPICPRUEXPZ0','8','D','50','6',NULL,'Custom Characteristic Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPICPRUEXPZ0','5','D','50','7',NULL,'Custom Characteristic Percent',NULL,NULL,'''''''''','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPICPRUEXPZ0','255','D','50','8',NULL,'Custom Characteristic Value Text',NULL,NULL,'"drvReportingValue"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPICPRUEXPZ0','3','D','60','1',NULL,'Record Type',NULL,NULL,'"CON"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPICPRUEXPZ0','10','D','60','2',NULL,'Client Control Number',NULL,NULL,'"71102"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPICPRUEXPZ0','32','D','60','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPICPRUEXPZ0','32','D','60','4',NULL,'Employment Contact ID',NULL,NULL,'"drvContactID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPICPRUEXPZ0','40','D','60','5',NULL,'Employment Contact Type Code',NULL,NULL,'"drvContactType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPICPRUEXPZ0','50','D','60','6',NULL,'Employment Contact First Name',NULL,NULL,'"drvContactFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPICPRUEXPZ0','80','D','60','7',NULL,'Employment Contact Last Name',NULL,NULL,'"drvContactLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPICPRUEXPZ0','50','D','60','8',NULL,'Employment Contact Middle Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPICPRUEXPZ0','30','D','60','9',NULL,'Employment Contact Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPICPRUEXPZ0','30','D','60','10',NULL,'Employment Contact Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPICPRUEXPZ0','30','D','60','11',NULL,'Employment Contact Telephone Type Code 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPICPRUEXPZ0','20','D','60','12',NULL,'Employment Contact Telephone Number 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPICPRUEXPZ0','10','D','60','13',NULL,'Employment Contact Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPICPRUEXPZ0','30','D','60','14',NULL,'Employment Contact Telephone Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPICPRUEXPZ0','20','D','60','15',NULL,'Employment Contact Telephone Number 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPICPRUEXPZ0','10','D','60','16',NULL,'Employment Contact Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPICPRUEXPZ0','30','D','60','17',NULL,'Employment Contact Telephone Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPICPRUEXPZ0','20','D','60','18',NULL,'Employment Contact Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPICPRUEXPZ0','10','D','60','19',NULL,'Employment Contact Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPICPRUEXPZ0','20','D','60','20',NULL,'Employment Contact Email Address Type Code 1',NULL,NULL,'"WORK"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPICPRUEXPZ0','350','D','60','21',NULL,'Employment Contact Email Address Text 1',NULL,NULL,'"drvContactWorkEmail"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPICPRUEXPZ0','25','D','60','22',NULL,'Employment Contact Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPICPRUEXPZ0','350','D','60','23',NULL,'Employment Contact Email Address Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPICPRUEXPZ0','9','D','60','24',NULL,'Employment Contact SSN',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPICPRUEXPZ0','32','D','60','25',NULL,'Employment Contact Employee ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPICPRUEXPZ0','8','D','60','26',NULL,'Employment Contact DOB',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPICPRUEXPZ0','3','T','90','1',NULL,'Record Type',NULL,NULL,'"TRL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPICPRUEXPZ0','32','T','90','2',NULL,'Audit ID',NULL,NULL,'"drvRunDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPICPRUEXPZ0','9','T','90','3',NULL,'Absence Related Employment Information Record Quan',NULL,NULL,'"drvRecordCountABS"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPICPRUEXPZ0','9','T','90','4',NULL,'Associate Record Quantity',NULL,NULL,'"drvRecordCountAST"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPICPRUEXPZ0','9','T','90','5',NULL,'Beneficiary Record Quantity',NULL,NULL,'""','(SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPICPRUEXPZ0','9','T','90','6',NULL,'Coverage Record Quantity',NULL,NULL,'"drvRecordCountCOV"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPICPRUEXPZ0','9','T','90','7',NULL,'Dependent Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPICPRUEXPZ0','9','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL,'"drvRecordCountCON"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPICPRUEXPZ0','9','T','90','9',NULL,'Employment Information Record Quantity',NULL,NULL,'"drvRecordCountEMP"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPICPRUEXPZ0','9','T','90','10',NULL,'Event Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPICPRUEXPZ0','9','T','90','11',NULL,'Preference Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPICPRUEXPZ0','9','T','90','12',NULL,'Custom Characteristics Record Quantity',NULL,NULL,'"drvRecordCountCCH"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPICPRUEXPZ0','17','T','90','13',NULL,'Total Coverage Amount',NULL,NULL,'"drvTotalCovAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPICPRUEXPZ0','9','T','90','14',NULL,'Total Record Quantity',NULL,NULL,'"drvTotalRecordCount"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPICPRUEXP_20230525.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Voluntary Life Expo','202304149','EMPEXPORT','ONDEM_XOE',NULL,'EPICPRUEXP',NULL,NULL,NULL,'202304149','Apr 14 2023  1:44PM','Apr 14 2023  1:44PM','202304141',NULL,'','','202304141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',P1QVW,CLMFC,FO23O',NULL,NULL,NULL,'Prudential Voluntary Lif-Sched','202304219','EMPEXPORT','SCH_EPICPR',NULL,'EPICPRUEXP',NULL,NULL,NULL,'202304219','Apr 14 2023  1:44PM','Apr 14 2023  1:44PM','202304081',NULL,'','','202304081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','P1QVW,CLMFC,FO23O',NULL,NULL,NULL,'Prudential Voluntary Lif-Test','202305199','EMPEXPORT','TEST_XOE',NULL,'EPICPRUEXP',NULL,NULL,NULL,'202305199','Apr 14 2023  1:44PM','Apr 14 2023  1:44PM','202305061',NULL,'','','202305061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPICPRUEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPICPRUEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPICPRUEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPICPRUEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPICPRUEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPICPRUEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPICPRUEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPICPRUEXP','H01','dbo.U_EPICPRUEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPICPRUEXP','D10','dbo.U_EPICPRUEXP_drvTbl_Associate',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPICPRUEXP','D20','dbo.U_EPICPRUEXP_drvTbl_Employment',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPICPRUEXP','D30','dbo.U_EPICPRUEXP_drvTbl_Cov',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPICPRUEXP','D40','dbo.U_EPICPRUEXP_drvTbl_Absence',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPICPRUEXP','D50','dbo.U_EPICPRUEXP_drvTbl_Custom',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPICPRUEXP','D60','dbo.U_EPICPRUEXP_drvTbl_Contact',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPICPRUEXP','T90','dbo.U_EPICPRUEXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EPICPRUEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EPICPRUEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPICPRUEXP] (
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
-- Create table U_EPICPRUEXP_Audit
-----------

IF OBJECT_ID('U_EPICPRUEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EPICPRUEXP_AuditFields
-----------

IF OBJECT_ID('U_EPICPRUEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EPICPRUEXP_DedList
-----------

IF OBJECT_ID('U_EPICPRUEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPICPRUEXP_drvTbl_Absence
-----------

IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Absence') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_drvTbl_Absence] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(10) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvAssociateID] char(9) NULL,
    [drvFMLABranchCode] varchar(5) NOT NULL,
    [drvHrsWorkedLast12Mts] nvarchar(4000) NULL,
    [drvFileRunDate] varchar(8) NULL
);

-----------
-- Create table U_EPICPRUEXP_drvTbl_Associate
-----------

IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Associate') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_drvTbl_Associate] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(10) NULL,
    [drvAssociateID] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvGender] varchar(7) NOT NULL,
    [drvDateofBirth] varchar(30) NULL,
    [drvMaritalStatus] varchar(8) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressPostalCode] varchar(50) NULL,
    [drvHomeTelephoneCode] varchar(4) NULL,
    [drvHomeTelehoneNumber] varchar(50) NULL,
    [drvMobleCode] varchar(6) NULL,
    [drvMobileNumber] varchar(50) NULL,
    [drvEmailCode] varchar(4) NULL,
    [drvEmail] varchar(50) NULL
);

-----------
-- Create table U_EPICPRUEXP_drvTbl_Contact
-----------

IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Contact') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_drvTbl_Contact] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(10) NULL,
    [drvAssociateID] char(9) NULL,
    [drvContactID] varchar(9) NOT NULL,
    [drvContactType] varchar(6) NOT NULL,
    [drvContactFirstName] varchar(7) NOT NULL,
    [drvContactLastName] varchar(8) NOT NULL,
    [drvContactWorkEmail] varchar(27) NOT NULL
);

-----------
-- Create table U_EPICPRUEXP_drvTbl_Cov
-----------

IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Cov') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_drvTbl_Cov] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(10) NULL,
    [drvAssociateID] char(9) NULL,
    [drvProductCode] varchar(3) NULL,
    [drvCoverageEffDate] varchar(30) NULL,
    [drvCoverageEndDate] datetime NULL,
    [drvClaimBranchCode] varchar(5) NULL
);

-----------
-- Create table U_EPICPRUEXP_drvTbl_Custom
-----------

IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Custom') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_drvTbl_Custom] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(10) NULL,
    [drvAssociateID] char(9) NULL,
    [drvReportingCode] varchar(16) NULL,
    [drvReportingValue] varchar(25) NULL
);

-----------
-- Create table U_EPICPRUEXP_drvTbl_Employment
-----------

IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Employment') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_drvTbl_Employment] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(10) NULL,
    [drvAssociateID] char(9) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvHireDate] varchar(30) NULL,
    [drvRehireDate] varchar(30) NULL,
    [drvTerminationDate] varchar(30) NULL,
    [drvAdjServiceDate] varchar(30) NULL,
    [drvJobTitleText] varchar(25) NOT NULL,
    [drvWorkStatusCode] varchar(9) NULL,
    [drvEarningsTypeCode] varchar(8) NOT NULL,
    [drvEarningsAmt] money NULL,
    [drvEarningsFrequecyCode] varchar(6) NOT NULL,
    [drvEarningsEffectiveDate] varchar(30) NULL,
    [drvWorkLocationStateCode] varchar(255) NULL
);

-----------
-- Create table U_EPICPRUEXP_EEList
-----------

IF OBJECT_ID('U_EPICPRUEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPICPRUEXP_File
-----------

IF OBJECT_ID('U_EPICPRUEXP_File') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EPICPRUEXP_Header
-----------

IF OBJECT_ID('U_EPICPRUEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_Header] (
    [drvCurrentTime] varchar(14) NULL,
    [drvTestorProdCode] varchar(10) NOT NULL,
    [drvActivityStartTime] varchar(8) NULL,
    [drvActivityEndTime] varchar(14) NULL
);

-----------
-- Create table U_EPICPRUEXP_PEarHist
-----------

IF OBJECT_ID('U_EPICPRUEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCompHrs12MO] nvarchar(4000) NULL
);

-----------
-- Create table U_EPICPRUEXP_Trailer
-----------

IF OBJECT_ID('U_EPICPRUEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EPICPRUEXP_Trailer] (
    [drvRunDate] varchar(8) NULL,
    [drvRecordCountABS] int NULL,
    [drvRecordCountAST] int NULL,
    [drvRecordCountCOV] int NULL,
    [drvRecordCountCON] int NULL,
    [drvRecordCountEMP] int NULL,
    [drvRecordCountCCH] int NULL,
    [drvTotalCovAmount] money NULL,
    [drvTotalRecordCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPICPRUEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Corvias Group, LLC

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 04/14/2023
Service Request Number: TekP-2023-03-01-03

Purpose: Prudential Voluntary Life Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPICPRUEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPICPRUEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPICPRUEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPICPRUEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPICPRUEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPICPRUEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPICPRUEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPICPRUEXP', 'SCH_EPICPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPICPRUEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPICPRUEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(4)
            ,@RundateTime       VARCHAR(14)
            ,@MinCovDate        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EPICPRUEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@RunTime         = REPLACE(CONVERT(VARCHAR(5), GETDATE(), 108),':',SPACE(0))
        ,@RundateTime     = FORMAT(GETDATE(),'yyyyMMddhhmmss')
        ,@MinCovDate      = '01/01/2023'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EPICPRUEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPICPRUEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EPICPRUEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_AuditFields;
    CREATE TABLE dbo.U_EPICPRUEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    
    INSERT INTO dbo.U_EPICPRUEXP_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EPICPRUEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EPICPRUEXP_AuditFields VALUES ('EmpComp','EecTermReason');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EPICPRUEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EPICPRUEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EPICPRUEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN  DATEADD(DD,-30,@StartDate)and @EndDate 
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EPICPRUEXP_Audit ON dbo.U_EPICPRUEXP_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EPICPRUEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EPICPRUEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GTL,BLIF2,LIFEA,LIFEC,LIFEE,LIFES';

    IF OBJECT_ID('U_EPICPRUEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPICPRUEXP_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EPICPRUEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_PEarHist;
   SELECT DISTINCT
         PehEEID
        --,PrgPayDate             = MAX(PrgPayDate)
        ---- Current Payroll Amount/Hours
        --,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        ---- YTD Payroll Amount/Hours
        --,PehCurAmtYTD           = SUM(PehCurAmt)
        --,PehCurHrsYTD           = SUM(PehCurHrs)
        ---- Current Include Deferred Comp Amount/Hours
        --,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        --,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        ---- YTD Include Deferred Comp Amount/Hours
        --,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehCompHrs12MO = Format(SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END), '0.00')
    INTO dbo.U_EPICPRUEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE  PehPerControl  between CONVERT(VARCHAR, DATEADD(D,-365,@EndDate), 112) + '1' and @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurHrs) > 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPICPRUEXP_drvTbl_Associate
    ---------------------------------
    IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Associate','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_drvTbl_Associate;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort ='2'
        ,drvSubSort =  EecEmpNo +'2'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvSSN = eepSSN
        ,drvGender =  CASE WHEN EepGender = 'F' THEN 'FEMALE'
                           WHEN EepGender = 'M' THEN 'Male'   ELSE 'UNKNOWN'
                        END
        ,drvDateofBirth = Convert(varchar,EepDateOfBirth, 112)
        ,drvMaritalStatus = CASE WHEN EepMaritalStatus = 'S' THEN 'SINGLE'
                                 WHEN EepMaritalStatus = 'M' THEN 'MARRIED'
                                 WHEN EepMaritalStatus = 'D' THEN 'DIVORCED'
                                 WHEN EepMaritalStatus = 'W' THEN 'WIDOWED' 
                                ELSE 'UNKNOWN'
                            END
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressPostalCode = CASE WHEN LEN(EepAddressZipCode) > 5 THEN LEFT(LTRIM(RTRIM(EepAddressZipCode)),5) + '-' + RIGHT(LTRIM(RTRIM(EepAddressZipCode)),4) ELSE  EepAddressZipCode END
        ,drvHomeTelephoneCode = CASE WHEn ISNULL(eepPhoneHomeNumber, '') <> '' THEN 'HOME' END
        ,drvHomeTelehoneNumber = CASE WHEn ISNULL(eepPhoneHomeNumber, '') <> '' THEN eepPhoneHomeNumber END
        ,drvMobleCode = CASE WHEn ISNULL(EfoPhoneNumber, '') <> '' THEN 'MOBILE' END
        ,drvMobileNumber = CASE WHEn ISNULL(EfoPhoneNumber, '') <> '' THEN EfoPhoneNumber END
        ,drvEmailCode = CASE WHEn ISNULL(EepAddressEMail, '') <> '' THEN 'WORK' END 
        ,drvEmail = CASE WHEn ISNULL(EepAddressEMail, '') <> '' THEN EepAddressEMail END 
    INTO dbo.U_EPICPRUEXP_drvTbl_Associate
    FROM dbo.U_EPICPRUEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EPICPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
                SELECT EfoEEID, EfoPhoneNumber
                FROM (
                        SELECT EfoEEID, EfoPhoneNumber, ROW_NUMBER() OVER (PARTITION BY EfoEEID ORDER BY EfoPhoneNumber) AS RN --, ORDER BY Ef
                        FROM  dbo.EmpMPhon WITH (NOLOCK)
                        WHERE EfoPhoneType = 'CEL') AS Efo
                WHERE RN = 1 ) AS EfoPhone
        ON EfoEEID = xEEID
    LEFT JOIN dbo.U_EPICPRUEXP_Audit WITH (NOLOCK)
        ON AudEEID = XEEID 
        and AudCOID = XCOID
    WHERE EecEEType <> 'TES' and (eecemplstatus <> 'T' or (eecemplstatus = 'T'  and eecTermReason <> 'TRO' and audTerm = 'Y' AND eecDateofTermination between DATEADD( D,-30, @enddate) and @enddate))
    and EecEmpNo not in ('001000','998899')
    
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPICPRUEXP_drvTbl_Employment
    ---------------------------------
    IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Employment','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_drvTbl_Employment;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '3'
        ,drvSubSort =  EecEmpNo +'3'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo --''
        ,drvEmployeeID = EecEmpNo
        ,drvHireDate = Convert(varchar,EecDateOfOriginalHire, 112)
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfSeniority THEN Convert(varchar,EecDateOfSeniority, 112) END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN Convert(varchar,EecDateOfTermination, 112) END
        ,drvAdjServiceDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfSeniority THEN Convert(varchar,EecDateOfSeniority, 112) END
        ,drvJobTitleText = JbcDesc
        ,drvWorkStatusCode = CASE WHEN EecFulltimeOrPartTime = 'F' THEN 'FULL TIME' WHEN EecFulltimeOrPartTime  = 'P' THEN 'PART TIME' END---CASE WHEN JbcFLSAType = 'F' THEN 'FULL TIME' WHEN JbcFLSAType = 'P' THEN 'PART TIME' END
        ,drvEarningsTypeCode = 'BASE PAY'
        ,drvEarningsAmt = CASE WHEn EecEmpNo not in ('001000','998899') THEN EecAnnSalary END -- Please exclude  EecEmpNo '001000' - this is the Owner/Founder
        ,drvEarningsFrequecyCode = 'ANNUAL'
        ,drvEarningsEffectiveDate = Convert(varchar,dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfSeniority), 112)
        ,drvWorkLocationStateCode = LocAddressState
    INTO dbo.U_EPICPRUEXP_drvTbl_Employment
    FROM dbo.U_EPICPRUEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_EPICPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID 
    LEFT JOIN dbo.LOCATION WITH (NOLOCK)
       ON LocCode = EecLocation
    LEFT JOIN dbo.U_EPICPRUEXP_Audit WITH (NOLOCK)
        ON AudEEID = XEEID 
        and AudCOID = XCOID
    WHERE EecEEType <> 'TES' and (eecemplstatus <> 'T' or (eecemplstatus = 'T'  and eecTermReason <> 'TRO' and audTerm = 'Y' AND eecDateofTermination between DATEADD( D,-30, @enddate) and @enddate))
    and EecEmpNo not in ('001000','998899')
    ;

    ---------------------------------
        
    ---------------------------------
    IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Cov','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_drvTbl_Cov;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '4'
        ,drvSubSort =  EecEmpNo +'4'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvProductCode = CASE WHEN Bdm1.BdmDedCode = 'BLIF2' THEN 'WDI' --'STD'
                               WHEN Bdm2.BdmDedCode = 'BLIF2' THEN 'LTD'
                              END
        ,drvCoverageEffDate = Convert(varchar,DATEADD(month, DATEDIFF(month, 2, dateadd(d, 90, EecDateOfSeniority)), 0) , 112)
        ,drvCoverageEndDate =   CASE WHEN Bdm1.BdmDedCode = 'BLIF2' and bdm1.BdmBenStopDate is not null THEN Convert(varchar,bdm1.BdmBenStopDate, 112)
							   WHEN Bdm2.BdmDedCode = 'BLIF2' and bdm2.BdmBenStopDate is not null THEN Convert(varchar,bdm2.BdmBenStopDate, 112)
                              END
        ,drvClaimBranchCode = CASE WHEN Bdm1.BdmDedCode = 'BLIF2' THEN '00001' --'STD'
                               WHEN Bdm2.BdmDedCode = 'BLIF2' THEN '00001'
                              END
    INTO dbo.U_EPICPRUEXP_drvTbl_Cov
    FROM dbo.U_EPICPRUEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPICPRUEXP Bdm1 WITH (NOLOCK)
        ON bdm1.BdmEEID = xEEID 
        AND bdm1.BdmCoID = xCoID        
    JOIN dbo.U_dsi_BDM_EPICPRUEXP Bdm2 WITH (NOLOCK)
        ON bdm2.BdmEEID = xEEID 
        AND bdm2.BdmCoID = xCoID
        and Bdm2.BdmDedCode = 'BLIF2'
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_EPICPRUEXP_Audit WITH (NOLOCK)
        ON AudEEID = XEEID 
        and AudCOID = XCOID
    WHERE EecEEType <> 'TES' and (eecemplstatus <> 'T' or (eecemplstatus = 'T'  and eecTermReason <> 'TRO' and audTerm = 'Y' AND eecDateofTermination between DATEADD( D,-30, @enddate) and @enddate))
    and EecEmpNo not in ('001000','998899')
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EPICPRUEXP_drvTbl_Absence
    ---------------------------------
    IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Absence','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_drvTbl_Absence;
        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = '5'
        ,drvSubSort =  EecEmpNo +'5'
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvFMLABranchCode = '00001'
        ,drvHrsWorkedLast12Mts = PehCompHrs12MO
        ,drvFileRunDate = @Rundate
    INTO dbo.U_EPICPRUEXP_drvTbl_Absence
    FROM dbo.U_EPICPRUEXP_EEList WITH (NOLOCK)
     JOIN dbo.U_dsi_BDM_EPICPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
     JOIN dbo.U_EPICPRUEXP_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID 
    LEFT JOIN dbo.U_EPICPRUEXP_Audit WITH (NOLOCK)
        ON AudEEID = XEEID 
        and AudCOID = XCOID
    WHERE EecEEType <> 'TES' and (eecemplstatus <> 'T' or (eecemplstatus = 'T'  and eecTermReason <> 'TRO' and audTerm = 'Y' AND eecDateofTermination between DATEADD( D,-30, @enddate) and @enddate))
    and EecEmpNo not in ('001000','998899')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPICPRUEXP_drvTbl_Custom
    ---------------------------------
    IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Custom','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_drvTbl_Custom;
   
   SELECT * 
   INTO dbo.U_EPICPRUEXP_drvTbl_Custom
     FROM  
     ( SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '6'
        ,drvSubSort =  EecEmpNo + '6'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvReportingCode = CASE WHEN EecOrgLvl1 is not null then 'Reporting Code 1'
                                -- WHEN EecOrgLvl4 is not null then 'Reporting Code 2'
                                -- WHEN EecOrgLvl2 is not null then 'Reporting Code 3'
                                END
        ,drvReportingValue = CASE WHEN EecOrgLvl1 is not null then (SELECT top 1 o1.OrgDesc from vw_int_OrgLevel o1 with (nolock) where eecorglvl1 = o1.orgcode and o1.orglvl = '1')
                                 -- WHEN EecOrgLvl4 is not null then (SELECT top 1 o4.OrgDesc from vw_int_OrgLevel o4 with (nolock) where eecorglvl4 = o4.orgcode and o4.orglvl = '4')
                                 -- WHEN EecOrgLvl2 is not null then (SELECT top 1 o2.OrgDesc from vw_int_OrgLevel o2 with (nolock) where eecorglvl2 = o2.orgcode and o2.orglvl = '2')
                                END
    --INTO dbo.U_EPICPRUEXP_drvTbl_Custom
    FROM dbo.U_EPICPRUEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPICPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_EPICPRUEXP_Audit WITH (NOLOCK)
        ON AudEEID = XEEID 
        and AudCOID = XCOID
        WHERE EecEEType <> 'TES' and (eecemplstatus <> 'T' or (eecemplstatus = 'T'  and eecTermReason <> 'TRO' and audTerm = 'Y' AND eecDateofTermination between DATEADD( D,-30, @enddate) and @enddate))
        and EecEmpNo not in ('001000','998899')

Union
SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '6'
        ,drvSubSort =  EecEmpNo + '6'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvReportingCode = CASE --WHEN EecOrgLvl1 is not null then 'Reporting Code 1'
                                 WHEN EecOrgLvl4 is not null then 'Reporting Code 2'
                                -- WHEN EecOrgLvl2 is not null then 'Reporting Code 3'
                                END
        ,drvReportingValue = CASE --WHEN EecOrgLvl1 is not null then (SELECT top 1 o1.OrgDesc from vw_int_OrgLevel o1 with (nolock) where eecorglvl1 = o1.orgcode and o1.orglvl = '1')
                                  WHEN EecOrgLvl4 is not null then (SELECT top 1 o4.OrgDesc from vw_int_OrgLevel o4 with (nolock) where eecorglvl4 = o4.orgcode and o4.orglvl = '4')
                                  --WHEN EecOrgLvl2 is not null then (SELECT top 1 o2.OrgDesc from vw_int_OrgLevel o2 with (nolock) where eecorglvl2 = o2.orgcode and o2.orglvl = '2')
                                END
    --INTO dbo.U_EPICPRUEXP_drvTbl_Custom
    FROM dbo.U_EPICPRUEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPICPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_EPICPRUEXP_Audit WITH (NOLOCK)
        ON AudEEID = XEEID 
        and AudCOID = XCOID
    WHERE EecEEType <> 'TES' and (eecemplstatus <> 'T' or (eecemplstatus = 'T'  and eecTermReason <> 'TRO' and audTerm = 'Y' AND eecDateofTermination between DATEADD( D,-30, @enddate) and @enddate))
    and EecEmpNo not in ('001000','998899')
    Union
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '6'
        ,drvSubSort =  EecEmpNo + '6'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvReportingCode = CASE --WHEN EecOrgLvl1 is not null then 'Reporting Code 1'
                                 --WHEN EecOrgLvl4 is not null then 'Reporting Code 2'
                                 WHEN EecOrgLvl2 is not null then 'Reporting Code 3'
                                END
        ,drvReportingValue = CASE-- WHEN EecOrgLvl1 is not null then (SELECT top 1 o1.OrgDesc from vw_int_OrgLevel o1 with (nolock) where eecorglvl1 = o1.orgcode and o1.orglvl = '1')
                                 -- WHEN EecOrgLvl4 is not null then (SELECT top 1 o4.OrgDesc from vw_int_OrgLevel o4 with (nolock) where eecorglvl4 = o4.orgcode and o4.orglvl = '4')
                                  WHEN EecOrgLvl2 is not null then (SELECT top 1 o2.OrgDesc from vw_int_OrgLevel o2 with (nolock) where eecorglvl2 = o2.orgcode and o2.orglvl = '2')
                                END
    --INTO dbo.U_EPICPRUEXP_drvTbl_Custom
    FROM dbo.U_EPICPRUEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPICPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_EPICPRUEXP_Audit WITH (NOLOCK)
        ON AudEEID = XEEID 
        and AudCOID = XCOID
        WHERE EecEEType <> 'TES' and (eecemplstatus <> 'T' or (eecemplstatus = 'T'  and eecTermReason <> 'TRO' and audTerm = 'Y' AND eecDateofTermination between DATEADD( D,-30, @enddate) and @enddate))
        and EecEmpNo not in ('001000','998899')
        )a
    Where drvReportingCode is not null and drvReportingValue is not null
    
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPICPRUEXP_drvTbl_Contact
    ---------------------------------
    IF OBJECT_ID('U_EPICPRUEXP_drvTbl_Contact','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_drvTbl_Contact;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '7'
        ,drvSubSort =  EecEmpNo + '7'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvContactID = 'Contact 1'--Send Contact1 for Beverly Villwok Send Contact2 for Wanda Houlihan
        ,drvContactType = 'HR REP'
        ,drvContactFirstName = 'Beverly' --Send Beverly for Contact1 Send Wanda for Contact2
        ,drvContactLastName = 'Villwok'--Send Villwok for Contact1 Send Houlihan for Contact2
        ,drvContactWorkEmail = 'beverly.villwok@corvias.com' --Send beverly.villwok@corvias.com for Contact1 Send wanda.houlihan@corvias.com for Contact2
    INTO dbo.U_EPICPRUEXP_drvTbl_Contact
    FROM dbo.U_EPICPRUEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EPICPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_EPICPRUEXP_Audit WITH (NOLOCK)
        ON AudEEID = XEEID 
        and AudCOID = XCOID
    WHERE EecEEType <> 'TES' and (eecemplstatus <> 'T' or (eecemplstatus = 'T'  and eecTermReason <> 'TRO' and audTerm = 'Y' AND eecDateofTermination between DATEADD( D,-30, @enddate) and @enddate))
    and EecEmpNo not in ('001000','998899')

    Union

     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '7'
        ,drvSubSort =  EecEmpNo + '7'
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvContactID = 'Contact 2'--Send Contact1 for Beverly Villwok Send Contact2 for Wanda Houlihan
        ,drvContactType = 'HR REP'
        ,drvContactFirstName = 'Wanda' --Send Beverly for Contact1 Send Wanda for Contact2
        ,drvContactLastName = 'Houlihan'--Send Villwok for Contact1 Send Houlihan for Contact2
        ,drvContactWorkEmail = 'wanda.houlihan@corvias.com' --Send beverly.villwok@corvias.com for Contact1 Send wanda.houlihan@corvias.com for Contact2
   -- INTO dbo.U_EPICPRUEXP_drvTbl_Contact
    FROM dbo.U_EPICPRUEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EPICPRUEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
     LEFT JOIN dbo.U_EPICPRUEXP_Audit WITH (NOLOCK)
        ON AudEEID = XEEID 
        and AudCOID = XCOID
    WHERE EecEEType <> 'TES' and (eecemplstatus <> 'T' or (eecemplstatus = 'T'  and eecTermReason <> 'TRO' and audTerm = 'Y' AND eecDateofTermination between DATEADD( D,-30, @enddate) and @enddate))
    and EecEmpNo not in ('001000','998899')
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPICPRUEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_Header;
      SELECT DISTINCT
         drvCurrentTime = @RundateTime 
        ,drvTestorProdCode = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'TEST' ELSE 'PRODUCTION' END
        ,drvActivityStartTime = Convert(varchar(8),Dateadd( d, -6,@RunDate),112)
        ,drvActivityEndTime = @RundateTime 
    INTO dbo.U_EPICPRUEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPICPRUEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EPICPRUEXP_Trailer;
    SELECT DISTINCT
         drvRunDate = @RunDate
         ,drvRecordCountABS = (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Absence WITH (NOLOCK) )
        ,drvRecordCountAST = (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Associate WITH (NOLOCK) )
        ,drvRecordCountCOV = (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Cov WITH (NOLOCK) )
        ,drvRecordCountCON = (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Contact WITH (NOLOCK) )
        ,drvRecordCountEMP = (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Employment WITH (NOLOCK) )
        ,drvRecordCountCCH = (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Custom WITH (NOLOCK) )
        ,drvTotalCovAmount = (SELECT SUM(BdmEEAmt) FROM dbo.U_dsi_BDM_EPICPRUEXP WITH (NOLOCK) Where BdmDedcode IN ('GTL','BLIF2','LIFEA','LIFEC','LIFEE','LIFES')) 
        ,drvTotalRecordCount = (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Custom WITH (NOLOCK)) + (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Employment  WITH (NOLOCK)) + (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Contact  WITH (NOLOCK))
                                +(Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Cov WITH (NOLOCK))+ (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Associate  WITH (NOLOCK)) + (Select Distinct Count(*) From dbo.U_EPICPRUEXP_drvTbl_Absence WITH (NOLOCK))
    INTO dbo.U_EPICPRUEXP_Trailer
    
        
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
ALTER VIEW dbo.dsi_vwEPICPRUEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPICPRUEXP_File (NOLOCK)
     ORDER BY subsort2, SubSort ,InitialSort, RIGHT(RecordSet,2);

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EPICPRUEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;


--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304071'
       ,expStartPerControl     = '202304071'
       ,expLastEndPerControl   = '202304149'
       ,expEndPerControl       = '202304149'
WHERE expFormatCode = 'EPICPRUEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPICPRUEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPICPRUEXP_File (NOLOCK)
     ORDER BY subsort2, SubSort ,InitialSort, RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPICPRUEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPICPRUEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPICPRUEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPICPRUEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPICPRUEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPICPRUEXP', 'UseFileName', 'V', 'Y'


-- End ripout