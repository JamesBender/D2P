/**********************************************************************************

EFIDFIS401: Fidelity 401K Export

FormatCode:     EFIDFIS401
Project:        Fidelity 401K Export
Client ID:      GLE1002
Date/time:      2021-12-22 12:53:03.733
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E32
Server:         E3SUP2ST01
Database:       ULTIPRO_GLEN
Web Filename:   GLE1002_E37C5_EEHISTORY_EFIDFIS401_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFIDFIS401_SavePath') IS NOT NULL DROP TABLE dbo.U_EFIDFIS401_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFIDFIS401'


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
WHERE FormatCode = 'EFIDFIS401'
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
WHERE ExpFormatCode = 'EFIDFIS401'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFIDFIS401')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFIDFIS401'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFIDFIS401'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFIDFIS401'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFIDFIS401'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFIDFIS401'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFIDFIS401'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFIDFIS401'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFIDFIS401'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFIDFIS401'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFIDFIS401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFIDFIS401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFIDFIS401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDFIS401];
GO
IF OBJECT_ID('U_EFIDFIS401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_PEarHist];
GO
IF OBJECT_ID('U_EFIDFIS401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_PDedHist];
GO
IF OBJECT_ID('U_EFIDFIS401_File') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_File];
GO
IF OBJECT_ID('U_EFIDFIS401_Employees') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_Employees];
GO
IF OBJECT_ID('U_EFIDFIS401_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_EEList];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_EA') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_EA];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_61') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_61];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_60') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_60];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_36') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_36];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_21') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_21];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_19Q') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_19Q];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_11') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_11];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_08') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_08];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_06') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_06];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_05') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_05];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_04') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_04];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_03') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_03];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_02E') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_02E];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_02D') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_02D];
GO
IF OBJECT_ID('U_EFIDFIS401_drvTbl_01') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_drvTbl_01];
GO
IF OBJECT_ID('U_EFIDFIS401_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_DedList];
GO
IF OBJECT_ID('U_EFIDFIS401_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_AuditFields];
GO
IF OBJECT_ID('U_EFIDFIS401_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFIDFIS401_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFIDFIS401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFIDFIS401];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFIDFIS401','Fidelity 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','80','S','N','EFIDFIS401Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','7','H','01','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','73','H','01','8',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','10','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','10','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','10','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','10','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','20','D','10','32',NULL,'LAST NAME (FREE FORM)',NULL,NULL,'"drvLASTNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','15','D','10','52',NULL,'FIRST NAME MIDDLE INITIAL (FREE FORM)',NULL,NULL,'"drvFIRSTNAMEMIDDLEINITIAL"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','9','D','10','67',NULL,'RESERVED',NULL,NULL,'"000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','1','D','10','76',NULL,'MARITAL STATUS',NULL,NULL,'"drvMARITALSTATUS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','1','D','10','77',NULL,'GENDER',NULL,NULL,'"drvGENDER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','1','D','10','78',NULL,'SPECIAL TAX TYPE ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFIDFIS401Z0','1','D','10','79',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFIDFIS401Z0','1','D','10','80',NULL,'BENE/QDRO PAYEE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','15','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','15','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','15','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','15','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','15','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','15','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"02"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','1','D','15','32',NULL,'FIELD TYPE',NULL,NULL,'"D"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','4','D','15','33',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','8','D','15','37',NULL,'HIRE DATE',NULL,NULL,'"drvHIREDATE"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','8','D','15','45',NULL,'PARTICIPATION DATE',NULL,NULL,'"00000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','8','D','15','53',NULL,'VESTING DATE',NULL,NULL,'"00000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','8','D','15','61',NULL,'DATE-OF-BIRTH',NULL,NULL,'"drvDATEOFBIRTH"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFIDFIS401Z0','8','D','15','69',NULL,'TERMINATION DATE',NULL,NULL,'"drvTERMINATIONDATE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFIDFIS401Z0','1','D','15','77',NULL,'DATE SWITCH',NULL,NULL,'"drvDateSwitch"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFIDFIS401Z0','1','D','15','78',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFIDFIS401Z0','1','D','15','79',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFIDFIS401Z0','1','D','15','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','20','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','20','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','20','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','20','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','20','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','20','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"02"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','1','D','20','32',NULL,'FIELD TYPE',NULL,NULL,'"E"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','11','D','20','33',NULL,'EMPLOYEE NUMBER',NULL,NULL,'"drvEMPLOYEENUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','1','D','20','44',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','2','D','20','45',NULL,'EMPLOYEE NUMBER STATUS CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','12','D','20','47',NULL,'CLIENT PROVIDED ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','22','D','20','59',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','25','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','25','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','25','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','25','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','25','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','25','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"03"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','1','D','25','32',NULL,'RECORD TYPE',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','2','D','25','33',NULL,'ADDRESS LINE NUMBER',NULL,NULL,'"drvADDRESSLINENUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','32','D','25','35',NULL,'ADDRESS',NULL,NULL,'"drvADDRESS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','11','D','25','67',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','1','D','25','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','1','D','25','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFIDFIS401Z0','1','D','25','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','30','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','30','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','30','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','30','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','30','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','30','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"04"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','1','D','30','32',NULL,'RECORD TYPE',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','20','D','30','33',NULL,'CITY',NULL,NULL,'"drvCITY"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','2','D','30','53',NULL,'STATE',NULL,NULL,'"drvSTATE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','8','D','30','55',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','5','D','30','63',NULL,'ZIP CODE',NULL,NULL,'"drvZIPCODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','4','D','30','68',NULL,'ZIP + 4 CODE',NULL,NULL,'"drvZIP4CODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFIDFIS401Z0','6','D','30','72',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFIDFIS401Z0','1','D','30','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFIDFIS401Z0','1','D','30','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFIDFIS401Z0','1','D','30','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','35','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','35','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','35','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','35','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','35','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','35','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"05"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','1','D','35','32',NULL,'RECORD TYPE',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','23','D','35','33',NULL,'COUNTRY',NULL,NULL,'"drvCOUNTRY"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','1','D','35','56',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','1','D','35','57',NULL,'SPECIAL HANDLING',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','19','D','35','58',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','1','D','35','77',NULL,'MAILING INDICATOR',NULL,NULL,'"drvMAILINGINDICATOR"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFIDFIS401Z0','1','D','35','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFIDFIS401Z0','1','D','35','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFIDFIS401Z0','1','D','35','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','40','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','40','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','40','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','40','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','40','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','40','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"06"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','20','D','40','32',NULL,'DIVISION ID (Name)',NULL,NULL,'"drvDIVISIONID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','20','D','40','52',NULL,'REGION ID',NULL,NULL,'"drvRegionId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','3','D','40','72',NULL,'SITE SECURITY CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','4','D','40','75',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','2','D','40','79',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','43','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','7','D','43','6',NULL,'BATCH GROUP ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','11','D','43','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','1','D','43','24',NULL,'BATCH GROUP ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','5','D','43','25',NULL,'BATCH GROUP ID',NULL,NULL,'"00000"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','43','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"08"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','13','D','43','32',NULL,'SALARY',NULL,NULL,'"drvSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','1','D','43','45',NULL,'SALARY INDICATOR',NULL,NULL,'"drvSalaryInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','2','D','43','46',NULL,'SPACES',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','8','D','43','46',NULL,'SALARY PAY DATE',NULL,NULL,'"drvSalPayDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','8','D','43','46',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','45','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','45','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','45','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','45','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','45','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','45','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"11"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','1','D','45','32',NULL,'STATUS CODE',NULL,NULL,'"drvSTATUSCODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','5','D','45','33',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','8','D','45','38',NULL,'STATUS CHANGE DATE',NULL,NULL,'"drvStatusDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','1','D','45','46',NULL,'LITERATURE KIT INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','32','D','45','47',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','1','D','45','79',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFIDFIS401Z0','1','D','45','80',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','50','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','50','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','50','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','50','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','50','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','50','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"36"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','4','D','50','32',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','4','D','50','36',NULL,'DIVISION CODE',NULL,NULL,'"drvDIVISIONCODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','40','D','50','40',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','1','D','50','80',NULL,'DIVISION CODE EXISTS INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','55','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','55','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','55','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','55','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','55','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','55','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"60"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','1','D','55','32',NULL,'PARTICIPANT CLASS',NULL,NULL,'"drvPARTICIPANTCLASS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','8','D','55','33',NULL,'PARTICIPANT DISTRICT',NULL,NULL,'"drvPARTICIPANTDISTRICT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','8','D','55','41',NULL,'PARTICIPANT DEPARTMENT',NULL,NULL,'"drvPARTICIPANTDEPARTMENT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','8','D','55','49',NULL,'PARTICIPANT LOCATION/STORE',NULL,NULL,'"drvPARTICIPANTLOCATIONSTORE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','8','D','55','57',NULL,'PARTICIPANT UNION CODE',NULL,NULL,'"drvPARTICIPANTUNIONCODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','1','D','55','65',NULL,'PARTICIPANT PAYMENT FREQUENCY',NULL,NULL,'"drvPARTICIPANTPAYMENTFREQ"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFIDFIS401Z0','8','D','55','66',NULL,'MISCELLANEOUS CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFIDFIS401Z0','1','D','55','74',NULL,'HIGHLY COMPENSATED FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFIDFIS401Z0','1','D','55','75',NULL,'OFFICER / 16 (B) FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFIDFIS401Z0','1','D','55','76',NULL,'DE MINIMUS ELIGIBILITY INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFIDFIS401Z0','1','D','55','77',NULL,'AGE PAYOUT ELIGIBILITY INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFIDFIS401Z0','1','D','55','78',NULL,'PARTICIPANT RESTRICTION CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFIDFIS401Z0','2','D','55','79',NULL,'PARTICIPANT RESTRICTION REASON',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','60','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','60','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','60','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','60','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','6','D','60','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','2','D','60','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"61"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','8','D','60','32',NULL,'ELIGIBILITY DATE',NULL,NULL,'"drvEligDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','8','D','60','40',NULL,'ADJUSTED DATE OF HIRE',NULL,NULL,'"drvADJUSTEDDATEOFHIRE"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','8','D','60','48',NULL,'RETIREMENT DATE',NULL,NULL,'"00000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','5','D','60','56',NULL,' RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','8','D','60','61',NULL,'BIS ACCRUAL START DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','12','D','60','69',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','63','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','63','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','63','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','63','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','1','D','63','24',NULL,'EMPLOYEEID',NULL,NULL,'"drvEmployeeId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','5','D','63','25',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','2','D','63','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"EA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','1','D','63','32',NULL,'E-MAIL ADDRESS STATUS CODE',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','2','D','63','33',NULL,'E-MAIL TYPE CODE',NULL,NULL,'"ER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','2','D','63','35',NULL,'RESERVED',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','1','D','63','37',NULL,'E-MAIL RECORD SEQUENCE NUMBER',NULL,NULL,'"drvEmailRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','35','D','63','38',NULL,'E-MAIL ADDRESS TEXT',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFIDFIS401Z0','1','D','63','73',NULL,'NON SAFE HARBOR INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFIDFIS401Z0','1','D','63','74',NULL,'EDELIVERY CONSENT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFIDFIS401Z0','6','D','63','76',NULL,'EDELIVERY CONSENT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','65','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','65','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','65','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','65','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','1','D','65','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','5','D','65','25',NULL,'RESERVED',NULL,NULL,'"00000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','2','D','65','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"19"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','4','D','65','32',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','3','D','65','36',NULL,'TRANSACTION CODE',NULL,NULL,'"220"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','2','D','65','39',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','2','D','65','41',NULL,'SOURCE',NULL,NULL,'"drvSOURCE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','2','D','65','43',NULL,'ITEM NUMBER',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFIDFIS401Z0','1','D','65','45',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFIDFIS401Z0','13','D','65','46',NULL,'AMOUNT',NULL,NULL,'"drvAMOUNT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFIDFIS401Z0','4','D','65','59',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFIDFIS401Z0','4','D','65','63',NULL,'FISCAL YEAR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFIDFIS401Z0','1','D','65','67',NULL,'ADJUSTMENT REASON',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFIDFIS401Z0','8','D','65','68',NULL,'ORIGINAL PAY DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFIDFIS401Z0','5','D','65','76',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFIDFIS401Z0','5','D','70','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFIDFIS401Z0','4','D','70','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFIDFIS401Z0','3','D','70','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFIDFIS401Z0','11','D','70','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFIDFIS401Z0','1','D','70','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFIDFIS401Z0','5','D','70','25',NULL,'RESERVED',NULL,NULL,'"00000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFIDFIS401Z0','2','D','70','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"21"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFIDFIS401Z0','4','D','70','32',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFIDFIS401Z0','12','D','70','36',NULL,'LOAN IDENTIFICATION',NULL,NULL,'"drvLOANIDENTIFICATION"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFIDFIS401Z0','1','D','70','48',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFIDFIS401Z0','3','D','70','49',NULL,'TRANSACTION CODE',NULL,NULL,'"260"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFIDFIS401Z0','2','D','70','52',NULL,'ITEM NUMBER',NULL,NULL,'"14"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFIDFIS401Z0','2','D','70','54',NULL,'RESERVED',NULL,NULL,'"00"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFIDFIS401Z0','1','D','70','56',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFIDFIS401Z0','7','D','70','57',NULL,'REPAYMENT AMOUNT',NULL,NULL,'"drvREPAYMENTAMOUNT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFIDFIS401Z0','1','D','70','64',NULL,'ADJUSTMENT REASON',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFIDFIS401Z0','8','D','70','65',NULL,'ORIGINAL PAY DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFIDFIS401Z0','1','D','70','73',NULL,'PRINCIPAL ONLY FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFIDFIS401Z0','1','D','70','74',NULL,'NEW REPAYMENT FREQUENCY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EFIDFIS401Z0','6','D','70','75',NULL,'REGION',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFIDFIS401_20211222.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Fidelity 401K Export','202002019','EMPEXPORT','ONDEMAND','Dec 22 2021 12:00AM','EFIDFIS401',NULL,NULL,NULL,'202002019','Feb  1 2020 12:00AM','Dec 30 1899 12:00AM','201705011','387','','','201705011',dbo.fn_GetTimedKey(),NULL,'LKING21',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','Q3TCF',NULL,NULL,NULL,'Living Fidelity401KDem-Thurs6a','202112169','EMPEXPORT','SCH_FID401','Dec 22 2021 12:00AM','EFIDFIS401',NULL,NULL,NULL,'202112169','Dec 16 2021 12:00AM','Dec 30 1899 12:00AM','202112091','455','','','202112091',dbo.fn_GetTimedKey(),NULL,'LKING21',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','5WU8J',NULL,NULL,NULL,'Fidelity 401K Demo Export-TEST','202112221','EMPEXPORT','TEST','Dec 22 2021 12:52PM','EFIDFIS401',NULL,NULL,NULL,'202112221','Dec 22 2021 12:00AM','Dec 30 1899 12:00AM','202112221','20','','','202112221',dbo.fn_GetTimedKey(),NULL,'LKING21',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDFIS401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDFIS401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDFIS401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDFIS401','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDFIS401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDFIS401','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDFIS401','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDFIS401','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------

INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFIDFIS401','ONDEMAND','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFIDFIS401','','D','50','Y','C');

-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D10','dbo.U_EFIDFIS401_drvTbl_01','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D15','dbo.U_EFIDFIS401_drvTbl_02D','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D20','dbo.U_EFIDFIS401_drvTbl_02E','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D25','dbo.U_EFIDFIS401_drvTbl_03','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D30','dbo.U_EFIDFIS401_drvTbl_04','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D35','dbo.U_EFIDFIS401_drvTbl_05','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D40','dbo.U_EFIDFIS401_drvTbl_06','ISNULL(drvPLANNUMBER,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D43','dbo.U_EFIDFIS401_drvTbl_08','ISNULL(drvPLANNUMBER,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D45','dbo.U_EFIDFIS401_drvTbl_11','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D50','dbo.U_EFIDFIS401_drvTbl_36','ISNULL(drvPLANNUMBER,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D55','dbo.U_EFIDFIS401_drvTbl_60','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D60','dbo.U_EFIDFIS401_drvTbl_61','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D63','dbo.U_EFIDFIS401_drvTbl_EA','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D65','dbo.U_EFIDFIS401_drvTbl_19Q','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDFIS401','D70','dbo.U_EFIDFIS401_drvTbl_21','ISNULL(drvPLANNUMBER,'''') <> ''''');

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EFIDFIS401
-----------

IF OBJECT_ID('U_dsi_BDM_EFIDFIS401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFIDFIS401] (
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
-- Create table U_EFIDFIS401_Audit
-----------

IF OBJECT_ID('U_EFIDFIS401_Audit') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_Audit] (
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
-- Create table U_EFIDFIS401_AuditFields
-----------

IF OBJECT_ID('U_EFIDFIS401_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EFIDFIS401_DedList
-----------

IF OBJECT_ID('U_EFIDFIS401_DedList') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_01
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_01') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_01] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvLASTNAME] varchar(100) NULL,
    [drvFIRSTNAMEMIDDLEINITIAL] varchar(102) NULL,
    [drvMARITALSTATUS] varchar(1) NULL,
    [drvGENDER] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_02D
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_02D') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_02D] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvHIREDATE] datetime NULL,
    [drvVestingDAte] varchar(8) NOT NULL,
    [drvDATEOFBIRTH] datetime NULL,
    [drvDateSwitch] varchar(1) NOT NULL,
    [drvTERMINATIONDATE] varchar(8000) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_02E
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_02E') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_02E] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvEMPLOYEENUMBER] char(9) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_03
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_03') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_03] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvADDRESSLINENUMBER] varchar(2) NOT NULL,
    [drvADDRESS] varchar(255) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_04
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_04') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_04] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvCITY] varchar(255) NULL,
    [drvSTATE] varchar(255) NULL,
    [drvZIPCODE] varchar(5) NULL,
    [drvZIP4CODE] varchar(4) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_05
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_05') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_05] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvCOUNTRY] char(3) NULL,
    [drvMAILINGINDICATOR] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_06
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_06') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_06] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvDIVISIONID] varchar(8) NULL,
    [drvRegionId] varchar(8) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_08
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_08') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_08] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvSalary] varchar(30) NULL,
    [drvSalaryInd] varchar(1) NOT NULL,
    [drvSalPayDate] datetime NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_11
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_11') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_11] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvSTATUSCODE] varchar(1) NULL,
    [drvStatusDate] datetime NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_19Q
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_19Q') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_19Q] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvSOURCE] varchar(2) NULL,
    [drvAMOUNT] varchar(13) NULL,
    [drvEEID] char(12) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_21
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_21') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_21] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvLOANIDENTIFICATION] varchar(6) NULL,
    [drvREPAYMENTAMOUNT] varchar(30) NULL,
    [drvEEID] char(12) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_36
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_36') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_36] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvDIVISIONCODE] varchar(8) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_60
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_60') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_60] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvPARTICIPANTCLASS] char(1) NULL,
    [drvPARTICIPANTDISTRICT] varchar(1) NOT NULL,
    [drvPARTICIPANTDEPARTMENT] varchar(1) NOT NULL,
    [drvPARTICIPANTLOCATIONSTORE] varchar(1) NOT NULL,
    [drvPARTICIPANTUNIONCODE] char(12) NULL,
    [drvPARTICIPANTPAYMENTFREQ] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_61
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_61') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_61] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvEligDate] varchar(9) NOT NULL,
    [drvADJUSTEDDATEOFHIRE] datetime NULL,
    [drvRETIREMENTDATE] datetime NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_drvTbl_EA
-----------

IF OBJECT_ID('U_EFIDFIS401_drvTbl_EA') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_drvTbl_EA] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvEmployeeId] varchar(1) NOT NULL,
    [drvEmailRecSeq] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_EEList
-----------

IF OBJECT_ID('U_EFIDFIS401_EEList') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFIDFIS401_Employees
-----------

IF OBJECT_ID('U_EFIDFIS401_Employees') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_Employees] (
    [xEEID] char(12) NULL,
    [xCOID] char(5) NULL,
    [EepSSN] char(11) NULL,
    [EepNameFirst] varchar(100) NULL,
    [EepNameMiddle] varchar(50) NULL,
    [EepNameLast] varchar(100) NULL,
    [EepGender] char(1) NULL,
    [EepDateOfBirth] datetime NULL,
    [EepMaritalStatus] char(1) NULL,
    [EepAddressLine1] varchar(255) NULL,
    [EepAddressLine2] varchar(255) NULL,
    [EepAddressLine3] varchar(255) NULL,
    [EepAddressCity] varchar(255) NULL,
    [EepAddressState] varchar(255) NULL,
    [EepAddressZipCode] varchar(50) NULL,
    [EepAddressCountry] char(3) NULL,
    [EecEmpNo] char(9) NULL,
    [EecEmplStatus] char(1) NULL,
    [EecDateOfOriginalHire] datetime NULL,
    [EecDateOfLastHire] datetime NULL,
    [EecDateOfTermination] datetime NULL,
    [EecDateOfRetirement] datetime NULL,
    [EecLocation] char(6) NULL,
    [EecFullTimeOrPartTime] char(1) NULL,
    [EecPayPeriod] char(1) NULL,
    [EecUnionLocal] char(12) NULL,
    [EecOrgLvl1] char(10) NULL,
    [EecOrgLvl2] char(10) NULL,
    [OrgLvl2Desc] varchar(25) NULL,
    [Record01Change] varchar(1) NULL,
    [Record02DChange] varchar(1) NULL,
    [Record02EChange] varchar(1) NULL,
    [Record03Change] varchar(1) NULL,
    [Record04Change] varchar(1) NULL,
    [Record05Change] varchar(1) NULL,
    [Record06Change] varchar(1) NULL,
    [Record11Change] varchar(1) NULL,
    [Record36Change] varchar(1) NULL,
    [Record60Change] varchar(1) NULL,
    [Record61Change] varchar(1) NULL,
    [audNewHire] varchar(1) NULL,
    [audReHire] varchar(1) NULL,
    [audTerm] varchar(1) NULL,
    [audSalaryChange] varchar(1) NULL,
    [EecDateOfSeniority] datetime NULL,
    [EecAnnSalary] money NULL,
    [EecTermReason] char(6) NULL,
    [EecEmplStatusStartDate] datetime NULL,
    [emailAddress] varchar(1) NULL,
    [eepAddressEMail] varchar(50) NULL,
    [EecLeaveReason] char(6) NULL,
    [eecpaygroup] char(6) NULL,
    [EecUnionNational] char(12) NULL
);

-----------
-- Create table U_EFIDFIS401_File
-----------

IF OBJECT_ID('U_EFIDFIS401_File') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);

-----------
-- Create table U_EFIDFIS401_PDedHist
-----------

IF OBJECT_ID('U_EFIDFIS401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(8) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL,
    [PlanNo] varchar(5) NOT NULL
);

-----------
-- Create table U_EFIDFIS401_PEarHist
-----------

IF OBJECT_ID('U_EFIDFIS401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFIDFIS401_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodStartDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDFIS401]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Glen-Geary Corporation

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 12/22/2021
Service Request Number: TekP-2021-09-16-0003

Purpose: Fidelity 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFIDFIS401';

SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFIDFIS401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFIDFIS401';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = 'EFIDFIS401'; -- Skip RecordSets by ExportCode
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EFIDFIS401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFIDFIS401' ORDER BY RunID DESC;
BEGIN TRAN
UPDATE  dbo.U_dsi_Configuration set cfgValue = null WHERE FormatCode = 'EFIDFIS401' and cfgname = 'ExportPath';
COMMIT
UPDATE U_dsi_Configuration set cfgvalue = null where  FormatCode = 'EFIDFIS401' and cfgname = 'ExportPath'
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDFIS401', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDFIS401', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFIDFIS401', @AllObjects = 'Y', @IsWeb = 'Y'
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

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EFIDFIS401';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFIDFIS401_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_AuditFields;
    CREATE TABLE dbo.U_EFIDFIS401_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpPers','EepEmailAddress');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_EFIDFIS401_AuditFields VALUES ('OrgLevel','OrgDesc');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFIDFIS401_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_Audit;
    SELECT DISTINCT
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
    INTO dbo.U_EFIDFIS401_Audit
    FROM dbo.U_EFIDFIS401_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EFIDFIS401_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate  AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';


    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = '401K4,401KF,401M4,401NM,401U2,40KM4,4LN1F,4LN2F,LOAN1';


    IF OBJECT_ID('U_EFIDFIS401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EFIDFIS401_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DIS,STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','');


    
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
   DELETE FROM dbo.U_EFIDFIS401_Audit WHERE audRowNo > 1;

   Delete from dbo.U_EFIDFIS401_Audit WHERE audFieldName = 'EedDedCode' and audNewValue not in ('401K4','401KF','401M4','401NM','401U2','40KM4','4LN1F','4LN2F','LOAN1') and audOldValue is null

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFIDFIS401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFIDFIS401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -- Changes Only
    DELETE FROM dbo.U_EFIDFIS401_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EFIDFIS401_Audit WHERE audEEID = xEEID);
    

    
    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFIDFIS401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhSource = CASE WHEN PdhDedCode IN ('L401P','401CU') THEN 'EEPRETAX' --401K
                          WHEN PdhDedCode IN ('LROTH') THEN 'ROTH' --ROTH
                          WHEN PdhDedCode IN ('L401M') THEN 'MATCH' --ROTH
                          WHEN PdhDedCode IN ('LOAN1', 'LOAN2','LOAN3') THEN 'LOAN 1' --401K LOAN
                     END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)
        ,PlanNo =  '00088'
    INTO dbo.U_EFIDFIS401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND 
    PdhDedCode IN ('L401P','401CU','LROTH','L401M','LOAN1','LOAN2','LOAN3')
    GROUP BY PdhEEID
        , CASE WHEN PdhDedCode IN ('L401P','401CU') THEN 'EEPRETAX' --401K
                          WHEN PdhDedCode IN ('LROTH') THEN 'ROTH' --ROTH
                          WHEN PdhDedCode IN ('L401M') THEN 'MATCH' --ROTH
                          WHEN PdhDedCode IN ('LOAN1', 'LOAN2','LOAN3') THEN 'LOAN 1' --401K LOAN
                     END
    HAVING (SUM(PdhEECurAmt) <> 0.00 or SUM(PdhERCurAmt) <> 0.00);

    -------------------------------
    -- Working Table - Employees
    -------------------------------
    IF OBJECT_ID('U_EFIDFIS401_Employees','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_Employees;
    SELECT xEEID
        ,xCOID
        ,EepSSN
        ,EepNameFirst
        ,EepNameMiddle
        ,EepNameLast
        ,EepGender
        ,EepDateOfBirth
        ,EepMaritalStatus
        ,EepAddressLine1
        ,EepAddressLine2
        ,EepAddressLine3
        ,EepAddressCity
        ,EepAddressState
        ,EepAddressZipCode
        ,EepAddressCountry
        ,EecEmpNo
        ,EecEmplStatus
        ,EecDateOfOriginalHire
        ,EecDateOfLastHire
        ,EecDateOfTermination
        ,EecDateOfRetirement
        ,EecLocation
        ,EecFullTimeOrPartTime
        ,EecPayPeriod
        ,EecUnionLocal
        ,EecOrgLvl1
        ,EecOrgLvl2
        ,OrgLvl2Desc = O2.OrgDesc
        ,Record01Change
        ,Record02DChange
        ,Record02EChange
        ,Record03Change
        ,Record04Change
        ,Record05Change
        ,Record06Change
        ,Record11Change
        ,Record36Change
        ,Record60Change
        ,Record61Change
        ,audNewHire
        ,audReHire
        ,audTerm
        ,audSalaryChange
        ,EecDateOfSeniority
        ,EecAnnSalary
        ,EecTermReason 
        ,EecEmplStatusStartDate
        ,emailAddress
        ,eepAddressEMail
        ,EecLeaveReason
        ,eecpaygroup
        ,EecUnionNational
    INTO dbo.U_EFIDFIS401_Employees
    FROM dbo.U_EFIDFIS401_EEList
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON O2.OrgCode = EecOrgLvl2
        AND O2.OrgLvl = '2'
    LEFT JOIN (
        -- Get Record Set Changes based on Audit Fields
        SELECT audEEID
            ,Record01Change = MAX(CASE WHEN audFieldName IN ('EepNameFirst','EepNameLast','EepNameMiddle','EepGender','EepMaritalStatus') THEN 'Y' ELSE 'N' END)
            ,Record02DChange = MAX(CASE WHEN audFieldName IN ('EecDateOfOriginalHire','EepDateOfBirth','EecDateOfTermination') THEN 'Y' ELSE 'N' END)
            ,Record02EChange = MAX(CASE WHEN audFieldName IN ('EecEmpNo') THEN 'Y' ELSE 'N' END)
            ,Record03Change = MAX(CASE WHEN audFieldName IN ('EepAddressLine1','EepAddressLine2','EepAddressLine3') THEN 'Y' ELSE 'N' END)
            ,Record04Change = MAX(CASE WHEN audFieldName IN ('EepAddressCity','EepAddressState','EepAddressZipCode') THEN 'Y' ELSE 'N' END)
            ,Record05Change = MAX(CASE WHEN audFieldName IN ('EepAddressCountry') THEN 'Y' ELSE 'N' END)
            ,Record06Change = MAX(CASE WHEN audFieldName IN ('OrgDesc') THEN 'Y' ELSE 'N' END)
            ,Record11Change = MAX(CASE WHEN audFieldName IN ('EecEmplStatus') THEN 'Y' ELSE 'N' END)
            ,Record36Change = MAX(CASE WHEN audFieldName IN ('EecOrglvl2') THEN 'Y' ELSE 'N' END)
            ,Record60Change = MAX(CASE WHEN audFieldName IN ('EecFullTimeOrPartTime','EecOrgLvl1','EecOrgLvl2','EecLocation','EecUnionLocal','EecPayPeriod') THEN 'Y' ELSE 'N' END)
            ,Record61Change = MAX(CASE WHEN audFieldName IN ('EecDateOfLastHire','EecDateOfRetirement') THEN 'Y' ELSE 'N' END)
            ,audNewHire = max( CASE WHEN  (audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A') OR  (audFieldName = 'EedDedCode'  AND ISNULL(audNewValue,'') <> '')  THEN 'Y' ELSE 'N' END)
            ,audReHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,audTerm = MAX(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END)
            ,audSalaryChange = max(CASE  WHEN  audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)
            ,emailAddress = max(CASE  WHEN  audFieldName = 'EepEmailAddress' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)

        FROM dbo.U_EFIDFIS401_Audit
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID;

        IF OBJECT_ID('U_EFIDFIS401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPeriodStartDate             = MAX(PrgPeriodStartDate)
        ,PrgPeriodEndDate             = MAX(PrgPeriodEndDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EFIDFIS401_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_01
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_01;
    SELECT DISTINCT
        drvPLANNUMBER = '29286'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLASTNAME = EepNameLast
        ,drvFIRSTNAMEMIDDLEINITIAL = RTRIM(EepNameFirst) + ' ' + ISNULL(LEFT(EepNameMiddle,1),'')
        ,drvMARITALSTATUS = CASE WHEN ISNULL(eepMaritalStatus,'') in ('','Z') THEN ' ' ELSE eepMaritalStatus END
        ,drvGENDER = CASE WHEN EepGender = 'M' THEN 'M' 
                          WHEN EepGender = 'F' THEN 'F'
                          ELSE ' '
                     END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '01'
    INTO dbo.U_EFIDFIS401_drvTbl_01
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE Record01Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';


    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_02D
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_02D','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_02D;
    SELECT DISTINCT
        drvPLANNUMBER = '29286'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvHIREDATE = EecDateOfOriginalHire
        ,drvVestingDAte = '00000000'
        ,drvDATEOFBIRTH = EepDateOfBirth
        ,drvDateSwitch = CASE WHEN audReHire = 'Y' THEN '5' ELSE '' END
        ,drvTERMINATIONDATE = CASE WHEN EecEmplStatus = 'T' THEN replace(convert(char(10), EecDateOfTermination, 101), '/', '')  ELSE '00000000' END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02D'
    INTO dbo.U_EFIDFIS401_drvTbl_02D
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE Record02DChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y' or audTerm = 'Y' ;

    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_02E
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_02E','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_02E;
    SELECT DISTINCT
        drvPLANNUMBER = '29286'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEMPLOYEENUMBER = EecEmpNo
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02E'
    INTO dbo.U_EFIDFIS401_drvTbl_02E
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE Record02EChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_03
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_03','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_03;
    SELECT DISTINCT
        drvPLANNUMBER = '29286'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvADDRESSLINENUMBER = LineNumber
        ,drvADDRESS = EepAddress
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '03'
    INTO dbo.U_EFIDFIS401_drvTbl_03
    FROM (
        -- Address Line 1
        SELECT xEEID, xCOID, EepSSN, EepAddressLine1 AS EepAddress, '01' AS LineNumber, Record03Change, audNewHire,audReHire,eecpaygroup FROM dbo.U_EFIDFIS401_Employees

        UNION ALL

        -- Address Line 2
        SELECT xEEID, xCOID, EepSSN, EepAddressLine2 AS EepAddress, '02' AS LineNumber, Record03Change, audNewHire,audReHire,eecpaygroup FROM dbo.U_EFIDFIS401_Employees

        UNION ALL

        -- Address Line 3
        SELECT xEEID, xCOID, EepSSN, EepAddressLine3 AS EepAddress, '03' AS LineNumber, Record03Change, audNewHire,audReHire,eecpaygroup  FROM dbo.U_EFIDFIS401_Employees
    ) Employee
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


    Delete from dbo.U_EFIDFIS401_drvTbl_03 where isnull(drvAddress,'') = '';
     

    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_04
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_04','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_04;
    SELECT DISTINCT
        drvPLANNUMBER = '29286'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvCITY = EepAddressCity
        ,drvSTATE = EepAddressState
        ,drvZIPCODE = LEFT(EepAddressZipCode,5)
        ,drvZIP4CODE = SUBSTRING(EepAddressZipCode,6,4)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '04'
    INTO dbo.U_EFIDFIS401_drvTbl_04
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE Record04Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_05
    ---------------------------------
    
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_05','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_05;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvCOUNTRY = EepAddressCountry
        ,drvMAILINGINDICATOR = 'Y'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '05'
    INTO dbo.U_EFIDFIS401_drvTbl_05
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE EepAddressCountry NOT IN ('US','USA')
    AND Record05Change = 'Y';
    
    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_06
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_06','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_06;
    SELECT DISTINCT
        drvPLANNUMBER = '29286'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONID = CASE WHEN eecpaygroup in ('GGS', 'GGSE', 'GGSON','GGSOE') and EecUnionNational = 'NONE' THEN 'SALARIED' ELSE eeclocation END
        ,drvRegionId = CASE WHEN eecpaygroup in ('GGS', 'GGSE', 'GGSON','GGSOE') and EecUnionNational = 'NONE' THEN 'SALARIED' ELSE eeclocation END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '06'
    INTO dbo.U_EFIDFIS401_drvTbl_06
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE Record06Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


  ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_08
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_08','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_08;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSalary =  CONVERT(VARCHAR,dbo.dsi_fnPadZero(EecAnnSalary*100,13,0)) 
        ,drvSalaryInd = 'R'
        ,drvSalPayDate = PrgPayDate
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '08'
    INTO dbo.U_EFIDFIS401_drvTbl_08
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    LEFT JOIN dbo.U_EFIDFIS401_PEarHist WITH (NOLOCK)
    ON PehEEID = xEEID
    WHERE   audNewHire = 'Y' or  audReHire = 'Y';


    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_11
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_11','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_11;
    SELECT DISTINCT
        drvPLANNUMBER = '29286'
        ,drvBATCHGROUPID = '' 
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSTATUSCODE = CASE --WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN 'D'
                              WHEN EecEmplStatus = 'A' AND  (audNewHire = 'N' and audReHire ='N') THEN 'A'
                              WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN 'E'
                              WHEN EecEmplStatus = 'L' THEN 'L'
                              WHEN EecEmplStatus = 'T' THEN 'T'
                              WHEN audNewHire = 'Y' THEN 'N'
                              WHEN audReHire = 'Y' THEN 'E'
                         END
        ,drvStatusDate = CASE --WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN 'D'
                              WHEN EecEmplStatus = 'A' AND  (audNewHire = 'N' or audNewHire ='N') THEN EecDateOfLastHire
                              WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN EecDateOfLastHire
                              WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                              WHEN EecEmplStatus = 'T' and EecTermReason not in ('202') THEN eecdateoftermination
                              WHEN EecEmplStatus = 'T' and EecTermReason IN ('202') THEN eecdateoftermination
                              WHEN audNewHire = 'Y' THEN EecDateOfOriginalHire
                              WHEN audReHire = 'Y' THEN EecDateOfLastHire
                             -- WHEN  EecEmplStatus = 'L' and EecLeaveReason = '300' THEN EecEmplStatusStartDate
                         END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '11'
    INTO dbo.U_EFIDFIS401_drvTbl_11
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE Record11Change = 'Y' or   audReHire = 'Y';

  
    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_36
    ---------------------------------
    
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_36','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_36;
    SELECT DISTINCT
        drvPLANNUMBER = '29286'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONCODE = CASE WHEN eecpaygroup in ('GGS', 'GGSE', 'GGSON','GGSOE') and EecUnionNational = 'NONE' THEN 'SALARIED' ELSE eeclocation END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '36'
    INTO dbo.U_EFIDFIS401_drvTbl_36
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE Record36Change = 'Y';
    
    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_60
    ---------------------------------
    
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_60','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_60;
    SELECT DISTINCT
        drvPLANNUMBER = '29286'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvPARTICIPANTCLASS = EecFullTimeOrPartTime
        ,drvPARTICIPANTDISTRICT = ''--EecOrgLvl1
        ,drvPARTICIPANTDEPARTMENT = ''--EecOrgLvl2
        ,drvPARTICIPANTLOCATIONSTORE = ''--EecLocation
        ,drvPARTICIPANTUNIONCODE = EecUnionNational
        ,drvPARTICIPANTPAYMENTFREQ = 'W'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '60'
    INTO dbo.U_EFIDFIS401_drvTbl_60
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE Record60Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';


    
    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_61
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_61','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_61;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEligDate = '000000000'
        ,drvADJUSTEDDATEOFHIRE = CASE WHEN audReHire = 'Y' THEN EecDateOfLastHire  ELSE NULL END
        ,drvRETIREMENTDATE = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '202' THEN  eecdateoftermination  END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '61'
    INTO dbo.U_EFIDFIS401_drvTbl_61
    FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE audReHire = 'Y';




    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_EA
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_EA','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_EA;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEmployeeId = ''
        ,drvEmailRecSeq = LineNumber
        ,drvEmailAddress = EepAddressEmail
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = 'EA'
    INTO dbo.U_EFIDFIS401_drvTbl_EA
    FROM ( -- Email 1
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 1, 35) AS EepAddressEmail, '1' AS LineNumber, emailAddress, audNewHire,audReHire,eecpaygroup FROM dbo.U_EFIDFIS401_Employees
        UNION ALL
        -- Email 2
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 36, 70)  EepAddressEmail, '2' AS LineNumber, emailAddress, audNewHire,audReHire, eecpaygroup FROM dbo.U_EFIDFIS401_Employees
        UNION ALL
        -- Email 3
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 71, 88)  AS EepAddressEmail, '3' AS LineNumber, emailAddress, audNewHire,audReHire, eecpaygroup  FROM dbo.U_EFIDFIS401_Employees
        )
        Employee
    WHERE emailAddress = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

    Delete from U_EFIDFIS401_drvTbl_EA where drvemailaddress is null or drvemailaddress = '';

    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_19Q
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_19Q','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_19Q;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSOURCE = CASE WHEN PdhSource IN ('EEPRETAX') THEN '01' --401K
                          WHEN PdhSource IN ('ROTH') THEN '02' --ROTH
                          WHEN PdhSource IN ('MATCH') THEN '03' --MATCH

                     END
        ,drvAMOUNT = CASE WHEN PdhSource in ('EEPRETAX') and PdhEECurAmt <> 0.00   then CONVERT(VARCHAR(13),PdhEECurAmt)
                          WHEN PdhSource in ('ROTH') and PdhEECurAmt <> 0.00   then CONVERT(VARCHAR(13),PdhEECurAmt)
                          WHEN PdhSource in ('MATCH') and PdhERCurAmt <> 0.00  then CONVERT(VARCHAR(13),PdhERCurAmt)
                      END 
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '19Q'
    INTO dbo.U_EFIDFIS401_drvTbl_19Q
    FROM dbo.U_EFIDFIS401_PDedHist WITH (NOLOCK)
    LEFT JOIN  (SELECT xEEID,xCOID,eecpaygroup  FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)
    WHERE   audNewHire = 'Y' or  audReHire = 'Y') HIRE_REHIRE
    on HIRE_REHIRE.xEEID = PdhEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    WHERE PdhSource not in  ('LOAN 1','LOAN 2')

    UPDATE U_EFIDFIS401_drvTbl_19Q set drvAmount = CONVERT(VARCHAR,dbo.dsi_fnPadZero( (cast (drvAmount as money)) *100,13,0)) 
        
    Update U_EFIDFIS401_drvTbl_19Q set drvAmount  =   CONCAT(LEFT(REPLACE(drvAmount,'.',''),(LEN( REPLACE(drvAmount,'.','')) -1)),CASE WHEN RIGHT(drvAmount,1) = '1' THEN 'A'
         WHEN RIGHT(drvAmount,1) = '2' THEN 'B'
         WHEN RIGHT(drvAmount,1) = '3' THEN 'C'
         WHEN RIGHT(drvAmount,1) = '4' THEN 'D'
         WHEN RIGHT(drvAmount,1) = '5' THEN 'E'
         WHEN RIGHT(drvAmount,1) = '6' THEN 'F'
         WHEN RIGHT(drvAmount,1) = '7' THEN 'G'
         WHEN RIGHT(drvAmount,1) = '8' THEN 'H'
         WHEN RIGHT(drvAmount,1) = '9' THEN 'I'
         WHEN RIGHT(drvAmount,1) = '0' THEN '{'

    END) 
    
    
     ;

    ---------------------------------
    -- DETAIL RECORD - U_EFIDFIS401_drvTbl_21
    ---------------------------------
    IF OBJECT_ID('U_EFIDFIS401_drvTbl_21','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDFIS401_drvTbl_21;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLOANIDENTIFICATION = CASE WHEN PdhSource in ('LOAN 1') THEN 'LOAN 1' END 
                                   
        ,drvREPAYMENTAMOUNT = CONVERT(VARCHAR,PdhEECurAmt)
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '21'
    INTO dbo.U_EFIDFIS401_drvTbl_21
    FROM dbo.U_EFIDFIS401_PDedHist WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    LEFT JOIN (SELECT xEEID,xCOID,eecpaygroup  FROM dbo.U_EFIDFIS401_Employees WITH (NOLOCK)) as Emp
    on xeeid =  pdheeid
    WHERE PdhSource  in  ('LOAN 1','LOAN 2') ;

     Update dbo.U_EFIDFIS401_drvTbl_21 set drvREPAYMENTAMOUNT  = CONVERT(VARCHAR,dbo.dsi_fnPadZero( (cast (drvREPAYMENTAMOUNT as money)) *100,7,0)) 

        Update dbo.U_EFIDFIS401_drvTbl_21 set drvREPAYMENTAMOUNT  =  CONCAT(LEFT(REPLACE(drvREPAYMENTAMOUNT,'.',''),(LEN( REPLACE(drvREPAYMENTAMOUNT,'.','')) -1)),CASE WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '1' THEN 'A'
         WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '2' THEN 'B'
         WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '3' THEN 'C'
         WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '4' THEN 'D'
         WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '5' THEN 'E'
         WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '6' THEN 'F'
         WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '7' THEN 'G'
         WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '8' THEN 'H'
         WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '9' THEN 'I'
         WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '0' THEN '{'

    END) 
    
    Delete from U_EFIDFIS401_drvTbl_19Q where drvBatchGroupId is null
    Delete from U_EFIDFIS401_drvTbl_21 where drvBatchGroupId is null


    
    Delete from dbo.U_EFIDFIS401_drvTbl_60 where drveeid not in (Select distinct drveeid from dbo.U_EFIDFIS401_drvTbl_01)


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EFIDFIS401','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('EFIDFIS401','Testing') = 'Y' THEN 'TEST_CSP_EFIDFIS401_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'CSP_EFIDFIS401_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = 'EFIDFIS401';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFIDFIS401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDFIS401_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFIDFIS401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201702011'
       ,ExpStartPerControl     = '201702011'
       ,ExpLastEndPerControl   = '201702019'
       ,ExpEndPerControl       = '201702019'
WHERE ExpFormatCode = 'EFIDFIS401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFIDFIS401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDFIS401_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFIDFIS401' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFIDFIS401'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFIDFIS401'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFIDFIS401', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFIDFIS401', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFIDFIS401', 'UseFileName', 'V', 'Y'


-- End ripout