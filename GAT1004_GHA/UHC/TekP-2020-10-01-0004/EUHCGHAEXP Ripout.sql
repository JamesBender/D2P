SET NOCOUNT ON;
IF OBJECT_ID('U_EUHCGHAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUHCGHAEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUHCGHAEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUHCGHAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUHCGHAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUHCGHAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCGHAEXP];
GO
IF OBJECT_ID('U_EUHCGHAEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_Trailer];
GO
IF OBJECT_ID('U_EUHCGHAEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_PEarHist];
GO
IF OBJECT_ID('U_EUHCGHAEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_PDedHist];
GO
IF OBJECT_ID('U_EUHCGHAEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_Header];
GO
IF OBJECT_ID('U_EUHCGHAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_File];
GO
IF OBJECT_ID('U_EUHCGHAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_EEList];
GO
IF OBJECT_ID('U_EUHCGHAEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_drvTbl];
GO
IF OBJECT_ID('U_EUHCGHAEXP_Dependents') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_Dependents];
GO
IF OBJECT_ID('U_EUHCGHAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EUHCGHAEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUHCGHAEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUHCGHAEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUHCGHAEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUHCGHAEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUHCGHAEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUHCGHAEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUHCGHAEXP','UHC Accident and Hospital Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EUHCGHAEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUHCGHAEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HD1"','1','(''UA''=''F'')','EUHCGHAEXPZ0','48','H','01','1',NULL,'HD1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HD2"','2','(''UA''=''F'')','EUHCGHAEXPZ0','13','H','01','2',NULL,'HD2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HD3"','3','(''UA''=''F'')','EUHCGHAEXPZ0','1','H','01','3',NULL,'HD3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HD4"','4','(''UA''=''F'')','EUHCGHAEXPZ0','8','H','01','4',NULL,'HD4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HD5"','5','(''UA''=''F'')','EUHCGHAEXPZ0','1','H','01','5',NULL,'HD5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HD6"','6','(''UD112''=''F'')','EUHCGHAEXPZ0','8','H','01','6',NULL,'HD6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HD7"','7','(''UA''=''F'')','EUHCGHAEXPZ0','355','H','01','7',NULL,'HD7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubscriberID"','1','(''UA''=''F'')','EUHCGHAEXPZ0','9','D','10','1',NULL,'SubscriberID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberIndicator"','2','(''UA''=''F'')','EUHCGHAEXPZ0','2','D','10','2',NULL,'MemberIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberLastName"','3','(''UA''=''F'')','EUHCGHAEXPZ0','35','D','10','3',NULL,'MemberLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberFirstName"','4','(''UA''=''F'')','EUHCGHAEXPZ0','15','D','10','4',NULL,'MemberFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberRelationship"','5','(''UA''=''F'')','EUHCGHAEXPZ0','2','D','10','5',NULL,'MemberRelationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberMiddleInitial"','6','(''UA''=''F'')','EUHCGHAEXPZ0','1','D','10','6',NULL,'MemberMiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','7','(''UA''=''F'')','EUHCGHAEXPZ0','40','D','10','7',NULL,'AddressLine1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','8','(''UA''=''F'')','EUHCGHAEXPZ0','40','D','10','8',NULL,'AddressLine2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','9','(''UA''=''F'')','EUHCGHAEXPZ0','19','D','10','9',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','10','(''UA''=''F'')','EUHCGHAEXPZ0','2','D','10','10',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','11','(''UA''=''F'')','EUHCGHAEXPZ0','5','D','10','11',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipSuffix"','12','(''UA''=''F'')','EUHCGHAEXPZ0','4','D','10','12',NULL,'ZipSuffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','13','(''UA''=''F'')','EUHCGHAEXPZ0','12','D','10','13',NULL,'HomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','14','(''UA''=''F'')','EUHCGHAEXPZ0','12','D','10','14',NULL,'WorkPhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''F'')','EUHCGHAEXPZ0','1','D','10','15',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','16','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','16',NULL,'BirthDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupPolicyNumber"','17','(''UA''=''F'')','EUHCGHAEXPZ0','30','D','10','17',NULL,'GroupPolicyNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubgrpPolicyNumber"','18','(''UA''=''F'')','EUHCGHAEXPZ0','30','D','10','18',NULL,'SubgrpPolicyNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSubGrpEffDate"','19','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','19',NULL,'EmpSubGrpEffDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode"','20','(''UA''=''F'')','EUHCGHAEXPZ0','10','D','10','20',NULL,'PlanCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCodeEffDate"','21','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','21',NULL,'PlanCodeEffDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTierCode"','22','(''UA''=''F'')','EUHCGHAEXPZ0','2','D','10','22',NULL,'TierCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberOriginalEffDate"','23','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','23',NULL,'MemberOriginalEffDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','24','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','24',NULL,'TermDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvALTID"','25','(''UA''=''F'')','EUHCGHAEXPZ0','9','D','10','25',NULL,'ALTID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStudentStatus"','26','(''UA''=''F'')','EUHCGHAEXPZ0','1','D','10','26',NULL,'StudentStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHandicapped"','27','(''UA''=''F'')','EUHCGHAEXPZ0','1','D','10','27',NULL,'Handicapped',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWrittenPreferenceLanguage"','28','(''UA''=''F'')','EUHCGHAEXPZ0','3','D','10','28',NULL,'WrittenPreferenceLanguage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWrittenPreferenceEffectiveDate"','29','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','29',NULL,'WrittenPreferenceEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpokenPreferenceLanguage"','30','(''UA''=''F'')','EUHCGHAEXPZ0','3','D','10','30',NULL,'SpokenPreferenceLanguage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpokenPreferenceEffectiveDate"','31','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','31',NULL,'SpokenPreferenceEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCALAPEligibilityIndicator"','32','(''UA''=''F'')','EUHCGHAEXPZ0','1','D','10','32',NULL,'CALAPEligibilityIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','33','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','33',NULL,'HireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubscriberClassId"','34','(''UA''=''F'')','EUHCGHAEXPZ0','4','D','10','34',NULL,'SubscriberClassId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubscriberClassEffectivedate"','35','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','35',NULL,'SubscriberClassEffectivedate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryType"','36','(''UA''=''F'')','EUHCGHAEXPZ0','1','D','10','36',NULL,'SalaryType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmount"','37','(''UA''=''F'')','EUHCGHAEXPZ0','10','D','10','37',NULL,'SalaryAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryEffectivedate"','38','(''UA''=''F'')','EUHCGHAEXPZ0','8','D','10','38',NULL,'SalaryEffectivedate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCoverageAmount"','39','(''UA''=''F'')','EUHCGHAEXPZ0','10','D','10','39',NULL,'PlanCoverageAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCoverageAmountEffectiveDate"','40','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','40',NULL,'PlanCoverageAmountEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStudentStatusEffectivedate"','41','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','41',NULL,'StudentStatusEffectivedate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStudentStatusTermdate"','42','(''UD112''=''F'')','EUHCGHAEXPZ0','8','D','10','42',NULL,'StudentStatusTermdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHandicapEffectivedate"','43','(''UD101''=''F'')','EUHCGHAEXPZ0','8','D','10','43',NULL,'HandicapEffectivedate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHandicapTermdate"','44','(''UA''=''F'')','EUHCGHAEXPZ0','8','D','10','44',NULL,'HandicapTermdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','45','(''UA''=''F'')','EUHCGHAEXPZ0','50','D','10','45',NULL,'EmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTR1"','1','(''UA''=''F'')','EUHCGHAEXPZ0','48','T','90','1',NULL,'drvTR1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTR2"','2','(''UA''=''F'')','EUHCGHAEXPZ0','14','T','90','2',NULL,'drvTR2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTR3"','3','(''UA''=''F'')','EUHCGHAEXPZ0','1','T','90','3',NULL,'drvTR3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTR4"','4','(''UA''=''F'')','EUHCGHAEXPZ0','8','T','90','4',NULL,'drvTR4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTR5"','5','(''UA''=''F'')','EUHCGHAEXPZ0','1','T','90','5',NULL,'drvTR5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTR6"','6','(''UA''=''F'')','EUHCGHAEXPZ0','9','T','90','6',NULL,'drvTR6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTR7"','7','(''UA''=''F'')','EUHCGHAEXPZ0','353','T','90','7',NULL,'drvTR7',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUHCGHAEXP_20210910.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202102049','EMPEXPORT','OEACTIVE',NULL,'EUHCGHAEXP',NULL,NULL,NULL,'202102049','Feb  4 2021  2:47PM','Feb  4 2021  2:47PM','202102041',NULL,'','','202102041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102049','EMPEXPORT','OEPASSIVE',NULL,'EUHCGHAEXP',NULL,NULL,NULL,'202102049','Feb  4 2021  2:47PM','Feb  4 2021  2:47PM','202102041',NULL,'','','202102041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC Accident and Hospital Expo','202102049','EMPEXPORT','ONDEMAND',NULL,'EUHCGHAEXP',NULL,NULL,NULL,'202102049','Feb  4 2021  2:47PM','Feb  4 2021  2:47PM','202102041',NULL,'','','202102041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202102049','EMPEXPORT','SCH_UHGX',NULL,'EUHCGHAEXP',NULL,NULL,NULL,'202102049','Feb  4 2021  2:47PM','Feb  4 2021  2:47PM','202102041',NULL,'','','202102041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202108251','EMPEXPORT','TEST','Sep 10 2021  1:13PM','EUHCGHAEXP',NULL,NULL,NULL,'202108251','Aug 25 2021 12:00AM','Dec 30 1899 12:00AM','202107121','2540','','','202107121',dbo.fn_GetTimedKey(),NULL,'us3rVaGAT1004',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCGHAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCGHAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCGHAEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCGHAEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCGHAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCGHAEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUHCGHAEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUHCGHAEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUHCGHAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUHCGHAEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCGHAEXP','H01','dbo.U_EUHCGHAEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCGHAEXP','D10','dbo.U_EUHCGHAEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCGHAEXP','T90','dbo.U_EUHCGHAEXP_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EUHCGHAEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUHCGHAEXP] (
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
IF OBJECT_ID('U_EUHCGHAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EUHCGHAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUHCGHAEXP_Dependents') IS NULL
CREATE TABLE [dbo].[U_EUHCGHAEXP_Dependents] (
    [DpnEEID] char(12) NOT NULL,
    [DpnConSystemID] char(12) NOT NULL,
    [DpnConNameFirst] varchar(100) NULL,
    [DpnConNameMiddle] varchar(50) NULL,
    [DpnConNameLast] varchar(100) NULL,
    [DpnConRelationship] char(3) NULL,
    [DpnConIsDisabled] char(1) NULL,
    [DpnConGender] char(1) NULL,
    [DpnConDateOfBirth] datetime NULL,
    [DpnConIsSmoker] varchar(1) NULL,
    [DpnDepNo] bigint NULL
);
IF OBJECT_ID('U_EUHCGHAEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUHCGHAEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubscriberID] char(11) NULL,
    [drvMemberIndicator] varchar(24) NULL,
    [drvMemberLastName] varchar(100) NULL,
    [drvMemberFirstName] varchar(100) NULL,
    [drvMemberRelationship] varchar(2) NOT NULL,
    [drvMemberMiddleInitial] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvZipSuffix] varchar(1) NOT NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvGroupPolicyNumber] varchar(7) NOT NULL,
    [drvSubgrpPolicyNumber] varchar(4) NOT NULL,
    [drvEmpSubGrpEffDate] datetime NULL,
    [drvPlanCode] varchar(8) NULL,
    [drvPlanCodeEffDate] datetime NULL,
    [drvTierCode] varchar(1) NULL,
    [drvMemberOriginalEffDate] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvALTID] varchar(1) NOT NULL,
    [drvStudentStatus] varchar(1) NOT NULL,
    [drvHandicapped] varchar(1) NOT NULL,
    [drvWrittenPreferenceLanguage] varchar(1) NOT NULL,
    [drvWrittenPreferenceEffectiveDate] varchar(1) NOT NULL,
    [drvSpokenPreferenceLanguage] varchar(1) NOT NULL,
    [drvSpokenPreferenceEffectiveDate] varchar(1) NOT NULL,
    [drvCALAPEligibilityIndicator] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvSubscriberClassId] varchar(6) NOT NULL,
    [drvSubscriberClassEffectivedate] datetime NULL,
    [drvSalaryType] varchar(1) NOT NULL,
    [drvSalaryAmount] varchar(1) NOT NULL,
    [drvSalaryEffectivedate] varchar(1) NOT NULL,
    [drvPlanCoverageAmount] varchar(256) NULL,
    [drvPlanCoverageAmountEffectiveDate] datetime NULL,
    [drvStudentStatusEffectivedate] varchar(1) NOT NULL,
    [drvStudentStatusTermdate] varchar(1) NOT NULL,
    [drvHandicapEffectivedate] varchar(1) NOT NULL,
    [drvHandicapTermdate] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUHCGHAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EUHCGHAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUHCGHAEXP_File') IS NULL
CREATE TABLE [dbo].[U_EUHCGHAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EUHCGHAEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EUHCGHAEXP_Header] (
    [HD1] varchar(1) NOT NULL,
    [HD2] varchar(13) NOT NULL,
    [HD3] varchar(1) NOT NULL,
    [HD4] varchar(6) NOT NULL,
    [HD5] varchar(1) NOT NULL,
    [HD6] datetime NOT NULL,
    [HD7] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUHCGHAEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUHCGHAEXP_PDedHist] (
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
IF OBJECT_ID('U_EUHCGHAEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUHCGHAEXP_PEarHist] (
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
IF OBJECT_ID('U_EUHCGHAEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EUHCGHAEXP_Trailer] (
    [drvTR1] varchar(1) NOT NULL,
    [drvTR2] varchar(14) NOT NULL,
    [drvTR3] varchar(1) NOT NULL,
    [drvTR4] varchar(6) NOT NULL,
    [drvTR5] varchar(1) NOT NULL,
    [drvTR6] int NULL,
    [drvTR7] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCGHAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Gates, Hudson & Associates, Inc.

Created By: Marco Lagrosa
Business Analyst: Richard Vars
Create Date: 02/04/2021
Service Request Number: TekP-2020-10-01-0004

Purpose: UHC Accident and Hospital Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUHCGHAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUHCGHAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUHCGHAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUHCGHAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUHCGHAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCGHAEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCGHAEXP', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCGHAEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCGHAEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCGHAEXP', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUHCGHAEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUHCGHAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME
            ,@FileOrgMinCovDate DATETIME
            ;

    -- Set FormatCode
    SELECT @FormatCode = 'EUHCGHAEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '1/1/2021'
        ,@FileOrgMinCovDate  = '9/1/2021'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUHCGHAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUHCGHAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Dependent Member Indicators
    --==========================================    
    IF OBJECT_ID('U_EUHCGHAEXP_Dependents','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCGHAEXP_Dependents;
    SELECT DpnEEID = ConEEID
          ,DpnConSystemID = ConSystemID
          ,DpnConNameFirst = ConNameFirst
          ,DpnConNameMiddle = ConNameMiddle
          ,DpnConNameLast = ConNameLast
          ,DpnConRelationship = ConRelationship
          ,DpnConIsDisabled = ConIsDisabled
          ,DpnConGender = ConGender 
          ,DpnConDateOfBirth = ConDateOfBirth 
          ,DpnConIsSmoker = ConIsSmoker
          ,DpnDepNo = ROW_NUMBER() OVER (PARTITION BY RTRIM(ConEEID) ORDER BY ConMarriageDate ASC)
      INTO dbo.U_EUHCGHAEXP_Dependents
      FROM dbo.Contacts WITH (NOLOCK)
      JOIN dbo.U_EUHCGHAEXP_EEList WITH (NOLOCK)
        ON ConEEID = xEEID
     WHERE ConRelationship IN ('SPS','DP')
     AND ConIsDependent = 'Y'
     ;
     --UPDATE SPOUSE NUMBER FOR MULTIPLE SPOUSES
     UPDATE U_EUHCGHAEXP_Dependents
     SET DpnDepNo = DpnDepNo + 88
     WHERE DpnDepNo > 1;

    INSERT INTO dbo.U_EUHCGHAEXP_Dependents
    SELECT DpnEEID = ConEEID
          ,DpnConSystemID = ConSystemID
          ,DpnConNameFirst = ConNameFirst
          ,DpnConNameMiddle = ConNameMiddle
          ,DpnConNameLast = ConNameLast
          ,DpnConRelationship = ConRelationship
          ,DpnConIsDisabled = ConIsDisabled
          ,DpnConGender = ConGender 
          ,DpnConDateOfBirth = ConDateOfBirth 
          ,DpnConIsSmoker = ConIsSmoker
          ,DpnDepNo = ROW_NUMBER() OVER (PARTITION BY RTRIM(ConEEID) ORDER BY conDateOfBirth ASC) + 1
      FROM dbo.Contacts WITH (NOLOCK)
      JOIN dbo.U_EUHCGHAEXP_EEList WITH (NOLOCK)
        ON ConEEID = xEEID
     WHERE ConRelationship IN ('CH','CHL','DPC','STC')
     AND ConIsDependent = 'Y'
     ;

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BASIC,ACCID,ACIDP,ADDO,HOSP,HOSPP,LFADC,LFADE,LFADS,LIFEC,LIFEE,LIFES,LTD,LTDP,STDER,STDP'
    IF OBJECT_ID('U_EUHCGHAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCGHAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUHCGHAEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Calculate Member Indicators
    --==========================================


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CountDependents', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild', 'CHL,STC')

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
    

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EUHCGHAEXP
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EUHCGHAEXP
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEEID = BdmEEID
       AND EedCOID = BdmCOID
       AND EedDedCode = BdmDedCode
    ;
    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EUHCGHAEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCGHAEXP_PDedHist;
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
    INTO dbo.U_EUHCGHAEXP_PDedHist
    FROM U_EUHCGHAEXP_EEList
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_EUHCGHAEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EUHCGHAEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCGHAEXP_PEarHist;
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
    INTO dbo.U_EUHCGHAEXP_PEarHist
    FROM U_EUHCGHAEXP_EEList
    JOIN dbo.vw_int_PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
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
    -- DETAIL RECORD - U_EUHCGHAEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUHCGHAEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCGHAEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),bdmdeprecid) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvSubscriberID = eepSSN
        ,drvMemberIndicator = CASE WHEN bdmrectype = 'EMP' THEN '00'
                                   WHEN bdmrectype = 'DEP' THEN dbo.dsi_fnPadZero(DpnDepNo,2,0)
                               END 
        ,drvMemberLastName = CASE WHEN bdmrectype = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvMemberFirstName = CASE WHEN bdmrectype = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvMemberRelationship = CASE WHEN bdmrectype = 'EMP' THEN 'EE'
                                      ELSE 
                                        CASE WHEN bdmrelationship in ('CHL') THEN 'CH'
                                            ELSE 'SP'
                                        END
                                 END
        ,drvMemberMiddleInitial = ''
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = eepAddressZipCode
        ,drvZipSuffix = ''
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = ''
        ,drvGender = CASE WHEN bdmrectype = 'EMP' THEN EepGender ELSE ConGender END 
        ,drvBirthDate = CASE WHEN bdmrectype = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END  
        ,drvGroupPolicyNumber = '0922120'
        ,drvSubgrpPolicyNumber = '2001'
                                 --CASE WHEN cmpcompanycode= 'Z182' THEN 'Z182 GHA Corp'
         --                             WHEN cmpcompanycode= 'Z183' THEN 'Z183 GHA Field'
         --                             WHEN cmpcompanycode= 'Z398' THEN 'Z398 GHA Services'
         --                             WHEN cmpcompanycode IN ('Z720','Z721')THEN 'Z720 GHCM Corp'
         --                             WHEN cmpcompanycode= 'Z182' THEN 'Z182 GHA Corp'
         --                             WHEN cmpcompanycode= 'Z182' THEN 'Z182 GHA Corp Motion'
         --                             WHEN cmpcompanycode= 'Z183' THEN 'Z183 GHA Field Motion'
         --                             WHEN cmpcompanycode= 'Z398' THEN 'Z398  GHA Services Motion'
         --                             WHEN cmpcompanycode IN ('Z720','Z721')THEN 'Z720  GHCM Corp Motion'
         --                       END
        ,drvEmpSubGrpEffDate = dbo.dsi_fnGetMinMaxDates('MAX',bdmbenstartdate, @FileOrgMinCovDate) 
        ,drvPlanCode = CASE 
                            WHEN BdmDedCode = 'BASIC' THEN 'LE000956'
                            WHEN BdmDedCode = 'ADDO' THEN 'LE000957'
                            WHEN BdmDedCode = 'LIFEE' THEN 'LE000236'
                            WHEN BdmDedCode = 'LFADE' THEN 'LE000004'
                            WHEN BdmDedCode = 'LFADS' THEN 'LE000237'
                            WHEN BdmDedCode = 'LIFES' THEN 'LE000023'
                            WHEN BdmDedCode = 'LIFEC' AND BdmBenOption = 'CL1K' THEN 'LE000125'
                            WHEN BdmDedCode = 'LIFEC' AND BdmBenOption = 'CL2K' THEN 'LE000192'
                            WHEN BdmDedCode = 'LIFEC' AND BdmBenOption = 'CL3K' THEN 'LE000193'
                            WHEN BdmDedCode = 'LIFEC' AND BdmBenOption = 'CL4K' THEN 'LE000194'
                            WHEN BdmDedCode = 'LIFEC' AND BdmBenOption = 'CL5K' THEN 'LE000007'
                            WHEN BdmDedCode = 'LIFEC' AND BdmBenOption = 'CL6K' THEN 'LE000195'
                            WHEN BdmDedCode = 'LIFEC' AND BdmBenOption = 'CL7K' THEN 'LE000196'
                            WHEN BdmDedCode = 'LIFEC' AND BdmBenOption = 'CL8K' THEN 'LE000197'
                            WHEN BdmDedCode = 'LIFEC' AND BdmBenOption = 'CL9K' THEN 'LE000198'
                            WHEN BdmDedCode = 'LIFEC' AND BdmBenOption = 'CL10K' THEN 'LE000009'
                            WHEN BdmDedCode = 'LFADC' AND BdmUSGField1 = '1000.00' THEN 'LE000126'
                            WHEN BdmDedCode = 'LFADC' AND BdmUSGField1 = '2000.00' THEN 'LE000199'
                            WHEN BdmDedCode = 'LFADC' AND BdmUSGField1 = '3000.00' THEN 'LE000200'
                            WHEN BdmDedCode = 'LFADC' AND BdmUSGField1 = '4000.00' THEN 'LE000201'
                            WHEN BdmDedCode = 'LFADC' AND BdmUSGField1 = '5000.00' THEN 'LE000086'
                            WHEN BdmDedCode = 'LFADC' AND BdmUSGField1 = '6000.00' THEN 'LE000202'
                            WHEN BdmDedCode = 'LFADC' AND BdmUSGField1 = '7000.00' THEN 'LE000203'
                            WHEN BdmDedCode = 'LFADC' AND BdmUSGField1 = '8000.00' THEN 'LE000204'
                            WHEN BdmDedCode = 'LFADC' AND BdmUSGField1 = '9000.00' THEN 'LE000205'
                            WHEN BdmDedCode = 'LFADC' AND BdmUSGField1 = '10000.00' THEN 'LE000024'
                            WHEN BdmDedCode = 'ACCID' AND BdmBenOption ='EE' THEN 'LE001795'
                            WHEN BdmDedCode = 'ACCID' AND BdmBenOption ='EES' THEN 'LE001796'
                            WHEN BdmDedCode = 'ACCID' AND BdmBenOption ='EEDP' THEN 'LE001796'
                            WHEN BdmDedCode = 'ACCID' AND BdmBenOption ='EEC' THEN 'LE001791'
                            WHEN BdmDedCode = 'ACCID' AND BdmBenOption ='EEF' THEN 'LE001797'
                            WHEN BdmDedCode = 'ACCID' AND BdmBenOption ='EEDPF' THEN 'LE001797'
                            WHEN BdmDedCode = 'ACIDP' AND BdmBenOption ='EE' THEN 'LE001795'
                            WHEN BdmDedCode = 'ACIDP' AND BdmBenOption ='EES' THEN 'LE001796'
                            WHEN BdmDedCode = 'ACIDP' AND BdmBenOption ='EEDP' THEN 'LE001796'
                            WHEN BdmDedCode = 'ACIDP' AND BdmBenOption ='EEC' THEN 'LE001791'
                            WHEN BdmDedCode = 'ACIDP' AND BdmBenOption ='EEF' THEN 'LE001797'
                            WHEN BdmDedCode = 'ACIDP' AND BdmBenOption ='EEDPF' THEN 'LE001797'
                            WHEN BdmDedCode = 'HOSP' AND BdmBenOption ='EE' THEN 'LE001286'
                            WHEN BdmDedCode = 'HOSP' AND BdmBenOption ='EES' THEN 'LE001287'
                            WHEN BdmDedCode = 'HOSP' AND BdmBenOption ='EEDP' THEN 'LE001287'
                            WHEN BdmDedCode = 'HOSP' AND BdmBenOption ='EEC' THEN 'LE001288'
                            WHEN BdmDedCode = 'HOSP' AND BdmBenOption ='EEF' THEN 'LE001289'
                            WHEN BdmDedCode = 'HOSP' AND BdmBenOption ='EEDPF' THEN 'LE001289'
                            WHEN BdmDedCode = 'HOSPP' AND BdmBenOption ='EE' THEN 'LE001286'
                            WHEN BdmDedCode = 'HOSPP' AND BdmBenOption ='EES' THEN 'LE001287'
                            WHEN BdmDedCode = 'HOSPP' AND BdmBenOption ='EEDP' THEN 'LE001287'
                            WHEN BdmDedCode = 'HOSPP' AND BdmBenOption ='EEC' THEN 'LE001288'
                            WHEN BdmDedCode = 'HOSPP' AND BdmBenOption ='EEF' THEN 'LE001289'
                            WHEN BdmDedCode = 'HOSPP' AND BdmBenOption ='EEDPF' THEN 'LE001289'
                            WHEN BdmDedCode = 'STDER' THEN 'LE000216'
                            WHEN BdmDedCode = 'STDP' THEN 'LE000216'
                            WHEN BdmDedCode = 'LTD' THEN 'LE000832'
                            WHEN BdmDedCode = 'LTDP' THEN 'LE000832'
                        END
        ,drvPlanCodeEffDate = dbo.dsi_fnGetMinMaxDates('MAX',bdmbenstartdate, @FileOrgMinCovDate) 
        ,drvTierCode = CASE WHEN BdmBenOption in ('EE') THEN 'C' 
                            WHEN BdmBenOption in ('EES', 'EEDP') THEN 'B'
                            WHEN BdmBenOption in ('EEC') AND BdmNumChildren > 1 THEN 'D'
                            WHEN BdmBenOption in ('EEC') THEN 'G'
                            WHEN BdmBenOption in ('EEF', 'EEDPF') THEN 'A' 
                       END
        ,drvMemberOriginalEffDate =  dbo.dsi_fnGetMinMaxDates('MAX',bdmbenstartdate, @FileOrgMinCovDate) 
        ,drvTermDate = eecDateOfTermination
        ,drvALTID = ''
        ,drvStudentStatus = ''
        ,drvHandicapped = ''
        ,drvWrittenPreferenceLanguage = ''
        ,drvWrittenPreferenceEffectiveDate = ''
        ,drvSpokenPreferenceLanguage = ''
        ,drvSpokenPreferenceEffectiveDate = ''
        ,drvCALAPEligibilityIndicator = ''
        ,drvHireDate = EecDateOfOriginalHire
        ,drvSubscriberClassId = '922120'
        ,drvSubscriberClassEffectivedate = dbo.dsi_fnGetMinMaxDates('MAX',bdmbenstartdate, @FileOrgMinCovDate) 
        ,drvSalaryType = ''
        ,drvSalaryAmount = ''
        ,drvSalaryEffectivedate = ''
        ,drvPlanCoverageAmount = substring(BdmUSGField1, 1, (len(BdmUSGField1) - 3))
        ,drvPlanCoverageAmountEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',bdmbenstartdate, @FileMinCovDate) 
        ,drvStudentStatusEffectivedate = ''
        ,drvStudentStatusTermdate = ''
        ,drvHandicapEffectivedate = ''
        ,drvHandicapTermdate = ''
        ,drvEmailAddress = ''
    INTO dbo.U_EUHCGHAEXP_drvTbl
    FROM dbo.U_EUHCGHAEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EUHCGHAEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT 
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.company  WITH (NOLOCK)
        On cmpcoid = xCoID
    LEFT
    JOIN dbo.U_EUHCGHAEXP_Dependents WITH (NOLOCK)
       on DpnConSystemID = ConSystemID
    ;

    Delete from dbo.U_EUHCGHAEXP_drvTbl where drvMemberIndicator is null

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUHCGHAEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCGHAEXP_Header;
    SELECT DISTINCT
         HD1 = ''
        ,HD2 = 'HEADER RECORD'
        ,HD3 = ''
        ,HD4 = '922120'
        ,HD5 = ''
        ,HD6 = GETDATE()
        ,HD7 = ''
    INTO dbo.U_EUHCGHAEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUHCGHAEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCGHAEXP_Trailer;
    SELECT DISTINCT
         drvTR1 = ''
        ,drvTR2 = 'TRAILER RECORD'
        ,drvTR3 = ''
        ,drvTR4 = '922120'
        ,drvTR5 = ''
        ,drvTR6 = (Select count(*) from U_EUHCGHAEXP_drvTbl)
        ,drvTR7 = ''
    INTO dbo.U_EUHCGHAEXP_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END
    
END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEUHCGHAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUHCGHAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUHCGHAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

UPDATE ASCDEFF SET AdfForCond = cast('(''UD112''=''F'')' as varchar(255)) WHERE adfforcond = '(''UD101''=''F'')'

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101281'
       ,expStartPerControl     = '202101281'
       ,expLastEndPerControl   = '202102049'
       ,expEndPerControl       = '202102049'
WHERE expFormatCode = 'EUHCGHAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUHCGHAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUHCGHAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort