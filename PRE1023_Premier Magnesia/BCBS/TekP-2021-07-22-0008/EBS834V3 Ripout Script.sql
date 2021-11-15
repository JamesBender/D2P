/**********************************************************************************

EBS834V3: BCBS of NC 834 Medical V3

FormatCode:     EBS834V3
Project:        BCBS of NC 834 Medical V3
Client ID:      PRE1023
Date/time:      2021-11-11 10:00:13.790
Ripout version: 7.4
Export Type:    Back Office
Status:         Production
Environment:    EWP
Server:         EW4WUP5DB03
Database:       ULTIPRO_WPPREMM
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBS834V3_SavePath') IS NOT NULL DROP TABLE dbo.U_EBS834V3_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBS834V3'


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
WHERE FormatCode = 'EBS834V3'
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
WHERE ExpFormatCode = 'EBS834V3'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBS834V3')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBS834V3'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBS834V3'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBS834V3'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBS834V3'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBS834V3'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBS834V3'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBS834V3'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBS834V3'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBS834V3'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBS834V3_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBS834V3_Export];
GO
IF OBJECT_ID('dsi_sp_EBS834V3_Copy_Files') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_EBS834V3_Copy_Files];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBS834V3') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBS834V3];
GO
IF OBJECT_ID('U_EBS834V3_IDTbl') IS NOT NULL DROP TABLE [dbo].[U_EBS834V3_IDTbl];
GO
IF OBJECT_ID('U_EBS834V3_File') IS NOT NULL DROP TABLE [dbo].[U_EBS834V3_File];
GO
IF OBJECT_ID('U_EBS834V3_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBS834V3_EEList];
GO
IF OBJECT_ID('U_EBS834V3_DRVTBL_DEDS') IS NOT NULL DROP TABLE [dbo].[U_EBS834V3_DRVTBL_DEDS];
GO
IF OBJECT_ID('U_EBS834V3_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBS834V3_drvTbl];
GO
IF OBJECT_ID('U_EBS834V3_DEDTRANS') IS NOT NULL DROP TABLE [dbo].[U_EBS834V3_DEDTRANS];
GO
IF OBJECT_ID('U_EBS834V3_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBS834V3_DedList];
GO
IF OBJECT_ID('U_EBS834V3_DedCodeList') IS NOT NULL DROP TABLE [dbo].[U_EBS834V3_DedCodeList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','EBS834V3','BCBS of NC 834 Medical V3','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','500','S','N','CL6C1R0000V3','N',NULL,'C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','H','01','1','ISA','ISA  Segment ID',NULL,NULL,'"ISA"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','H','01','2','ISA','01  Interchange Control Heade',NULL,NULL,'"00"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','10','H','01','3','ISA','02  Authorization Information',NULL,NULL,'""','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','2','H','01','4','ISA','03  Security Information Qual',NULL,NULL,'"00"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','10','H','01','5','ISA','04  Security Information',NULL,NULL,'""','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','2','H','01','6','ISA','05  Interchange ID Qual',NULL,NULL,'"drvISA_06"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','CL6C1R0000V3','15','H','01','7','ISA','06  Interchange Sender ID',NULL,NULL,'"drvISA_07"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','CL6C1R0000V3','2','H','01','8','ISA','07  Interchange ID Qual',NULL,NULL,'"drvISA_08"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','CL6C1R0000V3','15','H','01','9','ISA','08  Interchange receiver ID',NULL,NULL,'"drvISA_09"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','CL6C1R0000V3','6','H','01','10','ISA','09  Interchange Date',NULL,NULL,'"GetDate()"','(''UD012''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','CL6C1R0000V3','4','H','01','11','ISA','10  Interchange Time',NULL,NULL,'"GetDate()"','(''UDHMS''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','CL6C1R0000V3','1','H','01','12','ISA','11  Interchange Control Stand',NULL,NULL,'"^"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','CL6C1R0000V3','5','H','01','13','ISA','12  Interchange Control versi',NULL,NULL,'"drvISA_13"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','CL6C1R0000V3','9','H','01','14','ISA','13  Interchange Control Numbe',NULL,NULL,'"drvISA_14"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','CL6C1R0000V3','1','H','01','15','ISA','14  Acknowledgement Requested',NULL,NULL,'"drvISA_15"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','CL6C1R0000V3','1','H','01','16','ISA','15  Usage Indicator',NULL,NULL,'"drvISA_16"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','CL6C1R0000V3','1','H','01','17','ISA','16  Component Element Separat',NULL,NULL,'":"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','H','02','1','GS','GS  Segment ID',NULL,NULL,'"GS"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','H','02','2','GS','01 Functional Group Header',NULL,NULL,'"BE"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','15','H','02','3','GS','02  Application Senders code',NULL,NULL,'"drvGS_03"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','15','H','02','4','GS','03  Application Receivers Co',NULL,NULL,'"drvGS_04"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','8','H','02','5','GS','04  Date',NULL,NULL,'"GetDate()"','(''UD112''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','4','H','02','6','GS','05  Time',NULL,NULL,'"GetDate()"','(''UDHMS''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','CL6C1R0000V3','9','H','02','7','GS','06  Group Control Number',NULL,NULL,'"drvGS_07"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','CL6C1R0000V3','1','H','02','8','GS','07  Responsible Agency Code',NULL,NULL,'"X"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','CL6C1R0000V3','12','H','02','9','GS','08  Version  Release Indust',NULL,NULL,'"drvGS_09"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','H','03','1','ST','ST  Segment ID',NULL,NULL,'"ST"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','H','03','2','ST','01  Transaction Set Identifie',NULL,NULL,'"834"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','10','H','03','3','ST','02  Transaction Set Control n',NULL,NULL,'"drvST_03"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','30','H','03','4','ST','02  Transaction Set Control n',NULL,NULL,'"drvST_04"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','H','04','1','BGN','BGN Segment ID',NULL,NULL,'"BGN"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','H','04','2','BGN','01  Transaction Set Purpose C',NULL,NULL,'"00"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','30','H','04','3','BGN','02  Reference Number',NULL,NULL,'"drvBGN_03"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','H','04','4','BGN','03  Date',NULL,NULL,'"GetDate()"','(''UD112''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','4','H','04','5','BGN','04  Time',NULL,NULL,'"GetDate()"','(''UDHMS''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','2','H','04','6','BGN','05  Time Zone',NULL,NULL,'"ET"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','CL6C1R0000V3','1','H','04','7','BGN','06  Blank',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','CL6C1R0000V3','1','H','04','8','BGN','07  Blank',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','CL6C1R0000V3','2','H','04','9','BGN','08  Action Code',NULL,NULL,'"drvBGN_09"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','H','05','1','REF','REF  Segment ID',NULL,NULL,'"REF"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','H','05','2','REF','01  Reference Identification',NULL,NULL,'"drvREF_02"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','8','H','05','3','REF','02  Reference Identification',NULL,NULL,'"drvREF_03"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','H','06','1','DTP','DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','H','06','2','DTP','01  DateTime Qual',NULL,NULL,'"007"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','H','06','3','DTP','02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','H','06','4','DTP','03  Date',NULL,NULL,'"drvDTP_04"','(''UD112''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','H','07','1','QTY','QTY Segment ID',NULL,NULL,'"QTY"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','H','07','2','QTY','01 Quantity Qualifier',NULL,NULL,'"TO"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','30','H','07','3','QTY','02 Quantity',NULL,NULL,'"drvQTY_01"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','2','H','07','4','QTY','03  Composite Unit of Measure',NULL,NULL,'""','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','10','H','07','5','QTY','04  Free Form Information',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','4','H','08','1','QTY','N1 Segment ID','1000A',NULL,'"N1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','H','08','2','QTY','01 Entity Identifier Code','1000A',NULL,'"P5"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','30','H','08','3','QTY','02 Name','1000A',NULL,'"drvN1A_03"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','2','H','08','4','QTY','03  Identifiecation Code Qualifier','1000A',NULL,'"FI"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','10','H','08','5','QTY','04  Entity Relationship Code','1000B',NULL,'"drvN1A_05"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','H','09','1','N1','N1  Segment ID','1000B',NULL,'"N1"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','H','09','2','N1','01  Entity Identifier Code','1000B',NULL,'"IN"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','50','H','09','3','N1','02  Name','1000B',NULL,'"drvN1B_03"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','2','H','09','4','N1','03  Identification Code Qual','1000B',NULL,'"FI"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','10','H','09','5','N1','04  Identification Code','1000B',NULL,'"drvN1B_05"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','H','10','1','N1','N1  Segment ID','1000B',NULL,'"N1"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','H','10','2','N1','01  Entity Identifier Code','1000A',NULL,'"TV"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','50','H','10','3','N1','02  Name','1000B',NULL,'"drvN1C_03"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','2','H','10','4','N1','03  Identifiecation Code Qualifier','1000A',NULL,'"FI"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','50','H','10','5','N1','04  Identification Code','1000B',NULL,'"drvN1C_05"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','09','1',NULL,'INS  Segment ID',NULL,NULL,'"INS"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','1','D','09','2',NULL,'01  YesNo Condition',NULL,NULL,'"drv0902"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','09','3',NULL,'02  Individual Relationship C',NULL,NULL,'"drv0903"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','3','D','09','4',NULL,'03  Maintenance Type Code',NULL,NULL,'"030"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','2','D','09','5',NULL,'04  Maintenance Reason Code',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','1','D','09','6',NULL,'05  Benefit Status Code',NULL,NULL,'"A"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','CL6C1R0000V3','1','D','09','7',NULL,'06  Medicare Plan Code',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','CL6C1R0000V3','1','D','09','8',NULL,'07  COBRA Qualifying Event',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','CL6C1R0000V3','2','D','09','9',NULL,'08  Employment Status Code',NULL,NULL,'"drv0909"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','CL6C1R0000V3','2','D','09','10',NULL,'09  Student Status',NULL,NULL,'"drv0910"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','CL6C1R0000V3','1','D','09','11',NULL,'10  Handicap Indicator',NULL,NULL,'"drv0911"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','CL6C1R0000V3','2','D','09','12',NULL,'1112  Date IndDeath Date',NULL,NULL,'"drv0912"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','CL6C1R0000V3','8','D','09','13',NULL,'1112  Date IndDeath Date',NULL,NULL,'"drv0913"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','CL6C1R0000V3','1','D','09','14',NULL,'BLANK',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','CL6C1R0000V3','1','D','09','15',NULL,'BLANK',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','CL6C1R0000V3','1','D','09','16',NULL,'BLANK',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','CL6C1R0000V3','1','D','09','17',NULL,'BLANK',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','CL6C1R0000V3','10','D','09','18',NULL,'DEPENDENT SEQUENCE',NULL,NULL,'"drv0918"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','10','1',NULL,'REF  Segment ID',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','10','2',NULL,'01  Subscriber Number',NULL,NULL,'"0F"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','9','D','10','3',NULL,'02  Reference Number',NULL,NULL,'"drv1003"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','11','1',NULL,'REF  Segment ID',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','11','2',NULL,'01  Member Policy Number',NULL,NULL,'"1L"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','12','D','11','3',NULL,'02  Reference Identification',NULL,NULL,'"drv1103"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','12','1',NULL,'REF  Segment ID',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','12','2',NULL,'01  Subscriber Number',NULL,NULL,'"17"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','9','D','12','3',NULL,'02  Reference Number',NULL,NULL,'"drv1203"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','13','1',NULL,'REF  Segment ID',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','13','2',NULL,'01  Subscriber Number',NULL,NULL,'"DX"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','9','D','13','3',NULL,'02  Reference Number',NULL,NULL,'"drv1303"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','14','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','14','2',NULL,'01  DateTime Qual',NULL,NULL,'"336"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','14','3',NULL,'02  DateTime Format',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','14','4',NULL,'03  DateTime Period',NULL,NULL,'"drv1404"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','15','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','15','2',NULL,'01  DateTime Qual',NULL,NULL,'"drv1502"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','15','3',NULL,'02  DateTime Format',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','15','4',NULL,'03  DateTime Period',NULL,NULL,'"drv1504"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','16','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','16','2',NULL,'01  DateTime Qual',NULL,NULL,'"drv1602"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','16','3',NULL,'02  DateTime Format',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','16','4',NULL,'03  DateTime Period',NULL,NULL,'"drv1604"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','17','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','17','2',NULL,'01  DateTime Qual',NULL,NULL,'"drv1702"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','17','3',NULL,'02  DateTime Format',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','17','4',NULL,'03  DateTime Period',NULL,NULL,'"drv1704"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','18','1',NULL,'NM1  Segment ID',NULL,NULL,'"NM1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','18','2',NULL,'01  Entity Identifier Code',NULL,NULL,'"IL"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','1','D','18','3',NULL,'02  Entity Type Qual',NULL,NULL,'"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','25','D','18','4',NULL,'03  Name Last',NULL,NULL,'"drv1804"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','25','D','18','5',NULL,'04  Name First',NULL,NULL,'"drv1805"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','1','D','18','6',NULL,'05  Name Middle',NULL,NULL,'"drv1806"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','CL6C1R0000V3','10','D','18','7',NULL,'06  Name Prefix',NULL,NULL,'"drv1807"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','CL6C1R0000V3','10','D','18','8',NULL,'07  Name Suffix',NULL,NULL,'"drv1808"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','CL6C1R0000V3','2','D','18','9',NULL,'08  Identification Code',NULL,NULL,'"drv1809"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','CL6C1R0000V3','9','D','18','10',NULL,'09  Identification Code Qual',NULL,NULL,'"drv1810"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','19','1',NULL,'PER  Segment ID',NULL,NULL,'"PER"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','19','2',NULL,'01  Contact Function Code',NULL,NULL,'"IP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','1','D','19','3',NULL,'02  Name',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','2','D','19','4',NULL,'03  Comm Num Qual',NULL,NULL,'"HP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','10','D','19','5',NULL,'04  Comm Num',NULL,NULL,'"drv1905"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','2','D','19','6',NULL,'05  Comm Num Qual',NULL,NULL,'"WP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','CL6C1R0000V3','10','D','19','7',NULL,'06  Comm Num',NULL,NULL,'"drv1906"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','CL6C1R0000V3','2','D','19','8',NULL,'07  Comm Num Qual',NULL,NULL,'"EM"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','CL6C1R0000V3','50','D','19','9',NULL,'08  Comm Num',NULL,NULL,'"drv1907"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','D','20','1',NULL,'N3  Segment ID',NULL,NULL,'"N3"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','30','D','20','2',NULL,'01  AddressLine1',NULL,NULL,'"drv2002"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','30','D','20','3',NULL,'02  AddressLine2',NULL,NULL,'"drv2003"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','D','21','1',NULL,'N4  Segment ID',NULL,NULL,'"N4"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','20','D','21','2',NULL,'01  City',NULL,NULL,'"drv2102"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','21','3',NULL,'02  State',NULL,NULL,'"drv2103"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','10','D','21','4',NULL,'03  Postal Code',NULL,NULL,'"drv2104"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','3','D','21','5',NULL,'04  Country Code',NULL,NULL,'"drv2105"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','22','1',NULL,'DMG  Segment ID',NULL,NULL,'"DMG"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','22','2',NULL,'01  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','8','D','22','3',NULL,'02  DateTime Period',NULL,NULL,'"drv2203"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','1','D','22','4',NULL,'03  Gender Code',NULL,NULL,'"drv2204"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','1','D','22','5',NULL,'04  Marital Status',NULL,NULL,'"drv2205"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','1','D','22','6',NULL,'05  Ethnic Code',NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','23','1',NULL,'NM1  Segment ID',NULL,NULL,'"NM1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','23','2',NULL,'01  Entity Identifier Code',NULL,NULL,'"31"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','1','D','23','3',NULL,'02  Entity Type Qual',NULL,NULL,'"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','D','24','1',NULL,'N3  Segment ID',NULL,NULL,'"N3"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','30','D','24','2',NULL,'01  AddressLine1',NULL,NULL,'"drv2402"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','30','D','24','3',NULL,'02  AddressLine2',NULL,NULL,'"drv2403"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','D','25','1',NULL,'N4  Segment ID',NULL,NULL,'"N4"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','20','D','25','2',NULL,'01  City',NULL,NULL,'"drv2502"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','25','3',NULL,'02  State',NULL,NULL,'"drv2503"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','10','D','25','4',NULL,'03  Postal Code',NULL,NULL,'"drv2504"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','3','D','25','5',NULL,'04  Country Code',NULL,NULL,'"US"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','D','26','1',NULL,'HD  Segment ID',NULL,NULL,'"HD"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','26','2',NULL,'01  Maintenance Type Code',NULL,NULL,'"030"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','1','D','26','3',NULL,'02  Maintenance Reason Code',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','3','D','26','4',NULL,'03  Insurance Line Code',NULL,NULL,'"drv2604"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','50','D','26','5',NULL,'04  Plan Coverage Description',NULL,NULL,'"drv2605"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','3','D','26','6',NULL,'05  Coverage Level Code',NULL,NULL,'"drv2606"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','27','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','27','2',NULL,'01  DateTime Qual',NULL,NULL,'"348"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','27','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','27','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2704"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','28','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','28','2',NULL,'01  DateTime Qual',NULL,NULL,'"349"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','28','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','28','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2804"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','29','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','29','2',NULL,'01  DateTime Qual',NULL,NULL,'"543"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','29','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','13','D','29','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2904"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','30','1',NULL,'REF  Segment ID',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','30','2',NULL,'01  Reference Identification',NULL,NULL,'"1L"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','15','D','30','3',NULL,'02  Reference Identification',NULL,NULL,'"DRV3003"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','D','31','1',NULL,'HD  Segment ID',NULL,NULL,'"HD"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','31','2',NULL,'01  Maintenance Type Code',NULL,NULL,'"030"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','1','D','31','3',NULL,'02  Maintenance Reason Code',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','3','D','31','4',NULL,'03  Insurance Line Code',NULL,NULL,'"drv2604"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','1','D','31','5',NULL,'04  Plan Coverage Description',NULL,NULL,'"drv2605"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','3','D','31','6',NULL,'05  Coverage Level Code',NULL,NULL,'"drv2606"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','32','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','32','2',NULL,'01  DateTime Qual',NULL,NULL,'"348"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','32','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','32','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2704"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','33','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','33','2',NULL,'01  DateTime Qual',NULL,NULL,'"349"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','33','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','33','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2804"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','34','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','34','2',NULL,'01  DateTime Qual',NULL,NULL,'"543"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','34','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','13','D','34','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2904"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','35','1',NULL,'REF  Segment ID',NULL,NULL,'"REF"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','35','2',NULL,'01  Reference Identification',NULL,NULL,'"1L"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','15','D','35','3',NULL,'02  Reference Identification',NULL,NULL,'"DRV3003"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','D','36','1',NULL,'HD  Segment ID',NULL,NULL,'"HD"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','36','2',NULL,'01  Maintenance Type Code',NULL,NULL,'"030"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','1','D','36','3',NULL,'02  Maintenance Reason Code',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','3','D','36','4',NULL,'03  Insurance Line Code',NULL,NULL,'"drv2604"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','5','D','36','5',NULL,'04  Plan Coverage Description',NULL,NULL,'"drv2605"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','3','D','36','6',NULL,'05  Coverage Level Code',NULL,NULL,'"drv2606"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','37','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','37','2',NULL,'01  DateTime Qual',NULL,NULL,'"348"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','37','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','37','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2704"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','38','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','38','2',NULL,'01  DateTime Qual',NULL,NULL,'"349"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','38','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','38','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2804"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','39','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','39','2',NULL,'01  DateTime Qual',NULL,NULL,'"543"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','39','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','13','D','39','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2904"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','D','46','1',NULL,'HD  Segment ID',NULL,NULL,'"HD"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','46','2',NULL,'01  Maintenance Type Code',NULL,NULL,'"030"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','1','D','46','3',NULL,'02  Maintenance Reason Code',NULL,NULL,'""','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','3','D','46','4',NULL,'03  Insurance Line Code',NULL,NULL,'"drv2604"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','CL6C1R0000V3','1','D','46','5',NULL,'04  Plan Coverage Description',NULL,NULL,'"drv2605"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','CL6C1R0000V3','3','D','46','6',NULL,'05  Coverage Level Code',NULL,NULL,'"drv2606"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','47','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','47','2',NULL,'01  DateTime Qual',NULL,NULL,'"348"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','47','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','47','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2704"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','48','1',NULL,'DTP  Segment ID',NULL,NULL,'"DTP"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','48','2',NULL,'01  DateTime Qual',NULL,NULL,'"349"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','48','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','48','4',NULL,'03  DateTime Period',NULL,NULL,'"drv2804"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','49','1',NULL,'REF  Segment ID',NULL,NULL,'"REF"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','49','2',NULL,'01  DateTime Qual',NULL,NULL,'"303"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','49','3',NULL,'02  DateTime Format Qual',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','49','4',NULL,'03  DateTime Period',NULL,NULL,'"drv4904"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','50','1',NULL,'REF  Segment ID',NULL,NULL,'"REF"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','50','2',NULL,'01  Reference Identification',NULL,NULL,'"1L"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','15','D','50','3',NULL,'02  Reference Identification',NULL,NULL,'"drv5003"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','58','1',NULL,'LS*2700',NULL,NULL,'"LS"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','4','D','58','5',NULL,'LS*2700',NULL,NULL,'"2700"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','59','1',NULL,'LX*1',NULL,NULL,'"LX"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','4','D','59','5',NULL,'LX*1',NULL,NULL,'"0001"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','60','1',NULL,'N1  Segment ID',NULL,NULL,'"N1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','2','D','60','4',NULL,'N1  Entity Identifier Code',NULL,NULL,'"75"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','8','D','60','8',NULL,'N1  Code Identifiying New Hire Reporting',NULL,NULL,'"drv6003"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','61','1',NULL,'N1  Segment ID',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','61','2',NULL,'N1  Client Reporting Category',NULL,NULL,'"17"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','4','D','61','3',NULL,'N1  New Hire Code',NULL,NULL,'"drv6103"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','62','1',NULL,'DTP*2700',NULL,NULL,'"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','3','D','62','4',NULL,'Date/Time Qualifier',NULL,NULL,'"007"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','2','D','62','7',NULL,'Date Time Period Format Qualifier',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','CL6C1R0000V3','8','D','62','9',NULL,'Date Time Period',NULL,NULL,'"drv6204"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','D','63','1',NULL,'LE*2700',NULL,NULL,'"LE"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','4','D','63','5',NULL,'LE*2700',NULL,NULL,'"2700"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','T','97','1',NULL,'SE  Segment ID',NULL,NULL,'"SE"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','6','T','97','2',NULL,'01  Number of Included Segmen',NULL,NULL,'"Count(1)-1"','(''UNT0''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','10','T','97','3',NULL,'02  Transaction Set Control n',NULL,NULL,'"0001"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','2','T','98','1',NULL,'GE  Segment ID',NULL,NULL,'"GE"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','6','T','98','2',NULL,'01  Functional Group Header',NULL,NULL,'"1"','(''UNT0''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','9','T','98','3',NULL,'02  Group Control number',NULL,NULL,'"drvGE_03"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','CL6C1R0000V3','3','T','99','1',NULL,'IEA  Segment ID',NULL,NULL,'"IEA"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','CL6C1R0000V3','1','T','99','2',NULL,'01  Interchange Control Trail',NULL,NULL,'"1"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','CL6C1R0000V3','9','T','99','3',NULL,'02  Transaction Set Control n',NULL,NULL,'"drvIEA_03"','(''UA''=''F'')');

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File name auto generated',NULL,NULL,NULL,'EL161',NULL,NULL,NULL,'Open Enrollment Active','202005039','EMPEXPORT','OEACTIVE','Oct 13 2020 12:00AM','EBS834V3',NULL,NULL,NULL,'202005039','May  3 2020 12:00AM','Dec 30 1899 12:00AM','202005021','16916','','','202005021',dbo.fn_GetTimedKey(),NULL,'us3cSlPRE1023',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File name auto generated',NULL,NULL,NULL,'EL161',NULL,NULL,NULL,'Open Enrollment Passive','202005039','EMPEXPORT','OEPASSIVE','Oct 13 2020 12:00AM','EBS834V3',NULL,NULL,NULL,'202005039','May  3 2020 12:00AM','Dec 30 1899 12:00AM','202005021','17781','','','202005021',dbo.fn_GetTimedKey(),NULL,'us3cSlPRE1023',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File name auto generated',NULL,NULL,NULL,'EL161',NULL,NULL,NULL,'OE Active Enrollment Test','201902289','EMPEXPORT','OETACTIVE','Oct 13 2020 12:00AM','EBS834V3',NULL,NULL,NULL,'201902289','Feb 28 2019 12:00AM','Dec 30 1899 12:00AM','201902211','16954','','','201902211',dbo.fn_GetTimedKey(),NULL,'us3cSlPRE1023',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File name auto generated',NULL,NULL,NULL,'EL161',NULL,NULL,NULL,'OE Passive Enrollment Test','201902289','EMPEXPORT','OETPASSIVE','Oct 13 2020 12:00AM','EBS834V3',NULL,NULL,NULL,'201902289','Feb 28 2019 12:00AM','Dec 30 1899 12:00AM','201902211','16321','','','201902211',dbo.fn_GetTimedKey(),NULL,'us3cSlPRE1023',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File name auto generated',NULL,'','',',EL161',NULL,NULL,NULL,'On Demand Export','202012029','EMPEXPORT','ON_DEMAND','Oct 13 2020 12:00AM','EBS834V3',NULL,NULL,NULL,'202012029','Sep 27 2019 12:00AM','Dec 30 1899 12:00AM','202011231','34722','','','202011231',dbo.fn_GetTimedKey(),NULL,'us3cSlPRE1023',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File name auto generated',NULL,'Null','N','EL161',NULL,NULL,NULL,'Scheduled Export','202010089','EMPEXPORT','SCHEDULED','Oct 13 2020 12:00AM','EBS834V3',NULL,NULL,NULL,'202109239','Oct  8 2020 12:00AM','Dec 30 1899 12:00AM','202109161','33337','','','202010011',dbo.fn_GetTimedKey(),NULL,'us3cSlPRE1023',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW4\EW45\Downloads\V10\Exports\PREMM\EmployeeHistoryExport\PREMM_EBS834V3_20211029a.txt',NULL,'','','EL161',NULL,NULL,NULL,'Test Export','202111041','EMPEXPORT','TEST','Nov 11 2021  9:43AM','EBS834V3',NULL,NULL,NULL,'202111041','Nov  4 2021 12:00AM','Dec 30 1899 12:00AM','202110291','6061','','','202110291',dbo.fn_GetTimedKey(),NULL,'us3cPePRE1023',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('Reset Export',NULL,NULL,NULL,'EL161',NULL,NULL,NULL,'Reset Export','201902289','EMPEXPORT','ZAP','Oct 13 2020 12:00AM','EBS834V3',NULL,NULL,NULL,'201902289','Feb 28 2019 12:00AM','Dec 30 1899 12:00AM','201902211','-99','','','201902211',dbo.fn_GetTimedKey(),NULL,'us3cSlPRE1023',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','DateDiff','V','60');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','ExportPath_I','V','\\us.saas\ew0\DATA_EXCHANGE\PRE1023\exports\test\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','ExportPath_J','V','\\us.saas\ew0\DATA_EXCHANGE\PRE1023\exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','InitialSort','C','drvEEID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','IS834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','SubSort','C','drvMemberSSN + IsNull(drvconSysID,'''')');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','SubSort2','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBS834V3','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','H01','dbo.U_EBS834V3_IDTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','H02','dbo.U_EBS834V3_IDTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','H03','dbo.U_EBS834V3_IDTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','H04','dbo.U_EBS834V3_IDTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','H05','dbo.U_EBS834V3_IDTbl','ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','H06','dbo.U_EBS834V3_IDTbl','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','H07','dbo.U_EBS834V3_IDTbl','ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','H08','dbo.U_EBS834V3_IDTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','H09','dbo.U_EBS834V3_IDTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','H10','dbo.U_EBS834V3_IDTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D09','dbo.U_EBS834V3_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D10','dbo.U_EBS834V3_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D11','dbo.U_EBS834V3_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D12','dbo.U_EBS834V3_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D13','dbo.U_EBS834V3_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D14','dbo.U_EBS834V3_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D15','dbo.U_EBS834V3_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D16','Ignore','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D17','Ignore','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D18','dbo.U_EBS834V3_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D19','dbo.U_EBS834V3_drvTbl','(NullIf(drv1905,'''') is not null)');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D20','dbo.U_EBS834V3_drvTbl','(drv2002 != ''N'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D21','dbo.U_EBS834V3_drvTbl','(drv2002 != ''N'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D22','dbo.U_EBS834V3_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D23','Ignore','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D24','Ignore','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D25','dbo.U_EBS834V3_drvTbl','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D26','dbo.U_EBS834V3_drvTbl_Deds','(drv2604 = ''HLT'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D27','dbo.U_EBS834V3_drvTbl_Deds','(drv2604 = ''HLT'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D28','dbo.U_EBS834V3_drvTbl_Deds','(drv2804 is not null and drv2604 = ''HLT'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D29','Ignore','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D30','U_EBS834V3_drvTbl_Deds','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D31','dbo.U_EBS834V3_drvTbl_Deds','(drv2604 = ''PDG'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D32','dbo.U_EBS834V3_drvTbl_Deds','(drv2604 = ''PDG'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D33','dbo.U_EBS834V3_drvTbl_Deds','(drv2804 is not null and drv2604 = ''PDG'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D34','Ignore','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D35','Ignore','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D36','dbo.U_EBS834V3_drvTbl_Deds','(drv2604 = ''DEN'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D37','dbo.U_EBS834V3_drvTbl_Deds','(drv2604 = ''DEN'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D38','dbo.U_EBS834V3_drvTbl_Deds','(drv2804 is not null and drv2604 = ''DEN'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D39','Ignore','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D46','dbo.U_EBS834V3_drvTbl_Deds','(drv2604 = ''VIS'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D47','dbo.U_EBS834V3_drvTbl_Deds','(drv2604 = ''VIS'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D48','dbo.U_EBS834V3_drvTbl_Deds','(drv2804 is not null and drv2604 = ''VIS'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D49','dbo.U_EBS834V3_drvTbl_Deds','(drv4904 is not null and drv2604 = ''VIS'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D50','dbo.U_EBS834V3_drvTbl','ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D58','dbo.U_EBS834V3_drvTbl','(NULLIF(drv6003,'''') is not null)');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D59','dbo.U_EBS834V3_drvTbl','(NULLIF(drv6003,'''') is not null)');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D60','dbo.U_EBS834V3_drvTbl','(NULLIF(drv6003,'''') is not null)');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D61','dbo.U_EBS834V3_drvTbl','(NULLIF(drv6003,'''') is not null)');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D62','dbo.U_EBS834V3_drvTbl','(NULLIF(drv6003,'''') is not null)');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','D63','dbo.U_EBS834V3_drvTbl','(NULLIF(drv6003,'''') is not null)');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','T97','dbo.U_EBS834V3_File',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','T98','dbo.U_EBS834V3_IDTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBS834V3','T99','dbo.U_EBS834V3_IDTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EBS834V3_DedCodeList
-----------

IF OBJECT_ID('U_EBS834V3_DedCodeList') IS NULL
CREATE TABLE [dbo].[U_EBS834V3_DedCodeList] (
    [DedCode] varchar(5) NULL
);

-----------
-- Create table U_EBS834V3_DedList
-----------

IF OBJECT_ID('U_EBS834V3_DedList') IS NULL
CREATE TABLE [dbo].[U_EBS834V3_DedList] (
    [dl_COID] char(5) NOT NULL,
    [dl_CoCode] char(5) NULL,
    [dl_DedCode] varchar(5) NULL,
    [dl_834Type] varchar(3) NOT NULL,
    [dl_834Plan] varchar(8) NULL,
    [dl_GroupPolicy] varchar(25) NULL,
    [dl_SubGroup] varchar(4) NOT NULL,
    [dl_SubGroupOutOfNetwork] varchar(1) NOT NULL,
    [dl_BillGroup] varchar(2) NOT NULL
);

-----------
-- Create table U_EBS834V3_DEDTRANS
-----------

IF OBJECT_ID('U_EBS834V3_DEDTRANS') IS NULL
CREATE TABLE [dbo].[U_EBS834V3_DEDTRANS] (
    [dedCode] char(5) NOT NULL,
    [GroupNumber] varchar(25) NULL
);

-----------
-- Create table U_EBS834V3_drvTbl
-----------

IF OBJECT_ID('U_EBS834V3_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBS834V3_drvTbl] (
    [drvCOID] char(5) NOT NULL,
    [drvEEID] char(12) NOT NULL,
    [drvMemberSSN] char(11) NULL,
    [drvCoCode] char(5) NULL,
    [drvConSysid] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvRelatonship] varchar(20) NULL,
    [drv0902] varchar(1) NOT NULL,
    [drv0903] varchar(2) NOT NULL,
    [drv0906] varchar(1) NOT NULL,
    [drv0909] varchar(2) NOT NULL,
    [drv0910] char(1) NULL,
    [drv0911] varchar(1) NULL,
    [drv0912] varchar(2) NOT NULL,
    [drv0913] datetime NULL,
    [drv0918] varchar(10) NULL,
    [drv1003] char(11) NULL,
    [drv1103] varchar(8) NOT NULL,
    [drv1203] varchar(4) NULL,
    [drv1303] varchar(4) NOT NULL,
    [drv1404] datetime NULL,
    [drv1502] varchar(3) NOT NULL,
    [drv1504] datetime NULL,
    [drv1804] varchar(6000) NULL,
    [drv1805] varchar(6000) NULL,
    [drv1806] varchar(6000) NULL,
    [drv1807] varchar(6000) NULL,
    [drv1808] varchar(6000) NULL,
    [drv1809] varchar(2) NULL,
    [drv1810] char(11) NULL,
    [drv1905] varchar(6000) NULL,
    [drv1906] varchar(6000) NULL,
    [drv1907] varchar(50) NULL,
    [drv2002] varchar(6000) NULL,
    [drv2003] varchar(6000) NULL,
    [drv2102] varchar(6000) NULL,
    [drv2103] varchar(255) NOT NULL,
    [drv2104] varchar(6000) NULL,
    [drv2105] char(3) NULL,
    [drv2203] datetime NULL,
    [drv2204] char(1) NOT NULL,
    [drv2205] varchar(1) NOT NULL,
    [drv5003] varchar(1) NOT NULL,
    [drv6003] varchar(10) NULL,
    [drv6103] varchar(10) NULL,
    [drv6204] datetime NULL
);

-----------
-- Create table U_EBS834V3_DRVTBL_DEDS
-----------

IF OBJECT_ID('U_EBS834V3_DRVTBL_DEDS') IS NULL
CREATE TABLE [dbo].[U_EBS834V3_DRVTBL_DEDS] (
    [drvCOID] char(5) NULL,
    [drvEEID] char(12) NULL,
    [drvMemberSSN] char(11) NULL,
    [drvCoCode] char(5) NULL,
    [drvROW_NUM] bigint NULL,
    [drvconSysID] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvDedCode] char(5) NOT NULL,
    [drvBenStatus] char(1) NULL,
    [drvLocation] char(6) NULL,
    [drvBenOption] char(6) NULL,
    [ZipCode] varchar(5) NULL,
    [drv1103] varchar(8) NOT NULL,
    [drv1203] varchar(4) NULL,
    [drv1303] varchar(4) NOT NULL,
    [drv1502] varchar(3) NOT NULL,
    [drv1504] datetime NULL,
    [drv2604] varchar(3) NOT NULL,
    [drv2605] varchar(8) NULL,
    [drv2606] varchar(6) NULL,
    [drv2704] datetime NULL,
    [drv2804] datetime NULL,
    [drv3003] varchar(1) NOT NULL,
    [drv4904] datetime NULL,
    [drv5003] varchar(25) NULL
);

-----------
-- Create table U_EBS834V3_EEList
-----------

IF OBJECT_ID('U_EBS834V3_EEList') IS NULL
CREATE TABLE [dbo].[U_EBS834V3_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBS834V3_File
-----------

IF OBJECT_ID('U_EBS834V3_File') IS NULL
CREATE TABLE [dbo].[U_EBS834V3_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(500) NULL
);

-----------
-- Create table U_EBS834V3_IDTbl
-----------

IF OBJECT_ID('U_EBS834V3_IDTbl') IS NULL
CREATE TABLE [dbo].[U_EBS834V3_IDTbl] (
    [drvISA_06] varchar(2) NOT NULL,
    [drvISA_07] varchar(100) NULL,
    [drvISA_08] varchar(2) NOT NULL,
    [drvISA_09] varchar(20) NULL,
    [drvISA_12] varchar(1) NOT NULL,
    [drvISA_13] varchar(5) NOT NULL,
    [drvISA_14] varchar(9) NOT NULL,
    [drvISA_15] varchar(1) NOT NULL,
    [drvISA_16] varchar(1) NOT NULL,
    [drvGS_03] varchar(100) NULL,
    [drvGS_04] varchar(9) NOT NULL,
    [drvGS_07] varchar(1) NOT NULL,
    [drvGS_09] varchar(30) NULL,
    [drvST_03] varchar(4) NOT NULL,
    [drvST_04] varchar(30) NULL,
    [drvBGN_03] varchar(4) NOT NULL,
    [drvBGN_09] varchar(1) NOT NULL,
    [drvREF_02] varchar(2) NOT NULL,
    [drvREF_03] varchar(1) NOT NULL,
    [drvDTP_04] datetime NOT NULL,
    [drvQTY_01] varchar(30) NULL,
    [drvN1A_03] varchar(21) NOT NULL,
    [drvN1A_05] varchar(100) NULL,
    [drvN1B_03] varchar(6) NOT NULL,
    [drvN1B_05] varchar(9) NOT NULL,
    [drvN1C_03] varchar(22) NOT NULL,
    [drvN1C_05] varchar(9) NOT NULL,
    [drvSE_03] varchar(4) NOT NULL,
    [drvGE_03] varchar(1) NOT NULL,
    [drvIEA_03] varchar(9) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBS834V3]
@SystemID CHAR(12)
AS
    SET NOCOUNT ON

    BEGIN

/***********************************************************************
CREATE BY:        Gosa Group
CREATE DATE:    10/13/2020
PURPOSE:        Employee enrollment and demographic data sent to BCBS of NC

CHANGE HISTORY

DATE            CHANGED BY        TASK
-----------------------------------------------------------------

/=======================================================================

Hi future developer,

We made an update to this file in 11/2021, and discovered that the pervious
developer left a nast little time bomb for us. You'll notice that this file
is already pretty weird, but there's something we missed the first time through
that you should know about.

Instead of putting the deduction codes and group numbers in the code for the file
like most developers do, because it's the correct way, they created a table called
dbo.U_EBS834_DEDTRANS and put the deduction codes and group codes (all one of them)
there instead. 

The problem is that when we ran the rippout for this, it tagged that table to be 
dropped, but there was no logic to recreate the table in the script. So, as soon
as we ripped it out, it broke. Hard.

We were able to reconstruct that data (I think) and recreated the table. I also
added code below that will (I think) re-create the table if it gets dropped.

But, just in case, here is the code to re-insert the necessary rows into the table:

INSERT INTO dbo.U_EBS834_DedTrans (dedCode, GroupNumber) VALUES('MPPO', '14162163')
INSERT INTO dbo.U_EBS834_DedTrans (dedCode, GroupNumber) VALUES('MPPOG', '14162163')
INSERT INTO dbo.U_EBS834_DedTrans (dedCode, GroupNumber) VALUES('MHSA', '14162163')
INSERT INTO dbo.U_EBS834_DedTrans (dedCode, GroupNumber) VALUES('MHSAE', '14162163')
INSERT INTO dbo.U_EBS834_DedTrans (dedCode, GroupNumber) VALUES('MHSAS', '14162163')

Good luck!

J. Bender 

/=======================================================================



SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBS834V3';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBS834V3';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBS834V3';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBS834V3';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBS834V3' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBS834V3', 'TEST'
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBS834V3', 'ONDEMAND'
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBS834V3', 'SCHEDULED'
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBS834V3', 'ZAP'

Rip Out Export
--------------
EXEC dbo._dsi_usp_ExportRipOut 'EBS834V3', 'Y', 'FILEPATH', 'N'

EXEC dbo._dsi_usp_ExportRipOut_v7_4 'EBS834V3', 'Y', 'FILEPATH', 'N'

CREATE TABLE dbo.U_EBS834V3_DRVTBL_DEDS(drvCOID [char] (5) NULL,drvEEID [char] (12) NULL,drvMemberSSN [char] (11) NULL,drvROW_NUM [bigint]  NULL,drvconSysID [char] (12) NULL,drvDedCode [char] (5) NOT NULL,drvBenStatus [char] (1) NULL,drv1103 [varchar] (4) NULL,drv1203 [varchar] (4) NULL,drv2604 [varchar] (3) NOT NULL,drv2605 [varchar] (1) NOT NULL,drv2606 [varchar] (3) NOT NULL,drv2704 [datetime]  NULL,drv2804 [datetime]  NULL,drv3003 [varchar] (2) NOT NULL,drv4904 [datetime]  NULL,drv5003 [varchar] (4) NULL);
CREATE TABLE dbo.U_EBS834V3_drvTbl(pkid [int]  NOT NULL,drvCOID [char] (5) NOT NULL,drvEEID [char] (12) NOT NULL,drvMemberSSN [char] (11) NULL,drvConSysid [char] (12) NULL,drv0902 [varchar] (1) NOT NULL,drv0903 [varchar] (2) NOT NULL,drv0906 [varchar] (1) NOT NULL,drv0909 [varchar] (2) NOT NULL,drv0910 [char] (1) NULL,drv0911 [char] (1) NULL,drv1003 [char] (11) NULL,drv1103 [varchar] (4) NULL,drv1203 [varchar] (4) NULL,drv1303 [varchar] (2) NOT NULL,drv1404 [datetime]  NULL,drv1804 [varchar] (6000) NULL,drv1805 [varchar] (6000) NULL,drv1806 [varchar] (6000) NULL,drv1807 [varchar] (6000) NULL,drv1808 [varchar] (6000) NULL,drv1809 [varchar] (2) NOT NULL,drv1810 [char] (11) NULL,drv1905 [varchar] (6000) NULL,drv2002 [varchar] (6000) NULL,drv2003 [varchar] (6000) NULL,drv2102 [varchar] (6000) NULL,drv2103 [varchar] (255) NULL,drv2104 [varchar] (6000) NULL,drv2203 [datetime]  NULL,drv2204 [char] (1) NOT NULL,drv2205 [char] (1) NULL,drv5003 [varchar] (4) NULL,drv6003 [varchar] (8) NULL,drv6103 [varchar] (2) NULL);

*****************************************************************/



-- ======================================================================================================
-- SCRUBB EELIST
-- ======================================================================================================

    --!!REMOVE TRANSFERS
    DELETE    dbo.U_EBS834V3_EElist
    FROM    dbo.U_EBS834V3_EElist
    JOIN    EmpComp a WITH (NOLOCK) ON a.eecCOID = xCOID AND a.eecEEID = xEEID AND a.eecemplstatus = 'T'
    WHERE   EXISTS (SELECT 1
                    FROM EmpComp b WITH (NOLOCK)
                    WHERE b.eecEEID = xEEID AND b.eecCOID != xCOID AND
                          b.eecemplstatus != a.eecemplstatus)

--delete test case scnearios
DELETE 
FROM
    U_EBS834V3_EElist
WHERE 
    xEEID IN ('CLFA1R000040','DHMI1E000040','COAOU7001040','DHMPCF000040','DHMIUM000040','DHMJD9000040','DHMJLI000040','DHMJTG000040','D2WHYW000040')

--===========================================================================================
--SESSION PARAMETERS
--===========================================================================================
    DECLARE  @Year            CHAR(4),
             @Formatcode    VARCHAR(12),
             @Exportcode    VARCHAR(12),
             @FedTaxID        VARCHAR(100)

/**************************************************************************************************************************************
--GATHER THE DEDUCTION CODES
**************************************************************************************************************************************/

IF OBJECT_ID('U_EBS834V3_DedTrans') IS NULL
BEGIN
    CREATE TABLE [dbo].[U_EBS834V3_DedTrans] (
        [dedCode] CHAR(5) NULL,
        [GroupNumber] VARCHAR(25) NULL
    );
END

IF (SELECT COUNT(*) FROM dbo.U_EBS834V3_DedTrans) = 0
BEGIN
    INSERT INTO dbo.U_EBS834V3_DedTrans (dedCode, GroupNumber) VALUES('MPPO', '14162163')
    INSERT INTO dbo.U_EBS834V3_DedTrans (dedCode, GroupNumber) VALUES('MPPOG', '14162163')
    INSERT INTO dbo.U_EBS834V3_DedTrans (dedCode, GroupNumber) VALUES('MHSA', '14162163')
    INSERT INTO dbo.U_EBS834V3_DedTrans (dedCode, GroupNumber) VALUES('MHSAE', '14162163')
    INSERT INTO dbo.U_EBS834V3_DedTrans (dedCode, GroupNumber) VALUES('MHSAS', '14162163')
END




    DECLARE @DedList VARCHAR(MAX)

    IF OBJECT_ID('U_EBS834V3_DedCodeList') IS NOT NULL
        DROP TABLE dbo.U_EBS834V3_DedCodeList

        SELECT DISTINCT RTRIM(LTRIM(DedCode)) DedCode
        INTO dbo.U_EBS834V3_DedCodeList
        FROM dbo.U_EBS834V3_DedTrans

        SELECT @DedList = COALESCE(@DedList+',' ,'') + DedCode
        FROM dbo.U_EBS834V3_DedCodeList

        PRINT 'DedCodes'
        PRINT @DedList

        --  SELECT * FROM dbo.U_EBS834V3_DedTrans

/**************************************************************************************************************************************
FEDERAL TAX INFO
**************************************************************************************************************************************/
 
    SELECT @FedTaxID = REPLACE(RTRIM(cmpFedTaxID),'-','')
    FROM dbo.Company WITH (NOLOCK)
    WHERE cmpCompanyCode = 'PRMR'

/**************************************************************************************************************************************
LATEST AY DATE INFO
**************************************************************************************************************************************/
    --GET THE LAST PAY DATE
    DECLARE  @LastPayDate AS DATETIME
            ,@LastPercontrol VARCHAR(8)

    SELECT   @LastPayDate       = MAX(prgpaydate)
            ,@LastPercontrol    = MAX(SUBSTRING(prgpercontrol,1,8))
    FROM IPAYREGKEYS
    WHERE prgdocno <> 'ADJUSTMENT'

/**************************************************************************************************************************************
DECLARE DATES FROM PARAMETER FILE
**************************************************************************************************************************************/
    DECLARE  @StartDate DATETIME
            ,@EndDate DATETIME
            ,@StartPerControl VARCHAR(8)
            ,@EndPerControl VARCHAR(8)

    SELECT   @StartDate            = CASE WHEN ExportCode = 'SCHEDULED' THEN GETDATE()-7 ELSE CAST(SUBSTRING(StartPerControl,1,8) AS DATETIME)  END
            ,@EndDate            = CASE WHEN ExportCode = 'SCHEDULED' THEN GETDATE() ELSE CAST(SUBSTRING(ENDPerControl,1,8) as DATETIME)  END
            ,@StartPerControl    = SUBSTRING(StartPerControl,1,8)
            ,@EndPerControl        = SUBSTRING(ENDPerControl,1,8)
            ,@Formatcode        = Formatcode
            ,@Exportcode        = Exportcode
            ,@Year                = SUBSTRING(ENDpercontrol,1,4)
    FROM dbo.U_dsi_Parameters with (nolock)
    WHERE SystemID = @SystemID

    -- NOW SET VALUES FOR BENEFIT MODULE
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

    -- REQUIRED PARMS
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', @DedList)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'STARTDATETIME', @StartDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'ENDDATETIME', @EndDate)
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AUDITDATE')  --StopDate

    -- Non-required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CalcBenOptionDate', '2')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'IncludeOEDrops', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'InvalidateBadDeps', 'Y')

    -- Handle OE
    IF @Exportcode IN ('OEPASSIVE','OETPASSIVE')
    BEGIN
        PRINT 'OE PASSIVE'
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE')
    END

    IF @Exportcode IN ('OEACTIVE','OETACTIVE')
    BEGIN
        PRINT 'OE ACTIVE'
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE')
    END

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable 'EBS834V3' --@FormatCode

    --RELATIONSHIPS
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse', 'DOM,SPS')
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild', 'CHL,STC,SON,DAU,GRC')

    /***********************************************************************************************
    SHOULD RETURN THE SYSTEMDATESIMULATOR DATE
    ADD THE DATA SO THAT THE EFFECTIVE DATE IS SET TO THE POST DATE
    ***********************************************************************************************/

    --SELECTION ITEMS
    --SELECT * FROM U_dsi_bdm_Configuration WHERE FormatCode = 'EBS834V3'

    --SELECT EedValidForExport,* FROM dbo.U_dsi_bdm_EmpDeductions WHERE eedFormatCode = 'EBS834V3'
    --SELECT EedValidForExport,* FROM dbo.U_dsi_bdm_DepDeductions

/************************************************************************************************************
AUDIT DATA
************************************************************************************************************/
    --EMPLOYEES

 /*   IF OBJECT_ID('U_EBS834V3_Audit') IS NOT NULL
        DROP TABLE dbo.U_EBS834V3_Audit

    SELECT  audEEID        = xEEID
            ,audCOID    = xCOID
    INTO dbo.U_EBS834V3_Audit
    FROM dbo.U_EBS834V3_EEList
    JOIN dbo.vw_AuditData ON audKey1Value = xEEID AND audKey2Value = xCOID AND audTableName = 'EmpDed'
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
        AND
        (
            (
                audFieldName ='eedBenStopDate'
                AND NULLIF(audNewValue,'') IS NOT NULL
                AND NULLIF(audOldValue,'') IS NULL
            )
            OR
            (
                audFieldName ='eedBenStatus'
                AND audNewValue IN('T','C')
                AND audOldValue = 'A'
            )
        )
        */
/************************************************************************************************************
CREATE DEDCODE LIST
--THIS IS REPLACED BY THE DEDTRANS TABLE
************************************************************************************************************/

    IF OBJECT_ID('U_EBS834V3_DedList') IS NOT NULL
        DROP TABLE dbo.U_EBS834V3_DedList

        SELECT DISTINCT
             dl_COID                    = cmpCOID
            ,dl_CoCode                  = cmpCompanyCode
            ,dl_DedCode                 = RTRIM(DedCode)
            ,dl_834Type                 = CASE WHEN DedDedType = 'MED' THEN 'HLT'
                                               WHEN DedDedType = 'DEN' THEN 'DEN'
                                               WHEN DedDedType = 'VIS' THEN 'VIS'
                                               ELSE 'HMO'
                                          END
            --PLAN STRUCTURE
            , dl_834Plan                =  CASE WHEN DedCode IN ('MPPO','MPPOG') THEN  '1020003M'
                                               WHEN DedCode IN ('MHSA', 'MHSAE','MHSAS') THEN '1020004M'
                                          END
            , dl_GroupPolicy            = GroupNumber
            , dl_SubGroup               = '1001' 
            , dl_SubGroupOutOfNetwork    = ''
            , dl_BillGroup              = 'AA'
        INTO dbo.U_EBS834V3_DedList
        -- select *
        FROM dbo.U_EBS834V3_DEDTRANS
        LEFT JOIN dbo.DedCode WITH(NOLOCK) ON DedDedCode = DedCode
        JOIN dbo.Company WITH(NOLOCK) ON 1=1
        WHERE EXISTS(SELECT 1
                     FROM dbo.U_EBS834V3_EELIST
                     WHERE xCOID = cmpCOID)

--select * from U_EBS834V3_DedList
/********************************************************************************************************************************
CUSTOM
********************************************************************************************************************************/
    DECLARE  @Version       VARCHAR(30)
            ,@ReceiverID    VARCHAR(20)

    SELECT   @Version       = '005010X220A1'
            ,@ReceiverID    = '560894904'                --CODED BELOW

/********************************************************************************************************************************
CREATE HEAD/TRAILER
********************************************************************************************************************************/
    IF OBJECT_ID('U_EBS834V3_IDTbl') IS NOT NULL
        DROP TABLE dbo.U_EBS834V3_IDTbl

    SELECT
    --ISA
         drvISA_06        = '30'
        ,drvISA_07        = @FedTaxID
        ,drvISA_08        = '30'
        ,drvISA_09        = @ReceiverID
        ,drvISA_12        = '{'
        ,drvISA_13        = '00501'
        ,drvISA_14        = '000000001'                            --Interchange Control Number / MATCH IEA02
        ,drvISA_15        = '0'
        ,drvISA_16        = CASE WHEN @ExportCode LIKE '%TEST%' OR @ExportCode LIKE 'OET%' THEN 'T' ELSE 'P' END
    --GS
        ,drvGS_03        = @FedTaxID
        ,drvGS_04        = '560894904'                                    --Application Receivers Code
        ,drvGS_07        = '1'                                        --GROUP CONTROL NUMBER
        ,drvGS_09        = @Version
    --ST
        ,drvST_03        = '0001'                                    --UNIQUE NUMBER
        ,drvST_04        = @Version
    --BGN
        ,drvBGN_03        = '0001'                                    --UNIQUE NUMBER
        ,drvBGN_09        = '4'                                    --RX = FULL FILE
    --REF
        ,drvREF_02        = '38'                                    -- NOT USED BY CLIENT
        ,drvREF_03        = ''                                    -- POLICY NUMBER
    --DTP
        ,drvDTP_04        = GETDATE()                                -- CONVERT(DATETIME , dbo.fn_StartOfMonth(GETDATE()))
    --QTY
        ,drvQTY_01        = CAST('' AS VARCHAR(30))                    --THIS WILL BE UPDATED LATER
    --N1A
        ,drvN1A_03        = 'PREMIER MAGNESIA, LLC'
        ,drvN1A_05        = @FedTaxID
    --N1B
        ,drvN1B_03        = 'BCBSNC'
        ,drvN1B_05        = '560894904'                            --RECEIVER FEDID
    --N1C
        ,drvN1C_03        = 'Benefitfocus.com, Inc.'                         
        ,drvN1C_05        = '560894904'                            

    --FOOTER
        ,drvSE_03        = '0001'
        ,drvGE_03        = '1'
        ,drvIEA_03        = '000000001'
    INTO
        dbo.U_EBS834V3_IDTbl

    --SELECT LTRIM(RTRIM(CAST(33445 AS VARCHAR(20))))  + 'XX'

/********************************************************************************************************************************
CREATE DRIVER DEDUCTIONS TABLE
********************************************************************************************************************************/
    IF OBJECT_ID('U_EBS834V3_DRVTBL_DEDS') IS NOT NULL
        DROP TABLE dbo.U_EBS834V3_DRVTBL_DEDS

    SELECT
         drvCOID                = xCOID
        ,drvEEID                = xEEID
        ,drvMemberSSN           = eepSSN
        ,drvCoCode              = cmpCompanyCode
        ,drvROW_NUM             = ROW_NUMBER() OVER ( PARTITION BY eepSSN,eedDedCode ORDER BY eedbenstatus )
        ,drvconSysID            = CONVERT(CHAR(12) , NULL)
        ,drvSort2                = CASE
                                    WHEN dl_834Type = 'PPO' THEN 1
                                    WHEN dl_834Type = 'DEN' THEN 2
                                    ELSE 99
                                  END
        ,drvDedCode             = eedDedCode
        ,drvBenStatus           = eedBenStatus
        ,drvLocation            = EecLocation
        ,drvBenOption           = eedBenOption
        --CLIENT SPECIFIC
        ,ZipCode                = SUBSTRING(dbo.fn_834_RemoveChar(eepAddressZipCode),1,5)
        --,drvInNetwork            = CASE WHEN LocationCode IS NULL
                                --       THEN 'OUT'
                                --       ELSE 'IN'
                                --  END
        --dl_834GroupPolicy
        ,drv1103                = '14162163'                               -->>GROUP POLICY
        --CLASS ID FOR 17 RECORD
        ,drv1203                = CASE 
                                    WHEN eedDedCode IN ('MPPO','MPPOG') THEN '1001'
                                    WHEN eedDedCode IN ('MHSA', 'MHSAE', 'MHSAS') THEN '1003'
                                  END
        ----SUBGROUP NUMBER FOR DX RECORD
        ,drv1303                = '1001' 
        ,drv1502                = '356'
        ,drv1504                = CASE
                                    WHEN EedEEEligDate < '07/01/2021' THEN '07/01/2021'
                                    ELSE EedEEEligDate 
                                  END
        ,drv2604                = dl_834Type
        ,drv2605                = dl_834Plan
        ,drv2606                = CASE   
                                    WHEN RTRIM(eedBenOption) = 'EE' THEN 'EMP'
                                    WHEN RTRIM(eedBenOption) = 'EECH' THEN 'ECH'
                                    WHEN RTRIM(eedBenOption) = 'EESP' THEN 'ESP'
                                    WHEN RTRIM(eedBenOption) = 'FAM' THEN 'FAM'
                                    WHEN RTRIM(eedDedCode) = 'MHSAE' THEN 'EMP'
                                    ELSE eedBenOption
                                   END
        ,drv2704                = CASE
                                    --WHEN EedBenStatusDate < '5/01/2013' THEN '5/01/2013'
                                    WHEN dl_834Type = 'HLT' AND EedBenStartDate < '07/01/2021' THEN '07/01/2021'
                                    WHEN dl_834Type = 'DEN' AND EedBenStartDate < '07/01/2021' THEN '07/01/2021'
                                    ELSE EedBenStartDate
                                  END
        ,drv2804                = eedBenStopDate
        --END DEDUCTION
        ,drv3003                = ''
        ,drv4904                = CASE WHEN eedBenStopDate IS NOT NULL AND eedBenStopDate > EedBenStatusDate
                                            THEN EOMONTH(eedBenStopDate)  --NEW 303 Record
                                       WHEN eedBenStartDate > EedBenStatusDate
                                            THEN eedBenStartDate
                                       ELSE EedBenStatusDate
                                  END
        ,drv5003            = dl_GroupPolicy
    INTO dbo.U_EBS834V3_DRVTBL_DEDS
    FROM dbo.U_EBS834V3_EElist WITH(NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK) ON xEEID = eepEEID
    JOIN dbo.EmpComp WITH (NOLOCK) ON xCOID = eecCOID AND xEEID = eecEEID
    JOIN dbo.Company WITH(NOLOCK) ON CmpCoID = EecCoID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK) ON eedCOID = xCOID AND eedEEID = xEEID AND EedValidForExport = 'Y'
                                                      AND eedFormatCode = 'EBS834V3'
    JOIN dbo.U_EBS834V3_DedList WITH (NOLOCK) ON eedCOID = dl_COID AND eedDedCode = dl_DedCode

  --DELETE ANY DUPLICATE ENTRIES
    DELETE FROM
        dbo.U_EBS834V3_DRVTBL_DEDS
    WHERE
        DRVROW_NUM = 2

