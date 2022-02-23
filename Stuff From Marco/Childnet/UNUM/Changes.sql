SET NOCOUNT ON;
IF OBJECT_ID('U_EUNUMCHLFE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCHLFE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNUMCHLFE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNUMCHLFE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNUMCHLFE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMCHLFE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMCHLFE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMCHLFE];
GO
IF OBJECT_ID('U_EUNUMCHLFE_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCHLFE_File];
GO
IF OBJECT_ID('U_EUNUMCHLFE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCHLFE_EEList];
GO
IF OBJECT_ID('U_EUNUMCHLFE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCHLFE_drvTbl];
GO
IF OBJECT_ID('U_EUNUMCHLFE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCHLFE_DedList];
GO
IF OBJECT_ID('U_EUNUMCHLFE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCHLFE_AuditFields];
GO
IF OBJECT_ID('U_EUNUMCHLFE_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCHLFE_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMCHLFE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMCHLFE];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNUMCHLFE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNUMCHLFE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNUMCHLFE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNUMCHLFE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNUMCHLFE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMCHLFE','Unum Basic Life, Vol Life ADD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EUNUMCHLFEZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eEnroll2"','1','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','1',NULL,'eEnroll2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY"','2','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','3','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','3',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MEMBER ID"','4','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','4',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOH"','5','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','5',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SALARY"','6','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','6',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SALARY MODE"','7','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','7',NULL,'SALARY MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURS"','8','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','8',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM DATE"','9','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','9',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM REASON"','10','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','10',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NEW MEMBER ID"','11','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','11',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','12','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','12',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE NAME"','13','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','13',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','14','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','14',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUFFIX"','15','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','15',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','16','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','16',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','17','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','17',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAIL ADDRESS"','18','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','18',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE FIRST NAME"','19','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','19',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE GDR"','20','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','20',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE DOB"','21','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','21',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLASS"','22','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','22',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFFECTIVE DATE"','23','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','23',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD TYPE"','24','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','24',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID1"','25','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','25',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE1"','26','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','26',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE1"','27','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','27',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE1"','28','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','28',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT1"','29','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','29',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION 1"','30','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','29',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID2"','30','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','30',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE2"','31','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','31',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE2"','32','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','32',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE2"','33','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','33',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT2"','34','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','34',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID3"','35','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','35',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE3"','36','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','36',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE3"','37','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','37',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE3"','38','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','38',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT3"','39','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','39',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID4"','40','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','40',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE4"','41','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','41',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE4"','42','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','42',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE4"','43','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','43',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT4"','44','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','44',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID5"','45','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','45',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE5"','46','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','46',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE5"','47','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','47',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE5"','48','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','48',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT5"','49','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','49',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID6"','50','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','50',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE6"','51','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','51',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE6"','52','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','52',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE6"','53','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','53',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT6"','54','(''DA''=''T,'')','EUNUMCHLFEZ0','50','H','01','54',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','55','(''DA''=''T'')','EUNUMCHLFEZ0','50','H','01','55',NULL,'BENEFIT SELECTION',NULL,NULL);

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnroll2"','1','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','1',NULL,'eEnroll2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy"','2','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','3','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','3',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberId"','4','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','4',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','5','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','5',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','6','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','6',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode"','7','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','7',NULL,'SALARY MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHours"','8','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','8',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','9','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','9',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReason"','10','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','10',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNewMemberId"','11','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','11',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','12','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','12',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','13','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','13',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','14','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','14',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuffix"','15','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','15',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','16','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','16',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','17','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','17',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','18','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','18',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseFirstName"','19','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','19',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseGender"','20','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','20',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpounseDateOfBirth"','21','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','21',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClass"','22','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','22',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','23','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','23',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddType"','24','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','24',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId1"','25','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','25',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode1"','26','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','26',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate1"','27','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','27',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate1"','28','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','28',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt1"','29','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','29',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection1"','30','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','30',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId2"','31','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','31',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode2"','32','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','32',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate2"','33','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','33',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate2"','34','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','34',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt2"','35','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','35',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection3"','36','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','36',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId3"','37','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','37',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode3"','38','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','39',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate3"','39','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','39',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate3"','40','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','40',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt3"','41','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','41',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection3"','42','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','42',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId4"','43','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','43',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode4"','44','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','44',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate4"','45','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','45',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate4"','46','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','46',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt4"','47','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','47',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection4"','48','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','48',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId5"','49','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','49',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode5"','50','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','50',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate5"','51','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','51',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate5"','52','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','52',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt5"','53','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','53',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection5"','54','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','54',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId6"','55','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','55',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode6"','56','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','56',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate6"','57','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','57',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate6"','58','(''UD101''=''T,'')','EUNUMCHLFEZ0','50','D','10','58',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt6"','59','(''UA''=''T,'')','EUNUMCHLFEZ0','50','D','10','59',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection"','60','(''UA''=''T'')','EUNUMCHLFEZ0','50','D','10','60',NULL,'BENEFIT SELECTION',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMCHLFE_20200219.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum Life Export','201909259','EMPEXPORT','ONDEMAND',NULL,'EUNUMCHLFE',NULL,NULL,NULL,'201909259','Sep 25 2019 12:30PM','Sep 25 2019 12:30PM','201909251',NULL,'','','201909251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMCHLFE_20200219.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','201909259','EMPEXPORT','OEPASSIVE','Nov  4 2019 11:55AM','EUNUMCHLFE',NULL,NULL,NULL,'201909259','Sep 25 2019 12:00AM','Dec 30 1899 12:00AM','201809251','848','','','201809251',dbo.fn_GetTimedKey(),NULL,'us3mLaCHI1014',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMCHLFE_20200219.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','201909259','EMPEXPORT','SCHEDULED','Nov  4 2019 12:00AM','EUNUMCHLFE',NULL,NULL,NULL,'201909259','Sep 25 2019 12:00AM','Dec 30 1899 12:00AM','201909251','833','','','201909251',dbo.fn_GetTimedKey(),NULL,'us3mLaCHI1014',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMCHLFE_20200219.txt',NULL,'','','IAGFG',NULL,NULL,NULL,'Active Open Enrollment Export','202011021','EMPEXPORT','OEACTIVE','Jan  9 2020 12:02PM','EUNUMCHLFE',NULL,NULL,NULL,'202011021','Nov  2 2020 12:00AM','Dec 30 1899 12:00AM','202001081','1','','','202001081',dbo.fn_GetTimedKey(),NULL,'us3tKiCHI1014',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMCHLFE_20200219.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202002189','EMPEXPORT','TEST','Feb 19 2020  9:57AM','EUNUMCHLFE',NULL,NULL,NULL,'202002189','Feb 18 2020 12:00AM','Dec 30 1899 12:00AM','202001019','72','','','202001019',dbo.fn_GetTimedKey(),NULL,'us3mLaCHI1014',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EUNUMCHLFE_20200219.txt' END WHERE expFormatCode = 'EUNUMCHLFE';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCHLFE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCHLFE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCHLFE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCHLFE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCHLFE','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EUNUMCHLFE' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNUMCHLFE' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EUNUMCHLFE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCHLFE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMCHLFE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMCHLFE','D10','dbo.U_EUNUMCHLFE_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EUNUMCHLFE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMCHLFE] (
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
IF OBJECT_ID('U_EUNUMCHLFE_Audit') IS NULL
CREATE TABLE [dbo].[U_EUNUMCHLFE_Audit] (
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
IF OBJECT_ID('U_EUNUMCHLFE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUNUMCHLFE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EUNUMCHLFE_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMCHLFE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUNUMCHLFE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMCHLFE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvEnroll2] char(6) NULL,
    [drvPolicy] varchar(6) NULL,
    [drvDivision] varchar(4) NOT NULL,
    [drvMemberId] char(11) NULL,
    [drvDateOfHire] datetime NULL,
    [drvSalary] money NULL,
    [drvSalaryMode] varchar(1) NOT NULL,
    [drvHours] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvTermReason] varchar(2) NULL,
    [drvNewMemberId] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSuffix] varchar(30) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvSpouseFirstName] varchar(100) NULL,
    [drvSpouseGender] char(1) NULL,
    [drvSpounseDateOfBirth] datetime NULL,
    [drvClass] varchar(4) NOT NULL,
    [drvEffectiveDate] datetime NULL,
    [drvAddType] varchar(1) NULL,
    [drvBenefitId1] varchar(2) NULL,
    [drvPlanCode1] varchar(6) NULL,
    [drvBenefitQualifyingDate1] datetime NULL,
    [drvBenefitTerminationDate1] datetime NULL,
    [drvBenefitSelectionAmt1] varchar(256) NULL,
    [drvBenefitSelection1] varchar(1) NULL,
    [drvBenefitId2] varchar(2) NULL,
    [drvPlanCode2] varchar(6) NULL,
    [drvBenefitQualifyingDate2] datetime NULL,
    [drvBenefitTerminationDate2] datetime NULL,
    [drvBenefitSelectionAmt2] varchar(256) NULL,
    [drvBenefitSelection2] varchar(1) NULL,
    [drvBenefitId3] varchar(2) NULL,
    [drvPlanCode3] varchar(6) NULL,
    [drvBenefitQualifyingDate3] datetime NULL,
    [drvBenefitTerminationDate3] datetime NULL,
    [drvBenefitSelectionAmt3] varchar(256) NULL,
    [drvBenefitSelection3] varchar(1) NULL,
    [drvBenefitId4] varchar(2) NOT NULL,
    [drvPlanCode4] varchar(6) NOT NULL,
    [drvBenefitQualifyingDate4] datetime NULL,
    [drvBenefitTerminationDate4] datetime NULL,
    [drvBenefitSelectionAmt4] varchar(12) NULL,
    [drvBenefitSelection4] varchar(1) NOT NULL,
    [drvBenefitId5] varchar(2) NOT NULL,
    [drvPlanCode5] varchar(6) NOT NULL,
    [drvBenefitQualifyingDate5] datetime NULL,
    [drvBenefitTerminationDate5] datetime NULL,
    [drvBenefitSelectionAmt5] varchar(12) NULL,
    [drvBenefitSelection5] varchar(1) NOT NULL,
    [drvBenefitId6] varchar(2) NOT NULL,
    [drvPlanCode6] varchar(6) NOT NULL,
    [drvBenefitQualifyingDate6] datetime NULL,
    [drvBenefitTerminationDate6] datetime NULL,
    [drvBenefitSelectionAmt6] varchar(12) NULL,
    [drvBenefitSelection] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUNUMCHLFE_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMCHLFE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNUMCHLFE_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMCHLFE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMCHLFE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ChildNet, Inc

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 09/25/2019
Service Request Number: SR-2019-0023997

Purpose: Unum Life Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marco Lagrosa       10/03/2019     SR-2019-000XXXXX   Initial Build

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMCHLFE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMCHLFE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMCHLFE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMCHLFE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMCHLFE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMCHLFE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMCHLFE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMCHLFE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMCHLFE', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMCHLFE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNUMCHLFE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUMCHLFE';

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



    
    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EUNUMCHLFE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMCHLFE_AuditFields;
    CREATE TABLE dbo.U_EUNUMCHLFE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_EUNUMCHLFE_AuditFields VALUES ('EmpPers','EepSSN');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUNUMCHLFE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMCHLFE_Audit;
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
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EUNUMCHLFE_Audit
    FROM dbo.U_EUNUMCHLFE_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EUNUMCHLFE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EUNUMCHLFE_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List 
    --=========================================

    -- Changes Only
    DELETE FROM dbo.U_EUNUMCHLFE_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EUNUMCHLFE_Audit WHERE audEEID = xEEID);
 

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUNUMCHLFE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMCHLFE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --DELETE EE LIST where Employee Type is TES
    Delete U_EUNUMCHLFE_EEList
    FROM U_EUNUMCHLFE_EEList JOIN EmpComp
    ON EecEeid = xEEID and EEcCoid = xCoid
    WHERE EecEEType = 'TES'
        --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLIFE,LIFES,LIFEC,LTD,LIFEE,LIFES';

    IF OBJECT_ID('U_EUNUMCHLFE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMCHLFE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMCHLFE_DedList
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


    --========================================= 
    -- Update BdmChangeReason For Dependents 
    --========================================= 
    UPDATE D 
        SET D.BdmChangeReason = E.BdmChangeReason 
    FROM dbo.U_dsi_BDM_EUNUMCHLFE D 
    JOIN dbo.U_dsi_BDM_EUNUMCHLFE E 
        ON E.BdmEEID = D.BdmEEID 
        AND E.BdmCOID = D.BdmCOID 
        AND E.BdmDedCode = D.BdmDedCode 
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP'; 
 
    --===================================================== 
    -- Update BdmUSGField2 with EmpDedTVID for Employees 
    --===================================================== 
    UPDATE dbo.U_dsi_BDM_EUNUMCHLFE 
        SET BdmUSGField2 = EedEmpDedTVID 
    FROM dbo.U_dsi_BDM_EUNUMCHLFE 
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) 
        ON EedEEID = BdmEEID 
        AND EedCOID = BdmCOID 
        AND EedDedCode = BdmDedCode 
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y'; 
 
    --======================================================= 
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents 
    --======================================================= 
    UPDATE dbo.U_dsi_BDM_EUNUMCHLFE 
        SET BdmUSGField2 = DbnDepBPlanTVID 
    FROM dbo.U_dsi_BDM_EUNUMCHLFE 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) 
        ON DbnEEID = BdmEEID 
        AND DbnCOID = BdmCOID 
        AND DbnDedCode = BdmDedCode 
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y'; 
 
    --====================================================== 
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt) 
    --====================================================== 
    UPDATE dbo.U_dsi_BDM_EUNUMCHLFE 
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt) 
    FROM dbo.U_dsi_BDM_EUNUMCHLFE 
    JOIN dbo.EmpDedFull WITH (NOLOCK) 
        ON EedEmpDedTVID = BdmUSGField2;
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMCHLFE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMCHLFE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMCHLFE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvEnroll2 =  CONVERT(CHAR(6),'')
        ,drvPolicy = PolicyNumber
        ,drvDivision = '0001'
        ,drvMemberId = eepSSN
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvSalary = eecAnnSalary
        ,drvSalaryMode = 'A'
        ,drvHours = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTermReason = CASE WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '203' THEN 'DT'
                                                 WHEN EecTermReason IN ('202','213') THEN 'RT'
                                                 ELSE 'TE' END
                               END
        ,drvNewMemberId = CASE WHEN ISNULL(eepoldssn,'') <> '' THEN eepoldssn END 
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvLastName = EepNameLast
        ,drvSuffix = EepNameSuffix
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvEmailAddress = EepAddressEMail
        ,drvSpouseFirstName = CASE WHEN LIFES IN ('LIFES') THEN (select Top 1 ConNameFirst from Contacts where ConRelationship = 'SPS' and ConEEID = xEEID) END
        ,drvSpouseGender = CASE WHEN LIFES IN ('LIFES')  THEN (select Top 1 ConGender from Contacts where ConRelationship = 'SPS' and ConEEID = xEEID) END
        ,drvSpounseDateOfBirth = CASE WHEN LIFES IN ('LIFES') THEN (select Top 1 ConDateOfBirth from Contacts where ConRelationship = 'SPS' and ConEEID = xEEID) END
        ,drvClass = CASE WHEN LIFES IN ('LIFES') or LIFEE IN ('LIFEE') or LIFEC in ('LIFEC') THEN '1000' 
                         WHEN EECDedGroupCode IN ('AVP','DIRVP','EXEC') THEN '1000' ELSE '2002' END
        ,drvEffectiveDate = CASE WHEN audReHire = 'Y' THEN EecDateOfLastHire
                                 WHEN audTerm = 'Y' THEN EecDateOfTermination
                                 WHEN audSalaryChange = 'Y' THEN EjhJobEffDate
                                 ELSE 
                                        CASE WHEN GEN_StartDate IS NOT NULL THEN GEN_StartDate
                                            WHEN LIFES_StartDate IS NOT NULL THEN LIFES_StartDate    
                                            WHEN LIFEC_StartDate IS NOT NULL THEN LIFEC_StartDate    
                                            WHEN LIFEE_StartDate IS NOT NULL THEN LIFEE_StartDate    
                                        END

                            END
        ,drvAddType = CASE WHEN EXISTS(select top 1 * from U_EUNUMCHLFE_Audit where audAction = 'Update' and audFieldName = 'EecFullTimeOrPartTime' and audEEID = xEEID and Audkey2 = xCOID and audOldValue = 'P' and audNewValue = 'F') THEN 'O' END
        ,drvBenefitId1 = CASE WHEN LIFEE IN ('LIFEE') THEN 'LM'
                          END
        ,drvPlanCode1 = CASE WHEN LIFEE IN ('LIFEE') THEN '5.0N30' END
        ,drvBenefitQualifyingDate1 = CASE WHEN LIFEE_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN LIFEE_BenefitDate END
        ,drvBenefitTerminationDate1 = CASE WHEN EecEmplStatus <> 'T' THEN LIFEE_StopDate END
        ,drvBenefitSelectionAmt1 = CASE WHEN LIFEE IN ('LIFEE') THEN LIFEE_EEAmt END        
        ,drvBenefitSelection1 = CASE WHEN LIFEE IN ('LIFEE') THEN 'Y' END
        ,drvBenefitId2 = CASE WHEN LIFES IN ('LIFES') THEN 'LS'
                          END
        ,drvPlanCode2 = CASE WHEN LIFES IN ('LIFES') THEN '5.AN39' END
        ,drvBenefitQualifyingDate2 = CASE WHEN LIFES_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN LIFES_BenefitDate END
        ,drvBenefitTerminationDate2 = CASE WHEN EecEmplStatus <> 'T' THEN LIFES_StopDate END
        ,drvBenefitSelectionAmt2 = CASE WHEN LIFES IN ('LIFES') THEN LIFES_EEAmt END
        ,drvBenefitSelection2 = CASE WHEN LIFES IN ('LIFES') THEN 'Y' END
        ,drvBenefitId3 = CASE WHEN LIFEC IN ('LIFEC') THEN 'LC'
                          END
        ,drvPlanCode3 = CASE WHEN LIFEC IN ('LIFEC') THEN '5.AN39' END
        ,drvBenefitQualifyingDate3 = CASE WHEN LIFEC_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN LIFEC_BenefitDate END
        ,drvBenefitTerminationDate3 = CASE WHEN EecEmplStatus <> 'T' THEN LIFEC_StopDate END
        ,drvBenefitSelectionAmt3 = CASE WHEN LIFES IN ('LIFES') THEN LIFEC_EEAmt END
        ,drvBenefitSelection3 = CASE WHEN LIFES IN ('LIFES') THEN 'Y' END
        ,drvBenefitId4 ='  '
        ,drvPlanCode4 = '      '
        ,drvBenefitQualifyingDate4 = CAST(NULL as datetime)
        ,drvBenefitTerminationDate4 = CAST(NULL as datetime)
        ,drvBenefitSelectionAmt4 = SPACE(12)
        ,drvBenefitSelection4 = ''
        ,drvBenefitId5 = '  '
        ,drvPlanCode5 =  '      '
        ,drvBenefitQualifyingDate5 = CAST(NULL as datetime)
        ,drvBenefitTerminationDate5 = CAST(NULL as datetime)
        ,drvBenefitSelectionAmt5 = SPACE(12)
        ,drvBenefitSelection5 = ''
        ,drvBenefitId6 = '  '
        ,drvPlanCode6 = '      '
        ,drvBenefitQualifyingDate6 = CAST(NULL as datetime)
        ,drvBenefitTerminationDate6 = CAST(NULL as datetime)
        ,drvBenefitSelectionAmt6 = SPACE(12)
        ,drvBenefitSelection = ''
    INTO dbo.U_EUNUMCHLFE_drvTbl
    FROM dbo.U_EUNUMCHLFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            Select  bdmEEID,bdmcoid,BdmDepRecId,PolicyNumber = CASE WHEN BDMDedCode IN ('LTD','GLIFE') THEN '701540' 
                                WHEN BDMDedCode IN ('LIFEC','LIFES','LIFEE') THEN '701930' 
                            END
            ,GEN = MAX((CASE WHEN BDMDedCode IN ('LTD','GLIFE') then 'GEN' END))
            ,GEN_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LTD','GLIFE') then  BdmBenStatusDate END))
            ,GEN_StartDate = MAX((CASE WHEN BDMDedCode IN ('LTD','GLIFE') then  bdmBenStartDate END))
            ,GEN_StopDate = MAX((CASE WHEN BDMDedCode IN ('LTD','GLIFE') then  BdmStopDate END))
            ,GEN_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LTD','GLIFE') then  BdmUSGField1 END))
            ,GEN_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LTD','GLIFE') then  bdmChangeReason END))
            ,LIFEE = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then BDMDedCode END))
            ,LIFEE_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  BdmBenStatusDate END))
            ,LIFEE_StartDate = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  bdmBenStartDate END))
            ,LIFEE_StopDate = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  BdmStopDate END))
            ,LIFEE_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  BdmUSGField1 END))
            ,LIFEE_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  bdmChangeReason END))
            ,LIFES = MAX((CASE WHEN BDMDedCode IN ('LIFES') then BDMDedCode END))
            ,LIFES_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LIFES') then  BdmBenStatusDate END))
            ,LIFES_StartDate = MAX((CASE WHEN BDMDedCode IN ('LIFES') then  bdmBenStartDate END))
            ,LIFES_StopDate = MAX((CASE WHEN BDMDedCode IN ('LIFES') then  BdmStopDate END))
            ,LIFES_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LIFES') then  BdmUSGField1 END))
            ,LIFES_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  bdmChangeReason END))
            ,LIFEC = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then BDMDedCode END))
            ,LIFEC_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then  BdmBenStatusDate END))
            ,LIFEC_StartDate = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then  bdmBenStartDate END))
            ,LIFEC_StopDate = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then  BdmStopDate END))
            ,LIFEC_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then  BdmUSGField1 END))
            ,LIFEC_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then  bdmChangeReason END))
            
            from U_dsi_BDM_EUNUMCHLFE  where BdmRecType = 'EMP' group by bdmEEID,bdmcoid,BdmDepRecId,CASE WHEN BDMDedCode IN ('LTD','GLIFE') THEN '701540' 
                                WHEN BDMDedCode IN ('LIFEC','LIFES','LIFEE') THEN '701930' 
                            END
    ) as BdmConsolidated 
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN (
        -- Get NewHire, ReHire, Terms from Audit
        SELECT audEEID
            ,audNewHire = MAX(audNewHire)
            ,audReHire = MAX(audReHire)
            ,audTerm = MAX(audTerm)
            ,audSalaryChange = MAX(audSalaryChange)
        FROM dbo.U_EUNUMCHLFE_Audit
        WHERE (audNewHire = 'Y'
            OR audReHire = 'Y'
            OR audTerm = 'Y'
            OR audSalaryChange = 'Y'
        )
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID
    JOIN (
        -- Get Most Recent Salary Change Date
        SELECT EjhEEID, EjhCOID
            ,EjhJobEffDate = MAX(EjhJobEffDate)
        FROM dbo.EmpHJob
        WHERE EjhIsRateChange = 'Y'
        GROUP BY EjhEEID, EjhCOID
    ) EmpHJob
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID;


        /*
        UPDATE U_EUNUMCHLFE_drvTbl SET 
        drvBenefitSelectionAmt1 = CASE WHEN drvClass = '1000' THEN
                                            CASE WHEN (EecAnnSalary * 2) > 400000 THEN 400000 ELSE 
                                                (EecAnnSalary * 2)
                                            END 
                                        WHEN drvClass = '2002' THEN
                                            CASE WHEN (EecAnnSalary * 2) > 50000 THEN 50000 ELSE 
                                                (EecAnnSalary * 2)
                                            END 
                                   END     
        ,drvBenefitSelectionAmt2  = CASE WHEN drvClass = '1000' THEN
                                            CASE WHEN (EecAnnSalary * 2) > 400000 THEN 400000 ELSE 
                                                (EecAnnSalary * 2)
                                            END 
                                        WHEN drvClass = '2002' THEN
                                            CASE WHEN (EecAnnSalary * 2) > 50000 THEN 50000 ELSE 
                                                (EecAnnSalary * 2)
                                            END 
                                   END     

        ,drvBenefitSelectionAmt3 = CASE WHEN drvClass = '1000' THEN
                                            CASE WHEN (EecAnnSalary * 2) > 400000 THEN 400000 ELSE 
                                                (EecAnnSalary * 2)
                                            END 
                                        WHEN drvClass = '2002' THEN
                                            CASE WHEN (EecAnnSalary * 2) > 50000 THEN 50000 ELSE 
                                                (EecAnnSalary * 2)
                                            END 
                                   END     

        FROM dbo.U_EUNUMCHLFE_drvTbl WITH (NOLOCK)
        JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID 
        AND EecCoID = drvCOID
        where drvPolicy = '701930'
        */

    -- Update for ADD
    Update dbo.U_EUNUMCHLFE_drvTbl set 
        drvBenefitId4 = CASE WHEN drvBenefitId1 = 'LM' THEN 'AM' ELSE '' END
        ,drvPlanCode4 =  CASE WHEN drvPlanCode1 = '5.0N30' THEN '5.0N29' ELSE '' END
        ,drvBenefitQualifyingDate4 = CASE WHEN drvPlanCode1 = '5.0N30' THEN drvBenefitQualifyingDate1 END
        ,drvBenefitTerminationDate4 = CASE WHEN drvPlanCode1 = '5.0N30' THEN drvBenefitTerminationDate1 END
        ,drvBenefitSelectionAmt4 = CASE WHEN drvPlanCode1 = '5.0N30' THEN ISNULL(drvBenefitSelectionAmt1,'') END
        ,drvBenefitSelection4 = CASE WHEN drvPlanCode1 = '5.0N30' THEN ISNULL(drvBenefitSelection1,'') ELSE '' END
        ,drvBenefitId5 = CASE WHEN drvBenefitId2 = 'LS' THEN 'AS' ELSE '' END
        ,drvPlanCode5 = CASE WHEN drvPlanCode2 = '5.AN39' THEN '5.0Q03' ELSE '' END
        ,drvBenefitQualifyingDate5 = CASE WHEN drvPlanCode2 = '5.AN39' THEN drvBenefitQualifyingDate2 END
        ,drvBenefitTerminationDate5 = CASE WHEN drvPlanCode2 = '5.AN39' THEN drvBenefitTerminationDate2 END
        ,drvBenefitSelectionAmt5 = CASE WHEN drvPlanCode2 = '5.AN39' THEN ISNULL(drvBenefitSelectionAmt2,'') END
        ,drvBenefitSelection5 = CASE WHEN drvPlanCode2 = '5.AN39' THEN ISNULL(drvBenefitSelection2,'') ELSE ''  END
        ,drvBenefitId6 = CASE WHEN drvBenefitId3 = 'LC' THEN 'AC' ELSE ''END
        ,drvPlanCode6 = CASE WHEN drvPlanCode3 = '5.AM17' THEN '5.0AM5' ELSE '' END
        ,drvBenefitQualifyingDate6 = CASE WHEN drvPlanCode3 = '5.AM17' THEN drvBenefitQualifyingDate3 END
        ,drvBenefitTerminationDate6 =  CASE WHEN drvPlanCode3 = '5.AM17' THEN drvBenefitTerminationDate3 END
        ,drvBenefitSelectionAmt6 = CASE WHEN drvPlanCode3 = '5.AM17' THEN ISNULL(drvBenefitSelectionAmt3,'') END
        ,drvBenefitSelection = CASE WHEN drvPlanCode3 = '5.AM17'   THEN ISNULL(drvBenefitSelection3,'') ELSE ''  END
        where drvPolicy = '701930'
  




    --Update Header information for Enroll2 fields

    Update TOP (1)  U_EUNUMCHLFE_drvTbl set drvEnroll2 = (SELECT CONVERT(CHAR(6),count(*)) from U_EUNUMCHLFE_drvTbl) FROM  U_EUNUMCHLFE_drvTbl
    where drvInitialSort  = (select top (1) drvInitialSort from dbo.U_EUNUMCHLFE_drvTbl order by drvInitialSort)
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'EUNUMCHLFE_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'EUNUMTEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEUNUMCHLFE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMCHLFE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMCHLFE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201909181'
       ,expStartPerControl     = '201909181'
       ,expLastEndPerControl   = '201909259'
       ,expEndPerControl       = '201909259'
WHERE expFormatCode = 'EUNUMCHLFE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMCHLFE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMCHLFE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort