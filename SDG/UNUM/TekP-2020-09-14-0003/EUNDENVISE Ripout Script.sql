SET NOCOUNT ON;
IF OBJECT_ID('U_EUNDENVISE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNDENVISE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNDENVISE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNDENVISE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNDENVISE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNDENVISE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNDENVISE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNDENVISE];
GO
IF OBJECT_ID('U_EUNDENVISE_File') IS NOT NULL DROP TABLE [dbo].[U_EUNDENVISE_File];
GO
IF OBJECT_ID('U_EUNDENVISE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNDENVISE_EEList];
GO
IF OBJECT_ID('U_EUNDENVISE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNDENVISE_drvTbl];
GO
IF OBJECT_ID('U_EUNDENVISE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNDENVISE_DedList];
GO
IF OBJECT_ID('U_EUNDENVISE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUNDENVISE_AuditFields];
GO
IF OBJECT_ID('U_EUNDENVISE_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUNDENVISE_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EUNDENVISE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNDENVISE];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNDENVISE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNDENVISE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNDENVISE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNDENVISE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNDENVISE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNDENVISE','UNUM Dental Vision Elg Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EUNDENVISEZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNDENVISE' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eEnroll2"','1','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','1',NULL,'eEnroll2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY"','2','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','3','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','3',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MEMBER ID"','4','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','4',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS LINE 1"','5','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','5',NULL,'ADDRESS LINE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS LINE 2"','6','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','6',NULL,'ADDRESS LINE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY"','7','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','7',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATE"','8','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','8',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUNTRY"','9','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','9',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POSTAL CODE"','10','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','10',NULL,'POSTAL CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRI DIV"','11','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','11',NULL,'PRI DIV',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOH"','12','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','12',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM DATE"','13','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','13',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM REASON"','14','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','14',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NEW MEMBER ID"','15','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','15',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','16','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','16',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE NAME"','17','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','17',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','18','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','18',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUFFIX"','19','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','19',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','20','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','20',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','21','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','21',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAIL ADDRESS"','22','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','22',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE FIRST NAME"','23','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','23',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE MIDDLE NAME"','24','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','24',NULL,'SPOUSE MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE LAST NAME"','25','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','25',NULL,'SPOUSE LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE SUFFIX"','26','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','26',NULL,'SPOUSE SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE GDR"','27','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','27',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE DOB"','28','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','28',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE SSN"','29','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','29',NULL,'SPOUSE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE EFF DATE"','30','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','30',NULL,'SPOUSE EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE TERM DATE"','31','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','31',NULL,'SPOUSE TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLASS"','32','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','32',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SIGNATURE DATE"','33','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','33',NULL,'SIGNATURE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFFECTIVE DATE"','34','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','34',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD TYPE"','35','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','35',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','36','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','36',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','37','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','37',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','38','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','38',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','39','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','39',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','40','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','40',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','41','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','41',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','42','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','42',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE"','43','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','43',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE"','44','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','44',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION"','45','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','45',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT FIRST NAME"','46','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','46',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT MIDDLE NAME"','47','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','47',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT LAST NAME"','48','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','48',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SUFFIX"','49','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','49',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SSN"','50','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','50',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT EFF DATE"','51','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','51',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT TERM DATE"','52','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','52',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT GENDER"','53','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','53',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DOB"','54','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','54',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT RELATIONSHIP"','55','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','55',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DISABLED INDICATOR"','56','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','56',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT FIRST NAME"','57','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','57',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT MIDDLE NAME"','58','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','58',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT LAST NAME"','59','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','59',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SUFFIX"','60','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','60',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SSN"','61','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','61',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT EFF DATE"','62','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','62',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT TERM DATE"','63','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','63',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT GENDER"','64','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','64',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DOB"','65','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','65',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT RELATIONSHIP"','66','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','66',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DISABLED INDICATOR"','67','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','67',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT FIRST NAME"','68','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','68',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT MIDDLE NAME"','69','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','69',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT LAST NAME"','70','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','70',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SUFFIX"','71','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','71',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SSN"','72','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','72',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT EFF DATE"','73','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','73',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT TERM DATE"','74','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','74',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT GENDER"','75','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','75',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DOB"','76','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','76',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT RELATIONSHIP"','77','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','77',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DISABLED INDICATOR"','78','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','78',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT FIRST NAME"','79','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','79',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT MIDDLE NAME"','80','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','80',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT LAST NAME"','81','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','81',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SUFFIX"','82','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','82',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SSN"','83','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','83',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT EFF DATE"','84','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','84',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT TERM DATE"','85','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','85',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT GENDER"','86','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','86',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DOB"','87','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','87',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT RELATIONSHIP"','88','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','88',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DISABLED INDICATOR"','89','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','89',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT FIRST NAME"','90','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','90',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT MIDDLE NAME"','91','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','91',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT LAST NAME"','92','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','92',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SUFFIX"','93','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','93',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SSN"','94','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','94',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT EFF DATE"','95','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','95',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT TERM DATE"','96','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','96',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT GENDER"','97','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','97',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DOB"','98','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','98',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT RELATIONSHIP"','99','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','99',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DISABLED INDICATOR"','100','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','100',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT FIRST NAME"','101','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','101',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT MIDDLE NAME"','102','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','102',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT LAST NAME"','103','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','103',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SUFFIX"','104','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','104',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SSN"','105','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','105',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT EFF DATE"','106','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','106',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT TERM DATE"','107','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','107',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT GENDER"','108','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','108',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DOB"','109','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','109',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT RELATIONSHIP"','110','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','110',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DISABLED INDICATOR"','111','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','111',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT FIRST NAME"','112','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','112',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT MIDDLE NAME"','113','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','113',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT LAST NAME"','114','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','114',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SUFFIX"','115','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','115',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SSN"','116','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','116',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT EFF DATE"','117','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','117',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT TERM DATE"','118','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','118',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT GENDER"','119','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','119',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DOB"','120','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','120',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT RELATIONSHIP"','121','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','121',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DISABLED INDICATOR"','122','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','122',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT FIRST NAME"','123','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','123',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT MIDDLE NAME"','124','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','124',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT LAST NAME"','125','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','125',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SUFFIX"','126','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','126',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT SSN"','127','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','127',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT EFF DATE"','128','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','128',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT TERM DATE"','129','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','129',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT GENDER"','130','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','130',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DOB"','131','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','131',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT RELATIONSHIP"','132','(''DA''=''T,'')','EUNDENVISEZ0','50','H','01','132',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DENTAL DEPENDENT DISABLED INDICATOR"','133','(''DA''=''T'')','EUNDENVISEZ0','50','H','01','133',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','1','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','1',NULL,'eEnroll2 Record Count Value',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"652458"','2','(''DA''=''T,'')','EUNDENVISEZ0','50','D','10','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','3','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','3',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberId"','4','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','4',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','5','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','5',NULL,'ADDRESS LINE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','6','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','6',NULL,'ADDRESS LINE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','7','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','7',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddresState"','8','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','8',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USA"','9','(''DA''=''T,'')','EUNDENVISEZ0','50','D','10','9',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','10','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','10',NULL,'POSTAL CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T,'')','EUNDENVISEZ0','50','D','10','11',NULL,'PRI DIV',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDoh"','12','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','12',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','13','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','13',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReason"','14','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','14',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNewMemberId"','15','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','15',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','16','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','16',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','17','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','17',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','18','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','18',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','19','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','19',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','20','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','20',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','21','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','21',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEamilAddress"','22','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','22',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameFirst"','23','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','23',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameMiddle"','24','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','24',NULL,'SPOUSE MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameLast"','25','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','25',NULL,'SPOUSE LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameSuffix"','26','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','26',NULL,'SPOUSE SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseGender"','27','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','27',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDateOfBirth"','28','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','28',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSSN"','29','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','29',NULL,'SPOUSE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseEffectiveDate"','30','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','30',NULL,'SPOUSE EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseTermDate"','31','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','31',NULL,'SPOUSE TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0010"','32','(''DA''=''T,'')','EUNDENVISEZ0','50','D','10','32',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignatureDate"','33','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','33',NULL,'SIGNATURE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffecitveDate"','34','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','34',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddType"','35','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','35',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId1"','36','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','36',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode1"','37','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','37',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate1"','38','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','38',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate1"','39','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','39',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection1"','40','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','40',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitId2"','41','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','41',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode2"','42','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','42',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate2"','43','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','43',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate2"','44','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','44',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection2"','45','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','45',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameFirst1"','46','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','46',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameMIddle1"','47','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','47',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameLast1"','48','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','48',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameSuffix1"','49','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','49',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepSSN1"','50','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','50',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepEffDate1"','51','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','51',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepTermDate1"','52','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','52',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepGender1"','53','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','53',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDateOfBirth1"','54','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','54',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepRelationship1"','55','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','55',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDisabledInd1"','56','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','56',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameFirst2"','57','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','57',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameMIddle2"','58','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','58',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameLast2"','59','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','59',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameSuffix2"','60','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','60',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepSSN2"','61','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','61',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepEffDate2"','62','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','62',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepTermDate2"','63','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','63',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepGender2"','64','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','64',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDateOfBirth2"','65','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','65',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepRelationship2"','66','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','66',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDisabledInd2"','67','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','67',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameFirst3"','68','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','68',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameMIddle3"','69','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','69',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameLast3"','70','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','70',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameSuffix3"','71','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','71',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepSSN3"','72','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','72',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepEffDate3"','73','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','73',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepTermDate3"','74','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','74',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepGender3"','75','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','75',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDateOfBirth3"','76','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','76',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepRelationship3"','77','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','77',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDisabledInd3"','78','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','78',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameFirst4"','79','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','79',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameMIddle4"','80','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','80',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameLast4"','81','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','81',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameSuffix4"','82','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','82',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepSSN4"','83','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','83',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepEffDate4"','84','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','84',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepTermDate4"','85','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','85',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepGender4"','86','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','86',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDateOfBirth4"','87','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','87',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepRelationship4"','88','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','88',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDisabledInd4"','89','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','89',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameFirst5"','90','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','90',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameMIddle5"','91','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','91',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameLast5"','92','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','92',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameSuffix5"','93','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','93',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepSSN5"','94','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','94',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepEffDate5"','95','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','95',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepTermDate5"','96','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','96',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepGender5"','97','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','97',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDateOfBirth5"','98','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','98',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepRelationship5"','99','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','99',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDisabledInd5"','100','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','100',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameFirst6"','101','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','101',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameMIddle6"','102','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','102',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameLast6"','103','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','103',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameSuffix6"','104','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','104',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepSSN6"','105','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','105',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepEffDate6"','106','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','106',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepTermDate6"','107','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','107',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepGender6"','108','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','108',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDateOfBirth6"','109','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','109',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepRelationship6"','110','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','110',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDisabledInd6"','111','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','111',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameFirst7"','112','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','112',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameMIddle7"','113','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','113',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameLast7"','114','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','114',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameSuffix7"','115','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','115',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepSSN7"','116','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','116',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepEffDate7"','117','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','117',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepTermDate7"','118','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','118',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepGender7"','119','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','119',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDateOfBirth7"','120','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','120',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepRelationship7"','121','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','121',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDisabledInd7"','122','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','122',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameFirst8"','123','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','123',NULL,'DENTAL DEPENDENT FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameMIddle8"','124','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','124',NULL,'DENTAL DEPENDENT MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameLast8"','125','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','125',NULL,'DENTAL DEPENDENT LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepNameSuffix8"','126','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','126',NULL,'DENTAL DEPENDENT SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepSSN8"','127','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','127',NULL,'DENTAL DEPENDENT SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepEffDate8"','128','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','128',NULL,'DENTAL DEPENDENT EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepTermDate8"','129','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','129',NULL,'DENTAL DEPENDENT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepGender8"','130','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','130',NULL,'DENTAL DEPENDENT GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDateOfBirth8"','131','(''UD101''=''T,'')','EUNDENVISEZ0','50','D','10','131',NULL,'DENTAL DEPENDENT DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepRelationship8"','132','(''UA''=''T,'')','EUNDENVISEZ0','50','D','10','132',NULL,'DENTAL DEPENDENT RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalDepDisabledInd8"','133','(''UA''=''T'')','EUNDENVISEZ0','50','D','10','133',NULL,'DENTAL DEPENDENT DISABLED INDICATOR',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUNDENVISE_20201028.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM Dental Vision Elg Export','202010049','EMPEXPORT','CHANGES','Oct  6 2020  5:46PM','EUNDENVISE',NULL,NULL,NULL,'202010049','Oct  4 2020  5:13PM','Oct  4 2020  5:13PM','202009271','107','','','202009271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM Dental Vision Elg Export','202010279','EMPEXPORT','FULLFILE','Oct 27 2020 10:57AM','EUNDENVISE',NULL,NULL,NULL,'202010279','Oct 27 2020 12:00AM','Dec 30 1899 12:00AM','202009251','333','','','202009251',dbo.fn_GetTimedKey(),NULL,'us3cPeSDG1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202010049','EMPEXPORT','OEACTIVE','Oct  6 2020  5:48PM','EUNDENVISE',NULL,NULL,NULL,'202010049','Oct  4 2020  5:13PM','Oct  4 2020  5:13PM','202009271','78','','','202009271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202010049','EMPEXPORT','OEPASSIVE','Oct  6 2020  5:48PM','EUNDENVISE',NULL,NULL,NULL,'202010049','Oct  4 2020  5:13PM','Oct  4 2020  5:13PM','202009271','558','','','202009271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM Dental Vision Elg Export','202010049','EMPEXPORT','ONDEM_XOE','Oct  6 2020  5:49PM','EUNDENVISE',NULL,NULL,NULL,'202010049','Oct  4 2020  5:13PM','Oct  4 2020  5:13PM','202009271','107','','','202009271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM Dental Vision Elg E-Sched','202010049','EMPEXPORT','SCH_EUNDEN','Oct  6 2020  5:50PM','EUNDENVISE',NULL,NULL,NULL,'202010049','Oct  4 2020  5:13PM','Oct  4 2020  5:13PM','202009271','107','','','202009271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM Dental Vision Elg E-Test','202010049','EMPEXPORT','TEST_XOE','Oct  6 2020  5:51PM','EUNDENVISE',NULL,NULL,NULL,'202010049','Oct  4 2020  5:13PM','Oct  4 2020  5:13PM','202009271','107','','','202009271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNDENVISE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNDENVISE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNDENVISE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNDENVISE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNDENVISE','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUNDENVISE' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUNDENVISE' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUNDENVISE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNDENVISE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNDENVISE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNDENVISE','D10','dbo.U_EUNDENVISE_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EUNDENVISE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNDENVISE] (
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
IF OBJECT_ID('U_EUNDENVISE_Audit') IS NULL
CREATE TABLE [dbo].[U_EUNDENVISE_Audit] (
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
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL,
    [audDedChange] varchar(1) NOT NULL,
    [audBenOptionChange] varchar(1) NOT NULL,
    [audSSNChange] varchar(1) NOT NULL,
    [audNameChange] varchar(1) NOT NULL,
    [audDemoChange] varchar(1) NOT NULL,
    [audAddrChange] varchar(1) NOT NULL,
    [audNewlyEnroll] varchar(1) NOT NULL,
    [audReEnroll] varchar(1) NOT NULL,
    [audTermPlan] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUNDENVISE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUNDENVISE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EUNDENVISE_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNDENVISE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUNDENVISE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNDENVISE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvRecordCount] varchar(10) NOT NULL,
    [drvDivision] varchar(4) NULL,
    [drvMemberId] char(11) NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(257) NOT NULL,
    [drvAddresState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDoh] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvTermReason] varchar(2) NULL,
    [drvNewMemberId] varchar(2000) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvEamilAddress] varchar(50) NULL,
    [drvSpouseNameFirst] varchar(100) NULL,
    [drvSpouseNameMiddle] varchar(1) NULL,
    [drvSpouseNameLast] varchar(100) NULL,
    [drvSpouseNameSuffix] varchar(30) NULL,
    [drvSpouseGender] varchar(1) NULL,
    [drvSpouseDateOfBirth] datetime NULL,
    [drvSpouseSSN] char(11) NULL,
    [drvSpouseEffectiveDate] datetime NULL,
    [drvSpouseTermDate] datetime NULL,
    [drvSignatureDate] datetime NULL,
    [drvEffecitveDate] datetime NULL,
    [drvAddType] varchar(1) NULL,
    [drvBenefitId1] varchar(2) NULL,
    [drvPlanCode1] varchar(6) NULL,
    [drvBenefitQualDate1] datetime NULL,
    [drvBenefitTermDate1] datetime NULL,
    [drvBenefitSelection1] varchar(1) NULL,
    [drvBenefitId2] varchar(2) NULL,
    [drvPlanCode2] varchar(6) NULL,
    [drvBenefitQualDate2] datetime NULL,
    [drvBenefitTermDate2] datetime NULL,
    [drvBenefitSelection2] varchar(1) NULL,
    [drvDentalDepNameFirst1] varchar(100) NULL,
    [drvDentalDepNameMIddle1] varchar(1) NULL,
    [drvDentalDepNameLast1] varchar(100) NULL,
    [drvDentalDepNameSuffix1] varchar(30) NULL,
    [drvDentalDepSSN1] char(11) NULL,
    [drvDentalDepEffDate1] datetime NULL,
    [drvDentalDepTermDate1] datetime NULL,
    [drvDentalDepGender1] char(1) NULL,
    [drvDentalDepDateOfBirth1] datetime NULL,
    [drvDentalDepRelationship1] varchar(1) NULL,
    [drvDentalDepDisabledInd1] varchar(1) NULL,
    [drvDentalDepNameFirst2] varchar(100) NULL,
    [drvDentalDepNameMIddle2] varchar(1) NULL,
    [drvDentalDepNameLast2] varchar(100) NULL,
    [drvDentalDepNameSuffix2] varchar(30) NULL,
    [drvDentalDepSSN2] char(11) NULL,
    [drvDentalDepEffDate2] datetime NULL,
    [drvDentalDepTermDate2] datetime NULL,
    [drvDentalDepGender2] char(1) NULL,
    [drvDentalDepDateOfBirth2] datetime NULL,
    [drvDentalDepRelationship2] varchar(1) NULL,
    [drvDentalDepDisabledInd2] varchar(1) NULL,
    [drvDentalDepNameFirst3] varchar(100) NULL,
    [drvDentalDepNameMIddle3] varchar(1) NULL,
    [drvDentalDepNameLast3] varchar(100) NULL,
    [drvDentalDepNameSuffix3] varchar(30) NULL,
    [drvDentalDepSSN3] char(11) NULL,
    [drvDentalDepEffDate3] datetime NULL,
    [drvDentalDepTermDate3] datetime NULL,
    [drvDentalDepGender3] char(1) NULL,
    [drvDentalDepDateOfBirth3] datetime NULL,
    [drvDentalDepRelationship3] varchar(1) NULL,
    [drvDentalDepDisabledInd3] varchar(1) NULL,
    [drvDentalDepNameFirst4] varchar(100) NULL,
    [drvDentalDepNameMIddle4] varchar(1) NULL,
    [drvDentalDepNameLast4] varchar(100) NULL,
    [drvDentalDepNameSuffix4] varchar(30) NULL,
    [drvDentalDepSSN4] char(11) NULL,
    [drvDentalDepEffDate4] datetime NULL,
    [drvDentalDepTermDate4] datetime NULL,
    [drvDentalDepGender4] char(1) NULL,
    [drvDentalDepDateOfBirth4] datetime NULL,
    [drvDentalDepRelationship4] varchar(1) NULL,
    [drvDentalDepDisabledInd4] varchar(1) NULL,
    [drvDentalDepNameFirst5] varchar(100) NULL,
    [drvDentalDepNameMIddle5] varchar(1) NULL,
    [drvDentalDepNameLast5] varchar(100) NULL,
    [drvDentalDepNameSuffix5] varchar(30) NULL,
    [drvDentalDepSSN5] char(11) NULL,
    [drvDentalDepEffDate5] datetime NULL,
    [drvDentalDepTermDate5] datetime NULL,
    [drvDentalDepGender5] char(1) NULL,
    [drvDentalDepDateOfBirth5] datetime NULL,
    [drvDentalDepRelationship5] varchar(1) NULL,
    [drvDentalDepDisabledInd5] varchar(1) NULL,
    [drvDentalDepNameFirst6] varchar(100) NULL,
    [drvDentalDepNameMIddle6] varchar(1) NULL,
    [drvDentalDepNameLast6] varchar(100) NULL,
    [drvDentalDepNameSuffix6] varchar(30) NULL,
    [drvDentalDepSSN6] char(11) NULL,
    [drvDentalDepEffDate6] datetime NULL,
    [drvDentalDepTermDate6] datetime NULL,
    [drvDentalDepGender6] char(1) NULL,
    [drvDentalDepDateOfBirth6] datetime NULL,
    [drvDentalDepRelationship6] varchar(1) NULL,
    [drvDentalDepDisabledInd6] varchar(1) NULL,
    [drvDentalDepNameFirst7] varchar(100) NULL,
    [drvDentalDepNameMIddle7] varchar(1) NULL,
    [drvDentalDepNameLast7] varchar(100) NULL,
    [drvDentalDepNameSuffix7] varchar(30) NULL,
    [drvDentalDepSSN7] char(11) NULL,
    [drvDentalDepEffDate7] datetime NULL,
    [drvDentalDepTermDate7] datetime NULL,
    [drvDentalDepGender7] char(1) NULL,
    [drvDentalDepDateOfBirth7] datetime NULL,
    [drvDentalDepRelationship7] varchar(1) NULL,
    [drvDentalDepDisabledInd7] varchar(1) NULL,
    [drvDentalDepNameFirst8] varchar(100) NULL,
    [drvDentalDepNameMIddle8] varchar(1) NULL,
    [drvDentalDepNameLast8] varchar(100) NULL,
    [drvDentalDepNameSuffix8] varchar(30) NULL,
    [drvDentalDepSSN8] char(11) NULL,
    [drvDentalDepEffDate8] datetime NULL,
    [drvDentalDepTermDate8] datetime NULL,
    [drvDentalDepGender8] char(1) NULL,
    [drvDentalDepDateOfBirth8] datetime NULL,
    [drvDentalDepRelationship8] varchar(1) NULL,
    [drvDentalDepDisabledInd8] varchar(1) NULL
);
IF OBJECT_ID('U_EUNDENVISE_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNDENVISE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNDENVISE_File') IS NULL
CREATE TABLE [dbo].[U_EUNDENVISE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNDENVISE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: SDG Management Company LLC

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 10/04/2020
Service Request Number: TekP-2020-09-14-0003

Purpose: UNUM Dental Vision Elg Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNDENVISE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNDENVISE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNDENVISE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNDENVISE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNDENVISE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNDENVISE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNDENVISE', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNDENVISE', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNDENVISE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNDENVISE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNDENVISE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNDENVISE', 'SCH_EUNDEN';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNDENVISE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNDENVISE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNDENVISE';

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
    DELETE FROM dbo.U_EUNDENVISE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNDENVISE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_EUNDENVISE_EEList
    WHERE xEEID IN (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES'))

    --==========================================
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_EUNDENVISE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUNDENVISE_AuditFields;
    CREATE TABLE dbo.U_EUNDENVISE_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Dependent Information
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('Contacts','ConAddressCountry');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('EmpDed','EedBenStopDate');
    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_EUNDENVISE_AuditFields VALUES ('DepBPlan','DbnBenStopDate');

    IF OBJECT_ID('U_EUNDENVISE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUNDENVISE_Audit;
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
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
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
    INTO dbo.U_EUNDENVISE_Audit
    FROM dbo.U_EUNDENVISE_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_EUNDENVISE_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_EUNDENVISE_DedList))
        OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_EUNDENVISE_DedList))
    );
    --================
    -- Changes Only
    --================
    IF (@Exportcode NOT IN ('FULLFILE','OEACTIVE','OEPASSIVE'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_EUNDENVISE_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EUNDENVISE_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;




    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN,VIS';

    IF OBJECT_ID('U_EUNDENVISE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNDENVISE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNDENVISE_DedList
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
    -- DETAIL RECORD - U_EUNDENVISE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNDENVISE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNDENVISE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvRecordCount = '9999999999'
        ,drvDivision =    CASE EecCOID
                            WHEN 'NBGY8' THEN '0002'
                            WHEN 'NBGQ9' THEN '0003'
                            WHEN 'NBGSD' THEN '0004'
                            WHEN 'NBH0C' THEN '0005' 
                            WHEN 'NBH1Z' THEN '0006'
                            WHEN 'NBGUH' THEN '0007'
                        END
        ,drvMemberId = EepSSN
        ,drvAddressLine1 = '"' + EepAddressLine1 + '"'
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = '"' + ISNULL(EepAddressCity, '') + '"'
        ,drvAddresState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDoh = EecDateOfLastHire
        ,drvTermDate =    CASE WHEN EecEmplStatus = 'T' OR (Den_BdmBenStatus = 'T' AND Vis_BdmBenStatus = 'T') THEN 
                                CASE WHEN Den_DedCode IS NOT NULL THEN Den_BdmBenStopDate                
                                    WHEN Vis_DedCode IS NOT NULL THEN Vis_BdmBenStopDate 
                                END
                            --WHEN EecEmplStatus = 'A' THEN
                                --CASE WHEN Den_BdmBenStatus = 'T' OR Vis_BdmBenStatus = 'T' THEN 
                        END
        ,drvTermReason =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DT'
                                WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RT'
                                WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202','203') THEN 'TE'
                                WHEN Den_BdmBenStatus = 'T' AND Vis_BdmBenStatus = 'T' THEN 'IN'
                            END
        ,drvNewMemberId =    CASE WHEN @Exportcode NOT IN ('FULLFILE','OEACTIVE','OEPASSIVE') THEN (SELECT TOP 1 audNewValue from dbo.U_EUNDENVISE_Audit WITH (NOLOCK) WHERE audTableName = 'EmpPers' AND audFieldName = 'EepSSN' AND audEEID = xEEID AND audCOID = xCOID)
                            END
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = REPLACE(EepNameLast, 'ñ', 'n') -- This is a total kludge, but it works. I tried using COLLATE, but something downstream in Switchbox was throwing a type mis-match error. This stinks, but it's currently the best solution.
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvGender = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvEamilAddress = CASE WHEN ISNULL(EepAddressEmail, '') <> '' THEN EepAddressEmail ELSE EepAddressEmailAlternate END
        ,drvSpouseNameFirst = SpouseNameFirst
        ,drvSpouseNameMiddle = LEFT(SpouseNameMiddle,1)
        ,drvSpouseNameLast = SpouseNameLast
        ,drvSpouseNameSuffix = NULLIF(SpouseNameSuffix,'Z')
        ,drvSpouseGender =    CASE WHEN SpouseGender = 'M' THEN 'M'
                                WHEN SpouseGender = 'F' THEN 'F'
                                WHEN ISNULL(SpouseGender, '') <> '' AND SpouseGender NOT IN ('M','F') THEN 'M'                
                            END
        ,drvSpouseDateOfBirth = SpouseDateOfBirth
        ,drvSpouseSSN = CASE WHEN SpouseSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(SpouseSSN, 3) NOT IN ('999','888') THEN SpouseSSN END
        ,drvSpouseEffectiveDate = CASE WHEN SpouseNameFirst IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',SpsBenStartDate,'1/1/2021') END
        ,drvSpouseTermDate = SpsBenStopDate
        ,drvSignatureDate =    CASE WHEN Den_DedCode IS NOT NULL THEN Den_BdmBenStartDate
                                WHEN Vis_DedCode IS NOT NULL THEN Vis_BdmBenStartDate
                            END
        ,drvEffecitveDate =    dbo.dsi_fnGetMinMaxDates('MAX',
                                    CASE WHEN audReHire = 'Y' THEN EecDateOfLastHire
                                        WHEN audTerm = 'Y' THEN EecDateOfTermination
                                        WHEN audSalaryChange = 'Y' THEN XEjhJobEffDate
                                        ELSE 
                                                CASE WHEN Den_DedCode IS NOT NULL THEN Den_BdmBenStartDate
                                                    WHEN Vis_DedCode IS NOT NULL THEN Vis_BdmBenStartDate
                                                END
                                    END, '1/1/2021')
        ,drvAddType = CASE WHEN EecFullTimeOrPartTime = 'F' AND XEjhFullTimeOrPartTime = 'P' THEN 'O' END

        ,drvBenefitId1 =    CASE WHEN Den_DedCode IS NOT NULL THEN 'OA'
                                WHEN Vis_DedCode IS NOT NULL THEN 'VA'
                            END        
        ,drvPlanCode1 =    CASE WHEN Den_DedCode IS NOT NULL THEN
                                CASE WHEN DEN_BdmBenOption = 'EE' THEN 'DENT01'
                                    WHEN DEN_BdmBenOption IN ('EES','EEDP') THEN 'DENTA1'
                                    WHEN DEN_BdmBenOption IN ('EEC') THEN 'DENTC1'
                                    WHEN DEN_BdmBenOption IN ('EEF','EEDPF') THEN 'DENTF1'
                                END
                            WHEN Vis_DedCode IS NOT NULL THEN
                                CASE WHEN VIS_BdmBenOption = 'EE' THEN 'VISN01'
                                    WHEN VIS_BdmBenOption IN ('EES','EEDP') THEN 'VISNA1'
                                    WHEN VIS_BdmBenOption IN ('EEC') THEN 'VISNC1'
                                    WHEN VIS_BdmBenOption IN ('EEF','EEDPF') THEN 'VISNF1'
                                END
                        END
        ,drvBenefitQualDate1 =    CASE WHEN Den_DedCode IS NOT NULL AND Den_EdhChangeReason IN ('LEVNT2','LEVNT3','LEVNT4','103','105','107','108','109','110','201','204','210','300','302','303') THEN Den_EdhEffDate
                                    WHEN Vis_DedCode IS NOT NULL AND Vis_EdhChangeReason IN ('LEVNT2','LEVNT3','LEVNT4','103','105','107','108','109','110','201','204','210','300','302','303') THEN Vis_EdhEffDate
                                END 
        ,drvBenefitTermDate1 =    CASE WHEN Den_DedCode IS NOT NULL THEN Den_BdmBenStopDate
                                    WHEN Vis_DedCode IS NOT NULL THEN Vis_BdmBenStopDate
                                END        
        ,drvBenefitSelection1 = CASE WHEN Den_DedCode IS NOT NULL OR Vis_DedCode IS NOT NULL THEN 'Y' END                                
        ,drvBenefitId2 = CASE WHEN Vis_DedCode IS NOT NULL AND Den_DedCode IS NOT NULL THEN 'VA' END
        
        ,drvPlanCode2 =    CASE WHEN Vis_DedCode IS NOT NULL AND Den_DedCode IS NOT NULL THEN
                            CASE WHEN VIS_BdmBenOption = 'EE' THEN 'VISN01'
                                WHEN VIS_BdmBenOption IN ('EES','EEDP') THEN 'VISNA1'
                                WHEN VIS_BdmBenOption IN ('EEC') THEN 'VISNC1'
                                WHEN VIS_BdmBenOption IN ('EEF','EEDPF') THEN 'VISNF1'
                            END
                        END
        ,drvBenefitQualDate2 =  CASE WHEN Vis_DedCode IS NOT NULL AND Den_DedCode IS NOT NULL AND Vis_EdhChangeReason IN ('LEVNT2','LEVNT3','LEVNT4','103','105','107','108','109','110','201','202','203','204','210','300','302','303','303') THEN Vis_EdhEffDate END
        ,drvBenefitTermDate2 = CASE WHEN Vis_DedCode IS NOT NULL AND Den_DedCode IS NOT NULL THEN Vis_BdmBenStopDate END
        ,drvBenefitSelection2 = CASE WHEN Den_DedCode IS NOT NULL AND Vis_DedCode IS NOT NULL THEN 'Y' END

        ,drvDentalDepNameFirst1 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN DenDepNameFirst1 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameFirst1 END
        ,drvDentalDepNameMIddle1 = LEFT(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN DenDepNameMiddle1 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameMIddle1 END, 1)
        ,drvDentalDepNameLast1 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN DenDepNameLast1 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameLast1 END
        ,drvDentalDepNameSuffix1 = NULLIF(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN DenDepNameSuffix1 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSuffix1 END, 'Z')        
        ,drvDentalDepSSN1 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN DenDepNameSSN1 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSSN1 END
        ,drvDentalDepEffDate1 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepBdmStartDate1 IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', DenDepBdmStartDate1, '1/1/2021') WHEN Vis_DedCode IS NOT NULL AND VisDepBdmStartDate1 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VisDepBdmStartDate1, '1/1/2021') END
        ,drvDentalDepTermDate1 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN DenDepBdmStopDate1 WHEN Vis_DedCode IS NOT NULL THEN VisDepBdmStopDate1 END
        ,drvDentalDepGender1 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN DenDepGender1 WHEN Vis_DedCode IS NOT NULL THEN VisDepGender1 END
        ,drvDentalDepDateOfBirth1 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN DenDepDateOFBirth1 WHEN Vis_DedCode IS NOT NULL THEN VisDepDateOFBirth1 END
        ,drvDentalDepRelationship1 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN DenDepRelationship1 WHEN Vis_DedCode IS NOT NULL THEN VisDepRelationship1 END
        ,drvDentalDepDisabledInd1 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst1 IS NOT NULL THEN DenDepIsDisabled1 WHEN Vis_DedCode IS NOT NULL THEN VisDepIsDisabled1 END
        

        ,drvDentalDepNameFirst2 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN DenDepNameFirst2 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameFirst2 END
        ,drvDentalDepNameMIddle2 = LEFT(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN DenDepNameMiddle2 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameMIddle2 END, 1)
        ,drvDentalDepNameLast2 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN DenDepNameLast2 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameLast2 END
        ,drvDentalDepNameSuffix2 = NULLIF(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN DenDepNameSuffix2 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSuffix2 END, 'Z')
        ,drvDentalDepSSN2 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN DenDepNameSSN2 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSSN2 END
        ,drvDentalDepEffDate2 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepBdmStartDate2 IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', DenDepBdmStartDate2, '1/1/2021') WHEN Vis_DedCode IS NOT NULL AND VisDepBdmStartDate2 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VisDepBdmStartDate2, '1/1/2021') END
        ,drvDentalDepTermDate2 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN DenDepBdmStopDate2 WHEN Vis_DedCode IS NOT NULL THEN VisDepBdmStopDate2 END
        ,drvDentalDepGender2 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN DenDepGender2 WHEN Vis_DedCode IS NOT NULL THEN VisDepGender2 END
        ,drvDentalDepDateOfBirth2 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN DenDepDateOFBirth2 WHEN Vis_DedCode IS NOT NULL THEN VisDepDateOFBirth2 END
        ,drvDentalDepRelationship2 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN DenDepRelationship2 WHEN Vis_DedCode IS NOT NULL THEN VisDepRelationship2 END
        ,drvDentalDepDisabledInd2 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst2 IS NOT NULL THEN DenDepIsDisabled2 WHEN Vis_DedCode IS NOT NULL THEN VisDepIsDisabled2 END

        ,drvDentalDepNameFirst3 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN DenDepNameFirst3 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameFirst3 END
        ,drvDentalDepNameMIddle3 = LEFT(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN DenDepNameMiddle3 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameMIddle3 END, 1)
        ,drvDentalDepNameLast3 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN DenDepNameLast3 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameLast3 END
        ,drvDentalDepNameSuffix3 = NULLIF(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN DenDepNameSuffix3 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSuffix3 END, 'Z')
        ,drvDentalDepSSN3 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN DenDepNameSSN3 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSSN3 END
        ,drvDentalDepEffDate3 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepBdmStartDate3 IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', DenDepBdmStartDate3, '1/1/2021') WHEN Vis_DedCode IS NOT NULL AND VisDepBdmStartDate3 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VisDepBdmStartDate3, '1/1/2021') END
        ,drvDentalDepTermDate3 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN DenDepBdmStopDate3 WHEN Vis_DedCode IS NOT NULL THEN VisDepBdmStopDate3 END
        ,drvDentalDepGender3 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN DenDepGender3 WHEN Vis_DedCode IS NOT NULL THEN VisDepGender3 END
        ,drvDentalDepDateOfBirth3 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN DenDepDateOFBirth3 WHEN Vis_DedCode IS NOT NULL THEN VisDepDateOFBirth3 END
        ,drvDentalDepRelationship3 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN DenDepRelationship3 WHEN Vis_DedCode IS NOT NULL THEN VisDepRelationship3 END
        ,drvDentalDepDisabledInd3 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst3 IS NOT NULL THEN DenDepIsDisabled3 WHEN Vis_DedCode IS NOT NULL THEN VisDepIsDisabled3 END

        ,drvDentalDepNameFirst4 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN DenDepNameFirst4 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameFirst4 END
        ,drvDentalDepNameMIddle4 = LEFT(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN DenDepNameMiddle4 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameMIddle4 END, 1)
        ,drvDentalDepNameLast4 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN DenDepNameLast4 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameLast4 END
        ,drvDentalDepNameSuffix4 = NULLIF(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN DenDepNameSuffix4 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSuffix4 END, 'Z')
        ,drvDentalDepSSN4 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN DenDepNameSSN4 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSSN4 END
        ,drvDentalDepEffDate4 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepBdmStartDate4 IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', DenDepBdmStartDate4, '1/1/2021') WHEN Vis_DedCode IS NOT NULL AND VisDepBdmStartDate4 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VisDepBdmStartDate4, '1/1/2021') END
        ,drvDentalDepTermDate4 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN DenDepBdmStopDate4 WHEN Vis_DedCode IS NOT NULL THEN VisDepBdmStopDate4 END
        ,drvDentalDepGender4 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN DenDepGender4 WHEN Vis_DedCode IS NOT NULL THEN VisDepGender4 END
        ,drvDentalDepDateOfBirth4 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN DenDepDateOFBirth4 WHEN Vis_DedCode IS NOT NULL THEN VisDepDateOFBirth4 END
        ,drvDentalDepRelationship4 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN DenDepRelationship4 WHEN Vis_DedCode IS NOT NULL THEN VisDepRelationship4 END
        ,drvDentalDepDisabledInd4 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst4 IS NOT NULL THEN DenDepIsDisabled4 WHEN Vis_DedCode IS NOT NULL THEN VisDepIsDisabled4 END

        ,drvDentalDepNameFirst5 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN DenDepNameFirst5 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameFirst5 END
        ,drvDentalDepNameMIddle5 = LEFT(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN DenDepNameMiddle5 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameMIddle5 END, 1)
        ,drvDentalDepNameLast5 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN DenDepNameLast5 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameLast5 END
        ,drvDentalDepNameSuffix5 = NULLIF(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN DenDepNameSuffix5 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSuffix5 END, 'Z')
        ,drvDentalDepSSN5 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN DenDepNameSSN5 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSSN5 END
        ,drvDentalDepEffDate5 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepBdmStartDate5 IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', DenDepBdmStartDate5, '1/1/2021') WHEN Vis_DedCode IS NOT NULL AND VisDepBdmStartDate5 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VisDepBdmStartDate5, '1/1/2021') END
        ,drvDentalDepTermDate5 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN DenDepBdmStopDate5 WHEN Vis_DedCode IS NOT NULL THEN VisDepBdmStopDate5 END
        ,drvDentalDepGender5 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN DenDepGender5 WHEN Vis_DedCode IS NOT NULL THEN VisDepGender5 END
        ,drvDentalDepDateOfBirth5 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN DenDepDateOFBirth5 WHEN Vis_DedCode IS NOT NULL THEN VisDepDateOFBirth5 END
        ,drvDentalDepRelationship5 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN DenDepRelationship5 WHEN Vis_DedCode IS NOT NULL THEN VisDepRelationship5 END
        ,drvDentalDepDisabledInd5 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst5 IS NOT NULL THEN DenDepIsDisabled5 WHEN Vis_DedCode IS NOT NULL THEN VisDepIsDisabled5 END

        ,drvDentalDepNameFirst6 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN DenDepNameFirst6 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameFirst6 END
        ,drvDentalDepNameMIddle6 = LEFT(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN DenDepNameMiddle6 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameMIddle6 END, 1)
        ,drvDentalDepNameLast6 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN DenDepNameLast6 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameLast6 END
        ,drvDentalDepNameSuffix6 = NULLIF(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN DenDepNameSuffix6 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSuffix6 END, 'Z')
        ,drvDentalDepSSN6 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN DenDepNameSSN6 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSSN6 END
        ,drvDentalDepEffDate6 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepBdmStartDate6 IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', DenDepBdmStartDate6, '1/1/2021') WHEN Vis_DedCode IS NOT NULL AND VisDepBdmStartDate6 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VisDepBdmStartDate6, '1/1/2021') END
        ,drvDentalDepTermDate6 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN DenDepBdmStopDate6 WHEN Vis_DedCode IS NOT NULL THEN VisDepBdmStopDate6 END
        ,drvDentalDepGender6 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN DenDepGender6 WHEN Vis_DedCode IS NOT NULL THEN VisDepGender6 END
        ,drvDentalDepDateOfBirth6 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN DenDepDateOFBirth6 WHEN Vis_DedCode IS NOT NULL THEN VisDepDateOFBirth6 END
        ,drvDentalDepRelationship6 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN DenDepRelationship6 WHEN Vis_DedCode IS NOT NULL THEN VisDepRelationship6 END
        ,drvDentalDepDisabledInd6 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst6 IS NOT NULL THEN DenDepIsDisabled6 WHEN Vis_DedCode IS NOT NULL THEN VisDepIsDisabled6 END

        ,drvDentalDepNameFirst7 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN DenDepNameFirst7 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameFirst7 END
        ,drvDentalDepNameMIddle7 = LEFT(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN DenDepNameMiddle7 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameMIddle7 END, 1)
        ,drvDentalDepNameLast7 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN DenDepNameLast7 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameLast7 END
        ,drvDentalDepNameSuffix7 = NULLIF(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN DenDepNameSuffix7 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSuffix7 END, 'Z')
        ,drvDentalDepSSN7 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN DenDepNameSSN7 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSSN7 END
        ,drvDentalDepEffDate7 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepBdmStartDate7 IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', DenDepBdmStartDate7, '1/1/2021') WHEN Vis_DedCode IS NOT NULL AND VisDepBdmStartDate7 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VisDepBdmStartDate7, '1/1/2021') END
        ,drvDentalDepTermDate7 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN DenDepBdmStopDate7 WHEN Vis_DedCode IS NOT NULL THEN VisDepBdmStopDate7 END
        ,drvDentalDepGender7 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN DenDepGender7 WHEN Vis_DedCode IS NOT NULL THEN VisDepGender7 END
        ,drvDentalDepDateOfBirth7 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN DenDepDateOFBirth7 WHEN Vis_DedCode IS NOT NULL THEN VisDepDateOFBirth7 END
        ,drvDentalDepRelationship7 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN DenDepRelationship7 WHEN Vis_DedCode IS NOT NULL THEN VisDepRelationship7 END
        ,drvDentalDepDisabledInd7 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst7 IS NOT NULL THEN DenDepIsDisabled7 WHEN Vis_DedCode IS NOT NULL THEN VisDepIsDisabled7 END

        ,drvDentalDepNameFirst8 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN DenDepNameFirst8 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameFirst8 END
        ,drvDentalDepNameMIddle8 = LEFT(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN DenDepNameMiddle8 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameMIddle8 END, 1)
        ,drvDentalDepNameLast8 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN DenDepNameLast8 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameLast8 END
        ,drvDentalDepNameSuffix8 = NULLIF(CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN DenDepNameSuffix8 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSuffix8 END, 'Z')
        ,drvDentalDepSSN8 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN DenDepNameSSN8 WHEN Vis_DedCode IS NOT NULL THEN VisDepNameSSN8 END
        ,drvDentalDepEffDate8 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepBdmStartDate8 IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', DenDepBdmStartDate8, '1/1/2021') WHEN Vis_DedCode IS NOT NULL AND VisDepBdmStartDate8 IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VisDepBdmStartDate8, '1/1/2021') END
        ,drvDentalDepTermDate8 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN DenDepBdmStopDate8 WHEN Vis_DedCode IS NOT NULL THEN VisDepBdmStopDate8 END
        ,drvDentalDepGender8 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN DenDepGender8 WHEN Vis_DedCode IS NOT NULL THEN VisDepGender8 END
        ,drvDentalDepDateOfBirth8 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN DenDepDateOFBirth8 WHEN Vis_DedCode IS NOT NULL THEN VisDepDateOFBirth8 END
        ,drvDentalDepRelationship8 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN DenDepRelationship8 WHEN Vis_DedCode IS NOT NULL THEN VisDepRelationship8 END
        ,drvDentalDepDisabledInd8 = CASE WHEN Den_DedCode IS NOT NULL AND DenDepNameFirst8 IS NOT NULL THEN DenDepIsDisabled8 WHEN Vis_DedCode IS NOT NULL THEN VisDepIsDisabled8 END
    INTO dbo.U_EUNDENVISE_drvTbl
    FROM dbo.U_EUNDENVISE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT BdmEEID, BdmCOID
                ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmDedCode END) AS Den_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmBenStartDate END) AS Den_BdmBenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmBenStopDate END) AS Den_BdmBenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmBenOption END) AS Den_BdmBenOption
                ,MAX(CASE WHEN BdmDedCode = 'DEN' THEN BdmBenStatus END) AS Den_BdmBenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmDedCode END) AS Vis_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmBenStartDate END) AS Vis_BdmBenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmBenStopDate END) AS Vis_BdmBenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmBenOption END) AS Vis_BdmBenOption
                ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmBenStatus END) AS Vis_BdmBenStatus
            FROM dbo.U_dsi_BDM_EUNDENVISE WITH (NOLOCK) 
            WHERE BdmRecType = 'EMP'
            GROUP BY BdmEEID, BdmCOID) AS Flat_Bdm
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN (
                SELECT ConEEID AS SpouseEEID, ConNameFirst AS SpouseNameFirst, ConNameLast AS SpouseNameLast, ConNameMiddle AS SpouseNameMiddle, ConNameSuffix AS SpouseNameSuffix, ConGender AS SpouseGender, ConDateOfBirth AS SpouseDateOfBirth, ConSSN AS SpouseSSN, ConRelationship AS SpouseRelationship
                FROM dbo.Contacts WITH (NOLOCK)
                JOIN dbo.U_dsi_BDM_EUNDENVISE WITH (NOLOCK)
                    ON ConEEID = BdmEEID
                    AND BdmDepRecId = ConSystemId
                WHERE ConRelationship IN ('SPS','DP')
                    AND ConIsDependent = 'Y') AS Spouse
        ON SpouseEEID = xEEID
    LEFT JOIN (
                SELECT BdmEEID AS SpsBenEEID, BdmCOID AS SpsBenCOID, BdmDedCode AS SpouseDedCode, MAX(BdmBenStartDate) AS SpsBenStartDate, MAX(BdmBenStopDate) AS SpsBenStopDate
                FROM dbo.U_dsi_BDM_EUNDENVISE WITH (NOLOCK)
                JOIN dbo.Contacts WITH (NOLOCK)
                    ON ConEEID = BdmEEID 
                    AND BdmDepRecId = ConSystemId
                WHERE BdmRelationship IN ('SPS','DP')
                GROUP BY BdmEEID, BdmCOID, BdmDedCode) AS SpouseBenefit
        ON SpsBenEEID= xEEID
        AND SpsBenCOID = xCOID
    LEFT JOIN (
                SELECT EdhEEID AS Den_EdhEEID, EdhCOID AS Den_EdhCOID, EdhChangeReason AS Den_EdhChangeReason, EdhEffDate AS Den_EdhEffDate
                FROM (
                    SELECT EdhEEID, EdhCOID , EdhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID ORDER BY EdhDateTimeCreated DESC) AS RN
                    FROM dbo.EmpHDed WITH (NOLOCK)
                    WHERE EDhDedCode  IN ('DEN')) AS Den_X
                WHERE RN = 1) AS Den_Emp_Ded
        ON Den_EdhEEID = xEEID
        AND Den_EdhCOID = xCOID
    LEFT JOIN (
                SELECT EdhEEID AS Vis_EdhEEID, EdhCOID AS Vis_EdhCOID, EdhChangeReason AS Vis_EdhChangeReason, EdhEffDate AS Vis_EdhEffDate
                FROM (
                    SELECT EdhEEID, EdhCOID , EdhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID ORDER BY EdhDateTimeCreated DESC) AS RN
                    FROM dbo.EmpHDed WITH (NOLOCK)
                    WHERE EDhDedCode  IN ('Vis')) AS Vis_X
                WHERE RN = 1) AS Vis_Emp_Ded
        ON Vis_EdhEEID = xEEID
        AND Vis_EdhCOID = xCOID
    LEFT JOIN (
                    SELECT ConEEID AS DenDepEEID
                        ,MAX(CASE WHEN RN = 1 THEN ConRelationship END) AS DenDepRelationship1
                        ,MAX(CASE WHEN RN = 1 THEN ConSystemId END) AS DenDepSystemId1
                        ,MAX(CASE WHEN RN = 1 THEN ConNameLast END) AS DenDepNameLast1
                        ,MAX(CASE WHEN RN = 1 THEN ConNameMiddle END) AS DenDepNameMiddle1
                        ,MAX(CASE WHEN RN = 1 THEN ConNameFirst END) AS DenDepNameFirst1
                        ,MAX(CASE WHEN RN = 1 THEN ConNameSuffix END) AS DenDepNameSuffix1
                        ,MAX(CASE WHEN RN = 1 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS DenDepNameSSN1
                        ,MAX(CASE WHEN RN = 1 THEN ConGender END) AS DenDepGender1
                        ,MAX(CASE WHEN RN = 1 THEN ConDateOFBirth END) AS DenDepDateOFBirth1
                        ,MAX(CASE WHEN RN = 1 THEN ConIsDisabled END) AS DenDepIsDisabled1
                        ,MAX(CASE WHEN RN = 1 THEN BdmBenStartDate END) AS DenDepBdmStartDate1
                        ,MAX(CASE WHEN RN = 1 THEN BdmBenStopDate END) AS DenDepBdmStopDate1
                        ,MAX(CASE WHEN RN = 2 THEN ConRelationship END) AS DenDepRelationship2
                        ,MAX(CASE WHEN RN = 2 THEN ConSystemId END) AS DenDepSystemId2
                        ,MAX(CASE WHEN RN = 2 THEN ConNameLast END) AS DenDepNameLast2
                        ,MAX(CASE WHEN RN = 2 THEN ConNameMiddle END) AS DenDepNameMiddle2
                        ,MAX(CASE WHEN RN = 2 THEN ConNameFirst END) AS DenDepNameFirst2
                        ,MAX(CASE WHEN RN = 2 THEN ConNameSuffix END) AS DenDepNameSuffix2
                        ,MAX(CASE WHEN RN = 2 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS DenDepNameSSN2
                        ,MAX(CASE WHEN RN = 2 THEN ConGender END) AS DenDepGender2
                        ,MAX(CASE WHEN RN = 2 THEN ConDateOFBirth END) AS DenDepDateOFBirth2
                        ,MAX(CASE WHEN RN = 2 THEN BdmBenStartDate END) AS DenDepBdmStartDate2
                        ,MAX(CASE WHEN RN = 2 THEN BdmBenStopDate END) AS DenDepBdmStopDate2
                        ,MAX(CASE WHEN RN = 2 THEN ConIsDisabled END) AS DenDepIsDisabled2
                        ,MAX(CASE WHEN RN = 3 THEN ConRelationship END) AS DenDepRelationship3
                        ,MAX(CASE WHEN RN = 3 THEN ConSystemId END) AS DenDepSystemId3
                        ,MAX(CASE WHEN RN = 3 THEN ConNameLast END) AS DenDepNameLast3
                        ,MAX(CASE WHEN RN = 3 THEN ConNameMiddle END) AS DenDepNameMiddle3
                        ,MAX(CASE WHEN RN = 3 THEN ConNameFirst END) AS DenDepNameFirst3
                        ,MAX(CASE WHEN RN = 3 THEN ConNameSuffix END) AS DenDepNameSuffix3                        
                        ,MAX(CASE WHEN RN = 3 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS DenDepNameSSN3
                        ,MAX(CASE WHEN RN = 3 THEN ConGender END) AS DenDepGender3
                        ,MAX(CASE WHEN RN = 3 THEN ConDateOFBirth END) AS DenDepDateOFBirth3
                        ,MAX(CASE WHEN RN = 3 THEN ConIsDisabled END) AS DenDepIsDisabled3
                        ,MAX(CASE WHEN RN = 3 THEN BdmBenStartDate END) AS DenDepBdmStartDate3
                        ,MAX(CASE WHEN RN = 3 THEN BdmBenStopDate END) AS DenDepBdmStopDate3
                        ,MAX(CASE WHEN RN = 4 THEN ConRelationship END) AS DenDepRelationship4
                        ,MAX(CASE WHEN RN = 4 THEN ConSystemId END) AS DenDepSystemId4
                        ,MAX(CASE WHEN RN = 4 THEN ConNameLast END) AS DenDepNameLast4
                        ,MAX(CASE WHEN RN = 4 THEN ConNameMiddle END) AS DenDepNameMiddle4
                        ,MAX(CASE WHEN RN = 4 THEN ConNameFirst END) AS DenDepNameFirst4
                        ,MAX(CASE WHEN RN = 4 THEN ConNameSuffix END) AS DenDepNameSuffix4
                        ,MAX(CASE WHEN RN = 4 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS DenDepNameSSN4
                        ,MAX(CASE WHEN RN = 4 THEN ConGender END) AS DenDepGender4
                        ,MAX(CASE WHEN RN = 4 THEN ConDateOFBirth END) AS DenDepDateOFBirth4
                        ,MAX(CASE WHEN RN = 4 THEN ConIsDisabled END) AS DenDepIsDisabled4
                        ,MAX(CASE WHEN RN = 4 THEN BdmBenStartDate END) AS DenDepBdmStartDate4
                        ,MAX(CASE WHEN RN = 4 THEN BdmBenStopDate END) AS DenDepBdmStopDate4
                        ,MAX(CASE WHEN RN = 5 THEN ConRelationship END) AS DenDepRelationship5
                        ,MAX(CASE WHEN RN = 5 THEN ConSystemId END) AS DenDepSystemId5
                        ,MAX(CASE WHEN RN = 5 THEN ConNameLast END) AS DenDepNameLast5
                        ,MAX(CASE WHEN RN = 5 THEN ConNameMiddle END) AS DenDepNameMiddle5
                        ,MAX(CASE WHEN RN = 5 THEN ConNameFirst END) AS DenDepNameFirst5
                        ,MAX(CASE WHEN RN = 5 THEN ConNameSuffix END) AS DenDepNameSuffix5    
                        ,MAX(CASE WHEN RN = 5 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS DenDepNameSSN5
                        ,MAX(CASE WHEN RN = 5 THEN ConGender END) AS DenDepGender5
                        ,MAX(CASE WHEN RN = 5 THEN ConDateOFBirth END) AS DenDepDateOFBirth5
                        ,MAX(CASE WHEN RN = 5 THEN ConIsDisabled END) AS DenDepIsDisabled5
                        ,MAX(CASE WHEN RN = 5 THEN BdmBenStartDate END) AS DenDepBdmStartDate5
                        ,MAX(CASE WHEN RN = 5 THEN BdmBenStopDate END) AS DenDepBdmStopDate5
                        ,MAX(CASE WHEN RN = 6 THEN ConRelationship END) AS DenDepRelationship6
                        ,MAX(CASE WHEN RN = 6 THEN ConSystemId END) AS DenDepSystemId6
                        ,MAX(CASE WHEN RN = 6 THEN ConNameLast END) AS DenDepNameLast6
                        ,MAX(CASE WHEN RN = 6 THEN ConNameMiddle END) AS DenDepNameMiddle6
                        ,MAX(CASE WHEN RN = 6 THEN ConNameFirst END) AS DenDepNameFirst6
                        ,MAX(CASE WHEN RN = 6 THEN ConNameSuffix END) AS DenDepNameSuffix6
                        ,MAX(CASE WHEN RN = 6 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS DenDepNameSSN6
                        ,MAX(CASE WHEN RN = 6 THEN ConGender END) AS DenDepGender6
                        ,MAX(CASE WHEN RN = 6 THEN ConDateOFBirth END) AS DenDepDateOFBirth6
                        ,MAX(CASE WHEN RN = 6 THEN ConIsDisabled END) AS DenDepIsDisabled6
                        ,MAX(CASE WHEN RN = 6 THEN BdmBenStartDate END) AS DenDepBdmStartDate6
                        ,MAX(CASE WHEN RN = 6 THEN BdmBenStopDate END) AS DenDepBdmStopDate6
                        ,MAX(CASE WHEN RN = 7 THEN ConRelationship END) AS DenDepRelationship7
                        ,MAX(CASE WHEN RN = 7 THEN ConSystemId END) AS DenDepSystemId7
                        ,MAX(CASE WHEN RN = 7 THEN ConNameLast END) AS DenDepNameLast7
                        ,MAX(CASE WHEN RN = 7 THEN ConNameMiddle END) AS DenDepNameMiddle7
                        ,MAX(CASE WHEN RN = 7 THEN ConNameFirst END) AS DenDepNameFirst7
                        ,MAX(CASE WHEN RN = 7 THEN ConNameSuffix END) AS DenDepNameSuffix7                        
                        ,MAX(CASE WHEN RN = 7 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS DenDepNameSSN7                        
                        ,MAX(CASE WHEN RN = 7 THEN ConGender END) AS DenDepGender7
                        ,MAX(CASE WHEN RN = 7 THEN ConDateOFBirth END) AS DenDepDateOFBirth7
                        ,MAX(CASE WHEN RN = 7 THEN ConIsDisabled END) AS DenDepIsDisabled7
                        ,MAX(CASE WHEN RN = 7 THEN BdmBenStartDate END) AS DenDepBdmStartDate7
                        ,MAX(CASE WHEN RN = 7 THEN BdmBenStopDate END) AS DenDepBdmStopDate7
                        ,MAX(CASE WHEN RN = 8 THEN ConRelationship END) AS DenDepRelationship8
                        ,MAX(CASE WHEN RN = 8 THEN ConSystemId END) AS DenDepSystemId8
                        ,MAX(CASE WHEN RN = 8 THEN ConNameLast END) AS DenDepNameLast8
                        ,MAX(CASE WHEN RN = 8 THEN ConNameMiddle END) AS DenDepNameMiddle8
                        ,MAX(CASE WHEN RN = 8 THEN ConNameFirst END) AS DenDepNameFirst8
                        ,MAX(CASE WHEN RN = 8 THEN ConNameSuffix END) AS DenDepNameSuffix8                       
                        ,MAX(CASE WHEN RN = 8 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS DenDepNameSSN8
                        ,MAX(CASE WHEN RN = 8 THEN ConGender END) AS DenDepGender8
                        ,MAX(CASE WHEN RN = 8 THEN ConDateOFBirth END) AS DenDepDateOFBirth8
                        ,MAX(CASE WHEN RN = 8 THEN ConIsDisabled END) AS DenDepIsDisabled8
                        ,MAX(CASE WHEN RN = 8 THEN BdmBenStartDate END) AS DenDepBdmStartDate8
                        ,MAX(CASE WHEN RN = 8 THEN BdmBenStopDate END) AS DenDepBdmStopDate8
                    FROM (
                            SELECT ConEEID, CASE WHEN ConGender = 'M' THEN 'S' WHEN ConGender = 'F' THEN 'D' END AS ConRelationship, ConSystemId, ConNameLast, ConNameMiddle, ConNameFirst, ConNameSuffix, ConSSN, ConGender, CASE WHEN ConIsDisabled = 'Y' THEN 'Y' END AS ConIsDisabled, ConDateOfBirth, BdmBenStartDate, BdmBenStopDate, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY CASE WHEN ConRelationship IN ('SPS','DP') THEN 1 ELSE 2 END) AS RN
                            FROM dbo.Contacts WITH (NOLOCK)    
                            JOIN dbo.U_dsi_BDM_EUNDENVISE WITH (NOLOCK)
                                ON ConEEID = BdmEEID
                                AND ConSystemId = BdmDepRecId
                                AND BdmDedCode = 'DEN'    
                            WHERE ConIsDependent = 'Y'                                
                                AND ConRelationship IN (/*'SPS','DP',*/'CHL','DAU','DCH','DPC','SON','STC')) AS X
                    GROUP BY ConEEID ) AS DenDeps
        ON DenDepEEID = xEEID
    LEFT JOIN (
                    SELECT ConEEID AS VisDepEEID
                        ,MAX(CASE WHEN RN = 1 THEN ConRelationship END) AS VisDepRelationship1
                        ,MAX(CASE WHEN RN = 1 THEN ConSystemId END) AS VisDepSystemId1
                        ,MAX(CASE WHEN RN = 1 THEN ConNameLast END) AS VisDepNameLast1
                        ,MAX(CASE WHEN RN = 1 THEN ConNameMiddle END) AS VisDepNameMiddle1
                        ,MAX(CASE WHEN RN = 1 THEN ConNameFirst END) AS VisDepNameFirst1
                        ,MAX(CASE WHEN RN = 1 THEN ConNameSuffix END) AS VisDepNameSuffix1
                        ,MAX(CASE WHEN RN = 1 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS VisDepNameSSN1
                        ,MAX(CASE WHEN RN = 1 THEN ConGender END) AS VisDepGender1
                        ,MAX(CASE WHEN RN = 1 THEN ConDateOFBirth END) AS VisDepDateOFBirth1
                        ,MAX(CASE WHEN RN = 1 THEN ConIsDisabled END) AS VisDepIsDisabled1
                        ,MAX(CASE WHEN RN = 1 THEN BdmBenStartDate END) AS VisDepBdmStartDate1
                        ,MAX(CASE WHEN RN = 1 THEN BdmBenStopDate END) AS VisDepBdmStopDate1
                        ,MAX(CASE WHEN RN = 2 THEN ConRelationship END) AS VisDepRelationship2
                        ,MAX(CASE WHEN RN = 2 THEN ConSystemId END) AS VisDepSystemId2
                        ,MAX(CASE WHEN RN = 2 THEN ConNameLast END) AS VisDepNameLast2
                        ,MAX(CASE WHEN RN = 2 THEN ConNameMiddle END) AS VisDepNameMiddle2
                        ,MAX(CASE WHEN RN = 2 THEN ConNameFirst END) AS VisDepNameFirst2
                        ,MAX(CASE WHEN RN = 2 THEN ConNameSuffix END) AS VisDepNameSuffix2
                        ,MAX(CASE WHEN RN = 2 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS VisDepNameSSN2
                        ,MAX(CASE WHEN RN = 2 THEN ConGender END) AS VisDepGender2
                        ,MAX(CASE WHEN RN = 2 THEN ConDateOFBirth END) AS VisDepDateOFBirth2
                        ,MAX(CASE WHEN RN = 2 THEN ConIsDisabled END) AS VisDepIsDisabled2
                        ,MAX(CASE WHEN RN = 2 THEN BdmBenStartDate END) AS VisDepBdmStartDate2
                        ,MAX(CASE WHEN RN = 2 THEN BdmBenStopDate END) AS VisDepBdmStopDate2
                        ,MAX(CASE WHEN RN = 3 THEN ConRelationship END) AS VisDepRelationship3
                        ,MAX(CASE WHEN RN = 3 THEN ConSystemId END) AS VisDepSystemId3
                        ,MAX(CASE WHEN RN = 3 THEN ConNameLast END) AS VisDepNameLast3
                        ,MAX(CASE WHEN RN = 3 THEN ConNameMiddle END) AS VisDepNameMiddle3
                        ,MAX(CASE WHEN RN = 3 THEN ConNameFirst END) AS VisDepNameFirst3
                        ,MAX(CASE WHEN RN = 3 THEN ConNameSuffix END) AS VisDepNameSuffix3
                        ,MAX(CASE WHEN RN = 3 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS VisDepNameSSN3
                        ,MAX(CASE WHEN RN = 3 THEN ConGender END) AS VisDepGender3
                        ,MAX(CASE WHEN RN = 3 THEN ConDateOFBirth END) AS VisDepDateOFBirth3
                        ,MAX(CASE WHEN RN = 3 THEN ConIsDisabled END) AS VisDepIsDisabled3
                        ,MAX(CASE WHEN RN = 3 THEN BdmBenStartDate END) AS VisDepBdmStartDate3
                        ,MAX(CASE WHEN RN = 3 THEN BdmBenStopDate END) AS VisDepBdmStopDate3
                        ,MAX(CASE WHEN RN = 4 THEN ConRelationship END) AS VisDepRelationship4
                        ,MAX(CASE WHEN RN = 4 THEN ConSystemId END) AS VisDepSystemId4
                        ,MAX(CASE WHEN RN = 4 THEN ConNameLast END) AS VisDepNameLast4
                        ,MAX(CASE WHEN RN = 4 THEN ConNameMiddle END) AS VisDepNameMiddle4
                        ,MAX(CASE WHEN RN = 4 THEN ConNameFirst END) AS VisDepNameFirst4
                        ,MAX(CASE WHEN RN = 4 THEN ConNameSuffix END) AS VisDepNameSuffix4
                        ,MAX(CASE WHEN RN = 4 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS VisDepNameSSN4
                        ,MAX(CASE WHEN RN = 4 THEN ConGender END) AS VisDepGender4
                        ,MAX(CASE WHEN RN = 4 THEN ConDateOFBirth END) AS VisDepDateOFBirth4
                        ,MAX(CASE WHEN RN = 4 THEN ConIsDisabled END) AS VisDepIsDisabled4
                        ,MAX(CASE WHEN RN = 4 THEN BdmBenStartDate END) AS VisDepBdmStartDate4
                        ,MAX(CASE WHEN RN = 4 THEN BdmBenStopDate END) AS VisDepBdmStopDate4
                        ,MAX(CASE WHEN RN = 5 THEN ConRelationship END) AS VisDepRelationship5
                        ,MAX(CASE WHEN RN = 5 THEN ConSystemId END) AS VisDepSystemId5
                        ,MAX(CASE WHEN RN = 5 THEN ConNameLast END) AS VisDepNameLast5
                        ,MAX(CASE WHEN RN = 5 THEN ConNameMiddle END) AS VisDepNameMiddle5
                        ,MAX(CASE WHEN RN = 5 THEN ConNameFirst END) AS VisDepNameFirst5
                        ,MAX(CASE WHEN RN = 5 THEN ConNameSuffix END) AS VisDepNameSuffix5                            
                        ,MAX(CASE WHEN RN = 5 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS VisDepNameSSN5
                        ,MAX(CASE WHEN RN = 5 THEN ConGender END) AS VisDepGender5
                        ,MAX(CASE WHEN RN = 5 THEN ConDateOFBirth END) AS VisDepDateOFBirth5
                        ,MAX(CASE WHEN RN = 5 THEN ConIsDisabled END) AS VisDepIsDisabled5
                        ,MAX(CASE WHEN RN = 5 THEN BdmBenStartDate END) AS VisDepBdmStartDate5
                        ,MAX(CASE WHEN RN = 5 THEN BdmBenStopDate END) AS VisDepBdmStopDate5
                        ,MAX(CASE WHEN RN = 6 THEN ConRelationship END) AS VisDepRelationship6
                        ,MAX(CASE WHEN RN = 6 THEN ConSystemId END) AS VisDepSystemId6
                        ,MAX(CASE WHEN RN = 6 THEN ConNameLast END) AS VisDepNameLast6
                        ,MAX(CASE WHEN RN = 6 THEN ConNameMiddle END) AS VisDepNameMiddle6
                        ,MAX(CASE WHEN RN = 6 THEN ConNameFirst END) AS VisDepNameFirst6
                        ,MAX(CASE WHEN RN = 6 THEN ConNameSuffix END) AS VisDepNameSuffix6
                        ,MAX(CASE WHEN RN = 6 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS VisDepNameSSN6
                        ,MAX(CASE WHEN RN = 6 THEN ConGender END) AS VisDepGender6
                        ,MAX(CASE WHEN RN = 6 THEN ConDateOFBirth END) AS VisDepDateOFBirth6
                        ,MAX(CASE WHEN RN = 6 THEN ConIsDisabled END) AS VisDepIsDisabled6
                        ,MAX(CASE WHEN RN = 6 THEN BdmBenStartDate END) AS VisDepBdmStartDate6
                        ,MAX(CASE WHEN RN = 6 THEN BdmBenStopDate END) AS VisDepBdmStopDate6
                        ,MAX(CASE WHEN RN = 7 THEN ConRelationship END) AS VisDepRelationship7
                        ,MAX(CASE WHEN RN = 7 THEN ConSystemId END) AS VisDepSystemId7
                        ,MAX(CASE WHEN RN = 7 THEN ConNameLast END) AS VisDepNameLast7
                        ,MAX(CASE WHEN RN = 7 THEN ConNameMiddle END) AS VisDepNameMiddle7
                        ,MAX(CASE WHEN RN = 7 THEN ConNameFirst END) AS VisDepNameFirst7
                        ,MAX(CASE WHEN RN = 7 THEN ConNameSuffix END) AS VisDepNameSuffix7
                        ,MAX(CASE WHEN RN = 7 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS VisDepNameSSN7
                        ,MAX(CASE WHEN RN = 7 THEN ConGender END) AS VisDepGender7
                        ,MAX(CASE WHEN RN = 7 THEN ConDateOFBirth END) AS VisDepDateOFBirth7
                        ,MAX(CASE WHEN RN = 7 THEN ConIsDisabled END) AS VisDepIsDisabled7
                        ,MAX(CASE WHEN RN = 7 THEN BdmBenStartDate END) AS VisDepBdmStartDate7
                        ,MAX(CASE WHEN RN = 7 THEN BdmBenStopDate END) AS VisDepBdmStopDate7
                        ,MAX(CASE WHEN RN = 8 THEN ConRelationship END) AS VisDepRelationship8
                        ,MAX(CASE WHEN RN = 8 THEN ConSystemId END) AS VisDepSystemId8
                        ,MAX(CASE WHEN RN = 8 THEN ConNameLast END) AS VisDepNameLast8
                        ,MAX(CASE WHEN RN = 8 THEN ConNameMiddle END) AS VisDepNameMiddle8
                        ,MAX(CASE WHEN RN = 8 THEN ConNameFirst END) AS VisDepNameFirst8
                        ,MAX(CASE WHEN RN = 8 THEN ConNameSuffix END) AS VisDepNameSuffix8
                        ,MAX(CASE WHEN RN = 8 AND ConSSN NOT IN ('000000000','999999999','123456789','12345678') AND LEFT(ConSSN, 3) NOT IN ('999','888') THEN ConSSN END ) AS VisDepNameSSN8
                        ,MAX(CASE WHEN RN = 8 THEN ConGender END) AS VisDepGender8
                        ,MAX(CASE WHEN RN = 8 THEN ConDateOFBirth END) AS VisDepDateOFBirth8
                        ,MAX(CASE WHEN RN = 8 THEN ConIsDisabled END) AS VisDepIsDisabled8
                        ,MAX(CASE WHEN RN = 8 THEN BdmBenStartDate END) AS VisDepBdmStartDate8
                        ,MAX(CASE WHEN RN = 8 THEN BdmBenStopDate END) AS VisDepBdmStopDate8
                    FROM (
                            SELECT ConEEID, CASE WHEN ConGender = 'M' THEN 'S' WHEN ConGender = 'F' THEN 'D' END AS ConRelationship, ConSystemId, ConNameLast, ConNameMiddle, ConNameFirst, ConNameSuffix, ConSSN, ConGender, CASE WHEN ConIsDisabled = 'Y' THEN 'Y' END AS ConIsDisabled, ConDateOfBirth, BdmBenStartDate, BdmBenStopDate, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY CASE WHEN ConRelationship IN ('SPS','DP') THEN 1 ELSE 2 END) AS RN
                            FROM dbo.Contacts WITH (NOLOCK)    
                            JOIN dbo.U_dsi_BDM_EUNDENVISE WITH (NOLOCK)
                                ON ConEEID = BdmEEID
                                AND ConSystemId = BdmDepRecId
                                AND BdmDedCode = 'VIS'    
                            WHERE ConIsDependent = 'Y'                                
                                AND ConRelationship IN (/*'SPS','DP',*/'CHL','DAU','DCH','DPC','SON','STC')) AS X
                    GROUP BY ConEEID
            ) AS VisDeps
        ON VisDepEEID = xEEID
    LEFT JOIN (
                    SELECT audEEID, audCOID, MAX(audReHire) AS audReHire, MAX(audTerm) AS audTerm, MAX(audSalaryChange) AS audSalaryChange 
                    FROM dbo.U_EUNDENVISE_Audit WITH (NOLOCK)
                    GROUP BY audEEID, audCOID ) AS Audit
        ON audEEID = xEEID
        AND audCOID = xCOID
    LEFT JOIN (
            SELECT EjhEEID AS XEjhEEID, EjhCOID AS XEjhCOID, EjhFullTimeOrPartTime AS XEjhFullTimeOrPartTime, EjhIntegrationEffDate AS XEjhIntegrationEffDate, EjhJobEffDate AS XEjhJobEffDate
            FROM (
                SELECT EjhEEID, EjhCOID, EjhFullTimeOrPartTime, EjhIntegrationEffDate, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhIntegrationEffDate DESC) AS RN
                FROM dbo.EmpHJob WITH (NOLOCK)
                WHERE EjhIntegrationEffDate <= @EndDate
                ) AS JH
            WHERE RN = 1 ) AS JHT
        ON XEjhEEID = xEEID
        AND XEjhCOID = xCOID
    ;


    UPDATE dbo.U_EUNDENVISE_drvTbl
    SET drvRecordCount = FORMAT((SELECT COUNT(*) FROM dbo.U_EUNDENVISE_drvTbl), '#0')
    WHERE drvSort IN (select TOP 1 drvSort from dbo.U_EUNDENVISE_drvTbl A Order By A.drvSort)

    UPDATE dbo.U_EUNDENVISE_drvTbl
    SET drvRecordCount = ''
    WHERE drvSort NOT IN (select TOP 1 drvSort from dbo.U_EUNDENVISE_drvTbl A Order By A.drvSort)


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
ALTER VIEW dbo.dsi_vwEUNDENVISE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNDENVISE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNDENVISE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202009271'
       ,expStartPerControl     = '202009271'
       ,expLastEndPerControl   = '202010049'
       ,expEndPerControl       = '202010049'
WHERE expFormatCode = 'EUNDENVISE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNDENVISE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNDENVISE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort