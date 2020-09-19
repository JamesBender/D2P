SET NOCOUNT ON;
IF OBJECT_ID('U_EUNUMLAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNUMLAEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNUMLAEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNUMLAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMLAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMLAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMLAEXP];
GO
IF OBJECT_ID('U_EUNUMLAEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_PEarHist];
GO
IF OBJECT_ID('U_EUNUMLAEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_PDedHist];
GO
IF OBJECT_ID('U_EUNUMLAEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_Header];
GO
IF OBJECT_ID('U_EUNUMLAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_File];
GO
IF OBJECT_ID('U_EUNUMLAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_EEList];
GO
IF OBJECT_ID('U_EUNUMLAEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_drvTbl];
GO
IF OBJECT_ID('U_EUNUMLAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_DedList];
GO
IF OBJECT_ID('U_EUNUMLAEXP_benChgReason') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_benChgReason];
GO
IF OBJECT_ID('U_EUNUMLAEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_AuditFields];
GO
IF OBJECT_ID('U_EUNUMLAEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMLAEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMLAEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNUMLAEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNUMLAEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNUMLAEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNUMLAEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNUMLAEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMLAEXP','UNUM Life & ADD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EUNUMLAEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eEnroll2"','1','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','1',NULL,'eEnroll2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY"','2','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','3','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','3',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MEMBER ID"','4','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','4',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOH"','5','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','5',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SALARY"','6','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','6',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SALARY MODE"','7','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','7',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURS"','8','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','8',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM DATE"','9','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','9',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM REASON"','10','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','10',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NEW MEMBER ID"','11','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','11',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','12','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','12',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE NAME"','13','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','13',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','14','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','14',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUFFIX"','15','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','15',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','16','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','16',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','17','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','17',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAIL ADDRESS"','18','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','18',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE FIRST NAME"','19','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','19',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE GDR"','20','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','20',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE DOB"','21','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','21',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLASS"','22','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','22',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SIGNATURE DATE"','23','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','23',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFFECTIVE DATE"','24','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','24',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD TYPE"','25','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','25',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','26','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','26',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','27','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','27',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','28','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','28',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','29','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','29',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','30','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','30',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','31','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','31',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','32','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','32',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','33','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','33',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','34','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','34',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','35','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','35',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','36','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','36',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','37','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','37',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','38','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','38',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','39','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','39',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','40','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','40',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','41','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','41',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','42','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','42',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','43','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','43',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','44','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','44',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','45','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','45',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','46','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','46',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','47','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','47',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','48','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','48',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','49','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','49',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','50','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','50',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','51','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','51',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','52','(''DA''=''T,'')','EUNUMLAEXPZ0','52','H','01','51',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','53','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','53',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','54','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','54',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','55','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','55',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','56','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','56',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','57','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','57',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','58','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','58',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','59','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','59',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','60','(''DA''=''T,'')','EUNUMLAEXPZ0','50','H','01','60',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','61','(''DA''=''T'')','EUNUMLAEXPZ0','50','H','01','61',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','1','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','1',NULL,'RecordCount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy"','2','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','3','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','3',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberID"','4','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','4',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOH"','5','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','5',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','6','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','6',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','7','(''DA''=''T,'')','EUNUMLAEXPZ0','50','D','10','7',NULL,'SALARY MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','EUNUMLAEXPZ0','50','D','10','8',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','9','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','9',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReason"','10','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','10',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNewMemberId"','11','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','11',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','12','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','12',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','13','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','13',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','14','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','14',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','15','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','15',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','16','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','16',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','17','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','17',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','18','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','18',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameFirst"','19','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','19',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseGender"','20','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','20',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDOB"','21','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','21',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClass"','22','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','22',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignatureDate"','23','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','23',NULL,'SIGNATURE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEfectiveDate"','24','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','24',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddType"','25','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','25',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID1"','26','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','26',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode1"','27','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','27',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate1"','28','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','28',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate1"','29','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','29',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt1"','30','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','30',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection1"','31','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','31',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID2"','32','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','32',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode2"','33','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','33',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate2"','34','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','34',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate2"','35','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','35',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt2"','36','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','36',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection2"','37','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','37',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID3"','38','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','38',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode3"','39','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','39',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate3"','40','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','40',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate3"','41','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','41',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt3"','42','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','42',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection3"','43','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','43',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID4"','44','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','44',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode4"','45','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','45',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate4"','46','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','46',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate4"','47','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','47',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt4"','48','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','48',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection4"','49','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','49',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID5"','50','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','50',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode5"','51','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','51',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate5"','52','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','52',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate5"','53','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','53',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt5"','54','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','54',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection5"','55','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','55',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID6"','56','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','56',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode6"','57','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','57',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate6"','58','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','58',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate6"','59','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','59',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt6"','60','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','60',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection6"','61','(''UA''=''T'')','EUNUMLAEXPZ0','50','D','10','61',NULL,'BENEFIT SELECTION',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200903.txt',NULL,'','',NULL,NULL,NULL,NULL,'UNUM Life & ADD Export','202008249','EMPEXPORT','ONDEMAND',NULL,'EUNUMLAEXP',NULL,NULL,NULL,'202008249','Jul 30 2020  5:48PM','Jul 30 2020  5:48PM','202008101',NULL,'','','202008101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200903.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202008249','EMPEXPORT','SCHEDULED',NULL,'EUNUMLAEXP',NULL,NULL,NULL,'202008249','Jul 30 2020  5:48PM','Jul 30 2020  5:48PM','202008101',NULL,'','','202008101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200903.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202008249','EMPEXPORT','OEACTIVE',NULL,'EUNUMLAEXP',NULL,NULL,NULL,'202008249','Jul 30 2020  5:48PM','Jul 30 2020  5:48PM','202008101',NULL,'','','202008101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200903.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202008249','EMPEXPORT','OEPASSIVE',NULL,'EUNUMLAEXP',NULL,NULL,NULL,'202008249','Jul 30 2020  5:48PM','Jul 30 2020  5:48PM','202008101',NULL,'','','202008101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200903.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202008249','EMPEXPORT','TEST','Aug 17 2020 11:32AM','EUNUMLAEXP',NULL,NULL,NULL,'202008249','Aug  6 2020 12:00AM','Dec 30 1899 12:00AM','202008101','41','','','202008101',dbo.fn_GetTimedKey(),NULL,'us3cPeREV1004',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200903.txt',NULL,'','','',NULL,NULL,NULL,'UNUM Life & ADD Full File','202008249','EMPEXPORT','FULLFILE','Aug 24 2020  9:59AM','EUNUMLAEXP',NULL,NULL,NULL,'202008249','Aug 24 2020 12:00AM','Dec 30 1899 12:00AM','202008101','856','','','202008101',dbo.fn_GetTimedKey(),NULL,'us3cPeREV1004',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EUNUMLAEXP_20200903.txt' END WHERE expFormatCode = 'EUNUMLAEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLAEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLAEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EUNUMLAEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNUMLAEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EUNUMLAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMLAEXP','D10','dbo.U_EUNUMLAEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EUNUMLAEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMLAEXP] (
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
IF OBJECT_ID('U_EUNUMLAEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EUNUMLAEXP_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audConSystemID] varchar(255) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL,
    [audDedChange] varchar(1) NOT NULL,
    [audBenOptionChange] varchar(1) NOT NULL,
    [audSSNChange] varchar(1) NOT NULL,
    [audNameChange] varchar(1) NOT NULL,
    [audDemoChange] varchar(1) NOT NULL,
    [audAddrChange] varchar(1) NOT NULL,
    [audNewlyEnroll] varchar(1) NOT NULL,
    [audReEnroll] varchar(1) NOT NULL,
    [audTermPlan] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUNUMLAEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUNUMLAEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EUNUMLAEXP_benChgReason') IS NULL
CREATE TABLE [dbo].[U_EUNUMLAEXP_benChgReason] (
    [EdhEEID] char(12) NOT NULL,
    [EdhCOID] char(5) NOT NULL,
    [LIFEE_Reason] char(6) NULL,
    [LIFES_Reason] char(6) NULL,
    [LIFEC_Reason] char(6) NULL,
    [ADDE_Reason] char(6) NULL,
    [ADDS_Reason] char(6) NULL,
    [ADDC_Reason] char(6) NULL
);
IF OBJECT_ID('U_EUNUMLAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMLAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUNUMLAEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMLAEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(19) NULL,
    [drvRecordCount] varchar(10) NOT NULL,
    [drvPolicy] varchar(6) NOT NULL,
    [drvDivision] varchar(4) NULL,
    [drvMemberID] char(11) NULL,
    [drvDOH] datetime NULL,
    [drvSalary] money NULL,
    [drvTermDate] datetime NULL,
    [drvTermReason] varchar(2) NULL,
    [drvNewMemberId] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvDOB] datetime NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvSpouseNameFirst] varchar(100) NULL,
    [drvSpouseGender] varchar(1) NULL,
    [drvSpouseDOB] datetime NULL,
    [drvClass] varchar(4) NULL,
    [drvSignatureDate] datetime NULL,
    [drvEfectiveDate] datetime NULL,
    [drvAddType] varchar(1) NULL,
    [drvBenefitID1] varchar(2) NULL,
    [drvPlanCode1] varchar(6) NULL,
    [drvBenefitQualDate1] datetime NULL,
    [drvBenefitTermDate1] datetime NULL,
    [drvBenefitSelectionAmt1] nvarchar(4000) NULL,
    [drvBenefitSelection1] varchar(1) NOT NULL,
    [drvBenefitID2] varchar(2) NULL,
    [drvPlanCode2] varchar(6) NULL,
    [drvBenefitQualDate2] datetime NULL,
    [drvBenefitTermDate2] datetime NULL,
    [drvBenefitSelectionAmt2] nvarchar(4000) NULL,
    [drvBenefitSelection2] varchar(1) NOT NULL,
    [drvBenefitID3] varchar(2) NULL,
    [drvPlanCode3] varchar(6) NULL,
    [drvBenefitQualDate3] datetime NULL,
    [drvBenefitTermDate3] datetime NULL,
    [drvBenefitSelectionAmt3] nvarchar(4000) NULL,
    [drvBenefitSelection3] varchar(1) NOT NULL,
    [drvBenefitID4] varchar(2) NULL,
    [drvPlanCode4] varchar(6) NULL,
    [drvBenefitQualDate4] datetime NULL,
    [drvBenefitTermDate4] datetime NULL,
    [drvBenefitSelectionAmt4] nvarchar(4000) NULL,
    [drvBenefitSelection4] varchar(1) NOT NULL,
    [drvBenefitID5] varchar(2) NULL,
    [drvPlanCode5] varchar(6) NULL,
    [drvBenefitQualDate5] datetime NULL,
    [drvBenefitTermDate5] datetime NULL,
    [drvBenefitSelectionAmt5] nvarchar(4000) NULL,
    [drvBenefitSelection5] varchar(1) NOT NULL,
    [drvBenefitID6] varchar(2) NULL,
    [drvPlanCode6] varchar(6) NULL,
    [drvBenefitQualDate6] datetime NULL,
    [drvBenefitTermDate6] datetime NULL,
    [drvBenefitSelectionAmt6] nvarchar(4000) NULL,
    [drvBenefitSelection6] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUNUMLAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMLAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNUMLAEXP_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMLAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EUNUMLAEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EUNUMLAEXP_Header] (
    [drvRecordCount] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EUNUMLAEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMLAEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
IF OBJECT_ID('U_EUNUMLAEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMLAEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMLAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Revolution Foods

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 07/30/2020
Service Request Number: TekP-2020-06-16-0005

Purpose: UNUM Life & ADD Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMLAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMLAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMLAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMLAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMLAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMLAEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMLAEXP', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMLAEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMLAEXP', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMLAEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNUMLAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUMLAEXP';

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
    DELETE FROM dbo.U_EUNUMLAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMLAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    
        DELETE FROM dbo.U_EUNUMLAEXP_EEList
    WHERE xEEID IN (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES'));

    --==========================================
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_EUNUMLAEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_AuditFields;
    CREATE TABLE dbo.U_EUNUMLAEXP_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpComp','EecHourlyRate');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpComp','EecAnnSalary');
    -- Dependent Information
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('Contacts','ConAddressCountry');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpDed','EedBenStopDate');
    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('DepBPlan','DbnBenStopDate');
    -- Deduction/Benefit Information
    --INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('DedCode','DedBenAmt');
    --INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('DedCode','DedBenAmtRateOrPct');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUNUMLAEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audConSystemID =  CASE WHEN audTableName = 'Contacts' THEN audKey3Value
                                WHEN audTableName = 'DepBPlan' THEN DbnDepRecID
                           END
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audDedChange = CASE WHEN audTableName IN ('EmpDed','DepBPlan','DedCode') THEN 'Y'
                             ELSE 'N'
                        END
        ,audBenOptionChange = CASE WHEN audFieldName IN ('EedBenOption') THEN 'Y'
                                   ELSE 'N'
                              END
        ,audSSNChange = CASE WHEN audFieldName IN ('EepSSN','ConSSN') THEN 'Y'
                              ELSE 'N'
                        END
        ,audNameChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Name%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers') AND audFieldName LIKE '%Prefix%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Suffix%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audDemoChange = CASE WHEN audFieldName IN ('EepGender','EepDateOfBirth','EepMaritalStatus','ConGender','ConDateOfBirth','ConRelationship') THEN 'Y'
                              ELSE 'N'
                         END
        ,audAddrChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Address%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audNewlyEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') = '' AND audNewValue = 'A' THEN 'Y'
                               ELSE 'N'
                          END
        ,audReEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') NOT IN ('A','') AND audNewValue = 'A' THEN 'Y'
                            WHEN audFieldName IN ('EedBenStartDate','DbnBenStartDate') AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audTermPlan = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND audOldValue = 'A' AND ISNULL(audNewValue,'') NOT IN ('A','') THEN 'Y'
                            WHEN audFieldName IN ('EedBenStopDate','DbnBenStopDate') AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EUNUMLAEXP_Audit
    FROM dbo.U_EUNUMLAEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_EUNUMLAEXP_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    --WHERE audDateTime BETWEEN @StartDate AND @EndDate
    WHERE audDateTime <= @EndDate
    AND ISNULL(audNewValue, '') <> ''
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_EUNUMLAEXP_DedList))
        OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_EUNUMLAEXP_DedList))
    );



    --================
    -- Changes Only
    --================
    IF (@Exportcode NOT IN ('FULLFILE','OEACTIVE','OEPASSIVE'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_EUNUMLAEXP_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EUNUMLAEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLIF, ADDS, ADDC, ADDE, LTD1, EXSTD, LIFEE, LIFEC, LIFES';

    IF OBJECT_ID('U_EUNUMLAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMLAEXP_DedList
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

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','DAU,SON,DIS,STC')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');

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
    IF OBJECT_ID('U_EUNUMLAEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EUNUMLAEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EUNUMLAEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EUNUMLAEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_PEarHist;
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
    INTO dbo.U_EUNUMLAEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    IF OBJECT_ID('U_EUNUMLAEXP_benChgReason','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_benChgReason;

    SELECT EdhEEID, EdhCOID, MAX(LIFEE_Reason) AS LIFEE_Reason, MAX(LIFES_Reason) AS LIFES_Reason, MAX(LIFEC_Reason) AS LIFEC_Reason, MAX(ADDE_Reason) AS ADDE_Reason, MAX(ADDS_Reason) AS ADDS_Reason, MAX(ADDC_Reason) AS ADDC_Reason
    INTO dbo.U_EUNUMLAEXP_benChgReason
    FROM (
        SELECT EdhEEID, EdhCOID, EdhChangeReason AS LIFEE_Reason, NULL AS LIFES_Reason, NULL AS LIFEC_Reason, NULL AS ADDE_Reason, NULL AS ADDS_Reason, NULL AS ADDC_Reason
        FROM (
            SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID ORDER BY EdhBenStatusDate DESC) AS RN
            FROM dbo.EmpHDed WITH (NOLOCK)
            WHERE EdhDedCode = 'LIFEE'
        ) AS A
        WHERE RN = 1
    UNION
        SELECT EdhEEID, EdhCOID, NULL AS LIFEE_Reason, EdhChangeReason AS LIFES_Reason, NULL AS LIFEC_Reason, NULL AS ADDE_Reason, NULL AS ADDS_Reason, NULL AS ADDC_Reason
        FROM (
            SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID ORDER BY EdhBenStatusDate DESC) AS RN
            FROM dbo.EmpHDed WITH (NOLOCK)
            WHERE EdhDedCode IN ('LIFES')
        ) AS B
        WHERE RN = 1
    UNION
        SELECT EdhEEID, EdhCOID,  NULL AS LIFEE_Reason, NULL  AS LIFES_Reason, EdhChangeReason AS LIFEC_Reason, NULL AS ADDE_Reason, NULL AS ADDS_Reason, NULL AS ADDC_Reason
        FROM (
            SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID ORDER BY EdhBenStatusDate DESC) AS RN
            FROM dbo.EmpHDed WITH (NOLOCK)
            WHERE EdhDedCode IN ('LIFEC')
        ) AS B
        WHERE RN = 1
    UNION
        SELECT EdhEEID, EdhCOID,  NULL AS LIFEE_Reason, NULL  AS LIFES_Reason, NULL AS LIFEC_Reason, EdhChangeReason AS ADDE_Reason, NULL AS ADDS_Reason, NULL AS ADDC_Reason
        FROM (
            SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID ORDER BY EdhBenStatusDate DESC) AS RN
            FROM dbo.EmpHDed WITH (NOLOCK)
            WHERE EdhDedCode IN ('ADDE') 
        ) AS B
        WHERE RN = 1
    UNION
        SELECT EdhEEID, EdhCOID,  NULL AS LIFEE_Reason, NULL  AS LIFES_Reason, NULL AS LIFEC_Reason, NULL AS ADDE_Reason, EdhChangeReason AS ADDS_Reason, NULL AS ADDC_Reason
        FROM (
            SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID ORDER BY EdhBenStatusDate DESC) AS RN
            FROM dbo.EmpHDed WITH (NOLOCK)
            WHERE EdhDedCode IN ('ADDS')
        ) AS B
        WHERE RN = 1
    UNION
        SELECT EdhEEID, EdhCOID,  NULL AS LIFEE_Reason, NULL  AS LIFES_Reason, NULL AS LIFEC_Reason, NULL AS ADDE_Reason, NULL AS ADDS_Reason, EdhChangeReason AS ADDC_Reason
        FROM (
            SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID ORDER BY EdhBenStatusDate DESC) AS RN
            FROM dbo.EmpHDed WITH (NOLOCK)
            WHERE EdhDedCode IN ('ADDC')
        ) AS B
        WHERE RN = 1
    ) AS C
    GROUP BY EdhEEID, EDhCOID



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMLAEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMLAEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' '+ RD + ' ' + CASE WHEN RD = 'A' THEN
                                CASE WHEN LTD1_DedCode IS NOT NULL THEN '0001'
                                    WHEN GLIF_DedCode IS NOT NULL THEN '0002'
                                    WHEN EXSTD_DedCode IS NOT NULL THEN '0003'
                                END
                        ELSE '0001'                            
                        END

        -- standard fields above and additional driver fields below
        ,drvRecordCount = '9999999999'
        ,drvPolicy = CASE WHEN RD = 'A' THEN '143172' ELSE '143173' END
        ,drvDivision = CASE WHEN RD = 'A' THEN
                                CASE WHEN LTD1_DedCode IS NOT NULL THEN '0001'
                                    WHEN GLIF_DedCode IS NOT NULL THEN '0002'
                                    WHEN EXSTD_DedCode IS NOT NULL THEN '0003'
                                END
                        ELSE '0001'                            
                        END
        ,drvMemberID = EepSSN
        ,drvDOH = EecDateOfLastHire
        ,drvSalary = EecAnnSalary
        ,drvTermDate =    CASE WHEN EecEmplStatus = 'T' THEN 
                            CASE WHEN GLIF_DedCode IS NOT NULL THEN GLIF_BenStopDate 
                                WHEN LTD1_DedCode IS NOT NULL THEN LTD1_BenStopDate
                                WHEN EXSTD_DedCode IS NOT NULL THEN EXSTD_BenStopDate
                                WHEN LIFEE_DedCode IS NOT NULL THEN LIFEE_BenStopDate
                                WHEN LIFEC_DedCode IS NOT NULL THEN LIFEC_BenStopDate
                                WHEN LIFES_DedCode IS NOT NULL THEN LIFES_BenStopDate
                                WHEN ADDS_DedCode IS NOT NULL THEN ADDS_BenStopDate
                                WHEN ADDC_DedCode IS NOT NULL THEN ADDC_BenStopDate
                                WHEN ADDE_DedCode IS NOT NULL THEN ADDE_BenStopDate
                            END
                        END
        ,drvTermReason =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason IN ('203') THEN 'DT'
                                WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202') THEN 'RT'
                                WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN 'TE'
                            END
        ,drvNewMemberId = CASE WHEN ISNULL(EepOldSSN, '') <> '' THEN EepSSN END
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvGender =    CASE WHEN EepGender = 'M' /*OR ConGender = 'M'*/ THEN 'M'
                            WHEN EepGender = 'F'/* OR ConGender = 'F'*/ THEN 'F'
                            ELSE 'U'
                        END
        ,drvDOB = EepDateOfBirth
        ,drvEmailAddress =    CASE WHEN ISNULL(EepAddressEMail, '') <> '' THEN EepAddressEMail
                                ELSE EepAddressEmailAlternate
                            END
        ,drvSpouseNameFirst = CASE WHEN LIFES_DedCode IS NOT NULL OR ADDS_DedCode IS NOT NULL THEN ConNameFirst END 
        ,drvSpouseGender =    CASE WHEN LIFES_DedCode IS NOT NULL OR ADDS_DedCode IS NOT NULL THEN 
                                    CASE WHEN ConGender = 'M' THEN 'M'
                                        WHEN ConGender = 'F' THEN 'F'
                                        ELSE 'U'
                                    END
                                END 
        ,drvSpouseDOB = CASE WHEN LIFES_DedCode IS NOT NULL OR ADDS_DedCode IS NOT NULL THEN ConDateOfBirth END 
        ,drvClass =    CASE WHEN RD = 'A' THEN
                        CASE WHEN LTD1_DedCode IS NOT NULL THEN '0001'
                            WHEN EXSTD_DedCode IS NOT NULL THEN '0100'
                            WHEN GLIF_DedCode IS NOT NULL THEN '1000'
                        END
                    ELSE
                        CASE WHEN LIFEE_DedCode IS NOT NULL
                                OR LIFEC_DedCode IS NOT NULL
                                OR LIFES_DedCode IS NOT NULL
                                OR ADDS_DedCode IS NOT NULL
                                OR ADDC_DedCode IS NOT NULL
                                OR ADDE_DedCode IS NOT NULL THEN '1000'
                        END
                    END
        ,drvSignatureDate = Max_BenStartDate
        ,drvEfectiveDate =    CASE WHEN AudReHireB = 'Y' THEN dbo.dsi_fnGetMinMaxDates('MAX',EecDateOfLastHire, Max_BenStartDate) --EecDateOfLastHire -- JCB
                                WHEN AudTermB = 'Y' THEN dbo.dsi_fnGetMinMaxDates('MAX',EecDateOfTermination, Max_BenStartDate)
                                WHEN AudSalaryChangeB = 'Y' THEN dbo.dsi_fnGetMinMaxDates('MAX',EjhJobEffDate, Max_BenStartDate)
                                ELSE Max_BenStartDate
                            END
        ,drvAddType = CASE WHEN EecFullTimeOrPartTime = 'F' AND EjhFullTimeOrPartTime = 'P' THEN 'O' END
        ,drvBenefitID1 = CASE WHEN LIFEE_DedCode IS NOT NULL THEN 'LM' END
        ,drvPlanCode1 = CASE WHEN LIFEE_DedCode IS NOT NULL THEN '5.0N22' END
        ,drvBenefitQualDate1 = CASE WHEN LIFEE_DedCode IS NOT NULL AND LIFEE_Reason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','105','201','202','203','204','210','300','303') THEN LIFEE_EligDate END
        ,drvBenefitTermDate1 = CASE WHEN LIFEE_DedCode IS NOT NULL AND EecEmplStatus <> 'T' THEN LIFEE_BenStopDate END
        ,drvBenefitSelectionAmt1 = CASE WHEN LIFEE_DedCode IS NOT NULL THEN FORMAT(LIFEE_BenAmt, '#0.00') END    
        ,drvBenefitSelection1 = ''
        ,drvBenefitID2 = CASE WHEN LIFES_DedCode IS NOT NULL THEN 'LS' END
        ,drvPlanCode2 = CASE WHEN LIFES_DedCode IS NOT NULL THEN '5.AN47' END
        ,drvBenefitQualDate2 = CASE WHEN LIFES_DedCode IS NOT NULL AND LIFES_Reason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','105','201','202','203','204','210','300','303') THEN LIFES_EligDate END
        ,drvBenefitTermDate2 = CASE WHEN LIFES_DedCode IS NOT NULL AND EecEmplStatus <> 'T' THEN LIFES_BenStopDate END
        ,drvBenefitSelectionAmt2 = CASE WHEN LIFES_DedCode IS NOT NULL THEN FORMAT(LIFES_BenAmt, '#0.00') END    
        ,drvBenefitSelection2 = ''
        ,drvBenefitID3 = CASE WHEN LIFEC_DedCode IS NOT NULL THEN 'LC' END
        ,drvPlanCode3 = CASE WHEN LIFEC_DedCode IS NOT NULL THEN '5.0M04' END
        ,drvBenefitQualDate3 = CASE WHEN LIFEC_DedCode IS NOT NULL AND LIFEC_Reason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','105','201','202','203','204','210','300','303') THEN LIFEC_EligDate END
        ,drvBenefitTermDate3 = CASE WHEN LIFEC_DedCode IS NOT NULL AND EecEmplStatus <> 'T' THEN LIFEC_BenStopDate END
        ,drvBenefitSelectionAmt3 = CASE WHEN LIFEC_DedCode IS NOT NULL THEN FORMAT(LIFEC_BenAmt, '#0.00') END    
        ,drvBenefitSelection3 = ''
        ,drvBenefitID4 = CASE WHEN ADDE_DedCode IS NOT NULL THEN 'AM' END
        ,drvPlanCode4 = CASE WHEN ADDE_DedCode IS NOT NULL THEN '5.0S17' END
        ,drvBenefitQualDate4 = CASE WHEN ADDE_DedCode IS NOT NULL AND ADDE_Reason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','105','201','202','203','204','210','300','303') THEN ADDE_EligDate END
        ,drvBenefitTermDate4 = CASE WHEN ADDE_DedCode IS NOT NULL AND EecEmplStatus <> 'T' THEN ADDE_BenStopDate END
        ,drvBenefitSelectionAmt4 = CASE WHEN ADDE_DedCode IS NOT NULL THEN FORMAT(ADDE_BenAmt, '#0.00') END    
        ,drvBenefitSelection4 = ''
        ,drvBenefitID5 = CASE WHEN ADDS_DedCode IS NOT NULL THEN 'AS' END
        ,drvPlanCode5 = CASE WHEN ADDS_DedCode IS NOT NULL THEN '5.0L02' END
        ,drvBenefitQualDate5 = CASE WHEN ADDS_DedCode IS NOT NULL AND ADDS_Reason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','105','201','202','203','204','210','300','303') THEN ADDS_EligDate END
        ,drvBenefitTermDate5 = CASE WHEN ADDS_DedCode IS NOT NULL AND EecEmplStatus <> 'T' THEN ADDS_BenStopDate END
        ,drvBenefitSelectionAmt5 = CASE WHEN ADDS_DedCode IS NOT NULL THEN FORMAT(ADDS_BenAmt, '#0.00') END    
        ,drvBenefitSelection5 = ''
        ,drvBenefitID6 = CASE WHEN ADDC_DedCode IS NOT NULL THEN 'AC' END
        ,drvPlanCode6 = CASE WHEN ADDC_DedCode IS NOT NULL THEN '5.0L23' END
        ,drvBenefitQualDate6 = CASE WHEN ADDC_DedCode IS NOT NULL AND ADDC_Reason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','105','201','202','203','204','210','300','303') THEN ADDC_EligDate END
        ,drvBenefitTermDate6 = CASE WHEN ADDC_DedCode IS NOT NULL AND EecEmplStatus <> 'T' THEN ADDC_BenStopDate END
        ,drvBenefitSelectionAmt6 = CASE WHEN ADDC_DedCode IS NOT NULL THEN FORMAT(ADDC_BenAmt, '#0.00') END    
        ,drvBenefitSelection6 = ''
    INTO dbo.U_EUNUMLAEXP_drvTbl
    FROM dbo.U_EUNUMLAEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmRecType
                ,'B' AS RD
                ,MAX(CASE WHEN BdmDedCode = 'GLIF' THEN BdmDedCode END) AS GLIF_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD1' THEN BdmDedCode END) AS LTD1_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'EXSTD' THEN BdmDedCode END) AS EXSTD_DedCode    
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS LIFEE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS LIFEC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS LIFES_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDS' THEN BdmDedCode END) AS ADDS_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDC' THEN BdmDedCode END) AS ADDC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'ADDE' THEN BdmDedCode END) AS ADDE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GLIF' THEN BdmBenStopDate END) AS GLIF_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD1' THEN BdmBenStopDate END) AS LTD1_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'EXSTD' THEN BdmBenStopDate END) AS EXSTD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStopDate END) AS LIFEE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStopDate END) AS LIFEC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStopDate END) AS LIFES_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDS' THEN BdmBenStopDate END) AS ADDS_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDC' THEN BdmBenStopDate END) AS ADDC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'ADDE' THEN BdmBenStopDate END) AS ADDE_BenStopDate
            FROM dbo.U_dsi_BDM_EUNUMLAEXP WITH (NOLOCK)
            WHERE BdmDedCode NOT IN ('GLIF','LTD1','EXSTD')
            GROUP BY BdmEEID, BdmCOID, BdmRecType

            UNION

            SELECT BdmEEID, BdmCOID, BdmRecType
                ,'A' AS RD
                ,CASE WHEN BdmDedCode = 'GLIF' THEN BdmDedCode END AS GLIF_DedCode
                ,CASE WHEN BdmDedCode = 'LTD1' THEN BdmDedCode END AS LTD1_DedCode
                ,CASE WHEN BdmDedCode = 'EXSTD' THEN BdmDedCode END AS EXSTD_DedCode    
                ,NULL AS LIFEE_DedCode
                ,NULL AS LIFEC_DedCode
                ,NULL AS LIFES_DedCode
                ,NULL AS ADDS_DedCode
                ,NULL AS ADDC_DedCode
                ,NULL AS ADDE_DedCode
                ,CASE WHEN BdmDedCode = 'GLIF' THEN BdmBenStopDate END AS GLIF_BenStopDate
                ,CASE WHEN BdmDedCode = 'LTD1' THEN BdmBenStopDate END AS LTD1_BenStopDate
                ,CASE WHEN BdmDedCode = 'EXSTD' THEN BdmBenStopDate END AS EXSTD_BenStopDate
                ,NULL AS LIFEE_BenStopDate
                ,NULL AS LIFEC_BenStopDate
                ,NULL AS LIFES_BenStopDate
                ,NULL AS ADDS_BenStopDate
                ,NULL AS ADDC_BenStopDate
                ,NULL AS ADDE_BenStopDate
            FROM dbo.U_dsi_BDM_EUNUMLAEXP WITH (NOLOCK)
            WHERE BdmDedCode IN ('GLIF','LTD1','EXSTD')    ) AS Bdm_Grouped
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    JOIN (                
            SELECT BdmEEID AS BdmEEIDU, BdmCOID AS BdmCOIDU, BdmRecType AS BdmRecTypeU, BdmDepRecID AS BdmDepRecIDU
                ,MAX(BdmBenStartDate) AS Max_BenStartDate
            FROM dbo.U_dsi_BDM_EUNUMLAEXP WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecID) AS Bdm_UnGrouped
        ON BdmEEIDU = xEEID
        AND BdmCOIDU = xCOID
    LEFT JOIN (                    
                SELECT ConEEID, ConNameFirst, ConNameLast, ConGender, ConDateOfBirth
                FROM (
                    SELECT DISTINCT ConEEID, ConNameFirst, ConNameLast, ConGender, ConDateOfBirth, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY ConSystemID DESC) AS RN
                    FROM dbo.Contacts WITH (NOLOCK) 
                    WHERE ConRelationship IN ('SPS','DP') 
                        AND ConIsDependent = 'Y') AS C
                WHERE RN = 1
            ) AS Con
        ON ConEEID = xEEID
    /*LEFT JOIN dbo.U_EUNUMLAEXP_Audit WITH (NOLOCK)
        ON xEEID = audEEID
        AND audKey2 = xCOID*/
    LEFT JOIN (
                    SELECT audEEID,audCOID,audConSystemID,audKey1,audKey2,audKey3,audTableName,audFieldName,audAction,audDateTime,audOldValue,audNewValue,audEffectiveDate,audRowNo,audDedChange,audBenOptionChange,audSSNChange,audNameChange,audDemoChange,audAddrChange,audNewlyEnroll,audReEnroll,audTermPlan,audReHire,audTerm,audSalaryChange
                    FROM dbo.U_EUNUMLAEXP_Audit WITH (NOLOCK)
                    WHERE audTableName <> 'EmpComp' 
                        AND audFieldName <> 'EecAnnSalary' 
                        and audRowNo = 1
            ) AS AuditTable
        ON xEEID = audEEID
        AND audKey2 = xCOID
    LEFT JOIN (
                    SELECT AudReHire AS AudReHireB, AudTerm AS AudTermB, AudSalaryChange AS AudSalaryChangeB, audEEID AS audEEIDB, audCOID AS audCOIDB
                    FROM dbo.U_EUNUMLAEXP_Audit WITH (NOLOCK)
                    WHERE audTableName = 'EmpComp' 
                        AND audFieldName = 'EecAnnSalary' 
                        AND audRowNo = 1
            ) AS AuditTableB
        ON xEEID = audEEIDB
        AND audKey2 = audCOIDB
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhJobEffDate, EjhFullTimeOrPartTime
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhJobEffDate, EjhFullTimeOrPartTime, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM EmpHJob WITH (NOLOCK) 
                        WHERE EjhIsRateChange = 'Y'
                    ) AS X
                WHERE RN = 1) AS EJH_Flat
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    LEFT JOIN dbo.U_EUNUMLAEXP_benChgReason WITH (NOLOCK)
        ON xEEID = EdhEEID
        AND xCOID = EDhCOID
    LEFT JOIN (
                    SELECT EedEEID, EedCOID
                        ,MAX(CASE WHEN EedDedCode = 'LIFEE' THEN EedEEEligDate END) AS LIFEE_EligDate
                        ,MAX(CASE WHEN EedDedCode = 'LIFES' THEN EedEEEligDate END) AS LIFES_EligDate
                        ,MAX(CASE WHEN EedDedCode = 'LIFEC' THEN EedEEEligDate END) AS LIFEC_EligDate
                        ,MAX(CASE WHEN EedDedCode = 'ADDE' THEN EedEEEligDate END) AS ADDE_EligDate
                        ,MAX(CASE WHEN EedDedCode = 'ADDS' THEN EedEEEligDate END) AS ADDS_EligDate
                        ,MAX(CASE WHEN EedDedCode = 'ADDC' THEN EedEEEligDate END) AS ADDC_EligDate

                        ,MAX(CASE WHEN EedDEdCode = 'LIFEE' THEN EedBenAmt END) AS LIFEE_BenAmt
                        ,MAX(CASE WHEN EedDEdCode = 'LIFES' THEN EedBenAmt END) AS LIFES_BenAmt
                        ,MAX(CASE WHEN EedDEdCode = 'LIFEC' THEN EedBenAmt END) AS LIFEC_BenAmt

                        ,MAX(CASE WHEN EedDEdCode = 'ADDE' THEN EedBenAmt END) AS ADDE_BenAmt
                        ,MAX(CASE WHEN EedDEdCode = 'ADDS' THEN EedBenAmt END) AS ADDS_BenAmt
                        ,MAX(CASE WHEN EedDEdCode = 'ADDC' THEN EedBenAmt END) AS ADDC_BenAmt

                    FROM dbo.EmpDed WITH (NOLOCK)
                    WHERE EedDedCode IN ('LIFEE', 'LIFEC', 'LIFES', 'ADDE', 'ADDS','ADDC')
                    GROUP BY EedEEID, EedCOID) As EligDate
        ON EedEEID = xEEID
        AND EedCOID = xCOID
    ;


    UPDATE dbo.U_EUNUMLAEXP_drvTbl
SET drvRecordCount = FORMAT((SELECT COUNT(*) FROM dbo.U_EUNUMLAEXP_drvTbl), '#0')
WHERE drvSort IN (select TOP 1 drvSort from dbo.U_EUNUMLAEXP_drvTbl A Order By A.drvSort)

UPDATE dbo.U_EUNUMLAEXP_drvTbl
SET drvRecordCount = ''
WHERE drvSort NOT IN (select TOP 1 drvSort from dbo.U_EUNUMLAEXP_drvTbl A Order By A.drvSort)

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    /*IF OBJECT_ID('U_EUNUMLAEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_Header;
    SELECT DISTINCT
         drvRecordCount = FORMAT((SELECT COUNT(*) FROM dbo.U_EUNUMLAEXP_drvTbl), '#0')
    INTO dbo.U_EUNUMLAEXP_Header
    ;*/

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
ALTER VIEW dbo.dsi_vwEUNUMLAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMLAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMLAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates 
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202008101'
       ,expStartPerControl     = '202008101'
       ,expLastEndPerControl   = '202008249'
       ,expEndPerControl       = '202008249'
WHERE expFormatCode = 'EUNUMLAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMLAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMLAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort 