SET NOCOUNT ON;
IF OBJECT_ID('U_ETRIAHLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRIAHLEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETRIAHLEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETRIAHLEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETRIAHLEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETRIAHLEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETRIAHLEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRIAHLEXP];
GO
IF OBJECT_ID('U_ETRIAHLEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETRIAHLEXP_PEarHist];
GO
IF OBJECT_ID('U_ETRIAHLEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETRIAHLEXP_PDedHist];
GO
IF OBJECT_ID('U_ETRIAHLEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ETRIAHLEXP_File];
GO
IF OBJECT_ID('U_ETRIAHLEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETRIAHLEXP_EEList];
GO
IF OBJECT_ID('U_ETRIAHLEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETRIAHLEXP_drvTbl];
GO
IF OBJECT_ID('U_ETRIAHLEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETRIAHLEXP_DedList];
GO
IF OBJECT_ID('U_ETRIAHLEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETRIAHLEXP_AuditFields];
GO
IF OBJECT_ID('U_ETRIAHLEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETRIAHLEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ETRIAHLEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETRIAHLEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETRIAHLEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETRIAHLEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETRIAHLEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETRIAHLEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETRIAHLEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETRIAHLEXP','Tria Health/RX Benefits Health Interface Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ETRIAHLEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CustomerID "','1','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','1',NULL,'CustomerID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Id "','2','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','2',NULL,'Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GroupID "','3','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','3',NULL,'GroupID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GroupEffectiveDate "','4','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','4',NULL,'GroupEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MemberEffectiveDate "','5','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','5',NULL,'MemberEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MemberTerminationDate "','6','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','6',NULL,'MemberTerminationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COBRA "','7','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','7',NULL,'COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Retiree "','8','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','8',NULL,'Retiree',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeSSN "','9','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','9',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DependentSSN "','10','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','10',NULL,'DependentSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PersonCode "','11','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','11',NULL,'PersonCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender "','12','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','12',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Title "','13','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','13',NULL,'Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName "','14','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','14',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MiddleInitial "','15','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','15',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName "','16','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','16',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Suffix "','17','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','17',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DateOfBirth "','18','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','18',NULL,'DateOfBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relation "','19','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','19',NULL,'Relation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address1 "','20','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','20',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address2 "','21','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','21',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City "','22','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','22',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State "','23','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','23',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip "','24','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','24',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email "','25','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','25',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone "','26','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','26',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MedDSubsidyEffectiveDate "','27','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','27',NULL,'MedDSubsidyEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HIC Number "','28','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','28',NULL,'HIC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GeneralPurpose1 "','29','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','29',NULL,'GeneralPurpose1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GeneralPurpose2 "','30','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','30',NULL,'GeneralPurpose2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GeneralPurpose3 "','31','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','31',NULL,'GeneralPurpose3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GeneralPurpose4 "','32','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','32',NULL,'GeneralPurpose4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COB "','33','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','33',NULL,'COB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COBEffectiveDate "','34','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','34',NULL,'COBEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ReferenceID "','35','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','35',NULL,'ReferenceID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PlanOverride "','36','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','36',NULL,'PlanOverride',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PlanOverrideEffectiveDate "','37','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','37',NULL,'PlanOverrideEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ClientDefinedData "','38','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','38',NULL,'ClientDefinedData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BenefitPackageID "','39','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','39',NULL,'BenefitPackageID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BenefitPackageEffectiveDate "','40','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','40',NULL,'BenefitPackageEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DivisionID "','41','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','41',NULL,'DivisionID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DivisionName "','42','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','42',NULL,'DivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DivisionEffectiveDate "','43','(''DA''=''T,'')','ETRIAHLEXPZ0','50','H','01','43',NULL,'DivisionEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','1','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','1',NULL,'CustomerID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','2','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','2',NULL,'Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupId"','3','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','3',NULL,'GroupID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupEffDate"','4','(''UD101''=''T,'')','ETRIAHLEXPZ0','50','D','10','4',NULL,'GroupEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberEffDate"','5','(''UD101''=''T,'')','ETRIAHLEXPZ0','50','D','10','5',NULL,'MemberEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberTermDate"','6','(''UD101''=''T,'')','ETRIAHLEXPZ0','50','D','10','6',NULL,'MemberTerminationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','7','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','7',NULL,'COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','8','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','8',NULL,'Retiree',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','9','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','9',NULL,'EmployeeSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepSSN"','10','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','10',NULL,'DependentSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','11','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','11',NULL,'PersonCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','12',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','13','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','13',NULL,'Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','14','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','14',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInit"','15','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','15',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','16','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','16',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','17','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','17',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','18','(''UD101''=''T,'')','ETRIAHLEXPZ0','50','D','10','18',NULL,'DateOfBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelation"','19','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','19',NULL,'Relation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','20','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','20',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','21','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','21',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','22','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','22',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','23','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','23',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','24','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','24',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','25','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','25',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','26','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','26',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','27','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','27',NULL,'MedDSubsidyEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','28','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','28',NULL,'HIC Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','29','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','29',NULL,'GeneralPurpose1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','30','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','30',NULL,'GeneralPurpose2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','31','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','31',NULL,'GeneralPurpose3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','32','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','32',NULL,'GeneralPurpose4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','33','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','33',NULL,'COB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','34','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','34',NULL,'COBEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','35','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','35',NULL,'ReferenceID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','36','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','36',NULL,'PlanOverride',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','37','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','37',NULL,'PlanOverrideEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','38','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','38',NULL,'ClientDefinedData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','39','(''DA''=''T,'')','ETRIAHLEXPZ0','50','D','10','39',NULL,'BenefitPackageID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenfitPackEffDate"','40','(''UD101''=''T,'')','ETRIAHLEXPZ0','50','D','10','40',NULL,'BenefitPackageEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivId"','41','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','41',NULL,'DivisionID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivName"','42','(''UA''=''T,'')','ETRIAHLEXPZ0','50','D','10','42',NULL,'DivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','43','(''DA''=''T'')','ETRIAHLEXPZ0','50','D','10','43',NULL,'DivisionEffectiveDate',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETRIAHLEXP_20191210.txt',NULL,'','','',NULL,NULL,NULL,'Tria Health/RX Benefits Export','201911229','EMPEXPORT','ONDEMAND','Nov 22 2019 12:49PM','ETRIAHLEXP',NULL,NULL,NULL,'201911229','Nov 22 2019 11:03AM','Nov 22 2019 11:03AM','201911221','1739','','','201911221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETRIAHLEXP_20191210.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','201911229','EMPEXPORT','SCHEDULED','Nov 22 2019 12:49PM','ETRIAHLEXP',NULL,NULL,NULL,'201911229','Nov 22 2019 11:03AM','Nov 22 2019 11:03AM','201911221','1739','','','201911221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETRIAHLEXP_20191210.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','201911229','EMPEXPORT','OEACTIVE','Nov 22 2019 12:48PM','ETRIAHLEXP',NULL,NULL,NULL,'201911229','Nov 22 2019 11:03AM','Nov 22 2019 11:03AM','201911221','1','','','201911221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETRIAHLEXP_20191210.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','201911229','EMPEXPORT','OEPASSIVE','Nov 22 2019 12:48PM','ETRIAHLEXP',NULL,NULL,NULL,'201911229','Nov 22 2019 11:03AM','Nov 22 2019 11:03AM','201911221','1739','','','201911221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ETRIAHLEXP_20191210.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201912059','EMPEXPORT','TEST','Dec  5 2019  2:16PM','ETRIAHLEXP',NULL,NULL,NULL,'201912059','Dec  5 2019 12:00AM','Dec 30 1899 12:00AM','201911201','1498','','','201911201',dbo.fn_GetTimedKey(),NULL,'us3lKiSUN1006',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ETRIAHLEXP_20191210.txt' END WHERE expFormatCode = 'ETRIAHLEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIAHLEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIAHLEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIAHLEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIAHLEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRIAHLEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ETRIAHLEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETRIAHLEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ETRIAHLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRIAHLEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRIAHLEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRIAHLEXP','D10','dbo.U_ETRIAHLEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETRIAHLEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETRIAHLEXP] (
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
IF OBJECT_ID('U_ETRIAHLEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ETRIAHLEXP_Audit] (
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
IF OBJECT_ID('U_ETRIAHLEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETRIAHLEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ETRIAHLEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ETRIAHLEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETRIAHLEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETRIAHLEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvGroupId] varchar(10) NULL,
    [drvGroupEffDate] datetime NULL,
    [drvMemberEffDate] datetime NULL,
    [drvMemberTermDate] datetime NULL,
    [drvEmpSSN] char(11) NULL,
    [drvDepSSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvFirstName] varchar(102) NULL,
    [drvMiddleInit] varchar(1) NULL,
    [drvLastName] varchar(102) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvRelation] varchar(2) NULL,
    [drvAddress1] varchar(257) NULL,
    [drvAddress2] varchar(257) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(12) NULL,
    [drvBenfitPackEffDate] varchar(1) NOT NULL,
    [drvDivId] varchar(4) NULL,
    [drvDivName] varchar(38) NULL
);
IF OBJECT_ID('U_ETRIAHLEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ETRIAHLEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETRIAHLEXP_File') IS NULL
CREATE TABLE [dbo].[U_ETRIAHLEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ETRIAHLEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETRIAHLEXP_PDedHist] (
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
IF OBJECT_ID('U_ETRIAHLEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETRIAHLEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRIAHLEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: SunCoke Energy

Created By: James Bender
Business Analyst: Lea King
Create Date: 11/22/2019
Service Request Number: TekP-2019-10-22-0003

Purpose: Tria Health/RX Benefits Health Interface Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETRIAHLEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETRIAHLEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETRIAHLEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETRIAHLEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETRIAHLEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIAHLEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIAHLEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRIAHLEXP', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETRIAHLEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETRIAHLEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETRIAHLEXP';

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
    DELETE FROM dbo.U_ETRIAHLEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETRIAHLEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);



    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '1MED1, 1MED2, 1MEDC, 2MED1, 2MED2, 2MEDC, 3MED2';

    IF OBJECT_ID('U_ETRIAHLEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIAHLEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETRIAHLEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


        --==========================================
    IF OBJECT_ID('U_ETRIAHLEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIAHLEXP_AuditFields;
    CREATE TABLE dbo.U_ETRIAHLEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ETRIAHLEXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    -- Create audit table
    IF OBJECT_ID('U_ETRIAHLEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIAHLEXP_Audit;
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
    INTO dbo.U_ETRIAHLEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ETRIAHLEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ETRIAHLEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ETRIAHLEXP_Audit ON dbo.U_ETRIAHLEXP_Audit (audKey1Value, audKey2Value);

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
    IF OBJECT_ID('U_ETRIAHLEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIAHLEXP_PDedHist;
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
    INTO dbo.U_ETRIAHLEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ETRIAHLEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ETRIAHLEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIAHLEXP_PEarHist;
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
    INTO dbo.U_ETRIAHLEXP_PEarHist
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
    -- DETAIL RECORD - U_ETRIAHLEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETRIAHLEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETRIAHLEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvGroupId =    CASE BdmDedCode
                            WHEN '1MED1' THEN
                                CASE WHEN EecPayGroup in ('705HRY', '705SAL', '705SNE') THEN 'P462987051'
                                    WHEN EecPayGroup in ('722HRY', '722SAL', '722SNE') THEN 'P462987221'
                                    WHEN EecPayGroup in ('759SAL', '759SNE') THEN 'P462987591'
                                    WHEN EecPayGroup in ('768SAL', '768SNE') THEN 'P462987681'
                                    WHEN EecPayGroup in ('772SNE', '772SAL') THEN 'P462987731'
                                    WHEN EecPayGroup in ('775SAL', '775SNE') THEN 'P462987751'
                                    WHEN EecPayGroup in ('779HRY', '779SAL') THEN 'P462987791'
                                    WHEN EecPayGroup in ('783HRY', '783SAL') THEN 'P462987831'
                                    WHEN EecPayGroup in ('785HNU', '785SAL') THEN 'P462987851'
                                END
                            WHEN '1MED2' THEN 
                                CASE WHEN EecPayGroup in ('705HRY', '705SAL', '705SNE') THEN 'P468997051'
                                    WHEN EecPayGroup in ('722HRY', '722SAL', '722SNE') THEN 'P468997221'
                                    WHEN EecPayGroup in ('759SAL', '759SNE') THEN 'P468997591'
                                    WHEN EecPayGroup in ('768SAL', '768SNE') THEN 'P468997681'
                                    WHEN EecPayGroup in ('772SNE', '772SAL') THEN 'P468997731'
                                    WHEN EecPayGroup in ('775SAL', '775SNE') THEN 'P468997751'
                                    WHEN EecPayGroup in ('779HRY', '779SAL') THEN 'P468997791'
                                    WHEN EecPayGroup in ('783HRY', '783SAL') THEN 'P468997831'
                                    WHEN EecPayGroup in ('785HNU', '785SAL') THEN 'P468997851'
                                END
                            WHEN '1MEDC' THEN
                                CASE WHEN EecPayGroup in ('784HRY', '784SAL') THEN 'P462987841' END
                            WHEN '2MED1' THEN
                                CASE WHEN EecPayGroup in ('787HNU', '787SAL') THEN 'P462987871' END
                            WHEN '2MED2' THEN
                                CASE WHEN EecPayGroup in ('787HNU', '787SAL') THEN 'P468997871' END
                            WHEN '2MEDC' THEN
                                CASE WHEN EecPayGroup in ('784HRY', '784SAL') THEN 'P468997841' END
                            WHEN '3MED2' THEN
                                CASE WHEN EecPayGroup in ('772HRY') THEN 'P500917721' END

                                    
                            /*WHEN '1MED1' THEN 
                                CASE WHEN EecPayGroup IN ('705HRY', '705SAL', '705SNE') THEN 'P462987051' --
                                    WHEN EecPayGroup IN ('722HRY', '722SAL', '722SNE') THEN 'P462987221' -- change
                                    WHEN EecPayGroup IN ('759SAL', '759SNE') THEN 'P462987591' --
                                    WHEN EecPayGroup IN ('768SAL', '768SNE') THEN 'P462987681' --
                                    WHEN EecPayGroup IN ('772HRY', '772SAL') THEN 'P462987721'
                                    WHEN EecPayGroup IN ('772SNE', '722SAL') THEN 'P462987731' --
                                    WHEN EecPayGroup IN ('775HRY', '775SAL', '775SNE') THEN 'P462987751'
                                    WHEN EecPayGroup IN ('779HRY', '779SAL') THEN 'P462987791'
                                    WHEN EecPayGroup IN ('783HRY', '783SAL') THEN 'P462987831'
                                    WHEN EecPayGroup IN ('784HRY', '784SAL') THEN 'P462987841'
                                    WHEN EecPayGroup IN ('785HNU', '785HRY', '785SAL') THEN 'P462987851'
                                    WHEN EecPayGroup IN ('787HNU', '787HRY', '787SAL') THEN 'P462987871'                        
                                END
                            WHEN '1MED2' THEN
                                CASE WHEN EecPayGroup IN ('705HRY', '705SAL', '705SNE') THEN 'P468997051' --
                                    WHEN EecPayGroup IN ('722HRY', '722SAL', '722SNE') THEN 'P468997221' -- change
                                    WHEN EecPayGroup IN ('759SAL', '759SNE') THEN 'P468997591' --
                                    WHEN EecPayGroup IN ('768SAL', '768SNE') THEN 'P468997681' --
                                    WHEN EecPayGroup IN ('772HRY', '772SAL') THEN 'P468997721'
                                    WHEN EecPayGroup IN ('772SNE') THEN 'P468997731'
                                    WHEN EecPayGroup IN ('775HRY', '775SAL', '775SNE') THEN 'P468997751'
                                    WHEN EecPayGroup IN ('779HRY', '779SAL') THEN 'P468997791'
                                    WHEN EecPayGroup IN ('783HRY', '783SAL') THEN 'P468997831'
                                    WHEN EecPayGroup IN ('784HRY', '784SAL') THEN 'P468997841'
                                    WHEN EecPayGroup IN ('785HNU', '785HRY', '785SAL') THEN 'P468997851'
                                    WHEN EecPayGroup IN ('787HNU', '787HRY', '787SAL') THEN 'P468997871'                        
                                END                            
                            WHEN '1MEDC' THEN
                                CASE WHEN EecPayGroup IN ('705HRY', '705SAL', '705SNE') THEN 'P462987051'
                                    WHEN EecPayGroup IN ('722HRY', '722HSV', '722SAL', '722SNE', '722SSV') THEN 'P462987221'
                                    WHEN EecPayGroup IN ('759HRY', '759SAL', '759SNE') THEN 'P462987591'
                                    WHEN EecPayGroup IN ('768HRY', '768SAL', '768SNE') THEN 'P462987681'
                                    WHEN EecPayGroup IN ('772HRY', '772SAL') THEN 'P462987721'
                                    WHEN EecPayGroup IN ('772SNE') THEN 'P462987731'
                                    WHEN EecPayGroup IN ('775HRY', '775SAL', '775SNE') THEN 'P462987751'
                                    WHEN EecPayGroup IN ('779HRY', '779SAL') THEN 'P462987791'
                                    WHEN EecPayGroup IN ('783HRY', '783SAL') THEN 'P462987831'
                                    WHEN EecPayGroup IN ('784HRY', '784SAL') THEN 'P462987841'
                                    WHEN EecPayGroup IN ('785HNU', '785HRY', '785SAL') THEN 'P462987851'
                                    WHEN EecPayGroup IN ('787HNU', '787HRY', '787SAL') THEN 'P462987871'                        
                                END
                            WHEN '2MED1' THEN 
                                CASE WHEN EecPayGroup IN ('705HRY', '705SAL', '705SNE') THEN 'P462987051'
                                    WHEN EecPayGroup IN ('722HRY', '722HSV', '722SAL', '722SNE', '722SSV') THEN 'P462987221'
                                    WHEN EecPayGroup IN ('759HRY', '759SAL', '759SNE') THEN 'P462987591'
                                    WHEN EecPayGroup IN ('768HRY', '768SAL', '768SNE') THEN 'P462987681'
                                    WHEN EecPayGroup IN ('772HRY', '772SAL') THEN 'P462987721'
                                    WHEN EecPayGroup IN ('772SNE') THEN 'P462987731'
                                    WHEN EecPayGroup IN ('775HRY', '775SAL', '775SNE') THEN 'P462987751'
                                    WHEN EecPayGroup IN ('779HRY', '779SAL') THEN 'P462987791'
                                    WHEN EecPayGroup IN ('783HRY', '783SAL') THEN 'P462987831'
                                    WHEN EecPayGroup IN ('784HRY', '784SAL') THEN 'P462987841'
                                    WHEN EecPayGroup IN ('785HNU', '785HRY', '785SAL') THEN 'P462987851'
                                    WHEN EecPayGroup IN ('787HNU', '787HRY', '787SAL') THEN 'P462987871'                        
                                END
                            WHEN '2MED2' THEN
                                CASE WHEN EecPayGroup IN ('705HRY', '705SAL', '705SNE') THEN 'P468997051'
                                    WHEN EecPayGroup IN ('722HRY', '722HSV', '722SAL', '722SNE', '722SSV') THEN 'P468997221'
                                    WHEN EecPayGroup IN ('759HRY', '759SAL', '759SNE') THEN 'P468997591'
                                    WHEN EecPayGroup IN ('768HRY', '768SAL', '768SNE') THEN 'P468997681'
                                    WHEN EecPayGroup IN ('772HRY', '772SAL') THEN 'P468997721'
                                    WHEN EecPayGroup IN ('772SNE') THEN 'P468997731'
                                    WHEN EecPayGroup IN ('775HRY', '775SAL', '775SNE') THEN 'P468997751'
                                    WHEN EecPayGroup IN ('779HRY', '779SAL') THEN 'P468997791'
                                    WHEN EecPayGroup IN ('783HRY', '783SAL') THEN 'P468997831'
                                    WHEN EecPayGroup IN ('784HRY', '784SAL') THEN 'P468997841'
                                    WHEN EecPayGroup IN ('785HNU', '785HRY', '785SAL') THEN 'P468997851'
                                    WHEN EecPayGroup IN ('787HNU', '787HRY', '787SAL') THEN 'P468997871'                        
                                END
                            WHEN '2MEDC' THEN 
                                CASE WHEN EecPayGroup IN ('705HRY', '705SAL', '705SNE') THEN 'P468997051'
                                    WHEN EecPayGroup IN ('722HRY', '722HSV', '722SAL', '722SNE', '722SSV') THEN 'P468997221'
                                    WHEN EecPayGroup IN ('759HRY', '759SAL', '759SNE') THEN 'P468997591'
                                    WHEN EecPayGroup IN ('768HRY', '768SAL', '768SNE') THEN 'P468997681'
                                    WHEN EecPayGroup IN ('772HRY', '772SAL') THEN 'P468997721'
                                    WHEN EecPayGroup IN ('772SNE') THEN 'P468997731'
                                    WHEN EecPayGroup IN ('775HRY', '775SAL', '775SNE') THEN 'P468997751'
                                    WHEN EecPayGroup IN ('779HRY', '779SAL') THEN 'P468997791'
                                    WHEN EecPayGroup IN ('783HRY', '783SAL') THEN 'P468997831'
                                    WHEN EecPayGroup IN ('784HRY', '784SAL') THEN 'P468997841'
                                    WHEN EecPayGroup IN ('785HNU', '785HRY', '785SAL') THEN 'P468997851'
                                    WHEN EecPayGroup IN ('787HNU', '787HRY', '787SAL') THEN 'P468997871'                        
                                END
                            WHEN '3MED2' THEN 
                                CASE WHEN EecPayGroup IN ('705HRY', '705SAL', '705SNE') THEN 'P500917051'
                                    WHEN EecPayGroup IN ('722HRY', '722HSV', '722SAL', '722SNE', 'P50091722SSV') THEN '7221' -- Wat?!
                                    WHEN EecPayGroup IN ('759HRY', '759SAL', '759SNE') THEN 'P500917591'
                                    WHEN EecPayGroup IN ('768HRY', '768SAL', '768SNE') THEN 'P500917681'
                                    WHEN EecPayGroup IN ('772HRY') THEN 'P500917721' --
                                    WHEN EecPayGroup IN ('772SNE') THEN 'P500917731'
                                    WHEN EecPayGroup IN ('775HRY', '775SAL', '775SNE') THEN 'P500917751'
                                    WHEN EecPayGroup IN ('779HRY', '779SAL') THEN 'P500917791'
                                    WHEN EecPayGroup IN ('783HRY', '783SAL') THEN 'P500917831'
                                    WHEN EecPayGroup IN ('784HRY', '784SAL') THEN 'P500917841'
                                    WHEN EecPayGroup IN ('785HNU', '785HRY', '785SAL') THEN 'P500917851'
                                    WHEN EecPayGroup IN ('787HNU', '787HRY', '787SAL') THEN 'P500917871'                        
                                END*/
                        END
        ,drvGroupEffDate = CASE WHEN BdmBenStartDate < '01/01/2020' THEN '1/1/2020' ELSE BdmBenStartDate END
        ,drvMemberEffDate = CASE WHEN BdmBenStartDate < '01/01/2020' THEN '1/1/2020' ELSE BdmBenStartDate END
        ,drvMemberTermDate = BdmBenStopDate
        ,drvEmpSSN = eepSSN
        ,drvDepSSN = CASE WHEN BdmREcType <> 'EMP' THEN ConSSN END
        ,drvGender = CASE BdmRecType
                            WHEN 'EMP' THEN EepGender ELSE ConGender END
        ,drvFirstName = CASE BdmRecType
                            WHEN 'EMP' THEN '"' + EepNameFirst + '"' ELSE '"' + ConNameFirst + '"' END
        ,drvMiddleInit = CASE BdmRecType
                            WHEN 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle, 1) END
        ,drvLastName = CASE BdmRecType 
                        WHEN 'EMP' THEN '"' + EepNameLast + '"' ELSE '"' + ConNameLast + '"' END
        ,drvDateOfBirth = CASE BdmRecType
                            WHEN 'EMP' THEN EepDateOfBirth ELsE ConDateOfBirth END
        ,drvRelation =    CASE WHEN BdmRecType = 'EMP' THEN 'E'
                            ELSE CASE WHEN ConRelationship in ('SPS', 'DP') THEN 'S'
                                WHEN ConRelationship in ('CHL', 'DPC', 'STC') THEN
                                    CASE WHEN ConIsDisabled = 'Y' THEN 'AD' ELSE 'D' END
                            END
                        END
        ,drvAddress1 = '"' + EepAddressLine1 + '"' 
        ,drvAddress2 = CASE WHEN ISNULL(eepAddressLine2, '') <> '' THEN '"' + EepAddressLine2 + '"' END
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvEmail = CASE WHEN ISNULL(EepAddressEMail, '') <> '' THEN EepAddressEMail ELSE EepAddressEMailAlternate END
        ,drvPhone = CASE WHEN ISNULL(eepPhoneHomeNumber, '') <> '' THEN LEFT(eepPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(eepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4) END
        ,drvBenfitPackEffDate = ''
        ,drvDivId = CASE WHEN EecPayGroup IN ('705HRY', '705SAL', '705SNE') THEN '7051'
                        WHEN EecPayGroup IN ('722HRY', '722SAL', '722SNE') THEN '7221'
                        WHEN EecPayGroup IN ('759SAL', '759SNE') THEN '7591'
                        WHEN EecPayGroup IN ('768SAL', '768SNE') THEN '7681'
                        WHEN EecPayGroup IN ('772HRY') THEN '7721'
                        WHEN EecPayGroup IN ('772SNE', '772SAL') THEN '7731'
                        WHEN EecPayGroup IN ('775SAL', '775SNE') THEN '7751'
                        WHEN EecPayGroup IN ('779HRY', '779SAL') THEN '7791'
                        WHEN EecPayGroup IN ('783HRY', '783SAL') THEN '7831'
                        WHEN EecPayGroup IN ('784HRY', '784SAL') THEN '7841'
                        WHEN EecPayGroup IN ('785HNU', '785SAL') THEN '7851'
                        WHEN EecPayGroup IN ('787HNU', '787SAL') THEN '7871'                        
                    END
        ,drvDivName = CASE WHEN EecPayGroup IN ('705HRY', '705SAL', '705SNE') THEN 'JEWELL SMOKELESS COAL ACTIVE'
                        WHEN EecPayGroup IN ('722HRY', '722SAL', '722SNE') THEN 'SUNCOKE ENERGY COMPANY ACTIVE'
                        WHEN EecPayGroup IN ('759SAL', '759SNE') THEN 'HAVERHILL NORTH COKE COMPANY ACTIVE'
                        WHEN EecPayGroup IN ('768SAL', '768SNE', '768SNE') THEN 'INDIANA HARBOR COKE COMPANY ACTIVE'
                        WHEN EecPayGroup IN ('772HRY') THEN 'GATEWAY ENERGY & COKE ACTIVE'
                        WHEN EecPayGroup IN ('772SNE', '772SAL') THEN 'GATEWAY ENERGY & COKE NON-UNION ACTIVE'
                        WHEN EecPayGroup IN ('775SAL', '775SNE') THEN 'MIDDLETOWN COKE ACTIVE'
                        WHEN EecPayGroup IN ('779HRY', '779SAL') AND BdmDedCode = '1MED1' THEN 'JEWELL COKE ACTIVE'
                        WHEN EecPayGroup IN ('779HRY', '779SAL') AND BdmDedCode = '1MED2' THEN 'JEWELL COAL & COKE ACTIVE'
                        WHEN EecPayGroup IN ('783HRY', '783SAL') THEN 'DRT ACTIVE'
                        WHEN EecPayGroup IN ('784HRY', '784SAL') THEN 'CMT ACTIVES'
                        WHEN EecPayGroup IN ('785HNU', '785SAL') THEN 'LAKESHORE ACTIVE'
                        WHEN EecPayGroup IN ('787HNU', '787SAL') THEN 'KRT ACTIVES'                        
                    END
    INTO dbo.U_ETRIAHLEXP_drvTbl
    FROM dbo.U_ETRIAHLEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ETRIAHLEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConIsActive = 'Y'
        AND ConRelationship in ('SPS', 'DP', 'CHL', 'DPC', 'STC')
        AND (BdmDepRecId = ConSystemId OR BdmRecType = 'EMP')
    WHERE EecEeType <> 'TES'
            AND (eecemplstatus <> 'T'
            OR (eecemplstatus= 'T' 
            AND eectermreason <>'TRO' 
            AND EXISTS(select 1 from dbo.U_ETRIAHLEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
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
ALTER VIEW dbo.dsi_vwETRIAHLEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETRIAHLEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETRIAHLEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911151'
       ,expStartPerControl     = '201911151'
       ,expLastEndPerControl   = '201911229'
       ,expEndPerControl       = '201911229'
WHERE expFormatCode = 'ETRIAHLEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETRIAHLEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETRIAHLEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort