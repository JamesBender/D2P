/**********************************************************************************

EKAIMAJ834: Kaiser 834 Export

FormatCode:     EKAIMAJ834
Project:        Kaiser 834 Export
Client ID:      MAJ1001
Date/time:      2022-01-18 19:46:36.997
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW1WUP5DB01
Database:       ULTIPRO_WPMJS
Web Filename:   MAJ1001_JO8UK_EEHISTORY_EKAIMAJ834_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EKAIMAJ834_SavePath') IS NOT NULL DROP TABLE dbo.U_EKAIMAJ834_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EKAIMAJ834'


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
WHERE FormatCode = 'EKAIMAJ834'
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
WHERE ExpFormatCode = 'EKAIMAJ834'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EKAIMAJ834')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EKAIMAJ834'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EKAIMAJ834'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EKAIMAJ834'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EKAIMAJ834'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EKAIMAJ834'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EKAIMAJ834'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EKAIMAJ834'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EKAIMAJ834'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EKAIMAJ834'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEKAIMAJ834_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEKAIMAJ834_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EKAIMAJ834') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EKAIMAJ834];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_EKAIMAJ834') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_EKAIMAJ834];
GO
IF OBJECT_ID('U_EKAIMAJ834_TrlTbl') IS NOT NULL DROP TABLE [dbo].[U_EKAIMAJ834_TrlTbl];
GO
IF OBJECT_ID('U_EKAIMAJ834_HdrTbl') IS NOT NULL DROP TABLE [dbo].[U_EKAIMAJ834_HdrTbl];
GO
IF OBJECT_ID('U_EKAIMAJ834_File') IS NOT NULL DROP TABLE [dbo].[U_EKAIMAJ834_File];
GO
IF OBJECT_ID('U_EKAIMAJ834_EEList') IS NOT NULL DROP TABLE [dbo].[U_EKAIMAJ834_EEList];
GO
IF OBJECT_ID('U_EKAIMAJ834_DrvTbl_2300') IS NOT NULL DROP TABLE [dbo].[U_EKAIMAJ834_DrvTbl_2300];
GO
IF OBJECT_ID('U_EKAIMAJ834_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_EKAIMAJ834_DrvTbl];
GO
IF OBJECT_ID('U_EKAIMAJ834_DedList') IS NOT NULL DROP TABLE [dbo].[U_EKAIMAJ834_DedList];
GO
IF OBJECT_ID('U_EKAIMAJ834_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EKAIMAJ834_AuditFields];
GO
IF OBJECT_ID('U_EKAIMAJ834_Audit') IS NOT NULL DROP TABLE [dbo].[U_EKAIMAJ834_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EKAIMAJ834') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EKAIMAJ834];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EKAIMAJ834','Kaiser 834 Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EKAIMAJ834Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','H','01','1',NULL,'ISA  Segment ID (Header)',NULL,NULL,'"ISA"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','2','H','01','2',NULL,'Authorization Info Qualifier',NULL,NULL,'"00"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','10','H','01','3',NULL,'Authorization Info',NULL,NULL,'""','(''SS''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','2','H','01','4',NULL,'Security Info Qualifier',NULL,NULL,'"00"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','10','H','01','5',NULL,'Security Info',NULL,NULL,'""','(''SS''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EKAIMAJ834Z0','2','H','01','6',NULL,'Sender ID Qualifier',NULL,NULL,'"drvISA05_SenderIDQual"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EKAIMAJ834Z0','15','H','01','7',NULL,'Sender ID',NULL,NULL,'"drvISA06_SenderID"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EKAIMAJ834Z0','2','H','01','8',NULL,'Receiver ID Qualifier',NULL,NULL,'"drvISA07_ReceiverIDQual"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EKAIMAJ834Z0','15','H','01','9',NULL,'Receiver ID',NULL,NULL,'"drvISA08_ReceiverID"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EKAIMAJ834Z0','6','H','01','10',NULL,'Interchange Date',NULL,NULL,'"drvISA09_InterchangeDate"','(''UD12''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EKAIMAJ834Z0','4','H','01','11',NULL,'Interchange Time',NULL,NULL,'"drvISA10_InterchangeTime"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EKAIMAJ834Z0','1','H','01','12',NULL,'Repetition Separator',NULL,NULL,'"^"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EKAIMAJ834Z0','5','H','01','13',NULL,'Interchange Control Ver #',NULL,NULL,'"00501"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EKAIMAJ834Z0','9','H','01','14',NULL,'Interchange Control #',NULL,NULL,'"000000001"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EKAIMAJ834Z0','1','H','01','15',NULL,'Acknowledgement Requested',NULL,NULL,'"0"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EKAIMAJ834Z0','1','H','01','16',NULL,'Usage Indicator',NULL,NULL,'"drvISA15_UsageIndicator"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EKAIMAJ834Z0','1','H','01','17',NULL,'Component Element Separator',NULL,NULL,'":"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','H','02','1',NULL,'GS Segment ID (Header)',NULL,NULL,'"GS"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','2','H','02','2',NULL,'Functional ID Code',NULL,NULL,'"BE"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','15','H','02','3',NULL,'Sender ID',NULL,NULL,'"drvGS02_SenderID"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','15','H','02','4',NULL,'Receiver ID',NULL,NULL,'"drvGS03_ReceiverID"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','8','H','02','5',NULL,'Date',NULL,NULL,'"drvGS04_Date"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EKAIMAJ834Z0','8','H','02','6',NULL,'Time',NULL,NULL,'"drvGS05_Time"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EKAIMAJ834Z0','9','H','02','7',NULL,'Group Control Number',NULL,NULL,'"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EKAIMAJ834Z0','2','H','02','8',NULL,'Responsible Agency Code',NULL,NULL,'"X"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EKAIMAJ834Z0','12','H','02','9',NULL,'Version/Release  Code',NULL,NULL,'"005010X220A1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','H','03','1',NULL,'ST Segment ID (Header)',NULL,NULL,'"ST"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','H','03','2',NULL,'Transaction ID Code',NULL,NULL,'"834"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','9','H','03','3',NULL,'Transaction Set Control #',NULL,NULL,'"0001"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','35','H','03','4',NULL,'Implementation Convention Refe',NULL,NULL,'"005010X220A1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','H','04','1',NULL,'BGN Segment ID (Header)',NULL,NULL,'"BGN"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','2','H','04','2',NULL,'Transaction Set Purpose',NULL,NULL,'"00"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','50','H','04','3',NULL,'Reference Number',NULL,NULL,'"0001"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','8','H','04','4',NULL,'Date',NULL,NULL,'"drvBGN03_Date"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','8','H','04','5',NULL,'Time',NULL,NULL,'"drvBGN04_Time"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EKAIMAJ834Z0','2','H','04','6',NULL,'Time Code',NULL,NULL,'"drvBGN05_TimeCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EKAIMAJ834Z0','50','H','04','7',NULL,'Reference Identification',NULL,NULL,'"drvBGN06_RefID"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EKAIMAJ834Z0','2','H','04','8',NULL,'Transaction Type Code',NULL,NULL,'"drvBGN07_TransTypeCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EKAIMAJ834Z0','2','H','04','9',NULL,'Action Code',NULL,NULL,'"drvBGN08_ActionCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','H','05','1',NULL,'REF Segment ID (Header)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','H','05','2',NULL,'Reference Number Qualifier',NULL,NULL,'"drvREF01_RefNumberQual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','50','H','05','3',NULL,'Reference Number Qualifier',NULL,NULL,'"drvREF02_RefNumberQual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','H','06','1',NULL,'QTY Segment ID (Header)',NULL,NULL,'"QTY"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','2','H','06','2',NULL,'Quantity Qualifier',NULL,NULL,'"drvQTY01_QuantityQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','15','H','06','3',NULL,'Quantity',NULL,NULL,'"drvQTY02_Quantity1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','H','07','1',NULL,'QTY Segment ID (Header)',NULL,NULL,'"QTY"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','2','H','07','2',NULL,'Quantity Qualifier',NULL,NULL,'"drvQTY01_QuantityQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','15','H','07','3',NULL,'Quantity',NULL,NULL,'"drvQTY02_Quantity2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','H','08','1',NULL,'QTY Segment ID (Header)',NULL,NULL,'"QTY"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','2','H','08','2',NULL,'Quantity Qualifier',NULL,NULL,'"drvQTY01_QuantityQual3"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','15','H','08','3',NULL,'Quantity',NULL,NULL,'"drvQTY02_Quantity3"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','H','09','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL,'"N1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','H','09','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL,'"drvN101_EntityIDCodeSponsor1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','60','H','09','3',NULL,'Name',NULL,NULL,'"drvN102_Name1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','2','H','09','4',NULL,'Identification Code Qualifier',NULL,NULL,'"drvN103_IDCodeQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','80','H','09','5',NULL,'Identification Code',NULL,NULL,'"drvN104_IDCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','H','10','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL,'"N1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','H','10','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL,'"drvN101_EntityIDCodeSponsor2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','60','H','10','3',NULL,'Name',NULL,NULL,'"drvN102_Name2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','2','H','10','4',NULL,'Identification Code Qualifier',NULL,NULL,'"drvN103_IDCodeQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','80','H','10','5',NULL,'Identification Code',NULL,NULL,'"drvN104_IDCode2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','11','1',NULL,'INS Segment ID (Loop 2000)',NULL,NULL,'"INS"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','1','D','11','2',NULL,'Yes/No Condition',NULL,NULL,'"drvINS01_YesNoCond"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','2','D','11','3',NULL,'Individual Relationship Code',NULL,NULL,'"drvINS02_RelationshipCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','3','D','11','4',NULL,'Maintenance Type Code',NULL,NULL,'"drvINS03_MaintTypeCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','3','D','11','5',NULL,'Maintenance Reason Code',NULL,NULL,'"drvINS04_MaintReasonCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EKAIMAJ834Z0','1','D','11','6',NULL,'Benefit Status Code',NULL,NULL,'"drvINS05_BenefitStatusCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EKAIMAJ834Z0','1','D','11','7',NULL,'MEDICARE PLAN CODE',NULL,NULL,'"drvINS0601_MEDICAREPLANCODE"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EKAIMAJ834Z0','1','D','11','8',NULL,'Eligibility Reason Code',NULL,NULL,'"drvINS0602_EligibilityRsnCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EKAIMAJ834Z0','2','D','11','9',NULL,'COBRA Qualifying Event Code',NULL,NULL,'"drvINS07_COBRAQualEventCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EKAIMAJ834Z0','2','D','11','10',NULL,'Employment Status Code',NULL,NULL,'"drvINS08_EmploymentStatusCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EKAIMAJ834Z0','1','D','11','11',NULL,'Student Status Code',NULL,NULL,'"drvINS09_StudentStatusCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EKAIMAJ834Z0','1','D','11','12',NULL,'Response Code',NULL,NULL,'"drvINS10_ResponseCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EKAIMAJ834Z0','3','D','11','13',NULL,'Date Time Period Format Qualif',NULL,NULL,'"drvINS11_DateTimeFormatQual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EKAIMAJ834Z0','35','D','11','14',NULL,'Date Time Period',NULL,NULL,'"drvINS12_DateTimePeriod"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','12','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','12','2',NULL,'Reference Number Identificatio',NULL,NULL,'"0F"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','50','D','12','3',NULL,'Reference Number',NULL,NULL,'"drvSSN"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','13','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','13','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','50','D','13','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','14','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','14','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','50','D','14','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','15','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','15','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual3"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','50','D','15','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual3"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','16','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','16','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual4"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','50','D','16','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual4"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','17','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL,'"drvDTP00_DateTime1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','17','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','3','D','17','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','35','D','17','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod1"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','18','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL,'"drvDTP00_DateTime2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','18','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','3','D','18','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','35','D','18','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod2"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','20','1',NULL,'NM1 Segment ID (Loop 2100A)',NULL,NULL,'"NM1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','20','2',NULL,'Entity Identifier Code',NULL,NULL,'"IL"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','1','D','20','3',NULL,'Entity Type Qualifier',NULL,NULL,'"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','60','D','20','4',NULL,'Name Last',NULL,NULL,'"drvNM103_NameLast1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','35','D','20','5',NULL,'Name First',NULL,NULL,'"drvNM104_NameFirst1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EKAIMAJ834Z0','25','D','20','6',NULL,'Name Middle Initial',NULL,NULL,'"drvNM105_NameMiddleInitial1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EKAIMAJ834Z0','10','D','20','7',NULL,'Name Prefix',NULL,NULL,'"drvNM106_NamePrefix1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EKAIMAJ834Z0','10','D','20','8',NULL,'Name Suffix',NULL,NULL,'"drvNM107_NameSuffix1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EKAIMAJ834Z0','2','D','20','9',NULL,'Identification Code Qualifier',NULL,NULL,'"drvNM108_IDCodeQualifier1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EKAIMAJ834Z0','80','D','20','10',NULL,'Identification Code',NULL,NULL,'"drvNM109_IDCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','21','1',NULL,'PER Segment ID (Loop 2100A)',NULL,NULL,'"PER"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','2','D','21','2',NULL,'Contact Function Code',NULL,NULL,'"IP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','60','D','21','3',NULL,'Name',NULL,NULL,'"drvPER02_Name"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','3','D','21','4',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER03_CommNumberQualifier"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','256','D','21','5',NULL,'Communication Number',NULL,NULL,'"drvPER04_CommunicationNumber"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EKAIMAJ834Z0','3','D','21','6',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER05_CommNumberQualifier"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EKAIMAJ834Z0','256','D','21','7',NULL,'Communication Number',NULL,NULL,'"drvPER06_CommunicationNumber"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EKAIMAJ834Z0','3','D','21','8',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER07_CommNumberQualifier"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EKAIMAJ834Z0','256','D','21','9',NULL,'Communication Number',NULL,NULL,'"drvPER08_CommunicationNumber"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','D','22','1',NULL,'N3 Segment ID (Loop 2100A)',NULL,NULL,'"N3"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','55','D','22','2',NULL,'Address Line 1',NULL,NULL,'"drvN301_AddressLine1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','55','D','22','3',NULL,'Address Line 2',NULL,NULL,'"drvN302_AddressLine2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','D','23','1',NULL,'N4 Segment ID (Loop 2100A)',NULL,NULL,'"N4"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','30','D','23','2',NULL,'City',NULL,NULL,'"drvN401_City"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','2','D','23','3',NULL,'State',NULL,NULL,'"drvN402_State"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','15','D','23','4',NULL,'Zip',NULL,NULL,'"drvN403_Zip"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','3','D','23','5',NULL,'Country Code',NULL,NULL,'"drvN404_CountryCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','24','1',NULL,'DMG Segment ID (Loop 2100A)',NULL,NULL,'"DMG"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','24','2',NULL,'Date/Time Format Qualifier',NULL,NULL,'"D8"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','35','D','24','3',NULL,'Date/Time Period',NULL,NULL,'"drvDMG02_DateTimePeriod1"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','1','D','24','4',NULL,'Gender Code',NULL,NULL,'"drvDMG03_GenderCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','1','D','24','5',NULL,'Marital Status Code',NULL,NULL,'"drvDMG04_MaritalStatusCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','25','1',NULL,'ICM Segment ID (Loop1000A)',NULL,NULL,'"ICM"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','1','D','25','2',NULL,'Frequency Code',NULL,NULL,'"drvICM01_FrequencyCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','18','D','25','3',NULL,'Monetary Amount',NULL,NULL,'"drvICM02_MonetaryAmount"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','15','D','25','4',NULL,'Quantity',NULL,NULL,'"drvICM03_Quantity"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','30','D','25','5',NULL,'Location Identifier Description',NULL,NULL,'"drvICM04_LocationID"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','26','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL,'"drvAMT00_SegmentID1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','18','D','26','2',NULL,'Monetary Amount',NULL,NULL,'"drvAMT01_AmountQualifierCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','1','D','26','3',NULL,'Credit/Debit Flag Code',NULL,NULL,'"drvAMT02_MonetaryAmount1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','27','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL,'"drvAMT00_SegmentID2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','18','D','27','2',NULL,'Monetary Amount',NULL,NULL,'"drvAMT01_AmountQualifierCode2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','1','D','27','3',NULL,'Credit/Debit Flag Code',NULL,NULL,'"drvAMT02_MonetaryAmount2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','1','D','28','1',NULL,'HLH Segment ID (Loop1000A)',NULL,NULL,'"drvHLH00_SegmentID"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','8','D','28','2',NULL,'Health-Related Code',NULL,NULL,'"drvHLH01_HealthRelatedCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','10','D','28','3',NULL,'Height',NULL,NULL,'"drvHLH02_Height"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','10','D','28','4',NULL,'Weight',NULL,NULL,'"drvHLH03_Weight1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','10','D','28','5',NULL,'Weight',NULL,NULL,'"drvHLH04_Weight2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EKAIMAJ834Z0','10','D','28','6',NULL,'Description',NULL,NULL,'"drvHLH05_Description1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EKAIMAJ834Z0','10','D','28','7',NULL,'Current Health Condition Code',NULL,NULL,'"drvHLH06_CurrentHealthConditionCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EKAIMAJ834Z0','10','D','28','8',NULL,'Description',NULL,NULL,'"drvHLH07_Description2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','D','40','1',NULL,'HD Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvHD00_HealthCoverage"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','40','2',NULL,'Maintenance Type Code',NULL,NULL,'"drvHD01_MaintTypeCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','3','D','40','3',NULL,'Maintenance Reason Code',NULL,NULL,'"drvHD02_MaintReasonCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','3','D','40','4',NULL,'Insurance Line Code',NULL,NULL,'"drvHD03_InsuranceLineCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EKAIMAJ834Z0','50','D','40','5',NULL,'Plan Coverage Description',NULL,NULL,'"drvHD04_PlanCoverageDesc"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EKAIMAJ834Z0','3','D','40','6',NULL,'Coverage Level Code',NULL,NULL,'"drvHD05_CoverageLevelCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','41','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvDTP00_DateTime_348"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','41','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier_348"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','3','D','41','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual_348"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','35','D','41','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod_348"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','42','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvDTP00_DateTime_349"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','42','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier_349"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','3','D','42','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual_349"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','35','D','42','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod_349"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','43','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvDTP00_DateTime_303"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','43','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier_303"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','3','D','43','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual_303"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EKAIMAJ834Z0','35','D','43','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod_303"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','45','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL,'"drvREF00_RefNumberQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','45','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','50','D','45','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','46','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL,'"drvREF00_RefNumberQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','46','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','50','D','46','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','50','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvAMT00_AmountQualifierCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','50','2',NULL,'Amount Qualifier Code',NULL,NULL,'"drvAMT01_AmountQualifierCode1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','18','D','50','3',NULL,'Monetary Amount',NULL,NULL,'"drvAMT02_MonetaryAmount1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','51','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvAMT00_AmountQualifierCode2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','51','2',NULL,'Amount Qualifier Code',NULL,NULL,'"drvAMT01_AmountQualifierCode2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','18','D','51','3',NULL,'Monetary Amount',NULL,NULL,'"drvAMT02_MonetaryAmount2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','D','80','1',NULL,'LS Segment ID (Loop 2700)',NULL,NULL,'"LS"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','6','D','80','2',NULL,'Loop ID Code',NULL,NULL,'"drvLS01_LoopIDCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','D','81','1',NULL,'LX Segment ID (Loop 2700)',NULL,NULL,'"LX"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','6','D','81','2',NULL,'Assigned Number',NULL,NULL,'"drvLX01_AssignedNumber"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','D','85','1',NULL,'N1 Segment ID (Loop 2750)',NULL,NULL,'"N1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','85','2',NULL,'Entity Identifier Code',NULL,NULL,'"drvN101_EntityIDCodeSponsor"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','60','D','85','3',NULL,'Name',NULL,NULL,'"drvN102_Name"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','86','1',NULL,'REF Segment ID (Loop 2750)',NULL,NULL,'"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','3','D','86','2',NULL,'Reference Identification Quali',NULL,NULL,'"drvREF01_RefNumberQual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','50','D','86','3',NULL,'Reference Identification Descr',NULL,NULL,'"drvREF02_RefNumberDesc"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','D','87','1',NULL,'LE Segment ID (Loop 2750)',NULL,NULL,'"LE"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','6','D','87','2',NULL,'Loop ID Code',NULL,NULL,'"drvLE01_LoopIDCode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','T','90','1',NULL,'SE Segment ID (Trailer)',NULL,NULL,'"SE"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','10','T','90','2',NULL,'Number of Included Segments',NULL,NULL,'"drvSE01_SegmentCount"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','9','T','90','3',NULL,'Transaction Set Control Number',NULL,NULL,'"0001"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','2','T','91','1',NULL,'GE Segment ID (Trailer)',NULL,NULL,'"GE"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','6','T','91','2',NULL,'Number of Transaction Sets Inc',NULL,NULL,'"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','9','T','91','3',NULL,'Group Control Number',NULL,NULL,'"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EKAIMAJ834Z0','3','T','92','1',NULL,'IEA Segment ID (Trailer)',NULL,NULL,'"IEA"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EKAIMAJ834Z0','5','T','92','2',NULL,'Number of Functional Groups In',NULL,NULL,'"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EKAIMAJ834Z0','9','T','92','3',NULL,'Interchange Control Number',NULL,NULL,'"000000001"','(''DA''=''T*'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EKAIMAJ834_20220118.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Changes Only File','202201119','EMPEXPORT','CHANGES','Jan 11 2022  6:55PM','EKAIMAJ834',NULL,NULL,NULL,'202201119','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202201111','931','','','202201111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Full File Only','202201131','EMPEXPORT','FULLFILE','Jan 13 2022 10:10PM','EKAIMAJ834',NULL,NULL,NULL,'202201131','Jan 13 2022 12:00AM','Dec 30 1899 12:00AM','202201011','945','','','202201011',dbo.fn_GetTimedKey(),NULL,'us3cPeMAJ1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment','202201119','EMPEXPORT','OEACTIVE','Jan 11 2022  6:56PM','EKAIMAJ834',NULL,NULL,NULL,'202201119','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202201111','3','','','202201111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment','202201119','EMPEXPORT','OEPASSIVE','Jan 11 2022  6:56PM','EKAIMAJ834',NULL,NULL,NULL,'202201119','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202201111','931','','','202201111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Kaiser 834 Export','202201119','EMPEXPORT','SCH_KAI834','Jan 11 2022  6:56PM','EKAIMAJ834',NULL,NULL,NULL,'202201119','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202201111','931','','','202201111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAIMAJ834','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAIMAJ834','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAIMAJ834','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAIMAJ834','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAIMAJ834','Is834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAIMAJ834','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAIMAJ834','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAIMAJ834','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EKAIMAJ834','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','H01','U_EKAIMAJ834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','H02','U_EKAIMAJ834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','H03','U_EKAIMAJ834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','H04','U_EKAIMAJ834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','H05','U_EKAIMAJ834_HdrTbl','ISNULL(drvREF01_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','H06','U_EKAIMAJ834_HdrTbl','ISNULL(drvQTY01_QuantityQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','H07','U_EKAIMAJ834_HdrTbl','ISNULL(drvQTY01_QuantityQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','H08','U_EKAIMAJ834_HdrTbl','ISNULL(drvQTY01_QuantityQual3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','H09','U_EKAIMAJ834_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','H10','U_EKAIMAJ834_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D11','U_EKAIMAJ834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D12','U_EKAIMAJ834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D13','U_EKAIMAJ834_DrvTbl','ISNULL(drvREF01_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D14','U_EKAIMAJ834_DrvTbl','ISNULL(drvREF01_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D15','U_EKAIMAJ834_DrvTbl','ISNULL(drvREF01_RefNumberQual3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D16','U_EKAIMAJ834_DrvTbl','ISNULL(drvREF01_RefNumberQual4,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D17','U_EKAIMAJ834_DrvTbl','ISNULL(drvDTP00_DateTime1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D18','U_EKAIMAJ834_DrvTbl','ISNULL(drvDTP00_DateTime2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D20','U_EKAIMAJ834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D21','U_EKAIMAJ834_DrvTbl','ISNULL(drvPER03_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER05_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER07_CommNumberQualifier,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D22','U_EKAIMAJ834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D23','U_EKAIMAJ834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D24','U_EKAIMAJ834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D25','U_EKAIMAJ834_DrvTbl','ISNULL(drvICM01_FrequencyCode,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D26','U_EKAIMAJ834_DrvTbl','ISNULL(drvAMT00_SegmentID1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D27','U_EKAIMAJ834_DrvTbl','ISNULL(drvAMT00_SegmentID2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D28','U_EKAIMAJ834_DrvTbl','ISNULL(drvHLH00_SegmentID,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D40','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D41','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_348,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D42','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_349,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D43','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_303,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D45','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D46','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D50','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D51','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D80','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvLS01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D81','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvLX01_AssignedNumber,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D85','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvN101_EntityIDCodeSponsor,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D86','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvREF01_RefNumberQual,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','D87','U_EKAIMAJ834_DrvTbl_2300','ISNULL(drvLE01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','T90','U_EKAIMAJ834_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','T91','U_EKAIMAJ834_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EKAIMAJ834','T92','U_EKAIMAJ834_TrlTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EKAIMAJ834
-----------

IF OBJECT_ID('U_dsi_BDM_EKAIMAJ834') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EKAIMAJ834] (
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
-- Create table U_EKAIMAJ834_Audit
-----------

IF OBJECT_ID('U_EKAIMAJ834_Audit') IS NULL
CREATE TABLE [dbo].[U_EKAIMAJ834_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EKAIMAJ834_AuditFields
-----------

IF OBJECT_ID('U_EKAIMAJ834_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EKAIMAJ834_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EKAIMAJ834_DedList
-----------

IF OBJECT_ID('U_EKAIMAJ834_DedList') IS NULL
CREATE TABLE [dbo].[U_EKAIMAJ834_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EKAIMAJ834_DrvTbl
-----------

IF OBJECT_ID('U_EKAIMAJ834_DrvTbl') IS NULL
CREATE TABLE [dbo].[U_EKAIMAJ834_DrvTbl] (
    [drvINS01_YesNoCond] varchar(1) NOT NULL,
    [drvINS02_RelationshipCode] varchar(2) NOT NULL,
    [drvINS03_MaintTypeCode] varchar(3) NOT NULL,
    [drvINS04_MaintReasonCode] varchar(2) NOT NULL,
    [drvINS05_BenefitStatusCode] varchar(1) NOT NULL,
    [drvINS0601_MEDICAREPLANCODE] varchar(1) NOT NULL,
    [drvINS0602_EligibilityRsnCode] varchar(1) NOT NULL,
    [drvINS07_COBRAQualEventCode] varchar(1) NOT NULL,
    [drvINS08_EmploymentStatusCode] varchar(2) NULL,
    [drvINS09_StudentStatusCode] varchar(1) NOT NULL,
    [drvINS10_ResponseCode] varchar(1) NULL,
    [drvINS11_DateTimeFormatQual] varchar(2) NULL,
    [drvINS12_DateTimePeriod] varchar(8) NULL,
    [drvREF01_RefNumberQual1] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual1] varchar(9) NOT NULL,
    [drvREF01_RefNumberQual2] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual2] char(9) NULL,
    [drvREF01_RefNumberQual3] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual3] varchar(4) NOT NULL,
    [drvREF01_RefNumberQual4] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual4] varchar(3) NOT NULL,
    [drvDTP00_DateTime1] varchar(3) NOT NULL,
    [drvDTP01_DateTimeQualifier1] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual1] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod1] datetime NULL,
    [drvDTP00_DateTime2] varchar(1) NOT NULL,
    [drvDTP01_DateTimeQualifier2] varchar(1) NOT NULL,
    [drvDTP02_DateTimeFormatQual2] varchar(1) NOT NULL,
    [drvDTP03_DateTimePeriod2] varchar(1) NOT NULL,
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
    [drvICM03_Quantity] money NULL,
    [drvICM04_LocationID] varchar(8) NULL,
    [drvAMT00_SegmentID1] varchar(1) NOT NULL,
    [drvAMT01_AmountQualifierCode1] varchar(1) NOT NULL,
    [drvAMT02_MonetaryAmount1] varchar(1) NOT NULL,
    [drvAMT00_SegmentID2] varchar(1) NOT NULL,
    [drvAMT01_AmountQualifierCode2] varchar(1) NOT NULL,
    [drvAMT02_MonetaryAmount2] varchar(1) NOT NULL,
    [drvHLH00_SegmentID] varchar(1) NOT NULL,
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
    [drvSubSort] char(21) NULL
);

-----------
-- Create table U_EKAIMAJ834_DrvTbl_2300
-----------

IF OBJECT_ID('U_EKAIMAJ834_DrvTbl_2300') IS NULL
CREATE TABLE [dbo].[U_EKAIMAJ834_DrvTbl_2300] (
    [drvHD00_HealthCoverage] varchar(2) NULL,
    [drvHD01_MaintTypeCode] varchar(3) NOT NULL,
    [drvHD02_MaintReasonCode] varchar(1) NULL,
    [drvHD03_InsuranceLineCode] varchar(3) NOT NULL,
    [drvHD04_PlanCoverageDesc] varchar(1) NULL,
    [drvHD05_CoverageLevelCode] varchar(3) NULL,
    [drvDTP00_DateTime_348] varchar(3) NULL,
    [drvDTP01_DateTimeQualifier_348] varchar(3) NULL,
    [drvDTP02_DateTimeFormatQual_348] varchar(2) NULL,
    [drvDTP03_DateTimePeriod_348] datetime NULL,
    [drvDTP00_DateTime_349] varchar(3) NULL,
    [drvDTP01_DateTimeQualifier_349] varchar(3) NULL,
    [drvDTP02_DateTimeFormatQual_349] varchar(2) NULL,
    [drvDTP03_DateTimePeriod_349] datetime NULL,
    [drvDTP00_DateTime_303] varchar(1) NULL,
    [drvDTP01_DateTimeQualifier_303] varchar(3) NULL,
    [drvDTP02_DateTimeFormatQual_303] varchar(2) NULL,
    [drvDTP03_DateTimePeriod_303] datetime NULL,
    [drvREF00_RefNumberQual1] varchar(1) NULL,
    [drvREF01_RefNumberQual1] varchar(1) NULL,
    [drvREF02_RefNumberQual1] varchar(1) NULL,
    [drvREF00_RefNumberQual2] varchar(1) NULL,
    [drvREF01_RefNumberQual2] varchar(1) NULL,
    [drvREF02_RefNumberQual2] varchar(1) NULL,
    [drvAMT00_AmountQualifierCode1] varchar(1) NULL,
    [drvAMT01_AmountQualifierCode1] varchar(1) NULL,
    [drvAMT02_MonetaryAmount1] varchar(1) NULL,
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
    [drvSubSort] varchar(22) NULL
);

-----------
-- Create table U_EKAIMAJ834_EEList
-----------

IF OBJECT_ID('U_EKAIMAJ834_EEList') IS NULL
CREATE TABLE [dbo].[U_EKAIMAJ834_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EKAIMAJ834_File
-----------

IF OBJECT_ID('U_EKAIMAJ834_File') IS NULL
CREATE TABLE [dbo].[U_EKAIMAJ834_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EKAIMAJ834_HdrTbl
-----------

IF OBJECT_ID('U_EKAIMAJ834_HdrTbl') IS NULL
CREATE TABLE [dbo].[U_EKAIMAJ834_HdrTbl] (
    [drvISA05_SenderIDQual] varchar(2) NOT NULL,
    [drvISA06_SenderID] varchar(9) NOT NULL,
    [drvISA07_ReceiverIDQual] varchar(2) NOT NULL,
    [drvISA08_ReceiverID] varchar(13) NOT NULL,
    [drvISA09_InterchangeDate] varchar(6) NULL,
    [drvISA10_InterchangeTime] varchar(4) NULL,
    [drvISA15_UsageIndicator] varchar(1) NOT NULL,
    [drvGS02_SenderID] varchar(9) NOT NULL,
    [drvGS03_ReceiverID] varchar(15) NOT NULL,
    [drvGS04_Date] varchar(8) NULL,
    [drvGS05_Time] varchar(4) NULL,
    [drvBGN03_Date] varchar(8) NULL,
    [drvBGN04_Time] varchar(4) NULL,
    [drvBGN05_TimeCode] varchar(1) NOT NULL,
    [drvBGN06_RefID] varchar(1) NOT NULL,
    [drvBGN07_TransTypeCode] varchar(1) NOT NULL,
    [drvBGN08_ActionCode] varchar(1) NOT NULL,
    [drvREF01_RefNumberQual] varchar(1) NOT NULL,
    [drvREF02_RefNumberQual] varchar(1) NOT NULL,
    [drvQTY01_QuantityQual1] varchar(2) NOT NULL,
    [drvQTY02_Quantity1] int NULL,
    [drvQTY01_QuantityQual2] varchar(2) NOT NULL,
    [drvQTY02_Quantity2] int NULL,
    [drvQTY01_QuantityQual3] varchar(2) NOT NULL,
    [drvQTY02_Quantity3] int NULL,
    [drvN101_EntityIDCodeSponsor1] varchar(2) NOT NULL,
    [drvN102_Name1] varchar(22) NOT NULL,
    [drvN103_IDCodeQual1] varchar(2) NOT NULL,
    [drvN104_IDCode1] varchar(9) NOT NULL,
    [drvN101_EntityIDCodeSponsor2] varchar(2) NOT NULL,
    [drvN102_Name2] varchar(17) NOT NULL,
    [drvN103_IDCodeQual2] varchar(2) NOT NULL,
    [drvN104_IDCode2] varchar(10) NOT NULL
);

-----------
-- Create table U_EKAIMAJ834_TrlTbl
-----------

IF OBJECT_ID('U_EKAIMAJ834_TrlTbl') IS NULL
CREATE TABLE [dbo].[U_EKAIMAJ834_TrlTbl] (
    [drvSE01_SegmentCount] varchar(4) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EKAIMAJ834]
AS
SET NOCOUNT ON;
/************************************************************
Client: Majestic Steel

Created By: Andy Pineda
Create Date: 01/10/2022
ChangePoint Request Number: TekP-2021-10-12-0001

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
    WHILE (SELECT COUNT(*) FROM dbo.U_EKAIMAJ834_File WHERE RIGHT(DATA,2) = '*~') > 0
    BEGIN
        UPDATE dbo.U_EKAIMAJ834_File SET DATA = REPLACE(DATA,'*~','~') WHERE RIGHT(RTRIM(DATA),2) = '*~';
    END;

    --========================================
    -- Remove Extra Records from PER Segment
    --========================================
    UPDATE dbo.U_EKAIMAJ834_File SET DATA = REPLACE(DATA,'HP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%HP**%';
    UPDATE dbo.U_EKAIMAJ834_File SET DATA = REPLACE(DATA,'WP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%WP**%';
    UPDATE dbo.U_EKAIMAJ834_File SET DATA = REPLACE(DATA,'EM**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%EM**%';

    --====================================
    -- Update Record Count in SE Segment
    --====================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_EKAIMAJ834_File WHERE LEFT(Data, CHARINDEX('*',Data) - 1) NOT IN ('ISA','GS','IEA','GE'));

    UPDATE dbo.U_EKAIMAJ834_File
    SET Data = REPLACE(Data,'9999',@RecordCount)
    WHERE LEFT(Data,2) = 'SE';

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EKAIMAJ834]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Majestic Steel

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 01/10/2022
Service Request Number: TekP-2021-10-12-0001

Purpose: Kaiser 834 Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EKAIMAJ834';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EKAIMAJ834';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EKAIMAJ834';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EKAIMAJ834';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EKAIMAJ834' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EKAIMAJ834', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EKAIMAJ834', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EKAIMAJ834', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EKAIMAJ834', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EKAIMAJ834', 'SCH_KAI834';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EKAIMAJ834';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EKAIMAJ834', @AllObjects = 'Y', @IsWeb = 'Y';
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
        ,@FileMinCovDate  = CAST('10/01/2021' as DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EKAIMAJ834';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'MDK00, MDK15';

    IF OBJECT_ID('U_EKAIMAJ834_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EKAIMAJ834_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EKAIMAJ834_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EKAIMAJ834_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EKAIMAJ834_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_EKAIMAJ834_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EKAIMAJ834_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);

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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC');
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
    FROM dbo.U_dsi_bdm_EKAIMAJ834 D
    JOIN dbo.U_dsi_bdm_EKAIMAJ834 E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EKAIMAJ834
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EKAIMAJ834
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EKAIMAJ834
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EKAIMAJ834
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EKAIMAJ834
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EKAIMAJ834
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    --Code for "terminations sent one time only". One time means sent one time during the per control range.

--Audit Table
    IF OBJECT_ID('U_EKAIMAJ834_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EKAIMAJ834_AuditFields;
    CREATE TABLE dbo.U_EKAIMAJ834_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EKAIMAJ834_AuditFields VALUES ('Empcomp','EecEmplStatus');    
    -- Create audit table
    IF OBJECT_ID('U_EKAIMAJ834_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EKAIMAJ834_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EKAIMAJ834_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EKAIMAJ834_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EKAIMAJ834_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EKAIMAJ834_Audit ON dbo.U_EKAIMAJ834_Audit (audKey1Value, audKey2Value);

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
    IF OBJECT_ID('U_EKAIMAJ834_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EKAIMAJ834_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = '30'
        ,drvISA06_SenderID = '341289145'
        ,drvISA07_ReceiverIDQual = 'ZZ'
        ,drvISA08_ReceiverID = '076011108LCSP'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = '341289145'
        ,drvGS03_ReceiverID = 'GCAMAGESTICSGRP'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = ''
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = '4'
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberQual = ''
        ,drvQTY01_QuantityQual1 = 'ET'
        ,drvQTY02_Quantity1 = (SELECT COUNT(DISTINCT(BdmEEID)) FROM dbo.U_dsi_bdm_EKAIMAJ834 WITH(NOLOCK) WHERE BdmRecType = 'EMP')
        ,drvQTY01_QuantityQual2 = 'DT'
        ,drvQTY02_Quantity2 = (SELECT COUNT(DISTINCT(BdmDepRecID)) FROM dbo.U_dsi_bdm_EKAIMAJ834 WITH(NOLOCK) WHERE BdmRecType = 'DEP')
        ,drvQTY01_QuantityQual3 = 'TO'
        ,drvQTY02_Quantity3 = (SELECT COUNT(DISTINCT(BdmEEID)) FROM dbo.U_dsi_bdm_EKAIMAJ834 WITH(NOLOCK) WHERE BdmRecType = 'EMP') + (SELECT COUNT(DISTINCT(BdmDepRecID)) FROM dbo.U_dsi_bdm_EKAIMAJ834 WITH(NOLOCK) WHERE BdmRecType = 'DEP')
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'Majestic Steel USA Inc'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = '341289145'
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'Kaiser Permanente'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '94-1340523'
    INTO dbo.U_EKAIMAJ834_HdrTbl
    FROM dbo.U_EKAIMAJ834_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_EKAIMAJ834 WITH (NOLOCK)
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
    IF OBJECT_ID('U_EKAIMAJ834_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EKAIMAJ834_DrvTbl;
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
                                                     WHEN ConRelationship IN ('CHL', 'DPC', 'STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode = '030' --Audit or Compare
        ,drvINS04_MaintReasonCode = 'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = CASE WHEN BdmRecType = 'EMP' THEN
                                              --  CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
                                                CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
                                                     WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
                                                END
                                         END
        ,drvINS09_StudentStatusCode = 'N'
        ,drvINS10_ResponseCode = CASE
                                      WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN ConIsDisabled = 'Y' AND DATEDIFF(YEAR, ConDateOfBirth, BdmBenStartDate) >= 26 THEN 'Y'
                                             ELSE 'N'
                                        END
                                END
        ,drvINS11_DateTimeFormatQual = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN 'D8' END
        ,drvINS12_DateTimePeriod = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) END
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = '1L'
        ,drvREF02_RefNumberQual1 = CASE WHEN EepAddressZipCode IN ('93230', '93232', '93242', '93601', '93602', '93604', '93606',
                                            '93607', '93609', '93611', '93612',
                                            '93613',
                                            '93614',
                                            '93616',
                                            '93618',
                                            '93619',
                                            '93623',
                                            '93624',
                                            '93625',
                                            '93626',
                                            '93627',
                                            '93630',
                                            '93631',
                                            '93636',
                                            '93637',
                                            '93638',
                                            '93639',
                                            '93643',
                                            '93644',
                                            '93645',
                                            '93646',
                                            '93648',
                                            '93649',
                                            '93650',
                                            '93651',
                                            '93652',
                                            '93653',
                                            '93654',
                                            '93656',
                                            '93657',
                                            '93660',
                                            '93662',
                                            '93666',
                                            '93667',
                                            '93668',
                                            '93669',
                                            '93673',
                                            '93675',
                                            '93701',
                                            '93702',
                                            '93703',
                                            '93704',
                                            '93705',
                                            '93706',
                                            '93707',
                                            '93708',
                                            '93709',
                                            '93710',
                                            '93711',
                                            '93712',
                                            '93714',
                                            '93715',
                                            '93716',
                                            '93717',
                                            '93718',
                                            '93720',
                                            '93721',
                                            '93722',
                                            '93723',
                                            '93724',
                                            '93725',
                                            '93726',
                                            '93727',
                                            '93728',
                                            '93729',
                                            '93730',
                                            '93737',
                                            '93740',
                                            '93741',
                                            '93744',
                                            '93745',
                                            '93747',
                                            '93750',
                                            '93755',
                                            '93760',
                                            '93761',
                                            '93764',
                                            '93765',
                                            '93771',
                                            '93772',
                                            '93773',
                                            '93774',
                                            '93775',
                                            '93776',
                                            '93777',
                                            '93778',
                                            '93779',
                                            '93786',
                                            '93790',
                                            '93791',
                                            '93792',
                                            '93793',
                                            '93794',
                                            '93844',
                                            '93888',
                                            '94002',
                                            '94005',
                                            '94010',
                                            '94011',
                                            '94014',
                                            '94015',
                                            '94016',
                                            '94017',
                                            '94018',
                                            '94019',
                                            '94020',
                                            '94021',
                                            '94022',
                                            '94023',
                                            '94024',
                                            '94025',
                                            '94026',
                                            '94027',
                                            '94028',
                                            '94030',
                                            '94035',
                                            '94037',
                                            '94038',
                                            '94039',
                                            '94040',
                                            '94041',
                                            '94042',
                                            '94043',
                                            '94044',
                                            '94060',
                                            '94061',
                                            '94062',
                                            '94063',
                                            '94064',
                                            '94065',
                                            '94066',
                                            '94070',
                                            '94074',
                                            '94080',
                                            '94083',
                                            '94085',
                                            '94086',
                                            '94087',
                                            '94088',
                                            '94089',
                                            '94102',
                                            '94103',
                                            '94104',
                                            '94105',
                                            '94107',
                                            '94108',
                                            '94109',
                                            '94110',
                                            '94111',
                                            '94112',
                                            '94114',
                                            '94115',
                                            '94116',
                                            '94117',
                                            '94118',
                                            '94119',
                                            '94120',
                                            '94121',
                                            '94122',
                                            '94123',
                                            '94124',
                                            '94125',
                                            '94126',
                                            '94127',
                                            '94128',
                                            '94129',
                                            '94130',
                                            '94131',
                                            '94132',
                                            '94133',
                                            '94134',
                                            '94137',
                                            '94139',
                                            '94140',
                                            '94141',
                                            '94142',
                                            '94143',
                                            '94144',
                                            '94145',
                                            '94146',
                                            '94147',
                                            '94151',
                                            '94158',
                                            '94159',
                                            '94160',
                                            '94161',
                                            '94163',
                                            '94164',
                                            '94172',
                                            '94177',
                                            '94188',
                                            '94203',
                                            '94204',
                                            '94205',
                                            '94206',
                                            '94207',
                                            '94208',
                                            '94209',
                                            '94211',
                                            '94229',
                                            '94230',
                                            '94232',
                                            '94234',
                                            '94235',
                                            '94236',
                                            '94237',
                                            '94239',
                                            '94240',
                                            '94244',
                                            '94247',
                                            '94248',
                                            '94249',
                                            '94250',
                                            '94252',
                                            '94254',
                                            '94256',
                                            '94257',
                                            '94258',
                                            '94259',
                                            '94261',
                                            '94262',
                                            '94263',
                                            '94267',
                                            '94268',
                                            '94269',
                                            '94271',
                                            '94273',
                                            '94274',
                                            '94277',
                                            '94278',
                                            '94279',
                                            '94280',
                                            '94282',
                                            '94283',
                                            '94284',
                                            '94285',
                                            '94287',
                                            '94288',
                                            '94289',
                                            '94290',
                                            '94291',
                                            '94293',
                                            '94294',
                                            '94295',
                                            '94296',
                                            '94297',
                                            '94298',
                                            '94301',
                                            '94302',
                                            '94303',
                                            '94304',
                                            '94305',
                                            '94306',
                                            '94309',
                                            '94401',
                                            '94402',
                                            '94403',
                                            '94404',
                                            '94497',
                                            '94501',
                                            '94502',
                                            '94503',
                                            '94505',
                                            '94506',
                                            '94507',
                                            '94508',
                                            '94509',
                                            '94510',
                                            '94511',
                                            '94512',
                                            '94513',
                                            '94514',
                                            '94515',
                                            '94516',
                                            '94517',
                                            '94518',
                                            '94519',
                                            '94520',
                                            '94521',
                                            '94522',
                                            '94523',
                                            '94524',
                                            '94525',
                                            '94526',
                                            '94527',
                                            '94528',
                                            '94529',
                                            '94530',
                                            '94531',
                                            '94533',
                                            '94534',
                                            '94535',
                                            '94536',
                                            '94537',
                                            '94538',
                                            '94539',
                                            '94540',
                                            '94541',
                                            '94542',
                                            '94543',
                                            '94544',
                                            '94545',
                                            '94546',
                                            '94547',
                                            '94548',
                                            '94549',
                                            '94550',
                                            '94551',
                                            '94552',
                                            '94553',
                                            '94555',
                                            '94556',
                                            '94557',
                                            '94558',
                                            '94559',
                                            '94560',
                                            '94561',
                                            '94562',
                                            '94563',
                                            '94564',
                                            '94565',
                                            '94566',
                                            '94567',
                                            '94568',
                                            '94569',
                                            '94570',
                                            '94571',
                                            '94572',
                                            '94573',
                                            '94574',
                                            '94575',
                                            '94576',
                                            '94577',
                                            '94578',
                                            '94579',
                                            '94580',
                                            '94581',
                                            '94582',
                                            '94583',
                                            '94585',
                                            '94586',
                                            '94587',
                                            '94588',
                                            '94589',
                                            '94590',
                                            '94591',
                                            '94592',
                                            '94595',
                                            '94596',
                                            '94597',
                                            '94598',
                                            '94599',
                                            '94601',
                                            '94602',
                                            '94603',
                                            '94604',
                                            '94605',
                                            '94606',
                                            '94607',
                                            '94608',
                                            '94609',
                                            '94610',
                                            '94611',
                                            '94612',
                                            '94613',
                                            '94614',
                                            '94615',
                                            '94617',
                                            '94618',
                                            '94619',
                                            '94620',
                                            '94621',
                                            '94622',
                                            '94623',
                                            '94624',
                                            '94649',
                                            '94659',
                                            '94660',
                                            '94661',
                                            '94662',
                                            '94666',
                                            '94701',
                                            '94702',
                                            '94703',
                                            '94704',
                                            '94705',
                                            '94706',
                                            '94707',
                                            '94708',
                                            '94709',
                                            '94710',
                                            '94712',
                                            '94720',
                                            '94801',
                                            '94802',
                                            '94803',
                                            '94804',
                                            '94805',
                                            '94806',
                                            '94807',
                                            '94808',
                                            '94820',
                                            '94850',
                                            '94901',
                                            '94903',
                                            '94904',
                                            '94912',
                                            '94913',
                                            '94914',
                                            '94915',
                                            '94920',
                                            '94922',
                                            '94923',
                                            '94924',
                                            '94925',
                                            '94926',
                                            '94927',
                                            '94928',
                                            '94929',
                                            '94930',
                                            '94931',
                                            '94933',
                                            '94937',
                                            '94938',
                                            '94939',
                                            '94940',
                                            '94941',
                                            '94942',
                                            '94945',
                                            '94946',
                                            '94947',
                                            '94948',
                                            '94949',
                                            '94950',
                                            '94951',
                                            '94952',
                                            '94953',
                                            '94954',
                                            '94955',
                                            '94956',
                                            '94957',
                                            '94960',
                                            '94963',
                                            '94964',
                                            '94965',
                                            '94966',
                                            '94970',
                                            '94971',
                                            '94972',
                                            '94973',
                                            '94974',
                                            '94975',
                                            '94976',
                                            '94977',
                                            '94978',
                                            '94979',
                                            '94999',
                                            '95001',
                                            '95002',
                                            '95003',
                                            '95005',
                                            '95006',
                                            '95007',
                                            '95008',
                                            '95009',
                                            '95010',
                                            '95011',
                                            '95013',
                                            '95014',
                                            '95015',
                                            '95017',
                                            '95018',
                                            '95019',
                                            '95020',
                                            '95021',
                                            '95026',
                                            '95030',
                                            '95031',
                                            '95032',
                                            '95033',
                                            '95035',
                                            '95036',
                                            '95037',
                                            '95038',
                                            '95041',
                                            '95042',
                                            '95044',
                                            '95046',
                                            '95050',
                                            '95051',
                                            '95052',
                                            '95053',
                                            '95054',
                                            '95055',
                                            '95056',
                                            '95060',
                                            '95061',
                                            '95062',
                                            '95063',
                                            '95064',
                                            '95065',
                                            '95066',
                                            '95067',
                                            '95070',
                                            '95071',
                                            '95073',
                                            '95076',
                                            '95077',
                                            '95101',
                                            '95103',
                                            '95106',
                                            '95108',
                                            '95109',
                                            '95110',
                                            '95111',
                                            '95112',
                                            '95113',
                                            '95115',
                                            '95116',
                                            '95117',
                                            '95118',
                                            '95119',
                                            '95120',
                                            '95121',
                                            '95122',
                                            '95123',
                                            '95124',
                                            '95125',
                                            '95126',
                                            '95127',
                                            '95128',
                                            '95129',
                                            '95130',
                                            '95131',
                                            '95132',
                                            '95133',
                                            '95134',
                                            '95135',
                                            '95136',
                                            '95138',
                                            '95139',
                                            '95140',
                                            '95141',
                                            '95148',
                                            '95150',
                                            '95151',
                                            '95152',
                                            '95153',
                                            '95154',
                                            '95155',
                                            '95156',
                                            '95157',
                                            '95158',
                                            '95159',
                                            '95160',
                                            '95161',
                                            '95164',
                                            '95170',
                                            '95172',
                                            '95173',
                                            '95190',
                                            '95191',
                                            '95192',
                                            '95193',
                                            '95194',
                                            '95196',
                                            '95201',
                                            '95202',
                                            '95203',
                                            '95204',
                                            '95205',
                                            '95206',
                                            '95207',
                                            '95208',
                                            '95209',
                                            '95210',
                                            '95211',
                                            '95212',
                                            '95213',
                                            '95214',
                                            '95215',
                                            '95219',
                                            '95220',
                                            '95227',
                                            '95230',
                                            '95231',
                                            '95234',
                                            '95236',
                                            '95237',
                                            '95240',
                                            '95241',
                                            '95242',
                                            '95253',
                                            '95258',
                                            '95267',
                                            '95269',
                                            '95296',
                                            '95297',
                                            '95304',
                                            '95307',
                                            '95313',
                                            '95316',
                                            '95319',
                                            '95320',
                                            '95322',
                                            '95323',
                                            '95326',
                                            '95328',
                                            '95329',
                                            '95330',
                                            '95336',
                                            '95337',
                                            '95350',
                                            '95351',
                                            '95352',
                                            '95353',
                                            '95354',
                                            '95355',
                                            '95356',
                                            '95357',
                                            '95358',
                                            '95360',
                                            '95361',
                                            '95363',
                                            '95366',
                                            '95367',
                                            '95368',
                                            '95376',
                                            '95377',
                                            '95378',
                                            '95380',
                                            '95381',
                                            '95382',
                                            '95385',
                                            '95386',
                                            '95387',
                                            '95391',
                                            '95397',
                                            '95401',
                                            '95402',
                                            '95403',
                                            '95404',
                                            '95405',
                                            '95406',
                                            '95407',
                                            '95409',
                                            '95416',
                                            '95419',
                                            '95421',
                                            '95425',
                                            '95430',
                                            '95431',
                                            '95433',
                                            '95436',
                                            '95439',
                                            '95441',
                                            '95442',
                                            '95444',
                                            '95446',
                                            '95448',
                                            '95450',
                                            '95452',
                                            '95462',
                                            '95465',
                                            '95471',
                                            '95472',
                                            '95473',
                                            '95476',
                                            '95486',
                                            '95487',
                                            '95492',
                                            '95602',
                                            '95603',
                                            '95604',
                                            '95605',
                                            '95607',
                                            '95608',
                                            '95609',
                                            '95610',
                                            '95611',
                                            '95612',
                                            '95613',
                                            '95614',
                                            '95615',
                                            '95616',
                                            '95617',
                                            '95618',
                                            '95619',
                                            '95620',
                                            '95621',
                                            '95623',
                                            '95624',
                                            '95625',
                                            '95626',
                                            '95628',
                                            '95630',
                                            '95632',
                                            '95633',
                                            '95634',
                                            '95635',
                                            '95638',
                                            '95639',
                                            '95640',
                                            '95641',
                                            '95645',
                                            '95648',
                                            '95650',
                                            '95651',
                                            '95652',
                                            '95655',
                                            '95658',
                                            '95659',
                                            '95660',
                                            '95661',
                                            '95662',
                                            '95663',
                                            '95664',
                                            '95667',
                                            '95668',
                                            '95669',
                                            '95670',
                                            '95671',
                                            '95672',
                                            '95673',
                                            '95674',
                                            '95676',
                                            '95677',
                                            '95678',
                                            '95680',
                                            '95681',
                                            '95682',
                                            '95683',
                                            '95686',
                                            '95687',
                                            '95688',
                                            '95690',
                                            '95691',
                                            '95692',
                                            '95693',
                                            '95694',
                                            '95695',
                                            '95696',
                                            '95697',
                                            '95698',
                                            '95703',
                                            '95722',
                                            '95736',
                                            '95741',
                                            '95742',
                                            '95746',
                                            '95747',
                                            '95757',
                                            '95758',
                                            '95759',
                                            '95762',
                                            '95763',
                                            '95765',
                                            '95776',
                                            '95798',
                                            '95799',
                                            '95811',
                                            '95812',
                                            '95813',
                                            '95814',
                                            '95815',
                                            '95816',
                                            '95817',
                                            '95818',
                                            '95819',
                                            '95820',
                                            '95821',
                                            '95822',
                                            '95823',
                                            '95824',
                                            '95825',
                                            '95826',
                                            '95827',
                                            '95828',
                                            '95829',
                                            '95830',
                                            '95831',
                                            '95832',
                                            '95833',
                                            '95834',
                                            '95835',
                                            '95836',
                                            '95837',
                                            '95838',
                                            '95840',
                                            '95841',
                                            '95842',
                                            '95843',
                                            '95851',
                                            '95852',
                                            '95853',
                                            '95860',
                                            '95864',
                                            '95865',
                                            '95866',
                                            '95867',
                                            '95894',
                                            '95899',
                                            '95903',
                                            '95961') THEN '000607168' ELSE '000235507' END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = '23'
        ,drvREF02_RefNumberQual2 = EecEmpNo
        -- If drvREF01_RefNumberQual3 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual3 = 'DX'
        ,drvREF02_RefNumberQual3 = CASE WHEN BdmDedCode = 'MDK00' THEN '0000'
                                        ELSE '0001' END
        -- If drvREF01_RefNumberQual4 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual4 = 'ZZ'
        ,drvREF02_RefNumberQual4 = CASE WHEN EepAddressZipCode IN ('93230', '93232', '93242', '93601', '93602', '93604', '93606',
                                            '93607', '93609', '93611', '93612',
                                            '93613',
                                            '93614',
                                            '93616',
                                            '93618',
                                            '93619',
                                            '93623',
                                            '93624',
                                            '93625',
                                            '93626',
                                            '93627',
                                            '93630',
                                            '93631',
                                            '93636',
                                            '93637',
                                            '93638',
                                            '93639',
                                            '93643',
                                            '93644',
                                            '93645',
                                            '93646',
                                            '93648',
                                            '93649',
                                            '93650',
                                            '93651',
                                            '93652',
                                            '93653',
                                            '93654',
                                            '93656',
                                            '93657',
                                            '93660',
                                            '93662',
                                            '93666',
                                            '93667',
                                            '93668',
                                            '93669',
                                            '93673',
                                            '93675',
                                            '93701',
                                            '93702',
                                            '93703',
                                            '93704',
                                            '93705',
                                            '93706',
                                            '93707',
                                            '93708',
                                            '93709',
                                            '93710',
                                            '93711',
                                            '93712',
                                            '93714',
                                            '93715',
                                            '93716',
                                            '93717',
                                            '93718',
                                            '93720',
                                            '93721',
                                            '93722',
                                            '93723',
                                            '93724',
                                            '93725',
                                            '93726',
                                            '93727',
                                            '93728',
                                            '93729',
                                            '93730',
                                            '93737',
                                            '93740',
                                            '93741',
                                            '93744',
                                            '93745',
                                            '93747',
                                            '93750',
                                            '93755',
                                            '93760',
                                            '93761',
                                            '93764',
                                            '93765',
                                            '93771',
                                            '93772',
                                            '93773',
                                            '93774',
                                            '93775',
                                            '93776',
                                            '93777',
                                            '93778',
                                            '93779',
                                            '93786',
                                            '93790',
                                            '93791',
                                            '93792',
                                            '93793',
                                            '93794',
                                            '93844',
                                            '93888',
                                            '94002',
                                            '94005',
                                            '94010',
                                            '94011',
                                            '94014',
                                            '94015',
                                            '94016',
                                            '94017',
                                            '94018',
                                            '94019',
                                            '94020',
                                            '94021',
                                            '94022',
                                            '94023',
                                            '94024',
                                            '94025',
                                            '94026',
                                            '94027',
                                            '94028',
                                            '94030',
                                            '94035',
                                            '94037',
                                            '94038',
                                            '94039',
                                            '94040',
                                            '94041',
                                            '94042',
                                            '94043',
                                            '94044',
                                            '94060',
                                            '94061',
                                            '94062',
                                            '94063',
                                            '94064',
                                            '94065',
                                            '94066',
                                            '94070',
                                            '94074',
                                            '94080',
                                            '94083',
                                            '94085',
                                            '94086',
                                            '94087',
                                            '94088',
                                            '94089',
                                            '94102',
                                            '94103',
                                            '94104',
                                            '94105',
                                            '94107',
                                            '94108',
                                            '94109',
                                            '94110',
                                            '94111',
                                            '94112',
                                            '94114',
                                            '94115',
                                            '94116',
                                            '94117',
                                            '94118',
                                            '94119',
                                            '94120',
                                            '94121',
                                            '94122',
                                            '94123',
                                            '94124',
                                            '94125',
                                            '94126',
                                            '94127',
                                            '94128',
                                            '94129',
                                            '94130',
                                            '94131',
                                            '94132',
                                            '94133',
                                            '94134',
                                            '94137',
                                            '94139',
                                            '94140',
                                            '94141',
                                            '94142',
                                            '94143',
                                            '94144',
                                            '94145',
                                            '94146',
                                            '94147',
                                            '94151',
                                            '94158',
                                            '94159',
                                            '94160',
                                            '94161',
                                            '94163',
                                            '94164',
                                            '94172',
                                            '94177',
                                            '94188',
                                            '94203',
                                            '94204',
                                            '94205',
                                            '94206',
                                            '94207',
                                            '94208',
                                            '94209',
                                            '94211',
                                            '94229',
                                            '94230',
                                            '94232',
                                            '94234',
                                            '94235',
                                            '94236',
                                            '94237',
                                            '94239',
                                            '94240',
                                            '94244',
                                            '94247',
                                            '94248',
                                            '94249',
                                            '94250',
                                            '94252',
                                            '94254',
                                            '94256',
                                            '94257',
                                            '94258',
                                            '94259',
                                            '94261',
                                            '94262',
                                            '94263',
                                            '94267',
                                            '94268',
                                            '94269',
                                            '94271',
                                            '94273',
                                            '94274',
                                            '94277',
                                            '94278',
                                            '94279',
                                            '94280',
                                            '94282',
                                            '94283',
                                            '94284',
                                            '94285',
                                            '94287',
                                            '94288',
                                            '94289',
                                            '94290',
                                            '94291',
                                            '94293',
                                            '94294',
                                            '94295',
                                            '94296',
                                            '94297',
                                            '94298',
                                            '94301',
                                            '94302',
                                            '94303',
                                            '94304',
                                            '94305',
                                            '94306',
                                            '94309',
                                            '94401',
                                            '94402',
                                            '94403',
                                            '94404',
                                            '94497',
                                            '94501',
                                            '94502',
                                            '94503',
                                            '94505',
                                            '94506',
                                            '94507',
                                            '94508',
                                            '94509',
                                            '94510',
                                            '94511',
                                            '94512',
                                            '94513',
                                            '94514',
                                            '94515',
                                            '94516',
                                            '94517',
                                            '94518',
                                            '94519',
                                            '94520',
                                            '94521',
                                            '94522',
                                            '94523',
                                            '94524',
                                            '94525',
                                            '94526',
                                            '94527',
                                            '94528',
                                            '94529',
                                            '94530',
                                            '94531',
                                            '94533',
                                            '94534',
                                            '94535',
                                            '94536',
                                            '94537',
                                            '94538',
                                            '94539',
                                            '94540',
                                            '94541',
                                            '94542',
                                            '94543',
                                            '94544',
                                            '94545',
                                            '94546',
                                            '94547',
                                            '94548',
                                            '94549',
                                            '94550',
                                            '94551',
                                            '94552',
                                            '94553',
                                            '94555',
                                            '94556',
                                            '94557',
                                            '94558',
                                            '94559',
                                            '94560',
                                            '94561',
                                            '94562',
                                            '94563',
                                            '94564',
                                            '94565',
                                            '94566',
                                            '94567',
                                            '94568',
                                            '94569',
                                            '94570',
                                            '94571',
                                            '94572',
                                            '94573',
                                            '94574',
                                            '94575',
                                            '94576',
                                            '94577',
                                            '94578',
                                            '94579',
                                            '94580',
                                            '94581',
                                            '94582',
                                            '94583',
                                            '94585',
                                            '94586',
                                            '94587',
                                            '94588',
                                            '94589',
                                            '94590',
                                            '94591',
                                            '94592',
                                            '94595',
                                            '94596',
                                            '94597',
                                            '94598',
                                            '94599',
                                            '94601',
                                            '94602',
                                            '94603',
                                            '94604',
                                            '94605',
                                            '94606',
                                            '94607',
                                            '94608',
                                            '94609',
                                            '94610',
                                            '94611',
                                            '94612',
                                            '94613',
                                            '94614',
                                            '94615',
                                            '94617',
                                            '94618',
                                            '94619',
                                            '94620',
                                            '94621',
                                            '94622',
                                            '94623',
                                            '94624',
                                            '94649',
                                            '94659',
                                            '94660',
                                            '94661',
                                            '94662',
                                            '94666',
                                            '94701',
                                            '94702',
                                            '94703',
                                            '94704',
                                            '94705',
                                            '94706',
                                            '94707',
                                            '94708',
                                            '94709',
                                            '94710',
                                            '94712',
                                            '94720',
                                            '94801',
                                            '94802',
                                            '94803',
                                            '94804',
                                            '94805',
                                            '94806',
                                            '94807',
                                            '94808',
                                            '94820',
                                            '94850',
                                            '94901',
                                            '94903',
                                            '94904',
                                            '94912',
                                            '94913',
                                            '94914',
                                            '94915',
                                            '94920',
                                            '94922',
                                            '94923',
                                            '94924',
                                            '94925',
                                            '94926',
                                            '94927',
                                            '94928',
                                            '94929',
                                            '94930',
                                            '94931',
                                            '94933',
                                            '94937',
                                            '94938',
                                            '94939',
                                            '94940',
                                            '94941',
                                            '94942',
                                            '94945',
                                            '94946',
                                            '94947',
                                            '94948',
                                            '94949',
                                            '94950',
                                            '94951',
                                            '94952',
                                            '94953',
                                            '94954',
                                            '94955',
                                            '94956',
                                            '94957',
                                            '94960',
                                            '94963',
                                            '94964',
                                            '94965',
                                            '94966',
                                            '94970',
                                            '94971',
                                            '94972',
                                            '94973',
                                            '94974',
                                            '94975',
                                            '94976',
                                            '94977',
                                            '94978',
                                            '94979',
                                            '94999',
                                            '95001',
                                            '95002',
                                            '95003',
                                            '95005',
                                            '95006',
                                            '95007',
                                            '95008',
                                            '95009',
                                            '95010',
                                            '95011',
                                            '95013',
                                            '95014',
                                            '95015',
                                            '95017',
                                            '95018',
                                            '95019',
                                            '95020',
                                            '95021',
                                            '95026',
                                            '95030',
                                            '95031',
                                            '95032',
                                            '95033',
                                            '95035',
                                            '95036',
                                            '95037',
                                            '95038',
                                            '95041',
                                            '95042',
                                            '95044',
                                            '95046',
                                            '95050',
                                            '95051',
                                            '95052',
                                            '95053',
                                            '95054',
                                            '95055',
                                            '95056',
                                            '95060',
                                            '95061',
                                            '95062',
                                            '95063',
                                            '95064',
                                            '95065',
                                            '95066',
                                            '95067',
                                            '95070',
                                            '95071',
                                            '95073',
                                            '95076',
                                            '95077',
                                            '95101',
                                            '95103',
                                            '95106',
                                            '95108',
                                            '95109',
                                            '95110',
                                            '95111',
                                            '95112',
                                            '95113',
                                            '95115',
                                            '95116',
                                            '95117',
                                            '95118',
                                            '95119',
                                            '95120',
                                            '95121',
                                            '95122',
                                            '95123',
                                            '95124',
                                            '95125',
                                            '95126',
                                            '95127',
                                            '95128',
                                            '95129',
                                            '95130',
                                            '95131',
                                            '95132',
                                            '95133',
                                            '95134',
                                            '95135',
                                            '95136',
                                            '95138',
                                            '95139',
                                            '95140',
                                            '95141',
                                            '95148',
                                            '95150',
                                            '95151',
                                            '95152',
                                            '95153',
                                            '95154',
                                            '95155',
                                            '95156',
                                            '95157',
                                            '95158',
                                            '95159',
                                            '95160',
                                            '95161',
                                            '95164',
                                            '95170',
                                            '95172',
                                            '95173',
                                            '95190',
                                            '95191',
                                            '95192',
                                            '95193',
                                            '95194',
                                            '95196',
                                            '95201',
                                            '95202',
                                            '95203',
                                            '95204',
                                            '95205',
                                            '95206',
                                            '95207',
                                            '95208',
                                            '95209',
                                            '95210',
                                            '95211',
                                            '95212',
                                            '95213',
                                            '95214',
                                            '95215',
                                            '95219',
                                            '95220',
                                            '95227',
                                            '95230',
                                            '95231',
                                            '95234',
                                            '95236',
                                            '95237',
                                            '95240',
                                            '95241',
                                            '95242',
                                            '95253',
                                            '95258',
                                            '95267',
                                            '95269',
                                            '95296',
                                            '95297',
                                            '95304',
                                            '95307',
                                            '95313',
                                            '95316',
                                            '95319',
                                            '95320',
                                            '95322',
                                            '95323',
                                            '95326',
                                            '95328',
                                            '95329',
                                            '95330',
                                            '95336',
                                            '95337',
                                            '95350',
                                            '95351',
                                            '95352',
                                            '95353',
                                            '95354',
                                            '95355',
                                            '95356',
                                            '95357',
                                            '95358',
                                            '95360',
                                            '95361',
                                            '95363',
                                            '95366',
                                            '95367',
                                            '95368',
                                            '95376',
                                            '95377',
                                            '95378',
                                            '95380',
                                            '95381',
                                            '95382',
                                            '95385',
                                            '95386',
                                            '95387',
                                            '95391',
                                            '95397',
                                            '95401',
                                            '95402',
                                            '95403',
                                            '95404',
                                            '95405',
                                            '95406',
                                            '95407',
                                            '95409',
                                            '95416',
                                            '95419',
                                            '95421',
                                            '95425',
                                            '95430',
                                            '95431',
                                            '95433',
                                            '95436',
                                            '95439',
                                            '95441',
                                            '95442',
                                            '95444',
                                            '95446',
                                            '95448',
                                            '95450',
                                            '95452',
                                            '95462',
                                            '95465',
                                            '95471',
                                            '95472',
                                            '95473',
                                            '95476',
                                            '95486',
                                            '95487',
                                            '95492',
                                            '95602',
                                            '95603',
                                            '95604',
                                            '95605',
                                            '95607',
                                            '95608',
                                            '95609',
                                            '95610',
                                            '95611',
                                            '95612',
                                            '95613',
                                            '95614',
                                            '95615',
                                            '95616',
                                            '95617',
                                            '95618',
                                            '95619',
                                            '95620',
                                            '95621',
                                            '95623',
                                            '95624',
                                            '95625',
                                            '95626',
                                            '95628',
                                            '95630',
                                            '95632',
                                            '95633',
                                            '95634',
                                            '95635',
                                            '95638',
                                            '95639',
                                            '95640',
                                            '95641',
                                            '95645',
                                            '95648',
                                            '95650',
                                            '95651',
                                            '95652',
                                            '95655',
                                            '95658',
                                            '95659',
                                            '95660',
                                            '95661',
                                            '95662',
                                            '95663',
                                            '95664',
                                            '95667',
                                            '95668',
                                            '95669',
                                            '95670',
                                            '95671',
                                            '95672',
                                            '95673',
                                            '95674',
                                            '95676',
                                            '95677',
                                            '95678',
                                            '95680',
                                            '95681',
                                            '95682',
                                            '95683',
                                            '95686',
                                            '95687',
                                            '95688',
                                            '95690',
                                            '95691',
                                            '95692',
                                            '95693',
                                            '95694',
                                            '95695',
                                            '95696',
                                            '95697',
                                            '95698',
                                            '95703',
                                            '95722',
                                            '95736',
                                            '95741',
                                            '95742',
                                            '95746',
                                            '95747',
                                            '95757',
                                            '95758',
                                            '95759',
                                            '95762',
                                            '95763',
                                            '95765',
                                            '95776',
                                            '95798',
                                            '95799',
                                            '95811',
                                            '95812',
                                            '95813',
                                            '95814',
                                            '95815',
                                            '95816',
                                            '95817',
                                            '95818',
                                            '95819',
                                            '95820',
                                            '95821',
                                            '95822',
                                            '95823',
                                            '95824',
                                            '95825',
                                            '95826',
                                            '95827',
                                            '95828',
                                            '95829',
                                            '95830',
                                            '95831',
                                            '95832',
                                            '95833',
                                            '95834',
                                            '95835',
                                            '95836',
                                            '95837',
                                            '95838',
                                            '95840',
                                            '95841',
                                            '95842',
                                            '95843',
                                            '95851',
                                            '95852',
                                            '95853',
                                            '95860',
                                            '95864',
                                            '95865',
                                            '95866',
                                            '95867',
                                            '95894',
                                            '95899',
                                            '95903',
                                            '95961') THEN 'NCR' ELSE 'SCR' END
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = 'DTP'
        ,drvDTP01_DateTimeQualifier1 = '336'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = EecDateOfLastHire
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = ''
        ,drvDTP01_DateTimeQualifier2 = ''
        ,drvDTP02_DateTimeFormatQual2 = ''
        ,drvDTP03_DateTimePeriod2 = ''
        --=====================
        -- LOOP 2100A RECORDS
        --=====================
        ,drvNM103_NameLast1 = dbo.dsi_fnRemoveChars('.,/',
                              CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                   WHEN BdmRecType = 'DEP' THEN ConNameLast
                              END)
        ,drvNM104_NameFirst1 = dbo.dsi_fnRemoveChars('.,/',
                               CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                    WHEN BdmRecType = 'DEP' THEN ConNameFirst
                               END)
        ,drvNM105_NameMiddleInitial1 = dbo.dsi_fnRemoveChars('.,/',
                                       CASE WHEN BdmRecType = 'EMP' AND EepNameMiddle <> 'Z' THEN LEFT(EepNameMiddle,1)
                                            WHEN BdmRecType = 'DEP' AND ConNameMiddle <> 'Z' THEN LEFT(ConNameMiddle,1)
                                       END)
        ,drvNM106_NamePrefix1 = ''
		--CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' AND EepNameSuffix <> 'Z' THEN EepNameSuffix
                                     WHEN BdmRecType = 'DEP' AND ConNameSuffix <> 'Z' THEN ConNameSuffix
                                END
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' AND EepSSN NOT IN ('000000000', '999999999', '888888888', '123456789') AND LEFT(EepSSN, 3) NOT IN ('999','998') THEN '34'
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' AND ConSSN NOT IN ('000000000', '999999999', '888888888', '123456789') AND LEFT(ConSSN, 3) NOT IN ('999','998') THEN '34'
                                     END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' AND EepSSN NOT IN ('000000000', '999999999', '888888888', '123456789') AND LEFT(EepSSN, 3) NOT IN ('999','998') THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' AND ConSSN NOT IN ('000000000', '999999999', '888888888', '123456789') AND LEFT(ConSSN, 3) NOT IN ('999','998') THEN ConSSN
                                     END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' THEN 'TE'
                                           --  WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') = '' and ISNULL(eepAddressEMail,'') <> '' THEN 'EM'
                                           --   WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' and ISNULL(eepAddressEMail,'') <> '' THEN 'HP'
                                             END

        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' THEN ISNULL(EepPhoneHomeNumber,'') 
                                            --  WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') = '' and ISNULL(eepAddressEMail,'') <> '' THEN ISNULL(eepAddressEMail,'')
                                            --  WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' and ISNULL(eepAddressEMail,'') <> '' THEN  ISNULL(EepPhoneHomeNumber,'') 

                                             END

        ,drvPER05_CommNumberQualifier = ''--CASE WHEN BdmRecType = 'EMP' and ISNULL(eepAddressEMail,'') <> '' and   ISNULL(EepPhoneHomeNumber,'') <> '' THEN 'EM' END

        ,drvPER06_CommunicationNumber = ''--CASE WHEN BdmRecType = 'EMP' and ISNULL(eepAddressEMail,'') <> '' and   ISNULL(EepPhoneHomeNumber,'') <> '' THEN ISNULL(eepAddressEMail,'') END

        ,drvPER07_CommNumberQualifier = ''
        ,drvPER08_CommunicationNumber = ''
        ,drvN301_AddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvN302_AddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvN401_City = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvN402_State = EepAddressState
        ,drvN403_Zip = EepAddressZipCode
        ,drvN404_CountryCode = CASE WHEN EepAddressCountry NOT IN ('US','USA') THEN EepAddressCountry END
        ,drvDMG02_DateTimePeriod1 = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),EepDateOfBirth,112)
                                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(8),ConDateOfBirth,112)
                                    END
        ,drvDMG03_GenderCode1 = CASE WHEN BdmRecType = 'EMP' AND EepGender IN ('M','F') THEN EepGender
                                     WHEN BdmRecType = 'DEP' AND ConGender IN ('M','F') THEN ConGender
                                     ELSE 'U'
                                END
        ,drvDMG04_MaritalStatusCode1 = CASE EepMaritalStatus
                                        WHEN 'D' THEN 'D'
                                        WHEN 'M' THEN 'M'
                                        WHEN 'S' THEN 'I'
                                        WHEN 'W' THEN 'W'
                                        ELSE 'U' END
        -- CASE WHEN BdmRecType = 'EMP' THEN
        --                                         CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'I' END
        --                                END
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = CASE WHEN BdmRecType = 'EMP' THEN '' END --'7'
        ,drvICM02_MonetaryAmount = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvICM03_Quantity = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecScheduledWorkHrs) END
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
        ,drvHLH00_SegmentID = ''
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
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
    INTO dbo.U_EKAIMAJ834_DrvTbl
    FROM dbo.U_EKAIMAJ834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EKAIMAJ834_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EKAIMAJ834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2300 RECORDS - HD, DTP, AMT Segments
            -- Loop 2700 RECORDS - LX Segments
            -- Loop 2750 RECORDS - N1, REF Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_EKAIMAJ834_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_EKAIMAJ834_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = CASE WHEN BdmDedType IN ('MED') THEN 'HD'
                                        WHEN BdmDedType IN ('DEN') THEN 'HD'
                                        WHEN BdmDedType IN ('VIS') THEN 'HD'
                                 END
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD03_InsuranceLineCode = 'HMO'
        ,drvHD04_PlanCoverageDesc = CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD05_CoverageLevelCode = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmRecType = 'EMP' THEN
                                                CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('EES') THEN 'ESP'
                                                     WHEN BdmBenOption IN ('EEC') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('EEF') THEN 'FAM'
                                                END
                                     END
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '348' END
        ,drvDTP02_DateTimeFormatQual_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN BdmBenStopDate END
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = CASE WHEN BdmDedType IN ('MED') THEN '' END
        ,drvDTP01_DateTimeQualifier_303 = CASE WHEN BdmDedType IN ('MED') THEN '303' END
        ,drvDTP02_DateTimeFormatQual_303 = CASE WHEN BdmDedType IN ('MED') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_303 = CASE WHEN BdmDedType IN ('MED') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate) END
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT01_AmountQualifierCode1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT02_MonetaryAmount1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
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
                      + CASE BdmDedType
                             WHEN 'MED' THEN '1'
                             WHEN 'DEN' THEN '2'
                             WHEN 'VIS' THEN '3'
                             ELSE '9'
                      END
    INTO dbo.U_EKAIMAJ834_DrvTbl_2300
    FROM dbo.U_EKAIMAJ834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
        AND (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EKAIMAJ834_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.U_dsi_bdm_EKAIMAJ834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;

    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_EKAIMAJ834_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_EKAIMAJ834_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_EKAIMAJ834_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EKAIMAJ834','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'MJS_EKAIMAJ834_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EKAIMAJ834';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEKAIMAJ834_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EKAIMAJ834_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefFEEOnlyBenOpti
WHERE AdfHeaderSystemID LIKE 'EKAIMAJ834%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = 'EKAIMAJ834';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEKAIMAJ834_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EKAIMAJ834_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EKAIMAJ834' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EKAIMAJ834'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EKAIMAJ834'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EKAIMAJ834', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EKAIMAJ834', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EKAIMAJ834', 'UseFileName', 'V', 'Y'


-- End ripout