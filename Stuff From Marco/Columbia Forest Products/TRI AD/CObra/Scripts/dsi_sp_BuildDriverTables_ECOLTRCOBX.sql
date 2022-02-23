/**********************************************************************************

ECOLTRCOBX: TriAD Flex Cobra Export

FormatCode:     ECOLTRCOBX
Project:        TriAD Flex Cobra Export
Client ID:      COL1010
Date/time:      2022-01-12 18:13:35.880
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E11
Server:         E1SUP1ST56
Database:       ULTIPRO_CFP
Web Filename:   COL1010_5F147_EEHISTORY_ECOLTRCOBX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECOLTRCOBX_SavePath') IS NOT NULL DROP TABLE dbo.U_ECOLTRCOBX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECOLTRCOBX'


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
WHERE FormatCode = 'ECOLTRCOBX'
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
WHERE ExpFormatCode = 'ECOLTRCOBX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECOLTRCOBX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECOLTRCOBX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECOLTRCOBX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECOLTRCOBX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECOLTRCOBX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECOLTRCOBX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECOLTRCOBX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECOLTRCOBX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECOLTRCOBX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECOLTRCOBX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECOLTRCOBX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECOLTRCOBX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECOLTRCOBX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOLTRCOBX];
GO
IF OBJECT_ID('U_ECOLTRCOBX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECOLTRCOBX_PEarHist];
GO
IF OBJECT_ID('U_ECOLTRCOBX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECOLTRCOBX_PDedHist];
GO
IF OBJECT_ID('U_ECOLTRCOBX_File') IS NOT NULL DROP TABLE [dbo].[U_ECOLTRCOBX_File];
GO
IF OBJECT_ID('U_ECOLTRCOBX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECOLTRCOBX_EEList];
GO
IF OBJECT_ID('U_ECOLTRCOBX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECOLTRCOBX_drvTbl];
GO
IF OBJECT_ID('U_ECOLTRCOBX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECOLTRCOBX_DedList];
GO
IF OBJECT_ID('U_ECOLTRCOBX_BdmCobraTable') IS NOT NULL DROP TABLE [dbo].[U_ECOLTRCOBX_BdmCobraTable];
GO
IF OBJECT_ID('U_dsi_BDM_ECOLTRCOBX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECOLTRCOBX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECOLTRCOBX','TriAD Flex Cobra Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ECOLTRCOBXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOLTRCOBXZ0','50','H','01','1',NULL,'APP/DEP Flag',NULL,NULL,'"APP/DEP Flag"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOLTRCOBXZ0','50','H','01','2',NULL,'Employer’s Federal TIN',NULL,NULL,'"Employer’s Federal TIN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECOLTRCOBXZ0','50','H','01','3',NULL,'Employee’s SSN',NULL,NULL,'"Employee’s SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECOLTRCOBXZ0','50','H','01','4',NULL,'Employee ID',NULL,NULL,'"Employee ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECOLTRCOBXZ0','50','H','01','5',NULL,'Dependent’s SSN',NULL,NULL,'"Dependent’s SSN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECOLTRCOBXZ0','50','H','01','6',NULL,'First Name',NULL,NULL,'"First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECOLTRCOBXZ0','50','H','01','7',NULL,'Last Name',NULL,NULL,'"Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECOLTRCOBXZ0','50','H','01','8',NULL,'Middle Initial',NULL,NULL,'"Middle Initial"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECOLTRCOBXZ0','50','H','01','9',NULL,'Street Address1',NULL,NULL,'"Street Address1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECOLTRCOBXZ0','50','H','01','10',NULL,'Street Address2',NULL,NULL,'"Street Address2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECOLTRCOBXZ0','50','H','01','11',NULL,'City',NULL,NULL,'"City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECOLTRCOBXZ0','50','H','01','12',NULL,'State',NULL,NULL,'"State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECOLTRCOBXZ0','50','H','01','13',NULL,'Zip/Postal Code',NULL,NULL,'"Zip/Postal Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECOLTRCOBXZ0','50','H','01','14',NULL,'Gender',NULL,NULL,'"Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECOLTRCOBXZ0','50','H','01','15',NULL,'Marital Status',NULL,NULL,'"Marital Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECOLTRCOBXZ0','50','H','01','16',NULL,'Dependent Relationship Code',NULL,NULL,'"Dependent Relationship Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECOLTRCOBXZ0','50','H','01','17',NULL,'Employee/Dependent Birth Date',NULL,NULL,'"Employee/Dependent Birth Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECOLTRCOBXZ0','50','H','01','18',NULL,'Original Coverage Start Date',NULL,NULL,'"Original Coverage Start Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECOLTRCOBXZ0','50','H','01','19',NULL,'Division',NULL,NULL,'"Division"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECOLTRCOBXZ0','50','H','01','20',NULL,'Qualifying Event Code',NULL,NULL,'"Qualifying Event Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECOLTRCOBXZ0','50','H','01','21',NULL,'Qualifying Event Date',NULL,NULL,'"Qualifying Event Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECOLTRCOBXZ0','50','H','01','22',NULL,'Last Day of Active Coverage',NULL,NULL,'"Last Day of Active Coverage"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECOLTRCOBXZ0','50','H','01','23',NULL,'Benefit 1 Code',NULL,NULL,'"Benefit 1 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECOLTRCOBXZ0','50','H','01','24',NULL,'Benefit 1 Tier',NULL,NULL,'"Benefit 1 Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECOLTRCOBXZ0','50','H','01','25',NULL,'Benefit 2 Code',NULL,NULL,'"Benefit 2 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECOLTRCOBXZ0','50','H','01','26',NULL,'Benefit 2 Tier',NULL,NULL,'"Benefit 2 Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECOLTRCOBXZ0','50','H','01','27',NULL,'Benefit 3 Code',NULL,NULL,'"Benefit 3 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECOLTRCOBXZ0','50','H','01','28',NULL,'Benefit 3 Tier',NULL,NULL,'"Benefit 3 Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECOLTRCOBXZ0','50','H','01','29',NULL,'Benefit 4 Code',NULL,NULL,'"Benefit 4 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECOLTRCOBXZ0','50','H','01','30',NULL,'Benefit 4 Tier',NULL,NULL,'"Benefit 4 Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECOLTRCOBXZ0','50','H','01','31',NULL,'Benefit 5 Code',NULL,NULL,'"Benefit 5 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECOLTRCOBXZ0','50','H','01','32',NULL,'Benefit 5 Tier',NULL,NULL,'"Benefit 5 Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECOLTRCOBXZ0','50','H','01','33',NULL,'Benefit 6 Code',NULL,NULL,'"Benefit 6 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECOLTRCOBXZ0','50','H','01','34',NULL,'Benefit 6 Tier',NULL,NULL,'"Benefit 6 Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECOLTRCOBXZ0','50','H','01','35',NULL,'Benefit 7 Code',NULL,NULL,'"Benefit 7 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECOLTRCOBXZ0','50','H','01','36',NULL,'Benefit 7 Tier',NULL,NULL,'"Benefit 7 Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECOLTRCOBXZ0','50','H','01','37',NULL,'Benefit 8 Code',NULL,NULL,'"Benefit 8 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECOLTRCOBXZ0','50','H','01','38',NULL,'Benefit 8 Tier',NULL,NULL,'"Benefit 8 Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECOLTRCOBXZ0','50','H','01','39',NULL,'Benefit 9 Code',NULL,NULL,'"Benefit 9 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECOLTRCOBXZ0','50','H','01','40',NULL,'Benefit 9 Tier',NULL,NULL,'"Benefit 9 Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECOLTRCOBXZ0','50','H','01','41',NULL,'Benefit 10 Code',NULL,NULL,'"Benefit 10 Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECOLTRCOBXZ0','50','H','01','42',NULL,'Benefit 10 Tier',NULL,NULL,'"Benefit 10 Tier"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECOLTRCOBXZ0','50','H','01','43',NULL,'New Hire/Initial Notification Flag',NULL,NULL,'"New Hire/Initial Notification Flag"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECOLTRCOBXZ0','50','H','01','44',NULL,'Spouse First Name',NULL,NULL,'"Spouse First Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECOLTRCOBXZ0','50','H','01','45',NULL,'Spouse Last Name',NULL,NULL,'"Spouse Last Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECOLTRCOBXZ0','50','H','01','46',NULL,'Number of Dependents',NULL,NULL,'"Number of Dependents"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECOLTRCOBXZ0','50','H','01','47',NULL,'Company Paid Time',NULL,NULL,'"Company Paid Time"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECOLTRCOBXZ0','50','H','01','48',NULL,'Health FSA Monthly Premium',NULL,NULL,'"Health FSA Monthly Premium"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECOLTRCOBXZ0','50','H','01','49',NULL,'Optional Data 3',NULL,NULL,'"Optional Data 3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECOLTRCOBXZ0','50','H','01','50',NULL,'Optional Data 4',NULL,NULL,'"Optional Data 4"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECOLTRCOBXZ0','50','H','01','51',NULL,'Optional Data 5',NULL,NULL,'"Optional Data 5"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECOLTRCOBXZ0','50','H','01','52',NULL,'Optional Data 6',NULL,NULL,'"Optional Data 6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECOLTRCOBXZ0','50','H','01','53',NULL,'Optional Data 7',NULL,NULL,'"Optional Data 7"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECOLTRCOBXZ0','50','H','01','54',NULL,'Optional Data 8',NULL,NULL,'"Optional Data 8"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECOLTRCOBXZ0','50','H','01','55',NULL,'Optional Data 9',NULL,NULL,'"Optional Data 9"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECOLTRCOBXZ0','50','H','01','56',NULL,'Optional Data 10',NULL,NULL,'"Optional Data 10"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOLTRCOBXZ0','50','D','10','1',NULL,'drvAPPDEPFlag',NULL,NULL,'"drvAPPDEPFlag"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOLTRCOBXZ0','50','D','10','2',NULL,'drvEmployersFederalTIN',NULL,NULL,'"drvEmployersFederalTIN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECOLTRCOBXZ0','50','D','10','3',NULL,'drvEmployeesSSN',NULL,NULL,'"drvEmployeesSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECOLTRCOBXZ0','50','D','10','4',NULL,'drvEmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECOLTRCOBXZ0','50','D','10','5',NULL,'drvDependentsSSN',NULL,NULL,'"drvDependentsSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECOLTRCOBXZ0','50','D','10','6',NULL,'drvFirstName',NULL,NULL,'"drvFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECOLTRCOBXZ0','50','D','10','7',NULL,'drvLastName',NULL,NULL,'"drvLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECOLTRCOBXZ0','50','D','10','8',NULL,'drvMiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECOLTRCOBXZ0','50','D','10','9',NULL,'drvStreetAddress1',NULL,NULL,'"drvStreetAddress1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECOLTRCOBXZ0','50','D','10','10',NULL,'drvStreetAddress2',NULL,NULL,'"drvStreetAddress2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECOLTRCOBXZ0','50','D','10','11',NULL,'drvCity',NULL,NULL,'"drvCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECOLTRCOBXZ0','50','D','10','12',NULL,'drvState',NULL,NULL,'"drvState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECOLTRCOBXZ0','50','D','10','13',NULL,'drvZipPostalCode',NULL,NULL,'"drvZipPostalCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECOLTRCOBXZ0','50','D','10','14',NULL,'drvGender',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECOLTRCOBXZ0','50','D','10','15',NULL,'drvMaritalStatus',NULL,NULL,'"drvMaritalStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECOLTRCOBXZ0','50','D','10','16',NULL,'drvDependentRelationshipCode',NULL,NULL,'"drvDependentRelationshipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECOLTRCOBXZ0','50','D','10','17',NULL,'drvEmployeeDependentBirthDate',NULL,NULL,'"drvEmployeeDependentBirthDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECOLTRCOBXZ0','50','D','10','18',NULL,'drvOriginalCoverageStartDate',NULL,NULL,'"drvOriginalCoverageStartDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECOLTRCOBXZ0','50','D','10','19',NULL,'drvDivision',NULL,NULL,'"drvDivision"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECOLTRCOBXZ0','50','D','10','20',NULL,'drvQualifyingEventCode',NULL,NULL,'"drvQualifyingEventCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECOLTRCOBXZ0','50','D','10','21',NULL,'drvQualifyingEventDate',NULL,NULL,'"drvQualifyingEventDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECOLTRCOBXZ0','50','D','10','22',NULL,'drvLastDayofActiveCoverage',NULL,NULL,'"drvLastDayofActiveCoverage"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECOLTRCOBXZ0','50','D','10','23',NULL,'drvBenefit1Code',NULL,NULL,'"drvBenefit1Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECOLTRCOBXZ0','50','D','10','24',NULL,'drvBenefit1Tier',NULL,NULL,'"drvBenefit1Tier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECOLTRCOBXZ0','50','D','10','25',NULL,'drvBenefit2Code',NULL,NULL,'"drvBenefit2Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECOLTRCOBXZ0','50','D','10','26',NULL,'drvBenefit2Tier',NULL,NULL,'"drvBenefit2Tier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECOLTRCOBXZ0','50','D','10','27',NULL,'drvBenefit3Code',NULL,NULL,'"drvBenefit3Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECOLTRCOBXZ0','50','D','10','28',NULL,'drvBenefit3Tier',NULL,NULL,'"drvBenefit3Tier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECOLTRCOBXZ0','50','D','10','29',NULL,'drvBenefit4Code',NULL,NULL,'"drvBenefit4Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECOLTRCOBXZ0','50','D','10','30',NULL,'drvBenefit4Tier',NULL,NULL,'"drvBenefit4Tier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECOLTRCOBXZ0','50','D','10','31',NULL,'drvBenefit5Code',NULL,NULL,'"drvBenefit5Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECOLTRCOBXZ0','50','D','10','32',NULL,'drvBenefit5Tier',NULL,NULL,'"drvBenefit5Tier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECOLTRCOBXZ0','50','D','10','33',NULL,'drvBenefit6Code',NULL,NULL,'"drvBenefit6Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECOLTRCOBXZ0','50','D','10','34',NULL,'drvBenefit6Tier',NULL,NULL,'"drvBenefit6Tier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECOLTRCOBXZ0','50','D','10','35',NULL,'drvBenefit7Code',NULL,NULL,'"drvBenefit7Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECOLTRCOBXZ0','50','D','10','36',NULL,'drvBenefit7Tier',NULL,NULL,'"drvBenefit7Tier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECOLTRCOBXZ0','50','D','10','37',NULL,'drvBenefit8Code',NULL,NULL,'"drvBenefit8Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECOLTRCOBXZ0','50','D','10','38',NULL,'drvBenefit8Tier',NULL,NULL,'"drvBenefit8Tier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECOLTRCOBXZ0','50','D','10','39',NULL,'drvBenefit9Code',NULL,NULL,'"drvBenefit9Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECOLTRCOBXZ0','50','D','10','40',NULL,'drvBenefit9Tier',NULL,NULL,'"drvBenefit9Tier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECOLTRCOBXZ0','50','D','10','41',NULL,'drvBenefit10Code',NULL,NULL,'"drvBenefit10Code"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECOLTRCOBXZ0','50','D','10','42',NULL,'drvBenefit10Tier',NULL,NULL,'"drvBenefit10Tier"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECOLTRCOBXZ0','50','D','10','43',NULL,'drvNewHireInitialNotiFlag',NULL,NULL,'"drvNewHireInitialNotiFlag"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECOLTRCOBXZ0','50','D','10','44',NULL,'drvSpouseFirstName',NULL,NULL,'"drvSpouseFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECOLTRCOBXZ0','50','D','10','45',NULL,'drvSpouseLastName',NULL,NULL,'"drvSpouseLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECOLTRCOBXZ0','50','D','10','46',NULL,'drvNumberofDependents',NULL,NULL,'"drvNumberofDependents"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECOLTRCOBXZ0','50','D','10','47',NULL,'drvCompanyPaidTime',NULL,NULL,'"drvCompanyPaidTime"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECOLTRCOBXZ0','50','D','10','48',NULL,'drvHealthFSAMonthlyPremium',NULL,NULL,'"drvHealthFSAMonthlyPremium"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECOLTRCOBXZ0','50','D','10','49',NULL,'drvOptionalData3',NULL,NULL,'"drvOptionalData3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECOLTRCOBXZ0','50','D','10','50',NULL,'drvOptionalData4',NULL,NULL,'"drvOptionalData4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECOLTRCOBXZ0','50','D','10','51',NULL,'drvOptionalData5',NULL,NULL,'"drvOptionalData5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECOLTRCOBXZ0','50','D','10','52',NULL,'drvOptionalData6',NULL,NULL,'"drvOptionalData6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECOLTRCOBXZ0','50','D','10','53',NULL,'drvOptionalData7',NULL,NULL,'"drvOptionalData7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECOLTRCOBXZ0','50','D','10','54',NULL,'drvOptionalData8',NULL,NULL,'"drvOptionalData8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECOLTRCOBXZ0','50','D','10','55',NULL,'drvOptionalData9',NULL,NULL,'"drvOptionalData9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECOLTRCOBXZ0','50','D','10','56',NULL,'drvOptionalData10',NULL,NULL,'"drvOptionalData10"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECOLTRCOBX_20220112.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202110039','EMPEXPORT','OEACTIVE',NULL,'ECOLTRCOBX',NULL,NULL,NULL,'202110039','Oct  3 2021  2:13PM','Oct  3 2021  2:13PM','202110031',NULL,'','','202110031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202110039','EMPEXPORT','OEPASSIVE',NULL,'ECOLTRCOBX',NULL,NULL,NULL,'202110039','Oct  3 2021  2:13PM','Oct  3 2021  2:13PM','202110031',NULL,'','','202110031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TriAD Flex Export','202110039','EMPEXPORT','ONDEM_XOE',NULL,'ECOLTRCOBX',NULL,NULL,NULL,'202110039','Oct  3 2021  2:13PM','Oct  3 2021  2:13PM','202110031',NULL,'','','202110031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',60DZM,603MK,60DVD,60DPK,P34RH',NULL,NULL,NULL,'TriAD Flex Expor-Sched','202112279','EMPEXPORT','SCH_ECOLTR','Oct  8 2021  3:18PM','ECOLTRCOBX',NULL,NULL,NULL,'202201069','Oct  3 2021  2:13PM','Oct  3 2021  2:13PM','202112301','11','','','202112271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','60DZM,603MK,60DVD,60DPK,P34RH',NULL,NULL,NULL,'TriAD Flex Expor-Test','202201071','EMPEXPORT','TEST_XOE','Jan 12 2022  6:11PM','ECOLTRCOBX',NULL,NULL,NULL,'202201071','Jan  7 2022 12:00AM','Jan  2 2022 12:00AM','202201011','56','','','202201011',dbo.fn_GetTimedKey(),NULL,'us3cPeCOL1010',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOLTRCOBX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOLTRCOBX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOLTRCOBX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOLTRCOBX','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOLTRCOBX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOLTRCOBX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOLTRCOBX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOLTRCOBX','H01','None','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOLTRCOBX','D10','dbo.U_ECOLTRCOBX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECOLTRCOBX
-----------

IF OBJECT_ID('U_dsi_BDM_ECOLTRCOBX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECOLTRCOBX] (
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
-- Create table U_ECOLTRCOBX_BdmCobraTable
-----------

IF OBJECT_ID('U_ECOLTRCOBX_BdmCobraTable') IS NULL
CREATE TABLE [dbo].[U_ECOLTRCOBX_BdmCobraTable] (
    [BdmRecType] varchar(3) NOT NULL,
    [bdmeeid] char(12) NOT NULL,
    [bdmcoid] char(5) NULL,
    [BdmDepRecID] char(12) NULL,
    [BdmCobraReason] char(6) NULL,
    [BdmBenStopDate] datetime NULL,
    [BdmBenStartDate] datetime NULL,
    [BdmBenStatusDate] datetime NULL,
    [BdmDateOfCOBRAEvent] datetime NULL,
    [BdmChangereason] char(6) NULL,
    [Benefit1] varchar(3) NULL,
    [Benefit2] varchar(3) NULL,
    [Benefit3] varchar(3) NULL,
    [Benefit4] varchar(3) NULL,
    [Benefit5] varchar(3) NULL,
    [BenefitOption1] char(6) NULL,
    [BenefitOption2] char(6) NULL,
    [BenefitOption3] char(6) NULL,
    [BenefitOption4] char(6) NULL,
    [BenefitOption5] char(6) NULL,
    [BenefitAmount5] money NULL,
    [ISNPM] varchar(1) NULL
);

-----------
-- Create table U_ECOLTRCOBX_DedList
-----------

IF OBJECT_ID('U_ECOLTRCOBX_DedList') IS NULL
CREATE TABLE [dbo].[U_ECOLTRCOBX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECOLTRCOBX_drvTbl
-----------

IF OBJECT_ID('U_ECOLTRCOBX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECOLTRCOBX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvAPPDEPFlag] varchar(3) NOT NULL,
    [drvEmployersFederalTIN] varchar(9) NOT NULL,
    [drvEmployeesSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvDependentsSSN] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvStreetAddress1] varchar(255) NULL,
    [drvStreetAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipPostalCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvDependentRelationshipCode] varchar(3) NULL,
    [drvEmployeeDependentBirthDate] datetime NULL,
    [drvOriginalCoverageStartDate] datetime NULL,
    [drvDivision] varchar(25) NULL,
    [drvQualifyingEventCode] varchar(2) NULL,
    [drvQualifyingEventDate] datetime NULL,
    [drvLastDayofActiveCoverage] datetime NULL,
    [drvBenefit1Code] varchar(3) NULL,
    [drvBenefit1Tier] varchar(2) NULL,
    [drvBenefit2Code] varchar(3) NULL,
    [drvBenefit2Tier] varchar(2) NULL,
    [drvBenefit3Code] varchar(3) NULL,
    [drvBenefit3Tier] varchar(2) NULL,
    [drvBenefit4Code] varchar(3) NULL,
    [drvBenefit4Tier] varchar(2) NULL,
    [drvBenefit5Code] varchar(3) NULL,
    [drvBenefit5Tier] varchar(2) NULL,
    [drvBenefit6Code] varchar(1) NOT NULL,
    [drvBenefit6Tier] varchar(1) NOT NULL,
    [drvBenefit7Code] varchar(1) NOT NULL,
    [drvBenefit7Tier] varchar(1) NOT NULL,
    [drvBenefit8Code] varchar(1) NOT NULL,
    [drvBenefit8Tier] varchar(1) NOT NULL,
    [drvBenefit9Code] varchar(1) NOT NULL,
    [drvBenefit9Tier] varchar(1) NOT NULL,
    [drvBenefit10Code] varchar(1) NOT NULL,
    [drvBenefit10Tier] varchar(1) NOT NULL,
    [drvNewHireInitialNotiFlag] varchar(1) NULL,
    [drvSpouseFirstName] varchar(100) NULL,
    [drvSpouseLastName] varchar(100) NULL,
    [drvNumberofDependents] varchar(30) NULL,
    [drvCompanyPaidTime] datetime NULL,
    [drvHealthFSAMonthlyPremium] varchar(30) NULL,
    [drvOptionalData3] varchar(1) NOT NULL,
    [drvOptionalData4] varchar(1) NOT NULL,
    [drvOptionalData5] varchar(1) NOT NULL,
    [drvOptionalData6] varchar(1) NOT NULL,
    [drvOptionalData7] varchar(1) NOT NULL,
    [drvOptionalData8] varchar(1) NOT NULL,
    [drvOptionalData9] varchar(1) NOT NULL,
    [drvOptionalData10] varchar(1) NOT NULL
);

-----------
-- Create table U_ECOLTRCOBX_EEList
-----------

IF OBJECT_ID('U_ECOLTRCOBX_EEList') IS NULL
CREATE TABLE [dbo].[U_ECOLTRCOBX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECOLTRCOBX_File
-----------

IF OBJECT_ID('U_ECOLTRCOBX_File') IS NULL
CREATE TABLE [dbo].[U_ECOLTRCOBX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ECOLTRCOBX_PDedHist
-----------

IF OBJECT_ID('U_ECOLTRCOBX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECOLTRCOBX_PDedHist] (
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
-- Create table U_ECOLTRCOBX_PEarHist
-----------

IF OBJECT_ID('U_ECOLTRCOBX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECOLTRCOBX_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOLTRCOBX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Columbia Forest Products

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 10/03/2021
Service Request Number: TekP-2021-08-03-0004

Purpose: TriAD Flex Cobra Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECOLTRCOBX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECOLTRCOBX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECOLTRCOBX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECOLTRCOBX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECOLTRCOBX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOLTRCOBX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOLTRCOBX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOLTRCOBX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOLTRCOBX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOLTRCOBX', 'SCH_ECOLTR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECOLTRCOBX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECOLTRCOBX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECOLTRCOBX';

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
    DELETE FROM dbo.U_ECOLTRCOBX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECOLTRCOBX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '500,501,520,524,525';

    IF OBJECT_ID('U_ECOLTRCOBX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECOLTRCOBX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECOLTRCOBX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section for NPM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CountDependents', 'Y')

    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4,302'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DAU,DPC,SON,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP,DOM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ECOLTRCOBX D
    JOIN dbo.U_dsi_bdm_ECOLTRCOBX E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ECOLTRCOBX
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ECOLTRCOBX
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ECOLTRCOBX
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ECOLTRCOBX
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ECOLTRCOBX
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ECOLTRCOBX
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;
    


  --   --==========================================
 --   -- Insert into BDM Reason code 201 and 204
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_ECOLTRCOBX]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmBenOption]

    )
 Select rectype = 'DEP', dbnCoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 204 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey asc ) as bdmBenstartDate,DbnBenStopDate, edhEffDate,'204'
            ,edhStartDate, DbnBenStopDate, CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END, edhbenoption 
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
            WHERE edhChangeReason in ('204') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
                and dbnrunid  = 'QB'
                        Group by dbnCoid,dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption,DbnBenStopDate


INSERT INTO [dbo].[U_dsi_BDM_ECOLTRCOBX]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
          , [BdmBenOption]

    )
    Select rectype = 'DEP', dbncoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 201 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey asc ) as bdmBenstartDate,DbnBenStopDate, edhEffDate,'201'
            ,edhStartDate, DbnBenStopDate, 'Y',edhbenoption
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
           
            WHERE edhChangeReason in ('201') and DbnBenStatusDate between @startdate and @enddate and dbnValidForExport = 'N' and DbnRelationship not in ('SPS')
            and dbnrunid  = 'QB' and DbnBenStatus <>  ('A')
            Group by dbncoid, dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,DbnBenStopDate,edhbenoption
            ----
            /*
            INSERT INTO [dbo].[U_dsi_BDM_ECOLTRCOBX]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
          , [BdmBenOption]

    )
    
    Select rectype = 'DEP', dbncoid, dbneeid, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 302 Chg reason', 
            DbnRelationship, DbnDateOfBirth, dbnDedcode, (Select top 1 edhBenStartDate from emphded A where A.edhdedcode = dbnDedcode and A.edheeid =  dbneeid and A.edhcoid = dbncoid order by Auditkey asc ) as bdmBenstartDate,edhBenStopDate, edhEffDate,'302'
            ,edhStartDate, edhStopDate, 'Y',edhbenoption
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode
           
            WHERE edhChangeReason in ('302') and dbnbenstopdate between @startdate and @enddate and dbnValidForExport = 'N'
            and dbnrunid  = 'QB'
            Group by dbncoid, dbneeid,DbnDepRecID,DbnRelationship,DbnDateOfBirth,dbnDedcode,edhBenStopDate,edhEffDate,edhStartDate,edhStopDate,edhbenoption
    */
        
            Delete from dbo.U_dsi_BDM_ECOLTRCOBX where bdmdedcode not in (Select dedcode from U_ECOLTRCOBX_DedList)

            Update dbo.U_dsi_BDM_ECOLTRCOBX  
            set bdmNumSpouses = (select count(*) from U_dsi_BDM_ECOLTRCOBX A where A.bdmeeid = X.bdmeeid and A.bdmRelationship = 'SPS' and A.bdmcoid = X.bdmcoid)
            ,bdmNumChildren = (select count(*) from U_dsi_BDM_ECOLTRCOBX A where A.bdmeeid = X.bdmeeid and A.bdmRelationship = 'CHL' and A.bdmcoid = X.bdmcoid)
            from dbo.U_dsi_BDM_ECOLTRCOBX  X

            where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 302 Chg reason');


            Delete from dbo.U_dsi_BDM_ECOLTRCOBX   where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 302 Chg reason') and bdmbenoption is null

            Delete  from dbo.U_dsi_BDM_ECOLTRCOBX where bdmbenstatus = 'C'


    --==========================================
    -- Build Working Tables
    --==========================================

    IF OBJECT_ID('U_ECOLTRCOBX_BdmCobraTable','U') IS NOT NULL
        DROP TABLE dbo.U_ECOLTRCOBX_BdmCobraTable;

    Select distinct B.BdmRecType,B.bdmeeid,B.bdmcoid,B.BdmDepRecID, MAX(BdmCobraReason) as BdmCobraReason,
 MAX(BdmBenStopDate) as BdmBenStopDate,
 MAX(BdmBenStartDate) as BdmBenStartDate,
 MAX(BdmBenStatusDate) as BdmBenStatusDate,
 MAX(BdmDateOfCOBRAEvent) as BdmDateOfCOBRAEvent,
    MAX(BdmChangereason) as BdmChangereason,

    MAX( CASE WHEN bdmdedcode  = '500' THEN 'M01' END) as Benefit1,
    MAX( CASE WHEN bdmdedcode  = '520' THEN 'M02' END) as Benefit2,
    MAX( CASE WHEN bdmdedcode  = '524' THEN 'D01' END) as Benefit3,
    MAX( CASE WHEN bdmdedcode  = '525' THEN 'V01' END) as Benefit4,
    MAX( CASE WHEN bdmdedcode  = '501' THEN 'F01' END) as Benefit5,

    MAX( CASE WHEN bdmdedcode  = '500' THEN BdmBenOption END) as BenefitOption1,
    MAX( CASE WHEN bdmdedcode  = '520' THEN BdmBenOption END) as BenefitOption2,
    MAX( CASE WHEN bdmdedcode  = '524' THEN BdmBenOption END) as BenefitOption3,
    MAX( CASE WHEN bdmdedcode  = '525' THEN BdmBenOption END) as BenefitOption4,
    MAX( CASE WHEN bdmdedcode  = '501' THEN BdmBenOption END) as BenefitOption5, 
    MAX( CASE WHEN bdmdedcode  = '501' THEN BdmEEAmt END) as BenefitAmount5,

    CASE WHEN EXISTS (Select * from dbo.U_dsi_BDM_ECOLTRCOBX A where A.BdmEEID = B.BdmEEID and A.BdmCOID =  B.bdmcoid and A.BdmRunID = 'NPM') THEN '1'  END as ISNPM 
    INTO dbo.U_ECOLTRCOBX_BdmCobraTable
    from dbo.U_dsi_BDM_ECOLTRCOBX B
where bdmrunId = 'QB'
group by B.BdmRecType,B.bdmeeid,B.bdmcoid,B.BdmDepRecID


INSERT INTO dbo.U_ECOLTRCOBX_BdmCobraTable
Select distinct B.BdmRecType,B.bdmeeid,B.bdmcoid,B.BdmDepRecID, MAX(BdmCobraReason) as BdmCobraReason,
 MAX(BdmBenStopDate) as BdmBenStopDate,
 MAX(BdmBenStartDate) as BdmBenStartDate,
 MAX(BdmBenStatusDate) as BdmBenStatusDate,
 MAX(BdmDateOfCOBRAEvent) as BdmDateOfCOBRAEvent,
    MAX(BdmChangereason) as BdmChangereason,
    MAX( CASE WHEN bdmdedcode  = '500' THEN 'M01' END) as Benefit1,
    MAX( CASE WHEN bdmdedcode  = '520' THEN 'M02' END) as Benefit2,
    MAX( CASE WHEN bdmdedcode  = '524' THEN 'D01' END) as Benefit3,
    MAX( CASE WHEN bdmdedcode  = '525' THEN 'V01' END) as Benefit4,
    MAX( CASE WHEN bdmdedcode  = '501' THEN 'F01' END) as Benefit5,

    MAX( CASE WHEN bdmdedcode  = '500' THEN BdmBenOption END) as BenefitOption1,
    MAX( CASE WHEN bdmdedcode  = '520' THEN BdmBenOption END) as BenefitOption2,
    MAX( CASE WHEN bdmdedcode  = '524' THEN BdmBenOption END) as BenefitOption3,
    MAX( CASE WHEN bdmdedcode  = '525' THEN BdmBenOption END) as BenefitOption4,
    MAX( CASE WHEN bdmdedcode  = '501' THEN BdmBenOption END) as BenefitOption5, 
    MAX( CASE WHEN bdmdedcode  = '501' THEN (BdmEEAmt * 52) / 12 END) as BenefitAmount5,
    '1'
    from dbo.U_dsi_BDM_ECOLTRCOBX B
where bdmrunId = 'NPM' and BdmEEID not in (Select distinct bdmeeid from dbo.U_ECOLTRCOBX_BdmCobraTable where isNPM is not null)
group by B.BdmRecType,B.bdmeeid,B.bdmcoid,B.BdmDepRecID

    -----------------------------
    -- Working Table - PDedHist
    ----------------------------
    
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ECOLTRCOBX D
    JOIN dbo.U_dsi_bdm_ECOLTRCOBX E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ECOLTRCOBX
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ECOLTRCOBX
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ECOLTRCOBX
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ECOLTRCOBX
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ECOLTRCOBX
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ECOLTRCOBX
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECOLTRCOBX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECOLTRCOBX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECOLTRCOBX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = CASE WHEN BdmRecType = 'EMP' THEN '1' 
                              ELSE '2'
                         END 
        -- standard fields above and additional driver fields below
        ,drvAPPDEPFlag = CASE WHEN BdmRecType = 'EMP' THEN 'APP' 
                              WHEN BdmRecType = 'DEP' and (BdmCobraReason in ('204','201','LEVNT4','210') or  BdmChangereason in ('204','201','LEVNT4','210')) THEN 'APP' ELSE 'DEP' 
                         END
        ,drvEmployersFederalTIN = '930672034'
        ,drvEmployeesSSN = eepSSN 
        ,drvEmployeeID = EecEmpNo
        ,drvDependentsSSN = ConSSN --CASE WHEN BdmRecType = 'DEP' and BdmCobraReason in ('204','201','LEVNT4','210')THEN  CONSSN ELSE ConSSN END 
        ,drvFirstName = CASE WHEN BdmRecType = 'EMP' THEN  EepNameFirst ELSE ConNameFirst END  
        ,drvLastName = CASE WHEN BdmRecType = 'EMP' THEN  EepNameLast ELSE ConNameLast END  
        ,drvMiddleInitial = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END  
        ,drvStreetAddress1 = CASE WHEN BdmRecType = 'EMP' THEN  EepAddressLine1 ELSE ConAddressLine1 END  
        ,drvStreetAddress2 = CASE WHEN BdmRecType = 'EMP' THEN  EepAddressLine2 ELSE ConAddressLine2 END  
        ,drvCity = CASE WHEN BdmRecType = 'EMP' THEN  EepAddressCity ELSE ConAddressCity END 
        ,drvState =CASE WHEN BdmRecType = 'EMP' THEN  EepAddressState ELSE ConAddressState END  
        ,drvZipPostalCode = CASE WHEN BdmRecType = 'EMP' THEN  EepAddressZipCode ELSE ConAddressZipCode END  
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN  EepGender ELSE ConGender END
        ,drvMaritalStatus = CASE WHEN BdmRecType = 'EMP'   THEN 
                CASE WHEN eepMaritalStatus in ('D','M','S','W') THEN eepMaritalStatus ELSE 'U' END
                
                END
        ,drvDependentRelationshipCode = CASE WHEN ConRelationship in ('EX','SPS') THEN 'SPO' 
                                             WHEN ConRelationship in ('CHL','STC') and ConGender = 'M' THEN 'SON' 
                                             WHEN ConRelationship in ('CHL','STC') and ConGender = 'F' THEN 'DAU'

                                         END
        ,drvEmployeeDependentBirthDate = CASE WHEN bdmrectype = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvOriginalCoverageStartDate = EecDateOfOriginalHire
        ,drvDivision = EecUDField04
        ,drvQualifyingEventCode = 
                                    CASE 
                                        WHEN eecEmplStatus = 'T' and EECUDFIELD08 is not null  THEN 'CS'
                                        WHEN eecEmplStatus = 'T' and eectermtype = 'V' THEN 'FE'
                                       WHEN eecEmplStatus = 'T' and EecTermReason IN ('203', 'E202') THEN 'WW'
                                       WHEN eecEmplStatus = 'T' and EecTermReason IN ('202', '215', 'E104') THEN 'RT'
                                       WHEN eecEmplStatus = 'T' and EecTermReason IN ('218') THEN 'ML'
                                       WHEN eecEmplStatus = 'T' and eectermtype = 'I' THEN 'IV'
                                       
                                       WHEN BdmCobraReason in ('210','LEVNT4') or BdmChangereason  in ('210','LEVNT4') THEN 'DS'
                                       WHEN BdmCobraReason in ('201','LEVNT3') or BdmChangereason  in ('201','LEVNT3') THEN 'DC'
                                       WHEN BdmCobraReason in ('208') or BdmChangereason  in ('208') THEN 'RT'
                                       WHEN BdmCobraReason in ('207') or BdmChangereason  in ('208') THEN 'ML'
                                       WHEN BdmCobraReason in ('203') or BdmChangereason  in ('203') THEN 'RH'
                                      
                                  END
                                  
        ,drvQualifyingEventDate = CASE WHEN BdmDateOfCOBRAEvent is not null then BdmDateOfCOBRAEvent else BdmBenStatusDate END
        ,drvLastDayofActiveCoverage = BdmBenStopDate
        ,drvBenefit1Code = CASE WHEN Benefit1 is not null and ISNPM is null THEN Benefit1 END
        ,drvBenefit1Tier = CASE WHEN Benefit1 is not null and ISNPM is null THEN    
                                    CASE WHEN BenefitOption1 in ('EE') THEN '01'
                                         WHEN BenefitOption1 in ('EECH') THEN '07'
                                         WHEN BenefitOption1 in ('EESP') THEN '08'
                                         WHEN BenefitOption1 in ('EESPCH') THEN '09'
                                    END
                            END
        ,drvBenefit2Code = CASE WHEN Benefit2 is not null and ISNPM is null THEN Benefit2 END
        ,drvBenefit2Tier = CASE WHEN Benefit2 is not null and ISNPM is null THEN    
                                    CASE WHEN BenefitOption2 in ('EE') THEN '01'
                                         WHEN BenefitOption2 in ('EECH') THEN '07'
                                         WHEN BenefitOption2 in ('EESP') THEN '08'
                                         WHEN BenefitOption2 in ('EESPCH') THEN '09'
                                    END
                            END
        ,drvBenefit3Code = CASE WHEN Benefit3 is not null and ISNPM is null THEN Benefit3 END
        ,drvBenefit3Tier = CASE WHEN Benefit3 is not null and ISNPM is null THEN    
                                    CASE WHEN BenefitOption3 in ('EE') THEN '01'
                                         WHEN BenefitOption3 in ('EECH') THEN '07'
                                         WHEN BenefitOption3 in ('EESP') THEN '08'
                                         WHEN BenefitOption3 in ('EESPCH') THEN '09'
                                    END
                            END
        ,drvBenefit4Code = CASE WHEN Benefit4 is not null and ISNPM is null THEN Benefit4 END
        ,drvBenefit4Tier = CASE WHEN Benefit4 is not null and ISNPM is null THEN    
                                    CASE WHEN BenefitOption4 in ('EE') THEN '01'
                                         WHEN BenefitOption4 in ('EECH') THEN '07'
                                         WHEN BenefitOption4 in ('EESP') THEN '08'
                                         WHEN BenefitOption4 in ('EESPCH') THEN '09'
                                    END
                            END
        ,drvBenefit5Code = CASE WHEN Benefit5 is not null and ISNPM is null THEN Benefit5 END
        ,drvBenefit5Tier = CASE WHEN Benefit5 is not null and ISNPM is null THEN    
                                    '01'
                            END
        ,drvBenefit6Code = ''
        ,drvBenefit6Tier = ''
        ,drvBenefit7Code = ''
        ,drvBenefit7Tier = ''
        ,drvBenefit8Code = ''
        ,drvBenefit8Tier = ''
        ,drvBenefit9Code = ''
        ,drvBenefit9Tier = ''
        ,drvBenefit10Code = ''
        ,drvBenefit10Tier = ''
        ,drvNewHireInitialNotiFlag = CASE WHEN ISNPM is not null and EECUDFIELD04 is not null then 'H' END 
        ,drvSpouseFirstName = CASE WHEN ISNPM is not null and EECUDFIELD04 is not null then (Select Top 1 ConNameFirst from dbo.Contacts c where C.ConEEID = BdmEEID AND ConRelationship IN ('EX','SPS') ) END 
        ,drvSpouseLastName =  CASE WHEN ISNPM is not null and EECUDFIELD04 is not null then (Select Top 1 ConNameLast from dbo.Contacts c where C.ConEEID = BdmEEID AND ConRelationship IN ('EX','SPS') ) END 
        ,drvNumberofDependents = CAST( CASE WHEN ISNPM is not null and EECUDFIELD04 is not null and (Select Count(*) from dbo.Contacts c where C.ConEEID = BdmEEID AND C.ConIsDependent ='Y' )  <> 0 then (Select Count(*) from dbo.Contacts c where C.ConEEID = BdmEEID AND C.ConIsDependent ='Y' ) END  as varchar)
        ,drvCompanyPaidTime = EECUDFIELD08
        ,drvHealthFSAMonthlyPremium = CASE WHEN Benefit5 is not null and ISNPM is null then CAST( CONVERT(DECIMAL(10,2),(BenefitAmount5 * 52) / 12) as varchar) END
        ,drvOptionalData3 = ''
        ,drvOptionalData4 = ''
        ,drvOptionalData5 = ''
        ,drvOptionalData6 = ''
        ,drvOptionalData7 = ''
        ,drvOptionalData8 = ''
        ,drvOptionalData9 = ''
        ,drvOptionalData10 = ''
    INTO dbo.U_ECOLTRCOBX_drvTbl
    FROM dbo.U_ECOLTRCOBX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ECOLTRCOBX_BdmCobraTable A WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        On  ConEEID =  bdmeeid
        and ConSystemID = BdmDepRecID
    ;

    Update dbo.U_ECOLTRCOBX_drvTbl set drvNumberofDependents  = '' where isnull(drvNumberofDependents,0) <= 0
    --Update dbo.U_ECOLTRCOBX_drvTbl set drvNumberofDependents  = '' where drvNumberofDependents = '0'
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
ALTER VIEW dbo.dsi_vwECOLTRCOBX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECOLTRCOBX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECOLTRCOBX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202109261'
       ,expStartPerControl     = '202109261'
       ,expLastEndPerControl   = '202110039'
       ,expEndPerControl       = '202110039'
WHERE expFormatCode = 'ECOLTRCOBX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECOLTRCOBX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECOLTRCOBX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECOLTRCOBX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECOLTRCOBX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECOLTRCOBX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECOLTRCOBX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECOLTRCOBX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECOLTRCOBX', 'UseFileName', 'V', 'Y'


-- End ripout