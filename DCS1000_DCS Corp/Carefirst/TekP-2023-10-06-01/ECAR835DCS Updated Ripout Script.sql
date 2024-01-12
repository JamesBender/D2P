/**********************************************************************************

ECAR835DCS: Carefirst 835

FormatCode:     ECAR835DCS
Project:        Carefirst 835
Client ID:      DCS1000
Date/time:      2024-01-12 09:59:25.870
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW3WUP3DB01
Database:       ULTIPRO_WPDCSC
Web Filename:   DCS1000_A6BD0_EEHISTORY_ECAR835DCS_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECAR835DCS_SavePath') IS NOT NULL DROP TABLE dbo.U_ECAR835DCS_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECAR835DCS'


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
WHERE FormatCode = 'ECAR835DCS'
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
WHERE ExpFormatCode = 'ECAR835DCS'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECAR835DCS')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECAR835DCS'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECAR835DCS'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECAR835DCS'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECAR835DCS'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECAR835DCS'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECAR835DCS'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECAR835DCS'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECAR835DCS'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECAR835DCS'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECAR835DCS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECAR835DCS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECAR835DCS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECAR835DCS];
GO
IF OBJECT_ID('U_ECAR835DCS_transsetwork') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_transsetwork];
GO
IF OBJECT_ID('U_ECAR835DCS_ST') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_ST];
GO
IF OBJECT_ID('U_ECAR835DCS_SE') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_SE];
GO
IF OBJECT_ID('U_ECAR835DCS_REF') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_REF];
GO
IF OBJECT_ID('U_ECAR835DCS_N1') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_N1];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2750_REF') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2750_REF];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2750_N1') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2750_N1];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2750_DTP') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2750_DTP];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2700_LS') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2700_LS];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2700_LE') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2700_LE];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2310_NM1') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2310_NM1];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2300_REF') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2300_REF];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2300_HD') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2300_HD];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2300_DTP') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2300_DTP];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2300_AMT') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2300_AMT];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2100A_AMT') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2100A_AMT];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2000_REF') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2000_REF];
GO
IF OBJECT_ID('U_ECAR835DCS_Loop2000_DTP') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_Loop2000_DTP];
GO
IF OBJECT_ID('U_ECAR835DCS_ISA') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_ISA];
GO
IF OBJECT_ID('U_ECAR835DCS_GS') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_GS];
GO
IF OBJECT_ID('U_ECAR835DCS_File') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_File];
GO
IF OBJECT_ID('U_ECAR835DCS_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_EEList];
GO
IF OBJECT_ID('U_ECAR835DCS_DTP') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_DTP];
GO
IF OBJECT_ID('U_ECAR835DCS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_drvTbl];
GO
IF OBJECT_ID('U_ECAR835DCS_DepList') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_DepList];
GO
IF OBJECT_ID('U_ECAR835DCS_BGN') IS NOT NULL DROP TABLE [dbo].[U_ECAR835DCS_BGN];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECAR835DCS','Carefirst 835','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECAR835DCSZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','H','01','1','','ISA  Segment ID','','','"ISA"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','2','H','01','2','','Authorization Info Qualifer','','','"drvISA01_authinfoqual"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','10','H','01','3','','Authorization Info','','','"drvISA02_authinfo"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','2','H','01','4','','Security Info Qualifier','','','"drvISA03_secinfoqual"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','10','H','01','5','','Security Info','','','"drvISA04_secinfo"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','2','H','01','6','','Sender ID Qualifier','','','"drvISA05_senderidqual"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECAR835DCSZ0','15','H','01','7','','Sender ID','','','"drvISA06_senderid"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECAR835DCSZ0','2','H','01','8','','Receiver ID Qualifier','','','"drvISA07_recvidqual"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECAR835DCSZ0','15','H','01','9','','Receiver ID','','','"drvISA08_recvid"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECAR835DCSZ0','6','H','01','10','','Interchange Date','','','"drvISA09_intchgdate"','(''UD012''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECAR835DCSZ0','4','H','01','11','','InterChange Time','','','"drvISA10_intchgdate"','(''UDHMS''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECAR835DCSZ0','1','H','01','12','','InterChange Control ID','','','"drvISA11_intchgcontrolid"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECAR835DCSZ0','5','H','01','13','','Interchange Control Version','','','"drvISA12_intchgcontrolver"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECAR835DCSZ0','9','H','01','14','','Interchange Control Number','','','"drvISA13_intchgcontrolnum"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECAR835DCSZ0','1','H','01','15','','Acknowledgement Requested','','','"drvISA14_acknowreq"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECAR835DCSZ0','1','H','01','16','','Usage Indicator','','','"drvISA15_usageind"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECAR835DCSZ0','1','H','01','17','','Component Element Separator','','','"drvISA16_compelementsep"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','H','02','1','','GS  Segment ID','','','"GS"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','2','H','02','2','','Functional ID Code','','','"drvGS01_functidcode"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','15','H','02','3','','Sender ID','','','"drvGS02_senderid"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','15','H','02','4','','Receiver ID','','','"drvGS03_receiverid"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','8','H','02','5','','Date','','','"drvGS04_date"','(''UD112''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','4','H','02','6','','Time','','','"drvGS04_date"','(''UDHMS''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECAR835DCSZ0','9','H','02','7','','Group Control Number','','','"drvGS06_grpcontrolnum"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECAR835DCSZ0','2','H','02','8','','Responsible Agency Code','','','"drvGS07_respagencycode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECAR835DCSZ0','12','H','02','9','','Version  Release Indust','','','"drvGS08_verrelease"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','03','1','','ST  Segment ID (Transaction Se','','','"ST"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','03','2','','Transaction Set ID Code','','','"drvST01_transsetid"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','9','D','03','3','','Transaction Set Control Number','','','"drvST02_transsetctrlnum"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','35','D','03','4','','','','','"drvST03_implconvref"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','04','1','','BGN Segment ID (Beginning Segm','','','"BGN"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','2','D','04','2','','Transaction Set Purpose','','','"drvBGN01_transsetpurpose"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','30','D','04','3','','Reference Identification Sende','','','"drvBGN02_referenceidsender"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','8','D','04','4','','Date','','','"drvBGN03_date"','(''UD112''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','4','D','04','5','','Time','','','"drvBGN04_date"','(''UDHMS''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','2','D','04','6','','Time Zone','','','"drvBGN_05_timezone"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECAR835DCSZ0','30','D','04','7','','Reference Identification','','','"drvBGN06_referenceid"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECAR835DCSZ0','2','D','04','8','','Transaction Type Code','','','"drvBGN07_transtypecode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECAR835DCSZ0','2','D','04','9','','Action Code','','','"drvBGN08_actioncode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','05','1','','REF  Segment ID (Transaction S','','','"REF"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','05','2','','Reference ID Qualifier','','','"drvREF01_referenceidqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','30','D','05','3','','Reference Identification','','','"drvREF02_referenceid"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','06','1','','DTP Segment ID (File Effective','','','"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','06','2','','DateTime Qualifier','','','"drvDTP01_dttmqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','3','D','06','3','','DateTime Period Format','','','"drvDTP02_dttmformat"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','35','D','06','4','','DateTime Period','','','"drvDTP03_dttmperiod"','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','07','1','','N1  Segment ID  (Loop 1000)','','','"N1"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','07','2','','Entity Identifier Code','','','"drvN101_entityidcode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','60','D','07','3','','Name','','','"drvN102_name"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','2','D','07','4','','Identification Code Qualifier','','','"drvN103_idcodequal"','(''UA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','80','D','07','5','','Identification Code','','','"drvN104_idcode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','10','1','','INS  Segment ID (Loop 2000)','','','"INS"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','1','D','10','2','','YesNo Condition','','','"drvINS01_yesno"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','2','D','10','3','','Individual Relationship Code','','','"drvINS02_relationship"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','3','D','10','4','','Maintenance Type Code','','','"drvINS03_mainttype"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','2','D','10','5','','Maintenance Reason Code','','','"drvINS04_maintreason"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','1','D','10','6','','Benefit Status Code','','','"drvINS05_benstatus"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECAR835DCSZ0','1','D','10','7','','Medicare Plan Code','','','"drvINS06_medicareplan"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECAR835DCSZ0','2','D','10','8','','COBRA Qualifying Event','','','"drvINS07_cobraqualevent"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECAR835DCSZ0','2','D','10','9','','Employment Status Code','','','"drvINS08_emplstatuscode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECAR835DCSZ0','1','D','10','10','','Student Status','','','"drvINS09_studentstatus"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECAR835DCSZ0','1','D','10','11','','Handicap Indicator','','','"drvINS10_handicapind"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECAR835DCSZ0','2','D','10','12','','Date Format','','','"drvINS11_dateformat"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECAR835DCSZ0','35','D','10','13','','Death Date','','','"drvINS12_deathdate"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECAR835DCSZ0','1','D','10','14','','Not Used','','','"spaces"','(''SS''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECAR835DCSZ0','30','D','10','15','','Not Used','','','"spaces"','(''SS''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECAR835DCSZ0','2','D','10','16','','Not Used','','','"spaces"','(''SS''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECAR835DCSZ0','3','D','10','17','','Not Used','','','"spaces"','(''SS''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECAR835DCSZ0','9','D','10','18','','Birth Sequence Number','','','"drvINS17_birthseqnumber"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','11','1','','REF  Segment ID (Loop 2000)','','','"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','11','2','','Reference Number Qualifier','','','"drvREF01_refnumqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','30','D','11','3','','Reference Number','','','"drvREF02_refnum"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','12','1','','DTP  Segment ID (Loop 2000)','','','"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','12','2','','DateTime Qual','','','"drvDTP01_dttmqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','2','D','12','3','','DateTime Format','','','"drvDTP02_dttmformat"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','35','D','12','4','','DateTime Period','','','"drvDTP03_dttmperiod"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','13','1','','NM1  Segment ID (Loop 2100A)','','','"NM1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','13','2','','Entity Identifier Code','','','"drvNM101_entityidcode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','1','D','13','3','','Entity Type Qual','','','"drvNM102_entitytypequal"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','35','D','13','4','','Name Last','','','"drvNM103_namelast"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','25','D','13','5','','Name First','','','"drvNM104_namefirst"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','25','D','13','6','','Name Middle','','','"drvNM105_namemiddle"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECAR835DCSZ0','10','D','13','7','','Name Prefix','','','"drvNM106_nameprefix"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECAR835DCSZ0','10','D','13','8','','Name Suffix','','','"drvNM107_namesuffix"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECAR835DCSZ0','2','D','13','9','','Identification Code Qualifier','','','"drvNM108_identcodequal"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECAR835DCSZ0','80','D','13','10','','Identification Code','','','"drvNM109identcode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','14','1','','PER Segment ID (Loop 2100A)','','','"PER"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','2','D','14','2','','Contact Function Code','','','"drvPER01_contfunccode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','1','D','14','3','','Not Used','','','"spaces"','(''SS''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','2','D','14','4','','Communication Number1 Qual','','','"drvPER03_commnum1qual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','10','D','14','5','','Communication Number1','','','"drvPER04_commnum1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','2','D','14','6','','Communication Number2 Qualifie','','','"drvPER05_commnum2qual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECAR835DCSZ0','100','D','14','7','','Communication Number2','','','"drvPER06_commnum2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECAR835DCSZ0','2','D','14','8','','Communication Number3 Qual','','','"drvPER07_commnum3qual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECAR835DCSZ0','30','D','14','9','','Communication Number3','','','"drvPER08_commnum3"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','15','1','','N3  Segment ID (Loop 2100A)','','','"N3"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','55','D','15','2','','AddressLine1','','','"drvN301_address1"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','55','D','15','3','','AddressLine2','','','"drvN302_address2"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','16','1','','N4  Segment ID (Loop 2100A)','','','"N4"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','30','D','16','2','','City','','','"drvN401_city"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','2','D','16','3','','State or Province','','','"drvN402_state"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','15','D','16','4','','Postal Code','','','"drvN403_zipcode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','3','D','16','5','','Country Code','','','"drvN404_country"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','2','D','16','6','','Location Qualifier','','','"drvN405_locationqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECAR835DCSZ0','30','D','16','7','','Location Identifier','','','"drvN406_location"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','17','1','','DMG  Segment ID (Loop 2100A)','','','"DMG"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','17','2','','DateTime Format Qual','','','"drvDMG01_dttmqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','35','D','17','3','','DateTime Period','','','"drvDMG02_dttmperiod"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','1','D','17','4','','Gender Code','','','"drvDMG03_gender"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','1','D','17','5','','Marital Status','','','"drvDMG04_maritalstatus"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','1','D','17','6','','Ethnic Code','','','"drvDMG05_ethnic"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECAR835DCSZ0','2','D','17','7','','Citizenship Status','','','"drvDMG06_citizenship"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','18','1','','ICM Segment ID (Loop 2100A)','','','"ICM"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','1','D','18','2','','Frequency Code','','','"drvICM01_frequency"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','18','D','18','3','','Monetary Amount','','','"drvICM02_amount"','(''UNT2''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','15','D','18','4','','Quantity','','','"drvICM03_hours"','(''UNT0''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','30','D','18','5','','Location Identifier','','','"drvICM04_location"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','5','D','18','6','','Salary Grade','','','"drvICM05_salgrade"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','19','1','','AMT Segment ID (Loop 2100A)','','','"AMT"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','19','2','','Amount Qualifier Code','','','"drvAMT01_amtqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','18','D','19','3','','Monetary Amount','','','"drvAMT02_amount"','(''UNT2''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','45','1','','HD  Segment ID (Loop 2300)','','','"HD"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','45','2','','Maintenance Type Code','','','"drvHD01_mainttype"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','3','D','45','3','','Maintenance Reason Code','','','"drvHD02_maintreason"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','3','D','45','4','','Insurance Line Code','','','"drvHD03_inslinecode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','50','D','45','5','','Plan Coverage Description','','','"drvHD04_plancovdesc"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','3','D','45','6','','Coverage Level Code','','','"drvHD05_covlvl"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','46','1','','DTP  Segment ID','','','"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','46','2','','DateTime Qual','','','"drvDTP01_dttmqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','2','D','46','3','','DateTime Format Qual','','','"drvDTP02_dttmformat"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','35','D','46','4','','DateTime Period','','','"drvDTP03_dttmperiod"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','47','1','','AMT Segment ID (Loop 2300)','','','"AMT"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','47','2','','Amount Qualifier Code','','','"drvAMT01_amtqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','18','D','47','3','','Monetary Amount','','','"drvAMT02_amount"','(''UNT2''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','48','1','','REF  Segment ID (Loop 2300)','','','"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','2','D','48','2','','Reference Identification Quali','','','"drvREF01_refidentqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','25','D','48','20','','Reference Identification','','','"drvREF02_refident"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','50','1','','','','','"LX"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','6','D','50','2','','','','','"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','51','1','','','','','"NM1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','51','2','','','','','"drvNM101_refidentqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','1','D','51','3','','','','','"drvNM102_refident"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','60','D','51','4','','','','','"drvNM103_lname"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECAR835DCSZ0','35','D','51','5','','','','','"drvNM104_fname"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECAR835DCSZ0','25','D','51','6','','','','','"drvNM105_mname"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECAR835DCSZ0','10','D','51','7','','','','','"drvNM106_prefix"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECAR835DCSZ0','10','D','51','8','','','','','"drvNM107_suffix"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECAR835DCSZ0','2','D','51','9','','','','','"drvNM108_qualifier"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECAR835DCSZ0','80','D','51','10','','','','','"drvNM109_idcode"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECAR835DCSZ0','2','D','51','11','','','','','"drvNM110_relation"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','60','1','','','','','"LS"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','4','D','60','2','','','','','"2700"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','61','1','','','','','"LX"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','6','D','61','2','','','','','"1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','62','1','','','','','"N1"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','62','2','','','','','"drvN101_refidentqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','60','D','62','3','','','','','"drvN102_refident"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','64','1','','','','','"REF"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','64','2','','','','','"drvREF01_refidentqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','50','D','64','3','','','','','"drvREF02_refident"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','D','66','1','','','','','"DTP"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','3','D','66','2','','','','','"drvDTP01_dttmqual"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','3','D','66','3','','','','','"drvDTP02_dttmformat"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECAR835DCSZ0','35','D','66','4','','','','','"drvDTP03_dttmperiod"','(''UD112''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','69','1','','','','','"LE"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','4','D','69','2','','','','','"2700"','(''DA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','D','97','1','','SE  Segment ID (Transaction Se','','','"SE"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','6','D','97','2','','Number of Included Segments','','','"drvSE01_segcount"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','10','D','97','3','','Transaction Set Control number','','','"drvSE02_transsetctrlnum"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','2','T','98','1','','GE  Segment ID','','','"GE"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','6','T','98','2','','Number of Transaction Sets Inc','','','"drvGS_transsetcount"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','9','T','98','3','','Group Control number','','','"drvGS06_grpcontrolnum"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECAR835DCSZ0','3','T','99','1','','IEA  Segment ID','','','"IEA"','(''DA''=''F*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECAR835DCSZ0','5','T','99','2','','Number of Included Functional','','','"drvISA_groupcount"','(''UA''=''T*'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECAR835DCSZ0','9','T','99','3','','Interchange Control Number','','','"drvISA13_intchgcontrolnum"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECAR835DCS_20240112.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Carefirst Active OE Session','201601019','EMPEXPORT','ACTIVEOE','Dec  4 2015 12:46PM','ECAR835DCS',NULL,NULL,NULL,'201601019','Jan  1 2016 12:00AM','Dec 30 1899 12:00AM','201601011','4','','','201601011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPDCSC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','U6X8D',NULL,NULL,NULL,'Carefirst 835','202412319','EMPEXPORT','ECAR835DCS','Mar  1 2017 12:00AM','ECAR835DCS',NULL,NULL,NULL,'202412319','Feb 24 2017 12:00AM','Dec 30 1899 12:00AM','202401121','13523','','','202401121',dbo.fn_GetTimedKey(),NULL,'ULTI_WPDCSC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','U6X8D,U6XD3,U6XFB',NULL,NULL,NULL,'Carefirst Passive OE Session','202201109','EMPEXPORT','PASSIVEOE','Dec 13 2016  1:23PM','ECAR835DCS',NULL,NULL,NULL,'202201109','Jan 11 2017 12:00AM','Dec 30 1899 12:00AM','202201091','13288','','','202201091',dbo.fn_GetTimedKey(),NULL,'ULTI_WPDCSC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',U6X8D,U6XD3,U6XFB',NULL,NULL,NULL,'xxxTEST Carefirst 835','202206061','EMPEXPORT','TEST','Jun  6 2022 10:39AM','ECAR835DCS',NULL,NULL,NULL,'202206061','Jun  6 2022 12:00AM','Dec 30 1899 12:00AM','202205301','22226','','','202205301',dbo.fn_GetTimedKey(),NULL,'ULTI_WPDCSC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',U6X8D,U6XD3,U6XFB',NULL,NULL,NULL,'xxxunlock 835 template','201204119','EMPEXPORT','ZAP','Apr 11 2012 12:00AM','ECAR835DCS',NULL,NULL,NULL,'201204119','Apr 11 2012 12:00AM','Dec 30 1899 12:00AM','201204111',NULL,'','','201204111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAR835DCS','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAR835DCS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAR835DCS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAR835DCS','InitialSort','C','drvsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAR835DCS','IS834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAR835DCS','SubSort','C','drvsubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAR835DCS','SystemID','V','589F522734FA');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAR835DCS','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECAR835DCS','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','H01','dbo.U_ECAR835DCS_ISA',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','H02','dbo.U_ECAR835DCS_GS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D03','dbo.U_ECAR835DCS_ST',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D04','dbo.U_ECAR835DCS_BGN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D05','dbo.U_ECAR835DCS_REF','drvREF01_referenceidqual <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D06','dbo.U_ECAR835DCS_DTP','drvDTP01_dttmqual <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D07','dbo.U_ECAR835DCS_N1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D10','dbo.U_ECAR835DCS_drvtbl  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D11','dbo.U_ECAR835DCS_Loop2000_ref  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D12','dbo.U_ECAR835DCS_Loop2000_dtp  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D13','dbo.U_ECAR835DCS_drvtbl  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D14','dbo.U_ECAR835DCS_drvtbl  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',' (drvPER03_commnum1qual <> '''' or drvPER05_commnum2qual <> '''' or drvPER07_commnum3qual <> '''')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D15','dbo.U_ECAR835DCS_drvtbl  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')','(drvN301_address1 <> '''')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D16','dbo.U_ECAR835DCS_drvtbl  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')','(drvN401_city <> '''')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D17','dbo.U_ECAR835DCS_drvtbl  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D18','dbo.U_ECAR835DCS_drvtbl  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')','drvICM01_frequency <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D19','dbo.U_ECAR835DCS_Loop2100A_amt  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D45','dbo.U_ECAR835DCS_Loop2300_hd  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D46','dbo.U_ECAR835DCS_Loop2300_dtp  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D47','dbo.U_ECAR835DCS_Loop2300_amt  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D48','dbo.U_ECAR835DCS_Loop2300_ref  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D50','dbo.U_ECAR835DCS_Loop2310_NM1  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')','drvNM109_idcode <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D51','dbo.U_ECAR835DCS_Loop2310_NM1  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')','drvNM109_idcode <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D60','dbo.U_ECAR835DCS_Loop2700_LS   join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D61','dbo.U_ECAR835DCS_Loop2750_N1  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D62','dbo.U_ECAR835DCS_Loop2750_N1  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D64','dbo.U_ECAR835DCS_Loop2750_REF  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D66','dbo.U_ECAR835DCS_Loop2750_DTP  join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D69','dbo.U_ECAR835DCS_Loop2700_LE   join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'''') = isnull(drvdepid,'''')',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','D97','dbo.U_ECAR835DCS_SE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','T98','dbo.U_ECAR835DCS_GS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECAR835DCS','T99','dbo.U_ECAR835DCS_ISA',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ECAR835DCS_BGN
-----------

IF OBJECT_ID('U_ECAR835DCS_BGN') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_BGN] (
    [trnset] char(9) NULL,
    [drvsort] varchar(24) NULL,
    [drvsubsort] char(25) NULL,
    [drvBGN01_transsetpurpose] varchar(2) NOT NULL,
    [drvBGN02_referenceidsender] char(9) NULL,
    [drvBGN03_date] datetime NULL,
    [drvBGN04_date] datetime NULL,
    [drvBGN_05_timezone] varchar(2) NOT NULL,
    [drvBGN06_referenceid] varchar(1) NOT NULL,
    [drvBGN07_transtypecode] varchar(1) NOT NULL,
    [drvBGN08_actioncode] varchar(1) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_DepList
-----------

IF OBJECT_ID('U_ECAR835DCS_DepList') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_DepList] (
    [deeid] char(12) NOT NULL,
    [ddepid] char(12) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_drvTbl
-----------

IF OBJECT_ID('U_ECAR835DCS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvssn] char(11) NULL,
    [drvempno] char(9) NULL,
    [drvemplstatus] char(1) NULL,
    [drvsubsort] varchar(25) NULL,
    [drvINS01_yesno] varchar(1) NOT NULL,
    [drvINS02_relationship] varchar(2) NOT NULL,
    [drvINS03_mainttype] varchar(3) NOT NULL,
    [drvINS04_maintreason] varchar(2) NOT NULL,
    [drvINS05_benstatus] varchar(1) NOT NULL,
    [drvINS06_medicareplan] varchar(1) NOT NULL,
    [drvINS07_cobraqualevent] varchar(1) NOT NULL,
    [drvINS08_emplstatuscode] varchar(2) NULL,
    [drvINS09_studentstatus] varchar(1) NOT NULL,
    [drvINS10_handicapind] varchar(1) NOT NULL,
    [drvINS11_dateformat] varchar(1) NOT NULL,
    [drvINS12_deathdate] varchar(1) NOT NULL,
    [drvINS17_birthseqnumber] varchar(1) NOT NULL,
    [drvNM101_entityidcode] varchar(2) NOT NULL,
    [drvNM102_entitytypequal] varchar(1) NOT NULL,
    [drvNM103_namelast] varchar(6000) NULL,
    [drvNM104_namefirst] varchar(6000) NULL,
    [drvNM105_namemiddle] varchar(6000) NULL,
    [drvNM106_nameprefix] varchar(1) NOT NULL,
    [drvNM107_namesuffix] varchar(1) NOT NULL,
    [drvNM108_identcodequal] varchar(2) NOT NULL,
    [drvNM109identcode] char(11) NULL,
    [drvPER01_contfunccode] varchar(2) NOT NULL,
    [drvPER03_commnum1qual] varchar(2) NOT NULL,
    [drvPER04_commnum1] varchar(50) NULL,
    [drvPER05_commnum2qual] varchar(2) NOT NULL,
    [drvPER06_commnum2] varchar(50) NULL,
    [drvPER07_commnum3qual] varchar(1) NOT NULL,
    [drvPER08_commnum3] varchar(1) NOT NULL,
    [drvN301_address1] varchar(6000) NULL,
    [drvN302_address2] varchar(6000) NULL,
    [drvN401_city] varchar(6000) NULL,
    [drvN402_state] varchar(255) NULL,
    [drvN403_zipcode] varchar(8000) NULL,
    [drvN404_country] varchar(1) NOT NULL,
    [drvN405_locationqual] varchar(1) NOT NULL,
    [drvN406_location] varchar(1) NOT NULL,
    [drvDMG01_dttmqual] varchar(2) NOT NULL,
    [drvDMG02_dttmperiod] datetime NULL,
    [drvDMG03_gender] char(1) NULL,
    [drvDMG04_maritalstatus] varchar(1) NOT NULL,
    [drvDMG05_ethnic] varchar(1) NOT NULL,
    [drvDMG06_citizenship] varchar(1) NOT NULL,
    [drvICM01_frequency] varchar(1) NOT NULL,
    [drvICM02_amount] varchar(1) NOT NULL,
    [drvICM03_hours] varchar(1) NOT NULL,
    [drvICM04_location] varchar(1) NOT NULL,
    [drvICM05_salgrade] varchar(1) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_DTP
-----------

IF OBJECT_ID('U_ECAR835DCS_DTP') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_DTP] (
    [trnset] char(9) NULL,
    [drvsort] varchar(24) NULL,
    [drvsubsort] char(25) NULL,
    [drvDTP01_dttmqual] varchar(3) NOT NULL,
    [drvDTP02_dttmformat] varchar(2) NOT NULL,
    [drvDTP03_dttmperiod] datetime NULL
);

-----------
-- Create table U_ECAR835DCS_EEList
-----------

IF OBJECT_ID('U_ECAR835DCS_EEList') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECAR835DCS_File
-----------

IF OBJECT_ID('U_ECAR835DCS_File') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ECAR835DCS_GS
-----------

IF OBJECT_ID('U_ECAR835DCS_GS') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_GS] (
    [drvsort] char(20) NULL,
    [drvsubsort] char(25) NULL,
    [drvGS01_functidcode] varchar(2) NOT NULL,
    [drvGS02_senderid] varchar(9) NOT NULL,
    [drvGS03_receiverid] varchar(5) NOT NULL,
    [drvGS04_date] datetime NULL,
    [drvGS05_date] datetime NULL,
    [drvGS06_grpcontrolnum] varchar(9) NOT NULL,
    [drvGS07_respagencycode] varchar(1) NOT NULL,
    [drvGS08_verrelease] varchar(12) NOT NULL,
    [drvGS_transsetcount] int NULL
);

-----------
-- Create table U_ECAR835DCS_ISA
-----------

IF OBJECT_ID('U_ECAR835DCS_ISA') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_ISA] (
    [drvsort] char(20) NULL,
    [drvsubsort] char(25) NULL,
    [drvISA01_authinfoqual] varchar(2) NOT NULL,
    [drvISA02_authinfo] varchar(1) NOT NULL,
    [drvISA03_secinfoqual] varchar(2) NOT NULL,
    [drvISA04_secinfo] varchar(1) NOT NULL,
    [drvISA05_senderidqual] varchar(2) NOT NULL,
    [drvISA06_senderid] varchar(9) NOT NULL,
    [drvISA07_recvidqual] varchar(2) NOT NULL,
    [drvISA08_recvid] varchar(5) NOT NULL,
    [drvISA09_intchgdate] datetime NULL,
    [drvISA10_intchgdate] datetime NULL,
    [drvISA11_intchgcontrolid] varchar(1) NOT NULL,
    [drvISA12_intchgcontrolver] varchar(5) NOT NULL,
    [drvISA13_intchgcontrolnum] varchar(9) NOT NULL,
    [drvISA14_acknowreq] varchar(1) NOT NULL,
    [drvISA15_usageind] varchar(1) NOT NULL,
    [drvISA16_compelementsep] varchar(1) NOT NULL,
    [drvISA_groupcount] int NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2000_DTP
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2000_DTP') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2000_DTP] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvsubsort] varchar(25) NULL,
    [drvDTP01_dttmqual] varchar(3) NOT NULL,
    [drvDTP02_dttmformat] varchar(2) NOT NULL,
    [drvDTP03_dttmperiod] datetime NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2000_REF
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2000_REF') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2000_REF] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvsubsort] varchar(25) NULL,
    [drvREF01_refnumqual] varchar(2) NOT NULL,
    [drvREF02_refnum] varchar(30) NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2100A_AMT
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2100A_AMT') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2100A_AMT] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvsubsort] varchar(25) NULL,
    [drvAMT01_amtqual] varchar(1) NOT NULL,
    [drvAMT02_amount] money NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2300_AMT
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2300_AMT') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2300_AMT] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvsubsort] varchar(30) NULL,
    [drvAMT01_amtqual] varchar(18) NULL,
    [drvAMT02_amount] varchar(1) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2300_DTP
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2300_DTP') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2300_DTP] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvsubsort] varchar(30) NULL,
    [drvDTP01_dttmqual] varchar(3) NOT NULL,
    [drvDTP02_dttmformat] varchar(2) NOT NULL,
    [drvDTP03_dttmperiod] datetime NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2300_HD
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2300_HD') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2300_HD] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvsubsort] varchar(30) NULL,
    [drvHD01_mainttype] varchar(3) NOT NULL,
    [drvHD02_maintreason] varchar(1) NOT NULL,
    [drvHD03_inslinecode] varchar(3) NOT NULL,
    [drvHD04_plancovdesc] varchar(50) NULL,
    [drvHD05_covlvl] varchar(3) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2300_REF
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2300_REF') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2300_REF] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvsubsort] varchar(30) NULL,
    [drvREF01_refidentqual] varchar(2) NOT NULL,
    [drvREF02_refident] varchar(1) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2310_NM1
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2310_NM1') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2310_NM1] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvsubsort] varchar(30) NULL,
    [drvNM101_refidentqual] varchar(2) NOT NULL,
    [drvNM102_refident] varchar(1) NOT NULL,
    [drvNM103_lname] varchar(1) NOT NULL,
    [drvNM104_fname] varchar(1) NOT NULL,
    [drvNM105_mname] varchar(1) NOT NULL,
    [drvNM106_prefix] varchar(1) NOT NULL,
    [drvNM107_suffix] varchar(1) NOT NULL,
    [drvNM108_qualifier] varchar(2) NOT NULL,
    [drvNM109_idcode] char(10) NULL,
    [drvNM110_relation] varchar(2) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2700_LE
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2700_LE') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2700_LE] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvdedcode] varchar(1) NOT NULL,
    [drvsubsort] varchar(25) NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2700_LS
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2700_LS') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2700_LS] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvdedcode] varchar(1) NOT NULL,
    [drvsubsort] varchar(25) NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2750_DTP
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2750_DTP') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2750_DTP] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvdedcode] varchar(1) NOT NULL,
    [drvsubsort] varchar(25) NULL,
    [drvDTP01_dttmqual] varchar(3) NOT NULL,
    [drvDTP02_dttmformat] varchar(2) NOT NULL,
    [drvDTP03_dttmperiod] datetime NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2750_N1
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2750_N1') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2750_N1] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvdedcode] varchar(1) NOT NULL,
    [drvsubsort] varchar(25) NULL,
    [drvN101_refidentqual] varchar(2) NOT NULL,
    [drvN102_refident] varchar(3) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_Loop2750_REF
-----------

IF OBJECT_ID('U_ECAR835DCS_Loop2750_REF') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_Loop2750_REF] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvdedcode] varchar(1) NOT NULL,
    [drvsubsort] varchar(25) NULL,
    [drvREF01_refidentqual] varchar(2) NOT NULL,
    [drvREF02_refident] varchar(4) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_N1
-----------

IF OBJECT_ID('U_ECAR835DCS_N1') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_N1] (
    [trnset] char(9) NULL,
    [drvsort] varchar(24) NULL,
    [drvsubsort] char(25) NULL,
    [drvN101_entityidcode] varchar(2) NOT NULL,
    [drvN102_name] varchar(70) NULL,
    [drvN103_idcodequal] varchar(2) NOT NULL,
    [drvN104_idcode] varchar(9) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_REF
-----------

IF OBJECT_ID('U_ECAR835DCS_REF') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_REF] (
    [trnset] char(9) NULL,
    [drvsort] varchar(24) NULL,
    [drvsubsort] char(25) NULL,
    [drvREF01_referenceidqual] varchar(2) NOT NULL,
    [drvREF02_referenceid] varchar(5) NOT NULL
);

-----------
-- Create table U_ECAR835DCS_SE
-----------

IF OBJECT_ID('U_ECAR835DCS_SE') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_SE] (
    [drvsort] varchar(36) NULL,
    [drvsubsort] char(25) NULL,
    [drvSE01_segcount] int NULL,
    [drvSE02_transsetctrlnum] char(9) NULL
);

-----------
-- Create table U_ECAR835DCS_ST
-----------

IF OBJECT_ID('U_ECAR835DCS_ST') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_ST] (
    [drvsort] varchar(24) NULL,
    [drvsubsort] char(25) NULL,
    [drvST01_transsetid] varchar(3) NOT NULL,
    [drvST02_transsetctrlnum] char(9) NULL,
    [drvST03_implconvref] varchar(12) NOT NULL,
    [drvst_segcount] int NULL
);

-----------
-- Create table U_ECAR835DCS_transsetwork
-----------

IF OBJECT_ID('U_ECAR835DCS_transsetwork') IS NULL
CREATE TABLE [dbo].[U_ECAR835DCS_transsetwork] (
    [trneeid] char(12) NULL,
    [trncoid] char(5) NULL,
    [trndepdepid] varchar(30) NULL,
    [trnrow] int IDENTITY(1,1) NOT NULL,
    [trnset] char(9) NULL,
    [drvsort] char(20) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECAR835DCS]
 @systemid varchar(12) = ''
AS
Begin
 
/*************************************************************************************************
DRIVER TABLE SP FOR:  CareFirst 834 v5
BUILT FOR: DCS Corporation
ORIGINAL BUILD (V-1.0): 11/09/2015 - chas   - SF 05943573

Modifications:
Dagyei   8/1/2016  added location code MOSTL  SF 07356637
B'Nai Jackson 08/05/2016 added location code DEREM1 & CAEAFB  - SF 07373815
B'Nai Jackson 11/07/2016 update to remove sub-divisions PR-204700 
Lynn Manning    05/13/2022    SR-2021-00354797   Updated ISA record, updated INS09 (Student) so it does not populate for SPS/DP.
Lynn Manning    05/26/2022    SR-2021-00354797   Updated INS10 (handicapped) so it does not populate for SPS/DP.
MWaters            01/12/2024  TekP-2023-10-06-01 Moved changes (updated HD04 field) from copy to Prod 


SELECT TOP 10 filFilePath, filFileName, * from FileInfo WHERE filFileName LIKE '%ECAR835DCS%' AND FilCreateDate > GETDATE()-30 ORDER by filCreateDate DESC

SELECT * FROM dbo.U_Dsi_Configuration WHERE FormatCode = 'ECAR835DCS'
SELECT * FROM dbo.U_Dsi_SqlClauses WHERE FormatCode = 'ECAR835DCS'
SELECT * FROM dbo.U_Dsi_Parameters WHERE FormatCode = 'ECAR835DCS'
SELECT * FROM AscEXP WHERE ExpFormatCode = 'ECAR835DCS'
SELECT AdhFormatName, * FROM AscDefH WHERE AdhFormatCode = 'ECAR835DCS'
SELECT * FROM dbo.U_Dsi_InterfaceActivityLog WHERE FormatCode = 'ECAR835DCS' ORDER BY DateTimeStamp DESC

select TOP 10 filFilePath, filFileName, * from fileinfo WHERE filFileName LIKE '%ECAR835DCS%' ORDER by filCreateDate DESC

exec [dbo].[_dsi_usp_ExportRipOut_v7_4] @FormatCode = 'ECAR835DCS', @AllObjects = 'Y', @IsWeb = 'Y'

*************************************************************************************************/


    /***************************
    COLLECT DATE PARAMETERS
    ****************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200),
        @PlanDate DATETIME
        
    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = formatcode,
        @ExportCode = Exportcode,
        @Exportfile = ExportFile,
        @PlanDate = convert(varchar(4), year(@EndDate)) + '0101'--'20160101' --12/05 BJ PR-204700
    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID

declare @filedate as datetime
select @filedate = getdate()

        
-- STEP6 change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 30    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'N'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export show deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full oe

declare @include_STref char(1)
declare @include_STdtp char(1)
declare @include_Loop2100Amt char(1) 
declare @include_Loop2300amt char(1)
declare @include_Loop2300ref char(1)
declare @include_Loop2310nm1 char(1)
declare @include_Loop2750n1  char(1)
declare @include_Loop2750ref  char(1)
declare @include_Loop2750dtp  char(1)
set @include_STref = 'N'      -- Y or N if REF after BGN record is needed
set @include_STdtp = 'N'      -- Y or N if DTP after above REF is needed
set @include_Loop2100Amt = 'N'  -- Y or N if Loop 2100A Amt record is needed
set @include_Loop2300Amt = 'N'  -- Y or N if Loop 2300 Amt record is needed
set @include_Loop2300Ref = 'N'  -- Y or N if Loop 2300 Ref record is needed
set @include_Loop2310NM1 = 'N'  -- Y or N if Loop 2300 NM1 record (PCP) is needed
set @include_Loop2750N1  = 'N'  -- Y or N if Loop 2750 N1 record is needed
set @include_Loop2750REF = 'N'  -- Y or N if Loop 2750 REF record is needed
set @include_Loop2750DTP = 'N'  -- Y or N if Loop 2750 DTP record is needed

-- STEP7  clean up EELIST if needed  must provide criteria

--STEP8 clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_ECAR835DCS_EELIST
            from dbo.u_ECAR835DCS_EELIST
            join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_ECAR835DCS_eelist
            from dbo.u_ECAR835DCS_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ECAR835DCS_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)


end


--BDM
-- replace Esssssssss with the OE session if applicable

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','MIHSA,MIPPO')
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','MDHRA,MDOAP,MDTRI,MIHSA,MIPPO')
-- select deddedcode, dedlongdesc, deddedtype from dedcode where deddedtype = 'MED' order by 1
--MDHRA    Medical - HRA        MED 
--MDOAP    Medical - OAP        MED 
--MDTRI    Medical - Tri-Care    MED 
--MIHSA    Medical - HSA        MED 
--MIPPO    Medical - PPO        MED 

IF @ExportCode NOT IN ('ACTIVEOE','PASSIVEOE') BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@EndDate - @daysstopped)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END
IF @ExportCode IN ('ACTIVEOE','PASSIVEOE') BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

IF @ExportCode = 'ACTIVEOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Active')    --'Passive')
END
IF @ExportCode = 'PASSIVEOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')    --'Active')
END


EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode



--select * from dbo.U_dsi_bdm_EmpDeductions where eedformatcode = 'ECAR835DCS'




--Step20 Clean up eelist if needed to only include employees with deductions
            delete dbo.u_ECAR835DCS_eelist
            from dbo.u_ECAR835DCS_eelist a
            where not exists(select 1 from U_dsi_bdm_EmpDeductions 
                where a.xeeid = eedeeid
                and a.xcoid = eedcoid
                and eedformatcode = @formatcode
                and eedvalidforexport = 'Y')


-- Step21   Clean up eelist if only one record per employee per type
if @onerecperemp = 'Y'
begin
            delete dbo.u_ECAR835DCS_EELIST
            from dbo.u_ECAR835DCS_EELIST
            join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_ECAR835DCS_eelist
            from dbo.u_ECAR835DCS_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ECAR835DCS_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

-- Clean up eelist by removing TEST EEs
-- select eepeeid, eepnamelast, eepnamefirst from EmpPers where eepnamelast like 'test%'
--begin tran -- commit rollback
            delete dbo.u_ECAR835DCS_eelist
            from dbo.u_ECAR835DCS_EELIST
            join emppers with (nolock) on xeeid = eepeeid
            where EepNameLast like 'testdcs%'


-- Populate driver tables (The header logic follows employee and dependent logic)

--STEP22 Populate Source for Employees
if object_id('dbo.U_ECAR835DCS_drvTbl') is not null
  drop table dbo.U_ECAR835DCS_drvTbl

-- EE Detail


-- Get Emp data
SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
    drvssn = eepssn,
    drvempno = eecempno,
    drvemplstatus = eecemplstatus,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2000',
    drvINS01_yesno ='Y',
    drvINS02_relationship = '18',
    drvINS03_mainttype = '030',
    drvINS04_maintreason = 'XN',    --'AI',
    drvINS05_benstatus = 'A',    --WHEN EepCOBRAIsActive = 'Y' THEN 'C' ELSE 'A' end,
    drvINS06_medicareplan = '',
    drvINS07_cobraqualevent = '',
    drvINS08_emplstatuscode = case
                when eecemplstatus in ('A','L','O','R','S') and eecfulltimeorparttime = 'F' then 'FT'
                when eecemplstatus in ('A','L','O','R','S') then 'PT'
                when eecemplstatus = 'T' then 'TE'
                end,
    drvINS09_studentstatus = ' ',
    drvINS10_handicapind = ' ',
    drvINS11_dateformat = '',
    drvINS12_deathdate = '',
    drvINS17_birthseqnumber = ' ',
    drvNM101_entityidcode = 'IL',
    drvNM102_entitytypequal = '1',
    drvNM103_namelast = dbo.dsi_fnRemoveChars('.,/',Upper(eepNameLast)),
    drvNM104_namefirst = dbo.dsi_fnRemoveChars('.,/',Upper(eepNameFirst)),
    drvNM105_namemiddle  = dbo.dsi_fnRemoveChars('.,/',Upper(substring(eepNameMiddle,1,1))),
    drvNM106_nameprefix = '',--CONVERT(CHAR(1),null),    --dbo.dsi_fnRemoveChars('.,/-Z',upper(eepNamePrefix)),
    drvNM107_namesuffix = '',--convert(char(1),null),    --dbo.dsi_fnRemoveChars('.,/-Z',upper(eepNameSuffix)),
    drvNM108_identcodequal = '34',
    drvNM109identcode = eepssn,
    drvPER01_contfunccode = 'IP',  --IP
    drvPER03_commnum1qual = case when isnull(rtrim(eepphonehomenumber),'') = '' then '' else 'HP' end,
    drvPER04_commnum1 = eepphonehomenumber,
    drvPER05_commnum2qual = case when isnull(rtrim(eepaddressemail),'') = '' then '' else 'EM' end,
    drvPER06_commnum2 = eepaddressemail,
    drvPER07_commnum3qual = '',
    drvPER08_commnum3 = '',
    drvN301_address1 = dbo.dsi_fnRemoveChars('.,/-',Upper(eepAddressLine1)),
    drvN302_address2 = dbo.dsi_fnRemoveChars('.,/-',Upper(eepAddressLine2)),
    drvN401_city  = dbo.dsi_fnRemoveChars('.,/-',Upper(eepAddressCity)),
    drvN402_state = eepAddressState,
    drvN403_zipcode = replace(replace(left(eepAddressZipCode,5),'-',''),' ',''),
    drvN404_country = '',        -- eepAddressCountry
    drvN405_locationqual = '',
    drvN406_location = '',
    drvDMG01_dttmqual = 'D8',
    drvDMG02_dttmperiod = eepdateofbirth,
    drvDMG03_gender = eepgender,
    drvDMG04_maritalstatus = case
                    when eepmaritalstatus = 'M' then 'M'
                    when eepmaritalstatus = 'Z' then 'U'
                    else 'I'
                    end, 
    drvDMG05_ethnic = '',
    drvDMG06_citizenship = '',
    drvICM01_frequency = '',        --'7',
    drvICM02_amount = '',            --eecannsalary,
    drvICM03_hours = '',            --convert(char(20),convert(numeric(12,2),eecScheduledWorkHrs / 2)),    
    drvICM04_location = '',            --CONVERT(varchar(10), jh.jobeffdate, 112),
    drvICM05_salgrade = ''

  into dbo.U_ECAR835DCS_drvTbl
  from dbo.u_ECAR835DCS_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    --left join (select ejheeid, ejhcoid, max(ejhjobeffdate) jobeffdate
        --from vw_int_EmpHJob where ejhisratechange = 'Y' group by ejheeid,ejhcoid) jh on jh.ejheeid = xeeid and jh.ejhcoid = xcoid



--Build Loop 2000 REF Records
if object_id('U_ECAR835DCS_Loop2000_REF') is not null
  drop table dbo.U_ECAR835DCS_Loop2000_REF

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2000',
    drvREF01_refnumqual = '0F',
    drvREF02_refnum = cast(eepssn as varchar(30))

into dbo.U_ECAR835DCS_Loop2000_REF
from dbo.u_ECAR835DCS_eelist 
join emppers on xeeid = eepeeid



-- only include those needed
--insert into dbo.U_ECAR835DCS_Loop2000_REF
--SELECT    DISTINCT
--    drvEEID = xEEID, 
--    drvcoid = xcoid,
--    drvdepid = cast(null as varchar),
--    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2000',
--    drvREF01_refnumqual = 'DX',
--    drvREF02_refnum = '0001'
--from dbo.u_ECAR835DCS_eelist
--join emppers on xeeid = eepeeid 


--insert into dbo.U_ECAR835DCS_Loop2000_REF
--SELECT    DISTINCT
--    drvEEID = xEEID, 
--    drvcoid = xcoid,
--    drvdepid = cast(null as varchar),
--    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2000',
--    drvREF01_refnumqual = 'ZZ',
--    drvREF02_refnum = case
--                when eecorglvl1 = 'CORP' then '0001'
--                else '0002'
--                end
--from dbo.u_ECAR835DCS_eelist 
--join emppers on xeeid = eepeeid
--join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
--join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid


--Build Loop 2000 DTP Records
if object_id('U_ECAR835DCS_Loop2000_DTP') is not null
  drop table dbo.U_ECAR835DCS_Loop2000_DTP

--SELECT    DISTINCT
--    drvEEID = xEEID, 
--    drvcoid = xcoid,
--    drvdepid = cast(null as varchar),
--    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2000',
--    drvDTP01_dttmqual = '336',
--    drvDTP02_dttmformat = 'D8',
--    drvDTP03_dttmperiod = eecdateoflasthire

--into dbo.U_ECAR835DCS_Loop2000_DTP
--from dbo.u_ECAR835DCS_eelist 
--join emppers on xeeid = eepeeid
--join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid


--insert into dbo.U_ECAR835DCS_Loop2000_DTP
--SELECT    DISTINCT
--    drvEEID = xEEID, 
--    drvcoid = xcoid,
--    drvdepid = cast(null as varchar),
--    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2000',
--    drvDTP01_dttmqual = '337',
--    drvDTP02_dttmformat = 'D8',
--    drvDTP03_dttmperiod = eecdateoftermination

--from dbo.u_ECAR835DCS_eelist 
--join emppers on xeeid = eepeeid
--join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
--where eecemplstatus = 'T'



SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2000' ,
    drvDTP01_dttmqual = '303',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = eff.effdate

into dbo.U_ECAR835DCS_Loop2000_DTP
from dbo.u_ECAR835DCS_eelist
    join emppers on xeeid = eepeeid 
    JOIN (SELECT eedeeid eeid, EedCoID coid, MAX(EedBenStartDate) effdate 
                from dbo.U_dsi_bdm_EmpDeductions 
                WHERE EedFormatCode = @FormatCode
                AND EedValidForExport = 'Y'
                group by EedEEID,EedCoID) EFF ON eff.coid = xCOID AND eff.eeid = xEEID


/* only include the dtp's needed

insert into dbo.U_ECAR835DCS_Loop2000_DTP
SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2000' ,
    drvDTP01_dttmqual = '357',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = eedbenstopdate

from dbo.u_ECAR835DCS_eelist 
    join emppers on xeeid = eepeeid
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
  where eedbenstopdate is not null

*/

--Build Loop 2100A AMT Records if needed (must provide joins and fields if needed)
if object_id('U_ECAR835DCS_Loop2100A_AMT') is not null
  drop table dbo.U_ECAR835DCS_Loop2100A_AMT

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2000',
    drvAMT01_amtqual = '',
    drvAMT02_amount = eecAnnSalary

into dbo.U_ECAR835DCS_Loop2100A_AMT
from dbo.u_ECAR835DCS_eelist
join emppers on xeeid = eepeeid
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
where @include_Loop2100Amt = 'Y' 


/* uncomment and fix logic if more than one AMT is needed

insert into dbo.U_ECAR835DCS_Loop2100A_AMT
SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2000',
    drvAMT01_amtqual = '',
    drvAMT02_amount = ''

from dbo.u_ECAR835DCS_eelist
join emppers on xeeid = eepeeid
where @include_Loop2100Amt = 'Y' 


*/ --MWaters added updates to Prod file from copy file 1/12/2024
   --Spencer Kerch Added zip params to copy file for HD04 update 11/5/2023
DECLARE @vaZip varchar(MAX), 
        @gaZip varchar(MAX), 
        @flZip varchar(MAX), 
        @nhZip varchar(MAX); 
SELECT @vaZip = '20101,20102,20103,20104,20105,20106,20108,20109,20110,20111,20112,20113,20115,20116,20117,20118,20119,20120,20121,20122,20124,20128,20129,20130,20131,20132,20134,20135,20136,20137,20138,20139,20140,20141,20142,20143,20144,20146,20147,20148,20149,20151,20152,20153,20155,20156,20158,20159,20160,20163,20164,20165,20166,20167,20168,20169,20170,20171,20172,20175,20176,20177,20178,20180,20181,20182,20184,20185,20186,20187,20188,20189,20190,20191,20192,20194,20195,20196,20197,20198,20598,22025,22026,22030,22033,22035,22039,22066,22067,22079,22095,22096,22101,22102,22103,22124,22125,22134,22135,22172,22180,22181,22182,22183,22185,22191,22192,22193,22194,22195,22401,22402,22403,22404,22405,22406,22407,22408,22412,22427,22428,22430,22432,22433,22435,22436,22437,22438,22442,22443,22446,22448,22451,22454,22456,22460,22463,22469,22471,22472,22473,22476,22480,22481,22482,22485,22488,22501,22503,22504,22507,22508,22509,22511,22513,22514,22517,22520,22523,22524,22526,22528,22529,22530,22534,22535,22538,22539,22542,22544,22545,22546,22547,22548,22551,22552,22553,22554,22555,22556,22558,22560,22565,22567,22570,22572,22576,22577,22578,22579,22580,22581,22601,22602,22603,22604,22610,22611,22620,22622,22623,22624,22625,22626,22627,22630,22637,22639,22640,22641,22642,22643,22644,22645,22646,22649,22650,22652,22654,22655,22656,22657,22660,22663,22664,22701,22709,22711,22712,22713,22714,22715,22716,22718,22719,22720,22722,22723,22724,22725,22726,22727,22728,22729,22730,22731,22732,22733,22734,22735,22736,22737,22738,22739,22740,22741,22742,22743,22746,22747,22748,22749,22801,22802,22803,22807,22810,22811,22812,22815,22820,22821,22824,22827,22830,22831,22832,22833,22834,22835,22840,22841,22842,22843,22844,22845,22846,22847,22848,22849,22850,22851,22853,22901,22902,22903,22904,22905,22906,22907,22908,22909,22910,22911,22920,22922,22923,22924,22931,22932,22935,22936,22937,22938,22939,22940,22942,22943,22945,22946,22947,22948,22949,22952,22957,22958,22959,22960,22963,22964,22965,22967,22968,22969,22971,22972,22973,22974,22976,22980,22987,22989,23001,23002,23003,23004,23005,23009,23011,23014,23015,23018,23021,23022,23023,23024,23025,23027,23030,23031,23032,23035,23038,23039,23040,23043,23045,23047,23050,23055,23056,23058,23059,23060,23061,23062,23063,23064,23065,23066,23067,23068,23069,23070,23071,23072,23075,23076,23079,23081,23083,23084,23085,23086,23089,23090,23091,23092,23093,23102,23103,23105,23106,23107,23108,23109,23110,23111,23112,23113,23114,23115,23116,23117,23119,23120,23123,23124,23125,23126,23127,23128,23129,23130,23131,23138,23139,23140,23141,23146,23147,23148,23149,23150,23153,23154,23155,23156,23160,23161,23162,23163,23168,23169,23170,23173,23175,23176,23177,23178,23180,23181,23183,23184,23185,23186,23187,23188,23190,23192,23218,23219,23220,23221,23222,23223,23224,23225,23226,23227,23228,23229,23230,23231,23232,23233,23234,23235,23236,23237,23238,23241,23242,23249,23250,23255,23260,23261,23269,23273,23274,23276,23278,23279,23282,23284,23285,23286,23288,23289,23290,23291,23292,23293,23294,23295,23297,23298,23301,23302,23303,23304,23306,23307,23308,23310,23313,23314,23315,23316,23320,23321,23322,23323,23324,23325,23326,23327,23328,23336,23337,23341,23345,23347,23350,23354,23356,23357,23358,23359,23389,23395,23396,23397,23398,23399,23401,23404,23405,23407,23408,23409,23410,23412,23413,23414,23415,23416,23417,23418,23419,23420,23421,23422,23423,23424,23426,23427,23429,23430,23431,23432,23433,23434,23435,23436,23437,23438,23439,23440,23441,23442,23443,23450,23451,23452,23453,23454,23455,23456,23457,23458,23459,23460,23461,23462,23463,23464,23465,23466,23467,23471,23479,23480,23482,23483,23486,23487,23488,23501,23502,23503,23504,23505,23506,23507,23508,23509,23510,23511,23513,23514,23515,23517,23518,23519,23523,23529,23541,23551,23601,23602,23603,23604,23605,23606,23607,23608,23609,23612,23628,23630,23651,23661,23662,23663,23664,23665,23666,23667,23668,23669,23670,23681,23690,23691,23692,23693,23694,23696,23701,23702,23703,23704,23705,23707,23708,23709,23801,23803,23804,23805,23806,23821,23822,23824,23827,23828,23829,23830,23831,23832,23833,23834,23836,23837,23838,23839,23840,23841,23842,23843,23844,23845,23846,23847,23850,23851,23856,23857,23860,23866,23867,23868,23870,23872,23873,23874,23875,23876,23878,23879,23881,23882,23883,23884,23885,23887,23888,23889,23890,23891,23893,23894,23897,23898,23899,23901,23909,23915,23917,23919,23920,23921,23922,23923,23924,23927,23930,23934,23936,23937,23938,23939,23941,23942,23943,23944,23947,23950,23952,23954,23955,23958,23959,23960,23962,23963,23964,23966,23967,23968,23970,23974,23976,24001,24002,24003,24004,24005,24006,24007,24008,24009,24010,24011,24012,24013,24014,24015,24016,24017,24018,24019,24020,24022,24023,24024,24025,24026,24027,24028,24029,24030,24031,24032,24033,24034,24035,24036,24037,24038,24040,24042,24043,24050,24053,24054,24055,24058,24059,24060,24061,24062,24063,24064,24065,24066,24067,24068,24069,24070,24072,24073,24076,24077,24078,24079,24082,24083,24084,24085,24086,24087,24088,24089,24090,24091,24092,24093,24095,24101,24102,24104,24105,24111,24112,24113,24114,24115,24120,24121,24122,24124,24126,24127,24128,24129,24130,24131,24132,24133,24134,24136,24137,24138,24139,24141,24142,24143,24146,24147,24148,24149,24150,24151,24153,24155,24157,24161,24162,24165,24167,24168,24171,24174,24175,24176,24177,24178,24179,24184,24185,24201,24202,24203,24205,24209,24210,24211,24212,24215,24216,24217,24218,24219,24220,24221,24224,24225,24226,24228,24230,24236,24237,24239,24243,24244,24245,24246,24248,24250,24251,24256,24258,24260,24263,24265,24266,24269,24270,24271,24272,24273,24277,24279,24280,24281,24282,24283,24290,24292,24293,24301,24311,24312,24313,24314,24315,24316,24317,24318,24319,24322,24323,24324,24325,24326,24327,24328,24330,24333,24340,24343,24347,24348,24350,24351,24352,24354,24360,24361,24363,24366,24368,24370,24374,24375,24377,24378,24380,24381,24382,24401,24402,24411,24412,24413,24415,24416,24421,24422,24426,24430,24431,24432,24433,24435,24437,24438,24439,24440,24441,24442,24445,24448,24450,24457,24458,24459,24460,24463,24464,24465,24467,24469,24471,24472,24473,24474,24476,24477,24479,24482,24483,24484,24485,24486,24487,24501,24502,24503,24504,24505,24506,24513,24514,24515,24517,24520,24521,24522,24523,24526,24527,24528,24529,24530,24531,24533,24534,24535,24536,24538,24539,24540,24541,24543,24549,24550,24551,24553,24554,24555,24556,24557,24558,24562,24563,24565,24566,24569,24570,24571,24572,24574,24576,24577,24578,24579,24580,24581,24586,24588,24589,24590,24592,24593,24594,24595,24597,24598,24599,24601,24602,24603,24604,24605,24606,24607,24608,24609,24612,24613,24614,24619,24620,24622,24624,24627,24628,24630,24631,24634,24635,24637,24639,24640,24641,24646,24647,24649,24651,24656,24657,24658'
      ,@gaZip = '30002,30003,30004,30005,30006,30007,30008,30009,30010,30011,30012,30013,30014,30015,30016,30017,30018,30019,30021,30022,30023,30024,30025,30026,30028,30029,30030,30031,30032,30033,30034,30035,30036,30037,30038,30039,30040,30041,30042,30043,30044,30045,30046,30047,30048,30049,30052,30054,30055,30056,30058,30060,30061,30062,30063,30064,30065,30066,30067,30068,30069,30070,30071,30072,30074,30075,30076,30077,30078,30079,30080,30081,30082,30083,30084,30085,30086,30087,30088,30090,30091,30092,30093,30094,30095,30096,30097,30098,30099,30101,30102,30103,30104,30105,30106,30107,30108,30109,30110,30111,30112,30113,30114,30115,30116,30117,30118,30119,30120,30121,30122,30123,30124,30125,30126,30127,30129,30132,30133,30134,30135,30137,30138,30139,30140,30141,30142,30143,30144,30145,30146,30147,30148,30149,30150,30151,30152,30153,30154,30156,30157,30160,30161,30162,30164,30165,30168,30169,30170,30171,30172,30173,30175,30176,30177,30178,30179,30180,30182,30183,30184,30185,30187,30188,30189,30204,30205,30206,30212,30213,30214,30215,30216,30217,30218,30220,30222,30223,30224,30228,30229,30230,30233,30234,30236,30237,30238,30240,30241,30248,30250,30251,30252,30253,30256,30257,30258,30259,30260,30261,30263,30264,30265,30266,30268,30269,30270,30271,30272,30273,30274,30275,30276,30277,30281,30284,30285,30286,30287,30288,30289,30290,30291,30292,30293,30294,30295,30296,30297,30298,30301,30302,30303,30304,30305,30306,30307,30308,30309,30310,30311,30312,30313,30314,30315,30316,30317,30318,30319,30320,30321,30322,30324,30325,30326,30327,30328,30329,30331,30332,30333,30334,30336,30337,30338,30339,30340,30341,30342,30343,30344,30345,30346,30348,30349,30350,30353,30354,30355,30356,30357,30358,30359,30360,30361,30362,30363,30364,30366,30368,30369,30370,30371,30374,30375,30377,30378,30380,30384,30385,30388,30392,30394,30396,30398,30401,30410,30411,30412,30413,30414,30415,30417,30420,30421,30423,30424,30425,30426,30427,30428,30429,30434,30436,30438,30439,30441,30442,30445,30446,30447,30448,30449,30450,30451,30452,30453,30454,30455,30456,30457,30458,30459,30460,30461,30464,30467,30470,30471,30473,30474,30475,30477,30499,30501,30502,30503,30504,30506,30507,30510,30511,30512,30513,30514,30515,30516,30517,30518,30519,30520,30521,30522,30523,30525,30527,30528,30529,30530,30531,30533,30534,30535,30536,30537,30538,30539,30540,30541,30542,30543,30545,30546,30547,30548,30549,30552,30553,30554,30555,30557,30558,30559,30560,30562,30563,30564,30565,30566,30567,30568,30571,30572,30573,30575,30576,30577,30580,30581,30582,30597,30598,30599,30601,30602,30603,30604,30605,30606,30607,30608,30609,30612,30619,30620,30621,30622,30623,30624,30625,30627,30628,30629,30630,30631,30633,30634,30635,30638,30639,30641,30642,30643,30645,30646,30647,30648,30650,30655,30656,30660,30662,30663,30664,30665,30666,30667,30668,30669,30671,30673,30677,30678,30680,30683,30701,30703,30705,30707,30708,30710,30711,30719,30720,30721,30722,30724,30725,30726,30728,30730,30731,30732,30733,30734,30735,30736,30738,30739,30740,30741,30742,30746,30747,30750,30751,30752,30753,30755,30756,30757,30802,30803,30805,30806,30807,30808,30809,30810,30811,30812,30813,30814,30815,30816,30817,30818,30819,30820,30821,30822,30823,30824,30828,30830,30833,30901,30903,30904,30905,30906,30907,30909,30912,30914,30916,30917,30919,30999,31001,31002,31003,31004,31005,31006,31007,31008,31009,31010,31011,31012,31013,31014,31015,31016,31017,31018,31019,31020,31021,31022,31023,31024,31025,31026,31027,31028,31029,31030,31031,31032,31033,31034,31035,31036,31037,31038,31039,31040,31041,31042,31044,31045,31046,31047,31049,31050,31051,31052,31054,31055,31057,31058,31059,31060,31061,31062,31063,31064,31065,31066,31067,31068,31069,31070,31071,31072,31075,31076,31077,31078,31079,31081,31082,31083,31084,31085,31086,31087,31088,31089,31090,31091,31092,31093,31094,31095,31096,31097,31098,31099,31106,31107,31119,31126,31131,31136,31139,31141,31145,31146,31150,31156,31169,31192,31193,31195,31196,31201,31202,31203,31204,31205,31206,31207,31208,31209,31210,31211,31213,31216,31217,31220,31221,31294,31295,31296,31297,31301,31302,31303,31304,31305,31307,31308,31309,31310,31312,31313,31314,31315,31316,31318,31319,31320,31321,31322,31323,31324,31326,31327,31328,31329,31331,31333,31401,31402,31403,31404,31405,31406,31407,31408,31409,31410,31411,31412,31414,31415,31416,31418,31419,31420,31421,31501,31502,31503,31510,31512,31513,31515,31516,31518,31519,31520,31521,31522,31523,31524,31525,31527,31532,31533,31534,31535,31537,31539,31542,31543,31544,31545,31546,31547,31548,31549,31550,31551,31552,31553,31554,31555,31556,31557,31558,31560,31561,31562,31563,31564,31565,31566,31567,31568,31569,31598,31599,31601,31602,31603,31604,31605,31606,31620,31622,31623,31624,31625,31626,31627,31629,31630,31631,31632,31634,31635,31636,31637,31638,31639,31641,31642,31643,31645,31647,31648,31649,31650,31698,31699,31701,31702,31703,31704,31705,31706,31707,31708,31709,31711,31712,31714,31716,31719,31720,31721,31722,31727,31730,31733,31735,31738,31739,31743,31744,31747,31749,31750,31753,31756,31757,31758,31760,31763,31764,31765,31768,31769,31771,31772,31773,31774,31775,31776,31778,31779,31780,31781,31782,31783,31784,31787,31788,31789,31790,31791,31792,31793,31794,31795,31796,31798,31799,31801,31803,31804,31805,31806,31807,31808,31810,31811,31812,31814,31815,31816,31820,31821,31822,31823,31824,31825,31826,31827,31829,31830,31831,31832,31833,31836,31901,31902,31903,31904,31905,31906,31907,31908,31909,31914,31917,31993,31995,31997,31998,31999,39813,39815,39817,39818,39819,39823,39824,39825,39826,39827,39828,39829,39832,39834,39836,39837,39840,39841,39842,39845,39846,39851,39852,39854,39859,39861,39862,39866,39867,39870,39877,39885,39886,39897,39901'
      ,@flZip = '32003,32004,32006,32007,32008,32009,32011,32013,32024,32025,32030,32033,32034,32035,32038,32040,32041,32042,32043,32044,32046,32050,32052,32053,32054,32055,32056,32058,32059,32060,32061,32062,32063,32064,32065,32066,32067,32068,32071,32073,32079,32080,32081,32082,32083,32084,32085,32086,32087,32091,32092,32094,32095,32096,32097,32099,32102,32105,32110,32111,32112,32113,32114,32115,32116,32117,32118,32119,32120,32121,32122,32123,32124,32125,32126,32127,32128,32129,32130,32131,32132,32133,32134,32135,32136,32137,32138,32139,32140,32141,32142,32143,32145,32147,32148,32149,32157,32158,32159,32160,32162,32163,32164,32168,32169,32170,32173,32174,32175,32176,32177,32178,32179,32180,32181,32182,32183,32185,32187,32189,32190,32192,32193,32195,32198,32201,32202,32203,32204,32205,32206,32207,32208,32209,32210,32211,32212,32214,32216,32217,32218,32219,32220,32221,32222,32223,32224,32225,32226,32227,32228,32229,32231,32232,32233,32234,32235,32236,32238,32239,32240,32241,32244,32245,32246,32247,32250,32254,32255,32256,32257,32258,32259,32260,32266,32277,32301,32302,32303,32304,32305,32306,32307,32308,32309,32310,32311,32312,32313,32314,32315,32316,32317,32318,32320,32321,32322,32323,32324,32326,32327,32328,32329,32330,32331,32332,32333,32334,32335,32336,32337,32340,32341,32343,32344,32345,32346,32347,32348,32350,32351,32352,32353,32355,32356,32357,32358,32359,32360,32361,32362,32399,32401,32402,32403,32404,32405,32406,32407,32408,32409,32410,32411,32412,32413,32417,32420,32421,32422,32423,32424,32425,32426,32427,32428,32430,32431,32432,32433,32434,32435,32437,32438,32439,32440,32442,32443,32444,32445,32446,32447,32448,32449,32452,32455,32456,32457,32459,32460,32461,32462,32463,32464,32465,32466,32501,32502,32503,32504,32505,32506,32507,32508,32509,32511,32512,32513,32514,32516,32520,32521,32522,32523,32524,32526,32530,32531,32533,32534,32535,32536,32537,32538,32539,32540,32541,32542,32544,32547,32548,32549,32550,32559,32560,32561,32562,32563,32564,32565,32566,32567,32568,32569,32570,32571,32572,32577,32578,32579,32580,32583,32588,32591,32601,32602,32603,32604,32605,32606,32607,32608,32609,32610,32611,32612,32614,32615,32616,32617,32618,32619,32621,32622,32625,32626,32627,32628,32631,32633,32634,32635,32639,32640,32641,32643,32644,32648,32653,32654,32655,32656,32658,32662,32663,32664,32666,32667,32668,32669,32680,32681,32683,32686,32692,32693,32694,32696,32697,32701,32702,32703,32704,32706,32707,32708,32709,32710,32712,32713,32714,32715,32716,32718,32719,32720,32721,32722,32723,32724,32725,32726,32727,32728,32730,32732,32733,32735,32736,32738,32739,32744,32745,32746,32747,32750,32751,32752,32753,32754,32756,32757,32759,32762,32763,32764,32765,32766,32767,32768,32771,32772,32773,32774,32775,32776,32777,32778,32779,32780,32781,32783,32784,32789,32790,32791,32792,32793,32794,32795,32796,32798,32799,32801,32802,32803,32804,32805,32806,32807,32808,32809,32810,32811,32812,32814,32815,32816,32817,32818,32819,32820,32821,32822,32824,32825,32826,32827,32828,32829,32830,32831,32832,32833,32834,32835,32836,32837,32839,32853,32854,32855,32856,32857,32858,32859,32860,32861,32862,32867,32868,32869,32872,32877,32878,32885,32886,32887,32891,32896,32897,32899,32901,32902,32903,32904,32905,32906,32907,32908,32909,32910,32911,32912,32919,32920,32922,32923,32924,32925,32926,32927,32931,32932,32934,32935,32936,32937,32940,32941,32948,32949,32950,32951,32952,32953,32954,32955,32956,32957,32958,32959,32960,32961,32962,32963,32964,32965,32966,32967,32968,32969,32970,32971,32976,32978,33001,33002,33004,33008,33009,33010,33011,33012,33013,33014,33015,33016,33017,33018,33019,33020,33021,33022,33023,33024,33025,33026,33027,33028,33029,33030,33031,33032,33033,33034,33035,33036,33037,33039,33040,33041,33042,33043,33045,33050,33051,33052,33054,33055,33056,33060,33061,33062,33063,33064,33065,33066,33067,33068,33069,33070,33071,33072,33073,33074,33075,33076,33077,33081,33082,33083,33084,33090,33092,33093,33097,33101,33102,33106,33109,33111,33112,33114,33116,33119,33122,33124,33125,33126,33127,33128,33129,33130,33131,33132,33133,33134,33135,33136,33137,33138,33139,33140,33141,33142,33143,33144,33145,33146,33147,33149,33150,33151,33152,33153,33154,33155,33156,33157,33158,33160,33161,33162,33163,33164,33165,33166,33167,33168,33169,33170,33172,33173,33174,33175,33176,33177,33178,33179,33180,33181,33182,33183,33184,33185,33186,33187,33188,33189,33190,33191,33192,33193,33194,33195,33196,33197,33198,33199,33206,33222,33231,33233,33234,33238,33239,33242,33243,33245,33247,33255,33256,33257,33261,33265,33266,33269,33280,33283,33296,33299,33301,33302,33303,33304,33305,33306,33307,33308,33309,33310,33311,33312,33313,33314,33315,33316,33317,33318,33319,33320,33321,33322,33323,33324,33325,33326,33327,33328,33329,33330,33331,33332,33334,33335,33336,33337,33338,33339,33340,33345,33346,33348,33349,33351,33355,33359,33388,33394,33401,33402,33403,33404,33405,33406,33407,33408,33409,33410,33411,33412,33413,33414,33415,33416,33417,33418,33419,33420,33421,33422,33424,33425,33426,33427,33428,33429,33430,33431,33432,33433,33434,33435,33436,33437,33438,33440,33441,33442,33443,33444,33445,33446,33448,33449,33454,33455,33458,33459,33460,33461,33462,33463,33464,33465,33466,33467,33468,33469,33470,33471,33472,33473,33474,33475,33476,33477,33478,33480,33481,33482,33483,33484,33486,33487,33488,33493,33496,33497,33498,33499,33503,33508,33509,33510,33511,33513,33514,33521,33523,33524,33525,33526,33527,33530,33534,33537,33538,33539,33540,33541,33542,33543,33544,33545,33547,33548,33549,33550,33556,33558,33559,33563,33564,33565,33566,33567,33568,33569,33570,33571,33572,33573,33574,33575,33576,33578,33579,33583,33584,33585,33586,33587,33592,33593,33594,33595,33596,33597,33598,33601,33602,33603,33604,33605,33606,33607,33608,33609,33610,33611,33612,33613,33614,33615,33616,33617,33618,33619,33620,33621,33622,33623,33624,33625,33626,33629,33630,33631,33633,33634,33635,33637,33646,33647,33650,33655,33660,33664,33672,33673,33674,33675,33677,33679,33680,33681,33682,33684,33685,33686,33687,33688,33689,33694,33701,33702,33703,33704,33705,33706,33707,33708,33709,33710,33711,33712,33713,33714,33715,33716,33729,33730,33731,33732,33733,33734,33736,33738,33740,33741,33742,33743,33744,33747,33755,33756,33757,33758,33759,33760,33761,33762,33763,33764,33765,33766,33767,33769,33770,33771,33772,33773,33774,33775,33776,33777,33778,33779,33780,33781,33782,33784,33785,33786,33801,33802,33803,33804,33805,33806,33807,33809,33810,33811,33812,33813,33815,33820,33823,33825,33826,33827,33830,33831,33834,33835,33836,33837,33838,33839,33840,33841,33843,33844,33845,33846,33847,33848,33849,33850,33851,33852,33853,33854,33855,33856,33857,33858,33859,33860,33862,33863,33865,33867,33868,33870,33871,33872,33873,33875,33876,33877,33880,33881,33882,33883,33884,33885,33888,33890,33896,33897,33898,33901,33902,33903,33904,33905,33906,33907,33908,33909,33910,33911,33912,33913,33914,33915,33916,33917,33918,33919,33920,33921,33922,33924,33927,33928,33929,33930,33931,33932,33935,33936,33938,33944,33945,33946,33947,33948,33949,33950,33951,33952,33953,33954,33955,33956,33957,33960,33965,33966,33967,33970,33971,33972,33973,33974,33975,33976,33980,33981,33982,33983,33990,33991,33993,33994,34101,34102,34103,34104,34105,34106,34107,34108,34109,34110,34112,34113,34114,34116,34117,34119,34120,34133,34134,34135,34136,34137,34138,34139,34140,34141,34142,34143,34145,34146,34201,34202,34203,34204,34205,34206,34207,34208,34209,34210,34211,34212,34215,34216,34217,34218,34219,34220,34221,34222,34223,34224,34228,34229,34230,34231,34232,34233,34234,34235,34236,34237,34238,34239,34240,34241,34242,34243,34249,34250,34251,34260,34264,34265,34266,34267,34268,34269,34270,34272,34274,34275,34276,34277,34280,34281,34282,34284,34285,34286,34287,34288,34289,34290,34291,34292,34293,34295,34420,34421,34423,34428,34429,34430,34431,34432,34433,34434,34436,34441,34442,34445,34446,34447,34448,34449,34450,34451,34452,34453,34460,34461,34464,34465,34470,34471,34472,34473,34474,34475,34476,34477,34478,34479,34480,34481,34482,34483,34484,34487,34488,34489,34491,34492,34498,34601,34602,34603,34604,34605,34606,34607,34608,34609,34610,34611,34613,34614,34636,34637,34638,34639,34652,34653,34654,34655,34656,34660,34661,34667,34668,34669,34673,34674,34677,34679,34680,34681,34682,34683,34684,34685,34688,34689,34690,34691,34692,34695,34697,34698,34705,34711,34712,34713,34714,34715,34729,34731,34734,34736,34737,34739,34740,34741,34742,34743,34744,34745,34746,34747,34748,34749,34753,34755,34756,34758,34759,34760,34761,34762,34769,34770,34771,34772,34773,34777,34778,34785,34786,34787,34788,34789,34797,34945,34946,34947,34948,34949,34950,34951,34952,34953,34954,34956,34957,34958,34972,34973,34974,34979,34981,34982,34983,34984,34985,34986,34987,34988,34990,34991,34992,34994,34995,34996,34997'
      ,@nhZip = '03031,03032,03033,03034,03036,03037,03038,03040,03041,03042,03043,03044,03045,03046,03047,03048,03049,03051,03052,03053,03054,03055,03057,03060,03061,03062,03063,03064,03070,03071,03073,03076,03077,03079,03082,03084,03086,03087,03101,03102,03103,03104,03105,03106,03108,03109,03110,03111,03215,03216,03217,03218,03220,03221,03222,03223,03224,03225,03226,03227,03229,03230,03231,03233,03234,03235,03237,03238,03240,03241,03242,03243,03244,03245,03246,03247,03249,03251,03252,03253,03254,03255,03256,03257,03258,03259,03260,03261,03262,03263,03264,03266,03268,03269,03272,03273,03275,03276,03278,03279,03280,03281,03282,03284,03285,03287,03289,03290,03291,03293,03298,03299,03301,03302,03303,03304,03305,03307,03431,03435,03440,03441,03442,03443,03444,03445,03446,03447,03448,03449,03450,03451,03452,03455,03456,03457,03458,03461,03462,03464,03465,03466,03467,03468,03469,03470,03561,03570,03574,03575,03576,03579,03580,03581,03582,03583,03584,03585,03586,03588,03589,03590,03592,03593,03595,03597,03598,03601,03602,03603,03604,03605,03607,03608,03609,03740,03741,03743,03745,03746,03748,03749,03750,03751,03752,03753,03754,03755,03756,03765,03766,03768,03769,03770,03771,03773,03774,03777,03779,03780,03781,03782,03784,03785,03801,03802,03803,03804,03809,03810,03811,03812,03813,03814,03815,03816,03817,03818,03819,03820,03821,03822,03823,03824,03825,03826,03827,03830,03832,03833,03835,03836,03837,03838,03839,03840,03841,03842,03843,03844,03845,03846,03847,03848,03849,03850,03851,03852,03853,03854,03855,03856,03857,03858,03859,03860,03861,03862,03864,03865,03866,03867,03868,03869,03870,03871,03872,03873,03874,03875,03878,03882,03883,03884,03885,03886,03887,03890,03894,03896,03897'


