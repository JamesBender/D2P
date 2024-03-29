/**********************************************************************************

EPRUDTTT: Prudential 401K Export with CSV

FormatCode:     EPRUDTTT
Project:        Prudential 401K Export with CSV
Client ID:      ROL1002
Date/time:      2022-01-06 21:08:35.960
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    E42
Server:         E4SUP2DB07
Database:       ULTIPRO_ROLIN
ExportPath:    \\us.saas\E4\Public\ROL1002\Exports\Prudential_401K_Export\
TestPath:      \\us.saas\E4\Public\ROL1002\Exports\Prudential_401K_Export\

NOTE:          MultFile is set to Y, meaning Switchbox doesn't directly write the file.
               The file(s) are probably created by an AfterCollect.


**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPRUDTTT_SavePath') IS NOT NULL DROP TABLE dbo.U_EPRUDTTT_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPRUDTTT'


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
WHERE FormatCode = 'EPRUDTTT'
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
WHERE ExpFormatCode = 'EPRUDTTT'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPRUDTTT')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPRUDTTT'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPRUDTTT'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPRUDTTT'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPRUDTTT'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPRUDTTT'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPRUDTTT'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPRUDTTT'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPRUDTTT'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPRUDTTT'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEPRUDTTT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRUDTTT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRUDTTT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDTTT];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_EPRUDTTT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_EPRUDTTT];
GO
IF OBJECT_ID('U_EPRUDTTT_Trailer_T92') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_Trailer_T92];
GO
IF OBJECT_ID('U_EPRUDTTT_Trailer_T91') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_Trailer_T91];
GO
IF OBJECT_ID('U_EPRUDTTT_Trailer_T90') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_Trailer_T90];
GO
IF OBJECT_ID('U_EPRUDTTT_TaxWages') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_TaxWages];
GO
IF OBJECT_ID('U_EPRUDTTT_SubStatus') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_SubStatus];
GO
IF OBJECT_ID('U_EPRUDTTT_Sign') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_Sign];
GO
IF OBJECT_ID('U_EPRUDTTT_RLSubStatus') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_RLSubStatus];
GO
IF OBJECT_ID('U_EPRUDTTT_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_PEarHist];
GO
IF OBJECT_ID('U_EPRUDTTT_PDedHist_YTD') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_PDedHist_YTD];
GO
IF OBJECT_ID('U_EPRUDTTT_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_PDedHist];
GO
IF OBJECT_ID('U_EPRUDTTT_LOASubStatus') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_LOASubStatus];
GO
IF OBJECT_ID('U_EPRUDTTT_Header_H03') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_Header_H03];
GO
IF OBJECT_ID('U_EPRUDTTT_Header_H02') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_Header_H02];
GO
IF OBJECT_ID('U_EPRUDTTT_Header_H01') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_Header_H01];
GO
IF OBJECT_ID('U_EPRUDTTT_File') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_File];
GO
IF OBJECT_ID('U_EPRUDTTT_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_EEList];
GO
IF OBJECT_ID('U_EPRUDTTT_drvTbl_D60') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_drvTbl_D60];
GO
IF OBJECT_ID('U_EPRUDTTT_drvTbl_D50') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_drvTbl_D50];
GO
IF OBJECT_ID('U_EPRUDTTT_drvTbl_D40') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_drvTbl_D40];
GO
IF OBJECT_ID('U_EPRUDTTT_drvTbl_D30') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_drvTbl_D30];
GO
IF OBJECT_ID('U_EPRUDTTT_drvTbl_D20') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_drvTbl_D20];
GO
IF OBJECT_ID('U_EPRUDTTT_drvTbl_D10') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_drvTbl_D10];
GO
IF OBJECT_ID('U_EPRUDTTT_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_DedList];
GO
IF OBJECT_ID('U_EPRUDTTT_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_AuditFields];
GO
IF OBJECT_ID('U_EPRUDTTT_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTT_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EPRUDTTT','Prudential 401K Export with CSV','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EPRUDTTT00Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','H','01','1',NULL,'Record Type',NULL,NULL,'"001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','10','H','01','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','10','H','01','14',NULL,'Client Identifier',NULL,NULL,'"drvClientID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','8','H','01','24',NULL,'File Create Date',NULL,NULL,'"drvCreateDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','6','H','01','32',NULL,'File Creation Time',NULL,NULL,'"drvCreateTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','1','H','01','38',NULL,'Sender',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','633','H','01','39',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','H','02','1',NULL,'Record Type',NULL,NULL,'"001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','10','H','02','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','10','H','02','14',NULL,'Client Identifier',NULL,NULL,'"drvClientID2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','8','H','02','24',NULL,'File Create Date',NULL,NULL,'"drvCreateDate2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','6','H','02','32',NULL,'File Creation Time',NULL,NULL,'"drvCreateTime2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','1','H','02','38',NULL,'Sender',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','633','H','02','39',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','H','03','1',NULL,'Record Type',NULL,NULL,'"001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','10','H','03','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','10','H','03','14',NULL,'Client Identifier',NULL,NULL,'"drvClientID3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','8','H','03','24',NULL,'File Create Date',NULL,NULL,'"drvCreateDate3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','6','H','03','32',NULL,'File Creation Time',NULL,NULL,'"drvCreateTime3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','1','H','03','38',NULL,'Sender',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','633','H','03','39',NULL,'Filler',NULL,NULL,'"Filler"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','16','H','04','1',NULL,'Transaction Code',NULL,NULL,'"Trans Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','15','H','04','2',NULL,'Sequence Code',NULL,NULL,'"Seq Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','11','H','04','3',NULL,'Plan Number',NULL,NULL,'"Plan #"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','1','H','04','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','11','H','04','5',NULL,'Participant ID',NULL,NULL,'"Partipnt ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','1','H','04','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','10','H','04','7',NULL,'Investment',NULL,NULL,'"Investment"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','5','H','04','8',NULL,'Source 1',NULL,NULL,'"Src 1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','11','H','04','9',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','10','H','04','10',NULL,'Investment',NULL,NULL,'"Investment"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','4','H','04','11',NULL,'Source 2',NULL,NULL,'"Src 2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','12','H','04','12',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','11','H','04','13',NULL,'Investment',NULL,NULL,'"Investment2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','4','H','04','14',NULL,'Source 3',NULL,NULL,'"Src3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','12','H','04','15',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','11','H','04','12',NULL,'Investment',NULL,NULL,'"Investment3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','4','H','04','17',NULL,'Source 4',NULL,NULL,'"Src4"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRUDTTT00Z0','12','H','04','18',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt4"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRUDTTT00Z0','11','H','04','19',NULL,'Investment',NULL,NULL,'"Investment4"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRUDTTT00Z0','4','H','04','20',NULL,'Source 5',NULL,NULL,'"Src5"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRUDTTT00Z0','12','H','04','21',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt5"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRUDTTT00Z0','11','H','04','22',NULL,'Investment',NULL,NULL,'"Investment5"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRUDTTT00Z0','4','H','04','23',NULL,'Source 6',NULL,NULL,'"Src6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRUDTTT00Z0','12','H','04','24',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRUDTTT00Z0','12','H','04','25',NULL,'Pay Period End Date',NULL,NULL,'"Per End Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRUDTTT00Z0','13','H','04','26',NULL,'Insider Trader',NULL,NULL,'"Inside Trader"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRUDTTT00Z0','10','H','04','27',NULL,'Sub Plan Number',NULL,NULL,'"Sub Plan #"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRUDTTT00Z0','5','H','04','28',NULL,'Name',NULL,NULL,'"Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRUDTTT00Z0','6','H','04','29',NULL,'Address 1',NULL,NULL,'"Addr1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRUDTTT00Z0','6','H','04','30',NULL,'Address 2',NULL,NULL,'"Addr2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRUDTTT00Z0','4','H','04','31',NULL,'City',NULL,NULL,'"City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRUDTTT00Z0','5','H','04','32',NULL,'State',NULL,NULL,'"State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRUDTTT00Z0','3','H','04','33',NULL,'ZipCode',NULL,NULL,'"Zip"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRUDTTT00Z0','10','H','04','34',NULL,'Date of Birth',NULL,NULL,'"Birth Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRUDTTT00Z0','14','H','04','35',NULL,'Original Date of Hire',NULL,NULL,'"Orig Hire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRUDTTT00Z0','14','H','04','36',NULL,'Adj. Date of Hire',NULL,NULL,'"Adj. Hire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRUDTTT00Z0','12','H','04','37',NULL,'Marital Status',NULL,NULL,'"Marital Stat"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRUDTTT00Z0','6','H','04','38',NULL,'Gender Code',NULL,NULL,'"Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRUDTTT00Z0','9','H','04','39',NULL,'EE Status',NULL,NULL,'"EE Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRUDTTT00Z0','14','H','04','40',NULL,'Employee Status Date',NULL,NULL,'"EE Status Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRUDTTT00Z0','8','H','04','41',NULL,'Payroll Frequency',NULL,NULL,'"Pay Freq"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRUDTTT00Z0','8','H','04','42',NULL,'Years of Service',NULL,NULL,'"Yrs Serv"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRUDTTT00Z0','12','H','04','43',NULL,'YTD Hours of Service',NULL,NULL,'"YTD Hrs Serv"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRUDTTT00Z0','7','H','04','44',NULL,'Current Pay Period Hours Worked',NULL,NULL,'"Cur Hrs"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRUDTTT00Z0','9','H','04','45',NULL,'Current Pay Period Gross Pay',NULL,NULL,'"Cur Gross"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRUDTTT00Z0','14','H','04','46',NULL,'Current Eligible Gross Pay ''Source 1''',NULL,NULL,'"Cur Elig Gross"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPRUDTTT00Z0','10','H','04','47',NULL,'Current Pay Period W-2 Pay',NULL,NULL,'"Cur Per W2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPRUDTTT00Z0','12','H','04','48',NULL,'Anniversary Date',NULL,NULL,'"Annvsry Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPRUDTTT00Z0','12','H','04','49',NULL,'Anniversary Hours',NULL,NULL,'"Annvsry  Hrs"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPRUDTTT00Z0','8','H','04','50',NULL,'Check Date',NULL,NULL,'"Pay Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPRUDTTT00Z0','10','H','04','51',NULL,'Employee ID/Code',NULL,NULL,'"EE ID-Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPRUDTTT00Z0','7','H','04','52',NULL,'Div/Sub',NULL,NULL,'"Div-Sub"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPRUDTTT00Z0','11','H','04','53',NULL,'Employer Location Code',NULL,NULL,'"ER Loc Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPRUDTTT00Z0','12','H','04','54',NULL,'Location Effective Date',NULL,NULL,'"Loc Eff Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPRUDTTT00Z0','7','H','04','55',NULL,'Group Indicator',NULL,NULL,'"Grp Ind"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EPRUDTTT00Z0','10','H','04','56',NULL,'Never Eligible',NULL,NULL,'"Never Elig"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EPRUDTTT00Z0','12','H','04','57',NULL,'Eligible to Participate in EE Sources',NULL,NULL,'"Elig Part EE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EPRUDTTT00Z0','12','H','04','58',NULL,'Eligible to Participate in ER Sources',NULL,NULL,'"Elig Part ER"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EPRUDTTT00Z0','9','H','04','59',NULL,'Eligibility Date',NULL,NULL,'"Elig Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EPRUDTTT00Z0','11','H','04','60',NULL,'Auto Enrollment Decline Indicator',NULL,NULL,'"Auto Enroll"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EPRUDTTT00Z0','8','H','04','61',NULL,'Deferral Rate for Source 1',NULL,NULL,'"Def Rate"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EPRUDTTT00Z0','1','H','04','62',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EPRUDTTT00Z0','10','H','04','63',NULL,'Cash Bonus',NULL,NULL,'"Cash Bonus"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EPRUDTTT00Z0','7','H','04','64',NULL,'HCE Indicator',NULL,NULL,'"HCE Ind"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EPRUDTTT00Z0','8','H','04','65',NULL,'Union Employee',NULL,NULL,'"Union EE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EPRUDTTT00Z0','13','H','04','66',NULL,'Market Salary',NULL,NULL,'"Market Salary"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EPRUDTTT00Z0','11','H','04','67',NULL,'Rehire Date',NULL,NULL,'"Rehire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EPRUDTTT00Z0','9','H','04','68',NULL,'YTD Gross Pay/415/HCE/414 Compensation',NULL,NULL,'"YTD Gross"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EPRUDTTT00Z0','1','H','04','69',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EPRUDTTT00Z0','14','H','04','70',NULL,'Deferral & Plan Limit Compensation',NULL,NULL,'"Def Plan Limit"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EPRUDTTT00Z0','1','H','04','71',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EPRUDTTT00Z0','10','H','04','72',NULL,'Current Eligible Gross Pay ''Source 2''',NULL,NULL,'"Cur Gross2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EPRUDTTT00Z0','1','H','04','73',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EPRUDTTT00Z0','8','H','04','74',NULL,'ADP & Plan Compensation',NULL,NULL,'"ADP-Plan"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EPRUDTTT00Z0','1','H','04','75',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EPRUDTTT00Z0','10','H','04','76',NULL,'Current Eligible Gross Pay ''Source 3''',NULL,NULL,'"Cur Gross3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EPRUDTTT00Z0','1','H','04','77',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EPRUDTTT00Z0','13','H','04','78',NULL,'ER Match Compensation',NULL,NULL,'"ER Match Comp"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EPRUDTTT00Z0','1','H','04','79',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EPRUDTTT00Z0','7','H','04','80',NULL,'ACP Compensation',NULL,NULL,'"ACP Comp"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EPRUDTTT00Z0','1','H','04','81',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EPRUDTTT00Z0','9','H','04','82',NULL,'Excluded Compensation',NULL,NULL,'"Excl Comp"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EPRUDTTT00Z0','1','H','04','83',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EPRUDTTT00Z0','13','H','04','84',NULL,'Top Heavy 401(a) Compensation',NULL,NULL,'"Top 401a Comp"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EPRUDTTT00Z0','1','H','04','85',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EPRUDTTT00Z0','16','H','04','86',NULL,'EE Post Tax Compensation',NULL,NULL,'"EE Post Tax Comp"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EPRUDTTT00Z0','1','H','04','87',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EPRUDTTT00Z0','8','H','04','88',NULL,'Sub Status',NULL,NULL,'"Sub Stat"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EPRUDTTT00Z0','1','H','04','89',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EPRUDTTT00Z0','13','H','04','90',NULL,'Sub Status Date',NULL,NULL,'"Sub Stat Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EPRUDTTT00Z0','5','H','04','91',NULL,'Participant''s Email Address',NULL,NULL,'"Email"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','10','1',NULL,'Transaction Code',NULL,NULL,'"114"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','10','4',NULL,'Sequence Code',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','10','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','10','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','10','15',NULL,'Participant ID',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','12','D','10','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','2','D','10','36',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','1','D','10','38',NULL,'Source 1',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','9','D','10','39',NULL,'Contribution Amount',NULL,NULL,'"drvPretax"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','2','D','10','48',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','1','D','10','50',NULL,'Source 2',NULL,NULL,'"6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','9','D','10','51',NULL,'Contribution Amount',NULL,NULL,'"drvPretaxMatch_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','2','D','10','60',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','1','D','10','62',NULL,'Source 3',NULL,NULL,'"J"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','9','D','10','63',NULL,'Contribution Amount',NULL,NULL,'"drvRoth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','2','D','10','72',NULL,'Investment',NULL,NULL,'"drvInvestment3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','1','D','10','74',NULL,'Source 4',NULL,NULL,'"drvSource4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRUDTTT00Z0','9','D','10','75',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRUDTTT00Z0','2','D','10','84',NULL,'Investment',NULL,NULL,'"drvInvestment4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRUDTTT00Z0','1','D','10','86',NULL,'Source 5',NULL,NULL,'"drvSource5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRUDTTT00Z0','9','D','10','87',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRUDTTT00Z0','2','D','10','96',NULL,'Investment',NULL,NULL,'"drvInvestment5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRUDTTT00Z0','1','D','10','98',NULL,'Source 6',NULL,NULL,'"drvSource6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRUDTTT00Z0','9','D','10','99',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRUDTTT00Z0','8','D','10','108',NULL,'Pay Period End Date',NULL,NULL,'"drvPeriodEnd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRUDTTT00Z0','1','D','10','116',NULL,'Insider Trader',NULL,NULL,'"drvInsiderTrader"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRUDTTT00Z0','4','D','10','117',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRUDTTT00Z0','30','D','10','121',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRUDTTT00Z0','30','D','10','151',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRUDTTT00Z0','30','D','10','181',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRUDTTT00Z0','18','D','10','211',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRUDTTT00Z0','2','D','10','229',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRUDTTT00Z0','9','D','10','231',NULL,'ZipCode',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRUDTTT00Z0','8','D','10','240',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRUDTTT00Z0','8','D','10','248',NULL,'Original Date of Hire',NULL,NULL,'"drvODOH"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRUDTTT00Z0','8','D','10','256',NULL,'Adj. Date of Hire',NULL,NULL,'"drvADOH"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRUDTTT00Z0','1','D','10','264',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRUDTTT00Z0','1','D','10','265',NULL,'Gender Code',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRUDTTT00Z0','2','D','10','266',NULL,'EE Status',NULL,NULL,'"drvEmplStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRUDTTT00Z0','8','D','10','268',NULL,'Employee Status Date',NULL,NULL,'"drvEmplStatusDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRUDTTT00Z0','1','D','10','276',NULL,'Payroll Frequency',NULL,NULL,'"drvFrequency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRUDTTT00Z0','8','D','10','277',NULL,'Years of Service',NULL,NULL,'"00000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRUDTTT00Z0','6','D','10','285',NULL,'YTD Hours of Service',NULL,NULL,'"drvHrsOfService"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRUDTTT00Z0','6','D','10','291',NULL,'Current Pay Period Hours Worked',NULL,NULL,'"drvCurHrs"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRUDTTT00Z0','15','D','10','297',NULL,'Current Pay Period Gross Pay',NULL,NULL,'"drvCurGross"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRUDTTT00Z0','15','D','10','312',NULL,'Current Eligible Gross Pay ''Source 1''',NULL,NULL,'"drvCurEligGross"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPRUDTTT00Z0','11','D','10','327',NULL,'Current Pay Period W-2 Pay',NULL,NULL,'"drvCurW2Taxable"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPRUDTTT00Z0','8','D','10','338',NULL,'Anniversary Date',NULL,NULL,'"drvAnniversary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPRUDTTT00Z0','6','D','10','346',NULL,'Anniversary Hours',NULL,NULL,'"drvAnniversaryHrs"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPRUDTTT00Z0','8','D','10','352',NULL,'Check Date',NULL,NULL,'"drvPayDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPRUDTTT00Z0','13','D','10','360',NULL,'Employee ID/Code',NULL,NULL,'"drvEmpIDCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPRUDTTT00Z0','4','D','10','373',NULL,'Div/Sub',NULL,NULL,'"drvDivSub"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPRUDTTT00Z0','10','D','10','377',NULL,'Employer Location Code',NULL,NULL,'"drvERLocCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPRUDTTT00Z0','8','D','10','387',NULL,'Location Effective Date',NULL,NULL,'"drvLocEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPRUDTTT00Z0','1','D','10','395',NULL,'Group Indicator',NULL,NULL,'"drvGroupInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EPRUDTTT00Z0','10','D','10','396',NULL,'Never Eligible',NULL,NULL,'"drvNeverElig"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EPRUDTTT00Z0','5','D','10','406',NULL,'Eligible to Participate in EE Sources',NULL,NULL,'"drvEligEESources"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EPRUDTTT00Z0','5','D','10','411',NULL,'Eligible to Participate in ER Sources',NULL,NULL,'"drvEligERSources"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EPRUDTTT00Z0','8','D','10','416',NULL,'Eligibility Date',NULL,NULL,'"drvEligDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EPRUDTTT00Z0','1','D','10','424',NULL,'Auto Enrollment Decline Indicator',NULL,NULL,'"drvAutoEnroll"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EPRUDTTT00Z0','5','D','10','425',NULL,'Deferral Rate for Source 1',NULL,NULL,'"drvDefRate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EPRUDTTT00Z0','15','D','10','430',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EPRUDTTT00Z0','11','D','10','445',NULL,'Cash Bonus',NULL,NULL,'"drvCashBonus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EPRUDTTT00Z0','1','D','10','456',NULL,'HCE Indicator',NULL,NULL,'"drvHCEInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EPRUDTTT00Z0','1','D','10','457',NULL,'Union Employee',NULL,NULL,'"drvUnionEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EPRUDTTT00Z0','11','D','10','458',NULL,'Market Salary',NULL,NULL,'"drvMarketSal"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EPRUDTTT00Z0','8','D','10','469',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EPRUDTTT00Z0','15','D','10','477',NULL,'YTD Gross Pay/415/HCE/414 Compensation',NULL,NULL,'"drvYTDGross"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EPRUDTTT00Z0','1','D','10','492',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EPRUDTTT00Z0','15','D','10','493',NULL,'Deferral & Plan Limit Compensation',NULL,NULL,'"drvDefLimitComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EPRUDTTT00Z0','1','D','10','508',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EPRUDTTT00Z0','15','D','10','509',NULL,'Current Eligible Gross Pay ''Source 2''',NULL,NULL,'"drvCurEligGrossSource2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EPRUDTTT00Z0','1','D','10','524',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EPRUDTTT00Z0','15','D','10','525',NULL,'ADP & Plan Compensation',NULL,NULL,'"drvADPPlanComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EPRUDTTT00Z0','1','D','10','540',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EPRUDTTT00Z0','15','D','10','541',NULL,'Current Eligible Gross Pay ''Source 3''',NULL,NULL,'"drvCurEligGrossSource3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EPRUDTTT00Z0','1','D','10','556',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EPRUDTTT00Z0','15','D','10','557',NULL,'ER Match Compensation',NULL,NULL,'"drvERMatchComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EPRUDTTT00Z0','1','D','10','572',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EPRUDTTT00Z0','11','D','10','573',NULL,'ACP Compensation',NULL,NULL,'"drvACPComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EPRUDTTT00Z0','1','D','10','584',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EPRUDTTT00Z0','11','D','10','585',NULL,'Excluded Compensation',NULL,NULL,'"drvExclComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EPRUDTTT00Z0','1','D','10','596',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EPRUDTTT00Z0','11','D','10','597',NULL,'Top Heavy 401(a) Compensation',NULL,NULL,'"drv401A"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EPRUDTTT00Z0','1','D','10','608',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EPRUDTTT00Z0','11','D','10','609',NULL,'EE Post Tax Compensation',NULL,NULL,'"drvEEPostComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EPRUDTTT00Z0','1','D','10','620',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EPRUDTTT00Z0','2','D','10','621',NULL,'Sub Status',NULL,NULL,'"drvSubStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EPRUDTTT00Z0','1','D','10','623',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EPRUDTTT00Z0','8','D','10','624',NULL,'Sub Status Date',NULL,NULL,'"drvSubStatusDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EPRUDTTT00Z0','40','D','10','632',NULL,'Participant''s Email Address',NULL,NULL,'"drvEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','15','1',NULL,'Transaction Code',NULL,NULL,'"114"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','15','4',NULL,'Sequence Code',NULL,NULL,'"01"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','15','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','15','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','15','15',NULL,'Participant ID',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','12','D','15','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','2','D','15','36',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','1','D','15','38',NULL,'Source 1',NULL,NULL,'"A"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','9','D','15','39',NULL,'Contribution Amount',NULL,NULL,'"drvPretaxNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','2','D','15','48',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','1','D','15','50',NULL,'Source 2',NULL,NULL,'"6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','9','D','15','51',NULL,'Contribution Amount',NULL,NULL,'"drvPretaxMatch_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','2','D','15','60',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','1','D','15','62',NULL,'Source 3',NULL,NULL,'"J"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','9','D','15','63',NULL,'Contribution Amount',NULL,NULL,'"drvRothNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','2','D','15','72',NULL,'Investment',NULL,NULL,'"drvInvestment3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','1','D','15','74',NULL,'Source 4',NULL,NULL,'"drvSource4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRUDTTT00Z0','9','D','15','75',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRUDTTT00Z0','2','D','15','84',NULL,'Investment',NULL,NULL,'"drvInvestment4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRUDTTT00Z0','1','D','15','86',NULL,'Source 5',NULL,NULL,'"drvSource5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRUDTTT00Z0','9','D','15','87',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRUDTTT00Z0','2','D','15','96',NULL,'Investment',NULL,NULL,'"drvInvestment5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRUDTTT00Z0','1','D','15','98',NULL,'Source 6',NULL,NULL,'"drvSource6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRUDTTT00Z0','9','D','15','99',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRUDTTT00Z0','8','D','15','108',NULL,'Pay Period End Date',NULL,NULL,'"drvPeriodEnd"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRUDTTT00Z0','1','D','15','116',NULL,'Insider Trader',NULL,NULL,'"drvInsiderTrader"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRUDTTT00Z0','4','D','15','117',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRUDTTT00Z0','30','D','15','121',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRUDTTT00Z0','30','D','15','151',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRUDTTT00Z0','30','D','15','181',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRUDTTT00Z0','18','D','15','211',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRUDTTT00Z0','2','D','15','229',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRUDTTT00Z0','9','D','15','231',NULL,'ZipCode',NULL,NULL,'"drvZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRUDTTT00Z0','8','D','15','240',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRUDTTT00Z0','8','D','15','248',NULL,'Original Date of Hire',NULL,NULL,'"drvODOH"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRUDTTT00Z0','8','D','15','256',NULL,'Adj. Date of Hire',NULL,NULL,'"drvADOH"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRUDTTT00Z0','1','D','15','264',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRUDTTT00Z0','1','D','15','265',NULL,'Gender Code',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRUDTTT00Z0','2','D','15','266',NULL,'EE Status',NULL,NULL,'"drvEmplStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRUDTTT00Z0','8','D','15','268',NULL,'Employee Status Date',NULL,NULL,'"drvEmplStatusDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRUDTTT00Z0','1','D','15','276',NULL,'Payroll Frequency',NULL,NULL,'"drvFrequency"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRUDTTT00Z0','8','D','15','277',NULL,'Years of Service',NULL,NULL,'"00000000"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRUDTTT00Z0','6','D','15','285',NULL,'YTD Hours of Service',NULL,NULL,'"drvHrsOfService"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRUDTTT00Z0','6','D','15','291',NULL,'Current Pay Period Hours Worked',NULL,NULL,'"drvCurHrsNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRUDTTT00Z0','15','D','15','297',NULL,'Current Pay Period Gross Pay',NULL,NULL,'"drvCurGrossNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRUDTTT00Z0','15','D','15','312',NULL,'Current Eligible Gross Pay ''Source 1''',NULL,NULL,'"drvCurEligGrossNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPRUDTTT00Z0','11','D','15','327',NULL,'Current Pay Period W-2 Pay',NULL,NULL,'"drvCurW2TaxableNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPRUDTTT00Z0','8','D','15','338',NULL,'Anniversary Date',NULL,NULL,'"drvAnniversary"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPRUDTTT00Z0','6','D','15','346',NULL,'Anniversary Hours',NULL,NULL,'"drvAnniversaryHrs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPRUDTTT00Z0','8','D','15','352',NULL,'Check Date',NULL,NULL,'"drvPayDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPRUDTTT00Z0','13','D','15','360',NULL,'Employee ID/Code',NULL,NULL,'"drvEmpIDCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPRUDTTT00Z0','4','D','15','373',NULL,'Div/Sub',NULL,NULL,'"drvDivSub"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPRUDTTT00Z0','10','D','15','377',NULL,'Employer Location Code',NULL,NULL,'"drvERLocCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPRUDTTT00Z0','8','D','15','387',NULL,'Location Effective Date',NULL,NULL,'"drvLocEffDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPRUDTTT00Z0','1','D','15','395',NULL,'Group Indicator',NULL,NULL,'"drvGroupInd"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EPRUDTTT00Z0','10','D','15','396',NULL,'Never Eligible',NULL,NULL,'"drvNeverElig"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EPRUDTTT00Z0','5','D','15','406',NULL,'Eligible to Participate in EE Sources',NULL,NULL,'"drvEligEESources"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EPRUDTTT00Z0','5','D','15','411',NULL,'Eligible to Participate in ER Sources',NULL,NULL,'"drvEligERSources"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EPRUDTTT00Z0','8','D','15','416',NULL,'Eligibility Date',NULL,NULL,'"drvEligDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EPRUDTTT00Z0','1','D','15','424',NULL,'Auto Enrollment Decline Indicator',NULL,NULL,'"drvAutoEnroll"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EPRUDTTT00Z0','5','D','15','425',NULL,'Deferral Rate for Source 1',NULL,NULL,'"drvDefRate"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EPRUDTTT00Z0','15','D','15','430',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EPRUDTTT00Z0','11','D','15','445',NULL,'Cash Bonus',NULL,NULL,'"drvCashBonus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EPRUDTTT00Z0','1','D','15','456',NULL,'HCE Indicator',NULL,NULL,'"drvHCEInd"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EPRUDTTT00Z0','1','D','15','457',NULL,'Union Employee',NULL,NULL,'"drvUnionEE"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EPRUDTTT00Z0','11','D','15','458',NULL,'Market Salary',NULL,NULL,'"drvMarketSalNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EPRUDTTT00Z0','8','D','15','469',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EPRUDTTT00Z0','15','D','15','477',NULL,'YTD Gross Pay/415/HCE/414 Compensation',NULL,NULL,'"drvYTDGrossNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EPRUDTTT00Z0','1','D','15','492',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EPRUDTTT00Z0','15','D','15','493',NULL,'Deferral & Plan Limit Compensation',NULL,NULL,'"drvDefLimitCompNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EPRUDTTT00Z0','1','D','15','508',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EPRUDTTT00Z0','15','D','15','509',NULL,'Current Eligible Gross Pay ''Source 2''',NULL,NULL,'"drvCurEligGrossSource2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EPRUDTTT00Z0','1','D','15','524',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EPRUDTTT00Z0','15','D','15','525',NULL,'ADP & Plan Compensation',NULL,NULL,'"drvADPPlanComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EPRUDTTT00Z0','1','D','15','540',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EPRUDTTT00Z0','15','D','15','541',NULL,'Current Eligible Gross Pay ''Source 3''',NULL,NULL,'"drvCurEligGrossSource3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EPRUDTTT00Z0','1','D','15','556',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EPRUDTTT00Z0','15','D','15','557',NULL,'ER Match Compensation',NULL,NULL,'"drvERMatchComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EPRUDTTT00Z0','1','D','15','572',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EPRUDTTT00Z0','11','D','15','573',NULL,'ACP Compensation',NULL,NULL,'"drvACPComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EPRUDTTT00Z0','1','D','15','584',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EPRUDTTT00Z0','11','D','15','585',NULL,'Excluded Compensation',NULL,NULL,'"drvExclComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EPRUDTTT00Z0','1','D','15','596',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EPRUDTTT00Z0','11','D','15','597',NULL,'Top Heavy 401(a) Compensation',NULL,NULL,'"drv401A"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EPRUDTTT00Z0','1','D','15','608',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EPRUDTTT00Z0','11','D','15','609',NULL,'EE Post Tax Compensation',NULL,NULL,'"drvEEPostComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EPRUDTTT00Z0','1','D','15','620',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EPRUDTTT00Z0','2','D','15','621',NULL,'Sub Status',NULL,NULL,'"drvSubStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EPRUDTTT00Z0','1','D','15','623',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EPRUDTTT00Z0','8','D','15','624',NULL,'Sub Status Date',NULL,NULL,'"drvSubStatusDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EPRUDTTT00Z0','40','D','15','632',NULL,'Participant''s Email Address',NULL,NULL,'"drvEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','20','1',NULL,'Transaction Code',NULL,NULL,'"114"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','20','4',NULL,'Sequence Code',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','20','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','20','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','20','15',NULL,'Participant ID',NULL,NULL,'"drvSSN_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','12','D','20','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','2','D','20','36',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','1','D','20','38',NULL,'Source 1',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','9','D','20','39',NULL,'Contribution Amount',NULL,NULL,'"drvPretax_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','2','D','20','48',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','1','D','20','50',NULL,'Source 2',NULL,NULL,'"6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','9','D','20','51',NULL,'Contribution Amount',NULL,NULL,'"drvPretaxMatch_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','2','D','20','60',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','1','D','20','62',NULL,'Source 3',NULL,NULL,'"J"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','9','D','20','63',NULL,'Contribution Amount',NULL,NULL,'"drvRoth_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','2','D','20','72',NULL,'Investment',NULL,NULL,'"drvInvestment3_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','1','D','20','74',NULL,'Source 4',NULL,NULL,'"drvSource4_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRUDTTT00Z0','9','D','20','75',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt4_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRUDTTT00Z0','2','D','20','84',NULL,'Investment',NULL,NULL,'"drvInvestment4_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRUDTTT00Z0','1','D','20','86',NULL,'Source 5',NULL,NULL,'"drvSource5_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRUDTTT00Z0','9','D','20','87',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt5_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRUDTTT00Z0','2','D','20','96',NULL,'Investment',NULL,NULL,'"drvInvestment5_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRUDTTT00Z0','1','D','20','98',NULL,'Source 6',NULL,NULL,'"drvSource6_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRUDTTT00Z0','9','D','20','99',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt6_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRUDTTT00Z0','8','D','20','108',NULL,'Pay Period End Date',NULL,NULL,'"drvPeriodEnd_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRUDTTT00Z0','1','D','20','116',NULL,'Insider Trader',NULL,NULL,'"drvInsiderTrader_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRUDTTT00Z0','4','D','20','117',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanNumber_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRUDTTT00Z0','30','D','20','121',NULL,'Name',NULL,NULL,'"drvName_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRUDTTT00Z0','30','D','20','151',NULL,'Address 1',NULL,NULL,'"drvAddress1_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRUDTTT00Z0','30','D','20','181',NULL,'Address 2',NULL,NULL,'"drvAddress2_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRUDTTT00Z0','18','D','20','211',NULL,'City',NULL,NULL,'"drvCity_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRUDTTT00Z0','2','D','20','229',NULL,'State',NULL,NULL,'"drvState_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRUDTTT00Z0','9','D','20','231',NULL,'ZipCode',NULL,NULL,'"drvZipCode_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRUDTTT00Z0','8','D','20','240',NULL,'Date of Birth',NULL,NULL,'"drvDOB_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRUDTTT00Z0','8','D','20','248',NULL,'Original Date of Hire',NULL,NULL,'"drvODOH_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRUDTTT00Z0','8','D','20','256',NULL,'Adj. Date of Hire',NULL,NULL,'"drvADOH_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRUDTTT00Z0','1','D','20','264',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRUDTTT00Z0','1','D','20','265',NULL,'Gender Code',NULL,NULL,'"drvGender_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRUDTTT00Z0','2','D','20','266',NULL,'EE Status',NULL,NULL,'"drvEmplStatus_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRUDTTT00Z0','8','D','20','268',NULL,'Employee Status Date',NULL,NULL,'"drvEmplStatusDate_2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRUDTTT00Z0','1','D','20','276',NULL,'Payroll Frequency',NULL,NULL,'"drvFrequency_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRUDTTT00Z0','8','D','20','277',NULL,'Years of Service',NULL,NULL,'"00000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRUDTTT00Z0','6','D','20','285',NULL,'YTD Hours of Service',NULL,NULL,'"drvHrsOfService_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRUDTTT00Z0','6','D','20','291',NULL,'Current Pay Period Hours Worked',NULL,NULL,'"drvCurHrs_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRUDTTT00Z0','15','D','20','297',NULL,'Current Pay Period Gross Pay',NULL,NULL,'"drvCurGross_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRUDTTT00Z0','15','D','20','312',NULL,'Current Eligible Gross Pay ''Source 1''',NULL,NULL,'"drvCurEligGross_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPRUDTTT00Z0','11','D','20','327',NULL,'Current Pay Period W-2 Pay',NULL,NULL,'"drvCurW2Taxable_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPRUDTTT00Z0','8','D','20','338',NULL,'Anniversary Date',NULL,NULL,'"drvAnniversary_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPRUDTTT00Z0','6','D','20','346',NULL,'Anniversary Hours',NULL,NULL,'"drvAnniversaryHrs_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPRUDTTT00Z0','8','D','20','352',NULL,'Check Date',NULL,NULL,'"drvPayDate_2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPRUDTTT00Z0','13','D','20','360',NULL,'Employee ID/Code',NULL,NULL,'"drvEmpIDCode_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPRUDTTT00Z0','4','D','20','373',NULL,'Div/Sub',NULL,NULL,'"drvDivSub_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPRUDTTT00Z0','10','D','20','377',NULL,'Employer Location Code',NULL,NULL,'"drvERLocCode_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPRUDTTT00Z0','8','D','20','387',NULL,'Location Effective Date',NULL,NULL,'"drvLocEffDate_2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPRUDTTT00Z0','1','D','20','395',NULL,'Group Indicator',NULL,NULL,'"drvGroupInd_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EPRUDTTT00Z0','10','D','20','396',NULL,'Never Eligible',NULL,NULL,'"drvNeverElig_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EPRUDTTT00Z0','5','D','20','406',NULL,'Eligible to Participate in EE Sources',NULL,NULL,'"drvEligEESources_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EPRUDTTT00Z0','5','D','20','411',NULL,'Eligible to Participate in ER Sources',NULL,NULL,'"drvEligERSources_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EPRUDTTT00Z0','8','D','20','416',NULL,'Eligibility Date',NULL,NULL,'"drvEligDate_2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EPRUDTTT00Z0','1','D','20','424',NULL,'Auto Enrollment Decline Indicator',NULL,NULL,'"drvAutoEnroll_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EPRUDTTT00Z0','5','D','20','425',NULL,'Deferral Rate for Source 1',NULL,NULL,'"drvDefRate_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EPRUDTTT00Z0','15','D','20','430',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EPRUDTTT00Z0','11','D','20','445',NULL,'Cash Bonus',NULL,NULL,'"drvCashBonus_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EPRUDTTT00Z0','1','D','20','456',NULL,'HCE Indicator',NULL,NULL,'"drvHCEInd_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EPRUDTTT00Z0','1','D','20','457',NULL,'Union Employee',NULL,NULL,'"drvUnionEE_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EPRUDTTT00Z0','11','D','20','458',NULL,'Market Salary',NULL,NULL,'"drvMarketSal_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EPRUDTTT00Z0','8','D','20','469',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate_2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EPRUDTTT00Z0','15','D','20','477',NULL,'YTD Gross Pay/415/HCE/414 Compensation',NULL,NULL,'"drvYTDGross_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EPRUDTTT00Z0','1','D','20','492',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EPRUDTTT00Z0','15','D','20','493',NULL,'Deferral & Plan Limit Compensation',NULL,NULL,'"drvDefLimitComp_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EPRUDTTT00Z0','1','D','20','508',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EPRUDTTT00Z0','15','D','20','509',NULL,'Current Eligible Gross Pay ''Source 2''',NULL,NULL,'"drvCurEligGrossSource2_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EPRUDTTT00Z0','1','D','20','524',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EPRUDTTT00Z0','15','D','20','525',NULL,'ADP & Plan Compensation',NULL,NULL,'"drvADPPlanComp_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EPRUDTTT00Z0','1','D','20','540',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EPRUDTTT00Z0','15','D','20','541',NULL,'Current Eligible Gross Pay ''Source 3''',NULL,NULL,'"drvCurEligGrossSource3_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EPRUDTTT00Z0','1','D','20','556',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EPRUDTTT00Z0','15','D','20','557',NULL,'ER Match Compensation',NULL,NULL,'"drvERMatchComp_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EPRUDTTT00Z0','1','D','20','572',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EPRUDTTT00Z0','11','D','20','573',NULL,'ACP Compensation',NULL,NULL,'"drvACPComp_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EPRUDTTT00Z0','1','D','20','584',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EPRUDTTT00Z0','11','D','20','585',NULL,'Excluded Compensation',NULL,NULL,'"drvExclComp_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EPRUDTTT00Z0','1','D','20','596',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EPRUDTTT00Z0','11','D','20','597',NULL,'Top Heavy 401(a) Compensation',NULL,NULL,'"drv401A_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EPRUDTTT00Z0','1','D','20','608',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EPRUDTTT00Z0','11','D','20','609',NULL,'EE Post Tax Compensation',NULL,NULL,'"drvEEPostComp_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EPRUDTTT00Z0','1','D','20','620',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EPRUDTTT00Z0','2','D','20','621',NULL,'Sub Status',NULL,NULL,'"drvSubStatus_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EPRUDTTT00Z0','1','D','20','623',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EPRUDTTT00Z0','8','D','20','624',NULL,'Sub Status Date',NULL,NULL,'"drvSubStatusDate_2"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EPRUDTTT00Z0','40','D','20','632',NULL,'Participant''s Email Address',NULL,NULL,'"drvEmail_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','25','1',NULL,'Transaction Code',NULL,NULL,'"114"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','25','4',NULL,'Sequence Code',NULL,NULL,'"01"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','25','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','25','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','25','15',NULL,'Participant ID',NULL,NULL,'"drvSSN_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','12','D','25','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','2','D','25','36',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','1','D','25','38',NULL,'Source 1',NULL,NULL,'"A"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','9','D','25','39',NULL,'Contribution Amount',NULL,NULL,'"drvPretax_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','2','D','25','48',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','1','D','25','50',NULL,'Source 2',NULL,NULL,'"6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','9','D','25','51',NULL,'Contribution Amount',NULL,NULL,'"drvPretaxMatch_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','2','D','25','60',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','1','D','25','62',NULL,'Source 3',NULL,NULL,'"J"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','9','D','25','63',NULL,'Contribution Amount',NULL,NULL,'"drvRoth_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','2','D','25','72',NULL,'Investment',NULL,NULL,'"drvInvestment3_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','1','D','25','74',NULL,'Source 4',NULL,NULL,'"drvSource4_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRUDTTT00Z0','9','D','25','75',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt4_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRUDTTT00Z0','2','D','25','84',NULL,'Investment',NULL,NULL,'"drvInvestment4_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRUDTTT00Z0','1','D','25','86',NULL,'Source 5',NULL,NULL,'"drvSource5_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRUDTTT00Z0','9','D','25','87',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt5_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRUDTTT00Z0','2','D','25','96',NULL,'Investment',NULL,NULL,'"drvInvestment5_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRUDTTT00Z0','1','D','25','98',NULL,'Source 6',NULL,NULL,'"drvSource6_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRUDTTT00Z0','9','D','25','99',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt6_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRUDTTT00Z0','8','D','25','108',NULL,'Pay Period End Date',NULL,NULL,'"drvPeriodEnd_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRUDTTT00Z0','1','D','25','116',NULL,'Insider Trader',NULL,NULL,'"drvInsiderTrader_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRUDTTT00Z0','4','D','25','117',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanNumber_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRUDTTT00Z0','30','D','25','121',NULL,'Name',NULL,NULL,'"drvName_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRUDTTT00Z0','30','D','25','151',NULL,'Address 1',NULL,NULL,'"drvAddress1_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRUDTTT00Z0','30','D','25','181',NULL,'Address 2',NULL,NULL,'"drvAddress2_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRUDTTT00Z0','18','D','25','211',NULL,'City',NULL,NULL,'"drvCity_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRUDTTT00Z0','2','D','25','229',NULL,'State',NULL,NULL,'"drvState_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRUDTTT00Z0','9','D','25','231',NULL,'ZipCode',NULL,NULL,'"drvZipCode_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRUDTTT00Z0','8','D','25','240',NULL,'Date of Birth',NULL,NULL,'"drvDOB_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRUDTTT00Z0','8','D','25','248',NULL,'Original Date of Hire',NULL,NULL,'"drvODOH_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRUDTTT00Z0','8','D','25','256',NULL,'Adj. Date of Hire',NULL,NULL,'"drvADOH_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRUDTTT00Z0','1','D','25','264',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRUDTTT00Z0','1','D','25','265',NULL,'Gender Code',NULL,NULL,'"drvGender_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRUDTTT00Z0','2','D','25','266',NULL,'EE Status',NULL,NULL,'"drvEmplStatus_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRUDTTT00Z0','8','D','25','268',NULL,'Employee Status Date',NULL,NULL,'"drvEmplStatusDate_2"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRUDTTT00Z0','1','D','25','276',NULL,'Payroll Frequency',NULL,NULL,'"drvFrequency_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRUDTTT00Z0','8','D','25','277',NULL,'Years of Service',NULL,NULL,'"00000000"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRUDTTT00Z0','6','D','25','285',NULL,'YTD Hours of Service',NULL,NULL,'"drvHrsOfService_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRUDTTT00Z0','6','D','25','291',NULL,'Current Pay Period Hours Worked',NULL,NULL,'"drvCurHrs_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRUDTTT00Z0','15','D','25','297',NULL,'Current Pay Period Gross Pay',NULL,NULL,'"drvCurGross_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRUDTTT00Z0','15','D','25','312',NULL,'Current Eligible Gross Pay ''Source 1''',NULL,NULL,'"drvCurEligGross_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPRUDTTT00Z0','11','D','25','327',NULL,'Current Pay Period W-2 Pay',NULL,NULL,'"drvCurW2Taxable_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPRUDTTT00Z0','8','D','25','338',NULL,'Anniversary Date',NULL,NULL,'"drvAnniversary_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPRUDTTT00Z0','6','D','25','346',NULL,'Anniversary Hours',NULL,NULL,'"drvAnniversaryHrs_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPRUDTTT00Z0','8','D','25','352',NULL,'Check Date',NULL,NULL,'"drvPayDate_2"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPRUDTTT00Z0','13','D','25','360',NULL,'Employee ID/Code',NULL,NULL,'"drvEmpIDCode_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPRUDTTT00Z0','4','D','25','373',NULL,'Div/Sub',NULL,NULL,'"drvDivSub_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPRUDTTT00Z0','10','D','25','377',NULL,'Employer Location Code',NULL,NULL,'"drvERLocCode_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPRUDTTT00Z0','8','D','25','387',NULL,'Location Effective Date',NULL,NULL,'"drvLocEffDate_2"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPRUDTTT00Z0','1','D','25','395',NULL,'Group Indicator',NULL,NULL,'"drvGroupInd_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EPRUDTTT00Z0','10','D','25','396',NULL,'Never Eligible',NULL,NULL,'"drvNeverElig_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EPRUDTTT00Z0','5','D','25','406',NULL,'Eligible to Participate in EE Sources',NULL,NULL,'"drvEligEESources_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EPRUDTTT00Z0','5','D','25','411',NULL,'Eligible to Participate in ER Sources',NULL,NULL,'"drvEligERSources_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EPRUDTTT00Z0','8','D','25','416',NULL,'Eligibility Date',NULL,NULL,'"drvEligDate_2"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EPRUDTTT00Z0','1','D','25','424',NULL,'Auto Enrollment Decline Indicator',NULL,NULL,'"drvAutoEnroll_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EPRUDTTT00Z0','5','D','25','425',NULL,'Deferral Rate for Source 1',NULL,NULL,'"drvDefRate_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EPRUDTTT00Z0','15','D','25','430',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EPRUDTTT00Z0','11','D','25','445',NULL,'Cash Bonus',NULL,NULL,'"drvCashBonus_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EPRUDTTT00Z0','1','D','25','456',NULL,'HCE Indicator',NULL,NULL,'"drvHCEInd_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EPRUDTTT00Z0','1','D','25','457',NULL,'Union Employee',NULL,NULL,'"drvUnionEE_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EPRUDTTT00Z0','11','D','25','458',NULL,'Market Salary',NULL,NULL,'"drvMarketSal_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EPRUDTTT00Z0','8','D','25','469',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate_2"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EPRUDTTT00Z0','15','D','25','477',NULL,'YTD Gross Pay/415/HCE/414 Compensation',NULL,NULL,'"drvYTDGross_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EPRUDTTT00Z0','1','D','25','492',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EPRUDTTT00Z0','15','D','25','493',NULL,'Deferral & Plan Limit Compensation',NULL,NULL,'"drvDefLimitComp_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EPRUDTTT00Z0','1','D','25','508',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EPRUDTTT00Z0','15','D','25','509',NULL,'Current Eligible Gross Pay ''Source 2''',NULL,NULL,'"drvCurEligGrossSource2_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EPRUDTTT00Z0','1','D','25','524',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EPRUDTTT00Z0','15','D','25','525',NULL,'ADP & Plan Compensation',NULL,NULL,'"drvADPPlanComp_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EPRUDTTT00Z0','1','D','25','540',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EPRUDTTT00Z0','15','D','25','541',NULL,'Current Eligible Gross Pay ''Source 3''',NULL,NULL,'"drvCurEligGrossSource3_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EPRUDTTT00Z0','1','D','25','556',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EPRUDTTT00Z0','15','D','25','557',NULL,'ER Match Compensation',NULL,NULL,'"drvERMatchComp_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EPRUDTTT00Z0','1','D','25','572',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EPRUDTTT00Z0','11','D','25','573',NULL,'ACP Compensation',NULL,NULL,'"drvACPComp_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EPRUDTTT00Z0','1','D','25','584',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EPRUDTTT00Z0','11','D','25','585',NULL,'Excluded Compensation',NULL,NULL,'"drvExclComp_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EPRUDTTT00Z0','1','D','25','596',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EPRUDTTT00Z0','11','D','25','597',NULL,'Top Heavy 401(a) Compensation',NULL,NULL,'"drv401A_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EPRUDTTT00Z0','1','D','25','608',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EPRUDTTT00Z0','11','D','25','609',NULL,'EE Post Tax Compensation',NULL,NULL,'"drvEEPostComp_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EPRUDTTT00Z0','1','D','25','620',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EPRUDTTT00Z0','2','D','25','621',NULL,'Sub Status',NULL,NULL,'"drvSubStatus_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EPRUDTTT00Z0','1','D','25','623',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EPRUDTTT00Z0','8','D','25','624',NULL,'Sub Status Date',NULL,NULL,'"drvSubStatusDate_2"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EPRUDTTT00Z0','40','D','25','632',NULL,'Participant''s Email Address',NULL,NULL,'"drvEmail_2"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','30','1',NULL,'Transaction Code',NULL,NULL,'"114"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','30','4',NULL,'Sequence Code',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','30','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','30','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','30','15',NULL,'Participant ID',NULL,NULL,'"drvSSN_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','12','D','30','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','2','D','30','36',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','1','D','30','38',NULL,'Source 1',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','9','D','30','39',NULL,'Contribution Amount',NULL,NULL,'"drvPretax_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','2','D','30','48',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','1','D','30','50',NULL,'Source 2',NULL,NULL,'"6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','9','D','30','51',NULL,'Contribution Amount',NULL,NULL,'"drvPretaxMatch_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','2','D','30','60',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','1','D','30','62',NULL,'Source 3',NULL,NULL,'"J"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','9','D','30','63',NULL,'Contribution Amount',NULL,NULL,'"drvRoth_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','2','D','30','72',NULL,'Investment',NULL,NULL,'"drvInvestment3_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','1','D','30','74',NULL,'Source 4',NULL,NULL,'"drvSource4_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRUDTTT00Z0','9','D','30','75',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt4_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRUDTTT00Z0','2','D','30','84',NULL,'Investment',NULL,NULL,'"drvInvestment4_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRUDTTT00Z0','1','D','30','86',NULL,'Source 5',NULL,NULL,'"drvSource5_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRUDTTT00Z0','9','D','30','87',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt5_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRUDTTT00Z0','2','D','30','96',NULL,'Investment',NULL,NULL,'"drvInvestment5_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRUDTTT00Z0','1','D','30','98',NULL,'Source 6',NULL,NULL,'"drvSource6_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRUDTTT00Z0','9','D','30','99',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt6_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRUDTTT00Z0','8','D','30','108',NULL,'Pay Period End Date',NULL,NULL,'"drvPeriodEnd_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRUDTTT00Z0','1','D','30','116',NULL,'Insider Trader',NULL,NULL,'"drvInsiderTrader_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRUDTTT00Z0','4','D','30','117',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanNumber_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRUDTTT00Z0','30','D','30','121',NULL,'Name',NULL,NULL,'"drvName_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRUDTTT00Z0','30','D','30','151',NULL,'Address 1',NULL,NULL,'"drvAddress1_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRUDTTT00Z0','30','D','30','181',NULL,'Address 2',NULL,NULL,'"drvAddress2_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRUDTTT00Z0','18','D','30','211',NULL,'City',NULL,NULL,'"drvCity_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRUDTTT00Z0','2','D','30','229',NULL,'State',NULL,NULL,'"drvState_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRUDTTT00Z0','9','D','30','231',NULL,'ZipCode',NULL,NULL,'"drvZipCode_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRUDTTT00Z0','8','D','30','240',NULL,'Date of Birth',NULL,NULL,'"drvDOB_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRUDTTT00Z0','8','D','30','248',NULL,'Original Date of Hire',NULL,NULL,'"drvODOH_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRUDTTT00Z0','8','D','30','256',NULL,'Adj. Date of Hire',NULL,NULL,'"drvADOH_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRUDTTT00Z0','1','D','30','264',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRUDTTT00Z0','1','D','30','265',NULL,'Gender Code',NULL,NULL,'"drvGender_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRUDTTT00Z0','2','D','30','266',NULL,'EE Status',NULL,NULL,'"drvEmplStatus_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRUDTTT00Z0','8','D','30','268',NULL,'Employee Status Date',NULL,NULL,'"drvEmplStatusDate_3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRUDTTT00Z0','1','D','30','276',NULL,'Payroll Frequency',NULL,NULL,'"drvFrequency_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRUDTTT00Z0','8','D','30','277',NULL,'Years of Service',NULL,NULL,'"00000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRUDTTT00Z0','6','D','30','285',NULL,'YTD Hours of Service',NULL,NULL,'"drvHrsOfService_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRUDTTT00Z0','6','D','30','291',NULL,'Current Pay Period Hours Worked',NULL,NULL,'"drvCurHrs_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRUDTTT00Z0','15','D','30','297',NULL,'Current Pay Period Gross Pay',NULL,NULL,'"drvCurGross_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRUDTTT00Z0','15','D','30','312',NULL,'Current Eligible Gross Pay ''Source 1''',NULL,NULL,'"drvCurEligGross_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPRUDTTT00Z0','11','D','30','327',NULL,'Current Pay Period W-2 Pay',NULL,NULL,'"drvCurW2Taxable_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPRUDTTT00Z0','8','D','30','338',NULL,'Anniversary Date',NULL,NULL,'"drvAnniversary_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPRUDTTT00Z0','6','D','30','346',NULL,'Anniversary Hours',NULL,NULL,'"drvAnniversaryHrs_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPRUDTTT00Z0','8','D','30','352',NULL,'Check Date',NULL,NULL,'"drvPayDate_3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPRUDTTT00Z0','13','D','30','360',NULL,'Employee ID/Code',NULL,NULL,'"drvEmpIDCode_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPRUDTTT00Z0','4','D','30','373',NULL,'Div/Sub',NULL,NULL,'"drvDivSub_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPRUDTTT00Z0','10','D','30','377',NULL,'Employer Location Code',NULL,NULL,'"drvERLocCode_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPRUDTTT00Z0','8','D','30','387',NULL,'Location Effective Date',NULL,NULL,'"drvLocEffDate_3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPRUDTTT00Z0','1','D','30','395',NULL,'Group Indicator',NULL,NULL,'"drvGroupInd_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EPRUDTTT00Z0','10','D','30','396',NULL,'Never Eligible',NULL,NULL,'"drvNeverElig_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EPRUDTTT00Z0','5','D','30','406',NULL,'Eligible to Participate in EE Sources',NULL,NULL,'"drvEligEESources_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EPRUDTTT00Z0','5','D','30','411',NULL,'Eligible to Participate in ER Sources',NULL,NULL,'"drvEligERSources_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EPRUDTTT00Z0','8','D','30','416',NULL,'Eligibility Date',NULL,NULL,'"drvEligDate_3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EPRUDTTT00Z0','1','D','30','424',NULL,'Auto Enrollment Decline Indicator',NULL,NULL,'"drvAutoEnroll_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EPRUDTTT00Z0','5','D','30','425',NULL,'Deferral Rate for Source 1',NULL,NULL,'"drvDefRate_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EPRUDTTT00Z0','15','D','30','430',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EPRUDTTT00Z0','11','D','30','445',NULL,'Cash Bonus',NULL,NULL,'"drvCashBonus_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EPRUDTTT00Z0','1','D','30','456',NULL,'HCE Indicator',NULL,NULL,'"drvHCEInd_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EPRUDTTT00Z0','1','D','30','457',NULL,'Union Employee',NULL,NULL,'"drvUnionEE_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EPRUDTTT00Z0','11','D','30','458',NULL,'Market Salary',NULL,NULL,'"drvMarketSal_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EPRUDTTT00Z0','8','D','30','469',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate_3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EPRUDTTT00Z0','15','D','30','477',NULL,'YTD Gross Pay/415/HCE/414 Compensation',NULL,NULL,'"drvYTDGross_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EPRUDTTT00Z0','1','D','30','492',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EPRUDTTT00Z0','15','D','30','493',NULL,'Deferral & Plan Limit Compensation',NULL,NULL,'"drvDefLimitComp_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EPRUDTTT00Z0','1','D','30','508',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EPRUDTTT00Z0','15','D','30','509',NULL,'Current Eligible Gross Pay ''Source 2''',NULL,NULL,'"drvCurEligGrossSource2_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EPRUDTTT00Z0','1','D','30','524',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EPRUDTTT00Z0','15','D','30','525',NULL,'ADP & Plan Compensation',NULL,NULL,'"drvADPPlanComp_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EPRUDTTT00Z0','1','D','30','540',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EPRUDTTT00Z0','15','D','30','541',NULL,'Current Eligible Gross Pay ''Source 3''',NULL,NULL,'"drvCurEligGrossSource3_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EPRUDTTT00Z0','1','D','30','556',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EPRUDTTT00Z0','15','D','30','557',NULL,'ER Match Compensation',NULL,NULL,'"drvERMatchComp_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EPRUDTTT00Z0','1','D','30','572',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EPRUDTTT00Z0','11','D','30','573',NULL,'ACP Compensation',NULL,NULL,'"drvACPComp_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EPRUDTTT00Z0','1','D','30','584',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EPRUDTTT00Z0','11','D','30','585',NULL,'Excluded Compensation',NULL,NULL,'"drvExclComp_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EPRUDTTT00Z0','1','D','30','596',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EPRUDTTT00Z0','11','D','30','597',NULL,'Top Heavy 401(a) Compensation',NULL,NULL,'"drv401A_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EPRUDTTT00Z0','1','D','30','608',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EPRUDTTT00Z0','11','D','30','609',NULL,'EE Post Tax Compensation',NULL,NULL,'"drvEEPostComp_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EPRUDTTT00Z0','1','D','30','620',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EPRUDTTT00Z0','2','D','30','621',NULL,'Sub Status',NULL,NULL,'"drvSubStatus_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EPRUDTTT00Z0','1','D','30','623',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EPRUDTTT00Z0','8','D','30','624',NULL,'Sub Status Date',NULL,NULL,'"drvSubStatusDate_3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EPRUDTTT00Z0','40','D','30','632',NULL,'Participant''s Email Address',NULL,NULL,'"drvEmail_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','35','1',NULL,'Transaction Code',NULL,NULL,'"114"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','35','4',NULL,'Sequence Code',NULL,NULL,'"01"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','35','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','35','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','35','15',NULL,'Participant ID',NULL,NULL,'"drvSSN_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','12','D','35','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','2','D','35','36',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','1','D','35','38',NULL,'Source 1',NULL,NULL,'"A"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','9','D','35','39',NULL,'Contribution Amount',NULL,NULL,'"drvPretax_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','2','D','35','48',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','1','D','35','50',NULL,'Source 2',NULL,NULL,'"6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','9','D','35','51',NULL,'Contribution Amount',NULL,NULL,'"drvPretaxMatch_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','2','D','35','60',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','1','D','35','62',NULL,'Source 3',NULL,NULL,'"J"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','9','D','35','63',NULL,'Contribution Amount',NULL,NULL,'"drvRoth_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','2','D','35','72',NULL,'Investment',NULL,NULL,'"drvInvestment3_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','1','D','35','74',NULL,'Source 4',NULL,NULL,'"drvSource4_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EPRUDTTT00Z0','9','D','35','75',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt4_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EPRUDTTT00Z0','2','D','35','84',NULL,'Investment',NULL,NULL,'"drvInvestment4_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EPRUDTTT00Z0','1','D','35','86',NULL,'Source 5',NULL,NULL,'"drvSource5_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EPRUDTTT00Z0','9','D','35','87',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt5_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EPRUDTTT00Z0','2','D','35','96',NULL,'Investment',NULL,NULL,'"drvInvestment5_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EPRUDTTT00Z0','1','D','35','98',NULL,'Source 6',NULL,NULL,'"drvSource6_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EPRUDTTT00Z0','9','D','35','99',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt6_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EPRUDTTT00Z0','8','D','35','108',NULL,'Pay Period End Date',NULL,NULL,'"drvPeriodEnd_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EPRUDTTT00Z0','1','D','35','116',NULL,'Insider Trader',NULL,NULL,'"drvInsiderTrader_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EPRUDTTT00Z0','4','D','35','117',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanNumber_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EPRUDTTT00Z0','30','D','35','121',NULL,'Name',NULL,NULL,'"drvName_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EPRUDTTT00Z0','30','D','35','151',NULL,'Address 1',NULL,NULL,'"drvAddress1_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EPRUDTTT00Z0','30','D','35','181',NULL,'Address 2',NULL,NULL,'"drvAddress2_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EPRUDTTT00Z0','18','D','35','211',NULL,'City',NULL,NULL,'"drvCity_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EPRUDTTT00Z0','2','D','35','229',NULL,'State',NULL,NULL,'"drvState_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EPRUDTTT00Z0','9','D','35','231',NULL,'ZipCode',NULL,NULL,'"drvZipCode_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EPRUDTTT00Z0','8','D','35','240',NULL,'Date of Birth',NULL,NULL,'"drvDOB_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EPRUDTTT00Z0','8','D','35','248',NULL,'Original Date of Hire',NULL,NULL,'"drvODOH_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EPRUDTTT00Z0','8','D','35','256',NULL,'Adj. Date of Hire',NULL,NULL,'"drvADOH_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EPRUDTTT00Z0','1','D','35','264',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EPRUDTTT00Z0','1','D','35','265',NULL,'Gender Code',NULL,NULL,'"drvGender_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EPRUDTTT00Z0','2','D','35','266',NULL,'EE Status',NULL,NULL,'"drvEmplStatus_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EPRUDTTT00Z0','8','D','35','268',NULL,'Employee Status Date',NULL,NULL,'"drvEmplStatusDate_3"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EPRUDTTT00Z0','1','D','35','276',NULL,'Payroll Frequency',NULL,NULL,'"drvFrequency_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EPRUDTTT00Z0','8','D','35','277',NULL,'Years of Service',NULL,NULL,'"00000000"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EPRUDTTT00Z0','6','D','35','285',NULL,'YTD Hours of Service',NULL,NULL,'"drvHrsOfService_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EPRUDTTT00Z0','6','D','35','291',NULL,'Current Pay Period Hours Worked',NULL,NULL,'"drvCurHrs_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EPRUDTTT00Z0','15','D','35','297',NULL,'Current Pay Period Gross Pay',NULL,NULL,'"drvCurGross_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EPRUDTTT00Z0','15','D','35','312',NULL,'Current Eligible Gross Pay ''Source 1''',NULL,NULL,'"drvCurEligGross_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EPRUDTTT00Z0','11','D','35','327',NULL,'Current Pay Period W-2 Pay',NULL,NULL,'"drvCurW2Taxable_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EPRUDTTT00Z0','8','D','35','338',NULL,'Anniversary Date',NULL,NULL,'"drvAnniversary_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EPRUDTTT00Z0','6','D','35','346',NULL,'Anniversary Hours',NULL,NULL,'"drvAnniversaryHrs_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EPRUDTTT00Z0','8','D','35','352',NULL,'Check Date',NULL,NULL,'"drvPayDate_3"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EPRUDTTT00Z0','13','D','35','360',NULL,'Employee ID/Code',NULL,NULL,'"drvEmpIDCode_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EPRUDTTT00Z0','4','D','35','373',NULL,'Div/Sub',NULL,NULL,'"drvDivSub_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EPRUDTTT00Z0','10','D','35','377',NULL,'Employer Location Code',NULL,NULL,'"drvERLocCode_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EPRUDTTT00Z0','8','D','35','387',NULL,'Location Effective Date',NULL,NULL,'"drvLocEffDate_3"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EPRUDTTT00Z0','1','D','35','395',NULL,'Group Indicator',NULL,NULL,'"drvGroupInd_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EPRUDTTT00Z0','10','D','35','396',NULL,'Never Eligible',NULL,NULL,'"drvNeverElig_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EPRUDTTT00Z0','5','D','35','406',NULL,'Eligible to Participate in EE Sources',NULL,NULL,'"drvEligEESources_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EPRUDTTT00Z0','5','D','35','411',NULL,'Eligible to Participate in ER Sources',NULL,NULL,'"drvEligERSources_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EPRUDTTT00Z0','8','D','35','416',NULL,'Eligibility Date',NULL,NULL,'"drvEligDate_3"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EPRUDTTT00Z0','1','D','35','424',NULL,'Auto Enrollment Decline Indicator',NULL,NULL,'"drvAutoEnroll_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EPRUDTTT00Z0','5','D','35','425',NULL,'Deferral Rate for Source 1',NULL,NULL,'"drvDefRate_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EPRUDTTT00Z0','15','D','35','430',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EPRUDTTT00Z0','11','D','35','445',NULL,'Cash Bonus',NULL,NULL,'"drvCashBonus_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EPRUDTTT00Z0','1','D','35','456',NULL,'HCE Indicator',NULL,NULL,'"drvHCEInd_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EPRUDTTT00Z0','1','D','35','457',NULL,'Union Employee',NULL,NULL,'"drvUnionEE_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EPRUDTTT00Z0','11','D','35','458',NULL,'Market Salary',NULL,NULL,'"drvMarketSal_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EPRUDTTT00Z0','8','D','35','469',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate_3"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EPRUDTTT00Z0','15','D','35','477',NULL,'YTD Gross Pay/415/HCE/414 Compensation',NULL,NULL,'"drvYTDGross_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EPRUDTTT00Z0','1','D','35','492',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EPRUDTTT00Z0','15','D','35','493',NULL,'Deferral & Plan Limit Compensation',NULL,NULL,'"drvDefLimitComp_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EPRUDTTT00Z0','1','D','35','508',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EPRUDTTT00Z0','15','D','35','509',NULL,'Current Eligible Gross Pay ''Source 2''',NULL,NULL,'"drvCurEligGrossSource2_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EPRUDTTT00Z0','1','D','35','524',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EPRUDTTT00Z0','15','D','35','525',NULL,'ADP & Plan Compensation',NULL,NULL,'"drvADPPlanComp_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EPRUDTTT00Z0','1','D','35','540',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EPRUDTTT00Z0','15','D','35','541',NULL,'Current Eligible Gross Pay ''Source 3''',NULL,NULL,'"drvCurEligGrossSource3_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EPRUDTTT00Z0','1','D','35','556',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EPRUDTTT00Z0','15','D','35','557',NULL,'ER Match Compensation',NULL,NULL,'"drvERMatchComp_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EPRUDTTT00Z0','1','D','35','572',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EPRUDTTT00Z0','11','D','35','573',NULL,'ACP Compensation',NULL,NULL,'"drvACPComp_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EPRUDTTT00Z0','1','D','35','584',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EPRUDTTT00Z0','11','D','35','585',NULL,'Excluded Compensation',NULL,NULL,'"drvExclComp_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EPRUDTTT00Z0','1','D','35','596',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EPRUDTTT00Z0','11','D','35','597',NULL,'Top Heavy 401(a) Compensation',NULL,NULL,'"drv401A_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EPRUDTTT00Z0','1','D','35','608',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EPRUDTTT00Z0','11','D','35','609',NULL,'EE Post Tax Compensation',NULL,NULL,'"drvEEPostComp_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EPRUDTTT00Z0','1','D','35','620',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EPRUDTTT00Z0','2','D','35','621',NULL,'Sub Status',NULL,NULL,'"drvSubStatus_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EPRUDTTT00Z0','1','D','35','623',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EPRUDTTT00Z0','8','D','35','624',NULL,'Sub Status Date',NULL,NULL,'"drvSubStatusDate_3"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EPRUDTTT00Z0','40','D','35','632',NULL,'Participant''s Email Address',NULL,NULL,'"drvEmail_3"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','40','1',NULL,'Transaction Code',NULL,NULL,'"385"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','40','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','40','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumberLoan"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','40','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','40','15',NULL,'Participant ID',NULL,NULL,'"drvSSNLoan"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','6','D','40','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','D','40','30',NULL,'Date Expected Override',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','3','D','40','31',NULL,'Loan Number',NULL,NULL,'"drvLoanNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','D','40','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','9','D','40','35',NULL,'Loan Repayment Amount',NULL,NULL,'"drvLoanAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','10','D','40','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','1','D','40','54',NULL,'Loan Payment Override',NULL,NULL,'"2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','3','D','40','55',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','4','D','40','58',NULL,'Loan Payroll Code',NULL,NULL,'"PDED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','19','D','40','62',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','4','D','40','81',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanLoan"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','587','D','40','85',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','45','1',NULL,'Transaction Code',NULL,NULL,'"385"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','45','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','45','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumberLoan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','45','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','45','15',NULL,'Participant ID',NULL,NULL,'"drvSSNLoan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','6','D','45','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','D','45','30',NULL,'Date Expected Override',NULL,NULL,'"1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','3','D','45','31',NULL,'Loan Number',NULL,NULL,'"drvLoanNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','D','45','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','9','D','45','35',NULL,'Loan Repayment Amount',NULL,NULL,'"drvLoanAmtNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','10','D','45','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','1','D','45','54',NULL,'Loan Payment Override',NULL,NULL,'"2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','3','D','45','55',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','4','D','45','58',NULL,'Loan Payroll Code',NULL,NULL,'"PDED"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','19','D','45','62',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','4','D','45','81',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanLoan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','587','D','45','85',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','50','1',NULL,'Transaction Code',NULL,NULL,'"385"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','50','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','50','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumberLoan_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','50','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','50','15',NULL,'Participant ID',NULL,NULL,'"drvSSNLoan_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','6','D','50','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','D','50','30',NULL,'Date Expected Override',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','3','D','50','31',NULL,'Loan Number',NULL,NULL,'"drvLoanNumber_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','D','50','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','9','D','50','35',NULL,'Loan Repayment Amount',NULL,NULL,'"drvLoanAmt_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','10','D','50','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','1','D','50','54',NULL,'Loan Payment Override',NULL,NULL,'"2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','3','D','50','55',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','4','D','50','58',NULL,'Loan Payroll Code',NULL,NULL,'"PDED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','19','D','50','62',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','4','D','50','81',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanLoan_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','587','D','50','85',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','55','1',NULL,'Transaction Code',NULL,NULL,'"385"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','55','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','55','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumberLoan_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','55','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','55','15',NULL,'Participant ID',NULL,NULL,'"drvSSNLoan_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','6','D','55','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','D','55','30',NULL,'Date Expected Override',NULL,NULL,'"1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','3','D','55','31',NULL,'Loan Number',NULL,NULL,'"drvLoanNumber_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','D','55','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','9','D','55','35',NULL,'Loan Repayment Amount',NULL,NULL,'"drvLoanAmt_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','10','D','55','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','1','D','55','54',NULL,'Loan Payment Override',NULL,NULL,'"2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','3','D','55','55',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','4','D','55','58',NULL,'Loan Payroll Code',NULL,NULL,'"PDED"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','19','D','55','62',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','4','D','55','81',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanLoan_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','587','D','55','85',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','60','1',NULL,'Transaction Code',NULL,NULL,'"385"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','60','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','60','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumberLoan_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','60','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','60','15',NULL,'Participant ID',NULL,NULL,'"drvSSNLoan_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','6','D','60','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','D','60','30',NULL,'Date Expected Override',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','3','D','60','31',NULL,'Loan Number',NULL,NULL,'"drvLoanNumber_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','D','60','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','9','D','60','35',NULL,'Loan Repayment Amount',NULL,NULL,'"drvLoanAmt_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','10','D','60','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','1','D','60','54',NULL,'Loan Payment Override',NULL,NULL,'"2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','3','D','60','55',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','4','D','60','58',NULL,'Loan Payroll Code',NULL,NULL,'"PDED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','19','D','60','62',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','4','D','60','81',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanLoan_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','587','D','60','85',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','D','65','1',NULL,'Transaction Code',NULL,NULL,'"385"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','2','D','65','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','6','D','65','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumberLoan_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','3','D','65','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','9','D','65','15',NULL,'Participant ID',NULL,NULL,'"drvSSNLoan_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','6','D','65','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','D','65','30',NULL,'Date Expected Override',NULL,NULL,'"1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','3','D','65','31',NULL,'Loan Number',NULL,NULL,'"drvLoanNumber_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','D','65','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','9','D','65','35',NULL,'Loan Repayment Amount',NULL,NULL,'"drvLoanAmt_3NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','10','D','65','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EPRUDTTT00Z0','1','D','65','54',NULL,'Loan Payment Override',NULL,NULL,'"2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EPRUDTTT00Z0','3','D','65','55',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EPRUDTTT00Z0','4','D','65','58',NULL,'Loan Payroll Code',NULL,NULL,'"PDED"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EPRUDTTT00Z0','19','D','65','62',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EPRUDTTT00Z0','4','D','65','81',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanLoan_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EPRUDTTT00Z0','587','D','65','85',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','T','90','1',NULL,'Record Type',NULL,NULL,'"999"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','10','T','90','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','10','T','90','14',NULL,'Client Identifier',NULL,NULL,'"drvClientIDTrl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','8','T','90','24',NULL,'File Creation date',NULL,NULL,'"drvCreationDateTrl"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','6','T','90','32',NULL,'File Creation Time',NULL,NULL,'"drvCreationTimeTrl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','9','T','90','38',NULL,'Detail Record Count',NULL,NULL,'"drvRecordCount"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','T','90','47',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','11','T','90','48',NULL,'Total Contribution Amount',NULL,NULL,'"drvTotalCont"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','T','90','59',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','11','T','90','60',NULL,'Loan Repayment Amount',NULL,NULL,'"drvTotalLoanAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','601','T','90','71',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','T','91','1',NULL,'Record Type',NULL,NULL,'"999"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','10','T','91','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','10','T','91','14',NULL,'Client Identifier',NULL,NULL,'"drvClientIDTrl_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','8','T','91','24',NULL,'File Creation date',NULL,NULL,'"drvCreationDateTrl_2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','6','T','91','32',NULL,'File Creation Time',NULL,NULL,'"drvCreationTimeTrl_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','9','T','91','38',NULL,'Detail Record Count',NULL,NULL,'"drvRecordCount_2"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','T','91','47',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','11','T','91','48',NULL,'Total Contribution Amount',NULL,NULL,'"drvTotalCont_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','T','91','59',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','11','T','91','60',NULL,'Loan Repayment Amount',NULL,NULL,'"drvTotalLoanAmt_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','601','T','91','71',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','T','92','1',NULL,'Record Type',NULL,NULL,'"999"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','10','T','92','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','10','T','92','14',NULL,'Client Identifier',NULL,NULL,'"drvClientIDTrl_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','8','T','92','24',NULL,'File Creation date',NULL,NULL,'"drvCreationDateTrl_3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','6','T','92','32',NULL,'File Creation Time',NULL,NULL,'"drvCreationTimeTrl_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','9','T','92','38',NULL,'Detail Record Count',NULL,NULL,'"drvRecordCount_3"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','T','92','47',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','11','T','92','48',NULL,'Total Contribution Amount',NULL,NULL,'"drvTotalCont_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','T','92','59',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','11','T','92','60',NULL,'Loan Repayment Amount',NULL,NULL,'"drvTotalLoanAmt_3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','601','T','92','71',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','T','93','1',NULL,'Record Type',NULL,NULL,'"999"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','10','T','93','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','10','T','93','14',NULL,'Client Identifier',NULL,NULL,'"drvClientIDTrl"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','8','T','93','24',NULL,'File Creation date',NULL,NULL,'"drvCreationDateTrl"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','6','T','93','32',NULL,'File Creation Time',NULL,NULL,'"drvCreationTimeTrl"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','9','T','93','38',NULL,'Detail Record Count',NULL,NULL,'"drvRecordCount"','(''UN00''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','T','93','47',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','11','T','93','48',NULL,'Total Contribution Amount',NULL,NULL,'"drvTotalCont"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','T','93','59',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','11','T','93','60',NULL,'Loan Repayment Amount',NULL,NULL,'"drvTotalLoanAmt"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','601','T','93','71',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','T','94','1',NULL,'Record Type',NULL,NULL,'"999"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','10','T','94','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','10','T','94','14',NULL,'Client Identifier',NULL,NULL,'"drvClientIDTrl_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','8','T','94','24',NULL,'File Creation date',NULL,NULL,'"drvCreationDateTrl_2"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','6','T','94','32',NULL,'File Creation Time',NULL,NULL,'"drvCreationTimeTrl_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','9','T','94','38',NULL,'Detail Record Count',NULL,NULL,'"drvRecordCount_2"','(''UN00''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','T','94','47',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','11','T','94','48',NULL,'Total Contribution Amount',NULL,NULL,'"drvTotalCont_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','T','94','59',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','11','T','94','60',NULL,'Loan Repayment Amount',NULL,NULL,'"drvTotalLoanAmt_2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','601','T','94','71',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EPRUDTTT00Z0','3','T','95','1',NULL,'Record Type',NULL,NULL,'"999"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EPRUDTTT00Z0','10','T','95','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EPRUDTTT00Z0','10','T','95','14',NULL,'Client Identifier',NULL,NULL,'"drvClientIDTrl_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EPRUDTTT00Z0','8','T','95','24',NULL,'File Creation date',NULL,NULL,'"drvCreationDateTrl_3"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EPRUDTTT00Z0','6','T','95','32',NULL,'File Creation Time',NULL,NULL,'"drvCreationTimeTrl_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EPRUDTTT00Z0','9','T','95','38',NULL,'Detail Record Count',NULL,NULL,'"drvRecordCount_3"','(''UN00''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EPRUDTTT00Z0','1','T','95','47',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EPRUDTTT00Z0','11','T','95','48',NULL,'Total Contribution Amount',NULL,NULL,'"drvTotalCont_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EPRUDTTT00Z0','1','T','95','59',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EPRUDTTT00Z0','11','T','95','60',NULL,'Loan Repayment Amount',NULL,NULL,'"drvTotalLoanAmt_3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EPRUDTTT00Z0','601','T','95','71',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,'1ZD15,3S6LD,1ZF3V,GHJ2I,1ZF8F,1ZFAD,1ZFC8,YUJZX,F1IYF,48TKI,968CW,1ZFDM,1ZFF0,Z9MT2,1ZFIB,1ZFJD,1ZFN3,1ZFOF,1ZFPN,2STMJ,5D666,1ZFGN,ATSCL,SOH37',NULL,NULL,NULL,'Prudential 401K Export','202112319','EMPEXPORT','ONDEMAND','Jan  4 2022  9:13AM','EPRUDTTT',NULL,NULL,NULL,'202112319','Dec 31 2021 12:00AM','Dec 30 1899 12:00AM','202112271','47892','','','202112271',dbo.fn_GetTimedKey(),NULL,'CFORT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,'1ZD15,3S6LD,1ZF3V,GHJ2I,1ZF8F,1ZFAD,1ZFC8,F1IYF,48TKI,968CW,1ZFDM,1ZFF0,Z9MT2,1ZFIB,1ZFJD,1ZFN3,1ZFOF,1ZFPN,2STMJ,5D666,1ZFGN,ATSCL',NULL,NULL,NULL,'Test Purposes Only','202011159','EMPEXPORT','TEST','Nov 16 2020 12:00AM','EPRUDTTT',NULL,NULL,NULL,'202011159','Nov 15 2020 12:00AM','Dec 30 1899 12:00AM','202011091','40220','','','202011091',dbo.fn_GetTimedKey(),NULL,'ULTI_ROLIN',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTT','ExportPath','V','\\us.saas\E4\Public\ROL1002\Exports\Prudential_401K_Export\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTT','MultFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTT','SubSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTT','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTT','TestPath','V','\\us.saas\E4\Public\ROL1002\Exports\Prudential_401K_Export\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTT','UDESPath','C','\\us.saas\E0\data_exchange\ROL1002\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTT','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTT','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','H01','dbo.U_EPRUDTTT_Header_H01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','H02','dbo.U_EPRUDTTT_Header_H02',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','H03','dbo.U_EPRUDTTT_Header_H03',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D10','dbo.U_EPRUDTTT_drvTbl_D10',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D15','dbo.U_EPRUDTTT_drvTbl_D10',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D20','dbo.U_EPRUDTTT_drvTbl_D20',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D25','dbo.U_EPRUDTTT_drvTbl_D20',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D30','dbo.U_EPRUDTTT_drvTbl_D30',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D35','dbo.U_EPRUDTTT_drvTbl_D30',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D40','dbo.U_EPRUDTTT_drvTbl_D40',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D45','dbo.U_EPRUDTTT_drvTbl_D40',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D50','dbo.U_EPRUDTTT_drvTbl_D50',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D55','dbo.U_EPRUDTTT_drvTbl_D50',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D60','dbo.U_EPRUDTTT_drvTbl_D60',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','D65','dbo.U_EPRUDTTT_drvTbl_D60',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','T90','dbo.U_EPRUDTTT_Trailer_T90',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','T91','dbo.U_EPRUDTTT_Trailer_T91',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','T92','dbo.U_EPRUDTTT_Trailer_T92',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','T93','dbo.U_EPRUDTTT_Trailer_T90',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','T94','dbo.U_EPRUDTTT_Trailer_T91',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTT','T95','dbo.U_EPRUDTTT_Trailer_T92',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EPRUDTTT_Audit
-----------

IF OBJECT_ID('U_EPRUDTTT_Audit') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_Audit] (
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
-- Create table U_EPRUDTTT_AuditFields
-----------

IF OBJECT_ID('U_EPRUDTTT_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EPRUDTTT_DedList
-----------

IF OBJECT_ID('U_EPRUDTTT_DedList') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPRUDTTT_drvTbl_D10
-----------

IF OBJECT_ID('U_EPRUDTTT_drvTbl_D10') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_drvTbl_D10] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvDedGroupCode] char(5) NULL,
    [Pretax] decimal NOT NULL,
    [Roth] decimal NOT NULL,
    [CurHrs] decimal NOT NULL,
    [CurGross] decimal NOT NULL,
    [CurEligGross] decimal NOT NULL,
    [CurW2Taxable] money NOT NULL,
    [YTDGross] decimal NOT NULL,
    [PreTaxMatch] decimal NOT NULL,
    [DefLimitComp] decimal NOT NULL,
    [drvPretaxMatch_2] varchar(9) NULL,
    [drvPretaxMatch_2NOP] decimal NOT NULL,
    [drvPlanNumber] varchar(6) NOT NULL,
    [drvSSN2] char(11) NULL,
    [drvPretax] varchar(9) NULL,
    [drvRoth] varchar(9) NULL,
    [drvPretaxNOP] decimal NOT NULL,
    [drvRothNOP] decimal NOT NULL,
    [drvInvestment3] varchar(1) NOT NULL,
    [drvSource4] varchar(1) NOT NULL,
    [drvContAmt4] varchar(1) NOT NULL,
    [drvInvestment4] varchar(1) NOT NULL,
    [drvSource5] varchar(1) NOT NULL,
    [drvContAmt5] varchar(1) NOT NULL,
    [drvInvestment5] varchar(1) NOT NULL,
    [drvSource6] varchar(1) NOT NULL,
    [drvContAmt6] varchar(1) NOT NULL,
    [drvPeriodEnd] varchar(8) NULL,
    [drvInsiderTrader] varchar(1) NOT NULL,
    [drvSubPlanNumber] varchar(4) NULL,
    [drvName] varchar(204) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(8000) NULL,
    [drvDOB] varchar(8) NULL,
    [drvODOH] varchar(8) NULL,
    [drvADOH] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvGender] varchar(1) NULL,
    [drvEmplStatus] varchar(2) NOT NULL,
    [drvEmplStatusDate] varchar(8) NULL,
    [drvFrequency] varchar(1) NULL,
    [drvHrsOfService] varchar(1) NOT NULL,
    [drvCurHrs] varchar(6) NULL,
    [drvCurGross] varchar(15) NULL,
    [drvCurEligGross] varchar(15) NULL,
    [drvCurW2Taxable] varchar(11) NULL,
    [drvCurHrsNOP] decimal NOT NULL,
    [drvCurGrossNOP] decimal NOT NULL,
    [drvCurEligGrossNOP] decimal NULL,
    [drvCurW2TaxableNOP] money NOT NULL,
    [drvAnniversary] varchar(1) NOT NULL,
    [drvAnniversaryHrs] varchar(1) NOT NULL,
    [drvPayDate] varchar(8) NULL,
    [drvEmpIDCode] varchar(10) NULL,
    [drvDivSub] varchar(10) NULL,
    [drvERLocCode] varchar(20) NULL,
    [drvLocEffDate] varchar(1) NOT NULL,
    [drvGroupInd] varchar(1) NOT NULL,
    [drvNeverElig] varchar(1) NOT NULL,
    [drvEligEESources] varchar(1) NOT NULL,
    [drvEligERSources] varchar(1) NOT NULL,
    [drvEligDate] varchar(1) NOT NULL,
    [drvAutoEnroll] varchar(1) NOT NULL,
    [drvDefRate] varchar(1) NOT NULL,
    [drvCashBonus] varchar(1) NOT NULL,
    [drvHCEInd] varchar(1) NOT NULL,
    [drvUnionEE] varchar(1) NOT NULL,
    [drvMarketSal] varchar(11) NULL,
    [drvMarketSalNOP] money NOT NULL,
    [drvRehireDate] varchar(8) NULL,
    [drvYTDGross] varchar(15) NULL,
    [drvDefLimitComp] varchar(15) NULL,
    [drvYTDGrossNOP] decimal NULL,
    [drvDefLimitCompNOP] decimal NOT NULL,
    [drvCurEligGrossSource2] varchar(1) NOT NULL,
    [drvADPPlanComp] varchar(1) NOT NULL,
    [drvCurEligGrossSource3] varchar(1) NOT NULL,
    [drvERMatchComp] varchar(1) NOT NULL,
    [drvACPComp] varchar(1) NOT NULL,
    [drvExclComp] varchar(1) NOT NULL,
    [drv401A] varchar(1) NOT NULL,
    [drvEEPostComp] varchar(1) NOT NULL,
    [drvSubStatus] varchar(2) NULL,
    [drvSubStatusDate] varchar(8) NULL,
    [drvEmail] varchar(50) NULL
);

-----------
-- Create table U_EPRUDTTT_drvTbl_D20
-----------

IF OBJECT_ID('U_EPRUDTTT_drvTbl_D20') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_drvTbl_D20] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvDedGroupCode] char(5) NULL,
    [Pretax] decimal NOT NULL,
    [Roth] decimal NOT NULL,
    [CurHrs] decimal NOT NULL,
    [CurGross] decimal NOT NULL,
    [CurEligGross] decimal NOT NULL,
    [CurW2Taxable] money NOT NULL,
    [YTDGross] decimal NOT NULL,
    [DefLimitComp] decimal NOT NULL,
    [PreTaxMatch] decimal NOT NULL,
    [drvPlanNumber_2] varchar(6) NOT NULL,
    [drvSSN_2] char(11) NULL,
    [drvPretax_2] varchar(9) NULL,
    [drvPretaxMatch_2] varchar(9) NULL,
    [drvRoth_2] varchar(9) NULL,
    [drvPretax_2NOP] decimal NOT NULL,
    [drvPretaxMatch_2NOP] decimal NOT NULL,
    [drvRoth_2NOP] decimal NOT NULL,
    [drvInvestment3_2] varchar(1) NOT NULL,
    [drvSource4_2] varchar(1) NOT NULL,
    [drvContAmt4_2] varchar(1) NOT NULL,
    [drvInvestment4_2] varchar(1) NOT NULL,
    [drvSource5_2] varchar(1) NOT NULL,
    [drvContAmt5_2] varchar(1) NOT NULL,
    [drvInvestment5_2] varchar(1) NOT NULL,
    [drvSource6_2] varchar(1) NOT NULL,
    [drvContAmt6_2] varchar(1) NOT NULL,
    [drvPeriodEnd_2] varchar(8) NULL,
    [drvInsiderTrader_2] varchar(1) NOT NULL,
    [drvSubPlanNumber_2] varchar(4) NULL,
    [drvName_2] varchar(204) NULL,
    [drvAddress1_2] varchar(255) NULL,
    [drvAddress2_2] varchar(255) NULL,
    [drvCity_2] varchar(255) NULL,
    [drvState_2] varchar(255) NULL,
    [drvZipCode_2] varchar(8000) NULL,
    [drvDOB_2] varchar(8) NULL,
    [drvODOH_2] varchar(8) NULL,
    [drvADOH_2] varchar(1) NOT NULL,
    [drvMaritalStatus_2] varchar(1) NOT NULL,
    [drvGender_2] varchar(1) NULL,
    [drvEmplStatus_2] varchar(2) NOT NULL,
    [drvEmplStatusDate_2] varchar(8) NULL,
    [drvFrequency_2] varchar(1) NULL,
    [drvHrsOfService_2] varchar(1) NOT NULL,
    [drvCurHrs_2] varchar(6) NULL,
    [drvCurGross_2] varchar(15) NULL,
    [drvCurEligGross_2] varchar(15) NULL,
    [drvCurW2Taxable_2] varchar(11) NULL,
    [drvCurHrs_2NOP] decimal NOT NULL,
    [drvCurGross_2NOP] decimal NULL,
    [drvCurEligGross_2NOP] decimal NULL,
    [drvCurW2Taxable_2NOP] money NOT NULL,
    [drvAnniversary_2] varchar(1) NOT NULL,
    [drvAnniversaryHrs_2] varchar(1) NOT NULL,
    [drvPayDate_2] varchar(8) NULL,
    [drvEmpIDCode_2] varchar(10) NULL,
    [drvDivSub_2] varchar(10) NULL,
    [drvERLocCode_2] varchar(20) NULL,
    [drvLocEffDate_2] varchar(1) NOT NULL,
    [drvGroupInd_2] varchar(1) NOT NULL,
    [drvNeverElig_2] varchar(1) NOT NULL,
    [drvEligEESources_2] varchar(1) NOT NULL,
    [drvEligERSources_2] varchar(1) NOT NULL,
    [drvEligDate_2] varchar(1) NOT NULL,
    [drvAutoEnroll_2] varchar(1) NOT NULL,
    [drvDefRate_2] varchar(1) NOT NULL,
    [drvCashBonus_2] varchar(1) NOT NULL,
    [drvHCEInd_2] varchar(1) NOT NULL,
    [drvUnionEE_2] varchar(1) NOT NULL,
    [drvMarketSal_2] varchar(11) NULL,
    [drvMarketSal_2NOP] money NOT NULL,
    [drvRehireDate_2] varchar(8) NULL,
    [drvYTDGross_2] varchar(15) NULL,
    [drvDefLimitComp_2] varchar(15) NULL,
    [drvYTDGross_2NOP] decimal NULL,
    [drvDefLimitComp_2NOP] decimal NULL,
    [drvCurEligGrossSource2_2] varchar(1) NOT NULL,
    [drvADPPlanComp_2] varchar(1) NOT NULL,
    [drvCurEligGrossSource3_2] varchar(1) NOT NULL,
    [drvERMatchComp_2] varchar(1) NOT NULL,
    [drvACPComp_2] varchar(1) NOT NULL,
    [drvExclComp_2] varchar(1) NOT NULL,
    [drv401A_2] varchar(1) NOT NULL,
    [drvEEPostComp_2] varchar(1) NOT NULL,
    [drvSubStatus_2] varchar(2) NULL,
    [drvSubStatusDate_2] varchar(8) NULL,
    [drvEmail_2] varchar(50) NULL
);

-----------
-- Create table U_EPRUDTTT_drvTbl_D30
-----------

IF OBJECT_ID('U_EPRUDTTT_drvTbl_D30') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_drvTbl_D30] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvDedGroupCode] char(5) NULL,
    [Pretax] decimal NOT NULL,
    [Roth] decimal NOT NULL,
    [CurHrs] decimal NOT NULL,
    [CurGross] decimal NOT NULL,
    [CurEligGross] decimal NOT NULL,
    [CurW2Taxable] money NOT NULL,
    [YTDGross] decimal NOT NULL,
    [DefLimitComp] decimal NOT NULL,
    [PreTaxMatch] decimal NOT NULL,
    [drvPlanNumber_3] varchar(6) NOT NULL,
    [drvSSN_3] char(11) NULL,
    [drvPretax_3] varchar(9) NULL,
    [drvPretaxMatch_3] varchar(9) NULL,
    [drvRoth_3] varchar(9) NULL,
    [drvPretax_3NOP] decimal NOT NULL,
    [drvPretaxMatch_3NOP] decimal NOT NULL,
    [drvRoth_3NOP] decimal NOT NULL,
    [drvInvestment3_3] varchar(1) NOT NULL,
    [drvSource4_3] varchar(1) NOT NULL,
    [drvContAmt4_3] varchar(1) NOT NULL,
    [drvInvestment4_3] varchar(1) NOT NULL,
    [drvSource5_3] varchar(1) NOT NULL,
    [drvContAmt5_3] varchar(1) NOT NULL,
    [drvInvestment5_3] varchar(1) NOT NULL,
    [drvSource6_3] varchar(1) NOT NULL,
    [drvContAmt6_3] varchar(1) NOT NULL,
    [drvPeriodEnd_3] varchar(8) NULL,
    [drvInsiderTrader_3] varchar(1) NOT NULL,
    [drvSubPlanNumber_3] varchar(4) NULL,
    [drvName_3] varchar(204) NULL,
    [drvAddress1_3] varchar(255) NULL,
    [drvAddress2_3] varchar(255) NULL,
    [drvCity_3] varchar(255) NULL,
    [drvState_3] varchar(255) NULL,
    [drvZipCode_3] varchar(8000) NULL,
    [drvDOB_3] varchar(8) NULL,
    [drvODOH_3] varchar(8) NULL,
    [drvADOH_3] varchar(1) NOT NULL,
    [drvMaritalStatus_3] varchar(1) NOT NULL,
    [drvGender_3] varchar(1) NULL,
    [drvEmplStatus_3] varchar(2) NOT NULL,
    [drvEmplStatusDate_3] varchar(8) NULL,
    [drvFrequency_3] varchar(1) NULL,
    [drvHrsOfService_3] varchar(1) NOT NULL,
    [drvCurHrs_3] varchar(6) NULL,
    [drvCurGross_3] varchar(15) NULL,
    [drvCurEligGross_3] varchar(15) NULL,
    [drvCurW2Taxable_3] varchar(11) NULL,
    [drvCurHrs_3NOP] decimal NOT NULL,
    [drvCurGross_3NOP] decimal NOT NULL,
    [drvCurEligGross_3NOP] decimal NULL,
    [drvCurW2Taxable_3NOP] money NOT NULL,
    [drvAnniversary_3] varchar(1) NOT NULL,
    [drvAnniversaryHrs_3] varchar(1) NOT NULL,
    [drvPayDate_3] varchar(8) NULL,
    [drvEmpIDCode_3] varchar(10) NULL,
    [drvDivSub_3] varchar(10) NULL,
    [drvERLocCode_3] varchar(20) NULL,
    [drvLocEffDate_3] varchar(1) NOT NULL,
    [drvGroupInd_3] varchar(1) NOT NULL,
    [drvNeverElig_3] varchar(1) NOT NULL,
    [drvEligEESources_3] varchar(1) NOT NULL,
    [drvEligERSources_3] varchar(1) NOT NULL,
    [drvEligDate_3] varchar(1) NOT NULL,
    [drvAutoEnroll_3] varchar(1) NOT NULL,
    [drvDefRate_3] varchar(1) NOT NULL,
    [drvCashBonus_3] varchar(1) NOT NULL,
    [drvHCEInd_3] varchar(1) NOT NULL,
    [drvUnionEE_3] varchar(1) NOT NULL,
    [drvMarketSal_3] varchar(11) NULL,
    [drvMarketSal_3NOP] money NOT NULL,
    [drvRehireDate_3] varchar(10) NULL,
    [drvYTDGross_3] varchar(15) NULL,
    [drvDefLimitComp_3] varchar(15) NULL,
    [drvYTDGross_3NOP] decimal NULL,
    [drvDefLimitComp_3NOP] decimal NULL,
    [drvCurEligGrossSource2_3] varchar(1) NOT NULL,
    [drvADPPlanComp_3] varchar(1) NOT NULL,
    [drvCurEligGrossSource3_3] varchar(1) NOT NULL,
    [drvERMatchComp_3] varchar(1) NOT NULL,
    [drvACPComp_3] varchar(1) NOT NULL,
    [drvExclComp_3] varchar(1) NOT NULL,
    [drv401A_3] varchar(1) NOT NULL,
    [drvEEPostComp_3] varchar(1) NOT NULL,
    [drvSubStatus_3] varchar(2) NULL,
    [drvSubStatusDate_3] varchar(8) NULL,
    [drvEmail_3] varchar(50) NULL
);

-----------
-- Create table U_EPRUDTTT_drvTbl_D40
-----------

IF OBJECT_ID('U_EPRUDTTT_drvTbl_D40') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_drvTbl_D40] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvDedGroupCode] char(5) NULL,
    [LoanAmt] decimal NULL,
    [drvPlanNumberLoan] varchar(6) NOT NULL,
    [drvSSNLoan] char(11) NULL,
    [drvLoanNumber] varchar(max) NULL,
    [drvLoanAmt] varchar(9) NULL,
    [drvLoanAmtNOP] decimal NOT NULL,
    [drvSubPlanLoan] varchar(4) NULL
);

-----------
-- Create table U_EPRUDTTT_drvTbl_D50
-----------

IF OBJECT_ID('U_EPRUDTTT_drvTbl_D50') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_drvTbl_D50] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvDedGroupCode] char(5) NULL,
    [LoanAmt] decimal NULL,
    [drvPlanNumberLoan_2] varchar(6) NOT NULL,
    [drvSSNLoan_2] char(11) NULL,
    [drvLoanNumber_2] varchar(max) NULL,
    [drvLoanAmt_2] varchar(9) NULL,
    [drvLoanAmt_2NOP] decimal NOT NULL,
    [drvSubPlanLoan_2] varchar(4) NULL
);

-----------
-- Create table U_EPRUDTTT_drvTbl_D60
-----------

IF OBJECT_ID('U_EPRUDTTT_drvTbl_D60') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_drvTbl_D60] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvDedGroupCode] char(5) NULL,
    [LoanAmt] decimal NULL,
    [drvPlanNumberLoan_3] varchar(6) NOT NULL,
    [drvSSNLoan_3] char(11) NULL,
    [drvLoanNumber_3] varchar(max) NULL,
    [drvLoanAmt_3] varchar(9) NULL,
    [drvLoanAmt_3NOP] decimal NOT NULL,
    [drvSubPlanLoan_3] varchar(4) NULL
);

-----------
-- Create table U_EPRUDTTT_EEList
-----------

IF OBJECT_ID('U_EPRUDTTT_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPRUDTTT_File
-----------

IF OBJECT_ID('U_EPRUDTTT_File') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EPRUDTTT_Header_H01
-----------

IF OBJECT_ID('U_EPRUDTTT_Header_H01') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_Header_H01] (
    [drvClientID] varchar(6) NOT NULL,
    [drvCreateDate] varchar(8) NULL,
    [drvCreateTime] varchar(6) NULL
);

-----------
-- Create table U_EPRUDTTT_Header_H02
-----------

IF OBJECT_ID('U_EPRUDTTT_Header_H02') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_Header_H02] (
    [drvClientID2] varchar(6) NOT NULL,
    [drvCreateDate2] varchar(8) NULL,
    [drvCreateTime2] varchar(6) NULL
);

-----------
-- Create table U_EPRUDTTT_Header_H03
-----------

IF OBJECT_ID('U_EPRUDTTT_Header_H03') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_Header_H03] (
    [drvClientID3] varchar(6) NOT NULL,
    [drvCreateDate3] varchar(8) NULL,
    [drvCreateTime3] varchar(6) NULL
);

-----------
-- Create table U_EPRUDTTT_LOASubStatus
-----------

IF OBJECT_ID('U_EPRUDTTT_LOASubStatus') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_LOASubStatus] (
    [subLOAEEID] char(12) NULL,
    [subLOACOID] char(5) NULL,
    [subLOASubStatus] varchar(2) NULL,
    [subLOASubStatusDate] varchar(8) NULL
);

-----------
-- Create table U_EPRUDTTT_PDedHist
-----------

IF OBJECT_ID('U_EPRUDTTT_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource1] decimal NULL,
    [PdhSource2] decimal NULL,
    [PdhSource3] decimal NULL,
    [PdhSource4] decimal NULL,
    [PdhSource6] decimal NULL
);

-----------
-- Create table U_EPRUDTTT_PDedHist_YTD
-----------

IF OBJECT_ID('U_EPRUDTTT_PDedHist_YTD') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_PDedHist_YTD] (
    [YTDEEID] char(12) NOT NULL,
    [YTDPdhSource4] decimal NULL
);

-----------
-- Create table U_EPRUDTTT_PEarHist
-----------

IF OBJECT_ID('U_EPRUDTTT_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] decimal NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] decimal NULL,
    [PehInclInDefComp] decimal NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] decimal NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EPRUDTTT_RLSubStatus
-----------

IF OBJECT_ID('U_EPRUDTTT_RLSubStatus') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_RLSubStatus] (
    [subRLEEID] varchar(255) NOT NULL,
    [subRLSubStatus] varchar(2) NOT NULL,
    [subRLSubStatusDate] datetime NOT NULL
);

-----------
-- Create table U_EPRUDTTT_Sign
-----------

IF OBJECT_ID('U_EPRUDTTT_Sign') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_Sign] (
    [sValue] varchar(2) NULL,
    [sDigit] varchar(1) NULL
);

-----------
-- Create table U_EPRUDTTT_SubStatus
-----------

IF OBJECT_ID('U_EPRUDTTT_SubStatus') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_SubStatus] (
    [subEEID] varchar(255) NOT NULL,
    [subSubStatus] varchar(2) NOT NULL
);

-----------
-- Create table U_EPRUDTTT_TaxWages
-----------

IF OBJECT_ID('U_EPRUDTTT_TaxWages') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_TaxWages] (
    [PthTaxCode] char(8) NOT NULL,
    [PthEEID] char(12) NOT NULL,
    [PthCurFITWages] money NULL
);

-----------
-- Create table U_EPRUDTTT_Trailer_T90
-----------

IF OBJECT_ID('U_EPRUDTTT_Trailer_T90') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_Trailer_T90] (
    [drvClientIDTrl] varchar(10) NULL,
    [drvCreationDateTrl] varchar(8) NULL,
    [drvCreationTimeTrl] varchar(6) NULL,
    [drvRecordCount] int NULL,
    [drvTotalCont] varchar(11) NULL,
    [drvTotalLoanAmt] varchar(11) NULL
);

-----------
-- Create table U_EPRUDTTT_Trailer_T91
-----------

IF OBJECT_ID('U_EPRUDTTT_Trailer_T91') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_Trailer_T91] (
    [drvClientIDTrl_2] varchar(10) NULL,
    [drvCreationDateTrl_2] varchar(8) NULL,
    [drvCreationTimeTrl_2] varchar(6) NULL,
    [drvRecordCount_2] int NULL,
    [drvTotalCont_2] varchar(11) NULL,
    [drvTotalLoanAmt_2] varchar(11) NULL
);

-----------
-- Create table U_EPRUDTTT_Trailer_T92
-----------

IF OBJECT_ID('U_EPRUDTTT_Trailer_T92') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTT_Trailer_T92] (
    [drvClientIDTrl_3] varchar(10) NULL,
    [drvCreationDateTrl_3] varchar(8) NULL,
    [drvCreationTimeTrl_3] varchar(6) NULL,
    [drvRecordCount_3] int NULL,
    [drvTotalCont_3] varchar(11) NULL,
    [drvTotalLoanAmt_3] varchar(11) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EPRUDTTT]
AS
SET NOCOUNT ON;
/************************************************************
Client: Rollins Inc

Created By: Robert Dulaney
Create Date: 07/13/2018

Purpose: GENERATE MULTIPLE FILES WITH CUSTOM BCP STATEMENT

Revision History
----------------
Update By    Date    Request Num    Desc
XXXX         XX/XX/18    SR-2018-00XXXXXX    XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRUDTTT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRUDTTT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRUDTTT';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EPRUDTTT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRUDTTT' ORDER BY RunID DESC;

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTT', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTT', 'TEST';
************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE @FormatCode      VARCHAR(10)
        ,@ExportCode         VARCHAR(10)
        ,@ExportPath         VARCHAR(500)
        ,@dbName             VARCHAR(50)
        ,@NoEmpty            CHAR(1)
        ,@sCmd               VARCHAR(1000)
        ,@QueryInfo          VARCHAR(1000)
        ,@RowCount           INT;

    -- Set variables
    SET @FormatCode = 'EPRUDTTT';

    SELECT @ExportCode = ExportCode
       ,@ExportPath = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'IsUTF8') = 'Y' THEN dbo.dsi_fnVariable(@FormatCode,'UTF8Path') -- If using UTF8 Converter, then use UTF8Path instead of ExportPath
                           WHEN (@ExportCode LIKE '%TEST%' OR @ExportCode LIKE '%TST%' OR dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y') AND dbo.dsi_fnVariable(@FormatCode,'TestPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'TestPath')
                           WHEN @ExportCode LIKE '%OE%' AND dbo.dsi_fnVariable(@FormatCode,'OEPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'OEPath')
                           WHEN @ExportCode IN ('ONDEMAND','ON_DEMAND') AND dbo.dsi_fnVariable(@FormatCode,'OnDemandPath') IS NOT NULL THEN dbo.dsi_fnVariable(@FormatCode,'OnDemandPath')
                           ELSE dbo.dsi_fnVariable(@FormatCode,'ExportPath')
                      END
       ,@dbName     = RTRIM(DB_NAME())
       ,@NoEmpty    = dbo.dsi_fnVariable(FormatCode,'NoEmpty')
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    -- =================================================
    -- Define Filenames By Header & Detail ID in File
    -- =================================================

    DECLARE @FilesOut AS TABLE
    (
         RowID                INT IDENTITY(1,1)
        ,RecordSetGroup      VARCHAR(100)
        ,CustomFileName      VARCHAR(1000)
    );

    INSERT INTO @FilesOut (RecordSetGroup, CustomFileName)
    SELECT RecordSetGroup = 'H01,D10,D40,T90', CustomFileName = 'C006974.txt'  -- Rollins File
    UNION ALL
    SELECT RecordSetGroup = 'H02,D20,D50,T91', CustomFileName = 'C006976.txt'  -- Western File
    UNION ALL
    SELECT RecordSetGroup = 'H03,D30,D60,T92', CustomFileName = 'C010010.txt' -- Waltham File
    UNION ALL
    SELECT RecordSetGroup = 'H04,D15,D45', CustomFileName = 'Rollins_Review_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'  -- Rollins File
    UNION ALL
    SELECT RecordSetGroup = 'H04,D25,D55', CustomFileName = 'Western_Review_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'  -- Western File
    UNION ALL
    SELECT RecordSetGroup = 'H04,D35,D65', CustomFileName = 'Waltham_Review_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'; -- Waltham File



    SET @RowCount = (SELECT COUNT(*) FROM @FilesOut);

    -- ==================================================    
    -- Generate Multiple Files via Custom BCP statement:
    -- ==================================================    
    -- Declare variables
    DECLARE  @RecordSetGroup  VARCHAR(100)
        ,@FileName            VARCHAR(100)
        ,@LoopCount           INT;

    SET @LoopCount = 1;

    -- Begin Process of Exporting Multiple Files
    WHILE @LoopCount <= @RowCount
    BEGIN

    -- Set FileName to Export Based On Record Set Group (Header,Detail,Trailer Records)
    SELECT 
         @RecordSetGroup = RecordSetGroup
        ,@FileName = CustomFileName
    FROM @FilesOut
    WHERE RowID = @LoopCount;

    -- Set Query To Be Exported
    SET @QueryInfo = '"SELECT TOP 2000000 Data FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File WITH (NOLOCK) '
                        + 'WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''') '
                        + 'ORDER BY RIGHT(RECORDSET,2), InitialSort, SubSort"';

    -- Set Custom BCP Statement
    SELECT @sCmd = 'BCP ' + @QueryInfo + ' QUERYOUT "' + @ExportPath + @FileName +'"' + 
              ' -S"' + RTRIM(@@SERVERNAME) + '" -T -c';
    
    IF (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y')
    BEGIN
        PRINT 'Custom BCP For File# ' + CONVERT(VARCHAR(2),@LoopCount) + ': ' + ISNULL(@FileName,'');
        PRINT 'Custom BCP Statement: ' + ISNULL(@sCmd,'');
    END;

    -- Get Record Count
    DECLARE @RecordCnt INT, @Query NVARCHAR(1000);
    SET @Query = N'SELECT @RecordCount = COUNT(*) FROM '+ RTRIM(DB_NAME()) + '.dbo.U_' + @FormatCode + '_File WITH (NOLOCK) WHERE RECORDSET IN (''' + REPLACE(@RecordSetGroup,',',''',''') + ''')';
    EXECUTE master.dbo.sp_executesql @Query, N'@RecordCount INT OUTPUT',  @RecordCount = @RecordCnt OUTPUT;

    IF @RecordCnt = 0 AND @NoEmpty = 'Y'
    BEGIN
        IF (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y')
        BEGIN
            PRINT 'There are no records in the file, so no file will be created.'
        END
    END ELSE BEGIN
        -- Output File
        EXEC master.dbo.xp_cmdshell @sCmd, NO_OUTPUT;
    END;

    -- Get Next FileName
    SET @LoopCount = @LoopCount + 1;

    END;

END;
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDTTT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rollins Inc

Created By: Robert Dulaney
Business Analyst: Patrick Clare
Create Date: 07/13/2018
Service Request Number: SR-2017-00177851

Purpose: Prudential 401K Export

Revision History
----------------
Update By           Date           Request Num                Desc
Nicci Blady         05/30/2019     SR-2019-00234349           Updates to formatting, selection criteria
Anthony Ramos       10/15/2019     SF 15656661                Updated overpunch join
Cyndi Diaz          05/21/2020     SR-2020-00271189           Migrated from CLA1016 - Clark Pest Control of Stockton, Inc. 
David Miller        11/24/2020     SR-2020-00293386           Add deduction group NWEST, update loan number logic, update LOA date logic
Darren Collard      12/08/2021     TekP-2021-10-11-0002       Update Investment, Source2 and include 401KM 

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRUDTTT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRUDTTT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRUDTTT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRUDTTT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRUDTTT' ORDER BY RunID DESC;

--Update Drive Mappings in U_DSI_Configuration
---------------------------------------------------
SELECT * FROM dbo.U_DSI_Configuration WHERE cfgname like '%path%' order by 4
--TEST--
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\nz\Public\ROL1002\Exports_Test\Prudential_401K_Export\' WHERE formatcode = 'EPRUDTTT' AND cfgname = 'ExportPath';
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\nz\Public\ROL1002\Exports_Test\Prudential_401K_Export\' WHERE formatcode = 'EPRUDTTT' AND cfgname = 'TestPath';
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\nz\Public\ROL1002\Exports_Test\Prudential_401K_Export\' WHERE formatcode = 'EPRUDTTT' AND cfgname = 'UDESPath';

--PROD--
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\nz\Public\ROL1002\Exports_Test\Prudential_401K_Export\' WHERE formatcode = 'EPRUDTTT' AND cfgname = 'ExportPath';
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\nz\Public\ROL1002\Exports_Test\Prudential_401K_Export\' WHERE formatcode = 'EPRUDTTT' AND cfgname = 'TestPath';
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\nz\Public\ROL1002\Exports_Test\Prudential_401K_Export\' WHERE formatcode = 'EPRUDTTT' AND cfgname = 'UDESPath';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTT', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTT', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRUDTTT';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPRUDTTT', @AllObjects = 'Y', @IsWeb = 'N';

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
            ,@RunTime           VARCHAR(6)
            ,@RunDate           VARCHAR(8)
            ;

    -- Set FormatCode
    SELECT @FormatCode = 'EPRUDTTT';
    SELECT @RunTime    = REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), ':', '');
    SELECT @RunDate    = CONVERT(VARCHAR(8),GETDATE(),112);

    --SELECT @RunTime,@RunDate

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
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EPRUDTTT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRUDTTT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Cleans EE List of Where EecUDField14 = 'Y'
    DELETE FROM dbo.U_EPRUDTTT_EEList
    WHERE xEEID IN (SELECT EecEEID FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecUDField14 = 'Y');

    -- Cleans EE List with EEs in the Ded Group DG01,DG02,NONE,NOBEN,DG03 
    DELETE FROM dbo.U_EPRUDTTT_EEList
    WHERE xEEID IN (SELECT EecEEID FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecDedGroupCode IN ('DG01','DG02','NONE','NOBEN','DG03'));

    -- Cleans out EEs terminated more than 18 months ago
    --DELETE FROM dbo.U_EPRUDTTT_EEList
    --WHERE xEEID IN (SELECT EecEEID FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecDateOfTermination < DATEADD(MONTH,-18,@EndDate))     --SR-2019-00234349 05/30/2019

    -- Cleans out Test Employees
    DELETE FROM dbo.U_EPRUDTTT_EEList
    WHERE xEEID IN (SELECT EepEEID FROM dbo.EmpPers WITH (NOLOCK) WHERE EepNameLast = 'Hiring Manager')   --6/24 - remove OR EepNameLast = 'MANAGER' per Eric Sweet

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EPRUDTTT_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_AuditFields;
    CREATE TABLE dbo.U_EPRUDTTT_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EPRUDTTT_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EPRUDTTT_AuditFields VALUES ('EmpComp','EecEmplStatusStartDate');
    INSERT INTO dbo.U_EPRUDTTT_AuditFields VALUES ('EmpComp','EecDateOfTermination');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EPRUDTTT_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_Audit;
    SELECT 
         audEEID = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EPRUDTTT_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EPRUDTTT_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';


    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EPRUDTTT_Audit ON dbo.U_EPRUDTTT_Audit (audEEID,audKey2);

    --==========================================
    -- Create List of Sub Status Codes
    --==========================================
    IF OBJECT_ID('U_EPRUDTTT_RLSubStatus','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_RLSubStatus;
    SELECT DISTINCT
          subRLEEID = audEEID
         ,subRLSubStatus = 'RL'
         ,subRLSubStatusDate = audDateTime
    INTO dbo.U_EPRUDTTT_RLSubStatus
    FROM dbo.U_EPRUDTTT_Audit
    WHERE audFieldName = 'EecEmplStatus'
        AND audOldValue = 'L'
        AND audNewValue = 'A'
        AND audRowNo = 1
    ;
    
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401K,401KC,RPBK,RCUBK,G401K,G401C,GPBK,GCUBK,W401K,W401C,WPBK,WCUBK,ROTH,ROTHC,RRBK,RRCUB,GRBK
                    ,GRCUB,GROTH,GRTCU,WRBK,WRCUB,WROTH,WRTHC,401KL,G401L,401L2,GLNBK,RLNBK,W401L,WLNBK,G401M,W401M,401KM,DCSAL,DCBON';

    IF OBJECT_ID('U_EPRUDTTT_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPRUDTTT_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item
    ;

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedTypes','DEF,LON');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','ActiveOnly');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    UPDATE dbo.U_dsi_BDM_EmpDeductions
        SET  EedValidForExport = 'Y'
    FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    JOIN dbo.U_EPRUDTTT_PDedHist WITH (NOLOCK)
        ON PdhEEID = EedEEID
    WHERE DedDedType = 'LON'
    AND PdhSource3 <> 0.00
    AND EedValidForExport = 'N'
    AND EedFormatCode = @FormatCode
    AND EedStopdate >= @StartDate
    ;

    --==========================================
    -- Build Working Tables
    --==========================================

IF OBJECT_ID('U_EPRUDTTT_Sign','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_Sign;
CREATE TABLE dbo.U_EPRUDTTT_Sign (sValue VARCHAR(2), sDigit VARCHAR(1))
    --positives
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('1','A')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('2','B')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('3','C')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('4','D')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('5','E')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('6','F')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('7','G')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('8','H')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('9','I')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('0','{')
    --negatives
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('-1','J')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('-2','K')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('-3','L')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('-4','M')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('-5','N')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('-6','O')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('-7','P')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('-8','Q')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('-9','R')
    INSERT INTO dbo.U_EPRUDTTT_Sign VALUES ('-0','}')
;

-- select * from dbo.U_EPRUDTTT_Sign

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --Convert Pdh values to DECIMAL(12,2) values
    IF OBJECT_ID('U_EPRUDTTT_PDedHist','U') IS NOT NULL
            DROP TABLE dbo.U_EPRUDTTT_PDedHist;
     SELECT DISTINCT
         PdhEEID
        -- EE Cur Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K','401KC','RPBK','RCUBK','G401K','G401C','GPBK','GCUBK','W401K','W401C','WPBK','WCUBK') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- EE Pretax
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH','ROTHC','RRBK','RRCUB','GRBK','GRCUB','GROTH','GRTCU','WRBK','WRCUB','WROTH','WRTHC') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- Roth Ded
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('401KL','G401L','401L2','GLNBK','RLNBK','W401L','WLNBK') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- EE LOAN AMOUNTS
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('DCSAL','DCBON') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- ADP Test Pay / DC Covered Pay
        -- ER Cur Match Amounts
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('G401M','W401M','401KM') THEN ISNULL(CONVERT(DECIMAL(12,2), PdhERCurAmt), 0) ELSE 0.00 END) -- ER Pretax Match
    INTO dbo.U_EPRUDTTT_PDedHist  --select * from dbo.U_EPRUDTTT_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRUDTTT_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00           --SR-2019-00234349 05/30/2019
    --    OR SUM(PdhERCurAmt) <> 0.00
    --)
    ;

    IF OBJECT_ID('U_EPRUDTTT_PDedHist_YTD','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_PDedHist_YTD;
    SELECT DISTINCT
         YTDEEID           = PdhEEID
        -- YTD EE Cur Amounts
        ,YTDPdhSource4     = SUM(CASE WHEN PdhDedCode IN ('DCSAL','DCBON') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- ADP Test Pay / DC Covered Pay
    INTO dbo.U_EPRUDTTT_PDedHist_YTD
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRUDTTT_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00            --SR-2019-00234349 05/30/2019
    --    OR SUM(PdhERCurAmt) <> 0.00
    --)
    ;

    -----------------------------
    -- Working Table - Taxable Wages
    -----------------------------
    IF OBJECT_ID('U_EPRUDTTT_TaxWages','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_TaxWages;
    SELECT 
        PthTaxCode = PthTaxCode,
        PthEEID = PthEEID,
        PthCurFITWages = SUM(PthCurTaxableWages)
    INTO dbo.U_EPRUDTTT_TaxWages
    FROM dbo.vw_int_PayReg
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PthGenNumber = PrgGenNumber
        AND PthTaxCode = 'USFIT'
    WHERE PrgPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PthTaxCode,PthEEID
    ;

    -----------------------------
    -- Working Table - vw_int_PEarHist
    -----------------------------
    IF OBJECT_ID('U_EPRUDTTT_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode <> 'SEV' THEN CONVERT(DECIMAL(12,2), PehCurAmt) ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount
        ,PehCurAmtYTD           = SUM(CASE WHEN PehEarnCode <> 'SEV' THEN CONVERT(DECIMAL(12,2), PehCurAmt) ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehEarnCode <> 'SEV' AND PehPerControl >= @StartPerControl THEN CONVERT(DECIMAL(12,2), PehCurAmt) ELSE 0.00 END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN CONVERT(DECIMAL(12,2), PehCurAmt) ELSE 0.00 END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs ELSE 0.00 END)
    INTO dbo.U_EPRUDTTT_PEarHist  --select * from dbo.U_EPRUDTTT_PEarHist where pehcuramt < 0.00
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
        AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    --HAVING SUM(PehCurAmt) <> 0.00;        --SR-2019-00234349 05/30/2019
    ;

    -----------------------------
    -- Working Table - LOA Eff Date
    -----------------------------
    -- Get LOA Effective Date:  When emp previously on leave and changes leave type (e.g. Goes from Medical FMLA to Medical Non-FMLA), grab date emp first went on leave.
    --                            When emp status change to 'L' is keyed during date range of file, but is not "original loa date (e.g. just changing leave types), populate original loa date
    --                            When emp status changes to 'L' keyed in during date range of file and is first time emp has had 'L' status, populate audDate
    IF OBJECT_ID('U_EPRUDTTT_LOASubStatus','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_LOASubStatus;
    SELECT DISTINCT
          subLOAEEID = xEEID
         ,subLOACOID = xCOID
         ,subLOASubStatus = CASE WHEN OriginalLOADate <= @EndDate OR audDateTime IS NOT NULL THEN 'UL' END
         ,subLOASubStatusDate = CASE WHEN OriginalLOADate <= @EndDate THEN CONVERT(VARCHAR(8),OriginalLOADate,112)
                                     WHEN audDateTime IS NOT NULL THEN CONVERT(VARCHAR(8),audDateTime,112)
                                END
    INTO dbo.U_EPRUDTTT_LOASubStatus
    FROM dbo.U_EPRUDTTT_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.U_EPRUDTTT_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audFieldName = 'EecEmplStatus'
        AND audOldValue = 'A'
        AND audNewValue = 'L'
        AND audRowNo = 1
        AND audAction = 'UPDATE'
    LEFT JOIN (SELECT EhcEEID, EhcCOID, OriginalLOADate = MIN(EhcEmplStatusStartDate) 
                FROM dbo.EmpHComp Orig (NOLOCK)
                WHERE EhcEmplStatus = 'L'AND NOT EXISTS (Select 1 from dbo.emphcomp helper (NOLOCK) where helper.ehceeid = orig.ehceeid and helper.ehccoid = orig.ehccoid --DM 12/11/20
                and helper.ehcemplstatus <> 'L' and helper.ehcEmplStatusStartDate > orig.EhcEmplStatusStartDate)
                GROUP BY EhcEEId, EhcCOID) ttl1
        ON EhcEEID = xEEID
        AND EhcCOID = xCOID
    WHERE EecEmplStatus = 'L'
    ;

    DECLARE @PayDate DATE;
    SELECT @PayDate = MAX(PrgPayDate) FROM dbo.U_EPRUDTTT_PEarHist WITH (NOLOCK);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDTTT_drvTbl_D10 and U_EPRUDTTT_drvTbl_D15 - DEFERRAL DETAIL - ROLLINS
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_drvTbl_D10','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_drvTbl_D10;

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = EepSSN
        ,drvDedGroupCode = EecDedGroupCode
        ,Pretax = ISNULL(PdhSource1,0)
        ,Roth = ISNULL(PdhSource2,0)
        ,CurHrs = ISNULL(PehCurHrs,0)
        ,CurGross = ISNULL(PehCurAmt,0)
        ,CurEligGross = ISNULL(PehCurAmt - PdhSource4,0)
        ,CurW2Taxable = ISNULL(PthCurFITWages,0)
        ,YTDGross = ISNULL(PehCurAmtYTD,0)
        ,PreTaxMatch = ISNULL(PdhSource6,0)
        ,DefLimitComp = ISNULL(PehInclInDefCompYTD - YTDPdhSource4,0)
        ,drvPretaxMatch_2   = RIGHT(LEFT(REPLACE(CAST(dbo.dsi_fnPadZero(ISNULL(PdhSource6,0)*100,9,0) AS VARCHAR(9)),'-','0'),8) + PdhMS.sDigit,9) --SR-2019-00234349 05/30/2019
        ,drvPretaxMatch_2NOP   = ISNULL(PdhSource6,0)
        --,PreTaxMatch = PdhSource6
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '006974'
        ,drvSSN2 = EepSSN
        ,drvPretax  = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(9),(dbo.dsi_fnPadZero(ISNULL(PdhSource1,0)*100,9,0))),'-','0'),8) + PdhPTS.sDigit,9) --SR-2019-00234349 05/30/2019
        ,drvRoth    = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(9),(dbo.dsi_fnPadZero(ISNULL(PdhSource2,0)*100,9,0))),'-','0'),8) + PdhRS.sDigit,9) --SR-2019-00234349 05/30/2019
        ,drvPretaxNOP  = ISNULL(PdhSource1,0)
        ,drvRothNOP    = ISNULL(PdhSource2,0)
        ,drvInvestment3 = ''
        ,drvSource4 = ''
        ,drvContAmt4 = ''
        ,drvInvestment4 = ''
        ,drvSource5 = ''
        ,drvContAmt5 = ''
        ,drvInvestment5 = ''
        ,drvSource6 = ''
        ,drvContAmt6 = ''
        ,drvPeriodEnd = CONVERT(VARCHAR(8), @EndDate, 112)
        ,drvInsiderTrader = CASE CONVERT(VARCHAR(10), EepUDField13)
                                WHEN 'O' THEN 'O'
                                WHEN 'B' THEN 'B'
                                ELSE ' '
                            END
        ,drvSubPlanNumber = CASE
                                WHEN EecFullTimeOrPartTime = 'F' THEN '0001'
                                WHEN EecFullTimeOrPartTime = 'P' THEN '0002'
                            END
        ,drvName = EepNameLast + ', ' + EepNameFirst + ' ' + ISNULL(LEFT(EepNameMiddle,1),'')        
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = REPLACE(EepAddressZipCode,'-','')
        ,drvDOB = CONVERT(VARCHAR(8), EepDateOfBirth, 112)
        ,drvODOH = CONVERT(VARCHAR(8), EecDateOfOriginalHire, 112)
        ,drvADOH = ''
        ,drvMaritalStatus = ''
        ,drvGender = CASE EepGender 
                        WHEN 'F' THEN '2'  
                        WHEN 'M' THEN '1' 
                     END
        ,drvEmplStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN
                                CASE
                                    WHEN EecTermReason = '202' THEN '22'
                                    WHEN EecTermReason = '203' THEN '3D'
                                    ELSE '32'
                                END
                            WHEN EecEmplStatus <> 'T' AND EecUDField01 = 'Y' THEN '32'
                            ELSE '00'
                         END
        ,drvEmplStatusDate = CASE
                                WHEN EecEmplStatus <> 'T' AND EecUDField01 = 'Y' THEN CONVERT(VARCHAR(8), EecUDField07, 112)
                                WHEN EecEmplStatus = 'L' THEN CONVERT(VARCHAR(8), EecDateOfLastHire, 112)       --06/11/19 Updated per client email RE: SR 234349 - NB
                                ELSE CONVERT(VARCHAR(8), EecEmplStatusStartDate, 112)
                             END                                                       
        ,drvFrequency = CASE EecPayPeriod
                            WHEN 'W' THEN '7'
                            WHEN 'B' THEN '6'
                            WHEN 'S' THEN '5'
                            WHEN 'M' THEN '4'
                        END
        ,drvHrsOfService = ''
        ,drvCurHrs          = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(6),dbo.dsi_fnPadZero(ISNULL(PehCurHrs*100,0),6,0)),'-','0'),5) + HrsS.sDigit,6)        --SR-2019-00234349 05/30/2019
        ,drvCurGross        = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CgsS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvCurEligGross    = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CegDlS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvCurW2Taxable    = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(ISNULL(PthCurFITWages,0)*100,11,0)),'-','0'),10) + CurW2S.sDigit,11)    --SR-2019-00234349 05/30/2019
        ,drvCurHrsNOP          = ISNULL(PehCurHrs,0)
        ,drvCurGrossNOP        = ISNULL(PehCurAmt,0)
        ,drvCurEligGrossNOP    = ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)
        ,drvCurW2TaxableNOP    = ISNULL(PthCurFITWages,0)
        ,drvAnniversary = ''
        ,drvAnniversaryHrs = ''
        ,drvPayDate = CONVERT(VARCHAR(8), @PayDate, 112)
        ,drvEmpIDCode = EecOrgLvl3
        ,drvDivSub = EecOrgLvl2
        ,drvERLocCode = LTRIM(RTRIM(CmpImportCode)) + LTRIM(RTRIM(EecOrgLvl1))
        ,drvLocEffDate = ''
        ,drvGroupInd = ''
        ,drvNeverElig = ''
        ,drvEligEESources = ''
        ,drvEligERSources = ''
        ,drvEligDate = ''
        ,drvAutoEnroll = ''
        ,drvDefRate = ''
        ,drvCashBonus = ''
        ,drvHCEInd = ''
        ,drvUnionEE = CASE WHEN EecUnionNational IS NOT NULL THEN 'Y' ELSE 'N' END --EecAnnSalary
        ,drvMarketSal = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(ISNULL(EecAnnSalary,0)*100,11,0)),'-','0'),10)+MarSal.sDigit,11)        --SR-2019-00234349 05/30/2019
        ,drvMarketSalNOP = ISNULL(EecAnnSalary,0)
        ,drvRehireDate = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire THEN CONVERT(VARCHAR(8), EecDateOfLastHire, 112) END
        ,drvYTDGross     = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CgsS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvDefLimitComp = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CegDlS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvYTDGrossNOP     = ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0)
        ,drvDefLimitCompNOP = ISNULL(PehInclInDefCompYTD - YTDPdhSource4,0)
        ,drvCurEligGrossSource2 = ''
        ,drvADPPlanComp = ''
        ,drvCurEligGrossSource3 = ''
        ,drvERMatchComp = ''
        ,drvACPComp = ''
        ,drvExclComp = ''
        ,drv401A = ''
        ,drvEEPostComp = ''
        ,drvSubStatus = CASE
                            WHEN subRLSubStatus = 'RL' THEN 'RL'
                            WHEN subLOASubStatus IS NOT NULL THEN subLOASubStatus
                        END
        ,drvSubStatusDate = CASE
                                WHEN subRLSubStatus = 'RL' THEN CONVERT(VARCHAR(8), subRLSubStatusDate, 112)
                                WHEN subLOASubStatus IS NOT NULL THEN subLOASubStatusDate
                            END
        ,drvEmail = EepAddressEMail
    INTO dbo.U_EPRUDTTT_drvTbl_D10  --select * from dbo.U_EPRUDTTT_drvTbl_D10 order by drveeid
    FROM dbo.U_EPRUDTTT_EEList WITH (NOLOCK)        --select * from dbo.U_EPRUDTTT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK) 
        ON CmpCOID = xCOID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = 'EPRUDTTT' 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_EPRUDTTT_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_PDedHist_YTD WITH (NOLOCK)
        ON YTDEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_RLSubStatus WITH (NOLOCK)
        ON subRLEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_LOASubStatus WITH (NOLOCK)
        ON subLOAEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_TaxWages WITH (NOLOCK)
        ON PthEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_Sign PdhPTS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON PdhPTS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(10)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource1,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(10)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource1,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign PdhRS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON PdhRS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource2,0) AS VARCHAR(10)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource2,0)),1)
                                WHEN LEFT(CAST(ISNULL(PdhSource2,0) AS VARCHAR(10)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource2,0)),1)
                           END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign PdhMS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON PdhMS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource6,0) AS VARCHAR(10)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource6,0)),1)
                                WHEN LEFT(CAST(ISNULL(PdhSource6,0) AS VARCHAR(10)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource6,0)),1)
                           END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign HrsS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON HrsS.sValue = (CASE WHEN LEFT(CAST(FLOOR(ISNULL(PehCurHrs,0)) AS VARCHAR(6)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(6),FLOOR(ISNULL(PehCurHrs,0))),1)
                               WHEN LEFT(CAST(FLOOR(ISNULL(PehCurHrs,0)) AS VARCHAR(6)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(6),FLOOR(ISNULL(PehCurHrs,0))),1)
                          END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign CgsS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON CgsS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0)),1)
                               WHEN LEFT(CAST(ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0)),1)
                          END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign CegDlS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON CegDlS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign CurW2S WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON CurW2S.sValue = (CASE WHEN LEFT(CAST(ISNULL(PthCurFITWages,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PthCurFITWages,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PthCurFITWages,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PthCurFITWages,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign YTDGrS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON YTDGrS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign MarSal WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON MarSal.sValue = (CASE WHEN LEFT(CAST(ISNULL(EecAnnSalary,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(EecAnnSalary,0)),1)
                                 WHEN LEFT(CAST(ISNULL(EecAnnSalary,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(EecAnnSalary,0)),1)
                            END)
    WHERE EecDedGroupCode IN ('HTEAM','ROLLI','RWEST','WALTH','WALTN','ALL','NOBNC','NWEST') --DM 11/24/20 
        AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination >= DATEADD(MM,-18,@EndDate)))
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EPRUDTTT_drvTbl_D20 - DEFERRAL DETAIL - WESTERN
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_drvTbl_D20','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_drvTbl_D20;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = EepSSN
        ,drvDedGroupCode = EecDedGroupCode
        ,Pretax = ISNULL(PdhSource1,0)
        ,Roth = ISNULL(PdhSource2,0)
        ,CurHrs = ISNULL(PehCurHrs,0)
        ,CurGross = ISNULL(PehCurAmt,0)
        ,CurEligGross = ISNULL(PehInclInDefComp - PdhSource4,0)
        ,CurW2Taxable = ISNULL(PthCurFITWages,0)
        ,YTDGross = ISNULL(PehCurAmtYTD,0)
        ,DefLimitComp = ISNULL(PehInclInDefCompYTD - YTDPdhSource4,0)
        ,PreTaxMatch = ISNULL(PdhSource6,0)
        -- standard fields above and additional driver fields below
        ,drvPlanNumber_2 = '006976'
        ,drvSSN_2 = EepSSN
        ,drvPretax_2        = RIGHT(LEFT(REPLACE(CAST(dbo.dsi_fnPadZero(ISNULL(PdhSource1,0)*100,9,0) AS VARCHAR(9)),'-','0'),8) + PdhPTS.sDigit,9) --SR-2019-00234349 05/30/2019
        ,drvPretaxMatch_2   = RIGHT(LEFT(REPLACE(CAST(dbo.dsi_fnPadZero(ISNULL(PdhSource6,0)*100,9,0) AS VARCHAR(9)),'-','0'),8) + PdhMS.sDigit,9) --SR-2019-00234349 05/30/2019
        ,drvRoth_2          = RIGHT(LEFT(REPLACE(CAST(dbo.dsi_fnPadZero(ISNULL(PdhSource2,0)*100,9,0) AS VARCHAR(9)),'-','0'),8) + PdhRS.sDigit,9) --SR-2019-00234349 05/30/2019
        ,drvPretax_2NOP        = ISNULL(PdhSource1,0)
        ,drvPretaxMatch_2NOP   = ISNULL(PdhSource6,0)
        ,drvRoth_2NOP          = ISNULL(PdhSource2,0)
        ,drvInvestment3_2 = ''
        ,drvSource4_2 = ''
        ,drvContAmt4_2 = ''
        ,drvInvestment4_2 = ''
        ,drvSource5_2 = ''
        ,drvContAmt5_2 = ''
        ,drvInvestment5_2 = ''
        ,drvSource6_2 = ''
        ,drvContAmt6_2 = ''
        ,drvPeriodEnd_2 = CONVERT(VARCHAR(8), @EndDate, 112)
        ,drvInsiderTrader_2 = CASE CONVERT(VARCHAR(10), EepUDField13)
                                WHEN 'O' THEN 'O'
                                WHEN 'B' THEN 'B'
                                ELSE ' '
                              END
        ,drvSubPlanNumber_2 = CASE
                                WHEN EecFullTimeOrPartTime = 'F' THEN '0001'
                                WHEN EecFullTimeOrPartTime = 'P' THEN '0002'
                              END
        ,drvName_2 = EepNameLast + ', ' + EepNameFirst + ' ' + ISNULL(LEFT(EepNameMiddle,1),'')
        ,drvAddress1_2 = EepAddressLine1
        ,drvAddress2_2 = EepAddressLine2
        ,drvCity_2 = EepAddressCity
        ,drvState_2 = EepAddressState
        ,drvZipCode_2 = REPLACE(EepAddressZipCode,'-','')
        ,drvDOB_2 =  CONVERT(VARCHAR(8), EepDateOfBirth, 112)
        ,drvODOH_2 = CONVERT(VARCHAR(8), EecDateOfOriginalHire, 112)
        ,drvADOH_2 = ''
        ,drvMaritalStatus_2 = ''
        ,drvGender_2 = CASE EepGender 
                        WHEN 'F' THEN '2'  
                        WHEN 'M' THEN '1' 
                       END
        ,drvEmplStatus_2 = CASE
                            WHEN EecEmplStatus = 'T' THEN
                                CASE
                                    WHEN EecTermReason = '202' THEN '22'
                                    WHEN EecTermReason = '203' THEN '3D'
                                    ELSE '32'
                                END
                            WHEN EecEmplStatus <> 'T' AND EecUDField01 = 'Y' THEN '32'
                            ELSE '00'
                           END
        ,drvEmplStatusDate_2 = CASE
                                WHEN EecEmplStatus <> 'T' AND EecUDField01 = 'Y' THEN CONVERT(VARCHAR(8), EecUDField07, 112)
                                ELSE CONVERT(VARCHAR(8), EecEmplStatusStartDate, 112)
                               END    
        ,drvFrequency_2 = CASE EecPayPeriod
                            WHEN 'W' THEN '7'
                            WHEN 'B' THEN '6'
                            WHEN 'S' THEN '5'
                            WHEN 'M' THEN '4'
                          END
        ,drvHrsOfService_2 = ''
        ,drvCurHrs_2          = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(6),dbo.dsi_fnPadZero(ISNULL(PehCurHrs*100,0),6,0)),'-','0'),5) + HrsS.sDigit,6)        --SR-2019-00234349 05/30/2019
        ,drvCurGross_2        = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CgsS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvCurEligGross_2    = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CegDlS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvCurW2Taxable_2    = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(ISNULL(PthCurFITWages,0)*100,11,0)),'-','0'),10) + CurW2S.sDigit,11)    --SR-2019-00234349 05/30/2019
        ,drvCurHrs_2NOP          = ISNULL(PehCurHrs,0)        --SR-2019-00234349 05/30/2019
        ,drvCurGross_2NOP        = ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0)
        ,drvCurEligGross_2NOP    = ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)
        ,drvCurW2Taxable_2NOP    = ISNULL(PthCurFITWages,0)
        ,drvAnniversary_2 = ''
        ,drvAnniversaryHrs_2 = ''
        ,drvPayDate_2 = CONVERT(VARCHAR(8), @PayDate, 112)
        ,drvEmpIDCode_2 = EecOrgLvl3
        ,drvDivSub_2 = EecOrgLvl2
        ,drvERLocCode_2 = LTRIM(RTRIM(CmpImportCode)) + LTRIM(RTRIM(EecOrgLvl1))
        ,drvLocEffDate_2 = ''
        ,drvGroupInd_2 = ''
        ,drvNeverElig_2 = ''
        ,drvEligEESources_2 = ''
        ,drvEligERSources_2 = ''
        ,drvEligDate_2 = ''
        ,drvAutoEnroll_2 = ''
        ,drvDefRate_2 = ''
        ,drvCashBonus_2 = ''
        ,drvHCEInd_2 = ''
        ,drvUnionEE_2 = CASE WHEN EecUnionNational IS NOT NULL THEN 'Y' ELSE 'N' END
        ,drvMarketSal_2 = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(ISNULL(EecAnnSalary,0)*100,11,0)),'-','0'),10)+MarSal.sDigit,11)        --SR-2019-00234349 05/30/2019
        ,drvMarketSal_2NOP = ISNULL(EecAnnSalary,0)
        ,drvRehireDate_2 = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire THEN CONVERT(VARCHAR(8), EecDateOfLastHire, 112) END
        ,drvYTDGross_2     = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CgsS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvDefLimitComp_2 = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CegDlS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvYTDGross_2NOP     = ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0)
        ,drvDefLimitComp_2NOP = ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)
        ,drvCurEligGrossSource2_2 = ''
        ,drvADPPlanComp_2 = ''
        ,drvCurEligGrossSource3_2 = ''
        ,drvERMatchComp_2 = ''
        ,drvACPComp_2 = ''
        ,drvExclComp_2 = ''
        ,drv401A_2 = ''
        ,drvEEPostComp_2 = ''
        ,drvSubStatus_2 = CASE
                            WHEN subRLSubStatus = 'RL' THEN 'RL'
                            WHEN subLOASubStatus IS NOT NULL THEN subLOASubStatus
                        END
        ,drvSubStatusDate_2 = CASE
                                WHEN subRLSubStatus = 'RL' THEN CONVERT(VARCHAR(8), subRLSubStatusDate, 112)
                                WHEN subLOASubStatus IS NOT NULL THEN subLOASubStatusDate
                            END
        ,drvEmail_2 = EepAddressEMail
    INTO dbo.U_EPRUDTTT_drvTbl_D20
    FROM dbo.U_EPRUDTTT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK) 
        ON CmpCOID = xCOID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_EPRUDTTT_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_PDedHist_YTD WITH (NOLOCK)
        ON YTDEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_SubStatus WITH (NOLOCK)
        ON subEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_TaxWages WITH (NOLOCK)
        ON PthEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_RLSubStatus WITH (NOLOCK)
        ON subRLEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_LOASubStatus WITH (NOLOCK)
        ON subLOAEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_Sign PdhPTS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON PdhPTS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(10)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource1,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(10)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource1,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign PdhMS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON PdhMS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource6,0) AS VARCHAR(10)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource6,0)),1)
                                WHEN LEFT(CAST(ISNULL(PdhSource6,0) AS VARCHAR(10)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource6,0)),1)
                           END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign PdhRS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON PdhRS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource2,0) AS VARCHAR(10)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource2,0)),1)
                                WHEN LEFT(CAST(ISNULL(PdhSource2,0) AS VARCHAR(10)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource2,0)),1)
                           END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign HrsS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON HrsS.sValue = (CASE WHEN LEFT(CAST(FLOOR(ISNULL(PehCurHrs,0)) AS VARCHAR(6)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(6),FLOOR(ISNULL(PehCurHrs,0))),1)
                               WHEN LEFT(CAST(FLOOR(ISNULL(PehCurHrs,0)) AS VARCHAR(6)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(6),FLOOR(ISNULL(PehCurHrs,0))),1)
                          END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign CgsS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON CgsS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0)),1)
                               WHEN LEFT(CAST(ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0)),1)
                          END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign CegDlS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON CegDlS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign CurW2S WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON CurW2S.sValue = (CASE WHEN LEFT(CAST(ISNULL(PthCurFITWages,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PthCurFITWages,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PthCurFITWages,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PthCurFITWages,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign YTDGrS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON YTDGrS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign MarSal WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON MarSal.sValue = (CASE WHEN LEFT(CAST(ISNULL(EecAnnSalary,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(EecAnnSalary,0)),1)
                                 WHEN LEFT(CAST(ISNULL(EecAnnSalary,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(EecAnnSalary,0)),1)
                            END)
    WHERE EecDedGroupCode IN ('WADMN','WTECH')
    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination >= DATEADD(MM,-18,@EndDate)))
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EPRUDTTT_drvTbl_D30 - DEFERRAL DETAIL - WALTHAM
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_drvTbl_D30','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_drvTbl_D30;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = EepSSN
        ,drvDedGroupCode = EecDedGroupCode
        ,Pretax = ISNULL(PdhSource1,0)
        ,Roth = ISNULL(PdhSource2,0)
        ,CurHrs = ISNULL(PehCurHrs,0)
        ,CurGross = ISNULL(PehCurAmt,0)
        ,CurEligGross = ISNULL(PehInclInDefComp - PdhSource4,0)
        ,CurW2Taxable = ISNULL(PthCurFITWages,0)
        ,YTDGross = ISNULL(PehCurAmtYTD,0)
        ,DefLimitComp = ISNULL(PehInclInDefCompYTD - YTDPdhSource4,0)
        ,PreTaxMatch = ISNULL(PdhSource6,0)
        -- standard fields above and additional driver fields below
        ,drvPlanNumber_3 = '010010'
        ,drvSSN_3 = EepSSN
        ,drvPretax_3        = RIGHT(LEFT(REPLACE(CAST(dbo.dsi_fnPadZero(ISNULL(PdhSource1,0)*100,9,0) AS VARCHAR(9)),'-','0'),8) + PdhPTS.sDigit,9) --SR-2019-00234349 05/30/2019
        ,drvPretaxMatch_3   = RIGHT(LEFT(REPLACE(CAST(dbo.dsi_fnPadZero(ISNULL(PdhSource6,0)*100,9,0) AS VARCHAR(9)),'-','0'),8) + PdhMS.sDigit,9) --SR-2019-00234349 05/30/2019
        ,drvRoth_3          = RIGHT(LEFT(REPLACE(CAST(dbo.dsi_fnPadZero(ISNULL(PdhSource2,0)*100,9,0) AS VARCHAR(9)),'-','0'),8) + PdhRS.sDigit,9) --SR-2019-00234349 05/30/2019
        ,drvPretax_3NOP        = ISNULL(PdhSource1,0)
        ,drvPretaxMatch_3NOP   = ISNULL(PdhSource6,0)
        ,drvRoth_3NOP          = ISNULL(PdhSource2,0)
        ,drvInvestment3_3 = ''
        ,drvSource4_3 = ''
        ,drvContAmt4_3 = ''
        ,drvInvestment4_3 = ''
        ,drvSource5_3 = ''
        ,drvContAmt5_3 = ''
        ,drvInvestment5_3 = ''
        ,drvSource6_3 = ''
        ,drvContAmt6_3 = ''
        ,drvPeriodEnd_3 = CONVERT(VARCHAR(8), @EndDate, 112)
        ,drvInsiderTrader_3 = CASE CONVERT(VARCHAR(10), EepUDField13)
                                WHEN 'O' THEN 'O'
                                WHEN 'B' THEN 'B'
                                ELSE ' '
                              END
        ,drvSubPlanNumber_3 = CASE
                                WHEN EecFullTimeOrPartTime = 'F' THEN '0001'
                                WHEN EecFullTimeOrPartTime = 'P' THEN '0002'
                              END
        ,drvName_3 = EepNameLast + ', ' + EepNameFirst + ' ' + ISNULL(LEFT(EepNameMiddle,1),'')
        ,drvAddress1_3 = EepAddressLine1
        ,drvAddress2_3 = EepAddressLine2
        ,drvCity_3 = EepAddressCity
        ,drvState_3 = EepAddressState
        ,drvZipCode_3 = REPLACE(EepAddressZipCode,'-','')
        ,drvDOB_3 =  CONVERT(VARCHAR(8), EepDateOfBirth, 112)
        ,drvODOH_3 = CONVERT(VARCHAR(8), EecDateOfOriginalHire, 112)
        ,drvADOH_3 = ''
        ,drvMaritalStatus_3 = CASE EepMaritalStatus WHEN 'M' THEN '2' ELSE '1' END
        ,drvGender_3 = CASE EepGender 
                        WHEN 'F' THEN '2'  
                        WHEN 'M' THEN '1' 
                       END
        ,drvEmplStatus_3 = CASE
                            WHEN EecEmplStatus = 'T' THEN
                                CASE
                                    WHEN EecTermReason = '202' THEN '22'
                                    WHEN EecTermReason = '203' THEN '3D'
                                    ELSE '32'
                                END
                            WHEN EecEmplStatus <> 'T' AND EecUDField01 = 'Y' THEN '32'
                            ELSE '00'
                           END
        ,drvEmplStatusDate_3 = CASE
                                WHEN EecEmplStatus <> 'T' AND EecUDField01 = 'Y' THEN CONVERT(VARCHAR(8), EecUDField07, 112)
                                ELSE CONVERT(VARCHAR(8), EecEmplStatusStartDate, 112)
                               END    
        ,drvFrequency_3 = CASE EecPayPeriod
                            WHEN 'W' THEN '7'
                            WHEN 'B' THEN '6'
                            WHEN 'S' THEN '5'
                            WHEN 'M' THEN '4'
                          END
        ,drvHrsOfService_3 = ''
        ,drvCurHrs_3          = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(6),dbo.dsi_fnPadZero(ISNULL(PehCurHrs*100,0),6,0)),'-','0'),5) + HrsS.sDigit,6)        --SR-2019-00234349 05/30/2019
        ,drvCurGross_3        = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CgsS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvCurEligGross_3    = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CegDlS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvCurW2Taxable_3    = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(ISNULL(PthCurFITWages,0)*100,11,0)),'-','0'),10) + CurW2S.sDigit,11)    --SR-2019-00234349 05/30/2019
        ,drvCurHrs_3NOP          = ISNULL(PehCurHrs,0)
        ,drvCurGross_3NOP        = ISNULL(PehCurAmt,0)
        ,drvCurEligGross_3NOP    = ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)
        ,drvCurW2Taxable_3NOP    = ISNULL(PthCurFITWages,0)
        ,drvAnniversary_3 = ''
        ,drvAnniversaryHrs_3 = ''
        ,drvPayDate_3 = CONVERT(VARCHAR(8), @PayDate, 112)
        ,drvEmpIDCode_3 = EecOrgLvl3
        ,drvDivSub_3 = EecOrgLvl2
        ,drvERLocCode_3 = LTRIM(RTRIM(CmpImportCode)) + LTRIM(RTRIM(EecOrgLvl1))
        ,drvLocEffDate_3 = ''
        ,drvGroupInd_3 = ''
        ,drvNeverElig_3 = ''
        ,drvEligEESources_3 = ''
        ,drvEligERSources_3 = ''
        ,drvEligDate_3 = ''
        ,drvAutoEnroll_3 = ''
        ,drvDefRate_3 = ''
        ,drvCashBonus_3 = ''
        ,drvHCEInd_3 = ''
        ,drvUnionEE_3 = CASE WHEN EecUnionNational IS NOT NULL THEN 'Y' ELSE 'N' END
        ,drvMarketSal_3 = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(ISNULL(EecAnnSalary,0)*100,11,0)),'-','0'),10)+MarSal.sDigit,11)        --SR-2019-00234349 05/30/2019
        ,drvMarketSal_3NOP = ISNULL(EecAnnSalary,0)
        ,drvRehireDate_3 = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire THEN CONVERT(VARCHAR(10), EecDateOfLastHire, 112) END    
        ,drvYTDGross_3     = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CgsS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvDefLimitComp_3 = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(15),dbo.dsi_fnPadZero((ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0))*100,15,0)),'-','0'),14) + CegDlS.sDigit,15)    --SR-2019-00234349 05/30/2019
        ,drvYTDGross_3NOP     = ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0)
        ,drvDefLimitComp_3NOP = ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)
        ,drvCurEligGrossSource2_3 = ''
        ,drvADPPlanComp_3 = ''
        ,drvCurEligGrossSource3_3 = ''
        ,drvERMatchComp_3 = ''
        ,drvACPComp_3 = ''
        ,drvExclComp_3 = ''
        ,drv401A_3 = ''
        ,drvEEPostComp_3 = ''
        ,drvSubStatus_3 = CASE
                            WHEN subRLSubStatus = 'RL' THEN 'RL'
                            WHEN subLOASubStatus IS NOT NULL THEN subLOASubStatus
                        END
        ,drvSubStatusDate_3 = CASE
                                WHEN subRLSubStatus = 'RL' THEN CONVERT(VARCHAR(8), subRLSubStatusDate, 112)
                                WHEN subLOASubStatus IS NOT NULL THEN subLOASubStatusDate
                            END
        ,drvEmail_3 = EepAddressEMail
    INTO dbo.U_EPRUDTTT_drvTbl_D30
    FROM dbo.U_EPRUDTTT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK) 
        ON CmpCOID = xCOID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_EPRUDTTT_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_PDedHist_YTD WITH (NOLOCK)
        ON YTDEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_SubStatus WITH (NOLOCK)
        ON subEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_TaxWages WITH (NOLOCK)
        ON PthEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_RLSubStatus WITH (NOLOCK)
        ON subRLEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_LOASubStatus WITH (NOLOCK)
        ON subLOAEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_Sign PdhPTS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON PdhPTS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(10)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource1,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(10)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource1,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign PdhMS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON PdhMS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource6,0) AS VARCHAR(10)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource6,0)),1)
                                WHEN LEFT(CAST(ISNULL(PdhSource6,0) AS VARCHAR(10)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource6,0)),1)
                           END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign PdhRS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON PdhRS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource2,0) AS VARCHAR(10)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource2,0)),1)
                                WHEN LEFT(CAST(ISNULL(PdhSource2,0) AS VARCHAR(10)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(10),ISNULL(PdhSource2,0)),1)
                           END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign HrsS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON HrsS.sValue = (CASE WHEN LEFT(CAST(FLOOR(ISNULL(PehCurHrs,0)) AS VARCHAR(6)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(6),FLOOR(ISNULL(PehCurHrs,0))),1)
                               WHEN LEFT(CAST(FLOOR(ISNULL(PehCurHrs,0)) AS VARCHAR(6)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(6),FLOOR(ISNULL(PehCurHrs,0))),1)
                          END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign CgsS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON CgsS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0)),1)
                               WHEN LEFT(CAST(ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0)),1)
                          END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign CegDlS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON CegDlS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign CurW2S WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON CurW2S.sValue = (CASE WHEN LEFT(CAST(ISNULL(PthCurFITWages,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PthCurFITWages,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PthCurFITWages,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PthCurFITWages,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign YTDGrS WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON YTDGrS.sValue = (CASE WHEN LEFT(CAST(ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0)),1)
                                 WHEN LEFT(CAST(ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(PehInclInDefCompYTD,0) - ISNULL(YTDPdhSource4,0)),1)
                            END)
    LEFT JOIN dbo.U_EPRUDTTT_Sign MarSal WITH (NOLOCK)    --SR-2019-00234349 05/30/2019
        ON MarSal.sValue = (CASE WHEN LEFT(CAST(ISNULL(EecAnnSalary,0) AS VARCHAR(15)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(15),ISNULL(EecAnnSalary,0)),1)
                                 WHEN LEFT(CAST(ISNULL(EecAnnSalary,0) AS VARCHAR(15)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(15),ISNULL(EecAnnSalary,0)),1)
                            END)
    WHERE EecDedGroupCode IN ('WALTU')
    AND (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination >= DATEADD(MM,-18,@EndDate)))
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EPRUDTTT_drvTbl_D40 - LOAN DETAIL - ROLLINS
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_drvTbl_D40','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_drvTbl_D40;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = EepSSN
        ,drvDedGroupCode = EecDedGroupCode
        ,LoanAmt = PdhSource3
        -- standard fields above and additional driver fields below
        ,drvPlanNumberLoan = '006974'
        ,drvSSNLoan = EepSSN
        ,drvLoanNumber = CAST(EedNotes as varchar(MAX)) --DM 11/24/20 EedEEMemberOrCaseNo
        ,drvLoanAmt    = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(9),dbo.dsi_fnPadZero(ISNULL(PdhSource3,0)*100,9,0)),'-','0'),8) + sDigit,9)      --SR-2019-00234349 05/30/2019
        ,drvLoanAmtNOP    = ISNULL(PdhSource3,0)
        ,drvSubPlanLoan = CASE
                            WHEN EecFullTimeOrPartTime = 'F' THEN '0001'
                            WHEN EecFullTimeOrPartTime = 'P' THEN '0002'
                          END
    INTO dbo.U_EPRUDTTT_drvTbl_D40
    FROM dbo.U_EPRUDTTT_EEList WITH (NOLOCK)
    LEFT JOIN (SELECT EedEEID, EedCOID, EedDedCode, EedNotes --DM 11/24/20 EedEEMemberOrCaseNo
               FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
               WHERE EedFormatCode = @FormatCode
               AND EedValidForExport = 'Y'
               AND EedDedCode IN ('401KL','G401L','401L2','GLNBK','RLNBK','W401L','WLNBK')) TmpTbl1
        ON  EedEEID = xEEID 
        AND EedCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_Sign WITH (NOLOCK)
        ON sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(8)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(25),ISNULL(PdhSource3,0)),1) --AR SF15656661
                          WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(8)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(25),ISNULL(PdhSource3,0)),1) --AR SF15656661
                     END)       --SR-2019-00234349 05/30/2019
    WHERE EecDedGroupCode IN ('HTEAM','ROLLI','RWEST','WALTH','WALTN','ALL','NOBNC','NWEST') --DM 11/24/20 
        AND PdhSource3 <> 0                                    --SR-2019-00234349 05/30/2019
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EPRUDTTT_drvTbl_D50 - LOAN DETAIL - WESTERN
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_drvTbl_D50','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_drvTbl_D50;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = EepSSN
        ,drvDedGroupCode = EecDedGroupCode
        ,LoanAmt = PdhSource3
        -- standard fields above and additional driver fields below
        ,drvPlanNumberLoan_2 = '006976'
        ,drvSSNLoan_2 = EepSSN
        ,drvLoanNumber_2 = CAST(EedNotes as varchar(MAX)) --DM 11/24/20 EedEEMemberOrCaseNo
        ,drvLoanAmt_2    = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(9),dbo.dsi_fnPadZero(ISNULL(PdhSource3,0)*100,9,0)),'-','0'),8) + sDigit,9)      --SR-2019-00234349 05/30/2019
        ,drvLoanAmt_2NOP    = ISNULL(PdhSource3,0)
        ,drvSubPlanLoan_2 = CASE
                                WHEN EecFullTimeOrPartTime = 'F' THEN '0001'
                                WHEN EecFullTimeOrPartTime = 'P' THEN '0002'
                            END
    INTO dbo.U_EPRUDTTT_drvTbl_D50
    FROM dbo.U_EPRUDTTT_EEList WITH (NOLOCK)
    LEFT JOIN (SELECT EedEEID, EedCOID, EedDedCode, EedNotes --DM 11/24/20 EedEEMemberOrCaseNo
               FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
               WHERE EedFormatCode = @FormatCode
               AND EedValidForExport = 'Y'
               AND EedDedCode IN ('401KL','G401L','401L2','GLNBK','RLNBK','W401L','WLNBK')) TmpTbl1
        ON  EedEEID = xEEID 
        AND EedCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_Sign WITH (NOLOCK)
        ON sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(8)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(25),ISNULL(PdhSource3,0)),1) --AR SF15656661
                          WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(8)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(25),ISNULL(PdhSource3,0)),1) --AR SF15656661
                     END)       --SR-2019-00234349 05/30/2019 
    WHERE EecDedGroupCode IN ('WTECH','WADMN')                        --SR-2019-00234349 05/30/2019
        AND PdhSource3 <> 0
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EPRUDTTT_drvTbl_D60 - LOAN DETAIL - WALTHAM
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_drvTbl_D60','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_drvTbl_D60;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = EepSSN
        ,drvDedGroupCode = EecDedGroupCode
        ,LoanAmt = PdhSource3
        -- standard fields above and additional driver fields below
        ,drvPlanNumberLoan_3 = '010010'
        ,drvSSNLoan_3 = EepSSN
        ,drvLoanNumber_3 = CAST(EedNotes as varchar(MAX)) --DM 11/24/20 EedEEMemberOrCaseNo
        ,drvLoanAmt_3    = RIGHT(LEFT(REPLACE(CONVERT(VARCHAR(9),dbo.dsi_fnPadZero(ISNULL(PdhSource3,0)*100,9,0)),'-','0'),8) + sDigit,9)      --SR-2019-00234349 05/30/2019
        ,drvLoanAmt_3NOP    = ISNULL(PdhSource3,0)
        ,drvSubPlanLoan_3 = CASE
                                WHEN EecFullTimeOrPartTime = 'F' THEN '0001'
                                WHEN EecFullTimeOrPartTime = 'P' THEN '0002'
                            END
    INTO dbo.U_EPRUDTTT_drvTbl_D60
    FROM dbo.U_EPRUDTTT_EEList WITH (NOLOCK)
    LEFT JOIN (SELECT EedEEID, EedCOID, EedDedCode, EedNotes --DM 11/24/20 EedEEMemberOrCaseNo
               FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
               WHERE EedFormatCode = @FormatCode
               AND EedValidForExport = 'Y'
               AND EedDedCode IN ('401KL','G401L','401L2','GLNBK','RLNBK','W401L','WLNBK')) TmpTbl1
        ON  EedEEID = xEEID 
        AND EedCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTT_Sign WITH (NOLOCK)
        ON sValue = (CASE WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(8)),1) = '-' THEN '-'+RIGHT(CONVERT(VARCHAR(25),ISNULL(PdhSource3,0)),1) --AR SF15656661
                          WHEN LEFT(CAST(ISNULL(PdhSource1,0) AS VARCHAR(8)),1) <> '-' THEN RIGHT(CONVERT(VARCHAR(25),ISNULL(PdhSource3,0)),1) --AR SF15656661
                     END)       --SR-2019-00234349 05/30/2019
    WHERE EecDedGroupCode IN ('WALTU')
        AND PdhSource3 <> 0                            --SR-2019-00234349 05/30/2019
    ;

    ---------------------------------
    -- HEADER RECORD - U_EPRUDTTT_Header_H01 - ROLLINS
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_Header_H01','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_Header_H01;
    SELECT DISTINCT
         drvClientID = '006974'
        ,drvCreateDate = @RunDate
        ,drvCreateTime = @RunTime
    INTO dbo.U_EPRUDTTT_Header_H01    --SELECT * FROM dbo.U_EPRUDTTT_Header_H01
    ;
    ---------------------------------
    -- HEADER RECORD - U_EPRUDTTT_Header_H02 - WESTERN
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_Header_H02','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_Header_H02;
    SELECT DISTINCT
         drvClientID2 = '006976'
        ,drvCreateDate2 = @RunDate
        ,drvCreateTime2 = @RunTime
    INTO dbo.U_EPRUDTTT_Header_H02    --SELECT * FROM dbo.U_EPRUDTTT_Header_H02
    ;
    ---------------------------------
    -- HEADER RECORD - U_EPRUDTTT_Header_H03 - WALTHAM
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_Header_H03','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_Header_H03;
    SELECT DISTINCT
         drvClientID3 = '010010'
        ,drvCreateDate3 = @RunDate
        ,drvCreateTime3 = @RunTime
    INTO dbo.U_EPRUDTTT_Header_H03    --SELECT * FROM dbo.U_EPRUDTTT_Header_H03
    ;

    --------------------------------------
    -- TOTALS VARIABLES FOR TRAILER COUNTS
    --------------------------------------

    DECLARE @TtlCont_Rollins DECIMAL(24,2)
    DECLARE @TtlCont_Western DECIMAL(24,2)
    DECLARE @TtlCont_Waltham DECIMAL(24,2)

    DECLARE @TtlLoan_Rollins DECIMAL(24,2)
    DECLARE @TtlLoan_Western DECIMAL(24,2)
    DECLARE @TtlLoan_Waltham DECIMAL(24,2)

    DECLARE @TtlRecords_Rollins_DEF INT
    DECLARE @TtlRecords_Western_DEF INT
    DECLARE @TtlRecords_Waltham_DEF INT    

    DECLARE @TtlRecords_Rollins_LOAN INT
    DECLARE @TtlRecords_Western_LOAN INT
    DECLARE @TtlRecords_Waltham_LOAN INT

    -- Total Contribution / Loan Amounts

    SELECT @TtlCont_Rollins = SUM(CONVERT(DECIMAL(24,2), Pretax) + CONVERT(DECIMAL(24,2), PreTaxMatch) + CONVERT(DECIMAL(24,2), Roth))
    FROM dbo.U_EPRUDTTT_drvTbl_D10 (NOLOCK)
    ;

    SELECT @TtlCont_Western = SUM(CONVERT(DECIMAL(24,2), Pretax) + CONVERT(DECIMAL(24,2), PreTaxMatch) + CONVERT(DECIMAL(24,2), Roth)) 
    FROM dbo.U_EPRUDTTT_drvTbl_D20 (NOLOCK)
    ;

    SELECT @TtlCont_Waltham = SUM(CONVERT(DECIMAL(24,2), Pretax) + CONVERT(DECIMAL(24,2), PreTaxMatch) + CONVERT(DECIMAL(24,2), Roth))
    FROM dbo.U_EPRUDTTT_drvTbl_D30 (NOLOCK)
    ;

    SELECT @TtlLoan_Rollins = SUM(CONVERT(DECIMAL(24,2), LoanAmt))
    FROM dbo.U_EPRUDTTT_drvTbl_D40 (NOLOCK)
    ;

    SELECT @TtlLoan_Western = SUM(CONVERT(DECIMAL(24,2), LoanAmt))
    FROM dbo.U_EPRUDTTT_drvTbl_D50 (NOLOCK)
    ;

    SELECT @TtlLoan_Waltham = SUM(CONVERT(DECIMAL(24,2), LoanAmt))
    FROM dbo.U_EPRUDTTT_drvTbl_D60 (NOLOCK)
    ;


    -- Total Record Counts

    SELECT @TtlRecords_Rollins_DEF = COUNT(*) FROM dbo.U_EPRUDTTT_drvTbl_D10 WITH (NOLOCK)
    SELECT @TtlRecords_Western_DEF = COUNT(*) FROM dbo.U_EPRUDTTT_drvTbl_D20 WITH (NOLOCK)
    SELECT @TtlRecords_Waltham_DEF = COUNT(*) FROM dbo.U_EPRUDTTT_drvTbl_D30 WITH (NOLOCK)

    SELECT @TtlRecords_Rollins_LOAN = COUNT(*) FROM dbo.U_EPRUDTTT_drvTbl_D40 WITH (NOLOCK)
    SELECT @TtlRecords_Western_LOAN = COUNT(*) FROM dbo.U_EPRUDTTT_drvTbl_D50 WITH (NOLOCK)
    SELECT @TtlRecords_Waltham_LOAN = COUNT(*) FROM dbo.U_EPRUDTTT_drvTbl_D60 WITH (NOLOCK)
    ;

    ---------------------------------
    -- TRAILER RECORD - U_EPRUDTTT_Trailer_T90 - ROLLINS
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_Trailer_T90','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_Trailer_T90;
    SELECT DISTINCT
         drvClientIDTrl = LEFT('006974' + SPACE(10), 10)
        ,drvCreationDateTrl = @RunDate
        ,drvCreationTimeTrl = @RunTime
        ,drvRecordCount = (@TtlRecords_Rollins_DEF + @TtlRecords_Rollins_LOAN)
        ,drvTotalCont = CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(@TtlCont_Rollins*100,11,0))
        ,drvTotalLoanAmt = CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(@TtlLoan_Rollins*100,11,0))
    INTO dbo.U_EPRUDTTT_Trailer_T90        --SELECT * FROM dbo.U_EPRUDTTT_Trailer_T90
    ;
    ---------------------------------
    -- TRAILER RECORD - U_EPRUDTTT_Trailer_T91 - WESTERN
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_Trailer_T91','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_Trailer_T91;
    SELECT DISTINCT
         drvClientIDTrl_2 = LEFT('006976' + SPACE(10), 10)
        ,drvCreationDateTrl_2 = @RunDate
        ,drvCreationTimeTrl_2 = @RunTime
        ,drvRecordCount_2 = (@TtlRecords_Western_DEF + @TtlRecords_Western_LOAN)
        ,drvTotalCont_2 = CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(@TtlCont_Western*100,11,0))
        ,drvTotalLoanAmt_2 = CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(@TtlLoan_Western*100,11,0))
    INTO dbo.U_EPRUDTTT_Trailer_T91        --SELECT * FROM dbo.U_EPRUDTTT_Trailer_T91
    ;
    ---------------------------------
    -- TRAILER RECORD - U_EPRUDTTT_Trailer_T90 - WALTHAM
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTT_Trailer_T92','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTT_Trailer_T92;
    SELECT DISTINCT
         drvClientIDTrl_3 = LEFT('010010' + SPACE(10), 10)
        ,drvCreationDateTrl_3 = @RunDate
        ,drvCreationTimeTrl_3 = @RunTime
        ,drvRecordCount_3 = (@TtlRecords_Waltham_DEF + @TtlRecords_Waltham_LOAN)
        ,drvTotalCont_3 = CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(@TtlCont_Waltham*100,11,0))
        ,drvTotalLoanAmt_3 = CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(@TtlLoan_Waltham*100,11,0))
    INTO dbo.U_EPRUDTTT_Trailer_T92        --SELECT * FROM dbo.U_EPRUDTTT_Trailer_T92
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'Filename set in After Collect.txt'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRUDTTT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRUDTTT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRUDTTT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRUDTTT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRUDTTT' ORDER BY RunID DESC;


Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTT', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTT', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRUDTTT';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPRUDTTT', @AllObjects = 'Y', @IsWeb = 'N';

--Alter the View
ALTER VIEW dbo.dsi_vwEPRUDTTT_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EPRUDTTT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPRUDTTT%' AND AdfSetNumber = '10'
ORDER BY AdfSetNumber, AdfFieldNumber;


BEGIN TRANSACTION
UPDATE dbo.AscDefF
SET AdfForCond = REPLACE(CAST(AdfForCond AS VARCHAR(MAX)),'UN00','UA')
WHERE AdfHeaderSystemID LIKE 'EPRUDTTT%'
AND AdfSetNumber ='92'
AND AdfFieldNumber IN('8','10')    -- BETWEEN '24' AND '34'
ROLLBACK
COMMIT


--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201907061'
       ,expStartPerControl     = '201907061'
       ,expLastEndPerControl   = '201907129'
       ,expEndPerControl       = '201907129'
WHERE expFormatCode = 'EPRUDTTT' AND expExportCode = 'TEST';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPRUDTTT_Export AS
    SELECT TOP 20000000 *
    FROM dbo.U_EPRUDTTT_File (NOLOCK)
    WHERE RecordSet= 'H04'
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPRUDTTT'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPRUDTTT'
   AND rpoParmType = 'expSystemID'


-- End ripout