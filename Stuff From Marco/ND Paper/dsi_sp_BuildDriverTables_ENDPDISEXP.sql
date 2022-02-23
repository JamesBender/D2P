SET NOCOUNT ON;
IF OBJECT_ID('U_ENDPDISEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ENDPDISEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ENDPDISEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwENDPDISEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENDPDISEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENDPDISEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENDPDISEXP];
GO
IF OBJECT_ID('U_ENDPDISEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_PEarHist];
GO
IF OBJECT_ID('U_ENDPDISEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_PDedHist];
GO
IF OBJECT_ID('U_ENDPDISEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_File];
GO
IF OBJECT_ID('U_ENDPDISEXP_Employees_Changes') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_Employees_Changes];
GO
IF OBJECT_ID('U_ENDPDISEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_EEList];
GO
IF OBJECT_ID('U_ENDPDISEXP_drvSPMUPDATE') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_drvSPMUPDATE];
GO
IF OBJECT_ID('U_ENDPDISEXP_drvSPMPLANINSERT') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_drvSPMPLANINSERT];
GO
IF OBJECT_ID('U_ENDPDISEXP_drvSPMPLANDROP') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_drvSPMPLANDROP];
GO
IF OBJECT_ID('U_ENDPDISEXP_drvSPMINSERT') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_drvSPMINSERT];
GO
IF OBJECT_ID('U_ENDPDISEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_DedList];
GO
IF OBJECT_ID('U_ENDPDISEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_AuditFields];
GO
IF OBJECT_ID('U_ENDPDISEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ENDPDISEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENDPDISEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ENDPDISEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ENDPDISEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ENDPDISEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ENDPDISEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ENDPDISEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ENDPDISEXP','Discovery Benefit SPM Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ENDPDISEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''Q,'')','ENDPDISEXPZ0','100','H','01','1',NULL,'Version Line Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"2.0"','2','(''DA''=''Q'')','ENDPDISEXPZ0','100','H','01','2',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionName"','3','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','3',NULL,'ClientDivisionName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutation"','4','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','4',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','5',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','6','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','6',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','7','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','7',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualID"','9','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','9',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','10','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','10',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','11','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','11',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2"','12','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','12',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','13','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','14','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','15','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','15',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvince"','16','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','16',NULL,'State Or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','17','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','17',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','18','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','18',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','19',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','20','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','20',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobaccoUse"','21','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','21',NULL,'Tobacco Use',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','22','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','22',NULL,'Employee Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayrollType"','23','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','23',NULL,'Employee Payroll Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYearsOfService"','24','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','24',NULL,'Years Of Service',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCouponType"','25','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','25',NULL,'Premium Coupon Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingStartDate"','26','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','10','26',NULL,'Billing Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingEndDate"','27','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','10','27',NULL,'Billing End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingFrequency"','28','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','28',NULL,'Billing Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingType"','29','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','29',NULL,'Billing Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','30','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','10','30',NULL,'Enrollment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMGracePeriodNROfDays"','31','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','31',NULL,'SPM Grace Period NR Of Days',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGracePeriodNrOfDays"','32','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','32',NULL,'Grace Period Nr Of Days',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitGroup"','33','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','33',NULL,'Benefit Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountStructure"','34','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','34',NULL,'Account Structure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientSpecificData"','35','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','35',NULL,'Client Specific Data',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQueueWelcomeLetter"','36','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','10','36',NULL,'Queue Welcome  Letter',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','37','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','10','37',NULL,'Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInitialGracePeriodDate"','38','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','10','38',NULL,'Initial Grace Period Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingPeriodSeedDate"','39','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','10','39',NULL,'Billing Period Seed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSecondBillingPrdSeedDate"','40','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','10','40',NULL,'Second Billing Period Seed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCategory"','41','(''UA''=''Q'')','ENDPDISEXPZ0','100','D','10','41',NULL,'Plan Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoSSN"','3','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','3',NULL,'oSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoBillingStartDate"','4','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','20','4',NULL,'oBilling Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoBillingType"','5','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','5',NULL,'oBilling Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoBillingFrequency"','6','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','6',NULL,'oBilling Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutation"','7','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','7',NULL,'Salutation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','8','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','8',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','9','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','9',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','10','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','10',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','11','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','11',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualID"','12','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','12',NULL,'IndividualID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','13','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','13',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','14','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','14',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2"','15','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','15',NULL,'Phone2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','16','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','16',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','17','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','17',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','18','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','18',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvince"','19','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','19',NULL,'State Or Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','20','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','20',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','21','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','21',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','22','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','22',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','23','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','23',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobaccoUse"','24','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','24',NULL,'Tobacco Use',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','25','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','25',NULL,'Employee Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayrollType"','26','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','26',NULL,'Employee Payroll Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYearsOfService"','27','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','27',NULL,'Years Of Service',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCouponType"','28','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','28',NULL,'Premium Coupon Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingStartDate"','29','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','20','29',NULL,'Billing Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingEndDate"','30','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','20','30',NULL,'Billing End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingFrequency"','31','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','31',NULL,'Billing Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingType"','32','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','32',NULL,'Billing Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','33','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','20','33',NULL,'Enrollment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPMGracePeriodNROfDays"','34','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','34',NULL,'SPM Grace Period NR Of Days',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGracePeriodNrOfDays"','35','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','35',NULL,'Grace Period Nr Of Days',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitGroup"','36','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','36',NULL,'Benefit Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountStructure"','37','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','37',NULL,'Account Structure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientSpecificData"','38','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','38',NULL,'Client Specific Data',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQueueWelcomeLetter"','39','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','20','39',NULL,'Queue Welcome  Letter',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','40','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','20','40',NULL,'Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInitialGracePeriodDate"','41','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','20','41',NULL,'Initial Grace Period Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingPeriodSeedDate"','42','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','20','42',NULL,'Billing Period Seed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSecondBillingPrddSeedDate"','43','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','20','43',NULL,'Second Billing Period Seed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCategory"','44','(''UA''=''Q'')','ENDPDISEXPZ0','100','D','20','44',NULL,'Plan Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoSSN"','3','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','3',NULL,'oSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoBillingStartDate"','4','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','30','4',NULL,'oBilling Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoBillingType"','5','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','5',NULL,'oBilling Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoBillingFrequency"','6','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','6',NULL,'oBilling Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','7','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','7',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','8','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','8',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','9','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','9',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','10','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','10',NULL,'Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstDayOff"','11','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','11',NULL,'First Day Off',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastDayOff"','12','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','12',NULL,'Last Day Off',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfUnits"','13','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','13',NULL,'Number Of Units',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanBudleName"','14','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','30','13',NULL,'Plan Bundle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQueuePlanLetterChange"','15','(''UA''=''Q'')','ENDPDISEXPZ0','100','D','30','15',NULL,'Queue Plan Letter Change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordIdentifier"','1','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','40','1',NULL,'Record Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','40','2',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoSSN"','3','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','40','3',NULL,'oSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoBillingStartDate"','4','(''UD101''=''Q,'')','ENDPDISEXPZ0','100','D','40','4',NULL,'oBilling Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoBillingType"','5','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','40','5',NULL,'oBilling Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvoBillingFrequency"','6','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','40','6',NULL,'oBilling Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','7','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','40','7',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','8','(''UA''=''Q,'')','ENDPDISEXPZ0','100','D','40','8',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','9','(''UA''=''Q'')','ENDPDISEXPZ0','100','D','40','9',NULL,'Effective Date',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ENDPDISEXP_20200813.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery Benefit SPM Export','202008129','EMPEXPORT','ONDEMAND',NULL,'ENDPDISEXP',NULL,NULL,NULL,'202008129','Aug 12 2020 10:36AM','Aug 12 2020 10:36AM','202007051',NULL,'','','202008051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ENDPDISEXP_20200813.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202008129','EMPEXPORT','TEST',NULL,'ENDPDISEXP',NULL,NULL,NULL,'202008129','Aug 12 2020 10:36AM','Aug 12 2020 10:36AM','202007051',NULL,'','','202008051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ENDPDISEXP_20200813.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202008129','EMPEXPORT','SCHEDULED',NULL,'ENDPDISEXP',NULL,NULL,NULL,'202008129','Aug 12 2020 10:36AM','Aug 12 2020 10:36AM','202007051',NULL,'','','202008051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ENDPDISEXP_20200813.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202008129','EMPEXPORT','OEACTIVE',NULL,'ENDPDISEXP',NULL,NULL,NULL,'202008129','Aug 12 2020 10:36AM','Aug 12 2020 10:36AM','202007051',NULL,'','','202008051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ENDPDISEXP_20200813.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202008129','EMPEXPORT','OEPASSIVE',NULL,'ENDPDISEXP',NULL,NULL,NULL,'202008129','Aug 12 2020 10:36AM','Aug 12 2020 10:36AM','202007051',NULL,'','','202008051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ENDPDISEXP_20200813.txt' END WHERE expFormatCode = 'ENDPDISEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENDPDISEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENDPDISEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENDPDISEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENDPDISEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENDPDISEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENDPDISEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ENDPDISEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ENDPDISEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ENDPDISEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENDPDISEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENDPDISEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENDPDISEXP','D10','dbo.U_ENDPDISEXP_drvSPMINSERT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENDPDISEXP','D20','dbo.U_ENDPDISEXP_drvSPMUPDATE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENDPDISEXP','D30','dbo.U_ENDPDISEXP_drvSPMPLANINSERT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENDPDISEXP','D40','dbo.U_ENDPDISEXP_drvSPMPLANDROP',NULL);
IF OBJECT_ID('U_dsi_BDM_ENDPDISEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ENDPDISEXP] (
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
IF OBJECT_ID('U_ENDPDISEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_Audit] (
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
IF OBJECT_ID('U_ENDPDISEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ENDPDISEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ENDPDISEXP_drvSPMINSERT') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_drvSPMINSERT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvRecordIdentifier] varchar(11) NOT NULL,
    [drvClientName] varchar(29) NOT NULL,
    [drvClientDivisionName] varchar(50) NOT NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(110) NOT NULL,
    [drvMiddleInitial] varchar(15) NOT NULL,
    [drvLastName] varchar(109) NOT NULL,
    [drvSSN] varchar(15) NOT NULL,
    [drvIndividualID] varchar(22) NOT NULL,
    [drvEmail] varchar(1) NOT NULL,
    [drvPhone] varchar(1) NOT NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddress1] varchar(264) NOT NULL,
    [drvAddress2] varchar(264) NOT NULL,
    [drvCity] varchar(260) NOT NULL,
    [drvStateOrProvince] varchar(271) NOT NULL,
    [drvPostalCode] varchar(61) NOT NULL,
    [drvCountry] varchar(9) NOT NULL,
    [drvSex] varchar(5) NOT NULL,
    [drvDOB] varchar(34) NOT NULL,
    [drvTobaccoUse] varchar(18) NOT NULL,
    [drvEmployeeType] varchar(20) NOT NULL,
    [drvEmployeePayrollType] varchar(29) NOT NULL,
    [drvYearsOfService] varchar(15) NOT NULL,
    [drvPremiumCouponType] varchar(27) NOT NULL,
    [drvBillingStartDate] varchar(17) NOT NULL,
    [drvBillingEndDate] varchar(15) NOT NULL,
    [drvBillingFrequency] varchar(23) NOT NULL,
    [drvBillingType] varchar(25) NOT NULL,
    [drvEnrollmentDate] varchar(15) NOT NULL,
    [drvSPMGracePeriodNROfDays] varchar(35) NOT NULL,
    [drvGracePeriodNrOfDays] varchar(20) NOT NULL,
    [drvBenefitGroup] varchar(13) NOT NULL,
    [drvAccountStructure] varchar(17) NOT NULL,
    [drvClientSpecificData] varchar(19) NOT NULL,
    [drvQueueWelcomeLetter] varchar(22) NOT NULL,
    [drvEventDate] varchar(10) NOT NULL,
    [drvInitialGracePeriodDate] varchar(23) NOT NULL,
    [drvBillingPeriodSeedDate] varchar(22) NOT NULL,
    [drvSecondBillingPrdSeedDate] varchar(28) NOT NULL,
    [drvPlanCategory] varchar(13) NOT NULL
);
IF OBJECT_ID('U_ENDPDISEXP_drvSPMPLANDROP') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_drvSPMPLANDROP] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvRecordIdentifier] varchar(13) NOT NULL,
    [drvClientName] varchar(30) NOT NULL,
    [drvoSSN] varchar(16) NOT NULL,
    [drvoBillingStartDate] varchar(18) NOT NULL,
    [drvoBillingType] varchar(26) NOT NULL,
    [drvoBillingFrequency] varchar(24) NOT NULL,
    [drvPlanName] varchar(59) NOT NULL,
    [drvStartDate] varchar(11) NOT NULL,
    [drvEffectiveDate] varchar(16) NOT NULL,
    [drvDedCode] char(5) NOT NULL
);
IF OBJECT_ID('U_ENDPDISEXP_drvSPMPLANINSERT') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_drvSPMPLANINSERT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvRecordIdentifier] varchar(15) NOT NULL,
    [drvClientName] varchar(30) NOT NULL,
    [drvoSSN] varchar(16) NOT NULL,
    [drvoBillingStartDate] varchar(18) NOT NULL,
    [drvoBillingType] varchar(26) NOT NULL,
    [drvoBillingFrequency] varchar(24) NOT NULL,
    [drvPlanName] varchar(59) NOT NULL,
    [drvStartDate] varchar(11) NOT NULL,
    [drvEffectiveDate] varchar(9) NOT NULL,
    [drvCoverageLevel] varchar(25) NOT NULL,
    [drvFirstDayOff] varchar(12) NOT NULL,
    [drvLastDayOff] varchar(11) NOT NULL,
    [drvNumberOfUnits] varchar(14) NOT NULL,
    [drvPlanBudleName] varchar(14) NOT NULL,
    [drvQueuePlanLetterChange] varchar(22) NOT NULL,
    [drvDedCode] char(5) NOT NULL
);
IF OBJECT_ID('U_ENDPDISEXP_drvSPMUPDATE') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_drvSPMUPDATE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvRecordIdentifier] varchar(11) NOT NULL,
    [drvClientName] varchar(29) NOT NULL,
    [drvoSSN] varchar(16) NOT NULL,
    [drvoBillingStartDate] varchar(19) NOT NULL,
    [drvoBillingType] varchar(27) NOT NULL,
    [drvoBillingFrequency] varchar(25) NOT NULL,
    [drvSalutation] varchar(12) NOT NULL,
    [drvFirstName] varchar(110) NOT NULL,
    [drvMiddleInitial] varchar(15) NOT NULL,
    [drvLastName] varchar(109) NOT NULL,
    [drvSSN] varchar(15) NOT NULL,
    [drvIndividualID] varchar(22) NOT NULL,
    [drvEmail] varchar(7) NOT NULL,
    [drvPhone] varchar(7) NOT NULL,
    [drvPhone2] varchar(8) NOT NULL,
    [drvAddress1] varchar(264) NOT NULL,
    [drvAddress2] varchar(264) NOT NULL,
    [drvCity] varchar(260) NOT NULL,
    [drvStateOrProvince] varchar(271) NOT NULL,
    [drvPostalCode] varchar(61) NOT NULL,
    [drvCountry] varchar(9) NOT NULL,
    [drvSex] varchar(5) NOT NULL,
    [drvDOB] varchar(34) NOT NULL,
    [drvTobaccoUse] varchar(18) NOT NULL,
    [drvEmployeeType] varchar(20) NOT NULL,
    [drvEmployeePayrollType] varchar(20) NOT NULL,
    [drvYearsOfService] varchar(15) NOT NULL,
    [drvPremiumCouponType] varchar(27) NOT NULL,
    [drvBillingStartDate] varchar(17) NOT NULL,
    [drvBillingEndDate] varchar(15) NOT NULL,
    [drvBillingFrequency] varchar(23) NOT NULL,
    [drvBillingType] varchar(25) NOT NULL,
    [drvEnrollmentDate] varchar(15) NOT NULL,
    [drvSPMGracePeriodNROfDays] varchar(35) NOT NULL,
    [drvGracePeriodNrOfDays] varchar(20) NOT NULL,
    [drvBenefitGroup] varchar(13) NOT NULL,
    [drvAccountStructure] varchar(17) NOT NULL,
    [drvClientSpecificData] varchar(19) NOT NULL,
    [drvQueueWelcomeLetter] varchar(22) NOT NULL,
    [drvEventDate] varchar(10) NOT NULL,
    [drvInitialGracePeriodDate] varchar(23) NOT NULL,
    [drvBillingPeriodSeedDate] varchar(22) NOT NULL,
    [drvSecondBillingPrddSeedDate] varchar(28) NOT NULL,
    [drvPlanCategory] varchar(13) NOT NULL
);
IF OBJECT_ID('U_ENDPDISEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ENDPDISEXP_Employees_Changes') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_Employees_Changes] (
    [audEEID] varchar(255) NOT NULL,
    [audLOA] varchar(1) NULL,
    [audLOAToActiveOrTerm] varchar(1) NULL,
    [audTerm] varchar(1) NULL,
    [audBenDrop] varchar(1) NULL
);
IF OBJECT_ID('U_ENDPDISEXP_File') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ENDPDISEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_PDedHist] (
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
IF OBJECT_ID('U_ENDPDISEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ENDPDISEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENDPDISEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ND Paper

Created By: Inshan Singh
Business Analyst: Maribel Hernandez
Create Date: 08/12/2020
Service Request Number: SR-2020-00268396

Purpose: Discovery Benefit SPM Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENDPDISEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENDPDISEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENDPDISEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENDPDISEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENDPDISEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENDPDISEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENDPDISEXP', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENDPDISEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENDPDISEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENDPDISEXP', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENDPDISEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ENDPDISEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ENDPDISEXP';

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
    DELETE FROM dbo.U_ENDPDISEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENDPDISEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED,DEN,VIS,LTD,OPC,OPS,OPT';

    IF OBJECT_ID('U_ENDPDISEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENDPDISEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ENDPDISEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedTypes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'BuildConsolidatedTable','Standard');


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

    IF OBJECT_ID('U_ENDPDISEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ENDPDISEXP_AuditFields;
    CREATE TABLE dbo.U_ENDPDISEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ENDPDISEXP_AuditFields VALUES ('Empcomp','EecEmplStatus');
    INSERT INTO dbo.U_ENDPDISEXP_AuditFields VALUES ('EmpDed','EedBenStopDate');
         
    
    -- Create audit table
    IF OBJECT_ID('U_ENDPDISEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ENDPDISEXP_Audit;
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
    INTO dbo.U_ENDPDISEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ENDPDISEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ENDPDISEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ENDPDISEXP_Audit ON dbo.U_ENDPDISEXP_Audit (audKey1Value, audKey2Value);


    --Create Table to show employees and the changes 

    IF OBJECT_ID('U_ENDPDISEXP_Employees_Changes','U') IS NOT NULL
    DROP TABLE dbo.U_ENDPDISEXP_Employees_Changes;

    Select audKey1Value as audEEID,
        audLOA = MAX(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'A' AND ISNULL(audNewValue,'') = 'L' THEN 'Y' ELSE 'N' END),
        audLOAToActiveOrTerm = MAX(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'L' AND ISNULL(audNewValue,'') in ('A','T') THEN 'Y' ELSE 'N' END),

        audTerm = MAX(CASE WHEN  audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END),
        audBenDrop = MAX(CASE WHEN  audFieldName = 'EedBenStopDate' AND ISNULL(audNewValue,'') is not null THEN 'Y' ELSE 'N' END)
    INTO U_ENDPDISEXP_Employees_Changes
    from U_ENDPDISEXP_Audit
    group by audKey1Value

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ENDPDISEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENDPDISEXP_PDedHist;
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
    INTO dbo.U_ENDPDISEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ENDPDISEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ENDPDISEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ENDPDISEXP_PEarHist;
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
    INTO dbo.U_ENDPDISEXP_PEarHist
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
    -- DETAIL RECORD - U_ENDPDISEXP_drvSPMINSERT
    ---------------------------------
    IF OBJECT_ID('U_ENDPDISEXP_drvSPMINSERT','U') IS NOT NULL
        DROP TABLE dbo.U_ENDPDISEXP_drvSPMINSERT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepssn
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifier = '[SPMINSERT]'
        ,drvClientName = 'ClientName=ND Paper Inc 36815'
        ,drvClientDivisionName = Concat('ClientDivisionName=',
                                    CASE WHEN EecUnionLocal = 'IAM655' THEN 'NQ7 Biron Union IAM 655 LOA'
                                         WHEN EecUnionLocal = 'USW294' THEN 'NQ7 Biron Union USW 2-94 LOA'
                                         WHEN EecUnionLocal = 'USW2187' THEN 'NQ7 Biron Union USW 2-187 LOA'
                                         WHEN EecUnionLocal IN('UA434','UAJ434') THEN 'NQ7 Biron Union UAJ 434 LOA'
                                         WHEN EecUnionLocal = 'OPEIU39' THEN 'NQ7 Biron Union OPEIU 95 LOA'
                                         WHEN EecUnionLocal IN ('IBEW1147','IBEW1147BA') THEN 'NQ7 Biron Union IBEW 1147 LOA'
                                         WHEN EecUnionLocal = 'USW900' THEN 'NQ4 Rumford Union USW 900 LOA'
                                         WHEN EecUnionLocal = 'IBEW2144' THEN 'NQ4 Rumford Union IBEW 2144 LOA'
                                         WHEN EecUnionLocal = 'NQ5' THEN 'NQ5 Rumford Salary LOA'
                                         WHEN EecUnionLocal = 'NQ6' THEN 'NQ6 Biron Salary LOA'
                                         WHEN EecUnionLocal = 'NQB' THEN 'NQB Corporate Salary LOA'
                                         WHEN EecUnionLocal IN ('NQC', 'NQCH') THEN 'NQC Fairmont LOA'
                                         WHEN EecUnionLocal IN ('NQD', 'NQDH')THEN 'NQD Old Town LOA'
                                         WHEN EecUnionLocal IN ('NQP', 'NQPH') THEN 'NQP ND Packaging LOA'
                                    END
                                )
        ,drvSalutation = ''
        ,drvFirstName = CONCAT('FirstName=',EepNameFirst)
        ,drvMiddleInitial = CONCAT('MiddleInitial=',LEFT(ISNULL(EepNameMiddle,''),1))
        ,drvLastName = CONCAT('LastName=',EepNameLast)
        ,drvSSN = CONCAT('SSN=',eepSSN)
        ,drvIndividualID = CONCAT('IndividualID=',eecEmpNo)
        ,drvEmail = ''
        ,drvPhone = ''
        ,drvPhone2 = ''
        ,drvAddress1 = CONCAT('Address1=',EepAddressLine1)
        ,drvAddress2 = CONCAT('Address2=',EepAddressLine2) 
        ,drvCity = CONCAT('City=',EepAddressCity)
        ,drvStateOrProvince = CONCAT('StateOrProvince=',EepAddressState)
        ,drvPostalCode = CONCAT('PostalCode=',EepAddressZipCode)
        ,drvCountry = CONCAT('Country=','')
        ,drvSex = CONCAT('Sex=',eepGender)
        ,drvDOB = CONCAT('DOB=',CAST(CONVERT(DATETIME, EepDateOfBirth, 112) as varchar))
        ,drvTobaccoUse = CONCAT('TobaccoUse=','UNKNOWN')
        ,drvEmployeeType = CONCAT('EmployeeType=','UNKNOWN')
        ,drvEmployeePayrollType = CONCAT('EmployeePayrollType=',
                        CASE WHEN jbcFLSAType = 'N' THEN 'NONEXEMPT' ELSE 'EXEMPT' END
                            )
        ,drvYearsOfService = CONCAT('YearsOfService','')
        ,drvPremiumCouponType = CONCAT('PremiumCouponType','COUPONBOOK')
        ,drvBillingStartDate = CONCAT('BillingStartDate','') --TODO : Event Date mapping (Column G) of embedded spreadsheet dont have access to the reference doc
        ,drvBillingEndDate = CONCAT('BillingEndDate','')
        ,drvBillingFrequency = CONCAT('BillingFrequency','MONTHLY')
        ,drvBillingType = CONCAT('BillingType','LEAVEOFABSENCE')
        ,drvEnrollmentDate = CONCAT('EnrollmentDate','') --TODO : Event Date mapping (Column G) of embedded spreadsheet dont have access to the reference doc
        ,drvSPMGracePeriodNROfDays = CONCAT('SPMGracePeriodNROfDays','CLIENTDEFAULT')
        ,drvGracePeriodNrOfDays = CONCAT('GracePeriodNrOfDays','')
        ,drvBenefitGroup = CONCAT('BenefitGroup','')
        ,drvAccountStructure = CONCAT('AccountStructure','')
        ,drvClientSpecificData = CONCAT('ClientSpecificData','')
        ,drvQueueWelcomeLetter = CONCAT('QueueWelcomeLetter','TRUE')
        ,drvEventDate = CONCAT('EventDate','') --TODO : Event Date mapping (Column G) of embedded spreadsheet dont have access to the reference doc
        ,drvInitialGracePeriodDate = CONCAT('InitialGracePeriodDate','')
        ,drvBillingPeriodSeedDate = CONCAT('BillingPeriodSeedDate','')
        ,drvSecondBillingPrdSeedDate = CONCAT('SecondBillingPeriodSeedDate','')
        ,drvPlanCategory = CONCAT('PlanCategory','')
    INTO dbo.U_ENDPDISEXP_drvSPMINSERT
    FROM dbo.U_ENDPDISEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    Join dbo.JobCode WITH (NOLOCK)
        on JbcJobCode = eecjobcode
    JOIN dbo.U_ENDPDISEXP_Employees_Changes WITH (NOLOCK)
        on audEEID = xeeid
        and AudLOA ='Y'
    and exists (Select 1 from U_DSI_BDM_ENDPDISEXP where bdmeeid =  xeeid)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ENDPDISEXP_drvSPMUPDATE
    ---------------------------------
    IF OBJECT_ID('U_ENDPDISEXP_drvSPMUPDATE','U') IS NOT NULL
        DROP TABLE dbo.U_ENDPDISEXP_drvSPMUPDATE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepssn
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifier = '[SPMUPDATE]'
        ,drvClientName = CONCAT('ClientName=','ND Paper Inc 36815')
        ,drvoSSN = CONCAT('oSSN=',eepSSN)
        ,drvoBillingStartDate = CONCAT('oBillingStartDate=','') --TODO : Event Date mapping (Column G) of embedded spreadsheet dont have access to the reference doc
        ,drvoBillingType =  CONCAT('oBillingType=','LEAVEOFABSENCE')
        ,drvoBillingFrequency =  CONCAT('oBillingFrequency=','MONTHLY')
        ,drvSalutation = CONCAT('Salutation=','')
        ,drvFirstName = CONCAT('FirstName=',EepNameFirst)
        ,drvMiddleInitial = CONCAT('MiddleInitial=',LEFT(EepNameMiddle,1))
        ,drvLastName = CONCAT('LastName=',EepNameLast)
        ,drvSSN = CONCAT('SSN=',eepSSN) 
        ,drvIndividualID = CONCAT('IndividualID=',eecEmpNo) 
        ,drvEmail = CONCAT('Email=','')
        ,drvPhone =   CONCAT('Phone=','')
        ,drvPhone2 =   CONCAT('Phone2=','')
        ,drvAddress1 = CONCAT('Address1=',EepAddressLine1)
        ,drvAddress2 = CONCAT('Address2=',EepAddressLine1)
        ,drvCity = CONCAT('City=',EepAddressCity)
        ,drvStateOrProvince = CONCAT('StateOrProvince=',EepAddressState)
        ,drvPostalCode = CONCAT('PostalCode=',EepAddressZipCode)
        ,drvCountry = CONCAT('Country=','')
        ,drvSex = CONCAT('Sex=',eepgender)
        ,drvDOB = CONCAT('DOB=',CAST(CONVERT(DATETIME, EepDateOfBirth, 112) as varchar))
        ,drvTobaccoUse = CONCAT('TobaccoUse=','UNKNOWN')
        ,drvEmployeeType = CONCAT('EmployeeType=','UNKNOWN')
        ,drvEmployeePayrollType = CONCAT('EmployeeType=','UNKNOWN')
        ,drvYearsOfService = CONCAT('YearsOfService','')
        ,drvPremiumCouponType = CONCAT('PremiumCouponType','COUPONBOOK')
        ,drvBillingStartDate = CONCAT('BillingStartDate','') --TODO : Event Date mapping (Column G) of embedded spreadsheet dont have access to the reference doc
        ,drvBillingEndDate = CONCAT('BillingEndDate','')
        ,drvBillingFrequency = CONCAT('BillingFrequency','MONTHLY')
        ,drvBillingType = CONCAT('BillingType','LEAVEOFABSENCE')
        ,drvEnrollmentDate = CONCAT('EnrollmentDate','') --TODO : Event Date mapping (Column G) of embedded spreadsheet dont have access to the reference doc
        ,drvSPMGracePeriodNROfDays = CONCAT('SPMGracePeriodNROfDays','CLIENTDEFAULT')
        ,drvGracePeriodNrOfDays = CONCAT('GracePeriodNrOfDays','')
        ,drvBenefitGroup = CONCAT('BenefitGroup','')
        ,drvAccountStructure = CONCAT('AccountStructure','')
        ,drvClientSpecificData = CONCAT('ClientSpecificData','')
        ,drvQueueWelcomeLetter = CONCAT('QueueWelcomeLetter','TRUE')
        ,drvEventDate = CONCAT('EventDate','') --TODO : Event Date mapping (Column G) of embedded spreadsheet dont have access to the reference doc
        ,drvInitialGracePeriodDate = CONCAT('InitialGracePeriodDate','')
        ,drvBillingPeriodSeedDate = CONCAT('BillingPeriodSeedDate','')
        ,drvSecondBillingPrddSeedDate = CONCAT('SecondBillingPeriodSeedDate','')
        ,drvPlanCategory = CONCAT('PlanCategory','')
    INTO dbo.U_ENDPDISEXP_drvSPMUPDATE
    FROM dbo.U_ENDPDISEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_ENDPDISEXP_Employees_Changes WITH (NOLOCK)
        on audEEID = xeeid
        and audLOAToActiveOrTerm ='Y'
    and exists (Select 1 from U_DSI_BDM_ENDPDISEXP where bdmeeid =  xeeid)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ENDPDISEXP_drvSPMPLANINSERT
    ---------------------------------
    IF OBJECT_ID('U_ENDPDISEXP_drvSPMPLANINSERT','U') IS NOT NULL
        DROP TABLE dbo.U_ENDPDISEXP_drvSPMPLANINSERT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifier = '[SPMPLANINSERT]'
        ,drvClientName = CONCAT('ClientName=,','ND Paper Inc 36815')
        ,drvoSSN = CONCAT('oSSN=',eepSSN)
        ,drvoBillingStartDate = CONCAT('oBillingStartDate','') --TODO : Event Date mapping (Column G) of embedded spreadsheet dont have access to the reference doc
        ,drvoBillingType =  CONCAT('oBillingType','LEAVEOFABSENCE')
        ,drvoBillingFrequency = CONCAT('oBillingFrequency','MONTHLY')
        --TODO : Check with IA regarding the plan and coverage level looks like same info map to the same field.
        ,drvPlanName = CONCAT('PlanName=',
                            CASE WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'IBEW2144' THEN 'DB Cigna Dental Schedule LOA'
                                WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'IBEW2144' THEN 'DB Cigna Dental Schedule LOA'
                                WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'IBEW2144' THEN 'DB Cigna Dental URC LOA'
                                WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'IBEW2144' THEN 'DB Cigna Dental URC LOA'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Prudential Supp Life Rumford Union 0-69'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Prudential Supp Life Rumford Union 70-74'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Prudential Supp Life Rumford Union 75+'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'LTDRB, LTDUB' AND eecUnionLocal = 'IBEW2144' THEN 'DB Prudential LTD Biron and Rumford Union'
                                WHEN eeddedcode = 'LTDRB, LTDUB' AND eecUnionLocal = 'USW900' THEN 'DB Prudential LTD Biron and Rumford Union'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'USW900' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'USW900' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'USW900' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'USW900' THEN 'DB Cigna Dental Schedule LOA'
                                WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'USW900' THEN 'DB Cigna Dental Schedule LOA'
                                WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'USW900' THEN 'DB Cigna Dental URC LOA'
                                WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'USW900' THEN 'DB Cigna Dental URC LOA'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'USW900' THEN 'DB Prudential Supp Life Rumford Union 0-69'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'USW900' THEN 'DB Prudential Supp Life Rumford Union 70-74'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'USW900' THEN 'DB Prudential Supp Life Rumford Union 75+'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' THEN 'DB VSP Vision Voluntary LOA'
                                ---
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('15K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('5K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $10k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('25K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('50K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFS') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFCH') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQ6')   THEN 'DB Prudential AD&D Supplemental Employee'
                                WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQ6')   THEN 'DB Prudential LTD Salaried/Non Union'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('15K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('5K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('25K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('50K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP 10k'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQ6')   THEN 'DB Prudential Supp Life EE Non Tobacco'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQ6')   THEN 'DB Prudential Supp Life EE Tobacco'
                                --
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('15K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('5K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $10k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('25K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('50K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFS') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFCH') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'DB Prudential AD&D Supplemental Employee'
                                WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'DB Prudential LTD Salaried/Non Union'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('15K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('5K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('25K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('50K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP 10k'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'DB Prudential Supp Life EE Non Tobacco'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'DB Prudential Supp Life EE Tobacco'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('15K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('5K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $10k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('25K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('50K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'DB Prudential AD&D Supplemental Employee'
                                WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'DB Prudential LTD Salaried/Non Union'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('15K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('5K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('25K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('50K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP 10k'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'DB Prudential Supp Life EE Non Tobacco'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'DB Prudential Supp Life EE Tobacco'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('15K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('5K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $10k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('25K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('50K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'DB Prudential AD&D Supplemental Employee'
                                WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'DB Prudential LTD Salaried/Non Union'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('15K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('5K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('15K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('1K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP 10k'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'DB Prudential Supp Life EE Non Tobacco'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'DB Prudential Supp Life EE Tobacco'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('15K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('5K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $10k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('25K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('50K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'DB VSP Vision Voluntary LOA'
                                END
        )
        ,drvStartDate = CONCAT('StartDate=','')
        ,drvEffectiveDate = CONCAT('EndDate=','')
        ,drvCoverageLevel = CONCAT('CoverageLevel',CASE WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'eedBenOption' THEN 'EE'
                                                        WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELF' THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELFS' THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELFCH' THEN 'EE+FAMILY'
                                                        WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELFF' THEN 'EE'
                                                        WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELF' THEN 'EE+FAMILY'
                                                        WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELFF' THEN 'EE'
                                                        WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELF' THEN 'EE+FAMILY'
                                                        WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELFF' THEN 'EE'
                                                        WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'IBEW2144'  THEN 'EE'
                                                        WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'IBEW2144'  THEN 'EE'
                                                        WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144'  THEN 'EE'
                                                        WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELF' THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELFS' THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELFCH' THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('LTDRB', 'LTDUB') AND eecUnionLocal = 'IBEW2144' and eedbenoption = 'SELFF' THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDRB', 'LTDUB') AND eecUnionLocal = 'USW900'  THEN 'EE'
                                                        WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'USW900'  THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'USW900' and eedbenoption = 'SELFS' THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'USW900' and eedbenoption = 'SELFCH' THEN 'EE+FAMILY'
                                                        WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'USW900' and eedbenoption = 'SELFF' THEN 'EE'
                                                        WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'USW900' and eedbenoption = 'SELF' THEN 'EE+FAMILY'
                                                        WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'USW900' and eedbenoption = 'SELFF' THEN 'EE'
                                                        WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'USW900' and eedbenoption = 'SELF' THEN 'EE+FAMILY'
                                                        WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'USW900' and eedbenoption = 'SELFF' THEN 'EE'
                                                        WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'USW900'  THEN 'EE'
                                                        WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'USW900'  THEN 'EE'
                                                        WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900'  THEN 'EE'
                                                        WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' and eedbenoption = 'SELF' THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' and eedbenoption = 'SELFS' THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' and eedbenoption = 'SELFCH' THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ5') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ5') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ5') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ5') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ5') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ5') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ5') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ5') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ5') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ5') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ5') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ5') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ5') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ6') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ6') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ6') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ6') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ6') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ6') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ6') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ6') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ6') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ6') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ6') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ6') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQ6') THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQ6')   THEN 'EE'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRABC')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRABU')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBI')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDUB')   THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFBI')   THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4 ') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4 ') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4 ') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4 ') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQB')   THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQB')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('10K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('15K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('5K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('25K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('50K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('10K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQB')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQB')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('10K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('15K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('5K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('10K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('25K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('50K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('15K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('5K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('25K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('50K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('15K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('5K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('25K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('50K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('15K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('5K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('25K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('50K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('15K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('5K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('25K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('50K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'
                                                        WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('15K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('5K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('15K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('1K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'EE'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('15K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('5K') THEN 'CHILDRENONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('25K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('50K') THEN 'SPOUSEONLY'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'EE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'EE+SPOUSE'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'EE+CHILDREN'
                                                        WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'EE+FAMILY'

END)
        ,drvFirstDayOff = CONCAT('FirstDayOff','')
        ,drvLastDayOff = CONCAT('LastDayOff','')
        ,drvNumberOfUnits = CONCAT('NumberOfUnits','')
        ,drvPlanBudleName = CONCAT('PlanBudleName','')
        ,drvQueuePlanLetterChange = CONCAT('QueuePlanLetterChange','')
        ,drvDedCode =  eeddedcode
    INTO dbo.U_ENDPDISEXP_drvSPMPLANINSERT
    FROM dbo.U_ENDPDISEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    JOIN dbo.U_ENDPDISEXP_Employees_Changes WITH (NOLOCK)
        on audEEID = xeeid
        and audLOA ='Y'
    WHERE eecEmplStatus = 'L'
    ;


     ---------------------------------
    -- DETAIL RECORD - U_ENDPDISEXP_drvSPMPLANDROP
    ---------------------------------
    IF OBJECT_ID('U_ENDPDISEXP_drvSPMPLANDROP','U') IS NOT NULL
        DROP TABLE dbo.U_ENDPDISEXP_drvSPMPLANDROP;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifier = '[SPMPLANDROP]'
        ,drvClientName = CONCAT('ClientName=,','ND Paper Inc 36815')
        ,drvoSSN = CONCAT('oSSN=',eepSSN)
        ,drvoBillingStartDate = CONCAT('oBillingStartDate','') --TODO : Event Date mapping (Column G) of embedded spreadsheet
        ,drvoBillingType =  CONCAT('oBillingType','LEAVEOFABSENCE')
        ,drvoBillingFrequency = CONCAT('oBillingFrequency','MONTHLY')
        ,drvPlanName = CONCAT('PlanName=',
                            CASE WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'IBEW2144' THEN 'DB Cigna Dental Schedule LOA'
                                WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'IBEW2144' THEN 'DB Cigna Dental Schedule LOA'
                                WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'IBEW2144' THEN 'DB Cigna Dental URC LOA'
                                WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'IBEW2144' THEN 'DB Cigna Dental URC LOA'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Prudential Supp Life Rumford Union 0-69'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Prudential Supp Life Rumford Union 70-74'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'IBEW2144' THEN 'DB Prudential Supp Life Rumford Union 75+'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'IBEW2144' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'LTDRB, LTDUB' AND eecUnionLocal = 'IBEW2144' THEN 'DB Prudential LTD Biron and Rumford Union'
                                WHEN eeddedcode = 'LTDRB, LTDUB' AND eecUnionLocal = 'USW900' THEN 'DB Prudential LTD Biron and Rumford Union'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'USW900' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'USW900' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'HRARU' AND eecUnionLocal = 'USW900' THEN 'DB Anthem IL Med HRA Union/Rx LOA'
                                WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'USW900' THEN 'DB Cigna Dental Schedule LOA'
                                WHEN eeddedcode = 'DNTSC' AND eecUnionLocal = 'USW900' THEN 'DB Cigna Dental Schedule LOA'
                                WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'USW900' THEN 'DB Cigna Dental URC LOA'
                                WHEN eeddedcode = 'DNTUC' AND eecUnionLocal = 'USW900' THEN 'DB Cigna Dental URC LOA'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'USW900' THEN 'DB Prudential Supp Life Rumford Union 0-69'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'USW900' THEN 'DB Prudential Supp Life Rumford Union 70-74'
                                WHEN eeddedcode = 'SLFRU' AND eecUnionLocal = 'USW900' THEN 'DB Prudential Supp Life Rumford Union 75+'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode = 'VSP' AND eecUnionLocal = 'USW900' THEN 'DB VSP Vision Voluntary LOA'
                                ---
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('15K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('5K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $10k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('25K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('50K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFS') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFCH') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('SELFF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQ6')   THEN 'DB Prudential AD&D Supplemental Employee'
                                WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQ6')   THEN 'DB Prudential LTD Salaried/Non Union'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('15K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('5K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('25K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('50K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQ6')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP 10k'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQ6')   THEN 'DB Prudential Supp Life EE Non Tobacco'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQ6')   THEN 'DB Prudential Supp Life EE Tobacco'
                                --
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('15K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('5K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $10k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('25K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('50K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFS') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFCH') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQB')  and eedbenoption in('SELFF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HRAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HRA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'DB Prudential AD&D Supplemental Employee'
                                WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'DB Prudential LTD Salaried/Non Union'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('15K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('5K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('25K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('50K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP 10k'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'DB Prudential Supp Life EE Non Tobacco'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQC', 'NQCH')   THEN 'DB Prudential Supp Life EE Tobacco'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('15K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('5K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $10k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('25K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('50K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFS') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFCH') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQC', 'NQCH')  and eedbenoption in('SELFF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'DB Prudential AD&D Supplemental Employee'
                                WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'DB Prudential LTD Salaried/Non Union'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('15K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('5K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('25K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('50K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP 10k'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'DB Prudential Supp Life EE Non Tobacco'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQD', 'NQDH')   THEN 'DB Prudential Supp Life EE Tobacco'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('15K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('5K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $10k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('25K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('50K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFS') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFCH') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQD', 'NQDH')  and eedbenoption in('SELFF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA  + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HRA + 1 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HRA + 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HRA + 2 Wellness'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HRAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HRA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6', 'SMOKE 4') THEN 'Anthem IL Medical LOA HSA  + 1 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 2', 'WELL 3', 'WELL 6') THEN 'Anthem IL Medical LOA HSA + 1 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4') THEN 'Anthem IL Medical LOA HSA + 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4 ') THEN 'Anthem IL Medical LOA HSA + 2 Wellness'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('WELL 4', 'SMOKE 1', 'SMOKE 2', 'SMOKE 5') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 1 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN', 'SMOKE', 'WELLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SMOKE 4', 'WELL 4') THEN 'Anthem IL Medical LOA HSA + 2 Wellness & 2 Smoker'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('HSAFN') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'DB Anthem IL Med HSA/Rx LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTBA') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Basic PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('DNTCM') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'DB Cigna Dental Comprehensive PPO LOA'
                                WHEN eeddedcode IN ('ADNU') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'DB Prudential AD&D Supplemental Employee'
                                WHEN eeddedcode IN ('LTDNB') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'DB Prudential LTD Salaried/Non Union'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('15K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCADD') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('5K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('15K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('SADDS') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('1K') THEN 'DB Prudential Supp AD&D SlrdNonU Hrly SP 10k'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'DB Prudential Supp Life EE Non Tobacco'
                                WHEN eeddedcode IN ('SLFFG', 'SLFFN') AND eecPayGroup  IN( 'NQP', 'NQPH')   THEN 'DB Prudential Supp Life EE Tobacco'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $10k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('15K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $15k'
                                WHEN eeddedcode IN ('SCLFE') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('5K') THEN 'DB Prudential Supp Life SlrdNonU Hrly CH $5k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('10K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $10k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('25K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $25k'
                                WHEN eeddedcode IN ('SSPLF') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('50K') THEN 'DB Prudential Supp Life SlrdNonU Hrly SP $50k'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELF') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFS') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFCH') THEN 'DB VSP Vision Voluntary LOA'
                                WHEN eeddedcode IN ('VSP') AND eecPayGroup  IN( 'NQP', 'NQPH')  and eedbenoption in('SELFF') THEN 'DB VSP Vision Voluntary LOA'
                                END
        )
        ,drvStartDate = CONCAT('StartDate=','')
        ,drvEffectiveDate = CONCAT('EffectiveDate =','')
        ,drvDedCode =  eeddedcode
    INTO dbo.U_ENDPDISEXP_drvSPMPLANDROP
    FROM dbo.U_ENDPDISEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    JOIN dbo.U_ENDPDISEXP_Employees_Changes WITH (NOLOCK)
        on audEEID = xeeid
        and audBenDrop ='Y'
    WHERE eecEmplStatus = 'L'
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
ALTER VIEW dbo.dsi_vwENDPDISEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENDPDISEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ENDPDISEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007051'
       ,expStartPerControl     = '202008051'
       ,expLastEndPerControl   = '202008129'
       ,expEndPerControl       = '202008129'
WHERE expFormatCode = 'ENDPDISEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENDPDISEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENDPDISEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort