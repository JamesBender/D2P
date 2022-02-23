SET NOCOUNT ON;
IF OBJECT_ID('U_EVAN401KV2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EVAN401KV2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EVAN401KV2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEVAN401KV2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVAN401KV2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVAN401KV2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVAN401KV2];
GO
IF OBJECT_ID('U_EVAN401KV2_TOTAMTS') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_TOTAMTS];
GO
IF OBJECT_ID('U_EVAN401KV2_PLANDATES') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_PLANDATES];
GO
IF OBJECT_ID('U_EVAN401KV2_PDedHist2') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_PDedHist2];
GO
IF OBJECT_ID('U_EVAN401KV2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_PDedHist];
GO
IF OBJECT_ID('U_EVAN401KV2_File') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_File];
GO
IF OBJECT_ID('U_EVAN401KV2_EEMAST') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_EEMAST];
GO
IF OBJECT_ID('U_EVAN401KV2_EELIST2') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_EELIST2];
GO
IF OBJECT_ID('U_EVAN401KV2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_EEList];
GO
IF OBJECT_ID('U_EVAN401KV2_EEAMTS2') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_EEAMTS2];
GO
IF OBJECT_ID('U_EVAN401KV2_EEAMTS') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_EEAMTS];
GO
IF OBJECT_ID('U_EVAN401KV2_AUDIT') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_AUDIT];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EVAN401KV2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EVAN401KV2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EVAN401KV2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EVAN401KV2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EVAN401KV2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EVAN401KV2','VANGUARD SFF 401K EXPORT 2017 V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dsi_sp_SwitchBox_v2','800','S','N','EVAN401KV2Z0','N',NULL,'C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000000000"','1','(''DA''=''F'')','EVAN401KV2Z0','11','H','01','1',NULL,'Header Zeroes',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','2','(''DA''=''F'')','EVAN401KV2Z0','3','H','01','12',NULL,'Header Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SFF"','3','(''DA''=''F'')','EVAN401KV2Z0','8','H','01','15',NULL,'Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"091973"','4','(''DA''=''F'')','EVAN401KV2Z0','6','H','01','23',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GETDATE()"','5','(''UD112''=''F'')','EVAN401KV2Z0','8','H','01','29',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(CONVERT(CHAR,GETDATE(),108),'':'','''')"','6','(''UA''=''F'')','EVAN401KV2Z0','6','H','01','37',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','EVAN401KV2Z0','38','H','01','43',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"091973"','1','(''DA''=''F'')','EVAN401KV2Z0','6','D','02','1',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepSSN"','2','(''UA''=''F'')','EVAN401KV2Z0','9','D','02','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','3','(''DA''=''F'')','EVAN401KV2Z0','3','D','02','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EVAN401KV2Z0','22','D','02','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RTRIM(EepNameLast)+ '', ''+ ISNULL(NULLIF(RTRIM(EepNameSuffix),''Z'')+'' '','''')+RTRIM(EepNameFirst)+ISNULL(('' ''+SUBSTRING(nullif(EepNameMiddle,'' ''),1,1)+''.''),'''')"','5','(''UA''=''F'')','EVAN401KV2Z0','30','D','02','41',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','EVAN401KV2Z0','2','D','02','71',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepAddressLine1"','7','(''UA''=''F'')','EVAN401KV2Z0','30','D','02','73',NULL,'Address Line One',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepAddressLine2"','8','(''UA''=''F'')','EVAN401KV2Z0','30','D','02','103',NULL,'Address Line Two',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepAddressCity"','9','(''UA''=''F'')','EVAN401KV2Z0','18','D','02','133',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepAddressState"','10','(''UA''=''F'')','EVAN401KV2Z0','3','D','02','151',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepAddressZipcode"','11','(''UA''=''F'')','EVAN401KV2Z0','9','D','02','154',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EVAN401KV2Z0','1','D','02','163',NULL,'Foreign Address Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EecEmpno"','13','(''UA''=''F'')','EVAN401KV2Z0','13','D','02','164',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','EVAN401KV2Z0','4','D','02','177',NULL,'Location Code(4)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LocCode"','15','(''UA''=''F'')','EVAN401KV2Z0','10','D','02','181',NULL,'Location Code(10)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepDateOfBirth"','16','(''UD112''=''F'')','EVAN401KV2Z0','8','D','02','191',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EecDateOfOriginalHire"','17','(''UD112''=''F'')','EVAN401KV2Z0','8','D','02','199',NULL,'Employment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','207',NULL,'Plan Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLANENTRYDATE"','19','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','215',NULL,'Plan Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VESTINGDATE"','20','(''UD112''=''F'')','EVAN401KV2Z0','8','D','02','223',NULL,'Alternate Vesting Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','231',NULL,'Blank- For Vanguard use only',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EecDateofTermination"','22','(''UD112''=''F'')','EVAN401KV2Z0','8','D','02','239',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERMREASON"','23','(''UA''=''F'')','EVAN401KV2Z0','1','D','02','247',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERMKIT"','24','(''UA''=''F'')','EVAN401KV2Z0','1','D','02','248',NULL,'Send Kit Indicator (652)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN EecDateOfOriginalHire < EecDateOfLastHire THEN CONVERT(char(8),EecDateOfLastHire,112) ELSE '''' END"','25','(''UA''=''F'')','EVAN401KV2Z0','8','D','02','249',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''SS''=''F'')','EVAN401KV2Z0','4','D','02','257',NULL,'Vesting Override Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''F'')','EVAN401KV2Z0','1','D','02','261',NULL,'Vesting Override Percent Indic',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE EecPayPeriod WHEN ''M'' THEN ''4'' WHEN ''S'' THEN ''5'' WHEN ''B'' THEN ''6'' WHEN ''W'' THEN ''7'' END"','28','(''UA''=''F'')','EVAN401KV2Z0','2','D','02','262',NULL,'Payroll Freq. For Loan Amortiz',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''SS''=''F'')','EVAN401KV2Z0','2','D','02','264',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','266',NULL,'Blank- For Vanguard use only',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','274',NULL,'Blank- For Vanguard use only',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','282',NULL,'Blank- For Vanguard use only',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','290',NULL,'Blank- For Vanguard use only',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PayrollCodeOne"','34','(''UA''=''F'')','EVAN401KV2Z0','10','D','02','298',NULL,'Payroll Code One',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN EecUDField03 = ''P'' THEN ''NQP'' END"','35','(''UA''=''F'')','EVAN401KV2Z0','10','D','02','308',NULL,'Payroll Code Two',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''F'')','EVAN401KV2Z0','1','D','02','318',NULL,'Highly Compensated Flag (HCE)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EecDateOfLastHire"','37','(''UD112''=''F'')','EVAN401KV2Z0','8','D','02','319',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','327',NULL,'Blank- For Vanguard use only',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','335',NULL,'Blank- For Vanguard use only',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','343',NULL,'Blank- For Vanguard use only',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','351',NULL,'Spouse Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','42','(''DA''=''F'')','EVAN401KV2Z0','1','D','02','359',NULL,'Change Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','360',NULL,'Termination Kit Mail Date (772',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"5"','44','(''DA''=''F'')','EVAN401KV2Z0','1','D','02','368',NULL,'Termination Kit (656)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''SS''=''F'')','EVAN401KV2Z0','1','D','02','369',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''F'')','EVAN401KV2Z0','90','D','02','370',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''SS''=''F'')','EVAN401KV2Z0','3','D','02','460',NULL,'Data Element Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''F'')','EVAN401KV2Z0','30','D','02','463',NULL,'Data Element Number 1 Informat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''SS''=''F'')','EVAN401KV2Z0','3','D','02','493',NULL,'Data Element Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''F'')','EVAN401KV2Z0','30','D','02','496',NULL,'Data Element Number 2 Informat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''SS''=''F'')','EVAN401KV2Z0','5','D','02','526',NULL,'Prior Vested Years',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''SS''=''F'')','EVAN401KV2Z0','7','D','02','531',NULL,'Current Year Hours of Service',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''SS''=''F'')','EVAN401KV2Z0','1','D','02','538',NULL,'Break in Vesting Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''SS''=''F'')','EVAN401KV2Z0','1','D','02','539',NULL,'Calc Opt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''SS''=''F'')','EVAN401KV2Z0','1','D','02','540',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''SS''=''F'')','EVAN401KV2Z0','1','D','02','541',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','542',NULL,'Break in Service Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''SS''=''F'')','EVAN401KV2Z0','8','D','02','550',NULL,'Break in Service End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''SS''=''F'')','EVAN401KV2Z0','2','D','02','558',NULL,'Break in Service Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''SS''=''F'')','EVAN401KV2Z0','9','D','02','560',NULL,'Spousal SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN (EecEmplStatus=''L'' and EecLeaveReason IN (''MILIT'',''300'')) THEN ''M'' WHEN (EecEmplStatus= ''L'' and EecLeaveReason NOT IN (''MILIT'',''300'')) THEN ''O'' ELSE '''' END"','61','(''UA''=''F'')','EVAN401KV2Z0','1','D','02','569',NULL,'LOA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN EecEmplStatus=''L'' THEN CONVERT(char(8),EecEmplStatusStartDate,112) ELSE '''' END"','62','(''UA''=''F'')','EVAN401KV2Z0','8','D','02','570',NULL,'LOA Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RETURNFROMLEAVE"','63','(''UD112''=''F'')','EVAN401KV2Z0','8','D','02','578',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''SS''=''F'')','EVAN401KV2Z0','15','D','02','586',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"091973"','1','(''DA''=''F'')','EVAN401KV2Z0','6','D','03','1',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepSSN"','2','(''UA''=''F'')','EVAN401KV2Z0','9','D','03','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"B"','3','(''DA''=''F'')','EVAN401KV2Z0','3','D','03','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EVAN401KV2Z0','22','D','03','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENDDATE"','5','(''UD112''=''F'')','EVAN401KV2Z0','8','D','03','41',NULL,'Payroll End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STARTDATE"','6','(''UD112''=''F'')','EVAN401KV2Z0','8','D','03','49',NULL,'PRS Override Payroll End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','57',NULL,'Contribution Fund 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''AAA ''"','8','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','67',NULL,'Contribution Source 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_AAA,10,2),''.'','''') + ''+''"','9','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','71',NULL,'Contribution Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','81',NULL,'Contribution Fund 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''GGG ''"','11','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','91',NULL,'Contribution Source 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_GGG,10,2),''.'','''') + ''+''"','12','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','95',NULL,'Contribution Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','105',NULL,'Contribution Fund 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''DDD ''"','14','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','115',NULL,'Contribution Source 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_DDD,10,2),''.'','''') + ''+''"','15','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','119',NULL,'Contribution Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','129',NULL,'Contribution Fund 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''DDJ ''"','17','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','139',NULL,'Contribution Source 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_DDJ,10,2),''.'','''') + ''+''"','18','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','143',NULL,'Contribution Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','153',NULL,'Contribution Fund 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''DDE ''"','20','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','163',NULL,'Contribution Source 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_DDE,10,2),''.'','''') + ''+''"','21','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','167',NULL,'Contribution Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','177',NULL,'Contribution Fund 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''FFG ''"','23','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','187',NULL,'Contribution Source 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_FFG,10,2),''.'','''') + ''+''"','24','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','191',NULL,'Contribution Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','201',NULL,'Contribution Fund 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"''DDG ''"','26','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','211',NULL,'Contribution Source 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_DDG,10,2),''.'','''') + ''+''"','27','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','215',NULL,'Contribution Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','225',NULL,'Contribution Fund 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"''JJJ ''"','29','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','235',NULL,'Contribution Source 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_JJJ,10,2),''.'','''') + ''+''"','30','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','239',NULL,'Contribution Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','249',NULL,'Contribution Fund 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"''CCE ''"','32','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','259',NULL,'Contribution Source 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_CCE,10,2),''.'','''') + ''+''"','33','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','263',NULL,'Contribution Amount 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','273',NULL,'Contribution Fund, Source & Am',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"''FFJ ''"','35','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','283',NULL,'Contribution Source 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_LLL,10,2),''.'','''') + ''+''"','36','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','287',NULL,'Contribution Amount 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','297',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''NRB ''"','38','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','307',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_NRB,10,2),''.'','''') + ''+''"','39','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','311',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','321',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''NRC ''"','41','(''UA''=''F'')','EVAN401KV2Z0','4','D','03','331',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_NRC,10,2),''.'','''') + ''+''"','42','(''UA''=''F'')','EVAN401KV2Z0','10','D','03','335',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''F'')','EVAN401KV2Z0','10','D','03','345',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''SS''=''F'')','EVAN401KV2Z0','446','D','03','355',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"091973"','1','(''DA''=''F'')','EVAN401KV2Z0','6','D','04','1',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''F'')','EVAN401KV2Z0','9','D','04','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"C"','3','(''DA''=''F'')','EVAN401KV2Z0','3','D','04','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EVAN401KV2Z0','22','D','04','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''AAA ''"','5','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','41',NULL,'Contribution Source 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_AAA,10,2),''.'','''') + ''+''"','6','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','45',NULL,'Contribution Total Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''GGG ''"','7','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','55',NULL,'Contribution Source 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_GGG,10,2),''.'','''') + ''+''"','8','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','59',NULL,'Contribution Total Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''DDD ''"','9','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','69',NULL,'Contribution Source 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_DDD,10,2),''.'','''') + ''+''"','10','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','73',NULL,'Contribution Total Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''DDJ ''"','11','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','83',NULL,'Contribution Source 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_DDJ,10,2),''.'','''') + ''+''"','12','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','87',NULL,'Contribution Total Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''DDE ''"','13','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','97',NULL,'Contribution Source 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_DDE,10,2),''.'','''') + ''+''"','14','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','101',NULL,'Contribution Total Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ''FFG ''"','15','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','111',NULL,'Contribution Source 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_FFG,10,2),''.'','''') + ''+''"','16','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','115',NULL,'Contribution Total Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"''DDG ''"','17','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','125',NULL,'Contribution Source 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_DDG,10,2),''.'','''') + ''+''"','18','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','129',NULL,'Contribution Total Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"''JJJ ''"','19','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','139',NULL,'Contribution Source 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_JJJ,10,2),''.'','''') + ''+''"','20','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','143',NULL,'Contribution Total Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"''CCE ''"','21','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','153',NULL,'Contribution Source 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_CCE,10,2),''.'','''') + ''+''"','22','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','157',NULL,'Contribution Total Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"''NRB ''"','23','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','167',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_NRB,10,2),''.'','''') + ''+''"','24','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','171',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"''NRC ''"','25','(''UA''=''F'')','EVAN401KV2Z0','4','D','04','181',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(TOTAL_NRC,10,2),''.'','''') + ''+''"','26','(''UA''=''F'')','EVAN401KV2Z0','10','D','04','185',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''F'')','EVAN401KV2Z0','10','D','04','381',NULL,'Contribution Total Amount 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''SS''=''F'')','EVAN401KV2Z0','1','D','04','391',NULL,'Pretax Limit Override',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''SS''=''F'')','EVAN401KV2Z0','109','D','04','392',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"091973"','1','(''DA''=''F'')','EVAN401KV2Z0','6','D','05','1',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepSSN"','2','(''UA''=''F'')','EVAN401KV2Z0','9','D','05','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D"','3','(''DA''=''F'')','EVAN401KV2Z0','3','D','05','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EVAN401KV2Z0','22','D','05','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_001 IS NOT NULL THEN '' ''  + ''  ''  ELSE '''' END"','5','(''UA''=''F'')','EVAN401KV2Z0','3','D','05','41',NULL,'Loan Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_001 IS NOT NULL THEN SUBSTRING(PERCONTROL,1,8) ELSE '''' END"','6','(''UA''=''F'')','EVAN401KV2Z0','8','D','05','44',NULL,'Payroll End Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_001,10,2),''.'','''') + ''+''"','7','(''UA''=''F'')','EVAN401KV2Z0','10','D','05','52',NULL,'Payment Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_002 IS NOT NULL THEN ''   '' ELSE '''' END"','8','(''UA''=''F'')','EVAN401KV2Z0','3','D','05','62',NULL,'Loan Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_002 IS NOT NULL THEN SUBSTRING(PERCONTROL,1,8) ELSE '''' END"','9','(''UA''=''F'')','EVAN401KV2Z0','8','D','05','65',NULL,'Payroll End Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_002,10,2),''.'','''') + ''+''"','10','(''UA''=''F'')','EVAN401KV2Z0','10','D','05','73',NULL,'Payroll Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_003 IS NOT NULL THEN ''   '' ELSE '''' END"','11','(''UA''=''F'')','EVAN401KV2Z0','3','D','05','83',NULL,'Loan Number 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_003 IS NOT NULL THEN SUBSTRING(PERCONTROL,1,8) ELSE '''' END"','12','(''UA''=''F'')','EVAN401KV2Z0','8','D','05','86',NULL,'Payroll End Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_003,10,2),''.'','''') + ''+''"','13','(''UA''=''F'')','EVAN401KV2Z0','10','D','05','94',NULL,'Payroll Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_004 IS NOT NULL THEN ''   '' ELSE '''' END"','14','(''UA''=''F'')','EVAN401KV2Z0','3','D','05','104',NULL,'Loan Number 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_004 IS NOT NULL THEN SUBSTRING(PERCONTROL,1,8) ELSE '''' END"','15','(''UA''=''F'')','EVAN401KV2Z0','8','D','05','107',NULL,'Payroll End Date 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_004,10,2),''.'','''') + ''+''"','16','(''UA''=''F'')','EVAN401KV2Z0','10','D','05','115',NULL,'Payroll Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_005 IS NOT NULL THEN ''   '' ELSE '''' END"','17','(''UA''=''F'')','EVAN401KV2Z0','3','D','05','125',NULL,'Loan Number 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_005 IS NOT NULL THEN SUBSTRING(PERCONTROL,1,8) ELSE '''' END"','18','(''UA''=''F'')','EVAN401KV2Z0','8','D','05','128',NULL,'Payroll End Date 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_005,10,2),''.'','''') + ''+''"','19','(''UA''=''F'')','EVAN401KV2Z0','10','D','05','136',NULL,'Payroll Amount 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_006 IS NOT NULL THEN ''   '' ELSE '''' END"','20','(''UA''=''F'')','EVAN401KV2Z0','3','D','05','146',NULL,'Loan Number 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_006 IS NOT NULL THEN SUBSTRING(PERCONTROL,1,8) ELSE '''' END"','21','(''UA''=''F'')','EVAN401KV2Z0','8','D','05','149',NULL,'Payroll End Date 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_006,10,2),''.'','''') + ''+''"','22','(''UA''=''F'')','EVAN401KV2Z0','10','D','05','157',NULL,'Payroll Amount 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_007 IS NOT NULL THEN ''   '' ELSE '''' END"','23','(''UA''=''F'')','EVAN401KV2Z0','3','D','05','167',NULL,'Loan Number 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_007 IS NOT NULL THEN SUBSTRING(PERCONTROL,1,8) ELSE '''' END"','24','(''UA''=''F'')','EVAN401KV2Z0','8','D','05','170',NULL,'Payroll End Date 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_007,10,2),''.'','''') + ''+''"','25','(''UA''=''F'')','EVAN401KV2Z0','10','D','05','178',NULL,'Payroll Amount 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_008 IS NOT NULL THEN ''   '' ELSE '''' END"','26','(''UA''=''F'')','EVAN401KV2Z0','3','D','05','188',NULL,'Loan Number 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_008 IS NOT NULL THEN SUBSTRING(PERCONTROL,1,8) ELSE '''' END"','27','(''UA''=''F'')','EVAN401KV2Z0','8','D','05','191',NULL,'Payroll End Date 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_008,10,2),''.'','''') + ''+''"','28','(''UA''=''F'')','EVAN401KV2Z0','10','D','05','199',NULL,'Payroll Amount 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_009 IS NOT NULL THEN ''   '' ELSE '''' END"','29','(''UA''=''F'')','EVAN401KV2Z0','3','D','05','209',NULL,'Loan Number 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_009 IS NOT NULL THEN SUBSTRING(PERCONTROL,1,8) ELSE '''' END"','30','(''UA''=''F'')','EVAN401KV2Z0','8','D','05','212',NULL,'Payroll End Date 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_009,10,2),''.'','''') + ''+''"','31','(''UA''=''F'')','EVAN401KV2Z0','10','D','05','220',NULL,'Payroll Amount 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_010 IS NOT NULL THEN ''   '' ELSE '''' END"','32','(''UA''=''F'')','EVAN401KV2Z0','3','D','05','230',NULL,'Loan Number 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN SUM_010 IS NOT NULL THEN SUBSTRING(PERCONTROL,1,8) ELSE '''' END"','33','(''UA''=''F'')','EVAN401KV2Z0','8','D','05','233',NULL,'Payroll End Date 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_010,10,2),''.'','''') + ''+''"','34','(''UA''=''F'')','EVAN401KV2Z0','10','D','05','241',NULL,'Payroll Amount 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''F'')','EVAN401KV2Z0','3','D','05','251',NULL,'Loan Number 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''F'')','EVAN401KV2Z0','8','D','05','254',NULL,'Payroll End Date 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''F'')','EVAN401KV2Z0','10','D','05','262',NULL,'Payroll Amount 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''F'')','EVAN401KV2Z0','3','D','05','272',NULL,'Loan Number 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''F'')','EVAN401KV2Z0','8','D','05','275',NULL,'Payroll End Date 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''F'')','EVAN401KV2Z0','10','D','05','283',NULL,'Payment Amount 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''F'')','EVAN401KV2Z0','2','D','05','293',NULL,'Fund List 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''F'')','EVAN401KV2Z0','4','D','05','295',NULL,'Payroll Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''F'')','EVAN401KV2Z0','9','D','05','299',NULL,'Interest Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''SS''=''F'')','EVAN401KV2Z0','15','D','05','308',NULL,'Fund List Payroll Code Interes',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''SS''=''F'')','EVAN401KV2Z0','2','D','05','458',NULL,'Fund List 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''F'')','EVAN401KV2Z0','4','D','05','460',NULL,'Payroll Code 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''SS''=''F'')','EVAN401KV2Z0','9','D','05','464',NULL,'Interest Amount 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''F'')','EVAN401KV2Z0','88','D','05','473',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"091973"','1','(''DA''=''F'')','EVAN401KV2Z0','6','D','06','1',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepSSN"','2','(''UA''=''F'')','EVAN401KV2Z0','9','D','06','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"K"','3','(''DA''=''F'')','EVAN401KV2Z0','3','D','06','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EVAN401KV2Z0','22','D','06','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AA"','5','(''DA''=''F'')','EVAN401KV2Z0','4','D','06','41',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GCOM"','6','(''DA''=''F'')','EVAN401KV2Z0','4','D','06','45',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','7','(''DA''=''F'')','EVAN401KV2Z0','2','D','06','49',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LP"','8','(''DA''=''F'')','EVAN401KV2Z0','2','D','06','51',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PriorStartDate"','9','(''UA''=''F'')','EVAN401KV2Z0','8','D','06','53',NULL,'Payroll Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PriorEndDate"','10','(''UA''=''F'')','EVAN401KV2Z0','8','D','06','61',NULL,'Payroll End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(dbo.fn_padzero(SUM_PEHEECUR,14,2),''.'','''') + ''+''"','11','(''UA''=''F'')','EVAN401KV2Z0','14','D','06','69',NULL,'Compensation Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','EVAN401KV2Z0','17','D','06','83',NULL,'Compensation Units',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"091973"','1','(''DA''=''F'')','EVAN401KV2Z0','6','D','07','1',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EepSSN"','2','(''UA''=''F'')','EVAN401KV2Z0','9','D','07','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"X"','3','(''DA''=''F'')','EVAN401KV2Z0','3','D','07','16',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','EVAN401KV2Z0','22','D','07','19',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eepAddressEMail"','5','(''UA''=''F'')','EVAN401KV2Z0','140','D','07','41',NULL,'email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','EVAN401KV2Z0','140','D','07','181',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','EVAN401KV2Z0','140','D','07','321',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"99999999999"','1','(''DA''=''F'')','EVAN401KV2Z0','11','T','08','1',NULL,'Trailer 9''s',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRLR"','2','(''DA''=''F'')','EVAN401KV2Z0','4','T','08','12',NULL,'Trailer Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"091973"','3','(''DA''=''F'')','EVAN401KV2Z0','6','T','08','16',NULL,'Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GETDATE()"','4','(''UD112''=''F'')','EVAN401KV2Z0','8','T','08','22',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REPLACE(CONVERT(CHAR,GETDATE(),108),'':'','''')"','5','(''UA''=''F'')','EVAN401KV2Z0','6','T','08','30',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUM(CASE WHEN SUBSTRING(RECORDSET,1,1) = ''D'' THEN 1 ELSE 0 end)"','6','(''UN0''=''F'')','EVAN401KV2Z0','10','T','08','36',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('Vanguard01032020.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Export','201712319','EMPEXPORT','SCHEDULED','Jan  6 2020 12:00AM','EVAN401KV2',NULL,NULL,NULL,'201712319','Dec 31 2017 12:00AM','Dec 30 1899 12:00AM','201712241','11351','','','201712241',dbo.fn_GetTimedKey(),NULL,'ULTI_FSCORP',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('Vanguard08252021.txt',NULL,NULL,NULL,'OM1S6,F5634,OM288,6QYTP,QITD4,OM2Q9',NULL,NULL,NULL,'Test Export','202108251','EMPEXPORT','TEST','Aug 25 2021 10:24AM','EVAN401KV2',NULL,NULL,NULL,'202108251','Aug 25 2021 12:00AM','Dec 30 1899 12:00AM','202108251','2472','','','202108251',dbo.fn_GetTimedKey(),NULL,'us3cPeFED1002',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVAN401KV2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVAN401KV2','ExportPath','V','\\us.saas\n1\Public\10237\Exports\Vanguard\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVAN401KV2','InitialSort','C','eepSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVAN401KV2','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVAN401KV2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVAN401KV2','TestPath','V','\\us.saas\n1\Public\10237\Exports\Vanguard\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVAN401KV2','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_EVAN401KV2_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_EVAN401KV2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVAN401KV2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVAN401KV2','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVAN401KV2','D02','U_EVAN401KV2_EEMAST JOIN EmpPers WITH (NOLOCK) ON eepeeid = eeid JOIN EmpComp WITH (NOLOCK) ON eeceeid = eeid and eeccoid = coid',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVAN401KV2','D03','U_EVAN401KV2_EEAMTS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVAN401KV2','D04','U_EVAN401KV2_TOTAMTS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVAN401KV2','D05','U_EVAN401KV2_EEAMTS2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVAN401KV2','D06','U_EVAN401KV2_EEAMTS',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVAN401KV2','D07','U_EVAN401KV2_EEMAST JOIN EmpPers WITH (NOLOCK) ON eepeeid = eeid AND eepAddressEMail IS NOT NULL AND eepAddressEmail > '' ''',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVAN401KV2','T08','U_EVAN401KV2_FILE',NULL);
IF OBJECT_ID('U_EVAN401KV2_AUDIT') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_AUDIT] (
    [aEEID] varchar(255) NULL,
    [aCOID] varchar(255) NOT NULL,
    [ChangeDate] datetime NULL,
    [RETURNFROMLEAVE] datetime NULL
);
IF OBJECT_ID('U_EVAN401KV2_EEAMTS') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_EEAMTS] (
    [pEEID] char(12) NOT NULL,
    [eepSSN] char(11) NULL,
    [StartDate] datetime NULL,
    [EndDate] datetime NULL,
    [PriorStartDate] varchar(8) NULL,
    [PriorEndDate] varchar(8) NULL,
    [GenNumber] char(12) NOT NULL,
    [PerControl] char(9) NOT NULL,
    [SUM_AAA] money NULL,
    [SUM_GGG] money NULL,
    [SUM_DDJ] money NULL,
    [SUM_DDD] money NULL,
    [SUM_DDE] money NULL,
    [SUM_DDG] money NULL,
    [SUM_111] money NULL,
    [SUM_FFF] money NULL,
    [SUM_JJJ] money NULL,
    [SUM_FFG] money NULL,
    [SUM_KKK] money NULL,
    [SUM_LLL] money NULL,
    [SUM_CCE] money NULL,
    [SUM_NRB] money NULL,
    [SUM_NRC] money NULL,
    [SUM_PEHEECUR] money NULL
);
IF OBJECT_ID('U_EVAN401KV2_EEAMTS2') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_EEAMTS2] (
    [pEEID] char(12) NOT NULL,
    [eepSSN] char(11) NULL,
    [StartDate] datetime NULL,
    [EndDate] datetime NULL,
    [GenNumber] varchar(1) NOT NULL,
    [PerControl] char(9) NOT NULL,
    [SUM_001] money NULL,
    [SUM_002] money NULL,
    [SUM_003] money NULL,
    [SUM_004] money NULL,
    [SUM_005] money NULL,
    [SUM_006] money NULL,
    [SUM_007] money NULL,
    [SUM_008] money NULL,
    [SUM_009] money NULL,
    [SUM_010] money NULL,
    [DedCode] varchar(5) NULL
);
IF OBJECT_ID('U_EVAN401KV2_EEList') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EVAN401KV2_EELIST2') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_EELIST2] (
    [VEEID] char(12) NOT NULL,
    [VCOID] char(5) NOT NULL,
    [VCOCode] char(5) NULL,
    [LocCode] int NULL,
    [AltVestingDate] datetime NULL,
    [EESTATUS] char(1) NULL,
    [TermReason] varchar(1) NOT NULL,
    [TERMKIT] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EVAN401KV2_EEMAST') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_EEMAST] (
    [EEID] char(12) NOT NULL,
    [COID] char(5) NOT NULL,
    [COCODE] char(5) NULL,
    [LocCode] varchar(25) NULL,
    [PayrollCodeOne] varchar(3) NULL,
    [RETURNFROMLEAVE] datetime NULL,
    [PLANENTRYDATE] datetime NULL,
    [VESTINGDATE] datetime NULL,
    [TERMREASON] varchar(1) NOT NULL,
    [TERMKIT] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EVAN401KV2_File') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(800) NULL
);
IF OBJECT_ID('U_EVAN401KV2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_PDedHist] (
    [PrgEEID] char(12) NOT NULL,
    [PrgPeriodStartDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
    [PrgPerControl] char(9) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhEECurAmt] money NULL
);
IF OBJECT_ID('U_EVAN401KV2_PDedHist2') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_PDedHist2] (
    [PrgEEID] char(12) NOT NULL,
    [PrgPeriodStartDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
    [pdhgennumber] char(12) NOT NULL,
    [PrgPerControl] char(9) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL
);
IF OBJECT_ID('U_EVAN401KV2_PLANDATES') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_PLANDATES] (
    [PEEID] char(12) NOT NULL,
    [PlanEntryDate] datetime NULL,
    [VestingDate] datetime NULL
);
IF OBJECT_ID('U_EVAN401KV2_TOTAMTS') IS NULL
CREATE TABLE [dbo].[U_EVAN401KV2_TOTAMTS] (
    [TOTAL_AAA] money NULL,
    [TOTAL_GGG] money NULL,
    [TOTAL_DDD] money NULL,
    [TOTAL_DDE] money NULL,
    [TOTAL_DDG] money NULL,
    [TOTAL_111] money NULL,
    [TOTAL_DDJ] money NULL,
    [TOTAL_FFF] money NULL,
    [TOTAL_JJJ] money NULL,
    [TOTAL_FFG] money NULL,
    [TOTAL_CCE] money NULL,
    [TOTAL_KKK] money NULL,
    [TOTAL_NRB] money NULL,
    [TOTAL_NRC] money NULL,
    [eepssn] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVAN401KV2]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
    @SystemID VARCHAR (12)
AS
/************************************************************
Client: Federal Signal Corporation

Created By: NJR
Create Date: 06.01.2006

Purpose: Vanguard SFF 401K Export 2009

Revision History
-----------------
Update By        Date            CP Num                Desc            
NJR                06.14.2006                            TO ELIMINATE NULL LOAN VALUES FROM FILE
NJR                07.03.2006                            ADDED JJJ RECORD FOR 401CU DEDCODE (REMOVED 401CU FROM EEE)
NJR                07.21.2006                            MULTIPLE MODIFICATIONS
NJR                07.25.2006                            REMOVED D4KER (111 Group) FROM CONTRIBUTION RECORDSET
NJR                10.18.2006                            MODIFIED TO REMOVE NEG AMOUNT
JDK                12.27.2007                            MODIFIED TO INCLUDE TERMS 7 DAYS PRIOR TO START DATE
BBukiri            03.15.2014                            Modified loccode logc and payrollcodeone logic
Tanya Leonce       09.24.2014       SR-2014-00053459     *** TESTING - Utilizing TEST Session *** Update Deduction Code for Loans (Start With LN4)
Tanya Leonce       10.02.2014       SR-2014-00053459     *** TESTING - Utilizing TEST Session *** Correction to Pulling Vesting Dates
Tanya Leonce       10.09.2014       SR-2014-00053459     *** TESTING - Utilizing TEST Session *** Update Detail SetNo '05' - "Loan Number 1" (Pos# 41 - 43)
Tanya Leonce       12.04.2014       SR-2014-00053459     Migrated Changes to Production
Margaret Dresher   12.27.2017       SR-2017-00168987     Added New Codes CRC1 RPTSER
Jose Sotolongo       05.07.2018        SF 11417461             Changing inner join on EEList to include original list and not derived list. Conditions should be based only on payroll date data.
D.Agyei               11.27.2019       SR-2019-00255370     Added new Roth codes
D.Agyei               06.22.2020       SR-2020-00280561     Added dedgroupcode PWE

SELECT * FROM U_Dsi_Configuration WHERE FormatCode = 'EVAN401KV2'
SELECT * FROM U_Dsi_SqlClauses WHERE FormatCode = 'EVAN401KV2'
SELECT * FROM U_DSI_InterfaceActivityLog WHERE FormatCode = 'EVAN401KV2' ORDER BY DateTimeStamp DESC
SELECT * FROM dbo.U_Dsi_RecordSetDetails WHERE FormatCode = 'EVAN401KV2' ORDER BY 1, 2, SUBSTRING(SetNo,2,1), SUBSTRING(SetNo,1,1)
SELECT * FROM dbo.U_Dsi_Parameters WHERE FormatCode = 'EVAN401KV2'
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = 'EVAN401KV2'
Exec dbo._dsi_usp_ExportRipOut  'EVAN401KV2'
'EVAN401K09'
dsi_sp_testswitchbox_v2 'EVAN401KV2', 'ONDEMAND'
dsi_sp_testswitchbox_v2 'EVAN401KV2', 'TEST'
dsi_sp_testswitchbox_v2 'EVAN401KV2', 'SCHEDULED'

SELECT * FROM U_DSI_InterfaceActivityLog 
WHERE FormatCode = 'EVAN401KV2' 

ORDER BY DateTimeStamp DESC
select distinct (eecpaygroup) from empcomp

  SELECT * FROM  U_EVAN401KV2_EEMAST 
 SELECT * FROM U_EVAN401KV2_EEAMTS2   U_EVAN401KV2_EEAMTS 
 select * from ascexp where expformatcode like 'EVAN401%'

-- Updating Period Control Dates
UPDATE AscExp
SET expCOIDList = 'OM2CX,OM2BQ,OM2RX,OM1S6,OM2PG,OM2JU,OM1N3,OM2OA,OM288,OM2M7,OM29Z,OM28J,OM2LK,OM267,9NIOW,Q3SLM,6ZPEX,OM2Q9,7RZG6,OM2GD',
UPDATE AscExp set 
ExpStartPerControl     = '2017' + '12' + '241',
ExpLastStartPerControl = '2017' + '12' + '241',
--ExpEndPerControl       = '2017' + '01' + '011',
--ExpLastEndPerControl   = '2017' + '01' + '011'
ExpEndPerControl       = CONVERT(VARCHAR(8), GETDATE()+3, 112) + '9',
ExpLastEndPerControl   = CONVERT(VARCHAR(8), GETDATE()+3, 112) + '9'
WHERE ExpFormatCode    = 'EVAN401KV2'
AND ExpExportCode    = 'TEST' 
 VANGUARD SFF 401K EXPORT 2007 
 -----  AND SystemID = @SystemID
--   --Update Dates
--UPDATE U_dsi_Parameters SET StartPerControl = '201712101', ENDPERCONTROL = '201712159' WHERE ExportCode ='EVAN401KV2'
----update ascexp
--    set explaststartpercontrol='201407011'
--        , explastendpercontrol='201411309'
--where EXPformatcode ='ESTANDARD' and expexportcode ='ONDEMAND'
 *     FROM dbo.U_Dsi_Parameters  WHERE FormatCode = 'EVAN401KV2';

 select * from ascexp where expformatcode = 'EVAN401KV2'
********************************************************************/
BEGIN
/**********************
CLEAN-UP AND PREP
**********************/

    EXEC ('IF EXISTS (SELECT * FROM sysobjects WHERE name = ''U_EVAN401KV2_EELIST2'' AND type = ''U'')
           DROP TABLE dbo.U_EVAN401KV2_EELIST2');
    EXEC ('IF EXISTS (SELECT * FROM sysobjects WHERE name = ''U_EVAN401KV2_PLANDATES'' AND type = ''U'')
           DROP TABLE dbo.U_EVAN401KV2_PLANDATES');
    EXEC ('IF EXISTS (SELECT * FROM sysobjects WHERE name = ''U_EVAN401KV2_EEMAST'' AND type = ''U'')
           DROP TABLE dbo.U_EVAN401KV2_EEMAST');
    EXEC ('IF EXISTS (SELECT * FROM sysobjects WHERE name = ''U_EVAN401KV2_EEAMTS'' AND type = ''U'')
           DROP TABLE dbo.U_EVAN401KV2_EEAMTS');
    EXEC ('IF EXISTS (SELECT * FROM sysobjects WHERE name = ''U_EVAN401KV2_EEAMTS2'' AND type = ''U'')
           DROP TABLE dbo.U_EVAN401KV2_EEAMTS2');
    EXEC ('IF EXISTS (SELECT * FROM sysobjects WHERE name = ''U_EVAN401KV2_TOTAMTS'' AND type = ''U'')
           DROP TABLE dbo.U_EVAN401KV2_TOTAMTS');
    EXEC ('IF EXISTS (SELECT * FROM sysobjects WHERE name = ''U_EVAN401KV2_AUDIT'' AND type = ''U'')
           DROP TABLE dbo.U_EVAN401KV2_AUDIT');

    /******************************************************
    COLLECT DATE PARAMETERS
    ******************************************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @ExportCode VARCHAR(12),
        @start varchar(9),
        @end varchar(9),
        @PriorStartDate varchar(8),
        @PriorEndDate VARCHAR(8),
        @YearPerControl DATETIME,
        @Year DATETIME,
        @PRIORYEAR VARCHAR(4)
    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8)),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl, 8)),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @ExportCode = ExportCode,
        @YearPerControl =   DATEADD(year, -1, LEFT(EndPerControl,8)),
        @Year =   DATEADD(year, -1, LEFT(EndPerControl,4)),
        @PRIORYEAR =  LEFT(CONVERT(DATE,DATEADD(year, -1,LEFT(StartPerControl,8)),101),4),

        @PriorStartDate = convert(VARCHAR(4),@PRIORYEAR) + '0101',
        @PriorEndDate = convert(VARCHAR(4),@PRIORYEAR) + '1231',
        @start = StartPerControl,
        @end = EndPerControl
    FROM dbo.U_Dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EVAN401KV2';

--GETTING TERMS THAT WERE ENTERED DURING THE RANGE
    SELECT aEEID = audkey1value,
     aCOID = audkey2value,
     ChangeDate = CASE WHEN audnewvalue = 'T' then audDateTime Else '' end,
     RETURNFROMLEAVE =  CASE WHEN audoldvalue = 'L' then auddatetime else NULL end
    INTO dbo.U_EVAN401KV2_AUDIT
    FROM dbo.U_EVAN401KV2_EEList WITH (NOLOCK)
    JOIN dbo.vw_auditEEdata  WITH (NOLOCK)
        ON audkey1value = xeeid
        AND audkey2value = xcoid
        AND audtablename = 'empcomp'
        AND audfieldname = 'eecemplstatus'
        AND (audnewvalue = 'T' OR (audnewvalue = 'A' and audoldvalue = 'L'))
        AND dateadd (day,datediff(day,0,audDateTime),0) BETWEEN (@startDate -7) AND @endDate
        ;

/************************************************
RECTYPE A DRIVER TABLES
************************************************/

--CREATING INITIAL SET
SELECT DISTINCT VEEID = eeceeid, 
    VCOID = eeccoid,
    VCOCode = cmpCompanyCode,
  LocCode = NULL, --ADDED FOR 2007 EXPORT.
    AltVestingDate = eecudfield06,
    EESTATUS = EECEMPLSTATUS,
    TermReason = CASE WHEN eecemplstatus = 'T' AND eectermreason IN ('100','101','102','103','104','ABANDN','CNTRCT','DISSAT','MONEY','MUTUAL','NOSHOW','NWJBC','NWJBNC','PERS','RELO','SCHOOL','SHIFT','SUPERV','Z') THEN '0' 

             WHEN eecemplstatus = 'T' AND eectermreason IN ('200','201','204','206','207','ATTEND','CONDCT','DISC2','DISCHR','FALSE','FRLOA','INSUB','INTPSK', 'VIOLPL','MSUSEP','MSUSET','PERF','PERFS','NOLTD','SAFVIO') THEN '1' 
             WHEN eecemplstatus = 'T' AND eectermreason IN ('ELIM','LYOFFP','LYOFFT','SEVEXC','SEVGEN','SEVMSC','TROFWK') THEN '2' 
             WHEN eecemplstatus = 'T' AND eectermreason IN ('SHTDWN','MED','NEXTLV','WC','FAMILY','HOME','MILIT') THEN '3' 
             WHEN eecemplstatus = 'T' AND eectermreason = '202' THEN '4' 
             WHEN eecemplstatus = 'T' AND eectermreason IN ('LTD','DISABY') THEN '5' 
             WHEN eecemplstatus = 'T' AND eectermreason = '203' THEN '6' 
             ELSE '' END,
    TERMKIT = CASE WHEN eecemplstatus = 'T' AND eecTermReason IN ('100','101','102','103','104','200','201','204','206','207','ABANDN', 'CNTRCT', 'DISSAT','MONEY','MUTUAL','NOSHOW','NWJBC','NWJBNC',
                                   'PERS','RELO','SCHOOL','SHIFT','SUPERV' ,'Z','ATTEND','CONDCT','FALSE','INSUB','FRLOA',
                                   'INTPSK','MSUSEP','MSUSET','PERF','PERFS','SHTDWN','VIOLPL','WC','MILIT','NOLTD','DISABY','DISC2','DISCHR','RESIGN','SAFVIO',
                                   'SEVEXC','SEVGEN','SEVMSC','SOLD','TROFWK', 
                                   'ELIM','LYOFFP','LYOFFT','202','LTD','MED','NEXTLV','FAMILY','HOME') THEN '2'
                   WHEN eecemplstatus = 'T' AND eecTermReason NOT IN ('100','101','102','103','104','200','201','204','206','207','ABANDN', 'CNTRCT', 'DISSAT','MONEY','MUTUAL','NOSHOW','NWJBC','NWJBNC',
                                   'PERS','RELO','SCHOOL','SHIFT','SUPERV' ,'Z','ATTEND','CONDCT','FALSE','INSUB','FRLOA',
                                   'INTPSK','MSUSEP','MSUSET','PERF','PERFS','SHTDWN','VIOLPL','WC','MILIT','NOLTD','DISABY','DISC2','DISCHR','RESIGN','SAFVIO',
                                   'SEVEXC','SEVGEN','SEVMSC','SOLD','TROFWK', 
                                   'ELIM','LYOFFP','LYOFFT','202','LTD','MED','NEXTLV','FAMILY','HOME') THEN '0'
           ELSE '' END
   INTO dbo.U_EVAN401KV2_EELIST2
    FROM dbo.EmpComp WITH (NOLOCK)
    JOIN dbo.U_EVAN401KV2_EEList WITH (NOLOCK) ON eeceeid = xeeid and eeccoid = xcoid
    JOIN dbo.EmpPers WITH (NOLOCK) ON EecEEID = EepEEID
    JOIN dbo.Company WITH (NOLOCK) ON cmpCoid = eecCOID
    WHERE eecemplstatus <> 'T' OR (EecEmplStatus = 'T' AND (EecTermReason NOT IN ('TMMPER','TEMP','ERROR','FIXSRV','TRO', 'SCHOOL')));

    --FILTERING OUT UNWANTED RECORDS

--SELECT * FROM dbo.vw_auditEEdata where audkey1value in ( 'APFBCH0000K0' ,'BOFZTM0000K0')order by auddatetime desc 

DELETE dbo.U_EVAN401KV2_EELIST2
FROM dbo.EmpComp WITH (NOLOCK)
WHERE eeceeid = veeid
 AND eeccoid = vcoid
 AND EESTATUS = 'T'
 AND NOT EXISTS (SELECT 1 FROM dbo.U_EVAN401KV2_AUDIT WITH (NOLOCK) 
          WHERE AEEID = VEEID AND ACOID = VCOID)

DELETE U_EVAN401KV2_EELIST2
 FROM dbo.EmpComp WITH (NOLOCK)
  WHERE 
  eeceeid = VEEID 
   AND eeccoid = VCOID
   AND eecDedGroupCode IN ('NONE', 'PLUH','NOBEN', 'LCHS', 'PENS', 'NOBENEFIT', 'NOBEN')
   AND VCOCode = 'PLUHN'
--   --'6EMU8P0000K0'
DELETE U_EVAN401KV2_EELIST2
 FROM dbo.EmpComp WITH (NOLOCK)
  WHERE 
  eeceeid = VEEID 
   AND eeccoid = VCOID
   AND eecDedGroupCode IN ('NONE', 'PLUH','NOBEN', 'LCHS', 'PENS', 'NOBENEFIT', 'NOBEN')
   AND eeceetype like 'INT%'

DELETE U_EVAN401KV2_EELIST2
 FROM dbo.EmpComp WITH (NOLOCK)
  WHERE eeceeid = VEEID 
   AND eeccoid = VCOID
   AND eecDedGroupCode = 'NONE'
   AND VCOCode IN ('CLPDC','CORP','DAYTN','ELGIN','EONE','FAPD','GUZLR','JTSTM','LCHUS','MTC','OTM','PCS','VACTR','VICTR','SIGNL')

  --SELECT 'U_EVAN401KV2_EELIST2',count(*) FROM  U_EVAN401KV2_EELIST2 -- 10sec

--GETTING EARLIEST START/VESTING DATES
 IF OBJECT_ID('U_EVAN401KV2_PLANDATES') IS NOT NULL
        DROP TABLE dbo.U_EVAN401KV2_PLANDATES; 

SELECT DISTINCT PEEID = VEEID,
    PlanEntryDate = min(eedbenstartdate),
    VestingDate = COALESCE(AltVestingDate,MIN(eedeeeligdate))
INTO dbo.U_EVAN401KV2_PLANDATES
 FROM dbo.U_EVAN401KV2_EELIST2 with (nolock)
 JOIN dbo.EmpDed as edd1 WITH (NOLOCK) on Veeid = eedeeid
 JOIN dbo.EmpPers WITH (NOLOCK) ON EedEEID = EepEEID
    WHERE ((edd1.eeddedcode IN ('4KPM','4KPMA','C4KP','D4KP2','D4KP3','D4KP8','E4KPM','M4KPM',
                              'P4KPM','T4KPM','4KPUC','4KPUM','4KPUB','4KATA','4KATB','4KATC',
                              '4KATD','4KERA','E4ER1','F4KER','P4KPM','D4ER2','D4KER','E4KER',
                              'L4KER','M4KER','RKER','401CU','E4KPS','NRB','NRBU','NRC')) --DA added 'NRB','NRBU','NRC'
            OR (LEFT(LTRIM(edd1.EedDedCode),3) = 'LN4')    -- 12/04/2014, TL - Converted to pull all loans starting 'LN4'
    )
    AND EXISTS(SELECT 1 FROM dbo.EmpDed as edd2 WITH (NOLOCK) 
                    WHERE edd1.eedeeid = edd2.eedeeid
                    AND edd1.eeddedcode = edd2.eeddedcode
                    AND edd1.eedcoid = edd2.eedcoid
                GROUP BY edd2.eedEEID,edd2.eedcoid,edd2.eeddedcode,edd2.eedbenstartdate
                HAVING RIGHT(MIN(CONVERT(CHAR(8),edd2.eedbenstartdate,112) + edd2.eedSystemID),12) = edd1.eedSystemID) 
    GROUP BY VEEID,AltVestingDate
    ORDER BY 1
--BUILDING DRIVER TABLE FOR SET A
    IF OBJECT_ID('U_EVAN401KV2_EEMAST') IS NOT NULL
        DROP TABLE dbo.U_EVAN401KV2_EEMAST; 

  SELECT EEID = VEEID,
    COID = VCOID,
    COCODE = VCOCODE,
    LocCode = CONVERT(VARCHAR(25), NULL),
    PayrollCodeOne = CONVERT(VARCHAR(3), NULL),
    RETURNFROMLEAVE,
    PLANENTRYDATE,
    VESTINGDATE,
    TERMREASON,
    TERMKIT
  INTO dbo.U_EVAN401KV2_EEMAST
  FROM dbo.U_EVAN401KV2_EELIST2  with (nolock)
  LEFT JOIN dbo.U_EVAN401KV2_PLANDATES  with (nolock) on peeid = veeid
  LEFT JOIN dbo.U_EVAN401KV2_AUDIT with (nolock) on aeeid = veeid

 --SELECT 'U_EVAN401KV2_EEMAST', * FROM  dbo.U_EVAN401KV2_EEMAST where returnfromleave is not NULL
 --print @startpercontrol --quick

    --update LocCode for recordset D2 record 15
    --update PayrollCodeOne for recordset D2 record 34   
    --BBukiri 3/15/2014 updated LocCode and payrollcodeone  
    --select cmpcompanycode, cmpcompanyname, eecdedgroupcode, eeclocation from empcomp join company on cmpcoid = eeccoid where cmpcompanycode = 'MRL'
    --select * from U_EVAN401KV2_EEMAST
   UPDATE dbo.U_EVAN401KV2_EEMAST
    SET VESTINGDATE = eecdateofseniority,

        LocCode = CASE 
                 WHEN eecdedgroupcode =    'CORP'  THEN 'CORPORATE'
                 WHEN EecDedGroupCode =    'CORPH' then 'CORPORATE' 
                 WHEN eecdedgroupcode =    'ELGH'  THEN 'ELGIN' 
                 WHEN eecdedgroupcode =    'ELGS'  THEN 'ELGIN'
                 WHEN EecDedGroupCode =    'IAM' then 'SIG UNION'
                 WHEN EecDedGroupCode =    'IBEW' then 'IBEW'
                 WHEN EecDedGroupCode =    'JETH' then 'JETSTREAM'
                 WHEN eecdedgroupcode =    'JETS'  THEN 'JETSTREAM'
                 WHEN eecdedgroupcode =    'SIGH'  THEN 'SIGNAL'
                 WHEN eecdedgroupcode =    'SIGS'  THEN 'SIGNAL'
                 WHEN EecDedGroupCode =    'SMWU' then 'SIG UNION' 
                 WHEN eecdedgroupcode =    'UTROL' THEN 'UNITROL'
                 WHEN eecdedgroupcode =    'VACH'  THEN 'VACTOR'
                 WHEN eecdedgroupcode =    'VACS'  THEN 'VACTOR'
                 WHEN eecdedgroupcode =    'VICTR' THEN 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'ELGIN' then 'ELGIN'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'CALB' then 'VACTOR'    
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'CODESP' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'CORP' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'GUZZBR' then 'VACTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'GUZZNJ' then 'VACTOR'  
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'GUZZST' then 'VACTOR'   
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'JTSTOH' then 'JETSTREAM'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'JTSTRM' then 'JETSTREAM'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'NBRSKA' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'UNITRL' then 'UNITROL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'UP    ' and eecunionlocal IS NULL AND eecunionnational IS NULL then 'SIGNAL'     
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'UP    ' and (eecunionlocal = '20134' or eecunionnational = '20134') then 'IBEW'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'UP    ' then 'SIG UNION'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'VACTOR' then 'VACTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'VICTOR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMDE  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMDE  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMDE  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMFL  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMFL  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMGA  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMGA  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMGA  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMIN  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMIN  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMIN  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMKS  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMKS  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMKS  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMKY  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMKY  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMKY  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMLA  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMLA  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMLA  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMLA  ' and cmpcompanycode = 'VACTR' then 'VACTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMA  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMA  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMA  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMI  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMI  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMI  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMN  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMN  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMN  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMO  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMO  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMMO  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNC  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNC  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNJMO' and cmpcompanycode = 'FAPD' then 'FAPD'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNJMO' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNJMO' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNJMO' and cmpcompanycode = 'PIPS ' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNJNW' then 'FAPD'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNV  ' and cmpcompanycode = 'FAPD' then 'FAPD'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNV  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNV  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNV  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNY  ' and cmpcompanycode = 'FAPD' then 'FAPD'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNY  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNY  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMNY  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMOH  ' and cmpcompanycode = 'FAPD' then 'FAPD'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMOH  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMOH  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMOH  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMOR  ' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMPA  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMPA  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMPABU' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMPACH' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMPASL' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMPASL' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMPASO' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMPASO' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMPAWE' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMSC  ' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMTN  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMTN  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMTN  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMTXCL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMTXHO' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMTXMC' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMTXRW' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMUT  ' then 'VACTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMVA  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMVA  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMVA  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMWA  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMWA  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMWA  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMWI  ' and cmpcompanycode = 'SIGNL' then 'SIGNAL'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMWI  ' and cmpcompanycode = 'FSC' then 'CORPORATE'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMWI  ' and cmpcompanycode = 'VICTR' then 'VICTOR'
                 WHEN eecdedgroupcode =    'PTIME'  and eeclocation = 'RMWI  ' and cmpcompanycode = 'LCHUS' then 'ELGIN'
                 WHEN EecDedGroupCode = 'NONE' THEN 'NO BENEFIT'
                 WHEN EecDedGroupCode = 'NO BEN' THEN 'NO BENEFIT'
                 WHEN EecDedGroupCode = 'NOBEN' THEN 'NO BENEFIT'        
                 WHEN EecDedGroupCode = 'CORP' THEN 'CORPORATE'
                 WHEN EecDedGroupCode = 'ELGH' THEN 'ELGIN '
                 WHEN EecDedGroupCode = 'ELGS' THEN 'ELGIN '
                 WHEN EecDedGroupCode = 'VACS' THEN 'VACTOR '
                 WHEN EecDedGroupCode = 'VACH' THEN 'VACTOR '
                 WHEN EecDedGroupCode = 'JETS' THEN 'JETSTREAM'
                 WHEN EecDedGroupCode = 'DANS' THEN 'DANVILLE '
                 WHEN EecDedGroupCode = 'LCHS' THEN 'LEACH US '
                 WHEN EecDedGroupCode = 'PENS' THEN 'PENSIONER'
                 WHEN EecDedGroupCode = 'SIGS' THEN 'SIGNAL '
                 WHEN EecDedGroupCode = 'SIGH' THEN 'SIGNAL '
                 WHEN EecDedGroupCode = 'ADPS' THEN 'FAPD '
                 WHEN EecDedGroupCode = 'APDH' THEN 'FAPD '
                 WHEN EecDedGroupCode = 'PLUS' THEN 'PAULUHN '
                 WHEN EecDedGroupCode = 'PLUH' THEN 'PAULUHN '
                 WHEN EecDedGroupCode = 'EONES' THEN 'E-ONE '
                 WHEN EecDedGroupCode = 'EONEH' THEN 'E-ONE '
                 WHEN EecDedGroupCode = 'DAYS' THEN 'DAYTON '
                 WHEN EecDedGroupCode = 'DAYH' THEN 'DAYTON '
                 WHEN EecDedGroupCode = 'PCSS' THEN 'PCS '
                 WHEN EecDedGroupCode = 'PCSH' THEN 'PCS '
                 WHEN EecDedGroupCode = 'CLDS' THEN 'CLAPPDICO '
                 WHEN EecDedGroupCode = 'CLDH' THEN 'CLAPPDICO '
                 WHEN EecDedGroupCode = 'MTCS' THEN 'MTC'
                 WHEN EecDedGroupCode = 'MTCH' THEN 'MTC '
                 WHEN EecDedGroupCode = 'OTMS' THEN 'OTM '
                 WHEN EecDedGroupCode = 'OTMH' THEN 'OTM '
                 WHEN EecDedGroupCode = 'VICTR' THEN 'VICTOR US'
                 --WHEN EecDedGroupCode = 'IAM' THEN 'TOOL & DIE LOCAL 701 IAM'
                 --WHEN EecDedGroupCode = 'IBEW' THEN 'IBEW LOCAL 134 UNION'
                 WHEN EecDedGroupCode = 'JETH' THEN 'JETSTREAM '
                 WHEN EecDedGroupCode = 'JJE' THEN 'JOEJOHNSON'
                 --WHEN EecDedGroupCode = 'SMWU' THEN 'SHEET METAL WORKERS UNION'
                 WHEN EecDedGroupCode = 'ZFST' THEN 'FST CANADA'
                 when RTRIM(LTRIM(EecDedGroupCode)) in ('MRLH','MRLS') then 'MRL'--added 7/3/2019
                 WHEN EecDedGroupCode = 'PWE' THEN 'JOEJOHNSON' --DA 6/22/2020 added
                  END,
                  PayrollCodeOne = case when eecDedGroupCode IN ('CORPH', 'JETH','PTIME','SIGH','CORP', 'ELGH', 'ELGS',  'JETS', 'SIGS', 'UTROL', 'VACH', 'VACH', 'VACS', 'VICTR') then '1'
                                        when eecDedGroupCode  = 'IBEW' THEN '3'
                                        when EecDedGroupCode = 'SMWU' THEN 'SMW'
                                        when EecDedGroupCode = 'JJE' THEN '4'
                                        when RTRIM(LTRIM(EecDedGroupCode)) in ('MRLH','MRLS') then '4'--added 7/3/2019
                                        --The Vanguard Pay Code that MRL should be linked to is: 4
                                        when EecDedGroupCode = 'ZFST' THEN '0'
                                        when EecDedGroupCode = 'IAM' THEN '2'
                                        when EecDedGroupCode = 'PWE' THEN '4' --DA added 6/22/2020
                                        when EecDedGroupCode = 'MRLHM' Then '4' -- 082521 this needs to be added
                                        when EecDedGroupCode = 'HMS' Then '4' -- 082521 this needs to be added
                                        end

    FROM dbo.U_EVAN401KV2_EEMAST with (nolock)
    JOIN dbo.EmpComp ON EEID = EecEEID AND COID = EecCOID
    JOIN dbo.company ON COID = cmpcoid

--select 'UPDATE dbo.U_EVAN401KV2_EEMAST 1',count(*) FROM dbo.U_EVAN401KV2_EEMAST

    UPDATE dbo.U_EVAN401KV2_EEMAST
    SET LocCode = 'IBEW'
    FROM dbo.U_EVAN401KV2_EEMAST with (nolock)
    JOIN dbo.EmpComp ON EEID = EecEEID AND COID = EecCOID
    where eecdedGroupCode = 'SIGH' and (eecunionlocal = '20134' or eecunionnational = '20134');

    DELETE dbo.U_EVAN401KV2_EEMAST WHERE LocCode = 'NO BENEFIT';

--select 'UPDATE dbo.U_EVAN401KV2_EEMAST 2',count(*) FROM dbo.U_EVAN401KV2_EEMAST

/*******************************************************************************************************
RECTYPE B,D DRIVER TABLE
*******************************************************************************************************/
--SPLIT DRIVER TABLE INTO 2 SEPERATE TABLES ONE FOR CONTRIBS AND ONE FOR LOANS
--RECTYPE B - CONTRIBUTIONS

    -----------------------------
    -- Working Table - PDedHist2
    -----------------------------

    IF OBJECT_ID('U_EVAN401KV2_PDedHist2') IS NOT NULL
        DROP TABLE dbo.U_EVAN401KV2_PDedHist2;
    SELECT DISTINCT
         PrgEEID
         ,PrgPeriodStartDate
         ,PrgPeriodEndDate
         ,pdhgennumber
         ,PrgPerControl
         ,PdhDedCode
         ,PdhEECurAmt  
         ,PdhERCurAmt
    INTO dbo.U_EVAN401KV2_PDedHist2
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)  ON PdhEEID = PrgEEID
        AND PdhGenNumber = PrgGenNumber
        AND PrgPerControl BETWEEN @StartPerControl AND @EndPerControl
        AND ISNULL(PrgGenRef,'0') = '0'
        AND PrgTransactionType NOT IN ('A','E','O')
        AND PdhDedCode IN   
           ('D4KP8','E4KPS','F4KER','RKER',
            '401CU','C4KP','F4KER','D4ER2','D4KP3',  'D4KPM','D4KER','E4KPM','4KATA',
              '4KATB','4KATC','4KATD','4KPM','4KPMA', '4KPUM','L4KER','E4KER','E4ER1', 
              '4KERA','M4KER','M4KPM','T4KPM','P4KPM','4KPUC','R4KER','CRC1','RSPPT','RSPAT','RSPCU','CRC2','NRB','NRBU','NRC','4KPER','RSPER') --34 --DA added 'NRB','NRBU','NRC','4KPER','RSPER'
      AND  ( ISNULL(PdhEECurAmt,0.00) > 0.00 OR ISNULL(PdhERCurAmt,0.00) > 0.00)
      --JOIN dbo.U_EVAN401KV2_EEList2                    --J.S. 05/07/18 11417461
      --ON PdhEEID = vEEID AND pdhcoID = vCOID
      JOIN dbo.U_EVAN401KV2_EEList
        ON PdhEEID = xEEID AND pdhcoID = xCOID

        WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
  ;
    --  WHERE ISNULL(PdhEECurAmt,0.00) > 0.00
    --GROUP BY PrgEEID,PrgPeriodStartDate,PrgPeriodEndDate,PrgPerControl,PdhDedCode
    --HAVING (SUM(PdhEECurAmt) <> 0.00);
--select 'U_EVAN401KV2_PDedHist2',count(*) FROM dbo.U_EVAN401KV2_PDedHist2

        IF OBJECT_ID('U_EVAN401KV2_EEAMTS') IS NOT NULL
        DROP TABLE dbo.U_EVAN401KV2_EEAMTS;

SELECT DISTINCT pEEID= prgeeid,
    eepSSN,
    StartDate =  prgPeriodStartDate,
    EndDate = PrgPeriodEndDate,
    PriorStartDate =  convert(varchar(8),@PriorStartDate),
    PriorEndDate =  convert(varchar(8),@PriorEndDate),
    GenNumber = pdhgennumber,
    PerControl = PrgPerControl,
    SUM_AAA = CONVERT(MONEY,NULL),
           SUM_GGG = CONVERT(MONEY,NULL),
           SUM_DDJ = CONVERT(MONEY,NULL),
           SUM_DDD = CONVERT(MONEY,NULL),
           SUM_DDE = CONVERT(MONEY,NULL),
           SUM_DDG = CONVERT(MONEY,NULL),
           SUM_111 = CONVERT(MONEY,NULL),
           SUM_FFF = CONVERT(MONEY,NULL),
           SUM_JJJ = CONVERT(MONEY,NULL),
           SUM_FFG = CONVERT(MONEY,NULL),
    SUM_KKK = CONVERT(MONEY,NULL),
    SUM_LLL = CONVERT(MONEY,NULL),
    SUM_CCE = CONVERT(MONEY,NULL), --DA added
    SUM_NRB = CONVERT(MONEY,NULL),--DA added
    SUM_NRC = CONVERT(MONEY,NULL),--DA added
    SUM_PEHEECUR = CONVERT(MONEY,NULL) 
   INTO dbo.U_EVAN401KV2_EEAMTS

   FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK) 
   JOIN dbo.EmpPers WITH (NOLOCK) on prgEEid = eepeeid 
   WHERE  pdhdedcode IN  ('D4KP8','E4KPS','F4KER','RKER',
            '401CU','C4KP','F4KER','D4ER2','D4KP3',  'D4KPM','D4KER','E4KPM','4KATA',
              '4KATB','4KATC','4KATD','4KPM','4KPMA', '4KPUM','L4KER','E4KER','E4ER1', 
              '4KERA','M4KER','M4KPM','T4KPM','P4KPM','4KPUC','R4KER','CRC1','RSPPT','RSPAT','RSPCU','CRC2','NRB','NRBU','NRC','4KPER','RSPER') --34 --DA added 'NRB','NRBU','NRC','4KPER','RSPER'
   AND prgPerControl BETWEEN @startpercontrol AND @endpercontrol

   ;

   --select * from dbo.U_EVAN401KV2_PDedHist2 where pdhdedcode = 'CRC2'
 --  print @endpercontrol
  -- select 'U_EVAN401KV2_EEAMTS', * from dbo.U_EVAN401KV2_EEAMTS   -- 20 min later
    /*****************************************************
    GETTING 401K CONTRIB AMOUNTS AND 401K LOAN AMOUNTS
    ******************************************************/
    --select * from vw_DedDesc
    --======================================
    --EE CONTRIBUTION TOTALS - REC TYPE B
    --======================================

    --GETTING AAA TOTALS, pos 67
    UPDATE dbo.U_EVAN401KV2_EEAMTS
    SET SUM_AAA = SUMC
    FROM (SELECT SUMC = SUM(pdhEECurAmt),
                 PdhGenNumber
          FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
          JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK) ON PdhGenNumber = GenNumber
 --         WHERE pdhDedCode IN ('C4KP','4KPUC','4KPUM','4KPM','D4KPM','M4KPM','P4KPM','T4KPM','RSPPT')
     WHERE pdhDedCode IN ('4KPM','RSPPT')
    -- ('C4KP ','E4KPM','M4KPM', 'T4KPM','4KPMA', '4KPM', 'D4KP3', 'D4KP2', 'D4KP8', 'P4KPM','RSPPT') 
          AND pdhEECurAmt > 0
          GROUP BY PdhGenNumber) AS tbl 
    WHERE PdhGenNumber = gennumber

  -- select 'UPDATE dbo.U_EVAN401KV2_EEAMTS 1',count(*) from dbo.U_EVAN401KV2_EEAMTS

    --GETTING GGG TOTALS, pos 95
    UPDATE dbo.U_EVAN401KV2_EEAMTS
    SET SUM_GGG = SUMC
    FROM (SELECT SUMC = SUM(pdhEECurAmt),
                 PdhGenNumber
          FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
          JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK) ON PdhGenNumber = GenNumber
          WHERE pdhDedCode = 'RSPAT' --('4KATA','4KATB','4KATC','4KATD')--('4KATB','4KATC','4KATD','RSPAT')
                AND pdhEECurAmt > 0
           GROUP BY PdhGenNumber) AS tbl 
    WHERE PdhGenNumber = gennumber

    --GETTING DDJ TOTALS,             
    UPDATE dbo.U_EVAN401KV2_EEAMTS
    SET SUM_DDJ = (SELECT SUM(pdhERCurAmt)
                   FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
                   WHERE pdhDedCode IN ('4KPM','4KPER') --DA 2/13/19 added 4KPER        --'IBEW'  -- '4KPM'
                   AND PdhGenNumber = gennumber
                   AND pdhERCurAmt > 0
                   GROUP BY PdhGenNumber) 
    from dbo.U_EVAN401KV2_EEAMTS with (nolock)
    join dbo.empcomp on eeceeid = peeid 
    where (eecunionlocal = '20134' or eecunionnational = '20134')

    --GETTING DDD TOTALS            
    UPDATE dbo.U_EVAN401KV2_EEAMTS
    SET SUM_DDD = (SELECT SUM(pdhERCurAmt)
                   FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
                   WHERE pdhDedCode IN ('4KPM','4KPER') --DA added   -- IN ('M4KPM','T4KPM','C4KP', '4KPM')
                   AND PdhGenNumber = gennumber
                   AND pdhERCurAmt > 0
                   GROUP BY PdhGenNumber) 
    from dbo.U_EVAN401KV2_EEAMTS with (nolock)
    join dbo.empcomp on eeceeid = peeid 
    where eecunionlocal in ('20113A','20115B','20115C')           
    or  eecunionnational in ('20113A','20115B','20115C')

   --UPDATE dbo.U_EVAN401KV2_EEAMTS
   -- SET SUM_DDJ = (SELECT SUM(pdhERCurAmt)
   --                FROM dbo.iPDedHist WITH (NOLOCK)
   --                WHERE pdhDedCode = '4KPM'
   --                AND PdhGenNumber = gennumber
   --                AND pdhERCurAmt > 0
   --                GROUP BY PdhGenNumber) 
   -- from dbo.U_EVAN401K017_EEAMTS
   -- join dbo.empcomp on eeceeid = peeid 
   -- where (eecunionlocal = '20134' or eecunionnational = '20134')
    --sp_geteeid select * from dbo.U_EVAN401K017_EEAMTS where peeid =   '5Y8DSO0000K0'
    --GETTING DDD TOTALS            
    --UPDATE dbo.U_EVAN401KV2_EEAMTS
    --SET SUM_DDD = (SELECT SUM(pdhERCurAmt)
    --               FROM dbo.iPDedHist WITH (NOLOCK)
    --               WHERE pdhDedCode = '4KPM'
    --               AND PdhGenNumber = gennumber
    --               AND pdhERCurAmt > 0
    --               GROUP BY PdhGenNumber) 
    --from dbo.U_EVAN401KV2_EEAMTS
    --join dbo.empcomp on eeceeid = peeid 
    --where eecunionlocal in ('20113A','20115B','20115C')           
    --or  eecunionnational in ('20113A','20115B','20115C')

    --GETTING FFG TOTALS          
    UPDATE dbo.U_EVAN401KV2_EEAMTS
    SET SUM_FFG = SUMC
    FROM (SELECT SUMC = SUM(pdhERCurAmt),
                 PdhGenNumber
            FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
            JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK)ON PdhGenNumber = GenNumber
              WHERE pdhDedCode = 'CRC2'
                AND pdhERCurAmt > 0
           GROUP BY PdhGenNumber) AS tbl 
    WHERE PdhGenNumber = gennumber

 --   --GETTING DDE TOTALS, pos 167
 --   UPDATE dbo.U_EVAN401KV2_EEAMTS
 --   SET SUM_DDE = 0 
    ----SUMC
 --  -- FROM (SELECT SUMC = SUM(pdhERCurAmt),
 --  --              PdhGenNumber
 --   --        FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
 --   --        JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK)ON PdhGenNumber = GenNumber
 --  --         WHERE pdhDedCode = 'RSPPT'
 --  --             AND pdhERCurAmt > 0
 --   --       GROUP BY PdhGenNumber) AS tbl 
 --   WHERE PdhGenNumber = gennumber

    --GETTING FFF TOTALS, pos 191
    UPDATE dbo.U_EVAN401KV2_EEAMTS
    SET SUM_FFF = SUMC
    FROM (SELECT SUMC = SUM(pdhERCurAmt),
                 PdhGenNumber
          FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
          JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK)ON PdhGenNumber = GenNumber
          WHERE pdhDedCode = 'M4KER'
                AND pdhERCurAmt > 0
           GROUP BY PdhGenNumber) AS tbl 
    WHERE PdhGenNumber = gennumber

--Select * into work1tbl  from  pdedhist  join U_EVAN401KV2_eeamts on pdheeid = peeid WHERE pdhDedCode IN ('CRC1','CRC3','CRKIC') and pdhpercontrol = '201712291' and pdheeid = peeid 
--select  * from work1tbl join    U_EVAN401KV2_PDEDHIST2 on pdheeid = prgeeid where pdheeid = prgeeid  from U_EVAN401KV2_PDEDHIST2
--select * from U_EVAN401KV2_PdedHIST2 where prgeeid = '5SRJ110000K0'
 -- select * from U_EVAN401KV2_PdedHIST2 where prgeeid = '5SRJ110000K0' and pdhpercontrol = '201712291' select * from pdedhist where pdheeid = '5SRJ110000K0' and pdhpercontrol = '201712291'
    --GETTING DDG TOTALS, pos 215
    --UPDATE dbo.U_EVAN401KV2_EEAMTS
    --SET SUM_DDG = SUMC
    --FROM (SELECT SUMC = SUM(pdhERCurAmt),
    --             PdhGenNumber
    --        FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
    --        JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK)ON PdhGenNumber = GenNumber
    --        WHERE pdhDedCode IN ('CRC1','CRC3','CRKIC')
    --            AND pdhERCurAmt > 0
    --       GROUP BY PdhGenNumber) AS tbl 
    --WHERE PdhGenNumber = gennumber

    --GETTING JJJ TOTALS, pos 239 - THIS MIGHT NEED TO BE EE AMOUNT
    UPDATE dbo.U_EVAN401KV2_EEAMTS
    SET SUM_JJJ = SUMC
    FROM (SELECT SUMC = SUM(pdhEECurAmt),
                 PdhGenNumber
            FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
            JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK)ON PdhGenNumber = GenNumber
            WHERE pdhDedCode = 'RSPCU' --IN ('4KCUB','4KCUC','4KCUD','RSPCU')
                AND pdhEECurAmt > 0
           GROUP BY PdhGenNumber) AS tbl 
    WHERE PdhGenNumber = gennumber

--GETTING KKK TOTALS
UPDATE U_EVAN401KV2_EEAMTS
SET SUM_KKK = SUMC
FROM (SELECT SUMC = SUM(pdhERCurAmt),
       PdhGenNumber
    FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
    JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode = 'RSPPT'
      AND pdhERCurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber


 --GETTING NRB TOTALS, pos 67 --DA added
    UPDATE dbo.U_EVAN401KV2_EEAMTS
    SET SUM_NRB = SUMC
    FROM (SELECT SUMC = SUM(pdhEECurAmt),
                 PdhGenNumber
          FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
          JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK) ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN ('NRB','NRBU') 
          AND pdhEECurAmt > 0
          GROUP BY PdhGenNumber) AS tbl 
    WHERE PdhGenNumber = gennumber

  
 --GETTING NRC TOTALS, pos 67 --DA added
    UPDATE dbo.U_EVAN401KV2_EEAMTS
    SET SUM_NRC = SUMC
    FROM (SELECT SUMC = SUM(pdhEECurAmt),
                 PdhGenNumber
          FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
          JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK) ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN ('NRC') 
          AND pdhEECurAmt > 0
          GROUP BY PdhGenNumber) AS tbl 
    WHERE PdhGenNumber = gennumber


     --GETTING CCE TOTALS,DA added
    UPDATE dbo.U_EVAN401KV2_EEAMTS
    SET SUM_CCE = SUMC
    FROM (SELECT SUMC = SUM(pdhERCurAmt),
                 PdhGenNumber
          FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
          JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK) ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN ('RSPER') 
          AND pdhERCurAmt > 0
          GROUP BY PdhGenNumber) AS tbl 
    WHERE PdhGenNumber = gennumber

--UPDATE U_EVAN401KV2_EEAMTS
--SET SUM_LLL = 0
--SUMC
--FROM (SELECT SUMC = SUM(pdhERCurAmt),
--       PdhGenNumber
--    FROM dbo.U_EVAN401KV2_PDedHist2 WITH (NOLOCK)
--    JOIN dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK)ON PdhGenNumber = GenNumber
--     WHERE pdhDedCode = 'CRC1'
--      AND pdhERCurAmt > 0
--    GROUP BY PdhGenNumber) AS tbl 
--WHERE PdhGenNumber = gennumber

--EE LOAN TOTALS - REC TYPE D
UPDATE U_EVAN401KV2_EEAMTS
SET SUM_PEHEECUR = SUMC
FROM (SELECT SUMC = SUM(pehCurAmt)
 ,PehEEID
     ----  , PehGenNumber
    FROM dbo.PearHist WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS WITH (NOLOCK) ON PehEEID = pEEID
     WHERE pehearnCode in ( 'ABSPD','BERVH','BERVS','BNBIP', 'BNEV', 'BNGS','BNGS1','BNGS2','BNINC','BNMIP','BNREC',
    'BNVAR','COMM','COMM1','COMM2','COMMS','FLOTH','FLOTS','HOLH','HOLS', 'JURYF','JURYH','JURYS','LVPD',
    'OT1','OT15','OT5','OTDT1','OTDT2','PERS','PROFT','PTOPO','REG','RETRO','SAL','SEPPY','SHD8F','SHFJ1',
    'SHFTF', 'SICKH', 'SICKS','SPECD','STDH','STDH2','STDH5','TRANH','TRANS','UPGNS','VACFH','VACFS','VACH','VACPO','VACS','VJBDF')
      AND pehCurAmt > 0
      AND LEFT(pehpercontrol,4) = LEFT(@PRIORYear,4) 
          GROUP BY PehEEID) AS tbl 
  --  GROUP BY PehGenNumber) AS tbl 
WHERE PehEEid = pEEID

   --select 'UPDATE dbo.U_EVAN401KV2_EEAMTS JJJ',count(*) from dbo.U_EVAN401KV2_EEAMTS
   --sp_geteeid  berryman BRP2RW0040K0 coid 6QYTP Cocode =JJE paygroup JJEBWK  select * from U_EVAN401KV2_EEAMTS where peeid = 'BRP2RW0040K0'
    --=============================
    --EE LOAN TOTALS - REC TYPE D
    --=============================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    -- 09/24/2014, TL - Added
    IF OBJECT_ID('U_EVAN401KV2_PDedHist') IS NOT NULL
        DROP TABLE dbo.U_EVAN401KV2_PDedHist;
    SELECT DISTINCT
         PrgEEID
         ,PrgPeriodStartDate
         ,PrgPeriodEndDate
         ,PrgPerControl
         ,PdhDedCode
        ,SUM(PdhEECurAmt) AS PdhEECurAmt
    INTO dbo.U_EVAN401KV2_PDedHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = PrgEEID
        AND PdhGenNumber = PrgGenNumber
        AND PrgPerControl BETWEEN @StartPerControl AND @EndPerControl
        AND ISNULL(PrgGenRef,'0') = '0'
        AND PrgTransactionType NOT IN ('A','E','O')
        AND LEFT(PdhDedCode,3) = 'LN4'
    WHERE ISNULL(PdhEECurAmt,0.00) > 0.00
    GROUP BY PrgEEID,PrgPeriodStartDate,PrgPeriodEndDate,PrgPerControl,PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00);

   --select 'dbo.U_EVAN401KV2_PDedHist', * from dbo.U_EVAN401KV2_PDedHist where prgeeid = '5Y8B690000K0'

--RECTYPE B - LOANS

    -- 12/04/2014, TL - Migrated to Production - Replaced existing code
    IF OBJECT_ID('U_EVAN401KV2_EEAMTS2') IS NOT NULL
      DROP TABLE dbo.U_EVAN401KV2_EEAMTS2;
    SELECT DISTINCT pEEID = PrgEEID,
           eepSSN,
           StartDate = PrgPeriodStartDate,
           EndDate = PrgPeriodEndDate,
           GenNumber = '',
           PerControl = PrgPerControl,
           SUM_001 = CONVERT(MONEY,PdhEECurAmt),
           SUM_002 = CONVERT(MONEY,NULL),
           SUM_003 = CONVERT(MONEY,NULL),
           SUM_004 = CONVERT(MONEY,NULL),
           SUM_005 = CONVERT(MONEY,NULL),
           SUM_006 = CONVERT(MONEY,NULL),
           SUM_007 = CONVERT(MONEY,NULL),
           SUM_008 = CONVERT(MONEY,NULL),
           SUM_009 = CONVERT(MONEY,NULL),
           SUM_010 = CONVERT(MONEY,NULL),
           DedCode = RTRIM(PdhDedCode)        -- 10/09/2014, TL - Added
    INTO dbo.U_EVAN401KV2_EEAMTS2
    FROM dbo.EmpPers WITH (NOLOCK)
  JOIN dbo.U_EVAN401KV2_PDedHist
        ON PrgEEID = eepEEID;

   --print @start 

   --select 'dbo.U_EVAN401KV2_EEAMTS2',count(*) from dbo.U_EVAN401KV2_EEAMTS2

--GETTING 001 TOTALS
--EE LOAN TOTALS - REC TYPE D
--select * from pdedhist where pdheeid = '5Y8DPR0000K0' and pdhdedcode like 'L%' and pdhpercontrol like '201712%'
--select * from U_EVAN401KV2_EEAMTS2 where peeid = '5Y8DPR0000K0' '350620764'  5Y8DPR0000K0 '322781492' 5Y8B690000K0

--GETTING 001 TOTALS
UPDATE U_EVAN401KV2_EEAMTS2
SET SUM_001 = SUML
FROM (SELECT SUML = SUM(pdhEECurAmt),
       PdhGenNumber
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS2 WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN('LN401')
      AND pdhEECurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber

--GETTING 002 TOTALS
UPDATE U_EVAN401KV2_EEAMTS2
SET SUM_002 = SUML
FROM (SELECT SUML = SUM(pdhEECurAmt),
       PdhGenNumber
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS2 WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN('LN402')
      AND pdhEECurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber

--GETTING 003 TOTALS
UPDATE U_EVAN401KV2_EEAMTS2
SET SUM_003 = SUML
FROM (SELECT SUML = SUM(pdhEECurAmt),
       PdhGenNumber
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS2 WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN('LN403')
      AND pdhEECurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber

--GETTING 004 TOTALS
UPDATE U_EVAN401KV2_EEAMTS2
SET SUM_004 = SUML
FROM (SELECT SUML = SUM(pdhEECurAmt),
       PdhGenNumber
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS2 WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN('LN404')
      AND pdhEECurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber

--GETTING 005 TOTALS
UPDATE U_EVAN401KV2_EEAMTS2
SET SUM_005 = SUML
FROM (SELECT SUML = SUM(pdhEECurAmt),
       PdhGenNumber
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS2 WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN('LN405')
      AND pdhEECurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber

--GETTING 006 TOTALS
UPDATE U_EVAN401KV2_EEAMTS2
SET SUM_006 = SUML
FROM (SELECT SUML = SUM(pdhEECurAmt),
       PdhGenNumber
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS2 WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN('LN406')
      AND pdhEECurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber

--GETTING 007 TOTALS
UPDATE U_EVAN401KV2_EEAMTS2
SET SUM_007 = SUML
FROM (SELECT SUML = SUM(pdhEECurAmt),
       PdhGenNumber
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS2 WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN('LN407')
      AND pdhEECurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber

--GETTING 008 TOTALS
UPDATE U_EVAN401KV2_EEAMTS2
SET SUM_008 = SUML
FROM (SELECT SUML = SUM(pdhEECurAmt),
       PdhGenNumber
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS2 WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN('LN408')
      AND pdhEECurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber

--GETTING 009 TOTALS
UPDATE U_EVAN401KV2_EEAMTS2
SET SUM_009 = SUML
FROM (SELECT SUML = SUM(pdhEECurAmt),
       PdhGenNumber
    FROM dbo.PDedHist  WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS2 WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN('LN409')
      AND pdhEECurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber

--GETTING 010 TOTALS
UPDATE U_EVAN401KV2_EEAMTS2
SET SUM_010 = SUML
FROM (SELECT SUML = SUM(pdhEECurAmt),
       PdhGenNumber
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN U_EVAN401KV2_EEAMTS2 WITH (NOLOCK)ON PdhGenNumber = GenNumber
     WHERE pdhDedCode IN('LN410')
      AND pdhEECurAmt > 0
    GROUP BY PdhGenNumber) AS tbl 
WHERE PdhGenNumber = gennumber

/************************************************
RECTYPE C DRIVER TABLE
************************************************/
       IF OBJECT_ID('U_EVAN401KV2_TOTAMTS') IS NOT NULL
        DROP TABLE dbo.U_EVAN401KV2_TOTAMTS;

SELECT TOTAL_AAA = SUM(SUM_AAA),
           TOTAL_GGG = SUM(SUM_GGG),
           TOTAL_DDD = SUM(SUM_DDD),
           TOTAL_DDE = SUM(SUM_DDE),
           TOTAL_DDG = SUM(SUM_DDG),
           TOTAL_111 = SUM(SUM_111),
           TOTAL_DDJ = SUM(SUM_DDJ),
           TOTAL_FFF = SUM(SUM_FFF),
           TOTAL_JJJ = SUM(SUM_JJJ),
           TOTAL_FFG = SUM(SUM_FFG),
           --TOTAL_CCE = SUM(SUM_KKK),--Da commented out
           TOTAL_CCE = SUM(SUM_CCE), --DA added
           TOTAL_KKK = SUM(SUM_KKK),--DA added
           TOTAL_NRB = SUM(SUM_NRB),--DA added
           TOTAL_NRC = SUM(SUM_NRC), --DA added
              eepssn = '0'
INTO dbo.U_EVAN401KV2_TOTAMTS
 FROM dbo.U_EVAN401KV2_EEAMTS WITH (NOLOCK)

 --select 'U_EVAN401KV2_TOTAMTS',COUNT(*) from  U_EVAN401KV2_TOTAMTS

END

/*
-- Create View
CREATE VIEW [dbo].[dsi_vwEVAN401KV2_Export] AS
    SELECT TOP 2000000
        CASE WHEN SUBSTRING(RECORDSET,1,1) = 'T' THEN SUBSTRING(DATA,1,45) ELSE UPPER(DATA) END AS data
    FROM dbo.U_EVAN401KV2_File 
    ORDER BY SUBSTRING(RECORDSET,2,2),INITIALSORT

-- Field Definitions
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID IN (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = 'EVAN401KV2')
ORDER BY AdfSetNumber, AdfFieldNumber
*/
GO
CREATE  VIEW [dbo].[dsi_vwEVAN401KV2_Export]
AS
SELECT TOP 2000000
  CASE WHEN SUBSTRING(RECORDSET,1,1) = 'T' THEN SUBSTRING(DATA,1,45)
     ELSE UPPER(DATA) END 
AS data
 FROM dbo.U_EVAN401KV2_File 
ORDER BY SUBSTRING(RECORDSET,2,2),INITIALSORT