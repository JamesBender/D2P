SET NOCOUNT ON;
IF OBJECT_ID('U_EFIDEL403B_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFIDEL403B_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFIDEL403B' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFIDEL403B_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFIDEL403B_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFIDEL403B_G10_BKP_2020_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDEL403B_G10_BKP_2020_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFIDEL403B') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDEL403B];
GO
IF OBJECT_ID('U_EFIDEL403B_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_PEarHist];
GO
IF OBJECT_ID('U_EFIDEL403B_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_PDedHist];
GO
IF OBJECT_ID('U_EFIDEL403B_File') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_File];
GO
IF OBJECT_ID('U_EFIDEL403B_Employees') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_Employees];
GO
IF OBJECT_ID('U_EFIDEL403B_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_EEList];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_EA') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_EA];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_61') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_61];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_60') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_60];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_36') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_36];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_21') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_21];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_19Q') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_19Q];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_11') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_11];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_08') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_08];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_06') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_06];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_05') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_05];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_04') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_04];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_03') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_03];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_02E') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_02E];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_02D') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_02D];
GO
IF OBJECT_ID('U_EFIDEL403B_drvTbl_01') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_drvTbl_01];
GO
IF OBJECT_ID('U_EFIDEL403B_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_DedList];
GO
IF OBJECT_ID('U_EFIDEL403B_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_AuditFields];
GO
IF OBJECT_ID('U_EFIDEL403B_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFIDEL403B') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFIDEL403B];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFIDEL403B';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'EFIDEL403B';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFIDEL403B';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFIDEL403B';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFIDEL403B';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFIDEL403B';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFIDEL403B','Fidelity 403B Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','80','S','N','EFIDEL403BZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFIDEL403B' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','1','(''DA''=''F'')','EFIDEL403BZ0','7','H','01','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''F'')','EFIDEL403BZ0','73','H','01','8',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','10','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','10','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','10','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','10','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLASTNAME"','7','(''UA''=''F'')','EFIDEL403BZ0','20','D','10','32',NULL,'LAST NAME (FREE FORM)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFIRSTNAMEMIDDLEINITIAL"','8','(''UA''=''F'')','EFIDEL403BZ0','15','D','10','52',NULL,'FIRST NAME MIDDLE INITIAL (FREE FORM)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000000"','9','(''DA''=''F'')','EFIDEL403BZ0','9','D','10','67',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMARITALSTATUS"','10','(''UA''=''F'')','EFIDEL403BZ0','1','D','10','76',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGENDER"','11','(''UA''=''F'')','EFIDEL403BZ0','1','D','10','77',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EFIDEL403BZ0','1','D','10','78',NULL,'SPECIAL TAX TYPE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDEL403BZ0','1','D','10','79',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDEL403BZ0','1','D','10','80',NULL,'BENE/QDRO PAYEE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','15','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','15','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','15','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','15','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','15','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"02"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','15','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D"','7','(''DA''=''F'')','EFIDEL403BZ0','1','D','15','32',NULL,'FIELD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDEL403BZ0','4','D','15','33',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHIREDATE"','9','(''UDMDY''=''F'')','EFIDEL403BZ0','8','D','15','37',NULL,'HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000000"','10','(''DA''=''F'')','EFIDEL403BZ0','8','D','15','45',NULL,'PARTICIPATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVestingDAte"','11','(''UDMDY''=''F'')','EFIDEL403BZ0','8','D','15','53',NULL,'VESTING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDATEOFBIRTH"','12','(''UDMDY''=''F'')','EFIDEL403BZ0','8','D','15','61',NULL,'DATE-OF-BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTERMINATIONDATE"','13','(''UDMDY''=''F'')','EFIDEL403BZ0','8','D','15','69',NULL,'TERMINATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateSwitch"','14','(''UDMDY''=''F'')','EFIDEL403BZ0','1','D','15','77',NULL,'DATE SWITCH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDEL403BZ0','1','D','15','78',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EFIDEL403BZ0','1','D','15','79',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','EFIDEL403BZ0','1','D','15','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','20','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','20','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','20','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','20','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','20','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"02"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','20','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E"','7','(''DA''=''F'')','EFIDEL403BZ0','1','D','20','32',NULL,'FIELD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEENUMBER"','8','(''UA''=''F'')','EFIDEL403BZ0','11','D','20','33',NULL,'EMPLOYEE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EFIDEL403BZ0','1','D','20','44',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDEL403BZ0','2','D','20','45',NULL,'EMPLOYEE NUMBER STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDEL403BZ0','12','D','20','47',NULL,'CLIENT PROVIDED ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EFIDEL403BZ0','22','D','20','59',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','25','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','25','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','25','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','25','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','25','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"03"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','25','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P"','7','(''DA''=''F'')','EFIDEL403BZ0','1','D','25','32',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDRESSLINENUMBER"','8','(''UA''=''F'')','EFIDEL403BZ0','2','D','25','33',NULL,'ADDRESS LINE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDRESS"','9','(''UA''=''F'')','EFIDEL403BZ0','32','D','25','35',NULL,'ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDEL403BZ0','11','D','25','67',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDEL403BZ0','1','D','25','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EFIDEL403BZ0','1','D','25','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDEL403BZ0','1','D','25','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','30','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','30','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','30','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','30','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','30','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"04"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','30','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P"','7','(''DA''=''F'')','EFIDEL403BZ0','1','D','30','32',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCITY"','8','(''UA''=''F'')','EFIDEL403BZ0','20','D','30','33',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTATE"','9','(''UA''=''F'')','EFIDEL403BZ0','2','D','30','53',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDEL403BZ0','8','D','30','55',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIPCODE"','11','(''UA''=''F'')','EFIDEL403BZ0','5','D','30','63',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIP4CODE"','12','(''UA''=''F'')','EFIDEL403BZ0','4','D','30','68',NULL,'ZIP + 4 CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDEL403BZ0','6','D','30','72',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDEL403BZ0','1','D','30','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDEL403BZ0','1','D','30','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EFIDEL403BZ0','1','D','30','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','35','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','35','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','35','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','35','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','35','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"05"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','35','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P"','7','(''DA''=''F'')','EFIDEL403BZ0','1','D','35','32',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOUNTRY"','8','(''UA''=''F'')','EFIDEL403BZ0','23','D','35','33',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EFIDEL403BZ0','1','D','35','56',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','10','(''DA''=''F'')','EFIDEL403BZ0','1','D','35','57',NULL,'SPECIAL HANDLING',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDEL403BZ0','19','D','35','58',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMAILINGINDICATOR"','12','(''UA''=''F'')','EFIDEL403BZ0','1','D','35','77',NULL,'MAILING INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDEL403BZ0','1','D','35','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDEL403BZ0','1','D','35','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDEL403BZ0','1','D','35','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','40','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','40','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','40','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','40','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','40','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"06"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','40','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDIVISIONID"','7','(''UA''=''F'')','EFIDEL403BZ0','20','D','40','32',NULL,'DIVISION ID (Name)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDEL403BZ0','20','D','40','52',NULL,'REGION ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EFIDEL403BZ0','3','D','40','72',NULL,'SITE SECURITY CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDEL403BZ0','4','D','40','75',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDEL403BZ0','2','D','40','79',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','43','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''F'')','EFIDEL403BZ0','7','D','43','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','3','(''UA''=''F'')','EFIDEL403BZ0','11','D','43','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EFIDEL403BZ0','1','D','43','24',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','5','(''SS''=''F'')','EFIDEL403BZ0','5','D','43','25',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"08"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','43','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','7','(''UA''=''F'')','EFIDEL403BZ0','13','D','43','32',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryInd"','8','(''UA''=''F'')','EFIDEL403BZ0','1','D','43','45',NULL,'SALARY INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EFIDEL403BZ0','2','D','43','46',NULL,'SPACES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalPayDate"','10','(''UDMDY''=''F'')','EFIDEL403BZ0','8','D','43','46',NULL,'SALARY PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDEL403BZ0','8','D','43','46',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','45','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','45','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','45','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','45','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','45','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"11"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','45','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTATUSCODE"','7','(''UA''=''F'')','EFIDEL403BZ0','1','D','45','32',NULL,'STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDEL403BZ0','5','D','45','33',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusDate"','9','(''UDMDY''=''F'')','EFIDEL403BZ0','8','D','45','38',NULL,'STATUS CHANGE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDEL403BZ0','1','D','45','46',NULL,'LITERATURE KIT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDEL403BZ0','32','D','45','47',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EFIDEL403BZ0','1','D','45','79',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDEL403BZ0','1','D','45','80',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','50','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','50','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','50','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','50','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','50','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"36"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','50','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','EFIDEL403BZ0','4','D','50','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDIVISIONCODE"','8','(''UA''=''F'')','EFIDEL403BZ0','4','D','50','36',NULL,'DIVISION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EFIDEL403BZ0','40','D','50','40',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDEL403BZ0','1','D','50','80',NULL,'DIVISION CODE EXISTS INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','55','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','55','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','55','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','55','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','55','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"60"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','55','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTCLASS"','7','(''UA''=''F'')','EFIDEL403BZ0','1','D','55','32',NULL,'PARTICIPANT CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTDISTRICT"','8','(''UA''=''F'')','EFIDEL403BZ0','8','D','55','33',NULL,'PARTICIPANT DISTRICT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTDEPARTMENT"','9','(''UA''=''F'')','EFIDEL403BZ0','8','D','55','41',NULL,'PARTICIPANT DEPARTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTLOCATIONSTORE"','10','(''UA''=''F'')','EFIDEL403BZ0','8','D','55','49',NULL,'PARTICIPANT LOCATION/STORE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTUNIONCODE"','11','(''UA''=''F'')','EFIDEL403BZ0','8','D','55','57',NULL,'PARTICIPANT UNION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTPAYMENTFREQ"','12','(''UA''=''F'')','EFIDEL403BZ0','1','D','55','65',NULL,'PARTICIPANT PAYMENT FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDEL403BZ0','8','D','55','66',NULL,'MISCELLANEOUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDEL403BZ0','1','D','55','74',NULL,'HIGHLY COMPENSATED FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDEL403BZ0','1','D','55','75',NULL,'OFFICER / 16 (B) FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EFIDEL403BZ0','1','D','55','76',NULL,'DE MINIMUS ELIGIBILITY INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','EFIDEL403BZ0','1','D','55','77',NULL,'AGE PAYOUT ELIGIBILITY INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','EFIDEL403BZ0','1','D','55','78',NULL,'PARTICIPANT RESTRICTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','EFIDEL403BZ0','2','D','55','79',NULL,'PARTICIPANT RESTRICTION REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','60','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','60','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','60','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','60','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','6','D','60','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"61"','6','(''DA''=''F'')','EFIDEL403BZ0','2','D','60','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligDate"','7','(''UDMDY''=''F'')','EFIDEL403BZ0','8','D','60','32',NULL,'ELIGIBILITY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADJUSTEDDATEOFHIRE"','8','(''UDMDY''=''F'')','EFIDEL403BZ0','8','D','60','40',NULL,'ADJUSTED DATE OF HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRETIREMENTDATE"','9','(''UDMDY''=''F'')','EFIDEL403BZ0','8','D','60','48',NULL,'RETIREMENT DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDEL403BZ0','5','D','60','56',NULL,' RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDEL403BZ0','8','D','60','61',NULL,'BIS ACCRUAL START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EFIDEL403BZ0','12','D','60','69',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','63','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','63','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','63','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','63','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','5','(''UA''=''F'')','EFIDEL403BZ0','1','D','63','24',NULL,'EMPLOYEEID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','EFIDEL403BZ0','5','D','63','25',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EA"','7','(''DA''=''F'')','EFIDEL403BZ0','2','D','63','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','8','(''DA''=''F'')','EFIDEL403BZ0','1','D','63','32',NULL,'E-MAIL ADDRESS STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ER"','9','(''DA''=''F'')','EFIDEL403BZ0','2','D','63','33',NULL,'E-MAIL TYPE CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFIDEL403BZ0','2','D','63','35',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailRecSeq"','11','(''UA''=''F'')','EFIDEL403BZ0','1','D','63','37',NULL,'E-MAIL RECORD SEQUENCE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','12','(''UA''=''F'')','EFIDEL403BZ0','35','D','63','38',NULL,'E-MAIL ADDRESS TEXT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDEL403BZ0','1','D','63','73',NULL,'NON SAFE HARBOR INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDEL403BZ0','1','D','63','74',NULL,'EDELIVERY CONSENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDEL403BZ0','6','D','63','76',NULL,'EDELIVERY CONSENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','65','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','65','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','65','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','65','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','1','D','65','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','6','(''DA''=''F'')','EFIDEL403BZ0','5','D','65','25',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"19"','7','(''DA''=''F'')','EFIDEL403BZ0','2','D','65','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDEL403BZ0','4','D','65','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"220"','9','(''DA''=''F'')','EFIDEL403BZ0','3','D','65','36',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDEL403BZ0','2','D','65','39',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOURCE"','11','(''UA''=''F'')','EFIDEL403BZ0','2','D','65','41',NULL,'SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','12','(''DA''=''F'')','EFIDEL403BZ0','2','D','65','43',NULL,'ITEM NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDEL403BZ0','1','D','65','45',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMOUNT"','14','(''UNPN''=''F'')','EFIDEL403BZ0','13','D','65','46',NULL,'AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDEL403BZ0','4','D','65','59',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EFIDEL403BZ0','4','D','65','63',NULL,'FISCAL YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','EFIDEL403BZ0','1','D','65','67',NULL,'ADJUSTMENT REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','EFIDEL403BZ0','8','D','65','68',NULL,'ORIGINAL PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','EFIDEL403BZ0','5','D','65','76',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDEL403BZ0','5','D','70','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDEL403BZ0','4','D','70','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDEL403BZ0','3','D','70','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDEL403BZ0','11','D','70','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDEL403BZ0','1','D','70','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','6','(''DA''=''F'')','EFIDEL403BZ0','5','D','70','25',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"21"','7','(''DA''=''F'')','EFIDEL403BZ0','2','D','70','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDEL403BZ0','4','D','70','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOANIDENTIFICATION"','9','(''UA''=''F'')','EFIDEL403BZ0','12','D','70','36',NULL,'LOAN IDENTIFICATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDEL403BZ0','1','D','70','48',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"260"','11','(''DA''=''F'')','EFIDEL403BZ0','3','D','70','49',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"14"','12','(''DA''=''F'')','EFIDEL403BZ0','2','D','70','52',NULL,'ITEM NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','13','(''DA''=''F'')','EFIDEL403BZ0','2','D','70','54',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDEL403BZ0','1','D','70','56',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREPAYMENTAMOUNT"','15','(''UNPN''=''F'')','EFIDEL403BZ0','7','D','70','57',NULL,'REPAYMENT AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EFIDEL403BZ0','1','D','70','64',NULL,'ADJUSTMENT REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','EFIDEL403BZ0','8','D','70','65',NULL,'ORIGINAL PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','EFIDEL403BZ0','1','D','70','73',NULL,'PRINCIPAL ONLY FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','EFIDEL403BZ0','1','D','70','74',NULL,'NEW REPAYMENT FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''F'')','EFIDEL403BZ0','6','D','70','75',NULL,'REGION',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EFIDEL403B_20210503.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Fidelity 403B Export','201702019','EMPEXPORT','ONDEMAND','Feb  1 2017 12:00AM','EFIDEL403B',NULL,NULL,NULL,'201702019','Feb  1 2017 12:00AM','Dec 30 1899 12:00AM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Fidelity 403B Export','202003241','EMPEXPORT','SCH_FID403','Mar 24 2020  5:26PM','EFIDEL403B',NULL,NULL,NULL,'202003241','Mar 24 2020 12:00AM','Dec 30 1899 12:00AM','201701011','8210','','','201701011',dbo.fn_GetTimedKey(),NULL,'us3mLaOXF1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','Z86NN,Z88CM,IAGFG',NULL,NULL,NULL,'Fidelity 403B Export','202011279','EMPEXPORT','TEST','Feb 25 2021  4:52PM','EFIDEL403B',NULL,NULL,NULL,'202011279','Nov 27 2020 12:00AM','Dec 30 1899 12:00AM','202011271','1757','','','202011271',dbo.fn_GetTimedKey(),NULL,'us3mLaOXF1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDEL403B','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDEL403B','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDEL403B','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDEL403B','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDEL403B','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDEL403B','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDEL403B','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EFIDEL403B' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EFIDEL403B' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EFIDEL403B_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDEL403B_SavePath];
GO
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFIDEL403B','ONDEMAND','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D10','dbo.U_EFIDEL403B_drvTbl_01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D15','dbo.U_EFIDEL403B_drvTbl_02D',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D20','dbo.U_EFIDEL403B_drvTbl_02E',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D25','dbo.U_EFIDEL403B_drvTbl_03',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D30','dbo.U_EFIDEL403B_drvTbl_04',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D35','dbo.U_EFIDEL403B_drvTbl_05',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D40','dbo.U_EFIDEL403B_drvTbl_06',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D43','dbo.U_EFIDEL403B_drvTbl_08',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D45','dbo.U_EFIDEL403B_drvTbl_11',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D50','dbo.U_EFIDEL403B_drvTbl_36',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D55','dbo.U_EFIDEL403B_drvTbl_60',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D60','dbo.U_EFIDEL403B_drvTbl_61',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D63','dbo.U_EFIDEL403B_drvTbl_EA',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D65','dbo.U_EFIDEL403B_drvTbl_19Q',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDEL403B','D70','dbo.U_EFIDEL403B_drvTbl_21',NULL);
IF OBJECT_ID('U_dsi_BDM_EFIDEL403B') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFIDEL403B] (
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
IF OBJECT_ID('U_EFIDEL403B_Audit') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EFIDEL403B_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EFIDEL403B_DedList') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_01') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_01] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvLASTNAME] varchar(100) NULL,
    [drvFIRSTNAMEMIDDLEINITIAL] varchar(101) NULL,
    [drvMARITALSTATUS] varchar(1) NULL,
    [drvGENDER] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_02D') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_02D] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvHIREDATE] datetime NULL,
    [drvVestingDAte] datetime NULL,
    [drvDATEOFBIRTH] datetime NULL,
    [drvDateSwitch] varchar(1) NOT NULL,
    [drvTERMINATIONDATE] datetime NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_02E') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_02E] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvEMPLOYEENUMBER] char(9) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_03') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_03] (
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
IF OBJECT_ID('U_EFIDEL403B_drvTbl_04') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_04] (
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
IF OBJECT_ID('U_EFIDEL403B_drvTbl_05') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_05] (
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
IF OBJECT_ID('U_EFIDEL403B_drvTbl_06') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_06] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvDIVISIONID] varchar(21) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_08') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_08] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvSalary] varchar(30) NULL,
    [drvSalaryInd] varchar(1) NOT NULL,
    [drvSalPayDate] datetime NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_11') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_11] (
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
IF OBJECT_ID('U_EFIDEL403B_drvTbl_19Q') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_19Q] (
    [drvPLANNUMBER] varchar(5) NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvSOURCE] varchar(2) NULL,
    [drvAMOUNT] money NULL,
    [drvEEID] char(12) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_21') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_21] (
    [drvPLANNUMBER] varchar(5) NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvLOANIDENTIFICATION] varchar(1) NULL,
    [drvREPAYMENTAMOUNT] money NULL,
    [drvEEID] char(12) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_36') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_36] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvDIVISIONCODE] char(6) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_60') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_60] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvPARTICIPANTCLASS] char(1) NULL,
    [drvPARTICIPANTDISTRICT] varchar(1) NOT NULL,
    [drvPARTICIPANTDEPARTMENT] varchar(1) NOT NULL,
    [drvPARTICIPANTLOCATIONSTORE] varchar(1) NOT NULL,
    [drvPARTICIPANTUNIONCODE] varchar(1) NOT NULL,
    [drvPARTICIPANTPAYMENTFREQ] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_61') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_61] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvEligDate] varchar(1) NOT NULL,
    [drvADJUSTEDDATEOFHIRE] datetime NULL,
    [drvRETIREMENTDATE] datetime NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDEL403B_drvTbl_EA') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_drvTbl_EA] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
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
IF OBJECT_ID('U_EFIDEL403B_EEList') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFIDEL403B_Employees') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_Employees] (
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
    [EecOrgLvl1] varchar(10) NULL,
    [EecOrgLvl2] varchar(10) NULL,
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
    [eepAddressEMail] varchar(50) NULL
);
IF OBJECT_ID('U_EFIDEL403B_File') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);
IF OBJECT_ID('U_EFIDEL403B_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(9) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL,
    [PlanNo] varchar(5) NULL
);
IF OBJECT_ID('U_EFIDEL403B_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFIDEL403B_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDEL403B]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Oxfor University Press

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 03/20/2020
Service Request Number: TekP-2020-02-17-0003

Purpose: Fidelity 403B Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFIDEL403B';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFIDEL403B';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFIDEL403B';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = 'EFIDEL403B'; -- Skip RecordSets by ExportCode
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EFIDEL403B';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFIDEL403B' ORDER BY RunID DESC;


UPDATE U_dsi_Configuration set cfgvalue = null where  FormatCode = 'EFIDEL403B' and cfgname = 'ExportPath'
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDEL403B', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDEL403B', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFIDEL403B', @AllObjects = 'Y', @IsWeb = 'Y'
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
    WHERE FormatCode = 'EFIDEL403B';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFIDEL403B_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_AuditFields;
    CREATE TABLE dbo.U_EFIDEL403B_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepEmailAddress');

    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('OrgLevel','OrgDesc');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFIDEL403B_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_Audit;
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
    INTO dbo.U_EFIDEL403B_Audit
    FROM dbo.U_EFIDEL403B_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EFIDEL403B_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate - 21  AND @EndDate + 3
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EFIDEL403B_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFIDEL403B_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFIDEL403B_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EFIDEL403B_EEList
    WHERE xEEID IN (SELECT eeceeid FROM dbo.vw_int_EmpComp where eecPaygroup in ('COBRT','AGENCY','UKSUPV') );
    



    -- Changes Only
    DELETE FROM dbo.U_EFIDEL403B_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EFIDEL403B_Audit WHERE audEEID = xEEID);
    
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = '457C,457CP,457F,457P';

        IF OBJECT_ID('U_EFIDEL403B_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EFIDEL403B_DedList
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
    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFIDEL403B_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhSource = CASE WHEN PdhDedCode IN ('457CF','457CP','457F','457P') THEN 'EEPRETAX' --401K
                          WHEN PdhDedCode IN ('TDAPT', 'TDAC', 'TDACP', 'TDAP', 'TDA','TDAPB') THEN '403B' --ROTH
                          WHEN PdhDedCode IN ('TDALN','THRLN') THEN 'LOAN 1' --401K LOAN
                          WHEN PdhDedCode IN ('TDARO','TDABR') THEN 'ROTH'
                          WHEN PdhDedCode IN ('TDANE') THEN 'NEC'
                          WHEN PdhDedCode IN ('TDAMT' ,'TDPMC') THEN 'NEC2' 
                          WHEN PdhDedCode IN ('DC') THEN 'MON'
                          WHEN PdhDedCode in ('THRFS') THEN 'THRIFT06'
                          WHEN PdhDedCode in ('THRFB') and PdhEECurAmt <> 0.00 THEN 'THRIFT_01'
                          WHEN PdhDedCode in ('THRFB') and PdhERCurAmt <> 0.00 THEN 'THRIFT_02'
                     END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)
        ,PlanNo =  CASE WHEN PdhDedCode in ('457CF','457CP','457F','457P') THEN '76664'
                        WHEN PdhDedCode in ('DC') THEN '76662'
                        WHEN PdhDedCode in ('TDA', 'TDAP', 'TDAC', 'TDACP', 'TDANE', 'TDAPT' ,'TDARO','TDABR', 'TDAMT', 'TDAPB' , 'TDPMC' ) THEN '76661'
                        WHEN PdhDedCode in ('TDALN' ) THEN '76661'
                        WHEN PdhDedCode in ('THRFB', 'THRFS','THRLN' ) THEN '76663'
                    END
    INTO dbo.U_EFIDEL403B_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND 
    PdhDedCode IN ('457CF','457CP','457F','457P','DC','TDA','TDAC', 'TDACP','TDAP','TDALN','THRLN','TDANE','TDA', 'TDAP', 'TDAC', 'TDACP', 'TDANE', 'TDAPT' ,'TDARO','TDABR', 'TDAMT', 'TDAPB' , 'TDPMC','THRFS','THRFB')
    GROUP BY PdhEEID
        ,CASE WHEN PdhDedCode IN ('457CF','457CP','457F','457P') THEN 'EEPRETAX' --401K
                          WHEN PdhDedCode IN ('TDAPT', 'TDAC', 'TDACP', 'TDAP', 'TDA','TDAPB') THEN '403B' --ROTH
                          WHEN PdhDedCode IN ('TDALN','THRLN') THEN 'LOAN 1' --401K LOAN
                          WHEN PdhDedCode IN ('TDARO','TDABR') THEN 'ROTH'
                          WHEN PdhDedCode IN ('TDANE') THEN 'NEC'
                          WHEN PdhDedCode IN ('TDAMT' ,'TDPMC') THEN 'NEC2' 
                          WHEN PdhDedCode IN ('DC') THEN 'MON'
                         WHEN PdhDedCode in ('THRFS') THEN 'THRIFT06'
                         WHEN PdhDedCode in ('THRFB') and PdhEECurAmt <> 0.00 THEN 'THRIFT_01'
                         WHEN PdhDedCode in ('THRFB') and PdhERCurAmt <> 0.00 THEN 'THRIFT_02'
                     END
       ,CASE WHEN PdhDedCode in ('457CF','457CP','457F','457P') THEN '76664'
                        WHEN PdhDedCode in ('DC') THEN '76662'
                        WHEN PdhDedCode in ('TDA', 'TDAP', 'TDAC', 'TDACP', 'TDANE', 'TDAPT' ,'TDARO','TDABR', 'TDAMT', 'TDAPB' , 'TDPMC' ) THEN '76661'
                        WHEN PdhDedCode in ('TDALN' ) THEN '76661'
                       WHEN PdhDedCode in ('THRFB', 'THRFS','THRLN' ) THEN '76663'
                    END
    HAVING (SUM(PdhEECurAmt) <> 0.00 or SUM(PdhERCurAmt) <> 0.00);

    -------------------------------
    -- Working Table - Employees
    -------------------------------
    IF OBJECT_ID('U_EFIDEL403B_Employees','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_Employees;
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
    INTO dbo.U_EFIDEL403B_Employees
    FROM dbo.U_EFIDEL403B_EEList
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.vw_int_OrgLevel O2 WITH (NOLOCK)
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
            ,audNewHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,audReHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,audTerm = MAX(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END)
            ,audSalaryChange = max(CASE  WHEN  audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)
            ,emailAddress = max(CASE  WHEN  audFieldName = 'EepEmailAddress' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)

        FROM dbo.U_EFIDEL403B_Audit
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID;

        IF OBJECT_ID('U_EFIDEL403B_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_PEarHist;
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
    INTO dbo.U_EFIDEL403B_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_01
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_01;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLASTNAME = EepNameLast
        ,drvFIRSTNAMEMIDDLEINITIAL = RTRIM(EepNameFirst) + ISNULL(LEFT(EepNameMiddle,1),'')
        ,drvMARITALSTATUS = CASE WHEN ISNULL(eepMaritalStatus,'') in ('','Z') THEN ' ' ELSE eepMaritalStatus END
        ,drvGENDER = CASE WHEN EepGender = 'M' THEN 'M' 
                          WHEN EepGender = 'F' THEN 'F'
                          ELSE ' '
                     END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '01'
    INTO dbo.U_EFIDEL403B_drvTbl_01
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record01Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';

    --Replicate record for 457C dedcode
    
    INSERT INTO  dbo.U_EFIDEL403B_drvTbl_01
   SELECT DISTINCT
         drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvLASTNAME 
        ,drvFIRSTNAMEMIDDLEINITIAL 
        ,drvMARITALSTATUS 
        ,drvGENDER 
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
    FROM  dbo.U_EFIDEL403B_drvTbl_01
    WHERE drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)



    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_02D
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_02D','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_02D;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvHIREDATE = EecDateOfOriginalHire
        ,drvVestingDAte = CustomFields.Person_VestingDate --EecDateOfSeniority -- JCB
        ,drvDATEOFBIRTH = EepDateOfBirth
        ,drvDateSwitch = CASE WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN '5' ELSE '' END
        ,drvTERMINATIONDATE = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02D'
    INTO dbo.U_EFIDEL403B_drvTbl_02D
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    JOIN (SELECT * FROM [dbo].[fn_MP_CustomFields_EmpPers_Export] (NULL, NULL, NULL, NULL)) CustomFields
        ON xEEID = CustomFields.EEID
    WHERE Record02DChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y' or audTerm = 'Y' ;

    --the record for 457X dedcode
      INSERT INTO dbo.U_EFIDEL403B_drvTbl_02D
   SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvHIREDATE 
        ,drvVestingDAte 
        ,drvDATEOFBIRTH 
        ,drvDateSwitch
        ,drvTERMINATIONDATE 
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
    FROM dbo.U_EFIDEL403B_drvTbl_02D 
    WHERE  drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)

    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_02E
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_02E','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_02E;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEMPLOYEENUMBER = EecEmpNo
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02E'
    INTO dbo.U_EFIDEL403B_drvTbl_02E
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record02EChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


      INSERT INTO  dbo.U_EFIDEL403B_drvTbl_02E
  SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvEMPLOYEENUMBER 
        ,drvEEID
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort
    FROM dbo.U_EFIDEL403B_drvTbl_02E
     where drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)

    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_03
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_03','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_03;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvADDRESSLINENUMBER = LineNumber
        ,drvADDRESS = EepAddress
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '03'
    INTO dbo.U_EFIDEL403B_drvTbl_03
    FROM (
        -- Address Line 1
        SELECT xEEID, xCOID, EepSSN, EepAddressLine1 AS EepAddress, '01' AS LineNumber, Record03Change, audNewHire,audReHire FROM dbo.U_EFIDEL403B_Employees

        UNION ALL

        -- Address Line 2
        SELECT xEEID, xCOID, EepSSN, EepAddressLine2 AS EepAddress, '02' AS LineNumber, Record03Change, audNewHire,audReHire FROM dbo.U_EFIDEL403B_Employees

        UNION ALL

        -- Address Line 3
        SELECT xEEID, xCOID, EepSSN, EepAddressLine3 AS EepAddress, '03' AS LineNumber, Record03Change, audNewHire,audReHire  FROM dbo.U_EFIDEL403B_Employees
    ) Employee
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


    Delete from U_EFIDEL403B_drvTbl_03 where drvAddress is  null;
     
     INSERT INTO dbo.U_EFIDEL403B_drvTbl_03
        SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvADDRESSLINENUMBER
        ,drvADDRESS 
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
    FROM dbo.U_EFIDEL403B_drvTbl_03
     where drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)


    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_04
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_04','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_04;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
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
    INTO dbo.U_EFIDEL403B_drvTbl_04
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record04Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

      INSERT INTO dbo.U_EFIDEL403B_drvTbl_04
  SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvCITY 
        ,drvSTATE 
        ,drvZIPCODE 
        ,drvZIP4CODE 
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
    FROM dbo.U_EFIDEL403B_drvTbl_04 where drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)

    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_05
    ---------------------------------
    /*
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_05','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_05;
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
    INTO dbo.U_EFIDEL403B_drvTbl_05
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE EepAddressCountry NOT IN ('US','USA')
    AND Record05Change = 'Y';
    */
    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_06
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_06','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_06;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONID = Concat(EecOrgLvl1,'-',EecOrgLvl2)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '06'
    INTO dbo.U_EFIDEL403B_drvTbl_06
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record06Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

      INSERT INTO dbo.U_EFIDEL403B_drvTbl_06
          SELECT DISTINCT
                drvPLANNUMBER = '76664'
                ,drvBATCHGROUPID 
                ,drvSOCIALSECURITYNUMBER 
                ,drvDIVISIONID 
                ,drvEEID 
                ,drvCoID 
                ,drvInitialSort
                ,drvSubSort 
            FROM dbo.U_EFIDEL403B_drvTbl_06
            WHERE drveeid in  (select bdmeeid from U_dsi_BDM_EFIDEL403B)

  ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_08
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_08','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_08;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSalary =  CONVERT(VARCHAR,dbo.dsi_fnPadZero(EecAnnSalary*100,13,0)) 
        ,drvSalaryInd = 'R'
        ,drvSalPayDate = PrgPayDate
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '08'
    INTO dbo.U_EFIDEL403B_drvTbl_08
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    LEFT JOIN dbo.U_EFIDEL403B_PEarHist WITH (NOLOCK)
    ON PehEEID = xEEID
    WHERE   audNewHire = 'Y' or  audReHire = 'Y';

            INSERT INTO dbo.U_EFIDEL403B_drvTbl_08
        SELECT DISTINCT
            drvPLANNUMBER = '76664'
            ,drvSOCIALSECURITYNUMBER 
            ,drvSalary 
            ,drvSalaryInd 
            ,drvSalPayDate 
            ,drvEEID 
            ,drvCoID 
            ,drvInitialSort
            ,drvSubSort 
        FROM dbo.U_EFIDEL403B_drvTbl_08
        WHERE drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)
    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_11
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_11','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_11;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSTATUSCODE = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN 'D'
                              WHEN EecEmplStatus = 'A' THEN 'E'
                              WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN 'H'
                              WHEN EecEmplStatus = 'L' THEN 'L'
                              WHEN EecEmplStatus = 'T' and EecTermReason not in ('202') THEN 'R'
                              WHEN EecEmplStatus = 'T' THEN 'R'
                              WHEN EecEmplStatus = 'T' AND EjhReason = 'TRO' THEN 'I'
                              WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203','TRO') THEN 'T'
                         END
        ,drvStatusDate = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN eecdateoftermination
                              WHEN EecEmplStatus = 'A' THEN EecDateOfLastHire
                              WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire
                              WHEN EecEmplStatus = 'L' THEN  EecEmplStatusStartDate
                              WHEN EecEmplStatus = 'T' and EecTermReason not in ('202') THEN eecdateoftermination
                              WHEN EecEmplStatus = 'T' THEN eecdateoftermination
                              WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203','TRO') THEN Eecdateoftermination
                         END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '11'
    INTO dbo.U_EFIDEL403B_drvTbl_11
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID
        AND EjhCoID    = xCOID
    WHERE Record11Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';

            INSERT INTO dbo.U_EFIDEL403B_drvTbl_11
            SELECT DISTINCT
            drvPLANNUMBER = '76664'
            ,drvBATCHGROUPID 
            ,drvSOCIALSECURITYNUMBER 
            ,drvSTATUSCODE
            ,drvStatusDate
            ,drvEEID 
            ,drvCoID 
            ,drvInitialSort 
            ,drvSubSort = '11'
            FROM dbo.U_EFIDEL403B_drvTbl_11
            WHERE drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)

    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_36
    ---------------------------------
    /*
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_36','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_36;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONCODE = EecOrglvl2
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '36'
    INTO dbo.U_EFIDEL403B_drvTbl_36
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record36Change = 'Y';
    */
    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_60
    ---------------------------------
    
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_60','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_60;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvPARTICIPANTCLASS = EecFullTimeOrPartTime
        ,drvPARTICIPANTDISTRICT = ''--EecOrgLvl1
        ,drvPARTICIPANTDEPARTMENT = ''--EecOrgLvl2
        ,drvPARTICIPANTLOCATIONSTORE = ''--EecLocation
        ,drvPARTICIPANTUNIONCODE = ''--EecUnionLocal
        ,drvPARTICIPANTPAYMENTFREQ = 'B'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '60'
    INTO dbo.U_EFIDEL403B_drvTbl_60
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record60Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';

      INSERT INTO dbo.U_EFIDEL403B_drvTbl_60
        SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvPARTICIPANTCLASS 
        ,drvPARTICIPANTDISTRICT
        ,drvPARTICIPANTDEPARTMENT 
        ,drvPARTICIPANTLOCATIONSTORE 
        ,drvPARTICIPANTUNIONCODE 
        ,drvPARTICIPANTPAYMENTFREQ 
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
        FROM dbo.U_EFIDEL403B_drvTbl_60
        WHERE drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)
    
    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_61
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_61','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_61;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEligDate = ''
        ,drvADJUSTEDDATEOFHIRE = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvRETIREMENTDATE = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '202' THEN eecdateoftermination END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '61'
    INTO dbo.U_EFIDEL403B_drvTbl_61
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record61Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';

    INSERT INTO dbo.U_EFIDEL403B_drvTbl_61
    SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvEligDate 
        ,drvADJUSTEDDATEOFHIRE
        ,drvRETIREMENTDATE
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
    FROM dbo.U_EFIDEL403B_drvTbl_61 WHERE drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)



    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_EA
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_EA','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_EA;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEmployeeId = ''
        ,drvEmailRecSeq = LineNumber
        ,drvEmailAddress = EepAddressEmail
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = 'EA'
    INTO dbo.U_EFIDEL403B_drvTbl_EA
    FROM ( -- Email 1
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 1, 35) AS EepAddressEmail, '1' AS LineNumber, emailAddress, audNewHire,audReHire FROM dbo.U_EFIDEL403B_Employees

        UNION ALL

        -- Email 2
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 36, 70)  EepAddressEmail, '2' AS LineNumber, emailAddress, audNewHire,audReHire FROM dbo.U_EFIDEL403B_Employees

        UNION ALL

        -- Email 3
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 71, 88)  AS EepAddressEmail, '3' AS LineNumber, emailAddress, audNewHire,audReHire  FROM dbo.U_EFIDEL403B_Employees)
        Employee
    WHERE emailAddress = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

    Delete from U_EFIDEL403B_drvTbl_EA where drvemailaddress is null or drvemailaddress = '';


    INSERT INTO dbo.U_EFIDEL403B_drvTbl_EA
        SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER
        ,drvEmployeeId 
        ,drvEmailRecSeq 
        ,drvEmailAddress 
        ,drvEEID
        ,drvCoID 
        ,drvInitialSort
        ,drvSubSort
    FROM  dbo.U_EFIDEL403B_drvTbl_EA WITH (NOLOCK)
    where drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)

    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_19Q
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_19Q','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_19Q;
    SELECT DISTINCT
        drvPLANNUMBER = PlanNo
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSOURCE = CASE WHEN PdhSource IN ('EEPRETAX') THEN '01' --401K
                          WHEN PdhSource IN ('403B') THEN '01' --ROTH
                          WHEN PdhSource IN ('ROTH') THEN '02'
                          WHEN PdhSource IN ('MON') THEN '02'
                          --WHEN PdhSource IN ('NEC') and HIRE_REHIRE.xEEID is null THEN '04'
                          --WHEN PdhSource IN ('NEC2') and HIRE_REHIRE.xEEID is null THEN '03'
                          WHEN PdhSource IN ('NEC') THEN '04'
                          WHEN PdhSource IN ('NEC2') THEN '03'
                          WHEN PdhSource in ('THRIFT06') THEN '06'
                          WHEN PdhSource in ('THRIFT_01') THEN '01'
                     END
        ,drvAMOUNT = CASE WHEN PdhSource in ('MON') and PdhEECurAmt <> 0.00  and PdhEECurAmt = 0.00 then PdhEECurAmt 
                          WHEN PdhSource in ('MON') and PdhERCurAmt <> 0.00 and PdhEECurAmt = 0.00 then PdhERCurAmt
                          WHEN PdhSource in ('NEC2') and PdhEECurAmt <> 0.00  and PdhEECurAmt = 0.00 then PdhEECurAmt 
                          WHEN PdhSource in ('NEC2') and PdhERCurAmt <> 0.00 and PdhEECurAmt = 0.00 then PdhERCurAmt
                          WHEN PdhSource in ('NEC') and PdhEECurAmt <> 0.00  and PdhEECurAmt = 0.00 then PdhEECurAmt 
                          WHEN PdhSource in ('NEC') and PdhERCurAmt <> 0.00 and PdhEECurAmt = 0.00 then PdhERCurAmt
                          WHEN PdhSource in ('THRIFT_02') and PdhERCurAmt <> 0.00 THEN PdhERCurAmt
                          WHEN PdhSource in ('THRIFT_01') and PdhEECurAmt <> 0.00 THEN PdhEECurAmt
                          ELSE PdhEECurAmt
                      END 
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '19Q'
    INTO dbo.U_EFIDEL403B_drvTbl_19Q
    FROM dbo.U_EFIDEL403B_PDedHist WITH (NOLOCK)
    LEFT JOIN  (SELECT xEEID,xCOID  FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE   audNewHire = 'Y' or  audReHire = 'Y') HIRE_REHIRE
    on HIRE_REHIRE.xEEID = PdhEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    WHERE PdhSource not in  ('LOAN 1','LOAN 2')
    ;

    INSERT INTO dbo.U_EFIDEL403B_drvTbl_19Q
     SELECT DISTINCT
        drvPLANNUMBER 
        ,drvBATCHGROUPID
        ,drvSOCIALSECURITYNUMBER
        ,drvSOURCE = '02'
        ,drvAMOUNT = PdhERCurAmt
        ,drvEEID = PdhEEID
        ,drvInitialSort 
        ,drvSubSort = '19Q'
    FROM  dbo.U_EFIDEL403B_drvTbl_19Q 
    Join dbo.U_EFIDEL403B_PDedHist on drveeid  = pdheeid
    WHERE PdhSource = 'THRIFT_01' and PdhERCurAmt > 0
    AND drvPLanNumber = '76663' and drvSource = '01'



    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_21
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_21','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_21;
    SELECT DISTINCT
        drvPLANNUMBER = PlanNo
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLOANIDENTIFICATION = CASE WHEN PdhSource in ('LOAN 1','LOAN 2') THEN '' END 
                                   
        ,drvREPAYMENTAMOUNT = PdhEECurAmt
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '21'
    INTO dbo.U_EFIDEL403B_drvTbl_21
    FROM dbo.U_EFIDEL403B_PDedHist WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    WHERE PdhSource  in  ('LOAN 1','LOAN 2') ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EFIDEL403B','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('EFIDEL403B','Testing') = 'Y' THEN 'TEST_CSP_EFIDEL403B_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'CSP_EFIDEL403B_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = 'EFIDEL403B';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFIDEL403B_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDEL403B_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFIDEL403B%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201702011'
       ,ExpStartPerControl     = '201702011'
       ,ExpLastEndPerControl   = '201702019'
       ,ExpEndPerControl       = '201702019'
WHERE ExpFormatCode = 'EFIDEL403B';

**********************************************************************************/
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDEL403B_G10_BKP_2020_PROD]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Oxfor University Press

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 03/20/2020
Service Request Number: TekP-2020-02-17-0003

Purpose: Fidelity 403B Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFIDEL403B';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFIDEL403B';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFIDEL403B';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = 'EFIDEL403B'; -- Skip RecordSets by ExportCode
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EFIDEL403B';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFIDEL403B' ORDER BY RunID DESC;


UPDATE U_dsi_Configuration set cfgvalue = null where  FormatCode = 'EFIDEL403B' and cfgname = 'ExportPath'
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDEL403B', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDEL403B', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFIDEL403B', @AllObjects = 'Y'
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
    WHERE FormatCode = 'EFIDEL403B';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFIDEL403B_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_AuditFields;
    CREATE TABLE dbo.U_EFIDEL403B_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('EmpPers','EepEmailAddress');

    INSERT INTO dbo.U_EFIDEL403B_AuditFields VALUES ('OrgLevel','OrgDesc');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFIDEL403B_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_Audit;
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
    INTO dbo.U_EFIDEL403B_Audit
    FROM dbo.U_EFIDEL403B_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EFIDEL403B_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate - 14  AND @EndDate + 30
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EFIDEL403B_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFIDEL403B_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFIDEL403B_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EFIDEL403B_EEList
    WHERE xEEID IN (SELECT eeceeid FROM dbo.EmpComp where eecPaygroup in ('COBRT','AGENCY','UKSUPV') );
    



    -- Changes Only
    DELETE FROM dbo.U_EFIDEL403B_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EFIDEL403B_Audit WHERE audEEID = xEEID);
    
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = '457C,457CP,457F,457P';

        IF OBJECT_ID('U_EFIDEL403B_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EFIDEL403B_DedList
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
    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFIDEL403B_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhSource = CASE WHEN PdhDedCode IN ('457CF','457CP','457F','457P') THEN 'EEPRETAX' --401K
                          WHEN PdhDedCode IN ('TDAPT', 'TDAC', 'TDACP', 'TDAP', 'TDA','TDAPB') THEN '403B' --ROTH
                          WHEN PdhDedCode IN ('TDALN','THRLN') THEN 'LOAN 1' --401K LOAN
                          WHEN PdhDedCode IN ('TDARO','TDABR') THEN 'ROTH'
                          WHEN PdhDedCode IN ('TDANE') THEN 'NEC'
                          WHEN PdhDedCode IN ('TDAMT' ,'TDPMC') THEN 'NEC2' 
                          WHEN PdhDedCode IN ('DC') THEN 'MON'
                          WHEN PdhDedCode in ('THRFS') THEN 'THRIFT06'
                          WHEN PdhDedCode in ('THRFB') and PdhEECurAmt <> 0.00 THEN 'THRIFT_01'
                          WHEN PdhDedCode in ('THRFB') and PdhERCurAmt <> 0.00 THEN 'THRIFT_02'
                     END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)
        ,PlanNo =  CASE WHEN PdhDedCode in ('457CF','457CP','457F','457P') THEN '76664'
                        WHEN PdhDedCode in ('DC') THEN '76662'
                        WHEN PdhDedCode in ('TDA', 'TDAP', 'TDAC', 'TDACP', 'TDANE', 'TDAPT' ,'TDARO','TDABR', 'TDAMT', 'TDAPB' , 'TDPMC' ) THEN '76661'
                        WHEN PdhDedCode in ('TDALN' ) THEN '76661'
                        WHEN PdhDedCode in ('THRFB', 'THRFS','THRLN' ) THEN '76663'
                    END
    INTO dbo.U_EFIDEL403B_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND 
    PdhDedCode IN ('457CF','457CP','457F','457P','DC','TDA','TDAC', 'TDACP','TDAP','TDALN','THRLN','TDANE','TDA', 'TDAP', 'TDAC', 'TDACP', 'TDANE', 'TDAPT' ,'TDARO','TDABR', 'TDAMT', 'TDAPB' , 'TDPMC','THRFS','THRFB')
    GROUP BY PdhEEID
        ,CASE WHEN PdhDedCode IN ('457CF','457CP','457F','457P') THEN 'EEPRETAX' --401K
                          WHEN PdhDedCode IN ('TDAPT', 'TDAC', 'TDACP', 'TDAP', 'TDA','TDAPB') THEN '403B' --ROTH
                          WHEN PdhDedCode IN ('TDALN','THRLN') THEN 'LOAN 1' --401K LOAN
                          WHEN PdhDedCode IN ('TDARO','TDABR') THEN 'ROTH'
                          WHEN PdhDedCode IN ('TDANE') THEN 'NEC'
                          WHEN PdhDedCode IN ('TDAMT' ,'TDPMC') THEN 'NEC2' 
                          WHEN PdhDedCode IN ('DC') THEN 'MON'
                         WHEN PdhDedCode in ('THRFS') THEN 'THRIFT06'
                         WHEN PdhDedCode in ('THRFB') and PdhEECurAmt <> 0.00 THEN 'THRIFT_01'
                         WHEN PdhDedCode in ('THRFB') and PdhERCurAmt <> 0.00 THEN 'THRIFT_02'
                     END
       ,CASE WHEN PdhDedCode in ('457CF','457CP','457F','457P') THEN '76664'
                        WHEN PdhDedCode in ('DC') THEN '76662'
                        WHEN PdhDedCode in ('TDA', 'TDAP', 'TDAC', 'TDACP', 'TDANE', 'TDAPT' ,'TDARO','TDABR', 'TDAMT', 'TDAPB' , 'TDPMC' ) THEN '76661'
                        WHEN PdhDedCode in ('TDALN' ) THEN '76661'
                       WHEN PdhDedCode in ('THRFB', 'THRFS','THRLN' ) THEN '76663'
                    END
    HAVING (SUM(PdhEECurAmt) <> 0.00 or SUM(PdhERCurAmt) <> 0.00);

    -------------------------------
    -- Working Table - Employees
    -------------------------------
    IF OBJECT_ID('U_EFIDEL403B_Employees','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_Employees;
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
    INTO dbo.U_EFIDEL403B_Employees
    FROM dbo.U_EFIDEL403B_EEList
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
            ,audNewHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,audReHire = max(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,audTerm = MAX(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END)
            ,audSalaryChange = max(CASE  WHEN  audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)
            ,emailAddress = max(CASE  WHEN  audFieldName = 'EepEmailAddress' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)

        FROM dbo.U_EFIDEL403B_Audit
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID;

        IF OBJECT_ID('U_EFIDEL403B_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_PEarHist;
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
    INTO dbo.U_EFIDEL403B_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_01
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_01;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLASTNAME = EepNameLast
        ,drvFIRSTNAMEMIDDLEINITIAL = RTRIM(EepNameFirst) + ISNULL(LEFT(EepNameMiddle,1),'')
        ,drvMARITALSTATUS = CASE WHEN ISNULL(eepMaritalStatus,'') in ('','Z') THEN ' ' ELSE eepMaritalStatus END
        ,drvGENDER = CASE WHEN EepGender = 'M' THEN 'M' 
                          WHEN EepGender = 'F' THEN 'F'
                          ELSE ' '
                     END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '01'
    INTO dbo.U_EFIDEL403B_drvTbl_01
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record01Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';

    --Replicate record for 457C dedcode
    
    INSERT INTO  dbo.U_EFIDEL403B_drvTbl_01
   SELECT DISTINCT
         drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvLASTNAME 
        ,drvFIRSTNAMEMIDDLEINITIAL 
        ,drvMARITALSTATUS 
        ,drvGENDER 
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
    FROM  dbo.U_EFIDEL403B_drvTbl_01
    WHERE drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)



    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_02D
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_02D','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_02D;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvHIREDATE = EecDateOfOriginalHire
        ,drvVestingDAte = EecDateOfSeniority
        ,drvDATEOFBIRTH = EepDateOfBirth
        ,drvDateSwitch = CASE WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN '5' ELSE '' END
        ,drvTERMINATIONDATE = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02D'
    INTO dbo.U_EFIDEL403B_drvTbl_02D
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record02DChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y' or audTerm = 'Y' ;

    --Replicate the record for 457X dedcode
      INSERT INTO dbo.U_EFIDEL403B_drvTbl_02D
   SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvHIREDATE 
        ,drvVestingDAte 
        ,drvDATEOFBIRTH 
        ,drvDateSwitch
        ,drvTERMINATIONDATE 
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
    FROM dbo.U_EFIDEL403B_drvTbl_02D 
    WHERE  drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)

    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_02E
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_02E','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_02E;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEMPLOYEENUMBER = EecEmpNo
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02E'
    INTO dbo.U_EFIDEL403B_drvTbl_02E
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record02EChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


      INSERT INTO  dbo.U_EFIDEL403B_drvTbl_02E
  SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvEMPLOYEENUMBER 
        ,drvEEID
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort
    FROM dbo.U_EFIDEL403B_drvTbl_02E
     where drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)

    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_03
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_03','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_03;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvADDRESSLINENUMBER = LineNumber
        ,drvADDRESS = EepAddress
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '03'
    INTO dbo.U_EFIDEL403B_drvTbl_03
    FROM (
        -- Address Line 1
        SELECT xEEID, xCOID, EepSSN, EepAddressLine1 AS EepAddress, '01' AS LineNumber, Record03Change, audNewHire,audReHire FROM dbo.U_EFIDEL403B_Employees

        UNION ALL

        -- Address Line 2
        SELECT xEEID, xCOID, EepSSN, EepAddressLine2 AS EepAddress, '02' AS LineNumber, Record03Change, audNewHire,audReHire FROM dbo.U_EFIDEL403B_Employees

        UNION ALL

        -- Address Line 3
        SELECT xEEID, xCOID, EepSSN, EepAddressLine3 AS EepAddress, '03' AS LineNumber, Record03Change, audNewHire,audReHire  FROM dbo.U_EFIDEL403B_Employees
    ) Employee
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


    Delete from U_EFIDEL403B_drvTbl_03 where drvAddress is  null;
     
     INSERT INTO dbo.U_EFIDEL403B_drvTbl_03
        SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvADDRESSLINENUMBER
        ,drvADDRESS 
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
    FROM dbo.U_EFIDEL403B_drvTbl_03
     where drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)


    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_04
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_04','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_04;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
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
    INTO dbo.U_EFIDEL403B_drvTbl_04
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record04Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

      INSERT INTO dbo.U_EFIDEL403B_drvTbl_04
  SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvCITY 
        ,drvSTATE 
        ,drvZIPCODE 
        ,drvZIP4CODE 
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
    FROM dbo.U_EFIDEL403B_drvTbl_04 where drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)

    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_05
    ---------------------------------
    /*
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_05','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_05;
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
    INTO dbo.U_EFIDEL403B_drvTbl_05
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE EepAddressCountry NOT IN ('US','USA')
    AND Record05Change = 'Y';
    */
    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_06
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_06','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_06;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONID = Concat(EecOrgLvl1,'-',EecOrgLvl2)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '06'
    INTO dbo.U_EFIDEL403B_drvTbl_06
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record06Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

      INSERT INTO dbo.U_EFIDEL403B_drvTbl_06
          SELECT DISTINCT
                drvPLANNUMBER = '76664'
                ,drvBATCHGROUPID 
                ,drvSOCIALSECURITYNUMBER 
                ,drvDIVISIONID 
                ,drvEEID 
                ,drvCoID 
                ,drvInitialSort
                ,drvSubSort 
            FROM dbo.U_EFIDEL403B_drvTbl_06
            WHERE drveeid in  (select bdmeeid from U_dsi_BDM_EFIDEL403B)

  ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_08
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_08','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_08;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSalary =  CONVERT(VARCHAR,dbo.dsi_fnPadZero(EecAnnSalary*100,13,0)) 
        ,drvSalaryInd = 'R'
        ,drvSalPayDate = PrgPayDate
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '08'
    INTO dbo.U_EFIDEL403B_drvTbl_08
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    LEFT JOIN dbo.U_EFIDEL403B_PEarHist WITH (NOLOCK)
    ON PehEEID = xEEID
    WHERE   audNewHire = 'Y' or  audReHire = 'Y';

            INSERT INTO dbo.U_EFIDEL403B_drvTbl_08
        SELECT DISTINCT
            drvPLANNUMBER = '76664'
            ,drvSOCIALSECURITYNUMBER 
            ,drvSalary 
            ,drvSalaryInd 
            ,drvSalPayDate 
            ,drvEEID 
            ,drvCoID 
            ,drvInitialSort
            ,drvSubSort 
        FROM dbo.U_EFIDEL403B_drvTbl_08
        WHERE drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)
    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_11
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_11','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_11;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSTATUSCODE = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN 'D'
                              WHEN EecEmplStatus = 'A' THEN 'E'
                              WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN 'H'
                              WHEN EecEmplStatus = 'L' THEN 'L'
                              WHEN EecEmplStatus = 'T' and EecTermReason not in ('202') THEN 'R'
                              WHEN EecEmplStatus = 'T' THEN 'R'

                         END
        ,drvStatusDate = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN eecdateoftermination
                              WHEN EecEmplStatus = 'A' THEN EecDateOfLastHire
                              WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN EecDateOfLastHire
                              WHEN EecEmplStatus = 'L' THEN  EecEmplStatusStartDate
                              WHEN EecEmplStatus = 'T' and EecTermReason not in ('202') THEN eecdateoftermination
                              WHEN EecEmplStatus = 'T' THEN eecdateoftermination
                         END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '11'
    INTO dbo.U_EFIDEL403B_drvTbl_11
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record11Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';

            INSERT INTO dbo.U_EFIDEL403B_drvTbl_11
            SELECT DISTINCT
            drvPLANNUMBER = '76664'
            ,drvBATCHGROUPID 
            ,drvSOCIALSECURITYNUMBER 
            ,drvSTATUSCODE
            ,drvStatusDate
            ,drvEEID 
            ,drvCoID 
            ,drvInitialSort 
            ,drvSubSort = '11'
            FROM dbo.U_EFIDEL403B_drvTbl_11
            WHERE drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)

    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_36
    ---------------------------------
    /*
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_36','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_36;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONCODE = EecOrglvl2
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '36'
    INTO dbo.U_EFIDEL403B_drvTbl_36
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record36Change = 'Y';
    */
    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_60
    ---------------------------------
    
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_60','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_60;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvPARTICIPANTCLASS = EecFullTimeOrPartTime
        ,drvPARTICIPANTDISTRICT = ''--EecOrgLvl1
        ,drvPARTICIPANTDEPARTMENT = ''--EecOrgLvl2
        ,drvPARTICIPANTLOCATIONSTORE = ''--EecLocation
        ,drvPARTICIPANTUNIONCODE = ''--EecUnionLocal
        ,drvPARTICIPANTPAYMENTFREQ = 'B'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '60'
    INTO dbo.U_EFIDEL403B_drvTbl_60
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record60Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';

      INSERT INTO dbo.U_EFIDEL403B_drvTbl_60
        SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvPARTICIPANTCLASS 
        ,drvPARTICIPANTDISTRICT
        ,drvPARTICIPANTDEPARTMENT 
        ,drvPARTICIPANTLOCATIONSTORE 
        ,drvPARTICIPANTUNIONCODE 
        ,drvPARTICIPANTPAYMENTFREQ 
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
        FROM dbo.U_EFIDEL403B_drvTbl_60
        WHERE drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)
    
    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_61
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_61','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_61;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEligDate = ''
        ,drvADJUSTEDDATEOFHIRE = CASE WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN EecDateOfLastHire  ELSE '' END
        ,drvRETIREMENTDATE = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '202' THEN  eecdateoftermination ELSE EecDateOfRetirement END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '61'
    INTO dbo.U_EFIDEL403B_drvTbl_61
    FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE Record61Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';

    INSERT INTO dbo.U_EFIDEL403B_drvTbl_61
    SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER 
        ,drvEligDate 
        ,drvADJUSTEDDATEOFHIRE
        ,drvRETIREMENTDATE
        ,drvEEID 
        ,drvCoID 
        ,drvInitialSort 
        ,drvSubSort 
    FROM dbo.U_EFIDEL403B_drvTbl_61 WHERE drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)



    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_EA
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_EA','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_EA;
    SELECT DISTINCT
        drvPLANNUMBER = '76661'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEmployeeId = ''
        ,drvEmailRecSeq = LineNumber
        ,drvEmailAddress = EepAddressEmail
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = 'EA'
    INTO dbo.U_EFIDEL403B_drvTbl_EA
    FROM ( -- Email 1
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 1, 35) AS EepAddressEmail, '1' AS LineNumber, emailAddress, audNewHire,audReHire FROM dbo.U_EFIDEL403B_Employees

        UNION ALL

        -- Email 2
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 36, 70)  EepAddressEmail, '2' AS LineNumber, emailAddress, audNewHire,audReHire FROM dbo.U_EFIDEL403B_Employees

        UNION ALL

        -- Email 3
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 71, 88)  AS EepAddressEmail, '3' AS LineNumber, emailAddress, audNewHire,audReHire  FROM dbo.U_EFIDEL403B_Employees)
        Employee
    WHERE emailAddress = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

    Delete from U_EFIDEL403B_drvTbl_EA where drvemailaddress is null or drvemailaddress = '';


    INSERT INTO dbo.U_EFIDEL403B_drvTbl_EA
        SELECT DISTINCT
        drvPLANNUMBER = '76664'
        ,drvBATCHGROUPID 
        ,drvSOCIALSECURITYNUMBER
        ,drvEmployeeId 
        ,drvEmailRecSeq 
        ,drvEmailAddress 
        ,drvEEID
        ,drvCoID 
        ,drvInitialSort
        ,drvSubSort
    FROM  dbo.U_EFIDEL403B_drvTbl_EA WITH (NOLOCK)
    where drveeid in (select bdmeeid from U_dsi_BDM_EFIDEL403B)

    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_19Q
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_19Q','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_19Q;
    SELECT DISTINCT
        drvPLANNUMBER = PlanNo
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSOURCE = CASE WHEN PdhSource IN ('EEPRETAX') THEN '01' --401K
                          WHEN PdhSource IN ('403B') THEN '01' --ROTH
                          WHEN PdhSource IN ('ROTH') THEN '02'
                          WHEN PdhSource IN ('MON') THEN '02'
                          --WHEN PdhSource IN ('NEC') and HIRE_REHIRE.xEEID is null THEN '04'
                          --WHEN PdhSource IN ('NEC2') and HIRE_REHIRE.xEEID is null THEN '03'
                          WHEN PdhSource IN ('NEC') THEN '04'
                          WHEN PdhSource IN ('NEC2') THEN '03'
                          WHEN PdhSource in ('THRIFT06') THEN '06'
                          WHEN PdhSource in ('THRIFT_01') THEN '01'
                     END
        ,drvAMOUNT = CASE WHEN PdhSource in ('MON') and PdhEECurAmt <> 0.00  and PdhEECurAmt = 0.00 then PdhEECurAmt 
                          WHEN PdhSource in ('MON') and PdhERCurAmt <> 0.00 and PdhEECurAmt = 0.00 then PdhERCurAmt
                          WHEN PdhSource in ('NEC2') and PdhEECurAmt <> 0.00  and PdhEECurAmt = 0.00 then PdhEECurAmt 
                          WHEN PdhSource in ('NEC2') and PdhERCurAmt <> 0.00 and PdhEECurAmt = 0.00 then PdhERCurAmt
                          WHEN PdhSource in ('NEC') and PdhEECurAmt <> 0.00  and PdhEECurAmt = 0.00 then PdhEECurAmt 
                          WHEN PdhSource in ('NEC') and PdhERCurAmt <> 0.00 and PdhEECurAmt = 0.00 then PdhERCurAmt
                          WHEN PdhSource in ('THRIFT_02') and PdhERCurAmt <> 0.00 THEN PdhERCurAmt
                          WHEN PdhSource in ('THRIFT_01') and PdhEECurAmt <> 0.00 THEN PdhEECurAmt
                          ELSE PdhEECurAmt
                      END 
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '19Q'
    INTO dbo.U_EFIDEL403B_drvTbl_19Q
    FROM dbo.U_EFIDEL403B_PDedHist WITH (NOLOCK)
    LEFT JOIN  (SELECT xEEID,xCOID  FROM dbo.U_EFIDEL403B_Employees WITH (NOLOCK)
    WHERE   audNewHire = 'Y' or  audReHire = 'Y') HIRE_REHIRE
    on HIRE_REHIRE.xEEID = PdhEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    WHERE PdhSource not in  ('LOAN 1','LOAN 2')
    ;

    INSERT INTO dbo.U_EFIDEL403B_drvTbl_19Q
     SELECT DISTINCT
        drvPLANNUMBER 
        ,drvBATCHGROUPID
        ,drvSOCIALSECURITYNUMBER
        ,drvSOURCE = '02'
        ,drvAMOUNT = PdhERCurAmt
        ,drvEEID = PdhEEID
        ,drvInitialSort 
        ,drvSubSort = '19Q'
    FROM  dbo.U_EFIDEL403B_drvTbl_19Q 
    Join dbo.U_EFIDEL403B_PDedHist on drveeid  = pdheeid
    WHERE PdhSource = 'THRIFT_01' and PdhERCurAmt > 0
    AND drvPLanNumber = '76663' and drvSource = '01'



    ---------------------------------
    -- DETAIL RECORD - U_EFIDEL403B_drvTbl_21
    ---------------------------------
    IF OBJECT_ID('U_EFIDEL403B_drvTbl_21','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDEL403B_drvTbl_21;
    SELECT DISTINCT
        drvPLANNUMBER = PlanNo
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLOANIDENTIFICATION = CASE WHEN PdhSource in ('LOAN 1','LOAN 2') THEN '' END 
                                   
        ,drvREPAYMENTAMOUNT = PdhEECurAmt
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '21'
    INTO dbo.U_EFIDEL403B_drvTbl_21
    FROM dbo.U_EFIDEL403B_PDedHist WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    WHERE PdhSource  in  ('LOAN 1','LOAN 2') ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EFIDEL403B','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('EFIDEL403B','Testing') = 'Y' THEN 'TEST_CSP_EFIDEL403B_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'CSP_EFIDEL403B_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = 'EFIDEL403B';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFIDEL403B_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDEL403B_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFIDEL403B%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201702011'
       ,ExpStartPerControl     = '201702011'
       ,ExpLastEndPerControl   = '201702019'
       ,ExpEndPerControl       = '201702019'
WHERE ExpFormatCode = 'EFIDEL403B';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFIDEL403B_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDEL403B_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;