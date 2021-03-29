SET NOCOUNT ON;
IF OBJECT_ID('U_EFD401KHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFD401KHSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFD401KHSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFD401KHSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFD401KHSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFD401KHSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFD401KHSA];
GO
IF OBJECT_ID('U_EFD401KHSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_PEarHist];
GO
IF OBJECT_ID('U_EFD401KHSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_PDedHist];
GO
IF OBJECT_ID('U_EFD401KHSA_File') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_File];
GO
IF OBJECT_ID('U_EFD401KHSA_Employees') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_Employees];
GO
IF OBJECT_ID('U_EFD401KHSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_EEList];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_TestHeader') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_TestHeader];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_HS') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_HS];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_EA') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_EA];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_61') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_61];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_60') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_60];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_21') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_21];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_19') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_19];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_11') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_11];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_06') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_06];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_04') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_04];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_03') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_03];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_02E') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_02E];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_02D') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_02D];
GO
IF OBJECT_ID('U_EFD401KHSA_drvTbl_01') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_drvTbl_01];
GO
IF OBJECT_ID('U_EFD401KHSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_DedList];
GO
IF OBJECT_ID('U_EFD401KHSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_AuditFields];
GO
IF OBJECT_ID('U_EFD401KHSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFD401KHSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFD401KHSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFD401KHSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFD401KHSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFD401KHSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFD401KHSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFD401KHSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFD401KHSA','Fidelity 401K HSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','80','S','N','EFD401KHSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFD401KHSA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTestIdentifier"','1','(''UA''=''F'')','EFD401KHSAZ0','7','D','10','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''F'')','EFD401KHSAZ0','73','D','10','8',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','15','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','15','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','15','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','15','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','6','D','15','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','6','(''DA''=''F'')','EFD401KHSAZ0','2','D','15','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''F'')','EFD401KHSAZ0','20','D','15','32',NULL,'LAST NAME (FREE FORM)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirstMiddle"','8','(''UA''=''F'')','EFD401KHSAZ0','15','D','15','52',NULL,'FIRST NAME MIDDLE INITIAL (FREE FORM)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000000"','9','(''DA''=''F'')','EFD401KHSAZ0','9','D','15','67',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''F'')','EFD401KHSAZ0','1','D','15','76',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','11','(''UA''=''F'')','EFD401KHSAZ0','1','D','15','77',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','EFD401KHSAZ0','1','D','15','78',NULL,'SPECIAL TAX TYPE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFD401KHSAZ0','1','D','15','79',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','EFD401KHSAZ0','1','D','15','80',NULL,'BENE/QDRO PAYEE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','20','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','20','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','20','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','20','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','6','D','20','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"02"','6','(''DA''=''F'')','EFD401KHSAZ0','2','D','20','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D"','7','(''DA''=''F'')','EFD401KHSAZ0','1','D','20','32',NULL,'FIELD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EFD401KHSAZ0','4','D','20','33',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','9','(''UDMDY''=''F'')','EFD401KHSAZ0','8','D','20','37',NULL,'HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000000"','10','(''DA''=''F'')','EFD401KHSAZ0','8','D','20','45',NULL,'PARTICIPATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVestingDate"','11','(''UDMDY''=''F'')','EFD401KHSAZ0','8','D','20','53',NULL,'VESTING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','12','(''UDMDY''=''F'')','EFD401KHSAZ0','8','D','20','61',NULL,'DATE-OF-BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','13','(''UA''=''F'')','EFD401KHSAZ0','8','D','20','69',NULL,'TERMINATION DATE ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateSwitch"','14','(''UDMDY''=''F'')','EFD401KHSAZ0','1','D','20','77',NULL,'DATE SWITCH ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EFD401KHSAZ0','1','D','20','78',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EFD401KHSAZ0','1','D','20','79',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EFD401KHSAZ0','1','D','20','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','25','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','25','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','25','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','25','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','6','D','25','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"02"','6','(''DA''=''F'')','EFD401KHSAZ0','2','D','25','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E"','7','(''DA''=''F'')','EFD401KHSAZ0','1','D','25','32',NULL,'FIELD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','8','(''UA''=''F'')','EFD401KHSAZ0','11','D','25','33',NULL,'EMPLOYEE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EFD401KHSAZ0','1','D','25','44',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFD401KHSAZ0','2','D','25','45',NULL,'EMPLOYEE NUMBER STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','EFD401KHSAZ0','12','D','25','47',NULL,'CLIENT PROVIDED ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','EFD401KHSAZ0','22','D','25','59',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','30','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','30','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','30','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','30','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','6','D','30','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"03"','6','(''DA''=''F'')','EFD401KHSAZ0','2','D','30','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P"','7','(''DA''=''F'')','EFD401KHSAZ0','1','D','30','32',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLineNo"','8','(''UA''=''F'')','EFD401KHSAZ0','2','D','30','33',NULL,'ADDRESS LINE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine"','9','(''UA''=''F'')','EFD401KHSAZ0','32','D','30','35',NULL,'ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFD401KHSAZ0','11','D','30','67',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','EFD401KHSAZ0','1','D','30','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','EFD401KHSAZ0','1','D','30','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFD401KHSAZ0','1','D','30','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','35','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','35','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','35','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','35','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','6','D','35','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"04"','6','(''DA''=''F'')','EFD401KHSAZ0','2','D','35','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P"','7','(''DA''=''F'')','EFD401KHSAZ0','1','D','35','32',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','8','(''UA''=''F'')','EFD401KHSAZ0','20','D','35','33',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','9','(''UA''=''F'')','EFD401KHSAZ0','2','D','35','53',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFD401KHSAZ0','8','D','35','55',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','11','(''UA''=''F'')','EFD401KHSAZ0','5','D','35','63',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode4"','12','(''UA''=''F'')','EFD401KHSAZ0','4','D','35','68',NULL,'ZIP + 4 CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFD401KHSAZ0','6','D','35','72',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','EFD401KHSAZ0','1','D','35','78',NULL,'DATA SEARCH INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EFD401KHSAZ0','1','D','35','79',NULL,'OMIT STATEMENT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EFD401KHSAZ0','1','D','35','80',NULL,'ASSOCIATION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','40','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','40','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','40','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','40','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','6','D','40','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"06"','6','(''DA''=''F'')','EFD401KHSAZ0','2','D','40','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','7','(''DA''=''F'')','EFD401KHSAZ0','20','D','40','32',NULL,'DIVISION NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PENNSYLVANIA"','8','(''DA''=''F'')','EFD401KHSAZ0','20','D','40','52',NULL,'REGION NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EFD401KHSAZ0','3','D','40','72',NULL,'SITE SECURITY CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFD401KHSAZ0','4','D','40','75',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','EFD401KHSAZ0','2','D','40','79',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','45','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','45','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','45','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','45','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','6','D','45','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"11"','6','(''DA''=''F'')','EFD401KHSAZ0','2','D','45','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode"','7','(''UA''=''F'')','EFD401KHSAZ0','1','D','45','32',NULL,'STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EFD401KHSAZ0','5','D','45','33',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusChangeDate"','9','(''UDMDY''=''F'')','EFD401KHSAZ0','8','D','45','38',NULL,'STATUS CHANGE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFD401KHSAZ0','1','D','45','46',NULL,'LITERATURE KIT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','EFD401KHSAZ0','32','D','45','47',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','EFD401KHSAZ0','1','D','45','79',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFD401KHSAZ0','1','D','45','80',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','50','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','50','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','50','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','50','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','6','D','50','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"60"','6','(''DA''=''F'')','EFD401KHSAZ0','2','D','50','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantClass"','7','(''UA''=''F'')','EFD401KHSAZ0','1','D','50','32',NULL,'PARTICIPANT CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EFD401KHSAZ0','8','D','50','33',NULL,'PARTICIPANT DISTRICT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EFD401KHSAZ0','8','D','50','41',NULL,'PARTICIPANT DEPARTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFD401KHSAZ0','8','D','50','49',NULL,'PARTICIPANT LOCATION/STORE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NU"','11','(''DA''=''F'')','EFD401KHSAZ0','8','D','50','57',NULL,'PARTICIPANT UNION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantPaymentFreq"','12','(''UA''=''F'')','EFD401KHSAZ0','1','D','50','65',NULL,'PARTICIPANT PAYMENT FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFD401KHSAZ0','8','D','50','66',NULL,'MISCELLANEOUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','EFD401KHSAZ0','1','D','50','74',NULL,'HIGHLY COMPENSATED FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EFD401KHSAZ0','1','D','50','75',NULL,'OFFICER / 16 (B) FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EFD401KHSAZ0','1','D','50','76',NULL,'DE MINIMUS ELIGIBILITY INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EFD401KHSAZ0','1','D','50','77',NULL,'AGE PAYOUT ELIGIBILITY INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EFD401KHSAZ0','1','D','50','78',NULL,'PARTICIPANT RESTRICTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EFD401KHSAZ0','2','D','50','79',NULL,'PARTICIPANT RESTRICTION REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','55','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','55','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','55','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','55','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','6','D','55','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"61"','6','(''DA''=''F'')','EFD401KHSAZ0','2','D','55','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''F'')','EFD401KHSAZ0','8','D','55','32',NULL,'ELIGIBILITY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedDateOfHire"','8','(''UDMDY''=''F'')','EFD401KHSAZ0','8','D','55','40',NULL,'ADJUSTED DATE OF HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000000"','9','(''DA''=''F'')','EFD401KHSAZ0','8','D','55','48',NULL,'RETIREMENT DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFD401KHSAZ0','5','D','55','56',NULL,'PRE-BREAK SERVICE UNITS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','EFD401KHSAZ0','8','D','55','61',NULL,'BIS ACCRUAL START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','EFD401KHSAZ0','12','D','55','69',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','60','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','60','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','60','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','60','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','1','D','60','24',NULL,'EMPLOYEEID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''F'')','EFD401KHSAZ0','5','D','60','25',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EA"','7','(''DA''=''F'')','EFD401KHSAZ0','2','D','60','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','8','(''DA''=''F'')','EFD401KHSAZ0','1','D','60','32',NULL,'E-MAIL ADDRESS STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ER"','9','(''DA''=''F'')','EFD401KHSAZ0','2','D','60','33',NULL,'E-MAIL TYPE CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFD401KHSAZ0','2','D','60','35',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailRecSeqNumber"','11','(''UA''=''F'')','EFD401KHSAZ0','1','D','60','37',NULL,'E-MAIL RECORD SEQUENCE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','12','(''UA''=''F'')','EFD401KHSAZ0','35','D','60','38',NULL,'E-MAIL ADDRESS TEXT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFD401KHSAZ0','1','D','60','73',NULL,'NON SAFE HARBOR INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','EFD401KHSAZ0','1','D','60','74',NULL,'EDELIVERY CONSENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EFD401KHSAZ0','6','D','60','75',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','65','1',NULL,'HSA PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','65','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','65','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','65','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','1','D','65','24',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''F'')','EFD401KHSAZ0','5','D','65','25',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HS"','7','(''DA''=''F'')','EFD401KHSAZ0','2','D','65','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYear"','8','(''UA''=''F'')','EFD401KHSAZ0','4','D','65','32',NULL,'PLAN year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTier"','9','(''UA''=''F'')','EFD401KHSAZ0','2','D','65','36',NULL,'coverage tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDHP1"','10','(''DA''=''F'')','EFD401KHSAZ0','5','D','65','38',NULL,'HDHP id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatusDate"','11','(''UDMDY''=''F'')','EFD401KHSAZ0','8','D','65','43',NULL,'ENROLLMENT Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus"','12','(''UA''=''F'')','EFD401KHSAZ0','1','D','65','51',NULL,'Enrollment STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientBillingFlag"','13','(''UA''=''F'')','EFD401KHSAZ0','1','D','65','52',NULL,'CLIENT BILLING FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','EFD401KHSAZ0','1','D','65','53',NULL,'Simple acknowledgement indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EFD401KHSAZ0','8','D','65','54',NULL,'simple acknowledgement date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EFD401KHSAZ0','19','D','65','62',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','70','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','70','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','70','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','70','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','1','D','70','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','6','(''DA''=''F'')','EFD401KHSAZ0','5','D','70','25',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"19"','7','(''DA''=''F'')','EFD401KHSAZ0','2','D','70','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EFD401KHSAZ0','4','D','70','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"220"','9','(''DA''=''F'')','EFD401KHSAZ0','3','D','70','36',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFD401KHSAZ0','2','D','70','39',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource"','11','(''UA''=''F'')','EFD401KHSAZ0','2','D','70','41',NULL,'SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','12','(''DA''=''F'')','EFD401KHSAZ0','2','D','70','43',NULL,'ITEM NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFD401KHSAZ0','1','D','70','45',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmount"','14','(''UA''=''F'')','EFD401KHSAZ0','13','D','70','46',NULL,'AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EFD401KHSAZ0','4','D','70','59',NULL,'RESERVED (space-fill)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiscalYear"','16','(''UA''=''F'')','EFD401KHSAZ0','4','D','70','63',NULL,'FISCAL YEAR (current year default)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EFD401KHSAZ0','1','D','70','67',NULL,'CORRECTION METHOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostingDate"','18','(''UDMDY''=''F'')','EFD401KHSAZ0','8','D','70','68',NULL,'POSTING DATE (HSA)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EFD401KHSAZ0','5','D','70','76',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNumber"','1','(''UA''=''F'')','EFD401KHSAZ0','5','D','75','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLUS"','2','(''DA''=''F'')','EFD401KHSAZ0','4','D','75','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EFD401KHSAZ0','3','D','75','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''F'')','EFD401KHSAZ0','11','D','75','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EFD401KHSAZ0','1','D','75','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000"','6','(''DA''=''F'')','EFD401KHSAZ0','5','D','75','25',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"21"','7','(''DA''=''F'')','EFD401KHSAZ0','2','D','75','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EFD401KHSAZ0','4','D','75','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanIdentification"','9','(''UA''=''F'')','EFD401KHSAZ0','12','D','75','36',NULL,'LOAN IDENTIFICATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFD401KHSAZ0','1','D','75','48',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"260"','11','(''DA''=''F'')','EFD401KHSAZ0','3','D','75','49',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"14"','12','(''DA''=''F'')','EFD401KHSAZ0','2','D','75','52',NULL,'ITEM NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','13','(''DA''=''F'')','EFD401KHSAZ0','2','D','75','54',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','EFD401KHSAZ0','1','D','75','56',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRepaymentAmount"','15','(''UA''=''F'')','EFD401KHSAZ0','7','D','75','57',NULL,'REPAYMENT AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EFD401KHSAZ0','1','D','75','64',NULL,'CORRECTION METHOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EFD401KHSAZ0','8','D','75','65',NULL,'POSTING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EFD401KHSAZ0','1','D','75','73',NULL,'PRINCIPAL ONLY FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EFD401KHSAZ0','1','D','75','74',NULL,'NEW REPAYMENT FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EFD401KHSAZ0','6','D','75','75',NULL,'Master Remitter: ',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EFD401KHSA_20210324.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202103159','EMPEXPORT','OEACTIVE','Mar  3 2021  1:54PM','EFD401KHSA',NULL,NULL,NULL,'202103159','Feb 24 2021 12:34PM','Feb 24 2021 12:34PM','202103151','104','','','202103151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202103159','EMPEXPORT','OEPASSIVE','Mar  3 2021  1:56PM','EFD401KHSA',NULL,NULL,NULL,'202103159','Feb 24 2021 12:34PM','Feb 24 2021 12:34PM','202103151','3487','','','202103151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Fidelity 401K HSA Export','202103159','EMPEXPORT','ONDEM_XOE','Mar  3 2021  1:57PM','EFD401KHSA',NULL,NULL,NULL,'202103159','Feb 24 2021 12:34PM','Feb 24 2021 12:34PM','202103151','3522','','','202103151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Fidelity 401K HSA Export-Sched','202103159','EMPEXPORT','SCH_EFD401','Mar  3 2021  1:57PM','EFD401KHSA',NULL,NULL,NULL,'202103159','Feb 24 2021 12:34PM','Feb 24 2021 12:34PM','202103151','3522','','','202103151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','JEY43',NULL,NULL,NULL,'Fidelity 401K HSA Export-Test','202102269','EMPEXPORT','TEST_XOE','Mar 23 2021 12:49PM','EFD401KHSA',NULL,NULL,NULL,'202102269','Feb 26 2021 12:00AM','Dec 30 1899 12:00AM','202102261','363','eecPayGroup','SEMIE,SEMI','202102261',dbo.fn_GetTimedKey(),NULL,'us3jBePLA1016',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFD401KHSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFD401KHSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFD401KHSA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFD401KHSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFD401KHSA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EFD401KHSA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EFD401KHSA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EFD401KHSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFD401KHSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D10','dbo.U_EFD401KHSA_drvTbl_TestHeader',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D15','dbo.U_EFD401KHSA_drvTbl_01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D20','dbo.U_EFD401KHSA_drvTbl_02D',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D25','dbo.U_EFD401KHSA_drvTbl_02E',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D30','dbo.U_EFD401KHSA_drvTbl_03',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D35','dbo.U_EFD401KHSA_drvTbl_04',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D40','dbo.U_EFD401KHSA_drvTbl_06',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D45','dbo.U_EFD401KHSA_drvTbl_11',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D50','dbo.U_EFD401KHSA_drvTbl_60',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D55','dbo.U_EFD401KHSA_drvTbl_61',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D60','dbo.U_EFD401KHSA_drvTbl_EA',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D65','dbo.U_EFD401KHSA_drvTbl_HS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D70','dbo.U_EFD401KHSA_drvTbl_19',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFD401KHSA','D75','dbo.U_EFD401KHSA_drvTbl_21',NULL);
IF OBJECT_ID('U_dsi_BDM_EFD401KHSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFD401KHSA] (
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
IF OBJECT_ID('U_EFD401KHSA_Audit') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_Audit] (
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
IF OBJECT_ID('U_EFD401KHSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EFD401KHSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_01') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_01] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirstMiddle] varchar(102) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] char(1) NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_02D') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_02D] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvHireDate] datetime NULL,
    [drvVestingDate] datetime NULL,
    [drvDateOfBirth] datetime NULL,
    [drvTerminationDate] nvarchar(4000) NULL,
    [drvDateSwitch] varchar(1) NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_02E') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_02E] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEmployeeNumber] char(9) NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_03') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_03] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(18) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvAddressLineNo] varchar(2) NOT NULL,
    [drvAddressLine] varchar(255) NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_04') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_04] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvAddressZipCode4] varchar(4) NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_06') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_06] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_11') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_11] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvStatusCode] varchar(1) NULL,
    [drvStatusChangeDate] datetime NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_19') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_19] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvSource] varchar(2) NULL,
    [drvAmount] nvarchar(4000) NULL,
    [drvFiscalYear] nvarchar(4000) NULL,
    [drvPostingDate] datetime NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_21') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_21] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvLoanIdentification] varchar(6) NULL,
    [drvRepaymentAmount] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_60') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_60] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvParticipantClass] char(1) NULL,
    [drvParticipantPaymentFreq] varchar(1) NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_61') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_61] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvAdjustedDateOfHire] datetime NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_EA') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_EA] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEmailRecSeqNumber] int NOT NULL,
    [drvEmailAddress] varchar(35) NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_HS') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_HS] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(16) NULL,
    [drvPlanNumber] varchar(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvPlanYear] nvarchar(4000) NULL,
    [drvCoverageTier] varchar(2) NULL,
    [drvEnrollmentStatusDate] datetime NULL,
    [drvEnrollmentStatus] varchar(1) NOT NULL,
    [drvClientBillingFlag] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EFD401KHSA_drvTbl_TestHeader') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_drvTbl_TestHeader] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(1) NOT NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvTestIdentifier] varchar(7) NOT NULL
);
IF OBJECT_ID('U_EFD401KHSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFD401KHSA_Employees') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_Employees] (
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
    [EecPayGroup] char(6) NULL,
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
    [EecLeaveReason] char(6) NULL
);
IF OBJECT_ID('U_EFD401KHSA_File') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);
IF OBJECT_ID('U_EFD401KHSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPayDate] datetime NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh4OPROPAmt] numeric NULL,
    [Pdh401MAmt] numeric NULL,
    [PdhHSAAmt] numeric NULL
);
IF OBJECT_ID('U_EFD401KHSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFD401KHSA_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFD401KHSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Plate Plus

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 02/24/2021
Service Request Number: TekP-2020-10-28-0002

Purpose: Fidelity 401K HSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFD401KHSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFD401KHSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFD401KHSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFD401KHSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFD401KHSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFD401KHSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFD401KHSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFD401KHSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFD401KHSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFD401KHSA', 'SCH_EFD401';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFD401KHSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFD401KHSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFD401KHSA';

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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EFD401KHSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_AuditFields;
    CREATE TABLE dbo.U_EFD401KHSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecDateOfRetirement');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecEmpNo');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpComp','EecUnionLocal');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('EmpPers','EepEmailAddress');

    INSERT INTO dbo.U_EFD401KHSA_AuditFields VALUES ('OrgLevel','OrgDesc');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EFD401KHSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_Audit;
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
    INTO dbo.U_EFD401KHSA_Audit
    FROM dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EFD401KHSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @EndDate -30 AND @EndDate 
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';





    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFD401KHSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFD401KHSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EFD401KHSA_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '40P,ROP,401M,HSAF,HSAI,HSACF,HSACI,HSAER,401L,401L2';

    IF OBJECT_ID('U_EFD401KHSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFD401KHSA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

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

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFD401KHSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
         ,PdhPayDate = MAX(PdhPayDate)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh4OPROPAmt     = SUM(CASE WHEN PdhDedCode IN ('40P','ROP') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401MAmt     = SUM(CASE WHEN PdhDedCode IN ('401M') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhHSAAmt     = SUM(CASE WHEN PdhDedCode IN ('HSACF','HSACI','HSAF','HSAI','HSAER') THEN PdhEECurAmt ELSE 0.00 END)        
        /*,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)*/
    INTO dbo.U_EFD401KHSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFD401KHSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EFD401KHSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
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
    INTO dbo.U_EFD401KHSA_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;



    -------------------------------
    -- Working Table - Employees
    -------------------------------
    IF OBJECT_ID('U_EFD401KHSA_Employees','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_Employees;
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
        ,EecPayGroup
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
    INTO dbo.U_EFD401KHSA_Employees
    FROM dbo.U_EFD401KHSA_EEList
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

        FROM dbo.U_EFD401KHSA_Audit
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID;

    Delete from U_EFD401KHSA_Employees where xeeid not in ( Select xeeid from U_EFD401KHSA_Employees  where Record60Change = 'Y' or Record61Change = 'Y' or emailAddress = 'Y')






    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_TestHeader
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_TestHeader','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_TestHeader;
    SELECT DISTINCT
         drvEEID = '' --xEEID
        ,drvCoID = '' --xCoID
        ,drvDepRecID = '' --CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '1'
        -- standard fields above and additional driver fields below
        ,drvTestIdentifier = 'TESTEDT'
    INTO dbo.U_EFD401KHSA_drvTbl_TestHeader
    WHERE @ExportCode LIKE '%TEST%' -- ONLY send this record if a test file is being created
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_01
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_01;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 1'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvNameLast = EepNameLast
        ,drvNameFirstMiddle = EepNameFirst + ' ' + ISNULL(LEFT(EepNameMiddle, 1), '') 
        ,drvMaritalStatus =    CASE WHEN eepMaritalStatus IN ('S','D','W') THEN 'S'
                                WHEN EepMaritalStatus IN ('M') THEN 'M'
                            END
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
    INTO dbo.U_EFD401KHSA_drvTbl_01
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK)
    --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID        
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE Record01Change = 'Y' or audNewHire = 'Y' or  audReHire = 'Y'    
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_02D
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_02D','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_02D;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 2'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvHireDate = EecDateOfOriginalHire
        ,drvVestingDate = EecDateOfSeniority
        ,drvDateOfBirth = EepDateOfBirth
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN FORMAT(EecDateOfTermination, 'MMddyyyy') ELSE '00000000' END
        ,drvDateSwitch = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN '5' END
    INTO dbo.U_EFD401KHSA_drvTbl_02D
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK)
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    --JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
    --    ON EecEEID = xEEID 
    --    AND EecCoID = xCoID
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE Record02DChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y' or audTerm = 'Y' ;
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_02E
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_02E','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_02E;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 3'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvEmployeeNumber = EecEmpNo
    INTO dbo.U_EFD401KHSA_drvTbl_02E
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK)
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    /*JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID*/
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE Record02EChange = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_03
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_03','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_03;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 4' + ' 1'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvAddressLineNo = '01'
        ,drvAddressLine = EepAddressLine1
    INTO dbo.U_EFD401KHSA_drvTbl_03
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK)
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y';
    ;

    INSERT INTO dbo.U_EFD401KHSA_drvTbl_03
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 4' + ' 2'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvAddressLineNo = '02'
        ,drvAddressLine = EepAddressLine2    
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK)
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    /*JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID*/
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y'
    ;

    INSERT INTO dbo.U_EFD401KHSA_drvTbl_03
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 4' + ' 3'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvAddressLineNo = '03'
        ,drvAddressLine = ''
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK)
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_04
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_04','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_04;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 5'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode, 5)
        ,drvAddressZipCode4 = CASE WHEN LEN(RTRIM(EepAddressZipCode)) > 5 THEN RIGHT(RTRIM(EepAddressZipCode), 4) END
    INTO dbo.U_EFD401KHSA_drvTbl_04
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK)
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_06
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_06','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_06;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 6'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
    INTO dbo.U_EFD401KHSA_drvTbl_06
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK)
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    /*JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID*/
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_11
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_11','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_11;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 7'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvStatusCode =    CASE WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire NOT BETWEEN @StartDate AND @EndDate THEN 'A'
                                WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN 'E'
                                WHEN EecEmplStatus = 'L' AND EecLeaveReason = '300' THEN 'W'
                                WHEN EecEmplStatus = 'L' THEN 'L'
                                WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire BETWEEN @StartDate AND @EndDate THEN 'N'
                                WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN 'T'
                                WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') THEN 'D'
                            END
        ,drvStatusChangeDate = CASE WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire NOT BETWEEN @StartDate AND @EndDate THEN EecDateOfOriginalHire
                                WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire
                                WHEN EecEmplStatus = 'L' AND EecLeaveReason = '300' THEN EecEmplStatusStartDate
                                WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                WHEN EecEmplStatus = 'A' AND EecDateOfOriginalHire BETWEEN @StartDate AND @EndDate THEN EecDateOfOriginalHire
                                WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN EecDateOfTermination
                                WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') THEN EecDateOfTermination
                            END
    INTO dbo.U_EFD401KHSA_drvTbl_11
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK)
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    /*JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID*/
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_60
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_60','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_60;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 8'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvParticipantClass = CASE WHEN EecFullTimeOrPartTime IN ('F','P') THEN EecFullTimeOrPartTime END
        ,drvParticipantPaymentFreq =    CASE WHEN PgrPayFrequency = 'S' THEN '2'
                                            WHEN PgrPayFrequency = 'W' THEN 'W'
                                        END
    INTO dbo.U_EFD401KHSA_drvTbl_60
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK) 
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    /*JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID*/
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE Record03Change = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_61
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_61','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_61;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' 9'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvAdjustedDateOfHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
    INTO dbo.U_EFD401KHSA_drvTbl_61
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK) 
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    /*JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID*/
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE audReHire = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_EA
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_EA','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_EA;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' A'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvEmailRecSeqNumber = 1
        ,drvEmailAddress = LEFT(EepAddressEMail, 35)
    INTO dbo.U_EFD401KHSA_drvTbl_EA
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK) 
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    /*JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID*/
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE emailAddress = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y'
    ;


    INSERT INTO dbo.U_EFD401KHSA_drvTbl_EA
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' B'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvEmailRecSeqNumber = 2
        ,drvEmailAddress = RIGHT(EepAddressEMail, LEN(EepAddressEmail) - 35) 
    FROM dbo.U_EFD401KHSA_Employees WITH (NOLOCK) 
        --dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    /*JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID*/
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2','401M','ROP','40P')
    WHERE LEN(EepAddressEMail) > 35
    AND (emailAddress = 'Y'  or audNewHire = 'Y' or  audReHire = 'Y')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_HS
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_HS','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_HS;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' C'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI') THEN '91507' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvPlanYear = FORMAT(DATEPART(YEAR, GETDATE()), '0000')
        ,drvCoverageTier =    CASE WHEN BdmDedCode IN ('HSAI','HSACI') THEN '05'
                                WHEN BdmDedCode IN ('HSACF','HSAF') THEN '13'
                            END
        ,drvEnrollmentStatusDate = BdmBenStartDate
        ,drvEnrollmentStatus = CASE WHEN BdmBenStatus IN ('T','C') THEN 'I' ELSE 'A' END
        ,drvClientBillingFlag = CASE WHEN EecEmplStatus = 'T' THEN 'N' ELSE 'Y' END
    INTO dbo.U_EFD401KHSA_drvTbl_HS
    FROM dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI') 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_19
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_19','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_19;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' D'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber =    CASE WHEN BdmDedCode IN ('401L','401L2','401M','ROP','40P') THEN '29475'
                                WHEN BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI','HSAER') THEN '91507' 
                            END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvSource =    CASE WHEN BdmDedCode IN ('40P') THEN '01'
                            WHEN BdmDedCode IN ('ROP') THEN '02'
                            WHEN BdmDedCode IN ('401M') THEN '03'
                            WHEN BdmDedCode IN ('HSAF','HSAI') THEN '01'
                            WHEN BdmDedCode IN ('HSACF','HSACI') THEN '02'
                            WHEN BdmDedCode IN ('HSAER') THEN '04'
                        END
        ,drvAmount = FORMAT(
                            CASE WHEN BdmDedCode IN ('40P','ROP') THEN Pdh4OPROPAmt
                            END, '00000000000')
        ,drvFiscalYear = CASE WHEN BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI','HSAER') THEN FORMAT(DATEPART(YEAR,GETDATE()), '0000') END
        ,drvPostingDate = CASE WHEN BdmDedCode IN ('HSACF','HSACI','HSAF','HSAI','HSAER') THEN PdhPayDate END
    INTO dbo.U_EFD401KHSA_drvTbl_19
    FROM dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401M','ROP','40P','HSACF','HSACI','HSAF','HSAI','HSAER')
    JOIN dbo.U_EFD401KHSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    ;

    /*Pdh4OPROPAmt     = SUM(CASE WHEN PdhDedCode IN ('40P','ROP') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401MAmt     = SUM(CASE WHEN PdhDedCode IN ('401M') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhHSAAmt     = SUM(CASE WHEN PdhDedCode IN ('HSACF','HSACI','HSAF','HSAI','HSAER') T*/
    ---------------------------------
    -- DETAIL RECORD - U_EFD401KHSA_drvTbl_21
    ---------------------------------
    IF OBJECT_ID('U_EFD401KHSA_drvTbl_21','U') IS NOT NULL
        DROP TABLE dbo.U_EFD401KHSA_drvTbl_21;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '2 ' + xEEID + ' E'
        -- standard fields above and additional driver fields below
        ,drvPlanNumber = CASE WHEN BdmDedCode IN ('401L','401L2') THEN '29475' END
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(RTRIM(eepSSN),5), 2) + '-' + RIGHT(RTRIM(EepSSN), 4)
        ,drvLoanIdentification = CASE WHEN BdmDedCode IN ('401L','401L2') THEN 'LOAN 1' END
        ,drvRepaymentAmount = FORMAT(PdhEECurAmt*100, '00000')
    INTO dbo.U_EFD401KHSA_drvTbl_21
    FROM dbo.U_EFD401KHSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFD401KHSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmDedCode IN ('401L','401L2')
    JOIN dbo.U_EFD401KHSA_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
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
ALTER VIEW dbo.dsi_vwEFD401KHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFD401KHSA_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFD401KHSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202103151'
       ,expStartPerControl     = '202103151'
       ,expLastEndPerControl   = '202103159'
       ,expEndPerControl       = '202103159'
WHERE expFormatCode = 'EFD401KHSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFD401KHSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFD401KHSA_File (NOLOCK)
    ORDER BY InitialSort, SubSort;