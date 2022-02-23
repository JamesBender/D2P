SET NOCOUNT ON;
IF OBJECT_ID('U_ESTAFFCUEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESTAFFCUEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESTAFFCUEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESTAFFCUEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESTAFFCUEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTAFFCUEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTAFFCUEX];
GO
IF OBJECT_ID('U_ESTAFFCUEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_Trailer];
GO
IF OBJECT_ID('U_ESTAFFCUEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_PEarHist];
GO
IF OBJECT_ID('U_ESTAFFCUEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_PDedHist];
GO
IF OBJECT_ID('U_ESTAFFCUEX_Header') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_Header];
GO
IF OBJECT_ID('U_ESTAFFCUEX_File') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_File];
GO
IF OBJECT_ID('U_ESTAFFCUEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_EEList];
GO
IF OBJECT_ID('U_ESTAFFCUEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_drvTbl];
GO
IF OBJECT_ID('U_ESTAFFCUEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_DedList];
GO
IF OBJECT_ID('U_ESTAFFCUEX_BdmConsolidated') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_BdmConsolidated];
GO
IF OBJECT_ID('U_ESTAFFCUEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_AuditFields];
GO
IF OBJECT_ID('U_ESTAFFCUEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESTAFFCUEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESTAFFCUEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESTAFFCUEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESTAFFCUEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESTAFFCUEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESTAFFCUEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESTAFFCUEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTAFFCUEX','The Standard File Life Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','21000','S','N','ESTAFFCUEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderIdentifier "','1','(''UA''=''T|'')','ESTAFFCUEXZ0','50','H','01','1',NULL,'Header Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDate "','2','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','H','01','2',NULL,'File Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSFGCompanyID "','3','(''UA''=''T|'')','ESTAFFCUEXZ0','50','H','01','3',NULL,'SFG Company ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerName "','4','(''UA''=''T|'')','ESTAFFCUEXZ0','50','H','01','4',NULL,'Customer Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupID "','5','(''UA''=''T'')','ESTAFFCUEXZ0','50','H','01','5',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy"','1','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','1',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingDivision"','2','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','2',NULL,'Billing Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingDivisionEffDate"','3','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','3',NULL,'Billing Division Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingCategory"','4','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','4',NULL,'Billing Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingCategoryEffDate"','5','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','5',NULL,'Billing Category Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocialSecurityNumber"','6','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','6',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','7','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','7',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','8','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','8',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','9','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','9',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','10','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','10',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','11','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','11',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationCode"','12','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','12',NULL,'Occupation Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','13','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','13',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentHireDate"','14','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','14',NULL,'Current Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyEligibilityDate"','15','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','15',NULL,'Policy Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyEffectiveDate"','16','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','16',NULL,'Policy Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','17','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','17',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTobaccoIndicator"','18','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','18',NULL,'Employee Tobacco Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkHours"','19','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','19',NULL,'Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsAmount"','20','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','20',NULL,'Earnings Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsMode"','21','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','21',NULL,'Earnings Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsAmountEffDate"','22','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','22',NULL,'Earnings Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollfrequency"','23','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','23',NULL,'Payroll frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyIndicator"','24','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','24',NULL,'Family Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyIndicatorEffDate"','25','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','25',NULL,'Family Indicator Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifyingEventDate"','26','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','26',NULL,'Qualifying Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','27',NULL,'Employer Affiliate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','28',NULL,'Customer Defined Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','29',NULL,'Customer Defined Billing Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','30',NULL,'Job Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','31',NULL,'Job Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','32',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','33',NULL,'Employer Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','34',NULL,'Full Time or Part Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','35',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','36',NULL,'Exempt Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','37',NULL,'Grandfathered Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','38',NULL,'Union Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','39',NULL,'Union Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','40',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','41',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','42',NULL,'Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','43',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','44',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','45',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','46',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','47',NULL,'Email address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseFirstName"','48','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','48',NULL,'Spouse First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLastName"','49','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','49',NULL,'Spouse Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDOB"','50','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','50',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','51',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','52',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','53',NULL,'Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','54',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','55',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','56',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','57',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','58',NULL,'Email address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshiptoMember"','59','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','59',NULL,'Relationship to Member',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseGender"','60','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','60',NULL,'Spouse Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseTobaccoIndicator"','61','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','61',NULL,'Spouse Tobacco Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductIDBL"','62','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','62',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','63',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','64',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','65',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','66',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDateBL"','67','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','67',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTerminationDateBL"','68','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','68',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','69',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','70',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','71',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductIDAdd"','72','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','72',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','73',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','74',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','75',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','76',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDateAdd"','77','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','77',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTerminationDateAdd"','78','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','78',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','79',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','80',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','81',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductIDAL"','82','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','82',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','83',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','84',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','85',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','86',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDateAL"','87','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','87',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTerminationDateAL"','88','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','88',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','89',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveAmount"','90','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','90',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTakeoverAmount"','91','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','91',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','92',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','93',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','94',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','95',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','96',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','97',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','98',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','99',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','100',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','101',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','102',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','103',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','104',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','105',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','106',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','107',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','108',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','109',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','110',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','111',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductIDASL"','112','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','112',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','113',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','114',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','115',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','116',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDateASL"','117','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','117',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTerminationDateASL"','118','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','118',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','119','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','119',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveAmountASL"','120','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','120',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','121','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','121',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','122','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','122',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','123','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','123',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','124','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','124',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','125','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','125',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','126','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','126',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','127','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','127',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','128','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','128',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','129',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','130',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','131',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','132',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','133',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','134',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','135',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','136',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','137',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','138',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','139',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','140',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','141',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','142',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','143',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','144',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','145',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','146',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','147',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','148',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','149',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','150',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','151',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductIDACL"','152','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','152',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','153','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','153',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','154','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','154',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','155',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','156','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','156',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDateACL"','157','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','157',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTerminationDateACL"','158','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','158',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','159','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','159',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveAmountACL"','160','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','160',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','161',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','162','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','162',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','163','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','163',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','164','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','164',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','165','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','165',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','166','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','166',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','167','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','167',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','168','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','168',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','169','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','169',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','170','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','170',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','171','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','171',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','172','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','172',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','173',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','174','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','174',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','175','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','175',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','176','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','176',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','177',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','178','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','178',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','179',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','180',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','181','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','181',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductIDDL"','182','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','182',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','183',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','184',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','185',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','186',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDateDL"','187','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','187',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTerminationDateDL"','188','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','188',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyElectionIndicatorDL"','189','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','189',NULL,'Family Election Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','190','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','190',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','191','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','191',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','192','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','192',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','193','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','193',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','194','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','194',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','195','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','195',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','196','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','196',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','197','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','197',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','198','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','198',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','199','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','199',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','200','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','200',NULL,'Family Election Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','201','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','201',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','202','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','202',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','203','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','203',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','204','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','204',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','205','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','205',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','206','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','206',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','207','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','207',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','208','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','208',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','209','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','209',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','210','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','210',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','211','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','211',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','212','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','212',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','213','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','213',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','214','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','214',NULL,'Spouse Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','215','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','215',NULL,'Spouse Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','216','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','216',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','217','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','217',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','218','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','218',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','219','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','219',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','220','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','220',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','221','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','221',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','222','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','222',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','223','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','223',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','224','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','224',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','225','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','225',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','226','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','226',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','227','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','227',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','228','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','228',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','229','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','229',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','230','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','230',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','231','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','231',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','232','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','232',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','233','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','233',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','234','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','234',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','235','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','235',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','236','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','236',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','237','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','237',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','238','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','238',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','239','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','239',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','240','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','240',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','241','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','241',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','242','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','242',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','243','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','243',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','244','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','244',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','245','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','245',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','246','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','246',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','247','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','247',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','248','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','248',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','249','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','249',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','250','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','250',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','251','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','251',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','252','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','252',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','253','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','253',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','254','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','254',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','255','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','255',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductIDSTD"','256','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','256',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','257','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','257',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','258','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','258',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','259','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','259',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','260','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','260',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDateSTD"','261','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','261',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTerminationDateSTD"','262','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','262',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','263','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','263',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','264','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','264',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','265','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','265',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','266','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','266',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','267','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','267',NULL,'Maximum Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','268','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','268',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','269','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','269',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','270','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','270',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','271','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','271',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','272','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','272',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','273','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','273',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','274','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','274',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','275',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','276',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','277',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductIDLTD1"','278','(''UA''=''T|'')','ESTAFFCUEXZ0','50','D','10','278',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','279',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','280','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','280',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','281','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','281',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','282','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','282',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDateLTD1"','283','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','283',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTermiDateLTD1"','284','(''UD112''=''T|'')','ESTAFFCUEXZ0','50','D','10','284',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','285','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','285',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','286','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','286',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','287','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','287',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','288','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','288',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','289','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','289',NULL,'Maximum Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','290','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','290',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','291','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','291',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','292','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','292',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','293','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','293',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','294','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','294',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','295','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','295',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','296','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','296',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','297','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','297',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','298','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','298',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','299','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','299',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','300','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','300',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','301','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','301',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','302','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','302',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','303','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','303',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','304','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','304',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','305','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','305',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','306','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','306',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','307','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','307',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','308','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','308',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','309','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','309',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','310','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','310',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','311','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','311',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','312','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','312',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','313','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','313',NULL,'Coverage Factor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','314','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','314',NULL,'Coverage Election Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','315','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','315',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','316','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','316',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','317','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','317',NULL,'Coverage Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','318','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','318',NULL,'Coverage Effective Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','319','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','319',NULL,'Coverage Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','320','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','320',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','321','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','321',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','322','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','322',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','323','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','323',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','324','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','324',NULL,'Family Election Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','325','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','325',NULL,'Health Maintenance Screening Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','326','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','326',NULL,'Automobile Accident Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','327','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','327',NULL,'Question 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','328','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','328',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','329','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','329',NULL,'Employee Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','330','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','330',NULL,'Employee Amount with Cancer Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','331','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','331',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','332','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','332',NULL,'Employee Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','333','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','333',NULL,'Employee Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','334','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','334',NULL,'Spouse Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','335','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','335',NULL,'Spouse Amount with Cancer Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','336','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','336',NULL,'Spouse Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','337','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','337',NULL,'Spouse Percent with Cancer Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','338','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','338',NULL,'Spouse Gainfully Employed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','339','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','339',NULL,'Spouse Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','340','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','340',NULL,'Spouse Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','341','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','341',NULL,'Health Maintenance Screening Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','342','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','342',NULL,'All questions answered favorably for employee bene',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','343','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','343',NULL,'All questions answered favorably for spouse benefi',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','344','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','344',NULL,'Question 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','345','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','345',NULL,'Question 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','346','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','346',NULL,'Question 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','347','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','347',NULL,'Question 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','348','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','348',NULL,'Question 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','349','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','349',NULL,'Question 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','350','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','350',NULL,'Question 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','351','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','351',NULL,'Question 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','352','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','352',NULL,'Question 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','353','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','353',NULL,'Question 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','354','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','354',NULL,'Question 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','355','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','355',NULL,'Question 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','356','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','356',NULL,'Question 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','357','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','357',NULL,'Question 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','358','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','358',NULL,'Spouse Question 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','359','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','359',NULL,'Spouse Question 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','360','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','360',NULL,'Spouse Question 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','361','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','361',NULL,'Spouse Question 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','362','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','362',NULL,'Spouse Question 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','363','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','363',NULL,'Spouse Question 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','364','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','364',NULL,'Spouse Question 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','365','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','365',NULL,'Spouse Question 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','366','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','366',NULL,'Spouse Question 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','367','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','367',NULL,'Spouse Question 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','368','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','368',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','369','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','369',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','370','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','370',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','371','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','371',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','372','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','372',NULL,'Family Election Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','373','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','373',NULL,'Health Maintenance Screening Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','374','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','374',NULL,'Spouse Gainfully Employed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','375','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','375',NULL,'All questions answered favorably for employee bene',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','376','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','376',NULL,'All questions answered favorably for spouse benefi',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','377','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','377',NULL,'All questions answered favorably for child benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','378','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','378',NULL,'Question 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','379','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','379',NULL,'Question 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','380','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','380',NULL,'Question 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','381','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','381',NULL,'Question 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','382','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','382',NULL,'Question 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','383','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','383',NULL,'Question 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','384','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','384',NULL,'Question 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','385','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','385',NULL,'Question 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','386','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','386',NULL,'Question 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','387','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','387',NULL,'Question 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','388','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','388',NULL,'Question 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','389','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','389',NULL,'Spouse Question 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','390','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','390',NULL,'Spouse Question 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','391','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','391',NULL,'Spouse Question 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','392','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','392',NULL,'Spouse Question 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','393','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','393',NULL,'Spouse Question 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','394','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','394',NULL,'Spouse Question 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','395','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','395',NULL,'Spouse Question 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','396','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','396',NULL,'Spouse Question 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','397','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','397',NULL,'Spouse Question 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','398','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','398',NULL,'Spouse Question 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','399','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','399',NULL,'Child Question 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','400','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','400',NULL,'Child Question 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','401','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','401',NULL,'Child Question 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','402','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','402',NULL,'Child Question 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','403','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','403',NULL,'Child Question 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','404','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','404',NULL,'Child Question 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','405','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','405',NULL,'Child Question 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','406','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','406',NULL,'Child Question 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','407','(''DA''=''T|'')','ESTAFFCUEXZ0','50','D','10','407',NULL,'Child Question 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','408','(''DA''=''T'')','ESTAFFCUEXZ0','50','D','10','408',NULL,'Child Question 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TLR"','1','(''DA''=''T|'')','ESTAFFCUEXZ0','50','T','90','1',NULL,'Trailer Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerRecCount"','2','(''UA''=''T'')','ESTAFFCUEXZ0','50','T','90','2',NULL,'Record Count',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTAFFCUEX_20200915.txt',NULL,'','',NULL,NULL,NULL,NULL,'The Standard File Life Export','202007099','EMPEXPORT','ONDEMAND',NULL,'ESTAFFCUEX',NULL,NULL,NULL,'202007099','Jul  9 2020  3:54PM','Jul  9 2020  3:54PM','202007091',NULL,'','','202007091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTAFFCUEX_20200915.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202007099','EMPEXPORT','SCH_STFF',NULL,'ESTAFFCUEX',NULL,NULL,NULL,'202007099','Jul  9 2020  3:54PM','Jul  9 2020  3:54PM','202007091',NULL,'','','202007091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTAFFCUEX_20200915.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202007099','EMPEXPORT','OEACTIVE',NULL,'ESTAFFCUEX',NULL,NULL,NULL,'202007099','Jul  9 2020  3:54PM','Jul  9 2020  3:54PM','202007091',NULL,'','','202007091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTAFFCUEX_20200915.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202007099','EMPEXPORT','OEPASSIVE',NULL,'ESTAFFCUEX',NULL,NULL,NULL,'202007099','Jul  9 2020  3:54PM','Jul  9 2020  3:54PM','202007091',NULL,'','','202007091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTAFFCUEX_20200915.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202008271','EMPEXPORT','TEST','Aug 27 2020  6:21PM','ESTAFFCUEX',NULL,NULL,NULL,'202008271','Aug 27 2020 12:00AM','Dec 30 1899 12:00AM','202008011','297','','','202008011',dbo.fn_GetTimedKey(),NULL,'us3cPeFIR1030',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ESTAFFCUEX_20200915.txt' END WHERE expFormatCode = 'ESTAFFCUEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAFFCUEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAFFCUEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAFFCUEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAFFCUEX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAFFCUEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAFFCUEX','UDESPath','C','\\us.saas\0\data_exchange\\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTAFFCUEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ESTAFFCUEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESTAFFCUEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ESTAFFCUEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTAFFCUEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAFFCUEX','H01','dbo.U_ESTAFFCUEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAFFCUEX','D10','dbo.U_ESTAFFCUEX_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTAFFCUEX','T90','dbo.U_ESTAFFCUEX_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_ESTAFFCUEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESTAFFCUEX] (
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
IF OBJECT_ID('U_ESTAFFCUEX_Audit') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_Audit] (
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
IF OBJECT_ID('U_ESTAFFCUEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ESTAFFCUEX_BdmConsolidated') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_BdmConsolidated] (
    [bdmeeid] char(12) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmrecid] char(12) NULL,
    [bdmrectype] varchar(3) NOT NULL,
    [bdmrelationship] varchar(3) NULL,
    [BdmUSGField1] money NULL,
    [bdmbenoption] char(6) NULL,
    [bdmbenstatus] char(1) NULL,
    [bdmdedcode] char(5) NOT NULL,
    [bdmbenstartdate] datetime NULL,
    [bdmbenstopdate] datetime NULL
);
IF OBJECT_ID('U_ESTAFFCUEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESTAFFCUEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPolicy] varchar(6) NOT NULL,
    [drvBillingDivision] varchar(4) NOT NULL,
    [drvBillingDivisionEffDate] varchar(1) NOT NULL,
    [drvBillingCategory] varchar(4) NULL,
    [drvBillingCategoryEffDate] datetime NULL,
    [drvSocialSecurityNumber] char(11) NULL,
    [drvEmployeeID] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvDateofBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvOccupationCode] varchar(1) NOT NULL,
    [drvWorkState] varchar(255) NULL,
    [drvCurrentHireDate] datetime NULL,
    [drvPolicyEligibilityDate] datetime NULL,
    [drvPolicyEffectiveDate] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvEmployeeTobaccoIndicator] varchar(1) NOT NULL,
    [drvWorkHours] varchar(1) NOT NULL,
    [drvEarningsAmount] varchar(12) NULL,
    [drvEarningsMode] varchar(1) NOT NULL,
    [drvEarningsAmountEffDate] datetime NULL,
    [drvPayrollfrequency] varchar(1) NOT NULL,
    [drvFamilyIndicator] varchar(1) NULL,
    [drvFamilyIndicatorEffDate] datetime NULL,
    [drvQualifyingEventDate] varchar(1) NOT NULL,
    [drvSpouseFirstName] varchar(100) NULL,
    [drvSpouseLastName] varchar(100) NULL,
    [drvSpouseDOB] datetime NULL,
    [drvRelationshiptoMember] varchar(7) NULL,
    [drvSpouseGender] varchar(1) NULL,
    [drvSpouseTobaccoIndicator] varchar(1) NOT NULL,
    [drvProductIDBL] varchar(2) NULL,
    [drvCoverageEffectiveDateBL] datetime NULL,
    [drvCoverageTerminationDateBL] datetime NULL,
    [drvProductIDAdd] varchar(2) NULL,
    [drvCoverageEffectiveDateAdd] datetime NULL,
    [drvCoverageTerminationDateAdd] datetime NULL,
    [drvProductIDAL] varchar(2) NULL,
    [drvCoverageEffectiveDateAL] datetime NULL,
    [drvCoverageTerminationDateAL] datetime NULL,
    [drvCoverageEffectiveAmount] varchar(12) NULL,
    [drvCoverageTakeoverAmount] varchar(1) NOT NULL,
    [drvProductIDASL] varchar(3) NULL,
    [drvCoverageEffectiveDateASL] datetime NULL,
    [drvCoverageTerminationDateASL] datetime NULL,
    [drvCoverageEffectiveAmountASL] varchar(12) NULL,
    [drvProductIDACL] varchar(3) NULL,
    [drvCoverageEffectiveDateACL] datetime NULL,
    [drvCoverageTerminationDateACL] datetime NULL,
    [drvCoverageEffectiveAmountACL] varchar(12) NULL,
    [drvProductIDDL] varchar(3) NULL,
    [drvCoverageEffectiveDateDL] datetime NULL,
    [drvCoverageTerminationDateDL] datetime NULL,
    [drvFamilyElectionIndicatorDL] varchar(6) NULL,
    [drvProductIDSTD] varchar(2) NULL,
    [drvCoverageEffectiveDateSTD] datetime NULL,
    [drvCoverageTerminationDateSTD] datetime NULL,
    [drvProductIDLTD1] varchar(2) NULL,
    [drvCoverageEffectiveDateLTD1] datetime NULL,
    [drvCoverageTermiDateLTD1] datetime NULL
);
IF OBJECT_ID('U_ESTAFFCUEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESTAFFCUEX_File') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ESTAFFCUEX_Header') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_Header] (
    [drvHeaderIdentifier] varchar(3) NOT NULL,
    [drvFileDate] datetime NOT NULL,
    [drvSFGCompanyID] varchar(2) NOT NULL,
    [drvCustomerName] varchar(16) NOT NULL,
    [drvGroupID] varchar(8) NOT NULL
);
IF OBJECT_ID('U_ESTAFFCUEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_PDedHist] (
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
IF OBJECT_ID('U_ESTAFFCUEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_PEarHist] (
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
IF OBJECT_ID('U_ESTAFFCUEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_ESTAFFCUEX_Trailer] (
    [drvTrailerRecCount] varchar(12) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTAFFCUEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: First Community Credit Union

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 07/09/2020
Service Request Number: TekP-2020-05-29-0002

Purpose: The Standard File Life Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTAFFCUEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTAFFCUEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTAFFCUEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESTAFFCUEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTAFFCUEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAFFCUEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAFFCUEX', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAFFCUEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAFFCUEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTAFFCUEX', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESTAFFCUEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESTAFFCUEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESTAFFCUEX';

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
    DELETE FROM dbo.U_ESTAFFCUEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESTAFFCUEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_ESTAFFCUEX_EEList
    WHERE  xEEID IN (SELECT eeceeid FROM dbo.EmpComp where eeceetype IN ('TES','CON'));
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GDLIF, GLIFE, LIFEC, LIFES, LIFEE, ADD, LTD1, STD40, STD50, STD60';

    IF OBJECT_ID('U_ESTAFFCUEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAFFCUEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESTAFFCUEX_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');

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
    IF OBJECT_ID('U_ESTAFFCUEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAFFCUEX_AuditFields;
    CREATE TABLE dbo.U_ESTAFFCUEX_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ESTAFFCUEX_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ESTAFFCUEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAFFCUEX_Audit;
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
    INTO dbo.U_ESTAFFCUEX_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ESTAFFCUEX_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ESTAFFCUEX_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESTAFFCUEX_Audit ON dbo.U_ESTAFFCUEX_Audit (audKey1Value, audKey2Value);


    --Creating Consolidated BDM without the ValidExportCode = 'Y' to get all the list of employees and dependents
     IF OBJECT_ID('U_ESTAFFCUEX_BdmConsolidated','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAFFCUEX_BdmConsolidated;
Select eedeeid as bdmeeid,
      eedcoid as bdmcoid,
      NULL as bdmrecid,
      'EMP' as bdmrectype,
      'EMP' as bdmrelationship,
      EedBenAmt as BdmUSGField1,
      eedbenoption as bdmbenoption,
      eedbenstatus as bdmbenstatus,
      eeddedcode as bdmdedcode,
      eedbenstartdate as bdmbenstartdate,
      eedbenstopdate as bdmbenstopdate
    INTO dbo.U_ESTAFFCUEX_BdmConsolidated
    FROM dbo.U_DSI_BDM_EmpDeductions where eedFormatCode = @FormatCode
    and  eedbenstatus in ('A','T','W')
UNION ALL
Select dbneeid as bdmeeid,
      dbncoid as bdmcoid,
      dbnSystemId as bdmrecid,
      'DEP' as bdmrectype,
      dbnRelationship as bdmrelationship,
      dedeebenamt as BdmUSGField1,
      dbnbenoption as bdmbenoption,
      dbnbenstatus as bdmbenstatus,
      dbndedcode as bdmdedcode,
      dbnbenstartdate as bdmbenstartdate,
      dbnbenstopdate as bdmbenstopdate
    FROM dbo.U_DSI_BDM_DepDeductions where dbnFormatCode = @FormatCode
    and dbnbenstatus in ('A','T','W')

    Delete from dbo.U_ESTAFFCUEX_BdmConsolidated where  datediff(Day,bdmbenstopdate,getdate()) > 14 

  
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESTAFFCUEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTAFFCUEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAFFCUEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPolicy = '166888'
        ,drvBillingDivision = '0001'
        ,drvBillingDivisionEffDate = ''
        ,drvBillingCategory = BILLCATEGORY
        ,drvBillingCategoryEffDate = BillEffdate
        ,drvSocialSecurityNumber = eepSSN
        ,drvEmployeeID = ''
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvDateofBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvOccupationCode = ''
        ,drvWorkState = (Select top 1 LocAddressState from Location where loccode  = eeclocation)
        ,drvCurrentHireDate = EecDateOfLastHire
        ,drvPolicyEligibilityDate = EecDateOfBenefitSeniority
        ,drvPolicyEffectiveDate = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmployeeTobaccoIndicator =  ''
        ,drvWorkHours = ''
        ,drvEarningsAmount = CAST(EecAnnSalary as varchar(12))
        ,drvEarningsMode = 'A'
        ,drvEarningsAmountEffDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETDATE(),EecDateOfLastHire)
        ,drvPayrollfrequency = ''
        ,drvFamilyIndicator = 
                                            CASE WHEN GDLIF_SPS >= 1 and GDLIF_CHD >= 1 THEN 'A'
                                                 WHEN GDLIF_SPS >= 1 and ISNULL(GDLIF_CHD,0) = 0 THEN 'B'
                                                 WHEN GDLIF_SPS = 0 and GDLIF_CHD = 0 THEN 'C'
                                                 WHEN GDLIF_SPS = 0 and GDLIF_CHD  >= 1 THEN 'D'
                                            END
                                    
        ,drvFamilyIndicatorEffDate = (Select top 1 EdhEffDate from dbo.emphded where edheeid = xeeid and edhcoid = xcoid and edhChangeReason IN ( '100', '103', '105', '201', '204', '300', '302', '303', '400', 'OE', 'LE', 'LEVNT1', 'LEVNT2', 'LEVNT3', 'LEVNT4' ) and EdhEffDate is not null order by edhdatetimecreated desc)
        ,drvQualifyingEventDate = ''
        ,drvSpouseFirstName = (Select top 1 ConNameFirst from contacts where coneeid = xeeid and conrelationship IN ('SPS','DP') and exists(Select * from U_ESTAFFCUEX_BdmConsolidated where bdmdedcode in ('GDLIF','LIFES') and bdmeeid in (xeeid) and bdmrectype = 'EMP')  )
        ,drvSpouseLastName = (Select top 1 ConNameLast from contacts where coneeid = xeeid and conrelationship IN ('SPS','DP') and exists(Select * from U_ESTAFFCUEX_BdmConsolidated where bdmdedcode in ('GDLIF','LIFES') and bdmeeid in (xeeid) and bdmrectype = 'EMP')  )
        ,drvSpouseDOB = (Select top 1 Condateofbirth from contacts where coneeid = xeeid and conrelationship IN ('SPS','DP') and exists(Select * from U_ESTAFFCUEX_BdmConsolidated where bdmdedcode in ('GDLIF','LIFES') and bdmeeid in (xeeid) and bdmrectype = 'EMP')  )
        ,drvRelationshiptoMember = CASE WHEN (Select top 1 conrelationship from contacts where coneeid = xeeid and conrelationship = 'SPS' and exists(Select * from U_ESTAFFCUEX_BdmConsolidated where bdmdedcode in ('GDLIF','LIFES') and bdmeeid in (xeeid) and bdmrectype = 'EMP') ) = 'SPS' THEN 'Spouse'
                                        WHEN (Select top 1 conrelationship from contacts where coneeid = xeeid and conrelationship = 'DP' and exists(Select * from U_ESTAFFCUEX_BdmConsolidated where bdmdedcode in ('GDLIF','LIFES') and bdmeeid in (xeeid) and bdmrectype = 'EMP')) = 'DP' THEN 'Partner'
                                         END
        ,drvSpouseGender = CASE  (Select top 1 ConGender from contacts where coneeid = xeeid and conrelationship = 'SPS' and exists(Select * from U_ESTAFFCUEX_BdmConsolidated where bdmdedcode in ('GDLIF','LIFES') and bdmeeid in (xeeid) and bdmrectype = 'EMP')) 
                                WHEN 'M' THEN 'M'
                                WHEN 'F' THEN 'F'
                            END
        ,drvSpouseTobaccoIndicator = ''
        ,drvProductIDBL = CASE WHEN GLIFE is not null then 'BL' END
        ,drvCoverageEffectiveDateBL = CASE WHEN GLIFE is not null then GLIFE_BenefitDate END
        ,drvCoverageTerminationDateBL = CASE WHEN GLIFE is not null then GLIFE_BenefitStopDate END
        ,drvProductIDAdd = CASE WHEN ADD_BEN is not null then 'BA' END
        ,drvCoverageEffectiveDateAdd = CASE WHEN ADD_BEN is not null then ADD_BenefitDate END
        ,drvCoverageTerminationDateAdd = CASE WHEN ADD_BEN is not null then ADD_BenefitStopDate END
        ,drvProductIDAL = CASE WHEN LIFEE is not null then 'AL' END
        ,drvCoverageEffectiveDateAL = CASE WHEN LIFEE is not null then LIFEE_BenefitDate END
        ,drvCoverageTerminationDateAL = CASE WHEN LIFEE is not null then LIFEE_BenefitStopDate END
        ,drvCoverageEffectiveAmount = CASE WHEN LIFEE is not null then  CAST(LIFEE_BenefitAmt as varchar(12)) ELSE '' END
        ,drvCoverageTakeoverAmount = ''
        ,drvProductIDASL = CASE WHEN LIFES is not null then 'ASL' END 
        ,drvCoverageEffectiveDateASL = CASE WHEN LIFES is not null then LIFES_BenefitDate END 
        ,drvCoverageTerminationDateASL =  CASE WHEN LIFES is not null then LIFES_BenefitStopDate END 
        ,drvCoverageEffectiveAmountASL = CASE WHEN LIFES is not null then CAST(LIFES_BenefitAmt as varchar(12)) ELSE  '' END 
        ,drvProductIDACL = CASE WHEN LIFEC is not null then 'ACL' END
        ,drvCoverageEffectiveDateACL = CASE WHEN LIFEC is not null then LIFEC_BenefitDate END
        ,drvCoverageTerminationDateACL = CASE WHEN LIFEC is not null then LIFEC_BenefitStopDate END
        ,drvCoverageEffectiveAmountACL = CASE WHEN LIFEC is not null then CAST(LIFEC_BenefitAmt as varchar(12)) ELSE  '' END
        ,drvProductIDDL = CASE WHEN GDLIF is not null then 'XDL' END
        ,drvCoverageEffectiveDateDL = CASE WHEN GDLIF is not null then GDLIF_BenefitDate END
        ,drvCoverageTerminationDateDL = CASE WHEN GDLIF is not null then GDLIF_BenefitStopDate END
        ,drvFamilyElectionIndicatorDL = CASE WHEN GDLIF is not null then
                                                    CASE WHEN GDLIF_SPS >= 1 and GDLIF_CHD  >= 1 THEN 'Family'
                                                         WHEN GDLIF_SPS >= 1 and GDLIF_CHD = 0 THEN 'Spouse'
                                                         WHEN GDLIF_SPS = 0 and GDLIF_CHD >= 1 THEN 'Child'
                                                    END
                                         END
        ,drvProductIDSTD = CASE WHEN STD IS NOT NULL THEN 'ST' END
        ,drvCoverageEffectiveDateSTD =  CASE WHEN STD IS NOT NULL THEN STD_BenefitDate END
        ,drvCoverageTerminationDateSTD = CASE WHEN STD IS NOT NULL THEN STD_BenefitStopDate END
        ,drvProductIDLTD1 = CASE WHEN LTD1 IS NOT NULL THEN 'LT' END
        ,drvCoverageEffectiveDateLTD1 =  CASE WHEN LTD1 IS NOT NULL THEN LTD1_BenefitDate END
        ,drvCoverageTermiDateLTD1 = CASE WHEN LTD1 IS NOT NULL THEN LTD1_BenefitStopDate END
    INTO dbo.U_ESTAFFCUEX_drvTbl
    FROM dbo.U_ESTAFFCUEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
         and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ESTAFFCUEX_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select  bdmEEID,bdmcoid
             ,BillEffdate = Max(BdmBenStartDate)
            ,GDLIF = MAX((CASE WHEN BDMDedCode = 'GDLIF' then BDMDedCode END))
            ,GDLIF_BenefitDate = MAX((CASE WHEN BDMDedCode = 'GDLIF' then  BdmBenStartDate END))
            ,GDLIF_BenefitStopDate = MAX((CASE WHEN BDMDedCode = 'GDLIF' then  BdmBenStopDate END))
            ,GDLIF_BenefitAmt = SUM((CASE WHEN BDMDedCode = 'GDLIF'  then  CAST(BdmUSGField1 as MONEY) END))
            ,GDLIF_SPS = (Select count(*) from dbo.Contacts where coneeid = bdmeeid and ConRelationShip in ('DP', 'SPS') and ConisDependent = 'Y') 
            ,GDLIF_CHD = (Select count(*) from dbo.Contacts where coneeid = bdmeeid and ConRelationShip in ('CHL', 'DIS', 'DPC', 'STC' ) and ConisDependent = 'Y')
            ,STD = MAX((CASE WHEN BDMDedCode IN ('STD40', 'STD50', 'STD60') then BDMDedCode END))
            ,STD_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('STD40', 'STD50', 'STD60') then  BdmBenStartDate END))
            ,STD_BenefitStopDate = MAX((CASE WHEN BDMDedCode IN ('STD40', 'STD50', 'STD60')then  BdmBenStopDate END))
            ,STD_BenefitAmt = SUM((CASE WHEN BDMDedCode IN ('STD40', 'STD50', 'STD60')then  CAST(BdmUSGField1 as MONEY) END))
            ,LTD1 = MAX((CASE WHEN BDMDedCode IN ('LTD1') then BDMDedCode END))
            ,LTD1_BenefitDate = MAX((CASE WHEN BDMDedCode IN ('LTD1') then  BdmBenStartDate END))
            ,LTD1_BenefitStopDate = MAX((CASE WHEN BDMDedCode IN ('LTD1')then  BdmBenStopDate END))
            ,LTD1_BenefitAmt = SUM((CASE WHEN BDMDedCode IN ('LTD1')then  CAST(BdmUSGField1 as MONEY) END))
            ,ADD_BEN = MAX((CASE WHEN BDMDedCode = 'ADD' then BDMDedCode END))
            ,ADD_BenefitDate = MAX((CASE WHEN BDMDedCode = 'ADD' then  BdmBenStartDate END))
            ,ADD_BenefitStopDate = MAX((CASE WHEN BDMDedCode = 'ADD' then  BdmBenStopDate END))
            ,ADD_BenefitAmt = SUM((CASE WHEN BDMDedCode = 'ADD' then  CAST(BdmUSGField1 as MONEY) END))
            ,GLIFE = MAX((CASE WHEN BDMDedCode = 'GLIFE' then BDMDedCode END))
            ,GLIFE_BenefitDate = MAX((CASE WHEN BDMDedCode = 'GLIFE' then  BdmBenStartDate END))
            ,GLIFE_BenefitStopDate = MAX((CASE WHEN BDMDedCode = 'GLIFE' then  BdmBenStopDate END))
            ,GLIFE_BenefitAmt = SUM((CASE WHEN BDMDedCode = 'GLIFE' then  CAST(BdmUSGField1 as MONEY) END))
            ,LIFEE = MAX((CASE WHEN BDMDedCode = 'LIFEE' then BDMDedCode END))
            ,LIFEE_BenefitDate = MAX((CASE WHEN BDMDedCode = 'LIFEE' then  BdmBenStartDate END))
            ,LIFEE_BenefitStopDate = MAX((CASE WHEN BDMDedCode = 'LIFEE' then  BdmBenStopDate END))
            ,LIFEE_BenefitAmt = SUM((CASE WHEN BDMDedCode = 'LIFEE' and BdmUSGField1 > 0.00  then  CAST(BdmUSGField1 as MONEY) END))
            ,LIFEF = MAX((CASE WHEN BDMDedCode = 'LIFEF' then BDMDedCode END))
            ,LIFEF_BenefitDate = MAX((CASE WHEN BDMDedCode = 'LIFEF' then  BdmBenStartDate END))
            ,LIFEF_BenefitStopDate = MAX((CASE WHEN BDMDedCode = 'LIFEF' then  BdmBenStopDate END))
            ,LIFEF_BenefitAmt =  MAX((CASE WHEN BDMDedCode = 'LIFEF' and BdmUSGField1 > 0.00 then  BdmUSGField1 END))
            ,LIFEF_BenOption = MAX((CASE WHEN BDMDedCode = 'LIFEF' then bdmBenOption END))
            ,LIFEC = MAX((CASE WHEN BDMDedCode = 'LIFEC' then BDMDedCode END))
            ,LIFEC_BenefitDate = MAX((CASE WHEN BDMDedCode = 'LIFEC' then  BdmBenStartDate END))
            ,LIFEC_BenefitStopDate = MAX((CASE WHEN BDMDedCode = 'LIFEC' then  BdmBenStopDate END))
            ,LIFEC_BenefitAmt = SUM((CASE WHEN BDMDedCode = 'LIFEC' and BdmRecType = 'EMP' and BdmUSGField1 > 0.00 then  CAST(BdmUSGField1 as MONEY) END))
            ,LIFES = MAX((CASE WHEN BDMDedCode = 'LIFES' then BDMDedCode END))
            ,LIFES_BenefitDate = MAX((CASE WHEN BDMDedCode = 'LIFES' then  BdmBenStartDate END))
            ,LIFES_BenefitStopDate = MAX((CASE WHEN BDMDedCode = 'LIFES' then  BdmBenStopDate END))
            ,LIFES_BenefitAmt = SUM((CASE WHEN BDMDedCode = 'LIFES' and BdmRecType = 'EMP' and BdmUSGField1 > 0.00 then  CAST(BdmUSGField1 as MONEY) END))--SUM((CASE WHEN BDMDedCode = 'LIFES' and BdmRecType = 'EMP' then  CAST(BdmUSGField1 as MONEY) END))
            ,VADDC = MAX((CASE WHEN BDMDedCode = 'VADDC' then BDMDedCode END))
            ,VADDC_BenefitDate = MAX((CASE WHEN BDMDedCode = 'VADDC' then  BdmBenStartDate END))
            ,VADDC_BenefitStopDate = MAX((CASE WHEN BDMDedCode = 'VADDC' then  BdmBenStopDate END))
            ,VADDC_BenefitAmt = SUM((CASE WHEN BDMDedCode = 'VADDC' then  CAST(BdmUSGField1 as MONEY) END))
            ,VADD = MAX((CASE WHEN BDMDedCode = 'VADD' then BDMDedCode END))
            ,VADD_BenefitDate = MAX((CASE WHEN BDMDedCode = 'VADD' then  BdmBenStartDate END))
            ,VADD_BenefitStopDate = MAX((CASE WHEN BDMDedCode = 'VADD' then  BdmBenStopDate END))
            ,VADD_BenefitAmt = SUM((CASE WHEN BDMDedCode = 'VADD' then  CAST(BdmUSGField1 as MONEY) END))
            ,VADDS = MAX((CASE WHEN BDMDedCode = 'VADDS' then BDMDedCode END))
            ,VADDS_BenefitDate = MAX((CASE WHEN BDMDedCode = 'VADDS' then  BdmBenStartDate END))
            ,VADDS_BenefitStopDate = MAX((CASE WHEN BDMDedCode = 'VADDS' then  BdmBenStopDate END))
            ,VADDS_BenefitAmt = SUM((CASE WHEN BDMDedCode = 'VADDS' then  CAST(BdmUSGField1 as MONEY) END))
            ,LIFEF_BdmSpouse = MAX((CASE WHEN BDMDedCode = 'LIFEF' and BdmRelationShip = 'SPS' then '1' ELSE '0' END))
            ,LIFEF_BdmChl = MAX((CASE WHEN BDMDedCode = 'LIFEF' and BdmRelationShip = 'CHL' then '1' ELSE '0' END))
            ,LIFEF_BdmEmp = MAX((CASE WHEN BDMDedCode = 'LIFEF' and BdmRelationShip = 'EMP' then '1' ELSE '0' END))
            ,BILLCATEGORY = MAX(CASE WHEN BDMDedCode = 'STD40' THEN '0100'
                                      WHEN BdmDedCode in ('STD40','STD50','STD60','STD') and bdmbenstatus in ('W','C') THEN '0100'    
                                       WHEN BDMDedCode = 'STD50' THEN '0200'
                                       WHEN BDMDedCode = 'STD60' then '0300' 
                                       ELSE '0100' END)
            from dbo.U_ESTAFFCUEX_BdmConsolidated  group by bdmEEID,bdmcoid) AS BdmConsolidated
  
        on Bdmeeid = xeeid
        and bdmcoid =  xcoid
    /*
    SELECT DISTINCT
         drvEEID
        ,drvCoID
        ,drvDepRecID 
        ,drvInitialSort 
        ,drvSubSort
        ,drvPolicy 
        ,drvBillingDivision 
        ,drvBillingDivisionEffDate 
        ,drvBillingCategory 
        ,drvBillingCategoryEffDate 
        ,drvSocialSecurityNumber 
        ,drvEmployeeID 
        ,drvFirstName
        ,drvLastName 
        ,drvDateofBirth 
        ,drvGender 
        ,drvOccupationCode
        ,drvWorkState 
        ,drvCurrentHireDate
        ,drvPolicyEligibilityDate 
        ,drvPolicyEffectiveDate 
        ,drvTerminationDate
        ,drvEmployeeTobaccoIndicator 
        ,drvWorkHours
        ,drvEarningsAmount
        ,drvEarningsMode 
        ,drvEarningsAmountEffDate 
        ,drvPayrollfrequency
        ,drvFamilyIndicator 
        ,drvFamilyIndicatorEffDate 
        ,drvQualifyingEventDate
        ,drvSpouseFirstName
        ,drvSpouseLastName 
        ,drvSpouseDOB 
        ,drvRelationshiptoMember 
        ,drvSpouseGender 
        ,drvSpouseTobaccoIndicator 
        ,drvProductIDBL
        ,drvCoverageEffectiveDateBL 
        ,drvCoverageTerminationDateBL 
        ,drvProductIDAdd 
        ,drvCoverageEffectiveDateAdd 
        ,drvCoverageTerminationDateAdd 
        ,drvProductIDAL 
        ,drvCoverageEffectiveDateAL
        ,drvCoverageTerminationDateAL
        ,drvCoverageEffectiveAmount
        ,drvCoverageTakeoverAmount 
        ,drvProductIDASL
        ,drvCoverageEffectiveDateASL 
        ,drvCoverageTerminationDateASL
        ,drvCoverageEffectiveAmountASL 
        ,drvProductIDACL 
        ,drvCoverageEffectiveDateACL 
        ,drvCoverageTerminationDateACL
        ,drvCoverageEffectiveAmountACL
        ,drvProductIDDL 
        ,drvCoverageEffectiveDateDL 
        ,drvCoverageTerminationDateDL 
        ,drvFamilyElectionIndicatorDL
        ,drvProductIDSTD 
        ,drvCoverageEffectiveDateSTD 
        ,drvCoverageTerminationDateSTD
        ,drvProductIDLTD1 
        ,drvCoverageEffectiveDateLTD1 
        ,drvCoverageTermiDateLTD1 
    FROM dbo.U_ESTAFFCUEX_drvTbl
    Where drvTerminationDate is not null
    */

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESTAFFCUEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAFFCUEX_Header;
    SELECT DISTINCT
         drvHeaderIdentifier = 'HDR'
        ,drvFileDate = GETDATE()
        ,drvSFGCompanyID = 'SI'
        ,drvCustomerName = 'firstcommunitycu'
        ,drvGroupID = '10151124'
    INTO dbo.U_ESTAFFCUEX_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESTAFFCUEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ESTAFFCUEX_Trailer;
    SELECT DISTINCT
         drvTrailerRecCount = CAST((Select count(*) from dbo.U_ESTAFFCUEX_drvTbl) as varchar(12))
    INTO dbo.U_ESTAFFCUEX_Trailer
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
ALTER VIEW dbo.dsi_vwESTAFFCUEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTAFFCUEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESTAFFCUEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007021'
       ,expStartPerControl     = '202007021'
       ,expLastEndPerControl   = '202007099'
       ,expEndPerControl       = '202007099'
WHERE expFormatCode = 'ESTAFFCUEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESTAFFCUEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESTAFFCUEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort