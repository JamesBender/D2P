SET NOCOUNT ON;
IF OBJECT_ID('U_EMOALSTDVL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMOALSTDVL_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMOALSTDVL_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMOALSTDVL' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMOALSTDVL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMOALSTDVL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMOALSTDVL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMOALSTDVL];
GO
IF OBJECT_ID('U_EMOALSTDVL_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMOALSTDVL_PEarHist];
GO
IF OBJECT_ID('U_EMOALSTDVL_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMOALSTDVL_PDedHist];
GO
IF OBJECT_ID('U_EMOALSTDVL_File') IS NOT NULL DROP TABLE [dbo].[U_EMOALSTDVL_File];
GO
IF OBJECT_ID('U_EMOALSTDVL_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMOALSTDVL_EEList];
GO
IF OBJECT_ID('U_EMOALSTDVL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMOALSTDVL_drvTbl];
GO
IF OBJECT_ID('U_EMOALSTDVL_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMOALSTDVL_DedList];
GO
IF OBJECT_ID('U_EMOALSTDVL_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMOALSTDVL_AuditFields];
GO
IF OBJECT_ID('U_EMOALSTDVL_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMOALSTDVL_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMOALSTDVL') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMOALSTDVL];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMOALSTDVL';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMOALSTDVL';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMOALSTDVL';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMOALSTDVL';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMOALSTDVL';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMOALSTDVL','MofO BLife, AD&D, LTD, STD & Vol Lfe Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMOALSTDVLZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMOALSTDVL' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransDate"','1','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1',NULL,'Trans Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"G000BN9Y"','2','(''DA''=''F'')','EMOALSTDVLZ0','8','D','10','9',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','3','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','17',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','4','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','18',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''F'')','EMOALSTDVLZ0','35','D','10','28',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''F'')','EMOALSTDVLZ0','26','D','10','63',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','7','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','89',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','8','(''UD112''=''F'')','EMOALSTDVLZ0','19','D','10','90',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EMOALSTDVLZ0','40','D','10','109',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EMOALSTDVLZ0','80','D','10','149',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','EMOALSTDVLZ0','19','D','10','229',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','EMOALSTDVLZ0','2','D','10','248',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EMOALSTDVLZ0','59','D','10','250',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','14','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','309',NULL,'Date of Hire (DOH)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEffectiveDate"','15','(''UD112''=''F'')','EMOALSTDVLZ0','76','D','10','317',NULL,'Employee Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillGroupEffectiveDate"','16','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','393',NULL,'Bill Group Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','17','(''DA''=''F'')','EMOALSTDVLZ0','74','D','10','401',NULL,'Bill Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSalaryEffectiveDate"','18','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','475',NULL,'Basic Salary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','19','(''DA''=''F'')','EMOALSTDVLZ0','1','D','10','483',NULL,'Basic Salary Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSalaryAmount"','20','(''UA''=''F'')','EMOALSTDVLZ0','16','D','10','484',NULL,'Basic Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv1stAddCompEffDate"','21','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','500',NULL,'1st Additional Compensation Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','22','(''DA''=''F'')','EMOALSTDVLZ0','1','D','10','508',NULL,'1st Additional Compensation Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','23','(''DA''=''F'')','EMOALSTDVLZ0','2','D','10','509',NULL,'1st Additional Compensation Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv1stAddCompAmt"','24','(''UA''=''F'')','EMOALSTDVLZ0','16','D','10','511',NULL,'1st Additional Compensation Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv2ndAddCompEffDate"','25','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','527',NULL,'2nd Additional Compensation Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','26','(''DA''=''F'')','EMOALSTDVLZ0','1','D','10','535',NULL,'2nd Additional Compensation Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"03"','27','(''DA''=''F'')','EMOALSTDVLZ0','2','D','10','536',NULL,'2nd Additional Compensation Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv2ndAddCompAmt"','28','(''UA''=''F'')','EMOALSTDVLZ0','70','D','10','538',NULL,'2nd Additional Compensation Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassEffectiveDate"','29','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','608',NULL,'Class Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassID"','30','(''UA''=''F'')','EMOALSTDVLZ0','194','D','10','616',NULL,'Class ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLProductCategory"','31','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','810',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLEffectiveDate"','32','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','811',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLEligibiltyEvent"','33','(''UA''=''F'')','EMOALSTDVLZ0','2','D','10','819',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLPlanID"','34','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','821',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLFamilyCoverageInd"','35','(''UA''=''F'')','EMOALSTDVLZ0','34','D','10','831',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBADDProductCategory"','36','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','865',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBADDEffectiveDate"','37','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','866',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBADDEligibiltyEvent"','38','(''UA''=''F'')','EMOALSTDVLZ0','2','D','10','874',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBADDPlanID"','39','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','876',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBADDFamilyCoverageInd"','40','(''UA''=''F'')','EMOALSTDVLZ0','34','D','10','886',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBSTDProductCategory"','41','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','920',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBSTDEffectiveDate"','42','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','921',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBSTDEligibiltyEvent"','43','(''UA''=''F'')','EMOALSTDVLZ0','2','D','10','929',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBSTDPlanID"','44','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','931',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBSTDFamilyCoverageInd"','45','(''UA''=''F'')','EMOALSTDVLZ0','34','D','10','941',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLTDProductCategory"','46','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','975',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLTDEffectiveDate"','47','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','976',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLTDEligibiltyEvent"','48','(''UA''=''F'')','EMOALSTDVLZ0','2','D','10','984',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLTDPlanID"','49','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','986',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLTDFamilyCoverageInd"','50','(''UA''=''F'')','EMOALSTDVLZ0','34','D','10','996',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeEmpProductCat"','51','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','1030',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeEmpEffDate"','52','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1031',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeEmpEligEvent"','53','(''UA''=''F'')','EMOALSTDVLZ0','2','D','10','1039',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeEmpPlanID"','54','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','1041',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeEmpFamilyCvgInd"','55','(''UA''=''F'')','EMOALSTDVLZ0','5','D','10','1051',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeEmpAppAmtEffDte"','56','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1056',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeEmpApprovedAmt"','57','(''UA''=''F'')','EMOALSTDVLZ0','21','D','10','1064',NULL,'Elected and Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeSpsProductCat"','58','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','1085',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeSpsEffDate"','59','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1086',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeSpsEligEvent"','60','(''UA''=''F'')','EMOALSTDVLZ0','2','D','10','1094',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeSpsPlanID"','61','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','1096',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeSpsFamilyCvgInd"','62','(''UA''=''F'')','EMOALSTDVLZ0','5','D','10','1106',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeSpsAppAmtEffDte"','63','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1111',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeSpsApprovedAmt"','64','(''UA''=''F'')','EMOALSTDVLZ0','21','D','10','1119',NULL,'Elected and Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeDepProductCat"','65','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','1140',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeDepEffDate"','66','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1141',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeDepEligEvent"','67','(''UA''=''F'')','EMOALSTDVLZ0','2','D','10','1149',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeDepPlanID"','68','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','1151',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeDepFamilyCvgInd"','69','(''UA''=''F'')','EMOALSTDVLZ0','5','D','10','1161',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeDepAppAmtEffDte"','70','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1166',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolTermLifeDepApprovedAmt"','71','(''UA''=''F'')','EMOALSTDVLZ0','21','D','10','1174',NULL,'Elected and Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovEmpProductCat"','72','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','1195',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovEmpEffDate"','73','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1196',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovEmpEligEvent"','74','(''UA''=''F'')','EMOALSTDVLZ0','2','D','10','1204',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovEmpPlanID"','75','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','1206',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovEmpFamilyCvgInd"','76','(''UA''=''F'')','EMOALSTDVLZ0','5','D','10','1216',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovEmpAppAmtEffDte"','77','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1221',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovEmpApprovedAmt"','78','(''UA''=''F'')','EMOALSTDVLZ0','21','D','10','1229',NULL,'Elected and Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovSpsProductCat"','79','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','1250',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovSpsEffDate"','80','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1251',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovSpsEligEvent"','81','(''UA''=''F'')','EMOALSTDVLZ0','2','D','10','1259',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovSpsPlanID"','82','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','1261',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovSpsFamilyCvgInd"','83','(''UA''=''F'')','EMOALSTDVLZ0','5','D','10','1271',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovSpsAppAmtEffDte"','84','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1276',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovSpsApprovedAmt"','85','(''UA''=''F'')','EMOALSTDVLZ0','21','D','10','1284',NULL,'Elected and Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovDepProductCat"','86','(''UA''=''F'')','EMOALSTDVLZ0','1','D','10','1305',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovDepEffDate"','87','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1306',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovDepEligEvent"','88','(''UA''=''F'')','EMOALSTDVLZ0','2','D','10','1314',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovDepPlanID"','89','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','1316',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovDepFamilyCvgInd"','90','(''UA''=''F'')','EMOALSTDVLZ0','5','D','10','1326',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovDepAppAmtEffDte"','91','(''UD112''=''F'')','EMOALSTDVLZ0','8','D','10','1331',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolADDCovDepApprovedAmt"','92','(''UA''=''F'')','EMOALSTDVLZ0','10','D','10','1339',NULL,'Elected and Approved Amount',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EMOALSTDVL_20201020.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202008139','EMPEXPORT','OEACTIVE','Jul 29 2020  5:44PM','EMOALSTDVL',NULL,NULL,NULL,'202008139','Jul 28 2020  1:56PM','Jul 28 2020  1:56PM','202007011','18','','','202007011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202008139','EMPEXPORT','OEPASSIVE','Jul 29 2020  5:45PM','EMOALSTDVL',NULL,NULL,NULL,'202008139','Jul 28 2020  1:56PM','Jul 28 2020  1:56PM','202007011','860','','','202007011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'BsLfe ADD LTD STD Vol Lfe Exp','202008139','EMPEXPORT','ONDEMAND','Jul 29 2020  5:45PM','EMOALSTDVL',NULL,NULL,NULL,'202008139','Jul 28 2020  1:56PM','Jul 28 2020  1:56PM','202007011','861','','','202007011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202008139','EMPEXPORT','SCHEDULED','Jul 29 2020  5:46PM','EMOALSTDVL',NULL,NULL,NULL,'202008139','Jul 28 2020  1:56PM','Jul 28 2020  1:56PM','202007011','861','','','202007011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202010139','EMPEXPORT','TEST','Oct 13 2020 11:35AM','EMOALSTDVL',NULL,NULL,NULL,'202010139','Oct 13 2020 12:00AM','Dec 30 1899 12:00AM','202009281','906','','','202009281',dbo.fn_GetTimedKey(),NULL,'us3lKiVEN1002',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOALSTDVL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOALSTDVL','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOALSTDVL','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOALSTDVL','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOALSTDVL','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EMOALSTDVL' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EMOALSTDVL' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EMOALSTDVL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMOALSTDVL_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMOALSTDVL','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMOALSTDVL','D10','dbo.U_EMOALSTDVL_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EMOALSTDVL') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMOALSTDVL] (
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
IF OBJECT_ID('U_EMOALSTDVL_Audit') IS NULL
CREATE TABLE [dbo].[U_EMOALSTDVL_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EMOALSTDVL_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMOALSTDVL_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EMOALSTDVL_DedList') IS NULL
CREATE TABLE [dbo].[U_EMOALSTDVL_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EMOALSTDVL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMOALSTDVL_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvTransDate] datetime NOT NULL,
    [drvRelationshipCode] varchar(1) NOT NULL,
    [drvEmployeeID] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvEmployeeEffectiveDate] datetime NULL,
    [drvBillGroupEffectiveDate] datetime NULL,
    [drvBasicSalaryEffectiveDate] datetime NULL,
    [drvBasicSalaryAmount] varchar(24) NULL,
    [drv1stAddCompEffDate] datetime NULL,
    [drv1stAddCompAmt] varchar(24) NULL,
    [drv2ndAddCompEffDate] datetime NULL,
    [drv2ndAddCompAmt] varchar(24) NULL,
    [drvClassEffectiveDate] datetime NULL,
    [drvClassID] varchar(4) NULL,
    [drvBLProductCategory] varchar(1) NULL,
    [drvBLEffectiveDate] datetime NULL,
    [drvBLEligibiltyEvent] varchar(2) NULL,
    [drvBLPlanID] varchar(10) NULL,
    [drvBLFamilyCoverageInd] varchar(1) NULL,
    [drvBADDProductCategory] varchar(1) NULL,
    [drvBADDEffectiveDate] datetime NULL,
    [drvBADDEligibiltyEvent] varchar(2) NULL,
    [drvBADDPlanID] varchar(10) NULL,
    [drvBADDFamilyCoverageInd] varchar(1) NULL,
    [drvBSTDProductCategory] varchar(1) NULL,
    [drvBSTDEffectiveDate] datetime NULL,
    [drvBSTDEligibiltyEvent] varchar(2) NULL,
    [drvBSTDPlanID] varchar(10) NULL,
    [drvBSTDFamilyCoverageInd] varchar(1) NULL,
    [drvBLTDProductCategory] varchar(1) NULL,
    [drvBLTDEffectiveDate] datetime NULL,
    [drvBLTDEligibiltyEvent] varchar(2) NULL,
    [drvBLTDPlanID] varchar(10) NULL,
    [drvBLTDFamilyCoverageInd] varchar(1) NULL,
    [drvVolTermLifeEmpProductCat] varchar(1) NULL,
    [drvVolTermLifeEmpEffDate] datetime NULL,
    [drvVolTermLifeEmpEligEvent] varchar(2) NULL,
    [drvVolTermLifeEmpPlanID] varchar(10) NULL,
    [drvVolTermLifeEmpFamilyCvgInd] varchar(1) NULL,
    [drvVolTermLifeEmpAppAmtEffDte] datetime NULL,
    [drvVolTermLifeEmpApprovedAmt] varchar(24) NULL,
    [drvVolTermLifeSpsProductCat] varchar(1) NULL,
    [drvVolTermLifeSpsEffDate] datetime NULL,
    [drvVolTermLifeSpsEligEvent] varchar(2) NULL,
    [drvVolTermLifeSpsPlanID] varchar(10) NULL,
    [drvVolTermLifeSpsFamilyCvgInd] varchar(1) NULL,
    [drvVolTermLifeSpsAppAmtEffDte] datetime NULL,
    [drvVolTermLifeSpsApprovedAmt] varchar(24) NULL,
    [drvVolTermLifeDepProductCat] varchar(1) NULL,
    [drvVolTermLifeDepEffDate] datetime NULL,
    [drvVolTermLifeDepEligEvent] varchar(2) NULL,
    [drvVolTermLifeDepPlanID] varchar(10) NULL,
    [drvVolTermLifeDepFamilyCvgInd] varchar(1) NULL,
    [drvVolTermLifeDepAppAmtEffDte] datetime NULL,
    [drvVolTermLifeDepApprovedAmt] varchar(24) NULL,
    [drvVolADDCovEmpProductCat] varchar(1) NULL,
    [drvVolADDCovEmpEffDate] datetime NULL,
    [drvVolADDCovEmpEligEvent] varchar(2) NULL,
    [drvVolADDCovEmpPlanID] varchar(10) NULL,
    [drvVolADDCovEmpFamilyCvgInd] varchar(1) NULL,
    [drvVolADDCovEmpAppAmtEffDte] datetime NULL,
    [drvVolADDCovEmpApprovedAmt] varchar(24) NULL,
    [drvVolADDCovSpsProductCat] varchar(1) NULL,
    [drvVolADDCovSpsEffDate] datetime NULL,
    [drvVolADDCovSpsEligEvent] varchar(2) NULL,
    [drvVolADDCovSpsPlanID] varchar(10) NULL,
    [drvVolADDCovSpsFamilyCvgInd] varchar(1) NULL,
    [drvVolADDCovSpsAppAmtEffDte] datetime NULL,
    [drvVolADDCovSpsApprovedAmt] varchar(24) NULL,
    [drvVolADDCovDepProductCat] varchar(1) NULL,
    [drvVolADDCovDepEffDate] datetime NULL,
    [drvVolADDCovDepEligEvent] varchar(2) NULL,
    [drvVolADDCovDepPlanID] varchar(10) NULL,
    [drvVolADDCovDepFamilyCvgInd] varchar(1) NULL,
    [drvVolADDCovDepAppAmtEffDte] datetime NULL,
    [drvVolADDCovDepApprovedAmt] varchar(24) NULL
);
IF OBJECT_ID('U_EMOALSTDVL_EEList') IS NULL
CREATE TABLE [dbo].[U_EMOALSTDVL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMOALSTDVL_File') IS NULL
CREATE TABLE [dbo].[U_EMOALSTDVL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);
IF OBJECT_ID('U_EMOALSTDVL_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMOALSTDVL_PDedHist] (
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
IF OBJECT_ID('U_EMOALSTDVL_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMOALSTDVL_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurAmtYTD_WAGEH] money NULL,
    [PehCurAmtYTD_OVTI] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMOALSTDVL]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Symplr

Created By: James Bender
Business Analyst: Lea King
Create Date: 07/28/2020
Service Request Number: TekP-2020-06-19-0001

Purpose: MofO BLife, AD&D, LTD, STD & Vol Lfe Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMOALSTDVL';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMOALSTDVL';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMOALSTDVL';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMOALSTDVL';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMOALSTDVL' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOALSTDVL', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOALSTDVL', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOALSTDVL', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMOALSTDVL';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMOALSTDVL', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMOALSTDVL';

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
    DELETE FROM dbo.U_EMOALSTDVL_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMOALSTDVL_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BLIFE,BADD,LTD,STD,LIFEC,LIFEE,LIFES';

    IF OBJECT_ID('U_EMOALSTDVL_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMOALSTDVL_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMOALSTDVL_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');


    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHD,CHL,DPC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');

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


    IF OBJECT_ID('U_EMOALSTDVL_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMOALSTDVL_AuditFields;
    CREATE TABLE dbo.U_EMOALSTDVL_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EMOALSTDVL_AuditFields VALUES ('empcomp','eecemplstatus');    

    -- Create audit table
    IF OBJECT_ID('U_EMOALSTDVL_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMOALSTDVL_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EMOALSTDVL_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EMOALSTDVL_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EMOALSTDVL_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate - 30 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMOALSTDVL_Audit ON dbo.U_EMOALSTDVL_Audit (audKey1Value, audKey2Value);




    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMOALSTDVL_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMOALSTDVL_PDedHist;
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
    INTO dbo.U_EMOALSTDVL_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMOALSTDVL_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EMOALSTDVL_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMOALSTDVL_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurAmtYTD_WAGEH           = SUM(CASE WHEN ErnTaxCategory = 'WAGEH' THEN PehCurAmt END)
        ,PehCurAmtYTD_OVTI           = SUM(CASE WHEN ErnTaxCategory = 'OVTI' THEN PehCurAmt END)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EMOALSTDVL_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND 
    PehPerControl BETWEEN CONVERT(VARCHAR(8),DATEADD(YEAR, -1, GETDATE()), 112) + '1' AND CONVERT(VARCHAR(8),GETDATE(), 112) + '9'
    --AND ErnTaxCategory = 'OVTI'
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMOALSTDVL_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMOALSTDVL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMOALSTDVL_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' ' + CASE WHEN BdmRecType = 'EMP' THEN '1' ELSE '2' END
        -- standard fields above and additional driver fields below
        ,drvTransDate = GETDATE()
        ,drvRelationshipCode =    CASE WHEN ConRelationship IN ('SPS','DP') AND ConGender = 'F' THEN 'W'
                                    WHEN ConRelationship IN ('SPS','DP') AND ConGender = 'M' THEN 'H'
                                    WHEN ConRelationship IN ('CHD','CHL','DPC','STC') AND ConGender = 'F' THEN 'D'
                                    WHEN ConRelationship IN ('CHD','CHL','DPC','STC') AND ConGender = 'M' THEN 'S'
                                    ELSE 'M'
                                END
        ,drvEmployeeID = EepSSN
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOFBirth END
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvEmployeeEffectiveDate = CASE WHEN EecDateOfLastHire > '5/1/2020' THEN EecDateOfLastHire ELSE '5/1/2020' END
        ,drvBillGroupEffectiveDate =    CASE  WHEN BdmRecType = 'EMP' THEN 
                                            CASE WHEN EecDateOfLastHire > '5/1/2020' THEN EecDateOfLastHire ELSE '5/1/2020' END
                                        END
        ,drvBasicSalaryEffectiveDate = CASE  WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnGetMinMaxDates('MAX', dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire), '5/1/2020') END -- JCB
        ,drvBasicSalaryAmount = CASE  WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnPadZero(eecannsalary*100,16,0) END
        ,drv1stAddCompEffDate = CASE  WHEN BdmRecType = 'EMP' THEN GETDATE() END
        ,drv1stAddCompAmt = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnPadZero(PehCurAmtYTD_WAGEH*100,16,0) END
        ,drv2ndAddCompEffDate = CASE  WHEN BdmRecType = 'EMP' THEN GETDATE() END
        ,drv2ndAddCompAmt = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnPadZero(PehCurAmtYTD_OVTI*100,16,0) END
        ,drvClassEffectiveDate =    CASE  WHEN BdmRecType = 'EMP' THEN 
                                        CASE WHEN EecDateOfLastHire > '5/1/2020' THEN EecDateOfLastHire ELSE '5/1/2020' END
                                    END
        ,drvClassID =    CASE  WHEN BdmRecType = 'EMP' THEN 
                            CASE WHEN LocAddressState = 'NJ' THEN 'A002' ELSE 'A001' END
                        END


        ,drvBLProductCategory = CASE WHEN BdmRecType = 'EMP' AND BLIFE_DedCode IS NOT NULL THEN '1' END
        ,drvBLEffectiveDate =    CASE WHEN BdmRecType = 'EMP' AND BLIFE_DedCode IS NOT NULL THEN 
                                    dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN BLIFE_BenStatus = 'T' THEN DATEADD(DAY, +1, BLIFE_BenStopDate) ELSE BLIFE_BenStartDate END, '5/1/2020')
                                END
        ,drvBLEligibiltyEvent = CASE WHEN BdmRecType = 'EMP' AND BLIFE_DedCode IS NOT NULL THEN 
                                    CASE WHEN BLIFE_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBLPlanID = CASE WHEN BdmRecType = 'EMP' AND BLIFE_DedCode IS NOT NULL THEN 'LTL00NCSAL' END
        ,drvBLFamilyCoverageInd = CASE WHEN BdmRecType = 'EMP' AND BLIFE_DedCode IS NOT NULL THEN 'C' END



        ,drvBADDProductCategory = CASE WHEN BdmRecType = 'EMP' AND BADD_DedCode IS NOT NULL THEN 'A' END
        ,drvBADDEffectiveDate = CASE WHEN BdmRecType = 'EMP' AND BADD_DedCode IS NOT NULL THEN 
                                    dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN BADD_BenStatus = 'T' THEN DATEADD(DAY, +1, BADD_BenStopDate) ELSE BADD_BenStartDate END, '5/1/2020')
                                END
        ,drvBADDEligibiltyEvent = CASE WHEN BdmRecType = 'EMP' AND BADD_DedCode IS NOT NULL THEN 
                                    CASE WHEN BADD_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBADDPlanID = CASE WHEN BdmRecType = 'EMP' AND BADD_DedCode IS NOT NULL THEN 'ATA00NCSAL' END
        ,drvBADDFamilyCoverageInd =  CASE WHEN BdmRecType = 'EMP' AND BADD_DedCode IS NOT NULL THEN 'C' END


        ,drvBSTDProductCategory = CASE WHEN BdmRecType = 'EMP' AND STD_DedCode IS NOT NULL THEN 'S' END
        ,drvBSTDEffectiveDate = CASE WHEN BdmRecType = 'EMP' AND STD_DedCode IS NOT NULL THEN 
                                    dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN STD_BenStatus = 'T' THEN DATEADD(DAY, +1, STD_BenStopDate) ELSE STD_BenStartDate END, '5/1/2020')
                                END
        ,drvBSTDEligibiltyEvent = CASE WHEN BdmRecType = 'EMP' AND STD_DedCode IS NOT NULL THEN 
                                    CASE WHEN STD_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBSTDPlanID =    CASE WHEN BdmRecType = 'EMP' AND STD_DedCode IS NOT NULL THEN 
                                CASE WHEN LocAddressState = 'NJ' THEN 'STJ00NCSAL' ELSE 'STS00NCSAL' END
                            END
        ,drvBSTDFamilyCoverageInd = CASE WHEN BdmRecType = 'EMP' AND STD_DedCode IS NOT NULL THEN 'C' END


        ,drvBLTDProductCategory =  CASE WHEN BdmRecType = 'EMP' AND LTD_DedCode IS NOT NULL THEN 'T' END
        ,drvBLTDEffectiveDate = CASE WHEN BdmRecType = 'EMP' AND LTD_DedCode IS NOT NULL THEN 
                                    dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LTD_BenStatus = 'T' THEN DATEADD(DAY, +1, LTD_BenStopDate) ELSE LTD_BenStartDate END, '5/1/2020')
                                END
        ,drvBLTDEligibiltyEvent = CASE WHEN BdmRecType = 'EMP' AND LTD_DedCode IS NOT NULL THEN 
                                    CASE WHEN LTD_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBLTDPlanID = CASE WHEN BdmRecType = 'EMP' AND LTD_DedCode IS NOT NULL THEN 'TTT00NCSAL' END
        ,drvBLTDFamilyCoverageInd = CASE WHEN BdmRecType = 'EMP' AND LTD_DedCode IS NOT NULL THEN 'C' END


        ,drvVolTermLifeEmpProductCat = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN '3' END
        ,drvVolTermLifeEmpEffDate =    CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN 
                                        dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LIFEE_BenStatus = 'T' THEN DATEADD(DAY, +1, LIFEE_BenStopDate) ELSE LIFEE_BenStartDate END, '5/1/2020')
                                    END
        ,drvVolTermLifeEmpEligEvent =    CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN 
                                            CASE WHEN LIFEE_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvVolTermLifeEmpPlanID = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN 'ETL0CEEVAL' END
        ,drvVolTermLifeEmpFamilyCvgInd = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN 'C' END
        ,drvVolTermLifeEmpAppAmtEffDte = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN LIFEE_BenStartDate END
        ,drvVolTermLifeEmpApprovedAmt = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN dbo.dsi_fnPadZero(LIFEE_BenAmt,10,0) END   -- JCB
        

        ,drvVolTermLifeSpsProductCat = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN '4' END
        ,drvVolTermLifeSpsEffDate =    CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 
                                        dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LIFES_BenStatus = 'T' THEN DATEADD(DAY, +1, LIFES_BenStopDate) ELSE LIFES_BenStartDate END, '5/1/2020')
                                    END
        ,drvVolTermLifeSpsEligEvent =    CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 
                                            CASE WHEN LIFEE_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvVolTermLifeSpsPlanID = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 'ETL0CSPVAL' END
        ,drvVolTermLifeSpsFamilyCvgInd = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 'C' END
        ,drvVolTermLifeSpsAppAmtEffDte = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN LIFES_BenStartDate END
        ,drvVolTermLifeSpsApprovedAmt = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN dbo.dsi_fnPadZero(LIFES_BenAmt,10,0) END


        ,drvVolTermLifeDepProductCat = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN '5' END
        ,drvVolTermLifeDepEffDate = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 
                                        dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LIFEC_BenStatus = 'T' THEN DATEADD(DAY, +1, LIFEC_BenStopDate) ELSE LIFEC_BenStartDate END, '5/1/2020')
                                    END
        ,drvVolTermLifeDepEligEvent =    CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 
                                            CASE WHEN LIFEC_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                        END
        ,drvVolTermLifeDepPlanID = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 'ETL0CDPVAL' END
        ,drvVolTermLifeDepFamilyCvgInd = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 'C' END
        ,drvVolTermLifeDepAppAmtEffDte = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN LIFEC_BenStartDate END
        ,drvVolTermLifeDepApprovedAmt = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN dbo.dsi_fnPadZero(LIFEC_BenAmt,10,0) END -- JCB


        ,drvVolADDCovEmpProductCat = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN 'c' END
        ,drvVolADDCovEmpEffDate = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN 
                                        dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LIFEE_BenStatus = 'T' THEN DATEADD(DAY, +1, LIFEE_BenStopDate) ELSE LIFEE_BenStartDate END, '5/1/2020')
                                    END
        ,drvVolADDCovEmpEligEvent = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN 
                                        CASE WHEN LIFEE_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                    END
        ,drvVolADDCovEmpPlanID = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN 'BTA0CEEVAL' END
        ,drvVolADDCovEmpFamilyCvgInd = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN 'C' END
        ,drvVolADDCovEmpAppAmtEffDte = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN LIFEE_BenStartDate END
        ,drvVolADDCovEmpApprovedAmt = CASE WHEN BdmRecType = 'EMP' AND LIFEE_DedCode IS NOT NULL THEN dbo.dsi_fnPadZero(LIFEE_BenAmt,10,0) END


        ,drvVolADDCovSpsProductCat = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 'e' END
        ,drvVolADDCovSpsEffDate = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 
                                    dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LIFES_BenStatus = 'T' THEN DATEADD(DAY, +1, LIFES_BenStopDate) ELSE LIFES_BenStartDate END, '5/1/2020')
                                END
        ,drvVolADDCovSpsEligEvent = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 
                                        CASE WHEN LIFEE_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                    END
        ,drvVolADDCovSpsPlanID = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 'BTA0CSPVAL' END
        ,drvVolADDCovSpsFamilyCvgInd = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN 'C' END
        ,drvVolADDCovSpsAppAmtEffDte = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN LIFES_BenStartDate END
        ,drvVolADDCovSpsApprovedAmt = CASE WHEN BdmRecType = 'EMP' AND LIFES_DedCode IS NOT NULL THEN dbo.dsi_fnPadZero(LIFES_BenAmt,10,0) END


        ,drvVolADDCovDepProductCat = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 'd' END
        ,drvVolADDCovDepEffDate =    CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 
                                        dbo.dsi_fnGetMinMaxDates('MAX', CASE WHEN LIFEC_BenStatus = 'T' THEN DATEADD(DAY, +1, LIFEC_BenStopDate) ELSE LIFEC_BenStartDate END, '5/1/2020')
                                    END
        ,drvVolADDCovDepEligEvent = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 
                                        CASE WHEN LIFEC_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                    END
        ,drvVolADDCovDepPlanID = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 'BTA0CDPVAL' END
        ,drvVolADDCovDepFamilyCvgInd = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN 'C' END
        ,drvVolADDCovDepAppAmtEffDte = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN LIFEC_BenStartDate END
        ,drvVolADDCovDepApprovedAmt = CASE WHEN BdmRecType = 'EMP' AND LIFEC_DedCode IS NOT NULL THEN dbo.dsi_fnPadZero(LIFEC_BenAmt,10,0) END


    INTO dbo.U_EMOALSTDVL_drvTbl
    FROM dbo.U_EMOALSTDVL_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (EecEmplStatus <> 'T'
             OR (EecEmplStatus= 'T' AND EecTermReason <>'TRO' 
                AND EXISTS(    SELECT 1    
                            FROM dbo.U_EMOALSTDVL_Audit WITH (NOLOCK)
                            WHERE  AudKey1Value = xEEID 
                            AND AudKey2Value = xCOID 
                            AND Audfieldname = 'eecemplstatus' and AudNewValue = 'T'
                        )
                )
            )
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID    
--    JOIN dbo.U_dsi_BDM_EMOALSTDVL WITH (NOLOCK)
--        ON BdmEEID = xEEID 
--        AND BdmCoID = xCoID
    JOIN dbo.U_EMOALSTDVL_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
                ,MAX(CASE WHEN BdmDedCode = 'BLIFE' THEN BdmDedCode END) AS BLIFE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'BADD' THEN BdmDedCode END) AS BADD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmDedCode END) AS LTD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) AS STD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) AS LIFEC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) AS LIFEE_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) AS LIFES_DedCode    
                ,MAX(CASE WHEN BdmDedCode = 'BLIFE' THEN BdmBenStatus END) AS BLIFE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'BADD' THEN BdmBenStatus END) AS BADD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStatus END) AS LTD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStatus END) AS STD_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStatus END) AS LIFEC_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStatus END) AS LIFEE_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStatus END) AS LIFES_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'BLIFE' THEN BdmBenStartDate END) AS BLIFE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'BADD' THEN BdmBenStartDate END) AS BADD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStartDate END) AS LTD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS STD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStartDate END) AS LIFEC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStartDate END) AS LIFEE_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStartDate END) AS LIFES_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'BLIFE' THEN BdmBenStopDate END) AS BLIFE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'BADD' THEN BdmBenStopDate END) AS BADD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStopDate END) AS LTD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStopDate END) AS LIFEC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStopDate END) AS LIFEE_BenStopDate
                ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStopDate END) AS LIFES_BenStopDate
            FROM dbo.U_dsi_BDM_EMOALSTDVL WITH (NOLOCK)
            GROUP BY BdmRecType, BdmEEID, BdmCOID , BdmDepRecID
        ) AS DedCodes
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN (
                SELECT EdhEEID, EdhCOID
                    ,MAX(CASE WHEN EdhDedCode = 'LIFEE' THEN EdhEEBenAmt END) AS LIFEE_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'LIFES' THEN EdhEEBenAmt END) AS LIFES_BenAmt
                    ,MAX(CASE WHEN EdhDedCode = 'LIFEC' THEN EdhEEBenAmt END) AS LIFEC_BenAmt
                FROM (
                        SELECT EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt
                        FROM (
                                SELECT EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhBenStartDate DESC) AS RN
                                FROM dbo.EmpHDed WITH (NOLOCK) 
                                WHERE EdhDedCode IN ('LIFEE', 'LIFES', 'LIFEC') 
                                    AND EdhBenStatus = 'A') AS T
                WHERE RN = 1) AS Y
                GROUP BY EdhEEID, EdhCOID
            ) AS Life_Amount
        ON EdhEEID = xEEID
        AND EdhCOID = XCOID
    ;

    /*

    
SELECT EjhEEID, EjhCOID, EjhJobEffDate
FROM (
SELECT EjhEEID, EjhCOID, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
FROM dbo.EmpHJob WITH (NOLOCK)
WHERE EjhIsRateChange = 'Y'
) AS X
WHERE RN = 1
AND EjhEEID = 'BSDK5W03Q0K0'


*/

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
ALTER VIEW dbo.dsi_vwEMOALSTDVL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMOALSTDVL_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMOALSTDVL%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007011'
       ,expStartPerControl     = '202007011'
       ,expLastEndPerControl   = '202008139'
       ,expEndPerControl       = '202008139'
WHERE expFormatCode = 'EMOALSTDVL';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMOALSTDVL_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMOALSTDVL_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort