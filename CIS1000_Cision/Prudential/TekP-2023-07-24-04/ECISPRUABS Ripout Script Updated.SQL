/**********************************************************************************

ECISPRUABS: Prudential Absence Disability

FormatCode:     ECISPRUABS
Project:        Prudential Absence Disability
Client ID:      CIS1000
Date/time:      2023-11-02 07:32:35.763
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPCISIN
Web Filename:   CIS1000_35B05_EEHISTORY_ECISPRUABS_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECISPRUABS_SavePath') IS NOT NULL DROP TABLE dbo.U_ECISPRUABS_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECISPRUABS'


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
WHERE FormatCode = 'ECISPRUABS'
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
WHERE ExpFormatCode = 'ECISPRUABS'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECISPRUABS')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECISPRUABS'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECISPRUABS'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECISPRUABS'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECISPRUABS'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECISPRUABS'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECISPRUABS'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECISPRUABS'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECISPRUABS'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECISPRUABS'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECISPRUABS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECISPRUABS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECISPRUABS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECISPRUABS];
GO
IF OBJECT_ID('U_ECISPRUABS_TRL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_TRL_drvTbl];
GO
IF OBJECT_ID('U_ECISPRUABS_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_PEarHist];
GO
IF OBJECT_ID('U_ECISPRUABS_HDR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_HDR_drvTbl];
GO
IF OBJECT_ID('U_ECISPRUABS_File') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_File];
GO
IF OBJECT_ID('U_ECISPRUABS_EMP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_EMP_drvTbl];
GO
IF OBJECT_ID('U_ECISPRUABS_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_EEList];
GO
IF OBJECT_ID('U_ECISPRUABS_DEP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_DEP_drvTbl];
GO
IF OBJECT_ID('U_ECISPRUABS_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_DedList];
GO
IF OBJECT_ID('U_ECISPRUABS_COV_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_COV_drvTbl];
GO
IF OBJECT_ID('U_ECISPRUABS_CON_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_CON_drvTbl];
GO
IF OBJECT_ID('U_ECISPRUABS_CCH_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_CCH_drvTbl];
GO
IF OBJECT_ID('U_ECISPRUABS_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_AuditFields];
GO
IF OBJECT_ID('U_ECISPRUABS_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_Audit];
GO
IF OBJECT_ID('U_ECISPRUABS_AST_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_AST_drvTbl];
GO
IF OBJECT_ID('U_ECISPRUABS_ABS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECISPRUABS_ABS_drvTbl];
GO
IF OBJECT_ID('U_dsi_BDM_ECISPRUABS') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECISPRUABS];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECISPRUABS','Prudential Absence Disability','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ECISPRUABSZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRUABSZ0','3','H','01','1',NULL,'Record Type',NULL,NULL,'"HDR"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRUABSZ0','32','H','01','2',NULL,'Transmission GUID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRUABSZ0','14','H','01','3',NULL,'Creation Date Time',NULL,NULL,'"drvCreationDateTime"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRUABSZ0','10','H','01','4',NULL,'Client Control Number',NULL,NULL,'"71802"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRUABSZ0','80','H','01','5',NULL,'Client Name',NULL,NULL,'"Cision"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRUABSZ0','9','H','01','6',NULL,'SchemaVersionIdentifier',NULL,NULL,'"2.0"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRUABSZ0','80','H','01','7',NULL,'Sender Name',NULL,NULL,'"UKG"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISPRUABSZ0','80','H','01','8',NULL,'Sender Platform Name',NULL,NULL,'"UKG Pro"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECISPRUABSZ0','10','H','01','9',NULL,'Test Production Code',NULL,NULL,'"drvTestProductionCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECISPRUABSZ0','12','H','01','10',NULL,'Transmission Type Code',NULL,NULL,'"FULL FILE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECISPRUABSZ0','14','H','01','11',NULL,'Activity Start Date Time',NULL,NULL,'"drvActivityStartDateTime"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECISPRUABSZ0','14','H','01','12',NULL,'Activity End Date Time',NULL,NULL,'"drvActivityEndDateTime "','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRUABSZ0','3','D','10','1',NULL,'Record Type',NULL,NULL,'"AST"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRUABSZ0','10','D','10','2',NULL,'Client Control Number',NULL,NULL,'"71802"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRUABSZ0','32','D','10','3',NULL,'AssociateID',NULL,NULL,'"drvEmpNo"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRUABSZ0','9','D','10','4',NULL,'Associate Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRUABSZ0','25','D','10','5',NULL,'Associate Gender Code',NULL,NULL,'"drvGender"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRUABSZ0','8','D','10','6',NULL,'Associate Date of Birth',NULL,NULL,'"drvDateofBirth "','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRUABSZ0','8','D','10','7',NULL,'Associate Date of Death',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISPRUABSZ0','25','D','10','8',NULL,'Associate Smoker Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECISPRUABSZ0','30','D','10','9',NULL,'Associate Marital Status Code',NULL,NULL,'"drvMaritialStatus"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECISPRUABSZ0','30','D','10','10',NULL,'Associate Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECISPRUABSZ0','30','D','10','11',NULL,'Associate Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECISPRUABSZ0','80','D','10','12',NULL,'Associate Last Name',NULL,NULL,'"drvLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECISPRUABSZ0','50','D','10','13',NULL,'Associate First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECISPRUABSZ0','50','D','10','14',NULL,'Associate Middle Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECISPRUABSZ0','25','D','10','15',NULL,'Associate Address Type Code 1',NULL,NULL,'"HOME"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECISPRUABSZ0','64','D','10','16',NULL,'Associate Address Line 1 Text 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECISPRUABSZ0','64','D','10','17',NULL,'Associate Address Line 2 Text 1',NULL,NULL,'"drvAddressLine2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECISPRUABSZ0','64','D','10','18',NULL,'Associate Address Line 3 Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECISPRUABSZ0','50','D','10','19',NULL,'Associate City Name 1',NULL,NULL,'"drvAddressCity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECISPRUABSZ0','2','D','10','20',NULL,'Associate State Province Code 1',NULL,NULL,'"drvAddressState"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECISPRUABSZ0','12','D','10','21',NULL,'Associate Postal Code 1',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECISPRUABSZ0','35','D','10','22',NULL,'Associate Country Code 1',NULL,NULL,'"USA"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECISPRUABSZ0','25','D','10','23',NULL,'Associate Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECISPRUABSZ0','64','D','10','24',NULL,'Associate Address Line 1 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECISPRUABSZ0','64','D','10','25',NULL,'Associate Address Line 2 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECISPRUABSZ0','64','D','10','26',NULL,'Associate Address Line 3 Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECISPRUABSZ0','50','D','10','27',NULL,'Associate City Name 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECISPRUABSZ0','2','D','10','28',NULL,'Associate State Province Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECISPRUABSZ0','12','D','10','29',NULL,'Associate Postal Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECISPRUABSZ0','35','D','10','30',NULL,'Associate Country Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECISPRUABSZ0','25','D','10','31',NULL,'Associate Address Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECISPRUABSZ0','64','D','10','32',NULL,'Associate Address Line 1 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECISPRUABSZ0','64','D','10','33',NULL,'Associate Address Line 2 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECISPRUABSZ0','64','D','10','34',NULL,'Associate Address Line 3 Text 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECISPRUABSZ0','50','D','10','35',NULL,'Associate City Name 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECISPRUABSZ0','2','D','10','36',NULL,'Associate State Province Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECISPRUABSZ0','12','D','10','37',NULL,'Associate Postal Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECISPRUABSZ0','35','D','10','38',NULL,'Associate Country Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECISPRUABSZ0','30','D','10','39',NULL,'Associate Telephone Type Code 1',NULL,NULL,'"drvTelephoneTypeCode1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECISPRUABSZ0','20','D','10','40',NULL,'Associate Telephone Number 1',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECISPRUABSZ0','10','D','10','41',NULL,'Associate Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECISPRUABSZ0','30','D','10','42',NULL,'Telephone Type Code 2',NULL,NULL,'"drvTelephoneTypeCode2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECISPRUABSZ0','20','D','10','43',NULL,'Associate Telephone Number 2',NULL,NULL,'"drvAssTelephoneNumber2"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECISPRUABSZ0','10','D','10','44',NULL,'Associate Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECISPRUABSZ0','30','D','10','45',NULL,'Associate Telephone  Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECISPRUABSZ0','20','D','10','46',NULL,'Associate Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECISPRUABSZ0','10','D','10','47',NULL,'Associate Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECISPRUABSZ0','25','D','10','48',NULL,'Associate Email Address Type Code 1',NULL,NULL,'"drvEmailType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECISPRUABSZ0','350','D','10','49',NULL,'Associate Email Address Text 1',NULL,NULL,'"drvAddressEmailAlternate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECISPRUABSZ0','25','D','10','50',NULL,'Associate Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECISPRUABSZ0','350','D','10','51',NULL,'Associate Email Address Text 2',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRUABSZ0','3','D','20','1',NULL,'Record Type',NULL,NULL,'"EMP"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRUABSZ0','10','D','20','2',NULL,'Client Control Number',NULL,NULL,'"71802"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRUABSZ0','32','D','20','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRUABSZ0','32','D','20','4',NULL,'EmployeeID',NULL,NULL,'"drvEmpNo"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRUABSZ0','8','D','20','5',NULL,'Hire Date',NULL,NULL,'"drvDateofOriginalHire "','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRUABSZ0','8','D','20','6',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRUABSZ0','8','D','20','7',NULL,'Retirement Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISPRUABSZ0','8','D','20','8',NULL,'Employment Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECISPRUABSZ0','25','D','20','9',NULL,'Employment Termination Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECISPRUABSZ0','8','D','20','10',NULL,'Adjusted Service Date',NULL,NULL,'"drvAdjustedServiceDate"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECISPRUABSZ0','8','D','20','11',NULL,'Last Active Service Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECISPRUABSZ0','30','D','20','12',NULL,'Employment Status Code',NULL,NULL,'"drvEmplStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECISPRUABSZ0','8','D','20','13',NULL,'Employment Status Effective Date',NULL,NULL,'"drvEmplStatusEffDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECISPRUABSZ0','30','D','20','14',NULL,'Employment Status Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECISPRUABSZ0','30','D','20','15',NULL,'Job Title Text',NULL,NULL,'"drvJobTitleText"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECISPRUABSZ0','30','D','20','16',NULL,'Occupation Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECISPRUABSZ0','25','D','20','17',NULL,'OSHA Job Classification Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECISPRUABSZ0','25','D','20','18',NULL,'Occupation Class Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECISPRUABSZ0','25','D','20','19',NULL,'Work Status Code',NULL,NULL,'"drvWorkStatusCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECISPRUABSZ0','5','D','20','20',NULL,'Weekly Scheduled Hours',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECISPRUABSZ0','5','D','20','21',NULL,'Daily Hours Worked',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECISPRUABSZ0','25','D','20','22',NULL,'Hourly Salary Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECISPRUABSZ0','30','D','20','23',NULL,'Earnings Type  Code 1',NULL,NULL,'"ALTERNATE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECISPRUABSZ0','17','D','20','24',NULL,'Earnings  Amount 1',NULL,NULL,'"drvEarningsAmt1"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECISPRUABSZ0','30','D','20','25',NULL,'Earnings Frequency Code 1',NULL,NULL,'"ANNUAL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECISPRUABSZ0','8','D','20','26',NULL,'Earnings Effective  Date 1',NULL,NULL,'"drvEarningsEffDate1"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECISPRUABSZ0','30','D','20','27',NULL,'Earnings Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECISPRUABSZ0','17','D','20','28',NULL,'Earnings Amount 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECISPRUABSZ0','30','D','20','29',NULL,'Earnings Frequency  Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECISPRUABSZ0','8','D','20','30',NULL,'Earnings Effective Date 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECISPRUABSZ0','30','D','20','31',NULL,'Earnings Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECISPRUABSZ0','17','D','20','32',NULL,'Earnings Amount 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECISPRUABSZ0','30','D','20','33',NULL,'Earnings Frequency Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECISPRUABSZ0','8','D','20','34',NULL,'Earnings Effective Date 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECISPRUABSZ0','25','D','20','35',NULL,'W4 Filing Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECISPRUABSZ0','4','D','20','36',NULL,'W4 Exemptions Number',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECISPRUABSZ0','17','D','20','37',NULL,'W4 Additional Withholding Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECISPRUABSZ0','2','D','20','38',NULL,'W4 Withholding State Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECISPRUABSZ0','2','D','20','39',NULL,'W4 Withholding State Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECISPRUABSZ0','2','D','20','40',NULL,'W4 Withholding State Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECISPRUABSZ0','12','D','20','41',NULL,'W4 Work Location Postal Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECISPRUABSZ0','5','D','20','42',NULL,'Union Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECISPRUABSZ0','25','D','20','43',NULL,'Local Bargaining Unit Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECISPRUABSZ0','25','D','20','44',NULL,'Member Group Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECISPRUABSZ0','25','D','20','45',NULL,'Bill Group Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECISPRUABSZ0','30','D','20','46',NULL,'Payroll Frequency Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECISPRUABSZ0','25','D','20','47',NULL,'District Location Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECISPRUABSZ0','30','D','20','48',NULL,'Employment Location',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECISPRUABSZ0','10','D','20','49',NULL,'Regional Unit',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECISPRUABSZ0','20','D','20','50',NULL,'Employer Information',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECISPRUABSZ0','80','D','20','51',NULL,'Group',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECISPRUABSZ0','2','D','20','52',NULL,'Work Location State Code',NULL,NULL,'"drvWorkLocStateCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECISPRUABSZ0','256','D','20','53',NULL,'Comments',NULL,NULL,'"drvComments"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECISPRUABSZ0','17','D','20','54',NULL,'Year to Date Earnings',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECISPRUABSZ0','8','D','20','55',NULL,'Earnings As of Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRUABSZ0','3','D','30','1',NULL,'Record Type',NULL,NULL,'"COV"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRUABSZ0','10','D','30','2',NULL,'Client Control Number',NULL,NULL,'"71802"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRUABSZ0','32','D','30','3',NULL,'AssociateID',NULL,NULL,'"drvEmpNo"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRUABSZ0','25','D','30','4',NULL,'Product Code',NULL,NULL,'"drvProductCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRUABSZ0','25','D','30','5',NULL,'Coverage Tier Code',NULL,NULL,'"drvCoverageTierCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRUABSZ0','25','D','30','6',NULL,'Product Plan Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRUABSZ0','5','D','30','7',NULL,'Coverage Buy Up Indicator',NULL,NULL,'"drvCovBuyUpIndicator"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISPRUABSZ0','17','D','30','8',NULL,'Coverage Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECISPRUABSZ0','8','D','30','9',NULL,'Coverage  Effective Date',NULL,NULL,'"drvCoverageEffectiveDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECISPRUABSZ0','8','D','30','10',NULL,'Coverage  End Date',NULL,NULL,'"drvCoverageEndDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECISPRUABSZ0','25','D','30','11',NULL,'Coverage Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECISPRUABSZ0','8','D','30','12',NULL,'Coverage Status Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECISPRUABSZ0','25','D','30','13',NULL,'Coverage Status Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECISPRUABSZ0','30','D','30','14',NULL,'Coverage Termination Reduction Type Code',NULL,NULL,'"drvCovTermReductionTypeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECISPRUABSZ0','17','D','30','15',NULL,'Coverage Termination Reduction Amount',NULL,NULL,'"drvCovTermReductionAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECISPRUABSZ0','5','D','30','16',NULL,'Flat Benefit Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECISPRUABSZ0','50','D','30','17',NULL,'Claim Branch Code',NULL,NULL,'"drvClaimBranchCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECISPRUABSZ0','25','D','30','18',NULL,'EOB Correspondence Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECISPRUABSZ0','5','D','30','19',NULL,'Assignment Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECISPRUABSZ0','8','D','30','20',NULL,'Original LTD Coverage Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECISPRUABSZ0','25','D','30','21',NULL,'Partner Product Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECISPRUABSZ0','25','D','30','22',NULL,'Partner Short Benefit Description',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECISPRUABSZ0','8','D','30','23',NULL,'Client Coverage Effective Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECISPRUABSZ0','2','D','30','24',NULL,'Benefit Option Identifier',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECISPRUABSZ0','5','D','30','25',NULL,'Coverage Increase Within 2 years Indicator',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECISPRUABSZ0','3','D','30','26',NULL,'Issuance Age',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECISPRUABSZ0','25','D','30','27',NULL,'Voluntary Basis',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECISPRUABSZ0','8','D','30','28',NULL,'Applicant Eligibility Date',NULL,NULL,'"drvApplEligibilityDate"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECISPRUABSZ0','17','D','30','29',NULL,'Applicant Inforce Benefit Amount',NULL,NULL,'"drvApplInforceBenAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECISPRUABSZ0','17','D','30','30',NULL,'Applicant Additional Benefit Amount',NULL,NULL,'"drvApplAdditlBenefitAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECISPRUABSZ0','35','D','30','31',NULL,'Applicant Relationship Type Code',NULL,NULL,'"drvApplicantRelTypeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECISPRUABSZ0','5','D','30','32',NULL,'Applicant EOI Branch Code',NULL,NULL,'"drvApplicantEOIBranchCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECISPRUABSZ0','35','D','30','33',NULL,'Deduction Type  Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECISPRUABSZ0','17','D','30','34',NULL,'Deduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECISPRUABSZ0','30','D','30','35',NULL,'Deduction Frequency Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECISPRUABSZ0','2','D','30','36',NULL,'Deduction Withholding State',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECISPRUABSZ0','30','D','30','37',NULL,'Payroll Deduction Frequency Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECISPRUABSZ0','17','D','30','38',NULL,'Payroll Deduction Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECISPRUABSZ0','32','D','30','39',NULL,'Coverage Event ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECISPRUABSZ0','40','D','30','40',NULL,'Coverage Event Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECISPRUABSZ0','8','D','30','41',NULL,'Coverage Event Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECISPRUABSZ0','8','D','30','42',NULL,'Coverage Marriage Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECISPRUABSZ0','8','D','30','43',NULL,'Coverage Divorce Date',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRUABSZ0','3','D','40','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRUABSZ0','10','D','40','2',NULL,'Client Control Number',NULL,NULL,'"71802"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRUABSZ0','32','D','40','3',NULL,'AssociateID',NULL,NULL,'"drvEmpNo"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRUABSZ0','32','D','40','4',NULL,'DependentID',NULL,NULL,'"drvDependentID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRUABSZ0','35','D','40','5',NULL,'Dependent Relationship Type Code',NULL,NULL,'"drvDepRelTypeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRUABSZ0','9','D','40','6',NULL,'Dependent Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRUABSZ0','25','D','40','7',NULL,'Dependent Gender Code',NULL,NULL,'"drvConGender"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISPRUABSZ0','8','D','40','8',NULL,'Dependent Date of Birth',NULL,NULL,'"drvConDateofBirth"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECISPRUABSZ0','8','D','40','9',NULL,'Dependent Date of Death',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECISPRUABSZ0','25','D','40','10',NULL,'Dependent Smoker Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECISPRUABSZ0','30','D','40','11',NULL,'Dependent Marital Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECISPRUABSZ0','30','D','40','12',NULL,'Dependent Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECISPRUABSZ0','30','D','40','13',NULL,'Dependent Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECISPRUABSZ0','80','D','40','14',NULL,'Dependent Last Name',NULL,NULL,'"drvDepLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECISPRUABSZ0','50','D','40','15',NULL,'Dependent First Name',NULL,NULL,'"drvDepFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECISPRUABSZ0','50','D','40','16',NULL,'Dependent Middle Name',NULL,NULL,'"drvDepMiddleName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECISPRUABSZ0','25','D','40','17',NULL,'Dependent Address Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECISPRUABSZ0','64','D','40','18',NULL,'DependentAddress Line 1 Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECISPRUABSZ0','64','D','40','19',NULL,'Dependent Address Line 2 Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECISPRUABSZ0','64','D','40','20',NULL,'DependentAddress Line 3 Text',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECISPRUABSZ0','50','D','40','21',NULL,'Dependent City Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECISPRUABSZ0','2','D','40','22',NULL,'Dependent State Province Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECISPRUABSZ0','12','D','40','23',NULL,'DependentPostal Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECISPRUABSZ0','35','D','40','24',NULL,'Dependent Country Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECISPRUABSZ0','30','D','40','25',NULL,'Dependent Telephone Type Code 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECISPRUABSZ0','20','D','40','26',NULL,'Dependent Telephone Number 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECISPRUABSZ0','10','D','40','27',NULL,'Dependent Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECISPRUABSZ0','30','D','40','28',NULL,'Dependent Telephone Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECISPRUABSZ0','20','D','40','29',NULL,'Dependent Telephone Number 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECISPRUABSZ0','10','D','40','30',NULL,'Dependent Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECISPRUABSZ0','30','D','40','31',NULL,'Dependent Telephone  Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECISPRUABSZ0','20','D','40','32',NULL,'Dependent Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECISPRUABSZ0','10','D','40','33',NULL,'Dependent Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECISPRUABSZ0','25','D','40','34',NULL,'Dependent Email Address Type Code 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECISPRUABSZ0','350','D','40','35',NULL,'Dependent Email Address Text 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECISPRUABSZ0','25','D','40','36',NULL,'Dependent Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECISPRUABSZ0','350','D','40','37',NULL,'Dependent Email Address Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECISPRUABSZ0','25','D','40','38',NULL,'Dependent Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECISPRUABSZ0','25','D','40','39',NULL,'Dependent Delete Reason Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECISPRUABSZ0','25','D','40','40',NULL,'Student Status Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECISPRUABSZ0','5','D','40','41',NULL,'Incapacitated Dependent Clause Certification Indic',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECISPRUABSZ0','8','D','40','42',NULL,'Incapacitated Dependent Clause Certification Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECISPRUABSZ0','32','D','40','43',NULL,'Dependent Event ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECISPRUABSZ0','40','D','40','44',NULL,'Dependent Event Type Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECISPRUABSZ0','8','D','40','45',NULL,'Dependent Event Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECISPRUABSZ0','8','D','40','46',NULL,'Dependent Marriage Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECISPRUABSZ0','8','D','40','47',NULL,'Dependent Divorce Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECISPRUABSZ0','32','D','40','48',NULL,'Dependent  PreferenceID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECISPRUABSZ0','25','D','40','49',NULL,'Dependent  CorrespondenceTypeCode',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECISPRUABSZ0','50','D','40','50',NULL,'Dependent  Preferred Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECISPRUABSZ0','32','D','40','51',NULL,'Dependent  Preferred Language',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRUABSZ0','3','D','50','1',NULL,'Record Type',NULL,NULL,'"ABS"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRUABSZ0','10','D','50','2',NULL,'Client Control Number',NULL,NULL,'"71802"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRUABSZ0','32','D','50','3',NULL,'AssociateID',NULL,NULL,'"drvEmpNo"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRUABSZ0','50','D','50','4',NULL,'FMLA Branch Code',NULL,NULL,'"00001"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRUABSZ0','30','D','50','5',NULL,'FMLA Work Location Code',NULL,NULL,'"Cision"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRUABSZ0','25','D','50','6',NULL,'Hours Worked in Last 12 Months',NULL,NULL,'"drvHrsWkdInLast12Mths"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRUABSZ0','8','D','50','7',NULL,'As of Date Hours Worked in Last 12 Months',NULL,NULL,'"drvAsofDtHrsWkdInLast12Mths"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISPRUABSZ0','25','D','50','8',NULL,'Hours Worked Since Last File',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECISPRUABSZ0','25','D','50','9',NULL,'Other Hours Worked in Last 12 Months',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECISPRUABSZ0','8','D','50','10',NULL,'As of Date Other Hours Worked in Last 12 Months',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECISPRUABSZ0','25','D','50','11',NULL,'Employment Sector',NULL,NULL,'"PRIVATE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECISPRUABSZ0','25','D','50','12',NULL,'Employment Type',NULL,NULL,'"PRIVATE BUSINESS EMPLOYER"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECISPRUABSZ0','5','D','50','13',NULL,'Key EE Indicator',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECISPRUABSZ0','5','D','50','14',NULL,'Standard Work Schedule',NULL,NULL,'"FALSE"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECISPRUABSZ0','30','D','50','15',NULL,'Share Leave Relationship Code_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECISPRUABSZ0','12','D','50','16',NULL,'Shared Leave Relationship SSN_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECISPRUABSZ0','30','D','50','17',NULL,'Shared Leave Relationship Prefix Code_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECISPRUABSZ0','80','D','50','18',NULL,'Shared Leave Relationship First Name_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECISPRUABSZ0','50','D','50','19',NULL,'Shared Leave Relationship Middle Name_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECISPRUABSZ0','50','D','50','20',NULL,'Shared Leave Relationship Last Name_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECISPRUABSZ0','30','D','50','21',NULL,'Shared Leave Relationship Suffix Code_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECISPRUABSZ0','32','D','50','22',NULL,'Shared Leave Relationship EE ID_1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECISPRUABSZ0','30','D','50','23',NULL,'Share Leave Relationship Code_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECISPRUABSZ0','12','D','50','24',NULL,'Shared Leave Relationship SSN_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECISPRUABSZ0','30','D','50','25',NULL,'Shared Leave Relationship Prefix Code_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECISPRUABSZ0','80','D','50','26',NULL,'Shared Leave Relationship First Name_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECISPRUABSZ0','50','D','50','27',NULL,'Shared Leave Relationship Middle Name_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECISPRUABSZ0','50','D','50','28',NULL,'Shared Leave Relationship Last Name_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECISPRUABSZ0','30','D','50','29',NULL,'Shared Leave Relationship Suffix Code_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECISPRUABSZ0','32','D','50','30',NULL,'Shared Leave Relationship EE ID_2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECISPRUABSZ0','30','D','50','31',NULL,'Share Leave Relationship Code_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECISPRUABSZ0','12','D','50','32',NULL,'Shared Leave Relationship SSN_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECISPRUABSZ0','30','D','50','33',NULL,'Shared Leave Relationship Prefix Code_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECISPRUABSZ0','80','D','50','34',NULL,'Shared Leave Relationship First Name_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECISPRUABSZ0','50','D','50','35',NULL,'Shared Leave Relationship Middle Name_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECISPRUABSZ0','50','D','50','36',NULL,'Shared Leave Relationship Last Name_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECISPRUABSZ0','30','D','50','37',NULL,'Shared Leave Relationship Suffix Code_3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECISPRUABSZ0','32','D','50','38',NULL,'Shared Leave Relationship EE ID_3',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRUABSZ0','3','D','60','1',NULL,'Record Type',NULL,NULL,'"CCH"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRUABSZ0','10','D','60','2',NULL,'Client Control Number',NULL,NULL,'"71802"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRUABSZ0','32','D','60','3',NULL,'AssociateID',NULL,NULL,'"drvEmpNo"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRUABSZ0','25','D','60','4',NULL,'Custom Characteristic Code',NULL,NULL,'"drvCustCharCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRUABSZ0','17','D','60','5',NULL,'Custom Characteristic Amount',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRUABSZ0','8','D','60','6',NULL,'Custom Characteristic Date',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRUABSZ0','5','D','60','7',NULL,'Custom Characteristic Percent',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISPRUABSZ0','255','D','60','8',NULL,'Custom Characteristic Value Text',NULL,NULL,'"drcCustCharTxt"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRUABSZ0','3','D','70','1',NULL,'Record Type',NULL,NULL,'"CON"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRUABSZ0','10','D','70','2',NULL,'Client Control Number',NULL,NULL,'"71802"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRUABSZ0','32','D','70','3',NULL,'AssociateID',NULL,NULL,'"drvAssociateID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRUABSZ0','32','D','70','4',NULL,'Employment Contact ID',NULL,NULL,'"drvEmpContactID"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRUABSZ0','40','D','70','5',NULL,'Employment Contact Type Code',NULL,NULL,'"drvEmpContactTypeCode"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRUABSZ0','50','D','70','6',NULL,'Employment Contact First Name',NULL,NULL,'"drvEmpContactFirstName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRUABSZ0','80','D','70','7',NULL,'Employment Contact Last Name',NULL,NULL,'"drvEmpContactLastName"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISPRUABSZ0','50','D','70','8',NULL,'Employment Contact Middle Name',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECISPRUABSZ0','30','D','70','9',NULL,'Employment Contact Prefix Title Code',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECISPRUABSZ0','30','D','70','10',NULL,'Employment Contact Suffix',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECISPRUABSZ0','30','D','70','11',NULL,'Employment Contact Telephone Type Code 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECISPRUABSZ0','20','D','70','12',NULL,'Employment Contact Telephone Number 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECISPRUABSZ0','10','D','70','13',NULL,'Employment Contact Telephone Number Extension 1',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECISPRUABSZ0','30','D','70','14',NULL,'Employment Contact Telephone Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECISPRUABSZ0','20','D','70','15',NULL,'Employment Contact Telephone Number 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECISPRUABSZ0','10','D','70','16',NULL,'Employment Contact Telephone Number Extension 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECISPRUABSZ0','30','D','70','17',NULL,'Employment Contact Telephone  Type Code 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECISPRUABSZ0','20','D','70','18',NULL,'Employment Contact Telephone Number 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECISPRUABSZ0','10','D','70','19',NULL,'Employment Contact Telephone Number Extension 3',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECISPRUABSZ0','20','D','70','20',NULL,'Employment Contact Email Address Type Code 1',NULL,NULL,'"WORK"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECISPRUABSZ0','350','D','70','21',NULL,'Employment Contact Email Address Text 1',NULL,NULL,'"drvEmpContactEmail"','(UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECISPRUABSZ0','25','D','70','22',NULL,'Employment Contact Email Address Type Code 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECISPRUABSZ0','350','D','70','23',NULL,'Employment Contact Email Address Text 2',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECISPRUABSZ0','9','D','70','24',NULL,'Employment Contact SSN',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECISPRUABSZ0','32','D','70','25',NULL,'Employment Contact Employee ID',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECISPRUABSZ0','8','D','70','26',NULL,'Employment Contact DOB',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECISPRUABSZ0','3','T','90','1',NULL,'Record Type',NULL,NULL,'"TRL"','(''DA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECISPRUABSZ0','32','T','90','2',NULL,'Audit ID',NULL,NULL,'"drvAuditID"','(''UD112''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECISPRUABSZ0','9','T','90','3',NULL,'Absence Related Employment Information Record Quan',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECISPRUABSZ0','9','T','90','4',NULL,'Associate Record Quantity',NULL,NULL,'"drvAssRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECISPRUABSZ0','9','T','90','5',NULL,'Beneficiary Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECISPRUABSZ0','9','T','90','6',NULL,'Coverage Record Quantity',NULL,NULL,'"drvCovRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECISPRUABSZ0','9','T','90','7',NULL,'Dependent Record Quantity',NULL,NULL,'"drvDepRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECISPRUABSZ0','9','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECISPRUABSZ0','9','T','90','9',NULL,'Employment Information Record Quantity',NULL,NULL,'"drvEmpInfoRecordQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECISPRUABSZ0','9','T','90','10',NULL,'Event Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECISPRUABSZ0','9','T','90','11',NULL,'Preference Record Quantity',NULL,NULL,'""','(''SS''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECISPRUABSZ0','9','T','90','12',NULL,'Custom Characteristics Record Quantity',NULL,NULL,'"drvCustomCharRecQuantity"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECISPRUABSZ0','17','T','90','13',NULL,'Total Coverage Amount',NULL,NULL,'"drvTotalCovAmount"','(''UA''=''T~'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECISPRUABSZ0','9','T','90','14',NULL,'Total Record Quantity',NULL,NULL,'"drvTotalRecordQuantity"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECISPRUABS_20231102.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202310069','EMPEXPORT','OEACTIVE',NULL,'ECISPRUABS',NULL,NULL,NULL,'202310069','Oct  6 2023 10:49AM','Oct  6 2023 10:49AM','202310061',NULL,'','','202310061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202310069','EMPEXPORT','OEPASSIVE',NULL,'ECISPRUABS',NULL,NULL,NULL,'202310069','Oct  6 2023 10:49AM','Oct  6 2023 10:49AM','202310061',NULL,'','','202310061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Absence Disability','202310069','EMPEXPORT','ONDEM_XOE',NULL,'ECISPRUABS',NULL,NULL,NULL,'202310069','Oct  6 2023 10:49AM','Oct  6 2023 10:49AM','202310061',NULL,'','','202310061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Absence Disab-Sched','202310069','EMPEXPORT','SCH_ECISPR',NULL,'ECISPRUABS',NULL,NULL,NULL,'202310069','Oct  6 2023 10:49AM','Oct  6 2023 10:49AM','202310061',NULL,'','','202310061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Prudential Absence Disab-Test','202310189','EMPEXPORT','TEST_XOE','Oct 18 2023 12:15PM','ECISPRUABS',NULL,NULL,NULL,'202310189','Oct 18 2023 12:00AM','Dec 30 1899 12:00AM','202310031','10614','','','202310031',dbo.fn_GetTimedKey(),NULL,'us3lKiCIS1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRUABS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRUABS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRUABS','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRUABS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRUABS','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECISPRUABS','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRUABS','H01','dbo.U_ECISPRUABS_HDR_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRUABS','D10','dbo.U_ECISPRUABS_AST_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRUABS','D20','dbo.U_ECISPRUABS_EMP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRUABS','D30','dbo.U_ECISPRUABS_COV_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRUABS','D40','dbo.U_ECISPRUABS_DEP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRUABS','D50','dbo.U_ECISPRUABS_ABS_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRUABS','D60','dbo.U_ECISPRUABS_CCH_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRUABS','D70','dbo.U_ECISPRUABS_CON_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECISPRUABS','T90','dbo.U_ECISPRUABS_TRL_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECISPRUABS
-----------

IF OBJECT_ID('U_dsi_BDM_ECISPRUABS') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECISPRUABS] (
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
-- Create table U_ECISPRUABS_ABS_drvTbl
-----------

IF OBJECT_ID('U_ECISPRUABS_ABS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_ABS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvEmpNo] char(9) NULL,
    [drvHrsWkdInLast12Mths] nvarchar(4000) NULL,
    [drvAsofDtHrsWkdInLast12Mths] varchar(8) NULL
);

-----------
-- Create table U_ECISPRUABS_AST_drvTbl
-----------

IF OBJECT_ID('U_ECISPRUABS_AST_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_AST_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvEmpNo] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvGender] varchar(6) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvMaritialStatus] varchar(10) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvTelephoneTypeCode1] varchar(6) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvTelephoneTypeCode2] varchar(6) NULL,
    [drvAssTelephoneNumber2] varchar(16) NULL,
    [drvEmailType] varchar(8) NULL,
    [drvAddressEmailAlternate] varchar(50) NULL
);

-----------
-- Create table U_ECISPRUABS_Audit
-----------

IF OBJECT_ID('U_ECISPRUABS_Audit') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_Audit] (
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
-- Create table U_ECISPRUABS_AuditFields
-----------

IF OBJECT_ID('U_ECISPRUABS_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECISPRUABS_CCH_drvTbl
-----------

IF OBJECT_ID('U_ECISPRUABS_CCH_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_CCH_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvEmpNo] char(9) NULL,
    [drvCustCharCode] varchar(16) NOT NULL,
    [drcCustCharTxt] varchar(21) NULL
);

-----------
-- Create table U_ECISPRUABS_CON_drvTbl
-----------

IF OBJECT_ID('U_ECISPRUABS_CON_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_CON_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvAssociateID] char(9) NULL,
    [drvEmpContactID] varchar(9) NOT NULL,
    [drvEmpContactTypeCode] varchar(9) NOT NULL,
    [drvEmpContactFirstName] varchar(256) NULL,
    [drvEmpContactLastName] varchar(256) NULL,
    [drvEmpContactEmail] varchar(256) NULL
);

-----------
-- Create table U_ECISPRUABS_COV_drvTbl
-----------

IF OBJECT_ID('U_ECISPRUABS_COV_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_COV_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvEmpNo] char(9) NULL,
    [drvProductCode] varchar(4) NULL,
    [drvCoverageTierCode] varchar(2) NULL,
    [drvCovBuyUpIndicator] varchar(5) NULL,
    [drvCoverageEffectiveDate] datetime NULL,
    [drvCoverageEndDate] datetime NULL,
    [drvCovTermReductionTypeCode] varchar(1) NOT NULL,
    [drvCovTermReductionAmount] varchar(1) NOT NULL,
    [drvClaimBranchCode] varchar(5) NULL,
    [drvApplEligibilityDate] datetime NULL,
    [drvApplInforceBenAmount] varchar(6) NULL,
    [drvApplAdditlBenefitAmount] nvarchar(4000) NULL,
    [drvApplicantRelTypeCode] varchar(16) NULL,
    [drvApplicantEOIBranchCode] varchar(3) NOT NULL
);

-----------
-- Create table U_ECISPRUABS_DedList
-----------

IF OBJECT_ID('U_ECISPRUABS_DedList') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECISPRUABS_DEP_drvTbl
-----------

IF OBJECT_ID('U_ECISPRUABS_DEP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_DEP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvEmpNo] char(9) NULL,
    [drvDependentID] varchar(12) NOT NULL,
    [drvDepRelTypeCode] varchar(16) NULL,
    [drvSSN] char(11) NULL,
    [drvConGender] varchar(6) NULL,
    [drvConDateofBirth] datetime NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepMiddleName] varchar(1) NULL
);

-----------
-- Create table U_ECISPRUABS_EEList
-----------

IF OBJECT_ID('U_ECISPRUABS_EEList') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECISPRUABS_EMP_drvTbl
-----------

IF OBJECT_ID('U_ECISPRUABS_EMP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_EMP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvAssociateID] char(9) NULL,
    [drvEmpNo] char(9) NULL,
    [drvDateofOriginalHire] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvAdjustedServiceDate] varchar(8) NULL,
    [drvEmplStatusCode] varchar(16) NOT NULL,
    [drvEmplStatusEffDate] datetime NULL,
    [drvJobTitleText] varchar(25) NOT NULL,
    [drvWorkStatusCode] varchar(9) NULL,
    [drvEarningsAmt1] nvarchar(4000) NULL,
    [drvEarningsEffDate1] datetime NULL,
    [drvWorkLocStateCode] varchar(255) NULL,
    [drvComments] nvarchar(4000) NULL
);

-----------
-- Create table U_ECISPRUABS_File
-----------

IF OBJECT_ID('U_ECISPRUABS_File') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ECISPRUABS_HDR_drvTbl
-----------

IF OBJECT_ID('U_ECISPRUABS_HDR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_HDR_drvTbl] (
    [drvCreationDateTime] datetime NOT NULL,
    [drvTestProductionCode] varchar(10) NOT NULL,
    [drvActivityStartDateTime] varchar(8000) NULL,
    [drvActivityEndDateTime] varchar(8000) NULL
);

-----------
-- Create table U_ECISPRUABS_PEarHist
-----------

IF OBJECT_ID('U_ECISPRUABS_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtCom] numeric NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL
);

-----------
-- Create table U_ECISPRUABS_TRL_drvTbl
-----------

IF OBJECT_ID('U_ECISPRUABS_TRL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECISPRUABS_TRL_drvTbl] (
    [drvAuditID] datetime NOT NULL,
    [drvAssRecordQuantity] int NULL,
    [drvCovRecordQuantity] int NULL,
    [drvDepRecordQuantity] int NULL,
    [drvEmpInfoRecordQuantity] int NULL,
    [drvCustomCharRecQuantity] int NULL,
    [drvTotalCovAmount] nvarchar(4000) NULL,
    [drvTotalRecordQuantity] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECISPRUABS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cision US Inc

Created By: Marie Thomerson
Business Analyst: Kim Ephraim
Create Date: 10/06/2023
Service Request Number: TekP-2023-07-24-04

Purpose: Prudential Absence Disability

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        11/1/2023      TekP-2023-07-24-04  Updated multiple fields and case statments per layout update (added left join to contacts table and No locks where missing) 
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECISPRUABS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECISPRUABS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECISPRUABS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECISPRUABS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECISPRUABS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISPRUABS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISPRUABS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISPRUABS', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISPRUABS', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECISPRUABS', 'SCH_ECISPR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECISPRUABS';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECISPRUABS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECISPRUABS';

    -- Declare dates FROM Parameter file
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

    -- Cleans EE List of terms WHERE EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECISPRUABS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECISPRUABS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data FROM audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECISPRUABS_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_AuditFields;
    CREATE TABLE dbo.U_ECISPRUABS_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ECISPRUABS_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ECISPRUABS_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_ECISPRUABS_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECISPRUABS_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_Audit;
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
    INTO dbo.U_ECISPRUABS_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECISPRUABS_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECISPRUABS_Audit ON dbo.U_ECISPRUABS_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_ECISPRUABS_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTD,LTDER,LTDS,STD,LIFEE,LIFES';

    IF OBJECT_ID('U_ECISPRUABS_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECISPRUABS_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','LTD,LTDER,LTDS,STD,LIFEE,LIFES');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSELECTionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDPChild','DPC');

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
    EXEC dbo.dsi_BDM_sp_CalculateBenefitAmounts @FormatCode;

     --==========================================
    -- Build Working Tables
    --==========================================
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECISPRUABS_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_PEarHist;
    SELECT DISTINCT
         PehEEID
       -- ,PrgPayDate             = MAX(PrgPayDate)-- MW commented out
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN ErnIsRegularPayCode = 'Y' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN ErnIsRegularPayCode = 'Y' THEN PehCurHrs ELSE 0.00 END)
        ,PehCurAmtCom           = SUM(CASE WHEN PehEarnCode IN ('COMM','COMM2','COMMT') THEN PehCurAmt ELSE 0.00 END)--PehPerControl >= @StartPerControl AND
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
    INTO dbo.U_ECISPRUABS_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
     PehPerControl between CONVERT(VARCHAR, DATEADD(D,-365,@StartDate), 112) + '1' and @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECISPRUABS_AST_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECISPRUABS_AST_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_AST_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvSSN = eepSSN
        ,drvGender = CASE WHEN EepGender = 'M' THEN 'MALE' ELSE 'FEMALE' END -- MW updated 11/1/2023
        ,drvDateofBirth = EepDateOfBirth
        ,drvMaritialStatus = CASE WHEN EepMaritalStatus = 'M' THEN 'MARRIED' -- MW updated 11/1/2023
                                  WHEN EepMaritalStatus = 'C' THEN 'COMMON LAW'-- MW updated 11/1/2023
                                 ELSE 'SINGLE'-- MW updated 11/1/2023
                              END-- MW updated 11/1/2023
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvTelephoneTypeCode1 = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN  'HOME' -- MW updated 11/1/2023 FROM CASE WHEN EepPhoneHomeNumber is null then '' else 'HOME' END
                                      WHEN    dbo.dsi_fnlib_GetPhoneNumber(EepEEID, 'CEL') IS NOT NULL THEN 'MOBILE'-- MW updated 11/1/2023 
                                   END -- MW updated 11/1/2023 
        ,drvPhoneHomeNumber = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber ELSE dbo.dsi_fnlib_GetPhoneNumber(EepEEID, 'CEL') END -- MW updated 11/1/2023 FROM EepPhoneHomeNumber
        ,drvTelephoneTypeCode2 = CASE WHEN    dbo.dsi_fnlib_GetPhoneNumber(EepEEID, 'CEL') IS NOT NULL THEN 'MOBILE' END  -- MW updated 11/1/2023 CASE WHEN dbo.dsi_fnlib_GetPhoneNumber(EepEEID, 'CEL') is null then '' else  'MOBILE' END
        ,drvAssTelephoneNumber2 = dbo.dsi_fnlib_GetPhoneNumber(EepEEID, 'CEL') 
        ,drvEmailType = CASE WHEN ISNULL(EepAddressEmailAlternate, '') <> '' THEN 'PERSONAL' END -- MW Updated 11/1/2023 FROM being hardcoded
        ,drvAddressEmailAlternate = EepAddressEmailAlternate -- MW Updated 11/1/2023 EepAddressEMail
    INTO dbo.U_ECISPRUABS_AST_drvTbl
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
               AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason <> 'TRO' 
                  AND EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T') --- MW added WITH (NOLOCK)
             )
           )
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        And BdmRecType = 'EMP'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECISPRUABS_EMP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECISPRUABS_EMP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_EMP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvEmpNo = EecEmpNo
        ,drvDateofOriginalHire = EecDateOfOriginalHire
        ,drvRehireDate = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire AND EecJobChangeReason = '101' then EecDateOfLastHire
                            WHEN EecDateOfLastHire <> EecDateOfOriginalHire AND EecHireSource = 'REHIRE' then EecDateOfLastHire
                            END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvAdjustedServiceDate = CASE  ---MW updated from CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
                                       WHEN EecDateOfLastHire <> EecDateOfOriginalHire AND (EecJobChangeReason = '101' OR EecHireSource = 'REHIRE') THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112) -- MW Updated 11/1/2023
                                      END
        ,drvEmplStatusCode = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DECEASED'
                                    WHEN EecEmplStatus = 'T' and EecTermReason IN ('105','206','100','DHRS','DLOC','DSUP','303','305','104','205','300','201','207','202','RSC','301','FRTAG','101','304','VIO','102') THEN 'TERMINATED'
                                    WHEN EecEmplStatus = 'L' THEN 'LEAVE OF ABSENCE'
                                    WHEN EecEmplStatus = 'T' and EecTermReason IN ('FRRES','RUW') THEN 'RESIGNED'
                                    ELSE 'ACTIVE' END
        ,drvEmplStatusEffDate = EecEmplStatusStartDate
        ,drvJobTitleText = JbcDesc 
        ,drvWorkStatusCode = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'FULL TIME'
                                    WHEN EecFullTimeOrPartTime = 'P' THEN 'PART TIME' END
        ,drvEarningsAmt1 = CASE WHEN PehCurAmtCom <> 0.00 THEN FORMAT((EecAnnSalary + (PehCurAmtCom*12)), '##0.00') --MW updated  FORMAT((EecAnnSalary+PehCurAmtCom)*12, '##0.00') 
                                ELSE FORMAT(EecAnnSalary, '##0.00')--MW added 
                            END
        ,drvEarningsEffDate1 = [dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate] (EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire) 
        ,drvWorkLocStateCode = LocAddressState  --EecStateSUI
        ,drvComments = CASE WHEN BdmDedCode IN ('STD') AND EecStateSUI = 'WI' THEN FORMAT(PehCurHrs,'####.##') END
    INTO dbo.U_ECISPRUABS_EMP_drvTbl
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                       AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason <> 'TRO' 
                  AND EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')-- MW added WITH (NOLOCK)
             )
           )
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        And BdmRecType = 'EMP'
    LEFT JOIN dbo.U_ECISPRUABS_PEarHist WITH (NOLOCK) -- MW added WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.LOCATION WITH (NOLOCK)
        ON LocCode = EecLocation 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECISPRUABS_COV_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECISPRUABS_COV_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_COV_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvProductCode = Case    WHEN BdmDedCode ='STD' THEN 'WDI'
                                  WHEN BdmDedCode IN ('LTD','LTDER','LTDS') THEN 'LTD'
                                --WHEN BdmDedCode = 'STD' AND EepAddressState = 'NY' THEN ' DBL'
                                --WHEN BdmDedCode = 'STD' AND EepAddressState = 'NJ' THEN ' TDB'
                                --FOR EOI:
                                WHEN BdmDedCode IN ('LIFEE') THEN 'OGL'
                                WHEN BdmDedCode IN ('LIFES') THEN 'ODGL' END
        ,drvCoverageTierCode = CASE WHEN BdmDedCode = 'STD' THEN 'EE'
                                    WHEN BdmDedCode    in ('LTD','LTDER','LTDS') THEN 'EE'
                                    --WHEN BdmDedCode = 'STD' AND EepAddressState = 'NY' THEN 'EE'
                                    --WHEN BdmDedCode = 'STD' AND EepAddressState = 'NJ' THEN 'EE'
                                --FOR EOI:
                                    WHEN BdmDedCode IN ('LIFEE')  THEN 'EE'
                                    WHEN BdmDedCode IN ('LIFES') THEN 'SP' END
        ,drvCovBuyUpIndicator = Case    WHEN BdmDedCode = 'STD' THEN 'FALSE'
                                        WHEN BdmDedCode in('LTD','LTDER','LTDS') THEN 'TRUE'
                                        --WHEN BdmDedCode = 'STD' AND EepAddressState = 'NY' THEN 'FALSE'
                                        --WHEN BdmDedCode = 'STD' AND EepAddressState = 'NJ' THEN 'FALSE'
                                        --FOR EOI:
                                        WHEN BdmDedCode IN ('LIFEE','LIFES')  THEN 'FALSE' END
        ,drvCoverageEffectiveDate = CASE WHEN BdmDedCode IN ('STD','LTD','LTDER','LTDS') THEN BdmBenStartDate END
        ,drvCoverageEndDate = CASE WHEN BdmDedCode IN ('STD','LTD','LTDER','LTDS') THEN BdmBenStopDate END
        ,drvCovTermReductionTypeCode = ''
        ,drvCovTermReductionAmount = ''
        ,drvClaimBranchCode = CASE WHEN BdmDedCode = 'STD' AND EecOrgLvl1 = 'BRWA' AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00001'
                                            WHEN BdmDedCode = 'STD' AND EecOrgLvl1 = 'BUBULI' AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00002'
                                            WHEN BdmDedCode = 'STD' AND EecOrglvl1 IN ('BUCGI','BUCSE') AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00003'
                                            WHEN BdmDedCode = 'STD' AND EecOrglvl1 IN ('BUFALC','FLCN') AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00004'
                                            WHEN BdmDedCode = 'STD' AND EecOrglvl1 IN ('BUPMEI','BUPME') AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00005'
                                            WHEN BdmDedCode = 'STD' AND EecOrglvl1 = 'BUPRW' AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00006'
                                            --WHEN BdmDedCode = 'STD' AND EepAddressState = 'NY' THEN '00001'
                                            --WHEN BdmDedCode = 'STD' AND EepAddressState = 'NJ' THEN '00001'
                                            --LTD:
                                            WHEN EecJobCode IN ('1CEOUNM','1CEOPME','1PRESDNT','1PREBMBH','1PRZCIAM','1PRESCUS','1CHSTAFF','1CHSTFCO','1DRCRPSY') AND BdmDedCode IN ('LTD','LTDS','LTDER') AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00003'
                                            WHEN BdmDedCode IN ('LTD','LTDS','LTDER') AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00001'
                                            WHEN BdmDedCode IN ('LTD','LTDS','LTDER') AND EecFullTimeOrPartTime = 'F' THEN 'A0002' END
        ,drvApplEligibilityDate = CASE WHEN BdmDedCode IN ('LIFEE','LIFES')  THEN EecDateOfLastHire END
        ,drvApplInforceBenAmount = CASE WHEN BdmDedCode IN ('LIFEE','LIFES') AND BdmBenStatus IN ('A','T','C') AND BdmEEAmt >= 200000 THEN '200000' END
        ,drvApplAdditlBenefitAmount = CASE WHEN BdmDedCode IN ('LIFEE','LIFES') AND BdmBenStatus IN ('A','T','C') AND BdmEEAmt >= 200000 THEN  FORMAT(BdmEEAmt - 200000,'#####') END
        ,drvApplicantRelTypeCode = CASE WHEN  BdmDedCode IN ('LIFEE') AND BdmBenStatus IN ('A','T','C') THEN 'SELF' --MW added BdmDedCode IN ('LIFEE') AND
                                        WHEN BdmDedCode = 'LIFES' AND ConRelationship = 'SPS' AND BdmBenStatus IN ('A','T','C') THEN 'SPOUSE'
                                        WHEN BdmDedCode = 'LIFES' AND ConRelationship = 'DP' AND BdmBenStatus IN ('A','T','C') THEN 'DOMESTIC PARTNER' END
        ,drvApplicantEOIBranchCode = '001'
    INTO dbo.U_ECISPRUABS_COV_drvTbl
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
               AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason <> 'TRO' 
                  AND EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')-- MW added WITH (NOLOCK)
             )
           )
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        --And BdmRecType = 'EMP'
    LEFT JOIN (SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConRelationship, ConGender, ConNameLast, ConNameFirst,ConNameMiddle, ConIsDependent, ConDateOfBirth,  ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth Desc) AS RN         
        FROM dbo.Contacts WITH (NOLOCK) 
        WHERE ConIsDependent = 'Y' AND ConRelationship IN ('SPS','DP')) Con
        ON ConEEID = BdmEEID

UNION

         SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvProductCode = Case    --WHEN BdmDedCode ='STD' THEN 'WDI'
                                --WHEN BdmDedCode IN ('LTD','LTDER','LTDS') THEN 'LTD'
                                WHEN BdmDedCode = 'STD' AND EepAddressState = 'NY' THEN ' DBL'
                                WHEN BdmDedCode = 'STD' AND EepAddressState = 'NJ' THEN ' TDB'
                                --FOR EOI:
                                --WHEN BdmDedCode IN ('LIFEE') THEN 'OGL'
                                --WHEN BdmDedCode IN ('LIFES') THEN 'ODGL' 
                                END
        ,drvCoverageTierCode = Case --WHEN BdmDedCode = 'STD' THEN 'EE'
                                    --WHEN BdmDedCode    in ('LTD','LTDER','LTDS') THEN 'EE'
                                    WHEN BdmDedCode = 'STD' AND EepAddressState = 'NY' THEN 'EE'
                                    WHEN BdmDedCode = 'STD' AND EepAddressState = 'NJ' THEN 'EE'
                                --FOR EOI:
                                    --WHEN BdmDedCode IN ('LIFEE')  THEN 'EE'
                                    --WHEN BdmDedCode IN ('LIFES') THEN 'SP' 
                                    END
        ,drvCovBuyUpIndicator = Case    
                                        --WHEN BdmDedCode = 'STD' THEN 'FALSE'
          --                              WHEN BdmDedCode in('LTD','LTDER','LTDS') THEN 'TRUE'
                                        WHEN BdmDedCode = 'STD' AND EepAddressState = 'NY' THEN 'FALSE'
                                        WHEN BdmDedCode = 'STD' AND EepAddressState = 'NJ' THEN 'FALSE'
                                        --FOR EOI:
                                        --WHEN BdmDedCode IN ('LIFEE','LIFES')  THEN 'FALSE' 
                                        END
        ,drvCoverageEffectiveDate = CASE WHEN BdmDedCode IN ('STD','LTD','LTDER','LTDS') THEN BdmBenStartDate END
        ,drvCoverageEndDate = CASE WHEN BdmDedCode IN ('STD','LTD','LTDER','LTDS') THEN BdmBenStopDate END
        ,drvCovTermReductionTypeCode = ''
        ,drvCovTermReductionAmount = ''
        ,drvClaimBranchCode = CASE -- WHEN --BdmDedCode = 'STD' AND EecOrgLvl1 = 'BRWA' AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00001'
                                            --WHEN BdmDedCode = 'STD' AND EecOrgLvl1 = 'BUBULI' AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00002'
                                            --WHEN BdmDedCode = 'STD' AND EecOrglvl1 IN ('BUCGI','BUCSE') AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00003'
                                            --WHEN BdmDedCode = 'STD' AND EecOrglvl1 IN ('BUFALC','FLCN') AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00004'
                                            --WHEN BdmDedCode = 'STD' AND EecOrglvl1 IN ('BUPMEI','BUPME') AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00005'
                                            --WHEN BdmDedCode = 'STD' AND EecOrglvl1 = 'BUPRW' AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00006'
                                            WHEN BdmDedCode = 'STD' AND EepAddressState = 'NY' THEN '00001'
                                            WHEN BdmDedCode = 'STD' AND EepAddressState = 'NJ' THEN '00001'
                                            --LTD:
                                            --WHEN EecJobCode IN ('1CEOUNM','1CEOPME','1PRESDNT','1PREBMBH','1PRZCIAM','1PRESCUS','1CHSTAFF','1CHSTFCO','1DRCRPSY') AND BdmDedCode IN ('LTD','LTDS','LTDER') AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00003'
                                            --WHEN BdmDedCode IN ('LTD','LTDS','LTDER') AND EecFullTimeOrPartTime = 'F' AND EepAddressCountry = 'US' THEN '00001'
                                            --WHEN BdmDedCode IN ('LTD','LTDS','LTDER') AND EecFullTimeOrPartTime = 'F' THEN 'A0002' 
                                            END
        ,drvApplEligibilityDate = ''-- MW updated--CASE WHEN BdmDedCode IN ('LIFEE','LIFES')  THEN EecDateOfLastHire END 
        ,drvApplInforceBenAmount = ''-- MW updated--CASE WHEN BdmDedCode IN ('LIFEE','LIFES') AND BdmBenStatus IN ('A','T','C') AND BdmEEAmt >= 200000 THEN '200000' END
        ,drvApplAdditlBenefitAmount = ''--CASE WHEN BdmDedCode IN ('LIFEE','LIFES') AND BdmBenStatus IN ('A','T','C') AND BdmEEAmt >= 200000 THEN  FORMAT(BdmEEAmt - 200000,'#####') END
        ,drvApplicantRelTypeCode = ''-- MW updated--CASE WHEN BdmDedCode IN ('LIFEE') AND BdmBenStatus IN ('A','T','C') THEN 'SELF'
                                      --  WHEN BdmDedCode = 'LIFES' AND ConRelationship = 'SPS' AND BdmBenStatus IN ('A','T','C') THEN 'SPOUSE'
                                      --  WHEN BdmDedCode = 'LIFES' AND ConRelationship = 'DP' AND BdmBenStatus IN ('A','T','C') THEN 'DOMESTIC PARTNER' END
        ,drvApplicantEOIBranchCode = '001'
    --INTO dbo.U_ECISPRUABS_COV_drvTbl
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
               AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason <> 'TRO' 
                  AND EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')-- MW added WITH (NOLOCK)
             )
           )
          
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        AND EepAddressState in( 'NY','NJ')
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode = 'STD'-- MW updated
        --And BdmRecType = 'EMP'
    --LEFT JOIN (SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConRelationship, ConGender, ConNameLast, ConNameFirst,ConNameMiddle, ConIsDependent, ConDateOfBirth,  ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth Desc) AS RN         
    --    FROM dbo.Contacts WITH (NOLOCK) 
    --    WHERE ConIsDependent = 'Y' AND ConRelationship IN ('SPS','DP')) Con
    --    ON ConEEID = BdmEEID
        ;
    ---------------------------------
    -- DETAIL RECORD - U_ECISPRUABS_DEP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECISPRUABS_DEP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_DEP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvRecordType =  'DEP'
        ,drvEmpNo = EecEmpNo
        ,drvDependentID = CASE WHEN RN = 1 THEN Concat(EecEmpNo,'001') ELSE Concat(EecEmpNo,'002') END-- create dependent 1 digit sequence # in order of conrelationship = SPS or DP THEN Concat(EecEmpNo+'001') 
        ,drvDepRelTypeCode = Case    WHEN ConRelationship ='SPS' THEN 'SPOUSE'
                                    WHEN ConRelationship ='DP' THEN 'DOMESTIC PARTNER' END
        ,drvSSN = CASE WHEN ConRelationship IN ('SPS','DP') AND ConSSN NOT IN ('000000000', '999999999', '888888888', '123456789') THEN ConSSN END
        ,drvConGender = CASE WHEN ConRelationship IN ('SPS','DP') THEN 
                                        CASE WHEN ConGender = 'M' THEN 'MALE' ELSE 'FEMALE'  END
                                    END
        ,drvConDateofBirth = CASE WHEN ConRelationship IN ('SPS','DP') THEN ConDateOfBirth END
        ,drvDepLastName = CASE WHEN ConRelationship IN ('SPS','DP') THEN ConNameLast END
        ,drvDepFirstName = CASE WHEN ConRelationship IN ('SPS','DP') THEN ConNameFirst END
        ,drvDepMiddleName = CASE WHEN ConRelationship IN ('SPS','DP') THEN LEFT(ConNameMiddle,1) END
    INTO dbo.U_ECISPRUABS_DEP_drvTbl
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                       AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason <> 'TRO' 
                  AND EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')-- MW added WITH (NOLOCK)
             )
           )
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        --And BdmRecType = 'DEP'
    JOIN (SELECT DISTINCT ConEEID, ConSSN, ConSystemID, ConRelationship, ConGender, ConNameLast, ConNameFirst,ConNameMiddle, ConIsDependent, ConDateOfBirth,  ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth Desc) AS RN 
        FROM dbo.Contacts WITH (NOLOCK) 
        WHERE ConIsDependent = 'Y' AND ConRelationship IN ('SPS','DP')) Con
        ON ConEEID = BdmEEID;

    ---------------------------------
    -- DETAIL RECORD - U_ECISPRUABS_ABS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECISPRUABS_ABS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_ABS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvHrsWkdInLast12Mths = FORMAT(PehCurHrs,'###.##') 
        ,drvAsofDtHrsWkdInLast12Mths = CONVERT(VARCHAR(8), GetDate(), 112) -- MW updated from FORMAT(PehCurHrs,'###.##') --CASE WHEN ErnIsRegularPayCode = 'Y' THEN PehCurHrs as of date hours working in last 12 months
    INTO dbo.U_ECISPRUABS_ABS_drvTbl
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                       AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason <> 'TRO' 
                  AND EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WHERE audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')-- MW added WITH (NOLOCK)
             )
           )
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        And BdmRecType = 'EMP'
    LEFT JOIN dbo.U_ECISPRUABS_PEarHist WITH (NOLOCK) -- MW added WITH (NOLOCK)
        ON PehEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECISPRUABS_CCH_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECISPRUABS_CCH_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_CCH_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvCustCharCode = 'Reporting Code 1' 
        ,drcCustCharTxt =  CASE WHEN EecOrgLvl1 = 'BRWA' THEN 'Brandwatch'
                                WHEN EecOrgLvl1 = 'BUBULI' THEN 'Bulletin Intelligence'
                                WHEN EecOrglvl1 IN ('BUCGI','BUCSE') THEN 'Cision'
                                WHEN EecOrglvl1 IN ('BUFALC','FLCN') THEN 'Falcon.IO'
                                WHEN EecOrglvl1 IN ('BUPMEI','BUPME') THEN 'Prime Research'
                                WHEN EecOrglvl1 = 'BUPRW' THEN 'Vocus/PRW' END 
    INTO dbo.U_ECISPRUABS_CCH_drvTbl
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                       AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason <> 'TRO' 
                  AND EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')-- MW added WITH (NOLOCK)
             )
           )
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        And BdmRecType = 'EMP'


        UNION

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvCustCharCode = 'Reporting Code 2' 
        ,drcCustCharTxt =    CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Full Time'
                            ELSE 'Part Time' END
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                       AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason <> 'TRO' 
                  AND EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')-- MW added WITH (NOLOCK)
             )
           )
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        And BdmRecType = 'EMP'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECISPRUABS_CON_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECISPRUABS_CON_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_CON_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvEmpContactID = 'Contact 1'
        ,drvEmpContactTypeCode = 'MANAGER'
        ,drvEmpContactFirstName = dbo.dsi_fnlib_GetSupervisorField_v2('', EecEEID, 'NameFirst')
        ,drvEmpContactLastName = dbo.dsi_fnlib_GetSupervisorField_V2('', EecEEID, 'NameLast')
        ,drvEmpContactEmail = dbo.dsi_fnlib_GetSupervisorField_V2('', EecEEID, 'AddressEMail')
    INTO dbo.U_ECISPRUABS_CON_drvTbl
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                       AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason <> 'TRO' 
                  AND EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')-- MW added WITH (NOLOCK)
             )
           )
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        And BdmRecType = 'EMP'

        UNION

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvAssociateID = EecEmpNo
        ,drvEmpContactID = 'Contact 2'
        ,drvEmpContactTypeCode = 'BNFT COOR'
        ,drvEmpContactFirstName = 'Benefit'
        ,drvEmpContactLastName = 'Coordinator'
        ,drvEmpContactEmail =  'employeebenefits@cision.com'
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                       AND (eecemplstatus <> 'T' 
              OR 
             (    eecemplstatus = 'T' 
                  AND eectermreason <> 'TRO' 
                  AND EXISTS (SELECT 1 FROM dbo.U_ECISPRUABS_Audit WITH (NOLOCK) WHERE audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')-- MW added WITH (NOLOCK)
             )
           )
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        And BdmRecType = 'EMP'
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECISPRUABS_HDR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_HDR_drvTbl;
    SELECT DISTINCT
         drvCreationDateTime = GETDATE()
        ,drvTestProductionCode = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'TEST' ELSE 'PRODUCTION' END
        ,drvActivityStartDateTime = RTRIM(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(20),DATEADD(dd,-6,GETDATE()),20),'-',''),':',''),' ',''))
        ,drvActivityEndDateTime =   RTRIM(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(20),GETDATE(),20),'-',''),':',''),' ',''))
    INTO dbo.U_ECISPRUABS_HDR_drvTbl
    FROM dbo.U_ECISPRUABS_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECISPRUABS WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECISPRUABS_TRL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECISPRUABS_TRL_drvTbl;
    SELECT DISTINCT
         drvAuditID = GETDATE()
        ,drvAssRecordQuantity = (SELECT Count(drvEEID) FROM dbo.U_ECISPRUABS_AST_drvTbl WITH (NOLOCK))
        ,drvCovRecordQuantity = (SELECT Count(drvEEID) FROM dbo.U_ECISPRUABS_COV_drvTbl WITH (NOLOCK))
        ,drvDepRecordQuantity = (SELECT Count(drvEEID) FROM dbo.U_ECISPRUABS_DEP_drvTbl WITH (NOLOCK))
        ,drvEmpInfoRecordQuantity = (SELECT Count(drvEEID) FROM dbo.U_ECISPRUABS_EMP_drvTbl WITH (NOLOCK))
        ,drvCustomCharRecQuantity = (SELECT Count(drvEEID) FROM dbo.U_ECISPRUABS_CCH_drvTbl WITH (NOLOCK))
        ,drvTotalCovAmount = FORMAT(Count(drvEEID) , '####.##')
        ,drvTotalRecordQuantity = (SELECT Count(drvEEID) FROM dbo.U_ECISPRUABS_AST_drvTbl WITH (NOLOCK))+(SELECT Count(drvEEID) FROM dbo.U_ECISPRUABS_COV_drvTbl WITH (NOLOCK))+ (SELECT Count(drvEEID) FROM dbo.U_ECISPRUABS_CCH_drvTbl WITH (NOLOCK))+(SELECT Count(drvEEID) FROM dbo.U_ECISPRUABS_DEP_drvTbl WITH (NOLOCK))+Count(drvEEID) 
    INTO dbo.U_ECISPRUABS_TRL_drvTbl
    FROM dbo.U_ECISPRUABS_EMP_drvTbl WITH (NOLOCK)
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'CISIN_PRUD_TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'CISIN_PRUD_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECISPRUABS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECISPRUABS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECISPRUABS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202309291'
       ,expStartPerControl     = '202309291'
       ,expLastEndPerControl   = '202310069'
       ,expEndPerControl       = '202310069'
WHERE expFormatCode = 'ECISPRUABS';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECISPRUABS_Export AS 
    SELECT TOP 200000000  Data FROM dbo.U_ECISPRUABS_File WITH (NOLOCK)
    ORDER BY CASE when RIGHT(RecordSet,2) = '01' THEN '000000' WHEN RIGHT(RecordSet,2)  = '90' THEN '999999' else InitialSort END,  RIGHT(RecordSet,2)

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECISPRUABS' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECISPRUABS'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECISPRUABS'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECISPRUABS', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECISPRUABS', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECISPRUABS', 'UseFileName', 'V', 'Y'


-- End ripout