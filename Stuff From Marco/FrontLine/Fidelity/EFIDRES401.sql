SET NOCOUNT ON;
IF OBJECT_ID('U_EFIDRES401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFIDRES401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFIDRES401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFIDRES401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFIDRES401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFIDRES401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDRES401];
GO
IF OBJECT_ID('U_EFIDRES401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_PEarHist];
GO
IF OBJECT_ID('U_EFIDRES401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_PDedHist];
GO
IF OBJECT_ID('U_EFIDRES401_File') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_File];
GO
IF OBJECT_ID('U_EFIDRES401_Employees') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_Employees];
GO
IF OBJECT_ID('U_EFIDRES401_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_EEList];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_EA') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_EA];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_61') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_61];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_60') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_60];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_36') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_36];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_21') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_21];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_19Q') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_19Q];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_11') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_11];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_08') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_08];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_06') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_06];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_05') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_05];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_04') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_04];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_03') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_03];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_02E') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_02E];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_02D') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_02D];
GO
IF OBJECT_ID('U_EFIDRES401_drvTbl_01') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_drvTbl_01];
GO
IF OBJECT_ID('U_EFIDRES401_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_DedList];
GO
IF OBJECT_ID('U_EFIDRES401_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_AuditFields];
GO
IF OBJECT_ID('U_EFIDRES401_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFIDRES401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFIDRES401];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFIDRES401';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'EFIDRES401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFIDRES401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFIDRES401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFIDRES401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFIDRES401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFIDRES401','Fidelity 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','80','S','N','EFIDRES401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TESTEDT"','1','(''DA''=''F'')','EFIDRES401Z0','7','H','01','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''F'')','EFIDRES401Z0','73','H','01','8',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','10','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','10','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','10','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','10','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLASTNAME"','7','(''UA''=''F'')','EFIDRES401Z0','20','D','10','32',NULL,'LAST NAME (FREE FORM)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFIRSTNAMEMIDDLEINITIAL"','8','(''UA''=''F'')','EFIDRES401Z0','15','D','10','52',NULL,'FIRST NAME MIDDLE INITIAL (FREE FORM)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000000"','9','(''DA''=''F'')','EFIDRES401Z0','9','D','10','67',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMARITALSTATUS"','10','(''UA''=''F'')','EFIDRES401Z0','1','D','10','76',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGENDER"','11','(''UA''=''F'')','EFIDRES401Z0','1','D','10','77',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EFIDRES401Z0','1','D','10','78',NULL,'SPECIAL TAX TYPE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDRES401Z0','1','D','10','79',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDRES401Z0','1','D','10','80',NULL,'BENE/QDRO PAYEE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','15','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','15','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','15','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','15','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','15','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"02"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','15','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D"','7','(''DA''=''F'')','EFIDRES401Z0','1','D','15','32',NULL,'FIELD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDRES401Z0','4','D','15','33',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHIREDATE"','9','(''UDMDY''=''F'')','EFIDRES401Z0','8','D','15','37',NULL,'HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000000"','10','(''DA''=''F'')','EFIDRES401Z0','8','D','15','45',NULL,'PARTICIPATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVestingDAte"','11','(''UDMDY''=''F'')','EFIDRES401Z0','8','D','15','53',NULL,'VESTING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDATEOFBIRTH"','12','(''UDMDY''=''F'')','EFIDRES401Z0','8','D','15','61',NULL,'DATE-OF-BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTERMINATIONDATE"','13','(''UA''=''F'')','EFIDRES401Z0','8','D','15','69',NULL,'TERMINATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateSwitch"','14','(''UDMDY''=''F'')','EFIDRES401Z0','1','D','15','77',NULL,'DATE SWITCH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDRES401Z0','1','D','15','78',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EFIDRES401Z0','1','D','15','79',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','EFIDRES401Z0','1','D','15','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','20','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','20','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','20','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','20','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','20','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"02"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','20','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E"','7','(''DA''=''F'')','EFIDRES401Z0','1','D','20','32',NULL,'FIELD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEENUMBER"','8','(''UA''=''F'')','EFIDRES401Z0','11','D','20','33',NULL,'EMPLOYEE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EFIDRES401Z0','1','D','20','44',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDRES401Z0','2','D','20','45',NULL,'EMPLOYEE NUMBER STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDRES401Z0','12','D','20','47',NULL,'CLIENT PROVIDED ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EFIDRES401Z0','22','D','20','59',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','25','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','25','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','25','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','25','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','25','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"03"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','25','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P"','7','(''DA''=''F'')','EFIDRES401Z0','1','D','25','32',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDRESSLINENUMBER"','8','(''UA''=''F'')','EFIDRES401Z0','2','D','25','33',NULL,'ADDRESS LINE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDRESS"','9','(''UA''=''F'')','EFIDRES401Z0','32','D','25','35',NULL,'ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDRES401Z0','11','D','25','67',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDRES401Z0','1','D','25','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EFIDRES401Z0','1','D','25','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDRES401Z0','1','D','25','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','30','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','30','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','30','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','30','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','30','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"04"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','30','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P"','7','(''DA''=''F'')','EFIDRES401Z0','1','D','30','32',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCITY"','8','(''UA''=''F'')','EFIDRES401Z0','20','D','30','33',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTATE"','9','(''UA''=''F'')','EFIDRES401Z0','2','D','30','53',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDRES401Z0','8','D','30','55',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIPCODE"','11','(''UA''=''F'')','EFIDRES401Z0','5','D','30','63',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIP4CODE"','12','(''UA''=''F'')','EFIDRES401Z0','4','D','30','68',NULL,'ZIP + 4 CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDRES401Z0','6','D','30','72',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDRES401Z0','1','D','30','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDRES401Z0','1','D','30','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EFIDRES401Z0','1','D','30','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','35','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','35','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','35','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','35','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','35','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"05"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','35','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P"','7','(''DA''=''F'')','EFIDRES401Z0','1','D','35','32',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOUNTRY"','8','(''UA''=''F'')','EFIDRES401Z0','23','D','35','33',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EFIDRES401Z0','1','D','35','56',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','10','(''DA''=''F'')','EFIDRES401Z0','1','D','35','57',NULL,'SPECIAL HANDLING',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDRES401Z0','19','D','35','58',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMAILINGINDICATOR"','12','(''UA''=''F'')','EFIDRES401Z0','1','D','35','77',NULL,'MAILING INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDRES401Z0','1','D','35','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDRES401Z0','1','D','35','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDRES401Z0','1','D','35','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','40','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','40','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','40','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','40','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','40','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"06"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','40','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDIVISIONID"','7','(''UA''=''F'')','EFIDRES401Z0','20','D','40','32',NULL,'DIVISION ID (Name)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDRES401Z0','20','D','40','52',NULL,'REGION ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EFIDRES401Z0','3','D','40','72',NULL,'SITE SECURITY CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDRES401Z0','4','D','40','75',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDRES401Z0','2','D','40','79',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','43','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''F'')','EFIDRES401Z0','7','D','43','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','3','(''UA''=''F'')','EFIDRES401Z0','11','D','43','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EFIDRES401Z0','1','D','43','24',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','5','(''SS''=''F'')','EFIDRES401Z0','5','D','43','25',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"08"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','43','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','7','(''UA''=''F'')','EFIDRES401Z0','13','D','43','32',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryInd"','8','(''UA''=''F'')','EFIDRES401Z0','1','D','43','45',NULL,'SALARY INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EFIDRES401Z0','2','D','43','46',NULL,'SPACES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalPayDate"','10','(''UDMDY''=''F'')','EFIDRES401Z0','8','D','43','46',NULL,'SALARY PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDRES401Z0','8','D','43','46',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','45','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','45','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','45','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','45','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','45','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"11"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','45','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTATUSCODE"','7','(''UA''=''F'')','EFIDRES401Z0','1','D','45','32',NULL,'STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDRES401Z0','5','D','45','33',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusDate"','9','(''UDMDY''=''F'')','EFIDRES401Z0','8','D','45','38',NULL,'STATUS CHANGE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDRES401Z0','1','D','45','46',NULL,'LITERATURE KIT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDRES401Z0','32','D','45','47',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EFIDRES401Z0','1','D','45','79',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDRES401Z0','1','D','45','80',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','50','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','50','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','50','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','50','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','50','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"36"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','50','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','EFIDRES401Z0','4','D','50','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDIVISIONCODE"','8','(''UA''=''F'')','EFIDRES401Z0','4','D','50','36',NULL,'DIVISION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','EFIDRES401Z0','40','D','50','40',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDRES401Z0','1','D','50','80',NULL,'DIVISION CODE EXISTS INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','55','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','55','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','55','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','55','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','55','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"60"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','55','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTCLASS"','7','(''UA''=''F'')','EFIDRES401Z0','1','D','55','32',NULL,'PARTICIPANT CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTDISTRICT"','8','(''UA''=''F'')','EFIDRES401Z0','8','D','55','33',NULL,'PARTICIPANT DISTRICT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTDEPARTMENT"','9','(''UA''=''F'')','EFIDRES401Z0','8','D','55','41',NULL,'PARTICIPANT DEPARTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTLOCATIONSTORE"','10','(''UA''=''F'')','EFIDRES401Z0','8','D','55','49',NULL,'PARTICIPANT LOCATION/STORE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTUNIONCODE"','11','(''UA''=''F'')','EFIDRES401Z0','8','D','55','57',NULL,'PARTICIPANT UNION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPARTICIPANTPAYMENTFREQ"','12','(''UA''=''F'')','EFIDRES401Z0','1','D','55','65',NULL,'PARTICIPANT PAYMENT FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDRES401Z0','8','D','55','66',NULL,'MISCELLANEOUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDRES401Z0','1','D','55','74',NULL,'HIGHLY COMPENSATED FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDRES401Z0','1','D','55','75',NULL,'OFFICER / 16 (B) FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EFIDRES401Z0','1','D','55','76',NULL,'DE MINIMUS ELIGIBILITY INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','EFIDRES401Z0','1','D','55','77',NULL,'AGE PAYOUT ELIGIBILITY INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','EFIDRES401Z0','1','D','55','78',NULL,'PARTICIPANT RESTRICTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','EFIDRES401Z0','2','D','55','79',NULL,'PARTICIPANT RESTRICTION REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','60','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','60','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','60','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','60','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','6','D','60','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"61"','6','(''DA''=''F'')','EFIDRES401Z0','2','D','60','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligDate"','7','(''UDMDY''=''F'')','EFIDRES401Z0','8','D','60','32',NULL,'ELIGIBILITY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADJUSTEDDATEOFHIRE"','8','(''UDMDY''=''F'')','EFIDRES401Z0','8','D','60','40',NULL,'ADJUSTED DATE OF HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRETIREMENTDATE"','9','(''UDMDY''=''F'')','EFIDRES401Z0','8','D','60','48',NULL,'RETIREMENT DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDRES401Z0','5','D','60','56',NULL,' RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','EFIDRES401Z0','8','D','60','61',NULL,'BIS ACCRUAL START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EFIDRES401Z0','12','D','60','69',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','63','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','63','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','63','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','63','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','5','(''UA''=''F'')','EFIDRES401Z0','1','D','63','24',NULL,'EMPLOYEEID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','EFIDRES401Z0','5','D','63','25',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EA"','7','(''DA''=''F'')','EFIDRES401Z0','2','D','63','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','8','(''DA''=''F'')','EFIDRES401Z0','1','D','63','32',NULL,'E-MAIL ADDRESS STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ER"','9','(''DA''=''F'')','EFIDRES401Z0','2','D','63','33',NULL,'E-MAIL TYPE CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFIDRES401Z0','2','D','63','35',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailRecSeq"','11','(''UA''=''F'')','EFIDRES401Z0','1','D','63','37',NULL,'E-MAIL RECORD SEQUENCE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','12','(''UA''=''F'')','EFIDRES401Z0','35','D','63','38',NULL,'E-MAIL ADDRESS TEXT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDRES401Z0','1','D','63','73',NULL,'NON SAFE HARBOR INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDRES401Z0','1','D','63','74',NULL,'EDELIVERY CONSENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDRES401Z0','6','D','63','76',NULL,'EDELIVERY CONSENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','65','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','65','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','65','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','65','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','1','D','65','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','6','(''DA''=''F'')','EFIDRES401Z0','5','D','65','25',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"19"','7','(''DA''=''F'')','EFIDRES401Z0','2','D','65','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDRES401Z0','4','D','65','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"220"','9','(''DA''=''F'')','EFIDRES401Z0','3','D','65','36',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDRES401Z0','2','D','65','39',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOURCE"','11','(''UA''=''F'')','EFIDRES401Z0','2','D','65','41',NULL,'SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','12','(''DA''=''F'')','EFIDRES401Z0','2','D','65','43',NULL,'ITEM NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EFIDRES401Z0','1','D','65','45',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMOUNT"','14','(''UA''=''F'')','EFIDRES401Z0','13','D','65','46',NULL,'AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','EFIDRES401Z0','4','D','65','59',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EFIDRES401Z0','4','D','65','63',NULL,'FISCAL YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','EFIDRES401Z0','1','D','65','67',NULL,'ADJUSTMENT REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','EFIDRES401Z0','8','D','65','68',NULL,'ORIGINAL PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','EFIDRES401Z0','5','D','65','76',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDRES401Z0','5','D','70','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDRES401Z0','4','D','70','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDRES401Z0','3','D','70','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDRES401Z0','11','D','70','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDRES401Z0','1','D','70','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','6','(''DA''=''F'')','EFIDRES401Z0','5','D','70','25',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"21"','7','(''DA''=''F'')','EFIDRES401Z0','2','D','70','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','EFIDRES401Z0','4','D','70','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOANIDENTIFICATION"','9','(''UA''=''F'')','EFIDRES401Z0','12','D','70','36',NULL,'LOAN IDENTIFICATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EFIDRES401Z0','1','D','70','48',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"260"','11','(''DA''=''F'')','EFIDRES401Z0','3','D','70','49',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"14"','12','(''DA''=''F'')','EFIDRES401Z0','2','D','70','52',NULL,'ITEM NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','13','(''DA''=''F'')','EFIDRES401Z0','2','D','70','54',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EFIDRES401Z0','1','D','70','56',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREPAYMENTAMOUNT"','15','(''UA''=''F'')','EFIDRES401Z0','7','D','70','57',NULL,'REPAYMENT AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EFIDRES401Z0','1','D','70','64',NULL,'ADJUSTMENT REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','EFIDRES401Z0','8','D','70','65',NULL,'ORIGINAL PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','EFIDRES401Z0','1','D','70','73',NULL,'PRINCIPAL ONLY FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','EFIDRES401Z0','1','D','70','74',NULL,'NEW REPAYMENT FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''F'')','EFIDRES401Z0','6','D','70','75',NULL,'REGION',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW1\EW12\Downloads\V10\Exports\FTECH\EmployeeHistoryExport\FTECH_EFIDRES401_20200319',NULL,'','','',NULL,NULL,NULL,'Fidelity 401K Export','202002019','EMPEXPORT','ONDEMAND','Jun  5 2020 12:00AM','EFIDRES401',NULL,NULL,NULL,'202002019','Feb  1 2020 12:00AM','Dec 30 1899 12:00AM','201701011','387','','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW1\EW12\Downloads\V10\Exports\FTECH\EmployeeHistoryExport\FTECH_EFIDRES401_20200319.txt',NULL,'','','',NULL,NULL,NULL,'Fidelity 401K Export','202003241','EMPEXPORT','SCH_FID401','Jun  5 2020  4:44PM','EFIDRES401',NULL,NULL,NULL,'202003241','Mar 24 2020 12:00AM','Dec 30 1899 12:00AM','201701011','455','','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW1\EW12\Downloads\V10\Exports\FTECH\EmployeeHistoryExport\FTECH_EFIDRES401_20210115b.txt',NULL,'','','ZO75T,ZTWIP,ZTTTE,ZTW0F,HA9O6,LRNLI,ZTTMO',NULL,NULL,NULL,'Fidelity 401K Export','202101159','EMPEXPORT','TEST','Jan 26 2021  6:43PM','EFIDRES401',NULL,NULL,NULL,'202101159','Jan 15 2021 12:00AM','Dec 30 1899 12:00AM','202101151','2141','','','202101151',dbo.fn_GetTimedKey(),NULL,'us3rVaFRO1005',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDRES401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDRES401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDRES401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDRES401','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDRES401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDRES401','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDRES401','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_EFIDRES401_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_EFIDRES401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDRES401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFIDRES401','ONDEMAND','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFIDRES401','','D','50','Y','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D10','dbo.U_EFIDRES401_drvTbl_01','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D15','dbo.U_EFIDRES401_drvTbl_02D','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D20','dbo.U_EFIDRES401_drvTbl_02E','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D25','dbo.U_EFIDRES401_drvTbl_03','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D30','dbo.U_EFIDRES401_drvTbl_04','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D35','dbo.U_EFIDRES401_drvTbl_05','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D40','dbo.U_EFIDRES401_drvTbl_06','ISNULL(drvPLANNUMBER,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D43','dbo.U_EFIDRES401_drvTbl_08','ISNULL(drvPLANNUMBER,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D45','dbo.U_EFIDRES401_drvTbl_11','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D50','dbo.U_EFIDRES401_drvTbl_36','ISNULL(drvPLANNUMBER,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D55','dbo.U_EFIDRES401_drvTbl_60','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D60','dbo.U_EFIDRES401_drvTbl_61','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D63','dbo.U_EFIDRES401_drvTbl_EA','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D65','dbo.U_EFIDRES401_drvTbl_19Q','ISNULL(drvPLANNUMBER,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDRES401','D70','dbo.U_EFIDRES401_drvTbl_21','ISNULL(drvPLANNUMBER,'''') <> ''''');
IF OBJECT_ID('U_dsi_BDM_EFIDRES401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFIDRES401] (
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
IF OBJECT_ID('U_EFIDRES401_Audit') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_Audit] (
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
IF OBJECT_ID('U_EFIDRES401_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EFIDRES401_DedList') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_drvTbl_01') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_01] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
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
IF OBJECT_ID('U_EFIDRES401_drvTbl_02D') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_02D] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvHIREDATE] datetime NULL,
    [drvVestingDAte] datetime NULL,
    [drvDATEOFBIRTH] datetime NULL,
    [drvDateSwitch] varchar(1) NOT NULL,
    [drvTERMINATIONDATE] varchar(8000) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_drvTbl_02E') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_02E] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvEMPLOYEENUMBER] char(9) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_drvTbl_03') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_03] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvADDRESSLINENUMBER] varchar(2) NOT NULL,
    [drvADDRESS] varchar(255) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_drvTbl_04') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_04] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
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
IF OBJECT_ID('U_EFIDRES401_drvTbl_05') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_05] (
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
IF OBJECT_ID('U_EFIDRES401_drvTbl_06') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_06] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvDIVISIONID] varchar(21) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_drvTbl_08') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_08] (
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
IF OBJECT_ID('U_EFIDRES401_drvTbl_11') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_11] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvSTATUSCODE] varchar(1) NULL,
    [drvStatusDate] datetime NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_drvTbl_19Q') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_19Q] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvSOURCE] varchar(2) NULL,
    [drvAMOUNT] varchar(13) NULL,
    [drvEEID] char(12) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_drvTbl_21') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_21] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvLOANIDENTIFICATION] varchar(6) NULL,
    [drvREPAYMENTAMOUNT] varchar(30) NULL,
    [drvEEID] char(12) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_drvTbl_36') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_36] (
    [drvPLANNUMBER] varchar(1) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvDIVISIONCODE] char(10) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_drvTbl_60') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_60] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
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
IF OBJECT_ID('U_EFIDRES401_drvTbl_61') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_61] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvEligDate] varchar(9) NOT NULL,
    [drvADJUSTEDDATEOFHIRE] datetime NULL,
    [drvRETIREMENTDATE] datetime NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_drvTbl_EA') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_drvTbl_EA] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(3) NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvEmployeeId] varchar(1) NOT NULL,
    [drvEmailRecSeq] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_EEList') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFIDRES401_Employees') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_Employees] (
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
    [eecpaygroup] char(6) NULL
);
IF OBJECT_ID('U_EFIDRES401_File') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);
IF OBJECT_ID('U_EFIDRES401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(8) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL,
    [PlanNo] varchar(5) NOT NULL
);
IF OBJECT_ID('U_EFIDRES401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFIDRES401_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDRES401]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Frontline Technologies Group LLC

Created By: Marco Lagrosa
Business Analyst: Richard Vars
Create Date: 01/13/2021
Service Request Number: TekP-2020-12-01-0003

Purpose: Fidelity 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFIDRES401';

SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFIDRES401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFIDRES401';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = 'EFIDRES401'; -- Skip RecordSets by ExportCode
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EFIDRES401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFIDRES401' ORDER BY RunID DESC;
BEGIN TRAN
UPDATE  dbo.U_dsi_Configuration set cfgValue = null WHERE FormatCode = 'EFIDRES401' and cfgname = 'ExportPath';
COMMIT
UPDATE U_dsi_Configuration set cfgvalue = null where  FormatCode = 'EFIDRES401' and cfgname = 'ExportPath'
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDRES401', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDRES401', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFIDRES401', @AllObjects = 'Y'
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
    WHERE FormatCode = 'EFIDRES401';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFIDRES401_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_AuditFields;
    CREATE TABLE dbo.U_EFIDRES401_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('EmpPers','EepEmailAddress');

    INSERT INTO dbo.U_EFIDRES401_AuditFields VALUES ('OrgLevel','OrgDesc');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFIDRES401_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_Audit;
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
    INTO dbo.U_EFIDRES401_Audit
    FROM dbo.U_EFIDRES401_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EFIDRES401_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @EndDate -30 AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EFIDRES401_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFIDRES401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFIDRES401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -- Changes Only
    DELETE FROM dbo.U_EFIDRES401_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EFIDRES401_Audit WHERE audEEID = xEEID);
    

    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = '401CF,401CP,401F,401P,401CU,401RC,401RF,401RP,401M';


    IF OBJECT_ID('U_EFIDRES401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EFIDRES401_DedList
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
    IF OBJECT_ID('U_EFIDRES401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhSource = CASE WHEN PdhDedCode IN ('401CF','401CP','401F','401P') THEN 'EEPRETAX' --401K
                          WHEN PdhDedCode IN ('401RC','401RC','401RF','401RP') THEN 'ROTH' --ROTH
                          WHEN PdhDedCode IN ('401M') THEN 'MATCH' --ROTH
                          WHEN PdhDedCode IN ('401L', '401L2') THEN 'LOAN 1' --401K LOAN
                     END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)
        ,PlanNo =  '99431'
    INTO dbo.U_EFIDRES401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND 
    PdhDedCode IN ('401CF','401CP','401F','401P','401RC','401RC','401RF','401RP','401M','401L', '401L2')
    GROUP BY PdhEEID
        ,CASE WHEN PdhDedCode IN ('401CF','401CP','401F','401P') THEN 'EEPRETAX' --401K
                          WHEN PdhDedCode IN ('401RC','401RC','401RF','401RP') THEN 'ROTH' --ROTH
                          WHEN PdhDedCode IN ('401M') THEN 'MATCH' --ROTH
                          WHEN PdhDedCode IN ('401L', '401L2') THEN 'LOAN 1' --401K LOAN
                     END
    HAVING (SUM(PdhEECurAmt) <> 0.00 or SUM(PdhERCurAmt) <> 0.00);

    -------------------------------
    -- Working Table - Employees
    -------------------------------
    IF OBJECT_ID('U_EFIDRES401_Employees','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_Employees;
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
    INTO dbo.U_EFIDRES401_Employees
    FROM dbo.U_EFIDRES401_EEList
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

        FROM dbo.U_EFIDRES401_Audit
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID;

      Delete from U_EFIDRES401_Employees where eecpaygroup not in (    'DIGSCL','EDHLTH' ,'EDHLTS' ,'ESCAPE' ,'HOURLY' ,'SFTANH' ,'SFTANS' ,'SFTANH','SALARY')
      Delete from U_EFIDRES401_Employees where eepSSN in ('99999999','123456789','88888888')

        IF OBJECT_ID('U_EFIDRES401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_PEarHist;
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
    INTO dbo.U_EFIDRES401_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_01
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_01;
    SELECT DISTINCT
        drvPLANNUMBER = '99431'
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
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
    INTO dbo.U_EFIDRES401_drvTbl_01
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE Record01Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';


    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_02D
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_02D','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_02D;
    SELECT DISTINCT
        drvPLANNUMBER = '99431'
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvHIREDATE = EecDateOfOriginalHire
        ,drvVestingDAte = EecDateOfSeniority
        ,drvDATEOFBIRTH = EepDateOfBirth
        ,drvDateSwitch = CASE WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN '5' ELSE '' END
        ,drvTERMINATIONDATE = CASE WHEN EecEmplStatus = 'T' THEN replace(convert(char(10), EecDateOfTermination, 101), '/', '')  ELSE '00000000' END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02D'
    INTO dbo.U_EFIDRES401_drvTbl_02D
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE Record02DChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y' or audTerm = 'Y' ;

    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_02E
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_02E','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_02E;
    SELECT DISTINCT
        drvPLANNUMBER = '99431'
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEMPLOYEENUMBER = EecEmpNo
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02E'
    INTO dbo.U_EFIDRES401_drvTbl_02E
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE Record02EChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_03
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_03','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_03;
    SELECT DISTINCT
        drvPLANNUMBER = '99431'
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvADDRESSLINENUMBER = LineNumber
        ,drvADDRESS = EepAddress
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '03'
    INTO dbo.U_EFIDRES401_drvTbl_03
    FROM (
        -- Address Line 1
        SELECT xEEID, xCOID, EepSSN, EepAddressLine1 AS EepAddress, '01' AS LineNumber, Record03Change, audNewHire,audReHire,eecpaygroup FROM dbo.U_EFIDRES401_Employees

        UNION ALL

        -- Address Line 2
        SELECT xEEID, xCOID, EepSSN, EepAddressLine2 AS EepAddress, '02' AS LineNumber, Record03Change, audNewHire,audReHire,eecpaygroup FROM dbo.U_EFIDRES401_Employees

        UNION ALL

        -- Address Line 3
        SELECT xEEID, xCOID, EepSSN, EepAddressLine3 AS EepAddress, '03' AS LineNumber, Record03Change, audNewHire,audReHire,eecpaygroup  FROM dbo.U_EFIDRES401_Employees
    ) Employee
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


    --Delete from U_EFIDRES401_drvTbl_03 where isnull(drvAddress,'') = '';
     

    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_04
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_04','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_04;
    SELECT DISTINCT
        drvPLANNUMBER = '99431'
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvCITY = EepAddressCity
        ,drvSTATE = EepAddressState
        ,drvZIPCODE = LEFT(EepAddressZipCode,5)
        ,drvZIP4CODE = SUBSTRING(EepAddressZipCode,6,4)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '04'
    INTO dbo.U_EFIDRES401_drvTbl_04
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE Record04Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_05
    ---------------------------------
    
    IF OBJECT_ID('U_EFIDRES401_drvTbl_05','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_05;
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
    INTO dbo.U_EFIDRES401_drvTbl_05
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE EepAddressCountry NOT IN ('US','USA')
    AND Record05Change = 'Y';
    
    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_06
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_06','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_06;
    SELECT DISTINCT
        drvPLANNUMBER = '99431'
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONID = Concat(EecOrgLvl1,'-',EecOrgLvl2)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '06'
    INTO dbo.U_EFIDRES401_drvTbl_06
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE Record06Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';


  ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_08
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_08','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_08;
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
    INTO dbo.U_EFIDRES401_drvTbl_08
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    LEFT JOIN dbo.U_EFIDRES401_PEarHist WITH (NOLOCK)
    ON PehEEID = xEEID
    WHERE   audNewHire = 'Y' or  audReHire = 'Y';


    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_11
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_11','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_11;
    SELECT DISTINCT
        drvPLANNUMBER = '99431'
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSTATUSCODE = CASE --WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN 'D'
                              WHEN EecEmplStatus = 'A' AND (select top 1 EshEmplStatus from EmpHStat where esheeid = xeeid order by eshdatetimechanged desc) = 'L' THEN 'A'
                              WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN 'E'
                              WHEN EecEmplStatus = 'L' THEN 'L'
                              WHEN EecEmplStatus = 'T' and EecTermReason not in ('202','203') THEN 'T'
                              WHEN EecEmplStatus = 'T' and EecTermReason IN ('202') THEN 'R'
                              WHEN audNewHire = 'Y' THEN 'N'
                              WHEN audReHire = 'Y' THEN 'E'
                               WHEN  EecEmplStatus = 'L' and EecLeaveReason = '300' THEN 'W'
                         END
        ,drvStatusDate = CASE --WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN 'D'
                              WHEN EecEmplStatus = 'A' AND (select top 1 EshEmplStatus from EmpHStat where esheeid = xeeid order by eshdatetimechanged desc) = 'L' THEN (select top 1 EshStatusStopDate from EmpHStat where esheeid = xeeid order by eshdatetimechanged desc)
                              WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN EecDateOfLastHire
                              WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                              WHEN EecEmplStatus = 'T' and EecTermReason not in ('202','203') THEN eecdateoftermination
                              WHEN EecEmplStatus = 'T' and EecTermReason IN ('202') THEN eecdateoftermination
                              WHEN audNewHire = 'Y' THEN EecDateOfOriginalHire
                              WHEN audReHire = 'Y' THEN EecDateOfLastHire
                              WHEN  EecEmplStatus = 'L' and EecLeaveReason = '300' THEN EecEmplStatusStartDate
                         END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '11'
    INTO dbo.U_EFIDRES401_drvTbl_11
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE Record11Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';

  
    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_36
    ---------------------------------
    
    IF OBJECT_ID('U_EFIDRES401_drvTbl_36','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_36;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONCODE = EecOrglvl2
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '36'
    INTO dbo.U_EFIDRES401_drvTbl_36
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE Record36Change = 'Y';
    
    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_60
    ---------------------------------
    
    IF OBJECT_ID('U_EFIDRES401_drvTbl_60','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_60;
    SELECT DISTINCT
        drvPLANNUMBER = '99431'
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
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
    INTO dbo.U_EFIDRES401_drvTbl_60
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE Record60Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y';


    
    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_61
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_61','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_61;
    SELECT DISTINCT
        drvPLANNUMBER = '99431'
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEligDate = '000000000'
        ,drvADJUSTEDDATEOFHIRE = CASE WHEN EecDateOfOriginalHire  <> EecDateOfLastHire THEN EecDateOfLastHire  ELSE NULL END
        ,drvRETIREMENTDATE = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '202' THEN  eecdateoftermination  END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '61'
    INTO dbo.U_EFIDRES401_drvTbl_61
    FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE audReHire = 'Y';




    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_EA
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_EA','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_EA;
    SELECT DISTINCT
        drvPLANNUMBER = '99431'
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEmployeeId = ''
        ,drvEmailRecSeq = LineNumber
        ,drvEmailAddress = EepAddressEmail
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = 'EA'
    INTO dbo.U_EFIDRES401_drvTbl_EA
    FROM ( -- Email 1
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 1, 35) AS EepAddressEmail, '1' AS LineNumber, emailAddress, audNewHire,audReHire,eecpaygroup FROM dbo.U_EFIDRES401_Employees
        UNION ALL
        -- Email 2
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 36, 70)  EepAddressEmail, '2' AS LineNumber, emailAddress, audNewHire,audReHire, eecpaygroup FROM dbo.U_EFIDRES401_Employees
        UNION ALL
        -- Email 3
        SELECT xEEID, xCOID, EepSSN, SUBSTRING(EepAddressEmail, 71, 88)  AS EepAddressEmail, '3' AS LineNumber, emailAddress, audNewHire,audReHire, eecpaygroup  FROM dbo.U_EFIDRES401_Employees
        )
        Employee
    WHERE emailAddress = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';

    Delete from U_EFIDRES401_drvTbl_EA where drvemailaddress is null or drvemailaddress = '';

    ---------------------------------
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_19Q
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_19Q','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_19Q;
    SELECT DISTINCT
        drvPLANNUMBER = PlanNo
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
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
    INTO dbo.U_EFIDRES401_drvTbl_19Q
    FROM dbo.U_EFIDRES401_PDedHist WITH (NOLOCK)
    LEFT JOIN  (SELECT xEEID,xCOID,eecpaygroup  FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)
    WHERE   audNewHire = 'Y' or  audReHire = 'Y') HIRE_REHIRE
    on HIRE_REHIRE.xEEID = PdhEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    WHERE PdhSource not in  ('LOAN 1','LOAN 2')

    UPDATE U_EFIDRES401_drvTbl_19Q set drvAmount = CONVERT(VARCHAR,dbo.dsi_fnPadZero( (cast (drvAmount as money)) *100,13,0)) 
        
    Update U_EFIDRES401_drvTbl_19Q set drvAmount  =   CONCAT(LEFT(REPLACE(drvAmount,'.',''),(LEN( REPLACE(drvAmount,'.','')) -1)),CASE WHEN RIGHT(drvAmount,1) = '1' THEN 'A'
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
    -- DETAIL RECORD - U_EFIDRES401_drvTbl_21
    ---------------------------------
    IF OBJECT_ID('U_EFIDRES401_drvTbl_21','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDRES401_drvTbl_21;
    SELECT DISTINCT
        drvPLANNUMBER = PlanNo
        ,drvBATCHGROUPID = CASE 
        WHEN eecpaygroup = 'DIGSCL' THEN 'DS'
        WHEN eecpaygroup = 'EDHLTH' THEN 'EHH'
        WHEN eecpaygroup = 'EDHLTS' THEN 'EHS'
        WHEN eecpaygroup = 'ESCAPE' THEN 'ES'
        WHEN eecpaygroup = 'HOURLY' THEN 'HBW'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANS' THEN 'SAH'
        WHEN eecpaygroup = 'SFTANH' THEN 'SAS'
        WHEN eecpaygroup = 'SALARY' THEN 'SBW'
       END
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLOANIDENTIFICATION = CASE WHEN PdhSource in ('LOAN 1') THEN 'LOAN 1' END 
                                   
        ,drvREPAYMENTAMOUNT = CONVERT(VARCHAR,PdhEECurAmt)
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '21'
    INTO dbo.U_EFIDRES401_drvTbl_21
    FROM dbo.U_EFIDRES401_PDedHist WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    LEFT JOIN (SELECT xEEID,xCOID,eecpaygroup  FROM dbo.U_EFIDRES401_Employees WITH (NOLOCK)) as Emp
    on xeeid =  pdheeid
    WHERE PdhSource  in  ('LOAN 1','LOAN 2') ;

     Update dbo.U_EFIDRES401_drvTbl_21 set drvREPAYMENTAMOUNT  = CONVERT(VARCHAR,dbo.dsi_fnPadZero( (cast (drvREPAYMENTAMOUNT as money)) *100,7,0)) 

        Update dbo.U_EFIDRES401_drvTbl_21 set drvREPAYMENTAMOUNT  =  CONCAT(LEFT(REPLACE(drvREPAYMENTAMOUNT,'.',''),(LEN( REPLACE(drvREPAYMENTAMOUNT,'.','')) -1)),CASE WHEN RIGHT(drvREPAYMENTAMOUNT,1) = '1' THEN 'A'
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
    
    Delete from U_EFIDRES401_drvTbl_19Q where drvBatchGroupId is null
    Delete from U_EFIDRES401_drvTbl_21 where drvBatchGroupId is null


    
    Delete from dbo.U_EFIDRES401_drvTbl_60 where drveeid not in (Select distinct drveeid from dbo.U_EFIDRES401_drvTbl_01)


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EFIDRES401','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('EFIDRES401','Testing') = 'Y' THEN 'TEST_CSP_EFIDRES401_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'CSP_EFIDRES401_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = 'EFIDRES401';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFIDRES401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDRES401_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFIDRES401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201702011'
       ,ExpStartPerControl     = '201702011'
       ,ExpLastEndPerControl   = '201702019'
       ,ExpEndPerControl       = '201702019'
WHERE ExpFormatCode = 'EFIDRES401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFIDRES401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDRES401_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;