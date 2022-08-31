/**********************************************************************************

ESTAPRUD: Prudential Leave

FormatCode:     ESTAPRUD
Project:        Prudential Leave
Client ID:      STA1005
Date/time:      2022-08-24 07:26:33.710
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N21
Server:         N2SUP1DB52
Database:       ULTIPRO_SCF
Web Filename:   STA1005_71679_EEHISTORY_ESTAPRUD_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESTAPRUD_SavePath') IS NOT NULL DROP TABLE dbo.U_ESTAPRUD_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESTAPRUD'


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
WHERE FormatCode = 'ESTAPRUD'
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
WHERE ExpFormatCode = 'ESTAPRUD'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESTAPRUD')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESTAPRUD'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESTAPRUD'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESTAPRUD'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESTAPRUD'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESTAPRUD'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESTAPRUD'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESTAPRUD'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESTAPRUD'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESTAPRUD'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESTAPRUD_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESTAPRUD_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTAPRUD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTAPRUD];
GO
IF OBJECT_ID('U_ESTAPRUD_trTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_trTbl];
GO
IF OBJECT_ID('U_ESTAPRUD_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_hdrTbl];
GO
IF OBJECT_ID('U_ESTAPRUD_File') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_File];
GO
IF OBJECT_ID('U_ESTAPRUD_EMP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_EMP_drvTbl];
GO
IF OBJECT_ID('U_ESTAPRUD_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_EEList];
GO
IF OBJECT_ID('U_ESTAPRUD_DEP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_DEP_drvTbl];
GO
IF OBJECT_ID('U_ESTAPRUD_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_DedList];
GO
IF OBJECT_ID('U_ESTAPRUD_COV_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_COV_drvTbl];
GO
IF OBJECT_ID('U_ESTAPRUD_CON_trTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_CON_trTbl];
GO
IF OBJECT_ID('U_ESTAPRUD_CCH_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_CCH_drvTbl];
GO
IF OBJECT_ID('U_ESTAPRUD_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_AuditFields];
GO
IF OBJECT_ID('U_ESTAPRUD_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_Audit];
GO
IF OBJECT_ID('U_ESTAPRUD_AST_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_AST_drvTbl];
GO
IF OBJECT_ID('U_ESTAPRUD_ABS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAPRUD_ABS_drvTbl];
GO
IF OBJECT_ID('U_dsi_BDM_ESTAPRUD') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESTAPRUD];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTAPRUD','Prudential Leave','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ESTAPRUD0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTAPRUD0Z0','3','H','01','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTAPRUD0Z0','32','H','01','2',NULL,'Transmission GUID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTAPRUD0Z0','14','H','01','3',NULL,'Creation Date Time',NULL,NULL,'"drvCreationDateTime"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTAPRUD0Z0','10','H','01','4',NULL,'Client Control Number',NULL,NULL,'"61752"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTAPRUD0Z0','80','H','01','5',NULL,'Client Name',NULL,NULL,'"CopperPoint"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTAPRUD0Z0','6','H','01','6',NULL,'SchemaVersionIdentifier',NULL,NULL,'"1.0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTAPRUD0Z0','80','H','01','7',NULL,'Sender Name',NULL,NULL,'"CopperPoint"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTAPRUD0Z0','80','H','01','8',NULL,'Sender Platform Name',NULL,NULL,'"UKG"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTAPRUD0Z0','10','H','01','9',NULL,'Test Production Code',NULL,NULL,'"drvTESTorProd"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTAPRUD0Z0','12','H','01','10',NULL,'Transmission Type Code',NULL,NULL,'"FULL FILE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTAPRUD0Z0','14','H','01','11',NULL,'Activity Start Date Time',NULL,NULL,'"drvActivityStartDT"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTAPRUD0Z0','14','H','01','12',NULL,'Activity End Date Time',NULL,NULL,'"drvActivityEndDT"','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTAPRUD0Z0','3','D','10','1',NULL,'Record Type',NULL,NULL,'"AST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTAPRUD0Z0','10','D','10','2',NULL,'Client Control Number',NULL,NULL,'"61752"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTAPRUD0Z0','32','D','10','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTAPRUD0Z0','9','D','10','4',NULL,'Associate Social Security Number',NULL,NULL,'"drvAssSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTAPRUD0Z0','25','D','10','5',NULL,'Associate Gender Code',NULL,NULL,'"drvAssGenderCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTAPRUD0Z0','8','D','10','6',NULL,'Associate Date of Birth',NULL,NULL,'"drvAssDateofBirth "','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTAPRUD0Z0','8','D','10','7',NULL,'Associate Date of Death',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTAPRUD0Z0','25','D','10','8',NULL,'Associate Smoker Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTAPRUD0Z0','30','D','10','9',NULL,'Associate Marital Status Code',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTAPRUD0Z0','30','D','10','10',NULL,'Associate Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTAPRUD0Z0','30','D','10','11',NULL,'Associate Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTAPRUD0Z0','80','D','10','12',NULL,'Associate Last Name',NULL,NULL,'"drvAssLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTAPRUD0Z0','50','D','10','13',NULL,'Associate First Name',NULL,NULL,'"drvAssFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTAPRUD0Z0','50','D','10','14',NULL,'Associate Middle Name',NULL,NULL,'"drvMiddleName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTAPRUD0Z0','25','D','10','15',NULL,'Associate Address Type Code 1',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTAPRUD0Z0','64','D','10','16',NULL,'Associate Address Line 1 Text 1',NULL,NULL,'"drvAssAddressLine1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTAPRUD0Z0','64','D','10','17',NULL,'Associate Address Line 2 Text 1',NULL,NULL,'"drvAssAddressLine2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTAPRUD0Z0','64','D','10','18',NULL,'Associate Address Line 3 Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTAPRUD0Z0','50','D','10','19',NULL,'Associate City Name 1',NULL,NULL,'"drvAssCityName1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTAPRUD0Z0','2','D','10','20',NULL,'Associate State Province Code 1',NULL,NULL,'"drvAssStateProvinceCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTAPRUD0Z0','12','D','10','21',NULL,'Associate Postal Code 1',NULL,NULL,'"drvAssPostalCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTAPRUD0Z0','35','D','10','22',NULL,'Associate Country Code 1',NULL,NULL,'"drvAssCountryCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTAPRUD0Z0','25','D','10','23',NULL,'Associate Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTAPRUD0Z0','64','D','10','24',NULL,'Associate Address Line 1 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTAPRUD0Z0','64','D','10','25',NULL,'Associate Address Line 2 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTAPRUD0Z0','64','D','10','26',NULL,'Associate Address Line 3 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESTAPRUD0Z0','50','D','10','27',NULL,'Associate City Name 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESTAPRUD0Z0','2','D','10','28',NULL,'Associate State Province Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESTAPRUD0Z0','12','D','10','29',NULL,'Associate Postal Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESTAPRUD0Z0','35','D','10','30',NULL,'Associate Country Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESTAPRUD0Z0','25','D','10','31',NULL,'Associate Address Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESTAPRUD0Z0','64','D','10','32',NULL,'Associate Address Line 1 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESTAPRUD0Z0','64','D','10','33',NULL,'Associate Address Line 2 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESTAPRUD0Z0','64','D','10','34',NULL,'Associate Address Line 3 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESTAPRUD0Z0','50','D','10','35',NULL,'Associate City Name 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESTAPRUD0Z0','2','D','10','36',NULL,'Associate State Province Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESTAPRUD0Z0','12','D','10','37',NULL,'Associate Postal Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESTAPRUD0Z0','35','D','10','38',NULL,'Associate Country Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESTAPRUD0Z0','30','D','10','39',NULL,'Associate Telephone Type Code 1',NULL,NULL,'"drvAssTelephoneTypeCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESTAPRUD0Z0','20','D','10','40',NULL,'Associate Telephone Number 1',NULL,NULL,'"drvAssTelephoneNo1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESTAPRUD0Z0','10','D','10','41',NULL,'Associate Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESTAPRUD0Z0','30','D','10','42',NULL,'Telephone Type Code 2',NULL,NULL,'"drvAssTelephoneTypeCode2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESTAPRUD0Z0','20','D','10','43',NULL,'Associate Telephone Number 2',NULL,NULL,'"drvAssTelephoneNo2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESTAPRUD0Z0','10','D','10','44',NULL,'Associate Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESTAPRUD0Z0','30','D','10','45',NULL,'Associate Telephone  Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESTAPRUD0Z0','20','D','10','46',NULL,'Associate Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESTAPRUD0Z0','10','D','10','47',NULL,'Associate Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESTAPRUD0Z0','25','D','10','48',NULL,'Associate Email Address Type Code 1',NULL,NULL,'"drvAssEmailAddressTypeCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESTAPRUD0Z0','350','D','10','49',NULL,'Associate Email Address Text 1',NULL,NULL,'"drvAssEmailAddress1 "','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESTAPRUD0Z0','25','D','10','50',NULL,'Associate Email Address Type Code 2',NULL,NULL,'"drvAssEmailAddressTypeCode2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESTAPRUD0Z0','350','D','10','51',NULL,'Associate Email Address Text 2',NULL,NULL,'"drvAssEmailAddress2 "','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTAPRUD0Z0','3','D','20','1',NULL,'Record Type',NULL,NULL,'"EMP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTAPRUD0Z0','10','D','20','2',NULL,'Client Control Number',NULL,NULL,'"61752"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTAPRUD0Z0','32','D','20','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTAPRUD0Z0','32','D','20','4',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTAPRUD0Z0','8','D','20','5',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTAPRUD0Z0','8','D','20','6',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTAPRUD0Z0','8','D','20','7',NULL,'Retirement Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTAPRUD0Z0','8','D','20','8',NULL,'Employment Termination Date',NULL,NULL,'"drvEmpTermDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTAPRUD0Z0','25','D','20','9',NULL,'Employment Termination Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTAPRUD0Z0','8','D','20','10',NULL,'Adjusted Service Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTAPRUD0Z0','8','D','20','11',NULL,'Last Active Service Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTAPRUD0Z0','30','D','20','12',NULL,'Employment Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTAPRUD0Z0','8','D','20','13',NULL,'Employment Status Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTAPRUD0Z0','30','D','20','14',NULL,'Employment Status Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTAPRUD0Z0','30','D','20','15',NULL,'Job Title Text',NULL,NULL,'"drvJobTitleText "','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTAPRUD0Z0','30','D','20','16',NULL,'Occupation Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTAPRUD0Z0','25','D','20','17',NULL,'OSHA Job Classification Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTAPRUD0Z0','25','D','20','18',NULL,'Occupation Class Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTAPRUD0Z0','25','D','20','19',NULL,'Work Status Code',NULL,NULL,'"drvWorkStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTAPRUD0Z0','5','D','20','20',NULL,'Weekly Scheduled Hours',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTAPRUD0Z0','5','D','20','21',NULL,'Daily Hours Worked',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTAPRUD0Z0','25','D','20','22',NULL,'Hourly Salary Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTAPRUD0Z0','30','D','20','23',NULL,'Earnings Type  Code 1',NULL,NULL,'"BASE PAY"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTAPRUD0Z0','17','D','20','24',NULL,'Earnings  Amount 1',NULL,NULL,'"drvEarningsAmt1"','(''UNT2''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTAPRUD0Z0','30','D','20','25',NULL,'Earnings Frequency Code 1',NULL,NULL,'"ANNUAL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTAPRUD0Z0','8','D','20','26',NULL,'Earnings Effective  Date 1',NULL,NULL,'"drvEarningsEffDate1"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESTAPRUD0Z0','30','D','20','27',NULL,'Earnings Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESTAPRUD0Z0','17','D','20','28',NULL,'Earnings Amount 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESTAPRUD0Z0','30','D','20','29',NULL,'Earnings Frequency  Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESTAPRUD0Z0','8','D','20','30',NULL,'Earnings Effective Date 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESTAPRUD0Z0','30','D','20','31',NULL,'Earnings Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESTAPRUD0Z0','17','D','20','32',NULL,'Earnings Amount 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESTAPRUD0Z0','30','D','20','33',NULL,'Earnings Frequency Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESTAPRUD0Z0','8','D','20','34',NULL,'Earnings Effective Date 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESTAPRUD0Z0','25','D','20','35',NULL,'W4 Filing Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESTAPRUD0Z0','4','D','20','36',NULL,'W4 Exemptions Number',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESTAPRUD0Z0','17','D','20','37',NULL,'W4 Additional Withholding Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESTAPRUD0Z0','2','D','20','38',NULL,'W4 Withholding State Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESTAPRUD0Z0','2','D','20','39',NULL,'W4 Withholding State Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESTAPRUD0Z0','2','D','20','40',NULL,'W4 Withholding State Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESTAPRUD0Z0','12','D','20','41',NULL,'W4 Work Location Postal Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESTAPRUD0Z0','5','D','20','42',NULL,'Union Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESTAPRUD0Z0','25','D','20','43',NULL,'Local Bargaining Unit Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESTAPRUD0Z0','25','D','20','44',NULL,'Member Group Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESTAPRUD0Z0','25','D','20','45',NULL,'Bill Group Code',NULL,NULL,'" "','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESTAPRUD0Z0','30','D','20','46',NULL,'Payroll Frequency Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESTAPRUD0Z0','25','D','20','47',NULL,'District Location Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESTAPRUD0Z0','30','D','20','48',NULL,'Employment Location',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESTAPRUD0Z0','10','D','20','49',NULL,'Regional Unit',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESTAPRUD0Z0','20','D','20','50',NULL,'Employer Information',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESTAPRUD0Z0','80','D','20','51',NULL,'Group',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESTAPRUD0Z0','2','D','20','52',NULL,'Work Location State Code',NULL,NULL,'"drvWorkLocStateCd"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESTAPRUD0Z0','256','D','20','53',NULL,'Comments',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESTAPRUD0Z0','17','D','20','54',NULL,'YTD Earnings',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESTAPRUD0Z0','8','D','20','55',NULL,'Earnings As of Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTAPRUD0Z0','50','D','40','1',NULL,'Record Type',NULL,NULL,'"COV"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTAPRUD0Z0','50','D','40','2',NULL,'Client Control Number',NULL,NULL,'"61752"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTAPRUD0Z0','50','D','40','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTAPRUD0Z0','50','D','40','4',NULL,'Product Code',NULL,NULL,'"drvProdCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTAPRUD0Z0','50','D','40','5',NULL,'Coverage Tier Code',NULL,NULL,'"drvCovTierCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTAPRUD0Z0','50','D','40','6',NULL,'Product Plan Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTAPRUD0Z0','50','D','40','7',NULL,'Coverage Buy Up Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTAPRUD0Z0','50','D','40','8',NULL,'Coverage Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTAPRUD0Z0','50','D','40','9',NULL,'Coverage  Effective Date',NULL,NULL,'"drvCovEffDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTAPRUD0Z0','50','D','40','10',NULL,'Coverage  End Date',NULL,NULL,'"drvCovEndDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTAPRUD0Z0','50','D','40','11',NULL,'Coverage Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTAPRUD0Z0','50','D','40','12',NULL,'Coverage Status Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTAPRUD0Z0','50','D','40','13',NULL,'CS Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTAPRUD0Z0','50','D','40','14',NULL,'Term Red Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTAPRUD0Z0','50','D','40','15',NULL,'Term Red Amt',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTAPRUD0Z0','50','D','40','16',NULL,'Flat Benefit Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTAPRUD0Z0','50','D','40','17',NULL,'Claim Branch Code',NULL,NULL,'"drvClaimBranchCd"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTAPRUD0Z0','50','D','40','18',NULL,'EOB Corr Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTAPRUD0Z0','50','D','40','19',NULL,'Assignment Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTAPRUD0Z0','50','D','40','20',NULL,'Orig LTD',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTAPRUD0Z0','50','D','40','21',NULL,'Part Prod Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTAPRUD0Z0','50','D','40','22',NULL,'Part Short Ben Desc',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTAPRUD0Z0','50','D','40','23',NULL,'Client Cov Eff Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTAPRUD0Z0','50','D','40','24',NULL,'Ben Option ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTAPRUD0Z0','50','D','40','25',NULL,'Cov Increase 2 ind',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTAPRUD0Z0','50','D','40','26',NULL,'Issuance Age',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESTAPRUD0Z0','50','D','40','27',NULL,'Voluntary Basis',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESTAPRUD0Z0','50','D','40','28',NULL,'Applicant Eligibility Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESTAPRUD0Z0','50','D','40','29',NULL,'Applicant Inforce Benefit Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESTAPRUD0Z0','50','D','40','30',NULL,'Applicant Additional Benefit Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESTAPRUD0Z0','50','D','40','31',NULL,'Applicant Relationship Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESTAPRUD0Z0','50','D','40','32',NULL,'Applicant EOI Branch Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESTAPRUD0Z0','50','D','40','33',NULL,'Deduction Type  Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESTAPRUD0Z0','50','D','40','34',NULL,'Deduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESTAPRUD0Z0','50','D','40','35',NULL,'Deduction Frequency Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESTAPRUD0Z0','50','D','40','36',NULL,'Deduction Withholding State',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESTAPRUD0Z0','50','D','40','37',NULL,'Pay Ded Freq',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESTAPRUD0Z0','50','D','40','38',NULL,'Pay Ded Amt',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESTAPRUD0Z0','50','D','40','39',NULL,'Cov Event ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESTAPRUD0Z0','50','D','40','40',NULL,'Cov Event Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESTAPRUD0Z0','50','D','40','41',NULL,'Cov Event Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESTAPRUD0Z0','50','D','40','42',NULL,'Cov Marriage Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESTAPRUD0Z0','50','D','40','43',NULL,'Cov Div Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTAPRUD0Z0','3','D','45','1',NULL,'Record Type',NULL,NULL,'"ABS"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTAPRUD0Z0','10','D','45','2',NULL,'Client Control Number',NULL,NULL,'"61752"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTAPRUD0Z0','32','D','45','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTAPRUD0Z0','4','D','45','4',NULL,'FMLA Branch Code',NULL,NULL,'"drvFMLABranchCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTAPRUD0Z0','5','D','45','5',NULL,'FMLA Work Location Code',NULL,NULL,'"CopperPoint"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTAPRUD0Z0','45','D','45','6',NULL,'Hours Worked in Last 12 Months',NULL,NULL,'"drvHrsWorkedLast12Mts"','(''UNT2''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTAPRUD0Z0','45','D','45','7',NULL,'As of Date Hours Worked in Last 12 Months',NULL,NULL,'"drvFileRunDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTAPRUD0Z0','45','D','45','8',NULL,'Hours Worked Since Last File',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTAPRUD0Z0','45','D','45','9',NULL,'Other Hours Worked in Last 12 Months',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTAPRUD0Z0','45','D','45','10',NULL,'As of Date Other Hours Worked in Last 12 Months',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTAPRUD0Z0','45','D','45','11',NULL,'Employment Sector',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTAPRUD0Z0','45','D','45','12',NULL,'Employment Type',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTAPRUD0Z0','45','D','45','13',NULL,'Key EE Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTAPRUD0Z0','45','D','45','14',NULL,'Standard Work Schedule',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTAPRUD0Z0','45','D','45','15',NULL,'Share Leave Relationship Code_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTAPRUD0Z0','45','D','45','16',NULL,'Shared Leave Relationship SSN_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTAPRUD0Z0','45','D','45','17',NULL,'Shared Leave Relationship Prefix Code_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTAPRUD0Z0','45','D','45','18',NULL,'Shared Leave Relationship First Name_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTAPRUD0Z0','45','D','45','19',NULL,'Shared Leave Relationship Middle Name_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTAPRUD0Z0','45','D','45','20',NULL,'Shared Leave Relationship Last Name_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTAPRUD0Z0','45','D','45','21',NULL,'Shared Leave Relationship Suffix Code_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTAPRUD0Z0','45','D','45','22',NULL,'Shared Leave Relationship EE ID_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTAPRUD0Z0','45','D','45','23',NULL,'Share Leave Relationship Code_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTAPRUD0Z0','45','D','45','24',NULL,'Shared Leave Relationship SSN_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTAPRUD0Z0','45','D','45','25',NULL,'Shared Leave Relationship Prefix Code_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTAPRUD0Z0','45','D','45','26',NULL,'Shared Leave Relationship First Name_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESTAPRUD0Z0','45','D','45','27',NULL,'Shared Leave Relationship Middle Name_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESTAPRUD0Z0','45','D','45','28',NULL,'Shared Leave Relationship Last Name_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESTAPRUD0Z0','45','D','45','29',NULL,'Shared Leave Relationship Suffix Code_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESTAPRUD0Z0','45','D','45','30',NULL,'Shared Leave Relationship EE ID_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESTAPRUD0Z0','45','D','45','31',NULL,'Share Leave Relationship Code_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESTAPRUD0Z0','45','D','45','32',NULL,'Shared Leave Relationship SSN_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESTAPRUD0Z0','45','D','45','33',NULL,'Shared Leave Relationship Prefix Code_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESTAPRUD0Z0','45','D','45','34',NULL,'Shared Leave Relationship First Name_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESTAPRUD0Z0','45','D','45','35',NULL,'Shared Leave Relationship Middle Name_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESTAPRUD0Z0','45','D','45','36',NULL,'Shared Leave Relationship Last Name_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESTAPRUD0Z0','45','D','45','37',NULL,'Shared Leave Relationship Suffix Code_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESTAPRUD0Z0','45','D','45','38',NULL,'Shared Leave Relationship EE ID_3',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTAPRUD0Z0','50','D','50','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTAPRUD0Z0','50','D','50','2',NULL,'Client Control Number',NULL,NULL,'"61752"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTAPRUD0Z0','50','D','50','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTAPRUD0Z0','50','D','50','4',NULL,'Custom Characteristic Code',NULL,NULL,'"drvCustomCharacCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTAPRUD0Z0','50','D','50','5',NULL,'Custom Characteristic Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTAPRUD0Z0','50','D','50','6',NULL,'Custom Characteristic Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTAPRUD0Z0','50','D','50','7',NULL,'Custom Characteristic Percent',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTAPRUD0Z0','50','D','50','8',NULL,'Custom Characteristic Value Text',NULL,NULL,'"drvCustomCharacValue"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTAPRUD0Z0','50','D','60','1',NULL,'Record Type',NULL,NULL,'"CON"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTAPRUD0Z0','50','D','60','2',NULL,'Client Control Number',NULL,NULL,'"61752"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTAPRUD0Z0','50','D','60','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTAPRUD0Z0','50','D','60','4',NULL,'Employment Contact ID',NULL,NULL,'"drvEmpContactID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTAPRUD0Z0','50','D','60','5',NULL,'Employment Contact Type Code',NULL,NULL,'"HR REP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTAPRUD0Z0','50','D','60','6',NULL,'Employment Contact First Name',NULL,NULL,'"drvContactFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTAPRUD0Z0','50','D','60','7',NULL,'Employment Contact Last Name',NULL,NULL,'"drvContactLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTAPRUD0Z0','50','D','60','8',NULL,'Employment Contact Middle Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTAPRUD0Z0','50','D','60','9',NULL,'Employment Contact Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTAPRUD0Z0','50','D','60','10',NULL,'Employment Contact Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTAPRUD0Z0','50','D','60','11',NULL,'Employment Contact Telephone Type Code 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTAPRUD0Z0','50','D','60','12',NULL,'Employment Contact Telephone Number 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTAPRUD0Z0','50','D','60','13',NULL,'Employment Contact Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTAPRUD0Z0','50','D','60','14',NULL,'Employment Contact Telephone Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESTAPRUD0Z0','50','D','60','15',NULL,'Employment Contact Telephone Number 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESTAPRUD0Z0','50','D','60','16',NULL,'Employment Contact Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESTAPRUD0Z0','50','D','60','17',NULL,'Employment Contact Telephone  Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESTAPRUD0Z0','50','D','60','18',NULL,'Employment Contact Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESTAPRUD0Z0','50','D','60','19',NULL,'Employment Contact Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESTAPRUD0Z0','50','D','60','20',NULL,'Employment Contact Email Address Type Code 1',NULL,NULL,'"WORK"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESTAPRUD0Z0','50','D','60','21',NULL,'Employment Contact Email Address Text 1',NULL,NULL,'"drvContactEmailAddrTxt1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESTAPRUD0Z0','50','D','60','22',NULL,'Employment Contact Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESTAPRUD0Z0','50','D','60','23',NULL,'Employment Contact Email Address Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESTAPRUD0Z0','50','D','60','24',NULL,'Employment Contact SSN',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESTAPRUD0Z0','50','D','60','25',NULL,'Employment Contact Employee ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESTAPRUD0Z0','50','D','60','26',NULL,'Employment Contact DOB',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESTAPRUD0Z0','3','T','90','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESTAPRUD0Z0','32','T','90','2',NULL,'Audit ID',NULL,NULL,'"drvAuditID"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESTAPRUD0Z0','9','T','90','3',NULL,'Absence Related Employment Information Record Quan',NULL,NULL,'"drvAbRelEmpInfoRecQty"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESTAPRUD0Z0','9','T','90','4',NULL,'Associate Record Quantity',NULL,NULL,'"drvAssRecQty"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESTAPRUD0Z0','9','T','90','5',NULL,'Beneficiary Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESTAPRUD0Z0','9','T','90','6',NULL,'Coverage Record Quantity',NULL,NULL,'"drvCovRecQty"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESTAPRUD0Z0','9','T','90','7',NULL,'Dependent Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESTAPRUD0Z0','9','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL,'"drvEmpContRecQty"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESTAPRUD0Z0','9','T','90','9',NULL,'Employment Information Record Quantity',NULL,NULL,'"drvEmpInfoRecQty"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESTAPRUD0Z0','9','T','90','10',NULL,'Event Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESTAPRUD0Z0','9','T','90','11',NULL,'Preference Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESTAPRUD0Z0','9','T','90','12',NULL,'Custom Characteristics Record Quantity',NULL,NULL,'"drvCustCharRecQty"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESTAPRUD0Z0','17','T','90','13',NULL,'Total Coverage Amount',NULL,NULL,'"drvTotCovAmt"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESTAPRUD0Z0','9','T','90','14',NULL,'Total Record Quantity',NULL,NULL,'"drvTotRecQty"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESTAPRUD_20220824.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Leave Admin','202208199','EMPEXPORT','ONDEM_XOE',NULL,'ESTAPRUD',NULL,NULL,NULL,'202208199','Jan 19 2022 10:41AM','Jan 19 2022 10:41AM','202101121',NULL,'','','202101121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Leave Admin-Sched','202208199','EMPEXPORT','SCH_ESNAPR',NULL,'ESTAPRUD',NULL,NULL,NULL,'202208199','Jan 19 2022 10:41AM','Jan 19 2022 10:41AM','202101121',NULL,'','','202101121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','E97KN',NULL,NULL,NULL,'Prudential Leave Admin-Test','202208199','EMPEXPORT','TEST_XOE','Aug 22 2022 12:00AM','ESTAPRUD',NULL,NULL,NULL,'202208199','Aug 19 2022 12:00AM','Dec 30 1899 12:00AM','202101121',NULL,'','','202101121',dbo.fn_GetTimedKey(),NULL,'us3mThSTA1005',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAPRUD','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAPRUD','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAPRUD','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAPRUD','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAPRUD','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAPRUD','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAPRUD','H01','dbo.U_ESTAPRUD_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAPRUD','D10','dbo.U_ESTAPRUD_AST_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAPRUD','D20','dbo.U_ESTAPRUD_EMP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAPRUD','D40','dbo.U_ESTAPRUD_COV_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAPRUD','D45','dbo.U_ESTAPRUD_ABS_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAPRUD','D50','dbo.U_ESTAPRUD_CCH_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAPRUD','D60','dbo.U_ESTAPRUD_CON_trTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAPRUD','T90','dbo.U_ESTAPRUD_trTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ESTAPRUD
-----------

IF OBJECT_ID('U_dsi_BDM_ESTAPRUD') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESTAPRUD] (
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
-- Create table U_ESTAPRUD_ABS_drvTbl
-----------

IF OBJECT_ID('U_ESTAPRUD_ABS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_ABS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvAssociateID] char(9) NULL,
    [drvDependentID] varchar(7) NULL,
    [drvDepRelTypeCode] varchar(16) NULL,
    [drvDependentSSN] char(11) NULL,
    [drvDepGenderCode] varchar(7) NOT NULL,
    [drvDepDateofBirth] datetime NULL,
    [drvDepMaritalStatusCd] varchar(7) NOT NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepAddressLine1] varchar(255) NULL,
    [drvDepAddressLine2] varchar(255) NULL,
    [drvDepCityName] varchar(255) NULL,
    [drvDepStateProvinceCd] varchar(255) NULL,
    [drvDepPostalCode] varchar(50) NULL,
    [drvDepCountryCode] char(3) NULL,
    [drvDepTelephoneNo1] varchar(50) NULL
);

-----------
-- Create table U_ESTAPRUD_AST_drvTbl
-----------

IF OBJECT_ID('U_ESTAPRUD_AST_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_AST_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvAssociateID] char(9) NULL,
    [drvAssSSN] char(11) NULL,
    [drvAssGenderCode] varchar(7) NOT NULL,
    [drvAssDateofBirth] datetime NULL,
    [drvAssLastName] varchar(100) NULL,
    [drvAssFirstName] varchar(100) NULL,
    [drvAssAddressLine1] varchar(255) NULL,
    [drvAssCityName1] varchar(255) NULL,
    [drvAssStateProvinceCode1] varchar(255) NULL,
    [drvAssPostalCode1] varchar(50) NULL,
    [drvAssCountryCode1] char(3) NULL,
    [drvAssTelephoneNo1] varchar(50) NULL,
    [drvAssTelephoneNo2] varchar(51) NULL,
    [drvAssTelephoneNo3] varchar(50) NULL,
    [drvAssEmailAddress1] varchar(50) NULL,
    [drvAssEmailAddress2] varchar(50) NULL
);

-----------
-- Create table U_ESTAPRUD_Audit
-----------

IF OBJECT_ID('U_ESTAPRUD_Audit') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_Audit] (
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
-- Create table U_ESTAPRUD_AuditFields
-----------

IF OBJECT_ID('U_ESTAPRUD_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESTAPRUD_CCH_drvTbl
-----------

IF OBJECT_ID('U_ESTAPRUD_CCH_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_CCH_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvAssociateID] char(9) NULL,
    [drvCustomCharacCode] varchar(1) NOT NULL,
    [drvCustomCharacValue] varchar(1) NOT NULL
);

-----------
-- Create table U_ESTAPRUD_CON_trTbl
-----------

IF OBJECT_ID('U_ESTAPRUD_CON_trTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_CON_trTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvAssociateID] char(9) NULL,
    [drvEmpContactID] char(9) NULL,
    [drvEmpContactSSN] char(11) NULL,
    [drvEmpContactEmpID] char(9) NULL
);

-----------
-- Create table U_ESTAPRUD_COV_drvTbl
-----------

IF OBJECT_ID('U_ESTAPRUD_COV_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_COV_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvAssociateID] char(9) NULL,
    [drvProdCode] varchar(4) NULL,
    [drvCovTierCode] varchar(6) NULL,
    [drvProdPlanCode] varchar(4) NULL,
    [drvCovAmount] money NULL,
    [drvCovEffDate] datetime NULL,
    [drvCovEndDate] datetime NULL,
    [drvCovStatusCode] varchar(10) NOT NULL,
    [drvCovStatusEfDate] datetime NULL,
    [drvClaimBranchCd] varchar(5) NULL,
    [drvVoluntaryBasis] varchar(9) NULL,
    [drvAppEligDate] varchar(1) NOT NULL,
    [drvAppInfBenAmt] varchar(1) NOT NULL,
    [drvAppAddtlBenAmt] varchar(1) NOT NULL,
    [drvAppRelTypeCode] varchar(1) NOT NULL
);

-----------
-- Create table U_ESTAPRUD_DedList
-----------

IF OBJECT_ID('U_ESTAPRUD_DedList') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESTAPRUD_DEP_drvTbl
-----------

IF OBJECT_ID('U_ESTAPRUD_DEP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_DEP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvAssociateID] char(9) NULL,
    [drvDependentID] varchar(7) NULL,
    [drvDepRelTypeCode] varchar(16) NULL,
    [drvDependentSSN] char(11) NULL,
    [drvDepGenderCode] varchar(7) NOT NULL,
    [drvDepDateofBirth] datetime NULL,
    [drvDepMaritalStatusCd] varchar(7) NOT NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepAddressLine1] varchar(255) NULL,
    [drvDepAddressLine2] varchar(255) NULL,
    [drvDepCityName] varchar(255) NULL,
    [drvDepStateProvinceCd] varchar(255) NULL,
    [drvDepPostalCode] varchar(50) NULL,
    [drvDepCountryCode] char(3) NULL,
    [drvDepTelephoneNo1] varchar(50) NULL
);

-----------
-- Create table U_ESTAPRUD_EEList
-----------

IF OBJECT_ID('U_ESTAPRUD_EEList') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESTAPRUD_EMP_drvTbl
-----------

IF OBJECT_ID('U_ESTAPRUD_EMP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_EMP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvEmpNoSort] char(9) NULL,
    [drvAssociateID] char(9) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvEmpTermDate] datetime NULL,
    [drvEmpTermReasonCd] varchar(10) NULL,
    [drvEmpStatusCode] varchar(16) NULL,
    [drvEmpStatusEffDate] datetime NULL,
    [drvJobTitleText] varchar(25) NOT NULL,
    [drvOccupationText] varchar(25) NOT NULL,
    [drvWorkStatusCode] varchar(9) NOT NULL,
    [drvWeeklySchedHrs] decimal NULL,
    [drvDailyHrsWorked] decimal NULL,
    [drvHourlySalCode] varchar(8) NOT NULL,
    [drvEarningsAmt1] money NULL,
    [drvEarningsEffDate1] datetime NULL,
    [drvMemGroupCode] varchar(3) NOT NULL,
    [drvEmpLocation] varchar(3) NOT NULL,
    [drvWorkLocStateCd] varchar(255) NULL
);

-----------
-- Create table U_ESTAPRUD_File
-----------

IF OBJECT_ID('U_ESTAPRUD_File') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ESTAPRUD_hdrTbl
-----------

IF OBJECT_ID('U_ESTAPRUD_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_hdrTbl] (
    [drvCreationDateTime] datetime NOT NULL,
    [drvTESTorProd] varchar(4) NOT NULL,
    [drvActivityStartDT] datetime NULL,
    [drvActivityEndDT] datetime NOT NULL
);

-----------
-- Create table U_ESTAPRUD_trTbl
-----------

IF OBJECT_ID('U_ESTAPRUD_trTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAPRUD_trTbl] (
    [drvRecordType] varchar(3) NOT NULL,
    [drvAuditID] datetime NOT NULL,
    [drvAbRelEmpInfoRecQty] varchar(1) NOT NULL,
    [drvAssRecQty] int NULL,
    [drvCovRecQty] int NULL,
    [drvEmpContRecQty] int NULL,
    [drvEmpInfoRecQty] int NULL,
    [drvCustCharRecQty] int NULL,
    [drvTotCovAmt] money NULL,
    [drvTotRecQty] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTAPRUD]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: CopperPoint Insurance Company

Created By: Marie Thomerson
Business Analyst: Kim Ephraim
Create Date: 08/10/2022
Service Request Number: TekP-2022-05-26-04

Purpose: Prudential Leave Admin

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTAPRUD';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTAPRUD';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTAPRUD';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESTAPRUD';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTAPRUD' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101121'
       ,expStartPerControl     = '202101121'
       ,expLastEndPerControl   = '202208199'
       ,expEndPerControl       = '202208199'
WHERE expFormatCode = 'ESTAPRUD';



Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAPRUD', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAPRUD', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAPRUD', 'SCH_ESNAPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESTAPRUD';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESTAPRUD', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESTAPRUD';

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
    DELETE FROM dbo.U_ESTAPRUD_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESTAPRUD_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESTAPRUD_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_AuditFields;
    CREATE TABLE dbo.U_ESTAPRUD_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ESTAPRUD_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ESTAPRUD_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ESTAPRUD_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESTAPRUD_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_Audit;
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
    INTO dbo.U_ESTAPRUD_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESTAPRUD_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND DATEADD(DD,-30,@StartDate)
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESTAPRUD_Audit ON dbo.U_ESTAPRUD_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_ESTAPRUD_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ESTAPRUD_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '725L, 726L, 731';

    IF OBJECT_ID('U_ESTAPRUD_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESTAPRUD_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','725L, 726L, 731');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','EES');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','EEC');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','EEDP');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDPChild','EEDPC');

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


	-----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ESTAPRUD_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(CASE WHEN PehEarnCode in ('401F', '401P', 'MATER', '401CF', '401CP', 'ROTH', 'ROTHP', 'RTHCF', 'RTHCP', '401L', '457', '457B', '457ER') THEN PehCurAmt END)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehEarnCode not in ('PTO', 'HOLIDAYs', 'SICK','LOA') THEN PehCurHrs END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ESTAPRUD_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PrgPayDate between @StartDate and DATEADD(M,-11,@EndDate)
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESTAPRUD_AST_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTAPRUD_AST_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_AST_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID =  EecEmpNo
        ,drvAssSSN = eepSSN
        ,drvAssGenderCode = CASE    WHEN EepGender = 'M' THEN 'MALE'
                                    WHEN EepGender = 'F' THEN 'FEMALE'
                                    else 'UNKNOWN' 
                                END
        ,drvAssDateofBirth = EepDateofBirth
        ,drvMaritalStatus = CASE WHEN EepMaritalStatus = 'S' THEN 'SINGLE' WHEN EepMaritalStatus = 'M' THEN 'MARRIED' WHEN EepMaritalStatus = 'D' THEN 'DIVORCED' WHEN EepMaritalStatus = 'W' THEN 'WIDOWED' ELSE 'UKNOWN' END
        ,drvAssLastName = EepNameLast
        ,drvAssFirstName = EepNameFirst
        ,drvMiddleName = left(eepNameMiddle,1)
        ,drvAssAddressLine1 = EepAddressLine1
        ,drvAssAddressLine2 = EepAddressLine2
        ,drvAssCityName1 = EepAddressCity
        ,drvAssStateProvinceCode1 = EepAddressState
        ,drvAssPostalCode1 = EepAddressZipCode
        ,drvAssCountryCode1 = 'USA'
        ,drvAssTelephoneTypeCode1 = CASE WHEN EepPhoneHomeNumber is not null then 'HOME' end
        ,drvAssTelephoneNo1 = EepPhoneHomeNumber
        ,drvAssTelephoneTypeCode2 = CASE WHEN CASE WHEN efoPhoneType = 'CEL' THEN CONCAT('1',efoPhoneNumber) END is not null then 'MOBILE' end
        ,drvAssTelephoneNo2 = CASE WHEN efoPhoneType = 'CEL' THEN CONCAT('1',efoPhoneNumber) END
        ,drvAssEmailAddressTypeCode1 = 'WORK'
        ,drvAssEmailAddress1 = eepAddressEMail 
        ,drvAssEmailAddressTypeCode2 = CASE WHEN eepAddressEMailAlternate is not null then 'ALTERNATE' end
        ,drvAssEmailAddress2 = eepAddressEMailAlternate
    INTO dbo.U_ESTAPRUD_AST_drvTbl
    FROM dbo.U_ESTAPRUD_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ESTAPRUD WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESTAPRUD_EMP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTAPRUD_EMP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_EMP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvEmployeeID = EecEmpNo
        ,drvHireDate = EecDateOfOriginalHire
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvEmpTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvJobTitleText = JbcDesc 
        ,drvWorkStatusCode = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'FULL TIME' else 'PART TIME' END
        ,drvEarningsAmt1 = EecAnnSalary
        ,drvEarningsEffDate1 =[dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate] (EecEEID, EecCOID, '20220101',EecDateOfLastHire) 
        ,drvWorkLocStateCd = LocAddressState
    INTO dbo.U_ESTAPRUD_EMP_drvTbl
    FROM dbo.U_ESTAPRUD_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_ESTAPRUD WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESTAPRUD_COV_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTAPRUD_COV_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_COV_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvProdCode = CASE when BdmDedCode = '731' THEN 'WDI' WHEN BdmDedCode IN ('725L', '726L') THEN 'LTD'
                            END
        ,drvCovTierCode = 'EE'
        ,drvCovEffDate = BdmBenStartDate 
        ,drvCovEndDate = BdmBenStopDate
        ,drvClaimBranchCd = CASE    WHEN BdmDedCode IN ('725L', '726L','731') AND jbcJobCode NOT IN ('PRSNTCEO', 'ZZBOD','SVPSWRPR', 'RGPRESAK') THEN '00001'  
                                    WHEN BdmDedCode IN ('725L', '726L') AND jbcJobCode IN ('PRSNTCEO', 'ZZBOD','SVPSWRPR', 'RGPRESAK') THEN '00002'
                                    END
    INTO dbo.U_ESTAPRUD_COV_drvTbl
    FROM dbo.U_ESTAPRUD_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESTAPRUD WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType = 'EMP'
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID 
        AND ConImportID = BdmDepRecID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESTAPRUD_ABS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTAPRUD_ABS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_ABS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvFMLABranchCode = '0001'
        ,drvHrsWorkedLast12Mts = PehCurHrsYTD 
        ,drvFileRunDate = GetDate()
    INTO dbo.U_ESTAPRUD_ABS_drvTbl
    FROM dbo.U_ESTAPRUD_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESTAPRUD WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
	LEFT JOIN dbo.U_ESTAPRUD_PEarHist WITH (NOLOCK)
		ON PehEEID = xEEID
    ;
    -------------------------------
    -- DETAIL RECORD - U_ESTAPRUD_CCH_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTAPRUD_CCH_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_CCH_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'CCH'
        ,drvAssociateID = EecEmpNo
        ,drvCustomCharacCode = 'Reporting Code1'
        ,drvCustomCharacValue = 'CopperPoint Insurance Companies'
    INTO dbo.U_ESTAPRUD_CCH_drvTbl
    FROM dbo.U_ESTAPRUD_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ESTAPRUD WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    ;
    ---------------------------------
    ---- DETAIL RECORD - U_ESTAPRUD_CON_trTbl
    -----------------------------------
    IF OBJECT_ID('U_ESTAPRUD_CON_trTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_CON_trTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvEmpContactID = 'Contact1'
        ,drvContactFirstName ='Tasha'
        ,drvContactLastName = 'Garcia'
        ,drvContactEmailAddrTxt1 ='tgarcia@copperpoint.com'
    INTO dbo.U_ESTAPRUD_CON_trTbl
    FROM dbo.U_ESTAPRUD_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESTAPRUD WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    --;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESTAPRUD_hdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_hdrTbl;
    SELECT DISTINCT
         drvCreationDateTime = GetDate()
         ,drvTESTorProd = 'TEST'
        ,drvActivityStartDT = DATEADD(dd,-13,GetDate())
        ,drvActivityEndDT = GetDate()
    INTO dbo.U_ESTAPRUD_hdrTbl
    FROM dbo.U_ESTAPRUD_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESTAPRUD_trTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAPRUD_trTbl;
    SELECT DISTINCT
         drvRecordType = 'TRL'
        ,drvAuditID = GetDate()
        ,drvAbRelEmpInfoRecQty = (Select count(*) from dbo.U_ESTAPRUD_ABS_drvTbl WITH (NOLOCK))
        ---Format = CCYYMMDD
        ,drvAssRecQty = (Select count(*) from dbo.U_ESTAPRUD_AST_drvTbl WITH (NOLOCK))
        ,drvCovRecQty = (Select count(*) from dbo.U_ESTAPRUD_COV_drvTbl WITH (NOLOCK))
        --,drvDepRecQty = (Select count(*) from dbo.U_ESTAPRUD_ABS_drvTbl WITH (NOLOCK))
        ,drvEmpContRecQty = (Select count(*) from dbo.U_ESTAPRUD_CON_trTbl WITH (NOLOCK))
        ,drvEmpInfoRecQty = (Select count(*) from dbo.U_ESTAPRUD_EMP_drvTbl WITH (NOLOCK))
        ,drvCustCharRecQty = (Select count(*) from dbo.U_ESTAPRUD_CCH_drvTbl WITH (NOLOCK))
        ,drvTotCovAmt = (select sum(BdmEEAmt) from  dbo.U_dsi_BDM_ESTAPRUD WITH (NOLOCK) Where BdmDedCode in ('731','725L','726L'))
        ,drvTotRecQty = (Select count(*) from dbo.U_ESTAPRUD_AST_drvTbl WITH (NOLOCK)) +(Select count(*) from dbo.U_ESTAPRUD_COV_drvTbl WITH (NOLOCK))+(Select count(*) from dbo.U_ESTAPRUD_ABS_drvTbl WITH (NOLOCK)) +(Select count(*) from dbo.U_ESTAPRUD_CON_trTbl WITH (NOLOCK))+(Select count(*) from dbo.U_ESTAPRUD_EMP_drvTbl WITH (NOLOCK))+(Select count(*) from dbo.U_ESTAPRUD_CCH_drvTbl WITH (NOLOCK))
    INTO dbo.U_ESTAPRUD_trTbl
    FROM dbo.U_ESTAPRUD_EEList WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwESTAPRUD_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTAPRUD_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ESTAPRUD%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101121'
       ,expStartPerControl     = '202101121'
       ,expLastEndPerControl   = '202201199'
       ,expEndPerControl       = '202201199'
WHERE expFormatCode = 'ESTAPRUD';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESTAPRUD_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESTAPRUD_File WITH (NOLOCK)
    ORDER BY InitialSort, RIGHT(RecordSet,2)

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESTAPRUD' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESTAPRUD'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESTAPRUD'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESTAPRUD', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESTAPRUD', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESTAPRUD', 'UseFileName', 'V', 'Y'


-- End ripout