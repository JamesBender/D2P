SET NOCOUNT ON;
IF OBJECT_ID('U_EMOOSVAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMOOSVAEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMOOSVAEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMOOSVAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMOOSVAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMOOSVAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMOOSVAEXP];
GO
IF OBJECT_ID('U_EMOOSVAEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_PEarHist];
GO
IF OBJECT_ID('U_EMOOSVAEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_PDedHist];
GO
IF OBJECT_ID('U_EMOOSVAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_File];
GO
IF OBJECT_ID('U_EMOOSVAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_EEList];
GO
IF OBJECT_ID('U_EMOOSVAEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_drvTbl];
GO
IF OBJECT_ID('U_EMOOSVAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EMOOSVAEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMOOSVAEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMOOSVAEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMOOSVAEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMOOSVAEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMOOSVAEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMOOSVAEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMOOSVAEXP','MoO STD VolL ADD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1382','S','N','EMOOSVAEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMOOSVAEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransDate"','1','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1',NULL,'Trans Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"G000BW7J"','2','(''DA''=''F'')','EMOOSVAEXPZ0','8','D','10','9',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','3','(''UA''=''F'')','EMOOSVAEXPZ0','1','D','10','17',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','4','(''UA''=''F'')','EMOOSVAEXPZ0','10','D','10','18',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''F'')','EMOOSVAEXPZ0','35','D','10','28',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''F'')','EMOOSVAEXPZ0','26','D','10','63',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGenderCode"','7','(''UA''=''F'')','EMOOSVAEXPZ0','1','D','10','89',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','8','(''UD112''=''F'')','EMOOSVAEXPZ0','19','D','10','90',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EMOOSVAEXPZ0','40','D','10','109',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EMOOSVAEXPZ0','80','D','10','149',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','EMOOSVAEXPZ0','19','D','10','229',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','EMOOSVAEXPZ0','2','D','10','248',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EMOOSVAEXPZ0','59','D','10','250',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','14','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','309',NULL,'Date of Hire (DOH)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEffectiveDate"','15','(''UD112''=''F'')','EMOOSVAEXPZ0','76','D','10','317',NULL,'Employee Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillGroupEffectiveDate"','16','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','393',NULL,'Bill Group Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','17','(''DA''=''F'')','EMOOSVAEXPZ0','74','D','10','401',NULL,'Bill Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSalaryEffectiveDate"','18','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','475',NULL,'Basic Salary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','19','(''DA''=''F'')','EMOOSVAEXPZ0','1','D','10','483',NULL,'Basic Salary Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSalaryAmount"','20','(''UA''=''F'')','EMOOSVAEXPZ0','16','D','10','484',NULL,'Basic Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EMOOSVAEXPZ0','8','D','10','500',NULL,'1st Additional Compensation Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''F'')','EMOOSVAEXPZ0','1','D','10','508',NULL,'1st Additional Compensation Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','EMOOSVAEXPZ0','2','D','10','509',NULL,'1st Additional Compensation Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''F'')','EMOOSVAEXPZ0','97','D','10','511',NULL,'1st Additional Compensation Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassEffectiveDate"','25','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','608',NULL,'Class Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A001"','26','(''DA''=''F'')','EMOOSVAEXPZ0','414','D','10','616',NULL,'Class ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermEEProductCategory"','27','(''UA''=''F'')','EMOOSVAEXPZ0','1','D','10','1030',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermEEEffectiveDate"','28','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1031',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermEEEligibilityEvent"','29','(''UA''=''F'')','EMOOSVAEXPZ0','2','D','10','1039',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermEEPlanID"','30','(''UA''=''F'')','EMOOSVAEXPZ0','10','D','10','1041',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermEEFamCoverageInd"','31','(''UA''=''F'')','EMOOSVAEXPZ0','5','D','10','1051',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermEEApprovedAmtEffDate"','32','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1056',NULL,'Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermEEApprovedAmt"','33','(''UA''=''F'')','EMOOSVAEXPZ0','21','D','10','1064',NULL,'Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermSPSProductCategory"','34','(''UA''=''F'')','EMOOSVAEXPZ0','1','D','10','1085',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermSPSEffectiveDate"','35','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1086',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermSPSEligibilityEvent"','36','(''UA''=''F'')','EMOOSVAEXPZ0','2','D','10','1094',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermSPSPlanID"','37','(''UA''=''F'')','EMOOSVAEXPZ0','10','D','10','1096',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermSPSFamCoverageInd"','38','(''UA''=''F'')','EMOOSVAEXPZ0','5','D','10','1106',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermSPSApprovedAmtEffDate"','39','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1111',NULL,'Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermSPSApprovedAmt"','40','(''UA''=''F'')','EMOOSVAEXPZ0','21','D','10','1119',NULL,'Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDepProductCategory"','41','(''UA''=''F'')','EMOOSVAEXPZ0','1','D','10','1140',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDepEffectiveDate"','42','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1141',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDepEligibilityEvent"','43','(''UA''=''F'')','EMOOSVAEXPZ0','2','D','10','1149',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDepPlanID"','44','(''UA''=''F'')','EMOOSVAEXPZ0','10','D','10','1151',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDepFamCoverageInd"','45','(''UA''=''F'')','EMOOSVAEXPZ0','5','D','10','1161',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDepApprovedAmtEffDate"','46','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1166',NULL,'Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDepApprovedAmt"','47','(''UA''=''F'')','EMOOSVAEXPZ0','21','D','10','1174',NULL,'Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddEEProductCategory"','48','(''UA''=''F'')','EMOOSVAEXPZ0','1','D','10','1195',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddEEEffectiveDate"','49','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1196',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddEEEligibilityEvent"','50','(''UA''=''F'')','EMOOSVAEXPZ0','2','D','10','1204',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddEEPlanID"','51','(''UA''=''F'')','EMOOSVAEXPZ0','10','D','10','1206',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddEEFamCoverageInd"','52','(''UA''=''F'')','EMOOSVAEXPZ0','5','D','10','1216',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddEEApprovedAmtEffDate"','53','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1221',NULL,'Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddEEApprovedAmt"','54','(''UA''=''F'')','EMOOSVAEXPZ0','21','D','10','1229',NULL,'Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddSPSProductCategory"','55','(''UA''=''F'')','EMOOSVAEXPZ0','1','D','10','1250',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddSPSEffectiveDate"','56','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1251',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddSPSEligibilityEvent"','57','(''UA''=''F'')','EMOOSVAEXPZ0','2','D','10','1259',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddSPSPlanID"','58','(''UA''=''F'')','EMOOSVAEXPZ0','10','D','10','1261',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddSPSFamCoverageInd"','59','(''UA''=''F'')','EMOOSVAEXPZ0','5','D','10','1271',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddSPSApprovedAmtEffDate"','60','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1276',NULL,'Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddSPSApprovedAmt"','61','(''UA''=''F'')','EMOOSVAEXPZ0','21','D','10','1284',NULL,'Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddDepProductCategory"','62','(''UA''=''F'')','EMOOSVAEXPZ0','1','D','10','1305',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddDepEffectiveDate"','63','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1306',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddDepEligibilityEvent"','64','(''UA''=''F'')','EMOOSVAEXPZ0','2','D','10','1314',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddDepPlanID"','65','(''UA''=''F'')','EMOOSVAEXPZ0','10','D','10','1316',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddDepFamCoverageInd"','66','(''UA''=''F'')','EMOOSVAEXPZ0','5','D','10','1326',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddDepApprovedAmtEffDate"','67','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1331',NULL,'Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddDepApprovedAmt"','68','(''UA''=''F'')','EMOOSVAEXPZ0','21','D','10','1339',NULL,'Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolSTDProductCategory"','69','(''UA''=''F'')','EMOOSVAEXPZ0','1','D','10','1360',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolSTDEffectiveDate"','70','(''UD112''=''F'')','EMOOSVAEXPZ0','8','D','10','1361',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolSTDEligibilityEvent"','71','(''UA''=''F'')','EMOOSVAEXPZ0','2','D','10','1369',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolSTDPlanID"','72','(''UA''=''F'')','EMOOSVAEXPZ0','10','D','10','1371',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolSTDFamCoverageInd"','73','(''UA''=''F'')','EMOOSVAEXPZ0','1','D','10','1381',NULL,'Family Coverage Indicator',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EMOOSVAEXP_20210928.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202108279','EMPEXPORT','OEACTIVE','Sep  1 2021  5:22AM','EMOOSVAEXP',NULL,NULL,NULL,'202108279','Aug 27 2021  8:35AM','Aug 27 2021  8:35AM','202108271','0','','','202108271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202108279','EMPEXPORT','OEPASSIVE','Sep  1 2021  5:22AM','EMOOSVAEXP',NULL,NULL,NULL,'202108279','Aug 27 2021  8:35AM','Aug 27 2021  8:35AM','202108271','225','','','202108271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'MoO STD VolL ADD Export','202108279','EMPEXPORT','ONDEM_XOE','Sep  1 2021  5:23AM','EMOOSVAEXP',NULL,NULL,NULL,'202108279','Aug 27 2021  8:35AM','Aug 27 2021  8:35AM','202108271','220','','','202108271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'MoO STD VolL ADD Export-Sched','202108279','EMPEXPORT','SCH_EMOOSV','Sep  1 2021  5:24AM','EMOOSVAEXP',NULL,NULL,NULL,'202108279','Aug 27 2021  8:35AM','Aug 27 2021  8:35AM','202108271','220','','','202108271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'MoO STD VolL ADD Export-Test','202109251','EMPEXPORT','TEST_XOE','Sep 25 2021  4:47PM','EMOOSVAEXP',NULL,NULL,NULL,'202109251','Sep 25 2021 12:00AM','Dec 30 1899 12:00AM','202109111','227','','','202109111',dbo.fn_GetTimedKey(),NULL,'us3cPePCR1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOOSVAEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EMOOSVAEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EMOOSVAEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EMOOSVAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMOOSVAEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMOOSVAEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMOOSVAEXP','D10','dbo.U_EMOOSVAEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EMOOSVAEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMOOSVAEXP] (
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
IF OBJECT_ID('U_EMOOSVAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EMOOSVAEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvTransDate] datetime NOT NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvEmployeeID] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvGenderCode] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvEmployeeEffectiveDate] datetime NULL,
    [drvBillGroupEffectiveDate] datetime NULL,
    [drvBasicSalaryEffectiveDate] datetime NULL,
    [drvBasicSalaryAmount] nvarchar(4000) NULL,
    [drvClassEffectiveDate] datetime NULL,
    [drvTermEEProductCategory] varchar(1) NULL,
    [drvTermEEEffectiveDate] datetime NULL,
    [drvTermEEEligibilityEvent] varchar(2) NULL,
    [drvTermEEPlanID] varchar(10) NULL,
    [drvTermEEFamCoverageInd] varchar(1) NULL,
    [drvTermEEApprovedAmtEffDate] datetime NULL,
    [drvTermEEApprovedAmt] nvarchar(4000) NULL,
    [drvTermSPSProductCategory] varchar(1) NULL,
    [drvTermSPSEffectiveDate] datetime NULL,
    [drvTermSPSEligibilityEvent] varchar(2) NULL,
    [drvTermSPSPlanID] varchar(10) NULL,
    [drvTermSPSFamCoverageInd] varchar(1) NULL,
    [drvTermSPSApprovedAmtEffDate] datetime NULL,
    [drvTermSPSApprovedAmt] nvarchar(4000) NULL,
    [drvTermDepProductCategory] varchar(1) NULL,
    [drvTermDepEffectiveDate] datetime NULL,
    [drvTermDepEligibilityEvent] varchar(2) NULL,
    [drvTermDepPlanID] varchar(10) NULL,
    [drvTermDepFamCoverageInd] varchar(1) NULL,
    [drvTermDepApprovedAmtEffDate] datetime NULL,
    [drvTermDepApprovedAmt] nvarchar(4000) NULL,
    [drvAddEEProductCategory] varchar(1) NULL,
    [drvAddEEEffectiveDate] datetime NULL,
    [drvAddEEEligibilityEvent] varchar(2) NULL,
    [drvAddEEPlanID] varchar(10) NULL,
    [drvAddEEFamCoverageInd] varchar(1) NULL,
    [drvAddEEApprovedAmtEffDate] datetime NULL,
    [drvAddEEApprovedAmt] nvarchar(4000) NULL,
    [drvAddSPSProductCategory] varchar(1) NULL,
    [drvAddSPSEffectiveDate] datetime NULL,
    [drvAddSPSEligibilityEvent] varchar(2) NULL,
    [drvAddSPSPlanID] varchar(10) NULL,
    [drvAddSPSFamCoverageInd] varchar(1) NULL,
    [drvAddSPSApprovedAmtEffDate] datetime NULL,
    [drvAddSPSApprovedAmt] nvarchar(4000) NULL,
    [drvAddDepProductCategory] varchar(1) NULL,
    [drvAddDepEffectiveDate] datetime NULL,
    [drvAddDepEligibilityEvent] varchar(2) NULL,
    [drvAddDepPlanID] varchar(10) NULL,
    [drvAddDepFamCoverageInd] varchar(1) NULL,
    [drvAddDepApprovedAmtEffDate] datetime NULL,
    [drvAddDepApprovedAmt] nvarchar(4000) NULL,
    [drvVolSTDProductCategory] varchar(1) NULL,
    [drvVolSTDEffectiveDate] datetime NULL,
    [drvVolSTDEligibilityEvent] varchar(2) NULL,
    [drvVolSTDPlanID] varchar(10) NULL,
    [drvVolSTDFamCoverageInd] varchar(1) NULL
);
IF OBJECT_ID('U_EMOOSVAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMOOSVAEXP_File') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1382) NULL
);
IF OBJECT_ID('U_EMOOSVAEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_PDedHist] (
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
IF OBJECT_ID('U_EMOOSVAEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMOOSVAEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMOOSVAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PCRK

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 08/27/2021
Service Request Number: TekP-2021-07-04-0004

Purpose: MoO STD VolL ADD Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMOOSVAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMOOSVAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMOOSVAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMOOSVAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMOOSVAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOOSVAEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOOSVAEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOOSVAEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOOSVAEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOOSVAEXP', 'SCH_EMOOSV';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMOOSVAEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMOOSVAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMOOSVAEXP';

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
    DELETE FROM dbo.U_EMOOSVAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMOOSVAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'VLIFE,VLFES,VLFEF,VLFEC,STD';

    IF OBJECT_ID('U_EMOOSVAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMOOSVAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMOOSVAEXP_DedList
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
    IF OBJECT_ID('U_EMOOSVAEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMOOSVAEXP_PDedHist;
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
    INTO dbo.U_EMOOSVAEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMOOSVAEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EMOOSVAEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMOOSVAEXP_PEarHist;
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
    INTO dbo.U_EMOOSVAEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMOOSVAEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMOOSVAEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMOOSVAEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvTransDate = GETDATE()
        ,drvRelationshipCode = CASE WHEN ConRelationship IN ('SPS','SPX','DMP','DP') AND ConGender = 'F' THEN 'W'
                                    WHEN ConRelationship IN ('SPS','SPX','DMP','DP') AND ConGender = 'M' THEN 'H'
                                    WHEN ConRelationship IN ('CHL','DPC','STC') AND ConGender = 'F' THEN 'D'
                                    WHEN ConRelationship IN ('CHL','DPC','STC') AND ConGender = 'M' THEN 'S'
                                    ELSE 'E'
                                END
        ,drvEmployeeID = EepSSN
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvGenderCode = CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
                        ELSE 
                            CASE WHEN ConGender IN ('M','F') THEN EepGender ELSE 'U' END
                        END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvEmployeeEffectiveDate = CASE WHEN EecDateOfLastHire > '4/1/2021' THEN EecDateOfLastHire ELSE '4/1/2021' END
        ,drvBillGroupEffectiveDate = CASE WHEN EecDateOfLastHire > '4/1/2021' THEN EecDateOfLastHire ELSE '4/1/2021' END
        ,drvBasicSalaryEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate(xEEID, xCOID, eecDateOfLastHire)
                                        --dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, '4/1/2021', eecDateOfLastHire)
        ,drvBasicSalaryAmount = FORMAT(EecAnnSalary*100, REPLICATE('0',16))
        ,drvClassEffectiveDate = CASE WHEN EecDateOfLastHire > '4/1/2021' THEN EecDateOfLastHire ELSE '4/1/2021' END


        ,drvTermEEProductCategory = CASE WHEN VLIFE_DedCode IS NOT NULL THEN '3' END
        ,drvTermEEEffectiveDate =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLIFE_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStartDate, '4/1/2021') END
                                    END
        ,drvTermEEEligibilityEvent =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLIFE_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvTermEEPlanID = CASE WHEN VLIFE_DedCode IS NOT NULL THEN 'ETL0CEEVAL' END
        ,drvTermEEFamCoverageInd = CASE WHEN VLIFE_DedCode IS NOT NULL THEN 'C' END
        ,drvTermEEApprovedAmtEffDate = CASE WHEN VLIFE_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStartDate, '4/1/2021') END
        ,drvTermEEApprovedAmt = CASE WHEN VLIFE_DedCode IS NOT NULL THEN FORMAT(VLIFE_BenAmt, REPLICATE('0',10)) END



        ,drvTermSPSProductCategory = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN '4' END
        ,drvTermSPSEffectiveDate =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLFES_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStartDate, '4/1/2021') END
                                    WHEN VLFEF_DedCode IS NOT NULL THEN
                                        CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                    END
        ,drvTermSPSEligibilityEvent =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFES_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvTermSPSPlanID = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'ETL0CSPVAL' END
        ,drvTermSPSFamCoverageInd = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'C' END
        ,drvTermSPSApprovedAmtEffDate =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFES_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStartDate, '4/1/2021') END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                        END
        ,drvTermSPSApprovedAmt =    CASE WHEN VLFES_DedCode IS NOT NULL THEN FORMAT(VLFES_BenAmt, REPLICATE('0',10))
                                        WHEN VLFEF_DedCode IS NOT NULL THEN    FORMAT(VLFEF_BenAmt, REPLICATE('0',10))
                                    END


        ,drvTermDepProductCategory = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN '5' END
        ,drvTermDepEffectiveDate =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLFEC_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStartDate, '4/1/2021') END
                                    WHEN VLFEF_DedCode IS NOT NULL THEN
                                        CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                    END
        ,drvTermDepEligibilityEvent =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFEC_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvTermDepPlanID = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'ETL0CDPVAL' END
        ,drvTermDepFamCoverageInd = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'C' END
        ,drvTermDepApprovedAmtEffDate =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFEC_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStartDate, '4/1/2021') END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                        END
        ,drvTermDepApprovedAmt =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN FORMAT(VLFEC_BenAmt, REPLICATE('0',10))
                                        WHEN VLFEF_DedCode IS NOT NULL THEN    FORMAT(VLFEF_BenAmt, REPLICATE('0',10))
                                    END


        ,drvAddEEProductCategory = CASE WHEN VLIFE_DedCode IS NOT NULL THEN 'c' END
        ,drvAddEEEffectiveDate =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLIFE_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStartDate, '4/1/2021') END
                                    END
        ,drvAddEEEligibilityEvent =    CASE WHEN VLIFE_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLIFE_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                    END
        ,drvAddEEPlanID = CASE WHEN VLIFE_DedCode IS NOT NULL THEN 'BTA0CEEVAL' END
        ,drvAddEEFamCoverageInd = CASE WHEN VLIFE_DedCode IS NOT NULL THEN 'C' END
        ,drvAddEEApprovedAmtEffDate = CASE WHEN VLIFE_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', VLIFE_BenStartDate, '4/1/2021') END
        ,drvAddEEApprovedAmt = CASE WHEN VLIFE_DedCode IS NOT NULL THEN FORMAT(VLIFE_BenAmt, REPLICATE('0',10)) END



        ,drvAddSPSProductCategory = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'e' END
        ,drvAddSPSEffectiveDate =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLFES_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStartDate, '4/1/2021') END
                                    WHEN VLFEF_DedCode IS NOT NULL THEN
                                        CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                    END
        ,drvAddSPSEligibilityEvent =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFES_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvAddSPSPlanID = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'BTA0CSPVAL' END
        ,drvAddSPSFamCoverageInd = CASE WHEN VLFES_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'C' END
        ,drvAddSPSApprovedAmtEffDate =    CASE WHEN VLFES_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFES_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFES_BenStartDate, '4/1/2021') END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                        END
        ,drvAddSPSApprovedAmt =    CASE WHEN VLFES_DedCode IS NOT NULL THEN FORMAT(VLFES_BenAmt, REPLICATE('0',10))
                                    WHEN VLFEF_DedCode IS NOT NULL THEN    FORMAT(VLFEF_BenAmt, REPLICATE('0',10))
                                END


        ,drvAddDepProductCategory = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'd' END
        ,drvAddDepEffectiveDate =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                        CASE WHEN VLFEC_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStartDate, '4/1/2021') END
                                    WHEN VLFEF_DedCode IS NOT NULL THEN
                                        CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                    END
        ,drvAddDepEligibilityEvent =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFEC_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvAddDepPlanID = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'BTA0CDPVAL' END
        ,drvAddDepFamCoverageInd = CASE WHEN VLFEC_DedCode IS NOT NULL OR VLFEF_DedCode IS NOT NULL THEN 'C' END
        ,drvAddDepApprovedAmtEffDate =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN 
                                            CASE WHEN VLFEC_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEC_BenStartDate, '4/1/2021') END
                                        WHEN VLFEF_DedCode IS NOT NULL THEN
                                            CASE WHEN VLFEF_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', VLFEF_BenStartDate, '4/1/2021') END
                                        END
        ,drvAddDepApprovedAmt =    CASE WHEN VLFEC_DedCode IS NOT NULL THEN FORMAT(VLFEC_BenAmt, REPLICATE('0',10))
                                    WHEN VLFEF_DedCode IS NOT NULL THEN    FORMAT(VLFEF_BenAmt, REPLICATE('0',10))
                                END


        ,drvVolSTDProductCategory = CASE WHEN STD_DedCode IS NOT NULL THEN 'Q' END
        ,drvVolSTDEffectiveDate = CASE WHEN STD_DedCode IS NOT NULL THEN 
                                        CASE WHEN STD_BenStatus = 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', STD_BenStopDate, '4/1/2021') ELSE dbo.dsi_fnGetMinMaxDates('MAX', STD_BenStartDate, '4/1/2021') END
                                    END
        ,drvVolSTDEligibilityEvent =    CASE WHEN STD_DedCode IS NOT NULL THEN 
                                            CASE WHEN STD_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvVolSTDPlanID = CASE WHEN STD_DedCode IS NOT NULL THEN 'YTS000CSAL' END
        ,drvVolSTDFamCoverageInd = CASE WHEN STD_DedCode IS NOT NULL THEN 'C' END

    INTO dbo.U_EMOOSVAEXP_drvTbl
    FROM dbo.U_EMOOSVAEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EMOOSVAEXP WITH (NOLOCK)
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmRecType, BdmDepRecId
                ,MAX(CASE WHEN BdmDedCode = 'VLIFE' THEN BdmDedCode END) AS VLIFE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStatus END) AS VLIFE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStartDate END) AS VLIFE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VLIFE' THEN BdmBenStopDate END) AS VLIFE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VLIFE' THEN EedBenAmt END) AS VLIFE_BenAmt

                ,MAX(CASE WHEN BdmDedCode = 'VLFES' THEN BdmDedCode END) AS VLFES_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLFES' THEN BdmBenStatus END) AS VLFES_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VLFES' THEN BdmBenStartDate END) AS VLFES_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFES' THEN BdmBenStopDate END) AS VLFES_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFES' THEN EedBenAmt END) AS VLFES_BenAmt

                ,MAX(CASE WHEN BdmDedCode = 'VLFEF' THEN BdmDedCode END) AS VLFEF_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLFEF' THEN BdmBenStatus END) AS VLFEF_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VLFEF' THEN BdmBenStartDate END) AS VLFEF_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFEF' THEN BdmBenStopDate END) AS VLFEF_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFEF' THEN EedBenAmt END) AS VLFEF_BenAmt

                ,MAX(CASE WHEN BdmDedCode = 'VLFEC' THEN BdmDedCode END) AS VLFEC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VLFEC' THEN BdmBenStatus END) AS VLFEC_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'VLFEC' THEN BdmBenStartDate END) AS VLFEC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFEC' THEN BdmBenStopDate END) AS VLFEC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'VLFEC' THEN EedBenAmt END) AS VLFEC_BenAmt

                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) AS STD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStatus END) AS STD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS STD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_BenStopDate

            FROM dbo.U_dsi_BDM_EMOOSVAEXP WITH (NOLOCK)
            JOIN dbo.EmpDed WITH (NOLOCK)
                ON BdmEEID = EedEEID
                AND BdmDedCode = EedDedCode
            GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecID ) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
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
ALTER VIEW dbo.dsi_vwEMOOSVAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMOOSVAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMOOSVAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108201'
       ,expStartPerControl     = '202108201'
       ,expLastEndPerControl   = '202108279'
       ,expEndPerControl       = '202108279'
WHERE expFormatCode = 'EMOOSVAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMOOSVAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMOOSVAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort