/**********************************************************************************

EINSGURDEX: Guardian FMLA and STD Export

FormatCode:     EINSGURDEX
Project:        Guardian FMLA and STD Export
Client ID:      INS1016
Date/time:      2023-04-07 13:14:40.853
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB02
Database:       ULTIPRO_WPINPO
Web Filename:   INS1016_D0E49_EEHISTORY_EINSGURDEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EINSGURDEX_SavePath') IS NOT NULL DROP TABLE dbo.U_EINSGURDEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EINSGURDEX'


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
WHERE FormatCode = 'EINSGURDEX'
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
WHERE ExpFormatCode = 'EINSGURDEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EINSGURDEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EINSGURDEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EINSGURDEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EINSGURDEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EINSGURDEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EINSGURDEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EINSGURDEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EINSGURDEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EINSGURDEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EINSGURDEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEINSGURDEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEINSGURDEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EINSGURDEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINSGURDEX];
GO
IF OBJECT_ID('U_EINSGURDEX_TrailerES') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_TrailerES];
GO
IF OBJECT_ID('U_EINSGURDEX_TrailerDC') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_TrailerDC];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer_SS') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer_SS];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer_RF') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer_RF];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer_rCS') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer_rCS];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer_OS') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer_OS];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer_HW') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer_HW];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer_ES') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer_ES];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer_EN') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer_EN];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer_DC') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer_DC];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer_CS') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer_CS];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer_CO') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer_CO];
GO
IF OBJECT_ID('U_EINSGURDEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Trailer];
GO
IF OBJECT_ID('U_EINSGURDEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_PEarHist];
GO
IF OBJECT_ID('U_EINSGURDEX_Header_SS') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Header_SS];
GO
IF OBJECT_ID('U_EINSGURDEX_Header_RF') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Header_RF];
GO
IF OBJECT_ID('U_EINSGURDEX_Header_OS') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Header_OS];
GO
IF OBJECT_ID('U_EINSGURDEX_Header_HW') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Header_HW];
GO
IF OBJECT_ID('U_EINSGURDEX_Header_ES') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Header_ES];
GO
IF OBJECT_ID('U_EINSGURDEX_Header_EN') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Header_EN];
GO
IF OBJECT_ID('U_EINSGURDEX_Header_DC') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Header_DC];
GO
IF OBJECT_ID('U_EINSGURDEX_Header_CS') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Header_CS];
GO
IF OBJECT_ID('U_EINSGURDEX_Header_CO') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Header_CO];
GO
IF OBJECT_ID('U_EINSGURDEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Header];
GO
IF OBJECT_ID('U_EINSGURDEX_File') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_File];
GO
IF OBJECT_ID('U_EINSGURDEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_EEList];
GO
IF OBJECT_ID('U_EINSGURDEX_drvTbl_SS') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_drvTbl_SS];
GO
IF OBJECT_ID('U_EINSGURDEX_drvTbl_OS') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_drvTbl_OS];
GO
IF OBJECT_ID('U_EINSGURDEX_drvTbl_HW') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_drvTbl_HW];
GO
IF OBJECT_ID('U_EINSGURDEX_drvTbl_ES') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_drvTbl_ES];
GO
IF OBJECT_ID('U_EINSGURDEX_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_drvTbl_EN];
GO
IF OBJECT_ID('U_EINSGURDEX_drvTbl_DC') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_drvTbl_DC];
GO
IF OBJECT_ID('U_EINSGURDEX_drvTbl_CS') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_drvTbl_CS];
GO
IF OBJECT_ID('U_EINSGURDEX_drvTbl_CO') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_drvTbl_CO];
GO
IF OBJECT_ID('U_EINSGURDEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_DedList];
GO
IF OBJECT_ID('U_EINSGURDEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_AuditFields];
GO
IF OBJECT_ID('U_EINSGURDEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EINSGURDEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EINSGURDEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EINSGURDEX];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EINSGURDEX','Guardian FMLA and STD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','4000','S','N','EINSGURDEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','H','01','1',NULL,'Identifier',NULL,NULL,'"HEADER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','H','01','2',NULL,'SectionName',NULL,NULL,'"Roster File"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','H','01','3',NULL,'SectionIdentifier',NULL,NULL,'"RF"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','H','01','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINSGURDEXZ0','50','H','01','5',NULL,'FeedDate',NULL,NULL,'"drvFeedDate"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','H','02','1',NULL,'Identifier',NULL,NULL,'"HEADER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','H','02','2',NULL,'SectionName',NULL,NULL,'"Client Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','H','02','3',NULL,'SectionIdentifier',NULL,NULL,'"CS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','H','02','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','H','03','1',NULL,'Identifier',NULL,NULL,'"HEADER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','H','03','2',NULL,'SectionName',NULL,NULL,'"Default Contact Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','H','03','3',NULL,'SectionIdentifier',NULL,NULL,'"DC"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','H','03','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','H','04','1',NULL,'Identifier',NULL,NULL,'"HEADER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','H','04','2',NULL,'SectionName',NULL,NULL,'"Employee Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','H','04','3',NULL,'SectionIdentifier',NULL,NULL,'"ES"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','H','04','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','H','05','1',NULL,'Identifier',NULL,NULL,'"HEADER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','H','05','2',NULL,'SectionName',NULL,NULL,'"Organization Section "','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','H','05','3',NULL,'SectionIdentifier',NULL,NULL,'"OS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','H','05','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','H','06','1',NULL,'Identifier',NULL,NULL,'"HEADER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','H','06','2',NULL,'SectionName',NULL,NULL,'"Contact Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','H','06','3',NULL,'SectionIdentifier',NULL,NULL,'"CO"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','H','06','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','H','07','1',NULL,'Identifier',NULL,NULL,'"HEADER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','H','07','2',NULL,'SectionName',NULL,NULL,'"Enrollment Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','H','07','3',NULL,'SectionIdentifier',NULL,NULL,'"EN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','H','07','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','H','08','1',NULL,'Identifier',NULL,NULL,'"HEADER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','H','08','2',NULL,'SectionName',NULL,NULL,'"Schedule Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','H','08','3',NULL,'SectionIdentifier',NULL,NULL,'"SS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','H','08','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','H','09','1',NULL,'Identifier',NULL,NULL,'"HEADER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','H','09','2',NULL,'SectionName',NULL,NULL,'"Hours Worked Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','H','09','3',NULL,'SectionIdentifier',NULL,NULL,'"HW"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','H','09','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','D','10','1',NULL,'SectionType',NULL,NULL,'"CS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','D','10','2',NULL,'TPADomain',NULL,NULL,'"drvTPADomain"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','D','10','3',NULL,'GroupNumber',NULL,NULL,'"00044109"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','D','20','1',NULL,'SectionCode',NULL,NULL,'"DC"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','D','20','2',NULL,'GroupNumber',NULL,NULL,'"00044109"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','D','20','3',NULL,'DefaultContactEmail',NULL,NULL,'"drvContactEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','D','20','4',NULL,'DefaultContactFirstName',NULL,NULL,'"drvContactFirstName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINSGURDEXZ0','50','D','20','5',NULL,'DefaultContactLastName',NULL,NULL,'"drvContactLastName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EINSGURDEXZ0','50','D','20','6',NULL,'DefaultContactMiddleName ',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EINSGURDEXZ0','50','D','20','7',NULL,'DefaultContactPrefix',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EINSGURDEXZ0','50','D','20','8',NULL,'DefaultContactSuffix',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EINSGURDEXZ0','50','D','20','9',NULL,'DefaultContactAddress1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EINSGURDEXZ0','50','D','20','10',NULL,'DefaultContactAddress2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EINSGURDEXZ0','50','D','20','11',NULL,'DefaultContactCity',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EINSGURDEXZ0','50','D','20','12',NULL,'DefaultContactState',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EINSGURDEXZ0','50','D','20','13',NULL,'DefaultContactCountry',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EINSGURDEXZ0','50','D','20','14',NULL,'DefaultContactPostalCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EINSGURDEXZ0','50','D','20','15',NULL,'DefaultContactPhone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EINSGURDEXZ0','50','D','20','16',NULL,'DefaultContactPhoneExtension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EINSGURDEXZ0','50','D','20','17',NULL,'DefaultContactFax',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EINSGURDEXZ0','50','D','20','18',NULL,'DefaultContactFaxExtension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EINSGURDEXZ0','50','D','20','19',NULL,'DefaultContactRelationship',NULL,NULL,'"HMRS"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','50','D','30','1',NULL,'SectionCode',NULL,NULL,'"ES"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','50','D','30','2',NULL,'*GroupNumber',NULL,NULL,'"00044109"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','50','D','30','3',NULL,'UniqueIdentifier',NULL,NULL,'"drvUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','50','D','30','4',NULL,'NationalIDNumber',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINSGURDEXZ0','50','D','30','5',NULL,'NationalIDNumberType',NULL,NULL,'"S"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EINSGURDEXZ0','50','D','30','6',NULL,'EmployeeNumber',NULL,NULL,'"drvEmpNo"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EINSGURDEXZ0','50','D','30','7',NULL,'PreviousUniqueIdentifier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EINSGURDEXZ0','50','D','30','8',NULL,'NameFirst',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EINSGURDEXZ0','50','D','30','9',NULL,'NameMiddle',NULL,NULL,'"drvNameMiddle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EINSGURDEXZ0','50','D','30','10',NULL,'NameLast',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EINSGURDEXZ0','50','D','30','11',NULL,'NamePrefix',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EINSGURDEXZ0','50','D','30','12',NULL,'NameSuffix',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EINSGURDEXZ0','50','D','30','13',NULL,'EmploymentStatus',NULL,NULL,'"drvEmploymentStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EINSGURDEXZ0','50','D','30','14',NULL,'EmploymentStatusDate',NULL,NULL,'"drvEmploymentStatusDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EINSGURDEXZ0','50','D','30','15',NULL,'HireDate',NULL,NULL,'"drvHireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EINSGURDEXZ0','50','D','30','16',NULL,'RehireDate',NULL,NULL,'"drvRehireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EINSGURDEXZ0','50','D','30','17',NULL,'ServiceDate',NULL,NULL,'"drvServiceDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EINSGURDEXZ0','50','D','30','18',NULL,'TerminationDate',NULL,NULL,'"drvTerminationDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EINSGURDEXZ0','50','D','30','19',NULL,'BirthDate',NULL,NULL,'"drvBirthDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EINSGURDEXZ0','50','D','30','20',NULL,'DeceasedDate',NULL,NULL,'"drvDeceasedDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EINSGURDEXZ0','50','D','30','21',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EINSGURDEXZ0','50','D','30','22',NULL,'MaritalStatus ',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EINSGURDEXZ0','50','D','30','23',NULL,'IsFullTime',NULL,NULL,'"drvIsFullTime"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EINSGURDEXZ0','51','D','30','24',NULL,'IsFlsaExempt',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EINSGURDEXZ0','52','D','30','25',NULL,'IsHourly ',NULL,NULL,'"drvIsHourly"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EINSGURDEXZ0','53','D','30','26',NULL,'JobStartDate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EINSGURDEXZ0','54','D','30','27',NULL,'JobTitle',NULL,NULL,'"drvJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EINSGURDEXZ0','55','D','30','28',NULL,'JobCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EINSGURDEXZ0','56','D','30','29',NULL,'WorkStateCode',NULL,NULL,'"drvWorkStateCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EINSGURDEXZ0','57','D','30','30',NULL,'WorkCountryCode',NULL,NULL,'"US"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EINSGURDEXZ0','58','D','30','31',NULL,'TotalHoursWorkedLast12Months',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EINSGURDEXZ0','59','D','30','32',NULL,'KeyEmployee',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EINSGURDEXZ0','60','D','30','33',NULL,'EmployeeClass',NULL,NULL,'"Default"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EINSGURDEXZ0','61','D','30','34',NULL,'WorkSiteOrgCode',NULL,NULL,'"drvWorkLocation"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EINSGURDEXZ0','62','D','30','35',NULL,'EmployeeEmail',NULL,NULL,'"drvEmployeeEmail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EINSGURDEXZ0','63','D','30','36',NULL,'OrgCode',NULL,NULL,'"drvOrgCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EINSGURDEXZ0','64','D','30','37',NULL,'Pay',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EINSGURDEXZ0','65','D','30','38',NULL,'PayType',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EINSGURDEXZ0','66','D','30','39',NULL,'Pay Period',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EINSGURDEXZ0','67','D','30','40',NULL,'PayEffectiveDate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EINSGURDEXZ0','68','D','30','41',NULL,'MailingAddress1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EINSGURDEXZ0','69','D','30','42',NULL,'MailingAddress2 ',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EINSGURDEXZ0','70','D','30','43',NULL,'MailingCity',NULL,NULL,'"drvAddresscity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EINSGURDEXZ0','71','D','30','44',NULL,'MailingStateCode',NULL,NULL,'"drvAddressstate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EINSGURDEXZ0','72','D','30','45',NULL,'MailingPostalCode',NULL,NULL,'"drvAddresszipcode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EINSGURDEXZ0','73','D','30','46',NULL,'MailingCountryCode',NULL,NULL,'"drvAddresscountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EINSGURDEXZ0','74','D','30','47',NULL,'HomePhone',NULL,NULL,'"drvHomePhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EINSGURDEXZ0','75','D','30','48',NULL,'HomeFax',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EINSGURDEXZ0','76','D','30','49',NULL,'HomeCell',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EINSGURDEXZ0','77','D','30','50',NULL,'WorkAddress1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EINSGURDEXZ0','78','D','30','51',NULL,'WorkAddress2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EINSGURDEXZ0','79','D','30','52',NULL,'WorkAddressCity',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EINSGURDEXZ0','80','D','30','53',NULL,'WorkAddressStateCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EINSGURDEXZ0','81','D','30','54',NULL,'WorkAddressPostalCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EINSGURDEXZ0','82','D','30','55',NULL,'WorkAddressCountryCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EINSGURDEXZ0','83','D','30','56',NULL,'WorkAddressPhone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EINSGURDEXZ0','84','D','30','57',NULL,'WorkAddressExtension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EINSGURDEXZ0','85','D','30','58',NULL,'WorkAddressFax',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EINSGURDEXZ0','86','D','30','59',NULL,'WorkAddressFaxExtension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EINSGURDEXZ0','87','D','30','60',NULL,'WorkAddressEmail',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','88','D','40','1',NULL,'SectionCode',NULL,NULL,'"OS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','89','D','40','2',NULL,'GroupNumber',NULL,NULL,'"00044109"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','90','D','40','3',NULL,'OrgCode',NULL,NULL,'"drvOrgCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','91','D','40','4',NULL,'OrgName',NULL,NULL,'"drvOrgDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINSGURDEXZ0','92','D','40','5',NULL,'OrgType',NULL,NULL,'"DIVS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EINSGURDEXZ0','93','D','40','6',NULL,'OrgAddress1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EINSGURDEXZ0','94','D','40','7',NULL,'OrgAddress2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EINSGURDEXZ0','95','D','40','8',NULL,'OrgCity',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EINSGURDEXZ0','96','D','40','9',NULL,'OrgStateCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EINSGURDEXZ0','97','D','40','10',NULL,'OrgPostalCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EINSGURDEXZ0','98','D','40','11',NULL,'OrgCountryCode',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EINSGURDEXZ0','99','D','40','12',NULL,'OrgPhone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EINSGURDEXZ0','100','D','40','13',NULL,'OrgPhoneExtension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EINSGURDEXZ0','101','D','40','14',NULL,'OrgFax',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EINSGURDEXZ0','102','D','40','15',NULL,'OrgFaxExtension',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EINSGURDEXZ0','103','D','40','16',NULL,'OrgEmail',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EINSGURDEXZ0','104','D','40','17',NULL,'OrgParentOrgCode',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','105','D','50','1',NULL,'SectionCode',NULL,NULL,'"CO"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','106','D','50','2',NULL,'GroupNumber',NULL,NULL,'"00044109"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','107','D','50','3',NULL,'UniqueIdentifier',NULL,NULL,'"drvUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','108','D','50','4',NULL,'Relationship',NULL,NULL,'"SUPR"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINSGURDEXZ0','109','D','50','5',NULL,'ContactUniqueIdentifier',NULL,NULL,'"drvContactUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EINSGURDEXZ0','110','D','50','6',NULL,'DefaultContactEmail',NULL,NULL,'"drvContactEmail"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','111','D','60','1',NULL,'SectionCode',NULL,NULL,'"EN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','112','D','60','2',NULL,'GroupNumber',NULL,NULL,'"00044109"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','113','D','60','3',NULL,'UniqueIdentifier',NULL,NULL,'"drvUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','114','D','60','4',NULL,'PlanCode',NULL,NULL,'"STD"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINSGURDEXZ0','115','D','60','5',NULL,'FromDate',NULL,NULL,'"drvhireDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EINSGURDEXZ0','116','D','60','6',NULL,'ThruDate',NULL,NULL,'"drvTermDate"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','117','D','70','1',NULL,'SectionCode',NULL,NULL,'"SS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','118','D','70','2',NULL,'GroupNumber',NULL,NULL,'"00044109"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','119','D','70','3',NULL,'UniqueIdentifier',NULL,NULL,'"drvUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','120','D','70','4',NULL,'ScheduleFromDate',NULL,NULL,'"drvSchedFromDate"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINSGURDEXZ0','121','D','70','5',NULL,'ScheduleThruDate',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EINSGURDEXZ0','122','D','70','6',NULL,'WeeklyHours',NULL,NULL,'"40.00"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EINSGURDEXZ0','123','D','70','7',NULL,'HoursMon',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EINSGURDEXZ0','124','D','70','8',NULL,'HoursTue',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EINSGURDEXZ0','125','D','70','9',NULL,'HoursWed',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EINSGURDEXZ0','126','D','70','10',NULL,'HoursThur',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EINSGURDEXZ0','127','D','70','11',NULL,'HoursFri',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EINSGURDEXZ0','128','D','70','12',NULL,'HoursSat',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EINSGURDEXZ0','129','D','70','13',NULL,'HoursSun ',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','130','D','80','1',NULL,'SectionCode',NULL,NULL,'"HW"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','131','D','80','2',NULL,'GroupNumber',NULL,NULL,'"00044109"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','132','D','80','3',NULL,'UniqueIdentifier',NULL,NULL,'"drvUniqueID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','133','D','80','4',NULL,'Type',NULL,NULL,'"12M"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINSGURDEXZ0','134','D','80','5',NULL,'Hours',NULL,NULL,'"drvHours"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','135','T','90','1',NULL,'Identifier',NULL,NULL,'"FOOTER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','136','T','90','2',NULL,'SectionName',NULL,NULL,'"Client Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','137','T','90','3',NULL,'SectionIdentifier',NULL,NULL,'"CS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','138','T','90','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','135','T','91','1',NULL,'Identifier',NULL,NULL,'"FOOTER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','136','T','91','2',NULL,'SectionName',NULL,NULL,'"Default Contact Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','137','T','91','3',NULL,'SectionIdentifier',NULL,NULL,'"DC"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','138','T','91','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','135','T','92','1',NULL,'Identifier',NULL,NULL,'"FOOTER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','136','T','92','2',NULL,'SectionName',NULL,NULL,'"Employee Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','137','T','92','3',NULL,'SectionIdentifier',NULL,NULL,'"ES"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','138','T','92','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','135','T','93','1',NULL,'Identifier',NULL,NULL,'"FOOTER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','136','T','93','2',NULL,'SectionName',NULL,NULL,'"Organization Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','137','T','93','3',NULL,'SectionIdentifier',NULL,NULL,'"OS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','138','T','93','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','135','T','94','1',NULL,'Identifier',NULL,NULL,'"FOOTER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','136','T','94','2',NULL,'SectionName',NULL,NULL,'"Contact Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','137','T','94','3',NULL,'SectionIdentifier',NULL,NULL,'"CO"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','138','T','94','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','135','T','95','1',NULL,'Identifier',NULL,NULL,'"FOOTER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','136','T','95','2',NULL,'SectionName',NULL,NULL,'"Schedule Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','137','T','95','3',NULL,'SectionIdentifier',NULL,NULL,'"SS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','138','T','95','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','135','T','96','1',NULL,'Identifier',NULL,NULL,'"FOOTER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','136','T','96','2',NULL,'SectionName',NULL,NULL,'"Hours Worked Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','137','T','96','3',NULL,'SectionIdentifier',NULL,NULL,'"HW"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','138','T','96','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','135','T','97','1',NULL,'Identifier',NULL,NULL,'"FOOTER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','136','T','97','2',NULL,'SectionName',NULL,NULL,'"Enrollment Section"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','137','T','97','3',NULL,'SectionIdentifier',NULL,NULL,'"EN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','138','T','97','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINSGURDEXZ0','135','T','98','1',NULL,'Identifier',NULL,NULL,'"FOOTER"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINSGURDEXZ0','136','T','98','2',NULL,'SectionName',NULL,NULL,'"Roster File"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINSGURDEXZ0','137','T','98','3',NULL,'SectionIdentifier',NULL,NULL,'"RF"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINSGURDEXZ0','138','T','98','4',NULL,'RecordCount',NULL,NULL,'"drvRecordCount"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EINSGURDEX_20230407.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Guardian FMLA and STD Export','202304079','EMPEXPORT','ONDEM_XOE',NULL,'EINSGURDEX',NULL,NULL,NULL,'202304079','Apr  7 2023 10:11AM','Apr  7 2023 10:11AM','202304071',NULL,'','','202304071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Guardian FMLA and STD Ex-Sched','202304079','EMPEXPORT','SCH_EINSGU',NULL,'EINSGURDEX',NULL,NULL,NULL,'202304079','Apr  7 2023 10:11AM','Apr  7 2023 10:11AM','202304071',NULL,'','','202304071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Guardian FMLA and STD Ex-Test','202304079','EMPEXPORT','TEST_XOE',NULL,'EINSGURDEX',NULL,NULL,NULL,'202304079','Apr  7 2023 10:11AM','Apr  7 2023 10:11AM','202304071',NULL,'','','202304071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINSGURDEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINSGURDEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINSGURDEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINSGURDEX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINSGURDEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINSGURDEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINSGURDEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','H01','dbo.U_EINSGURDEX_Header_RF',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','H02','dbo.U_EINSGURDEX_Header_CS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','H03','dbo.U_EINSGURDEX_Header_DC',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','H04','dbo.U_EINSGURDEX_Header_ES',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','H05','dbo.U_EINSGURDEX_Header_OS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','H06','dbo.U_EINSGURDEX_Header_CO',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','H07','dbo.U_EINSGURDEX_Header_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','H08','dbo.U_EINSGURDEX_Header_SS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','H09','dbo.U_EINSGURDEX_Header_HW',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','D10','dbo.U_EINSGURDEX_drvTbl_CS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','D20','dbo.U_EINSGURDEX_drvTbl_DC',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','D30','dbo.U_EINSGURDEX_drvTbl_ES',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','D40','dbo.U_EINSGURDEX_drvTbl_OS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','D50','dbo.U_EINSGURDEX_drvTbl_CO',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','D60','dbo.U_EINSGURDEX_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','D70','dbo.U_EINSGURDEX_drvTbl_SS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','D80','dbo.U_EINSGURDEX_drvTbl_HW',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','T90','dbo.U_EINSGURDEX_Trailer_CS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','T91','dbo.U_EINSGURDEX_Trailer_DC',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','T92','dbo.U_EINSGURDEX_Trailer_ES',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','T93','dbo.U_EINSGURDEX_Trailer_OS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','T94','dbo.U_EINSGURDEX_Trailer_CO',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','T95','dbo.U_EINSGURDEX_Trailer_SS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','T96','dbo.U_EINSGURDEX_Trailer_HW',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','T97','dbo.U_EINSGURDEX_Trailer_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINSGURDEX','T98','dbo.U_EINSGURDEX_Trailer_RF',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EINSGURDEX
-----------

IF OBJECT_ID('U_dsi_BDM_EINSGURDEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EINSGURDEX] (
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
-- Create table U_EINSGURDEX_Audit
-----------

IF OBJECT_ID('U_EINSGURDEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
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
-- Create table U_EINSGURDEX_AuditFields
-----------

IF OBJECT_ID('U_EINSGURDEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EINSGURDEX_DedList
-----------

IF OBJECT_ID('U_EINSGURDEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EINSGURDEX_drvTbl_CO
-----------

IF OBJECT_ID('U_EINSGURDEX_drvTbl_CO') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_drvTbl_CO] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] char(9) NULL,
    [drvUniqueID] char(9) NULL,
    [drvContactUniqueID] varchar(256) NULL,
    [drvContactEmail] varchar(256) NULL
);

-----------
-- Create table U_EINSGURDEX_drvTbl_CS
-----------

IF OBJECT_ID('U_EINSGURDEX_drvTbl_CS') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_drvTbl_CS] (
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvTPADomain] varchar(14) NOT NULL
);

-----------
-- Create table U_EINSGURDEX_drvTbl_DC
-----------

IF OBJECT_ID('U_EINSGURDEX_drvTbl_DC') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_drvTbl_DC] (
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvContactEmail] varchar(17) NOT NULL,
    [drvContactFirstName] varchar(8) NOT NULL,
    [drvContactLastName] varchar(8) NOT NULL
);

-----------
-- Create table U_EINSGURDEX_drvTbl_EN
-----------

IF OBJECT_ID('U_EINSGURDEX_drvTbl_EN') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_drvTbl_EN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] char(9) NULL,
    [drvUniqueID] char(9) NULL,
    [drvhireDate] varchar(30) NULL,
    [drvTermDate] varchar(30) NULL
);

-----------
-- Create table U_EINSGURDEX_drvTbl_ES
-----------

IF OBJECT_ID('U_EINSGURDEX_drvTbl_ES') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_drvTbl_ES] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] char(9) NULL,
    [drvUniqueID] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvEmploymentStatus] char(1) NULL,
    [drvEmploymentStatusDate] varchar(30) NULL,
    [drvHireDate] varchar(30) NULL,
    [drvRehireDate] varchar(30) NULL,
    [drvServiceDate] varchar(1) NOT NULL,
    [drvTerminationDate] varchar(30) NULL,
    [drvBirthDate] varchar(30) NULL,
    [drvDeceasedDate] varchar(30) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvIsFullTime] varchar(1) NOT NULL,
    [drvIsHourly] varchar(1) NOT NULL,
    [drvJobTitle] varchar(150) NULL,
    [drvWorkStateCode] varchar(255) NULL,
    [drvWorkLocation] char(6) NULL,
    [drvEmployeeEmail] varchar(50) NULL,
    [drvOrgCode] varchar(10) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddresscity] varchar(255) NULL,
    [drvAddressstate] varchar(255) NULL,
    [drvAddresszipcode] varchar(50) NULL,
    [drvAddresscountry] char(3) NULL,
    [drvHomePhone] varchar(50) NULL
);

-----------
-- Create table U_EINSGURDEX_drvTbl_HW
-----------

IF OBJECT_ID('U_EINSGURDEX_drvTbl_HW') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_drvTbl_HW] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvUniqueID] char(11) NULL,
    [drvHours] nvarchar(4000) NULL
);

-----------
-- Create table U_EINSGURDEX_drvTbl_OS
-----------

IF OBJECT_ID('U_EINSGURDEX_drvTbl_OS') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_drvTbl_OS] (
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(10) NULL,
    [drvOrgCode] varchar(10) NULL,
    [drvOrgDesc] varchar(25) NULL
);

-----------
-- Create table U_EINSGURDEX_drvTbl_SS
-----------

IF OBJECT_ID('U_EINSGURDEX_drvTbl_SS') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_drvTbl_SS] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] char(9) NULL,
    [drvUniqueID] char(9) NULL,
    [drvSchedFromDate] varchar(18) NOT NULL
);

-----------
-- Create table U_EINSGURDEX_EEList
-----------

IF OBJECT_ID('U_EINSGURDEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EINSGURDEX_File
-----------

IF OBJECT_ID('U_EINSGURDEX_File') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);

-----------
-- Create table U_EINSGURDEX_Header
-----------

IF OBJECT_ID('U_EINSGURDEX_Header') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Header] (
    [drvSectionName] varchar(11) NOT NULL,
    [drvSectionIdentifier] varchar(2) NOT NULL,
    [drvRecordCount] varchar(1) NOT NULL,
    [drvFeedDate] datetime NOT NULL
);

-----------
-- Create table U_EINSGURDEX_Header_CO
-----------

IF OBJECT_ID('U_EINSGURDEX_Header_CO') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Header_CO] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Header_CS
-----------

IF OBJECT_ID('U_EINSGURDEX_Header_CS') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Header_CS] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Header_DC
-----------

IF OBJECT_ID('U_EINSGURDEX_Header_DC') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Header_DC] (
    [drvRecordCount] varchar(1) NOT NULL
);

-----------
-- Create table U_EINSGURDEX_Header_EN
-----------

IF OBJECT_ID('U_EINSGURDEX_Header_EN') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Header_EN] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Header_ES
-----------

IF OBJECT_ID('U_EINSGURDEX_Header_ES') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Header_ES] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Header_HW
-----------

IF OBJECT_ID('U_EINSGURDEX_Header_HW') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Header_HW] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Header_OS
-----------

IF OBJECT_ID('U_EINSGURDEX_Header_OS') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Header_OS] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Header_RF
-----------

IF OBJECT_ID('U_EINSGURDEX_Header_RF') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Header_RF] (
    [drvRecordCount] int NULL,
    [drvFeedDate] datetime NOT NULL
);

-----------
-- Create table U_EINSGURDEX_Header_SS
-----------

IF OBJECT_ID('U_EINSGURDEX_Header_SS') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Header_SS] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_PEarHist
-----------

IF OBJECT_ID('U_EINSGURDEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt12Mos] money NULL,
    [PehCurHrs12Mos] decimal NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer] (
    [drvSectionName] varchar(1) NOT NULL,
    [drvSectionIdentifier] varchar(1) NOT NULL,
    [drvRecordCount] varchar(1) NOT NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer_CO
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer_CO') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer_CO] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer_CS
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer_CS') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer_CS] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer_DC
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer_DC') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer_DC] (
    [drvRecordCount] varchar(1) NOT NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer_EN
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer_EN') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer_EN] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer_ES
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer_ES') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer_ES] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer_HW
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer_HW') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer_HW] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer_OS
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer_OS') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer_OS] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer_rCS
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer_rCS') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer_rCS] (
    [drvRecordCount] varchar(1) NOT NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer_RF
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer_RF') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer_RF] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_Trailer_SS
-----------

IF OBJECT_ID('U_EINSGURDEX_Trailer_SS') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_Trailer_SS] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EINSGURDEX_TrailerDC
-----------

IF OBJECT_ID('U_EINSGURDEX_TrailerDC') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_TrailerDC] (
    [drvRecordCount] varchar(1) NOT NULL
);

-----------
-- Create table U_EINSGURDEX_TrailerES
-----------

IF OBJECT_ID('U_EINSGURDEX_TrailerES') IS NULL
CREATE TABLE [dbo].[U_EINSGURDEX_TrailerES] (
    [drvRecordCount] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINSGURDEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Institute Of Nuclear Power Operations (INPO)

Created By: Marie Waters
Business Analyst: Lea King
Create Date: 04/07/2023
Service Request Number: TekP-2023-02-15-01

Purpose: Guardian FMLA and STD Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EINSGURDEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EINSGURDEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EINSGURDEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EINSGURDEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EINSGURDEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINSGURDEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINSGURDEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINSGURDEX', 'SCH_EINSGU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EINSGURDEX';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EINSGURDEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EINSGURDEX';

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
    DELETE FROM dbo.U_EINSGURDEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EINSGURDEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EINSGURDEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_AuditFields;
    CREATE TABLE dbo.U_EINSGURDEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EINSGURDEX_AuditFields VALUES ('EmpComp','EecEmplStatus');    
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EINSGURDEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Audit;
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
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EINSGURDEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EINSGURDEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN Dateadd(d, -30, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EINSGURDEX_Audit ON dbo.U_EINSGURDEX_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EINSGURDEX_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EINSGURDEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    ----==========================================
    ---- Create Deduction List
    ----==========================================
    --DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'DED1,DED2';

    --IF OBJECT_ID('U_EINSGURDEX_DedList','U') IS NOT NULL
    --    DROP TABLE dbo.U_EINSGURDEX_DedList;
    --SELECT DISTINCT
    --     DedCode = DedDedCode
    --    ,DedType = DedDedType
    --INTO dbo.U_EINSGURDEX_DedList
    --FROM dbo.fn_ListToTable(@DedList)
    --JOIN dbo.DedCode WITH (NOLOCK)
    --    ON DedDedCode = Item;


    ----==========================================
    ---- BDM Section
    ----==========================================
    --DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    ---- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    ---- Non-Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    ---- Run BDM Module
    --EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

   -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EINSGURDEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
       -- ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
       -- ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        
        -- YTD Payroll Amount/Hours
        ,PehCurAmt12Mos           = SUM(PehCurAmt)
        ,PehCurHrs12Mos           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        --,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
      --  ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
       -- ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
       -- ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EINSGURDEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4) AND
    convert(varchar,PehPerControl, 112)  > = Convert(varchar ,dateadd(month,datediff(month,0,Left(getdate(), 8))-12,0), 112)
    and pehearncode in ('BEREV', 'FMILL', 'HOL', 'JURY', 'OPHOL', 'PAR', 'PFML', 'REG', 'RETRO', 'SABB', 'SICK', 'VAC')
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EINSGURDEX_drvTbl_CS
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_drvTbl_CS','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_drvTbl_CS;
    SELECT DISTINCT
       --  drvEEID = xEEID
        --,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
         drvInitialSort = '3'
        ,drvSubSort = ''
        ,drvTPADomain = CASE WHEN @ExportCode = 'TEST_XOE' then  'Guardian-Stage' else 'Guardian' END
    INTO dbo.U_EINSGURDEX_drvTbl_CS
   
     ;

   ---------------------------------
    -- DETAIL RECORD - U_EINSGURDEX_drvTbl_DC
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_drvTbl_DC','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_drvTbl_DC;
        SELECT DISTINCT
       --  drvEEID = xEEID
        --,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
         drvInitialSort = '1'
        ,drvSubSort = ''
        ,drvContactEmail = 'benefits@inpo.org'
        ,drvContactFirstName  = 'Benefits'
        ,drvContactLastName  = 'Benefits'
    INTO dbo.U_EINSGURDEX_drvTbl_DC
   ;
    ---------------------------------
    -- DETAIL RECORD - U_EINSGURDEX_drvTbl_ES
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_drvTbl_ES','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_drvTbl_ES;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = eecempno
        -- standard fields above and additional driver fields below
        ,drvUniqueID = eecempno
        ,drvSSN = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvEmploymentStatus = EecEmplstatus
        ,drvEmploymentStatusDate = Convert(varchar,EecEmplStatusStartDate,101)
        ,drvHireDate = Convert(varchar,EecDateOfOriginalHire,101)
        ,drvRehireDate = Convert(varchar,EecDateOfLastHire,101)
        ,drvServiceDate = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN Convert(varchar,EecDateOfTermination, 101) END
        ,drvBirthDate = Convert(varchar,EepDateOfBirth, 101)
        ,drvDeceasedDate = CASE WHEN  eecemplstatus = 'T' and eectermreason = '203' then Convert(varchar, eecdateoftermination, 101)  END
        ,drvGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvIsFullTime = CASE WHEN EecFullTimeOrPartTime = 'F' THEN '1' else  '0' END
        ,drvIsHourly = ''
        ,drvJobTitle = EecJobtitle
        ,drvWorkStateCode = LocAddressState
        ,drvWorkLocation = EecLocation
        ,drvEmployeeEmail = EepAddressEMail
        ,drvOrgCode = Eecorglvl2
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddresscity = EepAddressCity
        ,drvAddressstate = EepAddressState
        ,drvAddresszipcode = EepAddressZipCode
        ,drvAddresscountry = EepAddressCountry
        ,drvHomePhone = CASE WHEN ISNULL(eepphonehomenumber, '') <> '' THEN  eepphonehomenumber 
                             WHEN ISNULL(eepphonehomenumber, '') = '' and ISNULL(dbo.dsi_fnlib_GetPhoneNumber(EecEEID,'CEL'),'') <> '' then dbo.dsi_fnlib_GetPhoneNumber(EecEEID,'CEL') END
    INTO dbo.U_EINSGURDEX_drvTbl_ES
    FROM dbo.U_EINSGURDEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    --LEFT JOIN dbo.U_dsi_BDM_EINSGURDEX WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    LEFT JOIN dbo.LOCATION WITH (NOLOCK) 
        ON LocCode = EecLocation
     WHERE EecEEtype = 'REG'
      and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EINSGURDEX_Audit where  audEEID = xEEID AND audCOID = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EINSGURDEX_drvTbl_OS
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_drvTbl_OS','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_drvTbl_OS;
    SELECT DISTINCT
        -- drvEEID = xEEID
        --,drvCoID = xCoID
      --  ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
         drvInitialSort = ''
        ,drvSubSort = Eecorglvl2
        -- standard fields above and additional driver fields below
        ,drvOrgCode = Eecorglvl2
        ,drvOrgDesc = OrgDesc--Eecorglvl2 desc
    INTO dbo.U_EINSGURDEX_drvTbl_OS
    FROM dbo.U_EINSGURDEX_EEList WITH (NOLOCK)
     JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    --LEFT JOIN dbo.U_dsi_BDM_EINSGURDEX WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
      join vw_int_OrgLevel o2 with (nolock) on eecorglvl2 = o2.orgcode and o2.orglvl = '2'
     WHERE EecEEtype = 'REG'
      and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EINSGURDEX_Audit where  audEEID = xEEID AND audCOID = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EINSGURDEX_drvTbl_CO
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_drvTbl_CO','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_drvTbl_CO;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
    --    ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = eecempno
        -- standard fields above and additional driver fields below
        ,drvUniqueID = eecempno
        ,drvContactUniqueID = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'eecempno')
        ,drvContactEmail = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail')
    INTO dbo.U_EINSGURDEX_drvTbl_CO
    FROM dbo.U_EINSGURDEX_EEList WITH (NOLOCK)
      JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    --LEFT JOIN dbo.U_dsi_BDM_EINSGURDEX WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
     WHERE EecEEtype = 'REG'
      and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EINSGURDEX_Audit where  audEEID = xEEID AND audCOID = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EINSGURDEX_drvTbl_EN
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = eecempno
        -- standard fields above and additional driver fields below
        ,drvUniqueID = eecempno
        ,drvhireDate = convert(varchar, Dateadd(Year,+1, EecDateOfLastHire) , 101)
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN Convert(varchar,EecDateOfTermination, 101) END
    INTO dbo.U_EINSGURDEX_drvTbl_EN
    FROM dbo.U_EINSGURDEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    --LEFT JOIN dbo.U_dsi_BDM_EINSGURDEX WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
     WHERE EecEEtype = 'REG'
      and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EINSGURDEX_Audit where  audEEID = xEEID AND audCOID = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EINSGURDEX_drvTbl_SS
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_drvTbl_SS','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_drvTbl_SS;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = eecempno
        -- standard fields above and additional driver fields below
        ,drvUniqueID = eecempno
        ,drvSchedFromDate = 'Saturday to Friday'
    INTO dbo.U_EINSGURDEX_drvTbl_SS
    FROM dbo.U_EINSGURDEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    --LEFT JOIN dbo.U_dsi_BDM_EINSGURDEX WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
     WHERE EecEEtype = 'REG'
      and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EINSGURDEX_Audit where  audEEID = xEEID AND audCOID = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EINSGURDEX_drvTbl_HW
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_drvTbl_HW','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_drvTbl_HW;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
      --  ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = eepssn
        -- standard fields above and additional driver fields below
        ,drvUniqueID = eepssn
        ,drvHours = FORMAT(PehCurHrs12Mos,'0.00')
    INTO dbo.U_EINSGURDEX_drvTbl_HW
    FROM dbo.U_EINSGURDEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --LEFT JOIN dbo.U_dsi_BDM_EINSGURDEX WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    JOIN dbo.U_EINSGURDEX_PEarHist WITH (NOLOCK)
        ON peheeid = XEEID
     WHERE EecEEtype = 'REG'
      and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EINSGURDEX_Audit where  audEEID = xEEID AND audCOID = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Header_RF','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Header_RF;
    SELECT DISTINCT
         drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_CS)+ 1 + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_ES)
                                                    + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_OS) + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_CO)
                                                    + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_EN) +(Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_SS)
                                                    + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_HW) + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_CS) + 1
        ,drvFeedDate = GetDate()
    INTO dbo.U_EINSGURDEX_Header_RF
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Header_CS','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Header_CS;
    SELECT DISTINCT
         drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_CS)
    INTO dbo.U_EINSGURDEX_Header_CS
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Header_DC','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Header_DC;
    SELECT DISTINCT
         drvRecordCount = '1'
    INTO dbo.U_EINSGURDEX_Header_DC
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Header_ES','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Header_ES;
    SELECT DISTINCT
         drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_ES)
    INTO dbo.U_EINSGURDEX_Header_ES
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Header_OS','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Header_OS;
    SELECT DISTINCT
         drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_OS)
    INTO dbo.U_EINSGURDEX_Header_OS
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Header_CO','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Header_CO;
    SELECT DISTINCT
          drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_CO)
    INTO dbo.U_EINSGURDEX_Header_CO
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Header_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Header_EN;
    SELECT DISTINCT
          drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_EN)
    INTO dbo.U_EINSGURDEX_Header_EN
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Header_SS','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Header_SS;
    SELECT DISTINCT
          drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_SS)
    INTO dbo.U_EINSGURDEX_Header_SS
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Header_HW','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Header_HW;
    SELECT DISTINCT
          drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_HW)
    INTO dbo.U_EINSGURDEX_Header_HW
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Trailer_CS','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Trailer_CS;
    SELECT DISTINCT
         drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_CS)
    INTO dbo.U_EINSGURDEX_Trailer_CS
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Trailer_DC','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Trailer_DC;
    SELECT DISTINCT
          drvRecordCount = '1'
    INTO dbo.U_EINSGURDEX_Trailer_DC
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Trailer_ES','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Trailer_ES;
    SELECT DISTINCT
          drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_ES)
    INTO dbo.U_EINSGURDEX_Trailer_ES
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Trailer_OS','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Trailer_OS;
    SELECT DISTINCT
          drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_OS)
    INTO dbo.U_EINSGURDEX_Trailer_OS
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Trailer_CO','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Trailer_CO;
    SELECT DISTINCT
         drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_CO)
    INTO dbo.U_EINSGURDEX_Trailer_CO
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Trailer_SS','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Trailer_SS;
    SELECT DISTINCT
          drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_SS)
    INTO dbo.U_EINSGURDEX_Trailer_SS
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Trailer_HW','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Trailer_HW;
    SELECT DISTINCT
         drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_HW)
    INTO dbo.U_EINSGURDEX_Trailer_HW
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Trailer_EN','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Trailer_EN;
    SELECT DISTINCT
          drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_EN)
    INTO dbo.U_EINSGURDEX_Trailer_EN
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINSGURDEX_Trailer_RF','U') IS NOT NULL
        DROP TABLE dbo.U_EINSGURDEX_Trailer_RF;
    SELECT DISTINCT
        
         drvRecordCount = (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_CS)+ 1 + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_ES)
                                                    + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_OS) + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_CO)
                                                    + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_EN) +(Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_SS)
                                                    + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_HW) + (Select distinct Count(*) FROm dbo.U_EINSGURDEX_drvTbl_CS) + 1
      
    INTO dbo.U_EINSGURDEX_Trailer_RF
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
ALTER VIEW dbo.dsi_vwEINSGURDEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EINSGURDEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EINSGURDEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202303311'
       ,expStartPerControl     = '202303311'
       ,expLastEndPerControl   = '202304079'
       ,expEndPerControl       = '202304079'
WHERE expFormatCode = 'EINSGURDEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEINSGURDEX_Export AS
 SELECT TOP 20000000 Data FROM ( SELECT RecordSet, InitialSort = CASE Left(Ltrim(RTrim(RecordSet)), 3)  
    WHEN  'H01' THEN 1
    WHEN 'H02' THEN 2
    WHEN 'D10' THEN 3
    WHEN 'T90' THEN 4
    WHEN 'H03' THEN 5
    WHEN 'D20' THEN 6
    WHEN 'T91' THEN 7
    WHEN 'H04' THEN 8
    WHEN 'D30' THEN 9
    WHEN 'T92' THEN 10
    WHEN 'H05' THEN 11
    WHEN 'D40' THEN 12
    WHEN 'T93' THEN 13
    WHEN 'H06' THEN 14
    WHEN 'D50' THEN 15
    WHEN 'T94' THEN 16
    WHEN 'H08' THEN 17
    WHEN 'D70' THEN 18
    WHEN 'T95' THEN 19
    WHEN 'H09' THEN 20
    WHEN 'D80' THEN 21
    WHEN 'T96' THEN 22
    WHEN 'H07' THEN 23
    WHEN 'D60' THEn 24
    WHEN 'T97' THEN 25
    WHEN 'T98' THEn 26
    END, SubSort, Subsort2, Subsort3, Data
    FROM dbo.U_EINSGURDEX_File (NOLOCK)
     )d
     ORDER BY  InitialSort,  Subsort, RIGHT(RecordSet,2)

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EINSGURDEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EINSGURDEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EINSGURDEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EINSGURDEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EINSGURDEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EINSGURDEX', 'UseFileName', 'V', 'Y'


-- End ripout