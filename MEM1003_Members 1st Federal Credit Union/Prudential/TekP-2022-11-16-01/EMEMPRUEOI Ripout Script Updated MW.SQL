/**********************************************************************************

EMEMPRUEOI: Prudential Vol Life EOI

FormatCode:     EMEMPRUEOI
Project:        Prudential Vol Life EOI
Client ID:      MEM1003
Date/time:      2023-12-28 09:46:27.287
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E15
Server:         E1SUP5DB01
Database:       ULTIPRO_MFCU
Web Filename:   MEM1003_E8BA4_EEHISTORY_EMEMPRUEOI_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMEMPRUEOI_SavePath') IS NOT NULL DROP TABLE dbo.U_EMEMPRUEOI_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMEMPRUEOI'


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
WHERE FormatCode = 'EMEMPRUEOI'
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
WHERE ExpFormatCode = 'EMEMPRUEOI'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMEMPRUEOI')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMEMPRUEOI'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMEMPRUEOI'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMEMPRUEOI'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMEMPRUEOI'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMEMPRUEOI'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMEMPRUEOI'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMEMPRUEOI'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMEMPRUEOI'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMEMPRUEOI'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMEMPRUEOI_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMEMPRUEOI_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMEMPRUEOI') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMEMPRUEOI];
GO
IF OBJECT_ID('U_EMEMPRUEOI_TRL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_TRL_drvTbl];
GO
IF OBJECT_ID('U_EMEMPRUEOI_LOA_Dates') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_LOA_Dates];
GO
IF OBJECT_ID('U_EMEMPRUEOI_HDR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_HDR_drvTbl];
GO
IF OBJECT_ID('U_EMEMPRUEOI_File') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_File];
GO
IF OBJECT_ID('U_EMEMPRUEOI_EMP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_EMP_drvTbl];
GO
IF OBJECT_ID('U_EMEMPRUEOI_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_EEList];
GO
IF OBJECT_ID('U_EMEMPRUEOI_DEP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_DEP_drvTbl];
GO
IF OBJECT_ID('U_EMEMPRUEOI_COV_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_COV_drvTbl];
GO
IF OBJECT_ID('U_EMEMPRUEOI_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_AuditFields];
GO
IF OBJECT_ID('U_EMEMPRUEOI_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_Audit];
GO
IF OBJECT_ID('U_EMEMPRUEOI_AST_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_AST_drvTbl];
GO
IF OBJECT_ID('U_EMEMPRUEOI_AGE') IS NOT NULL DROP TABLE [dbo].[U_EMEMPRUEOI_AGE];
GO
IF OBJECT_ID('U_dsi_BDM_EMEMPRUEOI') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMEMPRUEOI];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMEMPRUEOI','Prudential Vol Life EOI','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EMEMPRUEOIZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMEMPRUEOIZ0','3','H','01','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMEMPRUEOIZ0','32','H','01','2',NULL,'Transmission GUID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMEMPRUEOIZ0','14','H','01','3',NULL,'Creation Date Time',NULL,NULL,'"drvCreationDateTime"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMEMPRUEOIZ0','10','H','01','4',NULL,'Client Control Number',NULL,NULL,'"drvClientControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMEMPRUEOIZ0','80','H','01','5',NULL,'Client Name',NULL,NULL,'"Members 1st Federal Credit Union"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMEMPRUEOIZ0','6','H','01','6',NULL,'SchemaVersionIdentifier',NULL,NULL,'"Value 2.0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMEMPRUEOIZ0','80','H','01','7',NULL,'Sender Name',NULL,NULL,'"UKG"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMEMPRUEOIZ0','80','H','01','8',NULL,'Sender Platform Name',NULL,NULL,'"Ultipro"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMEMPRUEOIZ0','10','H','01','9',NULL,'Test Production Code',NULL,NULL,'"drvTestProductionCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMEMPRUEOIZ0','12','H','01','10',NULL,'Transmission Type Code',NULL,NULL,'"FULL FILE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMEMPRUEOIZ0','14','H','01','11',NULL,'Activity Start Date Time',NULL,NULL,'"drvActivityStartDateTime"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMEMPRUEOIZ0','14','H','01','12',NULL,'Activity End Date Time',NULL,NULL,'"drvActivityEndDateTime "','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMEMPRUEOIZ0','3','D','10','1',NULL,'Record Type',NULL,NULL,'"AST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMEMPRUEOIZ0','10','D','10','2',NULL,'Client Control Number',NULL,NULL,'"drvClientControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMEMPRUEOIZ0','32','D','10','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMEMPRUEOIZ0','9','D','10','4',NULL,'Associate Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMEMPRUEOIZ0','25','D','10','5',NULL,'Associate Gender Code',NULL,NULL,'"drvGender"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMEMPRUEOIZ0','8','D','10','6',NULL,'Associate Date of Birth',NULL,NULL,'"drvDateofBirth "','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMEMPRUEOIZ0','8','D','10','7',NULL,'Associate Date of Death',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMEMPRUEOIZ0','25','D','10','8',NULL,'Associate Smoker Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMEMPRUEOIZ0','30','D','10','9',NULL,'Associate Marital Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMEMPRUEOIZ0','30','D','10','10',NULL,'Associate Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMEMPRUEOIZ0','30','D','10','11',NULL,'Associate Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMEMPRUEOIZ0','80','D','10','12',NULL,'Associate Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMEMPRUEOIZ0','50','D','10','13',NULL,'Associate First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMEMPRUEOIZ0','50','D','10','14',NULL,'Associate Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMEMPRUEOIZ0','25','D','10','15',NULL,'Associate Address Type Code 1',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMEMPRUEOIZ0','64','D','10','16',NULL,'Associate Address Line 1 Text 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMEMPRUEOIZ0','64','D','10','17',NULL,'Associate Address Line 2 Text 1',NULL,NULL,'"drvAddressLine2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMEMPRUEOIZ0','64','D','10','18',NULL,'Associate Address Line 3 Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMEMPRUEOIZ0','50','D','10','19',NULL,'Associate City Name 1',NULL,NULL,'"drvAddressCity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMEMPRUEOIZ0','2','D','10','20',NULL,'Associate State Province Code 1',NULL,NULL,'"drvAddressState"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMEMPRUEOIZ0','12','D','10','21',NULL,'Associate Postal Code 1',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMEMPRUEOIZ0','35','D','10','22',NULL,'Associate Country Code 1',NULL,NULL,'"USA"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMEMPRUEOIZ0','25','D','10','23',NULL,'Associate Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMEMPRUEOIZ0','64','D','10','24',NULL,'Associate Address Line 1 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMEMPRUEOIZ0','64','D','10','25',NULL,'Associate Address Line 2 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMEMPRUEOIZ0','64','D','10','26',NULL,'Associate Address Line 3 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMEMPRUEOIZ0','50','D','10','27',NULL,'Associate City Name 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMEMPRUEOIZ0','2','D','10','28',NULL,'Associate State Province Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMEMPRUEOIZ0','12','D','10','29',NULL,'Associate Postal Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMEMPRUEOIZ0','35','D','10','30',NULL,'Associate Country Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMEMPRUEOIZ0','25','D','10','31',NULL,'Associate Address Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMEMPRUEOIZ0','64','D','10','32',NULL,'Associate Address Line 1 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMEMPRUEOIZ0','64','D','10','33',NULL,'Associate Address Line 2 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMEMPRUEOIZ0','64','D','10','34',NULL,'Associate Address Line 3 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMEMPRUEOIZ0','50','D','10','35',NULL,'Associate City Name 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMEMPRUEOIZ0','2','D','10','36',NULL,'Associate State Province Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMEMPRUEOIZ0','12','D','10','37',NULL,'Associate Postal Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMEMPRUEOIZ0','35','D','10','38',NULL,'Associate Country Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMEMPRUEOIZ0','30','D','10','39',NULL,'Associate Telephone Type Code 1',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMEMPRUEOIZ0','20','D','10','40',NULL,'Associate Telephone Number 1',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMEMPRUEOIZ0','10','D','10','41',NULL,'Associate Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMEMPRUEOIZ0','30','D','10','42',NULL,'Telephone Type Code 2',NULL,NULL,'"MOBILE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMEMPRUEOIZ0','20','D','10','43',NULL,'Associate Telephone Number 2',NULL,NULL,'"drvAssTelephoneNumber2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMEMPRUEOIZ0','10','D','10','44',NULL,'Associate Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMEMPRUEOIZ0','30','D','10','45',NULL,'Associate Telephone  Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMEMPRUEOIZ0','20','D','10','46',NULL,'Associate Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMEMPRUEOIZ0','10','D','10','47',NULL,'Associate Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMEMPRUEOIZ0','25','D','10','48',NULL,'Associate Email Address Type Code 1',NULL,NULL,'"drvAssEmail"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMEMPRUEOIZ0','350','D','10','49',NULL,'Associate Email Address Text 1',NULL,NULL,'"drvAddressEmailAlternate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMEMPRUEOIZ0','25','D','10','50',NULL,'Associate Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMEMPRUEOIZ0','350','D','10','51',NULL,'Associate Email Address Text 2',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMEMPRUEOIZ0','3','D','20','1',NULL,'Record Type',NULL,NULL,'"EMP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMEMPRUEOIZ0','10','D','20','2',NULL,'Client Control Number',NULL,NULL,'"drvClientControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMEMPRUEOIZ0','32','D','20','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMEMPRUEOIZ0','32','D','20','4',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMEMPRUEOIZ0','8','D','20','5',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMEMPRUEOIZ0','8','D','20','6',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMEMPRUEOIZ0','8','D','20','7',NULL,'Retirement Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMEMPRUEOIZ0','8','D','20','8',NULL,'Employment Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMEMPRUEOIZ0','25','D','20','9',NULL,'Employment Termination Reason Code',NULL,NULL,'"drvTerminationReasonCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMEMPRUEOIZ0','8','D','20','10',NULL,'Adjusted Service Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMEMPRUEOIZ0','8','D','20','11',NULL,'Last Active Service Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMEMPRUEOIZ0','30','D','20','12',NULL,'Employment Status Code',NULL,NULL,'"drvEmplStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMEMPRUEOIZ0','8','D','20','13',NULL,'Employment Status Effective Date',NULL,NULL,'"drvEmplStatusEffDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMEMPRUEOIZ0','30','D','20','14',NULL,'Employment Status Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMEMPRUEOIZ0','30','D','20','15',NULL,'Job Title Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMEMPRUEOIZ0','30','D','20','16',NULL,'Occupation Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMEMPRUEOIZ0','25','D','20','17',NULL,'OSHA Job Classification Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMEMPRUEOIZ0','25','D','20','18',NULL,'Occupation Class Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMEMPRUEOIZ0','25','D','20','19',NULL,'Work Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMEMPRUEOIZ0','5','D','20','20',NULL,'Weekly Scheduled Hours',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMEMPRUEOIZ0','5','D','20','21',NULL,'Daily Hours Worked',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMEMPRUEOIZ0','25','D','20','22',NULL,'Hourly Salary Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMEMPRUEOIZ0','30','D','20','23',NULL,'Earnings Type  Code 1',NULL,NULL,'"BASE PAY"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMEMPRUEOIZ0','17','D','20','24',NULL,'Earnings  Amount 1',NULL,NULL,'"drvEarningsAmt1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMEMPRUEOIZ0','30','D','20','25',NULL,'Earnings Frequency Code 1',NULL,NULL,'"ANNUAL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMEMPRUEOIZ0','8','D','20','26',NULL,'Earnings Effective  Date 1',NULL,NULL,'"drvEarningsEffDate1"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMEMPRUEOIZ0','30','D','20','27',NULL,'Earnings Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMEMPRUEOIZ0','17','D','20','28',NULL,'Earnings Amount 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMEMPRUEOIZ0','30','D','20','29',NULL,'Earnings Frequency  Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMEMPRUEOIZ0','8','D','20','30',NULL,'Earnings Effective Date 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMEMPRUEOIZ0','30','D','20','31',NULL,'Earnings Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMEMPRUEOIZ0','17','D','20','32',NULL,'Earnings Amount 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMEMPRUEOIZ0','30','D','20','33',NULL,'Earnings Frequency Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMEMPRUEOIZ0','8','D','20','34',NULL,'Earnings Effective Date 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMEMPRUEOIZ0','25','D','20','35',NULL,'W4 Filing Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMEMPRUEOIZ0','4','D','20','36',NULL,'W4 Exemptions Number',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMEMPRUEOIZ0','17','D','20','37',NULL,'W4 Additional Withholding Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMEMPRUEOIZ0','2','D','20','38',NULL,'W4 Withholding State Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMEMPRUEOIZ0','2','D','20','39',NULL,'W4 Withholding State Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMEMPRUEOIZ0','2','D','20','40',NULL,'W4 Withholding State Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMEMPRUEOIZ0','12','D','20','41',NULL,'W4 Work Location Postal Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMEMPRUEOIZ0','5','D','20','42',NULL,'Union Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMEMPRUEOIZ0','25','D','20','43',NULL,'Local Bargaining Unit Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMEMPRUEOIZ0','25','D','20','44',NULL,'Member Group Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMEMPRUEOIZ0','25','D','20','45',NULL,'Bill Group Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMEMPRUEOIZ0','30','D','20','46',NULL,'Payroll Frequency Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMEMPRUEOIZ0','25','D','20','47',NULL,'District Location Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMEMPRUEOIZ0','30','D','20','48',NULL,'Employment Location',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMEMPRUEOIZ0','10','D','20','49',NULL,'Regional Unit',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMEMPRUEOIZ0','20','D','20','50',NULL,'Employer Information',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMEMPRUEOIZ0','80','D','20','51',NULL,'Group',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMEMPRUEOIZ0','2','D','20','52',NULL,'Work Location State Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMEMPRUEOIZ0','256','D','20','53',NULL,'Comments',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EMEMPRUEOIZ0','17','D','20','54',NULL,'Year to Date Earnings',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EMEMPRUEOIZ0','8','D','20','55',NULL,'Earnings As of Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMEMPRUEOIZ0','3','D','40','1',NULL,'Record Type',NULL,NULL,'"DEP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMEMPRUEOIZ0','10','D','40','2',NULL,'Client Control Number',NULL,NULL,'"drvClientControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMEMPRUEOIZ0','32','D','40','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMEMPRUEOIZ0','32','D','40','4',NULL,'DependentID',NULL,NULL,'"drvDependentID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMEMPRUEOIZ0','35','D','40','5',NULL,'Dependent Relationship Type Code',NULL,NULL,'"drvDepRelTypeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMEMPRUEOIZ0','9','D','40','6',NULL,'Dependent Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMEMPRUEOIZ0','25','D','40','7',NULL,'Dependent Gender Code',NULL,NULL,'"drvConGender"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMEMPRUEOIZ0','8','D','40','8',NULL,'Dependent Date of Birth',NULL,NULL,'"drvConDateofBirth"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMEMPRUEOIZ0','8','D','40','9',NULL,'Dependent Date of Death',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMEMPRUEOIZ0','25','D','40','10',NULL,'Dependent Smoker Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMEMPRUEOIZ0','30','D','40','11',NULL,'Dependent Marital Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMEMPRUEOIZ0','30','D','40','12',NULL,'Dependent Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMEMPRUEOIZ0','30','D','40','13',NULL,'Dependent Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMEMPRUEOIZ0','80','D','40','14',NULL,'Dependent Last Name',NULL,NULL,'"drvConLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMEMPRUEOIZ0','50','D','40','15',NULL,'Dependent First Name',NULL,NULL,'"drvConFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMEMPRUEOIZ0','50','D','40','16',NULL,'Dependent Middle Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMEMPRUEOIZ0','25','D','40','17',NULL,'Dependent Address Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMEMPRUEOIZ0','64','D','40','18',NULL,'DependentAddress Line 1 Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMEMPRUEOIZ0','64','D','40','19',NULL,'Dependent Address Line 2 Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMEMPRUEOIZ0','64','D','40','20',NULL,'DependentAddress Line 3 Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMEMPRUEOIZ0','50','D','40','21',NULL,'Dependent City Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMEMPRUEOIZ0','2','D','40','22',NULL,'Dependent State Province Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMEMPRUEOIZ0','12','D','40','23',NULL,'DependentPostal Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMEMPRUEOIZ0','35','D','40','24',NULL,'Dependent Country Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMEMPRUEOIZ0','30','D','40','25',NULL,'Dependent Telephone Type Code 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMEMPRUEOIZ0','20','D','40','26',NULL,'Dependent Telephone Number 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMEMPRUEOIZ0','10','D','40','27',NULL,'Dependent Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMEMPRUEOIZ0','30','D','40','28',NULL,'Dependent Telephone Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMEMPRUEOIZ0','20','D','40','29',NULL,'Dependent Telephone Number 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMEMPRUEOIZ0','10','D','40','30',NULL,'Dependent Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMEMPRUEOIZ0','30','D','40','31',NULL,'Dependent Telephone  Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMEMPRUEOIZ0','20','D','40','32',NULL,'Dependent Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMEMPRUEOIZ0','10','D','40','33',NULL,'Dependent Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMEMPRUEOIZ0','25','D','40','34',NULL,'Dependent Email Address Type Code 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMEMPRUEOIZ0','350','D','40','35',NULL,'Dependent Email Address Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMEMPRUEOIZ0','25','D','40','36',NULL,'Dependent Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMEMPRUEOIZ0','350','D','40','37',NULL,'Dependent Email Address Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMEMPRUEOIZ0','25','D','40','38',NULL,'Dependent Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMEMPRUEOIZ0','25','D','40','39',NULL,'Dependent Delete Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMEMPRUEOIZ0','25','D','40','40',NULL,'Student Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMEMPRUEOIZ0','5','D','40','41',NULL,'Incapacitated Dependent Clause Certification Indic',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMEMPRUEOIZ0','8','D','40','42',NULL,'Incapacitated Dependent Clause Certification Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMEMPRUEOIZ0','32','D','40','43',NULL,'Dependent Event ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMEMPRUEOIZ0','40','D','40','44',NULL,'Dependent Event Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMEMPRUEOIZ0','8','D','40','45',NULL,'Dependent Event Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMEMPRUEOIZ0','8','D','40','46',NULL,'Dependent Marriage Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMEMPRUEOIZ0','8','D','40','47',NULL,'Dependent Divorce Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMEMPRUEOIZ0','32','D','40','48',NULL,'Dependent  PreferenceID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMEMPRUEOIZ0','25','D','40','49',NULL,'Dependent  CorrespondenceTypeCode',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMEMPRUEOIZ0','50','D','40','50',NULL,'Dependent  Preferred Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMEMPRUEOIZ0','32','D','40','51',NULL,'Dependent  Preferred Language',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMEMPRUEOIZ0','3','D','50','1',NULL,'Record Type',NULL,NULL,'"COV"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMEMPRUEOIZ0','10','D','50','2',NULL,'Client Control Number',NULL,NULL,'"drvClientControlNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMEMPRUEOIZ0','32','D','50','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMEMPRUEOIZ0','25','D','50','4',NULL,'Product Code',NULL,NULL,'"drvProductCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMEMPRUEOIZ0','25','D','50','5',NULL,'Coverage Tier Code',NULL,NULL,'"drvCoverageTierCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMEMPRUEOIZ0','25','D','50','6',NULL,'Product Plan Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMEMPRUEOIZ0','5','D','50','7',NULL,'Coverage Buy Up Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMEMPRUEOIZ0','17','D','50','8',NULL,'Coverage Amount',NULL,NULL,'"drvCoverageAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMEMPRUEOIZ0','8','D','50','9',NULL,'Coverage  Effective Date',NULL,NULL,'"drvCoverageEffectiveDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMEMPRUEOIZ0','8','D','50','10',NULL,'Coverage  End Date',NULL,NULL,'"drvCoverageEndDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMEMPRUEOIZ0','25','D','50','11',NULL,'Coverage Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMEMPRUEOIZ0','8','D','50','12',NULL,'Coverage Status Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMEMPRUEOIZ0','25','D','50','13',NULL,'Coverage Status Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMEMPRUEOIZ0','30','D','50','14',NULL,'Coverage Termination Reduction Type Code',NULL,NULL,'"drvCovTermReductionTypeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMEMPRUEOIZ0','17','D','50','15',NULL,'Coverage Termination Reduction Amount',NULL,NULL,'"drvCovTermReductionAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMEMPRUEOIZ0','5','D','50','16',NULL,'Flat Benefit Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMEMPRUEOIZ0','50','D','50','17',NULL,'Claim Branch Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMEMPRUEOIZ0','25','D','50','18',NULL,'EOB Correspondence Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMEMPRUEOIZ0','5','D','50','19',NULL,'Assignment Indicator',NULL,NULL,'"drvAssignmentIndicator"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMEMPRUEOIZ0','8','D','50','20',NULL,'Original LTD Coverage Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMEMPRUEOIZ0','25','D','50','21',NULL,'Partner Product Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMEMPRUEOIZ0','25','D','50','22',NULL,'Partner Short Benefit Description',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMEMPRUEOIZ0','8','D','50','23',NULL,'Client Coverage Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMEMPRUEOIZ0','2','D','50','24',NULL,'Benefit Option Identifier',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMEMPRUEOIZ0','5','D','50','25',NULL,'Coverage Increase Within 2 years Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMEMPRUEOIZ0','3','D','50','26',NULL,'Issuance Age',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMEMPRUEOIZ0','25','D','50','27',NULL,'Voluntary Basis',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMEMPRUEOIZ0','8','D','50','28',NULL,'Applicant Eligibility Date',NULL,NULL,'"drvApplEligibilityDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMEMPRUEOIZ0','17','D','50','29',NULL,'Applicant Inforce Benefit Amount',NULL,NULL,'"drvApplInforceBenAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMEMPRUEOIZ0','17','D','50','30',NULL,'Applicant Additional Benefit Amount',NULL,NULL,'"drvApplAdditlBenefitAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMEMPRUEOIZ0','35','D','50','31',NULL,'Applicant Relationship Type Code',NULL,NULL,'"drvApplRelType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMEMPRUEOIZ0','5','D','50','32',NULL,'Applicant EOI Branch Code',NULL,NULL,'"drvApplicantEOIBranch"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMEMPRUEOIZ0','35','D','50','33',NULL,'Deduction Type  Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMEMPRUEOIZ0','17','D','50','34',NULL,'Deduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMEMPRUEOIZ0','30','D','50','35',NULL,'Deduction Frequency Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMEMPRUEOIZ0','2','D','50','36',NULL,'Deduction Withholding State',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMEMPRUEOIZ0','30','D','50','37',NULL,'Payroll Deduction Frequency Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMEMPRUEOIZ0','17','D','50','38',NULL,'Payroll Deduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMEMPRUEOIZ0','32','D','50','39',NULL,'Coverage Event ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMEMPRUEOIZ0','40','D','50','40',NULL,'Coverage Event Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMEMPRUEOIZ0','8','D','50','41',NULL,'Coverage Event Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMEMPRUEOIZ0','8','D','50','42',NULL,'Coverage Marriage Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMEMPRUEOIZ0','8','D','50','43',NULL,'Coverage Divorce Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMEMPRUEOIZ0','3','T','90','1',NULL,'Record Type',NULL,NULL,'"TRL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMEMPRUEOIZ0','32','T','90','2',NULL,'Audit ID',NULL,NULL,'"drvAuditID"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMEMPRUEOIZ0','9','T','90','3',NULL,'Absence Related Employment Information Record Quan',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMEMPRUEOIZ0','9','T','90','4',NULL,'Associate Record Quantity',NULL,NULL,'"drvAssRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMEMPRUEOIZ0','9','T','90','5',NULL,'Beneficiary Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMEMPRUEOIZ0','9','T','90','6',NULL,'Coverage Record Quantity',NULL,NULL,'"drvCovRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMEMPRUEOIZ0','9','T','90','7',NULL,'Dependent Record Quantity',NULL,NULL,'"drvDepRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMEMPRUEOIZ0','9','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMEMPRUEOIZ0','9','T','90','9',NULL,'Employment Information Record Quantity',NULL,NULL,'"drvEmpRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMEMPRUEOIZ0','9','T','90','10',NULL,'Event Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMEMPRUEOIZ0','9','T','90','11',NULL,'Preference Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMEMPRUEOIZ0','9','T','90','12',NULL,'Custom Characteristics Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMEMPRUEOIZ0','17','T','90','13',NULL,'Total Coverage Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMEMPRUEOIZ0','9','T','90','14',NULL,'Total Record Quantity',NULL,NULL,'"drvTotalRecordQuantity"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMEMPRUEOI_20231228.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'DVORU',NULL,NULL,NULL,'Active Open Enrollment Export','202312139','EMPEXPORT','OEACTIVE',NULL,'EMEMPRUEOI',NULL,NULL,NULL,'202312139','Feb 14 2023 11:53AM','Feb 14 2023 11:53AM','202311291',NULL,'','','202311291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'DVORU',NULL,NULL,NULL,'Passive Open Enrollment Export','202312139','EMPEXPORT','OEPASSIVE',NULL,'EMEMPRUEOI',NULL,NULL,NULL,'202312139','Feb 14 2023 11:53AM','Feb 14 2023 11:53AM','202311291',NULL,'','','202311291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'DVORU',NULL,NULL,NULL,'Prudential Vol Life EOI','202312139','EMPEXPORT','ONDEM_XOE',NULL,'EMEMPRUEOI',NULL,NULL,NULL,'202312139','Feb 14 2023 11:53AM','Feb 14 2023 11:53AM','202311291',NULL,'','','202311291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'DVORU',NULL,NULL,NULL,'Prudential Vol Life EOI-Sched','202312139','EMPEXPORT','SCH_EMEMPR',NULL,'EMEMPRUEOI',NULL,NULL,NULL,'202312139','Feb 14 2023 11:53AM','Feb 14 2023 11:53AM','202311291',NULL,'','','202311291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','DVORU',NULL,NULL,NULL,'Prudential Vol Life EOI-Test','202312139','EMPEXPORT','TEST_XOE',NULL,'EMEMPRUEOI',NULL,NULL,NULL,'202312139','Feb 14 2023 11:53AM','Feb 14 2023 11:53AM','202311291',NULL,'','','202311291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEMPRUEOI','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEMPRUEOI','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEMPRUEOI','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEMPRUEOI','SubSort','C','drvDepRecID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEMPRUEOI','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEMPRUEOI','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMEMPRUEOI','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMEMPRUEOI','H01','dbo.U_EMEMPRUEOI_HDR_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMEMPRUEOI','D10','dbo.U_EMEMPRUEOI_AST_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMEMPRUEOI','D20','dbo.U_EMEMPRUEOI_EMP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMEMPRUEOI','D40','dbo.U_EMEMPRUEOI_DEP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMEMPRUEOI','D50','dbo.U_EMEMPRUEOI_COV_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMEMPRUEOI','T90','dbo.U_EMEMPRUEOI_TRL_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMEMPRUEOI
-----------

IF OBJECT_ID('U_dsi_BDM_EMEMPRUEOI') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMEMPRUEOI] (
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
    [BdmNumDPChildren] int NULL,
    [BdmAddtnlAmt] varchar(500) NULL,
    [BdmBenAmt] varchar(500) NULL,
    [BdmEOIDesiredAmt] varchar(500) NULL,
    [BdmEOIDesiredCalcRateOrPct] varchar(500) NULL,
    [BdmNeedEOI] varchar(500) NULL
);

-----------
-- Create table U_EMEMPRUEOI_AGE
-----------

IF OBJECT_ID('U_EMEMPRUEOI_AGE') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_AGE] (
    [EEID] char(12) NOT NULL,
    [DOB] date NULL,
    [AGE] int NULL,
    [SDate] datetime NULL,
    [EDate] datetime NULL,
    [CT] int NULL
);

-----------
-- Create table U_EMEMPRUEOI_AST_drvTbl
-----------

IF OBJECT_ID('U_EMEMPRUEOI_AST_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_AST_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvClientControlNumber] varchar(5) NOT NULL,
    [drvAssociateID] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvGender] varchar(7) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvAssTelephoneNumber2] varchar(16) NULL,
    [drvAssEmail] varchar(8) NULL,
    [drvAddressEmailAlternate] varchar(50) NULL
);

-----------
-- Create table U_EMEMPRUEOI_Audit
-----------

IF OBJECT_ID('U_EMEMPRUEOI_Audit') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_Audit] (
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
-- Create table U_EMEMPRUEOI_AuditFields
-----------

IF OBJECT_ID('U_EMEMPRUEOI_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EMEMPRUEOI_COV_drvTbl
-----------

IF OBJECT_ID('U_EMEMPRUEOI_COV_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_COV_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvClientControlNumber] varchar(5) NOT NULL,
    [drvAssociateID] char(9) NULL,
    [drvProductCode] varchar(4) NULL,
    [drvCoverageTierCode] varchar(2) NULL,
    [drvCoverageAmount] nvarchar(4000) NULL,
    [drvCoverageEffectiveDate] datetime NULL,
    [drvCoverageEndDate] datetime NULL,
    [drvCovTermReductionTypeCode] varchar(11) NULL,
    [drvCovTermReductionAmount] nvarchar(4000) NULL,
    [drvAssignmentIndicator] varchar(5) NOT NULL,
    [drvApplEligibilityDate] datetime NULL,
    [drvApplInforceBenAmount] nvarchar(4000) NULL,
    [drvApplAdditlBenefitAmount] varchar(500) NULL,
    [drvApplRelType] varchar(4) NULL,
    [drvApplicantEOIBranch] varchar(3) NULL
);

-----------
-- Create table U_EMEMPRUEOI_DEP_drvTbl
-----------

IF OBJECT_ID('U_EMEMPRUEOI_DEP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_DEP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] nvarchar(4000) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvRecordType] varchar(3) NULL,
    [drvClientControlNumber] varchar(5) NOT NULL,
    [drvAssociateID] char(9) NULL,
    [drvDependentID] nvarchar(4000) NULL,
    [drvDepRelTypeCode] varchar(16) NULL,
    [drvSSN] char(11) NULL,
    [drvConGender] varchar(7) NOT NULL,
    [drvConDateofBirth] datetime NULL,
    [drvConLastName] varchar(100) NULL,
    [drvConFirstName] varchar(100) NULL
);

-----------
-- Create table U_EMEMPRUEOI_EEList
-----------

IF OBJECT_ID('U_EMEMPRUEOI_EEList') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMEMPRUEOI_EMP_drvTbl
-----------

IF OBJECT_ID('U_EMEMPRUEOI_EMP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_EMP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvClientControlNumber] varchar(5) NOT NULL,
    [drvAssociateID] char(9) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvTerminationReasonCode] varchar(16) NULL,
    [drvEmplStatusCode] varchar(16) NOT NULL,
    [drvEmplStatusEffDate] datetime NULL,
    [drvEarningsAmt1] money NULL,
    [drvEarningsEffDate1] datetime NULL
);

-----------
-- Create table U_EMEMPRUEOI_File
-----------

IF OBJECT_ID('U_EMEMPRUEOI_File') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EMEMPRUEOI_HDR_drvTbl
-----------

IF OBJECT_ID('U_EMEMPRUEOI_HDR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_HDR_drvTbl] (
    [drvEmpNoSort] varchar(6) NOT NULL,
    [drvCreationDateTime] datetime NOT NULL,
    [drvClientControlNumber] varchar(5) NOT NULL,
    [drvTestProductionCode] varchar(10) NOT NULL,
    [drvActivityStartDateTime] nvarchar(4000) NULL,
    [drvActivityEndDateTime] nvarchar(4000) NULL
);

-----------
-- Create table U_EMEMPRUEOI_LOA_Dates
-----------

IF OBJECT_ID('U_EMEMPRUEOI_LOA_Dates') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_LOA_Dates] (
    [EshEEID] char(12) NOT NULL,
    [EshCOID] char(5) NOT NULL,
    [EshStatusStartDate] datetime NULL,
    [EshStatusStopDate] datetime NULL,
    [EshEmplStatus] char(1) NULL,
    [RN] bigint NULL
);

-----------
-- Create table U_EMEMPRUEOI_TRL_drvTbl
-----------

IF OBJECT_ID('U_EMEMPRUEOI_TRL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMEMPRUEOI_TRL_drvTbl] (
    [drvAuditID] datetime NOT NULL,
    [drvAssRecordQuantity] int NULL,
    [drvCovRecordQuantity] int NULL,
    [drvDepRecordQuantity] int NULL,
    [drvEmpRecordQuantity] int NULL,
    [drvTotalRecordQuantity] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMEMPRUEOI]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Members 1st Federal Credit Union

Created By: Marie Thomerson
Business Analyst: Lea King
Create Date: 02/14/2023
Service Request Number: TekP-2022-11-16-01

Purpose: Prudential Vol Life EOI

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        12/28/2023     TekP-2022-11-16-01 Added brackes areound Where OR clauses 
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMEMPRUEOI';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMEMPRUEOI';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMEMPRUEOI';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMEMPRUEOI';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMEMPRUEOI' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202311231'
       ,expStartPerControl     = '202311231'
       ,expLastEndPerControl   = '202312079'
       ,expEndPerControl       = '202312079'
        ,expCOIDList            = 'DVORU'
WHERE expFormatCode = 'EMEMPRUEOI';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMEMPRUEOI', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMEMPRUEOI', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMEMPRUEOI', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMEMPRUEOI', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMEMPRUEOI', 'SCH_EMEMPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMEMPRUEOI';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMEMPRUEOI', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
  DECLARE  @FormatCode        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@SDate                DATE
            ,@EDate                DATE
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EMEMPRUEOI';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@SDate            = CAST(LEFT(StartPerControl,8) as date)
        ,@EDate         = CAST(LEFT(EndPerControl,8) as date)
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EMEMPRUEOI_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMEMPRUEOI_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    ----==========================================
    ---- Audit Section
    ----==========================================
    -- Get data from audit fields table. Add fields here if auditing
    --IF OBJECT_ID('U_EMEMPRUEOI_AuditFields','U') IS NOT NULL
    --    DROP TABLE dbo.U_EMEMPRUEOI_AuditFields;
    --CREATE TABLE dbo.U_EMEMPRUEOI_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    --INSERT INTO dbo.U_EMEMPRUEOI_AuditFields VALUES ('EmpComp','EecDateofTermination');
    --INSERT INTO dbo.U_EMEMPRUEOI_AuditFields VALUES ('EmpComp','EecEmplStatus');
    --INSERT INTO dbo.U_EMEMPRUEOI_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    --IF OBJECT_ID('U_EMEMPRUEOI_Audit','U') IS NOT NULL
    --    DROP TABLE dbo.U_EMEMPRUEOI_Audit;
    --SELECT 
    --    audEEID  = audKey1Value
    --    ,audKey2 = audKey2Value
    --    ,audKey3 = audKey3Value
    --    ,audTableName
    --    ,audFieldName
    --    ,audAction
    --    ,audDateTime
    --    ,audOldValue
    --    ,audNewValue
    --    ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    --INTO dbo.U_EMEMPRUEOI_Audit
    --FROM dbo.vw_AuditData WITH (NOLOCK) 
    ----JOIN dbo.U_EMEMPRUEOI_AuditFields WITH (NOLOCK)    
    --WHERE aTableName = 'EmpComp' AND aFieldName in ('EecDateofTermination', 'EecEmplStatus') AND audDateTime BETWEEN @StartDate AND @EndDate --DATEADD(mm,11,DATEADD(yy,DATEDIFF(yy,0,@StartDate)-1,0)) AND @EndDate
    --AND audAction <> 'DELETE';

    ---- Create Index
    --CREATE CLUSTERED INDEX CDX_U_EMEMPRUEOI_Audit ON dbo.U_EMEMPRUEOI_Audit (audEEID,audKey2);

    --==========================================
    -- Create Deduction List
    --==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'LIFE1,LIFE2,LIFE3,DEPEN,OPAD1,OPAD2,OPAD3,GTLER,ADDER';

    --IF OBJECT_ID('U_EMEMPRUEOI_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_EMEMPRUEOI_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_EMEMPRUEOI_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','LIFE1,LIFE2,LIFE3,DEPEN,OPAD1,OPAD2,OPAD3,GTLER,ADDER');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',DATEADD(yy, DATEDIFF(yy, 0, @StartDate), 0));
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',DATEADD(yy, DATEDIFF(yy, 0, @StartDate) + 1, -1));
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','FIA');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDPChild','DPC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'FutureDatedStopDateDays','60')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BdmAddField','BdmNeedEOI');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BdmAddField','BdmEOIDesiredAmt');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BdmAddField','BdmEOIDesiredCalcRateOrPct');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BdmAddField','BdmBenAmt');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BdmAddField','BdmAddtnlAmt');
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
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable_v3 @FormatCode;

    EXEC dbo.dsi_BDM_sp_CalculateBenefitAmounts @FormatCode;

    --Delete from  dbo.U_dsi_BDM_EMEMPRUEOI where BdmBenStopDate <  DATEADD(mm,11,DATEADD(yy,DATEDIFF(yy,0,@StartDate)-1,0));

    --Set BdmUSGField1 value when deps 26 and more than 1 child
    --DATEADD(YY,26,ConDateofBirth) > @StartDate

    --UPDATE dbo.U_dsi_BDM_EMEMPRUEOI
    --SET BdmUSGField1 = CT
    --FROM dbo.U_dsi_BDM_EMEMPRUEOI BDM
    --JOIN (select BdmEEID, count(ConSystemID) as CT
    --from dbo.U_dsi_BDM_EMEMPRUEOI JOIN dbo.Contacts WITH (NOLOCK) 
    --On ConEEID = BdmEEID AND ConIsDependent = 'Y' AND ConRelationship IN ('CHL','STC') AND BdmDedCode = 'DEPEN'
    --AND DATEDIFF(year, ConDateOfBirth, @EndDate) < 27
    --Group by BdmEEID) AGE
    --ON Age.BdmEEID = Bdm.BdmEEID
    --;

    --UPDATE dbo.U_dsi_BDM_EMEMPRUEOI
    --SET BdmUSGDate1 = DOB.ConDateofBirth
    --FROM dbo.U_dsi_BDM_EMEMPRUEOI BDM
    --JOIN (
    --select BdmEEID, ConDateofBirth, DATEDIFF(year, ConDateOfBirth, @EndDate) as DBage, 
    --cast(datefromparts(year(@EndDate), MONTH(ConDateofBirth),DAY(ConDateofBirth)) as date) as DateOB, 
    --@Edate as EDate, @SDate as SDate
    --from dbo.U_dsi_BDM_EMEMPRUEOI 
    --JOIN dbo.Contacts WITH (NOLOCK) 
    --On ConEEID = BdmEEID AND ConIsDependent = 'Y' AND ConRelationship IN ('CHL','STC') AND BdmDedCode = 'DEPEN'
    -- AND DATEDIFF(year, ConDateOfBirth, @EndDate) = 26
    --) DOB
    --ON DOB.BdmEEID = Bdm.BdmEEID
    ----AND BDM.BdmUSGField1 is not null
    --AND DOB.DateoB between DOB.SDate and DOB.EDate;

    --UPDATE dbo.U_dsi_BDM_EMEMPRUEOI
    --SET BdmUSGField2 = 'Y'
    --FROM dbo.U_dsi_BDM_EMEMPRUEOI BDM
    --JOIN (select BdmEEID
    --from dbo.U_dsi_BDM_EMEMPRUEOI JOIN dbo.Contacts WITH (NOLOCK) 
    --On ConEEID = BdmEEID AND ConIsDependent = 'Y' AND ConRelationship IN ('CHL','STC') AND BdmDedCode = 'DEPEN'
    --AND (DATEDIFF(year, ConDateOfBirth, @EndDate) < 26 or BdmUSGDate1 is not null)
    --Group by BdmEEID) AGE
    --ON Age.BdmEEID = Bdm.BdmEEID
    --;
    IF OBJECT_ID('U_EMEMPRUEOI_AGE','U') IS NOT NULL
    DROP TABLE dbo.U_EMEMPRUEOI_AGE;
         SELECT 
         EEID = Bdm.BdmEEID
        ,DOB = datefromparts(year(@EndDate), MONTH(ConDateofBirth),DAY(ConDateofBirth)) 
        ,AGE = DATEDIFF(year, ConDateOfBirth, @EndDate)
        ,SDate = @StartDate
        ,EDate = @EndDate
        ,CT
    INTO dbo.U_EMEMPRUEOI_AGE
    FROM dbo.U_dsi_BDM_EMEMPRUEOI BDM
    JOIN dbo.Contacts WITH (NOLOCK) 
    On ConEEID = Bdm.BdmEEID AND ConIsDependent = 'Y' AND ConIsActive = 'Y' AND ConRelationship IN ('CHL','STC') AND Bdm.BdmDedCode = 'DEPEN'
    AND DATEDIFF(year, ConDateOfBirth, @EndDate) = 26
    AND cast(datefromparts(year(@EndDate), MONTH(ConDateofBirth),DAY(ConDateofBirth)) as date) between @StartDate AND @EndDate
    LEFT JOIN (select BdmEEID, count(ConSystemID) as CT
    from dbo.U_dsi_BDM_EMEMPRUEOI JOIN dbo.Contacts WITH (NOLOCK) 
    On ConEEID = BdmEEID AND ConIsDependent = 'Y' AND ConIsActive = 'Y' AND ConRelationship IN ('CHL','STC') AND BdmDedCode = 'DEPEN'
    AND DATEDIFF(year, ConDateOfBirth, @EndDate) < 27
    Group by BdmEEID) AGE
    ON Age.BdmEEID = Bdm.BdmEEID;

    UPDATE dbo.U_dsi_BDM_EMEMPRUEOI
    SET BdmUSGField2 = 'Y'
    FROM dbo.U_dsi_BDM_EMEMPRUEOI BDM
    JOIN dbo.U_EMEMPRUEOI_AGE
    ON EEID = BdmEEID
    AND DOB between SDate and EDate;

    DELETE FROM dbo.U_dsi_BDM_EMEMPRUEOI where BdmUSGField2 <> 'Y' AND BdmDedCode = 'DEPEN';

    --==============================================================
    -- Update BdmUSGField1 with Dependent Benefit Amount (DedEEBenAmt)
    --==============================================================     
    --UPDATE dbo.U_dsi_bdm_EMEMPRUEOI
    --    SET BdmEEAmt = DedEEBenAmt
    --FROM dbo.U_dsi_bdm_EMEMPRUEOI
    --JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    --    ON DbnEEID = BdmEEID
    --    AND DbnCOID = BdmCOID
    --    AND DbnDedCode = BdmDedCode
    --WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y' AND dbndedcode in ('DEPEN');     

    --UPDATE dbo.U_dsi_bdm_EMEMPRUEOI
    --    SET BdmEEAmt = EedBenAmt
    --FROM dbo.U_dsi_bdm_EMEMPRUEOI
    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = BdmEEID
    --    AND EedCOID = BdmCOID
    --    AND eedDedCode = BdmDedCode
    --       AND BdmRecType = 'EMP' 
    --    AND EedFormatCode = 'EMEMPRUEOI' AND EedValidForExport = 'Y' and eeddedcode in ('LIFE1','LIFE2','LIFE3','DEPEN','OPAD1','OPAD2','OPAD3','GTLER','ADDER');
    
        --Update Additional BDM Fields
        UPDATE dbo.U_dsi_BDM_EMEMPRUEOI
            SET  BdmNeedEOI = EF.EedNeedEOI
                ,BdmEOIDesiredAmt = EF.EedEOIDesiredAmt
                ,BdmEOIDesiredCalcRateOrPct = EF.EedEOIDesiredCalcRateOrPct
                ,BdmBenAmt = Bca.BcaBenAmtCalc
                ,BdmAddtnlAmt = CONVERT(DECIMAL(10,2),Bca.BcaBenAmtCalc - COALESCE(Bdm.BdmEOIDesiredAmt,0.00))
                --,BdmAddtnlAmt = CONVERT(DECIMAL(10,2),COALESCE(Bdm.BdmEOIDesiredAmt,0.00) - Bca.BcaBenAmtCalc)
                ,BdmUSGDate1 = EF.EedEEEligDate
                ,BdmEEAmt = EmpDed.EedBenAmt 
                ,BdmStopDate = EF.EedBenStopDate
            FROM U_dsi_BDM_EMEMPRUEOI Bdm WITH (NOLOCK)
            JOIN dbo.U_dsi_BDM_EmpDeductions EmpDed WITH (NOLOCK)
                ON EmpDed.EedFormatCode = 'EMEMPRUEOI'
                AND EmpDed.EedEEID = Bdm.BdmEEID
                AND EmpDed.EedCOID = Bdm.BdmCOID
                AND EmpDed.EedDedCode = Bdm.BdmDedCode
            JOIN dbo.EmpDedFull EF WITH (NOLOCK) 
                ON EF.EedEmpDedTVID = EmpDed.EedEmpDedTVID
            JOIN dbo.U_dsi_bdm_BenCalculationAmounts Bca WITH (NOLOCK)
                ON Bca.bcaFormatCode = EmpDed.EedFormatCode
                AND Bca.BcaEEID = Bdm.BdmEEID
                AND Bca.BcaCOID = Bdm.BdmCOID
            AND Bca.BcaDedCode = Bdm.BdmDedCode;

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --IF OBJECT_ID('U_EMEMPRUEOI_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_EMEMPRUEOI_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    ,PdhDedCalcBasisAmt = SUM(PdhDedCalcBasisAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('LIFE1') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('LIFE2') THEN PdhEECurAmt ELSE 0.00 END)
    --    --,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('LIFE3') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('DEPEN') THEN PdhEECurAmt ELSE 0.00 END)
    --INTO dbo.U_EMEMPRUEOI_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    ----JOIN dbo.U_EMEMPRUEOI_DedList WITH (NOLOCK)
    ----    ON DedCode = 
    --WHERE PdhDedCode in ('LIFE1','LIFE2','LIFE3','DEPEN','OPAD1','OPAD2','OPAD3','GTLER','ADDER')
    --AND LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    ----AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);

   -- Delete from  dbo.U_dsi_BDM_EMEMPRUEOI where BdmBenStopDate <  CAST(DATEADD(YEAR, DATEDIFF(YEAR, -1, @StartDate )-1, -1) AS DATE) AND BdmEEID not in (select distinct PdhEEID from dbo.U_EMEMPRUEOI_PDedHist);

  IF OBJECT_ID('U_EMEMPRUEOI_LOA_Dates','U') IS NOT NULL
        DROP TABLE dbo.U_EMEMPRUEOI_LOA_Dates;
    SELECT DISTINCT
             EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
    INTO dbo.U_EMEMPRUEOI_LOA_Dates
    FROM dbo.EmpHStat WITH (NOLOCK) 
        WHERE EshEmplStatus = 'L';
                    
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMEMPRUEOI_AST_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMEMPRUEOI_AST_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMEMPRUEOI_AST_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eecempno
        -- standard fields above and additional driver fields below
        ,drvClientControlNumber = '51876'
        ,drvAssociateID = eecempno
        ,drvSSN = eepSSN
        ,drvGender = CASE WHEN EepGender = 'M' THEN 'MALE'
                            WHEN EepGender = 'F' THEN 'FEMALE'
                            else 'UNKNOWN'
                        END
        ,drvDateofBirth  = eepdateofbirth
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode,5)
        ,drvPhoneHomeNumber = CASE WHEN EepPhoneHomeNumber <> '0000000000' or EepPhoneHomeNumber is not null THEN EepPhoneHomeNumber END
        ,drvAssTelephoneNumber2 = dbo.dsi_fnlib_GetPhoneNumber(EecEEID,'CEL')
        ,drvAssEmail = Case when eepaddressemailalternate is not null then 'PERSONAL' END 
        ,drvAddressEmailAlternate = eepaddressemailalternate
    INTO dbo.U_EMEMPRUEOI_AST_drvTbl
    FROM dbo.U_EMEMPRUEOI_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EMEMPRUEOI WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND (Bdmstopdate is null or Bdmstopdate > DATEADD(DAY,1,@StartDate)-30)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (EecDateofTermination is null or EecDateofTermination > @startDate)
    --JOIN dbo.EmpDed WITH (NOLOCK)
    --    On EedEEID = xEEID
    --    AND EedDedCode  IN ('LIFE1','LIFE2','LIFE3','DEPEN') ANd (EedBenStopDate is null or EedBenStopDate > DATEADD(mm,11,DATEADD(yy,DATEDIFF(yy,0,@StartDate)-1,0)))
            --AND (eecemplstatus <> 'T' 
      --        OR 
      --       (    eecemplstatus = 'T' 
      --            AND eectermreason <> 'TRO' 
      --            AND EXISTS (Select 1 from dbo.U_EMEMPRUEOI_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')
      --       )
      --     )
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EMEMPRUEOI_EMP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMEMPRUEOI_EMP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMEMPRUEOI_EMP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eecempno
        -- standard fields above and additional driver fields below
        ,drvClientControlNumber = '51876'
        ,drvAssociateID = eecempno
        ,drvEmployeeID = EecEmpNo
        ,drvHireDate = eecdateoforiginalhire
        ,drvRehireDate = EecDateOfLastHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationReasonCode = CASE WHEN EecEmplStatus = 'T' and eectermreason = 'ILL' THEN 'LEAVE OF ABSENCE'
                        WHEN EecEmplStatus = 'T' and eectermreason = '203' THEN 'DECEASED'
                        WHEN EecEmplStatus = 'T' and eectermreason = '202' THEN 'RETIRED'
                        WHEN EecEmplStatus = 'T' and eectermreason Not in ('ILL', '202','203') THEN 'TERMINATED'
                        WHEN EecEmplStatus = 'T' and eshemplstatus = 'L' THEN 'LEAVE OF ABSENCE'
                        END
        ,drvEmplStatusCode = CASE   WHEN EecEmplStatus = 'T' THEN 'TERMINATED'
                                    WHEN EecEmplStatus = 'L' THEN 'LEAVE OF ABSENCE'
                                    ELSE 'ACTIVE' END
        ,drvEmplStatusEffDate = EecEmplStatusStartDate
        ,drvEarningsAmt1 = eecannsalary
        ,drvEarningsEffDate1 =  [dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate](EecEEID, EecCOID, GETDATE(),EecDateOfLastHire) 
    INTO dbo.U_EMEMPRUEOI_EMP_drvTbl
    FROM dbo.U_EMEMPRUEOI_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EMEMPRUEOI WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND (Bdmstopdate is null or Bdmstopdate > DATEADD(DAY,1,@StartDate)-30)
    LEFT JOIN dbo.U_EMEMPRUEOI_LOA_Dates             
        ON EshEEID = xEEID
        AND EshCOID = xCOID
        AND RN = 1
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (EecDateofTermination is null or EecDateofTermination > @startDate)
                    --AND (eecemplstatus <> 'T' 
        --      OR 
        --     (    eecemplstatus = 'T' 
        --          AND eectermreason <> 'TRO' 
        --          AND EXISTS (Select 1 from dbo.U_EMEMPRUEOI_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')
        --     )
        --   )
    ;
        ---------------------------------
    -- DETAIL RECORD - U_EMEMPRUEOI_DEP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMEMPRUEOI_DEP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMEMPRUEOI_DEP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = FORMAT(RN,'00')
        ,drvEmpNoSort = eecempno
        -- standard fields above and additional driver fields below
        ,drvRecordType = CASE WHEN ConIsDependent = 'Y' and ConIsActive = 'Y' AND DATEADD(YY,26,ConDateofBirth)> @StartDate then 'DEP' END
        ,drvClientControlNumber = '51876'
        ,drvAssociateID = eecempno
        ,drvDependentID = CASE WHEN ConIsDependent = 'Y' and ConIsActive = 'Y' THEN REPLACE(eecempno + '00' + FORMAT(RN,'0'),' ','') END --CASE WHEN RN = 0 then '' else FORMAT(RN,'00') END--add sequence # based on eecempno with oldest condateofbirth as 01, next oldest 02, etc where ConIsDependent = Y and ConDateofBirth is less than 26
        ,drvDepRelTypeCode = CASE   WHEN ConIsDependent = 'Y' and ConIsActive = 'Y' and ConRelationship = 'SPS' then 'SPOUSE'
                                    WHEN ConIsDependent = 'Y' and ConIsActive = 'Y' and ConRelationship = 'FIA' then 'DOMESTIC PARTNER'
                                    WHEN ConIsDependent = 'Y' and ConIsActive = 'Y' and DATEADD(YY,26,ConDateofBirth) > @StartDate and ConRelationship in ('CHL','STC') then 'CHILD' END
        ,drvSSN = CASE WHEN ConSSN not in ('000000000','999999999') THEN ConSSN END
        ,drvConGender = CASE WHEN ConGender = 'M' THEN 'MALE'
                            WHEN ConGender = 'F' THEN 'FEMALE'
                            else 'UNKNOWN'
                        END
        ,drvConDateofBirth = ConDateOfBirth
        ,drvConLastName = ConNameLast
        ,drvConFirstName = connamefirst
    INTO dbo.U_EMEMPRUEOI_DEP_drvTbl
    FROM dbo.U_EMEMPRUEOI_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EMEMPRUEOI WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        --and Bdmdedcode = 'DEPEN'
        --AND Bdmdedcode IN ('DEPEN','LIFE1', 'LIFE2','LIFE3','OPAD1', 'OPAD2', 'OPAD3','GTLER','ADDER') ----?
        AND (Bdmstopdate is null or Bdmstopdate > DATEADD(DAY,1,@StartDate)-30)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (EecDateofTermination is null or EecDateofTermination > @startDate)
    JOIN (SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConRelationship, ConDateOfBirth, ConGender, ConNameLast, ConNameFirst, ConIsDependent,ConIsActive,  DATEDIFF(year, ConDateOfBirth, @EndDate) as Age, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By  DATEDIFF(year, ConDateOfBirth, @EndDate) Desc) AS RN 
        FROM dbo.Contacts WITH (NOLOCK) 
        --AND ConIsDependent = 'Y' AND ConRelationship IN ('SPS','FIA','CHL','STC')
       -- where (DATEADD(YY,26,ConDateofBirth) > @StartDate AND ConRelationship IN ('CHL','STC') AND ConIsDependent = 'Y' and ConIsActive = 'Y' or ConRelationship IN ('SPS','FIA') AND ConIsDependent = 'Y' and ConIsActive = 'Y')) Con -- MW commented out
        where (DATEADD(YY,26,ConDateofBirth) > @StartDate AND (( ConRelationship IN ('CHL','STC') AND ConIsDependent = 'Y' and ConIsActive = 'Y' ) or (ConRelationship IN ('SPS','FIA') AND ConIsDependent = 'Y' and ConIsActive = 'Y')))) Con -- MW updated 12/28/23
        ON ConEEID = BdmEEID;

    --LEFT JOIN (SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConRelationship, ConDateOfBirth, ConGender, ConNameLast, ConNameFirst, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, RN  
    --    FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConRelationship, ConDateOfBirth, ConGender, ConNameLast, ConNameFirst, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, 1 AS RN 
    --    FROM dbo.Contacts WITH (NOLOCK) 
    --    WHERE ConIsDependent = 'Y' AND ConRelationship IN ('SPS','FIA')

    --    UNION SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConRelationship, ConDateOfBirth, ConGender, ConNameLast, ConNameFirst, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, RN  
    --        --CASE WHEN dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) > 26 THEN 2 ELSE ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth ASC) END AS RN 
    --    FROM ( SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConRelationship, ConDateOfBirth, ConGender, ConNameLast, ConNameFirst, ConIsDependent, dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) as Age, 2 AS RN 
    --    FROM dbo.Contacts WITH (NOLOCK) 
    --    WHERE ConIsDependent = 'Y' AND ConRelationship IN ('CHL','STC') AND dbo.usi_fn_GetDependentAge(ConSystemID, GETDATE()) < 26
    --    ) AS CHLD
    --    ) AS Con 
    --    ) CON
    --    ON ConEEID = BdmEEID
    --    ;

--DELETE from dbo.U_EMEMPRUEOI_DEP_drvTbl where drvDepRelTypeCode is null;

    ---------------------------------
    -- DETAIL RECORD - U_EMEMPRUEOI_COV_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMEMPRUEOI_COV_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMEMPRUEOI_COV_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eecempno
        -- standard fields above and additional driver fields below
        ,drvClientControlNumber = '51876'
        ,drvAssociateID = eecempno
        ,drvProductCode = CASE  WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') THEN 'OGL'
                                WHEN Bdmdedcode in ('OPAD1', 'OPAD2', 'OPAD3') THEN 'OADD'
                                WHEN Bdmdedcode = 'DEPEN' THEN 'DGL' 
                                WHEN Bdmdedcode = 'GTLER'  THEN 'BGL'
                                WHEN Bdmdedcode = 'ADDER' THEN 'BADD'
                            END
        ,drvCoverageTierCode = CASE WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') THEN 'EE'
                                    WHEN Bdmdedcode in ('OPAD1', 'OPAD2', 'OPAD3') THEN 'EE'
                                    WHEN Bdmdedcode = 'DEPEN' AND ConRelationship IN ('SPS','FIA') THEN 'SP' 
                                    WHEN Bdmdedcode = 'DEPEN' AND ConRelationship IN ('CHL','STC') THEN 'CH'
                                    WHEN Bdmdedcode = 'GTLER'  THEN 'EE'
                                    WHEN Bdmdedcode = 'ADDER' THEN 'EE'
                                END
        ,drvCoverageAmount = CASE    WHEN Bdmdedcode = 'DEPEN' AND ConRelationship IN ('SPS','FIA') THEN '005000' 
                                    WHEN Bdmdedcode = 'DEPEN' AND ConRelationship IN ('CHL','STC') THEN '002500' 
                                    WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and bcabenamtcalc <> 0 then FORMAT(bcabenamtcalc ,'000000')    
                                    WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and bcabenamtcalc = 0 THEN FORMAT(BdmEEAmt,'000000')
                                    WHEN Bdmdedcode in ('OPAD1', 'OPAD2', 'OPAD3') and bcabenamtcalc <> 0 then FORMAT(bcabenamtcalc ,'000000')
                                    WHEN Bdmdedcode = 'GTLER' and bcabenamtcalc <> 0 then FORMAT(bcabenamtcalc ,'000000') 
                                    WHEN Bdmdedcode = 'ADDER' and bcabenamtcalc <> 0 then FORMAT(bcabenamtcalc ,'000000') 
                                 --WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and PdhDedCalcBasisAmt <> 0 THEN FORMAT(PdhDedCalcBasisAmt,'000000') 
                                END
        ,drvCoverageEffectiveDate = Bdmbenstartdate
        ,drvCoverageEndDate = CASE WHEN Bdmdedcode = 'DEPEN' AND ConRelationship IN ('CHL','STC') and BdmUSGField2 = 'Y' then DATEADD(YY,26,ConDateofBirth) ELSE Bdmstopdate END
        ,drvCovTermReductionTypeCode = CASE WHEN eecemplstatus = 'T' THEN 'INVOLUNTARY'
                                            WHEN Bdmdedcode = 'DEPEN' AND ConRelationship IN ('CHL','STC') and BdmUSGField2 = 'Y' then 'AGE'
                                            WHEN eecemplstatus <> 'T' and Bdmbenstatus in ('T','C','W') and BdmChangereason in ('304','OE') THEN 'CANCELLED'
                                            WHEN eecemplstatus <> 'T' and Bdmbenstatus in ('T','C','W') and Bdmchangereason = '204' THEN 'DIVORCE'
                                            WHEN eecemplstatus <> 'T' and Bdmbenstatus in ('T','C','W') and Bdmchangereason not in ('304','204','201','OE') THEN 'INVOLUNTARY'
                                            END
        ,drvCovTermReductionAmount = CASE WHEN (eecemplstatus = 'T' or Bdmbenstatus in ('T','C','W')) and Bdmdedcode = 'DEPEN' AND ConRelationship IN ('SPS','FIA') THEN '005000' 
                                            WHEN (eecemplstatus = 'T' or Bdmbenstatus in ('T','C','W')) and Bdmdedcode = 'DEPEN' AND ConRelationship IN ('CHL','STC') THEN '002500' 
                                            WHEN (eecemplstatus = 'T' or Bdmbenstatus in ('T','C','W')) and Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3','OPAD1', 'OPAD2', 'OPAD3','GTLER','ADDER') and bcabenamtcalc <> 0 then FORMAT(bcaeebenamt ,'000000')  
                                            WHEN (eecemplstatus = 'T' or Bdmbenstatus in ('T','C','W')) and Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3','OPAD1', 'OPAD2', 'OPAD3','GTLER','ADDER') and bcabenamtcalc = 0 THEN FORMAT(BdmEEAmt,'000000') 
                                            --WHEN (eecemplstatus = 'T' or Bdmbenstatus in ('T','C')) and Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and PdhDedCalcBasisAmt <> 0 THEN FORMAT(PdhDedCalcBasisAmt,'000000')
                                    END
        ,drvAssignmentIndicator = 'FALSE' --CASE WHEN eecemplstatus <> 'T' and Bdmbenstatus in ('T','C','W') THEN 'TRUE' END  
        ,drvApplEligibilityDate = CASE WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and (BdmNeedEOI = 'Y' or Bdmbenstatus = 'P') then BdmUSGDate1 END
        ,drvApplInforceBenAmount = CASE --WHEN Bdmdedcode = 'DEPEN' AND ConRelationship IN ('SPS','FIA') THEN '005000' 
                                    --WHEN Bdmdedcode = 'DEPEN' AND ConRelationship IN ('CHL','STC') THEN '002500' 
                                 -- WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and bcabenamtcalc <> 0 then FORMAT(bcabenamtcalc ,'000000')    
                                  --WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and bcabenamtcalc = 0 THEN FORMAT(BdmEEAmt,'000000')
                                 --WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and PdhDedCalcBasisAmt <> 0 THEN FORMAT(PdhDedCalcBasisAmt,'000000') 
                                --END
                                    WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and BdmNeedEOI = 'Y' and ceiling(EecAnnSalary/1000.0)*1000 >= 150000 then '150000'
                                    WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and BdmNeedEOI = 'Y' and ceiling(EecAnnSalary/1000.0)*1000 < 150000 then FORMAT(bcabenamtcalc, '000000')
                                    --WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and BdmNeedEOI = 'N' then FORMAT(bcabenamtcalc, '000000') 
                                    --WHEN Bdmdedcode in ('OPAD1', 'OPAD2', 'OPAD3') and bcabenamtcalc <> 0 then FORMAT(bcabenamtcalc ,'000000')
                                    --WHEN Bdmdedcode = 'GTLER' and bcabenamtcalc <> 0 then FORMAT(bcabenamtcalc ,'000000') 
                                    --WHEN Bdmdedcode = 'ADDER' and bcabenamtcalc <> 0 then FORMAT(bcabenamtcalc ,'000000') 
                                    --ELSE '000000' 
                                    END
        ,drvApplAdditlBenefitAmount = CASE WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and BdmNeedEOI = 'Y' then BdmAddtnlAmt 

                                            --WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and BdmNeedEOI = 'Y' and bcabenamtcalc <> 0 then FORMAT(bcabenamtcalc ,'000000')    
                                            --WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and BdmNeedEOI = 'Y' and bcabenamtcalc = 0 THEN FORMAT(BdmEEAmt,'000000')
                                            --WHEN Bdmdedcode = 'LIFE2' and BdmNeedEOI = 'Y' then FORMAT(2*EecAnnSalary,'000000')
                                            --WHEN Bdmdedcode = 'LIFE3' and BdmNeedEOI = 'Y' then FORMAT(3*EecAnnSalary,'000000')
                                            --FORMAT((((BdmEOIDesiredCalcRateOrPct*EecAnnSalary)/1000.0)*1000)-bcabenamtcalc,'000000')
                                            --WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and bcabenamtcalc = 0 And BdmBenStatus in ('A','P') and EedNeedEOI = 'Y' THEN FORMAT(EedEOIDesiredCalcRateOrPct ,'000000')
                                            --WHEN PdhDedCalcBasisAmt = 0 And BdmBenStatus in ('A','P') THEN FORMAT(EedEOIDesiredCalcRateOrPct ,'000000') 
                                    END
        ,drvApplRelType = CASE WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and (BdmNeedEOI = 'Y' or Bdmbenstatus = 'P') then 'SELF' END
        ,drvApplicantEOIBranch = CASE WHEN Bdmdedcode in ('LIFE1', 'LIFE2','LIFE3') and (BdmNeedEOI = 'Y' or Bdmbenstatus = 'P') then '001' END
    INTO dbo.U_EMEMPRUEOI_COV_drvTbl
    FROM dbo.U_EMEMPRUEOI_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EMEMPRUEOI WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND (Bdmstopdate is null or Bdmstopdate > DATEADD(DAY,1,@StartDate)-30)
   JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (EecDateofTermination is null or EecDateofTermination > @startDate)
                    --AND (eecemplstatus <> 'T' 
        --      OR 
        --     (    eecemplstatus = 'T' 
        --          AND eectermreason <> 'TRO' 
        --          AND EXISTS (Select 1 from dbo.U_EMEMPRUEOI_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')
        --     )
        --   )
    --LEFT JOIN dbo.U_EMEMPRUEOI_PDedHist WITH (NOLOCK)
    --    ON PdhEEID = xEEID 
    LEFT JOIN dbo.U_dsi_bdm_BenCalculationAmounts 
        ON BcaEEID = BdmEEID
        AND BcaCoID = BdmCoID
        AND BcaDedCode = BdmDedCode
        AND BCAFORMATCODE = 'EMEMPRUEOI'
    --LEFT JOIN dbo.EmpDed WITH (NOLOCK)
    --    ON EedCoID = BdmCoID
    --    AND EedEEID = BdmEEID
    --    AND EedDedCode = BdmDedCode
     LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON ConEEID = BdmEEID 
        AND ConIsDependent = 'Y' and ConIsActive = 'Y'
       -- AND ConRelationship IN ('CHL','STC') AND DATEADD(YY,26,ConDateofBirth) > @StartDate or ConRelationship IN ('SPS','FIA') -- MW commented out
       AND ((ConRelationship IN ('CHL','STC') AND DATEADD(YY,26,ConDateofBirth) > @StartDate) or ConRelationship IN ('SPS','FIA'))-- MW updated 12/28/23
    ;
 
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EMEMPRUEOI_HDR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMEMPRUEOI_HDR_drvTbl;
    SELECT DISTINCT
         drvEmpNoSort = '000000'
        ,drvCreationDateTime = GetDate()
        ,drvClientControlNumber = '51876'
        ,drvTestProductionCode = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'TEST' ELSE 'PRODUCTION' END
        ,drvActivityStartDateTime = format(getdate()-6,'yyyyMMddHHmmssffff')
        ,drvActivityEndDateTime = format(getdate(),'yyyyMMddHHmmssffff')
    INTO dbo.U_EMEMPRUEOI_HDR_drvTbl
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EMEMPRUEOI_TRL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMEMPRUEOI_TRL_drvTbl;
    SELECT DISTINCT
         drvAuditID = GetDate()
        ,drvAssRecordQuantity = (select Count(drvEEID) from dbo.U_EMEMPRUEOI_AST_drvTbl WITH (NOLOCK))
        ,drvCovRecordQuantity = (select Count(drvEEID) from dbo.U_EMEMPRUEOI_COV_drvTbl WITH (NOLOCK))
        ,drvDepRecordQuantity = (select Count(drvEEID) from dbo.U_EMEMPRUEOI_DEP_drvTbl WITH (NOLOCK))
        ,drvEmpRecordQuantity  = Count(drvEEID) 
        ,drvTotalRecordQuantity = (select Count(drvEEID) from dbo.U_EMEMPRUEOI_AST_drvTbl WITH (NOLOCK))+(select Count(drvEEID) from dbo.U_EMEMPRUEOI_COV_drvTbl WITH (NOLOCK))+ (select Count(drvEEID) from dbo.U_EMEMPRUEOI_DEP_drvTbl WITH (NOLOCK))+Count(drvEEID) 
    INTO dbo.U_EMEMPRUEOI_TRL_drvTbl
    FROM dbo.U_EMEMPRUEOI_EMP_drvTbl WITH (NOLOCK)
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN '51876_ClientEligibility_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE '51876_ClientEligibility_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEMEMPRUEOI_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMEMPRUEOI_File (NOLOCK)
    ORDER BY CASE WHEN InitialSort= 1 THEN '000000' ELSE InitialSort END,  RIGHT(RecordSet,2), SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EMEMPRUEOI%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202311231'
       ,expStartPerControl     = '202311231'
       ,expLastEndPerControl   = '202312079'
       ,expEndPerControl       = '202312079'
        ,expCOIDList            = 'DVORU'
WHERE expFormatCode = 'EMEMPRUEOI';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMEMPRUEOI_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMEMPRUEOI_File WITH (NOLOCK)
    ORDER BY CASE WHEN InitialSort= 1 THEN '000000' ELSE InitialSort END,  RIGHT(RecordSet,2), SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMEMPRUEOI' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMEMPRUEOI'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMEMPRUEOI'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMEMPRUEOI', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMEMPRUEOI', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMEMPRUEOI', 'UseFileName', 'V', 'Y'


-- End ripout