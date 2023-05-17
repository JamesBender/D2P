/**********************************************************************************

ESUNLNC83C: SunLIfe Non-Cancer 834 Export

FormatCode:     ESUNLNC83C
Project:        SunLIfe Non-Cancer 834 Export
Client ID:      PRI1029
Date/time:      2023-05-17 08:48:58.707
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB03
Database:       ULTIPRO_WPPWC
Web Filename:   PRI1029_3Y7VH_EEHISTORY_ESUNLNC83C_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESUNLNC83C_SavePath') IS NOT NULL DROP TABLE dbo.U_ESUNLNC83C_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESUNLNC83C'


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
WHERE FormatCode = 'ESUNLNC83C'
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
WHERE ExpFormatCode = 'ESUNLNC83C'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESUNLNC83C')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESUNLNC83C'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESUNLNC83C'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESUNLNC83C'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESUNLNC83C'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESUNLNC83C'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESUNLNC83C'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESUNLNC83C'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESUNLNC83C'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESUNLNC83C'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESUNLNC83C_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESUNLNC83C_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESUNLNC83C') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNLNC83C];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_ESUNLNC83C') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_ESUNLNC83C];
GO
IF OBJECT_ID('U_ESUNLNC83C_TrlTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC83C_TrlTbl];
GO
IF OBJECT_ID('U_ESUNLNC83C_HdrTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC83C_HdrTbl];
GO
IF OBJECT_ID('U_ESUNLNC83C_File') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC83C_File];
GO
IF OBJECT_ID('U_ESUNLNC83C_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC83C_EEList];
GO
IF OBJECT_ID('U_ESUNLNC83C_DrvTbl_2300') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC83C_DrvTbl_2300];
GO
IF OBJECT_ID('U_ESUNLNC83C_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC83C_DrvTbl];
GO
IF OBJECT_ID('U_ESUNLNC83C_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC83C_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ESUNLNC83C') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESUNLNC83C];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESUNLNC83C','SunLIfe Non-Cancer 834 Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ESUNLNC83CZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','H','01','1',NULL,'ISA  Segment ID (Header)',NULL,NULL,'"ISA"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','2','H','01','2',NULL,'Authorization Info Qualifier',NULL,NULL,'"00"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','10','H','01','3',NULL,'Authorization Info',NULL,NULL,'""','(''SS''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','2','H','01','4',NULL,'Security Info Qualifier',NULL,NULL,'"00"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','10','H','01','5',NULL,'Security Info',NULL,NULL,'""','(''SS''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESUNLNC83CZ0','2','H','01','6',NULL,'Sender ID Qualifier',NULL,NULL,'"drvISA05_SenderIDQual"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESUNLNC83CZ0','15','H','01','7',NULL,'Sender ID',NULL,NULL,'"drvISA06_SenderID"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESUNLNC83CZ0','2','H','01','8',NULL,'Receiver ID Qualifier',NULL,NULL,'"drvISA07_ReceiverIDQual"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESUNLNC83CZ0','15','H','01','9',NULL,'Receiver ID',NULL,NULL,'"drvISA08_ReceiverID"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESUNLNC83CZ0','6','H','01','10',NULL,'Interchange Date',NULL,NULL,'"drvISA09_InterchangeDate"','(''UD12''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESUNLNC83CZ0','4','H','01','11',NULL,'Interchange Time',NULL,NULL,'"drvISA10_InterchangeTime"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESUNLNC83CZ0','1','H','01','12',NULL,'Repetition Separator',NULL,NULL,'"^"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESUNLNC83CZ0','5','H','01','13',NULL,'Interchange Control Ver #',NULL,NULL,'"00501"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESUNLNC83CZ0','9','H','01','14',NULL,'Interchange Control #',NULL,NULL,'"000000001"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESUNLNC83CZ0','1','H','01','15',NULL,'Acknowledgement Requested',NULL,NULL,'"0"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESUNLNC83CZ0','1','H','01','16',NULL,'Usage Indicator',NULL,NULL,'"drvISA15_UsageIndicator"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESUNLNC83CZ0','1','H','01','17',NULL,'Component Element Separator',NULL,NULL,'":"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','H','02','1',NULL,'GS Segment ID (Header)',NULL,NULL,'"GS"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','2','H','02','2',NULL,'Functional ID Code',NULL,NULL,'"BE"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','15','H','02','3',NULL,'Sender ID',NULL,NULL,'"drvGS02_SenderID"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','15','H','02','4',NULL,'Receiver ID',NULL,NULL,'"drvGS03_ReceiverID"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','8','H','02','5',NULL,'Date',NULL,NULL,'"drvGS04_Date"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESUNLNC83CZ0','8','H','02','6',NULL,'Time',NULL,NULL,'"drvGS05_Time"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESUNLNC83CZ0','9','H','02','7',NULL,'Group Control Number',NULL,NULL,'"0001"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESUNLNC83CZ0','2','H','02','8',NULL,'Responsible Agency Code',NULL,NULL,'"X"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESUNLNC83CZ0','12','H','02','9',NULL,'Version/Release  Code',NULL,NULL,'"005010X220A1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','H','03','1',NULL,'ST Segment ID (Header)',NULL,NULL,'"ST"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','H','03','2',NULL,'Transaction ID Code',NULL,NULL,'"834"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','9','H','03','3',NULL,'Transaction Set Control #',NULL,NULL,'"0001"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','35','H','03','4',NULL,'Implementation Convention Refe',NULL,NULL,'"005010X220A1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','H','04','1',NULL,'BGN Segment ID (Header)',NULL,NULL,'"BGN"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','2','H','04','2',NULL,'Transaction Set Purpose',NULL,NULL,'"00"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','50','H','04','3',NULL,'Reference Number',NULL,NULL,'"0001"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','8','H','04','4',NULL,'Date',NULL,NULL,'"drvBGN03_Date"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','8','H','04','5',NULL,'Time',NULL,NULL,'"drvBGN04_Time"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESUNLNC83CZ0','2','H','04','6',NULL,'Time Code',NULL,NULL,'"drvBGN05_TimeCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESUNLNC83CZ0','50','H','04','7',NULL,'Reference Identification',NULL,NULL,'"drvBGN06_RefID"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESUNLNC83CZ0','2','H','04','8',NULL,'Transaction Type Code',NULL,NULL,'"drvBGN07_TransTypeCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESUNLNC83CZ0','2','H','04','9',NULL,'Action Code',NULL,NULL,'"drvBGN08_ActionCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','H','05','1',NULL,'REF Segment ID (Header)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','H','05','2',NULL,'Reference Number Qualifier',NULL,NULL,'"drvREF01_RefNumberQual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','50','H','05','3',NULL,'Reference Number Qualifier',NULL,NULL,'"drvREF02_RefNumberQual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','50','H','06','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL,'"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','50','H','06','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','50','H','06','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','50','H','06','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod1"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','H','07','1',NULL,'QTY Segment ID (Header)',NULL,NULL,'"QTY"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','2','H','07','2',NULL,'Quantity Qualifier',NULL,NULL,'"drvQTY01_QuantityQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','15','H','07','3',NULL,'Quantity',NULL,NULL,'"drvQTY02_Quantity1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','H','08','1',NULL,'QTY Segment ID (Header)',NULL,NULL,'"QTY"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','2','H','08','2',NULL,'Quantity Qualifier',NULL,NULL,'"drvQTY01_QuantityQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','15','H','08','3',NULL,'Quantity',NULL,NULL,'"drvQTY02_Quantity2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','H','09','1',NULL,'QTY Segment ID (Header)',NULL,NULL,'"QTY"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','2','H','09','2',NULL,'Quantity Qualifier',NULL,NULL,'"drvQTY01_QuantityQual3"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','15','H','09','3',NULL,'Quantity',NULL,NULL,'"drvQTY02_Quantity3"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','H','10','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL,'"N1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','H','10','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL,'"drvN101_EntityIDCodeSponsor1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','60','H','10','3',NULL,'Name',NULL,NULL,'"drvN102_Name1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','2','H','10','4',NULL,'Identification Code Qualifier',NULL,NULL,'"drvN103_IDCodeQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','80','H','10','5',NULL,'Identification Code',NULL,NULL,'"drvN104_IDCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','H','11','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL,'"N1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','H','11','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL,'"drvN101_EntityIDCodeSponsor2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','60','H','11','3',NULL,'Name',NULL,NULL,'"drvN102_Name2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','2','H','11','4',NULL,'Identification Code Qualifier',NULL,NULL,'"drvN103_IDCodeQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','80','H','11','5',NULL,'Identification Code',NULL,NULL,'"drvN104_IDCode2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','12','1',NULL,'INS Segment ID (Loop 2000)',NULL,NULL,'"INS"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','1','D','12','2',NULL,'Yes/No Condition',NULL,NULL,'"drvINS01_YesNoCond"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','2','D','12','3',NULL,'Individual Relationship Code',NULL,NULL,'"drvINS02_RelationshipCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','3','D','12','4',NULL,'Maintenance Type Code',NULL,NULL,'"drvINS03_MaintTypeCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','3','D','12','5',NULL,'Maintenance Reason Code',NULL,NULL,'"drvINS04_MaintReasonCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESUNLNC83CZ0','1','D','12','6',NULL,'Benefit Status Code',NULL,NULL,'"drvINS05_BenefitStatusCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESUNLNC83CZ0','1','D','12','7',NULL,'MEDICARE PLAN CODE',NULL,NULL,'"drvINS0601_MEDICAREPLANCODE"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESUNLNC83CZ0','1','D','12','8',NULL,'Eligibility Reason Code',NULL,NULL,'"drvINS0602_EligibilityRsnCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESUNLNC83CZ0','2','D','12','9',NULL,'COBRA Qualifying Event Code',NULL,NULL,'"drvINS07_COBRAQualEventCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESUNLNC83CZ0','2','D','12','10',NULL,'Employment Status Code',NULL,NULL,'"drvINS08_EmploymentStatusCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESUNLNC83CZ0','1','D','12','11',NULL,'Student Status Code',NULL,NULL,'"drvINS09_StudentStatusCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESUNLNC83CZ0','1','D','12','12',NULL,'Response Code',NULL,NULL,'"drvINS10_ResponseCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESUNLNC83CZ0','3','D','12','13',NULL,'Date Time Period Format Qualif',NULL,NULL,'"drvINS11_DateTimeFormatQual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESUNLNC83CZ0','35','D','12','14',NULL,'Date Time Period',NULL,NULL,'"drvINS12_DateTimePeriod"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESUNLNC83CZ0','35','D','12','15',NULL,'Confidentiality Code',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESUNLNC83CZ0','35','D','12','16',NULL,'Not Used',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESUNLNC83CZ0','35','D','12','17',NULL,'Not Used',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESUNLNC83CZ0','35','D','12','18',NULL,'Not Used',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESUNLNC83CZ0','35','D','12','19',NULL,'Birth Sequence Number',NULL,NULL,'"drvINS17_BirthSequenceNumber"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','13','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','13','2',NULL,'Reference Number Identificatio',NULL,NULL,'"0F"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','50','D','13','3',NULL,'Reference Number',NULL,NULL,'"drvSSN"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','14','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','14','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','50','D','14','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','15','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','15','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','50','D','15','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','16','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL,'"drvDTP00_DateTime1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','16','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','3','D','16','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','35','D','16','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod1"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','17','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL,'"drvDTP00_DateTime2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','17','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','3','D','17','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','35','D','17','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod2"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','20','1',NULL,'NM1 Segment ID (Loop 2100A)',NULL,NULL,'"NM1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','20','2',NULL,'Entity Identifier Code',NULL,NULL,'"IL"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','1','D','20','3',NULL,'Entity Type Qualifier',NULL,NULL,'"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','60','D','20','4',NULL,'Name Last',NULL,NULL,'"drvNM103_NameLast1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','35','D','20','5',NULL,'Name First',NULL,NULL,'"drvNM104_NameFirst1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESUNLNC83CZ0','25','D','20','6',NULL,'Name Middle Initial',NULL,NULL,'"drvNM105_NameMiddleInitial1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESUNLNC83CZ0','10','D','20','7',NULL,'Name Prefix',NULL,NULL,'"drvNM106_NamePrefix1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESUNLNC83CZ0','10','D','20','8',NULL,'Name Suffix',NULL,NULL,'"drvNM107_NameSuffix1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESUNLNC83CZ0','2','D','20','9',NULL,'Identification Code Qualifier',NULL,NULL,'"drvNM108_IDCodeQualifier1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESUNLNC83CZ0','80','D','20','10',NULL,'Identification Code',NULL,NULL,'"drvNM109_IDCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','21','1',NULL,'PER Segment ID (Loop 2100A)',NULL,NULL,'"PER"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','2','D','21','2',NULL,'Contact Function Code',NULL,NULL,'"IP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','60','D','21','3',NULL,'Name',NULL,NULL,'"drvPER02_Name"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','3','D','21','4',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER03_CommNumberQualifier"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','256','D','21','5',NULL,'Communication Number',NULL,NULL,'"drvPER04_CommunicationNumber"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESUNLNC83CZ0','3','D','21','6',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER05_CommNumberQualifier"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESUNLNC83CZ0','256','D','21','7',NULL,'Communication Number',NULL,NULL,'"drvPER06_CommunicationNumber"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESUNLNC83CZ0','3','D','21','8',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER07_CommNumberQualifier"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESUNLNC83CZ0','256','D','21','9',NULL,'Communication Number',NULL,NULL,'"drvPER08_CommunicationNumber"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','D','22','1',NULL,'N3 Segment ID (Loop 2100A)',NULL,NULL,'"N3"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','55','D','22','2',NULL,'Address Line 1',NULL,NULL,'"drvN301_AddressLine1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','55','D','22','3',NULL,'Address Line 2',NULL,NULL,'"drvN302_AddressLine2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','D','23','1',NULL,'N4 Segment ID (Loop 2100A)',NULL,NULL,'"N4"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','30','D','23','2',NULL,'City',NULL,NULL,'"drvN401_City"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','2','D','23','3',NULL,'State',NULL,NULL,'"drvN402_State"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','15','D','23','4',NULL,'Zip',NULL,NULL,'"drvN403_Zip"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','3','D','23','5',NULL,'Country Code',NULL,NULL,'"drvN404_CountryCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','24','1',NULL,'DMG Segment ID (Loop 2100A)',NULL,NULL,'"DMG"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','24','2',NULL,'Date/Time Format Qualifier',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','35','D','24','3',NULL,'Date/Time Period',NULL,NULL,'"drvDMG02_DateTimePeriod1"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','1','D','24','4',NULL,'Gender Code',NULL,NULL,'"drvDMG03_GenderCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','1','D','24','5',NULL,'Marital Status Code',NULL,NULL,'"drvDMG04_MaritalStatusCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','25','1',NULL,'ICM Segment ID (Loop1000A)',NULL,NULL,'"ICM"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','1','D','25','2',NULL,'Frequency Code',NULL,NULL,'"drvICM01_FrequencyCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','18','D','25','3',NULL,'Monetary Amount',NULL,NULL,'"drvICM02_MonetaryAmount"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','15','D','25','4',NULL,'Quantity',NULL,NULL,'"drvICM03_Quantity"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','30','D','25','5',NULL,'Location Identifier Description',NULL,NULL,'"drvICM04_LocationID"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','26','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL,'"drvAMT00_SegmentID1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','18','D','26','2',NULL,'Monetary Amount',NULL,NULL,'"drvAMT01_AmountQualifierCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','1','D','26','3',NULL,'Credit/Debit Flag Code',NULL,NULL,'"drvAMT02_MonetaryAmount1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','27','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL,'"drvAMT00_SegmentID2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','18','D','27','2',NULL,'Monetary Amount',NULL,NULL,'"drvAMT01_AmountQualifierCode2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','1','D','27','3',NULL,'Credit/Debit Flag Code',NULL,NULL,'"drvAMT02_MonetaryAmount2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','28','1',NULL,'HLH Segment ID (Loop1000A)',NULL,NULL,'"drvHLH00_SegmentID"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','8','D','28','2',NULL,'Health-Related Code',NULL,NULL,'"drvHLH01_HealthRelatedCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','10','D','28','3',NULL,'Height',NULL,NULL,'"drvHLH02_Height"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','10','D','28','4',NULL,'Weight',NULL,NULL,'"drvHLH03_Weight1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','10','D','28','5',NULL,'Weight',NULL,NULL,'"drvHLH04_Weight2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESUNLNC83CZ0','10','D','28','6',NULL,'Description',NULL,NULL,'"drvHLH05_Description1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESUNLNC83CZ0','10','D','28','7',NULL,'Current Health Condition Code',NULL,NULL,'"drvHLH06_CurrentHealthConditionCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESUNLNC83CZ0','10','D','28','8',NULL,'Description',NULL,NULL,'"drvHLH07_Description2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','D','40','1',NULL,'HD Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvHD00_HealthCoverage"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','40','2',NULL,'Maintenance Type Code',NULL,NULL,'"drvHD01_MaintTypeCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','3','D','40','3',NULL,'Maintenance Reason Code',NULL,NULL,'"drvHD02_MaintReasonCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','3','D','40','4',NULL,'Insurance Line Code',NULL,NULL,'"drvHD03_InsuranceLineCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESUNLNC83CZ0','50','D','40','5',NULL,'Plan Coverage Description',NULL,NULL,'"drvHD04_PlanCoverageDesc"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESUNLNC83CZ0','3','D','40','6',NULL,'Coverage Level Code',NULL,NULL,'"drvHD05_CoverageLevelCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','41','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvDTP00_DateTime_348"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','41','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier_348"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','3','D','41','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual_348"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','35','D','41','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod_348"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','42','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvDTP00_DateTime_349"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','42','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier_349"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','3','D','42','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual_349"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','35','D','42','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod_349"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','43','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvDTP00_DateTime_303"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','43','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier_303"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','3','D','43','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual_303"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESUNLNC83CZ0','35','D','43','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod_303"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','45','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL,'"drvREF00_RefNumberQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','45','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','50','D','45','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','46','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL,'"drvREF00_RefNumberQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','46','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','50','D','46','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','50','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvAMT00_AmountQualifierCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','50','2',NULL,'Amount Qualifier Code',NULL,NULL,'"drvAMT01_AmountQualifierCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','18','D','50','3',NULL,'Monetary Amount',NULL,NULL,'"drvAMT02_MonetaryAmount1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','51','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvAMT00_AmountQualifierCode2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','51','2',NULL,'Amount Qualifier Code',NULL,NULL,'"drvAMT01_AmountQualifierCode2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','18','D','51','3',NULL,'Monetary Amount',NULL,NULL,'"drvAMT02_MonetaryAmount2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','D','80','1',NULL,'LS Segment ID (Loop 2700)',NULL,NULL,'"LS"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','6','D','80','2',NULL,'Loop ID Code',NULL,NULL,'"drvLS01_LoopIDCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','D','81','1',NULL,'LX Segment ID (Loop 2700)',NULL,NULL,'"LX"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','6','D','81','2',NULL,'Assigned Number',NULL,NULL,'"drvLX01_AssignedNumber"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','D','85','1',NULL,'N1 Segment ID (Loop 2750)',NULL,NULL,'"N1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','85','2',NULL,'Entity Identifier Code',NULL,NULL,'"drvN101_EntityIDCodeSponsor"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','60','D','85','3',NULL,'Name',NULL,NULL,'"drvN102_Name"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','86','1',NULL,'REF Segment ID (Loop 2750)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','3','D','86','2',NULL,'Reference Identification Quali',NULL,NULL,'"drvREF01_RefNumberQual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','50','D','86','3',NULL,'Reference Identification Descr',NULL,NULL,'"drvREF02_RefNumberDesc"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','D','87','1',NULL,'LE Segment ID (Loop 2750)',NULL,NULL,'"LE"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','6','D','87','2',NULL,'Loop ID Code',NULL,NULL,'"drvLE01_LoopIDCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','T','90','1',NULL,'SE Segment ID (Trailer)',NULL,NULL,'"SE"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','10','T','90','2',NULL,'Number of Included Segments',NULL,NULL,'"drvSE01_SegmentCount"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','9','T','90','3',NULL,'Transaction Set Control Number',NULL,NULL,'"0001"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','2','T','91','1',NULL,'GE Segment ID (Trailer)',NULL,NULL,'"GE"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','6','T','91','2',NULL,'Number of Transaction Sets Inc',NULL,NULL,'"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','9','T','91','3',NULL,'Group Control Number',NULL,NULL,'"0001"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESUNLNC83CZ0','3','T','92','1',NULL,'IEA Segment ID (Trailer)',NULL,NULL,'"IEA"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESUNLNC83CZ0','5','T','92','2',NULL,'Number of Functional Groups In',NULL,NULL,'"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESUNLNC83CZ0','9','T','92','3',NULL,'Interchange Control Number',NULL,NULL,'"000000001"','(''DA''=''T*'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESUNLNC83C_20230517.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','XRAEE,XRS43',NULL,NULL,NULL,'Changes Only File','202305169','EMPEXPORT','CHANGES','May 16 2023  2:07PM','ESUNLNC83C',NULL,NULL,NULL,'202305169','May 16 2023 12:00AM','Dec 30 1899 12:00AM','202305161','55059','','','202305161',dbo.fn_GetTimedKey(),NULL,'us3kEpPRI1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','XRAEE,XRS43',NULL,NULL,NULL,'Full File Only','202304241','EMPEXPORT','FULLFILE','Apr 27 2023 10:12AM','ESUNLNC83C',NULL,NULL,NULL,'202304241','Apr 24 2023 12:00AM','Dec 30 1899 12:00AM','202304171','55954','','','202304171',dbo.fn_GetTimedKey(),NULL,'us3kEpPRI1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','XRAEE,XRS43',NULL,NULL,NULL,'Active Open Enrollment','202103249','EMPEXPORT','OEACTIVE','Dec 26 2020  4:44PM','ESUNLNC83C',NULL,NULL,NULL,'202103249','Jan  1 2021 12:00AM','Dec 26 2020 12:00AM','202101011','21675','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3cPePRI1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','XRAEE,XRS43',NULL,NULL,NULL,'Passive Open Enrollment','202103249','EMPEXPORT','OEPASSIVE','Dec 26 2020  4:23PM','ESUNLNC83C',NULL,NULL,NULL,'202103249','Jan  1 2021 12:00AM','Dec 26 2020 12:00AM','202101011','26924','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3cPePRI1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','XRAEE,XRS43',NULL,NULL,NULL,'SunLIfe Non-Cancer 834 Export','202302219','EMPEXPORT','SCHEDULED','Feb 21 2023  4:22PM','ESUNLNC83C',NULL,NULL,NULL,'202302279','Feb 21 2023 12:00AM','Dec 30 1899 12:00AM','202302201','54994','','','202302141',dbo.fn_GetTimedKey(),NULL,'us3kEpPRI1029',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC83C','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC83C','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC83C','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC83C','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC83C','Is834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC83C','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC83C','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC83C','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC83C','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H01','U_ESUNLNC83C_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H02','U_ESUNLNC83C_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H03','U_ESUNLNC83C_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H04','U_ESUNLNC83C_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H05','U_ESUNLNC83C_HdrTbl','ISNULL(drvREF01_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H06','U_ESUNLNC83C_HdrTbl','ISNULL(drvDTP01_DateTimeQualifier1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H07','U_ESUNLNC83C_HdrTbl','ISNULL(drvQTY01_QuantityQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H08','U_ESUNLNC83C_HdrTbl','ISNULL(drvQTY01_QuantityQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H09','U_ESUNLNC83C_HdrTbl','ISNULL(drvQTY01_QuantityQual3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H10','U_ESUNLNC83C_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','H11','U_ESUNLNC83C_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D12','U_ESUNLNC83C_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D13','U_ESUNLNC83C_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D14','U_ESUNLNC83C_DrvTbl','ISNULL(drvREF01_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D15','U_ESUNLNC83C_DrvTbl','ISNULL(drvREF01_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D16','U_ESUNLNC83C_DrvTbl','ISNULL(drvDTP00_DateTime1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D17','U_ESUNLNC83C_DrvTbl','ISNULL(drvDTP00_DateTime2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D20','U_ESUNLNC83C_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D21','U_ESUNLNC83C_DrvTbl','ISNULL(drvPER03_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER05_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER07_CommNumberQualifier,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D22','U_ESUNLNC83C_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D23','U_ESUNLNC83C_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D24','U_ESUNLNC83C_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D25','U_ESUNLNC83C_DrvTbl','ISNULL(drvICM01_FrequencyCode,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D26','U_ESUNLNC83C_DrvTbl','ISNULL(drvAMT00_SegmentID1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D27','U_ESUNLNC83C_DrvTbl','ISNULL(drvAMT00_SegmentID2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D28','U_ESUNLNC83C_DrvTbl','ISNULL(drvHLH00_SegmentID,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D40','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D41','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_348,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D42','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_349,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D43','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_303,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D45','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D46','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D50','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D51','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D80','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvLS01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D81','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvLX01_AssignedNumber,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D85','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvN101_EntityIDCodeSponsor,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D86','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvREF01_RefNumberQual,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','D87','U_ESUNLNC83C_DrvTbl_2300','ISNULL(drvLE01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','T90','U_ESUNLNC83C_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','T91','U_ESUNLNC83C_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC83C','T92','U_ESUNLNC83C_TrlTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ESUNLNC83C
-----------

IF OBJECT_ID('U_dsi_BDM_ESUNLNC83C') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESUNLNC83C] (
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
-- Create table U_ESUNLNC83C_DedList
-----------

IF OBJECT_ID('U_ESUNLNC83C_DedList') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC83C_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESUNLNC83C_DrvTbl
-----------

IF OBJECT_ID('U_ESUNLNC83C_DrvTbl') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC83C_DrvTbl] (
    [drvINS01_YesNoCond] varchar(1) NOT NULL,
    [drvINS02_RelationshipCode] varchar(2) NOT NULL,
    [drvINS03_MaintTypeCode] varchar(3) NOT NULL,
    [drvINS04_MaintReasonCode] varchar(2) NOT NULL,
    [drvINS05_BenefitStatusCode] varchar(1) NOT NULL,
    [drvINS0601_MEDICAREPLANCODE] varchar(1) NOT NULL,
    [drvINS0602_EligibilityRsnCode] varchar(1) NOT NULL,
    [drvINS07_COBRAQualEventCode] varchar(1) NOT NULL,
    [drvINS08_EmploymentStatusCode] varchar(2) NULL,
    [drvINS09_StudentStatusCode] varchar(1) NULL,
    [drvINS10_ResponseCode] varchar(1) NULL,
    [drvINS11_DateTimeFormatQual] varchar(1) NOT NULL,
    [drvINS12_DateTimePeriod] varchar(1) NOT NULL,
    [drvINS17_BirthSequenceNumber] varchar(1) NOT NULL,
    [drvREF01_RefNumberQual1] varchar(2) NULL,
    [drvREF02_RefNumberQual1] varchar(7) NULL,
    [drvREF01_RefNumberQual2] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual2] varchar(7) NULL,
    [drvDTP00_DateTime1] varchar(3) NOT NULL,
    [drvDTP01_DateTimeQualifier1] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual1] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod1] datetime NULL,
    [drvDTP00_DateTime2] varchar(3) NULL,
    [drvDTP01_DateTimeQualifier2] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual2] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod2] datetime NULL,
    [drvNM103_NameLast1] varchar(6000) NULL,
    [drvNM104_NameFirst1] varchar(6000) NULL,
    [drvNM105_NameMiddleInitial1] varchar(6000) NULL,
    [drvNM106_NamePrefix1] varchar(30) NULL,
    [drvNM107_NameSuffix1] varchar(30) NULL,
    [drvNM108_IDCodeQualifier1] varchar(2) NULL,
    [drvNM109_IDCode1] char(11) NULL,
    [drvPER02_Name] varchar(1) NOT NULL,
    [drvPER03_CommNumberQualifier] varchar(2) NULL,
    [drvPER04_CommunicationNumber] varchar(50) NULL,
    [drvPER05_CommNumberQualifier] varchar(2) NULL,
    [drvPER06_CommunicationNumber] varchar(50) NULL,
    [drvPER07_CommNumberQualifier] varchar(1) NOT NULL,
    [drvPER08_CommunicationNumber] varchar(1) NOT NULL,
    [drvN301_AddressLine1] varchar(6000) NULL,
    [drvN302_AddressLine2] varchar(6000) NULL,
    [drvN401_City] varchar(6000) NULL,
    [drvN402_State] varchar(255) NULL,
    [drvN403_Zip] varchar(50) NULL,
    [drvN404_CountryCode] char(3) NULL,
    [drvDMG02_DateTimePeriod1] varchar(8) NULL,
    [drvDMG03_GenderCode1] varchar(1) NULL,
    [drvDMG04_MaritalStatusCode1] varchar(1) NOT NULL,
    [drvICM01_FrequencyCode] varchar(1) NULL,
    [drvICM02_MonetaryAmount] money NULL,
    [drvICM03_Quantity] nvarchar(4000) NULL,
    [drvICM04_LocationID] varchar(8) NULL,
    [drvAMT00_SegmentID1] varchar(1) NOT NULL,
    [drvAMT01_AmountQualifierCode1] varchar(1) NOT NULL,
    [drvAMT02_MonetaryAmount1] varchar(1) NOT NULL,
    [drvAMT00_SegmentID2] varchar(1) NOT NULL,
    [drvAMT01_AmountQualifierCode2] varchar(1) NOT NULL,
    [drvAMT02_MonetaryAmount2] varchar(1) NOT NULL,
    [drvHLH00_SegmentID] varchar(3) NOT NULL,
    [drvHLH01_HealthRelatedCode] varchar(1) NULL,
    [drvHLH02_Height] varchar(1) NOT NULL,
    [drvHLH03_Weight1] varchar(1) NOT NULL,
    [drvHLH04_Weight2] varchar(1) NOT NULL,
    [drvHLH05_Description1] varchar(1) NOT NULL,
    [drvHLH06_CurrentHealthConditionCode] varchar(1) NOT NULL,
    [drvHLH07_Description2] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCOID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(23) NULL
);

-----------
-- Create table U_ESUNLNC83C_DrvTbl_2300
-----------

IF OBJECT_ID('U_ESUNLNC83C_DrvTbl_2300') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC83C_DrvTbl_2300] (
    [drvHD00_HealthCoverage] varchar(2) NOT NULL,
    [drvHD01_MaintTypeCode] varchar(3) NOT NULL,
    [drvHD02_MaintReasonCode] varchar(1) NOT NULL,
    [drvHD03_InsuranceLineCode] varchar(3) NULL,
    [drvHD04_PlanCoverageDesc] varchar(5) NULL,
    [drvHD05_CoverageLevelCode] varchar(3) NULL,
    [drvDTP00_DateTime_348] varchar(3) NOT NULL,
    [drvDTP01_DateTimeQualifier_348] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual_348] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod_348] datetime NULL,
    [drvDTP00_DateTime_349] varchar(3) NULL,
    [drvDTP01_DateTimeQualifier_349] varchar(3) NULL,
    [drvDTP02_DateTimeFormatQual_349] varchar(2) NULL,
    [drvDTP03_DateTimePeriod_349] datetime NULL,
    [drvDTP00_DateTime_303] varchar(3) NOT NULL,
    [drvDTP01_DateTimeQualifier_303] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual_303] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod_303] datetime NULL,
    [drvREF00_RefNumberQual1] varchar(1) NULL,
    [drvREF01_RefNumberQual1] varchar(1) NULL,
    [drvREF02_RefNumberQual1] varchar(1) NULL,
    [drvREF00_RefNumberQual2] varchar(1) NULL,
    [drvREF01_RefNumberQual2] varchar(1) NULL,
    [drvREF02_RefNumberQual2] varchar(1) NULL,
    [drvAMT00_AmountQualifierCode1] varchar(3) NULL,
    [drvAMT01_AmountQualifierCode1] varchar(2) NOT NULL,
    [drvAMT02_MonetaryAmount1] money NULL,
    [drvAMT00_AmountQualifierCode2] varchar(1) NULL,
    [drvAMT01_AmountQualifierCode2] varchar(1) NULL,
    [drvAMT02_MonetaryAmount2] varchar(1) NULL,
    [drvLS01_LoopIDCode] varchar(1) NOT NULL,
    [drvLX01_AssignedNumber] varchar(1) NOT NULL,
    [drvN101_EntityIDCodeSponsor] varchar(1) NOT NULL,
    [drvN102_Name] varchar(1) NOT NULL,
    [drvREF01_RefNumberQual] varchar(1) NOT NULL,
    [drvREF02_RefNumberDesc] varchar(1) NULL,
    [drvLE01_LoopIDCode] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCOID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(29) NULL
);

-----------
-- Create table U_ESUNLNC83C_EEList
-----------

IF OBJECT_ID('U_ESUNLNC83C_EEList') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC83C_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESUNLNC83C_File
-----------

IF OBJECT_ID('U_ESUNLNC83C_File') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC83C_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ESUNLNC83C_HdrTbl
-----------

IF OBJECT_ID('U_ESUNLNC83C_HdrTbl') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC83C_HdrTbl] (
    [drvISA05_SenderIDQual] varchar(2) NOT NULL,
    [drvISA06_SenderID] varchar(9) NOT NULL,
    [drvISA07_ReceiverIDQual] varchar(2) NOT NULL,
    [drvISA08_ReceiverID] varchar(9) NOT NULL,
    [drvISA09_InterchangeDate] varchar(6) NULL,
    [drvISA10_InterchangeTime] varchar(4) NULL,
    [drvISA15_UsageIndicator] varchar(1) NOT NULL,
    [drvGS02_SenderID] varchar(27) NOT NULL,
    [drvGS03_ReceiverID] varchar(9) NOT NULL,
    [drvGS04_Date] varchar(8) NULL,
    [drvGS05_Time] varchar(4) NULL,
    [drvBGN03_Date] varchar(8) NULL,
    [drvBGN04_Time] varchar(4) NULL,
    [drvBGN05_TimeCode] varchar(2) NOT NULL,
    [drvBGN06_RefID] varchar(1) NOT NULL,
    [drvBGN07_TransTypeCode] varchar(1) NOT NULL,
    [drvBGN08_ActionCode] varchar(1) NOT NULL,
    [drvREF01_RefNumberQual] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual] varchar(6) NOT NULL,
    [drvDTP01_DateTimeQualifier1] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual1] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod1] datetime NOT NULL,
    [drvQTY01_QuantityQual1] varchar(2) NOT NULL,
    [drvQTY02_Quantity1] int NULL,
    [drvQTY01_QuantityQual2] varchar(2) NOT NULL,
    [drvQTY02_Quantity2] int NULL,
    [drvQTY01_QuantityQual3] varchar(2) NOT NULL,
    [drvQTY02_Quantity3] int NULL,
    [drvN101_EntityIDCodeSponsor1] varchar(2) NOT NULL,
    [drvN102_Name1] varchar(27) NOT NULL,
    [drvN103_IDCodeQual1] varchar(2) NOT NULL,
    [drvN104_IDCode1] varchar(9) NOT NULL,
    [drvN101_EntityIDCodeSponsor2] varchar(2) NOT NULL,
    [drvN102_Name2] varchar(18) NOT NULL,
    [drvN103_IDCodeQual2] varchar(2) NOT NULL,
    [drvN104_IDCode2] varchar(9) NOT NULL
);

-----------
-- Create table U_ESUNLNC83C_TrlTbl
-----------

IF OBJECT_ID('U_ESUNLNC83C_TrlTbl') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC83C_TrlTbl] (
    [drvSE01_SegmentCount] varchar(4) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_ESUNLNC83C]
AS
SET NOCOUNT ON;
/************************************************************
Client: Priority Wire

Created By: James Bender
Create Date: 11/30/2020
ChangePoint Request Number: TekP-2020-09-02-0003

Purpose: Remove "bad" elements where record ends with Asterisk and Tilde (*~)

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

************************************************************/
BEGIN

    --==================================================
    -- Remove Blank Elements Where Row Ends With '*~'
    --==================================================
    WHILE (SELECT COUNT(*) FROM dbo.U_ESUNLNC83C_File WHERE RIGHT(DATA,2) = '*~') > 0
    BEGIN
        UPDATE dbo.U_ESUNLNC83C_File SET DATA = REPLACE(DATA,'*~','~') WHERE RIGHT(RTRIM(DATA),2) = '*~';
    END;

    --========================================
    -- Remove Extra Records from PER Segment
    --========================================
    UPDATE dbo.U_ESUNLNC83C_File SET DATA = REPLACE(DATA,'HP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%HP**%';
    UPDATE dbo.U_ESUNLNC83C_File SET DATA = REPLACE(DATA,'WP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%WP**%';
    UPDATE dbo.U_ESUNLNC83C_File SET DATA = REPLACE(DATA,'EM**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%EM**%';

    DELETE dbo.U_ESUNLNC83C_File WHERE SubSort LIKE '%3' AND DATA NOT LIKE 'REF*3H%'

    UPDATE dbo.U_ESUNLNC83C_File
    SET SubSort = LEFT(SubSort, LEN(SubSort)-2) + ' 1'
    WHERE SubSort LIKE '%3' AND DATA LIKE 'REF*3H%';

    --====================================
    -- Update Record Count in SE Segment
    --====================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_ESUNLNC83C_File WHERE LEFT(Data, CHARINDEX('*',Data) - 1) NOT IN ('ISA','GS','IEA','GE'));

    UPDATE dbo.U_ESUNLNC83C_File
    SET Data = REPLACE(Data,'9999',@RecordCount)
    WHERE LEFT(Data,2) = 'SE';

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNLNC83C]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Priority Wire

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 11/30/2020
Service Request Number: TekP-2020-09-02-0003

Purpose: SunLIfe Non-Cancer 834 Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        02/09/2023     TekP-2023-01-18-02  Add BLIFE dedcode
Kim Ephraim         02/14/2023     TekP-2023-01-18-02  Remove and replace BLIFE dedcode with 'LIFE' per client.
Marie Thomerson     03/02/2023     TekP-2023-01-18-02  No dups
Marie Waters        03/17/2023     TekP-2023-01-18-02  Lixed REF*17 loop
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESUNLNC83C';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESUNLNC83C';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESUNLNC83C';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'ESUNLNC83C';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESUNLNC83C' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLNC83C', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLNC83C', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLNC83C', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLNC83C', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLNC83C', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESUNLNC83C';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESUNLNC83C', @AllObjects = 'Y', @IsWeb = 'Y';
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
            ,@FileMinCovDate    DATETIME;

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl  = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@RunTime         = REPLACE(CONVERT(VARCHAR(5), GETDATE(), 108),':',SPACE(0))
        ,@FileMinCovDate  = ''
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'ESUNLNC83C';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'LTDH,LTD,LTDC2,LTDC4,LIF,LIFS,LIFC,SHO,ACC,CRI,CRIES,CRICH,CANP1,VIS,LIFE';

    IF OBJECT_ID('U_ESUNLNC83C_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLNC83C_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_ESUNLNC83C_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESUNLNC83C_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESUNLNC83C_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_ESUNLNC83C_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_ESUNLNC83C_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);

    DELETE FROM dbo.U_ESUNLNC83C_EEList WHERE xEEID IN 
        (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES'));

    --==========================================
    -- BDM Section
    --==========================================
    -- now set values for benefit module
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption', 'AuditDate');

    -- Non-required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DIS,DPC,STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');

    --Set if OE
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE');
    END;

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ESUNLNC83C D
    JOIN dbo.U_dsi_bdm_ESUNLNC83C E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ESUNLNC83C
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ESUNLNC83C
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ESUNLNC83C
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ESUNLNC83C
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ESUNLNC83C
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ESUNLNC83C
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Driver Tables
    --==========================================

    /**************************************************************************************************************
        HEADER RECORDS
            - ISA, GS, ST, BGN, REF, QTY Segments
            - LOOP 1000A/1000B RECORDS - N1 Segments
    ***************************************************************************************************************/

    -------------------
    -- HEADER RECORD 
    -------------------
    IF OBJECT_ID('U_ESUNLNC83C_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLNC83C_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = '30'
        ,drvISA06_SenderID = '710732557'
        ,drvISA07_ReceiverIDQual = '30'
        ,drvISA08_ReceiverID = '060893662'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'FULLFILE') WHEN 'Y' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = 'Priority Wire & Cable, Inc.'
        ,drvGS03_ReceiverID = '060893662'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = 'ET'
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = '4'
        ,drvREF01_RefNumberQual = '38'
        ,drvREF02_RefNumberQual = '941752'
        ,drvDTP01_DateTimeQualifier1 = '007'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = GETDATE()
        ,drvQTY01_QuantityQual1 = 'ET'
        ,drvQTY02_Quantity1 = (SELECT COUNT(DISTINCT BdmEEID) FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK) WHERE BdmRecType = 'EMP')
        ,drvQTY01_QuantityQual2 = 'DT'
        ,drvQTY02_Quantity2 = (SELECT COUNT(DISTINCT BdmEEID) FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK) WHERE BdmRecType = 'DEP')
        ,drvQTY01_QuantityQual3 = 'TO'
        ,drvQTY02_Quantity3 = (SELECT COUNT(DISTINCT BdmEEID) FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK))
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'Priority Wire & Cable, Inc.'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = '710732557'
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'Sun Life Financial'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '060893662'
    INTO dbo.U_ESUNLNC83C_HdrTbl
    FROM dbo.U_ESUNLNC83C_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2000 RECORDS - INS, REF, DTP Segments
            -- LOOP 2100A RECORDS - NM1, PER, N3, N4, DMG, ICM Segments
            -- LOOP 2100B RECORDS - NM1, DMG Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_ESUNLNC83C_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLNC83C_DrvTbl;
    SELECT DISTINCT
        --=====================
        --LOOP 2000 RECORDS
        --=====================
        drvINS01_YesNoCond = CASE BdmRecType
                                 WHEN 'EMP' THEN 'Y'
                                 ELSE 'N'
                             END
        ,drvINS02_RelationshipCode = CASE WHEN BdmRecType = 'EMP' THEN '18'
                                          ELSE
                                                CASE WHEN ConRelationship IN ('SPS') THEN '01'
                                                    WHEN ConRelationship IN ('DP') THEN '53'
                                                     WHEN ConRelationship IN ('CHL,DIS,DPC,STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode = CASE WHEN EecEmplStatus = 'T' THEN '024' ELSE '030' END --Audit or Compare
        ,drvINS04_MaintReasonCode = 'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
                                                     --WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
                                                     --WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
                                                     ELSE 'AC'
                                                END
                                         END
        ,drvINS09_StudentStatusCode = CASE WHEN BdmRecType = 'DEP' THEN
                                                CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time
                                      END
        ,drvINS10_ResponseCode = CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN EepIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                      WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                END
        ,drvINS11_DateTimeFormatQual = '' -- CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN 'D8' END
        ,drvINS12_DateTimePeriod = '' --CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) END
        ,drvINS17_BirthSequenceNumber = ''
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = CASE WHEN EecCOID IN ('XRAEE','XRS43') THEN '17'
                                            --WHEN DedCode_LTDH = 'LTDH' THEN '17'
                                            --WHEN DedCode_LTD  = 'LTD' THEN '17'
                                            --WHEN DedCode_LTDC2 = 'LTDC2' THEN '17'
                                            --WHEN DedCode_LTDC4 = 'LTDC4' THEN '17'
                                            END
        ,drvREF02_RefNumberQual1 =   CASE    WHEN EecCOID IN ( 'XRAEE','XRS43') AND (EecSalaryOrHourly = 'H' AND ((SELECT YEAR(getdate()) - YEAR(EecDateOfLastHire) - CASE WHEN MONTH(getdate()) < MONTH(EecDateOfLastHire) OR (DAY(getdate()) < DAY(EecDateOfLastHire) AND MONTH(getdate()) = MONTH(EecDateOfLastHire) ) THEN 1 ELSE  0 END) >=  5)) THEN '2524264'
                                            WHEN EecCOID IN ( 'XRAEE','XRS43') AND (EecSalaryOrHourly = 'S' AND ((SELECT YEAR(getdate()) - YEAR(EecDateOfLastHire) - CASE WHEN MONTH(getdate()) < MONTH(EecDateOfLastHire) OR (DAY(getdate()) < DAY(EecDateOfLastHire) AND MONTH(getdate()) = MONTH(EecDateOfLastHire) ) THEN 1 ELSE  0 END) >=  5)) THEN '2524265'
                                            WHEN EecCOID IN ( 'XRAEE','XRS43') AND (EecSalaryOrHourly = 'H' AND ((SELECT YEAR(getdate()) - YEAR(EecDateOfLastHire) - CASE WHEN MONTH(getdate()) < MONTH(EecDateOfLastHire) OR (DAY(getdate()) < DAY(EecDateOfLastHire) AND MONTH(getdate()) = MONTH(EecDateOfLastHire) ) THEN 1 ELSE  0 END) <   5)) THEN '2589382'
                                            WHEN EecCOID IN ( 'XRAEE','XRS43') AND (EecSalaryOrHourly = 'S' AND ((SELECT YEAR(getdate()) - YEAR(EecDateOfLastHire) - CASE WHEN MONTH(getdate()) < MONTH(EecDateOfLastHire) OR (DAY(getdate()) < DAY(EecDateOfLastHire) AND MONTH(getdate()) = MONTH(EecDateOfLastHire) ) THEN 1 ELSE  0 END) <   5)) THEN '2589383'
                                            --WHEN DedCode_LTDH = 'LTDH' THEN '2524264'
                                            --WHEN DedCode_LTD  = 'LTD' THEN '2524265'
                                            --WHEN DedCode_LTDC2 = 'LTDC2' THEN '2589383'
                                            --WHEN DedCode_LTDC4 = 'LTDC4' THEN '2589382'
                                            END
                                        
                                    --CASE WHEN EecSalaryOrHourly = 'H' THEN '2524264'
         --                               WHEN EecSalaryOrHourly = 'S' THEN '2524265'
         --                               ELSE ''
         --                           END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = 'DX'
        ,drvREF02_RefNumberQual2 = CASE WHEN EecCOID = 'XRAEE' THEN '2242992'
                                        WHEN EecCOID = 'XRS43' THEN '2305881'
                                        END
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = 'DTP'
        ,drvDTP01_DateTimeQualifier1 = '336'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = EecDateOfLastHire
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = CASE WHEN EecEmplStatus = 'T' THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier2 = '337'
        ,drvDTP02_DateTimeFormatQual2 = 'D8'
        ,drvDTP03_DateTimePeriod2 = EecDateOfTermination
        --=====================
        -- LOOP 2100A RECORDS
        --=====================
        ,drvNM103_NameLast1 = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameLast, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'ñ','n')
                                   WHEN BdmRecType = 'DEP' THEN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ConNameLast, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'ñ','n')
                              END)
        ,drvNM104_NameFirst1 = dbo.dsi_fnRemoveChars('.,/-',
                               CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                    WHEN BdmRecType = 'DEP' THEN ConNameFirst
                               END)
        ,drvNM105_NameMiddleInitial1 = dbo.dsi_fnRemoveChars('.,/-',
                                       CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                            WHEN BdmRecType = 'DEP' THEN LEFT(ConNameMiddle,1)
                                       END)
        ,drvNM106_NamePrefix1 = CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' THEN CASE WHEN EepNameSuffix NOT IN ('Z') THEN EepNameSuffix END
                                     WHEN BdmRecType = 'DEP' THEN CASE WHEN ConNameSuffix NOT IN ('Z') THEN ConNameSuffix END
                                END
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' AND ConSSN NOT IN ('000000000', '999999999', '888888888', '123456789') AND LEFT(ConSSN, 3) NOT IN ('999','998') THEN '34'
                                     END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' AND ConSSN NOT IN ('000000000', '999999999', '888888888', '123456789') AND LEFT(ConSSN, 3) NOT IN ('999','998') THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' THEN --CASE WHEN BdmRecType = 'EMP' THEN 'HP' END
                                            CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN 'HP' 
                                                 ELSE CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' and ISNULL(EepAddressEMail, '') <> '' THEN 'EM' END
                                            END
                                        END 
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepPhoneHomeNumber,'') END
                                            CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber
                                                 ELSE CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' and ISNULL(EepAddressEMail, '') <> '' THEN EepAddressEMail END
                                            END
                                        END 
        ,drvPER05_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(EepAddressEMail, '') <> '' THEN 'EM' END
        ,drvPER06_CommunicationNumber = EepAddressEMail --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EecPhoneBusinessNumber,'') END
        ,drvPER07_CommNumberQualifier = '' --CASE WHEN BdmRecType = 'EMP' THEN 'EM' END  -- TODO check if blank to be sent or field completely removed based on above sending email or primary phonw.
        ,drvPER08_CommunicationNumber = '' --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(eepAddressEMail,'') END
        ,drvN301_AddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvN302_AddressLine2 = dbo.dsi_fnRemoveChars('.,/-:;',EepAddressLine2)
        ,drvN401_City = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvN402_State = EepAddressState
        ,drvN403_Zip = EepAddressZipCode
        ,drvN404_CountryCode = CASE WHEN EepAddressCountry NOT IN ('US','USA') THEN EepAddressCountry END
        ,drvDMG02_DateTimePeriod1 = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),EepDateOfBirth,112)
                                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(8),ConDateOfBirth,112)
                                    END
        ,drvDMG03_GenderCode1 = CASE WHEN BdmRecType = 'EMP' AND EepGender IN ('M','F') THEN EepGender
                                     WHEN BdmRecType = 'DEP' AND EepGender IN ('M','F') THEN ConGender
                                     ELSE 'M'
                                END
        ,drvDMG04_MaritalStatusCode1 = '' /*CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'I' END
                                       END*/
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = CASE WHEN BdmRecType = 'EMP' THEN '7' END --'7'
        ,drvICM02_MonetaryAmount = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvICM03_Quantity =    FORMAT(CASE WHEN BdmRecType = 'EMP' THEN 
                                    CASE WHEN EecPayPeriod = 'W' THEN EecScheduledWorkHrs
                                        WHEN EecPayPeriod = 'B' THEN (EecScheduledWorkHrs/2)
                                        WHEN EecPayPeriod = 'S' THEN (EecScheduledWorkHrs*24)/52
                                        WHEN EecPayPeriod = 'M' THEN (EecScheduledWorkHrs*12)/52
                                    END
                                END, '#.00')
        ,drvICM04_LocationID = CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112)
                                            ELSE CONVERT(CHAR(4),YEAR(GETDATE())) + '0101'
                                        END
                               END
        -- If drvAMT00_AmountQualifierCode1 = 'AMT' is Populated, then Send AMT Segment
        ,drvAMT00_SegmentID1 = ''
        ,drvAMT01_AmountQualifierCode1 = ''
        ,drvAMT02_MonetaryAmount1 = ''
        -- If drvAMT00_AmountQualifierCode2 = 'AMT' is Populated, then Send AMT Segment
        ,drvAMT00_SegmentID2 = ''
        ,drvAMT01_AmountQualifierCode2 = ''
        ,drvAMT02_MonetaryAmount2 = ''
        -- If drvHLH00_SegmentID = 'HLH' is Populated, then Send HLH Segment
        ,drvHLH00_SegmentID = 'HLH'
        ,drvHLH01_HealthRelatedCode = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepIsSmoker
                                                     WHEN 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
                                           WHEN BdmRecType = 'DEP' THEN
                                                CASE ConIsSmoker
                                                     WHEN 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
                                      END
        ,drvHLH02_Height = ''
        ,drvHLH03_Weight1 = ''
        ,drvHLH04_Weight2 = ''
        ,drvHLH05_Description1 = ''
        ,drvHLH06_CurrentHealthConditionCode = ''
        ,drvHLH07_Description2 = ''
        ---------------------------------
        ,drvEEID = xEEID
        ,drvCOID = xCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN = EepSSN
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,'')) + ' 1'
    INTO dbo.U_ESUNLNC83C_DrvTbl
    FROM dbo.U_ESUNLNC83C_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
 JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID, BdmRunId, BdmDepRecID
                ,MAX(BdmBenStartDate) AS BdmBenStartDate
                ,MAX(BdmStopDate) AS BdmBenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LTDH' THEN BdmDedCode END) AS DedCode_LTDH
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmDedCode END) AS DedCode_LTD
                ,MAX(CASE WHEN BdmDedCode = 'LTDC2' THEN BdmDedCode END) AS DedCode_LTDC2
                ,MAX(CASE WHEN BdmDedCode = 'LTDC4' THEN BdmDedCode END) AS DedCode_LTDC4
                ,MAX(CASE WHEN BdmDedCode in ('LIF','LIFS','LIFC','SHO','ACC','CRI','CRIES','CRICH','CANP1','VIS','LIFE') THEN 'Y' END) AS DedCode_ALL
            FROM dbo.U_dsi_BDM_ESUNLNC83C WITH (NOLOCK)
            
            GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmRunId, BdmDepRecID
        ) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
        Where eeceetype <> 'TES';

    INSERT INTO dbo.U_ESUNLNC83C_DrvTbl
    SELECT DISTINCT
        drvINS01_YesNoCond = 'X'
        ,drvINS02_RelationshipCode
        ,drvINS03_MaintTypeCode
        ,drvINS04_MaintReasonCode
        ,drvINS05_BenefitStatusCode
        ,drvINS0601_MEDICAREPLANCODE
        ,drvINS0602_EligibilityRsnCode
        ,drvINS07_COBRAQualEventCode
        ,drvINS08_EmploymentStatusCode
        ,drvINS09_StudentStatusCode
        ,drvINS10_ResponseCode
        ,drvINS11_DateTimeFormatQual
        ,drvINS12_DateTimePeriod
        ,drvINS17_BirthSequenceNumber
        ,drvREF01_RefNumberQual1 = '3H'
        ,drvREF02_RefNumberQual1 =    CASE WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '300' THEN '329302'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '200' THEN '329303'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '000' THEN '329304'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '150' THEN '329305'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '110' THEN '329306'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '120' THEN '329307'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '100' THEN '329308'
                                        WHEN EecOrgLvl1 = '23' AND EecOrgLvl2 = '000' THEN '329309'
                                        WHEN EecOrgLvl1 = '0094' AND EecOrgLvl2 = '0051' THEN '329310'
                                        WHEN EecOrgLvl1 = '0094' AND EecOrgLvl2 = '0037' THEN '329311'
                                        WHEN EecOrgLvl1 = '0094' AND EecOrgLvl2 = '0000' THEN '329312'
                                        WHEN EecOrgLvl1 = '0094' AND EecOrgLvl2 = '0025' THEN '329313'
                                        WHEN EecOrgLvl1 = '0094' AND EecOrgLvl2 = '0045' THEN '329314'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0000' THEN '329315'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0028' THEN '329316'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0034' THEN '329317'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0098' THEN '329318'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0099' THEN '329319'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0032' THEN '329320'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0051' THEN '329321'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0016' THEN '329322'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0037' THEN '329323'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0061' THEN '329324'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0052' THEN '329325'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0054' THEN '329326'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0007' THEN '329327'
                                        WHEN EecOrgLvl1 = '0095' AND EecOrgLvl2 = '0007' THEN '329328'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0025' THEN '329329'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0001' THEN '329330'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0045' THEN '329331'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0065' THEN '329332'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0016' THEN '329333'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0034' THEN '329334'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0025' THEN '329335'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0029' THEN '329336'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0030' THEN '329337'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0033' THEN '329338'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0031' THEN '329339'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0035' THEN '329340'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0032' THEN '329341'
                                        
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0001' THEN '329353'

                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0045' THEN '329355'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0065' THEN '329356'

                                        WHEN EecOrgLvl1 = '12' AND EecOrgLvl2 = '000' THEN '329361'


                                        WHEN EecOrgLvl1 = '25' AND EecOrgLvl2 = '000' THEN '329375'
                                        WHEN EecOrgLvl1 = '03' AND EecOrgLvl2 = '000' THEN '329376'
                                        WHEN EecOrgLvl1 = '40' AND EecOrgLvl2 = '000' THEN '329378'
                                        WHEN EecOrgLvl1 = '52' AND EecOrgLvl2 = '000' THEN '329380'
                                        WHEN EecOrgLvl1 = '06' AND EecOrgLvl2 = '000' THEN '329381'
                                        WHEN EecOrgLvl1 = '08' AND EecOrgLvl2 = '000' THEN '329383'
                                        WHEN EecOrgLvl1 = '51' AND EecOrgLvl2 = '000' THEN '329386'


                                        WHEN EecOrgLvl1 = '17' AND EecOrgLvl2 = '000' THEN '329367'

                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0051' THEN '329342'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0016' THEN '329343'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0049' THEN '329344'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0062' THEN '329345'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0037' THEN '329346'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0061' THEN '329347'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0052' THEN '329348'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0054' THEN '329349'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0007' THEN '329350'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0068' THEN '329351'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0025' THEN '329352'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0064' THEN '329354'
                                        WHEN EecOrgLvl1 = '01' AND EecOrgLvl2 = '000' THEN '329357'
                                        WHEN EecOrgLvl1 = '10' AND EecOrgLvl2 = '000' THEN '329359'
                                        WHEN EecOrgLvl1 = '11' AND EecOrgLvl2 = '000' THEN '329360'
                                        WHEN EecOrgLvl1 = '13' AND EecOrgLvl2 = '000' THEN '329363'
                                        WHEN EecOrgLvl1 = '14' AND EecOrgLvl2 = '000' THEN '329364'
                                        WHEN EecOrgLvl1 = '15' AND EecOrgLvl2 = '000' THEN '329365'
                                        WHEN EecOrgLvl1 = '16' AND EecOrgLvl2 = '000' THEN '329366'
                                        WHEN EecOrgLvl1 = '18' AND EecOrgLvl2 = '000' THEN '329368'
                                        WHEN EecOrgLvl1 = '19' AND EecOrgLvl2 = '000' THEN '329369'
                                        WHEN EecOrgLvl1 = '02' AND EecOrgLvl2 = '000' THEN '329370'
                                        WHEN EecOrgLvl1 = '20' AND EecOrgLvl2 = '000' THEN '329371'
                                        WHEN EecOrgLvl1 = '21' AND EecOrgLvl2 = '000' THEN '329372'
                                        WHEN EecOrgLvl1 = '22' AND EecOrgLvl2 = '000' THEN '329373'
                                        WHEN EecOrgLvl1 = '24' AND EecOrgLvl2 = '000' THEN '329374'
                                        WHEN EecOrgLvl1 = '04' AND EecOrgLvl2 = '000' THEN '329377'
                                        WHEN EecOrgLvl1 = '05' AND EecOrgLvl2 = '000' THEN '329379'
                                        WHEN EecOrgLvl1 = '07' AND EecOrgLvl2 = '000' THEN '329382'
                                        WHEN EecOrgLvl1 = '09' AND EecOrgLvl2 = '000' THEN '329384'
                                        WHEN EecOrgLvl1 = '50' AND EecOrgLvl2 = '000' THEN '329385'

                                        WHEN EecOrgLvl1 = '26' AND EecOrgLvl2 = '000' THEN '332140'
                                        --WHEN EecOrgLvl1 = '27' AND EecOrgLvl2 = '000' THEN '332141'

                                        WHEN EecOrgLvl1 = '27' AND EecOrgLvl2 = '000' THEN '334295'
                                        WHEN EecOrgLvl1 = '28' AND EecOrgLvl2 = '000' THEN '334235'
                                        WHEN EecOrgLvl1 = '29' AND EecOrgLvl2 = '000' THEN '334236'
                                        WHEN EecOrgLvl1 = '30' AND EecOrgLvl2 = '000' THEN '334296'
                                        WHEN EecOrgLvl1 = '31' AND EecOrgLvl2 = '000' THEN '334297'
                                        WHEN EecOrgLvl1 = '32' AND EecOrgLvl2 = '000' THEN '334298'
                                        WHEN EecOrgLvl1 = '33' AND EecOrgLvl2 = '000' THEN '334299'
                                        WHEN EecOrgLvl1 = '34' AND EecOrgLvl2 = '000' THEN '334300'
                                        WHEN EecOrgLvl1 = '35' AND EecOrgLvl2 = '000' THEN '334301'
                                        WHEN EecOrgLvl1 = '36' AND EecOrgLvl2 = '000' THEN '334302'
                                        WHEN EecOrgLvl1 = '37' AND EecOrgLvl2 = '000' THEN '334303'
                                        WHEN EecOrgLvl1 = '38' AND EecOrgLvl2 = '000' THEN '334304'
                                        WHEN EecOrgLvl1 = '39' AND EecOrgLvl2 = '000' THEN '334305'
                                        WHEN EecOrgLvl1 = '40' AND EecOrgLvl2 = '000' THEN '334306'
                                        WHEN EecOrgLvl1 = '41' AND EecOrgLvl2 = '000' THEN '334307'
                                        WHEN EecOrgLvl1 = '42' AND EecOrgLvl2 = '000' THEN '334308'
                                        WHEN EecOrgLvl1 = '43' AND EecOrgLvl2 = '000' THEN '334309'
                                        WHEN EecOrgLvl1 = '44' AND EecOrgLvl2 = '000' THEN '334310'
                                        WHEN EecOrgLvl1 = '45' AND EecOrgLvl2 = '000' THEN '334311'
                                        WHEN EecOrgLvl1 = '46' AND EecOrgLvl2 = '000' THEN '334312'
                                        WHEN EecOrgLvl1 = '47' AND EecOrgLvl2 = '000' THEN '334313'
                                        WHEN EecOrgLvl1 = '48' AND EecOrgLvl2 = '000' THEN '334314'
                                        WHEN EecOrgLvl1 = '49' AND EecOrgLvl2 = '000' THEN '334315'
                                        WHEN EecOrgLvl1 = '50' AND EecOrgLvl2 = '000' THEN '334316'
                                        WHEN EecOrgLvl1 = '51' AND EecOrgLvl2 = '000' THEN '334317'
                                        WHEN EecOrgLvl1 = '52' AND EecOrgLvl2 = '000' THEN '334318'
                                        WHEN EecOrgLvl1 = '53' AND EecOrgLvl2 = '000' THEN '334319'
                                        WHEN EecOrgLvl1 = '54' AND EecOrgLvl2 = '000' THEN '334320'
                                        WHEN EecOrgLvl1 = '55' AND EecOrgLvl2 = '000' THEN '334321'
                                        WHEN EecOrgLvl1 = '56' AND EecOrgLvl2 = '000' THEN '334322'
                                        WHEN EecOrgLvl1 = '57' AND EecOrgLvl2 = '000' THEN '334323'
                                        WHEN EecOrgLvl1 = '58' AND EecOrgLvl2 = '000' THEN '334324'
                                        WHEN EecOrgLvl1 = '59' AND EecOrgLvl2 = '000' THEN '334325'
                                        WHEN EecOrgLvl1 = '60' AND EecOrgLvl2 = '000' THEN '334326'
                                        WHEN EecOrgLvl1 = '61' AND EecOrgLvl2 = '000' THEN '334327'
                                        WHEN EecOrgLvl1 = '62' AND EecOrgLvl2 = '000' THEN '334328'
                                        WHEN EecOrgLvl1 = '63' AND EecOrgLvl2 = '000' THEN '334329'
                                        WHEN EecOrgLvl1 = '64' AND EecOrgLvl2 = '000' THEN '334330'
                                        WHEN EecOrgLvl1 = '65' AND EecOrgLvl2 = '000' THEN '334331'
                                        WHEN EecOrgLvl1 = '66' AND EecOrgLvl2 = '000' THEN '334332'
                                        WHEN EecOrgLvl1 = '67' AND EecOrgLvl2 = '000' THEN '334333'
                                        WHEN EecOrgLvl1 = '68' AND EecOrgLvl2 = '000' THEN '334334'
                                        WHEN EecOrgLvl1 = '69' AND EecOrgLvl2 = '000' THEN '334335'
                                        WHEN EecOrgLvl1 = '70' AND EecOrgLvl2 = '000' THEN '334336'
                                        WHEN EecOrgLvl1 = '71' AND EecOrgLvl2 = '000' THEN '334337'
                                        WHEN EecOrgLvl1 = '72' AND EecOrgLvl2 = '000' THEN '334338'
                                        WHEN EecOrgLvl1 = '73' AND EecOrgLvl2 = '000' THEN '334339'
                                        WHEN EecOrgLvl1 = '74' AND EecOrgLvl2 = '000' THEN '334340'
                                        WHEN EecOrgLvl1 = '75' AND EecOrgLvl2 = '000' THEN '334341'
                                        WHEN EecOrgLvl1 = '76' AND EecOrgLvl2 = '000' THEN '334342'
                                        WHEN EecOrgLvl1 = '77' AND EecOrgLvl2 = '000' THEN '334343'
                                        WHEN EecOrgLvl1 = '78' AND EecOrgLvl2 = '000' THEN '334344'
                                        WHEN EecOrgLvl1 = '79' AND EecOrgLvl2 = '000' THEN '334345'
                                        WHEN EecOrgLvl1 = '80' AND EecOrgLvl2 = '000' THEN '334346'
                                        WHEN EecOrgLvl1 = '81' AND EecOrgLvl2 = '000' THEN '334347'
                                        WHEN EecOrgLvl1 = '82' AND EecOrgLvl2 = '000' THEN '334348'
                                        WHEN EecOrgLvl1 = '83' AND EecOrgLvl2 = '000' THEN '334349'
                                        WHEN EecOrgLvl1 = '84' AND EecOrgLvl2 = '000' THEN '334350'
                                        WHEN EecOrgLvl1 = '85' AND EecOrgLvl2 = '000' THEN '334351'
                                        WHEN EecOrgLvl1 = '86' AND EecOrgLvl2 = '000' THEN '334352'
                                        WHEN EecOrgLvl1 = '87' AND EecOrgLvl2 = '000' THEN '334353'
                                        WHEN EecOrgLvl1 = '88' AND EecOrgLvl2 = '000' THEN '334354'
                                        WHEN EecOrgLvl1 = '89' AND EecOrgLvl2 = '000' THEN '334355'
                                        WHEN EecOrgLvl1 = '90' AND EecOrgLvl2 = '000' THEN '334356'
                                        WHEN EecOrgLvl1 = '91' AND EecOrgLvl2 = '000' THEN '334357'
                                        WHEN EecOrgLvl1 = '92' AND EecOrgLvl2 = '000' THEN '334358'
                                        WHEN EecOrgLvl1 = '93' AND EecOrgLvl2 = '000' THEN '334359'
                                        WHEN EecOrgLvl1 = '94' AND EecOrgLvl2 = '000' THEN '334360'
                                        WHEN EecOrgLvl1 = '95' AND EecOrgLvl2 = '000' THEN '334361'
                                        WHEN EecOrgLvl1 = '96' AND EecOrgLvl2 = '000' THEN '334362'
                                        WHEN EecOrgLvl1 = '97' AND EecOrgLvl2 = '000' THEN '334363'
                                        WHEN EecOrgLvl1 = '98' AND EecOrgLvl2 = '000' THEN '334364'
                                        WHEN EecOrgLvl1 = '99' AND EecOrgLvl2 = '000' THEN '334365'
                                        WHEN EecOrgLvl1 = '100' AND EecOrgLvl2 = '000' THEN '334366'

                                        WHEN EecOrgLvl1 = '90' AND EecOrgLvl2 = '900' THEN '335875'
                                        WHEN ISNULL(EecUDField03, '') <> '' THEN EecUDField03
                                        ELSE '329387'
                                    END
                                    /*CASE EecOrgLvl1
                                        WHEN '00' THEN '327053'
                                        WHEN '0092' THEN '327055'
                                        WHEN '0095' THEN '327056'
                                        WHEN '0093' THEN '327057'
                                        WHEN '0094' THEN '327058'
                                        WHEN '0090' THEN '327059'
                                        WHEN '0091' THEN '327060'
                                        WHEN '21' THEN '327061'
                                        WHEN '01' THEN '327062'
                                        WHEN '10' THEN '327063'
                                        WHEN '11' THEN '327064'
                                        WHEN '12' THEN '327065'
                                        WHEN '13' THEN '327066'
                                        WHEN '14' THEN '327067'
                                        WHEN '15' THEN '327068'
                                        WHEN '16' THEN '327069'
                                        WHEN '17' THEN '327070'
                                        WHEN '18' THEN '327071'
                                        WHEN '19' THEN '327072'
                                        WHEN '02' THEN '327073'
                                        WHEN '20' THEN '327074'
                                        WHEN '22' THEN '327075'
                                        WHEN '24' THEN '327076'
                                        WHEN '25' THEN '327077'
                                        WHEN '03' THEN '327078'
                                        WHEN '04' THEN '327079'
                                        WHEN '40' THEN '327080'
                                        WHEN '05' THEN '327081'
                                        WHEN '50' THEN '327082'
                                        WHEN '51' THEN '327083'
                                        WHEN '52' THEN '327084'
                                        WHEN '06' THEN '327085'
                                        WHEN '07' THEN '327086'
                                        WHEN '08' THEN '327087'
                                        WHEN '09' THEN '327088'
                                        WHEN '23' THEN '327054'
                                        ELSE '!' -- + EecOrgLvl1
                                    END*/
        ,drvREF01_RefNumberQual2 
        ,drvREF02_RefNumberQual2     
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1
        ,drvDTP01_DateTimeQualifier1 
        ,drvDTP02_DateTimeFormatQual1
        ,drvDTP03_DateTimePeriod1
        ,drvDTP00_DateTime2 
        ,drvDTP01_DateTimeQualifier2 
        ,drvDTP02_DateTimeFormatQual2
        ,drvDTP03_DateTimePeriod2 
        --=====================
        -- LOOP 2100A RECORDS
        --=====================
        ,drvNM103_NameLast1 
        ,drvNM104_NameFirst1
        ,drvNM105_NameMiddleInitial1
        ,drvNM106_NamePrefix1
        ,drvNM107_NameSuffix1
        ,drvNM108_IDCodeQualifier1
        ,drvNM109_IDCode1 
        ,drvPER02_Name 
        ,drvPER03_CommNumberQualifier
        ,drvPER04_CommunicationNumber
        ,drvPER05_CommNumberQualifier
        ,drvPER06_CommunicationNumber
        ,drvPER07_CommNumberQualifier
        ,drvPER08_CommunicationNumber
        ,drvN301_AddressLine1
        ,drvN302_AddressLine2
        ,drvN401_City
        ,drvN402_State
        ,drvN403_Zip
        ,drvN404_CountryCode
        ,drvDMG02_DateTimePeriod1
        ,drvDMG03_GenderCode1 
        ,drvDMG04_MaritalStatusCode1 
        ,drvICM01_FrequencyCode 
        ,drvICM02_MonetaryAmount 
        ,drvICM03_Quantity 
        ,drvICM04_LocationID
        ,drvAMT00_SegmentID1
        ,drvAMT01_AmountQualifierCode1 
        ,drvAMT02_MonetaryAmount1 
        ,drvAMT00_SegmentID2 
        ,drvAMT01_AmountQualifierCode2 
        ,drvAMT02_MonetaryAmount2 
        ,drvHLH00_SegmentID 
        ,drvHLH01_HealthRelatedCode
        ,drvHLH02_Height 
        ,drvHLH03_Weight1
        ,drvHLH04_Weight2
        ,drvHLH05_Description1 
        ,drvHLH06_CurrentHealthConditionCode 
        ,drvHLH07_Description2 
        ---------------------------------
        ,drvEEID 
        ,drvCOID 
        ,drvDepRecID 
        ,drvSSN 
        ,drvInitialSort 
        ,drvSubSort = LEFT(drvSubSort, LEN(drvSubSort)-2) + ' 3'
    FROM dbo.U_ESUNLNC83C_DrvTbl
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
        AND EecCOID = drvCOID
        Where eeceetype <> 'TES'
    ;

    DECLARE @EmpCount INT
        ,@DedCount INT
    ;

    SELECT @EmpCount = (SELECT COUNT(*) FROM dbo.U_ESUNLNC83C_DrvTbl WITH (NOLOCK) WHERE drvINS01_YesNoCond = 'Y');
    SELECT @DedCount = (SELECT COUNT(*) FROM dbo.U_ESUNLNC83C_DrvTbl WITH (NOLOCK) WHERE drvINS01_YesNoCond = 'N');

    UPDATE dbo.U_ESUNLNC83C_HdrTbl
        SET drvQTY02_Quantity1 = @EmpCount
            ,drvQTY02_Quantity2 = @DedCount
            ,drvQTY02_Quantity3 = @EmpCount + @DedCount
    ;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2300 RECORDS - HD, DTP, AMT Segments
            -- Loop 2700 RECORDS - LX Segments
            -- Loop 2750 RECORDS - N1, REF Segments
    ***************************************************************************************************************/

    Update dbo.U_ESUNLNC83C_DrvTbl set drvINS17_BirthSequenceNumber = counts
        FROM dbo.U_ESUNLNC83C_DrvTbl
        JOIN (
            select drvEEID as eeid,drvCOID as coid,drvDepRecID  as recid,drvDMG02_dateTimePeriod1,count(drvDMG02_dateTimePeriod1) as counts 
            from dbo.U_ESUNLNC83C_DrvTbl 
            where drvIns01_YesNoCond  = 'N' 
            group by   drvEEID,drvCOID,drvDepRecID,drvDMG02_dateTimePeriod1 
            having count(drvDMG02_dateTimePeriod1) > 1 
        ) as  Updates
        ON eeid =  drvEEID AND coid =  drvCOID and recid =  drvDepRecID
        and drvINS01_YesNoCond = 'N';

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_ESUNLNC83C_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLNC83C_DrvTbl_2300;
  SELECT DISTINCT * 
    INTO dbo.U_ESUNLNC83C_DrvTbl_2300 
    FROM (
        SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = 'HD'             
        ,drvHD01_MaintTypeCode = CASE WHEN EecEmplStatus = 'T' THEN '024' ELSE '030' END --Audit or Compare
        ,drvHD02_MaintReasonCode = ''
        ,drvHD03_InsuranceLineCode =    CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN BdmDedCode IN ('LTDH','LTD','LTDC2','LTDC4') THEN 'LTD'
                                                    WHEN BdmDedCode IN ('LIF') THEN 'AF'
                                                    WHEN BdmDedCode IN ('SHO') THEN 'STD'
                                                    WHEN BdmDedCode IN ('ACC','CANP1','CRI') THEN 'ZZZ'
                                                    WHEN BdmDedCode IN ('VIS') THEN 'VIS'
                                                    WHEN BdmDedCode = 'LIFE' THEN 'AC'
                                                    --WHEN BdmDedCode = 'LIFE' THEN 'ADD'
                                                END
                                            WHEN BdmRecType = 'DEP' AND ConRelationship IN ('SPS','DP')THEN
                                                CASE WHEN BdmDedCode IN ('LIFS') THEN 'AF'
                                                    WHEN BdmDedCode IN ('ACC','CANP1','CRIES') THEN 'ZZZ'
                                                    WHEN BdmDedCode IN ('VIS') THEN 'VIS'
                                                END                                            
                                            WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DIS','DPC','STC')THEN
                                                CASE WHEN BdmDedCode IN ('LIFC') THEN 'AF'
                                                    WHEN BdmDedCode IN ('ACC','CANP1','CRICH') THEN 'ZZZ'
                                                    WHEN BdmDedCode IN ('VIS') THEN 'VIS'
                                                END    
                                        END
        ,drvHD04_PlanCoverageDesc =    CASE WHEN BdmRecType = 'EMP' THEN
                                            CASE WHEN BdmDedCode IN ('LTDH','LTD','LTDC4','LIFE') THEN 'N'   --KE 20230323 - per vendor 'LTDC2' should pass with a 'C'
                                                WHEN BDmDedCode IN ('LTDC2') THEN 'C' 
                                                WHEN BdmDedCode IN ('LIF') THEN 'V'
                                                WHEN BdmDedCode IN ('SHO') THEN 'V/STD'
                                                WHEN BdmDedCode IN ('ACC') THEN 'V/ACC'
                                                WHEN BdmDedCode IN ('CANP1') THEN 'V/CAN'
                                                WHEN BdmDedCode IN ('CRI','CRIES','CRICH') THEN 'V/CIB'
                                                WHEN BdmDedCode IN ('VIS') THEN 'V/EYE'
                                            END
                                        WHEN BdmRecType = 'DEP' AND ConRelationship IN ('SPS','DP') THEN
                                            CASE WHEN BdmDedCode IN ('LIFS') THEN 'V'
                                                WHEN BdmDedCode IN ('ACC') THEN 'V/ACC'
                                                WHEN BdmDedCode IN ('CANP1') THEN 'V/CAN'
                                                WHEN BdmDedCode IN ('CRI','CRIES','CRICH') THEN 'V/CIB'
                                                WHEN BdmDedCode IN ('VIS') THEN 'V/EYE'
                                            END
                                        WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DIS','DPC','STC') THEN
                                            CASE WHEN BdmDedCode IN ('LIFC') THEN 'V'
                                                WHEN BdmDedCode IN ('ACC') THEN 'V/ACC'
                                                WHEN BdmDedCode IN ('CANP1') THEN 'V/CAN'
                                                WHEN BdmDedCode IN ('CRI','CRIES','CRICH') THEN 'V/CIB'
                                                WHEN BdmDedCode IN ('VIS') THEN 'V/EYE'
                                            END
                                    END
        ,drvHD05_CoverageLevelCode = CASE WHEN BdmDedCode IN ('ACC','CANP1','VIS') THEN 
                                            CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                                WHEN BdmBenOption IN ('EES','EEDP') THEN 'ESP'
                                                WHEN BdmBenOption IN ('EEC','EECH') THEN 'ECH'
                                                WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'FAM'
                                            END
                                        WHEN BdmRecType = 'EMP' THEN
                                            CASE WHEN BdmDedCode IN ('LTDH','LTD','SHO','CRI', 'LIFE','LTDC2','LTDC4') THEN 'EMP'
                                                WHEN BdmDedCode IN ('LIF') THEN 'EMP'
                                            END
                                        WHEN BdmRecType = 'DEP' AND ConRelationship IN ('SPS','DP') THEN
                                            CASE WHEN BdmDedCode IN ('LIFS','CRIES') THEN 'SPO'
                                            END
                                        WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DIS','DPC','STC') THEN
                                            CASE WHEN BdmDedCode IN ('LIFC','CRICH') THEN 'CHD'
                                            END
                                        END
                -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = 'DTP' 
        ,drvDTP01_DateTimeQualifier_348 = '348' 
        ,drvDTP02_DateTimeFormatQual_348 = 'D8' 
        ,drvDTP03_DateTimePeriod_348 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '10/1/2020') 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN /*BdmDedType IN ('MED','DEN','VIS') AND*/ BdmBenStopDate IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN /*BdmDedType IN ('MED','DEN','VIS') AND*/ BdmBenStopDate IS NOT NULL THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN /*BdmDedType IN ('MED','DEN','VIS') AND*/ BdmBenStopDate IS NOT NULL THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = BdmBenStopDate -- CASE WHEN /*BdmDedType IN ('MED','DEN','VIS')*/ THEN BdmBenStopDate END
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = 'DTP' 
        ,drvDTP01_DateTimeQualifier_303 = '300' 
        ,drvDTP02_DateTimeFormatQual_303 = 'D8' 
        ,drvDTP03_DateTimePeriod_303 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '10/1/2020') 
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = CASE WHEN BdmDedCode IN ('LIF','LIFS','LIFC','CRI','CRIES','CRICH') THEN 'AMT' END 
        ,drvAMT01_AmountQualifierCode1 = 'B9' 
        ,drvAMT02_MonetaryAmount1 =    CASE WHEN BdmDedCode IN ('LTDH','LIF','CRI') THEN BdmUSGField1 
                                        WHEN BdmDedCode IN ('CRIES') THEN 
                                            CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
                                            ELSE  (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'CRIES')
                                                --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'CRIES')
                                            END
                                        WHEN BdmDedCode IN ('CRICH') THEN 
                                            CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
                                            ELSE (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'CRICH')
                                                --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'CRICH')
                                            END
                                        WHEN BdmDedCode IN ('LIFS') THEN 
                                            CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
                                            ELSE  (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'LIFS')
                                                --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'LIFS')
                                            END
                                        WHEN BdmDedCode IN ('LIFC') THEN 
                                            CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
                                            ELSE  (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'LIFC')
                                                --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'LIFC')
                                            END
                                        WHEN BdmDedCode IN ('SHO') THEN FORMAT(EecWeeklyPayRate*.6, '#0.00')
                                        WHEN BdmDedCode IN ('LTD') THEN FORMAT((EecWeeklyPayRate*2)*.6, '#0.00')
                                    END
        --CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT01_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT02_MonetaryAmount2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        --=====================
        -- Loop 2700 RECORDS
        --=====================
        -- If drvLS01_LoopIDCode is Populated, then send LS Segment
        ,drvLS01_LoopIDCode = '' 
        -- If drvLX01_AssignedNumber is Populated, then send LX Segment
        ,drvLX01_AssignedNumber = ''
        --=====================
        -- Loop 2750 RECORDS
        --=====================
        -- If drvN101_EntityIDCodeSponsor is Populated, then send N1 Segment
        ,drvN101_EntityIDCodeSponsor = ''
        ,drvN102_Name = ''
        -- If drvREF01_RefNumberQual is Populated, then send REF Segment
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberDesc = CASE BdmDedType
                                       WHEN 'MED' THEN ''
                                       WHEN 'DEN' THEN ''
                                       WHEN 'VIS' THEN ''
                                  END
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode = ''
        ---------------------------------
        ,drvEEID = xEEID
        ,drvCOID = xCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN = EepSSN
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
                      + ' ' + BdmDedCode + ' 1'
   --INTO dbo.U_ESUNLNC83C_DrvTbl_2300
    FROM dbo.U_ESUNLNC83C_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
        Where eeceetype <> 'TES'


        Union 

        SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = 'HD'             
        ,drvHD01_MaintTypeCode = CASE WHEN EecEmplStatus = 'T' THEN '024' ELSE '030' END --Audit or Compare
        ,drvHD02_MaintReasonCode = ''
        ,drvHD03_InsuranceLineCode =    CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE --WHEN BdmDedCode IN ('LTDH','LTD') THEN 'LTD'
             --                                       WHEN BdmDedCode IN ('LIF') THEN 'AF'
             --                                       WHEN BdmDedCode IN ('SHO') THEN 'STD'
             --                                       WHEN BdmDedCode IN ('ACC','CANP1','CRI') THEN 'ZZZ'
             --                                       WHEN BdmDedCode IN ('VIS') THEN 'VIS'
                                                    --WHEN BdmDedCode = 'LIFE' THEN 'AC'
                                                    WHEN BdmDedCode = 'LIFE' THEN 'ADD'
                                                END
                                            --WHEN BdmRecType = 'DEP' AND ConRelationship IN ('SPS','DP')THEN
                                            --    CASE WHEN BdmDedCode IN ('LIFS') THEN 'AF'
                                            --        WHEN BdmDedCode IN ('ACC','CANP1','CRIES') THEN 'ZZZ'
                                            --        WHEN BdmDedCode IN ('VIS') THEN 'VIS'
                                            --    END                                            
                                            --WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DIS','DPC','STC')THEN
                                            --    CASE WHEN BdmDedCode IN ('LIFC') THEN 'AF'
                                            --        WHEN BdmDedCode IN ('ACC','CANP1','CRICH') THEN 'ZZZ'
                                            --        WHEN BdmDedCode IN ('VIS') THEN 'VIS'
                                            --    END    
                                        END
        ,drvHD04_PlanCoverageDesc =    CASE WHEN BdmRecType = 'EMP' THEN
                                            CASE WHEN BdmDedCode IN ('LIFE') THEN 'N'
                                                --WHEN BdmDedCode IN ('LIF') THEN 'V'
                                                --WHEN BdmDedCode IN ('SHO') THEN 'V/STD'
                                                --WHEN BdmDedCode IN ('ACC') THEN 'V/ACC'
                                                --WHEN BdmDedCode IN ('CANP1') THEN 'V/CAN'
                                                --WHEN BdmDedCode IN ('CRI','CRIES','CRICH') THEN 'V/CIB'
                                                --WHEN BdmDedCode IN ('VIS') THEN 'V/EYE'
                                            END
                                        --WHEN BdmRecType = 'DEP' AND ConRelationship IN ('SPS','DP') THEN
                                        --    CASE WHEN BdmDedCode IN ('LIFS') THEN 'V'
                                        --        WHEN BdmDedCode IN ('ACC') THEN 'V/ACC'
                                        --        WHEN BdmDedCode IN ('CANP1') THEN 'V/CAN'
                                        --        WHEN BdmDedCode IN ('CRI','CRIES','CRICH') THEN 'V/CIB'
                                        --        WHEN BdmDedCode IN ('VIS') THEN 'V/EYE'
                                        --    END
                                        --WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DIS','DPC','STC') THEN
                                        --    CASE WHEN BdmDedCode IN ('LIFC') THEN 'V'
                                        --        WHEN BdmDedCode IN ('ACC') THEN 'V/ACC'
                                        --        WHEN BdmDedCode IN ('CANP1') THEN 'V/CAN'
                                        --        WHEN BdmDedCode IN ('CRI','CRIES','CRICH') THEN 'V/CIB'
                                        --        WHEN BdmDedCode IN ('VIS') THEN 'V/EYE'
                                        --    END
                                    END
        ,drvHD05_CoverageLevelCode = CASE              
                                                --WHEN BdmDedCode IN ('ACC','CANP1','VIS') THEN 
                                          --  CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                          --      WHEN BdmBenOption IN ('EES','EEDP') THEN 'ESP'
                                          --      WHEN BdmBenOption IN ('EEC','EECH') THEN 'ECH'
                                          --      WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'FAM'
                                          --  END
                                        WHEN BdmRecType = 'EMP' THEN
                                            CASE WHEN BdmDedCode IN ( 'LIFE') THEN 'EMP'
                                               -- WHEN BdmDedCode IN ('LIF') THEN 'EMP'
                                            END
                                        --WHEN BdmRecType = 'DEP' AND ConRelationship IN ('SPS','DP') THEN
                                        --    CASE WHEN BdmDedCode IN ('LIFS','CRIES') THEN 'SPO'
                                        --    END
                                        --WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DIS','DPC','STC') THEN
                                        --    CASE WHEN BdmDedCode IN ('LIFC','CRICH') THEN 'CHD'
                                        --    END
                                        END
                -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = 'DTP' 
        ,drvDTP01_DateTimeQualifier_348 = '348' 
        ,drvDTP02_DateTimeFormatQual_348 = 'D8' 
        ,drvDTP03_DateTimePeriod_348 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '10/1/2020') 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN /*BdmDedType IN ('MED','DEN','VIS') AND*/ BdmBenStopDate IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN /*BdmDedType IN ('MED','DEN','VIS') AND*/ BdmBenStopDate IS NOT NULL THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN /*BdmDedType IN ('MED','DEN','VIS') AND*/ BdmBenStopDate IS NOT NULL THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = BdmBenStopDate -- CASE WHEN /*BdmDedType IN ('MED','DEN','VIS')*/ THEN BdmBenStopDate END
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = 'DTP' 
        ,drvDTP01_DateTimeQualifier_303 = '300' 
        ,drvDTP02_DateTimeFormatQual_303 = 'D8' 
        ,drvDTP03_DateTimePeriod_303 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '10/1/2020') 
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = ''--CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual1 = ''--CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual1 = ''--CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = ''--CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual2 = ''--CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual2 = ''--CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = '' --CASE WHEN BdmDedCode IN ('LIF','LIFS','LIFC','CRI','CRIES','CRICH') THEN 'AMT' END 
        ,drvAMT01_AmountQualifierCode1 = 'B9' 
        ,drvAMT02_MonetaryAmount1 = ''   
                                    --CASE WHEN BdmDedCode IN ('LTDH','LIF','CRI') THEN BdmUSGField1 
         --                               WHEN BdmDedCode IN ('CRIES') THEN 
         --                                   CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
         --                                   ELSE  (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'CRIES')
         --                                       --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'CRIES')
         --                                   END
         --                               WHEN BdmDedCode IN ('CRICH') THEN 
         --                                   CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
         --                                   ELSE (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'CRICH')
         --                                       --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'CRICH')
         --                                   END
         --                               WHEN BdmDedCode IN ('LIFS') THEN 
         --                                   CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
         --                                   ELSE  (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'LIFS')
         --                                       --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'LIFS')
         --                                   END
         --                               WHEN BdmDedCode IN ('LIFC') THEN 
         --                                   CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
         --                                   ELSE  (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'LIFC')
         --                                       --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'LIFC')
         --                                   END
         --                               WHEN BdmDedCode IN ('SHO') THEN FORMAT(EecWeeklyPayRate*.6, '#0.00')
         --                               WHEN BdmDedCode IN ('LTD') THEN FORMAT((EecWeeklyPayRate*2)*.6, '#0.00')
         --                           END
        --CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = ''--CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT01_AmountQualifierCode2 = ''--CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT02_MonetaryAmount2 = ''--CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        --=====================
        -- Loop 2700 RECORDS
        --=====================
        -- If drvLS01_LoopIDCode is Populated, then send LS Segment
        ,drvLS01_LoopIDCode = '' 
        -- If drvLX01_AssignedNumber is Populated, then send LX Segment
        ,drvLX01_AssignedNumber = ''
        --=====================
        -- Loop 2750 RECORDS
        --=====================
        -- If drvN101_EntityIDCodeSponsor is Populated, then send N1 Segment
        ,drvN101_EntityIDCodeSponsor = ''
        ,drvN102_Name = ''
        -- If drvREF01_RefNumberQual is Populated, then send REF Segment
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberDesc = ''
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode = ''
        ---------------------------------
        ,drvEEID = xEEID
        ,drvCOID = xCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN = EepSSN
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
                      + ' ' + BdmDedCode + ' 2'
   --INTO dbo.U_ESUNLNC83C_DrvTbl_2300
    FROM dbo.U_ESUNLNC83C_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_ESUNLNC83C WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
        AND BdmDedCode IN ( 'LIFE')
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID 
        Where eeceetype <> 'TES') a

        Where drvHD03_InsuranceLineCode is not null 
        
;

    INSERT INTO dbo.U_ESUNLNC83C_DrvTbl_2300 
    SELECT DISTINCT
        drvHD00_HealthCoverage 
        ,drvHD01_MaintTypeCode 
        ,drvHD02_MaintReasonCode
        ,drvHD03_InsuranceLineCode = 'ADD'
        ,drvHD04_PlanCoverageDesc =    'V' 
        ,drvHD05_CoverageLevelCode 
                -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348
        ,drvDTP01_DateTimeQualifier_348 
        ,drvDTP02_DateTimeFormatQual_348 
        ,drvDTP03_DateTimePeriod_348 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 
        ,drvDTP01_DateTimeQualifier_349 
        ,drvDTP02_DateTimeFormatQual_349 
        ,drvDTP03_DateTimePeriod_349 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 
        ,drvDTP01_DateTimeQualifier_303 
        ,drvDTP02_DateTimeFormatQual_303 
        ,drvDTP03_DateTimePeriod_303 
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 
        ,drvREF01_RefNumberQual1 
        ,drvREF02_RefNumberQual1 
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 
        ,drvREF01_RefNumberQual2 
        ,drvREF02_RefNumberQual2 
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 
        ,drvAMT01_AmountQualifierCode1 
        ,drvAMT02_MonetaryAmount1 
        --CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 
        ,drvAMT01_AmountQualifierCode2 
        ,drvAMT02_MonetaryAmount2 
        --=====================
        -- Loop 2700 RECORDS
        --=====================
        -- If drvLS01_LoopIDCode is Populated, then send LS Segment
        ,drvLS01_LoopIDCode 
        -- If drvLX01_AssignedNumber is Populated, then send LX Segment
        ,drvLX01_AssignedNumber 
        --=====================
        -- Loop 2750 RECORDS
        --=====================
        -- If drvN101_EntityIDCodeSponsor is Populated, then send N1 Segment
        ,drvN101_EntityIDCodeSponsor 
        ,drvN102_Name 
        -- If drvREF01_RefNumberQual is Populated, then send REF Segment
        ,drvREF01_RefNumberQual 
        ,drvREF02_RefNumberDesc 
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode
        ---------------------------------
        ,drvEEID 
        ,drvCOID 
        ,drvDepRecID 
        ,drvSSN 
        ,drvInitialSort 
        ,drvSubSort = LEFT(drvSubSort, LEN(drvSubSort) - 1) + '2'        
    FROM dbo.U_ESUNLNC83C_DrvTbl_2300 WITH (NOLOCK)
    WHERE drvHD03_InsuranceLineCode = 'AF'
    ;
    
    DELETE dbo.U_ESUNLNC83C_DrvTbl_2300 WHERE drvHD03_InsuranceLineCode IS NULL;



    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_ESUNLNC83C_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_ESUNLNC83C_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_ESUNLNC83C_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('ESUNLNC83C','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'PWC_ESUNLNC83C_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'ESUNLNC83C';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESUNLNC83C_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_ESUNLNC83C_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefF
SELECT * FROM dbo.AscDef
WHERE AdfHeaderSystemID LIKE 'ESUNLNC83C%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202101011'
       ,ExpStartPerControl     = '202101011'
       ,ExpLastEndPerControl   = '202103249'
       ,ExpEndPerControl       = '202103249'
WHERE ExpFormatCode = 'ESUNLNC83C';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESUNLNC83C_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_ESUNLNC83C_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESUNLNC83C' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESUNLNC83C'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESUNLNC83C'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESUNLNC83C', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESUNLNC83C', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESUNLNC83C', 'UseFileName', 'V', 'Y'


-- End ripout