/********************************************************************************************************************************
DEPENDENTS DEDUCTIONS TABLE
********************************************************************************************************************************/
    INSERT  INTO dbo.U_EBS834V3_drvTbl_Deds
    SELECT
         drvCOID
        ,drvEEID
        ,drvMemberSSN
        ,drvCoCode
        ,drvROW_NUM
        ,drvconSysID        = dbndepRecID
        ,drvSort2
        ,drvDedCode
        ,drvBenStatus       = dbnBenStatus
        ,drvLocation        --EMPLOYEE LEVEL
        ,drvBenOption       --EMPLOYEE LEVEL
        ,ZipCode            --CLIENT SPECIFIC
        --,drvInNetwork       --CLIENT SPECIFIC
        ,drv1103
        ,drv1203
        ,drv1303
        ,drv1502                
        ,drv1504                
        ,drv2604
        ,drv2605
        ,drv2606            = ''
        ,drv2704            = CASE
                                WHEN drv2604 = 'HLT' AND dbnBenStartDate < '07/01/2021' THEN  '07/01/2021'
                                WHEN drv2604 = 'DEN' AND dbnBenStartDate < '07/01/2021' THEN  '07/01/2021'
                                ELSE dbnBenStartDate
                              END
        ,drv2804            = dbnBenStopDate
        ,drv3003            = drv3003
        ,drv4904
        ,drv5003
        --,U_EBS834V3_drvTbl_Deds.*
    FROM dbo.U_EBS834V3_drvTbl_Deds
    JOIN dbo.U_dsi_bdm_DepDeductions WITH (NOLOCK) ON drvEEID = dbnEEID AND drvDedCode = RTRIM(dbnDedCode)
    WHERE dbnValidForExport = 'Y' AND dbnFormatCode = 'EBS834V3' --@FormatCode

/********************************************************************************************************************************
CREATE DRIVER TABLE
********************************************************************************************************************************/
        IF OBJECT_ID('U_EBS834V3_drvTbl') IS NOT NULL
            DROP TABLE dbo.U_EBS834V3_drvTbl

        -- Get Emp data
        SELECT DISTINCT
             --pkid               = IDENTITY ( INT )
            drvCOID            = eecCOID
            ,drvEEID            = eecEEID
            ,drvMemberSSN       = eepSSN
            ,drvCoCode          = CmpCompanyCode
            ,drvConSysid        = CONVERT(CHAR(12) , NULL)
            ,drvSort2            = 1
            ,drvRelatonship     = CAST('EMP' AS VARCHAR(20))
        -- Loop: 2000   Segment: INS   Member Level Detail
            ,drv0902            = 'Y'
            ,drv0903            = '18'
            ,drv0906            = 'A'       --A,C,S,T (Active Cobra, Surviving, Tax Equity)

            --ANTHEM USES THIS FOR STUDENT
            --,drv0909            = CONVERT(CHAR(1) , NULL)
            ,drv0909            = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' ELSE 'PT' END
            ,drv0910           = CONVERT(CHAR(1) , NULL)
            ,drv0911            = CAST( CASE WHEN ISNULL(eepIsDisabled,'') = 'Y' THEN 'Y' ELSE 'N' END AS VARCHAR(1) )
            ,drv0912           = CASE WHEN EepDateDeceased IS NULL THEN '' ELSE 'D8' END
            ,drv0913            = EepDateDeceased
            ,drv0918            = CAST('' AS VARCHAR(10))
        --Loop: 2000   Segment: REF   Subscriber SSN  (Required)
            ,drv1003            = eepSSN
        --Loop: 2000   Segment: REF   Group Number/Purchaser ID  (Situational)     **
            ,drv1103
        --Loop: 2000   Segment: REF   Subgroup Number  (Situational)       **
            ,drv1203            = drv1203
        --Loop: 2000   Segment: REF   Bill Group  (Situational)         **
            ,drv1303
        --Loop: 2000   Segment: DTP   Member Level Dates  (Required)*
            ,drv1404            = EecDateOfOriginalHire
            ,drv1502            = drv1502
            ,drv1504            = drv1504
        --Loop: 2100A   Segment: NM1   Member Name  (Required)
            ,drv1804            = dbo.fn_834_RemoveChar(UPPER(eepNameLast))
            ,drv1805            = dbo.fn_834_RemoveChar(UPPER(eepNameFirst))
            ,drv1806            = dbo.fn_834_RemoveChar(UPPER(eepNameMiddle))
            ,drv1807            = NULLIF(dbo.fn_834_RemoveChar(UPPER(EepNamePrefix)),'Z')
            ,drv1808            = NULLIF(dbo.fn_834_RemoveChar(UPPER(eepNameSuffix)),'Z')
            ,drv1809            = CASE WHEN eepSSN IS NOT NULL THEN '34' ELSE NULL END
            ,drv1810            = eepSSN
        --Loop: 2100A   Segment: PER   Member Communications Numbers  (Situational)
            ,drv1905            = dbo.fn_834_RemoveChar(EepPhoneHomeNumber)
            ,drv1906            = dbo.fn_834_RemoveChar(EecPhoneBusinessNumber)
            ,drv1907            = eepAddressEMail
        --Loop: 2100A   Segment: N3   Member Residence Street Address  (Situational)
            ,drv2002            = NULLIF(dbo.fn_834_RemoveChar(UPPER(eepAddressLine1)) , SPACE(1))
            ,drv2003            = NULLIF(dbo.fn_834_RemoveChar(UPPER(eepAddressLine2)) , SPACE(1))
        --Loop: 2100A   Segment: N4   Member Residence City, State, Zip Code  (Requied)
            ,drv2102            = NULLIF(dbo.fn_834_RemoveChar(UPPER(eepAddressCity)) , SPACE(1))
            ,drv2103            = ISNULL(eepAddressState,'')
            ,drv2104            = dbo.fn_834_RemoveChar(eepAddressZipCode)
            ,drv2105            = EepAddressCountry
        --Loop: 2100A   Segment: DMG   Member Demographics  (Situational)
            ,drv2203            = eepDateOfBirth
            ,drv2204            = ISNULL(eepGender , 'M')
            ,drv2205            = CASE EepMaritalStatus
                                       WHEN 'M' THEN 'M'
                                       WHEN 'S' THEN 'I'
                                       WHEN 'D' THEN 'D'
                                       WHEN 'W' THEN 'I'
                                       WHEN 'Z' THEN 'I'
                                       ELSE 'I'
                                  END
        --  IGNORED
            ,drv5003            = ''--drv5003
        --Loop: 2750   Segment: Reporting Category  (Situational: Required for New Hires)
            --,drv6003    = CASE WHEN (nHireEffDate BETWEEN @StartDate AND @EndDate) OR (nIntegrationEffDate BETWEEN @StartDate AND @EndDate) THEN 'NEW HIRE' ELSE NULL END
            --,drv6103    = CASE WHEN (nHireEffDate BETWEEN @StartDate AND @EndDate) OR (nIntegrationEffDate BETWEEN @StartDate AND @EndDate) THEN '20' ELSE NULL END
            ,drv6003    = CONVERT(VARCHAR(10), NULL) --CASE WHEN drvBenStatus = 'A' THEN 'CMSESC' ELSE CONVERT(VARCHAR(10), NULL) END -- CASE WHEN (getdate() BETWEEN @StartDate AND @EndDate) OR (getdate() BETWEEN @StartDate AND @EndDate) THEN 'CMSESC' ELSE NULL END  --nHireEffDate
            ,drv6103    = CONVERT(VARCHAR(10), NULL)
            ,drv6204    = CONVERT(DATETIME, NULL)--drv2704
        INTO dbo.U_EBS834V3_drvTbl
        --select *
        FROM dbo.U_EBS834V3_drvTbl_Deds WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK) ON drvCOID = eecCOID AND drvEEID = eecEEID AND drvConSysID IS NULL
        JOIN dbo.EmpPers WITH (NOLOCK) ON eecEEID = eepEEID
        JOIN dbo.Company WITH (NOLOCK) ON eecCOID = cmpCOID
        LEFT JOIN dbo.gosa_vw_NewHires WITH(NOLOCK)
            ON nEEID = drvEEID
            AND nCOID = drvCOID

--SELECT * FROM U_EBS834V3_drvTbl WHERE drv6204 IS NULL

/********************************************************************************************************************************
GATHER THE DEPENDENTS
********************************************************************************************************************************/
-- Get Dep data
    INSERT  INTO dbo.U_EBS834V3_drvTbl
    (
        drvCOID
        ,drvEEID
        ,drvMemberSSN
        ,drvCoCode
        ,drvConSysid
        ,drvSort2
        ,drvRelatonship
        ,drv0902
        ,drv0903
        ,drv0906
        ,drv0909
        ,drv0910
        ,drv0911
        ,drv0912
        ,drv0913
        --,drv0914
        ,drv0918
        ,drv1003
        ,drv1103
        ,drv1203
        ,drv1303
        ,drv1404
        ,drv1502                
        ,drv1504                
        ,drv1804
        ,drv1805
        ,drv1806
        ,drv1807
        ,drv1808
        ,drv1809
        ,drv1810
        ,drv1905
        ,drv2002
        ,drv2003
        ,drv2102
        ,drv2103
        ,drv2104
        ,drv2105
        ,drv2203
        ,drv2204
        ,drv2205
        ,drv5003
    )
    SELECT
         drvCOID            = A.drvCOID
        ,drvEEID            = A.drvEEID
        ,drvMemberSSN
        ,drvCoCode
        ,drvConSysid        = CONVERT(CHAR(12) , consystemid)
        ,drvSort2
        ,drvRelatonship        = ConRelationship
        ,drv0902            = 'N'

        --select * from codes where CodTable = 'RELATION'

        ,drv0903            = CASE
                                WHEN ConRelationShip IN ('SPS')
                                    THEN '01' --SPOUSE  / DECEASED SPOUSE
                                WHEN ConRelationShip IN ('C6','CH1','CH2','CH3','CH4','CH5','CH6','CH7','CHL','STC')
                                    THEN '19' --CHILDREN
                                WHEN ConRelationShip LIKE '%CH'
                                    THEN '19' --CHILDREN
                                WHEN ConRelationShip IN ('XSP')                 THEN '25' --EX SPOUSE
                                WHEN ConRelationShip IN ('NIC','NPW')           THEN '07' --NIECE/NEPHEW
                                ELSE ''
                              END
        ,drv0906            = ''
        ,drv0909            = SPACE(1)
        ,drv0910            = ''
        ,drv0911            = ''
        ,drv0912            = ''
        ,drv0913            = NULL
        --,drv0914
        ,drv0918            = ''
        ,drv1003
        --Loop: 2000   Segment: REF   Group Number/Purchaser ID  (Situational)     **
        ,drv1103
        --Loop: 2000   Segment: REF   Subgroup Number  (Situational)       **
        ,drv1203
        --Loop: 2000   Segment: REF   Bill Group  (Situational)         **
        ,drv1303
        --
        ,drv1404            = drv1404
        ,drv1502                
        ,drv1504                
        ,drv1804            = dbo.fn_834_RemoveChar(UPPER(conNameLast))
        ,drv1805            = dbo.fn_834_RemoveChar(UPPER(conNameFirst))
        ,drv1806            = dbo.fn_834_RemoveChar(UPPER(conNameMiddle))
        ,drv1807            = CONVERT(CHAR(1) , NULL)            -- dbo.fn_834_RemoveChar(conNamePrefix)
        ,drv1808            = dbo.dsi_fnRemoveChars('.,/-Z',conNameSuffix)       --CONVERT(CHAR(1) , NULL)
        ,drv1809            = '34'
        ,drv1810            = NULLIF(NULLIF(conSSN , drvMemberSSN) , '')--ISNULL(NULLIF(NULLIF(conSSN , drvMemberSSN) , '') , REPLICATE('0' , 9))
        ,drv1905            = ISNULL(NULLIF(dbo.fn_834_RemoveChar(ConPhoneHomeNumber) , '') , drv1905)
        ,drv2002            = COALESCE(NULLIF(dbo.fn_834_RemoveChar(UPPER(conAddressLine1)) , SPACE(1)) , drv2002)
        ,drv2003            = NULLIF(dbo.fn_834_RemoveChar(UPPER(conAddressLine2)) , SPACE(1))
        ,drv2102            = COALESCE(NULLIF(dbo.fn_834_RemoveChar(UPPER(conAddressCity)) , SPACE(1)) , drv2102)
        ,drv2103            = COALESCE(NULLIF(conAddressState , SPACE(1)) , drv2103)
        ,drv2104            = COALESCE(NULLIF(dbo.fn_834_RemoveChar(conAddressZipCode) , SPACE(1)) , drv2104)
        ,drv2105            = ConAddressCountry
        ,drv2203            = conDateOfBirth
        ,drv2204            = ISNULL(conGENDer , 'M')
        ,drv2205            = ''
        ,drv5003
    FROM dbo.Contacts WITH (NOLOCK)
    JOIN dbo.U_EBS834V3_drvTbl a
        ON a.drvEEID = conEEID
    WHERE
        EXISTS ( SELECT 1
                 FROM dbo.U_EBS834V3_drvTbl_Deds b
                 WHERE
                    a.drvCOID = b.drvCOID
                    AND a.drvEEID = a.drvEEID
                    AND consystemid = b.drvconsysid )

/********************************************************************************************************************************
SET THE HEADER RECORD WITH THE TOTAL RECORDS PROCESSED
********************************************************************************************************************************/
    UPDATE dbo.U_EBS834V3_IDTbl
    SET drvQTY_01 = RTRIM(LTRIM(CAST((SELECT COUNT(1) FROM dbo.U_EBS834V3_drvTbl) AS VARCHAR(20))))

/********************************************************************************************************************************
CREATE HEAD/TRAILER
********************************************************************************************************************************/
-- CLEAN UP THE DATA - REMOVE DEPENDENT DEDUCTIONS THAT DO NOT EXIST IN THE DRIVER TABLE
-- ======================================================================================================

    DELETE A
    FROM dbo.U_EBS834V3_drvTbl_Deds A
    WHERE
        drvconSysID IS NOT NULL
        AND NOT EXISTS(SELECT 1 FROM dbo.U_EBS834V3_drvTbl B WHERE A.drvConSysid = B.drvConSysid)

/********************************************************************************************************************************
SCRUBB CONTACTS
********************************************************************************************************************************/
    --UPDATE
    --    U_EBS834V3_drvTbl
    --SET
    --    drv1810 = NULL--REPLICATE('0' , 9)
    --    ,drv1809 = NULL
    --WHERE
    --    drvconsysid IS NOT NULL
    --    AND ISNULL( NULLIF(drv1810 , SPACE(1)) , REPLICATE('1' , 9)) IN ( '000000000' , '111111111' , '', '123456789','999999999')

    --UPDATE dbo.Contacts
    --SET conssn = REPLICATE('1' , 9)
    --FROM dbo.Contacts
    --WHERE
    --EXISTS ( SELECT
    --            1
    --         FROM
    --            U_EBS834V3_drvTbl
    --         WHERE
    --            drvconsysid IS NOT NULL AND
    --            drv1810 = REPLICATE('1' , 9) AND
    --            consystemid = drvconsysid AND
    --            NULLIF(conssn , SPACE(1)) IS NULL )

/********************************************************************************************************************************
--UPDATE FILE NAME
********************************************************************************************************************************/
 IF (dbo.dsi_fnVariable('EBS834V3','UseFileName') = 'N')

    UPDATE dbo.U_dsi_Parameters
    SET ExportFile =
                CASE
                    WHEN RTRIM(@ExportCode) IN('SCHEDULED','ON_DEMAND')        THEN ''
                    WHEN RTRIM(@ExportCode) LIKE 'OET%'                        THEN 'TESTOE_'        --TEST
                    WHEN RTRIM(@ExportCode) LIKE 'OE%'                        THEN ''                --REMOVED OE FROM THE FRONT OF THE FILE
                    WHEN RTRIM(@ExportCode) LIKE '%TEST%'                    THEN 'TEST_'
                    ELSE ''
                END
                + 'BlueStar_834_' + CONVERT(VARCHAR(10), GETDATE(), 112) + '.txt'
    WHERE
        SystemID = @SystemID

END
GO
CREATE PROCEDURE dbo.dsi_sp_EBS834V3_Copy_Files
AS

SET NOCOUNT ON

BEGIN

--DECLARE

    DECLARE @From VARCHAR(1000), @To VARCHAR(1000), @FULL VARCHAR(2000)

      SELECT  @From = '\\Munpr2\bi\HR_INTERFACES\Exports\Kaiser_834\Medline_Industries_834_ca.txt'
            ,@To  = '\\Munpr2\bi\HR_INTERFACES\Exports\Kaiser_834\Archive\'  --+ CONVERT(VARCHAR,GETDATE(),112) + SUBSTRING(REPLACE(CONVERT(VARCHAR,GETDATE(),114),':',''),1,6) + '.txt'

    SELECT @FULL = RTRIM('COPY ' + @From + ' ' + @To )

    EXEC master.dbo.xp_cmdshell @FULL

    SELECT  @From = '\\Munpr2\bi\HR_INTERFACES\Exports\Kaiser_834\Archive\Medline_Industries_834_ca.txt'
            ,@To  = 'Medline_Industries_834_ca_' + CONVERT(VARCHAR,GETDATE(),112) + '_' + SUBSTRING(REPLACE(CONVERT(VARCHAR,GETDATE(),114),':',''),1,6) + '.txt'

    SELECT @FULL = RTRIM('RENAME ' + @From + ' ' + @To )

    EXEC master.dbo.xp_cmdshell @FULL

END
GO
CREATE VIEW [dbo].[dsi_vwEBS834V3_Export] AS

    SELECT TOP 9000000000 RTRIM(DATA) DATA
    FROM dbo.U_EBS834V3_File WITH (NOLOCK)
    ORDER BY
        CASE SUBSTRING(RecordSet,1,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END
        ,InitialSort
        ,SubSort
        --,SUBSTRING(RecordSet,2,2)
        ,CASE
            WHEN RecordSet = 'D30' AND SubSort2 = '2' THEN 39 --THIS SORTS THE DENTAL PORTION; SUBSORT2 REPRESENTS DENTAL
            ELSE SUBSTRING(RecordSet,2,2)
         END
        ,SubSort2

GO


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBS834V3'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBS834V3'
   AND rpoParmType = 'expSystemID'


-- End ripout