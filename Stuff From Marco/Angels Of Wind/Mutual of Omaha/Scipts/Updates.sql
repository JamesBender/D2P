SET NOCOUNT ON;
IF OBJECT_ID('U_EMUTOMAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMAEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMUTOMAEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMUTOMAEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMUTOMAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMUTOMAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMUTOMAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMUTOMAEXP];
GO
IF OBJECT_ID('U_EMUTOMAEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMAEXP_PEarHist];
GO
IF OBJECT_ID('U_EMUTOMAEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMAEXP_PDedHist];
GO
IF OBJECT_ID('U_EMUTOMAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMAEXP_File];
GO
IF OBJECT_ID('U_EMUTOMAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMAEXP_EEList];
GO
IF OBJECT_ID('U_EMUTOMAEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMAEXP_drvTbl];
GO
IF OBJECT_ID('U_EMUTOMAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMAEXP_DedList];
GO
IF OBJECT_ID('U_EMUTOMAEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMAEXP_AuditFields];
GO
IF OBJECT_ID('U_EMUTOMAEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMAEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMUTOMAEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMUTOMAEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMUTOMAEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMUTOMAEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMUTOMAEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMUTOMAEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMUTOMAEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMUTOMAEXP','Mutual of Omaha Benefit Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1876','S','N','EMUTOMAEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransDate"','1','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1',NULL,'Trans Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupId"','2','(''UA''=''F'')','EMUTOMAEXPZ0','8','D','10','9',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationShipCode"','3','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','17',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','4','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','18',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','5','(''UA''=''F'')','EMUTOMAEXPZ0','35','D','10','28',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','6','(''UA''=''F'')','EMUTOMAEXPZ0','26','D','10','63',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGenderCode"','7','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','89',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','8','(''UD112''=''F'')','EMUTOMAEXPZ0','19','D','10','90',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''F'')','EMUTOMAEXPZ0','40','D','10','109',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''F'')','EMUTOMAEXPZ0','80','D','10','149',NULL,'Address Line 2',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','11','(''UA''=''F'')','EMUTOMAEXPZ0','19','D','10','229',NULL,'City',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','12','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','248',NULL,'State',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','13','(''UA''=''F'')','EMUTOMAEXPZ0','59','D','10','250',NULL,'Zip Code',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHire"','14','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','309',NULL,'Date of Hire (DOH)',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpEffectiveDate"','15','(''UD112''=''F'')','EMUTOMAEXPZ0','75','D','10','317',NULL,'Employee Effective Date',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillGroupEffDate"','16','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','393',NULL,'Bill Group Effective Date',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillGroupId"','17','(''UA''=''F'')','EMUTOMAEXPZ0','74','D','10','401',NULL,'Bill Group ID',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSalaryEffDate"','18','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','475',NULL,'Basic Salary Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSalMode"','19','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','483',NULL,'Basic Salary Mode',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSalAmt"','20','(''UA''=''F'')','EMUTOMAEXPZ0','124','D','10','484',NULL,'Basic Salary Amount',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBLifeEffDate"','21','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','608',NULL,'Class Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassBLife"','22','(''UA''=''F'')','EMUTOMAEXPZ0','194','D','10','616',NULL,'Class ID',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassBLifeProdCat"','23','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','810',NULL,'Product Category',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassBlifeEffDate"','24','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','811',NULL,'Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassBlifeEligEvent"','25','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','819',NULL,'Eligibility Event',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassBlifePlanId"','26','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','821',NULL,'Plan ID',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassBlifeFamCovInd"','27','(''UA''=''F'')','EMUTOMAEXPZ0','34','D','10','831',NULL,'Family Coverage Indicator',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDProdCat"','28','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','865',NULL,'Product Category',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEffDAte"','29','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','866',NULL,'Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEligEvent"','30','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','874',NULL,'Eligibility Event',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEPlanId"','31','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','876',NULL,'Plan ID',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDFamInd"','32','(''UA''=''F'')','EMUTOMAEXPZ0','34','D','10','886',NULL,'Family Coverage Indicator',NULL,NULL); --
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSTDProdCat"','33','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','920',NULL,'Product Category',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSTDEffDAte"','34','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','921',NULL,'Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSTDEligEvent"','35','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','929',NULL,'Eligibility Event',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSTDPlanId"','36','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','931',NULL,'Plan ID',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSTDFamInd"','37','(''UA''=''F'')','EMUTOMAEXPZ0','34','D','10','941',NULL,'Family Coverage Indicator',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLTDProdCat"','38','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','975',NULL,'Product Category',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLTDEffDAte"','39','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','976',NULL,'Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLTDEligEvent"','40','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','984',NULL,'Eligibility Event',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLTDPlanId"','41','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','986',NULL,'Plan ID',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLTDFamInd"','42','(''UA''=''F'')','EMUTOMAEXPZ0','34','D','10','996',NULL,'Family Coverage Indicator',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFEEProdCat"','43','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','1030',NULL,'Product Category',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFEEEffDAte"','44','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1031',NULL,'Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFEEEligEvent"','45','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','1039',NULL,'Eligibility Event',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFEEPlanId"','46','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','1041',NULL,'Plan ID',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFEEFamInd"','47','(''UA''=''F'')','EMUTOMAEXPZ0','5','D','10','1051',NULL,'Family Coverage Indicator',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFEEApprovedEffDate"','48','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1056',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFEEApprovedEffAmt"','49','(''UA''=''F'')','EMUTOMAEXPZ0','21','D','10','1064',NULL,'Elected and Approved Amount',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFESProdCat"','50','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','1085',NULL,'Product Category',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFESEffDAte"','51','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1086',NULL,'Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFCEligEvent"','52','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','1094',NULL,'Eligibility Event',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFESPlanId"','53','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','1096',NULL,'Plan ID',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFESFamInd"','54','(''UA''=''F'')','EMUTOMAEXPZ0','5','D','10','1106',NULL,'Family Coverage Indicator',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFESApprovedEffDate"','55','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1111',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFESApprovedEffAmt"','56','(''UA''=''F'')','EMUTOMAEXPZ0','21','D','10','1119',NULL,'Elected and Approved Amount',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFECProdCat"','57','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','1140',NULL,'Product Category',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFECEffDAte"','58','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1141',NULL,'Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFECEligEvent"','59','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','1149',NULL,'Eligibility Event',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFECPlanId"','60','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','1151',NULL,'Plan ID',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFECFamInd"','61','(''UA''=''F'')','EMUTOMAEXPZ0','5','D','10','1161',NULL,'Family Coverage Indicator',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFECApprovedEffDate"','62','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1166',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLIFECApprovedEffAmt"','63','(''UA''=''F'')','EMUTOMAEXPZ0','21','D','10','1174',NULL,'Elected and Approved Amount',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEProdCat"','64','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','1195',NULL,'Product Category',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEEffDAte"','65','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1196',NULL,'Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEEligEvent"','66','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','1204',NULL,'Eligibility Event',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDPlanId"','67','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','1206',NULL,'Plan ID',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEFamInd"','68','(''UA''=''F'')','EMUTOMAEXPZ0','5','D','10','1216',NULL,'Family Coverage Indicator',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEApprovedEffDate"','69','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1221',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEApprovedEffAmt"','70','(''UA''=''F'')','EMUTOMAEXPZ0','21','D','10','1229',NULL,'Elected and Approved Amount',NULL,NULL);--
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDSProdCat"','71','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','1250',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDSEffDAte"','72','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1251',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDSEligEvent"','73','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','1259',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDSPlanId"','74','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','1261',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDSFamInd"','75','(''UA''=''F'')','EMUTOMAEXPZ0','5','D','10','1271',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDSApprovedEffDate"','76','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1276',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDSApprovedEffAmt"','77','(''UA''=''F'')','EMUTOMAEXPZ0','21','D','10','1284',NULL,'Elected and Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDCProdCat"','78','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','1305',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDCEffDAte"','79','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1306',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDCEligEvent"','80','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','1314',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDCPlanId"','81','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','1316',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDCFamInd"','82','(''UA''=''F'')','EMUTOMAEXPZ0','5','D','10','1326',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDCApprovedEffDate"','83','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1331',NULL,'Elected and Approved Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDCApprovedEffAmt"','84','(''UA''=''F'')','EMUTOMAEXPZ0','516','D','10','1339',NULL,'Elected and Approved Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolAccProdCategory"','85','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','1855',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolAccEffDate"','86','(''UD112''=''F'')','EMUTOMAEXPZ0','8','D','10','1856',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolAccEligEvent"','87','(''UA''=''F'')','EMUTOMAEXPZ0','2','D','10','1864',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolAccPlanId"','88','(''UA''=''F'')','EMUTOMAEXPZ0','10','D','10','1866',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolAccFamInd"','89','(''UA''=''F'')','EMUTOMAEXPZ0','1','D','10','1876',NULL,'Family Coverage Indicator',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMUTOMAEXP_20200210.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual of Omaha Benefit Export','202001149','EMPEXPORT','ONDEMAND',NULL,'EMUTOMAEXP',NULL,NULL,NULL,'202001149','Jan 14 2020  4:23PM','Jan 14 2020  4:23PM','202001141',NULL,'','','202001141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMUTOMAEXP_20200210.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202001149','EMPEXPORT','SCHEDULED',NULL,'EMUTOMAEXP',NULL,NULL,NULL,'202001149','Jan 14 2020  4:23PM','Jan 14 2020  4:23PM','202001141',NULL,'','','202001141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMUTOMAEXP_20200210.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202001149','EMPEXPORT','OEACTIVE',NULL,'EMUTOMAEXP',NULL,NULL,NULL,'202001149','Jan 14 2020  4:23PM','Jan 14 2020  4:23PM','202001141',NULL,'','','202001141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMUTOMAEXP_20200210.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202001149','EMPEXPORT','OEPASSIVE',NULL,'EMUTOMAEXP',NULL,NULL,NULL,'202001149','Jan 14 2020  4:23PM','Jan 14 2020  4:23PM','202001141',NULL,'','','202001141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMUTOMAEXP_20200210.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202002109','EMPEXPORT','TEST','Feb 10 2020 10:55AM','EMUTOMAEXP',NULL,NULL,NULL,'202002109','Feb 10 2020 12:00AM','Dec 30 1899 12:00AM','202001271','832','','','202001271',dbo.fn_GetTimedKey(),NULL,'us3lKiANG1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EMUTOMAEXP_20200210.txt' END WHERE expFormatCode = 'EMUTOMAEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMAEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMAEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EMUTOMAEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMUTOMAEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EMUTOMAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMAEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMUTOMAEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMUTOMAEXP','D10','dbo.U_EMUTOMAEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EMUTOMAEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMUTOMAEXP] (
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
IF OBJECT_ID('U_EMUTOMAEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EMUTOMAEXP_Audit] (
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
IF OBJECT_ID('U_EMUTOMAEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMUTOMAEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EMUTOMAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EMUTOMAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EMUTOMAEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMUTOMAEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvTransDate] datetime NOT NULL,
    [drvGroupId] varchar(8) NOT NULL,
    [drvRelationShipCode] varchar(1) NOT NULL,
    [drvEmployeeId] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvGenderCode] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(1) NOT NULL,
    [drvCity] varchar(1) NOT NULL,
    [drvState] varchar(1) NOT NULL,
    [drvZipCode] varchar(1) NOT NULL,
    [drvDateofHire] datetime NULL,
    [drvEmpEffectiveDate] datetime NULL,
    [drvBillGroupEffDate] datetime NULL,
    [drvBillGroupId] varchar(3) NOT NULL,
    [drvBasicSalaryEffDate] datetime NULL,
    [drvBasicSalMode] varchar(1) NOT NULL,
    [drvBasicSalAmt] varchar(24) NULL,
    [drvBLifeEffDate] datetime NULL,
    [drvClassBLife] varchar(4) NOT NULL,
    [drvClassBLifeProdCat] varchar(1) NULL,
    [drvClassBlifeEffDate] datetime NULL,
    [drvClassBlifeEligEvent] varchar(2) NULL,
    [drvClassBlifePlanId] varchar(10) NULL,
    [drvClassBlifeFamCovInd] varchar(1) NULL,
    [drvBasicADDProdCat] varchar(1) NULL,
    [drvBasicADDEffDAte] datetime NULL,
    [drvBasicADDEligEvent] varchar(2) NULL,
    [drvBasicADDEPlanId] varchar(10) NULL,
    [drvBasicADDFamInd] varchar(1) NULL,
    [drvBasicSTDProdCat] varchar(1) NULL,
    [drvBasicSTDEffDAte] datetime NULL,
    [drvBasicSTDEligEvent] varchar(2) NULL,
    [drvBasicSTDPlanId] varchar(10) NULL,
    [drvBasicSTDFamInd] varchar(1) NULL,
    [drvBasicLTDProdCat] varchar(1) NULL,
    [drvBasicLTDEffDAte] datetime NULL,
    [drvBasicLTDEligEvent] varchar(2) NULL,
    [drvBasicLTDPlanId] varchar(10) NULL,
    [drvBasicLTDFamInd] varchar(1) NULL,
    [drvBasicLIFEEProdCat] varchar(1) NULL,
    [drvBasicLIFEEEffDAte] datetime NULL,
    [drvBasicLIFEEEligEvent] varchar(2) NULL,
    [drvBasicLIFEEPlanId] varchar(10) NULL,
    [drvBasicLIFEEFamInd] varchar(1) NULL,
    [drvBasicLIFEEApprovedEffDate] datetime NULL,
    [drvBasicLIFEEApprovedEffAmt] varchar(24) NULL,
    [drvBasicLIFESProdCat] varchar(1) NULL,
    [drvBasicLIFESEffDAte] datetime NULL,
    [drvBasicLIFCEligEvent] varchar(2) NULL,
    [drvBasicLIFESPlanId] varchar(10) NULL,
    [drvBasicLIFESFamInd] varchar(1) NULL,
    [drvBasicLIFESApprovedEffDate] datetime NULL,
    [drvBasicLIFESApprovedEffAmt] varchar(24) NULL,
    [drvBasicLIFECProdCat] varchar(1) NULL,
    [drvBasicLIFECEffDAte] datetime NULL,
    [drvBasicLIFECEligEvent] varchar(2) NULL,
    [drvBasicLIFECPlanId] varchar(10) NULL,
    [drvBasicLIFECFamInd] varchar(1) NULL,
    [drvBasicLIFECApprovedEffDate] datetime NULL,
    [drvBasicLIFECApprovedEffAmt] varchar(24) NULL,
    [drvBasicADDEProdCat] varchar(1) NULL,
    [drvBasicADDEEffDAte] datetime NULL,
    [drvBasicADDEEligEvent] varchar(2) NULL,
    [drvBasicADDPlanId] varchar(10) NULL,
    [drvBasicADDEFamInd] varchar(1) NULL,
    [drvBasicADDEApprovedEffDate] datetime NULL,
    [drvBasicADDEApprovedEffAmt] varchar(24) NULL,
    [drvBasicADDSProdCat] varchar(1) NULL,
    [drvBasicADDSEffDAte] datetime NULL,
    [drvBasicADDSEligEvent] varchar(2) NULL,
    [drvBasicADDSPlanId] varchar(10) NULL,
    [drvBasicADDSFamInd] varchar(1) NULL,
    [drvBasicADDSApprovedEffDate] datetime NULL,
    [drvBasicADDSApprovedEffAmt] varchar(24) NULL,
    [drvBasicADDCProdCat] varchar(1) NULL,
    [drvBasicADDCEffDAte] datetime NULL,
    [drvBasicADDCEligEvent] varchar(2) NULL,
    [drvBasicADDCPlanId] varchar(10) NULL,
    [drvBasicADDCFamInd] varchar(1) NULL,
    [drvBasicADDCApprovedEffDate] datetime NULL,
    [drvBasicADDCApprovedEffAmt] varchar(24) NULL,
    [drvVolAccProdCategory] varchar(1) NULL,
    [drvVolAccEffDate] datetime NULL,
    [drvVolAccEligEvent] varchar(2) NULL,
    [drvVolAccPlanId] varchar(10) NULL,
    [drvVolAccFamInd] varchar(1) NULL
);
IF OBJECT_ID('U_EMUTOMAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMUTOMAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMUTOMAEXP_File') IS NULL
CREATE TABLE [dbo].[U_EMUTOMAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EMUTOMAEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMUTOMAEXP_PDedHist] (
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
IF OBJECT_ID('U_EMUTOMAEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMUTOMAEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMUTOMAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Angel of the Winds Casino

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/14/2020
Service Request Number: TekP-2019-09-13-0005

Purpose: Mutual of Omaha Benefit Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMUTOMAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMUTOMAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMUTOMAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMUTOMAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMUTOMAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMUTOMAEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMUTOMAEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMUTOMAEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMUTOMAEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMUTOMAEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMUTOMAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EMUTOMAEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate = CAST('9/1/2019' as datetime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EMUTOMAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMUTOMAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ERADD,ERADE,ERADM,ERLTD,ERSTD,GLIFD,GLIFE,GLIFM,LIFEC,LIFEE,LIFES,ADDC,ADDE,ADDS,MVACE';

    IF OBJECT_ID('U_EMUTOMAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMUTOMAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMUTOMAEXP_DedList
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
  INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
  
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

    IF OBJECT_ID('U_EMUTOMAEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMUTOMAEXP_AuditFields;
    CREATE TABLE dbo.U_EMUTOMAEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EMUTOMAEXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EMUTOMAEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMUTOMAEXP_Audit;
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
    INTO dbo.U_EMUTOMAEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EMUTOMAEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EMUTOMAEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate - 30 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMUTOMAEXP_Audit ON dbo.U_EMUTOMAEXP_Audit (audKey1Value, audKey2Value);

    --=========================================

    -- Update BdmChangeReason For Dependents

    --=========================================

    UPDATE D

        SET D.BdmChangeReason = E.BdmChangeReason

    FROM dbo.U_dsi_bdm_EMUTOMAEXP D

    JOIN dbo.U_dsi_bdm_EMUTOMAEXP E

        ON E.BdmEEID = D.BdmEEID

        AND E.BdmCOID = D.BdmCOID

        AND E.BdmDedCode = D.BdmDedCode

    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';



    --=====================================================

    -- Update BdmUSGField2 with EmpDedTVID for Employees

    --=====================================================

    UPDATE dbo.U_dsi_bdm_EMUTOMAEXP

        SET BdmUSGField2 = EedEmpDedTVID

    FROM dbo.U_dsi_bdm_EMUTOMAEXP

    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)

        ON EedEEID = BdmEEID

        AND EedCOID = BdmCOID

        AND EedDedCode = BdmDedCode

    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';



    --=======================================================

    -- Update BdmUSGField2 with DepBPlanTVID for Dependents

    --=======================================================

    UPDATE dbo.U_dsi_bdm_EMUTOMAEXP

        SET BdmUSGField2 = DbnDepBPlanTVID

    FROM dbo.U_dsi_bdm_EMUTOMAEXP

    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)

        ON DbnEEID = BdmEEID

        AND DbnCOID = BdmCOID

        AND DbnDedCode = BdmDedCode

    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';



    --======================================================

    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)

    --======================================================

    UPDATE dbo.U_dsi_bdm_EMUTOMAEXP

        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)

    FROM dbo.U_dsi_bdm_EMUTOMAEXP

    JOIN dbo.EmpDedFull WITH (NOLOCK)

        ON EedEmpDedTVID = BdmUSGField2;


    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMUTOMAEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMUTOMAEXP_PDedHist;
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
    INTO dbo.U_EMUTOMAEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMUTOMAEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EMUTOMAEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMUTOMAEXP_PEarHist;
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
    INTO dbo.U_EMUTOMAEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMUTOMAEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMUTOMAEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMUTOMAEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvTransDate = GETDATE()
        ,drvGroupId = 'G000BGY2'
        ,drvRelationShipCode = CASE WHEN ConRelationShip in ('SPS','DP') and ConGender = 'F' THEN 'W'
                                    WHEN ConRelationShip in ('SPS','DP') and ConGender = 'M' THEN 'H'
                                    WHEN ConRelationShip in ('CHD','CHL','DPC','STC') and ConGender = 'F' THEN 'D'
                                    WHEN ConRelationShip in ('CHD','CHL','DPC','STC') and ConGender = 'M' THEN 'S'
                                    ELSE 'M'
                               END
        ,drvEmployeeId = EepSSN
        ,drvLastName = CASE WHEN BdmRecType = 'EMP' or BdmRecType is null then EepNameLast
                               WHEN BdmRecType = 'DEP' then ConNameLast
                         END
                         
        ,drvFirstName = CASE WHEN BdmRecType = 'EMP' or BdmRecType is null then EepNameFirst
                               WHEN BdmRecType = 'DEP' then ConNameFirst
                         END 
        ,drvGenderCode = CASE WHEN BdmRecType = 'EMP' or BdmRecType is null then EepGender
                               WHEN BdmRecType = 'DEP' then ConGender
                         END 
        ,drvDateofBirth = CASE WHEN BdmRecType = 'EMP' or BdmRecType is null then EepDateOfBirth
                               WHEN BdmRecType = 'DEP' then ConDateOfBirth
                         END  
        ,drvAddressLine1 = ''
        ,drvAddressLine2 = ''
        ,drvCity = ''
        ,drvState = ''
        ,drvZipCode = ''
        ,drvDateofHire = eecdateoforiginalhire
        ,drvEmpEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',eecdateoflasthire , @FileMinCovDate) 
        ,drvBillGroupEffDate = dbo.dsi_fnGetMinMaxDates('MAX',eecdateoflasthire , @FileMinCovDate) 
        ,drvBillGroupId = '001'
        ,drvBasicSalaryEffDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire)
        ,drvBasicSalMode = 'A'
        ,drvBasicSalAmt = dbo.dsi_fnPadZero(CAST(eecannsalary as varchar(12)),16,0) --Format decimal 16 character pad zero
        ,drvBLifeEffDate = dbo.dsi_fnGetMinMaxDates('MAX',eecdateoflasthire , @FileMinCovDate) 
        ,drvClassBLife =   CASE WHEN GLIFM is not null then 'A002'
                                WHEN GLIFD is not null then 'A001'
                                ELSe 'A003'
                            END
        ,drvClassBLifeProdCat = CASE WHEN GLIFM IS NOT NULL or GLIFD IS NOT NULL or GLIFE is not null THEN '1' END 
        ,drvClassBlifeEffDate = CASE WHEN GLIFM is not null then GLIFM_BenefitDate
                                WHEN GLIFD is not null then GLIFD_BenefitDate
                                WHEN GLIFE is not null then GLIFE_BenefitDate
                            END
        ,drvClassBlifeEligEvent =  CASE WHEN GLIFM IS NOT NULL or GLIFD IS NOT NULL or GLIFE is not null THEN
                                        CASE WHEN GLIFM is not null and GLIFM_BenStatus =  'T' then 'TM'
                                               WHEN GLIFD is not null and GLIFD_BenStatus =  'T' then 'TM'
                                               WHEN GLIFE is not null  and GLIFE_BenStatus =  'T' then 'TM'
                                               ELSE 'EN'
                                        END 
                                  END
        ,drvClassBlifePlanId = CASE WHEN GLIFM IS NOT NULL or GLIFD IS NOT NULL or GLIFE is not null THEN 'LTL0NCFLAT' END 
        ,drvClassBlifeFamCovInd = CASE WHEN GLIFM IS NOT NULL or GLIFD IS NOT NULL or GLIFE is not null THEN 'C' END
        ,drvBasicADDProdCat = CASE WHEN ERADD IS NOT NULL OR ERADE IS NOT NULL OR ERADM IS NOT NULL THEN 'A' END
        ,drvBasicADDEffDAte = CASE WHEN ERADD is not null then ERADD_BenefitDate
                                WHEN ERADE is not null then ERADE_BenefitDate
                                WHEN ERADM is not null then ERADM_BenefitDate
                            END
        ,drvBasicADDEligEvent = CASE WHEN ERADD IS NOT NULL OR ERADE IS NOT NULL OR ERADM IS NOT NULL THEN
                                        CASE WHEN ERADD is not null and ERADD_BenStatus =  'T' then 'TM'
                                               WHEN ERADE is not null and ERADE_BenStatus =  'T' then 'TM'
                                               WHEN ERADM is not null  and ERADM_BenStatus =  'T' then 'TM'
                                               ELSE 'EN'
                                        END 
                                  END
        ,drvBasicADDEPlanId = CASE WHEN ERADD IS NOT NULL OR ERADE IS NOT NULL OR ERADM IS NOT NULL THEN 'ATA0NCFLAT' END
        ,drvBasicADDFamInd = CASE WHEN ERADD IS NOT NULL OR ERADE IS NOT NULL OR ERADM IS NOT NULL THEN 'C' END
        ,drvBasicSTDProdCat = CASE WHEN ERSTD IS NOT NULL THEN 'S' END
        ,drvBasicSTDEffDAte = CASE WHEN ERSTD IS NOT NULL THEN ERSTD_BenefitDate END
        ,drvBasicSTDEligEvent = CASE WHEN ERSTD IS NOT NULL THEN
                                            CASE WHEN ERSTD_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBasicSTDPlanId = CASE WHEN ERSTD IS NOT NULL THEN 'STS00NCSAL' END
        ,drvBasicSTDFamInd =  CASE WHEN ERSTD IS NOT NULL THEN 'C' END
        ,drvBasicLTDProdCat = CASE WHEN ERLTD IS NOT NULL THEN 'T' END
        ,drvBasicLTDEffDAte = CASE WHEN ERLTD IS NOT NULL THEN ERLTD_BenefitDate END
        ,drvBasicLTDEligEvent = CASE WHEN ERLTD IS NOT NULL THEN
                                        CASE WHEN  ERLTD_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBasicLTDPlanId = CASE WHEN ERLTD IS NOT NULL THEN 'TTT00NCSAL' END
        ,drvBasicLTDFamInd = CASE WHEN ERLTD IS NOT NULL THEN 'C' END
        ,drvBasicLIFEEProdCat = CASE WHEN LIFEE IS NOT NULL THEN '3' END
        ,drvBasicLIFEEEffDAte =  CASE WHEN LIFEE IS NOT NULL THEN LIFEE_BenefitDate END
        ,drvBasicLIFEEEligEvent =  CASE WHEN LIFEE IS NOT NULL THEN
                                        CASE WHEN  LIFEC_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBasicLIFEEPlanId = CASE WHEN LIFEE IS NOT NULL THEN 'ETL0CEEVAL' END
        ,drvBasicLIFEEFamInd = CASE WHEN LIFEE IS NOT NULL THEN 'C' END
        ,drvBasicLIFEEApprovedEffDate = CASE WHEN LIFEE IS NOT NULL THEN LIFEE_BenefitDate END
        ,drvBasicLIFEEApprovedEffAmt =  CASE WHEN LIFEE IS NOT NULL THEN dbo.dsi_fnPadZero(CAST(CONVERT(DECIMAL(8,2),LIFEE_BenAmt) as varchar(10)),10,0) END 
        ,drvBasicLIFESProdCat = CASE WHEN LIFES IS NOT NULL THEN '4' END
        ,drvBasicLIFESEffDAte = CASE WHEN LIFES IS NOT NULL THEN LIFES_BenefitDate END
        ,drvBasicLIFCEligEvent = CASE WHEN LIFES IS NOT NULL THEN
                                        CASE WHEN  LIFES_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBasicLIFESPlanId = CASE WHEN LIFES IS NOT NULL THEN 'ETL0CSPVAL' END
        ,drvBasicLIFESFamInd = CASE WHEN LIFES IS NOT NULL THEN 'C' END
        ,drvBasicLIFESApprovedEffDate = CASE WHEN LIFES IS NOT NULL THEN LIFES_BenefitDate END
        ,drvBasicLIFESApprovedEffAmt = CASE WHEN LIFES IS NOT NULL THEN dbo.dsi_fnPadZero(CAST(CONVERT(DECIMAL(8,2),LIFES_BenAmt) as varchar(10)),10,0) END
        ,drvBasicLIFECProdCat = CASE WHEN LIFEC IS NOT NULL THEN '5' END
        ,drvBasicLIFECEffDAte = CASE WHEN LIFEC IS NOT NULL THEN LIFEC_BenefitDate END
        ,drvBasicLIFECEligEvent = CASE WHEN LIFEC IS NOT NULL THEN
                                        CASE WHEN  LIFEC_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBasicLIFECPlanId = CASE WHEN LIFEC IS NOT NULL THEN 'ETL0CDPVAL' END
        ,drvBasicLIFECFamInd = CASE WHEN LIFEC IS NOT NULL THEN 'C' END
        ,drvBasicLIFECApprovedEffDate = CASE WHEN LIFEC IS NOT NULL THEN LIFEC_BenefitDate END
        ,drvBasicLIFECApprovedEffAmt = CASE WHEN LIFEC IS NOT NULL THEN dbo.dsi_fnPadZero(CAST(CONVERT(DECIMAL(8,2),LIFEC_BenAmt) as varchar(10)),10,0) END
        ,drvBasicADDEProdCat = CASE WHEN ADDE IS NOT NULL THEN 'C' END 
        ,drvBasicADDEEffDAte = CASE WHEN ADDE IS NOT NULL THEN ADDE_BenefitDate END 
        ,drvBasicADDEEligEvent =  CASE WHEN ADDE IS NOT NULL THEN
                                        CASE WHEN  ADDE_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBasicADDPlanId =  CASE WHEN ADDE IS NOT NULL THEN 'BTA0CEEVAL' END 
        ,drvBasicADDEFamInd = CASE WHEN ADDE IS NOT NULL THEN 'C' END
        ,drvBasicADDEApprovedEffDate = CASE WHEN ADDE IS NOT NULL THEN ADDE_BenefitDate END 
        ,drvBasicADDEApprovedEffAmt = CASE WHEN ADDE IS NOT NULL THEN dbo.dsi_fnPadZero(CAST(CONVERT(DECIMAL(8,2),ADDE_BenAmt) as varchar(10)),10,0) END
        ,drvBasicADDSProdCat = CASE WHEN ADDS IS NOT NULL THEN 'e' END 
        ,drvBasicADDSEffDAte =  CASE WHEN ADDS IS NOT NULL THEN ADDS_BenefitDate END 
        ,drvBasicADDSEligEvent = CASE WHEN ADDS IS NOT NULL THEN
                                        CASE WHEN  ADDS_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBasicADDSPlanId = CASE WHEN ADDS IS NOT NULL THEN 'BTA0CSPVAL' END 
        ,drvBasicADDSFamInd = CASE WHEN ADDS IS NOT NULL THEN 'C' END 
        ,drvBasicADDSApprovedEffDate = CASE WHEN ADDS IS NOT NULL THEN ADDS_BenefitDate END 
        ,drvBasicADDSApprovedEffAmt = CASE WHEN ADDS IS NOT NULL THEN dbo.dsi_fnPadZero(CAST(CONVERT(DECIMAL(8,2),ADDS_BenAmt) as varchar(10)),10,0) END
        ,drvBasicADDCProdCat = CASE WHEN ADDC IS NOT NULL THEN 'd' END
        ,drvBasicADDCEffDAte = CASE WHEN ADDC IS NOT NULL THEN ADDC_BenefitDate END
        ,drvBasicADDCEligEvent = CASE WHEN ADDC IS NOT NULL THEN
                                        CASE WHEN  ADDC_BenStatus = 'T' THEN 'TM' ELSE 'EN' END
                                END
        ,drvBasicADDCPlanId = CASE WHEN ADDC IS NOT NULL THEN 'BTA0CDPVAL' END
        ,drvBasicADDCFamInd = CASE WHEN ADDC IS NOT NULL THEN 'C' END
        ,drvBasicADDCApprovedEffDate = CASE WHEN ADDC IS NOT NULL THEN ADDC_BenefitDate END
        ,drvBasicADDCApprovedEffAmt =  CASE WHEN ADDC IS NOT NULL THEN dbo.dsi_fnPadZero(CAST(CONVERT(DECIMAL(8,2),ADDC_BenAmt) as varchar(10)),10,0) END
        ,drvVolAccProdCategory = CASE WHEN MVACE IS NOT NULL THEN 'h' END
        ,drvVolAccEffDate = CASE WHEN MVACE IS NOT NULL THEN MVACE_BenefitDate END
        ,drvVolAccEligEvent = CASE WHEN MVACE IS NOT NULL THEN
                                CASE WHEN bdmRecType = 'EMP' or bdmRecType is null and MVACE_BenStatus = 'T' THEN 'TM'
                                     WHEN bdmRecType = 'DEP'  and MVACE_BenStatus = 'T' and (SELECT top 1 bdmBenStatus FROM U_dsi_BDM_EMUTOMAEXP WHERE BdmDedCode = 'MVACE' and bdmeeid = xeeid and bdmcoid = xcoid) <> 'T'  THEN 'SE'
                                     ELSE 'EN' 
                                END
                              END
        ,drvVolAccPlanId = CASE WHEN MVACE IS NOT NULL THEN '6AS000VACC' END
        ,drvVolAccFamInd = CASE WHEN MVACE IS NOT NULL THEN
                                CASE WHEN MVACE_BenOption = 'EE' THEN 'C' 
                                     WHEN MVACE_BenOption = 'EES' THEN 'B'
                                     WHEN MVACE_BenOption = 'EEC' THEN 'D'
                                     WHEN MVACE_BenOption = 'EEF' THEN 'A'
                                END
                           END
    INTO dbo.U_EMUTOMAEXP_drvTbl
    FROM dbo.U_EMUTOMAEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
         and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_EMUTOMAEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (Select  bdmEEID,bdmcoid,bdmrectype,bdmdeprecid
            ,GLIFM  = MAX((CASE WHEN BDMDedCode = 'GLIFM' then 'GLIFM' END))
            ,GLIFM_BenefitDate = MAX((CASE WHEN BDMDedCode = 'GLIFM' then  BdmBenStartDate END))
            ,GLIFM_BenStatus = MAX((CASE WHEN BDMDedCode = 'GLIFM' then  BdmBenStatus END))
            ,GLIFM_BenStopDate = MAX((CASE WHEN BDMDedCode = 'GLIFM' then  BdmBenStopDate END))
            ,GLIFD  = MAX((CASE WHEN BDMDedCode = 'GLIFD ' then 'GLIFD' END))
            ,GLIFD_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'GLIFD' then  BdmBenStartDate END))
            ,GLIFD_BenStatus = MAX((CASE WHEN BDMDedCode = 'GLIFD' then  BdmBenStatus END))
            ,GLIFD_BenStopDate = MAX((CASE WHEN BDMDedCode = 'GLIFD' then  BdmBenStopDate END))
            ,GLIFE  = MAX((CASE WHEN BDMDedCode = 'GLIFE ' then 'GLIFE' END))
            ,GLIFE_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'GLIFE' then  BdmBenStartDate END))
            ,GLIFE_BenStatus = MAX((CASE WHEN BDMDedCode = 'GLIFE' then  BdmBenStatus END))
            ,GLIFE_BenStopDate = MAX((CASE WHEN BDMDedCode = 'GLIFE' then  BdmBenStopDate END))
            ,ERADD  = MAX((CASE WHEN BDMDedCode = 'ERADD ' then 'ERADD' END))
            ,ERADD_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'ERADD' then  BdmBenStartDate END))
            ,ERADD_BenStatus = MAX((CASE WHEN BDMDedCode = 'ERADD' then  BdmBenStatus END))
            ,ERADD_BenStopDate = MAX((CASE WHEN BDMDedCode = 'ERADD' then  BdmBenStopDate END))
            ,ERADE  = MAX((CASE WHEN BDMDedCode = 'ERADE' then 'ERADE' END))
            ,ERADE_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'ERADE' then  BdmBenStartDate END))
            ,ERADE_BenStatus = MAX((CASE WHEN BDMDedCode = 'ERADE' then  BdmBenStatus END))
            ,ERADE_BenStopDate = MAX((CASE WHEN BDMDedCode = 'ERADE' then  BdmBenStopDate END))
            ,ERADM  = MAX((CASE WHEN BDMDedCode = 'ERADM' then 'ERADM' END))
            ,ERADM_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'ERADM' then  BdmBenStartDate END))
            ,ERADM_BenStatus = MAX((CASE WHEN BDMDedCode = 'ERADM' then  BdmBenStatus END))
            ,ERADM_BenStopDate = MAX((CASE WHEN BDMDedCode = 'ERADM' then  BdmBenStopDate END))
            ,ERSTD  = MAX((CASE WHEN BDMDedCode = 'ERSTD' then 'ERSTD' END))
            ,ERSTD_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'ERSTD' then  BdmBenStartDate END))
            ,ERSTD_BenStatus = MAX((CASE WHEN BDMDedCode = 'ERSTD' then  BdmBenStatus END))
            ,ERSTD_BenStopDate = MAX((CASE WHEN BDMDedCode = 'ERSTD' then  BdmBenStopDate END))
            ,ERLTD  = MAX((CASE WHEN BDMDedCode = 'ERLTD' then 'ERLTD' END))
            ,ERLTD_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'ERLTD' then  BdmBenStartDate END))
            ,ERLTD_BenStatus = MAX((CASE WHEN BDMDedCode = 'ERLTD' then  BdmBenStatus END))
            ,ERLTD_BenStopDate = MAX((CASE WHEN BDMDedCode = 'ERLTD' then  BdmBenStopDate END))
            ,LIFEE  = MAX((CASE WHEN BDMDedCode = 'LIFEE' then 'LIFEE' END))
            ,LIFEE_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'LIFEE' then  BdmBenStartDate END))
            ,LIFEE_BenStatus = MAX((CASE WHEN BDMDedCode = 'LIFEE' then  BdmBenStatus END))
            ,LIFEE_BenStopDate = MAX((CASE WHEN BDMDedCode = 'LIFEE' then  BdmBenStopDate END))
            ,LIFEE_BenAmt = SUM((CASE WHEN BDMDedCode = 'LIFEE' then  CAST(BdmUSGField1 as money)END)) 
            ,LIFES  = MAX((CASE WHEN BDMDedCode = 'LIFES' then 'LIFES' END))
            ,LIFES_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'LIFES' then  BdmBenStartDate END))
            ,LIFES_BenStatus = MAX((CASE WHEN BDMDedCode = 'LIFES' then  BdmBenStatus END))
            ,LIFES_BenStopDate = MAX((CASE WHEN BDMDedCode = 'LIFES' then  BdmBenStopDate END))
            ,LIFES_BenAmt = SUM((CASE WHEN BDMDedCode = 'LIFES' then  CAST(BdmUSGField1 as money)END)) 
            ,LIFEC  = MAX((CASE WHEN BDMDedCode = 'LIFEC' then 'LIFEC' END))
            ,LIFEC_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'LIFEC' then  BdmBenStartDate END))
            ,LIFEC_BenStatus = MAX((CASE WHEN BDMDedCode = 'LIFEC' then  BdmBenStatus END))
            ,LIFEC_BenStopDate = MAX((CASE WHEN BDMDedCode = 'LIFEC' then  BdmBenStopDate END))
            ,LIFEC_BenAmt = SUM((CASE WHEN BDMDedCode = 'LIFEC' then  CAST(BdmUSGField1 as money)END)) 
            ,ADDE = MAX((CASE WHEN BDMDedCode = 'ADDE' then 'ADDE' END))
            ,ADDE_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'ADDE' then  BdmBenStartDate END))
            ,ADDE_BenStatus = MAX((CASE WHEN BDMDedCode = 'ADDE' then  BdmBenStatus END))
            ,ADDE_BenStopDate = MAX((CASE WHEN BDMDedCode = 'ADDE' then  BdmBenStopDate END))
            ,ADDE_BenAmt = SUM((CASE WHEN BDMDedCode = 'ADDE' then  CAST(BdmUSGField1 as money)END)) 
            ,ADDS = MAX((CASE WHEN BDMDedCode = 'ADDS' then 'ADDS' END))
            ,ADDS_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'ADDS' then  BdmBenStartDate END))
            ,ADDS_BenStatus = MAX((CASE WHEN BDMDedCode = 'ADDS' then  BdmBenStatus END))
            ,ADDS_BenStopDate = MAX((CASE WHEN BDMDedCode = 'ADDS' then  BdmBenStopDate END))
            ,ADDS_BenAmt = SUM((CASE WHEN BDMDedCode = 'ADDS' then  CAST(BdmUSGField1 as money)END)) 

            ,ADDC = MAX((CASE WHEN BDMDedCode = 'ADDC' then 'ADDS' END))
            ,ADDC_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'ADDC' then  BdmBenStartDate END))
            ,ADDC_BenStatus = MAX((CASE WHEN BDMDedCode = 'ADDC' then  BdmBenStatus END))
            ,ADDC_BenStopDate = MAX((CASE WHEN BDMDedCode = 'ADDC' then  BdmBenStopDate END))
            ,ADDC_BenAmt = SUM((CASE WHEN BDMDedCode = 'ADDC' then  CAST(BdmUSGField1 as money)END)) 

            ,MVACE = MAX((CASE WHEN BDMDedCode = 'MVACE' then 'MVACE' END))
            ,MVACE_BenefitDate =   MAX((CASE WHEN BDMDedCode = 'MVACE' then  BdmBenStartDate END))
            ,MVACE_BenStatus = MAX((CASE WHEN BDMDedCode = 'MVACE' then  BdmBenStatus END))
            ,MVACE_BenStopDate = MAX((CASE WHEN BDMDedCode = 'MVACE' then  BdmBenStopDate END))
            ,MVACE_BenAmt = SUM((CASE WHEN BDMDedCode = 'MVACE' then  CAST(BdmUSGField1 as money)END)) 
            ,MVACE_BenOption =   MAX((CASE WHEN BDMDedCode = 'MVACE' then  BdmBenOption END))
            from U_dsi_BDM_EMUTOMAEXP
            group by bdmEEID,bdmcoid,bdmrectype,bdmdeprecid) as BdmConsolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;
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
ALTER VIEW dbo.dsi_vwEMUTOMAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMUTOMAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMUTOMAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001071'
       ,expStartPerControl     = '202001071'
       ,expLastEndPerControl   = '202001149'
       ,expEndPerControl       = '202001149'
WHERE expFormatCode = 'EMUTOMAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMUTOMAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMUTOMAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort