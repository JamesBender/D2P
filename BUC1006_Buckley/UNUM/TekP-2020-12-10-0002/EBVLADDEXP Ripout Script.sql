SET NOCOUNT ON;
IF OBJECT_ID('U_EBVLADDEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBVLADDEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBVLADDEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBVLADDEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEBVLADDEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBVLADDEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBVLADDEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBVLADDEXP];
GO
IF OBJECT_ID('U_EBVLADDEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EBVLADDEXP_File];
GO
IF OBJECT_ID('U_EBVLADDEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBVLADDEXP_EEList];
GO
IF OBJECT_ID('U_EBVLADDEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBVLADDEXP_drvTbl];
GO
IF OBJECT_ID('U_EBVLADDEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBVLADDEXP_DedList];
GO
IF OBJECT_ID('U_EBVLADDEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBVLADDEXP_AuditFields];
GO
IF OBJECT_ID('U_EBVLADDEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBVLADDEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EBVLADDEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBVLADDEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBVLADDEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBVLADDEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBVLADDEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBVLADDEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBVLADDEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBVLADDEXP','UNUM B ADD LTD L ADD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EBVLADDEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBVLADDEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eEnroll2"','1','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','1',NULL,'eEnroll2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY"','2','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','3','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','3',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MEMBER ID"','4','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','4',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOH"','5','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','5',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SALARY"','6','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','6',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SALARY MODE"','7','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','7',NULL,'SALARY MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURS"','8','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','8',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM DATE"','9','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','9',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM REASON"','10','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','10',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NEW MEMBER ID"','11','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','11',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','12','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','12',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE NAME"','13','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','13',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','14','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','14',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUFFIX"','15','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','15',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','16','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','16',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','17','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','17',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAIL ADDRESS"','18','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','18',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE FIRST NAME"','19','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','19',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE GDR"','20','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','20',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE DOB"','21','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','21',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLASS"','22','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','22',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SIGNATURE DATE"','23','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','23',NULL,'SIGNATURE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFFECTIVE DATE"','24','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','24',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD TYPE"','25','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','25',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','26','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','26',NULL,'BENEFIT ID 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','27','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','27',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','28','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','28',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','29','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','29',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','30','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','30',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','31','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','31',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','32','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','32',NULL,'BENEFIT ID 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','33','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','33',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','34','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','34',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','35','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','35',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','36','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','36',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','37','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','37',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','38','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','38',NULL,'BENEFIT ID 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','39','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','39',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','40','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','40',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','41','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','41',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','42','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','42',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','43','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','43',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','44','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','44',NULL,'BENEFIT ID 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','45','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','45',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','46','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','46',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','47','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','47',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','48','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','48',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','49','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','49',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','50','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','50',NULL,'BENEFIT ID 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','51','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','51',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','52','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','52',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','53','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','53',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','54','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','54',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','55','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','55',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','56','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','56',NULL,'BENEFIT ID 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','57','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','57',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','58','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','58',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','59','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','59',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','60','(''DA''=''T,'')','EBVLADDEXPZ0','50','H','01','60',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','61','(''DA''=''T'')','EBVLADDEXPZ0','50','H','01','61',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnroll2"','1','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','1',NULL,'eEnroll2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy"','2','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','3','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','3',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberId"','4','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','4',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOH"','5','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','5',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','6','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','6',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','7','(''DA''=''T,'')','EBVLADDEXPZ0','50','D','10','7',NULL,'SALARY MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','EBVLADDEXPZ0','50','D','10','8',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','9','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','9',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReason"','10','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','10',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNewMemberId"','11','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','11',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','12','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','12',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','13','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','13',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','14','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','14',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','15','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','15',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','16','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','16',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','17','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','17',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','18','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','18',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameFirst"','19','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','19',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseGender"','20','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','20',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDateOfBirth"','21','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','21',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClass"','22','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','22',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignatureDate"','23','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','23',NULL,'SIGNATURE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','24','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','24',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddType"','25','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','25',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId1"','26','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','26',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode1"','27','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','27',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate1"','28','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','28',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate1"','29','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','29',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt1"','30','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','30',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','EBVLADDEXPZ0','50','D','10','31',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId2"','32','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','32',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode2"','33','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','33',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate2"','34','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','34',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate2"','35','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','35',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt2"','36','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','36',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EBVLADDEXPZ0','50','D','10','37',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId3"','38','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','38',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode3"','39','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','39',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate3"','40','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','40',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate3"','41','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','41',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt3"','42','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','42',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T,'')','EBVLADDEXPZ0','50','D','10','43',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId4"','44','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','44',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode4"','45','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','45',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate4"','46','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','46',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate4"','47','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','47',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt4"','48','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','48',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T,'')','EBVLADDEXPZ0','50','D','10','49',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId5"','50','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','50',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode5"','51','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','51',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate5"','52','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','52',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate5"','53','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','53',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt5"','54','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','54',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T,'')','EBVLADDEXPZ0','50','D','10','55',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId6"','56','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','56',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode6"','57','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','57',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate6"','58','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','58',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate6"','59','(''UD101''=''T,'')','EBVLADDEXPZ0','50','D','10','59',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt6"','60','(''UA''=''T,'')','EBVLADDEXPZ0','50','D','10','60',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''T'')','EBVLADDEXPZ0','50','D','10','61',NULL,'BENEFIT SELECTION',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EBVLADDEXP_20211004.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM B ADD LTD L ADD Full File','202109219','EMPEXPORT','FULLFILE','Sep 21 2021  8:49AM','EBVLADDEXP',NULL,NULL,NULL,'202109219','Sep 21 2021 12:00AM','Dec 30 1899 12:00AM','202109071','460','','','202109071',dbo.fn_GetTimedKey(),NULL,'us3lKiBUC1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202103229','EMPEXPORT','OEACTIVE','Mar 31 2021  1:31PM','EBVLADDEXP',NULL,NULL,NULL,'202103229','Mar 22 2021  5:43PM','Mar 22 2021  5:43PM','202101011','92','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202103229','EMPEXPORT','OEPASSIVE','Mar 31 2021  1:32PM','EBVLADDEXP',NULL,NULL,NULL,'202103229','Mar 22 2021  5:43PM','Mar 22 2021  5:43PM','202101011','190','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM B ADD LTD L ADD Export','202103229','EMPEXPORT','ONDEM_XOE','Mar 31 2021  1:32PM','EBVLADDEXP',NULL,NULL,NULL,'202103229','Mar 22 2021  5:43PM','Mar 22 2021  5:43PM','202101011','193','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',Q3ZXL,Q3ZVA',NULL,NULL,NULL,'UNUM LifeLTD - Monthly on 9th','202103229','EMPEXPORT','SCH_EBVLAD','Mar 31 2021  1:32PM','EBVLADDEXP',NULL,NULL,NULL,'202109099','Mar 22 2021  5:43PM','Mar 22 2021  5:43PM','202109011','193','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM B ADD LTD L ADD Exp-Test','202108099','EMPEXPORT','TEST_XOE','Sep 29 2021  2:10PM','EBVLADDEXP',NULL,NULL,NULL,'202108099','Aug  9 2021 12:00AM','Dec 30 1899 12:00AM','202107091','149','','','202107091',dbo.fn_GetTimedKey(),NULL,'us3lKiBUC1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBVLADDEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBVLADDEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBVLADDEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBVLADDEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBVLADDEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EBVLADDEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EBVLADDEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EBVLADDEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBVLADDEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBVLADDEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBVLADDEXP','D10','dbo.U_EBVLADDEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EBVLADDEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBVLADDEXP] (
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
IF OBJECT_ID('U_EBVLADDEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EBVLADDEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBVLADDEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBVLADDEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EBVLADDEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EBVLADDEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EBVLADDEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBVLADDEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEnroll2] varchar(1) NOT NULL,
    [drvPolicy] varchar(6) NULL,
    [drvDivision] varchar(4) NOT NULL,
    [drvMemberId] char(11) NULL,
    [drvDOH] datetime NULL,
    [drvSalary] nvarchar(4000) NULL,
    [drvTermDate] datetime NULL,
    [drvTermReason] varchar(2) NULL,
    [drvNewMemberId] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvSpouseNameFirst] varchar(100) NULL,
    [drvSpouseGender] char(1) NULL,
    [drvSpouseDateOfBirth] datetime NULL,
    [drvClass] varchar(4) NULL,
    [drvSignatureDate] datetime NULL,
    [drvEffectiveDate] datetime NULL,
    [drvAddType] varchar(1) NULL,
    [drvBenefitId1] varchar(2) NULL,
    [drvPlanCode1] varchar(6) NULL,
    [drvBenefitQualDate1] datetime NULL,
    [drvBenefitTermDate1] datetime NULL,
    [drvBenefitSelectionAmt1] nvarchar(4000) NULL,
    [drvBenefitId2] varchar(2) NULL,
    [drvPlanCode2] varchar(6) NULL,
    [drvBenefitQualDate2] datetime NULL,
    [drvBenefitTermDate2] datetime NULL,
    [drvBenefitSelectionAmt2] nvarchar(4000) NULL,
    [drvBenefitId3] varchar(2) NULL,
    [drvPlanCode3] varchar(6) NULL,
    [drvBenefitQualDate3] datetime NULL,
    [drvBenefitTermDate3] datetime NULL,
    [drvBenefitSelectionAmt3] nvarchar(4000) NULL,
    [drvBenefitId4] varchar(2) NULL,
    [drvPlanCode4] varchar(6) NULL,
    [drvBenefitQualDate4] datetime NULL,
    [drvBenefitTermDate4] datetime NULL,
    [drvBenefitSelectionAmt4] nvarchar(4000) NULL,
    [drvBenefitId5] varchar(1) NOT NULL,
    [drvPlanCode5] varchar(1) NOT NULL,
    [drvBenefitQualDate5] varchar(1) NOT NULL,
    [drvBenefitTermDate5] varchar(1) NOT NULL,
    [drvBenefitSelectionAmt5] varchar(1) NOT NULL,
    [drvBenefitId6] varchar(1) NOT NULL,
    [drvPlanCode6] varchar(1) NOT NULL,
    [drvBenefitQualDate6] varchar(1) NOT NULL,
    [drvBenefitTermDate6] varchar(1) NOT NULL,
    [drvBenefitSelectionAmt6] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBVLADDEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EBVLADDEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EBVLADDEXP_File') IS NULL
CREATE TABLE [dbo].[U_EBVLADDEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBVLADDEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Buckley

Created By: James Bender
Business Analyst: Lea King
Create Date: 03/22/2021
Service Request Number: TekP-2020-12-10-0002

Purpose: UNUM B ADD LTD L ADD Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBVLADDEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBVLADDEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBVLADDEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBVLADDEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBVLADDEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBVLADDEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBVLADDEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBVLADDEXP', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBVLADDEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBVLADDEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBVLADDEXP', 'SCH_EBVLAD';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBVLADDEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBVLADDEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBVLADDEXP';

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
    DELETE FROM dbo.U_EBVLADDEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBVLADDEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EBVLADDEXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBVLADDEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBVLADDEXP_AuditFields;
    CREATE TABLE dbo.U_EBVLADDEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepSSN');

    -- Employee Information
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepNameSuffix');
    /*INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepAddressCountry');*/
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    --INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepIsDisabled');
    --INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    --INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpComp','EECUDFIELD09');
    -- Dependent Information
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConDateOfBirth');
--    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConRelationship');
    /*INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('Contacts','ConAddressCountry');*/

    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('EmpDed','EedBenStopDate');

    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_EBVLADDEXP_AuditFields VALUES ('DepBPlan','DbnBenStopDate');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBVLADDEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBVLADDEXP_Audit;
    SELECT 
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

        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE --WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' 
                                WHEN audTableName = 'EmpComp' AND ISNULL('EECUDFIELD09','') <> '' and audAction = 'Update' THEN 'Y'
                                ELSE 'N' 
                            END


    INTO dbo.U_EBVLADDEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBVLADDEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBVLADDEXP_Audit ON dbo.U_EBVLADDEXP_Audit (audEEID,audKey2);

    --SELECT @ExportCode;

    --================
    -- Changes Only
    --================
    IF @ExportCode <> 'FULLFILE' 
    BEGIN
        DELETE FROM dbo.U_EBVLADDEXP_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBVLADDEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GTL1,GTL2,GTL3,GTL4,GTLP,LTD10,LTD20,LTDP,VLE,VADD,VLS,VLC';

    IF OBJECT_ID('U_EBVLADDEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBVLADDEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBVLADDEXP_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBVLADDEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBVLADDEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBVLADDEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' --NVOL_StartDate 
                    --VOL_StartDate
                    --audDateTime
        -- standard fields above and additional driver fields below
        ,drvEnroll2 = ''
        ,drvPolicy =    CASE WHEN GTL1_DedCode IS NOT NULL OR GTL2_DedCode IS NOT NULL OR GTL3_DedCode IS NOT NULL OR GTL4_DedCode IS NOT NULL OR GTLP_DedCode IS NOT NULL 
                            AND LTD10_DedCode IS NOT NULL OR LTD20_DedCode IS NOT NULL OR LTDP_DedCode IS NOT NULL THEN '656271'
                            WHEN VLE_DedCode IS NOT NULL OR VLS_DedCode IS NOT NULL OR VLC_DedCode IS NOT NULL OR VADD_DedCode IS NOT NULL THEN '656272'
                        END
        /*CASE WHEN BdmDedCode IN ('GTL1','GTL2','GTL3','GTL4','GTLP','LTD10','LTD20','LTDP') THEN '656271'
                            WHEN BdmDedCode IN ('VLE','VLS','VLC','VADD') THEN '656272'
                        END*/
        ,drvDivision = CASE WHEN EecOrgLvl1 = '4700' THEN '0002' ELSE '0001' END
        ,drvMemberId = EepSSN
        ,drvDOH = EecDateOfLastHire
        ,drvSalary = FORMAT(EecUdField09, '#0.00')
        ,drvTermDate =    CASE WHEN EecEmplStatus = 'T' THEN eecdateoftermination END
                        --    CASE WHEN GTL1_DedCode IS NOT NULL THEN GTL1_BenStopDate
                        --        WHEN GTL2_DedCode IS NOT NULL THEN GTL2_BenStopDate
                        --        WHEN GTL3_DedCode IS NOT NULL THEN GTL3_BenStopDate
                        --        WHEN GTL4_DedCode IS NOT NULL THEN GTL4_BenStopDate
                        --        WHEN GTLP_DedCode IS NOT NULL THEN GTLP_BenStopDate
                        --        WHEN LTD10_DedCode IS NOT NULL THEN LTD10_BenStopDate
                        --        WHEN LTD20_DedCode IS NOT NULL THEN LTD20_BenStopDate
                        --        WHEN LTDP_DedCode IS NOT NULL THEN LTDP_BenStopDate
                        --        WHEN VLE_DedCode IS NOT NULL THEN VLE_BenStopDate
                        --        WHEN VLS_DedCode IS NOT NULL THEN VLS_BenStopDate
                        --        WHEN VLC_DedCode IS NOT NULL THEN VLC_BenStopDate
                        --        WHEN VADD_DedCode IS NOT NULL THEN VADD_BenStopDate
                        --    END
                        --END
        ,drvTermReason =    CASE WHEN EecEmplStatus = 'T' THEN 
                                CASE WHEN EecTermReason = '203' THEN 'DT'
                                    WHEN EecTermReason = '202' THEN 'RT'
                                    WHEN EecTermReason NOT IN ('202','203') THEN 'TE'
                                END
                            END
        ,drvNewMemberId = CASE WHEN eepOldSSN IS NOT NULL THEN eepSSN END
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvGender = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvEmailAddress = EepAddressEMail
        ,drvSpouseNameFirst = CASE WHEN VLS_DedCode IS NOT NULL AND ConIsDependent = 'Y' THEN Spouse.ConNameFirst END
        ,drvSpouseGender = CASE WHEN VLS_DedCode IS NOT NULL AND ConIsDependent = 'Y' THEN Spouse.ConGender END
        ,drvSpouseDateOfBirth = CASE WHEN VLS_DedCode IS NOT NULL AND ConIsDependent = 'Y' AND Spouse.ConDateOfBirth is NOT NULL THEN Spouse.ConDateOfBirth
                                        WHEN VLS_DedCode IS NOT NULL AND ConIsDependent = 'Y' AND Spouse.ConDateOfBirth is NULL THEN EepDateOfBirth 
                                        END
        ,drvClass =    CASE WHEN EecDedGroupCode = 'PART' AND LTD10_DedCode IS NULL AND LTD20_DedCode IS NULL AND LTDP_DedCode IS NULL THEN '1000'
                    WHEN EecDedGroupCode = 'PART' AND (LTD10_DedCode IS NOT NULL OR LTD20_DedCode IS NOT NULL OR LTDP_DedCode IS NOT NULL) THEN '1001'
                    WHEN (VLE_DedCode IS NOT NULL OR VLS_DedCode IS NOT NULL OR VLC_DedCode IS NOT NULL OR VADD_DedCode IS NOT NULL) AND EecDedGroupCode <> 'PART' THEN '2000'
                    WHEN  GTL1_DedCode IS NOT NULL OR GTL2_DedCode IS NOT NULL OR GTL3_DedCode IS NOT NULL OR GTL4_DedCode IS NOT NULL OR GTLP_DedCode IS NOT NULL OR LTD10_DedCode IS NOT NULL OR LTD20_DedCode IS NOT NULL OR LTDP_DedCode IS NOT NULL THEN
                        CASE WHEN EecDedGroupCode IN ('ASDT1','ASDT2','ASDT3','ASDT4','ASDT5','ASDT6') THEN '2002'
                            WHEN EecDedGroupCode IN ('DMT1','DMT2','DMT3','DMT4','DMT5','DMT6') THEN '3003'
                            WHEN EecDedGroupCode IN ('FTT1','FTT2','FTT3','FTT4','FTT5','FTT6') THEN '4004'
                        END
                    END
        ,drvSignatureDate = CASE WHEN VLE_DedCode IS NOT NULL OR VLS_DedCode IS NOT NULL OR VLC_DedCode IS NOT NULL OR VADD_DedCode IS NOT NULL THEN VOL_StartDate END
        ,drvEffectiveDate =    CASE WHEN audSalaryChange = 'Y' THEN EjhJobEffDate --UD9DateTime  -- EjhJobEffDate
                                WHEN audReHire = 'Y' THEN eecDateOfLastHire
                                WHEN audTerm = 'Y' THEN EecDateOfTermination
                                ELSE CASE WHEN NVOL_StartDate IS NOT NULL THEN NVOL_StartDate ELSE VOL_StartDate END
                                /*ELSE 
                                    CASE WHEN NVOL_StartDate IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', NVOL_StartDate, DedAudEffDate) 
                                    ELSE dbo.dsi_fnGetMinMaxDates('MAX', VOL_StartDate, DedAudEffDate) 
                                    END*/
                            END
        ,drvAddType = CASE WHEN EecFullTimeOrPartTime = 'F' AND EjhFullTimeOrPartTime = 'P' THEN 'O' END
        ,drvBenefitId1 = CASE WHEN VLE_DedCode IS NOT NULL THEN 'LM' END
        ,drvPlanCode1 = CASE WHEN VLE_DedCode IS NOT NULL THEN '5.0N22' END
        ,drvBenefitQualDate1 = CASE WHEN VLE_DedCode IS NOT NULL AND VLE_ChangeReason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','105','201','202','203','204','210','300','303') THEN VLE_EligDate END
        ,drvBenefitTermDate1 = CASE WHEN VLE_DedCode IS NOT NULL and EecEmplStatus <> 'T' THEN VLE_BenStopDate END
        ,drvBenefitSelectionAmt1 =    CASE WHEN VLE_DedCode IS NOT NULL AND VLE_NeedEoi = 'Y' THEN FORMAT(VLE_EoiDesiredAmt, '#0.00') 
                                        WHEN VLE_DedCode IS NOT NULL AND VLE_NeedEoi <> 'Y' THEN FORMAT(VLE_BenAmt, '#0.00') 
                                    END
        -- VLE_EoiDesiredAmt  VLE_NeedEoi

        ,drvBenefitId2 = CASE WHEN VLS_DedCode IS NOT NULL THEN 'LS' END
        ,drvPlanCode2 = CASE WHEN VLS_DedCode IS NOT NULL THEN '5.AN47' END
        ,drvBenefitQualDate2 = CASE WHEN VLS_DedCode IS NOT NULL AND VLS_ChangeReason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','105','201','202','203','204','210','300','303') THEN VLS_EligDate END
        ,drvBenefitTermDate2 = CASE WHEN VLS_DedCode IS NOT NULL and EecEmplStatus <> 'T' THEN VLS_BenStopDate END
        ,drvBenefitSelectionAmt2 =    CASE WHEN VLS_DedCode IS NOT NULL AND VLS_NeedEoi = 'Y' THEN FORMAT(VLS_EoiDesiredAmt, '#0.00')
                                        WHEN VLS_DedCode IS NOT NULL AND VLS_NeedEoi <> 'Y' THEN  FORMAT(VLS_BenAmt, '#0.00')
                                    END

        ,drvBenefitId3 = CASE WHEN VLC_DedCode IS NOT NULL THEN 'LC' END
        ,drvPlanCode3 = CASE WHEN VLC_DedCode IS NOT NULL THEN '5.0M04' END
        ,drvBenefitQualDate3 = CASE WHEN VLC_DedCode IS NOT NULL AND VLC_ChangeReason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','105','201','202','203','204','210','300','303') THEN VLC_EligDate END
        ,drvBenefitTermDate3 = CASE WHEN VLC_DedCode IS NOT NULL and EecEmplStatus <> 'T' THEN VLC_BenStopDate END
        ,drvBenefitSelectionAmt3 = FORMAT(CASE WHEN VLC_DedCode IS NOT NULL and EecEmplStatus <> 'T' THEN VLC_BenAmt END, '#0.00')

        ,drvBenefitId4 = CASE WHEN VADD_DedCode IS NOT NULL THEN 'AM' END
        ,drvPlanCode4 = CASE WHEN VADD_DedCode IS NOT NULL THEN '5.0S17' END
        ,drvBenefitQualDate4 = CASE WHEN VADD_DedCode IS NOT NULL AND VADD_ChangeReason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','105','201','202','203','204','210','300','303') THEN VADD_EligDate END
        ,drvBenefitTermDate4 = CASE WHEN VADD_DedCode IS NOT NULL and EecEmplStatus <> 'T' THEN VADD_BenStopDate END
        ,drvBenefitSelectionAmt4 = FORMAT(CASE WHEN VADD_DedCode IS NOT NULL and EecEmplStatus <> 'T' THEN VADD_BenAmt END, '#0.00')

        ,drvBenefitId5 = ''
        ,drvPlanCode5 = ''
        ,drvBenefitQualDate5 = ''
        ,drvBenefitTermDate5 = ''
        ,drvBenefitSelectionAmt5 = ''

        ,drvBenefitId6 = ''
        ,drvPlanCode6 = ''
        ,drvBenefitQualDate6 = ''
        ,drvBenefitTermDate6 = ''
        ,drvBenefitSelectionAmt6 = ''
    INTO dbo.U_EBVLADDEXP_drvTbl
    FROM dbo.U_EBVLADDEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EBVLADDEXP WITH (NOLOCK)
    JOIN (
            SELECT BdmEEID, BdmCOID
                ,MAX(CASE WHEN BdmDedCode = 'GTL1' THEN BdmDedCode END) AS GTL1_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GTL2' THEN BdmDedCode END) AS GTL2_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GTL3' THEN BdmDedCode END) AS GTL3_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GTL4' THEN BdmDedCode END) AS GTL4_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GTLP' THEN BdmDedCode END) AS GTLP_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD10' THEN BdmDedCode END) AS LTD10_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD20' THEN BdmDedCode END) AS LTD20_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTDP' THEN BdmDedCode END) AS LTDP_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'GTL1' THEN BdmBenStopDate END) AS GTL1_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GTL2' THEN BdmBenStopDate END) AS GTL2_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GTL3' THEN BdmBenStopDate END) AS GTL3_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GTL4' THEN BdmBenStopDate END) AS GTL4_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'GTLP' THEN BdmBenStopDate END) AS GTLP_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD10' THEN BdmBenStopDate END) AS LTD10_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD20' THEN BdmBenStopDate END) AS LTD20_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LTDP' THEN BdmBenStopDate END) AS LTDP_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('GTL1','GTL2','GTL3','GTL4','GTLP','LTD10','LTD20','LTDP') THEN BdmBenStartDate END) AS NVOL_StartDate
                ,NULL AS VLE_DedCode
                ,NULL AS VLS_DedCode
                ,NULL AS VLC_DedCode
                ,NULL AS VADD_DedCode
                ,NULL AS VLE_BenStopDate
                ,NULL AS VLS_BenStopDate
                ,NULL AS VLC_BenStopDate
                ,NULL AS VADD_BenStopDate
                ,NULL AS VOL_StartDate
            FROM dbo.U_dsi_BDM_EBVLADDEXP WITH (NOLOCK)
            WHERE BdmDedCode IN ('GTL1','GTL2','GTL3','GTL4','GTLP','LTD10','LTD20','LTDP')
            GROUP BY BdmEEID, BdmCOID
            UNION
            SELECT BdmEEID, BdmCOID
                ,NULL AS GTL1_DedCode
                ,NULL AS GTL2_DedCode
                ,NULL AS GTL3_DedCode
                ,NULL AS GTL4_DedCode
                ,NULL AS GTLP_DedCode
                ,NULL AS LTD10_DedCode
                ,NULL AS LTD20_DedCode
                ,NULL AS LTDP_DedCode
                ,NULL AS GTL1_BenStopDate
                ,NULL AS GTL2_BenStopDate
                ,NULL AS GTL3_BenStopDate
                ,NULL AS GTL4_BenStopDate
                ,NULL AS GTLP_BenStopDate
                ,NULL AS LTD10_BenStopDate
                ,NULL AS LTD20_BenStopDate
                ,NULL AS LTDP_BenStopDate
                ,NULL AS NVOL_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'VLE' THEN BdmDedCode END) AS VLE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLS' THEN BdmDedCode END) AS VLS_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLC' THEN BdmDedCode END) AS VLC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VADD' THEN BdmDedCode END) AS VADD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLE' THEN BdmBenStopDate END) AS VLE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VLS' THEN BdmBenStopDate END) AS VLS_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VLC' THEN BdmBenStopDate END) AS VLC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VADD' THEN BdmBenStopDate END) AS VADD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('VLE','VLS','VLC','VADD') THEN BdmBenStartDate END) AS VOL_StartDate
            FROM dbo.U_dsi_BDM_EBVLADDEXP WITH (NOLOCK)
            WHERE BdmDedCode IN ('VLE','VADD','VLS','VLC') AND BdmBenStatus = 'A'
            GROUP BY BdmEEID, BdmCOID) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        --AND BdmDedCode NOT IN ('VLE','VLS','VLC','VADD') 
    LEFT JOIN dbo.Contacts Spouse WITH (NOLOCK)
        ON Spouse.ConEEID = xEEID
        --AND Spouse.ConIsActive = 'Y'
        AND Spouse.ConIsDependent = 'Y'
        AND Spouse.ConRelationship IN ('SPS','DP')
    LEFT JOIN ( --dbo.U_EBVLADDEXP_Audit WITH (NOLOCK)
                SELECT AudEEID, audKey2 
                    ,MAX(audReHire) AS audReHire
                    ,MAX(audTerm) AS audTerm
                    ,MAX(audSalaryChange) AS AudSalaryChange
                    FROM dbo.U_EBVLADDEXP_Audit WITH (NOLOCK)
                --where audEEID = 'DVUDCU000030' AND audKey2 = 'Q3ZVA'
                GROUP BY AudEEID, audKey2) AS aud
        ON audEEID = xEEID
        AND audKey2 = xCOID  
    LEFT JOIN (
                SELECT DISTINCT AudEEID AS UD9EEID, AudKey2 AS UD9COID, AudDateTime AS UD9DateTime 
                FROM dbo.U_EBVLADDEXP_Audit 
                WHERE audFieldName = 'EecUDField09') AS UD9Date
        ON UD9EEID = xEEID
        AND UD9COID = xCOID      
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhJobEffDate, EjhAnnSalary, EjhFullTimeOrPartTime -- EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhJobEffDate, EjhAnnSalary, EjhFullTimeOrPartTime, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)
                    ) AS X
                WHERE RN = 1
                ) AS Ejh
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    LEFT JOIN (
                SELECT EdhEEID AS VLE_EEID, EdhCOID AS VLE_COID, EdhChangeReason AS VLE_ChangeReason
                FROM (
                        SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn 
                                FROM dbo.EmpHDed a WITH (NOLOCK)
                                WHERE EdhDedCode = 'VLE') AS X    
                WHERE RN = 1 ) AS VLE_Reason
        ON VLE_EEID = xEEID
        AND VLE_COID = xCOID

        LEFT JOIN (
                SELECT EdhEEID AS VLS_EEID, EdhCOID AS VLS_COID, EdhChangeReason AS VLS_ChangeReason
                FROM (
                        SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn 
                                FROM dbo.EmpHDed a WITH (NOLOCK)
                                WHERE EdhDedCode = 'VLS') AS X    
                WHERE RN = 1 ) AS VLS_Reason
        ON VLS_EEID = xEEID
        AND VLS_COID = xCOID

        LEFT JOIN (
                SELECT EdhEEID AS VLC_EEID, EdhCOID AS VLC_COID, EdhChangeReason AS VLC_ChangeReason
                FROM (
                        SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn 
                                FROM dbo.EmpHDed a WITH (NOLOCK)
                                WHERE EdhDedCode = 'VLC') AS X    
                WHERE RN = 1 ) AS VLC_Reason
        ON VLC_EEID = xEEID
        AND VLC_COID = xCOID

        LEFT JOIN (
                SELECT EdhEEID AS VADD_EEID, EdhCOID AS VADD_COID, EdhChangeReason AS VADD_ChangeReason
                FROM (
                        SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn 
                                FROM dbo.EmpHDed a WITH (NOLOCK)
                                WHERE EdhDedCode = 'VLC') AS X    
                WHERE RN = 1 ) AS VADD_Reason
        ON VADD_EEID = xEEID
        AND VADD_COID = xCOID
        AND VLE_COID = xCOID
    LEFT JOIN (
                    SELECT EedEEID, EedCOID 
                        ,MAX(CASE WHEN EedDedCode = 'VLE' THEN EedEEEligDate END) AS VLE_EligDate
                        ,MAX(CASE WHEN EedDedCode = 'VLE' THEN EedBenAmt END) AS VLE_BenAmt
                        ,MAX(CASE WHEN EedDedCode = 'VLE' THEN EedEOIDesiredAmt END) AS VLE_EoiDesiredAmt
                        ,MAX(CASE WHEN EedDedCode = 'VLE' THEN EedNeedEOI END) AS VLE_NeedEoi
                        ,MAX(CASE WHEN EedDedCode = 'VLS' THEN EedEEEligDate END) AS VLS_EligDate
                        ,MAX(CASE WHEN EedDedCode = 'VLS' THEN EedBenAmt END) AS VLS_BenAmt
                        ,MAX(CASE WHEN EedDedCode = 'VLS' THEN EedEOIDesiredAmt END) AS VLS_EoiDesiredAmt
                        ,MAX(CASE WHEN EedDedCode = 'VLS' THEN EedNeedEOI END) AS VLS_NeedEoi
                        ,MAX(CASE WHEN EedDedCode = 'VLC' THEN EedEEEligDate END) AS VLC_EligDate
                        ,MAX(CASE WHEN EedDedCode = 'VLC' THEN EedBenAmt END) AS VLC_BenAmt
                        ,MAX(CASE WHEN EedDedCode = 'VADD' THEN EedEEEligDate END) AS VADD_EligDate
                        ,MAX(CASE WHEN EedDedCode = 'VADD' THEN EedBenAmt END) AS VADD_BenAmt
                    FROM dbo.EmpDed WITH (NOLOCK)
                    WHERE EedDedCode IN ('VLE','VLS','VLC','VADD')
                    GROUP BY EedEEID, EedCOID) AS EligDates
        ON EedEEID = xEEID
        AND EedCOID = xCOID
    /*LEFT JOIN (
                SELECT audEEID AS DedAudEEID, audKey2 AS DedAudCOID, DATEADD(DAY, 1, MAX(audDateTime)) AS DedAudEffDate
                FROM dbo.U_EBVLADDEXP_Audit WITH (NOLOCK)
                WHERE audFieldName = 'EedDedCode'
                    --AND audEEID = 'CR6M3R02L030'
                GROUP BY audEEID, audKey2) AS AudDed
        ON DedAudEEID = xEEID*/
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
ALTER VIEW dbo.dsi_vwEBVLADDEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBVLADDEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBVLADDEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101011'
       ,expStartPerControl     = '202101011'
       ,expLastEndPerControl   = '202103229'
       ,expEndPerControl       = '202103229'
WHERE expFormatCode = 'EBVLADDEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBVLADDEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBVLADDEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort