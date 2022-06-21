/**********************************************************************************

EFDSN401PR: Fidelity Payroll Export

FormatCode:     EFDSN401PR
Project:        Fidelity Payroll Export
Client ID:      SUN1006
Date/time:      2022-06-14 10:08:20.550
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP3DB03
Database:       ULTIPRO_WPSUNCO
Web Filename:   SUN1006_ACCC7_EEHISTORY_EFDSN401PR_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EFDSN401PR_SavePath') IS NOT NULL DROP TABLE dbo.U_EFDSN401PR_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EFDSN401PR'


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
WHERE FormatCode = 'EFDSN401PR'
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
WHERE ExpFormatCode = 'EFDSN401PR'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EFDSN401PR')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EFDSN401PR'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EFDSN401PR'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EFDSN401PR'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EFDSN401PR'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EFDSN401PR'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EFDSN401PR'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EFDSN401PR'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EFDSN401PR'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EFDSN401PR'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEFDSN401PR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFDSN401PR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFDSN401PR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFDSN401PR];
GO
IF OBJECT_ID('U_EFDSN401PR_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_PEarHist];
GO
IF OBJECT_ID('U_EFDSN401PR_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_PDedHist];
GO
IF OBJECT_ID('U_EFDSN401PR_File') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_File];
GO
IF OBJECT_ID('U_EFDSN401PR_Employees') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_Employees];
GO
IF OBJECT_ID('U_EFDSN401PR_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_EEList];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_H01') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_H01];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_EA') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_EA];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_61') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_61];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_60') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_60];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_36') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_36];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_21') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_21];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_19Q') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_19Q];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_11') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_11];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_08') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_08];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_06') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_06];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_05') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_05];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_04') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_04];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_03') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_03];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_02E') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_02E];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_02D') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_02D];
GO
IF OBJECT_ID('U_EFDSN401PR_drvTbl_01') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_drvTbl_01];
GO
IF OBJECT_ID('U_EFDSN401PR_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_DedList];
GO
IF OBJECT_ID('U_EFDSN401PR_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_AuditFields];
GO
IF OBJECT_ID('U_EFDSN401PR_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFDSN401PR_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFDSN401PR') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFDSN401PR];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFDSN401PR','Fidelity Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','80','S','N','EFDSN401PRZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','7','H','01','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','73','H','01','8',NULL,'FILLER',NULL,NULL,'"drvTestIdentifier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','10','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','10','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','10','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','10','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','20','D','10','32',NULL,'LAST NAME (FREE FORM)',NULL,NULL,'"drvLASTNAME"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','15','D','10','52',NULL,'FIRST NAME MIDDLE INITIAL (FREE FORM)',NULL,NULL,'"drvFIRSTNAMEMIDDLEINITIAL"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','9','D','10','67',NULL,'RESERVED',NULL,NULL,'"000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','1','D','10','76',NULL,'MARITAL STATUS',NULL,NULL,'"drvMARITALSTATUS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','1','D','10','77',NULL,'GENDER',NULL,NULL,'"drvGENDER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','1','D','10','78',NULL,'SPECIAL TAX TYPE ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDSN401PRZ0','1','D','10','79',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFDSN401PRZ0','1','D','10','80',NULL,'BENE/QDRO PAYEE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','15','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','15','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','15','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','15','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','15','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','15','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"02"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','1','D','15','32',NULL,'FIELD TYPE',NULL,NULL,'"D"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','4','D','15','33',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','8','D','15','37',NULL,'HIRE DATE',NULL,NULL,'"drvHIREDATE"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','8','D','15','45',NULL,'PARTICIPATION DATE',NULL,NULL,'"00000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','8','D','15','53',NULL,'VESTING DATE',NULL,NULL,'"00000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','8','D','15','61',NULL,'DATE-OF-BIRTH',NULL,NULL,'"drvDATEOFBIRTH"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDSN401PRZ0','8','D','15','69',NULL,'TERMINATION DATE',NULL,NULL,'"drvTERMINATIONDATE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFDSN401PRZ0','1','D','15','77',NULL,'DATE SWITCH',NULL,NULL,'"drvDateSwitch"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFDSN401PRZ0','1','D','15','78',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFDSN401PRZ0','1','D','15','79',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFDSN401PRZ0','1','D','15','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','20','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','20','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','20','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','20','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','20','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','20','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"02"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','1','D','20','32',NULL,'FIELD TYPE',NULL,NULL,'"E"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','11','D','20','33',NULL,'EMPLOYEE NUMBER',NULL,NULL,'"drvEMPLOYEENUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','1','D','20','44',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','2','D','20','45',NULL,'EMPLOYEE NUMBER STATUS CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','12','D','20','47',NULL,'CLIENT PROVIDED ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','22','D','20','59',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','25','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','25','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','25','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','25','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','25','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','25','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"03"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','1','D','25','32',NULL,'RECORD TYPE',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','2','D','25','33',NULL,'ADDRESS LINE NUMBER',NULL,NULL,'"drvADDRESSLINENUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','32','D','25','35',NULL,'ADDRESS',NULL,NULL,'"drvADDRESS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','11','D','25','67',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','1','D','25','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','1','D','25','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDSN401PRZ0','1','D','25','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','30','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','30','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','30','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','30','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','30','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','30','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"04"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','1','D','30','32',NULL,'RECORD TYPE',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','20','D','30','33',NULL,'CITY',NULL,NULL,'"drvCITY"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','2','D','30','53',NULL,'STATE',NULL,NULL,'"drvSTATE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','8','D','30','55',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','5','D','30','63',NULL,'ZIP CODE',NULL,NULL,'"drvZIPCODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','4','D','30','68',NULL,'ZIP + 4 CODE',NULL,NULL,'"drvZIP4CODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDSN401PRZ0','6','D','30','72',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFDSN401PRZ0','1','D','30','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFDSN401PRZ0','1','D','30','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFDSN401PRZ0','1','D','30','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','35','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','35','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','35','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','35','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','35','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','35','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"05"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','1','D','35','32',NULL,'RECORD TYPE',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','23','D','35','33',NULL,'COUNTRY',NULL,NULL,'"drvCOUNTRY"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','1','D','35','56',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','1','D','35','57',NULL,'SPECIAL HANDLING',NULL,NULL,'"Y"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','19','D','35','58',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','1','D','35','77',NULL,'MAILING INDICATOR',NULL,NULL,'"drvMAILINGINDICATOR"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDSN401PRZ0','1','D','35','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFDSN401PRZ0','1','D','35','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFDSN401PRZ0','1','D','35','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','40','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','40','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','40','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','40','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','40','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','40','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"06"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','20','D','40','32',NULL,'DIVISION ID (Name)',NULL,NULL,'"drvDIVISIONID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','20','D','40','52',NULL,'REGION ID',NULL,NULL,'"drvRegionId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','3','D','40','72',NULL,'SITE SECURITY CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','4','D','40','75',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','2','D','40','79',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','43','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','7','D','43','6',NULL,'BATCH GROUP ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','11','D','43','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','1','D','43','24',NULL,'BATCH GROUP ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','5','D','43','25',NULL,'BATCH GROUP ID',NULL,NULL,'"00000"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','43','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"08"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','13','D','43','32',NULL,'SALARY',NULL,NULL,'"drvSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','1','D','43','45',NULL,'SALARY INDICATOR',NULL,NULL,'"drvSalaryInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','2','D','43','46',NULL,'SPACES',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','8','D','43','46',NULL,'SALARY PAY DATE',NULL,NULL,'"drvSalPayDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','8','D','43','46',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','45','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','45','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','45','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','45','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','45','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','45','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"11"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','1','D','45','32',NULL,'STATUS CODE',NULL,NULL,'"drvSTATUSCODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','5','D','45','33',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','8','D','45','38',NULL,'STATUS CHANGE DATE',NULL,NULL,'"drvStatusDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','1','D','45','46',NULL,'LITERATURE KIT INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','32','D','45','47',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','1','D','45','79',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDSN401PRZ0','1','D','45','80',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','50','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','50','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','50','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','50','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','50','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','50','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"36"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','4','D','50','32',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','4','D','50','36',NULL,'DIVISION CODE',NULL,NULL,'"drvDIVISIONCODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','40','D','50','40',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','1','D','50','80',NULL,'DIVISION CODE EXISTS INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','55','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','55','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','55','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','55','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','55','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','55','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"60"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','1','D','55','32',NULL,'PARTICIPANT CLASS',NULL,NULL,'"drvPARTICIPANTCLASS"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','8','D','55','33',NULL,'PARTICIPANT DISTRICT',NULL,NULL,'"drvPARTICIPANTDISTRICT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','8','D','55','41',NULL,'PARTICIPANT DEPARTMENT',NULL,NULL,'"drvPARTICIPANTDEPARTMENT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','8','D','55','49',NULL,'PARTICIPANT LOCATION/STORE',NULL,NULL,'"drvPARTICIPANTLOCATIONSTORE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','8','D','55','57',NULL,'PARTICIPANT UNION CODE',NULL,NULL,'"drvPARTICIPANTUNIONCODE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','1','D','55','65',NULL,'PARTICIPANT PAYMENT FREQUENCY',NULL,NULL,'"drvPARTICIPANTPAYMENTFREQ"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDSN401PRZ0','8','D','55','66',NULL,'MISCELLANEOUS CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFDSN401PRZ0','1','D','55','74',NULL,'HIGHLY COMPENSATED FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFDSN401PRZ0','1','D','55','75',NULL,'OFFICER / 16 (B) FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFDSN401PRZ0','1','D','55','76',NULL,'DE MINIMUS ELIGIBILITY INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFDSN401PRZ0','1','D','55','77',NULL,'AGE PAYOUT ELIGIBILITY INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFDSN401PRZ0','1','D','55','78',NULL,'PARTICIPANT RESTRICTION CODE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFDSN401PRZ0','2','D','55','79',NULL,'PARTICIPANT RESTRICTION REASON',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','60','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','60','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','60','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','60','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','6','D','60','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','2','D','60','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"61"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','8','D','60','32',NULL,'ELIGIBILITY DATE',NULL,NULL,'"drvEligDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','8','D','60','40',NULL,'ADJUSTED DATE OF HIRE',NULL,NULL,'"drvADJUSTEDDATEOFHIRE"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','8','D','60','48',NULL,'RETIREMENT DATE',NULL,NULL,'"00000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','5','D','60','56',NULL,' RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','8','D','60','61',NULL,'BIS ACCRUAL START DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','12','D','60','69',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','63','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','63','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','63','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','63','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','1','D','63','24',NULL,'EMPLOYEEID',NULL,NULL,'"drvEmployeeId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','5','D','63','25',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','2','D','63','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"EA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','1','D','63','32',NULL,'E-MAIL ADDRESS STATUS CODE',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','2','D','63','33',NULL,'E-MAIL TYPE CODE',NULL,NULL,'"ER"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','2','D','63','35',NULL,'RESERVED',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','1','D','63','37',NULL,'E-MAIL RECORD SEQUENCE NUMBER',NULL,NULL,'"drvEmailRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','35','D','63','38',NULL,'E-MAIL ADDRESS TEXT',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDSN401PRZ0','1','D','63','73',NULL,'NON SAFE HARBOR INDICATOR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFDSN401PRZ0','1','D','63','74',NULL,'EDELIVERY CONSENT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFDSN401PRZ0','6','D','63','76',NULL,'EDELIVERY CONSENT',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','65','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','65','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','65','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','65','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','1','D','65','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','5','D','65','25',NULL,'RESERVED',NULL,NULL,'"00000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','2','D','65','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"19"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','4','D','65','32',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','3','D','65','36',NULL,'TRANSACTION CODE',NULL,NULL,'"220"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','2','D','65','39',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','2','D','65','41',NULL,'SOURCE',NULL,NULL,'"drvSOURCE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','2','D','65','43',NULL,'ITEM NUMBER',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDSN401PRZ0','1','D','65','45',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFDSN401PRZ0','13','D','65','46',NULL,'AMOUNT',NULL,NULL,'"drvAMOUNT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFDSN401PRZ0','4','D','65','59',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFDSN401PRZ0','4','D','65','63',NULL,'FISCAL YEAR',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFDSN401PRZ0','1','D','65','67',NULL,'ADJUSTMENT REASON',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFDSN401PRZ0','8','D','65','68',NULL,'ORIGINAL PAY DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFDSN401PRZ0','5','D','65','76',NULL,'RESERVED',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EFDSN401PRZ0','5','D','70','1',NULL,'PLAN NUMBER',NULL,NULL,'"drvPLANNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EFDSN401PRZ0','4','D','70','6',NULL,'BATCH GROUP ID',NULL,NULL,'"drvBATCHGROUPID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EFDSN401PRZ0','3','D','70','10',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EFDSN401PRZ0','11','D','70','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL,'"drvSOCIALSECURITYNUMBER"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EFDSN401PRZ0','1','D','70','24',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EFDSN401PRZ0','5','D','70','25',NULL,'RESERVED',NULL,NULL,'"00000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EFDSN401PRZ0','2','D','70','30',NULL,'RECORD IDENTIFIER',NULL,NULL,'"21"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EFDSN401PRZ0','4','D','70','32',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EFDSN401PRZ0','12','D','70','36',NULL,'LOAN IDENTIFICATION',NULL,NULL,'"drvLOANIDENTIFICATION"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EFDSN401PRZ0','1','D','70','48',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EFDSN401PRZ0','3','D','70','49',NULL,'TRANSACTION CODE',NULL,NULL,'"260"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EFDSN401PRZ0','2','D','70','52',NULL,'ITEM NUMBER',NULL,NULL,'"14"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EFDSN401PRZ0','2','D','70','54',NULL,'RESERVED',NULL,NULL,'"00"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EFDSN401PRZ0','1','D','70','56',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EFDSN401PRZ0','7','D','70','57',NULL,'REPAYMENT AMOUNT',NULL,NULL,'"drvREPAYMENTAMOUNT"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EFDSN401PRZ0','1','D','70','64',NULL,'ADJUSTMENT REASON',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EFDSN401PRZ0','8','D','70','65',NULL,'ORIGINAL PAY DATE',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EFDSN401PRZ0','1','D','70','73',NULL,'PRINCIPAL ONLY FLAG',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EFDSN401PRZ0','1','D','70','74',NULL,'NEW REPAYMENT FREQUENCY',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EFDSN401PRZ0','6','D','70','75',NULL,'REGION',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EFDSN401PR_20220614.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Fidely 401K Payroll Export','202205279','EMPEXPORT','ONDEMAND','Feb 10 2022 12:00AM','EFDSN401PR',NULL,NULL,NULL,'202205279','Feb  1 2020 12:00AM','Dec 30 1899 12:00AM','202205271','8027','','NEHRLY,NESAL,GGSENP,GGH,GGHNP,GGM,GGSNP,GGSE,GGS,GGSOE,GGSON,GGSECA,GMSH,GMSS,HOPEH,HOPES,N51,OBH,OBG,NYE,NYD,OBE,OBA,OBF,OBB,MSH,MBADMN,MBPROD,NRTHFH,NRTHFS,OBS,OBS2,RECRT,PBADMN,PBPROD,PBPRNY,PWPROD,OBD,SIERRA,SPRLT,COAST,COASTC,CORP,CPS','202205271',dbo.fn_GetTimedKey(),NULL,'LKING21',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','5WU8J',NULL,NULL,NULL,'Schedule Session','202205279','EMPEXPORT','SCH_SUNPAR','Feb 10 2022 12:00AM','EFDSN401PR',NULL,NULL,NULL,'202205279','Dec 16 2021 12:00AM','Dec 30 1899 12:00AM','202205271','134','',NULL,'202205271',dbo.fn_GetTimedKey(),NULL,'LKING21',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','THVLX,RXRA1,RXR08,RXQUC,RXR2J,RXR4M,TLLUS,RXR86,TKZGH,RXQLI,TMUGQ,OBW2M,RXRBK',NULL,NULL,NULL,'Payroll Test','202205279','EMPEXPORT','TEST','Jun  9 2022  7:20PM','EFDSN401PR',NULL,NULL,NULL,'202205279','May 27 2022 12:00AM','Dec 30 1899 12:00AM','202205271','1993','eecPayGroup','779HRY,779SAL,768SAL,768SNE,772HRY,772SAL,759HRY,759SAL,775SAL,784HRY,784SAL,787HNU,787HRY,787SAL,785SAL,783HRY,783SAL,722SAL,722SNE','202205271',dbo.fn_GetTimedKey(),NULL,'us3lKiSUN1006',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDSN401PR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDSN401PR','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDSN401PR','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDSN401PR','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDSN401PR','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDSN401PR','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDSN401PR','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFDSN401PR','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------

INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFDSN401PR','ONDEMAND','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFDSN401PR','','D','50','Y','C');

-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','H01','dbo.U_EFDSN401PR_drvTbl_H01','ISNULL(drvTestIdentifier,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D10','dbo.U_EFDSN401PR_drvTbl_01','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D15','dbo.U_EFDSN401PR_drvTbl_02D','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D20','dbo.U_EFDSN401PR_drvTbl_02E','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D25','dbo.U_EFDSN401PR_drvTbl_03','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D30','dbo.U_EFDSN401PR_drvTbl_04','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D35','dbo.U_EFDSN401PR_drvTbl_05','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D40','dbo.U_EFDSN401PR_drvTbl_06','ISNULL(drvPLANNUMBER,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D43','dbo.U_EFDSN401PR_drvTbl_08','ISNULL(drvPLANNUMBER,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D45','dbo.U_EFDSN401PR_drvTbl_11','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D50','dbo.U_EFDSN401PR_drvTbl_36','ISNULL(drvPLANNUMBER,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D55','dbo.U_EFDSN401PR_drvTbl_60','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D60','dbo.U_EFDSN401PR_drvTbl_61','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D63','dbo.U_EFDSN401PR_drvTbl_EA','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D65','dbo.U_EFDSN401PR_drvTbl_19Q','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFDSN401PR','D70','dbo.U_EFDSN401PR_drvTbl_21','ISNULL(drvPLANNUMBER,'''') <> ''''');

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EFDSN401PR
-----------

IF OBJECT_ID('U_dsi_BDM_EFDSN401PR') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFDSN401PR] (
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
-- Create table U_EFDSN401PR_Audit
-----------

IF OBJECT_ID('U_EFDSN401PR_Audit') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_Audit] (
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
-- Create table U_EFDSN401PR_AuditFields
-----------

IF OBJECT_ID('U_EFDSN401PR_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EFDSN401PR_DedList
-----------

IF OBJECT_ID('U_EFDSN401PR_DedList') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EFDSN401PR_drvTbl_01
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_01') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_01] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvLASTNAME] varchar(100) NULL,
    [drvFIRSTNAMEMIDDLEINITIAL] varchar(102) NULL,
    [drvMARITALSTATUS] varchar(1) NOT NULL,
    [drvGENDER] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFDSN401PR_drvTbl_02D
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_02D') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_02D] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
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
-- Create table U_EFDSN401PR_drvTbl_02E
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_02E') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_02E] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvEMPLOYEENUMBER] char(9) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);

-----------
-- Create table U_EFDSN401PR_drvTbl_03
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_03') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_03] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
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
-- Create table U_EFDSN401PR_drvTbl_04
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_04') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_04] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
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
-- Create table U_EFDSN401PR_drvTbl_05
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_05') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_05] (
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
-- Create table U_EFDSN401PR_drvTbl_06
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_06') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_06] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
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
-- Create table U_EFDSN401PR_drvTbl_08
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_08') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_08] (
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
-- Create table U_EFDSN401PR_drvTbl_11
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_11') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_11] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
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
-- Create table U_EFDSN401PR_drvTbl_19Q
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_19Q') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_19Q] (
    [drvPLANNUMBER] varchar(5) NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvSOURCE] varchar(2) NULL,
    [drvAMOUNT] varchar(13) NULL,
    [drvEEID] char(12) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);

-----------
-- Create table U_EFDSN401PR_drvTbl_21
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_21') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_21] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvLOANIDENTIFICATION] varchar(5) NULL,
    [drvREPAYMENTAMOUNT] varchar(30) NULL,
    [drvEEID] char(12) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFDSN401PR_drvTbl_36
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_36') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_36] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvDIVISIONCODE] varchar(8) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_EFDSN401PR_drvTbl_60
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_60') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_60] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
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
-- Create table U_EFDSN401PR_drvTbl_61
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_61') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_61] (
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
-- Create table U_EFDSN401PR_drvTbl_EA
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_EA') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_EA] (
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
-- Create table U_EFDSN401PR_drvTbl_H01
-----------

IF OBJECT_ID('U_EFDSN401PR_drvTbl_H01') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_drvTbl_H01] (
    [drvTestIdentifier] varchar(7) NULL
);

-----------
-- Create table U_EFDSN401PR_EEList
-----------

IF OBJECT_ID('U_EFDSN401PR_EEList') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EFDSN401PR_Employees
-----------

IF OBJECT_ID('U_EFDSN401PR_Employees') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_Employees] (
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
-- Create table U_EFDSN401PR_File
-----------

IF OBJECT_ID('U_EFDSN401PR_File') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);

-----------
-- Create table U_EFDSN401PR_PDedHist
-----------

IF OBJECT_ID('U_EFDSN401PR_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(11) NULL,
    [PlanNo] varchar(5) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL
);

-----------
-- Create table U_EFDSN401PR_PEarHist
-----------

IF OBJECT_ID('U_EFDSN401PR_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFDSN401PR_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFDSN401PR]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Suncoke Energy

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 05/21/2022
Service Request Number: TekP-2022-01-19-04

Purpose: Fidely 401K Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFDSN401PR';

SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFDSN401PR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFDSN401PR';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = 'EFDSN401PR'; -- Skip RecordSets by ExportCode
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EFDSN401PR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFDSN401PR' ORDER BY RunID DESC;

BEGIN TRAN
UPDATE  dbo.U_dsi_Configuration set cfgValue = null WHERE FormatCode = 'EFDSN401PR' and cfgname = 'ExportPath';
COMMIT
UPDATE U_dsi_Configuration set cfgvalue = null where  FormatCode = 'EFDSN401PR' and cfgname = 'ExportPath'

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFDSN401PR', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFDSN401PR', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EFDSN401PR', @AllObjects = 'Y', @IsWeb = 'Y'
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
    WHERE FormatCode = 'EFDSN401PR';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFDSN401PR_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_AuditFields;
    CREATE TABLE dbo.U_EFDSN401PR_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpPers','EepEmailAddress');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_EFDSN401PR_AuditFields VALUES ('OrgLevel','OrgDesc');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFDSN401PR_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_Audit;
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
    INTO dbo.U_EFDSN401PR_Audit
    FROM dbo.U_EFDSN401PR_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EFDSN401PR_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate  AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';


    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = '4SUBP,4SUNP,4TRMP,401K,401KU,401T5,401TD,4GTMA,4GTMC,4HAVC,4HAVH,401KR,401RU,40CKR,4CKRU,4KM82,401KM,4GTMT,409AP,40SH,40F,409NF,LOAN,LOAN2,LOAN3,LOAN4,LOAN5,LOAN6,409AP,409NF,40F,40SH';


    IF OBJECT_ID('U_EFDSN401PR_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EFDSN401PR_DedList
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
   DELETE FROM dbo.U_EFDSN401PR_Audit WHERE audRowNo > 1;

   Delete from dbo.U_EFDSN401PR_Audit WHERE audFieldName = 'EedDedCode' and audNewValue not in 
   ('4SUBP','4SUNP','4TRMP','401K','401KU','401T5','401TD','4GTMA',
   '4GTMC','4HAVC','4HAVH','401KR','401RU','40CKR','4CKRU','4KM82','401KM','4GTMT','409AP','40SH','40F','409NF','LOAN',
   'LOAN2','LOAN3','LOAN4','LOAN5','LOAN6','409AP','409NF','40F','40SH') and audOldValue is null

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFDSN401PR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFDSN401PR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -- Changes Only
    DELETE FROM dbo.U_EFDSN401PR_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EFDSN401PR_Audit WHERE audEEID = xEEID);
    
    --DELETE FROM dbo.U_EFDSN401PR_EEList
    --WHERE xEEID IN (SELECT eeceeid from dbo.EmpComp WITH (NOLOCK) where eecpaygroup in ('GGHNP', 'GGSNP', 'GGSENP')) ;
    
    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFDSN401PR_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_PDedHist;
   SELECT DISTINCT
         PdhEEID
         --,pdhdedcode
        ,PdhSource = CASE WHEN PdhDedCode IN ('401K', '401KU', '401T5', '401TD','4GTMA', '4GTMC','4HAVC', '4HAVH') THEN 'EEPRETAX' --401K
                          WHEN PdhDedCode IN ('401KR', '401RU', '40CKR', '4CKRU') THEN 'ROTH' 
                          WHEN PdhDedCode IN ('4KM82', '401KM', '4GTMT') THEN 'MATCH' 
                          WHEN PdhDedCode IN ('4SUBP', '4SUNP', '4TRMP') THEN 'BASIC' 
                          WHEN PdhDedCode in ('409AP') THEN 'BASESALARY'
                          WHEN PdhDedCode in ('409NF') THEN 'ERDisc'+LEFT(@StartPerControl,4)
                          WHEN PdhDedCode in ('40F') THEN 'ERMatch'+LEFT(@StartPerControl,4)
                          WHEN PdhDedCode in ('40SH' ) THEN 'ERSH'+LEFT(@StartPerControl,4)
                          --WHEN PdhDedCode in ('409NF') THEN 'ERDisc2023'
                          --WHEN PdhDedCode in ('40F') THEN 'ERMatch2023'
                          --WHEN PdhDedCode in ('40SH') THEN 'ERSH2023'
                          WHEN PdhDedCode IN ('LOAN', 'LOAN2','LOAN3','LOAN4', 'LOAN5', 'LOAN6') THEN 'LOAN1' 
                     END

        ,PlanNo =  CASE WHEN PdhDedCode in ('401K', '401KU', '401T5', '401TD', '4GTMA', '4GTMC', '4HAVC', '4HAVH',
                                           '401KR', '401RU', '40CKR', '4CKRU','4KM82', '401KM', '4GTMT', '4SUBP', '4SUNP', '4TRMP') THEN '1102M'
                        WHEN PdhDedCode in ('409AP', '409NF', '40F', '40SH' ) THEN '54099'
                   END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)

    INTO dbo.U_EFDSN401PR_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE 
    PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND 
    PdhDedCode IN ('4SUBP','4SUNP','4TRMP','401K','401KU','401T5','401TD','4GTMA','4GTMC','4HAVC','4HAVH',
                   '401KR','401RU','40CKR','4CKRU','4KM82','401KM','4GTMT','409AP','40SH','40F','409NF',
                   'LOAN','LOAN2','LOAN3','LOAN4','LOAN5','LOAN6','409AP','409NF','40F','40SH')
    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('401K', '401KU', '401T5', '401TD','4GTMA', '4GTMC','4HAVC', '4HAVH') THEN 'EEPRETAX' --401K
                          WHEN PdhDedCode IN ('401KR', '401RU', '40CKR', '4CKRU') THEN 'ROTH' 
                          WHEN PdhDedCode IN ('4KM82', '401KM', '4GTMT') THEN 'MATCH' 
                          WHEN PdhDedCode IN ('4SUBP', '4SUNP', '4TRMP') THEN 'BASIC' 
                          WHEN PdhDedCode in ('409AP') THEN 'BASESALARY'
                          WHEN PdhDedCode in ('409NF') THEN 'ERDisc'+LEFT(@StartPerControl,4)
                          WHEN PdhDedCode in ('40F') THEN 'ERMatch'+LEFT(@StartPerControl,4)
                          WHEN PdhDedCode in ('40SH' ) THEN 'ERSH'+LEFT(@StartPerControl,4)
                          --WHEN PdhDedCode in ('409NF') THEN 'ERDisc2023'
                          --WHEN PdhDedCode in ('40F') THEN 'ERMatch2023'
                          --WHEN PdhDedCode in ('40SH') THEN 'ERSH2023'
                          WHEN PdhDedCode IN ('LOAN', 'LOAN2','LOAN3','LOAN4', 'LOAN5', 'LOAN6') THEN 'LOAN1' 
                     END
,CASE WHEN PdhDedCode in ('401K', '401KU', '401T5', '401TD', '4GTMA', '4GTMC', '4HAVC', '4HAVH',
                                           '401KR', '401RU', '40CKR', '4CKRU','4KM82', '401KM', '4GTMT', '4SUBP', '4SUNP', '4TRMP') THEN '1102M'
                        WHEN PdhDedCode in ('409AP', '409NF', '40F', '40SH' ) THEN '54099'
                   END
    HAVING (SUM(PdhEECurAmt) <> 0.00 or SUM(PdhERCurAmt) <> 0.00);

    -------------------------------
    -- Working Table - Employees
    -------------------------------
    IF OBJECT_ID('U_EFDSN401PR_Employees','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_Employees;
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
    INTO dbo.U_EFDSN401PR_Employees
    FROM dbo.U_EFDSN401PR_EEList
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

        FROM dbo.U_EFDSN401PR_Audit
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID;

        IF OBJECT_ID('U_EFDSN401PR_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_PEarHist;
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
    INTO dbo.U_EFDSN401PR_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_01
    ---------------------------------

    
    Delete  from dbo.U_EFDSN401PR_Employees WHERE  xEEID IN (SELECT eeceeid from dbo.EmpComp WITH (NOLOCK) where EecUnionNational in ('786','673', '364', '179')); 
    
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_H01','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_H01;
    SELECT DISTINCT
        drvTestIdentifier = CASE WHEN @ExportCode like 'Test%' THEN  'TESTEDT' END
    INTO dbo.U_EFDSN401PR_drvTbl_H01
 

    IF OBJECT_ID('U_EFDSN401PR_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_01;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLASTNAME = EepNameLast
        ,drvFIRSTNAMEMIDDLEINITIAL = RTRIM(EepNameFirst) + ' ' + ISNULL(LEFT(EepNameMiddle,1),'')
        ,drvMARITALSTATUS = CASE WHEN ISNULL(eepMaritalStatus,'') in ('','Z') THEN ' ' 
                                WHEN eepMaritalStatus = 'M' THEN 'M'
                                ELSE 'S' 
                            END
        ,drvGENDER = CASE WHEN EepGender = 'M' THEN 'M' 
                          WHEN EepGender = 'F' THEN 'F'
                          ELSE ' '
                     END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '01'
    INTO dbo.U_EFDSN401PR_drvTbl_01
    FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    WHERE Record01Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';


    
    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_02E
    ---------------------------------
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_02E','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_02E;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEMPLOYEENUMBER = EecEmpNo
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02E'
    INTO dbo.U_EFDSN401PR_drvTbl_02E
    FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    WHERE Record02EChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_03
    ---------------------------------
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_03','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_03;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvADDRESSLINENUMBER = LineNumber
        ,drvADDRESS = EepAddress
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '03'
    INTO dbo.U_EFDSN401PR_drvTbl_03
    FROM (
        -- Address Line 1
        SELECT xEEID, xCOID, EepSSN, EepAddressLine1 AS EepAddress, '01' AS LineNumber, Record03Change, audNewHire,audReHire,eecpaygroup FROM dbo.U_EFDSN401PR_Employees

        UNION ALL

        -- Address Line 2
        SELECT xEEID, xCOID, EepSSN, EepAddressLine2 AS EepAddress, '02' AS LineNumber, Record03Change, audNewHire,audReHire,eecpaygroup FROM dbo.U_EFDSN401PR_Employees

        UNION ALL

        -- Address Line 3
        SELECT xEEID, xCOID, EepSSN, EepAddressLine3 AS EepAddress, '03' AS LineNumber, Record03Change, audNewHire,audReHire,eecpaygroup  FROM dbo.U_EFDSN401PR_Employees
    ) Employee
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


    Delete from dbo.U_EFDSN401PR_drvTbl_03 where isnull(drvAddress,'') = '';
     

    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_04
    ---------------------------------
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_04','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_04;
    SELECT DISTINCT
        drvPLANNUMBER = ''
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
    INTO dbo.U_EFDSN401PR_drvTbl_04
    FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    WHERE Record04Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_05
    ---------------------------------
    
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_05','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_05;
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
    INTO dbo.U_EFDSN401PR_drvTbl_05
    FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    WHERE EepAddressCountry NOT IN ('US','USA')
    AND Record05Change = 'Y';
    
    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_06
    ---------------------------------
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_06','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_06;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONID = CASE WHEN eecpaygroup in ('GGS', 'GGSE', 'GGSON','GGSOE') and EecUnionNational = 'NONE' THEN 'SALARIED' ELSE eeclocation END
        ,drvRegionId = CASE WHEN eecpaygroup in ('GGS', 'GGSE', 'GGSON','GGSOE') and EecUnionNational = 'NONE' THEN 'SALARIED' ELSE eeclocation END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '06'
    INTO dbo.U_EFDSN401PR_drvTbl_06
    FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    WHERE Record06Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


  ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_08
    ---------------------------------
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_08','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_08;
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
    INTO dbo.U_EFDSN401PR_drvTbl_08
    FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    LEFT JOIN dbo.U_EFDSN401PR_PEarHist WITH (NOLOCK)
    ON PehEEID = xEEID
    WHERE   audNewHire = 'Y' or  audReHire = 'Y';


    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_11
    ---------------------------------
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_11','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_11;
    SELECT DISTINCT
        drvPLANNUMBER = ''
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
    INTO dbo.U_EFDSN401PR_drvTbl_11
    FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    WHERE Record11Change = 'Y' or   audReHire = 'Y';

  
    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_36
    ---------------------------------
    
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_36','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_36;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONCODE = CASE WHEN eecpaygroup in ('GGS', 'GGSE', 'GGSON','GGSOE') and EecUnionNational = 'NONE' THEN 'SALARIED' ELSE eeclocation END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '36'
    INTO dbo.U_EFDSN401PR_drvTbl_36
    FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    WHERE Record36Change = 'Y';
    
    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_60
    ---------------------------------
    
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_60','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_60;
    SELECT DISTINCT
        drvPLANNUMBER = ''
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
    INTO dbo.U_EFDSN401PR_drvTbl_60
    FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    WHERE Record60Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_61
    ---------------------------------
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_61','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_61;
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
    INTO dbo.U_EFDSN401PR_drvTbl_61
    FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    WHERE audReHire = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_EA
    ---------------------------------
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_EA','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_EA;
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
    INTO dbo.U_EFDSN401PR_drvTbl_EA
    FROM ( -- Email 1
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 1, 35) AS EepAddressEmail, '1' AS LineNumber, emailAddress, audNewHire,audReHire,eecpaygroup FROM dbo.U_EFDSN401PR_Employees
        UNION ALL
        -- Email 2
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 36, 70)  EepAddressEmail, '2' AS LineNumber, emailAddress, audNewHire,audReHire, eecpaygroup FROM dbo.U_EFDSN401PR_Employees
        UNION ALL
        -- Email 3
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 71, 88)  AS EepAddressEmail, '3' AS LineNumber, emailAddress, audNewHire,audReHire, eecpaygroup  FROM dbo.U_EFDSN401PR_Employees
        )
        Employee
    WHERE emailAddress = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

    Delete from U_EFDSN401PR_drvTbl_EA where drvemailaddress is null or drvemailaddress = '';

    ---------------------------------
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_19Q
    ---------------------------------
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_19Q','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_19Q;
    SELECT DISTINCT
        drvPLANNUMBER = PlanNo
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSOURCE = CASE WHEN PdhSource IN ('EEPRETAX') THEN '01' --401K
                          WHEN PdhSource IN ('ROTH') THEN '02' --ROTH
                          WHEN PdhSource IN ('MATCH') THEN '04' --MATCH
                          WHEN PdhSource IN ('BASIC') THEN '05' --BASIC
                          WHEN PdhSource in ('BASESALARY') THEN '01'
                          WHEN PdhSource in ('ERDisc2022') THEN '03'
                          WHEN PdhSource in ('ERMatch2022') THEN '04'
                          WHEN PdhSource in ('ERSH2022') THEN '05'
                          WHEN PdhSource in ('ERDisc2023') THEN '06'
                          WHEN PdhSource in ('ERMatch2023') THEN '07'
                          WHEN PdhSource in ('ERSH2023') THEN '08'
                     END
        ,drvAMOUNT = CASE WHEN PdhSource in ('EEPRETAX') and PdhEECurAmt <> 0.00   then CONVERT(VARCHAR(13),PdhEECurAmt)
                          WHEN PdhSource in ('ROTH') and PdhEECurAmt <> 0.00   then CONVERT(VARCHAR(13),PdhEECurAmt)
                          WHEN PdhSource in ('MATCH') and PdhERCurAmt <> 0.00  then CONVERT(VARCHAR(13),PdhERCurAmt)
                          WHEN PdhSource in ('BASIC') and PdhERCurAmt <> 0.00  then CONVERT(VARCHAR(13),PdhERCurAmt)
                          WHEN PdhSource in ('BASESALARY') and PdhEECurAmt <> 0.00   then CONVERT(VARCHAR(13),PdhEECurAmt)
                          WHEN PdhSource in ('ERDisc2022') and PdhERCurAmt <> 0.00  then CONVERT(VARCHAR(13),PdhERCurAmt)
                          WHEN PdhSource in ('ERMatch2022') and PdhEECurAmt <> 0.00  then CONVERT(VARCHAR(13),PdhEECurAmt)
                          WHEN PdhSource in ('ERSH2022') and PdhEECurAmt <> 0.00  then CONVERT(VARCHAR(13),PdhEECurAmt)
                          WHEN PdhSource in ('ERDisc2023') and PdhERCurAmt <> 0.00  then CONVERT(VARCHAR(13),PdhERCurAmt)
                          WHEN PdhSource in ('ERMatch2023') and PdhEECurAmt <> 0.00  then CONVERT(VARCHAR(13),PdhEECurAmt)
                          WHEN PdhSource in ('ERSH2023') and PdhEECurAmt <> 0.00  then CONVERT(VARCHAR(13),PdhEECurAmt)
                      END 
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '19Q'
    INTO dbo.U_EFDSN401PR_drvTbl_19Q
    FROM dbo.U_EFDSN401PR_PDedHist WITH (NOLOCK)
    LEFT JOIN  (SELECT xEEID,xCOID,eecpaygroup  FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)
    WHERE   audNewHire = 'Y' or  audReHire = 'Y') HIRE_REHIRE
    on HIRE_REHIRE.xEEID = PdhEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    WHERE PdhSource not in ('LOAN1')

    UPDATE U_EFDSN401PR_drvTbl_19Q set drvAmount = CONVERT(VARCHAR,dbo.dsi_fnPadZero( (cast (drvAmount as money)) *100,13,0))     
    Update U_EFDSN401PR_drvTbl_19Q set drvAmount  = CONCAT(LEFT(REPLACE(drvAmount,'.',''),(LEN( REPLACE(drvAmount,'.','')) -1)),
    CASE WHEN RIGHT(drvAmount,1) = '1' THEN 'A'
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
    -- DETAIL RECORD - U_EFDSN401PR_drvTbl_21
    ---------------------------------
    IF OBJECT_ID('U_EFDSN401PR_drvTbl_21','U') IS NOT NULL
        DROP TABLE dbo.U_EFDSN401PR_drvTbl_21;
    SELECT DISTINCT
        drvPLANNUMBER = '1102M'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLOANIDENTIFICATION = CASE WHEN PdhSource in ('LOAN1') THEN 'LOAN1' END 
                                   
        ,drvREPAYMENTAMOUNT = CONVERT(VARCHAR,PdhEECurAmt)
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '21'
    INTO dbo.U_EFDSN401PR_drvTbl_21
    FROM dbo.U_EFDSN401PR_PDedHist WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    LEFT JOIN (SELECT xEEID,xCOID,eecpaygroup  FROM dbo.U_EFDSN401PR_Employees WITH (NOLOCK)) as Emp
    on xeeid =  pdheeid
    WHERE PdhSource in ('LOAN1') ;

     Update dbo.U_EFDSN401PR_drvTbl_21 set drvREPAYMENTAMOUNT  = CONVERT(VARCHAR,dbo.dsi_fnPadZero( (cast (drvREPAYMENTAMOUNT as money)) *100,7,0)) 

        Update dbo.U_EFDSN401PR_drvTbl_21 set drvREPAYMENTAMOUNT  =  CONCAT(LEFT(REPLACE(drvREPAYMENTAMOUNT,'.',''),(LEN( REPLACE(drvREPAYMENTAMOUNT,'.','')) -1)),CASE WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '1' THEN 'A'
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
    
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EFDSN401PR','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('EFDSN401PR','Testing') = 'Y' THEN 'TEST_CSP_EFDSN401PR_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'CSP_EFDSN401PR_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = 'EFDSN401PR';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFDSN401PR_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFDSN401PR_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFDSN401PR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202205271'
       ,ExpStartPerControl     = '202205271'
       ,ExpLastEndPerControl   = '202205279'
       ,ExpEndPerControl       = '202205279'
WHERE ExpFormatCode = 'EFDSN401PR';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFDSN401PR_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFDSN401PR_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EFDSN401PR' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EFDSN401PR'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EFDSN401PR'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFDSN401PR', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EFDSN401PR', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EFDSN401PR', 'UseFileName', 'V', 'Y'


-- End ripout