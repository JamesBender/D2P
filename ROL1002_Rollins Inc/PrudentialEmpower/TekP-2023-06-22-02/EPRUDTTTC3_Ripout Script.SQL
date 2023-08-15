/**********************************************************************************

EPRUDTTTC3: Empower 401K Export CSV

FormatCode:     EPRUDTTTC3
Project:        Empower 401K Export CSV
Client ID:      ROL1002
Date/time:      2023-08-11 10:35:37.003
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    E42
Server:         E4SUP2DB07
Database:       ULTIPRO_ROLIN
Web Filename:   ROL1002_C9MXB_EEHISTORY_EPRUDTTTC3_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EPRUDTTTC3_SavePath') IS NOT NULL DROP TABLE dbo.U_EPRUDTTTC3_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EPRUDTTTC3'


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
WHERE FormatCode = 'EPRUDTTTC3'
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
WHERE ExpFormatCode = 'EPRUDTTTC3'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EPRUDTTTC3')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EPRUDTTTC3'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EPRUDTTTC3'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EPRUDTTTC3'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EPRUDTTTC3'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EPRUDTTTC3'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EPRUDTTTC3'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EPRUDTTTC3'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EPRUDTTTC3'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EPRUDTTTC3'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_fn_EPRUDTTTC3_CodedValue') IS NOT NULL DROP FUNCTION [dbo].[dsi_fn_EPRUDTTTC3_CodedValue];
GO
IF OBJECT_ID('dsi_fn_ConvertAccent_EPRUDTTTC3') IS NOT NULL DROP FUNCTION [dbo].[dsi_fn_ConvertAccent_EPRUDTTTC3];
GO
IF OBJECT_ID('dsi_vwEPRUDTTTC3_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRUDTTTC3_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRUDTTTC3') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDTTTC3];
GO
IF OBJECT_ID('U_EPRUDTTTC3_Trailer_T92') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_Trailer_T92];
GO
IF OBJECT_ID('U_EPRUDTTTC3_Trailer_T91') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_Trailer_T91];
GO
IF OBJECT_ID('U_EPRUDTTTC3_Trailer_T90') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_Trailer_T90];
GO
IF OBJECT_ID('U_EPRUDTTTC3_TaxWages') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_TaxWages];
GO
IF OBJECT_ID('U_EPRUDTTTC3_SubStatus') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_SubStatus];
GO
IF OBJECT_ID('U_EPRUDTTTC3_Sign') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_Sign];
GO
IF OBJECT_ID('U_EPRUDTTTC3_RLSubStatus') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_RLSubStatus];
GO
IF OBJECT_ID('U_EPRUDTTTC3_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_PEarHist];
GO
IF OBJECT_ID('U_EPRUDTTTC3_PDedLoans') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_PDedLoans];
GO
IF OBJECT_ID('U_EPRUDTTTC3_PDedHist_YTD') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_PDedHist_YTD];
GO
IF OBJECT_ID('U_EPRUDTTTC3_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_PDedHist];
GO
IF OBJECT_ID('U_EPRUDTTTC3_LOASubStatus') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_LOASubStatus];
GO
IF OBJECT_ID('U_EPRUDTTTC3_Header_H03') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_Header_H03];
GO
IF OBJECT_ID('U_EPRUDTTTC3_Header_H02') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_Header_H02];
GO
IF OBJECT_ID('U_EPRUDTTTC3_Header_H01') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_Header_H01];
GO
IF OBJECT_ID('U_EPRUDTTTC3_File') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_File];
GO
IF OBJECT_ID('U_EPRUDTTTC3_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_EEList];
GO
IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D60') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D60];
GO
IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D50') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D50];
GO
IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D40') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D40];
GO
IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D30') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D30];
GO
IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D20') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D20];
GO
IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D10') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D10];
GO
IF OBJECT_ID('U_EPRUDTTTC3_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_DedList];
GO
IF OBJECT_ID('U_EPRUDTTTC3_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_AuditFields];
GO
IF OBJECT_ID('U_EPRUDTTTC3_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPRUDTTTC3_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EPRUDTTTC3','Empower 401K Export CSV','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EXIQ1S0000C0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EXIQ1S0000C0','3','H','01','1',NULL,'Record Type',NULL,NULL,'"001"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EXIQ1S0000C0','10','H','01','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EXIQ1S0000C0','10','H','01','14',NULL,'Client Identifier',NULL,NULL,'"drvClientID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EXIQ1S0000C0','8','H','01','24',NULL,'File Create Date',NULL,NULL,'"drvCreateDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EXIQ1S0000C0','6','H','01','32',NULL,'File Creation Time',NULL,NULL,'"drvCreateTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EXIQ1S0000C0','1','H','01','38',NULL,'Sender',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EXIQ1S0000C0','633','H','01','39',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EXIQ1S0000C0','16','H','04','1',NULL,'Transaction Code',NULL,NULL,'"Trans Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EXIQ1S0000C0','15','H','04','2',NULL,'Sequence Code',NULL,NULL,'"Seq Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EXIQ1S0000C0','11','H','04','3',NULL,'Plan Number',NULL,NULL,'"Plan #"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EXIQ1S0000C0','1','H','04','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EXIQ1S0000C0','11','H','04','5',NULL,'Participant ID',NULL,NULL,'"Partipnt ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EXIQ1S0000C0','1','H','04','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EXIQ1S0000C0','10','H','04','7',NULL,'Investment',NULL,NULL,'"Investment"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EXIQ1S0000C0','5','H','04','8',NULL,'Source 1',NULL,NULL,'"Src 1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EXIQ1S0000C0','11','H','04','9',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EXIQ1S0000C0','10','H','04','10',NULL,'Investment',NULL,NULL,'"Investment"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EXIQ1S0000C0','4','H','04','11',NULL,'Source 2',NULL,NULL,'"Src 2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EXIQ1S0000C0','12','H','04','12',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EXIQ1S0000C0','11','H','04','13',NULL,'Investment',NULL,NULL,'"Investment2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EXIQ1S0000C0','4','H','04','14',NULL,'Source 3',NULL,NULL,'"Src3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EXIQ1S0000C0','12','H','04','15',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EXIQ1S0000C0','11','H','04','12',NULL,'Investment',NULL,NULL,'"Investment3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EXIQ1S0000C0','4','H','04','17',NULL,'Source 4',NULL,NULL,'"Src4"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EXIQ1S0000C0','12','H','04','18',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt4"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EXIQ1S0000C0','11','H','04','19',NULL,'Investment',NULL,NULL,'"Investment4"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EXIQ1S0000C0','4','H','04','20',NULL,'Source 5',NULL,NULL,'"Src5"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EXIQ1S0000C0','12','H','04','21',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt5"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EXIQ1S0000C0','11','H','04','22',NULL,'Investment',NULL,NULL,'"Investment5"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EXIQ1S0000C0','4','H','04','23',NULL,'Source 6',NULL,NULL,'"Src6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EXIQ1S0000C0','12','H','04','24',NULL,'Contribution Amount',NULL,NULL,'"Contrib Amt6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EXIQ1S0000C0','12','H','04','25',NULL,'Pay Period End Date',NULL,NULL,'"Per End Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EXIQ1S0000C0','13','H','04','26',NULL,'Insider Trader',NULL,NULL,'"Inside Trader"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EXIQ1S0000C0','10','H','04','27',NULL,'Sub Plan Number',NULL,NULL,'"Sub Plan #"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EXIQ1S0000C0','5','H','04','28',NULL,'Name',NULL,NULL,'"Name"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EXIQ1S0000C0','6','H','04','29',NULL,'Address 1',NULL,NULL,'"Addr1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EXIQ1S0000C0','6','H','04','30',NULL,'Address 2',NULL,NULL,'"Addr2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EXIQ1S0000C0','4','H','04','31',NULL,'City',NULL,NULL,'"City"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EXIQ1S0000C0','5','H','04','32',NULL,'State',NULL,NULL,'"State"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EXIQ1S0000C0','3','H','04','33',NULL,'ZipCode',NULL,NULL,'"Zip"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EXIQ1S0000C0','10','H','04','34',NULL,'Date of Birth',NULL,NULL,'"Birth Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EXIQ1S0000C0','14','H','04','35',NULL,'Original Date of Hire',NULL,NULL,'"Orig Hire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EXIQ1S0000C0','14','H','04','36',NULL,'Adj. Date of Hire',NULL,NULL,'"Adj. Hire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EXIQ1S0000C0','12','H','04','37',NULL,'Marital Status',NULL,NULL,'"Marital Stat"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EXIQ1S0000C0','6','H','04','38',NULL,'Gender Code',NULL,NULL,'"Gender"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EXIQ1S0000C0','9','H','04','39',NULL,'EE Status',NULL,NULL,'"EE Status"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EXIQ1S0000C0','14','H','04','40',NULL,'Employee Status Date',NULL,NULL,'"EE Status Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EXIQ1S0000C0','8','H','04','41',NULL,'Payroll Frequency',NULL,NULL,'"Pay Freq"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EXIQ1S0000C0','8','H','04','42',NULL,'Years of Service',NULL,NULL,'"Yrs Serv"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EXIQ1S0000C0','12','H','04','43',NULL,'YTD Hours of Service',NULL,NULL,'"YTD Hrs Serv"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EXIQ1S0000C0','7','H','04','44',NULL,'Current Pay Period Hours Worked',NULL,NULL,'"Cur Hrs"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EXIQ1S0000C0','9','H','04','45',NULL,'Current Pay Period Gross Pay',NULL,NULL,'"Cur Gross"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EXIQ1S0000C0','14','H','04','46',NULL,'Current Eligible Gross Pay ''Source 1''',NULL,NULL,'"Cur Elig Gross"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EXIQ1S0000C0','10','H','04','47',NULL,'Current Pay Period W-2 Pay',NULL,NULL,'"Cur Per W2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EXIQ1S0000C0','12','H','04','48',NULL,'Anniversary Date',NULL,NULL,'"Annvsry Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EXIQ1S0000C0','12','H','04','49',NULL,'Anniversary Hours',NULL,NULL,'"Annvsry  Hrs"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EXIQ1S0000C0','8','H','04','50',NULL,'Check Date',NULL,NULL,'"Pay Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EXIQ1S0000C0','10','H','04','51',NULL,'Employee ID/Code',NULL,NULL,'"EE ID-Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EXIQ1S0000C0','7','H','04','52',NULL,'Div/Sub',NULL,NULL,'"Div-Sub"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EXIQ1S0000C0','11','H','04','53',NULL,'Employer Location Code',NULL,NULL,'"ER Loc Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EXIQ1S0000C0','12','H','04','54',NULL,'Location Effective Date',NULL,NULL,'"Loc Eff Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EXIQ1S0000C0','7','H','04','55',NULL,'Group Indicator',NULL,NULL,'"Grp Ind"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EXIQ1S0000C0','10','H','04','56',NULL,'Never Eligible',NULL,NULL,'"Never Elig"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EXIQ1S0000C0','12','H','04','57',NULL,'Eligible to Participate in EE Sources',NULL,NULL,'"Elig Part EE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EXIQ1S0000C0','12','H','04','58',NULL,'Eligible to Participate in ER Sources',NULL,NULL,'"Elig Part ER"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EXIQ1S0000C0','9','H','04','59',NULL,'Eligibility Date',NULL,NULL,'"Elig Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EXIQ1S0000C0','11','H','04','60',NULL,'Auto Enrollment Decline Indicator',NULL,NULL,'"Auto Enroll"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EXIQ1S0000C0','8','H','04','61',NULL,'Deferral Rate for Source 1',NULL,NULL,'"Def Rate"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EXIQ1S0000C0','1','H','04','62',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EXIQ1S0000C0','10','H','04','63',NULL,'Cash Bonus',NULL,NULL,'"Cash Bonus"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EXIQ1S0000C0','7','H','04','64',NULL,'HCE Indicator',NULL,NULL,'"HCE Ind"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EXIQ1S0000C0','8','H','04','65',NULL,'Union Employee',NULL,NULL,'"Union EE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EXIQ1S0000C0','13','H','04','66',NULL,'Market Salary',NULL,NULL,'"Market Salary"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EXIQ1S0000C0','11','H','04','67',NULL,'Rehire Date',NULL,NULL,'"Rehire Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EXIQ1S0000C0','9','H','04','68',NULL,'YTD Gross Pay/415/HCE/414 Compensation',NULL,NULL,'"YTD Gross"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EXIQ1S0000C0','1','H','04','69',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EXIQ1S0000C0','14','H','04','70',NULL,'Deferral & Plan Limit Compensation',NULL,NULL,'"Def Plan Limit"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EXIQ1S0000C0','1','H','04','71',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EXIQ1S0000C0','10','H','04','72',NULL,'Current Eligible Gross Pay ''Source 2''',NULL,NULL,'"Cur Gross2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EXIQ1S0000C0','1','H','04','73',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EXIQ1S0000C0','8','H','04','74',NULL,'ADP & Plan Compensation',NULL,NULL,'"ADP-Plan"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EXIQ1S0000C0','1','H','04','75',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EXIQ1S0000C0','10','H','04','76',NULL,'Current Eligible Gross Pay ''Source 3''',NULL,NULL,'"Cur Gross3"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EXIQ1S0000C0','1','H','04','77',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EXIQ1S0000C0','13','H','04','78',NULL,'ER Match Compensation',NULL,NULL,'"ER Match Comp"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EXIQ1S0000C0','1','H','04','79',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EXIQ1S0000C0','7','H','04','80',NULL,'ACP Compensation',NULL,NULL,'"ACP Comp"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EXIQ1S0000C0','1','H','04','81',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EXIQ1S0000C0','9','H','04','82',NULL,'Excluded Compensation',NULL,NULL,'"Excl Comp"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EXIQ1S0000C0','1','H','04','83',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EXIQ1S0000C0','13','H','04','84',NULL,'Top Heavy 401(a) Compensation',NULL,NULL,'"Top 401a Comp"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EXIQ1S0000C0','1','H','04','85',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EXIQ1S0000C0','16','H','04','86',NULL,'EE Post Tax Compensation',NULL,NULL,'"EE Post Tax Comp"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EXIQ1S0000C0','1','H','04','87',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EXIQ1S0000C0','8','H','04','88',NULL,'Sub Status',NULL,NULL,'"Sub Stat"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EXIQ1S0000C0','1','H','04','89',NULL,'Filler',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EXIQ1S0000C0','13','H','04','90',NULL,'Sub Status Date',NULL,NULL,'"Sub Stat Date"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EXIQ1S0000C0','5','H','04','91',NULL,'Participant''s Email Address',NULL,NULL,'"Email"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EXIQ1S0000C0','3','D','10','1',NULL,'Transaction Code',NULL,NULL,'"114"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EXIQ1S0000C0','2','D','10','4',NULL,'Sequence Code',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EXIQ1S0000C0','6','D','10','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EXIQ1S0000C0','3','D','10','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EXIQ1S0000C0','9','D','10','15',NULL,'Participant ID',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EXIQ1S0000C0','12','D','10','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EXIQ1S0000C0','2','D','10','36',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EXIQ1S0000C0','1','D','10','38',NULL,'Source 1',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EXIQ1S0000C0','9','D','10','39',NULL,'Contribution Amount',NULL,NULL,'"drvPretax"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EXIQ1S0000C0','2','D','10','48',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EXIQ1S0000C0','1','D','10','50',NULL,'Source 2',NULL,NULL,'"6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EXIQ1S0000C0','9','D','10','51',NULL,'Contribution Amount',NULL,NULL,'"drvPretaxMatch_2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EXIQ1S0000C0','2','D','10','60',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EXIQ1S0000C0','1','D','10','62',NULL,'Source 3',NULL,NULL,'"J"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EXIQ1S0000C0','9','D','10','63',NULL,'Contribution Amount',NULL,NULL,'"drvRoth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EXIQ1S0000C0','2','D','10','72',NULL,'Investment',NULL,NULL,'"drvInvestment3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EXIQ1S0000C0','1','D','10','74',NULL,'Source 4',NULL,NULL,'"drvSource4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EXIQ1S0000C0','9','D','10','75',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EXIQ1S0000C0','2','D','10','84',NULL,'Investment',NULL,NULL,'"drvInvestment4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EXIQ1S0000C0','1','D','10','86',NULL,'Source 5',NULL,NULL,'"drvSource5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EXIQ1S0000C0','9','D','10','87',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EXIQ1S0000C0','2','D','10','96',NULL,'Investment',NULL,NULL,'"drvInvestment5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EXIQ1S0000C0','1','D','10','98',NULL,'Source 6',NULL,NULL,'"drvSource6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EXIQ1S0000C0','9','D','10','99',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EXIQ1S0000C0','8','D','10','108',NULL,'Pay Period End Date',NULL,NULL,'"drvPeriodEnd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EXIQ1S0000C0','1','D','10','116',NULL,'Insider Trader',NULL,NULL,'"drvInsiderTrader"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EXIQ1S0000C0','4','D','10','117',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EXIQ1S0000C0','30','D','10','121',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EXIQ1S0000C0','30','D','10','151',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EXIQ1S0000C0','30','D','10','181',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EXIQ1S0000C0','18','D','10','211',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EXIQ1S0000C0','2','D','10','229',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EXIQ1S0000C0','9','D','10','231',NULL,'ZipCode',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EXIQ1S0000C0','8','D','10','240',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EXIQ1S0000C0','8','D','10','248',NULL,'Original Date of Hire',NULL,NULL,'"drvODOH"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EXIQ1S0000C0','8','D','10','256',NULL,'Adj. Date of Hire',NULL,NULL,'"drvADOH"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EXIQ1S0000C0','1','D','10','264',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EXIQ1S0000C0','1','D','10','265',NULL,'Gender Code',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EXIQ1S0000C0','2','D','10','266',NULL,'EE Status',NULL,NULL,'"drvEmplStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EXIQ1S0000C0','8','D','10','268',NULL,'Employee Status Date',NULL,NULL,'"drvEmplStatusDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EXIQ1S0000C0','1','D','10','276',NULL,'Payroll Frequency',NULL,NULL,'"drvFrequency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EXIQ1S0000C0','8','D','10','277',NULL,'Years of Service',NULL,NULL,'"00000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EXIQ1S0000C0','6','D','10','285',NULL,'YTD Hours of Service',NULL,NULL,'"drvHrsOfService"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EXIQ1S0000C0','6','D','10','291',NULL,'Current Pay Period Hours Worked',NULL,NULL,'"drvCurHrs"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EXIQ1S0000C0','15','D','10','297',NULL,'Current Pay Period Gross Pay',NULL,NULL,'"drvCurGross"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EXIQ1S0000C0','15','D','10','312',NULL,'Current Eligible Gross Pay ''Source 1''',NULL,NULL,'"drvCurEligGross"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EXIQ1S0000C0','11','D','10','327',NULL,'Current Pay Period W-2 Pay',NULL,NULL,'"drvCurW2Taxable"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EXIQ1S0000C0','8','D','10','338',NULL,'Anniversary Date',NULL,NULL,'"drvAnniversary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EXIQ1S0000C0','6','D','10','346',NULL,'Anniversary Hours',NULL,NULL,'"drvAnniversaryHrs"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EXIQ1S0000C0','8','D','10','352',NULL,'Check Date',NULL,NULL,'"drvPayDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EXIQ1S0000C0','13','D','10','360',NULL,'Employee ID/Code',NULL,NULL,'"drvEmpIDCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EXIQ1S0000C0','4','D','10','373',NULL,'Div/Sub',NULL,NULL,'"drvDivSub"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EXIQ1S0000C0','10','D','10','377',NULL,'Employer Location Code',NULL,NULL,'"drvERLocCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EXIQ1S0000C0','8','D','10','387',NULL,'Location Effective Date',NULL,NULL,'"drvLocEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EXIQ1S0000C0','1','D','10','395',NULL,'Group Indicator',NULL,NULL,'"drvGroupInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EXIQ1S0000C0','10','D','10','396',NULL,'Never Eligible',NULL,NULL,'"drvNeverElig"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EXIQ1S0000C0','5','D','10','406',NULL,'Eligible to Participate in EE Sources',NULL,NULL,'"drvEligEESources"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EXIQ1S0000C0','5','D','10','411',NULL,'Eligible to Participate in ER Sources',NULL,NULL,'"drvEligERSources"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EXIQ1S0000C0','8','D','10','416',NULL,'Eligibility Date',NULL,NULL,'"drvEligDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EXIQ1S0000C0','1','D','10','424',NULL,'Auto Enrollment Decline Indicator',NULL,NULL,'"drvAutoEnroll"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EXIQ1S0000C0','5','D','10','425',NULL,'Deferral Rate for Source 1',NULL,NULL,'"drvDefRate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EXIQ1S0000C0','15','D','10','430',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EXIQ1S0000C0','11','D','10','445',NULL,'Cash Bonus',NULL,NULL,'"drvCashBonus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EXIQ1S0000C0','1','D','10','456',NULL,'HCE Indicator',NULL,NULL,'"drvHCEInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EXIQ1S0000C0','1','D','10','457',NULL,'Union Employee',NULL,NULL,'"drvUnionEE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EXIQ1S0000C0','11','D','10','458',NULL,'Market Salary',NULL,NULL,'"drvMarketSal"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EXIQ1S0000C0','8','D','10','469',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EXIQ1S0000C0','15','D','10','477',NULL,'YTD Gross Pay/415/HCE/414 Compensation',NULL,NULL,'"drvYTDGross"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EXIQ1S0000C0','1','D','10','492',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EXIQ1S0000C0','15','D','10','493',NULL,'Deferral & Plan Limit Compensation',NULL,NULL,'"drvDefLimitComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EXIQ1S0000C0','1','D','10','508',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EXIQ1S0000C0','15','D','10','509',NULL,'Current Eligible Gross Pay ''Source 2''',NULL,NULL,'"drvCurEligGrossSource2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EXIQ1S0000C0','1','D','10','524',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EXIQ1S0000C0','15','D','10','525',NULL,'ADP & Plan Compensation',NULL,NULL,'"drvADPPlanComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EXIQ1S0000C0','1','D','10','540',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EXIQ1S0000C0','15','D','10','541',NULL,'Current Eligible Gross Pay ''Source 3''',NULL,NULL,'"drvCurEligGrossSource3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EXIQ1S0000C0','1','D','10','556',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EXIQ1S0000C0','15','D','10','557',NULL,'ER Match Compensation',NULL,NULL,'"drvERMatchComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EXIQ1S0000C0','1','D','10','572',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EXIQ1S0000C0','11','D','10','573',NULL,'ACP Compensation',NULL,NULL,'"drvACPComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EXIQ1S0000C0','1','D','10','584',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EXIQ1S0000C0','11','D','10','585',NULL,'Excluded Compensation',NULL,NULL,'"drvExclComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EXIQ1S0000C0','1','D','10','596',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EXIQ1S0000C0','11','D','10','597',NULL,'Top Heavy 401(a) Compensation',NULL,NULL,'"drv401A"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EXIQ1S0000C0','1','D','10','608',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EXIQ1S0000C0','11','D','10','609',NULL,'EE Post Tax Compensation',NULL,NULL,'"drvEEPostComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EXIQ1S0000C0','1','D','10','620',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EXIQ1S0000C0','2','D','10','621',NULL,'Sub Status',NULL,NULL,'"drvSubStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EXIQ1S0000C0','1','D','10','623',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EXIQ1S0000C0','8','D','10','624',NULL,'Sub Status Date',NULL,NULL,'"drvSubStatusDate"','(''UD101''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EXIQ1S0000C0','40','D','10','632',NULL,'Participant''s Email Address',NULL,NULL,'"drvEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EXIQ1S0000C0','3','D','15','1',NULL,'Transaction Code',NULL,NULL,'"114"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EXIQ1S0000C0','2','D','15','4',NULL,'Sequence Code',NULL,NULL,'"01"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EXIQ1S0000C0','6','D','15','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EXIQ1S0000C0','3','D','15','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EXIQ1S0000C0','9','D','15','15',NULL,'Participant ID',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EXIQ1S0000C0','12','D','15','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EXIQ1S0000C0','2','D','15','36',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EXIQ1S0000C0','1','D','15','38',NULL,'Source 1',NULL,NULL,'"A"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EXIQ1S0000C0','9','D','15','39',NULL,'Contribution Amount',NULL,NULL,'"drvPretaxNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EXIQ1S0000C0','2','D','15','48',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EXIQ1S0000C0','1','D','15','50',NULL,'Source 2',NULL,NULL,'"6"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EXIQ1S0000C0','9','D','15','51',NULL,'Contribution Amount',NULL,NULL,'"drvPretaxMatch_2NOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EXIQ1S0000C0','2','D','15','60',NULL,'Investment',NULL,NULL,'"**"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EXIQ1S0000C0','1','D','15','62',NULL,'Source 3',NULL,NULL,'"J"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EXIQ1S0000C0','9','D','15','63',NULL,'Contribution Amount',NULL,NULL,'"drvRothNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EXIQ1S0000C0','2','D','15','72',NULL,'Investment',NULL,NULL,'"drvInvestment3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EXIQ1S0000C0','1','D','15','74',NULL,'Source 4',NULL,NULL,'"drvSource4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EXIQ1S0000C0','9','D','15','75',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt4NOP"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EXIQ1S0000C0','2','D','15','84',NULL,'Investment',NULL,NULL,'"drvInvestment4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EXIQ1S0000C0','1','D','15','86',NULL,'Source 5',NULL,NULL,'"drvSource5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EXIQ1S0000C0','9','D','15','87',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EXIQ1S0000C0','2','D','15','96',NULL,'Investment',NULL,NULL,'"drvInvestment5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EXIQ1S0000C0','1','D','15','98',NULL,'Source 6',NULL,NULL,'"drvSource6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EXIQ1S0000C0','9','D','15','99',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EXIQ1S0000C0','8','D','15','108',NULL,'Pay Period End Date',NULL,NULL,'"drvPeriodEnd"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EXIQ1S0000C0','1','D','15','116',NULL,'Insider Trader',NULL,NULL,'"drvInsiderTrader"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EXIQ1S0000C0','4','D','15','117',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EXIQ1S0000C0','30','D','15','121',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EXIQ1S0000C0','30','D','15','151',NULL,'Address 1',NULL,NULL,'"drvAddress1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EXIQ1S0000C0','30','D','15','181',NULL,'Address 2',NULL,NULL,'"drvAddress2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EXIQ1S0000C0','18','D','15','211',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EXIQ1S0000C0','2','D','15','229',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EXIQ1S0000C0','9','D','15','231',NULL,'ZipCode',NULL,NULL,'"drvZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EXIQ1S0000C0','8','D','15','240',NULL,'Date of Birth',NULL,NULL,'"drvDOB"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EXIQ1S0000C0','8','D','15','248',NULL,'Original Date of Hire',NULL,NULL,'"drvODOH"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EXIQ1S0000C0','8','D','15','256',NULL,'Adj. Date of Hire',NULL,NULL,'"drvADOH"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EXIQ1S0000C0','1','D','15','264',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EXIQ1S0000C0','1','D','15','265',NULL,'Gender Code',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EXIQ1S0000C0','2','D','15','266',NULL,'EE Status',NULL,NULL,'"drvEmplStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EXIQ1S0000C0','8','D','15','268',NULL,'Employee Status Date',NULL,NULL,'"drvEmplStatusDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EXIQ1S0000C0','1','D','15','276',NULL,'Payroll Frequency',NULL,NULL,'"drvFrequency"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EXIQ1S0000C0','8','D','15','277',NULL,'Years of Service',NULL,NULL,'"00000000"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EXIQ1S0000C0','6','D','15','285',NULL,'YTD Hours of Service',NULL,NULL,'"drvHrsOfService"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EXIQ1S0000C0','6','D','15','291',NULL,'Current Pay Period Hours Worked',NULL,NULL,'"drvCurHrsNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EXIQ1S0000C0','15','D','15','297',NULL,'Current Pay Period Gross Pay',NULL,NULL,'"drvCurGrossNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EXIQ1S0000C0','15','D','15','312',NULL,'Current Eligible Gross Pay ''Source 1''',NULL,NULL,'"drvCurEligGrossNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EXIQ1S0000C0','11','D','15','327',NULL,'Current Pay Period W-2 Pay',NULL,NULL,'"drvCurW2TaxableNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EXIQ1S0000C0','8','D','15','338',NULL,'Anniversary Date',NULL,NULL,'"drvAnniversary"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EXIQ1S0000C0','6','D','15','346',NULL,'Anniversary Hours',NULL,NULL,'"drvAnniversaryHrs"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EXIQ1S0000C0','8','D','15','352',NULL,'Check Date',NULL,NULL,'"drvPayDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EXIQ1S0000C0','13','D','15','360',NULL,'Employee ID/Code',NULL,NULL,'"drvEmpIDCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EXIQ1S0000C0','4','D','15','373',NULL,'Div/Sub',NULL,NULL,'"drvDivSub"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EXIQ1S0000C0','10','D','15','377',NULL,'Employer Location Code',NULL,NULL,'"drvERLocCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EXIQ1S0000C0','8','D','15','387',NULL,'Location Effective Date',NULL,NULL,'"drvLocEffDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EXIQ1S0000C0','1','D','15','395',NULL,'Group Indicator',NULL,NULL,'"drvGroupInd"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EXIQ1S0000C0','10','D','15','396',NULL,'Never Eligible',NULL,NULL,'"drvNeverElig"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EXIQ1S0000C0','5','D','15','406',NULL,'Eligible to Participate in EE Sources',NULL,NULL,'"drvEligEESources"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EXIQ1S0000C0','5','D','15','411',NULL,'Eligible to Participate in ER Sources',NULL,NULL,'"drvEligERSources"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EXIQ1S0000C0','8','D','15','416',NULL,'Eligibility Date',NULL,NULL,'"drvEligDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EXIQ1S0000C0','1','D','15','424',NULL,'Auto Enrollment Decline Indicator',NULL,NULL,'"drvAutoEnroll"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EXIQ1S0000C0','5','D','15','425',NULL,'Deferral Rate for Source 1',NULL,NULL,'"drvDefRate"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EXIQ1S0000C0','15','D','15','430',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EXIQ1S0000C0','11','D','15','445',NULL,'Cash Bonus',NULL,NULL,'"drvCashBonus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EXIQ1S0000C0','1','D','15','456',NULL,'HCE Indicator',NULL,NULL,'"drvHCEInd"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EXIQ1S0000C0','1','D','15','457',NULL,'Union Employee',NULL,NULL,'"drvUnionEE"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EXIQ1S0000C0','11','D','15','458',NULL,'Market Salary',NULL,NULL,'"drvMarketSalNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EXIQ1S0000C0','8','D','15','469',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EXIQ1S0000C0','15','D','15','477',NULL,'YTD Gross Pay/415/HCE/414 Compensation',NULL,NULL,'"drvYTDGrossNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EXIQ1S0000C0','1','D','15','492',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EXIQ1S0000C0','15','D','15','493',NULL,'Deferral & Plan Limit Compensation',NULL,NULL,'"drvDefLimitCompNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EXIQ1S0000C0','1','D','15','508',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EXIQ1S0000C0','15','D','15','509',NULL,'Current Eligible Gross Pay ''Source 2''',NULL,NULL,'"drvCurEligGrossSource2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EXIQ1S0000C0','1','D','15','524',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EXIQ1S0000C0','15','D','15','525',NULL,'ADP & Plan Compensation',NULL,NULL,'"drvADPPlanComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EXIQ1S0000C0','1','D','15','540',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EXIQ1S0000C0','15','D','15','541',NULL,'Current Eligible Gross Pay ''Source 3''',NULL,NULL,'"drvCurEligGrossSource3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EXIQ1S0000C0','1','D','15','556',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EXIQ1S0000C0','15','D','15','557',NULL,'ER Match Compensation',NULL,NULL,'"drvERMatchComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EXIQ1S0000C0','1','D','15','572',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EXIQ1S0000C0','11','D','15','573',NULL,'ACP Compensation',NULL,NULL,'"drvACPComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EXIQ1S0000C0','1','D','15','584',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EXIQ1S0000C0','11','D','15','585',NULL,'Excluded Compensation',NULL,NULL,'"drvExclComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EXIQ1S0000C0','1','D','15','596',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EXIQ1S0000C0','11','D','15','597',NULL,'Top Heavy 401(a) Compensation',NULL,NULL,'"drv401A"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EXIQ1S0000C0','1','D','15','608',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EXIQ1S0000C0','11','D','15','609',NULL,'EE Post Tax Compensation',NULL,NULL,'"drvEEPostComp"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EXIQ1S0000C0','1','D','15','620',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EXIQ1S0000C0','2','D','15','621',NULL,'Sub Status',NULL,NULL,'"drvSubStatus"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EXIQ1S0000C0','1','D','15','623',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EXIQ1S0000C0','8','D','15','624',NULL,'Sub Status Date',NULL,NULL,'"drvSubStatusDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EXIQ1S0000C0','40','D','15','632',NULL,'Participant''s Email Address',NULL,NULL,'"drvEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EXIQ1S0000C0','3','D','40','1',NULL,'Transaction Code',NULL,NULL,'"385"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EXIQ1S0000C0','2','D','40','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EXIQ1S0000C0','6','D','40','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumberLoan"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EXIQ1S0000C0','3','D','40','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EXIQ1S0000C0','9','D','40','15',NULL,'Participant ID',NULL,NULL,'"drvSSNLoan"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EXIQ1S0000C0','6','D','40','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EXIQ1S0000C0','1','D','40','30',NULL,'Date Expected Override',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EXIQ1S0000C0','3','D','40','31',NULL,'Loan Number',NULL,NULL,'"drvLoanNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EXIQ1S0000C0','1','D','40','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EXIQ1S0000C0','9','D','40','35',NULL,'Loan Repayment Amount',NULL,NULL,'"drvLoanAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EXIQ1S0000C0','10','D','40','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EXIQ1S0000C0','1','D','40','54',NULL,'Loan Payment Override',NULL,NULL,'"2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EXIQ1S0000C0','3','D','40','55',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EXIQ1S0000C0','4','D','40','58',NULL,'Loan Payroll Code',NULL,NULL,'"PDED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EXIQ1S0000C0','19','D','40','62',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EXIQ1S0000C0','4','D','40','81',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanLoan"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EXIQ1S0000C0','587','D','40','85',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EXIQ1S0000C0','3','D','45','1',NULL,'Transaction Code',NULL,NULL,'"385"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EXIQ1S0000C0','2','D','45','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EXIQ1S0000C0','6','D','45','6',NULL,'Plan Number',NULL,NULL,'"drvPlanNumberLoan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EXIQ1S0000C0','3','D','45','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EXIQ1S0000C0','9','D','45','15',NULL,'Participant ID',NULL,NULL,'"drvSSNLoan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EXIQ1S0000C0','6','D','45','24',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EXIQ1S0000C0','1','D','45','30',NULL,'Date Expected Override',NULL,NULL,'"1"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EXIQ1S0000C0','3','D','45','31',NULL,'Loan Number',NULL,NULL,'"drvLoanNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EXIQ1S0000C0','1','D','45','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EXIQ1S0000C0','9','D','45','35',NULL,'Loan Repayment Amount',NULL,NULL,'"drvLoanAmtNOP"','(''UNT2''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EXIQ1S0000C0','10','D','45','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EXIQ1S0000C0','1','D','45','54',NULL,'Loan Payment Override',NULL,NULL,'"2"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EXIQ1S0000C0','3','D','45','55',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EXIQ1S0000C0','4','D','45','58',NULL,'Loan Payroll Code',NULL,NULL,'"PDED"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EXIQ1S0000C0','19','D','45','62',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EXIQ1S0000C0','4','D','45','81',NULL,'Sub Plan Number',NULL,NULL,'"drvSubPlanLoan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EXIQ1S0000C0','587','D','45','85',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EXIQ1S0000C0','3','T','90','1',NULL,'Record Type',NULL,NULL,'"999"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EXIQ1S0000C0','10','T','90','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EXIQ1S0000C0','10','T','90','14',NULL,'Client Identifier',NULL,NULL,'"drvClientIDTrl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EXIQ1S0000C0','8','T','90','24',NULL,'File Creation date',NULL,NULL,'"drvCreationDateTrl"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EXIQ1S0000C0','6','T','90','32',NULL,'File Creation Time',NULL,NULL,'"drvCreationTimeTrl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EXIQ1S0000C0','9','T','90','38',NULL,'Detail Record Count',NULL,NULL,'"drvRecordCount"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EXIQ1S0000C0','1','T','90','47',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EXIQ1S0000C0','11','T','90','48',NULL,'Total Contribution Amount',NULL,NULL,'"drvTotalCont"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EXIQ1S0000C0','1','T','90','59',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EXIQ1S0000C0','11','T','90','60',NULL,'Loan Repayment Amount',NULL,NULL,'"drvTotalLoanAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EXIQ1S0000C0','601','T','90','71',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EXIQ1S0000C0','3','T','93','1',NULL,'Record Type',NULL,NULL,'"999"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EXIQ1S0000C0','10','T','93','4',NULL,'File Type',NULL,NULL,'"COMBINED"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EXIQ1S0000C0','10','T','93','14',NULL,'Client Identifier',NULL,NULL,'"drvClientIDTrl"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EXIQ1S0000C0','8','T','93','24',NULL,'File Creation date',NULL,NULL,'"drvCreationDateTrl"','(''UD112''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EXIQ1S0000C0','6','T','93','32',NULL,'File Creation Time',NULL,NULL,'"drvCreationTimeTrl"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EXIQ1S0000C0','9','T','93','38',NULL,'Detail Record Count',NULL,NULL,'"drvRecordCount"','(''UN00''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EXIQ1S0000C0','1','T','93','47',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EXIQ1S0000C0','11','T','93','48',NULL,'Total Contribution Amount',NULL,NULL,'"drvTotalCont"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EXIQ1S0000C0','1','T','93','59',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EXIQ1S0000C0','11','T','93','60',NULL,'Loan Repayment Amount',NULL,NULL,'"drvTotalLoanAmt"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EXIQ1S0000C0','601','T','93','71',NULL,'Filler',NULL,NULL,'""','(''SS''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EPRUDTTTC3_20230811.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empower 401K Export CSV','202307239','EMPEXPORT','ONDEM_XOE','Jul 24 2023  9:07AM','EPRUDTTTC3',NULL,NULL,NULL,'202307239','Jul 23 2023 12:00AM','Dec 30 1899 12:00AM','202307171','55976',NULL,NULL,'202307171',dbo.fn_GetTimedKey(),NULL,'CFORT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Empower 401K','202209259','EMPEXPORT','SCH_PRU402','Oct  7 2022  4:42PM','EPRUDTTTC3',NULL,NULL,NULL,'202209259','Sep 25 2022 12:00AM','Dec 30 1899 12:00AM','202209191','55950',NULL,NULL,'202209191',dbo.fn_GetTimedKey(),NULL,'us3cPeROL1002',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','202307179','EMPEXPORT','TEST_XOE','Jul 26 2023  1:56PM','EPRUDTTTC3',NULL,NULL,NULL,'202307179','Jul 17 2023 12:00AM','Dec 30 1899 12:00AM','202307111','54176',NULL,NULL,'202307111',dbo.fn_GetTimedKey(),NULL,'us3lKiROL1002',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTTC3','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTTC3','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTTC3','MultFile','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTTC3','SubSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTTC3','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTTC3','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTTC3','UDESPath','C','\\us.saas\E0\data_exchange\ROL1002\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTTC3','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDTTTC3','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTTC3','H01','dbo.U_EPRUDTTTC3_Header_H01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTTC3','D10','dbo.U_EPRUDTTTC3_drvTbl_D10',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTTC3','D15','dbo.U_EPRUDTTTC3_drvTbl_D10',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTTC3','D40','dbo.U_EPRUDTTTC3_drvTbl_D40',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTTC3','D45','dbo.U_EPRUDTTTC3_drvTbl_D40',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTTC3','T90','dbo.U_EPRUDTTTC3_Trailer_T90',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDTTTC3','T93','dbo.U_EPRUDTTTC3_Trailer_T90',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EPRUDTTTC3_Audit
-----------

IF OBJECT_ID('U_EPRUDTTTC3_Audit') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_Audit] (
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
-- Create table U_EPRUDTTTC3_AuditFields
-----------

IF OBJECT_ID('U_EPRUDTTTC3_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EPRUDTTTC3_DedList
-----------

IF OBJECT_ID('U_EPRUDTTTC3_DedList') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EPRUDTTTC3_drvTbl_D10
-----------

IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D10') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D10] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvDedGroupCode] char(5) NULL,
    [Pretax] decimal NOT NULL,
    [Roth] decimal NOT NULL,
    [WalthamMatch] decimal NOT NULL,
    [CurHrs] decimal NOT NULL,
    [CurGross] decimal NOT NULL,
    [CurEligGross] decimal NOT NULL,
    [CurW2Taxable] money NOT NULL,
    [YTDGross] decimal NOT NULL,
    [PreTaxMatch] decimal NOT NULL,
    [DefLimitComp] decimal NOT NULL,
    [drvPretaxMatch_2] varchar(30) NULL,
    [drvPretaxMatch_2NOP] decimal NOT NULL,
    [drvPlanNumber] varchar(6) NOT NULL,
    [drvSSN2] char(11) NULL,
    [drvPretax] varchar(30) NULL,
    [drvRoth] varchar(30) NULL,
    [drvPretaxNOP] decimal NOT NULL,
    [drvRothNOP] decimal NOT NULL,
    [drvInvestment3] varchar(2) NOT NULL,
    [drvSource4] varchar(1) NOT NULL,
    [drvContAmt4] varchar(30) NULL,
    [drvContAmt4NOP] decimal NOT NULL,
    [drvInvestment4] varchar(1) NOT NULL,
    [drvSource5] varchar(1) NOT NULL,
    [drvContAmt5] varchar(1) NOT NULL,
    [drvInvestment5] varchar(1) NOT NULL,
    [drvSource6] varchar(1) NOT NULL,
    [drvContAmt6] varchar(1) NOT NULL,
    [drvPeriodEnd] varchar(8) NULL,
    [drvInsiderTrader] varchar(1) NOT NULL,
    [drvSubPlanNumber] varchar(4) NOT NULL,
    [drvName] varchar(max) NULL,
    [drvAddress1] varchar(8000) NULL,
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
    [drvCurHrs] varchar(30) NULL,
    [drvCurGross] varchar(30) NULL,
    [drvCurEligGross] varchar(30) NULL,
    [drvCurW2Taxable] varchar(30) NULL,
    [drvCurHrsNOP] decimal NOT NULL,
    [drvCurGrossNOP] decimal NOT NULL,
    [drvCurEligGrossNOP] decimal NULL,
    [drvCurW2TaxableNOP] money NOT NULL,
    [drvAnniversary] varchar(1) NOT NULL,
    [drvAnniversaryHrs] varchar(1) NOT NULL,
    [drvPayDate] varchar(8) NULL,
    [drvEmpIDCode] varchar(15) NULL,
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
    [drvMarketSal] varchar(30) NULL,
    [drvMarketSalNOP] money NOT NULL,
    [drvRehireDate] varchar(8) NULL,
    [drvYTDGross] varchar(30) NULL,
    [drvDefLimitComp] varchar(30) NULL,
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
-- Create table U_EPRUDTTTC3_drvTbl_D20
-----------

IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D20') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D20] (
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
    [drvEmpIDCode_2] varchar(15) NULL,
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
-- Create table U_EPRUDTTTC3_drvTbl_D30
-----------

IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D30') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D30] (
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
    [drvEmpIDCode_3] varchar(15) NULL,
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
-- Create table U_EPRUDTTTC3_drvTbl_D40
-----------

IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D40') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D40] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvDedGroupCode] char(5) NULL,
    [LoanAmt] decimal NULL,
    [drvPlanNumberLoan] varchar(6) NOT NULL,
    [drvSSNLoan] char(11) NULL,
    [drvLoanNumber] varchar(max) NULL,
    [drvLoanAmt] varchar(30) NULL,
    [drvLoanAmtNOP] decimal NOT NULL,
    [drvSubPlanLoan] varchar(4) NOT NULL
);

-----------
-- Create table U_EPRUDTTTC3_drvTbl_D50
-----------

IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D50') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D50] (
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
-- Create table U_EPRUDTTTC3_drvTbl_D60
-----------

IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D60') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_drvTbl_D60] (
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
-- Create table U_EPRUDTTTC3_EEList
-----------

IF OBJECT_ID('U_EPRUDTTTC3_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EPRUDTTTC3_File
-----------

IF OBJECT_ID('U_EPRUDTTTC3_File') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EPRUDTTTC3_Header_H01
-----------

IF OBJECT_ID('U_EPRUDTTTC3_Header_H01') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_Header_H01] (
    [drvClientID] varchar(6) NOT NULL,
    [drvCreateDate] varchar(8) NULL,
    [drvCreateTime] varchar(6) NULL
);

-----------
-- Create table U_EPRUDTTTC3_Header_H02
-----------

IF OBJECT_ID('U_EPRUDTTTC3_Header_H02') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_Header_H02] (
    [drvClientID2] varchar(6) NOT NULL,
    [drvCreateDate2] varchar(8) NULL,
    [drvCreateTime2] varchar(6) NULL
);

-----------
-- Create table U_EPRUDTTTC3_Header_H03
-----------

IF OBJECT_ID('U_EPRUDTTTC3_Header_H03') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_Header_H03] (
    [drvClientID3] varchar(6) NOT NULL,
    [drvCreateDate3] varchar(8) NULL,
    [drvCreateTime3] varchar(6) NULL
);

-----------
-- Create table U_EPRUDTTTC3_LOASubStatus
-----------

IF OBJECT_ID('U_EPRUDTTTC3_LOASubStatus') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_LOASubStatus] (
    [subLOAEEID] char(12) NULL,
    [subLOACOID] char(5) NULL,
    [subLOASubStatus] varchar(2) NULL,
    [subLOASubStatusDate] varchar(8) NULL
);

-----------
-- Create table U_EPRUDTTTC3_PDedHist
-----------

IF OBJECT_ID('U_EPRUDTTTC3_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource1] decimal NULL,
    [PdhSource2] decimal NULL,
    [PdhSource4] decimal NULL,
    [PdhSource5] decimal NULL,
    [PdhSource6] decimal NULL
);

-----------
-- Create table U_EPRUDTTTC3_PDedHist_YTD
-----------

IF OBJECT_ID('U_EPRUDTTTC3_PDedHist_YTD') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_PDedHist_YTD] (
    [YTDEEID] char(12) NOT NULL,
    [YTDPdhSource4] decimal NULL
);

-----------
-- Create table U_EPRUDTTTC3_PDedLoans
-----------

IF OBJECT_ID('U_EPRUDTTTC3_PDedLoans') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_PDedLoans] (
    [PdhEEID] char(12) NOT NULL,
    [PdhLoans] decimal NULL,
    [PdhLoanCodes] char(5) NULL
);

-----------
-- Create table U_EPRUDTTTC3_PEarHist
-----------

IF OBJECT_ID('U_EPRUDTTTC3_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_PEarHist] (
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
-- Create table U_EPRUDTTTC3_RLSubStatus
-----------

IF OBJECT_ID('U_EPRUDTTTC3_RLSubStatus') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_RLSubStatus] (
    [subRLEEID] varchar(255) NOT NULL,
    [subRLSubStatus] varchar(2) NOT NULL,
    [subRLSubStatusDate] datetime NOT NULL
);

-----------
-- Create table U_EPRUDTTTC3_Sign
-----------

IF OBJECT_ID('U_EPRUDTTTC3_Sign') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_Sign] (
    [sValue] varchar(2) NULL,
    [sDigit] varchar(1) NULL
);

-----------
-- Create table U_EPRUDTTTC3_SubStatus
-----------

IF OBJECT_ID('U_EPRUDTTTC3_SubStatus') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_SubStatus] (
    [subEEID] varchar(255) NOT NULL,
    [subSubStatus] varchar(2) NOT NULL
);

-----------
-- Create table U_EPRUDTTTC3_TaxWages
-----------

IF OBJECT_ID('U_EPRUDTTTC3_TaxWages') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_TaxWages] (
    [PthTaxCode] char(8) NOT NULL,
    [PthEEID] char(12) NOT NULL,
    [PthCurFITWages] money NULL
);

-----------
-- Create table U_EPRUDTTTC3_Trailer_T90
-----------

IF OBJECT_ID('U_EPRUDTTTC3_Trailer_T90') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_Trailer_T90] (
    [drvClientIDTrl] varchar(10) NULL,
    [drvCreationDateTrl] varchar(8) NULL,
    [drvCreationTimeTrl] varchar(6) NULL,
    [drvRecordCount] int NULL,
    [drvTotalCont] varchar(30) NULL,
    [drvTotalLoanAmt] varchar(11) NULL
);

-----------
-- Create table U_EPRUDTTTC3_Trailer_T91
-----------

IF OBJECT_ID('U_EPRUDTTTC3_Trailer_T91') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_Trailer_T91] (
    [drvClientIDTrl_2] varchar(10) NULL,
    [drvCreationDateTrl_2] varchar(8) NULL,
    [drvCreationTimeTrl_2] varchar(6) NULL,
    [drvRecordCount_2] int NULL,
    [drvTotalCont_2] varchar(30) NULL,
    [drvTotalLoanAmt_2] varchar(11) NULL
);

-----------
-- Create table U_EPRUDTTTC3_Trailer_T92
-----------

IF OBJECT_ID('U_EPRUDTTTC3_Trailer_T92') IS NULL
CREATE TABLE [dbo].[U_EPRUDTTTC3_Trailer_T92] (
    [drvClientIDTrl_3] varchar(10) NULL,
    [drvCreationDateTrl_3] varchar(8) NULL,
    [drvCreationTimeTrl_3] varchar(6) NULL,
    [drvRecordCount_3] int NULL,
    [drvTotalCont_3] varchar(30) NULL,
    [drvTotalLoanAmt_3] varchar(11) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDTTTC3]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rollins Inc

Created By: Robert Dulaney
Business Analyst: Patrick Clare
Create Date: 07/13/2018
Service Request Number: SR-2017-00177851

Purpose: Empower 401K Export CSV 

Revision History
----------------
Update By           Date           Request Num                Desc
Nicci Blady         05/30/2019     SR-2019-00234349           Updates to formatting, selection criteria
Anthony Ramos       10/15/2019     SF 15656661                Updated overpunch join
Cyndi Diaz          05/21/2020     SR-2020-00271189           Migrated from CLA1016 - Clark Pest Control of Stockton, Inc. 
David Miller        11/24/2020     SR-2020-00293386           Add deduction group NWEST, update loan number logic, update LOA date logic
Darren Collard      12/08/2021     TekP-2021-10-11-0002       Update Investment, Source2 and include 401KM 
Darren Collard      04/23/2022     TekP-2022-02-28-03         Update fields "Insider Trader" and "Employee ID/Code"
Darren Collard      07/10/2022     TekP-2022-02-28-03         Remove "Filler" from H03, Coded Trailer Contribution
Darren Collard      09/18/2022     TekP-2022-08-31-001        Merge exports to single file

Marie Waters        07/24/2023     TekP-2023-06-22-02         Added code for audit params and separated out the loan values
Lea King            08/07/2023       TekP-2023-06-22-02          Changed word Prudential to Empower   
Marie Waters		08/11/2023	   TekP-2023-06-22-02         Created EPRUDTTTC3 to puopulate the old CSV data. EPRUDTTTC2 is the data sent to Empower 

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRUDTTTC3';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRUDTTTC3';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRUDTTTC3';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRUDTTTC3';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRUDTTTC3' ORDER BY RunID DESC;


--Update Drive Mappings in U_DSI_Configuration
---------------------------------------------------
SELECT * FROM dbo.U_DSI_Configuration WHERE cfgname like '%path%' order by 4
--TEST--
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\nz\Public\ROL1002\Exports_Test\Empower_401K_Export\' WHERE formatcode = 'EPRUDTTTC3' AND cfgname = 'ExportPath';
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\nz\Public\ROL1002\Exports_Test\Empower_401K_Export\' WHERE formatcode = 'EPRUDTTTC3' AND cfgname = 'TestPath';
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\nz\Public\ROL1002\Exports_Test\Empower_401K_Export\' WHERE formatcode = 'EPRUDTTTC3' AND cfgname = 'UDESPath';

--PROD--
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\E4\Public\ROL1002\Exports\Empower_401K_Export\' WHERE formatcode = 'EPRUDTTTC3' AND cfgname = 'ExportPath';
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\E4\Public\ROL1002\Exports\Empower_401K_Export\' WHERE formatcode = 'EPRUDTTTC3' AND cfgname = 'TestPath';
update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\E4\Public\ROL1002\Exports\Empower_401K_Export\' WHERE formatcode = 'EPRUDTTTC3' AND cfgname = 'UDESPath';
--update dbo.U_DSI_Configuration SET cfgvalue = '\\us.saas\E0\data_exchange\ROL1002\Exports\'               WHERE formatcode = 'EPRUDTTTC3' AND cfgname = 'UDESPath';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTTC3', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTTC3', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTTC3', 'SCH_PRU402';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRUDTTTC3';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EPRUDTTTC3', @AllObjects = 'Y', @IsWeb = 'Y';

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
    SELECT @FormatCode = 'EPRUDTTTC3';
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
    DELETE FROM dbo.U_EPRUDTTTC3_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRUDTTTC3_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Cleans EE List of Where EecUDField14 = 'Y'
    DELETE FROM dbo.U_EPRUDTTTC3_EEList
    WHERE xEEID IN (SELECT EecEEID FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecUDField14 = 'Y');

    -- Cleans EE List with EEs in the Ded Group DG01,DG02,NONE,NOBEN,DG03 
    DELETE FROM dbo.U_EPRUDTTTC3_EEList
    WHERE xEEID IN (SELECT EecEEID FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecDedGroupCode IN ('DG01','DG02','NONE','NOBEN','DG03'));

    -- Cleans out EEs terminated more than 18 months ago
    --DELETE FROM dbo.U_EPRUDTTTC3_EEList
    --WHERE xEEID IN (SELECT EecEEID FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecDateOfTermination < DATEADD(MONTH,-18,@EndDate))     --SR-2019-00234349 05/30/2019

    -- Cleans out Test Employees
    DELETE FROM dbo.U_EPRUDTTTC3_EEList
    WHERE xEEID IN (SELECT EepEEID FROM dbo.EmpPers WITH (NOLOCK) WHERE EepNameLast = 'Hiring Manager')   --6/24 - remove OR EepNameLast = 'MANAGER' per Eric Sweet

    --==========================================
    -- Audit Section
    --==========================================
    --IF OBJECT_ID('U_EPRUDTTTC3_Audit','U') IS NOT NULL
    --    DROP TABLE dbo.U_EPRUDTTTC3_Audit;
    --SELECT 
    --     audEEID = audKey1Value
    --    ,audKey2 = audKey2Value
    --    ,audKey3 = audKey3Value
    --    ,audTableName
    --    ,audFieldName
    --    ,audAction
    --    ,audDateTime
    --    ,audOldValue
    --    ,audNewValue
    --    ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    --INTO dbo.U_EPRUDTTTC3_Audit
    --FROM dbo.vw_AuditData WITH (NOLOCK) 
    --WHERE audDateTime BETWEEN @StartDate AND @EndDate
    --AND audFieldName = 'EmpComp' 
    --AND audFieldName = 'EecEmplStatus'
    --AND audAction   <> 'DELETE';

     --==========================================
    -- Audit Section                                -- MW updated this section from the code above due to no audit data being populated
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EPRUDTTTC3_AuditFields','U') IS NOT NULL --this was missing from above
        DROP TABLE dbo.U_EPRUDTTTC3_AuditFields; --this was missing from above
    CREATE TABLE dbo.U_EPRUDTTTC3_AuditFields (aTableName varchar(30),aFieldName varchar(30)); --this was missing from above

     INSERT INTO dbo.U_EPRUDTTTC3_AuditFields VALUES ('EmpComp','EecEmplStatus'); --this was missing from above

    IF OBJECT_ID('U_EPRUDTTTC3_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_Audit;
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

    INTO dbo.U_EPRUDTTTC3_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EPRUDTTTC3_AuditFields WITH (NOLOCK)  --this was missing from above
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction   <> 'DELETE';


    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EPRUDTTTC3_Audit ON dbo.U_EPRUDTTTC3_Audit (audEEID,audKey2);


    --==========================================
    -- Create List of Sub Status Codes
    --==========================================
    IF OBJECT_ID('U_EPRUDTTTC3_RLSubStatus','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_RLSubStatus;
    SELECT DISTINCT
          subRLEEID = audEEID
         ,subRLSubStatus = 'RL'
         ,subRLSubStatusDate = audDateTime
    INTO dbo.U_EPRUDTTTC3_RLSubStatus
    FROM dbo.U_EPRUDTTTC3_Audit
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

    IF OBJECT_ID('U_EPRUDTTTC3_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPRUDTTTC3_DedList
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



    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --Convert Pdh values to DECIMAL(12,2) values
    IF OBJECT_ID('dbo.U_EPRUDTTTC3_PDedHist','U') IS NOT NULL
            DROP TABLE dbo.U_EPRUDTTTC3_PDedHist;
     SELECT DISTINCT
         PdhEEID
         
        -- EE Cur Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K','401KC','RPBK','RCUBK','G401K','G401C','GPBK','GCUBK','W401K','W401C','WPBK','WCUBK') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- EE Pretax
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH','ROTHC','RRBK','RRCUB','GRBK','GRCUB','GROTH','GRTCU','WRBK','WRCUB','WROTH','WRTHC') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- Roth Ded
      --  ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('401KL','G401L','401L2','GLNBK','RLNBK','W401L','WLNBK') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- EE LOAN AMOUNTS
        --,PdhSource3Codes     = MAX(CASE WHEN PdhDedCode IN ('401KL','G401L','401L2','GLNBK','RLNBK','W401L','WLNBK') THEN PdhDedCode END) -- EE LOAN AMOUNTS
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('DCSAL','DCBON') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- ADP Test Pay / DC Covered Pay
        -- ER Cur Match Amounts
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('G401M') THEN ISNULL(CONVERT(DECIMAL(12,2), PdhERCurAmt), 0) ELSE 0.00 END) -- ER Pretax Match Waltham
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('W401M','401KM') THEN ISNULL(CONVERT(DECIMAL(12,2), PdhERCurAmt), 0) ELSE 0.00 END) -- ER Pretax Match
    INTO dbo.U_EPRUDTTTC3_PDedHist  --select * from dbo.U_EPRUDTTTC3_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRUDTTTC3_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00           --SR-2019-00234349 05/30/2019
    --    OR SUM(PdhERCurAmt) <> 0.00
    --)
    ;


        IF OBJECT_ID('dbo.U_EPRUDTTTC3_PDedLoans','U') IS NOT NULL
            DROP TABLE dbo.U_EPRUDTTTC3_PDedLoans;
     SELECT DISTINCT
         PdhEEID         
        ,PdhLoans    = SUM(CASE WHEN PdhDedCode IN ('401KL','G401L','401L2','GLNBK','RLNBK','W401L','WLNBK') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- EE LOAN AMOUNTS
        ,PdhLoanCodes     = MAX(CASE WHEN PdhDedCode IN ('401KL','G401L','401L2','GLNBK','RLNBK','W401L','WLNBK') THEN PdhDedCode END) -- EE LOAN AMOUNTS
  
    INTO dbo.U_EPRUDTTTC3_PDedLoans  --select * from dbo.U_EPRUDTTTC3_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRUDTTTC3_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID, PdhDedCode
    
    ;

    IF OBJECT_ID('U_EPRUDTTTC3_PDedHist_YTD','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_PDedHist_YTD;
    SELECT DISTINCT
         YTDEEID           = PdhEEID
        -- YTD EE Cur Amounts
        ,YTDPdhSource4     = SUM(CASE WHEN PdhDedCode IN ('DCSAL','DCBON') THEN CONVERT(DECIMAL(12,2), PdhEECurAmt) ELSE 0.00 END) -- ADP Test Pay / DC Covered Pay
    INTO dbo.U_EPRUDTTTC3_PDedHist_YTD
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRUDTTTC3_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00            --SR-2019-00234349 05/30/2019
    --    OR SUM(PdhERCurAmt) <> 0.00
    --)
    ;


     UPDATE dbo.U_dsi_BDM_EmpDeductions
        SET  EedValidForExport = 'Y'
    FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    JOIN dbo.U_EPRUDTTTC3_PDedLoans WITH (NOLOCK)
        ON PdhEEID = EedEEID
    WHERE DedDedType = 'LON'
    AND PdhLoans <> 0.00
    AND EedValidForExport = 'N'
    AND EedFormatCode = @FormatCode
    AND EedStopdate >= @StartDate
    -----------------------------
    -- Working Table - Taxable Wages
    -----------------------------
    IF OBJECT_ID('U_EPRUDTTTC3_TaxWages','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_TaxWages;
    SELECT 
        PthTaxCode = PthTaxCode,
        PthEEID = PthEEID,
        PthCurFITWages = SUM(PthCurTaxableWages)
    INTO dbo.U_EPRUDTTTC3_TaxWages
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
    IF OBJECT_ID('U_EPRUDTTTC3_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_PEarHist;
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
    INTO dbo.U_EPRUDTTTC3_PEarHist  --select * from dbo.U_EPRUDTTTC3_PEarHist where pehcuramt < 0.00
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
    IF OBJECT_ID('U_EPRUDTTTC3_LOASubStatus','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_LOASubStatus;
    SELECT DISTINCT
          subLOAEEID = xEEID
         ,subLOACOID = xCOID
         ,subLOASubStatus = CASE WHEN OriginalLOADate <= @EndDate OR audDateTime IS NOT NULL THEN 'UL' END
         ,subLOASubStatusDate = CASE WHEN OriginalLOADate <= @EndDate THEN CONVERT(VARCHAR(8),OriginalLOADate,112)
                                     WHEN audDateTime IS NOT NULL THEN CONVERT(VARCHAR(8),audDateTime,112)
                                END
    INTO dbo.U_EPRUDTTTC3_LOASubStatus
    FROM dbo.U_EPRUDTTTC3_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.U_EPRUDTTTC3_Audit WITH (NOLOCK)
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
    SELECT @PayDate = MAX(PrgPayDate) FROM dbo.U_EPRUDTTTC3_PEarHist WITH (NOLOCK);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDTTTC3_drvTbl_D10 and U_EPRUDTTTC3_drvTbl_D15 - DEFERRAL DETAIL - ROLLINS
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D10','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_drvTbl_D10;

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = EepSSN
        ,drvDedGroupCode = EecDedGroupCode
        ,Pretax = ISNULL(PdhSource1,0)
        ,Roth = ISNULL(PdhSource2,0)
        ,WalthamMatch = ISNULL(PdhSource5,0)
        ,CurHrs = ISNULL(PehCurHrs,0)
        ,CurGross = ISNULL(PehCurAmt,0)
        ,CurEligGross = ISNULL(PehCurAmt - PdhSource4,0)
        ,CurW2Taxable = ISNULL(PthCurFITWages,0)
        ,YTDGross = ISNULL(PehCurAmtYTD,0)
        ,PreTaxMatch = ISNULL(PdhSource6,0)
        ,DefLimitComp = ISNULL(PehInclInDefCompYTD - YTDPdhSource4,0)
        ,drvPretaxMatch_2   = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PdhSource6,0),9)
        ,drvPretaxMatch_2NOP   = ISNULL(PdhSource6,0)
        --,PreTaxMatch = PdhSource6
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = '006974'
        ,drvSSN2 = EepSSN
        ,drvPretax  = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PdhSource1,0),9) 
        ,drvRoth    = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PdhSource2,0),9) 
        ,drvPretaxNOP  = ISNULL(PdhSource1,0)
        ,drvRothNOP    = ISNULL(PdhSource2,0)
        ,drvInvestment3 = '**'
        ,drvSource4 = 'D'
        ,drvContAmt4 = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PdhSource5,0),9)
        ,drvContAmt4NOP = ISNULL(PdhSource5,0)
        ,drvInvestment4 = ''
        ,drvSource5 = ''
        ,drvContAmt5 = ''
        ,drvInvestment5 = ''
        ,drvSource6 = ''
        ,drvContAmt6 = ''
        ,drvPeriodEnd = CONVERT(VARCHAR(8), @EndDate, 112)
        ,drvInsiderTrader = CASE CONVERT(VARCHAR(10), EecUDField13)
                                WHEN 'O' THEN 'O'
                                WHEN 'B' THEN 'B'
                                ELSE ' '
                            END
        ,drvSubPlanNumber = CASE
                               -- WHEN eecDedGroupCode NOT IN ('WALTU','WTECH','WADMN') THEN '0001'                                
                                --WHEN eecDedGroupCode     IN ('WTECH','WADMN')         THEN '0003'
                               -- WHEN eecDedGroupCode     IN ('WALTU')                 THEN '0005'
                               WHEN eeccoid = '2STMJ' and EecUnionLocal in ('252','125','NO') then '0003'
                               WHEN eeccoid = '1ZFPN' and EecUnionLocal = '36609' then '0005'
                               ELSE '0001'
                            END


        ,drvName = dbo.dsi_fn_ConvertAccent_EPRUDTTTC3(EepNameLast + ', ' + EepNameFirst + ' ' + ISNULL(LEFT(EepNameMiddle,1),''))
        ,drvAddress1 = REPLACE(EepAddressLine1,' ½',' 1/2')  --Fix bad data
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
        ,drvCurHrs          = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PehCurHrs,0),6)
        ,drvCurGross        = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0),15) 
        ,drvCurEligGross    = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0),15)
        ,drvCurW2Taxable    = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PthCurFITWages,0),11)
        ,drvCurHrsNOP          = ISNULL(PehCurHrs,0)
        ,drvCurGrossNOP        = ISNULL(PehCurAmt,0)
        ,drvCurEligGrossNOP    = ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0)
        ,drvCurW2TaxableNOP    = ISNULL(PthCurFITWages,0)
        ,drvAnniversary = ''
        ,drvAnniversaryHrs = ''
        ,drvPayDate = CONVERT(VARCHAR(8), @PayDate, 112)
        ,drvEmpIDCode = CAST(EecEmpno AS varchar(15))
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
        ,drvUnionEE = CASE WHEN  (EecUnionLocal in ('252','125','NO') or eecUnionNational in ('252','125','NO'))  then 'Y'  ELSE 'N' END  --CASE WHEN EecUnionNational IS NOT NULL THEN 'Y' ELSE 'N' END --EecAnnSalary
        ,drvMarketSal = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(EecAnnSalary,0),11)
        ,drvMarketSalNOP = ISNULL(EecAnnSalary,0)
        ,drvRehireDate = CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire THEN CONVERT(VARCHAR(8), EecDateOfLastHire, 112) END
        ,drvYTDGross     = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PehCurAmt,0) - ISNULL(PdhSource4,0),15)
        ,drvDefLimitComp = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PehInclInDefComp,0) - ISNULL(PdhSource4,0),15)
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
    INTO dbo.U_EPRUDTTTC3_drvTbl_D10  --select * from dbo.U_EPRUDTTTC3_drvTbl_D10 order by drveeid
    FROM dbo.U_EPRUDTTTC3_EEList WITH (NOLOCK)        --select * from dbo.U_EPRUDTTTC3_EEList WITH (NOLOCK)
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
        AND EedFormatCode = 'EPRUDTTTC3' 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_EPRUDTTTC3_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTTC3_PDedHist_YTD WITH (NOLOCK)
        ON YTDEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTTC3_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTTC3_RLSubStatus WITH (NOLOCK)
        ON subRLEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTTC3_LOASubStatus WITH (NOLOCK)
        ON subLOAEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTTC3_TaxWages WITH (NOLOCK)
        ON PthEEID = xEEID
    WHERE (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination >= DATEADD(MM,-18,@EndDate)));

    ---------------------------------
    -- DETAIL RECORD - U_EPRUDTTTC3_drvTbl_D40 - LOAN DETAIL - ROLLINS
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTTC3_drvTbl_D40','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_drvTbl_D40;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSSN = EepSSN
        ,drvDedGroupCode = EecDedGroupCode
        ,LoanAmt = PdhLoans
        -- standard fields above and additional driver fields below
        ,drvPlanNumberLoan = '006974'
        ,drvSSNLoan = EepSSN
        ,drvLoanNumber = CAST(EedNotes as varchar(MAX)) --DM 11/24/20 EedEEMemberOrCaseNo
        ,drvLoanAmt    = dbo.dsi_fn_EPRUDTTTC3_CodedValue(ISNULL(PdhLoans,0),9)
        ,drvLoanAmtNOP    = ISNULL(PdhLoans,0)
        ,drvSubPlanLoan = CASE
                            -- WHEN eecDedGroupCode NOT IN ('WALTU','WTECH','WADMN') THEN '0001'
                           --  WHEN eecDedGroupCode     IN ('WTECH','WADMN')         THEN '0003'
                           --  WHEN eecDedGroupCode     IN ('WALTU')                 THEN '0005'
                               WHEN eeccoid = '2STMJ' and EecUnionLocal in ('252','125','NO') then '0003'
                               WHEN eeccoid = '1ZFPN' and EecUnionLocal = '36609' then '0005'
                               ELSE '0001'
                          END
    INTO dbo.U_EPRUDTTTC3_drvTbl_D40
    FROM dbo.U_EPRUDTTTC3_EEList WITH (NOLOCK)
   
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EPRUDTTTC3_PDedLoans WITH (NOLOCK)
        ON PdhEEID = xEEID
         LEFT JOIN (SELECT EedEEID, EedCOID, EedDedCode, EedNotes --DM 11/24/20 EedEEMemberOrCaseNo
               FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
               WHERE EedFormatCode = @FormatCode
               AND EedValidForExport = 'Y'
               AND EedDedCode IN ('401KL','G401L','401L2','GLNBK','RLNBK','W401L','WLNBK')
              ) TmpTbl1
        ON  EedEEID = xEEID 
        AND EedCoID = xCoID
        and EedDedCode = PdhLoanCodes
    WHERE Pdhloans <> 0                                    --SR-2019-00234349 05/30/2019
    ;


    ---------------------------------
    -- HEADER RECORD - U_EPRUDTTTC3_Header_H01 - ROLLINS
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTTC3_Header_H01','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_Header_H01;
    SELECT DISTINCT
         drvClientID = '006974'
        ,drvCreateDate = @RunDate
        ,drvCreateTime = @RunTime
    INTO dbo.U_EPRUDTTTC3_Header_H01    --SELECT * FROM dbo.U_EPRUDTTTC3_Header_H01
    ;

    --------------------------------------
    -- TOTALS VARIABLES FOR TRAILER COUNTS
    --------------------------------------

    DECLARE @TtlCont_Rollins DECIMAL(24,2)

    DECLARE @TtlLoan_Rollins DECIMAL(24,2)

    DECLARE @TtlRecords_Rollins_DEF INT

    DECLARE @TtlRecords_Rollins_LOAN INT

    -- Total Contribution / Loan Amounts

    SELECT @TtlCont_Rollins = SUM(CONVERT(DECIMAL(24,2), Pretax) + CONVERT(DECIMAL(24,2), PreTaxMatch) + CONVERT(DECIMAL(24,2), Roth) + CONVERT(DECIMAL(24,2),WalthamMatch))
    FROM dbo.U_EPRUDTTTC3_drvTbl_D10 (NOLOCK)
    ;

    SELECT @TtlLoan_Rollins = SUM(CONVERT(DECIMAL(24,2), LoanAmt))
    FROM dbo.U_EPRUDTTTC3_drvTbl_D40 (NOLOCK)
    ;


    -- Total Record Counts

    SELECT @TtlRecords_Rollins_DEF = COUNT(*) FROM dbo.U_EPRUDTTTC3_drvTbl_D10 WITH (NOLOCK)
    SELECT @TtlRecords_Rollins_LOAN = COUNT(*) FROM dbo.U_EPRUDTTTC3_drvTbl_D40 WITH (NOLOCK)
    ;

    ---------------------------------
    -- TRAILER RECORD - U_EPRUDTTTC3_Trailer_T90 - ROLLINS
    ---------------------------------
    IF OBJECT_ID('U_EPRUDTTTC3_Trailer_T90','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDTTTC3_Trailer_T90;
    SELECT DISTINCT
         drvClientIDTrl = LEFT('006974' + SPACE(10), 10)
        ,drvCreationDateTrl = @RunDate
        ,drvCreationTimeTrl = @RunTime
        ,drvRecordCount = (@TtlRecords_Rollins_DEF + @TtlRecords_Rollins_LOAN)
        ,drvTotalCont = dbo.dsi_fn_EPRUDTTTC3_CodedValue(@TtlCont_Rollins,11)
        ,drvTotalLoanAmt = CONVERT(VARCHAR(11),dbo.dsi_fnPadZero(@TtlLoan_Rollins*100,11,0))
    INTO dbo.U_EPRUDTTTC3_Trailer_T90        --SELECT * FROM dbo.U_EPRUDTTTC3_Trailer_T90
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

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRUDTTTC3';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRUDTTTC3';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRUDTTTC3';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRUDTTTC3';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRUDTTTC3' ORDER BY RunID DESC;


Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTTC3', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTTC3', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDTTTC3', 'SCH_PRU402';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRUDTTTC3';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPRUDTTTC3', @AllObjects = 'Y', @IsWeb = 'Y';

--Alter the View
ALTER VIEW dbo.dsi_vwEPRUDTTTC3_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EPRUDTTTC3_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPRUDTTTC3%' AND AdfSetNumber = '10'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202307101'
       ,expStartPerControl     = '202307101'
       ,expLastEndPerControl   = '202307169'
       ,expEndPerControl       = '202307169'
WHERE expFormatCode = 'EPRUDTTTC3' AND expExportCode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW [dbo].[dsi_vwEPRUDTTTC3_Export] AS
    SELECT TOP 20000000 *
    FROM dbo.U_EPRUDTTTC3_File (NOLOCK)
    WHERE RecordSet= 'H04,D15,D45'
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;
GO
CREATE FUNCTION [dbo].[dsi_fn_ConvertAccent_EPRUDTTTC3](@name varchar(max))
RETURNS varchar(max)
AS 
BEGIN
    DECLARE @return varchar(200) = (SELECT @name COLLATE SQL_Latin1_general_CP1253_CI_AI)
    RETURN  @return
END
GO
CREATE FUNCTION dbo.dsi_fn_EPRUDTTTC3_CodedValue (@value money, @Length smallint)
RETURNS varchar(30)
AS 
BEGIN
    DECLARE @CodedValue varchar(30) = dbo.dsi_fnPadZero(abs(@value)*100,@Length,0)
    DECLARE @Code varchar(1) = RIGHT(@CodedValue,1)

    if @value >= 0 
        SET @Code = SUBSTRING('{ABCDEFGHI', @Code+1,1)
    else
        SET @Code = SUBSTRING('}JKLMNOPQR', @Code+1,1)

    SET @CodedValue = LEFT(@CodedValue,@Length-1) + @Code
    RETURN @CodedValue
END

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EPRUDTTTC3' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EPRUDTTTC3'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EPRUDTTTC3'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPRUDTTTC3', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EPRUDTTTC3', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EPRUDTTTC3', 'UseFileName', 'V', 'Y'


-- End ripout