SET NOCOUNT ON;
IF OBJECT_ID('U_EUNUMBAWFE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMBAWFE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNUMBAWFE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNUMBAWFE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNUMBAWFE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMBAWFE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMBAWFE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMBAWFE];
GO
IF OBJECT_ID('U_EUNUMBAWFE_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMBAWFE_File];
GO
IF OBJECT_ID('U_EUNUMBAWFE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMBAWFE_EEList];
GO
IF OBJECT_ID('U_EUNUMBAWFE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMBAWFE_drvTbl];
GO
IF OBJECT_ID('U_EUNUMBAWFE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMBAWFE_DedList];
GO
IF OBJECT_ID('U_EUNUMBAWFE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUNUMBAWFE_AuditFields];
GO
IF OBJECT_ID('U_EUNUMBAWFE_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUNUMBAWFE_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMBAWFE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMBAWFE];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNUMBAWFE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNUMBAWFE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNUMBAWFE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNUMBAWFE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNUMBAWFE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMBAWFE','Unum Basic Life, Vol Life ADD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EUNUMBAWFEZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNUMBAWFE' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eEnroll2"','1','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','1',NULL,'eEnroll2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY"','2','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','3','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','3',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MEMBER ID"','4','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','4',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRI DIV"','5','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','5',NULL,'PRI DIV',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOH"','6','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','5',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SALARY"','7','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','6',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SALARY MODE"','8','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','7',NULL,'SALARY MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURS"','9','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','8',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM DATE"','10','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','9',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM REASON"','11','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','10',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NEW MEMBER ID"','12','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','11',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','13','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','12',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE NAME"','14','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','13',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','15','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','14',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUFFIX"','16','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','15',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','17','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','16',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','18','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','17',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAIL ADDRESS"','19','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','18',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE FIRST NAME"','20','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','19',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE GDR"','21','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','20',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE DOB"','22','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','21',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLASS"','23','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','22',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SIGNATURE DATE"','24','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','23',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFFECTIVE DATE"','25','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','23',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE COVERAGE"','26','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','23',NULL,'SPOUSE COVERAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHILD COVERAGE"','27','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','23',NULL,'CHILD COVERAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD TYPE"','28','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','24',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','29','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','25',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','30','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','26',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','31','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','27',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','32','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','28',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','33','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','29',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','34','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','31',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','35','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','30',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','36','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','31',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','37','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','32',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','38','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','33',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','39','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','34',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','40','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','37',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','41','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','35',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','42','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','36',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','43','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','37',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','44','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','38',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','45','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','39',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','46','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','43',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','47','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','40',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','48','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','41',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','49','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','42',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','50','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','43',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','51','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','44',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','52','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','49',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','53','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','45',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','54','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','46',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','55','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','47',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','56','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','48',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','57','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','49',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','58','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','49',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','59','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','50',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','60','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','51',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','61','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','52',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','62','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','53',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT"','63','(''DA''=''T,'')','EUNUMBAWFEZ0','50','H','01','54',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','64','(''DA''=''T'')','EUNUMBAWFEZ0','50','H','01','55',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnroll2"','1','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','1',NULL,'eEnroll2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy"','2','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','3','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','3',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberId"','4','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','4',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T,'')','EUNUMBAWFEZ0','50','D','10','5',NULL,'PRI DIV',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','6','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','5',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','7','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','6',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode"','8','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','7',NULL,'SALARY MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHours"','9','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','8',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','10','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','9',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReason"','11','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','10',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNewMemberId"','12','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','11',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','13','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','12',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','14','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','13',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','15','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','14',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuffix"','16','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','15',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','16',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','18','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','17',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','19','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','18',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseFirstName"','20','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','19',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseGender"','21','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','20',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpounseDateOfBirth"','22','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','21',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClass"','23','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','22',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignatureDate"','24','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','23',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','25','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','23',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPOUSECOVERAGE"','26','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','23',NULL,'SPOUSE COVERAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHILDCOVERAGE"','27','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','23',NULL,'CHILD COVERAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddType"','28','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','24',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId1"','29','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','25',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode1"','30','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','26',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate1"','31','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','27',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate1"','32','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','28',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt1"','33','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','29',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T,'')','EUNUMBAWFEZ0','50','D','10','31',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId2"','35','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','31',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode2"','36','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','32',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate2"','37','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','33',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate2"','38','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','34',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt2"','39','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','35',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T,'')','EUNUMBAWFEZ0','50','D','10','37',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId3"','41','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','37',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode3"','42','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','39',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate3"','43','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','39',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate3"','44','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','40',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt3"','45','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','41',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T,'')','EUNUMBAWFEZ0','50','D','10','43',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId4"','47','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','43',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode4"','48','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','44',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate4"','49','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','45',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate4"','50','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','46',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt4"','51','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','47',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T,'')','EUNUMBAWFEZ0','50','D','10','49',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId5"','53','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','49',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode5"','54','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','50',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate5"','55','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','51',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate5"','56','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','52',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt5"','57','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','53',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T,'')','EUNUMBAWFEZ0','50','D','10','55',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId6"','59','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','55',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode6"','60','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','56',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualifyingDate6"','61','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','57',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTerminationDate6"','62','(''UD101''=''T,'')','EUNUMBAWFEZ0','50','D','10','58',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt6"','63','(''UA''=''T,'')','EUNUMBAWFEZ0','50','D','10','59',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection"','64','(''UA''=''T'')','EUNUMBAWFEZ0','50','D','10','60',NULL,'BENEFIT SELECTION',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUNUMBAWFE_20210407.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','IAGFG',NULL,NULL,NULL,'Active Open Enrollment Export','202011021','EMPEXPORT','OEACTIVE','Jan  9 2020 12:02PM','EUNUMBAWFE',NULL,NULL,NULL,'202011021','Nov  2 2020 12:00AM','Dec 30 1899 12:00AM','202001081','1','','','202001081',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','201909259','EMPEXPORT','OEPASSIVE','Nov  4 2019 11:55AM','EUNUMBAWFE',NULL,NULL,NULL,'201909259','Sep 25 2019 12:00AM','Dec 30 1899 12:00AM','201809251','848','','','201809251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Unum Life Export','201909259','EMPEXPORT','ONDEMAND',NULL,'EUNUMBAWFE',NULL,NULL,NULL,'201909259','Sep 25 2019 12:30PM','Sep 25 2019 12:30PM','201909251',NULL,'','','201909251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Scheduled Session','201909259','EMPEXPORT','SCH_UNMX','Nov  4 2019 12:00AM','EUNUMBAWFE',NULL,NULL,NULL,'201909259','Sep 25 2019 12:00AM','Dec 30 1899 12:00AM','201909251','833','','','201909251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202104061','EMPEXPORT','TEST','Apr  6 2021  9:24AM','EUNUMBAWFE',NULL,NULL,NULL,'202104061','Apr  6 2021 12:00AM','Dec 30 1899 12:00AM','202103231','345','','','202103231',dbo.fn_GetTimedKey(),NULL,'us3lKiBAT1002',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMBAWFE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMBAWFE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMBAWFE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMBAWFE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMBAWFE','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUNUMBAWFE' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUNUMBAWFE' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUNUMBAWFE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMBAWFE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMBAWFE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMBAWFE','D10','dbo.U_EUNUMBAWFE_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EUNUMBAWFE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMBAWFE] (
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
IF OBJECT_ID('U_EUNUMBAWFE_Audit') IS NULL
CREATE TABLE [dbo].[U_EUNUMBAWFE_Audit] (
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
IF OBJECT_ID('U_EUNUMBAWFE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUNUMBAWFE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EUNUMBAWFE_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMBAWFE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUNUMBAWFE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMBAWFE_drvTbl] (
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
    [drvClass] varchar(4) NULL,
    [drvSignatureDate] datetime NULL,
    [drvEffectiveDate] datetime NULL,
    [drvSPOUSECOVERAGE] varchar(1) NOT NULL,
    [drvCHILDCOVERAGE] varchar(1) NOT NULL,
    [drvAddType] varchar(1) NOT NULL,
    [drvBenefitId1] varchar(2) NULL,
    [drvPlanCode1] varchar(6) NULL,
    [drvBenefitQualifyingDate1] datetime NULL,
    [drvBenefitTerminationDate1] datetime NULL,
    [drvBenefitSelectionAmt1] varchar(256) NULL,
    [drvBenefitSelection1] varchar(1) NOT NULL,
    [drvBenefitId2] varchar(2) NULL,
    [drvPlanCode2] varchar(6) NULL,
    [drvBenefitQualifyingDate2] datetime NULL,
    [drvBenefitTerminationDate2] datetime NULL,
    [drvBenefitSelectionAmt2] varchar(256) NULL,
    [drvBenefitSelection2] varchar(1) NOT NULL,
    [drvBenefitId3] varchar(2) NULL,
    [drvPlanCode3] varchar(6) NULL,
    [drvBenefitQualifyingDate3] datetime NULL,
    [drvBenefitTerminationDate3] datetime NULL,
    [drvBenefitSelectionAmt3] varchar(256) NULL,
    [drvBenefitSelection3] varchar(1) NOT NULL,
    [drvBenefitId4] varchar(2) NULL,
    [drvPlanCode4] varchar(6) NULL,
    [drvBenefitQualifyingDate4] datetime NULL,
    [drvBenefitTerminationDate4] datetime NULL,
    [drvBenefitSelectionAmt4] varchar(256) NULL,
    [drvBenefitSelection4] varchar(1) NOT NULL,
    [drvBenefitId5] varchar(2) NULL,
    [drvPlanCode5] varchar(6) NULL,
    [drvBenefitQualifyingDate5] datetime NULL,
    [drvBenefitTerminationDate5] datetime NULL,
    [drvBenefitSelectionAmt5] varchar(256) NULL,
    [drvBenefitSelection5] varchar(1) NOT NULL,
    [drvBenefitId6] varchar(2) NULL,
    [drvPlanCode6] varchar(6) NULL,
    [drvBenefitQualifyingDate6] datetime NULL,
    [drvBenefitTerminationDate6] datetime NULL,
    [drvBenefitSelectionAmt6] varchar(256) NULL,
    [drvBenefitSelection] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUNUMBAWFE_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMBAWFE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNUMBAWFE_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMBAWFE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMBAWFE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Bates White LLC

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 04/01/2021
Service Request Number: TekP-2021-03-01-0001

Purpose: Unum Life Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marco Lagrosa       10/03/2019     SR-2019-000XXXXX   Initial Build

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMBAWFE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMBAWFE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMBAWFE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMBAWFE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMBAWFE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMBAWFE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMBAWFE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMBAWFE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMBAWFE', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMBAWFE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNUMBAWFE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUMBAWFE';

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
    IF OBJECT_ID('U_EUNUMBAWFE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMBAWFE_AuditFields;
    CREATE TABLE dbo.U_EUNUMBAWFE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_EUNUMBAWFE_AuditFields VALUES ('EmpPers','EepSSN');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUNUMBAWFE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMBAWFE_Audit;
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
    INTO dbo.U_EUNUMBAWFE_Audit
    FROM dbo.U_EUNUMBAWFE_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EUNUMBAWFE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EUNUMBAWFE_Audit WHERE audRowNo > 1;

    --==========================================
    -- Clean EE List 
    --========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUNUMBAWFE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMBAWFE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --DELETE EE LIST where Employee Type is TES
    Delete U_EUNUMBAWFE_EEList
    FROM U_EUNUMBAWFE_EEList JOIN EmpComp
    ON EecEeid = xEEID and EEcCoid = xCoid
    WHERE EecEEType = 'TES'
        --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ADDCH,ADDEE,ADDL1,ADDL2,ADDL3,ADDL4,ADDSP,ADP,LIFE1,LIFEC,LIFEE,LIFES,LIFL2,LIFL3,LIFL4,LTDA,LTDEP,LTDMG';

    IF OBJECT_ID('U_EUNUMBAWFE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMBAWFE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMBAWFE_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');

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
         
    FROM dbo.U_dsi_BDM_EUNUMBAWFE D 
    JOIN dbo.U_dsi_BDM_EUNUMBAWFE E 
        ON E.BdmEEID = D.BdmEEID 
        AND E.BdmCOID = D.BdmCOID 
        AND E.BdmDedCode = D.BdmDedCode 
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP'; 
 
    --===================================================== 
    -- Update BdmUSGField2 with EmpDedTVID for Employees 
    --===================================================== 
    UPDATE dbo.U_dsi_BDM_EUNUMBAWFE 
        SET BdmUSGField2 = EedEmpDedTVID,
        BdmUsgDate1 =  EedEEEligDate
    FROM dbo.U_dsi_BDM_EUNUMBAWFE 
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) 
        ON EedEEID = BdmEEID 
        AND EedCOID = BdmCOID 
        AND EedDedCode = BdmDedCode 
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y'; 
 
    --======================================================= 
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents 
    --======================================================= 
    UPDATE dbo.U_dsi_BDM_EUNUMBAWFE 
        SET BdmUSGField2 = DbnDepBPlanTVID 
    FROM dbo.U_dsi_BDM_EUNUMBAWFE 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) 
        ON DbnEEID = BdmEEID 
        AND DbnCOID = BdmCOID 
        AND DbnDedCode = BdmDedCode 
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y'; 
 
    --====================================================== 
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt) 
    --====================================================== 
    UPDATE dbo.U_dsi_BDM_EUNUMBAWFE 
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt) 
    FROM dbo.U_dsi_BDM_EUNUMBAWFE 
    JOIN dbo.EmpDedFull WITH (NOLOCK) 
        ON EedEmpDedTVID = BdmUSGField2;
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMBAWFE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMBAWFE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMBAWFE_drvTbl;
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
        ,drvDateOfHire = EecDateOflasthire
        ,drvSalary = EecAnnSalary
        ,drvSalaryMode = 'A'
        ,drvHours = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN BENEFIT_STOPDATE END
        ,drvTermReason = CASE WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '203' THEN 'DT'
                                                 WHEN EecTermReason IN ('202') THEN 'RT'
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
        ,drvSpouseFirstName = CASE WHEN LIFES IS NOT NULL OR ADDSP IS NOT NULL THEN (select Top 1 ConNameFirst from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
        ,drvSpouseGender = CASE WHEN LIFES IS NOT NULL OR ADDSP IS NOT NULL THEN (select Top 1 ConGender from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
        ,drvSpounseDateOfBirth = CASE WHEN LIFES IS NOT NULL OR ADDSP IS NOT NULL THEN (select Top 1 ConDateOfBirth from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
        ,drvClass = CASE WHEN PolicyNumber = '910170' and EecDedGroupCode = 'EQPAR' THEN '1001' 
                         WHEN PolicyNumber = '910170' and EecDedGroupCode IN ('DIR', 'PART' ,'PRIN') THEN '2002' 
                         WHEN LEV2 IS NOT NULL OR  LTDMG IS NOT NULL then '3003'
                         WHEN LEV3 IS NOT NULL  then '4004'
                         WHEN LEV4 IS NOT NULL  then '5005'
                         WHEN ADDCH IS NOT NULL  OR ADDEE IS NOT NULL  OR ADDSP IS NOT NULL  OR LIFEE IS NOT NULL  OR  LIFEC IS NOT NULL  or LIFES IS NOT NULL  then '1000'
                    END
        ,drvSignatureDate = Signature_Date



        ,drvEffectiveDate = CASE WHEN audReHire = 'Y' THEN EecDateOfLastHire
                                 WHEN audTerm = 'Y' THEN EecDateOfTermination
                                 WHEN audSalaryChange = 'Y' THEN EjhJobEffDate
                                 ELSE 
                                 BENEFIT_STARTDATE
                            END
        ,drvSPOUSECOVERAGE = CASE WHEN ADDSP IS NOT NULL or  LIFES IS NOT NULL  THEN 'Y' else  'N' END
        ,drvCHILDCOVERAGE = CASE WHEN ADDSP IS NOT NULL or  LIFES IS NOT NULL  THEN 'Y' else  'N' END
        ,drvAddType = CASE WHEN EXISTS(select top 1 * from U_EUNUMBAWFE_Audit where audAction = 'Update' and audFieldName = 'EecFullTimeOrPartTime' and audEEID = xEEID and Audkey2 = xCOID and audOldValue = 'P' and audNewValue = 'F') and EecFullTimeOrPartTime = 'F' THEN 'O' ELSE '' END
        ,drvBenefitId1 = CASE WHEN LIFEE IS NOT NULL THEN 'LM' END
        ,drvPlanCode1 = CASE  WHEN LIFEE IS NOT NULL THEN '5.0N22' END
        ,drvBenefitQualifyingDate1 = CASE WHEN LIFEE_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303') THEN LIFEE_BenefitDate END
        ,drvBenefitTerminationDate1 = CASE WHEN EecEmplStatus <> 'T' THEN LIFEE_StopDate END
        ,drvBenefitSelectionAmt1 = CASE WHEN LIFEE IN ('LIFEE') THEN LIFEE_EEAmt END        
        ,drvBenefitSelection1 = ''
        ,drvBenefitId2 = CASE WHEN LIFES IN ('LIFES') THEN 'LS'
                          END
        ,drvPlanCode2 = CASE WHEN LIFES IN ('LIFES') THEN '5.AN97' END
        ,drvBenefitQualifyingDate2 = CASE WHEN LIFES_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')
                    THEN LIFES_BenefitDate END
        ,drvBenefitTerminationDate2 = CASE WHEN EecEmplStatus <> 'T' THEN LIFES_StopDate END
        ,drvBenefitSelectionAmt2 = CASE WHEN LIFES IN ('LIFES') THEN LIFES_EEAmt END
        ,drvBenefitSelection2 = ''
        ,drvBenefitId3 = CASE WHEN LIFEC IN ('LIFEC') THEN 'LC'
                          END
        ,drvPlanCode3 = CASE WHEN LIFEC IN ('LIFEC')THEN '5.0M04' END
        ,drvBenefitQualifyingDate3 = CASE WHEN (LIFEC IN ('LIFEC') and LIFEC_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303')) THEN LIFEC_BenefitDate END
        ,drvBenefitTerminationDate3 = CASE WHEN LIFEC IN ('LIFEC') and EecEmplStatus <> 'T' THEN LIFEC_StopDate END
        ,drvBenefitSelectionAmt3 = CASE WHEN (LIFEC IS NOT NULL )  THEN LIFEC_EEAmt END
        ,drvBenefitSelection3 = ''
        ,drvBenefitId4 = CASE WHEN ADDEE IS NOT NULL THEN 'AM' END
        ,drvPlanCode4 = CASE WHEN ADDEE IS NOT NULL THEN '5.0S17' END
        ,drvBenefitQualifyingDate4 =  CASE WHEN ADDEE_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303') THEN ADDEE_BenefitDate END
        ,drvBenefitTerminationDate4 = CASE WHEN EecEmplStatus <> 'T' THEN ADDEE_StopDate END
        ,drvBenefitSelectionAmt4 = CASE WHEN (ADDEE IS NOT NULL )  THEN ADDEE_EEAmt END
        ,drvBenefitSelection4 = ''
        ,drvBenefitId5 = CASE WHEN ADDSP IS NOT NULL THEN 'AS' END
        ,drvPlanCode5 =  CASE WHEN ADDSP IS NOT NULL THEN '5.0L03' END
        ,drvBenefitQualifyingDate5 = CASE WHEN ADDSP_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303') THEN ADDSP_BenefitDate END
        ,drvBenefitTerminationDate5 = CASE WHEN EecEmplStatus <> 'T' THEN ADDSP_StopDate END
        ,drvBenefitSelectionAmt5 = CASE WHEN (ADDSP IS NOT NULL )  THEN ADDSP_EEAmt END
        ,drvBenefitSelection5 = ''
        ,drvBenefitId6 = CASE WHEN ADDCH IS NOT NULL THEN 'AC' END 
        ,drvPlanCode6 = CASE WHEN ADDCH IS NOT NULL THEN '5.0L23' END
        ,drvBenefitQualifyingDate6 = CASE WHEN ADDCH_ChangeReason IN ('LEVNT2', 'LEVNT3', 'LEVNT4', 'LEVNT5', '105', '201', '202', '203', '204', '210', '300', '303') THEN ADDCH_BenefitDate END
        ,drvBenefitTerminationDate6 = CASE WHEN ADDCH IN ('ADDCH') and EecEmplStatus <> 'T' THEN ADDCH_StopDate END
        ,drvBenefitSelectionAmt6 = CASE WHEN (ADDCH IS NOT NULL )  THEN ADDCH_EEAmt END
        ,drvBenefitSelection = ''
    INTO dbo.U_EUNUMBAWFE_drvTbl
    FROM dbo.U_EUNUMBAWFE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            Select  bdmEEID,bdmcoid,BdmDepRecId,PolicyNumber = 
                            CASE 
                                WHEN BDMDedCode IN ('ADDL1', 'ADDL2', 'ADDL3', 'ADDL4', 'ADP', 'LIFE1', 'LIFL2', 'LIFL3', 'LIFL4', 'LTDA', 'LTDEP' ,'LTDMG') THEN '910170' 
                                WHEN BDMDedCode IN ('ADDCH', 'ADDEE', 'ADDSP', 'LIFEE', 'LIFEC','LIFES') THEN '910171' 
                            END
           
            
            ,LIFES = MAX((CASE WHEN BDMDedCode IN ('LIFES') then BDMDedCode END))
            ,LIFES_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LIFES') then  BdmUsgDate1 END))
            ,LIFES_StartDate = MAX((CASE WHEN BDMDedCode IN ('LIFES') then  bdmBenStartDate END))
            ,LIFES_StopDate = MAX((CASE WHEN BDMDedCode IN ('LIFES') then  BdmStopDate END))
            ,LIFES_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LIFES') then  BdmUSGField1 END))
            ,LIFES_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LIFES') then  bdmChangeReason END))

            ,ADDSP = MAX((CASE WHEN BDMDedCode IN ('ADDSP') then BDMDedCode END))
            ,ADDSP_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('ADDSP') then  BdmUsgDate1 END))
            ,ADDSP_StartDate = MAX((CASE WHEN BDMDedCode IN ('ADDSP') then  bdmBenStartDate END))
            ,ADDSP_StopDate = MAX((CASE WHEN BDMDedCode IN ('ADDSP') then  BdmStopDate END))
            ,ADDSP_EEAmt = MAX((CASE WHEN BDMDedCode IN ('ADDSP') then  BdmUSGField1 END))
            ,ADDSP_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('ADDSP') then  bdmChangeReason END))

            ,ADDL1 = MAX((CASE WHEN BDMDedCode IN ('ADDL1') then BDMDedCode END))
            ,ADDL1_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('ADDL1') then  BdmUsgDate1 END))
            ,ADDL1_StartDate = MAX((CASE WHEN BDMDedCode IN ('ADDL1') then  bdmBenStartDate END))
            ,ADDL1_StopDate = MAX((CASE WHEN BDMDedCode IN ('ADDL1') then  BdmStopDate END))
            ,ADDL1_EEAmt = MAX((CASE WHEN BDMDedCode IN ('ADDL1') then  BdmUSGField1 END))
            ,ADDL1_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('ADDL1') then  bdmChangeReason END))
            

            ,ADDL2 = MAX((CASE WHEN BDMDedCode IN ('ADDL2') then BDMDedCode END))
            ,ADDL2_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('ADDL2') then  BdmUsgDate1 END))
            ,ADDL2_StartDate = MAX((CASE WHEN BDMDedCode IN ('ADDL2') then  bdmBenStartDate END))
            ,ADDL2_StopDate = MAX((CASE WHEN BDMDedCode IN ('ADDL2') then  BdmStopDate END))
            ,ADDL2_EEAmt = MAX((CASE WHEN BDMDedCode IN ('ADDL2') then  BdmUSGField1 END))
            ,ADDL2_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('ADDL2') then  bdmChangeReason END))


            ,ADDL3 = MAX((CASE WHEN BDMDedCode IN ('ADDL3') then BDMDedCode END))
            ,ADDL3_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('ADDL3') then  BdmUsgDate1 END))
            ,ADDL3_StartDate = MAX((CASE WHEN BDMDedCode IN ('ADDL3') then  bdmBenStartDate END))
            ,ADDL3_StopDate = MAX((CASE WHEN BDMDedCode IN ('ADDL3') then  BdmStopDate END))
            ,ADDL3_EEAmt = MAX((CASE WHEN BDMDedCode IN ('ADDL3') then  BdmUSGField1 END))
            ,ADDL3_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('ADDL3') then  bdmChangeReason END))


            ,ADDL4 = MAX((CASE WHEN BDMDedCode IN ('ADDL4') then BDMDedCode END))
            ,ADDL4_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('ADDL4') then  BdmUsgDate1 END))
            ,ADDL4_StartDate = MAX((CASE WHEN BDMDedCode IN ('ADDL4') then  bdmBenStartDate END))
            ,ADDL4_StopDate = MAX((CASE WHEN BDMDedCode IN ('ADDL4') then  BdmStopDate END))
            ,ADDL4_EEAmt = MAX((CASE WHEN BDMDedCode IN ('ADDL4') then  BdmUSGField1 END))
            ,ADDL4_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('ADDL4') then  bdmChangeReason END))


            ,ADP = MAX((CASE WHEN BDMDedCode IN ('ADP') then BDMDedCode END))
            ,ADP_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('ADP') then  BdmUsgDate1 END))
            ,ADP_StartDate = MAX((CASE WHEN BDMDedCode IN ('ADP') then  bdmBenStartDate END))
            ,ADP_StopDate = MAX((CASE WHEN BDMDedCode IN ('ADP') then  BdmStopDate END))
            ,ADP_EEAmt = MAX((CASE WHEN BDMDedCode IN ('ADP') then  BdmUSGField1 END))
            ,ADP_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('ADP') then  bdmChangeReason END))


            ,LIFE1 = MAX((CASE WHEN BDMDedCode IN ('LIFE1') then BDMDedCode END))
            ,LIFE1_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LIFE1') then  BdmUsgDate1 END))
            ,LIFE1_StartDate = MAX((CASE WHEN BDMDedCode IN ('LIFE1') then  bdmBenStartDate END))
            ,LIFE1_StopDate = MAX((CASE WHEN BDMDedCode IN ('LIFE1') then  BdmStopDate END))
            ,LIFE1_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LIFE1') then  BdmUSGField1 END))
            ,LIFE1_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LIFE1') then  bdmChangeReason END))


            ,LIFL2 = MAX((CASE WHEN BDMDedCode IN ('LIFL2') then BDMDedCode END))
            ,LIFL2_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LIFL2') then  BdmUsgDate1 END))
            ,LIFL2_StartDate = MAX((CASE WHEN BDMDedCode IN ('LIFL2') then  bdmBenStartDate END))
            ,LIFL2_StopDate = MAX((CASE WHEN BDMDedCode IN ('LIFL2') then  BdmStopDate END))
            ,LIFL2_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LIFL2') then  BdmUSGField1 END))
            ,LIFL2_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LIFL2') then  bdmChangeReason END))


            ,LIFL3 = MAX((CASE WHEN BDMDedCode IN ('LIFL3') then BDMDedCode END))
            ,LIFL3_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LIFL3') then  BdmUsgDate1 END))
            ,LIFL3_StartDate = MAX((CASE WHEN BDMDedCode IN ('LIFL3') then  bdmBenStartDate END))
            ,LIFL3_StopDate = MAX((CASE WHEN BDMDedCode IN ('LIFL3') then  BdmStopDate END))
            ,LIFL3_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LIFL3') then  BdmUSGField1 END))
            ,LIFL3_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LIFL3') then  bdmChangeReason END))


            ,LIFL4 = MAX((CASE WHEN BDMDedCode IN ('LIFL4') then BDMDedCode END))
            ,LIFL4_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LIFL4') then  BdmUsgDate1 END))
            ,LIFL4_StartDate = MAX((CASE WHEN BDMDedCode IN ('LIFL4') then  bdmBenStartDate END))
            ,LIFL4_StopDate = MAX((CASE WHEN BDMDedCode IN ('LIFL4') then  BdmStopDate END))
            ,LIFL4_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LIFL4') then  BdmUSGField1 END))
            ,LIFL4_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LIFL4') then  bdmChangeReason END))


            ,LTDA = MAX((CASE WHEN BDMDedCode IN ('LTDA') then BDMDedCode END))
            ,LTDA_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LTDA') then  BdmUsgDate1 END))
            ,LTDA_StartDate = MAX((CASE WHEN BDMDedCode IN ('LTDA') then  bdmBenStartDate END))
            ,LTDA_StopDate = MAX((CASE WHEN BDMDedCode IN ('LTDA') then  BdmStopDate END))
            ,LTDA_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LTDA') then  BdmUSGField1 END))
            ,LTDA_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LTDA') then  bdmChangeReason END))


            ,LTDEP = MAX((CASE WHEN BDMDedCode IN ('LTDEP') then BDMDedCode END))
            ,LTDEP_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LTDEP') then  BdmUsgDate1 END))
            ,LTDEP_StartDate = MAX((CASE WHEN BDMDedCode IN ('LTDEP') then  bdmBenStartDate END))
            ,LTDEP_StopDate = MAX((CASE WHEN BDMDedCode IN ('LTDEP') then  BdmStopDate END))
            ,LTDEP_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LTDEP') then  BdmUSGField1 END))
            ,LTDEP_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LTDEP') then  bdmChangeReason END))


            ,LTDMG = MAX((CASE WHEN BDMDedCode IN ('LTDMG') then BDMDedCode END))
            ,LTDMG_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LTDMG') then  BdmUsgDate1 END))
            ,LTDMG_StartDate = MAX((CASE WHEN BDMDedCode IN ('LTDMG') then  bdmBenStartDate END))
            ,LTDMG_StopDate = MAX((CASE WHEN BDMDedCode IN ('LTDMG') then  BdmStopDate END))
            ,LTDMG_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LTDMG') then  BdmUSGField1 END))
            ,LTDMG_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LTDMG') then  bdmChangeReason END))


            ,LEV2 = MAX((CASE WHEN BDMDedCode IN ('LEV2') then BDMDedCode END))
            ,LEV2_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LEV2') then  BdmUsgDate1 END))
            ,LEV2_StartDate = MAX((CASE WHEN BDMDedCode IN ('LEV2') then  bdmBenStartDate END))
            ,LEV2_StopDate = MAX((CASE WHEN BDMDedCode IN ('LEV2') then  BdmStopDate END))
            ,LEV2_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LEV2') then  BdmUSGField1 END))
            ,LEV2_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LEV2') then  bdmChangeReason END))





            ,LEV3 = MAX((CASE WHEN BDMDedCode IN ('LEV3') then BDMDedCode END))
            ,LEV3_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LEV3') then  BdmUsgDate1 END))
            ,LEV3_StartDate = MAX((CASE WHEN BDMDedCode IN ('LEV3') then  bdmBenStartDate END))
            ,LEV3_StopDate = MAX((CASE WHEN BDMDedCode IN ('LEV3') then  BdmStopDate END))
            ,LEV3_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LEV3') then  BdmUSGField1 END))
            ,LEV3_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LEV3') then  bdmChangeReason END))
           

            ,LEV4 = MAX((CASE WHEN BDMDedCode IN ('LEV4') then BDMDedCode END))
            ,LEV4_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LEV4') then  BdmUsgDate1 END))
            ,LEV4_StartDate = MAX((CASE WHEN BDMDedCode IN ('LEV4') then  bdmBenStartDate END))
            ,LEV4_StopDate = MAX((CASE WHEN BDMDedCode IN ('LEV4') then  BdmStopDate END))
            ,LEV4_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LEV4') then  BdmUSGField1 END))
            ,LEV4_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LEV4') then  bdmChangeReason END))


            ,ADDCH = MAX((CASE WHEN BDMDedCode IN ('ADDCH') then BDMDedCode END))
            ,ADDCH_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('ADDCH') then  BdmUsgDate1 END))
            ,ADDCH_StartDate = MAX((CASE WHEN BDMDedCode IN ('ADDCH') then  bdmBenStartDate END))
            ,ADDCH_StopDate = MAX((CASE WHEN BDMDedCode IN ('ADDCH') then  BdmStopDate END))
            ,ADDCH_EEAmt = MAX((CASE WHEN BDMDedCode IN ('ADDCH') then  BdmUSGField1 END))
            ,ADDCH_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('ADDCH') then  bdmChangeReason END))



            ,ADDEE = MAX((CASE WHEN BDMDedCode IN ('ADDEE') then BDMDedCode END))
            ,ADDEE_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('ADDEE') then  BdmUsgDate1 END))
            ,ADDEE_StartDate = MAX((CASE WHEN BDMDedCode IN ('ADDEE') then  bdmBenStartDate END))
            ,ADDEE_StopDate = MAX((CASE WHEN BDMDedCode IN ('ADDEE') then  BdmStopDate END))
            ,ADDEE_EEAmt = MAX((CASE WHEN BDMDedCode IN ('ADDEE') then  BdmUSGField1 END))
            ,ADDEE_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('ADDEE') then  bdmChangeReason END))

            ,LIFEE = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then BDMDedCode END))
            ,LIFEE_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  BdmUsgDate1 END))
            ,LIFEE_StartDate = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  bdmBenStartDate END))
            ,LIFEE_StopDate = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  BdmStopDate END))
            ,LIFEE_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  BdmUSGField1 END))
            ,LIFEE_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LIFEE') then  bdmChangeReason END))


            ,LIFEC = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then BDMDedCode END))
            ,LIFEC_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then  BdmUsgDate1 END))
            ,LIFEC_StartDate = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then  bdmBenStartDate END))
            ,LIFEC_StopDate = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then  BdmStopDate END))
            ,LIFEC_EEAmt = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then  BdmUSGField1 END))
            ,LIFEC_ChangeReason = MAX((CASE WHEN BDMDedCode IN ('LIFEC') then  bdmChangeReason END))


            ,BENEFIT_STARTDATE = MAX((CASE WHEN BDMDedCode IN ('ADDCH','ADDEE','ADDL1','ADDL2','ADDL3','ADDL4','ADDSP','ADP','LIFE1','LIFEC','LIFEE','LIFES','LIFL2','LIFL3','LIFL4','LTDA','LTDEP','LTDMG') then  bdmBenStartDate END)) 
            ,BENEFIT_STOPDATE = MAX((CASE WHEN BDMDedCode IN ('ADDCH','ADDEE','ADDL1','ADDL2','ADDL3','ADDL4','ADDSP','ADP','LIFE1','LIFEC','LIFEE','LIFES','LIFL2','LIFL3','LIFL4','LTDA','LTDEP','LTDMG') then  bdmBenStopDate END)) 

            ,Signature_Date = MAX((CASE WHEN BDMDedCode IN ('ADDCH', 'ADDEE', 'ADDSP', 'LIFEE', 'LIFEC' , 'LIFES' ) then  bdmBenStartDate END)) 
            
            from U_dsi_BDM_EUNUMBAWFE  where BdmRecType = 'EMP' group by bdmEEID,bdmcoid,BdmDepRecId, 
                            CASE 
                                WHEN BDMDedCode IN ('ADDL1', 'ADDL2', 'ADDL3', 'ADDL4', 'ADP', 'LIFE1', 'LIFL2', 'LIFL3', 'LIFL4', 'LTDA', 'LTDEP' ,'LTDMG') THEN '910170' 
                                WHEN BDMDedCode IN ('ADDCH', 'ADDEE', 'ADDSP', 'LIFEE', 'LIFEC','LIFES') THEN '910171' 
                            END
    ) as BdmConsolidated 
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
        -- Get NewHire, ReHire, Terms from Audit
        SELECT audEEID
            ,audNewHire = MAX(audNewHire)
            ,audReHire = MAX(audReHire)
            ,audTerm = MAX(audTerm)
            ,audSalaryChange = MAX(audSalaryChange)
        FROM dbo.U_EUNUMBAWFE_Audit
        WHERE (audNewHire = 'Y'
            OR audReHire = 'Y'
            OR audTerm = 'Y'
            OR audSalaryChange = 'Y'
        )
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID
    LEFT JOIN (
        -- Get Most Recent Salary Change Date
        SELECT EjhEEID, EjhCOID
            ,EjhJobEffDate = MAX(EjhJobEffDate)
        FROM dbo.EmpHJob
        WHERE EjhIsRateChange = 'Y'
        GROUP BY EjhEEID, EjhCOID
    ) EmpHJob
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID;

   
    Delete from dbo.U_EUNUMBAWFE_drvTbl where drvPolicy is null

    /*  -- Update for ADD
    Update dbo.U_EUNUMBAWFE_drvTbl set 
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
        ,drvBenefitSelection = ''
        where drvPolicy = '701930'
    */

    --Update Header information for Enroll2 fields

    Update TOP (1)  U_EUNUMBAWFE_drvTbl set drvEnroll2 = (SELECT CONVERT(CHAR(6),count(*)) from U_EUNUMBAWFE_drvTbl) FROM  U_EUNUMBAWFE_drvTbl
    where drvInitialSort  = (select top (1) drvInitialSort from dbo.U_EUNUMBAWFE_drvTbl order by drvInitialSort)
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'EUNUMBAWFE_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'EUNUMTEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEUNUMBAWFE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMBAWFE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMBAWFE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201909181'
       ,expStartPerControl     = '201909181'
       ,expLastEndPerControl   = '201909259'
       ,expEndPerControl       = '201909259'
WHERE expFormatCode = 'EUNUMBAWFE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMBAWFE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMBAWFE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort