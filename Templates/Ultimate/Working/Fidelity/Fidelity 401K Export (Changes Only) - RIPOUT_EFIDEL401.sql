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
@CustomFormatCode - Replace with Format Code (i.e., EFIDEL401)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Fidelity 401K Export - Participant Indicative Data)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Export parameters
@DedCodeList - Replace with list of Deduction Codes (i.e., 401K,ROTH,MATCH,401CU,ROTHC)

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Fidelity\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Fidelity\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PDedHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_Employees') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Employees];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_61') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_61];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_60') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_60];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_36') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_36];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_21') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_21];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_19Q') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_19Q];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_11') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_11];
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

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT(@CustomFormatCode + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','80','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TESTEDT"','1','(''DA''=''F'')',@AdhSystemID,'7','H','01','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'73','H','01','8',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','10','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','10','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','10','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','10','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"01"','6','(''DA''=''F'')',@AdhSystemID,'2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLASTNAME"','7','(''UA''=''F'')',@AdhSystemID,'20','D','10','32',NULL,'LAST NAME (FREE FORM)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFIRSTNAMEMIDDLEINITIAL"','8','(''UA''=''F'')',@AdhSystemID,'15','D','10','52',NULL,'FIRST NAME MIDDLE INITIAL (FREE FORM)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"000000000"','9','(''DA''=''F'')',@AdhSystemID,'9','D','10','67',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMARITALSTATUS"','10','(''UA''=''F'')',@AdhSystemID,'1','D','10','76',NULL,'MARITAL STATUS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGENDER"','11','(''UA''=''F'')',@AdhSystemID,'1','D','10','77',NULL,'GENDER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'1','D','10','78',NULL,'SPECIAL TAX TYPE ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'1','D','10','79',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','10','80',NULL,'BENE/QDRO PAYEE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','15','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','15','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','15','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','15','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','15','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"02"','6','(''DA''=''F'')',@AdhSystemID,'2','D','15','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"D"','7','(''DA''=''F'')',@AdhSystemID,'1','D','15','32',NULL,'FIELD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'4','D','15','33',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHIREDATE"','9','(''UDMDY''=''F'')',@AdhSystemID,'8','D','15','37',NULL,'HIRE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000000"','10','(''DA''=''F'')',@AdhSystemID,'8','D','15','45',NULL,'PARTICIPATION DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000000"','11','(''DA''=''F'')',@AdhSystemID,'8','D','15','53',NULL,'VESTING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDATEOFBIRTH"','12','(''UDMDY''=''F'')',@AdhSystemID,'8','D','15','61',NULL,'DATE-OF-BIRTH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTERMINATIONDATE"','13','(''UDMDY''=''F'')',@AdhSystemID,'8','D','15','69',NULL,'TERMINATION DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','15','77',NULL,'DATE SWITCH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'1','D','15','78',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','15','79',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','17','(''SS''=''F'')',@AdhSystemID,'1','D','15','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','20','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','20','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','20','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','20','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','20','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"02"','6','(''DA''=''F'')',@AdhSystemID,'2','D','20','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"E"','7','(''DA''=''F'')',@AdhSystemID,'1','D','20','32',NULL,'FIELD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEMPLOYEENUMBER"','8','(''UA''=''F'')',@AdhSystemID,'11','D','20','33',NULL,'EMPLOYEE NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'1','D','20','44',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'2','D','20','45',NULL,'EMPLOYEE NUMBER STATUS CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'12','D','20','47',NULL,'CLIENT PROVIDED ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'22','D','20','59',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','25','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','25','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','25','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','25','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','25','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"03"','6','(''DA''=''F'')',@AdhSystemID,'2','D','25','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"P"','7','(''DA''=''F'')',@AdhSystemID,'1','D','25','32',NULL,'RECORD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADDRESSLINENUMBER"','8','(''UA''=''F'')',@AdhSystemID,'2','D','25','33',NULL,'ADDRESS LINE NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADDRESS"','9','(''UA''=''F'')',@AdhSystemID,'32','D','25','35',NULL,'ADDRESS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'11','D','25','67',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'1','D','25','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'1','D','25','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'1','D','25','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','30','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','30','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','30','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','30','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','30','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"04"','6','(''DA''=''F'')',@AdhSystemID,'2','D','30','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"P"','7','(''DA''=''F'')',@AdhSystemID,'1','D','30','32',NULL,'RECORD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCITY"','8','(''UA''=''F'')',@AdhSystemID,'20','D','30','33',NULL,'CITY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTATE"','9','(''UA''=''F'')',@AdhSystemID,'2','D','30','53',NULL,'STATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'8','D','30','55',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZIPCODE"','11','(''UA''=''F'')',@AdhSystemID,'5','D','30','63',NULL,'ZIP CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZIP4CODE"','12','(''UA''=''F'')',@AdhSystemID,'4','D','30','68',NULL,'ZIP + 4 CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'6','D','30','72',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','30','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'1','D','30','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','30','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','35','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','35','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','35','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','35','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','35','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"05"','6','(''DA''=''F'')',@AdhSystemID,'2','D','35','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"P"','7','(''DA''=''F'')',@AdhSystemID,'1','D','35','32',NULL,'RECORD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCOUNTRY"','8','(''UA''=''F'')',@AdhSystemID,'23','D','35','33',NULL,'COUNTRY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'1','D','35','56',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Y"','10','(''DA''=''F'')',@AdhSystemID,'1','D','35','57',NULL,'SPECIAL HANDLING',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'19','D','35','58',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMAILINGINDICATOR"','12','(''UA''=''F'')',@AdhSystemID,'1','D','35','77',NULL,'MAILING INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'1','D','35','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','35','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'1','D','35','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','40','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','40','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','40','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','40','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','40','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"06"','6','(''DA''=''F'')',@AdhSystemID,'2','D','40','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDIVISIONID"','7','(''UA''=''F'')',@AdhSystemID,'20','D','40','32',NULL,'DIVISION ID (Name)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'20','D','40','52',NULL,'REGION ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'3','D','40','72',NULL,'SITE SECURITY CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'4','D','40','75',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'2','D','40','79',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','45','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','45','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','45','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','45','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','45','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"11"','6','(''DA''=''F'')',@AdhSystemID,'2','D','45','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTATUSCODE"','7','(''UA''=''F'')',@AdhSystemID,'1','D','45','32',NULL,'STATUS CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'5','D','45','33',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'8','D','45','38',NULL,'STATUS CHANGE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'1','D','45','46',NULL,'LITERATURE KIT INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'32','D','45','47',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'1','D','45','79',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'1','D','45','80',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','50','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','50','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','50','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','50','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','50','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"36"','6','(''DA''=''F'')',@AdhSystemID,'2','D','50','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''F'')',@AdhSystemID,'4','D','50','32',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDIVISIONCODE"','8','(''UA''=''F'')',@AdhSystemID,'4','D','50','36',NULL,'DIVISION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'40','D','50','40',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'1','D','50','80',NULL,'DIVISION CODE EXISTS INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','55','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','55','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','55','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','55','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','55','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"60"','6','(''DA''=''F'')',@AdhSystemID,'2','D','55','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTCLASS"','7','(''UA''=''F'')',@AdhSystemID,'1','D','55','32',NULL,'PARTICIPANT CLASS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTDISTRICT"','8','(''UA''=''F'')',@AdhSystemID,'8','D','55','33',NULL,'PARTICIPANT DISTRICT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTDEPARTMENT"','9','(''UA''=''F'')',@AdhSystemID,'8','D','55','41',NULL,'PARTICIPANT DEPARTMENT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTLOCATIONSTORE"','10','(''UA''=''F'')',@AdhSystemID,'8','D','55','49',NULL,'PARTICIPANT LOCATION/STORE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTUNIONCODE"','11','(''UA''=''F'')',@AdhSystemID,'8','D','55','57',NULL,'PARTICIPANT UNION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPARTICIPANTPAYMENTFREQ"','12','(''UA''=''F'')',@AdhSystemID,'1','D','55','65',NULL,'PARTICIPANT PAYMENT FREQUENCY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'8','D','55','66',NULL,'MISCELLANEOUS CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','55','74',NULL,'HIGHLY COMPENSATED FLAG',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'1','D','55','75',NULL,'OFFICER / 16 (B) FLAG',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','55','76',NULL,'DE MINIMUS ELIGIBILITY INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','17','(''SS''=''F'')',@AdhSystemID,'1','D','55','77',NULL,'AGE PAYOUT ELIGIBILITY INDICATOR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'1','D','55','78',NULL,'PARTICIPANT RESTRICTION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','19','(''SS''=''F'')',@AdhSystemID,'2','D','55','79',NULL,'PARTICIPANT RESTRICTION REASON',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','60','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','60','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','60','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','60','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'6','D','60','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"61"','6','(''DA''=''F'')',@AdhSystemID,'2','D','60','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''F'')',@AdhSystemID,'8','D','60','32',NULL,'ELIGIBILITY DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADJUSTEDDATEOFHIRE"','8','(''UDMDY''=''F'')',@AdhSystemID,'8','D','60','40',NULL,'ADJUSTED DATE OF HIRE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRETIREMENTDATE"','9','(''UDMDY''=''F'')',@AdhSystemID,'8','D','60','48',NULL,'RETIREMENT DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000"','10','(''DA''=''F'')',@AdhSystemID,'5','D','60','56',NULL,' RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'8','D','60','61',NULL,'BIS ACCRUAL START DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'12','D','60','69',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','65','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','65','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','65','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','65','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','65','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000"','6','(''DA''=''F'')',@AdhSystemID,'5','D','65','25',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"19"','7','(''DA''=''F'')',@AdhSystemID,'2','D','65','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'4','D','65','32',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"220"','9','(''DA''=''F'')',@AdhSystemID,'3','D','65','36',NULL,'TRANSACTION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'2','D','65','39',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOURCE"','11','(''UA''=''F'')',@AdhSystemID,'2','D','65','41',NULL,'SOURCE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"01"','12','(''DA''=''F'')',@AdhSystemID,'2','D','65','43',NULL,'ITEM NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','13','(''SS''=''F'')',@AdhSystemID,'1','D','65','45',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAMOUNT"','14','(''UNPN''=''F'')',@AdhSystemID,'13','D','65','46',NULL,'AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''F'')',@AdhSystemID,'4','D','65','59',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'4','D','65','63',NULL,'FISCAL YEAR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','17','(''SS''=''F'')',@AdhSystemID,'1','D','65','67',NULL,'ADJUSTMENT REASON',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'8','D','65','68',NULL,'ORIGINAL PAY DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','19','(''SS''=''F'')',@AdhSystemID,'5','D','65','76',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANNUMBER"','1','(''UA''=''F'')',@AdhSystemID,'5','D','70','1',NULL,'PLAN NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBATCHGROUPID"','2','(''UA''=''F'')',@AdhSystemID,'4','D','70','6',NULL,'BATCH GROUP ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','3','(''SS''=''F'')',@AdhSystemID,'3','D','70','10',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')',@AdhSystemID,'11','D','70','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','5','(''SS''=''F'')',@AdhSystemID,'1','D','70','24',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000"','6','(''DA''=''F'')',@AdhSystemID,'5','D','70','25',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"21"','7','(''DA''=''F'')',@AdhSystemID,'2','D','70','30',NULL,'RECORD IDENTIFIER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'4','D','70','32',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLOANIDENTIFICATION"','9','(''UA''=''F'')',@AdhSystemID,'12','D','70','36',NULL,'LOAN IDENTIFICATION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'1','D','70','48',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"260"','11','(''DA''=''F'')',@AdhSystemID,'3','D','70','49',NULL,'TRANSACTION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"14"','12','(''DA''=''F'')',@AdhSystemID,'2','D','70','52',NULL,'ITEM NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00"','13','(''DA''=''F'')',@AdhSystemID,'2','D','70','54',NULL,'RESERVED',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','70','56',NULL,'FILLER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvREPAYMENTAMOUNT"','15','(''UNPN''=''F'')',@AdhSystemID,'7','D','70','57',NULL,'REPAYMENT AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','70','64',NULL,'ADJUSTMENT REASON',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','17','(''SS''=''F'')',@AdhSystemID,'8','D','70','65',NULL,'ORIGINAL PAY DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'1','D','70','73',NULL,'PRINCIPAL ONLY FLAG',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','19','(''SS''=''F'')',@AdhSystemID,'1','D','70','74',NULL,'NEW REPAYMENT FREQUENCY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','20','(''SS''=''F'')',@AdhSystemID,'6','D','70','75',NULL,'REGION',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,@FixedFormatName2,'201702019','EMPEXPORT','ONDEMAND','Feb 01 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017 12:00AM','Dec 30 1899 12:00AM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','201702019','EMPEXPORT','TEST','Feb 01 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201702019','Feb 01 2017 12:00AM','Dec 30 1899 12:00AM','201702071',NULL,'','','201702071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','ONDEMAND','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D15','dbo.U_@CustomFormatCode_drvTbl_02D',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl_02E',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D25','dbo.U_@CustomFormatCode_drvTbl_03',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_@CustomFormatCode_drvTbl_04',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D35','dbo.U_@CustomFormatCode_drvTbl_05',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D40','dbo.U_@CustomFormatCode_drvTbl_06',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D45','dbo.U_@CustomFormatCode_drvTbl_11',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D50','dbo.U_@CustomFormatCode_drvTbl_36',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D55','dbo.U_@CustomFormatCode_drvTbl_60',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D60','dbo.U_@CustomFormatCode_drvTbl_61',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D65','dbo.U_@CustomFormatCode_drvTbl_19Q',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D70','dbo.U_@CustomFormatCode_drvTbl_21',NULL);
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
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = '@CustomFormatCode'; -- Skip RecordSets by ExportCode
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
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepAddressCountry');
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
        ,PdhSource = CASE WHEN PdhDedCode IN ('401KF','401KP','4KCUF','4KCUP') THEN '01' --401K
                          WHEN PdhDedCode IN ('401RD','401RP','4RCUD','4RCUP') THEN '02' --ROTH
                          WHEN PdhDedCode IN ('4MTCH') THEN '03' --MATCH
                          WHEN PdhDedCode IN ('401LN') THEN 'LOAN 1' --401K LOAN
                     END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
    INTO dbo.U_@CustomFormatCode_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND PdhDedCode IN ('401KF','401KP','401LN','401RD','401RP','4KCUF','4KCUP','4MTCH','4RCUD','4RCUP')
    GROUP BY PdhEEID
        ,CASE WHEN PdhDedCode IN ('401KF','401KP','4KCUF','4KCUP') THEN '01' --401K
              WHEN PdhDedCode IN ('401RD','401RP','4RCUD','4RCUP') THEN '02' --ROTH
              WHEN PdhDedCode IN ('4MTCH') THEN '03' --MATCH
              WHEN PdhDedCode IN ('401LN') THEN 'LOAN 1' --401K LOAN
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
    INTO dbo.U_@CustomFormatCode_Employees
    FROM dbo.U_@CustomFormatCode_EEList
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
        FROM dbo.U_@CustomFormatCode_Audit
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID;

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_01
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_01;
    SELECT DISTINCT
        drvPLANNUMBER = ''
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
        drvPLANNUMBER = ''
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
        drvPLANNUMBER = ''
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
        drvPLANNUMBER = ''
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
    INTO dbo.U_@CustomFormatCode_drvTbl_04
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record04Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_05
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_05','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_05;
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
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONID = OrgLvl2Desc
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '06'
    INTO dbo.U_@CustomFormatCode_drvTbl_06
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record06Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_11
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_11','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_11;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSTATUSCODE = EecEmplStatus
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '11'
    INTO dbo.U_@CustomFormatCode_drvTbl_11
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record11Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_36
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_36','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_36;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvDIVISIONCODE = EecOrglvl2
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '36'
    INTO dbo.U_@CustomFormatCode_drvTbl_36
    FROM dbo.U_@CustomFormatCode_Employees WITH (NOLOCK)
    WHERE Record36Change = 'Y';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_60
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_60','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_60;
    SELECT DISTINCT
        drvPLANNUMBER = ''
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
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
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
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_19Q
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_19Q','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_19Q;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSOURCE = PdhSource
        ,drvAMOUNT = PdhEECurAmt
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '19Q'
    INTO dbo.U_@CustomFormatCode_drvTbl_19Q
    FROM dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
	WHERE PdhSource <> 'LOAN 1';

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_21
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_21','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_21;
    SELECT DISTINCT
        drvPLANNUMBER = ''
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvLOANIDENTIFICATION = PdhSource
        ,drvREPAYMENTAMOUNT = PdhEECurAmt
        ,drvEEID = PdhEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '21'
    INTO dbo.U_@CustomFormatCode_drvTbl_21
    FROM dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = PdhEEID
	WHERE PdhSource = 'LOAN 1';

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('@CustomFormatCode','Testing') = 'Y' THEN 'TEST_CSP_@CustomFormatCode_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'CSP_@CustomFormatCode_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = '@CustomFormatCode';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201702011'
       ,ExpStartPerControl     = '201702011'
       ,ExpLastEndPerControl   = '201702019'
       ,ExpEndPerControl       = '201702019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO