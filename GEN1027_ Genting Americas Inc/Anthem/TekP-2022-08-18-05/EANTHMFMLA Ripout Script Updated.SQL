/**********************************************************************************

EANTHMFMLA: Anthem FMLA File

FormatCode:     EANTHMFMLA
Project:        Anthem FMLA File
Client ID:      GEN1027
Date/time:      2024-01-15 08:53:57.120
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E41
Server:         E4SUP1DB03
Database:       ULTIPRO_GENAI
Web Filename:   GEN1027_ET68A_EEHISTORY_EANTHMFMLA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EANTHMFMLA_SavePath') IS NOT NULL DROP TABLE dbo.U_EANTHMFMLA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EANTHMFMLA'


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
WHERE FormatCode = 'EANTHMFMLA'
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
WHERE ExpFormatCode = 'EANTHMFMLA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EANTHMFMLA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EANTHMFMLA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EANTHMFMLA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EANTHMFMLA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EANTHMFMLA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EANTHMFMLA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EANTHMFMLA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EANTHMFMLA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EANTHMFMLA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EANTHMFMLA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_fnlib_GetSupervisorField_EANTHMFMLA') IS NOT NULL DROP FUNCTION [dbo].[dsi_fnlib_GetSupervisorField_EANTHMFMLA];
GO
IF OBJECT_ID('dsi_vwEANTHMFMLA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEANTHMFMLA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EANTHMFMLA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTHMFMLA];
GO
IF OBJECT_ID('U_EANTHMFMLA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_Trailer];
GO
IF OBJECT_ID('U_EANTHMFMLA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_PEarHist];
GO
IF OBJECT_ID('U_EANTHMFMLA_HeaderTop') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_HeaderTop];
GO
IF OBJECT_ID('U_EANTHMFMLA_Header') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_Header];
GO
IF OBJECT_ID('U_EANTHMFMLA_File') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_File];
GO
IF OBJECT_ID('U_EANTHMFMLA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_EEList];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_230') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_230];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_8') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_8];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_7') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_7];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_6') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_6];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_5') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_5];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_4') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_4];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_3') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_3];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_2') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_2];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_1') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_1];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_210];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_200') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_200];
GO
IF OBJECT_ID('U_EANTHMFMLA_drvTbl_100') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_drvTbl_100];
GO
IF OBJECT_ID('U_EANTHMFMLA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_DedList];
GO
IF OBJECT_ID('U_EANTHMFMLA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_AuditFields];
GO
IF OBJECT_ID('U_EANTHMFMLA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EANTHMFMLA_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EANTHMFMLA','Anthem FMLA File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1500','S','N','EANTHMFMLAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','45','H','01','1',NULL,'RECORD TYPE',NULL,NULL,'"drvRECORDTYPE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','1455','H','01','2',NULL,'RECORD TYPE',NULL,NULL,'"drvFiller"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','H','02','1',NULL,'RECORD TYPE',NULL,NULL,'"drvRECORDTYPE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','10','H','02','4',NULL,'GRP NO',NULL,NULL,'"drvGRPNO"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','50','H','02','14',NULL,'GROUP NAME',NULL,NULL,'"drvGROUPNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','8','H','02','64',NULL,'DATE',NULL,NULL,'"drvDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','6','H','02','72',NULL,'TIME',NULL,NULL,'"drvTIME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','1','H','02','78',NULL,'FULL FILE/DETLA',NULL,NULL,'"drvFULLFILEDETLA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EANTHMFMLAZ0','1','H','02','79',NULL,'FILLER',NULL,NULL,'"drvFILLER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','10','1',NULL,'RECORD TYPE',NULL,NULL,'"drvRECORDTYPE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','50','D','10','4',NULL,'FIRST NAME',NULL,NULL,'"drvFIRSTNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','50','D','10','54',NULL,'MID NAME',NULL,NULL,'"drvMIDNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','50','D','10','104',NULL,'LAST NAME',NULL,NULL,'"drvLASTNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','50','D','10','154',NULL,'MAIDEN NAME',NULL,NULL,'"drvMAIDENNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','8','D','10','204',NULL,'EFF DATE',NULL,NULL,'"drvEFFDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EANTHMFMLAZ0','8','D','10','212',NULL,'TERM DATE',NULL,NULL,'"drvTERMDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EANTHMFMLAZ0','20','D','10','220',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EANTHMFMLAZ0','1','D','10','240',NULL,'GENDER',NULL,NULL,'"drvGENDER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EANTHMFMLAZ0','8','D','10','241',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EANTHMFMLAZ0','10','D','10','249',NULL,'GRP NO',NULL,NULL,'"drvGRPNO"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EANTHMFMLAZ0','8','D','10','259',NULL,'GRP EFF DATE',NULL,NULL,'"drvGRPEFFDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EANTHMFMLAZ0','8','D','10','267',NULL,'SAL EFF DATE',NULL,NULL,'"drvSALEFFDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EANTHMFMLAZ0','8','D','10','275',NULL,'BILL GRP EFF DATE',NULL,NULL,'"drvBILLGRPEFFDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EANTHMFMLAZ0','8','D','10','283',NULL,'MEMBER CLASS EFF DATE',NULL,NULL,'"drvMEMBERCLASSEFFDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EANTHMFMLAZ0','8','D','10','291',NULL,'BILL CLASS EFF DATE',NULL,NULL,'"drvBILLCLASSEFFDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EANTHMFMLAZ0','120','D','10','299',NULL,'EMPLOYER NAME',NULL,NULL,'"drvEMPLOYERNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EANTHMFMLAZ0','10','D','10','419',NULL,'BILL GRP NO',NULL,NULL,'"drvBILLGRPNO"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EANTHMFMLAZ0','100','D','10','429',NULL,'BILL GRP NM',NULL,NULL,'"drvBILLGRPNM"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EANTHMFMLAZ0','5','D','10','529',NULL,'MEMBER CLASS NO',NULL,NULL,'"drvMEMBERCLASSNO"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EANTHMFMLAZ0','80','D','10','534',NULL,'MEMBER CLASS DESC',NULL,NULL,'"drvMEMBERCLASSDESC"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EANTHMFMLAZ0','10','D','10','614',NULL,'SALARY',NULL,NULL,'"drvSALARY"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EANTHMFMLAZ0','1','D','10','624',NULL,'SALARY FREQ',NULL,NULL,'"drvSALARYFREQ"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EANTHMFMLAZ0','3','D','10','625',NULL,'HOURS WORKED',NULL,NULL,'"drvHOURSWORKED"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EANTHMFMLAZ0','3','D','10','628',NULL,'ELIGIBILITY STATUS',NULL,NULL,'"drvELIGIBILITYSTATUS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EANTHMFMLAZ0','8','D','10','631',NULL,'DATE OF HIRE',NULL,NULL,'"drvDATEOFHIRE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EANTHMFMLAZ0','10','D','10','639',NULL,'JOIN GRP DT',NULL,NULL,'"drvJOINGRPDT"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EANTHMFMLAZ0','50','D','10','649',NULL,'ADDR1',NULL,NULL,'"drvADDR1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EANTHMFMLAZ0','50','D','10','699',NULL,'ADDR2',NULL,NULL,'"drvADDR2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EANTHMFMLAZ0','50','D','10','749',NULL,'ADDR3',NULL,NULL,'"drvADDR3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EANTHMFMLAZ0','50','D','10','799',NULL,'CITY',NULL,NULL,'"drvCITY"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EANTHMFMLAZ0','2','D','10','849',NULL,'STATE',NULL,NULL,'"drvSTATE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EANTHMFMLAZ0','12','D','10','851',NULL,'ZIP',NULL,NULL,'"drvZIP"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EANTHMFMLAZ0','15','D','10','863',NULL,'PHONE',NULL,NULL,'"drvPHONE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EANTHMFMLAZ0','15','D','10','878',NULL,'FAX',NULL,NULL,'"drvFAX"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EANTHMFMLAZ0','40','D','10','893',NULL,'EMAIL',NULL,NULL,'"drvEMAIL"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EANTHMFMLAZ0','1','D','10','933',NULL,'SMOKER CODE',NULL,NULL,'"drvSMOKERCODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EANTHMFMLAZ0','1','D','10','934',NULL,'MARITAL STATUS',NULL,NULL,'"drvMARITALSTATUS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EANTHMFMLAZ0','10','D','10','935',NULL,'BILLCLASS',NULL,NULL,'"drvBILLCLASS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EANTHMFMLAZ0','556','D','10','945',NULL,'FILLER',NULL,NULL,'"drvFILLER1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','20','1',NULL,'RECORD TYPE',NULL,NULL,'"drvRECORDTYPE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','20','D','20','4',NULL,'LOB',NULL,NULL,'"drvLOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','3','D','20','24',NULL,'BENEFIT STATUS',NULL,NULL,'"drvBENEFITSTATUS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','8','D','20','27',NULL,'EFF DATE',NULL,NULL,'"drvEFFDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','8','D','20','35',NULL,'TERM DATE',NULL,NULL,'"drvTERMDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','15','D','20','43',NULL,'COVERAGE AMOUNT',NULL,NULL,'"drvCOVERAGEAMOUNT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EANTHMFMLAZ0','2','D','20','58',NULL,'BENSELECT OPT',NULL,NULL,'"drvBENSELECTOPT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EANTHMFMLAZ0','1441','D','20','60',NULL,'FILLER',NULL,NULL,'"drvFILLER2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','30','1',NULL,'RECORD TYPE',NULL,NULL,'"drvRECORDTYPE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','30','D','30','4',NULL,'UDDT TYPE',NULL,NULL,'"drvUDDTTYPE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','300','D','30','34',NULL,'VALUE',NULL,NULL,'"drvVALUE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','20','D','30','334',NULL,'LOB',NULL,NULL,'"drvLOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','8','D','30','354',NULL,'EFFDATE',NULL,NULL,'"drvEFFDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','1139','D','30','362',NULL,'FILLER',NULL,NULL,'"drvFILLER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','31','1',NULL,'RECORD TYPE _UT1',NULL,NULL,'"drvRECORDTYPE_UT1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','30','D','31','4',NULL,'UDDT TYPE _UT1',NULL,NULL,'"drvUDDTTYPE_UT1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','300','D','31','34',NULL,'VALUE_UT1',NULL,NULL,'"drvVALUE_UT1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','20','D','31','334',NULL,'LOB_UT1',NULL,NULL,'"drvLOB_UT1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','8','D','31','354',NULL,'EFFDATE_UT1',NULL,NULL,'"drvEFFDATE_UT1"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','1139','D','31','362',NULL,'FILLER_UT1',NULL,NULL,'"drvFILLER_UT1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','32','1',NULL,'RECORD TYPE_UT2',NULL,NULL,'"drvRECORDTYPE_UT2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','30','D','32','4',NULL,'UDDT TYPE_UT2',NULL,NULL,'"drvUDDTTYPE_UT2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','300','D','32','34',NULL,'VALUE_UT2',NULL,NULL,'"drvVALUE_UT2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','20','D','32','334',NULL,'LOB_UT2',NULL,NULL,'"drvLOB_UT2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','8','D','32','354',NULL,'EFFDATE_UT2',NULL,NULL,'"drvEFFDATE_UT2"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','1139','D','32','362',NULL,'FILLER_UT2',NULL,NULL,'"drvFILLER_UT2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','33','1',NULL,'RECORD TYPE_UT3',NULL,NULL,'"drvRECORDTYPE_UT3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','30','D','33','4',NULL,'UDDT TYPE_UT3',NULL,NULL,'"drvUDDTTYPE_UT3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','300','D','33','34',NULL,'VALUE_UT3',NULL,NULL,'"drvVALUE_UT3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','20','D','33','334',NULL,'LOB_UT3',NULL,NULL,'"drvLOB_UT3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','8','D','33','354',NULL,'EFFDATE_UT3',NULL,NULL,'"drvEFFDATE_UT3"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','1139','D','33','362',NULL,'FILLER_UT3',NULL,NULL,'"drvFILLER_UT3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','34','1',NULL,'RECORD TYPE_UT4',NULL,NULL,'"drvRECORDTYPE_UT4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','30','D','34','4',NULL,'UDDT TYPE_UT4',NULL,NULL,'"drvUDDTTYPE_UT4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','300','D','34','34',NULL,'VALUE_UT4',NULL,NULL,'"drvVALUE_UT4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','20','D','34','334',NULL,'LOB_UT4',NULL,NULL,'"drvLOB_UT4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','8','D','34','354',NULL,'EFFDATE_UT4',NULL,NULL,'"drvEFFDATE_UT4"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','1139','D','34','362',NULL,'FILLER_UT4',NULL,NULL,'"drvFILLER_UT4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','35','1',NULL,'RECORD TYPE_UT5',NULL,NULL,'"drvRECORDTYPE_UT5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','30','D','35','4',NULL,'UDDT TYPE_UT5',NULL,NULL,'"drvUDDTTYPE_UT5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','300','D','35','34',NULL,'VALUE_UT5',NULL,NULL,'"drvVALUE_UT5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','20','D','35','334',NULL,'LOB_UT5',NULL,NULL,'"drvLOB_UT5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','8','D','35','354',NULL,'EFFDATE_UT5',NULL,NULL,'"drvEFFDATE_UT5"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','1139','D','35','362',NULL,'FILLER_UT5',NULL,NULL,'"drvFILLER_UT5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','36','1',NULL,'RECORD TYPE_UT6',NULL,NULL,'"drvRECORDTYPE_UT6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','30','D','36','4',NULL,'UDDT TYPE_UT6',NULL,NULL,'"drvUDDTTYPE_UT6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','300','D','36','34',NULL,'VALUE_UT6',NULL,NULL,'"drvVALUE_UT6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','20','D','36','334',NULL,'LOB_UT6',NULL,NULL,'"drvLOB_UT6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','8','D','36','354',NULL,'EFFDATE_UT6',NULL,NULL,'"drvEFFDATE_UT6"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','1139','D','36','362',NULL,'FILLER_UT6',NULL,NULL,'"drvFILLER_UT6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','37','1',NULL,'RECORD TYPE_UT7',NULL,NULL,'"drvRECORDTYPE_UT7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','30','D','37','4',NULL,'UDDT TYPE_UT7',NULL,NULL,'"drvUDDTTYPE_UT7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','300','D','37','34',NULL,'VALUE_UT7',NULL,NULL,'"drvVALUE_UT7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','20','D','37','334',NULL,'LOB_UT7',NULL,NULL,'"drvLOB_UT7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','8','D','37','354',NULL,'EFFDATE_UT7',NULL,NULL,'"drvEFFDATE_UT7"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','1139','D','37','362',NULL,'FILLER_UT7',NULL,NULL,'"drvFILLER_UT7"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','38','1',NULL,'RECORD TYPE_UT8',NULL,NULL,'"drvRECORDTYPE_UT8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','30','D','38','4',NULL,'UDDT TYPE_UT8',NULL,NULL,'"drvUDDTTYPE_UT8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','300','D','38','34',NULL,'VALUE_UT8',NULL,NULL,'"drvVALUE_UT8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','20','D','38','334',NULL,'LOB_UT8',NULL,NULL,'"drvLOB_UT8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','8','D','38','354',NULL,'EFFDATE_UT8',NULL,NULL,'"drvEFFDATE_UT8"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','1139','D','38','362',NULL,'FILLER_UT8',NULL,NULL,'"drvFILLER_UT8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','D','40','1',NULL,'RECORD TYPE',NULL,NULL,'"drvRECORDTYPE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','8','D','40','4',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','50','D','40','12',NULL,'FIRST NAME',NULL,NULL,'"drvFIRSTNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTHMFMLAZ0','50','D','40','62',NULL,'MID NAME',NULL,NULL,'"drvMIDNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTHMFMLAZ0','50','D','40','112',NULL,'LAST NAME',NULL,NULL,'"drvLASTNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTHMFMLAZ0','50','D','40','162',NULL,'MAIDEN NAME',NULL,NULL,'"drvMAIDENNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EANTHMFMLAZ0','1','D','40','212',NULL,'GENDER',NULL,NULL,'"drvGENDER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EANTHMFMLAZ0','2','D','40','213',NULL,'RELATION CODE',NULL,NULL,'"drvRELATIONCODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EANTHMFMLAZ0','8','D','40','215',NULL,'EFF DATE',NULL,NULL,'"drvEFFDATE_SP"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EANTHMFMLAZ0','8','D','40','223',NULL,'TERM DATE',NULL,NULL,'"drvTERMDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EANTHMFMLAZ0','20','D','40','231',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EANTHMFMLAZ0','1','D','40','251',NULL,'Smoker Code',NULL,NULL,'"drvSmokerCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EANTHMFMLAZ0','5','D','40','252',NULL,'MEMBER CLASS NO',NULL,NULL,'"drvMEMBERCLASSNO"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EANTHMFMLAZ0','20','D','40','257',NULL,'LOB',NULL,NULL,'"drvLOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EANTHMFMLAZ0','8','D','40','277',NULL,'EFF DATE',NULL,NULL,'"drvEFFDATE"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EANTHMFMLAZ0','15','D','40','285',NULL,'COVERAGE AMOUT',NULL,NULL,'"drvCOVERAGEAMOUT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EANTHMFMLAZ0','2','D','40','300',NULL,'BENSELECT OPT',NULL,NULL,'"drvBENSELECTOPT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EANTHMFMLAZ0','1199','D','40','302',NULL,'FILLER',NULL,NULL,'"drvFILLER4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTHMFMLAZ0','3','T','90','1',NULL,'RECORD TYPE',NULL,NULL,'"drvRECORDTYPE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTHMFMLAZ0','10','T','90','4',NULL,'TOTAL RECORDS',NULL,NULL,'"drvTOTALRECORDS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTHMFMLAZ0','1487','T','90','14',NULL,'FILLER',NULL,NULL,'"drvFILLER"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EANTHMFMLA_20240115.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',4D8BQ,4J1K7,4J1PX',NULL,NULL,NULL,'Active Open Enrollment Export','202401019','EMPEXPORT','OEACTIVE',NULL,'EANTHMFMLA',NULL,NULL,NULL,'202401019','Nov 19 2020  3:03PM','Nov 19 2020  3:03PM','202401011',NULL,'','','202401011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202011199','EMPEXPORT','OEPASSIVE',NULL,'EANTHMFMLA',NULL,NULL,NULL,'202011199','Nov 19 2020  3:03PM','Nov 19 2020  3:03PM','202011191',NULL,'','','202011191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Anthem FMLA File','202011199','EMPEXPORT','ONDEM_XOE',NULL,'EANTHMFMLA',NULL,NULL,NULL,'202011199','Nov 19 2020  3:03PM','Nov 19 2020  3:03PM','202011191',NULL,'','','202011191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',4D8BQ,4J1K7,4J1PX',NULL,NULL,NULL,'Anthem FMLA_Life - Tues 9am','202101279','EMPEXPORT','SCH_EANTHM','Jan 27 2021 12:57PM','EANTHMFMLA',NULL,NULL,NULL,'202401099','Jan 27 2021 12:00AM','Dec 30 1899 12:00AM','202401021','21079','','','202101131',dbo.fn_GetTimedKey(),NULL,'us3lKiMON1019',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Anthem FMLA File-Test','202311289','EMPEXPORT','TEST_XOE','Jul 12 2022  3:49PM','EANTHMFMLA',NULL,NULL,NULL,'202311289','Jul 12 2022 12:00AM','Dec 30 1899 12:00AM','202311211','19231','','','202311211',dbo.fn_GetTimedKey(),NULL,'us3jReMON1019',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTHMFMLA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTHMFMLA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTHMFMLA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTHMFMLA','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTHMFMLA','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTHMFMLA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTHMFMLA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTHMFMLA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','H01','dbo.U_EANTHMFMLA_HeaderTop',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','H02','dbo.U_EANTHMFMLA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D10','dbo.U_EANTHMFMLA_drvTbl_100',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D20','dbo.U_EANTHMFMLA_drvTbl_200',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D30','dbo.U_EANTHMFMLA_drvTbl_210',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D31','dbo.U_EANTHMFMLA_drvTbl_210_1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D32','dbo.U_EANTHMFMLA_drvTbl_210_2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D33','dbo.U_EANTHMFMLA_drvTbl_210_3',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D34','dbo.U_EANTHMFMLA_drvTbl_210_4',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D35','dbo.U_EANTHMFMLA_drvTbl_210_5',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D36','dbo.U_EANTHMFMLA_drvTbl_210_6',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D37','dbo.U_EANTHMFMLA_drvTbl_210_7',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D38','dbo.U_EANTHMFMLA_drvTbl_210_8',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','D40','dbo.U_EANTHMFMLA_drvTbl_230','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTHMFMLA','T90','dbo.U_EANTHMFMLA_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EANTHMFMLA_Audit
-----------

IF OBJECT_ID('U_EANTHMFMLA_Audit') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCoid] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audTermed] varchar(1) NOT NULL
);

-----------
-- Create table U_EANTHMFMLA_AuditFields
-----------

IF OBJECT_ID('U_EANTHMFMLA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EANTHMFMLA_DedList
-----------

IF OBJECT_ID('U_EANTHMFMLA_DedList') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_100
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_100') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_100] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE] varchar(3) NOT NULL,
    [drvFIRSTNAME] varchar(100) NULL,
    [drvMIDNAME] varchar(50) NULL,
    [drvLASTNAME] varchar(100) NULL,
    [drvMAIDENNAME] varchar(50) NULL,
    [drvEFFDATE] datetime NULL,
    [drvTERMDATE] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvGENDER] varchar(10) NOT NULL,
    [drvDOB] datetime NULL,
    [drvGRPNO] varchar(10) NOT NULL,
    [drvGRPEFFDATE] varchar(8) NOT NULL,
    [drvSALEFFDATE] datetime NULL,
    [drvBILLGRPEFFDATE] datetime NULL,
    [drvMEMBERCLASSEFFDATE] varchar(8) NULL,
    [drvBILLCLASSEFFDATE] varchar(8) NULL,
    [drvEMPLOYERNAME] varchar(32) NOT NULL,
    [drvBILLGRPNO] varchar(4) NULL,
    [drvBILLGRPNM] varchar(100) NULL,
    [drvMEMBERCLASSNO] varchar(2) NULL,
    [drvMEMBERCLASSDESC] varchar(80) NULL,
    [drvSALARY] varchar(24) NULL,
    [drvSALARYFREQ] varchar(1) NOT NULL,
    [drvHOURSWORKED] varchar(3) NULL,
    [drvELIGIBILITYSTATUS] varchar(3) NOT NULL,
    [drvDATEOFHIRE] datetime NULL,
    [drvJOINGRPDT] datetime NULL,
    [drvADDR1] varchar(255) NULL,
    [drvADDR2] varchar(255) NULL,
    [drvADDR3] varchar(50) NULL,
    [drvCITY] varchar(255) NULL,
    [drvSTATE] varchar(255) NULL,
    [drvZIP] varchar(50) NULL,
    [drvPHONE] varchar(50) NULL,
    [drvFAX] varchar(15) NULL,
    [drvEMAIL] varchar(50) NULL,
    [drvSMOKERCODE] varchar(1) NULL,
    [drvMARITALSTATUS] varchar(1) NULL,
    [drvBILLCLASS] varchar(3) NOT NULL,
    [drvFILLER1] varchar(556) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_200
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_200') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_200] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE] varchar(3) NOT NULL,
    [drvLOB] varchar(14) NULL,
    [drvBENEFITSTATUS] varchar(3) NOT NULL,
    [drvEFFDATE] datetime NULL,
    [drvTERMDATE] datetime NULL,
    [drvCOVERAGEAMOUNT] varchar(24) NULL,
    [drvBENSELECTOPT] varchar(2) NULL,
    [drvFILLER2] varchar(1441) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_210
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_210] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE] varchar(3) NOT NULL,
    [drvUDDTTYPE] varchar(18) NOT NULL,
    [drvVALUE] varchar(22) NOT NULL,
    [drvLOB] varchar(20) NULL,
    [drvEFFDATE] datetime NOT NULL,
    [drvFILLER] varchar(1139) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_210_1
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_1') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_1] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE_UT1] varchar(3) NOT NULL,
    [drvUDDTTYPE_UT1] varchar(17) NOT NULL,
    [drvVALUE_UT1] varchar(16) NOT NULL,
    [drvLOB_UT1] varchar(20) NULL,
    [drvEFFDATE_UT1] datetime NOT NULL,
    [drvFILLER_UT1] varchar(1139) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_210_2
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_2') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_2] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE_UT2] varchar(3) NOT NULL,
    [drvUDDTTYPE_UT2] varchar(7) NOT NULL,
    [drvVALUE_UT2] varchar(1) NOT NULL,
    [drvLOB_UT2] varchar(20) NULL,
    [drvEFFDATE_UT2] datetime NOT NULL,
    [drvFILLER_UT2] varchar(1139) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_210_3
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_3') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_3] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE_UT3] varchar(3) NOT NULL,
    [drvUDDTTYPE_UT3] varchar(12) NOT NULL,
    [drvVALUE_UT3] varchar(255) NULL,
    [drvLOB_UT3] varchar(20) NULL,
    [drvEFFDATE_UT3] datetime NOT NULL,
    [drvFILLER_UT3] varchar(1139) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_210_4
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_4') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_4] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE_UT4] varchar(3) NOT NULL,
    [drvUDDTTYPE_UT4] varchar(12) NOT NULL,
    [drvVALUE_UT4] int NULL,
    [drvLOB_UT4] varchar(20) NULL,
    [drvEFFDATE_UT4] datetime NOT NULL,
    [drvFILLER_UT4] varchar(1139) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_210_5
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_5') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_5] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE_UT5] varchar(3) NOT NULL,
    [drvUDDTTYPE_UT5] varchar(21) NOT NULL,
    [drvVALUE_UT5] varchar(8) NULL,
    [drvLOB_UT5] varchar(20) NULL,
    [drvEFFDATE_UT5] datetime NOT NULL,
    [drvFILLER_UT5] varchar(1139) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_210_6
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_6') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_6] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE_UT6] varchar(3) NOT NULL,
    [drvUDDTTYPE_UT6] varchar(12) NOT NULL,
    [drvVALUE_UT6] varchar(4) NULL,
    [drvLOB_UT6] varchar(20) NULL,
    [drvEFFDATE_UT6] datetime NOT NULL,
    [drvFILLER_UT6] varchar(1139) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_210_7
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_7') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_7] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE_UT7] varchar(3) NOT NULL,
    [drvUDDTTYPE_UT7] varchar(13) NOT NULL,
    [drvVALUE_UT7] varchar(4) NOT NULL,
    [drvLOB_UT7] varchar(20) NULL,
    [drvEFFDATE_UT7] datetime NOT NULL,
    [drvFILLER_UT7] varchar(1139) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_210_8
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_8') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_210_8] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE_UT8] varchar(3) NOT NULL,
    [drvUDDTTYPE_UT8] varchar(12) NOT NULL,
    [drvVALUE_UT8] varchar(4) NOT NULL,
    [drvLOB_UT8] varchar(1) NOT NULL,
    [drvEFFDATE_UT8] datetime NOT NULL,
    [drvFILLER_UT8] varchar(1139) NULL
);

-----------
-- Create table U_EANTHMFMLA_drvTbl_230
-----------

IF OBJECT_ID('U_EANTHMFMLA_drvTbl_230') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_drvTbl_230] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvRECORDTYPE] varchar(3) NOT NULL,
    [drvDOB] datetime NULL,
    [drvFIRSTNAME] varchar(100) NULL,
    [drvMIDNAME] varchar(50) NULL,
    [drvLASTNAME] varchar(100) NULL,
    [drvMAIDENNAME] varchar(50) NULL,
    [drvGENDER] varchar(6) NULL,
    [drvRELATIONCODE] varchar(2) NULL,
    [drvEFFDATE_SP] datetime NULL,
    [drvTERMDATE] varchar(8) NULL,
    [drvSSN] varchar(20) NULL,
    [drvSmokerCode] varchar(1) NULL,
    [drvMEMBERCLASSNO] varchar(2) NOT NULL,
    [drvLOB] varchar(10) NULL,
    [drvEFFDATE] datetime NULL,
    [drvCOVERAGEAMOUT] varchar(24) NULL,
    [drvBENSELECTOPT] varchar(2) NULL,
    [drvFILLER4] varchar(1199) NULL
);

-----------
-- Create table U_EANTHMFMLA_EEList
-----------

IF OBJECT_ID('U_EANTHMFMLA_EEList') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EANTHMFMLA_File
-----------

IF OBJECT_ID('U_EANTHMFMLA_File') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1500) NULL
);

-----------
-- Create table U_EANTHMFMLA_Header
-----------

IF OBJECT_ID('U_EANTHMFMLA_Header') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_Header] (
    [drvRECORDTYPE] varchar(3) NOT NULL,
    [drvGRPNO] varchar(10) NOT NULL,
    [drvGROUPNAME] varchar(32) NOT NULL,
    [drvDATE] datetime NOT NULL,
    [drvTIME] varchar(8000) NULL,
    [drvFULLFILEDETLA] varchar(1) NOT NULL,
    [drvFILLER] varchar(1) NOT NULL
);

-----------
-- Create table U_EANTHMFMLA_HeaderTop
-----------

IF OBJECT_ID('U_EANTHMFMLA_HeaderTop') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_HeaderTop] (
    [drvRECORDTYPE] varchar(44) NOT NULL,
    [drvFiller] varchar(1455) NOT NULL
);

-----------
-- Create table U_EANTHMFMLA_PEarHist
-----------

IF OBJECT_ID('U_EANTHMFMLA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehCurHrs12mth] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EANTHMFMLA_Trailer
-----------

IF OBJECT_ID('U_EANTHMFMLA_Trailer') IS NULL
CREATE TABLE [dbo].[U_EANTHMFMLA_Trailer] (
    [drvRECORDTYPE] varchar(3) NOT NULL,
    [drvTOTALRECORDS] int NULL,
    [drvFILLER] varchar(1487) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTHMFMLA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: RWC

Created By: Inshan Singh
Business Analyst: Richard Vars
Create Date: 11/19/2020
Service Request Number: TekP-2020-10-22-0001 

Purpose: Anthem FMLA File

Revision History
----------------
Update By           Date           Request Num            Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX        XXXXX
B Waldrop           10/4/2022                            Moved from MONT to GENT as part of migration. 
LeaK                11/20/2023       TekP-2022-08-18-05    added vol add ee and sp ded codes
MWaters                1/15/2024       TekP-2022-08-18-05    updated the join for the 200 to pull the max code on the grouped codes

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EANTHMFMLA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EANTHMFMLA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EANTHMFMLA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EANTHMFMLA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EANTHMFMLA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTHMFMLA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTHMFMLA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTHMFMLA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTHMFMLA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTHMFMLA', 'SCH_EANTHM';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EANTHMFMLA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EANTHMFMLA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EANTHMFMLA';

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
    DELETE FROM dbo.U_EANTHMFMLA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EANTHMFMLA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -- Delete test employees 
    DELETE FROM dbo.U_EANTHMFMLA_EEList where xEEID in ('C3RMWG0000K0','BUK9780000K0','BUF6CY0000K0','BUF6FI0000K0','C3XDCF0010K0','BUF6I10000K0','DMTW5L000030')

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BLIFE,BLIFT,VLTD,VSTD,LIFEE,LIFET,LIFES,LIFST,LIFEC,LFECT,BADDT,BADD,VADDE,VADTE,VADDS,VADTS';

    IF OBJECT_ID('U_EANTHMFMLA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EANTHMFMLA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','BLIFE,BLIFT,VLTD,VSTD,LIFEE,LIFET,LIFES,LIFST,LIFEC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

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

    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;


   --==========================================
 --   -- Audit Section
 --   --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EANTHMFMLA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_AuditFields;
    CREATE TABLE dbo.U_EANTHMFMLA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    --INSERT INTO dbo.U_EANTHMFMLA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EANTHMFMLA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EANTHMFMLA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_Audit;
    SELECT 
         audEEID = audKey1Value
        ,audCoid = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audTermed = CASE WHEN ISNULL(audNewValue, '')  = 'T' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EANTHMFMLA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EANTHMFMLA_AuditFields WITH (NOLOCK) 
          ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate    
    AND audAction = 'Update';

    -- Create Index
   CREATE CLUSTERED INDEX CDX_U_EANTHMFMLA_Audit ON dbo.U_EANTHMFMLA_Audit (audEEID,audCoid);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------

    DECLARE @StartLast12MthPerocontrol VARCHAR(9) = CONVERT(VARCHAR, DATEADD(M, -12, @EndDate), 112)+'1'

    IF OBJECT_ID('U_EANTHMFMLA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PehCurHrs12mth           = SUM(CASE WHEN PehPerControl between @StartLast12MthPerocontrol and @EndPerControl THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EANTHMFMLA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    WHERE PehPerControl between @StartLast12MthPerocontrol and @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
     --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_100
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_100','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_100;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ xEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE = '200'
        ,drvFIRSTNAME = EepNameFirst
        ,drvMIDNAME = eepnamemiddle
        ,drvLASTNAME = EepNameLast
        ,drvMAIDENNAME = space(50)
        ,drvEFFDATE = EecDateOfLastHire
        ,drvTERMDATE = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSSN = eepSSN
        ,drvGENDER = CASE EepGender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' ELSE 'Undeclared' END
        ,drvDOB = EepDateOfBirth
        ,drvGRPNO = 'AL00006406'
        ,drvGRPEFFDATE = '20200101' --'1/1/20'
        ,drvSALEFFDATE =  dbo.dsi_fnGetMinMaxDates('MAX',dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire), EecDateOfLastHire) 
        ,drvBILLGRPEFFDATE = CASE WHEN cmpcompanycode = 'MRMI' and eecpaygroup = 'RWHV' THEN dbo.dsi_fnGetMinMaxDates('MAX','03/01/2022',EecDateOfLastHire) 
                                    ELSE dbo.dsi_fnGetMinMaxDates('MAX','01/01/2018',EecDateOfLastHire) 
                                END
                            --EecDateOfLastHire
        ,drvMEMBERCLASSEFFDATE = space(8)
        ,drvBILLCLASSEFFDATE = space(8)
        ,drvEMPLOYERNAME = 'Montreign Operating Company, LLC'
        ,drvBILLGRPNO = CASE WHEN cmpcompanycode = 'ERI'  THEN '0000' --'AL00006406' 12/31/2020 change to case logic
                             WHEN cmpcompanycode = 'MRMI' and eecpaygroup <> 'RWHV' THEN '0001'
                             WHEN cmpcompanycode = 'MOC'  THEN '0002'
                             WHEN cmpcompanycode = 'MRMI' and eecpaygroup = 'RWHV' THEN '0003'
                            END
        ,drvBILLGRPNM = space(100)
        ,drvMEMBERCLASSNO = CASE WHEN EecDedGroupCode = 'L6PTT' and TEedDedcode in ('BLIFT','BADDT') THEN '02'
                                 WHEN EecDedGroupCode IN ('RWCHT','L6TC') THEN '02'
                                 WHEN EecDedGroupCode IN ('RWCPT','RCPTT','DAY') THEN '04'
                                 WHEN EecDedGroupCode = 'PTL6N' and BEedDedcode in ('BLIFE','BADD') and eedbenstatus in ('A') THEN '01'
                                 WHEN EecDedGroupCode = 'PTL6N' and BEedDedcode in ('BLIFE','BADD') and eedbenstatus <> ('A') THEN '04'
                                 WHEN EecDedGroupCode = 'L6PTT' and TEedDedcode in ('BLIFT','BADDT') and eedbenstatus not in ('A') THEN '04'
                                 WHEN EecDedGroupCode = 'PTL6N' and BEedDedcode not in ('BLIFE','BADD') THEN '04'
                                 WHEN EecDedGroupCode = 'L6PTT' and TEedDedcode not in ('BLIFT','BADDT') THEN '04'
                                 WHEN EecDedGroupCode NOT IN ('RWCHT','L6TC','RWCPT','RCPTT','L6PTT') THEN '01'
                                --Else '01'
                                END
        
        --CASE WHEN EecDedGroupCode = 'L6PTT' and eeddedcode in ('BLIFT','BADDT') THEN '02'
        --                         WHEN EecDedGroupCode IN ('RWCHT','L6TC') THEN '02'
        --                         WHEN EecDedGroupCode IN ('RWCPT','RCPTT','DAY') THEN '04'
  --                               WHEN EecDedGroupCode = 'PTL6N' and eeddedcode in ('BLIFE','BADD') and eedbenstatus in ('A') THEN '01'
  --                               WHEN EecDedGroupCode = 'PTL6N' and eeddedcode in ('BLIFE','BADD') and eedbenstatus not in ('A') THEN '04'
  --                               WHEN EecDedGroupCode = 'L6PTT' and eeddedcode in ('BLIFT','BADDT') and eedbenstatus not in ('A') THEN '04'
  --                               WHEN EecDedGroupCode = 'PTL6N' and eeddedcode not in ('BLIFE','BADD') THEN '04'
  --                               WHEN EecDedGroupCode = 'L6PTT' and eeddedcode not in ('BLIFT','BADDT') THEN '04'
  --                               WHEN EecDedGroupCode NOT IN ('RWCHT','L6TC','RWCPT','RCPTT','L6PTT') THEN '01'
  --                              --Else '01'
  --                              END
                    --CASE WHEN EecDedGroupCode IN ('RWCPT','RCPTT','DAY') THEN '04'
     --                            WHEN EecDedGroupCode = 'PTL6N' and eeddedcode in ('BLIFE','BADD') and eedbenstatus not in ('A') THEN '04'
     --                            WHEN EecDedGroupCode = 'L6PTT' and eeddedcode in ('BLIFT','BADDT') and eedbenstatus not in ('A') THEN '04'
     --                            WHEN EecDedGroupCode = 'PTL6N' and eeddedcode not in ('BLIFE','BADD') THEN '04'
     --                            WHEN EecDedGroupCode = 'L6PTT' and eeddedcode not in ('BLIFT','BADDT') THEN '04'
     --                            WHEN EecDedGroupCode IN ('RWCHT','L6TC') THEN '02'
     --                            WHEN EecDedGroupCode = 'PTL6N' and eeddedcode in ('BLIFE','BADD') and eedbenstatus = 'A' THEN '01'
     --                            WHEN EecDedGroupCode = 'L6PTT' and eeddedcode in ('BLIFT','BADDT') and eedbenstatus = 'A' THEN '02'
     --                            WHEN EecDedGroupCode NOT IN ('RWCHT','L6TC','RWCPT','RCPTT','L6PTT') THEN '01'
     --                           --Else '01'
     --                           END 
                                --CASE WHEN EecDedGroupCode IN ('RWCHT','L6TC') THEN '02'
        --                         WHEN EecFullTimeOrPartTime = 'P' OR EecDedGroupCode = 'PT' THEN '04'
                                --Else '01'
        --                        END
        ,drvMEMBERCLASSDESC = space(80)
        ,drvSALARY = CASE WHEN eecannsalary > 0 then [dbo].[dsi_fnPadZero](eecannsalary * 100,10,0) END --[dbo].[dsi_fnPadZero](eecannsalary * 100,10,0) --space(10) 
        ,drvSALARYFREQ =  '7' --CASE WHEN  EecPayPeriod = 'B' THEN 'BI-Weekly' END
        ,drvHOURSWORKED = CASE WHEN EecScheduledWorkHrs > 0 THEN CONVERT(VARCHAR(2), CONVERT(DECIMAL(10,0),EecScheduledWorkHrs)) + space(1)  --CONVERT(VARCHAR(2), CONVERT(DECIMAL(10,0),EecScheduledWorkHrs/2)) + space(1)
                            ELSE '01 '
                            END
                --[dbo].[dsi_fnPadZero](EecScheduledWorkHrs/2,3,0) -- todo 
        ,drvELIGIBILITYSTATUS = CASE WHEN eecemplstatus = 'T' THEN '337' else '336' END
        ,drvDATEOFHIRE = EecDateOflastHire
        ,drvJOINGRPDT = EecDateOfLastHire
        ,drvADDR1 = Eepaddressline1
        ,drvADDR2 = Eepaddressline2
        ,drvADDR3 = space(50)
        ,drvCITY = EepAddressCity
        ,drvSTATE = EepAddressState
        ,drvZIP = EepAddressZipCode
        ,drvPHONE = CASE WHEN ISNULL(eepphonehomenumber,'') <> '' THEN eepphonehomenumber 
                    WHEN ISNULL(eepphonehomenumber,'') = '' and ISNULL(dbo.dsi_fnlib_GetPhoneNumber(EecEEID,'CEL'),'') <> '' THEN dbo.dsi_fnlib_GetPhoneNumber(EecEEID,'CEL')
                    ELSE EecPhoneBusinessNumber
                    END
                --eepphonehomenumber EecPhoneBusinessNumber
        ,drvFAX = space(15)
        ,drvEMAIL = CASE WHEN ISNULL(EepAddressEmailAlternate,'') <> '' THEN EepAddressEmailAlternate ELSE EepAddressEMail END
        ,drvSMOKERCODE = space(1)
        ,drvMARITALSTATUS = space(1)
        ,drvBILLCLASS = CASE WHEN EecUnionLocal IN ('L6C', 'L17C', 'L279C', 'L30C') THEN '001' ELSE '002' END
                        --CASE 
         --                   WHEN cmpcompanycode = 'EMP' THEN '0000'
         --                   WHEN cmpcompanycode = 'MRMI' THEN '0001'
         --                   WHEN cmpcompanycode = 'MOC' THEN '0002'
         --               END
        ,drvFILLER1 = space(556)
    INTO dbo.U_EANTHMFMLA_drvTbl_100
    FROM dbo.U_EANTHMFMLA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCOID
        AND EecEEType = 'REG'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (Select  Distinct 
                  EedEEID
                 ,EedCoID
                 ,MAX(Case when EedDedCode IN ('BLIFE','BADD') THEN Eeddedcode END) AS BEedDedcode 
                 ,MAX(Case when EedDedCode IN ('BLIFT','BADDT') THEN Eeddedcode END) AS TEedDedcode                 
                 ,EedBenOption = MAX(EedBenOption)
                 ,EEdBenStartDate = MAX(EEdBenStartDate)
                 ,EedBenStatusDate = MAX(EedBenStatusDate)
                 ,EEdBenStopDate  = MAX(EedBenStopDate)
                 ,eedBenstatus = MAx(eedBenstatus)
                 FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
                WHERE  EedFormatCode = @Formatcode
                       AND Eedbenstatus NOT IN ('W','C')
                GROUP BY EedEEID ,EedCoID ) Bdm
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
       
   --LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
   --     ON EedEEID = xEEID 
   --     AND EedCoID = xCoID
   --     AND EedFormatCode = @FormatCode 
     --   AND EedValidForExport = 'Y' -- MW commented out 9/12/2023
    --LEFT JOIN dbo.BenProg WITH (NOLOCK)
    --    ON  CbpDedCode = EedDedcode
    LEFT JOIN dbo.Company WITH (NOLOCK)
        ON cmpCOID = xCOID
    LEFT JOIN dbo.U_EANTHMFMLA_Audit WITH (NOLOCK)
       ON audeeid = xeeid  
       AND audcoid = xcoid
    WHERE ( (eecemplstatus in ('A', 'L','S') or  (eecemplstatus = 'T' and  auddatetime is not null))
       OR EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) WHERE EedEEID = xEEID  AND EedCoID = xCoID AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y'))
       --and CASE WHEN EecDedGroupCode = 'L6PTT' and eeddedcode in ('BLIFT','BADDT') THEN '02'
                            --     WHEN EecDedGroupCode IN ('RWCHT','L6TC') THEN '02'
                            --     WHEN EecDedGroupCode IN ('RWCPT','RCPTT','DAY') THEN '04'
       --                          WHEN EecDedGroupCode = 'PTL6N' and eeddedcode in ('BLIFE','BADD') and eedbenstatus in ('A') THEN '01'
       --                          WHEN EecDedGroupCode = 'PTL6N' and eeddedcode in ('BLIFE','BADD') and eedbenstatus not in ('A') THEN '04'
       --                          WHEN EecDedGroupCode = 'L6PTT' and eeddedcode in ('BLIFT','BADDT') and eedbenstatus not in ('A') THEN '04'
       --                          WHEN EecDedGroupCode = 'PTL6N' and eeddedcode not in ('BLIFE','BADD') THEN '04'
       --                          WHEN EecDedGroupCode = 'L6PTT' and eeddedcode not in ('BLIFT','BADDT') THEN '04'
       --                          WHEN EecDedGroupCode NOT IN ('RWCHT','L6TC','RWCPT','RCPTT','L6PTT') THEN '01'
       --                         --Else '01'
       --                         END is not null
      AND CASE WHEN EecDedGroupCode = 'L6PTT' and TEedDedcode in ('BLIFT','BADDT') THEN '02'
                                 WHEN EecDedGroupCode IN ('RWCHT','L6TC') THEN '02'
                                 WHEN EecDedGroupCode IN ('RWCPT','RCPTT','DAY') THEN '04'
                                 WHEN EecDedGroupCode = 'PTL6N' and BEedDedcode in ('BLIFE','BADD') and eedbenstatus in ('A') THEN '01'
                                 WHEN EecDedGroupCode = 'PTL6N' and BEedDedcode in ('BLIFE','BADD') and eedbenstatus <> ('A') THEN '04'
                                 WHEN EecDedGroupCode = 'L6PTT' and TEedDedcode in ('BLIFT','BADDT') and eedbenstatus not in ('A') THEN '04'
                                 WHEN EecDedGroupCode = 'PTL6N' and BEedDedcode not in ('BLIFE','BADD') THEN '04'
                                 WHEN EecDedGroupCode = 'L6PTT' and TEedDedcode not in ('BLIFT','BADDT') THEN '04'
                                 WHEN EecDedGroupCode NOT IN ('RWCHT','L6TC','RWCPT','RCPTT','L6PTT') THEN '01'
                                --Else '01'
                                END is not null
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_200
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_200','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_200;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE = '210'
        ,drvLOB = CASE
                        WHEN eeddedcode = 'BLIFE' THEN 'Life-Sal'
                        WHEN eeddedcode = 'BLIFT' THEN 'Life-Flat'
                        WHEN eeddedcode = 'BADD' THEN 'AD&D-Sal'
                        WHEN eeddedcode = 'BADDT' THEN 'AD&D-Flat'
                        WHEN Eeddedcode IN ('LIFEE','LIFET') THEN 'SUPP LIFE-Flat'
                        WHEN Eeddedcode IN ('LIFES','LIFST') THEN 'DEP Spouse'
                        WHEN Eeddedcode IN ('LIFEC','LFECT') THEN 'DEP Child'
                        WHEN eeddedcode IN ('VADDE', 'VADTE') THEN 'SUPP ADD-Flat'  --updated 11/20/23 LeaK
                        --WHEN eeddedcode IN ('LIFEE','LIFET') THEN 'SUPP ADD-Flat'
                        WHEN eeddedcode IN ('VADDS', 'VADTS') THEN 'DEP SP ADD'   --updated 11/20/23 LeaK
                        --WHEN eeddedcode IN ('LIFES','LIFST') THEN 'DEP SP ADD'
                        WHEN Eeddedcode IN ('LIFEC','LFECT') THEN 'Dep AD&D'
                        WHEN eeddedcode IN ('VLTD') THEN 'VLTD-Sal'
                        WHEN eeddedcode IN ('VSTD') THEN 'VSTD-Sal'
                        --WHEN EecEEType = 'REG' and LocAddressState = 'NY' and eepgender = 'M' THEN 'PFLSM' 
                        --WHEN EecEEType = 'REG' and LocAddressState = 'NY' and eepgender = 'F' THEN 'PFLSF'
                        --WHEN EecEEType = 'REG' THEN 'FML'
                        --WHEN EecEEType = 'REG' and LocAddressState = 'NY' and eepgender = 'M' THEN 'DBLSM' 
                        --WHEN EecEEType = 'REG' and LocAddressState = 'NY' and eepgender = 'F' THEN 'DBLSF'
                    END
        ,drvBENEFITSTATUS  = CASE WHEN eeddedcode IN ('BLIFT', 'BLIFE', 'BADD', 'BADDT', 'LIFEE', 'LIFET', 'LIFES', 'LIFST', 'LIFEC', 'LFECT', 'VLTD', 'VSTD','VADDE', 'VADTE','VADDS', 'VADTS') and eedbenstatus IN ('T','C') THEN '349' 
                                  WHEN eeddedcode NOT IN ('BLIFT', 'BLIFE', 'BADD', 'BADDT', 'LIFEE', 'LIFET', 'LIFES', 'LIFST', 'LIFEC', 'LFECT', 'VLTD', 'VSTD','VADDE', 'VADTE','VADDS', 'VADTS') and eecemplstatus = 'T' THEN '349'
                                  ELSE  '348'
                              END
        ,drvEFFDATE = CASE WHEN eeddedcode IN ('BLIFT', 'BLIFE', 'BADD', 'BADDT', 'LIFEE', 'LIFET', 'LIFES', 'LIFST', 'LIFEC', 'LFECT', 'VLTD', 'VSTD','VADDE', 'VADTE','VADDS', 'VADTS') THEN eedbenstartdate else eecdateoflasthire END  
        ,drvTERMDATE = CASE WHEN eeddedcode IN ('BLIFT', 'BLIFE', 'BADD', 'BADDT', 'LIFEE', 'LIFET', 'LIFES', 'LIFST', 'LIFEC', 'LFECT', 'VLTD', 'VSTD','VADDE', 'VADTE','VADDS', 'VADTS') THEN eedbenstopdate else EecDateOfTermination END


        ,drvCOVERAGEAMOUNT = CASE WHEN EedDedcode IN ('LIFEE', 'LIFET', 'LIFES', 'LIFST','VADDE', 'VADTE','VADDS', 'VADTS') and EedBenStatus not in ('A') THEN [dbo].[dsi_fnPadZero](BcaBenAmtMax *100,15,0)  
                                WHEN EedDedcode IN ('LIFEE', 'LIFET', 'LIFES', 'LIFST','VADDE', 'VADTE','VADDS', 'VADTS') and EedBenStatus = 'A' THEN  [dbo].[dsi_fnPadZero](BcaEEBenAmt *100,15,0) --[dbo].[dsi_fnPadZero](EedBenAmt *100,15,0) 
                                    --ELSE  [dbo].[dsi_fnPadZero](EedBenAmt *100,15,0) 
                                --WHEN EedBenAmt = 0.00 and EedBenStatus = 'A' then '' 
                                    END 
                                
        --,drvCOVERAGEAMOUNT = CASE WHEN EedBenAmt = 0.00 then '' ELSE  CASE WHEN EedDedcode IN ('LIFEE', 'LIFET', 'LIFES', 'LIFST') THEN [dbo].[dsi_fnPadZero](EedBenAmt *100,15,0) END END-- CASE WHEN EedBenAmt = 0.00 then '' ELSE [dbo].[dsi_fnPadZero](EedBenAmt *100,15,0) END  
        ,drvBENSELECTOPT = space(2)
        ,drvFILLER2 = space(1441)
    INTO dbo.U_EANTHMFMLA_drvTbl_200
    --FROM dbo.U_EANTHMFMLA_EEList WITH (NOLOCK) 
    FROM dbo.U_EANTHMFMLA_drvTbl_100 WITH (NOLOCK) 
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID 
        AND EecCoID = drvCoID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.location WITH (NOLOCK)
         ON loccode = eeclocation
    LEFT JOIN dbo.Emppers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN dbo.u_dsi_bdm_BenCalculationAmounts ON eedeeid = bcaeeid AND eedcoid = bcacoid
    AND eedFormatCode = bcaFormatCode AND eeddedcode = bcadedcode
    AND BcaDepRecID IS NULL and bcaFormatcode = @FormatCode
    ;


    --PFLSM/PFLSF Segment (NY MAnadated Paid Family Leave - Male or Female)

        INSERT INTO dbo.U_EANTHMFMLA_drvTbl_200
           SELECT DISTINCT
                drvEEID = drvEEID
               ,drvCoID = drvCOID
               ,drvDepRecID = CONVERT(varchar(12),'1')
               ,drvInitialSort = drvInitialSort
               ,drvSubsort = ''
               ,drvSubsort2 = ''
               ,drvRECORDTYPE = '210'
               ,drvLOB = CASE WHEN eepgender = 'M' then 'PFLSM' when eepgender = 'F' then 'PFLSF' end
               ,drvBENEFITSTATUS = CASE WHEN eecEmplstatus IN ('T') THEN '349' 
                                      ELSE  '348'
                                  END
               ,drvEFFDATE = dbo.dsi_fnGetMinMaxDates('MAX','8/1/2020', EecDateOfLastHire)  -- Eecdateoflasthire 
               ,drvTERMDATE = EecDateOfTermination 
               ,drvCOVERAGEAMOUNT = ''
               ,drvBENSELECTOPT = space(2)
               ,drvFILLER2 = space(1441)
    FROM U_EANTHMFMLA_drvTbl_100
    JOIN dbo.empcomp  with (NOLOCK)
    on EecEEID = drveeid
    and eecCOID = drvCOID
    and EecWCState = 'NY'
    LEFT JOIN dbo.EmpPers with (NOLOCK) 
    on EepEEID = EecEEID 
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = 'EANTHMFMLA' 
        AND EedValidForExport = 'Y' 
        --WHERE NOT EXISTS(SELECT 1 from dbo.U_EANTHMFMLA_drvTbl_200 WITH (NOLOCK) WHERE drvEEID = drvEEID and drvLOB = 'PFLSM' or drvLOB = 'PFLSF')

 --DBLSM/DBLSF Segment (NY MAnadated STD - Male or Female)
    INSERT INTO dbo.U_EANTHMFMLA_drvTbl_200
           SELECT DISTINCT
                drvEEID = drvEEID
               ,drvCoID = drvCOID
               ,drvDepRecID = CONVERT(varchar(12),'1')
               ,drvInitialSort = drvInitialSort
               ,drvSubsort = ''
               ,drvSubsort2 = ''
               ,drvRECORDTYPE = '210'
               ,drvLOB = CASE WHEN eepgender = 'M' then 'DBLSM' when eepgender = 'F' then 'DBLSF' end
               ,drvBENEFITSTATUS = CASE WHEN eecEmplstatus IN ('T') THEN '349' 
                                      ELSE  '348'
                                  END
               ,drvEFFDATE = dbo.dsi_fnGetMinMaxDates('MAX','8/1/2020', EecDateOfLastHire)  -- Eecdateoflasthire  
               ,drvTERMDATE = EecDateOfTermination
               ,drvCOVERAGEAMOUNT = ''
               ,drvBENSELECTOPT = space(2)
               ,drvFILLER2 = space(1441)
    FROM U_EANTHMFMLA_drvTbl_100
    JOIN empcomp 
    on EecEEID = drveeid
    and eecCOID = drvCOID
    and EecWCState = 'NY'
    LEFT JOIN dbo.EmpPers with (NOLOCK) 
    on EepEEID = EecEEID 
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = 'EANTHMFMLA' 
        AND EedValidForExport = 'Y'
        --WHERE NOT EXISTS(SELECT 1 from dbo.U_EANTHMFMLA_drvTbl_200 WITH (NOLOCK) WHERE drvEEID = drvEEID and drvLOB = 'DBLSM' or drvLOB = 'DBLSF')

-- ADD
 --INSERT INTO dbo.U_EANTHMFMLA_drvTbl_200         
 --          SELECT DISTINCT
 --               drvEEID = drvEEID
 --              ,drvCoID = drvCOID
 --              ,drvDepRecID = CONVERT(varchar(12),'1')
 --              ,drvInitialSort = drvInitialSort
 --              ,drvSubsort = ''
 --              ,drvSubsort2 = ''
 --              ,drvRECORDTYPE = '210'
 --              ,drvLOB = CASE  WHEN eeddedcode IN ('VADDE', 'VADTE') THEN 'SUPP ADD-Flat'  --updated 11/20/23 LeaK
 --                              WHEN eeddedcode IN ('VADDS', 'VADTS') THEN 'DEP SP ADD'    --updated 11/20/23 LeaK
    --                           --WHEN eeddedcode IN ('LIFEE','LIFET') THEN 'SUPP ADD-Flat'
 --                              --WHEN eeddedcode IN ('LIFES','LIFST') THEN 'DEP SP ADD' 
 --                              WHEN eeddedcode IN ('LIFEC','LFECT') THEN 'Dep AD&D' 
 --                       end
 --              ,drvBENEFITSTATUS = CASE WHEN eedbenstatus IN ('T','C') THEN '349' 
 --                                 ELSE  '348'
 --                             END
 --              ,drvEFFDATE = eedbenstartdate 
 --              ,drvTERMDATE = eedbenstopdate 
 --              --,drvCOVERAGEAMOUNT = CASE WHEN EedBenAmt = 0.00 then '' ELSE  CASE WHEN EedDedcode IN ('LIFEE', 'LIFET','LIFES','LIFST', 'LIFEC') THEN [dbo].[dsi_fnPadZero](EedBenAmt *100,15,0) END END
 --              ,drvCOVERAGEAMOUNT = CASE WHEN EedDedcode IN ('LIFEC','LFECT') THEN space(15)
 --                                        WHEN EedDedcode IN ('VADDE', 'VADTE','VADDS', 'VADTS') and EedBenStatus not in ('A') THEN [dbo].[dsi_fnPadZero](BcaBenAmtMax *100,15,0)  
    --                                     --WHEN EedDedcode IN ('LIFEE', 'LIFET', 'LIFES', 'LIFST') and EedBenStatus not in ('A') THEN [dbo].[dsi_fnPadZero](BcaBenAmtMax *100,15,0)  
 --                                   ELSE  [dbo].[dsi_fnPadZero](EedBenAmt *100,15,0) 
 --                               --WHEN EedBenAmt = 0.00 and EedBenStatus = 'A' then '' 
 --                                   END 
 --              ,drvBENSELECTOPT = space(2)
 --              ,drvFILLER2 = space(1441)
 --   FROM U_EANTHMFMLA_drvTbl_100
 --   JOIN dbo.empcomp  with (NOLOCK)
 --   on EecEEID = drveeid
 --   and eecCOID = drvCOID
 --   LEFT JOIN dbo.EmpPers with (NOLOCK) 
 --   on EepEEID = EecEEID 
 --   JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
 --       ON EedEEID = drvEEID 
 --       AND EedCoID = drvCoID
 --       AND EedFormatCode = 'EANTHMFMLA' 
 --       AND EedValidForExport = 'Y'
 --       AND EedDedCode IN ('VADDE', 'VADTE','VADDS', 'VADTS', 'LIFEC','LFECT')
    --    --AND EedDedCode IN ('LIFEE', 'LIFET','LIFES','LIFST', 'LIFEC','LFECT')
 --   JOIN dbo.u_dsi_bdm_BenCalculationAmounts ON eedeeid = bcaeeid AND eedcoid = bcacoid
 --   AND eedFormatCode = bcaFormatCode AND eeddedcode = bcadedcode
 --   AND BcaDepRecID IS NULL and bcaFormatcode = @FormatCode  

        -- FML
INSERT INTO dbo.U_EANTHMFMLA_drvTbl_200         
           SELECT DISTINCT
                drvEEID = drvEEID
               ,drvCoID = drvCOID
               ,drvDepRecID = CONVERT(varchar(12),'1')
               ,drvInitialSort = drvInitialSort
               ,drvSubsort = ''
               ,drvSubsort2 = ''
               ,drvRECORDTYPE = '210'
               ,drvLOB = 'FML'
               ,drvBENEFITSTATUS = CASE WHEN eecEmplstatus IN ('T') THEN '349' 
                                      ELSE  '348'
                                  END
               ,drvEFFDATE = dbo.dsi_fnGetMinMaxDates('MAX','2/1/2021', EecDateOfLastHire)  --EecDateofLastHire 
               ,drvTERMDATE = EecDateOfTermination 
               ,drvCOVERAGEAMOUNT = ''--CASE WHEN EedBenAmt = 0.00 then '' ELSE  CASE WHEN EedDedcode IN ('LIFEE', 'LIFET','LIFES','LIFST', 'LIFEC') THEN [dbo].[dsi_fnPadZero](EedBenAmt *100,15,0) END END
               ,drvBENSELECTOPT = space(2)
               ,drvFILLER2 = space(1441)
    FROM U_EANTHMFMLA_drvTbl_100
    JOIN dbo.empcomp  with (NOLOCK)
    on EecEEID = drveeid
    and eecCOID = drvCOID and EecEEtype = 'REG'
    LEFT JOIN dbo.EmpPers with (NOLOCK) 
    on EepEEID = EecEEID 

    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_210
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_210;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE = '999'
        ,drvUDDTTYPE = 'UDDT_PRM_CNT_EMAIL'
        ,drvVALUE = 'HRTeam@rwcatskills.com'
        --CASE WHEN [dbo].[dsi_fnlib_GetSupervisorField_EANTHMFMLA](drvcoid, drveeid,'AddressEMail') = '' THEN [dbo].[dsi_fnlib_GetSupervisorField_EANTHMFMLA](drvcoid, drveeid,'AddressEMailAlternate') 
        --ELSE [dbo].[dsi_fnlib_GetSupervisorField_EANTHMFMLA](drvcoid, drveeid,'AddressEMail') END
        --CASE WHEN ISNULL([dbo].[dsi_fnlib_GetSupervisorField_EANTHMFMLA](drvcoid, drveeid,'AddressEMail'), '') <> ''   THEN [dbo].[dsi_fnlib_GetSupervisorField_EANTHMFMLA](drvcoid, drveeid,'AddressEMailAlternate') 
        --            ELSE [dbo].[dsi_fnlib_GetSupervisorField_EANTHMFMLA](drvcoid, drveeid,'AddressEMailAlternate') 
        --            END

        ,drvLOB = space(20)
        ,drvEFFDATE = GETDATE()
        ,drvFILLER = space(1139)
    INTO dbo.U_EANTHMFMLA_drvTbl_210
    FROM dbo.U_EANTHMFMLA_drvTbl_100
   LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_210_1
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_1','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_210_1;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE_UT1 = '999'
        ,drvUDDTTYPE_UT1 = 'UDDT_HR_CNT_EMAIL'
        ,drvVALUE_UT1 = 'hr@rwnewyork.com'
        ,drvLOB_UT1 = space(20)
        ,drvEFFDATE_UT1 = GETDATE()
        ,drvFILLER_UT1 = space(1139)
    INTO dbo.U_EANTHMFMLA_drvTbl_210_1
    FROM dbo.U_EANTHMFMLA_drvTbl_100
   LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_210_2
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_2','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_210_2;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE_UT2 = '999'
        ,drvUDDTTYPE_UT2 = 'UDDT_FT'
        ,drvVALUE_UT2 = CASE WHEN EecFulltimeOrPartTime = 'F' THEN '1' else '0' END
        ,drvLOB_UT2 = space(20)
        ,drvEFFDATE_UT2 = GETDATE()
        ,drvFILLER_UT2 = space(1139)
    INTO dbo.U_EANTHMFMLA_drvTbl_210_2
    FROM dbo.U_EANTHMFMLA_drvTbl_100
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID 
        AND EecCoID = drvCoID
   LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_210_3
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_3','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_210_3;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE_UT3 = '999'
        ,drvUDDTTYPE_UT3 = 'UDDT_WRK_ST '
        ,drvVALUE_UT3 = LocAddressState --Eeclocation
        ,drvLOB_UT3 = space(20)
        ,drvEFFDATE_UT3 = GETDATE()
        ,drvFILLER_UT3 = space(1139)
    INTO dbo.U_EANTHMFMLA_drvTbl_210_3
    FROM dbo.U_EANTHMFMLA_drvTbl_100
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID 
        AND EecCoID = drvCoID
  LEFT  JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.Location with (nolock)
        ON locCode = eecLocation
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_210_4
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_4','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_210_4;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE_UT4 = '999'
        ,drvUDDTTYPE_UT4 = 'UDDT_YR_HRS '
        ,drvVALUE_UT4 = --[dbo].[dsi_fnPadZero](PehCurHrs12mth,4,0) --CONVERT(VARCHAR, CONVERT(DECIMAL(10,0), PehCurHrs12mth))
         CASE WHEN PehCurHrs12mth <> 0.00  THEN [dbo].[dsi_fnPadZero](IIF(ISNUMERIC(wiht.EecUDField29)=1,CAST(wiht.EecUDField29 AS INTEGER),0) + PehCurHrs12mth,4,0) ELSE IIF(ISNUMERIC(wiht.EecUDField29)=1,CAST(wiht.EecUDField29 AS INTEGER),0) + [dbo].[dsi_fnPadZero](EecScheduledWorkHrs,4,0) END 
        ,drvLOB_UT4 = space(20)
        ,drvEFFDATE_UT4 = GETDATE()
        ,drvFILLER_UT4 = space(1139)
    INTO dbo.U_EANTHMFMLA_drvTbl_210_4
    FROM dbo.U_EANTHMFMLA_drvTbl_100
    JOIN dbo.Empcomp wiht (nolock) 
        ON Eeceeid = drvEEID
        AND EecCOID = drvCOID
  LEFT  JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID 
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_EANTHMFMLA_PEarHist WITH (NOLOCK)
        ON pehEEID = drvEEID

    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_210_5
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_5','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_210_5;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE_UT5 = '999'
        ,drvUDDTTYPE_UT5 = 'UDDT_CNTRCTR_HIRE_DT '
        ,drvVALUE_UT5 = IIF(ISDATE(EecUDField28)=1,convert(varchar(8),CAST(EecUDField28 AS DATE), 112),'') 
        ,drvLOB_UT5 = space(20)
        ,drvEFFDATE_UT5 = GETDATE()
        ,drvFILLER_UT5 = space(1139)
    INTO dbo.U_EANTHMFMLA_drvTbl_210_5
    FROM dbo.U_EANTHMFMLA_drvTbl_100
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID 
        AND EecCoID = drvCoID
        AND EecEEType = 'REG'
   LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    JOIN dbo.Company WITH (NOLOCK)
        ON cmpCOID = drvCOID
    WHERE ISDATE(EecUDField28)=1
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_210_6
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_6','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_210_6;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE_UT6 = '999'
        ,drvUDDTTYPE_UT6 = 'UDDT_ORG_CD '
        ,drvVALUE_UT6 = CASE WHEN cmpcompanycode = 'ERI'  THEN '0000' --'AL00006406' 12/31/2020 change to case logic
                             WHEN cmpcompanycode = 'MRMI' and eecpaygroup <> 'RWHV' THEN '0001'
                             WHEN cmpcompanycode = 'MOC'  THEN '0002'
                             WHEN cmpcompanycode = 'MRMI' and eecpaygroup = 'RWHV' THEN '0003'
                            END
        ,drvLOB_UT6 = space(20)
        ,drvEFFDATE_UT6 = GETDATE()
        ,drvFILLER_UT6 = space(1139)
    INTO dbo.U_EANTHMFMLA_drvTbl_210_6
    FROM dbo.U_EANTHMFMLA_drvTbl_100
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID 
        AND EecCoID = drvCoID
        AND EecEEType = 'REG'
   LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    JOIN dbo.Company WITH (NOLOCK)
        ON cmpCOID = drvCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_210_7
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_7','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_210_7;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE_UT7 = '999'
        ,drvUDDTTYPE_UT7 = 'UDDT_EMP_TYP '
        ,drvVALUE_UT7 = 'HMRS'
        ,drvLOB_UT7 = space(20)
        ,drvEFFDATE_UT7 = GETDATE()
        ,drvFILLER_UT7 = space(1139)
    INTO dbo.U_EANTHMFMLA_drvTbl_210_7
    FROM dbo.U_EANTHMFMLA_drvTbl_100
   LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_210_8
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_210_8','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_210_8;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE_UT8 = '999'
        ,drvUDDTTYPE_UT8 = 'UDDT_ORG_TYP'
        ,drvVALUE_UT8 = 'AREA'
        ,drvLOB_UT8 = ''
        ,drvEFFDATE_UT8 = GETDATE()
        ,drvFILLER_UT8 = space(1139)
    INTO dbo.U_EANTHMFMLA_drvTbl_210_8
    FROM dbo.U_EANTHMFMLA_drvTbl_100
  LEFT  JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    ;
   
    ---------------------------------
    -- DETAIL RECORD - U_EANTHMFMLA_drvTbl_230
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_drvTbl_230','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_drvTbl_230;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1'+ drvEEID
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvRECORDTYPE = '230'
        ,drvDOB = CASE WHEN conrelationship = 'SPS' THEN ConDateOfBirth END
        ,drvFIRSTNAME = ConNameFirst
        ,drvMIDNAME = space(50)
        ,drvLASTNAME = ConNameLast
        ,drvMAIDENNAME = space(50)
        ,drvGENDER = CASE WHEN conrelationship = 'SPS' THEN CASE WHEN conGender = 'M' THEN 'Male' WHEN conGender = 'F' THEN 'Female' END END
        ,drvRELATIONCODE = CASE WHEN conrelationship = 'SPS' THEN '01' END
        ,drvEFFDATE_SP = DbnBenStartDate
        ,drvTERMDATE = space(8)
        ,drvSSN = space(20)
        ,drvSmokerCode = space(1)
        ,drvMEMBERCLASSNO = CASE WHEN EecDedGroupCode IN ('RWCPT','RCPTT') THEN '04'
                                 WHEN EecDedGroupCode = 'PTL6N' and eeddedcode in ('BLIFE','BADD') and eedbenstatus <> 'A' THEN '04'
                                 WHEN EecDedGroupCode = 'L6PTT' and eeddedcode in ('BLIFT','BADDT') and eedbenstatus <> 'A' THEN '04'
                                 WHEN EecDedGroupCode IN ('RWCHT','L6TC') THEN '02'
                                 WHEN EecDedGroupCode = 'PTL6N' and eeddedcode in ('BLIFE','BADD') and eedbenstatus = 'A' THEN '01'
                                 WHEN EecDedGroupCode = 'L6PTT' and eeddedcode in ('BLIFT','BADDT') and eedbenstatus = 'A' THEN '02'
                                Else '01'
                                END
                                --CASE WHEN EecDedGroupCode IN ('RWCHT','L6TC') THEN '02'
        --                         WHEN EecFullTimeOrPartTime = 'P' OR EecDedGroupCode = 'PT' THEN '04'
                                --Else '01'
        --                        END
        ,drvLOB = CASE
                    WHEN dbnDedCode IN ('LIFES', 'LIFST') THEN 'DEP Spouse'
                    WHEN dbnDedCode IN ('LIFES', 'LIFST') THEN 'DEP SP ADD'
                  END
        ,drvEFFDATE = DbnBenStartDate
        ,drvCOVERAGEAMOUT =  CASE WHEN dbnDedcode IN ('LIFES','LIFST') THEN [dbo].[dsi_fnPadZero](eedBenAmt *100,15,0) END
        ,drvBENSELECTOPT = space(2)
        ,drvFILLER4 = space(1199)
    INTO dbo.U_EANTHMFMLA_drvTbl_230
    FROM dbo.U_EANTHMFMLA_drvTbl_100
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID 
        AND EecCoID = drvCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = drvEEID 
        AND DbnCoID = drvCoID
        AND DbnFormatCode = @FormatCode 
        AND DbnValidForExport = 'Y'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = drvEEID 
        AND EedCoID = drvCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drvEEID
    --LEFT JOIN dbo.BenProg WITH (NOLOCK)
    --    ON  CbpDedCode = DbnDedcode
    WHERE conrelationship = 'SPS' 
    ;

    --'dbo.U_EANTHMFMLA_HeaderTop
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_HeaderTop','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_HeaderTop;
    SELECT DISTINCT
         drvRECORDTYPE = CONCAT('_W–SOF_:fmlprop:ct12139z:FML Proprietary:'
                                , IIF(@ExportCode LIKE 'TEST%', 'T', 'P')    --CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'T' ELSE 'P' END     
                                ,'::')
        ,drvFiller = CONCAT(space(1454),':')
    INTO dbo.U_EANTHMFMLA_HeaderTop
    ;

    IF OBJECT_ID('U_EANTHMFMLA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_Header;
    SELECT DISTINCT
         drvRECORDTYPE = '100'
        ,drvGRPNO = 'AL00006406'
        ,drvGROUPNAME = 'Montreign Operating Company, LLC'
        ,drvDATE = GETDATE()
        ,drvTIME = REPLACE(convert(varchar, getdate(), 108), ':', '')
        ,drvFULLFILEDETLA = '1'
        ,drvFILLER = ''
    INTO dbo.U_EANTHMFMLA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTHMFMLA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EANTHMFMLA_Trailer;
    SELECT DISTINCT
         drvRECORDTYPE = '300'
        ,drvTOTALRECORDS =  
                         (SELECT 
                            (SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_HeaderTop)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_Header)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_100)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_200)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_210)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_210_1)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_210_2)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_210_3)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_210_4)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_210_5)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_210_6)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_210_7)
                            +(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_210_8)
                          --+(SELECT COUNT(*) FROM dbo.U_EANTHMFMLA_drvTbl_230) -- U_dsi_SQLClauses - EANTHMFMLA,D40,dbo.U_EANTHMFMLA_drvTbl_230,IGNORE
                            +(1)-- trailer
                         )
        ,drvFILLER = SPACE(1487)
    INTO dbo.U_EANTHMFMLA_Trailer
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
ALTER VIEW dbo.dsi_vwEANTHMFMLA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EANTHMFMLA_File (NOLOCK)
        ORDER BY InitialSort, SubSort,  RIGHT(RecordSet,2);

    ALTER VIEW dbo.dsi_vwEANTHMFMLA_Export AS    
        SELECT TOP 20000000 CASE WHEN RECORDSET = 'H01' THEN RTRIM(DATA) ELSE DATA END Data FROM dbo.U_EANTHMFMLA_File (NOLOCK)
        ORDER BY InitialSort, SubSort,  RIGHT(RecordSet,2);   

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EANTHMFMLA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202311211'
       ,expStartPerControl     = '202311211'
       ,expLastEndPerControl   = '202311289'
       ,expEndPerControl       = '202311289'
WHERE expFormatCode = 'EANTHMFMLA' and expExportcode LIKE '%TEST%';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEANTHMFMLA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EANTHMFMLA_File (NOLOCK)
        ORDER BY InitialSort, SubSort,  RIGHT(RecordSet,2);
GO
CREATE FUNCTION [dbo].[dsi_fnlib_GetSupervisorField_EANTHMFMLA] (    
@COID            VARCHAR(5),    
@EEID            VARCHAR(12),    
@FieldName       VARCHAR(32)    
)    
    
RETURNS VARCHAR(256)    
WITH EXECUTE AS CALLER    
AS    
    
/************************************************************    
    
Created By: John Transier    
Create Date: 08/16/2017    
    
Revision History    
----------------    
Update By            Date            Desc    
XXXX                 XX/XX/16        Added 1234    
    
Purpose: Pulls basic supervisor fields for an employee, e.g. name, employee number.    
             
Description    
-----------    
Pulls basic supervisor fields, e.g. name, employee number. If COID is left blank it will pull the employee's current COID.    
    
    
Commands     
--------    
SELECT     
    
EecEEID,     
EecSupervisorID,    
dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast, First')     
    
FROM dbo.EmpComp    
    
************************************************************/    
    
BEGIN    
    
-----------    
-- Declare and set variables    
-----------    
    
DECLARE @Return         VARCHAR(256)    
DECLARE @SupervisorCOID VARCHAR(5)    
DECLARE @SupervisorEEID VARCHAR(12)    
    
SET @COID      = LTRIM(RTRIM(COALESCE(@COID, '')))    
SET @EEID      = LTRIM(RTRIM(COALESCE(@EEID, '')))    
SET @FieldName = LTRIM(RTRIM(COALESCE(@FieldName, '')))    
    
IF @EEID      = '' RETURN ''    
IF @FieldName = '' RETURN ''    
    
IF @COID = '' SET @COID = dbo.dsi_fn_GetCurrentCOID(@EEID)     
    
    
-----------    
-- Set supervisor fields    
-----------    
    
SELECT     
    
@SupervisorEEID = LTRIM(RTRIM(COALESCE(EecSupervisorID, ''))),    
@SupervisorCOID = dbo.dsi_fn_GetCurrentCOID(EecSupervisorID)     
       
FROM dbo.EmpComp    
WHERE EecCOID = @COID    
  AND EecEEID = @EEID    
    
IF @SupervisorEEID = '' RETURN ''    
    
    
-----------    
-- Get supervisor data    
-----------    
    
SELECT @Return = CASE    
                    WHEN @FieldName = 'SSN'               THEN EepSSN    
                    WHEN @FieldName = 'NameFirst'         THEN EepNameFirst    
                    WHEN @FieldName = 'NameLast'          THEN EepNameLast    
                    WHEN @FieldName = 'NameMiddle'        THEN EepNameMiddle    
                    WHEN @FieldName = 'NameMiddleInit'    THEN LEFT(EepNameMiddle, 1)    
                    WHEN @FieldName = 'NameLast, First'   THEN LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst))    
                    WHEN @FieldName = 'NameLast, First M' THEN LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + COALESCE(LEFT(EepNameMiddle, 1), '')  
                    WHEN @FieldName = 'NameFirst Last'    THEN LTRIM(RTRIM(EepNameFirst)) + ' ' + LTRIM(RTRIM(EepNameLast))    
                    WHEN @FieldName = 'NameFML'           THEN LTRIM(RTRIM(EepNameFirst)) + ' ' + LTRIM(RTRIM(COALESCE(EepNameMiddle, ''))) + ' ' + LTRIM(RTRIM(EepNameLast))    
                    WHEN @FieldName = 'AddressEMail'      THEN EepAddressEMail  
                    WHEN @FieldName = 'AddressEMailAlternate'      THEN EepAddressEMailAlternate      
                    WHEN @FieldName = 'PhoneHomeNumber'   THEN EepPhoneHomeNumber    
                    WHEN @FieldName = 'EmpNo'             THEN EecEmpNo    
                    WHEN @FieldName = 'Status'            THEN EecEmplStatus    
                    WHEN @FieldName = 'JobDesc'           THEN JbcDesc    
                    WHEN @FieldName = 'COID'              THEN @SupervisorCOID    
     ELSE ''    
     END    
FROM EmpPers    
JOIN EmpComp WITH (NOLOCK) ON EecEEID = EepEEID AND EecCOID = @SupervisorCOID    
JOIN dbo.JobCode WITH (NOLOCK) ON JbcJobCode = EecJobCode    
WHERE EepEEID = @SupervisorEEID    
    
    
-----------    
-- Return    
-----------    
    
RETURN LTRIM(RTRIM(COALESCE(@Return, '')))    
    
END    

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EANTHMFMLA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EANTHMFMLA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EANTHMFMLA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EANTHMFMLA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EANTHMFMLA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EANTHMFMLA', 'UseFileName', 'V', 'Y'


-- End ripout