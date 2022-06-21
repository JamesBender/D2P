SET NOCOUNT ON;
IF OBJECT_ID('U_EFIDDEMO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDDEMO_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFIDDEMO_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFIDDEMO' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFIDDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFIDDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFIDDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDDEMO];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_EFIDDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_EFIDDEMO];
GO
IF OBJECT_ID('U_EFIDDEMO_Pearhist') IS NOT NULL DROP TABLE [dbo].[U_EFIDDEMO_Pearhist];
GO
IF OBJECT_ID('U_EFIDDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_EFIDDEMO_File];
GO
IF OBJECT_ID('U_EFIDDEMO_EEList_Detail') IS NOT NULL DROP TABLE [dbo].[U_EFIDDEMO_EEList_Detail];
GO
IF OBJECT_ID('U_EFIDDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFIDDEMO_EEList];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_Header') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_Header];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_EA') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_EA];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_Audit') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_Audit];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_63') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_63];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_61') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_61];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_60') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_60];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_36') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_36];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_11') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_11];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_08') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_08];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_06') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_06];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_05') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_05];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_04') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_04];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_03') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_03];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_02E') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_02E];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_02D') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_02D];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_01') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_01];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFIDDEMO';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFIDDEMO';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFIDDEMO';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFIDDEMO';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFIDDEMO';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EFIDDEMO','Fidelity 401(k) Demographic  Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_switchbox_v2','80','S','N','EFIDDEMOZ0','N',NULL,'C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFIDDEMO' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','H','00','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','2','(''UA''=''F'')','EFIDDEMOZ0','3','H','00','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','1','H','00','9','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvTypeOfAccount"','4','(''UA''=''F'')','EFIDDEMOZ0','15','H','00','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','H','00','25','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvClientName"','6','(''UA''=''F'')','EFIDDEMOZ0','25','H','00','31','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvChangesOnlyFileIndicator"','7','(''UA''=''F'')','EFIDDEMOZ0','1','H','00','56','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','8','(''UA''=''F'')','EFIDDEMOZ0','24','H','00','57','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','10','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupID"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','10','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','10','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','10','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','10','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','10','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvLastName"','7','(''UA''=''F'')','EFIDDEMOZ0','20','D','10','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFirstNameMiddleInitial"','8','(''UA''=''F'')','EFIDDEMOZ0','15','D','10','52','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved"','9','(''UA''=''F'')','EFIDDEMOZ0','9','D','10','67','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvMaritalStatus"','10','(''UA''=''F'')','EFIDDEMOZ0','1','D','10','76','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvGender"','11','(''UA''=''F'')','EFIDDEMOZ0','1','D','10','77','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSpecialTaxTypeID"','12','(''UA''=''F'')','EFIDDEMOZ0','1','D','10','78','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','13','(''UA''=''F'')','EFIDDEMOZ0','2','D','10','79','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','15','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupID"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','15','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','15','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','15','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','15','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','15','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFieldType"','7','(''UA''=''F'')','EFIDDEMOZ0','1','D','15','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','8','(''UA''=''F'')','EFIDDEMOZ0','4','D','15','33','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvHireDate"','9','(''UA''=''F'')','EFIDDEMOZ0','8','D','15','37','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvParticipationDate"','10','(''UA''=''F'')','EFIDDEMOZ0','8','D','15','45','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvVestingDate"','11','(''UA''=''F'')','EFIDDEMOZ0','8','D','15','53','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBirthDate"','12','(''UA''=''F'')','EFIDDEMOZ0','8','D','15','61','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvTerminationDate"','13','(''UA''=''F'')','EFIDDEMOZ0','8','D','15','69','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvDateSwitch"','14','(''UA''=''F'')','EFIDDEMOZ0','1','D','15','77','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved"','15','(''UA''=''F'')','EFIDDEMOZ0','1','D','15','78','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller4"','16','(''UA''=''F'')','EFIDDEMOZ0','1','D','15','79','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvAssociationIndicator"','17','(''UA''=''F'')','EFIDDEMOZ0','1','D','15','80','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','20','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupID"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','20','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','20','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','20','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','20','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','20','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvStatusCode"','7','(''UA''=''F'')','EFIDDEMOZ0','1','D','20','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','8','(''UA''=''F'')','EFIDDEMOZ0','13','D','20','33','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvLitKitSw"','9','(''UA''=''F'')','EFIDDEMOZ0','1','D','20','46','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller4"','10','(''UA''=''F'')','EFIDDEMOZ0','34','D','20','47','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','25','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupID"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','25','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','25','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','25','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','25','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','25','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFieldType"','7','(''UA''=''F'')','EFIDDEMOZ0','1','D','25','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvAddressLineNumber"','8','(''UA''=''F'')','EFIDDEMOZ0','2','D','25','33','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvAddress"','9','(''UA''=''F'')','EFIDDEMOZ0','32','D','25','35','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','10','(''UA''=''F'')','EFIDDEMOZ0','11','D','25','67','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvMailingIndicator"','11','(''UA''=''F'')','EFIDDEMOZ0','1','D','25','78','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvOmitStatementIndicator"','12','(''UA''=''F'')','EFIDDEMOZ0','1','D','25','79','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvAssociationIndicator"','13','(''UA''=''F'')','EFIDDEMOZ0','1','D','25','80','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','30','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupID"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','30','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','30','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','30','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','30','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','30','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordType"','7','(''UA''=''F'')','EFIDDEMOZ0','1','D','30','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvCity"','8','(''UA''=''F'')','EFIDDEMOZ0','20','D','30','33','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvState"','9','(''UA''=''F'')','EFIDDEMOZ0','2','D','30','53','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','10','(''UA''=''F'')','EFIDDEMOZ0','8','D','30','55','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvZipCode"','11','(''UA''=''F'')','EFIDDEMOZ0','5','D','30','63','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvZipPlus4Code"','12','(''UA''=''F'')','EFIDDEMOZ0','4','D','30','68','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller4"','13','(''UA''=''F'')','EFIDDEMOZ0','6','D','30','72','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvDataSearchIndicator"','14','(''UA''=''F'')','EFIDDEMOZ0','1','D','30','78','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvOmitStatementIndicator"','15','(''UA''=''F'')','EFIDDEMOZ0','1','D','30','79','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvAssociationIndicator"','16','(''UA''=''F'')','EFIDDEMOZ0','1','D','30','80','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','35','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupID"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','35','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','35','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','35','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','35','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','35','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordType"','7','(''UA''=''F'')','EFIDDEMOZ0','1','D','35','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvCountry"','8','(''UA''=''F'')','EFIDDEMOZ0','23','D','35','33','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','9','(''UA''=''F'')','EFIDDEMOZ0','1','D','35','56','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSpecialHandling"','10','(''UA''=''F'')','EFIDDEMOZ0','1','D','35','57','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller4"','11','(''UA''=''F'')','EFIDDEMOZ0','19','D','35','58','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvMailingIndicator"','12','(''UA''=''F'')','EFIDDEMOZ0','1','D','35','77','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvDataSearchIndicator"','13','(''UA''=''F'')','EFIDDEMOZ0','1','D','35','78','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvOmitStatementIndicator"','14','(''UA''=''F'')','EFIDDEMOZ0','1','D','35','79','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvAssociationIndicator"','15','(''UA''=''F'')','EFIDDEMOZ0','1','D','35','80','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','40','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupNumber"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','40','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','40','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','40','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','40','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','40','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvParticipantClass"','7','(''UA''=''F'')','EFIDDEMOZ0','1','D','40','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvParticipantDistrict"','8','(''UA''=''F'')','EFIDDEMOZ0','8','D','40','33','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvParticipantDepartment"','9','(''UA''=''F'')','EFIDDEMOZ0','8','D','40','41','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvParticipantLocationStore"','10','(''UA''=''F'')','EFIDDEMOZ0','8','D','40','49','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvParticipantUnionCode"','11','(''UA''=''F'')','EFIDDEMOZ0','8','D','40','57','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvParticipantPaymentFrequency"','12','(''UA''=''F'')','EFIDDEMOZ0','1','D','40','65','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvMiscellaneousCode"','13','(''UA''=''F'')','EFIDDEMOZ0','8','D','40','66','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvHighlyCompensatedFlag"','14','(''UA''=''F'')','EFIDDEMOZ0','1','D','40','74','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvOffice16BFlag"','15','(''UA''=''F'')','EFIDDEMOZ0','1','D','40','75','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvDeMinimusEligibilityIndicator"','16','(''UA''=''F'')','EFIDDEMOZ0','1','D','40','76','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvAgePayoutEligibilityIndicator"','17','(''UA''=''F'')','EFIDDEMOZ0','1','D','40','77','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvParticipantRestrictionCode"','18','(''UA''=''F'')','EFIDDEMOZ0','1','D','40','78','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvParticipantRestrictionReason"','19','(''UA''=''F'')','EFIDDEMOZ0','2','D','40','79','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','45','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupNumber"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','45','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','45','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','45','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','45','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','45','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvEligibilityDate"','7','(''UA''=''F'')','EFIDDEMOZ0','8','D','45','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvAdjustedDateOfHire"','8','(''UA''=''F'')','EFIDDEMOZ0','8','D','45','40','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRetirementDate"','9','(''UA''=''F'')','EFIDDEMOZ0','8','D','45','48','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPreBreakServiceUnites"','10','(''UA''=''F'')','EFIDDEMOZ0','5','D','45','56','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBisAcrrualStartDate"','11','(''UA''=''F'')','EFIDDEMOZ0','8','D','45','61','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','12','(''UA''=''F'')','EFIDDEMOZ0','12','D','45','69','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','50','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupNumber"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','50','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','50','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','50','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','50','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','50','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvDivisionName"','7','(''UA''=''F'')','EFIDDEMOZ0','20','D','50','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRegionName"','8','(''UA''=''F'')','EFIDDEMOZ0','20','D','50','52','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','9','(''UA''=''F'')','EFIDDEMOZ0','3','D','50','72','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved"','10','(''UA''=''F'')','EFIDDEMOZ0','4','D','50','75','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller4"','11','(''UA''=''F'')','EFIDDEMOZ0','2','D','50','79','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','51','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupNumber"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','51','6','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','51','10','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','51','13','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','51','24','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','51','30','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','7','(''UA''=''F'')','EFIDDEMOZ0','4','D','51','32',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvDivisionCode"','8','(''UA''=''F'')','EFIDDEMOZ0','4','D','51','36','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','9','(''UA''=''F'')','EFIDDEMOZ0','40','D','51','40','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivCodeExists"','10','(''UA''=''F'')','EFIDDEMOZ0','1','D','51','80','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','52','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupNumber"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','52','6','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','52','10','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','52','13','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved"','5','(''UA''=''F'')','EFIDDEMOZ0','1','D','52','24','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvZeros"','6','(''UA''=''F'')','EFIDDEMOZ0','5','D','52','25','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','7','(''UA''=''F'')','EFIDDEMOZ0','2','D','52','30','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvServiceUnitAmt"','8','(''UA''=''F'')','EFIDDEMOZ0','4','D','52','32','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvHourEffDate"','9','(''UA''=''F'')','EFIDDEMOZ0','8','D','52','36','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"R"','10','(''DA''=''F'')','EFIDDEMOZ0','1','D','52','44',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','11','(''UA''=''F'')','EFIDDEMOZ0','1','D','52','45','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved"','12','(''UA''=''F'')','EFIDDEMOZ0','24','D','52','46','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','13','(''UA''=''F'')','EFIDDEMOZ0','11','D','52','70','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','55','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupNumber"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','55','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','55','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','55','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','55','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','55','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFieldType"','7','(''UA''=''F'')','EFIDDEMOZ0','1','D','55','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvEmployeeNumber"','8','(''UA''=''F'')','EFIDDEMOZ0','11','D','55','33','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved"','9','(''UA''=''F'')','EFIDDEMOZ0','1','D','55','44','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','10','(''UA''=''F'')','EFIDDEMOZ0','36','D','55','45','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvPlanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','60','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvBatchGroupNumber"','2','(''UA''=''F'')','EFIDDEMOZ0','4','D','60','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','3','(''UA''=''F'')','EFIDDEMOZ0','3','D','60','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSocialSecurityNumber"','4','(''UA''=''F'')','EFIDDEMOZ0','11','D','60','13','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','5','(''UA''=''F'')','EFIDDEMOZ0','6','D','60','24','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordIdentifier"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','60','30','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvEMailAddressStatusCode"','7','(''UA''=''F'')','EFIDDEMOZ0','1','D','60','32','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvEMailTypeCode"','8','(''UA''=''F'')','EFIDDEMOZ0','2','D','60','33','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReservedForFutureUse"','9','(''UA''=''F'')','EFIDDEMOZ0','2','D','60','35','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvEMailRecordSequenceNbr"','10','(''UA''=''F'')','EFIDDEMOZ0','1','D','60','37','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvEMailAddressText"','11','(''UA''=''F'')','EFIDDEMOZ0','35','D','60','38','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvNonSafeHarborIndicator"','12','(''UA''=''F'')','EFIDDEMOZ0','1','D','60','73','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','13','(''UA''=''F'')','EFIDDEMOZ0','7','D','60','74','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvplanNumber"','1','(''UA''=''F'')','EFIDDEMOZ0','5','D','70','1','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller1"','2','(''UA''=''F'')','EFIDDEMOZ0','7','D','70','2','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSSN"','3','(''UA''=''F'')','EFIDDEMOZ0','11','D','70','3','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller2"','4','(''UA''=''F'')','EFIDDEMOZ0','1','D','70','4','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved"','5','(''UA''=''F'')','EFIDDEMOZ0','5','D','70','5','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordID"','6','(''UA''=''F'')','EFIDDEMOZ0','2','D','70','6','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSalary"','7','(''UN0''=''F'')','EFIDDEMOZ0','13','D','70','7','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSalaryID"','8','(''UA''=''F'')','EFIDDEMOZ0','1','D','70','8','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvReserved2"','9','(''UA''=''F'')','EFIDDEMOZ0','2','D','70','9','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvSalPayDate"','10','(''UA''=''F'')','EFIDDEMOZ0','8','D','70','10','','',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvFiller3"','11','(''UA''=''F'')','EFIDDEMOZ0','25','D','70','11','','',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EFIDDEMO_20211007.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','FR95C,N7GY3,WO2AC,RIOOJ,H4VKS,0Y1AJ',NULL,NULL,NULL,'Fidelity Demographic2','202106249','EMPEXPORT','SCH_FIDD','Jun 28 2021 12:00AM','EFIDDEMO',NULL,NULL,NULL,'202110039','Jun 24 2021 12:00AM','Dec 30 1899 12:00AM','202110011',NULL,'','','202106101',dbo.fn_GetTimedKey(),NULL,'us3lKiAIR1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'FR95C,N7GY3,WO2AC,RIOOJ,H4VKS,0Y1AJ',NULL,NULL,NULL,'Fidelity Demographic','201911119','EMPEXPORT','SCHEDULED','Nov 22 2019 12:00AM','EFIDDEMO',NULL,NULL,NULL,'202110059','Nov 11 2019 12:00AM','Dec 30 1899 12:00AM','202110011','6003','','','201911041',dbo.fn_GetTimedKey(),NULL,'ULTI_AIRMC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','FR95C,N7GY3,WO2AC,RIOOJ,H4VKS,0Y1AJ',NULL,NULL,NULL,'Fidelity Demo - TEST','202107219','EMPEXPORT','TEST','Jul 21 2021  2:23PM','EFIDDEMO',NULL,NULL,NULL,'202107219','Jul 21 2021 12:00AM','Dec 30 1899 12:00AM','202107141','10957','','','202107141',dbo.fn_GetTimedKey(),NULL,'us3lKiAIR1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDDEMO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDDEMO','InitialSort','C','DrvEEID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDDEMO','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDDEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDDEMO','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDDEMO','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EFIDDEMO' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EFIDDEMO' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EFIDDEMO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDDEMO_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','H00','dbo.U_Dsi_DrvTbl_EFIDDEMO_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D10','dbo.U_Dsi_DrvTbl_EFIDDEMO_01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D15','dbo.U_Dsi_DrvTbl_EFIDDEMO_02D',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D20','dbo.U_Dsi_DrvTbl_EFIDDEMO_11',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D25','dbo.U_Dsi_DrvTbl_EFIDDEMO_03',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D30','dbo.U_Dsi_DrvTbl_EFIDDEMO_04',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D35','dbo.U_Dsi_DrvTbl_EFIDDEMO_05',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D40','dbo.U_Dsi_DrvTbl_EFIDDEMO_60',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D45','dbo.U_Dsi_DrvTbl_EFIDDEMO_61',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D50','dbo.U_Dsi_DrvTbl_EFIDDEMO_06',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D51','dbo.U_Dsi_DrvTbl_EFIDDEMO_36',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D52','dbo.U_Dsi_DrvTbl_EFIDDEMO_63',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D55','dbo.U_Dsi_DrvTbl_EFIDDEMO_02E',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D60','dbo.U_Dsi_DrvTbl_EFIDDEMO_EA',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDDEMO','D70','dbo.U_Dsi_DrvTbl_EFIDDEMO_08',NULL);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_01') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_01] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupID] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvLastName] varchar(131) NULL,
    [DrvFirstNameMiddleInitial] varchar(102) NULL,
    [DrvReserved] varchar(1) NOT NULL,
    [DrvMaritalStatus] varchar(1) NOT NULL,
    [DrvGender] char(1) NULL,
    [DrvSpecialTaxTypeID] varchar(1) NOT NULL,
    [DrvFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_02D') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_02D] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupID] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvFieldType] varchar(1) NOT NULL,
    [DrvFiller3] varchar(1) NOT NULL,
    [DrvHireDate] varchar(8000) NULL,
    [DrvParticipationDate] varchar(1) NOT NULL,
    [DrvVestingDate] varchar(8000) NULL,
    [DrvBirthDate] varchar(8000) NULL,
    [DrvTerminationDate] varchar(8000) NULL,
    [DrvDateSwitch] varchar(1) NOT NULL,
    [DrvReserved] varchar(1) NOT NULL,
    [DrvFiller4] varchar(1) NOT NULL,
    [DrvAssociationIndicator] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_02E') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_02E] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupNumber] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvFieldType] varchar(1) NOT NULL,
    [DrvEmployeeNumber] char(9) NULL,
    [DrvReserved] varchar(1) NOT NULL,
    [DrvFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_03') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_03] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupID] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvFieldType] varchar(1) NOT NULL,
    [DrvAddressLineNumber] varchar(2) NOT NULL,
    [DrvAddress] varchar(255) NULL,
    [DrvFiller3] varchar(1) NOT NULL,
    [DrvMailingIndicator] varchar(1) NOT NULL,
    [DrvOmitStatementIndicator] varchar(1) NOT NULL,
    [DrvAssociationIndicator] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_04') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_04] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupID] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvRecordType] varchar(1) NOT NULL,
    [DrvCity] varchar(255) NULL,
    [DrvState] varchar(255) NULL,
    [DrvFiller3] varchar(1) NOT NULL,
    [DrvZipCode] varchar(5) NULL,
    [DrvZipPlus4Code] varchar(4) NULL,
    [DrvFiller4] varchar(1) NOT NULL,
    [DrvDataSearchIndicator] varchar(1) NOT NULL,
    [DrvOmitStatementIndicator] varchar(1) NOT NULL,
    [DrvAssociationIndicator] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_05') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_05] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupID] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvRecordType] varchar(1) NOT NULL,
    [DrvCountry] char(3) NULL,
    [DrvFiller3] varchar(1) NOT NULL,
    [DrvSpecialHandling] varchar(1) NOT NULL,
    [DrvFiller4] varchar(1) NOT NULL,
    [DrvMailingIndicator] varchar(1) NOT NULL,
    [DrvDataSearchIndicator] varchar(1) NOT NULL,
    [DrvOmitStatementIndicator] varchar(1) NOT NULL,
    [DrvAssociationIndicator] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_06') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_06] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupNumber] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvDivisionName] varchar(10) NULL,
    [DrvRegionName] varchar(10) NULL,
    [DrvFiller3] varchar(1) NOT NULL,
    [DrvReserved] varchar(1) NOT NULL,
    [DrvFiller4] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_08') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_08] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSSN] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvReserved] varchar(5) NOT NULL,
    [DrvRecordId] varchar(2) NOT NULL,
    [DrvSalary] varchar(30) NULL,
    [DrvSalaryID] varchar(1) NOT NULL,
    [DrvReserved2] varchar(1) NOT NULL,
    [DrvSalPayDate] varchar(8) NULL,
    [DrvFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_11') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_11] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupID] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvStatusCode] varchar(1) NULL,
    [DrvFiller3] varchar(1) NOT NULL,
    [DrvLitKitSw] varchar(1) NOT NULL,
    [DrvFiller4] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_36') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_36] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupNumber] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvFieldType] varchar(1) NOT NULL,
    [DrvDivisionCode] varchar(10) NULL,
    [DrvReserved] varchar(1) NOT NULL,
    [drvDivCodeExists] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_60') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_60] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupNumber] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvParticipantClass] varchar(1) NOT NULL,
    [DrvParticipantDistrict] char(5) NOT NULL,
    [DrvParticipantDepartment] varchar(10) NULL,
    [DrvParticipantLocationStore] char(6) NULL,
    [DrvParticipantUnionCode] char(12) NULL,
    [DrvParticipantPaymentFrequency] varchar(1) NULL,
    [DrvMiscellaneousCode] varchar(1) NOT NULL,
    [DrvHighlyCompensatedFlag] varchar(1) NOT NULL,
    [DrvOffice16BFlag] varchar(1) NOT NULL,
    [DrvDeMinimusEligibilityIndicator] varchar(1) NOT NULL,
    [DrvAgePayoutEligibilityIndicator] varchar(1) NOT NULL,
    [DrvParticipantRestrictionCode] varchar(1) NOT NULL,
    [DrvParticipantRestrictionReason] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_61') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_61] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupNumber] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvEligibilityDate] varchar(1) NOT NULL,
    [DrvAdjustedDateOfHire] varchar(8000) NULL,
    [DrvRetirementDate] varchar(1) NOT NULL,
    [DrvPreBreakServiceUnites] varchar(1) NOT NULL,
    [DrvBisAcrrualStartDate] varchar(1) NOT NULL,
    [DrvFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_63') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_63] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupNumber] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvServiceUnitAmt] varchar(24) NULL,
    [DrvHourEffDate] varchar(8000) NULL,
    [DrvAddReplInd] varchar(1) NOT NULL,
    [DrvReserved] varchar(1) NOT NULL,
    [DrvZeros] varchar(5) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_Audit') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_Audit] (
    [AudKey1Value] varchar(255) NULL,
    [AudKey2Value] varchar(255) NULL,
    [AudKey3Value] varchar(255) NULL,
    [AudTableName] varchar(128) NULL,
    [AudFieldName] varchar(128) NULL,
    [AudOldValue] varchar(256) NULL,
    [AudNewValue] varchar(256) NULL,
    [AudDateTime] datetime NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_EA') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_EA] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvBatchGroupNumber] varchar(1) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvSocialSecurityNumber] varchar(11) NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvRecordIdentifier] varchar(2) NOT NULL,
    [DrvEMailAddressStatusCode] varchar(1) NOT NULL,
    [DrvEMailTypeCode] varchar(2) NOT NULL,
    [DrvReservedForFutureUse] varchar(1) NOT NULL,
    [DrvEMailRecordSequenceNbr] varchar(1) NOT NULL,
    [DrvEMailAddressRaw] varchar(50) NULL,
    [DrvEMailAddressText] varchar(35) NULL,
    [DrvNonSafeHarborIndicator] varchar(1) NOT NULL,
    [DrvFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EFIDDEMO_Header') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_Header] (
    [DrvPlanNumber] varchar(5) NOT NULL,
    [DrvRecordIdentifier] varchar(3) NOT NULL,
    [DrvFiller1] varchar(1) NOT NULL,
    [DrvTypeOfAccount] varchar(10) NOT NULL,
    [DrvFiller2] varchar(1) NOT NULL,
    [DrvClientName] varchar(11) NOT NULL,
    [DrvChangesOnlyFileIndicator] varchar(1) NOT NULL,
    [DrvFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EFIDDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_EFIDDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFIDDEMO_EEList_Detail') IS NULL
CREATE TABLE [dbo].[U_EFIDDEMO_EEList_Detail] (
    [DetEEID] char(12) NULL,
    [DetCOID] char(5) NULL,
    [DetStatus] char(1) NULL,
    [DetNewHire] varchar(1) NULL,
    [DetRehire] varchar(1) NULL,
    [DetTerm] varchar(1) NULL,
    [DetRetLOA] varchar(1) NULL,
    [DetLOA] varchar(1) NULL,
    [Det01] varchar(1) NULL,
    [Det02D] varchar(1) NULL,
    [Det11] varchar(1) NULL,
    [Det03] varchar(1) NULL,
    [Det04] varchar(1) NULL,
    [Det05] varchar(1) NULL,
    [Det60] varchar(1) NULL,
    [Det61] varchar(1) NULL,
    [Det06] varchar(1) NULL,
    [Det36] varchar(1) NULL,
    [Det63] varchar(1) NULL,
    [Det02E] varchar(1) NULL,
    [DetEA] varchar(1) NULL,
    [Det08] varchar(1) NULL
);
IF OBJECT_ID('U_EFIDDEMO_File') IS NULL
CREATE TABLE [dbo].[U_EFIDDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);
IF OBJECT_ID('U_EFIDDEMO_Pearhist') IS NULL
CREATE TABLE [dbo].[U_EFIDDEMO_Pearhist] (
    [PehEEID] char(12) NOT NULL,
    [pehCuramt] numeric NULL,
    [PehPerControl] char(9) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EFIDDEMO]
AS

/************************************************************

Client: AIRMC

Created By: Megan Grieves
Business Analyst: Greg Travetti
Create Date: 6/10/2013
ChangePoint Request Number: 68700

Purpose: Insert Testing Header

Revision History
----------------
Update By         Date          CP Num         Descr
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx

************************************************************/

-----------
-- If testing, insert testing header
-----------

IF dbo.dsi_fnVariable('EFIDDEMO','TEST') = 'Y' BEGIN

    INSERT INTO dbo.U_EFIDDEMO_File VALUES ('H00','1','1','1','1','TESTEDT' + SPACE(73))

END
GO
CREATE PROCEDURE[dbo].[dsi_sp_BuildDriverTables_EFIDDEMO]
@SystemID VARCHAR(15) = NULL

AS

/************************************************************

Created By: Megan Grieves
Business Analyst: Greg Travetti
Create Date: 6/10/2013
ChangePoint Request Number: 68700

Purpose:
Execute Export:

Revision History
-----------------
Update By            Date            CP Num                    Desc            
XXXX                XX/XX/10        12345                    Added DedCode 1234
Andrew Zoorob       10/12/13        20524                    added company code to record 60
Sean Hawkins        09/26/2014      Sr-2014-55935            Updated for address changes and proper use from audit
Sean Hawkins        10/03/2014      SR-2014-55935            Updated to handle status of "R" same as terminations (released/laid-off)
Ric Dreese          11/18/2015      SF 06139940                Updated name combo with space
Sean Hawkins        01/13/2017      SR-2016-00131575        Updates for new 93523 logic and field changes
Pushpa Narayana     04/24/2017      SR-2017-00152991        Updates to 02D and 11 records (V2.6)
Osviel Vazquez      07/05/2018      SR-2018-00201434        Updated Staus Code, changed first Rehire to 'E N', removed Leave Reason = WORK clause
Jimmy Tran          10/3/2019       SR-2019-00236877        Updated file per spec v 2.6
Sean Hawkins        04/22/2020        SR-2020-00274496        Updated for DrvRegionName
TekPartners            06/28/2021      no SR                   Removed coding for plan number 93523, changed the division and region coding, removed sql scheduler and move to web  

SELECT * FROM U_Dsi_Configuration WHERE FormatCode = 'EFIDDEMO'
SELECT * FROM U_Dsi_SqlClauses WHERE FormatCode = 'EFIDDEMO'
SELECT * FROM U_Dsi_Parameters WHERE FormatCode = 'EFIDDEMO'

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFIDDEMO', @AllObjects = 'Y', @IsWeb = 'Y'

UPDATE U_Dsi_Configuration
   SET CfgValue = dbo.dsi_fnVariable('EFIDDEMO','TestPath')
 WHERE FormatCode = 'EFIDDEMO'
   AND CfgName = 'ExportPath'

 --UDES PATH

 --UPDATE U_Dsi_Configuration
 --  SET CfgValue = dbo.dsi_fnVariable('EFIDDEMO','UDESPath')
 --WHERE FormatCode = 'EFIDDEMO'
 --  AND CfgName = 'ExportPath'

dsi_sp_testswitchbox_v2 'EFIDDEMO', 'ON_DEMAND'
dsi_sp_testswitchbox_v2 'EFIDDEMO', 'TEST'
dsi_sp_testswitchbox_v2 'EFIDDEMO', 'SCHEDULED'

UPDATE AscExp
SET
ExpStartPerControl     = '2013' + '01' + '011',
ExpLastStartPerControl = '2013' + '01' + '011',
--ExpEndPerControl       = '2013' + '01' + '011',
--ExpLastEndPerControl   = '2013' + '01' + '011'
ExpEndPerControl       = CONVERT(VARCHAR(8), GETDATE(), 112) + '9',
ExpLastEndPerControl   = CONVERT(VARCHAR(8), GETDATE(), 112) + '9'
WHERE ExpFormatCode    = 'EFIDDEMO'
AND ExpExportCode    = 'ON_DEMAND'

************************************************************/

SET NOCOUNT ON

-----------
-- Declare variables
-----------

DECLARE @FormatCode       CHAR(10)
DECLARE @ExportCode       CHAR(10)
DECLARE @StartDateTime    DATETIME
DECLARE @EndDateTime      DATETIME
DECLARE @StartPerControl  CHAR(9)
DECLARE @EndPerControl    CHAR(9)
DECLARE @TestingFlag      CHAR(1)

-----------
-- Set start and end dates
-----------

SELECT

@FormatCode      = FormatCode,
@ExportCode      = ExportCode,
@StartPerControl = StartPerControl,
@EndPerControl   = EndPerControl

FROM dbo.U_dsi_Parameters
WHERE FormatCode = 'EFIDDEMO'

SET @StartDateTime = CONVERT(DATETIME, LEFT(@StartPerControl, 8))
SET @EndDateTime   = CONVERT(DATETIME, LEFT(@EndPerControl, 8))
SET @EndDateTime   = DATEADD(SECOND, -1, DATEADD(DD,1, DATEDIFF(DD, 0, @EndDateTime))) -- 11:59:59 pm
SET @TestingFlag   = dbo.dsi_fnVariable(@FormatCode, 'TEST')

-- Scheduled Run

--IF @ExportCode = 'SCHEDULED' BEGIN
--   SET @EndDateTime     = GETDATE()
--   SET @StartDateTime   = DATEADD(DD, -7, @EndDateTime)
--   SET @StartPerControl = CONVERT(VARCHAR(8),@StartDateTime,112) + '1'
--   SET @EndPerControl   = CONVERT(VARCHAR(8),@EndDateTime,112) + '9'
--END

PRINT '@StartPerControl: ' + @StartPerControl
PRINT '@EndPerControl:   ' + @EndPerControl
PRINT '@StartDateTime    ' + CONVERT(VARCHAR(30), @StartDateTime)
PRINT '@EndDateTime:     ' + CONVERT(VARCHAR(30), @EndDateTime)

-----------
-- Drop tables
-----------

IF OBJECT_ID('dbo.U_EFIDDEMO_EEList_Detail')          IS NOT NULL  DROP TABLE dbo.U_EFIDDEMO_EEList_Detail
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit')       IS NOT NULL DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_Header')      IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_Header
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_01')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_01
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_02D')         IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_02D
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_02E')         IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_02E
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_03')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_03
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_04')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_04
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_05')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_05
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_06')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_06
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_11')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_11
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_36')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_36
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_60')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_60
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_61')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_61
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_63')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_63
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_EA')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_EA
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EFIDDEMO_08')          IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EFIDDEMO_08 --Updated By j.tran

-----------
-- Clean up EE List
-----------

DELETE FROM dbo.U_EFIDDEMO_EEList WHERE xCOID <> dbo.dsi_fn_GetCurrentCOID(xEEID)

-----------
-- Gather audit data for employees

--sp_geteeid '523753214' 
--select * from U_EFIDDEMO_EEList where xeeid = '9JC8PM00F0K0'
--select * from U_Dsi_DrvTbl_EFIDDEMO_Audit where audkey1value = '9JC8PM00F0K0'
--select * from U_EFIDDEMO_EEList_Detail where deteeid = '9JC8PM00F0K0'
-----------

CREATE TABLE [dbo].[U_Dsi_DrvTbl_EFIDDEMO_Audit](
  [AudKey1Value] [VARCHAR](255)  NULL,
  [AudKey2Value] [VARCHAR](255)  NULL,
  [AudKey3Value] [VARCHAR](255)  NULL,
  [AudTableName] [VARCHAR](128)  NULL,
  [AudFieldName] [VARCHAR](128)  NULL,
  [AudOldValue]  [VARCHAR](256)  NULL,
  [AudNewValue]  [VARCHAR](256)  NULL,
  [AudDateTime]  [DATETIME]      NULL
) ON [PRIMARY]

INSERT INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit
SELECT DISTINCT

AudKey1Value,
AudKey2Value,
AudKey3Value,
AudTableName,
AudFieldName,
AudOldValue,
AudNewValue,
AudProcessedDateTime as AudDateTime

FROM dbo.U_EFIDDEMO_EELIST
JOIN vw_AuditEEdata ON AudKey1Value = xEEID
WHERE AudProcessedDateTime BETWEEN @StartDateTime AND @EndDateTime
AND ((AudTableName = 'EmpPers' AND AudFieldName IN ('EepNameLast','EepNameSuffix','EepNameFirst','EepNameMiddle','EepMaritalStatus','EepGender','EepDateOfBirth','EepAddressLine1','EepAddressLine2','EepAddressCity','EepAddressState','EepAddressZipCode','EepAddressCountry','eepaddressEmail'))
OR (AudTableName = 'EmpComp' AND AudFieldName IN ('EecDateOfTermination','EecEmplStatus','EecDateOfOriginalHire','EecDateOfBenefitSeniority','EecDateOfLastHire','EecOrgLvl3','EecLocation','EecPayPeriod','EecOrgLvl1','EecOrgLvl2','EecEmpNo','EepAddressEMail','eecAnnSalary','eecEEType')))



      ---------------------------
  --   Working Table - vw_int_PEarHist
    ---------------------------
   IF OBJECT_ID('U_EFIDDEMO_Pearhist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDDEMO_Pearhist;
    SELECT
         PehEEID
        ,pehCuramt = SUM(CASE WHEN pehInclInDefComp = 'Y' THEN pehCuramt ELSE 0.00 END)
        ,PehPerControl = MAX(PehPerControl)


    INTO dbo.U_EFIDDEMO_Pearhist
    FROM dbo.U_EFIDDEMO_EELIST WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON pehEEID = xEEID
    WHERE PehPerControl BETWEEN CONVERT(VARCHAR(4),@STARTDATETIME,112) + '01011'  AND @EndPerControl 
    GROUP BY PehEEID



-----------------------
-- Identify Employee Changes
-----------------------

SELECT DISTINCT

DetEEID    = xEEID,
DetCOID    = xCOID,
DetStatus  = EecEmplStatus,
DetNewHire = SPACE(1),
DetRehire  = SPACE(1),
DetTerm    = SPACE(1),
DetRetLOA  = SPACE(1),
DetLOA     = SPACE(1),
Det01      = SPACE(1),
Det02D     = SPACE(1),
Det11      = SPACE(1),
Det03      = SPACE(1),
Det04      = SPACE(1),
Det05      = SPACE(1),
Det60      = SPACE(1),
Det61      = SPACE(1),
Det06      = SPACE(1),
Det36       = SPACE(1),
Det63      = SPACE(1),
Det02E     = SPACE(1),
DetEA      = SPACE(1),
Det08      = SPACE(1)--Updated By j.tran for auditing purposes
--For testing purposes:
--DetNewHire = 'Y',
--DetRehire  = 'Y',
--DetTerm    = 'Y',
--DetRetLOA  = 'Y',
--DetLOA     = 'Y',
--Det01      = 'Y',
--Det02D     = 'Y',
--Det11      = 'Y',
--Det03      = 'Y',
--Det04      = 'Y',
--Det05      = 'Y',
--Det60      = 'Y',
--Det61      = 'Y',
--Det06      = 'Y',
--Det02E     = 'Y',
--DetEA      = 'Y'

INTO dbo.U_EFIDDEMO_EEList_Detail
FROM dbo.U_EFIDDEMO_EEList
JOIN vw_int_EmpComp WITH (NOLOCK) ON EecEEID = xEEID AND EecCOID = xCOID
WHERE eecEETYPE NOT IN('CON') -- Updated by J.Tran to exclude eecEETYpe

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET DetNewHire = 'Y',
       Det01      = 'Y',
       Det02D     = 'Y',
       Det11      = 'Y',
       Det03      = 'Y',
       Det04      = 'Y',
       Det05      = 'Y',
       Det60      = 'Y',
       Det06      = 'Y',
       Det02E     = 'Y',
       DetEA      = 'Y',
       Det36       ='Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName = 'EecEmplStatus'
   AND ISNULL(AudOldValue,'') = ''
   AND ISNULL(AudNewValue,'') = 'A')

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET DetRehire = 'Y',
       Det01     = 'Y',
       Det02D    = 'Y',
       Det11     = 'Y',
       Det03     = 'Y',
       Det04     = 'Y',
       Det05     = 'Y',
       Det60     = 'Y',
       Det61     = 'Y',
       Det06     = 'Y',
       Det02E    = 'Y',
       DetEA     = 'Y',
       Det36       ='Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName = 'EecEmplStatus'
   AND ISNULL(AudOldValue,'') IN('R','T')-- = 'T'
   AND ISNULL(AudNewValue,'') = 'A')
--select * from codes where codtable = 'EMPLOYEESTATUS'
UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET DetTerm = 'Y',
       Det02D  = 'Y',
       Det11   = 'Y',
       DetEA   = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName = 'EecEmplStatus'
   AND ISNULL(AudOldValue,'') NOT IN ('R','T')
   AND ISNULL(AudNewValue,'')IN('R','T'))-- = 'T')

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET DetRetLOA = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName = 'EecEmplStatus'
   AND ISNULL(AudOldValue,'') = 'L'
   AND ISNULL(AudNewValue,'') = 'A')

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET DetLOA = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName = 'EecEmplStatus'
   AND ISNULL(AudOldValue,'') <> 'L'
   AND ISNULL(AudNewValue,'') = 'L')

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET Det01 = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID --cannot join to audkey2value as no coid for emppers fields:  AND AudKey2Value = DetCOID
   AND AudFieldName IN ('EepNameLast','EepNameSuffix','EepNameFirst','EepNameMiddle','EepMaritalStatus','EepGender'))

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET Det02D = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName IN ('EecDateOfOriginalHire','EecDateOfBenefitSeniority','EepDateOfBirth','EecDateOfTermination','EecDateOfLastHire'))

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET Det11 = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName = 'EecEmplStatus')

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET Det03 = 'Y',
       Det04 = 'Y',
       Det05 = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID --cannot join to audkey2value as no coid for emppers fields:  AND AudKey2Value = DetCOID
   AND AudFieldName IN ('EepAddressLine1','EepAddressLine2','EepAddressCity','EepAddressState','EepAddressZipCode','EepAddressCountry'))

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET Det60 = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName IN ('EecOrgLvl3','EecLocation','EecPayPeriod'))

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET Det06 = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName IN ('EecOrgLvl1','EecOrgLvl2'))

   UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET Det36 = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName IN ('EecOrgLvl1'))

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET Det02E = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName = 'EecEmpNo')

UPDATE dbo.U_EFIDDEMO_EEList_Detail
   SET DetEA = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID --cannot join to audkey2value as no coid for emmpers fields:  AND AudKey2Value = DetCOID
   AND AudFieldName = 'EepAddressEmail')


UPDATE dbo.U_EFIDDEMO_EEList_Detail --Updated by J.tran 
   SET Det08 = 'Y'
 WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID
   AND AudFieldName = 'eecAnnSalary')

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_Header
-----------------------

SELECT DISTINCT

DrvPlanNumber               = '37379',
DrvRecordIdentifier         = 'THR',
DrvFiller1                  = '',
DrvTypeOfAccount            = 'Indicative',
DrvFiller2                  = '',
DrvClientName               = 'Air Methods',
DrvChangesOnlyFileIndicator = 'Y',
DrvFiller3                  = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_Header

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_01
-----------------------

SELECT DISTINCT

DrvCOID                   = DetCOID,
DrvEEID                   = DetEEID,
DrvPlanNumber             = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupID           = '',
DrvFiller1                = '',
DrvSocialSecurityNumber   = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2                = '',
DrvRecordIdentifier       = '01',
DrvLastName               = EepNameLast + ' ' + ISNULL(EepNameSuffix,''),
DrvFirstNameMiddleInitial = EepNameFirst + ' ' + LEFT(ISNULL(EepNameMiddle,''),1), -- updated RAD 06139940
DrvReserved               = '',
DrvMaritalStatus          = CASE EepMaritalStatus
                                WHEN 'M' THEN 'M'
                                WHEN 'Z' THEN ''
                                ELSE 'S'
                            END,
DrvGender                 = EepGender,
DrvSpecialTaxTypeID       = '',
DrvFiller3                = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_01
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN company with (nolock) on cmpcoid = DetCOID
WHERE Det01 = 'Y'

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_02D
-----------------------

SELECT DISTINCT

DrvCOID                 = DetCOID,
DrvEEID                 = DetEEID,
DrvPlanNumber           = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupID         = '',
DrvFiller1              = '',
DrvSocialSecurityNumber = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2              = '',
DrvRecordIdentifier     = '02',
DrvFieldType            = 'D',
DrvFiller3              = '',
DrvHireDate             = REPLACE(CONVERT(VARCHAR(10),EecDateOfOriginalHire,101),'/',''),
DrvParticipationDate    = '',
DrvVestingDate          = REPLACE(CONVERT(VARCHAR(10),EecDateOfBenefitSeniority,101),'/',''),
DrvBirthDate            = REPLACE(CONVERT(VARCHAR(10),EepDateOfBirth,101),'/',''),
DrvTerminationDate      = CASE DetTerm
                            WHEN 'Y' THEN REPLACE(CONVERT(VARCHAR(10),EecDateOfTermination,101),'/','')
                            ELSE REPLICATE('0',8)
                          END,
DrvDateSwitch           = case when CmpCompanyCode not in ('HH','BHH','SNDNC') 
                            then CASE DetRehire
                                --WHEN 'Y' THEN '5'
                                WHEN 'Y' THEN ''
                                ELSE ''
                            END
                          ELSE ''
                          END,
DrvReserved             = '',
DrvFiller4              = '',
DrvAssociationIndicator = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_02D
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN vw_int_EmpComp WITH (NOLOCK) ON EecEEID = DetEEID AND EecCOID = DetCOID
JOIN Company WITH (nolock) on CmpCoid = DetCoid
WHERE Det02D = 'Y'

--select * from U_Dsi_DrvTbl_EFIDDEMO_02D where drvdateswitch = '5'

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_11
-----------------------

SELECT DISTINCT

DrvCOID                 = DetCOID,
DrvEEID                 = DetEEID,
DrvPlanNumber           = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupID         = '',
DrvFiller1              = '',
DrvSocialSecurityNumber = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2              = '',
DrvRecordIdentifier     = '11',
DrvStatusCode           = CASE
                            WHEN DetNewHire = 'Y' AND eecEEType in ('PDM','INT','STU','TMP','SUM') THEN 'I' -- Updated By j.tran 
                            WHEN DetNewHire = 'Y' AND eecEEType NOT in ('PDM','INT','STU','TMP','SUM')  THEN 'N' -- Updated By j.tran 

                            WHEN DetRehire = 'Y' AND CmpCompanyCode NOT IN ('HH','BHH','SNDNC') AND  eecEEType = 'REG' AND NOT EXISTS(SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WITH (NOLOCK) WHERE audKey1value = DetEEID AND audFieldName = 'eecEEType' AND audOLDValue IN('PDM','INT','STU','TMP','SUM') ) THEN 'N'  -- Updated By j.tran 
                            WHEN DetRehire = 'Y' AND CmpCompanyCode  IN ('HH','BHH','SNDNC') AND  eecEEType = 'REG' AND NOT EXISTS(SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WITH (NOLOCK) WHERE audKey1value = DetEEID AND audFieldName = 'eecEEType' AND audOLDValue IN('PDM','INT','STU','TMP','SUM') ) THEN 'H'  -- Updated By j.tran 
                            WHEN DetRehire = 'Y' AND  eecEEType IN('PDM','INT','STU','TMP','SUM') AND EXISTS(SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WITH (NOLOCK) WHERE audKey1value = DetEEID AND audFieldName = 'eecEEType' AND audOLDValue IN('PDM','INT','STU','TMP','SUM') ) THEN 'I'  -- Updated By j.tran 
                            WHEN DetRehire = 'Y' AND  eecEEType IN('PDM','INT','STU','TMP','SUM') AND EXISTS(SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WITH (NOLOCK) WHERE audKey1value = DetEEID AND audFieldName = 'eecEEType' AND audOLDValue IN('REG') ) THEN 'N'  -- Updated By j.tran 
                            
                            WHEN eecEmplStatus = 'A' AND EXISTS(SELECT 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WITH (NOLOCK) WHERE audKey1value = DetEEID AND audFieldName = 'eecEEType' AND audOLDValue IN('PDM','INT','STU','TMP','SUM') AND audNewValue ='REG') THEN 'N' --Updated by J.Tran
                            --WHEN DetRehire = 'Y' AND CmpCompanyCode NOT IN ('HH','BHH','SNDNC') THEN 'E N' --'N'
       --                     WHEN DetRehire = 'Y' AND CmpCompanyCode IN ('HH','BHH','SNDNC') then 'H'                   
                            WHEN DetTerm = 'Y' THEN 'T'
                            WHEN DetRetLOA = 'Y' THEN 'A'
                            WHEN DetLOA = 'Y' THEN CASE
                                                        WHEN EecLeaveReason IN ('MIL','MIS','MRE') THEN 'W'
                                                        -- WHEN EecLeaveReason = 'WORK' THEN 'P'
                                                        ELSE 'L'
                                                   END
                          END,

DrvFiller3              = '',
DrvLitKitSw             = '',
DrvFiller4              = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_11
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN vw_int_EmpComp WITH (NOLOCK) ON EecEEID = DetEEID AND EecCOID = DetCOID
JOIN Company WITH (nolock) on CmpCoid = DetCoid
WHERE (Det11 = 'Y' OR EXISTS(Select 1 FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_Audit WITH (NOLOCK) WHERE audKey1value = DetEEID AND audFieldName = 'eecEEType' AND audOLDValue IN('PDM','INT','STU','TMP','SUM') AND audNewValue ='REG'))

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_03
-----------------------

SELECT DISTINCT

DrvCOID                   = DetCOID,
DrvEEID                   = DetEEID,
DrvPlanNumber             = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupID           = '',
DrvFiller1                = '',
DrvSocialSecurityNumber   = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2                = '',
DrvRecordIdentifier       = '03',
DrvFieldType              = 'P',
DrvAddressLineNumber      = '01',
DrvAddress                = EepAddressLine1,
DrvFiller3                = '',
DrvMailingIndicator       = '',
DrvOmitStatementIndicator = '',
DrvAssociationIndicator   = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_03
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN Company WITH (nolock) on CmpCoid = DetCoid
WHERE Det03 = 'Y'

INSERT INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_03
SELECT DISTINCT

DrvCOID                   = DetCOID,
DrvEEID                   = DetEEID,
DrvPlanNumber             = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupID           = '',
DrvFiller1                = '',
DrvSocialSecurityNumber   = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2                = '',
DrvRecordIdentifier       = '03',
DrvFieldType              = 'P',
DrvAddressLineNumber      = '02',
DrvAddress                = EepAddressLine2,
DrvFiller3                = '',
DrvMailingIndicator       = '',
DrvOmitStatementIndicator = '',
DrvAssociationIndicator   = ''

FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN Company WITH (nolock) on CmpCoid = DetCoid
WHERE Det03 = 'Y'

INSERT INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_03
SELECT DISTINCT

DrvCOID                   = DetCOID,
DrvEEID                   = DetEEID,
DrvPlanNumber             = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupID           = '',
DrvFiller1                = '',
DrvSocialSecurityNumber   = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2                = '',
DrvRecordIdentifier       = '03',
DrvFieldType              = 'P',
DrvAddressLineNumber      = '03',
DrvAddress                = '',
DrvFiller3                = '',
DrvMailingIndicator       = '',
DrvOmitStatementIndicator = '',
DrvAssociationIndicator   = ''

FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN Company WITH (nolock) on CmpCoid = DetCoid
WHERE Det03 = 'Y'

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_04
-----------------------

SELECT DISTINCT

DrvCOID                   = DetCOID,
DrvEEID                   = DetEEID,
DrvPlanNumber             = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupID           = '',
DrvFiller1                = '',
DrvSocialSecurityNumber   = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2                = '',
DrvRecordIdentifier       = '04',
DrvRecordType             = 'P',
DrvCity                   = EepAddressCity,
DrvState                  = CASE
                                WHEN EepAddressCountry IN ('USA','US') THEN EepAddressState
                            END,
DrvFiller3                = '',
DrvZipCode                = CASE
                                WHEN EepAddressCountry IN ('USA','US') THEN SUBSTRING(EepAddressZipCode,1,5)
                            END,
DrvZipPlus4Code           = CASE
                                WHEN EepAddressCountry IN ('USA','US') THEN SUBSTRING(EepAddressZipCode,6,4)
                            END,
DrvFiller4                = '',
DrvDataSearchIndicator    = '',
DrvOmitStatementIndicator = '',
DrvAssociationIndicator   = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_04
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN Company WITH (nolock) on CmpCoid = DetCoid

WHERE Det04 = 'Y'

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_05
-----------------------

SELECT DISTINCT

DrvCOID                   = DetCOID,
DrvEEID                   = DetEEID,
DrvPlanNumber             = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupID           = '',
DrvFiller1                = '',
DrvSocialSecurityNumber   = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2                = '',
DrvRecordIdentifier       = '05',
DrvRecordType             = 'P',
DrvCountry                = EepAddressCountry,
DrvFiller3                = '',
DrvSpecialHandling        = 'Y',
DrvFiller4                = '',
DrvMailingIndicator       = '',
DrvDataSearchIndicator    = '',
DrvOmitStatementIndicator = '',
DrvAssociationIndicator   = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_05
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN Company WITH (nolock) on CmpCoid = DetCoid
WHERE Det05 = 'Y'
AND EepAddressCountry NOT IN ('USA','US')

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_60
-----------------------

SELECT DISTINCT

DrvCOID                          = DetCOID,
DrvEEID                          = DetEEID,
DrvPlanNumber                    = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupNumber              = '',
DrvFiller1                       = '',
DrvSocialSecurityNumber          = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2                       = '',
DrvRecordIdentifier              = '60',
DrvParticipantClass              = '',
DrvParticipantDistrict           = ISNULL(cmpCompanycode,''),
DrvParticipantDepartment         = EecOrgLvl3,
DrvParticipantLocationStore      = EecLocation,
DrvParticipantCode          = eecUnionLocal,
DrvParticipantPaymentFrequency   = CASE EecPayPeriod
                                    WHEN 'S' THEN '2'
                                    ELSE EecPayPeriod
                                   END,
DrvMiscellaneousCode             = '',
DrvHighlyCompensatedFlag         = '',
DrvOffice16BFlag                 = '',
DrvDeMinimusEligibilityIndicator = '',
DrvAgePayoutEligibilityIndicator = '',
DrvParticipantRestrictionCode    = '',
DrvParticipantRestrictionReason  = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_60
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN vw_int_EmpComp WITH (NOLOCK) ON EecEEID = DetEEID AND EecCOID = DetCOID
JOIN Company on detcoid = CmpCoID  
WHERE Det60 = 'Y'

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_61
-----------------------

SELECT DISTINCT

DrvCOID                  = DetCOID,
DrvEEID                  = DetEEID,
DrvPlanNumber            = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupNumber      = '',
DrvFiller1               = '',
DrvSocialSecurityNumber  = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2               = '',
DrvRecordIdentifier      = '61',
DrvEligibilityDate       = '',
DrvAdjustedDateOfHire    = REPLACE(CONVERT(VARCHAR(10),EecDateOfLastHire,101),'/',''),
DrvRetirementDate        = '',
DrvPreBreakServiceUnites = '',
DrvBisAcrrualStartDate   = '',
DrvFiller3               = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_61
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN vw_int_EmpComp WITH (NOLOCK) ON EecEEID = DetEEID AND EecCOID = DetCOID
JOIN Company on detcoid = CmpCoID  
WHERE Det61 = 'Y'

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_06
-----------------------

SELECT DISTINCT

DrvCOID                 = DetCOID,
DrvEEID                 = DetEEID,
DrvPlanNumber           = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupNumber     = '',
DrvFiller1              = '',
DrvSocialSecurityNumber = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2              = '',
DrvRecordIdentifier     = '06',
DrvDivisionName         = EecOrgLvl1, --CASE WHEN cmpCompanyCode IN('HH','BHH') THEN 'BLUE'
                               --WHEN cmpCompanyCode = 'SNDNC' THEN 'SUN' 
                              -- ELSE OL1.OrgDesc
                             --  END,--OL1.OrgDesc, --Updated By j.tran
DrvRegionName           = EecOrgLvl2, --CASE WHEN cmpCompanyCode IN('HH','BHH') THEN 'BLUE'
                             --  WHEN cmpCompanyCode = 'SNDNC' THEN 'SUN' 
                            --   WHEN EecLocal IS NOT NULL then 'AMC PILOTS'--new 4/22/2020
                           --    ELSE 'AMC'
                            --   END,--OL2.OrgDesc,
DrvFiller3              = '',
DrvReserved             = '',
DrvFiller4              = ''
--select * from U_Dsi_DrvTbl_EFIDDEMO_06
INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_06
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN vw_int_EmpComp WITH (NOLOCK) ON EecEEID = DetEEID AND EecCOID = DetCOID
JOIN vw_int_OrgLevel OL1 WITH (NOLOCK) ON EecOrgLvl1 = OL1.OrgCode AND OL1.OrgLvl = '1'
JOIN vw_int_OrgLevel OL2 WITH (NOLOCK) ON EecOrgLvl2 = OL2.OrgCode AND OL2.OrgLvl = '2'
JOIN Company on detcoid = CmpCoID  
WHERE Det06 = 'Y'

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_02E
-----------------------

SELECT DISTINCT

DrvCOID                 = DetCOID,
DrvEEID                 = DetEEID,
DrvPlanNumber           = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupNumber     = '',
DrvFiller1              = '',
DrvSocialSecurityNumber = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2              = '',
DrvRecordIdentifier     = '02',
DrvFieldType            = 'E',
DrvEmployeeNumber       = EecEmpNo,
DrvReserved             = '',
DrvFiller3              = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_02E
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN vw_int_EmpComp WITH (NOLOCK) ON EecEEID = DetEEID AND EecCOID = DetCOID
JOIN Company on detcoid = CmpCoID  
WHERE Det02E = 'Y'

-----------------------
-- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_EA
-----------------------

SELECT DISTINCT

DrvCOID                   = DetCOID,
DrvEEID                   = DetEEID,
DrvPlanNumber             = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupNumber       = '',
DrvFiller1                = '',
DrvSocialSecurityNumber   = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2                = '',
DrvRecordIdentifier       = 'EA',
DrvEMailAddressStatusCode = CASE
                                WHEN EecEmplStatus IN ('R','T') THEN 'I'
                                ELSE 'A'
                            END,
DrvEMailTypeCode          = 'ER',
DrvReservedForFutureUse   = '',
DrvEMailRecordSequenceNbr = '1',
DrvEMailAddressRaw        = EepAddressEmail,
DrvEMailAddressText       = SUBSTRING(EepAddressEmail,1,35),
DrvNonSafeHarborIndicator = '',
DrvFiller3                = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_EA
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN vw_int_EmpComp WITH (NOLOCK) ON EecEEID = DetEEID AND EecCOID = DetCOID
JOIN Company on detcoid = CmpCoID  
WHERE DetEA = 'Y'
AND ISNULL(EepAddressEmail,'') <> ''

INSERT INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_EA
SELECT DISTINCT

DrvCOID,
DrvEEID,
DrvPlanNumber,
DrvBatchGroupNumber,
DrvFiller1,
DrvSocialSecurityNumber,
DrvFiller2,
DrvRecordIdentifier,
DrvEMailAddressStatusCode,
DrvEMailTypeCode,
DrvReservedForFutureUse,
DrvEMailRecordSequenceNbr = '2',
DrvEMailAddressRaw,
DrvEMailAddressText       = SUBSTRING(DrvEMailAddressRaw,36,35),
DrvNonSafeHarborIndicator,
DrvFiller3

FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_EA
WHERE LEN(DrvEMailAddressRaw) > 35

INSERT INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_EA
SELECT DISTINCT

DrvCOID,
DrvEEID,
DrvPlanNumber,
DrvBatchGroupNumber,
DrvFiller1,
DrvSocialSecurityNumber,
DrvFiller2,
DrvRecordIdentifier,
DrvEMailAddressStatusCode,
DrvEMailTypeCode,
DrvReservedForFutureUse,
DrvEMailRecordSequenceNbr = '3',
DrvEMailAddressRaw,
DrvEMailAddressText       = SUBSTRING(DrvEMailAddressRaw,71,35),
DrvNonSafeHarborIndicator,
DrvFiller3

FROM dbo.U_Dsi_DrvTbl_EFIDDEMO_EA
WHERE LEN(DrvEMailAddressRaw) > 70

--new sections 36 and 63:
/*
Detail Record – Forfeitures By Division (36 Record)
Comments/Special Instructions    Only send records for EEs who have a change to any of the fields listed (8) in the date range the export is run for as well as new hires and rehires in the date range export is run for.
Only send this record If CmpCompanyCode in ('HH','BHH','SNDNC') 

insert into U_dsi_SqlClauses (FormatCode, RecordSet, FromClause, WhereClause)
select 'EFIDDEMO','D51','dbo.U_Dsi_DrvTbl_EFIDDEMO_36',NULL
select * from U_dsi_SqlClauses where formatcode = 'EFIDDEMO'
select * from U_Dsi_DrvTbl_EFIDDEMO_36
*/

SELECT DISTINCT

DrvCOID                 = DetCOID,
DrvEEID                 = DetEEID,
DrvPlanNumber           = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupNumber     = '',
DrvFiller1              = '',
DrvSocialSecurityNumber = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2              = '',
DrvRecordIdentifier     = '36',
DrvFieldType            = '',
DrvDivisionCode         = EecOrgLvl1, --case when CmpCompanyCode in ('HH','BHH') then 'BLUE' -- AND EecOrgLvl3 <> '11210' then 'CONS' --Updated by j.tran
                               -- when CmpCompanyCode in ('HH','BHH') AND EecOrgLvl3 = '11210' then 'AIR' --Updated by j.tran
                              --  when CmpCompanyCode in ('SNDNC') then 'SUN'
                        -- end,
DrvReserved             = '',
drvDivCodeExists        = 'Y'

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_36
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN vw_int_EmpComp WITH (NOLOCK) ON EecEEID = DetEEID AND EecCOID = DetCOID
--JOIN Company on detcoid = CmpCoID  
--and CmpCompanyCode in ('HH','BHH','SNDNC') 
WHERE Det36 = 'Y'

/*
insert into U_dsi_SqlClauses (FormatCode, RecordSet, FromClause, WhereClause)
select 'EFIDDEMO','D52','dbo.U_Dsi_DrvTbl_EFIDDEMO_63',NULL
*/

--63:
SELECT DISTINCT

DrvCOID                 = DetCOID,
DrvEEID                 = DetEEID,
DrvPlanNumber           = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvBatchGroupNumber     = '',
DrvFiller1              = '',
DrvSocialSecurityNumber = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2              = '',
DrvRecordIdentifier     = '63',
DrvServiceUnitAmt       = dbo.dsi_fnpadzero(cast(CurHours as varchar),4,0),
DrvHourEffDate            = replace(convert(char(8), paydt, 112), '/',SPACE(0)),
DrvAddReplInd           = 'R',
DrvReserved             = '',
DrvZeros                = '00000'
--select replace(convert(char(8), GetDate(), 112), '/',SPACE(0))

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_63
--select *
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN vw_int_EmpComp WITH (NOLOCK) ON EecEEID = DetEEID AND EecCOID = DetCOID
--JOIN Company on detcoid = CmpCoID  
--and CmpCompanyCode in ('HH','BHH','SNDNC') 
JOIN (Select PehEEid, PehCoid, SUM(PehCurHrs) CurHours,max(cast(substring(pehpercontrol,1,8)as datetime)) paydt
        from dbo.vw_int_PEarHist
        JOIN EarnCode on ErnEarnCode = PehEarnCode
        where ErnInclInDefCompHrs = 'Y'
        AND        PEhPerControl BETWEEN SUBSTRING(@EndPerControl,1,4) + '01011' AND @EndPerControl
        GROUP BY PehEEID, PehCoid ) CurHrs
        on PehEEID = DetEEID and PehCOID = DetCoid

--select * from U_Dsi_DrvTbl_EFIDDEMO_63
--select prgeeid, prgcoid,* from vw_int_PayReg where prgeeid = '9JC7PL00F0K0' order by prgperiodenddate
--WHERE Det36 = 'Y'



-----------------------
---- Build dbo.U_Dsi_DrvTbl_EFIDDEMO_08 --Updated by J.tran
-----------------------

SELECT DISTINCT

DrvCOID                    = DetCOID,
DrvEEID                    = DetEEID,
DrvPlanNumber              = '37379', --case when CmpCompanyCode in ('HH','BHH','SNDNC') then '93523' Else '37379' end
DrvFiller1                 = '',
DrvSSN                       = SUBSTRING(EepSSN,1,3) + '-' + SUBSTRING(EepSSN,4,2) + '-' + SUBSTRING(EepSSN,6,4),
DrvFiller2                 = '',
DrvReserved                = '00000',
DrvRecordId                   = '08',
DrvSalary                   = CONVERT(VARCHAR,PehCurAmt * 100) ,
DrvSalaryID                = 'R',
DrvReserved2               = '',
DrvSalPayDate              = SUBSTRING(PehPerControl,5,4) + SUBSTRING(PehPerControl,1,4),
DrvFiller3                 = ''

INTO dbo.U_Dsi_DrvTbl_EFIDDEMO_08
FROM dbo.U_EFIDDEMO_EEList_Detail
JOIN EmpPers WITH (NOLOCK) ON EepEEID = DetEEID
JOIN company with (nolock) on cmpcoid = DetCOID
JOIN dbo.U_EFIDDEMO_Pearhist WITH (NOLOCK)
ON PehEEID = DetEEID
AND pehCuramt > 0
--WHERE Det08 = 'Y'




-----------------------
-- Update filename
-----------------------

--UPDATE dbo.U_dsi_Parameters
--   SET ExportFile = 'FPRS.PAS.AMU1TXNS(+1)'
-- WHERE SystemID = @SystemID
GO
CREATE View [dbo].[dsi_vwEFIDDEMO_Export] as
        select top 2000000 UPPER(Data) AS UPPERDATA from dbo.U_EFIDDEMO_File with (nolock)
        order by InitialSort,substring(RecordSet,2,2),Data