-- Now build coverage data  HD Loop 2300
if object_id('U_ECAR835DCS_Loop2300_HD') is not null
  drop table dbo.U_ECAR835DCS_Loop2300_HD

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300' + eeddedcode,
    drvHD01_mainttype = '030',
    drvHD02_maintreason = '',
    drvHD03_inslinecode = 'HLT',
    --drvHD04_plancovdesc = '', 
    
    --Group Numbers    See Worksheet 'HD04'. Values are provided once the CareFirst Group Structure (benefits) are approved by the account.
    --MIHSA    Medical - HSA    5801553DC10
    --MIPPO    Medical - PPO    5801555DC10

    
--Product ID        "Group Number"                    NASCO Package Code                NASCO Department #                Rate Modifier                    
--"1-3 a/n -3"    "4-23 a/n-20 Left Justified"    "24-28 a/n-5 Left Justified"    "29-37 a/n-9 Left Justified"    "37-41 a/n-4 Left Justified"

--Status        Home Plan        Control Plan    Product Process Indicator    Product Process Indicator
--"42 a/n-1"    "43-45 a/n-3"    "46-48 a/n-3"    "49 a/n-1"                    "50 a/n-1"





    drvHD04_plancovdesc = 'NAS' + 
                            --GROUP NUMBER
                            CASE 
                                WHEN EedDedCode IN ('MIHSA') then '5803769'--'5801553DC10         '
                                WHEN EedDedCode IN ('MIPPO') then '5803771'--'5801555DC10         '
                                end +
                            CASE WHEN @vaZip like concat('%',replace(replace(left(eepAddressZipCode,5),'-',''),' ',''),'%') then 'VA10'
                            WHEN  @gaZip like concat('%',replace(replace(left(eepAddressZipCode,5),'-',''),' ',''),'%') then 'GA10'
                            WHEN  @flZip like concat('%',replace(replace(left(eepAddressZipCode,5),'-',''),' ',''),'%') then 'FL10'
                            WHEN  @nhZip like concat('%',replace(replace(left(eepAddressZipCode,5),'-',''),' ',''),'%') then 'NH10'
                            else 'DC10'
                            end +
                            '         ' +
                            --NASCO Package Code
                            --"Values:
                            --006 - IND
                            --016  - H&W/P&C/FAM/SAME SEX SPOUSE"
                            -- select * from BenOpt
                               CASE WHEN eedbenoption = 'EE' then '006'
                                    WHEN eedbenoption IN ('EES', 'EEC',  'EEF')  then '016' -- updated 1/10/24
                                    WHEN eedbenoption= 'EEDP' then '026'-- updated 1/10/24
                                    WHEN eedbenoption= 'EEDPF' then '036'-- updated 1/10/24
                            --WHEN eedbenoption IN ('EES', 'EEC', 'EEDP')  then '026' removed
                            --WHEN eedbenoption IN ('EEDPF',  'EEF')  then '036' removed
                                ELSE '016' END +
                            '  '+
                            --NASCO Department # 
                            --11/08/16 BJ PR-204700
                            CASE 
                                WHEN EedDedCode IN ('MIHSA') then '00001KA4U'--'00000K74W'
                                WHEN EedDedCode IN ('MIPPO') then '00001KA4V'--'00000K9QQ'
                                end +
                            /*CASE WHEN EedDedCode IN ('MIHSA') then 
                                    CASE 
                                        WHEN EecLocation IN ('VAARL','VADAH','VADUM','VAFB','VAHQ','VAMC','VAPENT','VAREM1') then '00001K8QZ'
                                        WHEN EecLocation IN ('VAPORT') then '00001K8RB'
                                        WHEN EecLocation IN ('MDPAX','MDREM1') then '00001K8RD'
                                        WHEN EecLocation IN ('MDABNG','MDAPG') then '00001K8RF'
                                        WHEN EecLocation IN ('CAMAGU','CARDGC') then '00001K8RH'
                                        WHEN EecLocation IN ('MIREM1','MIWAR') then '00001K8RK'
                                        WHEN EecLocation IN ('OHDAY','OHDAYD','OHREM1','OHREM2','OHREM3') then '00001K8RM'
                                        WHEN EecLocation IN ('MABOS','NHNASH','NHREM1') then '00001K8RP'
                                        WHEN EecLocation IN ('ALHUNT','ALREM1') then '00001K8RR'
                                        WHEN EecLocation IN ('FLGCST','FLREM1') then '00001K8RT'
                                        WHEN EecLocation IN ('CASAND') then '00001K8RV'
                                        WHEN EecLocation IN ('AZREM1','CAEAFB','DEREM1','GAFB','GAREM1','ILREM1','KYFC','KYREM1','MNREM1','MSVICK','NCMCAS','NJREM1','NMWSO','NVREM1','NYREM1','OKREM1','PAPHIL','PAREM1','PAREM2','PAREM3','SCREM1','TNREM2','TXEPD','TXREM1','TXSAD','WAJBLM','WAREM1','MOSTL') --added MOSTL 8/1/2016 DA
                                            then '00001K8RX' END --added MOSTL 8/1/2016 DA --08/05/16 BJ SF 07373815
                                 WHEN EedDedCode IN ('MIPPO') then 
                                    CASE 
                                        WHEN EecLocation IN ('VAARL','VADAH','VADUM','VAFB','VAHQ','VAMC','VAPENT','VAREM1') then '00001K8RZ'
                                        WHEN EecLocation IN ('VAPORT') then '00001K8XC'
                                        WHEN EecLocation IN ('MDPAX','MDREM1') then '00001K8XG'
                                        WHEN EecLocation IN ('MDABNG','MDAPG') then '00001K8AB'
                                        WHEN EecLocation IN ('CAMAGU','CARDGC') then '00001K8AF'
                                        WHEN EecLocation IN ('MIREM1','MIWAR') then '00001K8BV'
                                        WHEN EecLocation IN ('OHDAY','OHDAYD','OHREM1','OHREM2','OHREM3') then '00001K8SA'
                                        WHEN EecLocation IN ('MABOS','NHNASH','NHREM1') then '00001K8XD'
                                        WHEN EecLocation IN ('ALHUNT','ALREM1') then '00001K8XH'
                                        WHEN EecLocation IN ('FLGCST','FLREM1') then '00001K8AC'
                                        WHEN EecLocation IN ('CASAND') then '00001K8BS'
                                        WHEN EecLocation IN ('AZREM1','CAEAFB','DEREM1','GAFB','GAREM1','ILREM1','KYFC','KYREM1','MNREM1','MSVICK','NCMCAS','NJREM1','NMWSO','NVREM1','NYREM1','OKREM1','PAPHIL','PAREM1','PAREM2','PAREM3','SCREM1','TNREM2','TXEPD','TXREM1','TXSAD','WAJBLM','WAREM1','MOSTL') --added MOSTL 8/1/2016 DA
                                            then '00001K8BW' END--08/05/16 BJ SF 07373815
                                 end +*/
                                 --Rate Modifier
                                 '    ' +
                                 --Status
                                 'A' +
                                 --Home Plan
                                 --CASE WHEN LEFT(LTRIM(eepaddresszipcode),3) IN ('210','211','212','213','214','215','216','217','218','219')
                                CASE WHEN LEFT(LTRIM(eepaddresszipcode),3) BETWEEN '210' AND '219'
                                                                 then '690'
                                                                 else '580' end +
                                '580FV'  ,
                                    
    --EE        0    Employee Only
    --EES       0    Employee + Spouse
    --EEC       0    Employee + Child
    --EEF       0    Employee + Family
    --EEDP      0    Emp + Domestic Partner
    --EEDPF     0    Emp + Dom Partner Family
    drvHD05_covlvl = CASE eedbenoption
                WHEN 'EE' then 'IND'
                WHEN 'EEC' then 'ECH'
                WHEN 'EES' then 'ESP'
                WHEN 'EEDP' then 'ESP'
                WHEN 'EEF' then 'FAM'
                WHEN 'EEDPF' then 'FAM'
            else ''    end

into dbo.U_ECAR835DCS_Loop2300_HD
from dbo.u_ECAR835DCS_eelist 
    join empPers with (nolock) on xEEID = eepEEID
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
        --JOIN dbo.EmpDedFull WITH (NOLOCK) on EedCoID = xCOID AND EedEEID = xEEID
WHERE eeddedcode IN ('MIHSA','MIPPO') -- Updated 1/10/2024


-- Now build coverage data DTP Loop 2300
if object_id('U_ECAR835DCS_Loop2300_DTP') is not null
  drop table dbo.U_ECAR835DCS_Loop2300_DTP

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300' + eeddedcode,
    drvDTP01_dttmqual = '348',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = case when eedbenstartdate < @PlanDate then @PlanDate else eedbenstartdate end

into dbo.U_ECAR835DCS_Loop2300_DTP
from dbo.u_ECAR835DCS_eelist
    join emppers on xeeid = eepeeid 
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID

insert into dbo.U_ECAR835DCS_Loop2300_DTP
SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300' + eeddedcode,
    drvDTP01_dttmqual = '349',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = eedbenstopdate

from dbo.u_ECAR835DCS_eelist 
    join emppers on xeeid = eepeeid
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
  where eedbenstopdate is not null



-- Now build coverage data AMT Loop 2300 if needed
if object_id('U_ECAR835DCS_Loop2300_AMT') is not null
  drop table dbo.U_ECAR835DCS_Loop2300_AMT

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300' + eeddedcode,
    drvAMT01_amtqual = cast('' as varchar(18)),
    drvAMT02_amount = ''

into dbo.U_ECAR835DCS_Loop2300_AMT
from dbo.u_ECAR835DCS_eelist 
    join emppers on eepeeid = xeeid
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
  where @include_Loop2300Amt = 'Y' 


/* uncomment and fix logic if more than one AMT is needed
insert into dbo.U_ECAR835DCS_Loop2300_AMT
SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = dedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300' + dedcode,
    drvAMT01_amtqual = '',
    drvAMT02_amount = ''

from dbo.u_ECAR835DCS_eelist
    join emppers on eepeeid = xeeid
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
 where @include_Loop2300Amt = 'Y' 

*/

-- Build Coverage Level REF Loop 2300 if needed (must provided joins and data)
if object_id('U_ECAR835DCS_Loop2300_REF') is not null
  drop table dbo.U_ECAR835DCS_Loop2300_REF

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300' + eeddedcode,
    drvREF01_refidentqual = '1L',
    drvREF02_refident = ''

into dbo.U_ECAR835DCS_Loop2300_REF
from dbo.u_ECAR835DCS_eelist 
    join emppers on eepeeid = xeeid
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
  where @include_Loop2300ref = 'Y' 

/* uncomment and fix logic if more than one REF is needed
insert into dbo.U_ECAR835DCS_Loop2300_REF
SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = dedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300',
    drvREF01_refidentqual = '',
    drvREF02_refident = ''

from dbo.u_ECAR835DCS_eelist 
    join emppers on eepeeid = xeeid
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
    where @include_Loop2300ref = 'Y' 
*/ 




/*
-- Include this section if the vendor needs a separate prescription RX

INSERT into dbo.U_ECAR835DCS_Loop2300_HD  -- RX
SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300' + 'Rx',
    drvHD01_mainttype = '030',
    drvHD02_maintreason = '',
    drvHD03_inslinecode = 'PDG',
    drvHD04_plancovdesc = '00010001',
    drvHD05_covlvl = case when eedbenoption in ('EE') then 'EMP'
                          when eedbenoption in ('EEC') then 'ECH'
                          when eedbenoption in ('EES') then 'ESP'
                          when eedbenoption in ('EEF') then 'FAM'
                     else '' end

from dbo.u_ECAR835DCS_eelist 
    join empPers with (nolock) on xEEID = eepEEID
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
    where deddedtype = 'MED'




insert into dbo.U_ECAR835DCS_Loop2300_DTP  --Rx
SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300' + 'Rx',
    drvDTP01_dttmqual = '348',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = case when eedbenstartdate < @PlanDate then @PlanDate else eedbenstartdate end

from dbo.u_ECAR835DCS_eelist
    join emppers on xeeid = eepeeid
    join vw_int_EmpComp on eeceeid = xeeid and eeccoid = xcoid 
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
    where deddedtype = 'MED'

insert into dbo.U_ECAR835DCS_Loop2300_DTP    --Rx
SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300' + 'Rx',
    drvDTP01_dttmqual = '349',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = eedbenstopdate

from dbo.u_ECAR835DCS_eelist 
    join emppers on xeeid = eepeeid
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
  where eedbenstopdate is not null
    and deddedtype = 'MED'


INSERT into dbo.U_ECAR835DCS_Loop2300_REF
SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2300' + 'Rx',
    drvREF01_refidentqual = '1L',
    drvREF02_refident = ''

from dbo.u_ECAR835DCS_eelist 
    join emppers on eepeeid = xeeid
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
  where @include_Loop2300ref = 'Y' 
    and deddedtype = 'MED'

*/



-- Build Coverage Level LX and NM1 Loop 2310 if needed (Primary Care Provider PCP information)
if object_id('U_ECAR835DCS_Loop2310_NM1') is not null
  drop table dbo.U_ECAR835DCS_Loop2310_NM1

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2310' + eeddedcode,
    drvNM101_refidentqual = 'P3',        --P3 = pcp/doctor; QN = dentist; OD = optometrist; Y2 = managed care organaization; other codes available also
    drvNM102_refident = '1',            --1 = person, 2 = non-person entity
    drvNM103_lname = '',
    drvNM104_fname = '',
    drvNM105_mname = '',
    drvNM106_prefix = '',
    drvNM107_suffix = '',
    drvNM108_qualifier = 'SV',            --sv = service provider number; 34 = ssn; fi = federal tax no.
    drvNM109_idcode = eedprimarycarephysid,
    drvNM110_relation = '72'            --72 = unknown relation; 25 = established patient; 26 = not established

into dbo.U_ECAR835DCS_Loop2310_NM1
from dbo.u_ECAR835DCS_eelist 
    join emppers on eepeeid = xeeid
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y' 
        AND EedCOID = xCOID AND EedEEID = xEEID
  where @include_Loop2310nm1 = 'Y'
    and isnull(eedprimarycarephysid,'') <> ''






-- Build N1 Loop 2750 if needed (Reporting Category)  (2700 loop is created after this)
if object_id('U_ECAR835DCS_Loop2750_N1') is not null
  drop table dbo.U_ECAR835DCS_Loop2750_N1

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = '',    --eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2750',    -- + eeddedcode,
    drvN101_refidentqual = '75',
    drvN102_refident = 'rrr'

into dbo.U_ECAR835DCS_Loop2750_N1
from dbo.u_ECAR835DCS_eelist 
    join emppers on eepeeid = xeeid
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join jobcode with (nolock) on eecjobcode = jbcjobcode
--    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
--        AND EedValidForExport = 'Y' 
--        AND EedCOID = xCOID AND EedEEID = xEEID
  where @include_Loop2750n1 = 'Y'



-- Build REF Loop 2750 if needed (Reporting Category REF)
if object_id('U_ECAR835DCS_Loop2750_REF') is not null
  drop table dbo.U_ECAR835DCS_Loop2750_REF

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = '',    --eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2755',    -- + eeddedcode,
    drvREF01_refidentqual = '18',                        --00 = district; 17 = client reporting; 18 = plan no; 19 = division; 3L = branch; LU = location; many others available
    drvREF02_refident = 'pppp'

into dbo.U_ECAR835DCS_Loop2750_REF
from dbo.u_ECAR835DCS_eelist 
    join emppers on eepeeid = xeeid
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join jobcode with (nolock) on eecjobcode = jbcjobcode
--    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
--        AND EedValidForExport = 'Y' 
--        AND EedCOID = xCOID AND EedEEID = xEEID
  where @include_Loop2750ref = 'Y'



-- Build DTP Loop 2750 if needed (Reporting Category REF)
if object_id('U_ECAR835DCS_Loop2750_DTP') is not null
  drop table dbo.U_ECAR835DCS_Loop2750_DTP

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = '',    --eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2757',    -- + eeddedcode,
    drvDTP01_dttmqual = '007',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = eecdateoflasthire

into dbo.U_ECAR835DCS_Loop2750_DTP
from dbo.u_ECAR835DCS_eelist 
    join emppers on eepeeid = xeeid
    join vw_int_EmpComp on eeceeid = xeeid and eeccoid = xcoid
--    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
--        AND EedValidForExport = 'Y' 
--        AND EedCOID = xCOID AND EedEEID = xEEID
  where @include_Loop2750dtp = 'Y'



-- Build LS Loop 2700
if object_id('U_ECAR835DCS_Loop2700_LS') is not null
  drop table dbo.U_ECAR835DCS_Loop2700_LS

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = '',    --eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2700'

into dbo.U_ECAR835DCS_Loop2700_LS 
from dbo.u_ECAR835DCS_eelist
    join emppers on eepeeid = xeeid
    join dbo.U_ECAR835DCS_Loop2750_N1 on xeeid = drveeid and xcoid = drvcoid
  where @include_Loop2750n1 = 'Y'


-- Build LE Loop 2700
if object_id('U_ECAR835DCS_Loop2700_LE') is not null
  drop table dbo.U_ECAR835DCS_Loop2700_LE

SELECT    DISTINCT
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvdedcode = '',    --eeddedcode,
    drvsubsort = cast(eepssn as char(9)) + cast(' ' as char(12)) + '2799'

into dbo.U_ECAR835DCS_Loop2700_LE 
from dbo.u_ECAR835DCS_eelist
    join emppers on eepeeid = xeeid
    join dbo.U_ECAR835DCS_Loop2750_N1 on xeeid = drveeid and xcoid = drvcoid
  where @include_Loop2750n1 = 'Y'







----------------------------------------------------------



-- Build Dependent List
if object_id('dbo.U_ECAR835DCS_DepList') is not null
  drop table dbo.U_ECAR835DCS_DepList

select distinct dbneeid deeid, dbndeprecid ddepid
into dbo.U_ECAR835DCS_DepList 
from U_dsi_bdm_DepDeductions with (nolock)
where DbnFormatCode = @FormatCode
and dbnvalidforexport = 'Y'


--select * from U_dsi_bdm_DepDeductions

--STEP18 Populate Source for Dependents --must be careful if showing all company data (too many records on join)

-- select * from dbo.U_ECAR835DCS_drvTbl 

insert into dbo.U_ECAR835DCS_drvTbl 
SELECT    DISTINCT
    drvEEID = drvEEID, 
    drvcoid = ' ',
    drvdepid = ddepid,
    drvrectype = 'D',
    drvssn = drvssn,
    drvempno = drvempno,
    drvemplstatus = drvemplstatus,
    drvsubsort = cast(drvssn as char(9)) + ddepid + '2000',
    drvINS01_yesno ='N',
    
    --BRO                Brother
    --CHL                Child
    --COU                Cousin
    --DAD                Father
    --DP                 Registered Dom Partner
    --DPC                Domestic Partner Child
    --FIA                Fiance
    --GRC                Grandson or Granddaughter
    --MOM                Mother
    --OTH                Other
    --SIS                Sister
    --SPS                Spouse
    --STC                Step-Child
    --STF                Step-father
    --STM                Step-mother
    --Z                  <None>
    drvINS02_relationship = Case ConRelationShip 
                WHEN 'SPS' THEN '01' 
                WHEN 'DP'  THEN '53' 
                WHEN 'CHL' THEN '19' 
                WHEN 'STC' THEN '19' 
                WHEN 'DPC' THEN '19' 
                WHEN 'GRC' THEN '19' 
                else '19' end,
    drvINS03_mainttype = '030',
    drvINS04_maintreason = 'XN',    --'AI',
    drvINS05_benstatus = 'A',
    drvINS06_medicareplan = '',
    drvINS07_cobraqualevent = '',
    drvINS08_emplstatuscode = '',
    drvINS09_studentstatus = case when ISNULL(conrelationship,'') not in ('SPS','DP') AND ISNULL(conisstudent,'') = 'Y' then 'F' else '' end,  -- LynnM SR 354797
    drvINS10_handicapind =   case when ISNULL(conrelationship,'') not in ('SPS','DP') AND ISNULL(conisdisabled,'') = 'Y' then 'Y' else '' end, -- LynnM SR 354797
    drvINS11_dateformat = '',
    drvINS12_deathdate = '',
    drvINS17_birthseqnumber = ' ',
    drvNM101_entityidcode = 'IL',
    drvNM102_entitytypequal = '1',
    drvNM103_namelast = dbo.dsi_fnRemoveChars('.,/',Upper(conNameLast)),
    drvNM104_namefirst = dbo.dsi_fnRemoveChars('.,/',Upper(conNameFirst)),
    drvNM105_namemiddle  = dbo.dsi_fnRemoveChars('.,/',Upper(substring(conNameMiddle,1,1))),
    drvNM106_nameprefix = '',--CONVERT(CHAR(1),null),    --dbo.dsi_fnRemoveChars('.,/-Z',upper(conNamePrefix)),
    drvNM107_namesuffix = '',--convert(char(1),null),    --dbo.dsi_fnRemoveChars('.,/-Z',upper(conNameSuffix)),
    drvNM108_identcodequal = case
                    when isnull(rtrim(conssn),'') = '' then ''
                    else '34'
                    end,
    drvNM109identcode = isnull(rtrim(conssn),''),
    drvPER01_contfunccode = '',  -- = 'IP',
    drvPER03_commnum1qual = '',    --case when isnull(rtrim(eepphonehomenumber),'') = '' then '' else 'HP end,
    drvPER04_commnum1 = '',        --eepphonehomenumber,
    drvPER05_commnum2qual = '',    --case when isnull(rtrim(eepaddressemail),'') = '' then '' else 'EM' end,
    drvPER06_commnum2 = '',        --eepaddressemail,
    drvPER07_commnum3qual = '',
    drvPER08_commnum3 = '',
    drvN301_address1 = dbo.dsi_fnRemoveChars('.,/-',Upper(eepAddressLine1)),
    drvN302_address2 = dbo.dsi_fnRemoveChars('.,/-',Upper(eepAddressLine2)),
    drvN401_city  = dbo.dsi_fnRemoveChars('.,/-',Upper(eepAddressCity)),
    drvN402_state = eepAddressState,
    drvN403_zipcode = replace(replace(left(eepAddressZipCode,5),'-',''),' ',''),
    drvN404_country = '',        -- eepAddressCountry
    drvN405_locationqual = '',
    drvN406_location = '',
    drvDMG01_dttmqual = 'D8',
    drvDMG02_dttmperiod = condateofbirth,
    drvDMG03_gender = congender,
    drvDMG04_maritalstatus = '',
    drvDMG05_ethnic = '',
    drvDMG06_citizenship = '',
    drvICM01_frequency = '',
    drvICM02_amount = '',
    drvICM03_hours = '',
    drvICM04_location = '',
    drvICM05_salgrade = ''

    from dbo.U_ECAR835DCS_DepList with (nolock)
    join U_ECAR835DCS_drvTbl on deeid = drveeid and drvdepid is null
    join empPers with (nolock) on dEEID = eepEEID
    join contacts with (nolock)    on deeid = coneeid and consystemid = ddepid


--Build Loop 2000 REF Records for dependents
insert into dbo.U_ECAR835DCS_Loop2000_REF
SELECT    DISTINCT
    drvEEID = drvEEID, 
    drvcoid = drvcoid,
    drvdepid = drvdepid,
    drvsubsort = cast(drvssn as char(9)) + drvdepid + '2000',
    drvREF01_refnumqual = '0F',
    drvREF02_refnum = cast(drvssn as varchar(30))

from dbo.u_ECAR835DCS_drvtbl
where drvrectype = 'D'


--insert into dbo.U_ECAR835DCS_Loop2000_REF
--SELECT    DISTINCT
--    drvEEID = d.drvEEID, 
--    drvcoid = d.drvcoid,
--    drvdepid = d.drvdepid,
--    drvsubsort = cast(d.drvssn as char(9)) + d.drvdepid + '2000',
--    drvREF01_refnumqual = 'DX',
--    drvREF02_refnum = '0001'
--from dbo.u_ECAR835DCS_drvtbl D
----join dbo.U_ECAR835DCS_Loop2000_REF R on r.drveeid = d.drveeid and r.drvdepid is null and drvREF01_refnumqual = 'DX'
--where drvrectype = 'D'


--insert into dbo.U_ECAR835DCS_Loop2000_REF
--SELECT    DISTINCT
--    drvEEID = d.drvEEID, 
--    drvcoid = d.drvcoid,
--    drvdepid = d.drvdepid,
--    drvsubsort = cast(d.drvssn as char(9)) + d.drvdepid + '2000',
--    drvREF01_refnumqual = 'ZZ',
--    drvREF02_refnum = r.drvREF02_refnum
--
--from dbo.u_ECAR835DCS_drvtbl D
--join dbo.u_ECAR835DCS_drvtbl E on d.drveeid = e.drveeid and e.drvrectype = 'E'
--join vw_int_EmpComp on e.drveeid = eeceeid and e.drvcoid = eeccoid
--join dbo.U_ECAR835DCS_Loop2000_REF R on r.drveeid = drveeid and r.drvdepid is null and drvREF01_refnumqual = 'zz'
--where d.drvrectype = 'D'


--Build Loop 2000 DTP Records for dependents (not usually needed)

/*
insert into dbo.U_ECAR835DCS_Loop2000_DTP
SELECT    DISTINCT
    drvEEID = dbnEEID, 
    drvcoid = ' ',
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(drvssn as char(9)) + dbndeprecid + '2000' ,
    drvDTP01_dttmqual = '356',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = dbnbenstartdate

from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'


insert into dbo.U_ECAR835DCS_Loop2000_DTP
SELECT    DISTINCT
    drvEEID = dbnEEID, 
    drvcoid = ' ',
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(drvssn as char(9)) + dbndeprecid + '2000' ,
    drvDTP01_dttmqual = '357',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = dbnbenstopdate

from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'
    and dbnbenstopdate is not null

*/


-- Now build coverage data  HD Loop 2300
Insert into dbo.U_ECAR835DCS_Loop2300_HD
SELECT    DISTINCT
    drvEEID = dbnEEID, 
    drvcoid = ' ',
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(drvssn as char(9)) + dbndeprecid + '2300' + dbndedcode,
    drvHD01_mainttype = '030',
    drvHD02_maintreason = '',
    drvHD03_inslinecode = 'HLT',
    drvHD04_plancovdesc = drvHD04_plancovdesc,
    drvHD05_covlvl = ''

from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
    join dbo.u_ECAR835DCS_Loop2300_HD E on dbneeid = e.drveeid and e.drvdepid is null and dbndedcode = e.drvdedcode and drvHD03_inslinecode <> 'PDG'
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'



--select * from dbo.U_dsi_bdm_DepDeductions

-- Now build coverage data  DTP Loop 2300

insert into dbo.U_ECAR835DCS_Loop2300_DTP
SELECT    DISTINCT
    drvEEID = dbnEEID, 
    drvcoid = ' ',
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(drvssn as char(9)) + dbndeprecid + '2300' + dbndedcode,
    drvDTP01_dttmqual = '348',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = case when dbnbenstartdate < @PlanDate then @PlanDate else dbnbenstartdate end

from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'


insert into dbo.U_ECAR835DCS_Loop2300_DTP
SELECT    DISTINCT
    drvEEID = dbnEEID, 
    drvcoid = ' ',
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(drvssn as char(9)) + dbndeprecid + '2300' + dbndedcode,
    drvDTP01_dttmqual = '349',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = dbnbenstopdate

from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'
    and dbnbenstopdate is not null


-- Build Coverage Level REF Loop 2300 if needed (must provided joins and data)

insert into dbo.U_ECAR835DCS_Loop2300_REF
SELECT    DISTINCT
    drvEEID = d.drvEEID, 
    drvcoid = d.drvcoid,
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(d.drvssn as char(9)) + dbndeprecid + '2300' + dbndedcode,
    drvREF01_refidentqual = '1L',
    drvREF02_refident = ''        --r.drvREF02_refident
 
from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl D on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
    --join dbo.U_ECAR835DCS_Loop2300_REF R on r.drveeid = d.drveeid and r.drvdepid is null and drvREF01_refidentqual = '1L' and r.drvdedcode = dbndedcode
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'
    and @include_Loop2300ref = 'Y'



/*
-- dependent prescription Rx

Insert into dbo.U_ECAR835DCS_Loop2300_HD    --Rx
SELECT    DISTINCT
    drvEEID = dbnEEID, 
    drvcoid = ' ',
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(drvssn as char(9)) + dbndeprecid + '2300' + 'Rx',
    drvHD01_mainttype = '030',
    drvHD02_maintreason = '',
    drvHD03_inslinecode = 'PDG', 
    drvHD04_plancovdesc = '',
    drvHD05_covlvl = ''

from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
    --join dbo.u_ECAR835DCS_Loop2300_HD E on dbneeid = e.drveeid and e.drvdepid is null and dbndedcode = e.drvdedcode and drvHD03_inslinecode = 'PDG'
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'
    and deddedtype = 'MED'


insert into dbo.U_ECAR835DCS_Loop2300_DTP    --Rx
SELECT    DISTINCT
    drvEEID = dbnEEID, 
    drvcoid = ' ',
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(drvssn as char(9)) + dbndeprecid + '2300' + 'Rx',
    drvDTP01_dttmqual = '348',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = case when dbnbenstartdate < @PlanDate then @PlanDate else dbnbenstartdate end

from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
    join vw_int_EmpComp on drveeid = eeceeid
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'
    and deddedtype = 'MED'


insert into dbo.U_ECAR835DCS_Loop2300_DTP    --Rx
SELECT    DISTINCT
    drvEEID = dbnEEID, 
    drvcoid = ' ',
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(drvssn as char(9)) + dbndeprecid + '2300' + 'Rx',
    drvDTP01_dttmqual = '349',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = dbnbenstopdate

from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'
    and dbnbenstopdate is not null
    and deddedtype = 'MED'



insert into dbo.U_ECAR835DCS_Loop2300_REF
SELECT    DISTINCT
    drvEEID = d.drvEEID, 
    drvcoid = d.drvcoid,
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(d.drvssn as char(9)) + dbndeprecid + '2300' + 'Rx',
    drvREF01_refidentqual = '1L',
    drvREF02_refident = ''        --r.drvREF02_refident
 
from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl D on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
    --join dbo.U_ECAR835DCS_Loop2300_REF R on r.drveeid = d.drveeid and r.drvdepid is null and drvREF01_refidentqual = '1L'
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'
    and @include_Loop2300ref = 'Y'
    and deddedtype = 'MED'

*/


-- Build Coverage Level LX and NM1 Loop 2310 if needed (Primary Care Provider PCP information)

insert into dbo.U_ECAR835DCS_Loop2310_NM1
SELECT    DISTINCT
    drvEEID = drvEEID, 
    drvcoid = drvcoid,
    drvdepid = dbndeprecid,
    drvdedcode = dbndedcode,
    drvsubsort = cast(drvssn as char(9)) + dbndeprecid + '2310' + dbndedcode,
    drvNM101_refidentqual = 'P3',
    drvNM102_refident = '1',
    drvNM103_lname = '',
    drvNM104_fname = '',
    drvNM105_mname = '',
    drvNM106_prefix = '',
    drvNM107_suffix = '',
    drvNM108_qualifier = 'SV',
    drvNM109_idcode = dbnprimarycarephysid,
    drvNM110_relation = '72'

from dbo.U_dsi_bdm_DepDeductions with (nolock)
    join dbo.u_ECAR835DCS_drvtbl on dbneeid = drveeid and dbndeprecid = drvdepid and drvrectype = 'D'
where DbnFormatCode = @FormatCode
    and dbnvalidforexport = 'Y'
    and @include_Loop2310nm1 = 'Y'
    and isnull(dbnprimarycarephysid,'') <> ''




---- Build N1 Loop 2750 if needed (Reporting Category) - dependents  (usually not needed)
--
--Insert into dbo.U_ECAR835DCS_Loop2750_N1
--SELECT    DISTINCT
--    drvEEID = drvEEID, 
--    drvcoid = drvcoid,
--    drvdepid = drvdepid,
--    drvdedcode = '',
--    drvsubsort = cast(drvssn as char(9)) + drvdepid + '2750',    -- + eeddedcode,
--    drvN101_refidentqual = '75',
--    drvN102_refident = case when jbcflsatype = 'X' and eepaddressstate not in ('GA','NC') then '001'
--                            when eepaddressstate = 'GA' then '002'
--                            when eepaddressstate = 'NC' then '003'
--                            when eepaddressstate = 'PR' then '005'
--                        else '004' end
--
--from dbo.u_ECAR835DCS_drvtbl
--    join emppers on eepeeid = drveeid
--    join vw_int_EmpComp with (nolock) on drveeid = eecEEid and drvcoid = eecCOID
--    join jobcode with (nolock) on eecjobcode = jbcjobcode
--where drvrectype = 'D'
--and @include_Loop2750n1 = 'Y'




-- Build REF Loop 2750 if needed (Reporting Category REF) - dependents

--Insert into dbo.U_ECAR835DCS_Loop2750_REF
--SELECT    DISTINCT
--    drvEEID = drvEEID, 
--    drvcoid = drvcoid,
--    drvdepid = drvdepid,
--    drvdedcode = '',
--    drvsubsort = cast(drvssn as char(9)) + drvdepid +  '2755',    -- + eeddedcode,
--    drvREF01_refidentqual = '18',
--    drvREF02_refident = case when jbcflsatype = 'X' and eepaddressstate not in ('GA','NC') then '001'
--                            when eepaddressstate = 'GA' then '002'
--                            when eepaddressstate = 'NC' then '003'
--                            when eepaddressstate = 'PR' then '005'
--                        else '004' end
--
--from dbo.u_ECAR835DCS_drvtbl
--    join emppers on eepeeid = drveeid
--    join vw_int_EmpComp with (nolock) on drveeid = eecEEid and drvcoid = eecCOID
--    join jobcode with (nolock) on eecjobcode = jbcjobcode
--where drvrectype = 'D'
--and @include_Loop2750ref = 'Y'
--
--
---- Build DTP Loop 2750 if needed (Reporting Category REF) - deps
--
--Insert into dbo.U_ECAR835DCS_Loop2750_DTP
--SELECT    DISTINCT
--    drvEEID = drv.drvEEID, 
--    drvcoid = drv.drvcoid,
--    drvdepid = drv.drvdepid,
--    drvdedcode = '',
--    drvsubsort = cast(drv.drvssn as char(9)) + drv.drvdepid + '2757',    -- + eeddedcode,
--    drvDTP01_dttmqual = '007',
--    drvDTP02_dttmformat = 'D8',
--    drvDTP03_dttmperiod = dtp.drvDTP03_dttmperiod
--
--from dbo.u_ECAR835DCS_drvtbl drv
--join dbo.U_ECAR835DCS_Loop2750_DTP dtp on drv.drveeid = dtp.drveeid and dtp.drvdepid is null and dtp.drvDTP01_dttmqual = '007'
--where drvrectype = 'D'
--and @include_Loop2750dtp = 'Y'
--
--
--
---- Build LS Loop 2700 - deps
--
--INSERT into dbo.U_ECAR835DCS_Loop2700_LS 
--SELECT    DISTINCT
--    drvEEID = drvEEID, 
--    drvcoid = drvcoid,
--    drvdepid = drvdepid,
--    drvdedcode = '',
--    drvsubsort = cast(drvssn as char(9)) + drvdepid + '2700'
--
--from dbo.u_ECAR835DCS_drvtbl
--where drvrectype = 'D'
--and @include_Loop2750n1 = 'Y'
--
--
---- Build LE Loop 2700 - deps
--
--INSERT into dbo.U_ECAR835DCS_Loop2700_LE 
--SELECT    DISTINCT
--    drvEEID = drvEEID, 
--    drvcoid = drvcoid,
--    drvdepid = drvdepid,
--    drvdedcode = '',
--    drvsubsort = cast(drvssn as char(9)) + drvdepid +  '2799'
--
--from dbo.u_ECAR835DCS_drvtbl
--where drvrectype = 'D'
--and @include_Loop2750n1 = 'Y'




--STEP24  delete deductions from employee when not used such in domestic partner codes
--                        or if dependent deductions are not same as employeees

--delete from dbo.U_ECAR835DCS_Loop2300_HD
--where drvdepid is null and drvdedcode in ('XXXXX','YYYYY')
--
--delete from dbo.U_ECAR835DCS_Loop2300_DTP
--where drvdepid is null and drvdedcode in ('XXXXX','YYYYY')
--
--delete from dbo.U_ECAR835DCS_Loop2300_AMT
--where drvdepid is null and drvdedcode in ('XXXXX','YYYYY')
--
--delete from dbo.U_ECAR835DCS_Loop2300_REF
--where drvdepid is null and drvdedcode in ('XXXXX','YYYYY')


-- Build Transaction Set Tables
if object_id('U_ECAR835DCS_transsetwork') is not null
  drop table dbo.U_ECAR835DCS_transsetwork

select trneeid = drveeid,
    trncoid = drvcoid,
    trndepdepid = drvdepid,
    trnrow = identity(int,1,1),
    trnset = cast(' ' as char(9)),
    drvsort = cast(' ' as char(20))
into dbo.u_ECAR835DCS_transsetwork
from dbo.u_ECAR835DCS_drvtbl 
order by drveeid,drvdepid

-- Now build logic to handle assigning transaction sets (can't have more than 10000 Ins records in a set)
update dbo.u_ECAR835DCS_transsetwork
set trnset = dbo.fn_padzero((trnrow / 10000 + 1),9,0),
    drvsort = dbo.fn_padzero((trnrow / 10000 + 1),8,0) + trneeid

--Now build transaction set header - ST
if object_id('U_ECAR835DCS_ST') is not null
  drop table dbo.U_ECAR835DCS_ST


SELECT    DISTINCT
    drvsort = dbo.fn_padzero(trnset,8,0),
    drvsubsort = cast(' ' as char(25)),
    drvST01_transsetid = '834',
    drvST02_transsetctrlnum = trnset,
    drvST03_implconvref = '005010X220A1',        --'005010X220',
    drvst_segcount = cast(0 as integer)

into dbo.U_ECAR835DCS_ST
from dbo.u_ECAR835DCS_transsetwork
          

--Now build BGN record
if object_id('U_ECAR835DCS_BGN') is not null
  drop table dbo.U_ECAR835DCS_BGN

SELECT    DISTINCT
    trnset = trnset,
    drvsort = dbo.fn_padzero(trnset,8,0),
    drvsubsort = cast(' ' as char(25)),
    drvBGN01_transsetpurpose = '00',
    drvBGN02_referenceidsender =  trnset,        --use customer fed tax ID if not specified by vendor
    drvBGN03_date = @filedate,
    drvBGN04_date = @filedate,
    drvBGN_05_timezone = 'ET',
    drvBGN06_referenceid = '',
    drvBGN07_transtypecode = '',
    drvBGN08_actioncode = '4'    --'RX'

into dbo.U_ECAR835DCS_BGN
from dbo.u_ECAR835DCS_transsetwork


--Now build REF record
if object_id('U_ECAR835DCS_REF') is not null
  drop table dbo.U_ECAR835DCS_REF


SELECT    DISTINCT
    trnset = trnset,
    drvsort = dbo.fn_padzero(trnset,8,0),
    drvsubsort = cast(' ' as char(25)),
    drvREF01_referenceidqual = '38',
    drvREF02_referenceid = 'ppppp'

into dbo.U_ECAR835DCS_REF
from dbo.u_ECAR835DCS_transsetwork
where @include_STref = 'Y'


--Now build DTP record (can have multiple DTP records, if so insert additional records to table)
if object_id('U_ECAR835DCS_DTP') is not null
  drop table dbo.U_ECAR835DCS_DTP


SELECT    DISTINCT
    trnset = trnset,
    drvsort = dbo.fn_padzero(trnset,8,0),
    drvsubsort = cast(' ' as char(25)),
    drvDTP01_dttmqual = '007',
    drvDTP02_dttmformat = 'D8',
    drvDTP03_dttmperiod = @filedate

into dbo.U_ECAR835DCS_DTP
from dbo.u_ECAR835DCS_transsetwork
where @include_STdtp = 'Y'

--Now build N1 record 
if object_id('U_ECAR835DCS_N1') is not null
  drop table dbo.U_ECAR835DCS_N1


SELECT    DISTINCT
    trnset = trnset,
    drvsort = dbo.fn_padzero(trnset,8,0),
    drvsubsort = cast(' ' as char(25)),
    drvN101_entityidcode = 'P5',
    drvN102_name = UPPER(cast('DCS Corp' as varchar(70))),   --UPPER(cast('DCS Corporation' as varchar(70))),
    drvN103_idcodequal = 'FI',        --'24'  HIPPA EIN
    drvN104_idcode = '541044062'

into dbo.U_ECAR835DCS_N1
from dbo.u_ECAR835DCS_transsetwork

Insert into dbo.U_ECAR835DCS_N1
SELECT    DISTINCT
    trnset = trnset,
    drvsort = dbo.fn_padzero(trnset,8,0),
    drvsubsort = cast(' ' as char(25)),
    drvN101_entityidcode = 'IN',
    drvN102_name = 'CAREFIRST',
    drvN103_idcodequal = 'FI',
    drvN104_idcode = '521385894'

from dbo.u_ECAR835DCS_transsetwork


--update transaction set segment counts



update dbo.U_ECAR835DCS_ST
set drvst_segcount =
    isnull(bgncount,0) +    -- BGN
    isnull(refcount,0) +    -- REF
    isnull(dtpcount,0) +    -- DTP
    isnull(n1count,0) +    --N1
    isnull(inscount,0) +     -- INS    
    isnull(nm1count,0) +    -- NM1
    isnull(percount,0) +    -- PER    
    isnull(n3count,0) +     -- N3    
    isnull(n4count,0) +    -- N4
    isnull(dmgcount,0) +     -- DMG
    isnull(icmcount,0) +    -- ICM
    isnull(L2000refcount,0) +    -- Loop 2000 REF
    isnull(L2000dtpcount,0) +    -- Loop 2000 DTP
    isnull(L2100amtcount,0) +    -- Loop 2100 AMT
    isnull(L2300hdcount,0) +    -- Loop 2300 HD
    isnull(L2300dtpcount,0) +    -- Loop 2300 DTP
    isnull(L2300amtcount,0) +    -- Loop 2300 AMT
    isnull(l2300refcount,0) +    -- Loop 2300 REF
    isnull(l2310lxcount,0) +    -- Loop 2310 LX
    isnull(l2310nm1count,0) +    -- Loop 2310 NM1

    isnull(l2700lscount,0) +    -- Loop 2700 LS
    isnull(l2700lxcount,0) +    -- Loop 2700 LX
    isnull(l2750n1count,0) +    -- Loop 2750 N1
    isnull(l2750refcount,0) +    -- Loop 2750 REF
    isnull(l2750dtpcount,0) +    -- Loop 2750 DTP
    isnull(l2700lecount,0) +    -- Loop 2700 LE
    2                    -- Count of ST, SE segment
from dbo.U_ECAR835DCS_ST
left join (select count(*) bgncount, trnset 
    from dbo.U_ECAR835DCS_BGN group by trnset) bgn on bgn.trnset = drvST02_transsetctrlnum 
left join (select count(*) refcount, trnset 
    from dbo.U_ECAR835DCS_REF 
    where drvREF01_referenceidqual <> '' group by trnset) ref on ref.trnset = drvST02_transsetctrlnum
left join (select count(*) dtpcount, trnset 
    from dbo.U_ECAR835DCS_DTP 
    where drvDTP01_dttmqual <> ''
    group by trnset) dtp on dtp.trnset = drvST02_transsetctrlnum
left join (select count(*) n1count, trnset 
    from dbo.U_ECAR835DCS_N1 group by trnset) n1 on n1.trnset = drvST02_transsetctrlnum 
left join (select count(*) inscount, trnset 
    from dbo.U_ECAR835DCS_drvtbl
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) ins on ins.trnset = drvST02_transsetctrlnum
left join (select count(*) nm1count, trnset 
    from dbo.U_ECAR835DCS_drvtbl
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) nm1 on nm1.trnset = drvST02_transsetctrlnum
left join (select count(*) percount, trnset 
    from dbo.U_ECAR835DCS_drvtbl
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    where (drvPER03_commnum1qual <> '' or drvPER05_commnum2qual <> '' or drvPER07_commnum3qual <> '')
    group by trnset) per on per.trnset = drvST02_transsetctrlnum
left join (select count(*) n3count, trnset 
    from dbo.U_ECAR835DCS_drvtbl
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    where (drvN301_address1 <> '')
    group by trnset) n3 on n3.trnset = drvST02_transsetctrlnum
left join (select count(*) n4count, trnset 
    from dbo.U_ECAR835DCS_drvtbl
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    where (drvN401_city <> '')
    group by trnset) n4 on n4.trnset = drvST02_transsetctrlnum
left join (select count(*) dmgcount, trnset 
    from dbo.U_ECAR835DCS_drvtbl
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) dmg on dmg.trnset = drvST02_transsetctrlnum
left join (select count(*) icmcount, trnset 
    from dbo.U_ECAR835DCS_drvtbl
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    where drvICM01_frequency <> ''
    group by trnset) icm on icm.trnset = drvST02_transsetctrlnum
left join (select count(*) L2000refcount, trnset 
    from dbo.U_ECAR835DCS_Loop2000_ref
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2000ref on l2000ref.trnset = drvST02_transsetctrlnum
left join (select count(*) L2000dtpcount, trnset 
    from dbo.U_ECAR835DCS_Loop2000_dtp
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2000dtp on l2000dtp.trnset = drvST02_transsetctrlnum
left join (select count(*) L2100amtcount, trnset 
    from dbo.U_ECAR835DCS_Loop2100A_amt 
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2100amt on l2100amt.trnset = drvST02_transsetctrlnum
left join (select count(*) L2300hdcount, trnset 
    from dbo.U_ECAR835DCS_Loop2300_hd 
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2300hd on l2300hd.trnset = drvST02_transsetctrlnum
left join (select count(*) L2300dtpcount, trnset 
    from dbo.U_ECAR835DCS_Loop2300_dtp 
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2300dtp on l2300dtp.trnset = drvST02_transsetctrlnum
left join (select count(*) L2300amtcount, trnset 
    from dbo.U_ECAR835DCS_Loop2300_amt 
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2300amt on l2300amt.trnset = drvST02_transsetctrlnum
left join (select count(*) L2300refcount, trnset 
    from dbo.U_ECAR835DCS_Loop2300_ref 
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2300ref on l2300ref.trnset = drvST02_transsetctrlnum

left join (select count(*) L2310lxcount, trnset 
    from dbo.U_ECAR835DCS_Loop2310_nm1 
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2310lx on l2310lx.trnset = drvST02_transsetctrlnum
left join (select count(*) L2310nm1count, trnset 
    from dbo.U_ECAR835DCS_Loop2310_nm1 
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2310nm1 on l2310nm1.trnset = drvST02_transsetctrlnum

left join (select count(*) L2700lscount, trnset 
    from dbo.U_ECAR835DCS_Loop2700_ls
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2700ls on l2700ls.trnset = drvST02_transsetctrlnum
left join (select count(*) L2700lxcount, trnset 
    from dbo.U_ECAR835DCS_Loop2700_ls
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2700lx on l2700lx.trnset = drvST02_transsetctrlnum
left join (select count(*) L2750n1count, trnset 
    from dbo.U_ECAR835DCS_Loop2750_n1
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2750n1 on l2750n1.trnset = drvST02_transsetctrlnum
left join (select count(*) L2750refcount, trnset 
    from dbo.U_ECAR835DCS_Loop2750_ref
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2750ref on l2750ref.trnset = drvST02_transsetctrlnum
left join (select count(*) L2750dtpcount, trnset 
    from dbo.U_ECAR835DCS_Loop2750_dtp
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2750dtp on l2750dtp.trnset = drvST02_transsetctrlnum
left join (select count(*) L2700lecount, trnset 
    from dbo.U_ECAR835DCS_Loop2700_ls
    join dbo.u_ECAR835DCS_transsetwork  on trneeid = drveeid and trncoid = drvcoid and isnull(trndepdepid,'') = isnull(drvdepid,'')
    group by trnset) l2700le on l2700le.trnset = drvST02_transsetctrlnum



--Build SE Trailer
--Now build transaction set trailer SE (can't use header record due to sorting)

if object_id('U_ECAR835DCS_SE') is not null
  drop table dbo.U_ECAR835DCS_SE

SELECT    DISTINCT
    drvsort = rtrim(drvsort)+ 'ZZZZZZZZZZZZ',        --'999999999999',
    drvsubsort = cast(' ' as char(25)),
    drvSE01_segcount = drvst_segcount,
    drvSE02_transsetctrlnum = drvST02_transsetctrlnum

into dbo.U_ECAR835DCS_SE
from dbo.u_ECAR835DCS_ST

--Step25 Create Headers

--Create GS Header Record
if object_id('U_ECAR835DCS_GS') is not null
  drop table dbo.U_ECAR835DCS_GS

SELECT    DISTINCT
    drvsort = cast(' ' as char(20)),
    drvsubsort = cast(' ' as char(25)),
    drvGS01_functidcode = 'BE',
    drvGS02_senderid = '541044062',
    drvGS03_receiverid = '00190',
    drvGS04_date = @filedate,
    drvGS05_date = @filedate,
    drvGS06_grpcontrolnum = '100000001',
    drvGS07_respagencycode = 'X',
    drvGS08_verrelease = '005010X220A1',        --'005010X220',
    drvGS_transsetcount = setcount

into dbo.U_ECAR835DCS_GS
from (select count(*) setcount from dbo.U_ECAR835DCS_ST) st


--Create ISA Header Record
if object_id('U_ECAR835DCS_ISA') is not null
  drop table dbo.U_ECAR835DCS_ISA

SELECT    DISTINCT
    drvsort = cast(' ' as char(20)),
    drvsubsort = cast(' ' as char(25)),
    drvISA01_authinfoqual = '00',
    drvISA02_authinfo = ' ',
    drvISA03_secinfoqual = '00',
    drvISA04_secinfo = ' ',
    drvISA05_senderidqual = '30',  -- LynnM SR 354797   'ZZ'
    drvISA06_senderid = '541044062',  -- select cmmfedtaxid from compmast 541044062
    drvISA07_recvidqual = 'ZZ',
    drvISA08_recvid = '00190',  -- 00190 - MD Plan, 00580 - DC Plan
    drvISA09_intchgdate = @filedate,
    drvISA10_intchgdate = @filedate,
    drvISA11_intchgcontrolid = '^',  -- LynnM SR 354797  '^',   
    drvISA12_intchgcontrolver = '00501',
    drvISA13_intchgcontrolnum = '100000001',
    drvISA14_acknowreq = '0',
    drvISA15_usageind =  case when @exportcode like '%TEST%' then 'T' else 'P' end,
    drvISA16_compelementsep =  ':',  -- LynnM SR 354797  ':',        
    drvISA_groupcount =  groupcount

into dbo.U_ECAR835DCS_ISA
from (select count(*) groupcount from dbo.U_ECAR835DCS_GS) gs



--STEP30 Set FileName  
if (dbo.dsi_fnVariable('ECAR835DCS','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'DCSC_CAR_' + convert(char(8),getdate(),112) + '.txt'
    where FormatCode = 'ECAR835DCS'

END

/********



select * from ascdeff
where adfheadersystemid IN (SELECT adhSystemID from AscDefH WHERE AdhFormatCode = 'ECAR835DCS')
order by adfsetnumber, adffieldnumber



padzero

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE function [dbo].[fn_PadZero](@numIn float, @Length int, @decimal int)
  returns varchar(24) as
  begin
    declare @out varchar(24)
    select @out = case when @numIn < 0 then '-' else '' end +
      replace(str(abs(@numIn), @Length - case when @numIn < 0 then 1 else 0 end, @decimal), ' ', '0')
    return @out
  end





--STEP31 Remember to alter view for correct sorting
ALTER  View dbo.dsi_vwECAR835DCS_Export as
        select top 2000000 Data from dbo.U_ECAR835DCS_File with (nolock)
         order by case
                when substring(Recordset,1,1) = 'H' then 1
                when substring(Recordset,1,1) = 'D' then 2
                when substring(Recordset,1,1) = 'T' then 3
            end, 
                initialsort, subsort, substring(Recordset,2,2),
            case when substring(data,1,2) = 'N1' then
                case when substring(data,4,2) = 'P5' then '1'
                    when substring(data,4,2) = 'IN' then '2'
                        else '3' end
                when substring(data,1,3) = 'REF' then
                    case when substring(data,5,2) = '0F' then '1'
                        when substring(data,5,2) = '1L' then '2'
                        else '3' + substring(data,5,2) end
                when substring(data,1,3) = 'DTP' then
                    case when substring(data,5,3) = '348' then '1'
                        when substring(data,5,3) = '349' then '2'
                        when substring(data,5,3) = '356' then '3'
                        when substring(data,5,3) = '357' then '4'
                        else '5' + substring(data,5,2) end
            else '0'
            end

-- select * from dbo.U_ECAR835DCS_File where [data] like 'per%'

*STEP27 Used for testing
dbo.dsi_sp_testswitchbox_v2 'ECAR835DCS','ECAR835DCS'
dbo.dsi_sp_testswitchbox_v2 'ECAR835DCS','TEST'
dbo.dsi_sp_testswitchbox_v2 'ECAR835DCS','ACTIVEOE'
dbo.dsi_sp_testswitchbox_v2 'ECAR835DCS','PASSIVEOE'
*************/
GO
 CREATE  View dbo.dsi_vwECAR835DCS_Export as
        select top 2000000 Data from dbo.U_ECAR835DCS_File with (nolock)
         order by case
                when substring(Recordset,1,1) = 'H' then 1
                when substring(Recordset,1,1) = 'D' then 2
                when substring(Recordset,1,1) = 'T' then 3
            end, 
                initialsort, subsort, substring(Recordset,2,2),
            case when substring(data,1,2) = 'N1' then
                case when substring(data,4,2) = 'P5' then '1'
                    when substring(data,4,2) = 'IN' then '2'
                        else '3' end
                when substring(data,1,3) = 'REF' then
                    case when substring(data,5,2) = '0F' then '1'
                        when substring(data,5,2) = '1L' then '2'
                        else '3' + substring(data,5,2) end
                when substring(data,1,3) = 'DTP' then
                    case when substring(data,5,3) = '348' then '1'
                        when substring(data,5,3) = '349' then '2'
                        when substring(data,5,3) = '356' then '3'
                        when substring(data,5,3) = '357' then '4'
                        else '5' + substring(data,5,2) end
            else '0'
            end

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECAR835DCS' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECAR835DCS'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECAR835DCS'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECAR835DCS', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECAR835DCS', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECAR835DCS', 'UseFileName', 'V', 'Y'


-- End ripout