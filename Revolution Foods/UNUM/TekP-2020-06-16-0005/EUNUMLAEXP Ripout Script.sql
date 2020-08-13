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
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''T'')','EUNUMLAEXPZ0','50','H','01','2',NULL,'RecordCount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy"','1','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','1',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','2','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','2',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberID"','3','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','3',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOH"','4','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','4',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','5','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','5',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','6','(''DA''=''T,'')','EUNUMLAEXPZ0','50','D','10','6',NULL,'SALARY MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T,'')','EUNUMLAEXPZ0','50','D','10','7',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','8','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','8',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReason"','9','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','9',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNewMemberId"','10','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','10',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','11','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','11',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','12','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','12',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','13','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','13',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','14','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','14',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','15',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','16','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','16',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','17','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','17',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameFirst"','18','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','18',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameLast"','19','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','19',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDOB"','20','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','20',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClass"','21','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','21',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignatureDate"','22','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','22',NULL,'SIGNATURE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEfectiveDate"','23','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','23',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddType"','24','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','24',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID1"','25','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','25',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode1"','26','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','26',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate1"','27','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','27',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate1"','28','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','28',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt1"','29','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','29',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection1"','30','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','30',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID2"','31','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','31',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode2"','32','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','32',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate2"','33','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','33',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate2"','34','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','34',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt2"','35','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','35',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection2"','36','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','36',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID3"','37','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','37',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode3"','38','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','38',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate3"','39','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','39',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate3"','40','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','40',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt3"','41','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','41',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection3"','42','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','42',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID4"','43','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','43',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode4"','44','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','44',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate4"','45','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','45',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate4"','46','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','46',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt4"','47','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','47',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection4"','48','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','48',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID5"','49','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','49',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode5"','50','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','50',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate5"','51','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','51',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate5"','52','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','52',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt5"','53','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','53',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection5"','54','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','54',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitID6"','55','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','55',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode6"','56','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','56',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitQualDate6"','57','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','57',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitTermDate6"','58','(''UD101''=''T,'')','EUNUMLAEXPZ0','50','D','10','58',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelectionAmt6"','59','(''UA''=''T,'')','EUNUMLAEXPZ0','50','D','10','59',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSelection6"','60','(''UA''=''T'')','EUNUMLAEXPZ0','50','D','10','60',NULL,'BENEFIT SELECTION',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200804.txt',NULL,'','',NULL,NULL,NULL,NULL,'UNUM Life & ADD Export','202007309','EMPEXPORT','ONDEMAND',NULL,'EUNUMLAEXP',NULL,NULL,NULL,'202007309','Jul 30 2020  5:48PM','Jul 30 2020  5:48PM','202001011',NULL,'','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200804.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202007309','EMPEXPORT','TEST',NULL,'EUNUMLAEXP',NULL,NULL,NULL,'202007309','Jul 30 2020  5:48PM','Jul 30 2020  5:48PM','202001011',NULL,'','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200804.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202007309','EMPEXPORT','SCHEDULED',NULL,'EUNUMLAEXP',NULL,NULL,NULL,'202007309','Jul 30 2020  5:48PM','Jul 30 2020  5:48PM','202001011',NULL,'','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200804.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202007309','EMPEXPORT','OEACTIVE',NULL,'EUNUMLAEXP',NULL,NULL,NULL,'202007309','Jul 30 2020  5:48PM','Jul 30 2020  5:48PM','202001011',NULL,'','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMLAEXP_20200804.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202007309','EMPEXPORT','OEPASSIVE',NULL,'EUNUMLAEXP',NULL,NULL,NULL,'202007309','Jul 30 2020  5:48PM','Jul 30 2020  5:48PM','202001011',NULL,'','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EUNUMLAEXP_20200804.txt' END WHERE expFormatCode = 'EUNUMLAEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLAEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMLAEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EUNUMLAEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNUMLAEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EUNUMLAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMLAEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMLAEXP','H01','dbo.U_EUNUMLAEXP_Header',NULL);
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
    [drvSort] varchar(1) NOT NULL,
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
    [drvSpouseNameLast] varchar(100) NULL,
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
    [drvRecordCount] varchar(1) NOT NULL
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



    IF OBJECT_ID('U_EUNUMLAEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_AuditFields;
    CREATE TABLE dbo.U_EUNUMLAEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EUNUMLAEXP_AuditFields VALUES ('EmpComp','EecEecEmplStatus');


    --,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        --,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        --,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END


        IF OBJECT_ID('U_EUNUMLAEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_Audit;
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
    INTO dbo.U_EUNUMLAEXP_Audit
    FROM dbo.U_EUNUMLAEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EUNUMLAEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    DELETE FROM dbo.U_EUNUMLAEXP_Audit WHERE audRowNo > 1;

        CREATE CLUSTERED INDEX CDX_U_EUNUMLAEXP_Audit ON dbo.U_EUNUMLAEXP_Audit (/*audKey1Value, audKey2Value*/ audEEID, audKey2);


        

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
        ,drvSort = RD 
        -- standard fields above and additional driver fields below
        ,drvPolicy = CASE WHEN RD = 'A' THEN '143172' ELSE '143173' END
        ,drvDivision = CASE WHEN RD = 'A' THEN
                                CASE WHEN LTD1_DedCodeU IS NOT NULL THEN '0001'
                                    WHEN GLIF_DedCodeU IS NOT NULL THEN '0002'
                                    WHEN EXSTD_DedCodeU IS NOT NULL THEN '0003'
                                END
                        ELSE
                            CASE WHEN LIFEE_DedCodeU IS NOT NULL
                                    OR LIFEC_DedCodeU IS NOT NULL
                                    OR LIFES_DedCodeU IS NOT NULL
                                    OR ADDS_DedCodeU IS NOT NULL
                                    OR ADDC_DedCodeU IS NOT NULL
                                    OR ADDE_DedCodeU IS NOT NULL THEN '0001'                            
                            END
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
                                WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','203') THEN 'TE'
                            END
        ,drvNewMemberId = CASE WHEN ISNULL(EepOldSSN, '') <> '' THEN EepSSN END
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvGender =    CASE WHEN EepGender = 'M' OR ConGender = 'M' THEN 'M'
                            WHEN EepGender = 'F' OR ConGender = 'F' THEN 'F'
                            ELSE 'U'
                        END
        ,drvDOB = EepDateOfBirth
        ,drvEmailAddress =    CASE WHEN ISNULL(EepAddressEMail, '') <> '' THEN EepAddressEMail
                                ELSE EepAddressEmailAlternate
                            END
        ,drvSpouseNameFirst = CASE WHEN ConRelationship IN ('SPS','SP') THEN ConNameFirst END
        ,drvSpouseNameLast = CASE WHEN ConRelationship IN ('SPS','SP') THEN ConNameLast END
        ,drvSpouseDOB = CASE WHEN ConRelationship IN ('SPS','SP') THEN ConDateOfBirth END
        ,drvClass =    CASE WHEN RD = 'A' THEN
                        CASE WHEN LTD1_DedCode IS NOT NULL THEN '0001'
                            WHEN EXSTD_DedCode IS NOT NULL THEN '1000'
                            WHEN GLIF_DedCode IS NOT NULL THEN '0100'
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
        ,drvEfectiveDate =    CASE WHEN AudReHire = 'Y' THEN EecDateOfLastHire
                                WHEN AudTerm = 'Y' THEN EecDateOfTermination
                                WHEN AudSalaryChange = 'Y' THEN EjhJobEffDate
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
                ,CASE WHEN BdmDedCode IN ('GLIF','LTD1','EXSTD') THEN 'A' ELSE 'B' END AS RD
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
            GROUP BY BdmEEID, BdmCOID, BdmRecType, CASE WHEN BdmDedCode IN ('GLIF','LTD1','EXSTD') THEN 'A' ELSE 'B' END) AS Bdm_Grouped
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    JOIN (                
            SELECT BdmEEID AS BdmEEIDU, BdmCOID AS BdmCOIDU, BdmRecType AS BdmRecTypeU, BdmDepRecID AS BdmDepRecIDU
                --,CASE WHEN BdmDedCode IN ('GLIF','LTD1','EXSTD') THEN 'A' ELSE 'B' END AS RD
                ,MAX(CASE WHEN BdmDedCode = 'GLIF' THEN BdmDedCode END) AS GLIF_DedCodeU
                ,MAX(CASE WHEN BdmDedCode = 'LTD1' THEN BdmDedCode END) AS LTD1_DedCodeU
                ,MAX(CASE WHEN BdmDedCode = 'EXSTD' THEN BdmDedCode END) AS EXSTD_DedCodeU    
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS LIFEE_DedCodeU
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS LIFEC_DedCodeU
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS LIFES_DedCodeU
                ,MAX(CASE WHEN BdmDedCode = 'ADDS' THEN BdmDedCode END) AS ADDS_DedCodeU
                ,MAX(CASE WHEN BdmDedCode = 'ADDC' THEN BdmDedCode END) AS ADDC_DedCodeU
                ,MAX(CASE WHEN BdmDedCode = 'ADDE' THEN BdmDedCode END) AS ADDE_DedCodeU
                ,MAX(BdmBenStartDate) AS Max_BenStartDate
            FROM dbo.U_dsi_BDM_EUNUMLAEXP WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecID) AS Bdm_UnGrouped
        ON BdmEEIDU = xEEID
        AND BdmCOIDU = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecIDU
    LEFT JOIN dbo.U_EUNUMLAEXP_Audit WITH (NOLOCK)
        ON xEEID = audEEID
        AND audKey2 = xCOID
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


/*    JOIN dbo.U_dsi_BDM_EUNUMLAEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID */
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUNUMLAEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMLAEXP_Header;
    SELECT DISTINCT
         drvRecordCount = ''
    INTO dbo.U_EUNUMLAEXP_Header
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
ALTER VIEW dbo.dsi_vwEUNUMLAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMLAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMLAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001011'
       ,expStartPerControl     = '202001011'
       ,expLastEndPerControl   = '202007309'
       ,expEndPerControl       = '202007309'
WHERE expFormatCode = 'EUNUMLAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMLAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMLAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort