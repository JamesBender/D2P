SET NOCOUNT ON;
IF OBJECT_ID('U_ESPMWESTDS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESPMWESTDS_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESPMWESTDS' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESPMWESTDS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESPMWESTDS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESPMWESTDS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESPMWESTDS];
GO
IF OBJECT_ID('U_ESPMWESTDS_spmTbl') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_spmTbl];
GO
IF OBJECT_ID('U_ESPMWESTDS_spmplanTbl') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_spmplanTbl];
GO
IF OBJECT_ID('U_ESPMWESTDS_spmplanmemspcrateTbl') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_spmplanmemspcrateTbl];
GO
IF OBJECT_ID('U_ESPMWESTDS_spmHdr') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_spmHdr];
GO
IF OBJECT_ID('U_ESPMWESTDS_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_PEarHist];
GO
IF OBJECT_ID('U_ESPMWESTDS_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_PDedHist];
GO
IF OBJECT_ID('U_ESPMWESTDS_File') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_File];
GO
IF OBJECT_ID('U_ESPMWESTDS_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_EEList];
GO
IF OBJECT_ID('U_ESPMWESTDS_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ESPMWESTDS') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESPMWESTDS];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESPMWESTDS';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESPMWESTDS';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESPMWESTDS';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESPMWESTDS';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESPMWESTDS';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESPMWESTDS','SPM Benefits Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ESPMWESTDSZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESPMWESTDS' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[Version]"','1','(''DA''=''T,'')','ESPMWESTDSZ0','50','H','01','1',NULL,'VersionLineIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.2"','2','(''DA''=''T'')','ESPMWESTDSZ0','50','H','01','2',NULL,'Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[SPM]"','1','(''DA''=''T,'')','ESPMWESTDSZ0','50','D','10','1',NULL,'Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivName"','3','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutation"','4','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFName"','5','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddle"','6','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLName"','7','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndID"','9','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','10','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','11','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2"','12','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','13','(''UA''=''Q,'')','ESPMWESTDSZ0','50','D','10','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','14','(''UA''=''Q,'')','ESPMWESTDSZ0','50','D','10','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','15','(''UA''=''Q,'')','ESPMWESTDSZ0','50','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','16','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','16',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostCode"','17','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','18','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','20','(''UD101''=''T,'')','ESPMWESTDSZ0','50','D','10','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillStartDate"','21','(''UD101''=''T,'')','ESPMWESTDSZ0','50','D','10','21',NULL,'BillingStartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillEndDate"','22','(''UD101''=''T,'')','ESPMWESTDSZ0','50','D','10','22',NULL,'BillingEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillType"','23','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','23',NULL,'BillingType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillFreq"','24','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','24',NULL,'BillingFrequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsCOBRAElig"','25','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','25',NULL,'IsCOBRAEligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsCOBRAEligTerm"','26','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','26',NULL,'IsCOBRAEligibleAtTermination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsequentGraceNumDays"','27','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','27',NULL,'SubsequentGracePeriodNumDays',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubsequentGracePeriodOpt"','28','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','28',NULL,'SPMSubsequentGracePeriodOption',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsLegacy"','29','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','29',NULL,'IsLegacy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobaccoUse"','30','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','30',NULL,'TobaccoUse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','31','(''UD101''=''T,'')','ESPMWESTDSZ0','50','D','10','31',NULL,'EnrollmentDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','32','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','32',NULL,'EmployeeType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayrollType"','33','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','33',NULL,'EmployeePayrollType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYearsOfService"','34','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','34',NULL,'YearsOfService',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCoupon"','35','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','35',NULL,'PremiumCoupon',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActive"','36','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','36',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAllowMemberSSO"','37','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','37',NULL,'AllowMemberSSO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenGroup"','38','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','38',NULL,'BenefitGroup',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountStructure"','39','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','39',NULL,'AccountStructure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientCustomData"','40','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','40',NULL,'ClientCustomData',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSO"','41','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','41',NULL,'SSOIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','42','(''UD101''=''T,'')','ESPMWESTDSZ0','50','D','10','42',NULL,'EventDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInitialGracePeriodDate"','43','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','43',NULL,'InitialGracePeriodDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingSeedDate"','44','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','44',NULL,'BillingPeriodSeedDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSecBillingSeedDate"','45','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','10','45',NULL,'SecondBillingPeriodSeedDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCat"','46','(''UA''=''T'')','ESPMWESTDSZ0','50','D','10','46',NULL,'PlanCategory',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[SPMPLAN]"','1','(''DA''=''T,'')','ESPMWESTDSZ0','50','D','20','1',NULL,'Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','20','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','3','(''UD101''=''T,'')','ESPMWESTDSZ0','50','D','20','3',NULL,'StartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndDate"','4','(''UA''=''T,'')','ESPMWESTDSZ0','50','D','20','4',NULL,'EndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovLevel"','5','(''UA''=''T,'')','ESPMWESTDSZ0','51','D','20','5',NULL,'CoverageLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstDayOfCov"','6','(''UA''=''T,'')','ESPMWESTDSZ0','52','D','20','6',NULL,'FirstDayOfCoverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastDayOfCov"','7','(''UA''=''T,'')','ESPMWESTDSZ0','53','D','20','7',NULL,'LastDayOfCoverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastDatesRateNotif"','8','(''UA''=''T,'')','ESPMWESTDSZ0','54','D','20','8',NULL,'LastDateRatesNotified',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSendPlanChangeLetter"','9','(''UA''=''T,'')','ESPMWESTDSZ0','54','D','20','9',NULL,'SendPlanChangeLetter',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfUnits"','10','(''UA''=''T,'')','ESPMWESTDSZ0','54','D','20','10',NULL,'NumberOfUnits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBundle"','11','(''UA''=''T'')','ESPMWESTDSZ0','54','D','20','11',NULL,'BundleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[SPMPLANMEMBERSPECIFICRATE]"','1','(''DA''=''T,'')','ESPMWESTDSZ0','54','D','30','1',NULL,'Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','ESPMWESTDSZ0','54','D','30','2',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','3','(''UD101''=''T,'')','ESPMWESTDSZ0','54','D','30','3',NULL,'StartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndDate"','4','(''UA''=''T,'')','ESPMWESTDSZ0','54','D','30','4',NULL,'EndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','5','(''UA''=''T'')','ESPMWESTDSZ0','54','D','30','5',NULL,'Rate',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESPMWESTDS_20210712.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SPM Benefits Export','202106119','EMPEXPORT','ONDEM_XOE',NULL,'ESPMWESTDS',NULL,NULL,NULL,'202106119','Jun 11 2021 10:50AM','Jun 11 2021 10:50AM','202106111',NULL,'','','202106111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SPM Benefits Export-Sched','202106119','EMPEXPORT','SCH_ESPMWE',NULL,'ESPMWESTDS',NULL,NULL,NULL,'202106119','Jun 11 2021 10:50AM','Jun 11 2021 10:50AM','202106111',NULL,'','','202106111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'SPM Benefits Export-Test','202106241','EMPEXPORT','TEST_XOE','Jul  1 2021  9:39AM','ESPMWESTDS',NULL,NULL,NULL,'202106241','Jun 24 2021 12:00AM','Dec 30 1899 12:00AM','202106101','792','','','202106101',dbo.fn_GetTimedKey(),NULL,'CPETITTI16',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPMWESTDS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPMWESTDS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPMWESTDS','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPMWESTDS','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPMWESTDS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPMWESTDS','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESPMWESTDS' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESPMWESTDS' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESPMWESTDS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESPMWESTDS_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESPMWESTDS','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESPMWESTDS','D10','dbo.U_ESPMWESTDS_spmTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESPMWESTDS','D20','dbo.U_ESPMWESTDS_spmplanTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESPMWESTDS','D30','dbo.U_ESPMWESTDS_spmplanmemspcrateTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ESPMWESTDS') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESPMWESTDS] (
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
IF OBJECT_ID('U_ESPMWESTDS_DedList') IS NULL
CREATE TABLE [dbo].[U_ESPMWESTDS_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESPMWESTDS_EEList') IS NULL
CREATE TABLE [dbo].[U_ESPMWESTDS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESPMWESTDS_File') IS NULL
CREATE TABLE [dbo].[U_ESPMWESTDS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ESPMWESTDS_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESPMWESTDS_PDedHist] (
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
IF OBJECT_ID('U_ESPMWESTDS_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESPMWESTDS_PEarHist] (
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
IF OBJECT_ID('U_ESPMWESTDS_spmHdr') IS NULL
CREATE TABLE [dbo].[U_ESPMWESTDS_spmHdr] (
    [drvIdentifier] varchar(9) NOT NULL,
    [drvVersion] varchar(3) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ESPMWESTDS_spmplanmemspcrateTbl') IS NULL
CREATE TABLE [dbo].[U_ESPMWESTDS_spmplanmemspcrateTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(45) NULL,
    [drvStartDate] varchar(30) NOT NULL,
    [drvEndDate] varchar(1) NOT NULL,
    [drvRate] money NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ESPMWESTDS_spmplanTbl') IS NULL
CREATE TABLE [dbo].[U_ESPMWESTDS_spmplanTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPlanName] varchar(43) NULL,
    [drvStartDate] varchar(30) NOT NULL,
    [drvEndDate] varchar(1) NOT NULL,
    [drvCovLevel] varchar(12) NULL,
    [drvFirstDayOfCov] varchar(1) NOT NULL,
    [drvLastDayOfCov] varchar(1) NOT NULL,
    [drvLastDatesRateNotif] varchar(1) NOT NULL,
    [drvSendPlanChangeLetter] varchar(5) NOT NULL,
    [drvNumberOfUnits] varchar(1) NOT NULL,
    [drvBundle] varchar(1) NOT NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ESPMWESTDS_spmTbl') IS NULL
CREATE TABLE [dbo].[U_ESPMWESTDS_spmTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvClientName] varchar(33) NOT NULL,
    [drvClientDivName] varchar(29) NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFName] varchar(100) NULL,
    [drvMiddle] varchar(1) NULL,
    [drvLName] varchar(100) NULL,
    [drvSSN] varchar(11) NULL,
    [drvIndID] varchar(1) NOT NULL,
    [drvEmail] varchar(1) NOT NULL,
    [drvPhone] varchar(1) NOT NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvPostCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvSex] varchar(1) NOT NULL,
    [drvDOB] datetime NULL,
    [drvBillStartDate] varchar(30) NOT NULL,
    [drvBillEndDate] varchar(30) NOT NULL,
    [drvBillType] varchar(14) NULL,
    [drvBillFreq] varchar(7) NOT NULL,
    [drvIsCOBRAElig] varchar(5) NOT NULL,
    [drvIsCOBRAEligTerm] varchar(5) NOT NULL,
    [drvSubsequentGraceNumDays] varchar(1) NOT NULL,
    [drvSubsequentGracePeriodOpt] varchar(13) NOT NULL,
    [drvIsLegacy] varchar(5) NOT NULL,
    [drvTobaccoUse] varchar(7) NOT NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeType] varchar(3) NOT NULL,
    [drvEmployeePayrollType] varchar(6) NOT NULL,
    [drvYearsOfService] varchar(1) NOT NULL,
    [drvPremiumCoupon] varchar(10) NOT NULL,
    [drvActive] varchar(4) NOT NULL,
    [drvAllowMemberSSO] varchar(5) NOT NULL,
    [drvBenGroup] varchar(1) NOT NULL,
    [drvAccountStructure] varchar(1) NOT NULL,
    [drvClientCustomData] varchar(1) NOT NULL,
    [drvSSO] varchar(1) NOT NULL,
    [drvEventDate] varchar(30) NOT NULL,
    [drvInitialGracePeriodDate] varchar(1) NOT NULL,
    [drvBillingSeedDate] varchar(1) NOT NULL,
    [drvSecBillingSeedDate] varchar(1) NOT NULL,
    [drvPlanCat] varchar(1) NOT NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESPMWESTDS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Western Dental Services

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 06/11/2021
Service Request Number: SR-2021-00309704

Purpose: SPM Benefits Export

Revision History
----------------
06/22/2021 by AP:
        - Set all employee output to LOA.
        - Fixed output order of employee records to SPM -> SPMPLAN -> SPMPLANMEMBERSPECIFICRATE.
        - Added double quote to field address1, address2 and city.
        - Set Allow Member SSO field to FALSE.
        - Set Benefit Group to BLANK.

06/29/2021 by AP:
        - Fixed sorting issue.
        - Fixed SPMPLAN not showing on file.
        - SPMPLANMEMBERSPECIFICRATE value change for plan name field.

07/12/2021 by AP:
		- Updated client division name field.
		- Updated plan name field.
		- Updated where eedeeamt > 0.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESPMWESTDS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESPMWESTDS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESPMWESTDS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESPMWESTDS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESPMWESTDS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPMWESTDS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPMWESTDS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPMWESTDS', 'SCH_ESPMWE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESPMWESTDS';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESPMWESTDS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESPMWESTDS';

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
    DELETE FROM dbo.U_ESPMWESTDS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESPMWESTDS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DENAL, MEDAB, MEDEB, MEDEH, MEDAG, MEDAS, VLBTC, VLBTE, VLBTS, VCAN, VIDP, VIDV, MEDK2, MEDK4, MEDK1, MEDK3, VACC, VCIEE, VCISP, VHOSP, VLFCH, VLFEE, VLFSP, VLTD2, VSTD, VISN, DEN3, DENAZ, VCICH';

    IF OBJECT_ID('U_ESPMWESTDS_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESPMWESTDS_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESPMWESTDS_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_PDedHist;
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
    INTO dbo.U_ESPMWESTDS_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESPMWESTDS_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESPMWESTDS_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_PEarHist;
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
    INTO dbo.U_ESPMWESTDS_PEarHist
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
    -- DETAIL RECORD - U_ESPMWESTDS_spmTbl
    ---------------------------------
    IF OBJECT_ID('U_ESPMWESTDS_spmTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_spmTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvClientName = REPLACE(CmpCompanyName, ',', '')
		--'Western Dental Services Inc 21645'
        ,drvClientDivName = CASE WHEN EecCOID IN ('MV70M', 'N0A78') THEN 'DB Brident Dental Services-TX' 
                                    WHEN EecCOID = 'N0A01' THEN 'DB Kelley Dunay DMD P.C.-NV'
                                    WHEN EecCOID = 'N0A9B' THEN 'DB Soumava Sen DDS P.C.-TX'
                                    WHEN EecCOID = 'MV7G2' THEN 'DB Vital Smiles-AL'
                                    WHEN EecCOID = 'N0A50' THEN 'DB Western Dental of AZ'
                                    WHEN EecCOID = 'N0BXX' THEN 'DB Western Dental of NV' 
                                    WHEN EecCOID = 'N09HN' THEN 'DB Western Dental Services-CA' END
        ,drvSalutation = ''
        ,drvFName = RTRIM(EepNameFirst)
        ,drvMiddle = LEFT(EepNameMiddle, 1)
        ,drvLName = RTRIM(EepNameLast)
        ,drvSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                    SUBSTRING(EepSSN, 4, 2)+'-'+
                    SUBSTRING(EepSSN, 6, 4) 
        ,drvIndID = ''
        ,drvEmail = ''
        ,drvPhone = ''
        ,drvPhone2 = ''
        ,drvAddress1 = EepAddressLine1
        ,drvAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvPostCode = EepAddressZipCode
        ,drvCountry = ''
        ,drvSex = CASE WHEN EepGender = 'M' THEN 'M' WHEN EepGender = 'F' THEN 'F' ELSE 'U' END
        ,drvDOB = EepDateOfBirth
        ,drvBillStartDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END), 101), '')
        ,drvBillEndDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'A' AND Esh.EshEmplStatus = 'L' THEN Esh.EshStatusStopDate END), 101), '')
        ,drvBillType = CASE WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE' END
        ,drvBillFreq = 'MONTHLY' 
        ,drvIsCOBRAElig = 'FALSE'
        ,drvIsCOBRAEligTerm = 'FALSE'
        ,drvSubsequentGraceNumDays = ''
        ,drvSubsequentGracePeriodOpt = 'CLIENTDEFAULT'
        ,drvIsLegacy = 'FALSE'
        ,drvTobaccoUse = 'UNKNOWN'
        ,drvEnrollmentDate = (SELECT MIN(EdhBenStartDate) FROM dbo.EmpHDed WITH(NOLOCK) WHERE EdhEEID = xEEID AND EdhCOID = xCOID)
        ,drvEmployeeType = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'FTE' ELSE 'PTE' END
        ,drvEmployeePayrollType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'SALARY' ELSE 'HOURLY' END
        ,drvYearsOfService = ''
        ,drvPremiumCoupon = 'COUPONBOOK'
        ,drvActive = 'TRUE'
        ,drvAllowMemberSSO = 'FALSE'
        ,drvBenGroup = ''
        ,drvAccountStructure = ''
        ,drvClientCustomData = ''
        ,drvSSO = ''
        ,drvEventDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END), 101), '')
        ,drvInitialGracePeriodDate = ''
        ,drvBillingSeedDate = ''
        ,drvSecBillingSeedDate = ''
        ,drvPlanCat = ''
        ,drvInitialSort = '2' + EepSSN
        ,drvSubSort = '1'
    INTO dbo.U_ESPMWESTDS_spmTbl
    FROM dbo.U_ESPMWESTDS_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK) ON xEEID = eepEEID
    JOIN dbo.EmpComp WITH(NOLOCK) ON xEEID = eecEEID AND xCOID = eecCOID
    JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK) ON xEEID = EedEEID AND xCOID = EedCOID
	LEFT JOIN dbo.Company WITH(NOLOCK) ON CmpCOID = xCOID
    LEFT JOIN (SELECT EshEEID, EshCOID, EshEmplStatus, MAX(EshStatusStopDate) AS EshStatusStopDate
                FROM dbo.EmpHStat WITH(NOLOCK)
                WHERE EshEmplStatus = 'L'
                GROUP BY EshEEID, EshCOID, EshEmplStatus
                ) Esh ON Esh.EshEEID = xEEID AND Esh.EshCOID = xCOID
    WHERE EedFormatCode = @FormatCode
    AND EedValidForExport = 'Y'
    AND EecEmplStatus = 'L'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESPMWESTDS_spmplanTbl
    ---------------------------------
    IF OBJECT_ID('U_ESPMWESTDS_spmplanTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_spmplanTbl;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE EedDedCode 
                            WHEN 'DENAL' THEN 'DB Aetna Dental (Alabama Only)'
                            WHEN 'MEDAB' THEN 'DB Anthem BCBS Medical Bronze PPO'
                            WHEN 'MEDEB' THEN 'DB Anthem BCBS Medical EPO'
                            WHEN 'MEDEH' THEN 'DB Anthem BCBS Medical EPO HSA'
                            WHEN 'MEDAG' THEN 'DB Anthem BCBS Medical Gold PPO'
                            WHEN 'MEDAS' THEN 'DB Anthem BCBS Medical Silver PPO'
                            WHEN 'VLBTC' THEN 'DB Chubb LTD Child'
                            WHEN 'VLBTE' THEN 'DB Chubb LTD Employee'
                            WHEN 'VLBTS' THEN 'DB Chubb LTD Spouse'
                            WHEN 'VCAN' THEN 'DB Guardian Cancer'
                            WHEN 'VIDP' THEN 'DB Identity Guard Premier'
                            WHEN 'VIDV' THEN 'DB Identity Guard Value'
                            WHEN 'MEDK2' THEN 'DB Kaiser Northern CA DHMO'
                            WHEN 'MEDK4' THEN 'DB Kaiser Northern CA HDHP HMO w/HSA'
                            WHEN 'MEDK1' THEN 'DB Kaiser Sourthern CA DHMO'
                            WHEN 'MEDK3' THEN 'DB Kaiser Sourthern CA HDHP HMO w/HSA'
                            WHEN 'VACC' THEN 'DB MetLife Accident'
                            WHEN 'VCIEE' THEN 'DB MetLife Critical Illness - EE'
                            WHEN 'VCISP' THEN 'DB MetLife Critical Illness - Spouse'
                            WHEN 'VHOSP' THEN 'DB MetLife Hospital Indemnity'
                            WHEN 'VLFCH' THEN 'DB MetLife Voluntary Child Life'
                            WHEN 'VLFEE' THEN 'DB MetLife Voluntary Life and AD&D - Employee'
                            WHEN 'VLFSP' THEN 'DB MetLife Voluntary Life and AD&D - Spouse'
                            WHEN 'VLTD2' THEN 'DB MetLife Voluntary LTD'
                            WHEN 'VSTD' THEN 'DB MetLife Voluntary STD - Out of CA'
                            WHEN 'VISN' THEN 'DB VSP Vision'
                            WHEN 'DEN3' THEN 'DB Western Dental DHMO CA Only'
                            WHEN 'DENAZ' THEN 'DB Western Dental Premier Choice AZ Only'
                            WHEN 'VCICH' THEN 'DB MetLife Critical Illness - Children' END

        ,drvStartDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END), 101), '')
        ,drvEndDate = ''
        ,drvCovLevel = CASE WHEN EedDedCode = 'VLFCH' THEN 'CHILDRENONLY' -- FIGURE OUT 1 child dependent 
                                WHEN EedDedCode IN ('VCISP', 'VLFSP') THEN 'SPOUSEONLY'
                                WHEN EedDedCode = 'DENAL' AND EedBenOption = 'EE' THEN 'EE'
                                WHEN EedDedCode = 'DENAL' AND EedBenOption = 'EESP' THEN 'EE+1'
                                WHEN EedDedCode = 'DENAL' AND EedBenOption = 'EECH' THEN 'EE+CHILDREN'
                                WHEN EedDedCode = 'DENAL' AND EedBenOption = 'FAM' THEN 'EE+FAMILY' 
                                WHEN EedBenOption IN ('EE', 'EE50', 'EE65', 'EE49') THEN 'EE' 
                                WHEN EedBenOption = 'EE1' THEN 'EE+1'
                                WHEN EedBenOption = 'EECH' THEN 'EE+CHILDREN'
                                WHEN EedBenOption IN ('FAM', 'EES49', 'EES50') THEN 'EE+FAMILY'
                                WHEN EedBenOption = 'EESP' THEN 'EE+SPOUSE' END
        ,drvFirstDayOfCov = ''
        ,drvLastDayOfCov = ''
        ,drvLastDatesRateNotif = ''
        ,drvSendPlanChangeLetter = 'FALSE'
        ,drvNumberOfUnits = ''
        ,drvBundle = ''
        ,drvInitialSort = '2' + EepSSN
        ,drvSubSort = '2'
    INTO dbo.U_ESPMWESTDS_spmplanTbl
    FROM dbo.U_ESPMWESTDS_spmTbl WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = drvEEID
    JOIN dbo.EmpComp WITH(NOLOCK) 
    ON EecEEID = drvEEID AND EecCOID = drvCOID
    JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
    ON drvEEID = EedEEID AND drvCOID = EedCOID
    WHERE EedFormatCode = @FormatCode
    AND EedValidForExport = 'Y'
    AND EecEmplStatus = 'L'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESPMWESTDS_spmplanmemspcrateTbl
    ---------------------------------
    IF OBJECT_ID('U_ESPMWESTDS_spmplanmemspcrateTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESPMWESTDS_spmplanmemspcrateTbl;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE EedDedCode 
                            WHEN 'VCAN' THEN 'DB Guardian Cancer'
                            WHEN 'VCIEE' THEN 'DB MetLife Critical Illness - EE'
                            WHEN 'VCISP' THEN 'DB MetLife Critical Illness - Spouse'
                            WHEN 'VLFCH' THEN 'DB MetLife Voluntary Child Life'
                            WHEN 'VLFEE' THEN 'DB MetLife Voluntary Life and AD&D - Employee'
                            WHEN 'VLFSP' THEN 'DB MetLife Voluntary Life and AD&D - Spouse'
                            WHEN 'VLTD2' THEN 'DB MetLife Voluntary LTD'
                            WHEN 'VSTD' THEN 'DB MetLife Voluntary STD - Out of CA'
                            WHEN 'VCICH' THEN 'DB MetLife Critical Illness - Children' END
        ,drvStartDate = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END), 101), '')
        ,drvEndDate = ''
        ,drvRate = EedEEAmt * 2
        ,drvInitialSort = '2' + EepSSN
        ,drvSubSort = '3'
    INTO dbo.U_ESPMWESTDS_spmplanmemspcrateTbl
    FROM dbo.U_ESPMWESTDS_spmTbl WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = drvEEID
    JOIN dbo.EmpComp WITH(NOLOCK) 
    ON EecEEID = drvEEID AND EecCOID = drvCOID
    JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
    ON drvEEID = EedEEID AND drvCOID = EedCOID
    WHERE EedDedCode IN ('VCAN', 'VCIEE', 'VCISP', 'VLFCH', 'VLFEE', 'VLFSP', 'VLTD2', 'VSTD', 'VCICH')
    AND EedFormatCode = @FormatCode
    and EedValidForExport = 'Y'
    AND EecEmplStatus = 'L'
	AND EedEEAmt > 0.00
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
ALTER VIEW dbo.dsi_vwESPMWESTDS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESPMWESTDS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESPMWESTDS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106041'
       ,expStartPerControl     = '202106041'
       ,expLastEndPerControl   = '202106119'
       ,expEndPerControl       = '202106119'
WHERE expFormatCode = 'ESPMWESTDS';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESPMWESTDS_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESPMWESTDS_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, RecordSet;
  --  ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

  --select InitialSort, SubSort, RecordSet
  --from U_ESPMWESTDS_File
  --ORDER BY InitialSort, SubSort, RecordSet;