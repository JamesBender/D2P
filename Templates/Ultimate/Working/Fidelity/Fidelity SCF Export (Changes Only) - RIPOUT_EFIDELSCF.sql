/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@CustomFormatCode - Replace with Format Code (i.e., EFIDELSCF)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Fidelity SCF Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Imports\[Vendor]\Reports\)
@FileImportPath - Replace with the Import Path where the Vendor Import File is located (i.e., \\us.saas\e1\Public\[Client ARNum]\Imports\[Vendor]\)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_T07A') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_TrlTbl_T07A];
GO
IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_T06AtoJ') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_TrlTbl_T06AtoJ];
GO
IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_T01C') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_TrlTbl_T01C];
GO
IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_T01B') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_TrlTbl_T01B];
GO
IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_T01A') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_TrlTbl_T01A];
GO
IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_BT3A') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_TrlTbl_BT3A];
GO
IF OBJECT_ID('U_@CustomFormatCode_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PDedHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_HdrTbl_THR') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_HdrTbl_THR];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_Employees') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Employees];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_EA') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_EA];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_CA') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_CA];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_BG') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_BG];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_61') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_61];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_60') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_60];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_3K') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_3K];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_21') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_21];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_08') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_08];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_06') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_06];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_05') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_05];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_04') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_04];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_03') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_03];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_02E') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_02E];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_02D') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_02D];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_01') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_01];
GO
IF OBJECT_ID('U_@CustomFormatCode_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_AuditFields];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(30);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','SDF','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','80','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TESTEDT"','1','(''DA''=''F'')',@AdhSystemID,'7','H','01','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'73','H','01','8',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','H','02','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"THR"','2','(''DA''=''F'')',@AdhSystemID,'4','H','02','6',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','H','02','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTYPEOFACCOUNT"','4','(''UA''=''F'')',@AdhSystemID,'11','H','02','13',NULL,'TYPE OF ACCOUNT (I.E. 401K)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','H','02','24',NULL,'RESERVED (FIDELITY USE ONLY)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCLIENTNAME"','6','(''UA''=''F'')',@AdhSystemID,'2','H','02','30',NULL,'CLIENT NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Y"','7','(''DA''=''F'')',@AdhSystemID,'20','H','02','32',NULL,'CHANGES ONLY FILE INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'15','H','02','52',NULL,'RESERVED (FIDELITY USE ONLY)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'9','H','02','67',NULL,'RESERVED (FIDELITY USE ONLY)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'1','H','02','76',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','10','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','10','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','10','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','10','24',NULL,'EMPLOYEE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'5','D','10','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"01"','7','(''DA''=''F'')',@AdhSystemID,'2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLASTNAME"','8','(''UA''=''F'')',@AdhSystemID,'20','D','10','32',NULL,'LAST NAME (FREE FORM)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFIRSTNAMEMIDDLEINITIAL"','9','(''UA''=''F'')',@AdhSystemID,'15','D','10','52',NULL,'FIRST NAME MIDDLE INITIAL (FREE FORM)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"000000000"','10','(''DA''=''F'')',@AdhSystemID,'9','D','10','67',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMARITALSTATUS"','11','(''UA''=''F'')',@AdhSystemID,'1','D','10','76',NULL,'MARITAL STATUS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGENDER"','12','(''UA''=''F'')',@AdhSystemID,'1','D','10','77',NULL,'GENDER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'1','D','10','78',NULL,'SPECIAL TAX TYPE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','10','79',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'1','D','10','80',NULL,'BENE/QDRO PAYEE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','15','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','15','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','15','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','15','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','15','24',NULL,'EMPLOYEE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'5','D','15','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"02"','7','(''DA''=''F'')',@AdhSystemID,'2','D','15','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"D"','8','(''DA''=''F'')',@AdhSystemID,'1','D','15','32',NULL,'FIELD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'4','D','15','33',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHIREDATE"','10','(''UDMDY''=''F'')',@AdhSystemID,'8','D','15','37',NULL,'HIRE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000000"','11','(''DA''=''F'')',@AdhSystemID,'8','D','15','45',NULL,'PARTICIPATION DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000000"','12','(''DA''=''F'')',@AdhSystemID,'8','D','15','53',NULL,'VESTING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDATEOFBIRTH"','13','(''UDMDY''=''F'')',@AdhSystemID,'8','D','15','61',NULL,'DATE-OF-BIRTH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTERMINATIONDATE"','14','(''UDMDY''=''F'')',@AdhSystemID,'8','D','15','69',NULL,'TERMINATION DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'1','D','15','77',NULL,'DATE SWITCH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','15','78',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','17','(''SS''=''F'')',@AdhSystemID,'1','D','15','79',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'1','D','15','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','16','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','16','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','16','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','16','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','16','24',NULL,'EMPLOYEE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'5','D','16','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"02"','7','(''DA''=''F'')',@AdhSystemID,'2','D','16','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"E"','8','(''DA''=''F'')',@AdhSystemID,'1','D','16','32',NULL,'FIELD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEMPLOYEENUMBER"','9','(''UA''=''F'')',@AdhSystemID,'11','D','16','33',NULL,'EMPLOYEE NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'1','D','16','44',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'2','D','16','45',NULL,'EMPLOYEE NUMBER STATUS CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'12','D','16','47',NULL,'CLIENT PROVIDED ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'22','D','16','59',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','20','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','20','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','20','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','20','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','20','24',NULL,'EMPLOYEE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'5','D','20','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"03"','7','(''DA''=''F'')',@AdhSystemID,'2','D','20','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"P"','8','(''DA''=''F'')',@AdhSystemID,'1','D','20','32',NULL,'RECORD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADDRESSLINENUMBER"','9','(''UA''=''F'')',@AdhSystemID,'2','D','20','33',NULL,'ADDRESS LINE NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADDRESS"','10','(''UA''=''F'')',@AdhSystemID,'32','D','20','35',NULL,'ADDRESS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'10','D','20','67',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Y"','12','(''DA''=''F'')',@AdhSystemID,'1','D','20','77',NULL,'MAILING INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'1','D','20','78',NULL,'ADDRESS CHANGE SOURCE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','20','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'1','D','20','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','21','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','21','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','21','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','21','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','21','24',NULL,'EMPLOYEE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'5','D','21','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"04"','7','(''DA''=''F'')',@AdhSystemID,'2','D','21','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"P"','8','(''DA''=''F'')',@AdhSystemID,'1','D','21','32',NULL,'RECORD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCITY"','9','(''UA''=''F'')',@AdhSystemID,'20','D','21','33',NULL,'CITY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTATE"','10','(''UA''=''F'')',@AdhSystemID,'2','D','21','53',NULL,'STATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'8','D','21','55',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZIPCODE"','12','(''UA''=''F'')',@AdhSystemID,'5','D','21','63',NULL,'ZIP CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZIP4CODE"','13','(''UA''=''F'')',@AdhSystemID,'4','D','21','68',NULL,'ZIP + 4 CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'5','D','21','72',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Y"','15','(''DA''=''F'')',@AdhSystemID,'1','D','21','77',NULL,'MAILING INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','21','78',NULL,'ADDRESS CHANGE SOURCE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','17','(''SS''=''F'')',@AdhSystemID,'1','D','21','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'1','D','21','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','22','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','22','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','22','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','22','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','22','24',NULL,'EMPLOYEE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'5','D','22','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"05"','7','(''DA''=''F'')',@AdhSystemID,'2','D','22','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"P"','8','(''DA''=''F'')',@AdhSystemID,'1','D','22','32',NULL,'RECORD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCOUNTRY"','9','(''UA''=''F'')',@AdhSystemID,'23','D','22','33',NULL,'COUNTRY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'1','D','22','56',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Y"','11','(''DA''=''F'')',@AdhSystemID,'1','D','22','57',NULL,'SPECIAL HANDLING',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'19','D','22','58',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Y"','13','(''DA''=''F'')',@AdhSystemID,'1','D','22','77',NULL,'MAILING INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','22','78',NULL,'ADDRESS CHANGE SOURCE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'1','D','22','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','22','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','23','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','23','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','23','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','23','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','23','24',NULL,'EMPLOYEE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'5','D','23','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"06"','7','(''DA''=''F'')',@AdhSystemID,'2','D','23','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDIVISIONID"','8','(''UA''=''F'')',@AdhSystemID,'20','D','23','32',NULL,'DIVISION ID (Name)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvREGIONID"','9','(''UA''=''F'')',@AdhSystemID,'20','D','23','52',NULL,'REGION ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'3','D','23','72',NULL,'SITE SECURITY CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'6','D','23','75',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','25','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'7','D','25','6',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','3','(''UA''=''F'')',@AdhSystemID,'11','D','25','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','4','(''SS''=''F'')',@AdhSystemID,'1','D','25','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000"','5','(''DA''=''F'')',@AdhSystemID,'5','D','25','25',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"08"','6','(''DA''=''F'')',@AdhSystemID,'2','D','25','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSALARY"','7','(''UA''=''F'')',@AdhSystemID,'13','D','25','32',NULL,'SALARY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSALARYADDREPLACEINDICATOR"','8','(''UA''=''F'')',@AdhSystemID,'1','D','25','45',NULL,'SALARY ADD/REPLACE INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'2','D','25','46',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSALARYPAYDATE"','10','(''UDMDY''=''F'')',@AdhSystemID,'8','D','25','48',NULL,'SALARY PAY DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'25','D','25','56',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','30','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','30','6',NULL,'BATCH GROUP NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','3','(''UA''=''F'')',@AdhSystemID,'3','D','30','10',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','4','(''SS''=''F'')',@AdhSystemID,'11','D','30','13',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000"','5','(''DA''=''F'')',@AdhSystemID,'6','D','30','24',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"3K"','6','(''DA''=''F'')',@AdhSystemID,'2','D','30','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFISCALYEAR"','7','(''UA''=''F'')',@AdhSystemID,'1','D','30','32',NULL,'FISCAL YEAR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"220"','8','(''DA''=''F'')',@AdhSystemID,'5','D','30','33',NULL,'TRANSACTION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'8','D','30','38',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOURCE"','10','(''UA''=''F'')',@AdhSystemID,'1','D','30','46',NULL,'SOURCE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"01"','11','(''DA''=''F'')',@AdhSystemID,'32','D','30','47',NULL,'ITEM NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'1','D','30','79',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAMOUNT"','13','(''UNPY''=''F'')',@AdhSystemID,'1','D','30','80',NULL,'AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADJUSTMENTREASON"','14','(''UA''=''F'')',@AdhSystemID,'1','D','30','81',NULL,'ADJUSTMENT REASON',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvORIGINALPAYDATE"','15','(''UDMDY''=''F'')',@AdhSystemID,'1','D','30','82',NULL,'ORIGINAL PAY DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEMPLOYEESALARY"','16','(''UNPY''=''F'')',@AdhSystemID,'1','D','30','83',NULL,'EMPLOYEE SALARY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"000"','17','(''DA''=''F'')',@AdhSystemID,'1','D','30','84',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','35','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','35','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','35','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','35','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','35','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000"','6','(''DA''=''F'')',@AdhSystemID,'5','D','35','25',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"21"','7','(''DA''=''F'')',@AdhSystemID,'2','D','35','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'4','D','35','32',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLOANIDENTIFICATION"','9','(''UA''=''F'')',@AdhSystemID,'12','D','35','36',NULL,'LOAN IDENTIFICATION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'1','D','35','48',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"260"','11','(''DA''=''F'')',@AdhSystemID,'3','D','35','49',NULL,'TRANSACTION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"14"','12','(''DA''=''F'')',@AdhSystemID,'2','D','35','52',NULL,'ITEM NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00"','13','(''DA''=''F'')',@AdhSystemID,'2','D','35','54',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','35','56',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRINCIPALAMOUNT"','15','(''UNPY''=''F'')',@AdhSystemID,'7','D','35','57',NULL,'PRINCIPAL AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','35','64',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"0000000"','17','(''DA''=''F'')',@AdhSystemID,'7','D','35','65',NULL,'INTEREST AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'1','D','35','72',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','19','(''SS''=''F'')',@AdhSystemID,'1','D','35','73',NULL,'PRINCIPAL ONLY FLAG',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','20','(''SS''=''F'')',@AdhSystemID,'1','D','35','74',NULL,'NEW REPAYMENT FRQUENCY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','21','(''SS''=''F'')',@AdhSystemID,'6','D','35','75',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','40','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','40','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','40','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','40','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','40','24',NULL,'EMPLOYEE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'5','D','40','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"60"','7','(''DA''=''F'')',@AdhSystemID,'2','D','40','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTCLASS"','8','(''UA''=''F'')',@AdhSystemID,'1','D','40','32',NULL,'PARTICIPANT CLASS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTDISTRICT"','9','(''UA''=''F'')',@AdhSystemID,'8','D','40','33',NULL,'PARTICIPANT DISTRICT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTDEPARTMENT"','10','(''UA''=''F'')',@AdhSystemID,'8','D','40','41',NULL,'PARTICIPANT DEPARTMENT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTLOCATIONSTORE"','11','(''UA''=''F'')',@AdhSystemID,'8','D','40','49',NULL,'PARTICIPANT LOCATION/STORE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTUNIONCODE"','12','(''UA''=''F'')',@AdhSystemID,'8','D','40','57',NULL,'PARTICIPANT UNION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTPAYMENTFREQ"','13','(''UA''=''F'')',@AdhSystemID,'1','D','40','65',NULL,'PARTICIPANT PAYMENT FREQUENCY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'8','D','40','66',NULL,'MISCELLANEOUS CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'1','D','40','74',NULL,'HIGHLY COMPENSATED FLAG',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','40','75',NULL,'OFFICER / 16 (B) FLAG',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','17','(''SS''=''F'')',@AdhSystemID,'1','D','40','76',NULL,'DE MINIMUS ELIGIBILITY INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'1','D','40','77',NULL,'AGE PAYOUT ELIGIBILITY INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','19','(''SS''=''F'')',@AdhSystemID,'1','D','40','78',NULL,'PARTICIPANT RESTRICTION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','20','(''SS''=''F'')',@AdhSystemID,'2','D','40','79',NULL,'PARTICIPANT RESTRICTION REASON',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','41','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','41','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','41','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','41','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','41','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"61"','6','(''DA''=''F'')',@AdhSystemID,'2','D','41','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvELIGIBILITYDATE"','7','(''UDMDY''=''F'')',@AdhSystemID,'8','D','41','32',NULL,'ELIGIBILITY DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADJUSTEDDATEOFHIRE"','8','(''UDMDY''=''F'')',@AdhSystemID,'8','D','41','40',NULL,'ADJUSTED DATE OF HIRE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRETIREMENTDATE"','9','(''UDMDY''=''F'')',@AdhSystemID,'8','D','41','48',NULL,'RETIREMENT DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000"','10','(''DA''=''F'')',@AdhSystemID,'5','D','41','56',NULL,'PRE-BREAK SERVICE UNITS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000000"','11','(''DA''=''F'')',@AdhSystemID,'8','D','41','61',NULL,'BIS ACCRUAL START DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'8','D','41','69',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'1','D','41','77',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'3','D','41','78',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','50','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','50','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','50','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','50','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','50','24',NULL,'EMPLOYEE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'5','D','50','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BG"','7','(''DA''=''F'')',@AdhSystemID,'2','D','50','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"01"','8','(''DA''=''F'')',@AdhSystemID,'2','D','50','32',NULL,'EVENT SEQUENCE NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEVENTEFFECTIVEDATE"','9','(''UDMDY''=''F'')',@AdhSystemID,'8','D','50','34',NULL,'EVENT EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEVENTCODE"','10','(''UA''=''F'')',@AdhSystemID,'3','D','50','42',NULL,'EVENT CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'3','D','50','45',NULL,'EVENT REASON CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'32','D','50','48',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'1','D','50','80',NULL,'RESERVED FOR FIDELITY INTERNAL USE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','55','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'7','D','55','6',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','3','(''UA''=''F'')',@AdhSystemID,'11','D','55','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','4','(''SS''=''F'')',@AdhSystemID,'6','D','55','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CA"','5','(''DA''=''F'')',@AdhSystemID,'2','D','55','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BASE"','6','(''DA''=''F'')',@AdhSystemID,'5','D','55','32',NULL,'COMPENSATION AMOUNT TYPE CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCOMPENSATIONAMOUNTEFFDATE"','7','(''UDMDY''=''F'')',@AdhSystemID,'8','D','55','37',NULL,'COMPENSATION AMOUNT EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCOMPENSATIONAMOUNT"','8','(''UNPY''=''F'')',@AdhSystemID,'17','D','55','45',NULL,'COMPENSATION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"001"','9','(''DA''=''F'')',@AdhSystemID,'3','D','55','62',NULL,'COMPENSATION FREQUENCY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'16','D','55','65',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','60','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','60','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','60','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','60','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','60','24',NULL,'EMPLOYEE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'5','D','60','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EA"','7','(''DA''=''F'')',@AdhSystemID,'2','D','60','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEMAILADDRESSSTATUSCODE"','8','(''UA''=''F'')',@AdhSystemID,'1','D','60','32',NULL,'E-MAIL ADDRESS STATUS CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ER"','9','(''DA''=''F'')',@AdhSystemID,'2','D','60','33',NULL,'E-MAIL TYPE CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'2','D','60','35',NULL,'RESERVED FOR FUTURE USE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEMAILRECORDSEQUENCENBR"','11','(''UA''=''F'')',@AdhSystemID,'1','D','60','37',NULL,'E-MAIL RECORD SEQUENCE NBR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEMAILADDRESSTEXT"','12','(''UA''=''F'')',@AdhSystemID,'35','D','60','38',NULL,'E-MAIL ADDRESS TEXT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'1','D','60','73',NULL,'NON  SAFE HARBOR INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'7','D','60','74',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','1','(''SS''=''F'')',@AdhSystemID,'5','T','90','1',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BT3A"','2','(''DA''=''F'')',@AdhSystemID,'4','T','90','6',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDATEOFTRANSMISSION"','3','(''UDMDY''=''F'')',@AdhSystemID,'8','T','90','10',NULL,'DATE OF TRANSMISSION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALDBDEMOGRAPHICRECORDS"','4','(''UN00''=''F'')',@AdhSystemID,'7','T','90','18',NULL,'TOTAL DB DEMOGRAPHIC RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'56','T','90','25',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','T','91','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"T01A"','2','(''DA''=''F'')',@AdhSystemID,'4','T','91','6',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDATEOFTRANSMISSION"','3','(''UDMDY''=''F'')',@AdhSystemID,'8','T','91','10',NULL,'DATE OF TRANSMISSION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALCONTRIBUTIONAMOUNT"','4','(''UNPY''=''F'')',@AdhSystemID,'14','T','91','18',NULL,'TOTAL CONTRIBUTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALCONTRIBUTIONRECORDS"','5','(''UN00''=''F'')',@AdhSystemID,'9','T','91','32',NULL,'TOTAL CONTRIBUTION RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALPARTICIPANTRECORDS"','6','(''UN00''=''F'')',@AdhSystemID,'9','T','91','41',NULL,'TOTAL PARTICIPANT RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''F'')',@AdhSystemID,'31','T','91','50',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','T','92','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"T01B"','2','(''DA''=''F'')',@AdhSystemID,'4','T','92','6',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDATEOFTRANSMISSION"','3','(''UDMDY''=''F'')',@AdhSystemID,'8','T','92','10',NULL,'DATE OF TRANSMISSION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALFUNDELECTIONRECORDS"','4','(''UN00''=''F'')',@AdhSystemID,'9','T','92','18',NULL,'TOTAL FUND ELECTION RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALLOANREPAYRECORDS"','5','(''UN00''=''F'')',@AdhSystemID,'9','T','92','27',NULL,'TOTAL LOAN REPAY RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALLOANREPAYAMOUNT"','6','(''UNPY''=''F'')',@AdhSystemID,'14','T','92','36',NULL,'TOTAL LOAN REPAY AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''F'')',@AdhSystemID,'31','T','92','50',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','T','93','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"T01C"','2','(''DA''=''F'')',@AdhSystemID,'4','T','93','6',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDATEOFTRANSMISSION"','3','(''UDMDY''=''F'')',@AdhSystemID,'8','T','93','10',NULL,'DATE OF TRANSMISSION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALSALARYAMOUNT"','4','(''UNPY''=''F'')',@AdhSystemID,'14','T','93','18',NULL,'TOTAL SALARY AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALSALARYRECORDS"','5','(''UN00''=''F'')',@AdhSystemID,'9','T','93','32',NULL,'TOTAL SALARY RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'40','T','93','41',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','T','94','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRECORDIDENTIFIER"','2','(''UA''=''F'')',@AdhSystemID,'4','T','94','6',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALSOURCE1AMOUNT"','3','(''UNPY''=''F'')',@AdhSystemID,'11','T','94','10',NULL,'TOTAL SOURCE 1 AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOURCE1RECORDCOUNT"','4','(''UN00''=''F'')',@AdhSystemID,'7','T','94','21',NULL,'SOURCE 1 RECORD COUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALSOURCE2AMOUNT"','5','(''UNPY''=''F'')',@AdhSystemID,'11','T','94','28',NULL,'TOTAL SOURCE 2 AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOURCE2RECORDCOUNT"','6','(''UN00''=''F'')',@AdhSystemID,'7','T','94','39',NULL,'SOURCE 2 RECORD COUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTALSOURCE3AMOUNT"','7','(''UNPY''=''F'')',@AdhSystemID,'11','T','94','46',NULL,'TOTAL SOURCE 3 AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOURCE3RECORDCOUNT"','8','(''UN00''=''F'')',@AdhSystemID,'7','T','94','57',NULL,'SOURCE 3 RECORD COUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'17','T','94','64',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','T','95','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"T07A"','2','(''DA''=''F'')',@AdhSystemID,'4','T','95','6',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDATEOFTRANSMISSION"','3','(''UDMDY''=''F'')',@AdhSystemID,'8','T','95','10',NULL,'DATE OF TRANSMISSION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTAL57RECORDS"','4','(''UN00''=''F'')',@AdhSystemID,'7','T','95','18',NULL,'TOTAL 57 RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTAL58RECORDS"','5','(''UN00''=''F'')',@AdhSystemID,'7','T','95','25',NULL,'TOTAL 58 RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTAL59RECORDS"','6','(''UN00''=''F'')',@AdhSystemID,'7','T','95','32',NULL,'TOTAL 59 RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTAL60RECORDS"','7','(''UN00''=''F'')',@AdhSystemID,'7','T','95','39',NULL,'TOTAL 60 RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTOTAL61RECORDS"','8','(''UN00''=''F'')',@AdhSystemID,'7','T','95','46',NULL,'TOTAL 61 RECORDS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'28','T','95','53',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,@FixedFormatName2,'201702189','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702189','Feb 18 2017 11:22AM','Feb 18 2017 11:22AM','201702181',NULL,'','','201702181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201702189','EMPEXPORT','TEST',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702189','Feb 18 2017 11:22AM','Feb 18 2017 11:22AM','201702181',NULL,'','','201702181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','ONDEMAND','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H02','dbo.U_@CustomFormatCode_HdrTbl_THR',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D15','dbo.U_@CustomFormatCode_drvTbl_02D',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D16','dbo.U_@CustomFormatCode_drvTbl_02E',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl_03',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D21','dbo.U_@CustomFormatCode_drvTbl_04',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D22','dbo.U_@CustomFormatCode_drvTbl_05',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D23','dbo.U_@CustomFormatCode_drvTbl_06',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D25','dbo.U_@CustomFormatCode_drvTbl_08',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_@CustomFormatCode_drvTbl_3K',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D35','dbo.U_@CustomFormatCode_drvTbl_21',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D40','dbo.U_@CustomFormatCode_drvTbl_60',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D41','dbo.U_@CustomFormatCode_drvTbl_61',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D50','dbo.U_@CustomFormatCode_drvTbl_BG',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D55','dbo.U_@CustomFormatCode_drvTbl_CA',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D60','dbo.U_@CustomFormatCode_drvTbl_EA',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T90','dbo.U_@CustomFormatCode_TrlTbl_BT3A',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T91','dbo.U_@CustomFormatCode_TrlTbl_T01A',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T92','dbo.U_@CustomFormatCode_TrlTbl_T01B',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T93','dbo.U_@CustomFormatCode_TrlTbl_T01C',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T94','dbo.U_@CustomFormatCode_TrlTbl_T06AtoJ',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T95','dbo.U_@CustomFormatCode_TrlTbl_T07A',NULL);
GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

END
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] char(80) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: @ClientName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: 02/18/2017
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2017     SR-2017-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y'
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
    WHERE FormatCode = '@CustomFormatCode';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_@CustomFormatCode_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_AuditFields;
    CREATE TABLE dbo.U_@CustomFormatCode_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecFulllTimeOrPartTime');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecLeaveReason');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepAddressEmail');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('OrgLevel','OrgDesc');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_@CustomFormatCode_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
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
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_@CustomFormatCode_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_@CustomFormatCode_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Changes Only
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audEEID = xEEID);

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_@CustomFormatCode_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhPerControl = LEFT(PdhPerControl,8)
        ,PdhSource = CASE WHEN PdhDedCode IN ('401KF','401KP') THEN '01' --Pre-Tax
                          WHEN PdhDedCode IN ('401RD','401RP') THEN '12' --Roth
                          WHEN PdhDedCode IN ('4KCUF','4KCUP') THEN '07' --Catch-up
                          WHEN PdhDedCode IN ('4RCUD','4RCUP') THEN '14' --Roth Catch-up
                          WHEN PdhDedCode IN ('401LN') THEN 'LOAN01'
                     END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
    INTO dbo.U_@CustomFormatCode_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND PdhDedCode IN ('401KF','401KP','401LN','401RD','401RP','4KCUF','4KCUP','4RCUD','4RCUP')
    GROUP BY PdhEEID, LEFT(PdhPerControl,8)
        ,CASE WHEN PdhDedCode IN ('401KF','401KP') THEN '01' --Pre-Tax
              WHEN PdhDedCode IN ('401RD','401RP') THEN '12' --Roth
              WHEN PdhDedCode IN ('4KCUF','4KCUP') THEN '07' --Catch-up
              WHEN PdhDedCode IN ('4RCUD','4RCUP') THEN '14' --Roth Catch-up
              WHEN PdhDedCode IN ('401LN') THEN 'LOAN01'
         END
    HAVING (SUM(PdhEECurAmt) <> 0.00);

    -------------------------------
    -- Working Table - Employees
    -------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Employees','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Employees;
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
        ,eepAddressEMail
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
        ,EecAnnSalary
        ,EecTermReason
        ,EecLeaveReason
        ,OrgLvl1Desc = O1.OrgDesc
        ,OrgLvl2Desc = O2.OrgDesc
        ,Record01Change
        ,Record02DChange
        ,Record02EChange
        ,Record03Change
        ,Record04Change
        ,Record05Change
        ,Record06Change
        ,Record08Change
        ,Record3KChange
        ,Record60Change
        ,Record61Change
        ,RecordBGChange
        ,RecordCAChange
        ,RecordEAChange
    INTO dbo.U_@CustomFormatCode_Employees
    FROM dbo.U_@CustomFormatCode_EEList
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.OrgLevel O1 WITH (NOLOCK)
        ON O1.OrgCode = EecOrgLvl1
        AND O1.OrgLvl = '1'
    LEFT JOIN dbo.OrgLevel O2 WITH (NOLOCK)
        ON O2.OrgCode = EecOrgLvl2
        AND O2.OrgLvl = '2'
    LEFT JOIN (
        SELECT audEEID
            ,Record01Change = MAX(CASE WHEN audFieldName IN ('EepNameFirst','EepNameLast','EepNameMiddle','EepGender','EepMaritalStatus') THEN 'Y' ELSE 'N' END)
            ,Record02DChange = MAX(CASE WHEN audFieldName IN ('EecDateOfOriginalHire','EepDateOfBirth','EecDateOfTermination') THEN 'Y' ELSE 'N' END)
            ,Record02EChange = MAX(CASE WHEN audFieldName IN ('EecEmpNo') THEN 'Y' ELSE 'N' END)
            ,Record03Change = MAX(CASE WHEN audFieldName IN ('EepAddressLine1','EepAddressLine2','EepAddressLine3') THEN 'Y' ELSE 'N' END)
            ,Record04Change = MAX(CASE WHEN audFieldName IN ('EepAddressCity','EepAddressState','EepAddressZipCode') THEN 'Y' ELSE 'N' END)
            ,Record05Change = MAX(CASE WHEN audFieldName IN ('EepAddressCountry') THEN 'Y' ELSE 'N' END)
            ,Record06Change = MAX(CASE WHEN audFieldName IN ('OrgDesc') THEN 'Y' ELSE 'N' END)
            ,Record08Change = MAX(CASE WHEN audFieldName IN ('EecEmplStatus') THEN 'Y' ELSE 'N' END)
            ,Record3KChange = MAX(CASE WHEN audFieldName IN ('EecOrglvl2') THEN 'Y' ELSE 'N' END)
            ,Record60Change = MAX(CASE WHEN audFieldName IN ('EecFullTimeOrPartTime','EecOrgLvl1','EecOrgLvl2','EecLocation','EecUnionLocal','EecPayPeriod') THEN 'Y' ELSE 'N' END)
            ,Record61Change = MAX(CASE WHEN audFieldName IN ('EecDateOfLastHire','EecDateOfRetirement') THEN 'Y' ELSE 'N' END)
            ,RecordBGChange = MAX(CASE WHEN audFieldName IN ('EecEmplStatus','EecTermReason','EecLeaveReason') THEN 'Y' ELSE 'N' END)
            ,RecordCAChange = MAX(CASE WHEN audFieldName IN ('EecAnnSalary') THEN 'Y' ELSE 'N' END)
            ,RecordEAChange = MAX(CASE WHEN audFieldName IN ('EepAddressEmail') THEN 'Y' ELSE 'N' END)
        FROM dbo.U_@CustomFormatCode_Audit
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID;

    ---------------------------------
    -- HEADER RECORD - THR
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_HdrTbl_THR','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_HdrTbl_THR;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvTYPEOFACCOUNT = '401K'
        ,drvCLIENTNAME = '@ClientName'
    INTO dbo.U_@CustomFormatCode_HdrTbl_THR;

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_01
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_01;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLASTNAME = EepNameLast
        ,drvFIRSTNAMEMIDDLEINITIAL = RTRIM(EepNameFirst) + ISNULL(LEFT(EepNameMiddle,1),'')
        ,drvMARITALSTATUS = eepMaritalStatus
        ,drvGENDER = EepGender
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '01'
    INTO dbo.U_@CustomFormatCode_drvTbl_01
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record01Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_02D
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_02D','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_02D;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvHIREDATE = EecDateOfOriginalHire
        ,drvDATEOFBIRTH = EepDateOfBirth
        ,drvTERMINATIONDATE = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02D'
    INTO dbo.U_@CustomFormatCode_drvTbl_02D
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record02DChange = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_02E
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_02E','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_02E;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEMPLOYEENUMBER = EecEmpNo
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02E'
    INTO dbo.U_@CustomFormatCode_drvTbl_02E
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record02EChange = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_03
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_03','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_03;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvADDRESSLINENUMBER = LineNumber
        ,drvADDRESS = EepAddress
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '03'
    INTO dbo.U_@CustomFormatCode_drvTbl_03
    FROM (
        -- Address Line 1
        SELECT xEEID, xCOID, EepSSN, EepAddressLine1 AS EepAddress, '01' AS LineNumber, Record03Change FROM dbo.U_@CustomFormatCode_Employees

        UNION ALL

        -- Address Line 2
        SELECT xEEID, xCOID, EepSSN, EepAddressLine2 AS EepAddress, '02' AS LineNumber, Record03Change FROM dbo.U_@CustomFormatCode_Employees

        UNION ALL

        -- Address Line 3
        SELECT xEEID, xCOID, EepSSN, EepAddressLine3 AS EepAddress, '03' AS LineNumber, Record03Change FROM dbo.U_@CustomFormatCode_Employees
    ) Employee
    WHERE Record03Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_04
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_04','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_04;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
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
    INTO dbo.U_@CustomFormatCode_drvTbl_04
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record04Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_05
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_05','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_05;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvCOUNTRY = EepAddressCountry
        ,drvMAILINGINDICATOR = 'Y'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '05'
    INTO dbo.U_@CustomFormatCode_drvTbl_05
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE EepAddressCountry NOT IN ('US','USA')
    AND Record05Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_06
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_06','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_06;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONID = OrgLvl2Desc
        ,drvREGIONID = OrgLvl1Desc
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '06'
    INTO dbo.U_@CustomFormatCode_drvTbl_06
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record06Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_08
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_08','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_08;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSALARY = EecAnnSalary
        ,drvSALARYADDREPLACEINDICATOR = ''
        ,drvSALARYPAYDATE = COALESCE(EjhJobEffDate,EecDateOfLastHire)
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '08'
    INTO dbo.U_@CustomFormatCode_drvTbl_08
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    LEFT JOIN (
        -- Get Most Recent Effective Date of Salary Change
        SELECT EjhEEID, EjhCOID
            ,EjhJobEffDate = MAX(EjhJobEffDate)
        FROM dbo.EmpHJob
        WHERE EjhIsRateChange = 'Y'
        GROUP BY EjhEEID, EjhCOID
    ) EmpHJob
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    WHERE Record08Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_3K
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_3K','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_3K;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvFISCALYEAR = LEFT(PdhPerControl,4)
        ,drvSOURCE = PdhSource
        ,drvAMOUNT = PdhEECurAmt
        ,drvADJUSTMENTREASON = ''
        ,drvORIGINALPAYDATE = ''
        ,drvEMPLOYEESALARY = '000000000'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '3K'
    INTO dbo.U_@CustomFormatCode_drvTbl_3K
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    WHERE PdhSource <> 'LOAN01';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_21
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_21','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_21;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLOANIDENTIFICATION = PdhSource
        ,drvPRINCIPALAMOUNT = PdhEECurAmt
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '21'
    INTO dbo.U_@CustomFormatCode_drvTbl_21
    FROM dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
    WHERE PdhSource = 'LOAN01';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_60
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_60','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_60;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvPARTICIPANTCLASS = EecFullTimeOrPartTime
        ,drvPARTICIPANTDISTRICT = EecOrgLvl1
        ,drvPARTICIPANTDEPARTMENT = EecOrgLvl2
        ,drvPARTICIPANTLOCATIONSTORE = EecLocation
        ,drvPARTICIPANTUNIONCODE = EecUnionLocal
        ,drvPARTICIPANTPAYMENTFREQ = CASE EecPayPeriod
                                          WHEN 'S' THEN '2'
                                          ELSE EecPayPeriod
                                     END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '60'
    INTO dbo.U_@CustomFormatCode_drvTbl_60
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record60Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_61
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_61','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_61;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvELIGIBILITYDATE = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvADJUSTEDDATEOFHIRE = EecDateOfLastHire
        ,drvRETIREMENTDATE = EecDateOfRetirement
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '61'
    INTO dbo.U_@CustomFormatCode_drvTbl_61
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record61Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_BG
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_BG','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_BG;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEVENTEFFECTIVEDATE = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                      ELSE audDateTime
                                 END
        ,drvEVENTCODE = CASE WHEN EecEmplStatus = 'T' THEN
                                CASE EecTermReason
                                    WHEN '202' THEN 'RET'
                                    WHEN '203' THEN 'DTH'
                                    ELSE 'TER'
                                END
                             WHEN EecEmplStatus = 'L' THEN 'LOA'
                             ELSE
                                CASE WHEN NewHire = 'Y' THEN 'HIR'
                                     WHEN Rehire = 'Y' THEN 'REH'
                                     WHEN ReturnFromLOA = 'Y' THEN 'RFL'
                                     WHEN ReturnFromLOA = 'Y' THEN 'RFL'
                                END
                       END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = 'BG'
    INTO dbo.U_@CustomFormatCode_drvTbl_BG
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    JOIN (
        -- Audit Changes
        SELECT audEEID
            ,audDateTime = MAX(audDateTime)
            ,NewHire = MAX(CASE WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,ReHire = MAX(CASE WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
            ,Termed = MAX(CASE WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END)
            ,LOA = MAX(CASE WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'A' AND ISNULL(audNewValue,'') = 'L' THEN 'Y' ELSE 'N' END)
            ,ReturnFromLOA = MAX(CASE WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'L' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END)
        FROM dbo.U_@CustomFormatCode_Audit
        WHERE audFieldName = 'EecEmplStatus'
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID
    WHERE RecordBGChange = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_CA
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_CA','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_CA;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvCOMPENSATIONAMOUNTEFFDATE = COALESCE(EjhJobEffDate,EecDateOfLastHire)
        ,drvCOMPENSATIONAMOUNT = EecAnnSalary
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = 'CA'
    INTO dbo.U_@CustomFormatCode_drvTbl_CA
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    LEFT JOIN (
        -- Get Most Recent Effective Date of Salary Change
        SELECT EjhEEID, EjhCOID
            ,EjhJobEffDate = MAX(EjhJobEffDate)
        FROM dbo.EmpHJob
        WHERE EjhIsRateChange = 'Y'
        GROUP BY EjhEEID, EjhCOID
    ) EmpHJob
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    WHERE RecordCAChange = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_EA
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_EA','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_EA;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvEMAILADDRESSSTATUSCODE = 'A'
        ,drvEMAILRECORDSEQUENCENBR = SeqNo
        ,drvEMAILADDRESSTEXT = EepAddressEMail
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = 'EA'
    INTO dbo.U_@CustomFormatCode_drvTbl_EA
    FROM (
        -- Sequence 1 (First 35 Characters of Email Address)
        SELECT xEEID, xCOID, EepSSN, SeqNo = '1', EepAddressEMail = SUBSTRING(eepAddressEMail,1,35)
        FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
        WHERE RecordEAChange = 'Y'

        UNION ALL

        -- Sequence 2 (Second 35 Characters of Email Address)
        SELECT xEEID, xCOID, EepSSN, SeqNo = '2', eepAddressEMail = SUBSTRING(eepAddressEMail,36,35)
        FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
        WHERE RecordEAChange = 'Y' AND eepAddressEMail > 35

        UNION ALL

        -- Sequence 3 (Last 35 Characters of Email Address)
        SELECT xEEID, xCOID, EepSSN, SeqNo = '3', eepAddressEMail = SUBSTRING(eepAddressEMail,71,35)
        FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
        WHERE RecordEAChange = 'Y' AND eepAddressEMail > 70
    ) EmailChanges;

    -----------------------------------------------------
    -- TRAILER RECORD - BT3A
    -- Total Record: 3S, BE, BF, BG, BM, CC, EC AND RD
    -----------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_BT3A','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_TrlTbl_BT3A;
    SELECT DISTINCT
        drvDATEOFTRANSMISSION = GETDATE()
        ,drvTOTALDBDEMOGRAPHICRECORDS = COUNT(*)
    INTO dbo.U_@CustomFormatCode_TrlTbl_BT3A
    FROM dbo.U_@CustomFormatCode_drvTbl_BG WITH (NOLOCK);

    ----------------------------------------------------------------------------------------------------------
    -- TRAILER RECORD - T01A
    -- Total Record: 01, 02D, 02E 03, 04, 05, 06, 07, 08, 09, 11, 12, 14, 31, 32, 33, 34, 36, CA, EA and SW
    ----------------------------------------------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_T01A','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_TrlTbl_T01A;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvDATEOFTRANSMISSION = GETDATE()
        ,drvTOTALCONTRIBUTIONAMOUNT = SUM(drvAMOUNT)
        ,drvTOTALCONTRIBUTIONRECORDS = COUNT(drvSOURCE)
        ,drvTOTALPARTICIPANTRECORDS = COUNT(*)
    INTO dbo.U_@CustomFormatCode_TrlTbl_T01A
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    LEFT JOIN dbo.U_@CustomFormatCode_drvTbl_3K
        ON drvEEID = xEEID;

    ---------------------------------
    -- TRAILER RECORD - T01B
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_T01B','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_TrlTbl_T01B;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvDATEOFTRANSMISSION = GETDATE()
        ,drvTOTALFUNDELECTIONRECORDS = 0
        ,drvTOTALLOANREPAYRECORDS = COUNT(*)
        ,drvTOTALLOANREPAYAMOUNT = SUM(drvPRINCIPALAMOUNT)
    INTO dbo.U_@CustomFormatCode_TrlTbl_T01B
    FROM dbo.U_@CustomFormatCode_drvTbl_21 WITH (NOLOCK);

    ---------------------------------
    -- TRAILER RECORD - T01C
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_T01C','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_TrlTbl_T01C;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvDATEOFTRANSMISSION = GETDATE()
        ,drvTOTALSALARYAMOUNT = SUM(drvCOMPENSATIONAMOUNT)
        ,drvTOTALSALARYRECORDS = COUNT(*)
    INTO dbo.U_@CustomFormatCode_TrlTbl_T01C
    FROM dbo.U_@CustomFormatCode_drvTbl_CA WITH (NOLOCK);

    ----------------------------------
    -- TRAILER RECORD - T06A to T06J
    ----------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_T06AtoJ','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_TrlTbl_T06AtoJ;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvRECORDIDENTIFIER = 'T06A'
        ,drvTOTALSOURCE1AMOUNT = SUM(CASE WHEN drvSOURCE = '01' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE1RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '01' THEN 1 ELSE 0 END)
        ,drvTOTALSOURCE2AMOUNT = SUM(CASE WHEN drvSOURCE = '02' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE2RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '02' THEN 1 ELSE 0 END)
        ,drvTOTALSOURCE3AMOUNT = SUM(CASE WHEN drvSOURCE = '03' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE3RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '03' THEN 1 ELSE 0 END)
    INTO dbo.U_@CustomFormatCode_TrlTbl_T06AtoJ
    FROM dbo.U_@CustomFormatCode_drvTbl_3K WITH (NOLOCK)
    WHERE drvSOURCE IN ('01','02','03');

    ----------------------
    -- Load T06B Records
    ----------------------
    INSERT INTO dbo.U_@CustomFormatCode_TrlTbl_T06AtoJ (drvPLANNUMBER,drvRECORDIDENTIFIER,drvTOTALSOURCE1AMOUNT,drvSOURCE1RECORDCOUNT,drvTOTALSOURCE2AMOUNT,drvSOURCE2RECORDCOUNT,drvTOTALSOURCE3AMOUNT,drvSOURCE3RECORDCOUNT)
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvRECORDIDENTIFIER = 'T06B'
        ,drvTOTALSOURCE1AMOUNT = SUM(CASE WHEN drvSOURCE = '04' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE1RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '04' THEN 1 ELSE 0 END)
        ,drvTOTALSOURCE2AMOUNT = SUM(CASE WHEN drvSOURCE = '05' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE2RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '05' THEN 1 ELSE 0 END)
        ,drvTOTALSOURCE3AMOUNT = SUM(CASE WHEN drvSOURCE = '06' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE3RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '06' THEN 1 ELSE 0 END)
    FROM dbo.U_@CustomFormatCode_drvTbl_3K WITH (NOLOCK)
    WHERE drvSOURCE IN ('04','05','06');

    ----------------------
    -- Load T06C Records
    ----------------------
    INSERT INTO dbo.U_@CustomFormatCode_TrlTbl_T06AtoJ (drvPLANNUMBER,drvRECORDIDENTIFIER,drvTOTALSOURCE1AMOUNT,drvSOURCE1RECORDCOUNT,drvTOTALSOURCE2AMOUNT,drvSOURCE2RECORDCOUNT,drvTOTALSOURCE3AMOUNT,drvSOURCE3RECORDCOUNT)
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvRECORDIDENTIFIER = 'T06C'
        ,drvTOTALSOURCE1AMOUNT = SUM(CASE WHEN drvSOURCE = '07' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE1RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '07' THEN 1 ELSE 0 END)
        ,drvTOTALSOURCE2AMOUNT = SUM(CASE WHEN drvSOURCE = '08' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE2RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '08' THEN 1 ELSE 0 END)
        ,drvTOTALSOURCE3AMOUNT = SUM(CASE WHEN drvSOURCE = '09' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE3RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '09' THEN 1 ELSE 0 END)
    FROM dbo.U_@CustomFormatCode_drvTbl_3K WITH (NOLOCK)
    WHERE drvSOURCE IN ('07','08','09');

    ----------------------
    -- Load T06D Records
    ----------------------
    INSERT INTO dbo.U_@CustomFormatCode_TrlTbl_T06AtoJ (drvPLANNUMBER,drvRECORDIDENTIFIER,drvTOTALSOURCE1AMOUNT,drvSOURCE1RECORDCOUNT,drvTOTALSOURCE2AMOUNT,drvSOURCE2RECORDCOUNT,drvTOTALSOURCE3AMOUNT,drvSOURCE3RECORDCOUNT)
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvRECORDIDENTIFIER = 'T06D'
        ,drvTOTALSOURCE1AMOUNT = SUM(CASE WHEN drvSOURCE = '10' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE1RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '10' THEN 1 ELSE 0 END)
        ,drvTOTALSOURCE2AMOUNT = SUM(CASE WHEN drvSOURCE = '11' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE2RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '11' THEN 1 ELSE 0 END)
        ,drvTOTALSOURCE3AMOUNT = SUM(CASE WHEN drvSOURCE = '12' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE3RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '12' THEN 1 ELSE 0 END)
    FROM dbo.U_@CustomFormatCode_drvTbl_3K WITH (NOLOCK)
    WHERE drvSOURCE IN ('10','11','12');

    ----------------------
    -- Load T06E Records
    ----------------------
    INSERT INTO dbo.U_@CustomFormatCode_TrlTbl_T06AtoJ (drvPLANNUMBER,drvRECORDIDENTIFIER,drvTOTALSOURCE1AMOUNT,drvSOURCE1RECORDCOUNT,drvTOTALSOURCE2AMOUNT,drvSOURCE2RECORDCOUNT,drvTOTALSOURCE3AMOUNT,drvSOURCE3RECORDCOUNT)
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvRECORDIDENTIFIER = 'T06E'
        ,drvTOTALSOURCE1AMOUNT = SUM(CASE WHEN drvSOURCE = '13' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE1RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '13' THEN 1 ELSE 0 END)
        ,drvTOTALSOURCE2AMOUNT = SUM(CASE WHEN drvSOURCE = '14' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE2RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '14' THEN 1 ELSE 0 END)
        ,drvTOTALSOURCE3AMOUNT = SUM(CASE WHEN drvSOURCE = '15' THEN 1 ELSE drvAMOUNT END)
        ,drvSOURCE3RECORDCOUNT = SUM(CASE WHEN drvSOURCE = '15' THEN 1 ELSE 0 END)
    FROM dbo.U_@CustomFormatCode_drvTbl_3K WITH (NOLOCK)
    WHERE drvSOURCE IN ('13','14','15');

    ---------------------------------
    -- TRAILER RECORD - T07A
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_TrlTbl_T07A','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_TrlTbl_T07A;
    SELECT DISTINCT
        drvPLANNUMBER = '@PlanNumber'
        ,drvDATEOFTRANSMISSION = GETDATE()
        ,drvTOTAL57RECORDS = 0
        ,drvTOTAL58RECORDS = 0
        ,drvTOTAL59RECORDS = 0
        ,drvTOTAL60RECORDS = CASE WHEN RecType = '60' THEN RecordCount ELSE 0 END
        ,drvTOTAL61RECORDS = CASE WHEN RecType = '61' THEN RecordCount ELSE 0 END
    INTO dbo.U_@CustomFormatCode_TrlTbl_T07A
    FROM (
        -- Total Record Count of Record '60'
        SELECT RecType = '60', RecordCount = COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_60 WITH (NOLOCK)

        UNION ALL

        -- Total Record Count of Record '61'
        SELECT RecType = '61', RecordCount = COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_61 WITH (NOLOCK)
    ) RecordCount

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('@CustomFormatCode','Testing') = 'Y' THEN '[CoCode]_@CustomFormatCode_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE '[CoCode]_@CustomFormatCode_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = '@CustomFormatCode';
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201702111'
       ,ExpStartPerControl     = '201702111'
       ,ExpLastEndPerControl   = '201702189'
       ,ExpEndPerControl       = '201702189'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO