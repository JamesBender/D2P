SET NOCOUNT ON;
IF OBJECT_ID('U_EI2VRPAYEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EI2VRPAYEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EI2VRPAYEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEI2VRPAYEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEI2VRPAYEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EI2VRPAYEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EI2VRPAYEX];
GO
IF OBJECT_ID('U_EI2VRPAYEX_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_PTaxHist];
GO
IF OBJECT_ID('U_EI2VRPAYEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_PEarHist];
GO
IF OBJECT_ID('U_EI2VRPAYEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_PDedHist];
GO
IF OBJECT_ID('U_EI2VRPAYEX_File') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_File];
GO
IF OBJECT_ID('U_EI2VRPAYEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_EEList];
GO
IF OBJECT_ID('U_EI2VRPAYEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_drvTbl];
GO
IF OBJECT_ID('U_EI2VRPAYEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_DedList];
GO
IF OBJECT_ID('U_EI2VRPAYEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_AuditFields];
GO
IF OBJECT_ID('U_EI2VRPAYEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EI2VRPAYEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EI2VRPAYEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EI2VRPAYEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EI2VRPAYEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EI2VRPAYEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EI2VRPAYEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EI2VRPAYEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EI2VRPAYEX','i2Verify Payroll Earnings Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EI2VRPAYEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EI2VRPAYEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FEIN"','1','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','1',NULL,'FEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SuiAccountNumber"','2','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','2',NULL,'SuiAccountNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkStreetAddress"','3','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','3',NULL,'WorkStreetAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LocationCode"','4','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','4',NULL,'LocationCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkCity"','5','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','5',NULL,'WorkCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkState"','6','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','6',NULL,'WorkState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkZip"','7','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','7',NULL,'WorkZip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','8','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeID"','9','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','9',NULL,'EmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName"','10','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','10',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName"','11','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','11',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MiddleName"','12','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','12',NULL,'MiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BirthDate"','13','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','13',NULL,'BirthDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeStreetAddress"','14','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','14',NULL,'EmployeeStreetAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeCity"','15','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','15',NULL,'EmployeeCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeState"','16','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','16',NULL,'EmployeeState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeZip"','17','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','17',NULL,'EmployeeZip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department"','18','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','18',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"JobTitle"','19','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','19',NULL,'JobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OriginalHireDate"','20','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','20',NULL,'OriginalHireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TermDate"','21','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','21',NULL,'TermDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MostRecentHireDate"','22','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','22',NULL,'MostRecentHireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OriginalTermDate"','23','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','23',NULL,'OriginalTermDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmploymentStatus"','24','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','24',NULL,'EmploymentStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmploymentType"','25','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','25',NULL,'EmploymentType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FteRatio"','26','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','26',NULL,'FteRatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TermReason"','27','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','27',NULL,'TermReason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MonthsWorked"','28','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','28',NULL,'MonthsWorked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PayRate"','29','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','29',NULL,'PayRate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PayRateFrequency"','30','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','30',NULL,'PayRateFrequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PayFrequency"','31','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','31',NULL,'PayFrequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PayStartDate"','32','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','32',NULL,'PayStartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PayEndDate"','33','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','33',NULL,'PayEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CheckDate"','34','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','34',NULL,'CheckDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GrossPay"','35','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','35',NULL,'GrossPay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GrossHours"','36','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','36',NULL,'GrossHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Regular"','37','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','37',NULL,'Regular',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Overtime"','38','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','38',NULL,'Overtime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Bonus"','39','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','39',NULL,'Bonus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PayPeriodSuiWages"','40','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','40',NULL,'PayPeriodSuiWages',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Commission"','41','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','41',NULL,'Commission',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Incentive"','42','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','42',NULL,'Incentive',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Other"','43','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','43',NULL,'Other',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ShiftDifferential"','44','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','44',NULL,'ShiftDifferential',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CheckNumber"','45','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','45',NULL,'CheckNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SocialSecurityWages"','46','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','46',NULL,'SocialSecurityWages',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MedicareWagesAndTips"','47','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','47',NULL,'MedicareWagesAndTips',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SocialSecurityTips"','48','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','48',NULL,'SocialSecurityTips',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StateWithholding"','49','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','49',NULL,'StateWithholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FederalWithholding"','50','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','50',NULL,'FederalWithholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SocialSecurityWithholding"','51','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','51',NULL,'SocialSecurityWithholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MedicareWithholding"','52','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','52',NULL,'MedicareWithholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OtherWithholding"','53','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','53',NULL,'OtherWithholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StateWagesTipsEtc"','54','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','54',NULL,'StateWagesTipsEtc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StateIncomeTax"','55','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','55',NULL,'StateIncomeTax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LocalWagesTipsEtc"','56','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','56',NULL,'LocalWagesTipsEtc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LocalIncomeTax"','57','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','57',NULL,'LocalIncomeTax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MedicalCarrier"','58','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','58',NULL,'MedicalCarrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MedicalEnrollmentType"','59','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','59',NULL,'MedicalEnrollmentType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IsOfferedMedical"','60','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','60',NULL,'IsOfferedMedical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IsEligibleMedical"','61','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','61',NULL,'IsEligibleMedical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IsEnrolledMedical"','62','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','62',NULL,'IsEnrolledMedical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DentalCarrier"','63','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','63',NULL,'DentalCarrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DentalEnrollmentType"','64','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','64',NULL,'DentalEnrollmentType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IsOfferedDental"','65','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','65',NULL,'IsOfferedDental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IsEligibleDental"','66','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','66',NULL,'IsEligibleDental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IsEnrolledDental"','67','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','67',NULL,'IsEnrolledDental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IsPaidSeverance"','68','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','68',NULL,'IsPaidSeverance',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SeveranceBeginDate"','69','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','69',NULL,'SeveranceBeginDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SeveranceEndDate"','70','(''DA''=''T,'')','EI2VRPAYEXZ0','50','H','01','70',NULL,'SeveranceEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SeveranceTotalAmountPaid"','71','(''DA''=''T'')','EI2VRPAYEXZ0','50','H','01','71',NULL,'SeveranceTotalAmountPaid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFEIN"','1','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','1',NULL,'FEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuiAccountNo"','2','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','2',NULL,'SuiAccountNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStreetAddress"','3','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','3',NULL,'WorkStreetAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','4','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','4',NULL,'LocationCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCity"','5','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','5',NULL,'WorkCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','6','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','6',NULL,'WorkState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkZip"','7','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','7',NULL,'WorkZip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','8',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','9','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','9',NULL,'EmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','10','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','10',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','11','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','11',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','12','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','12',NULL,'MiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','13','(''UD101''=''T,'')','EI2VRPAYEXZ0','50','D','10','13',NULL,'BirthDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStAddress"','14','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','14',NULL,'EmployeeStreetAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeCity"','15','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','15',NULL,'EmployeeCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeState"','16','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','16',NULL,'EmployeeState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeZip"','17','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','17',NULL,'EmployeeZip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartment"','18','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','18',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','19','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','19',NULL,'JobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','20','(''UD101''=''T,'')','EI2VRPAYEXZ0','50','D','10','20',NULL,'OriginalHireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','21','(''UD101''=''T,'')','EI2VRPAYEXZ0','50','D','10','21',NULL,'TermDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMostRecentHireDate"','22','(''UD101''=''T,'')','EI2VRPAYEXZ0','50','D','10','22',NULL,'MostRecentHireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalTermDate"','23','(''UD101''=''T,'')','EI2VRPAYEXZ0','50','D','10','23',NULL,'OriginalTermDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','24','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','24',NULL,'EmploymentStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployementType"','25','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','25',NULL,'EmploymentType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','26',NULL,'FteRatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReason"','27','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','27',NULL,'TermReason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','28',NULL,'MonthsWorked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayRate"','29','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','29',NULL,'PayRate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayRateFrequency"','30','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','30',NULL,'PayRateFrequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"6"','31','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','31',NULL,'PayFrequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayStartDate"','32','(''UD101''=''T,'')','EI2VRPAYEXZ0','50','D','10','32',NULL,'PayStartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayEndDate"','33','(''UD101''=''T,'')','EI2VRPAYEXZ0','50','D','10','33',NULL,'PayEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','34','(''UD101''=''T,'')','EI2VRPAYEXZ0','50','D','10','34',NULL,'CheckDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrossPay"','35','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','35',NULL,'GrossPay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrossHours"','36','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','36',NULL,'GrossHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRegular"','37','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','37',NULL,'Regular',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOvertime"','38','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','38',NULL,'Overtime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBonus"','39','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','39',NULL,'Bonus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','40',NULL,'PayPeriodSuiWages',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCommission"','41','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','41',NULL,'Commission',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIncentive"','42','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','42',NULL,'Incentive',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOther"','43','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','43',NULL,'Other',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvShiftDifferential"','44','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','44',NULL,'ShiftDifferential',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckNumber"','45','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','45',NULL,'CheckNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocialSecurityWages"','46','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','46',NULL,'SocialSecurityWages',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicuareWagesAndTips"','47','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','47',NULL,'MedicareWagesAndTips',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','48',NULL,'SocialSecurityTips',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateWithholding"','49','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','49',NULL,'StateWithholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFederalWithholding"','50','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','50',NULL,'FederalWithholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocialSecurityWithholding"','51','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','51',NULL,'SocialSecurityWithholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicareWithholding"','52','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','52',NULL,'MedicareWithholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOtherWithholding"','53','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','53',NULL,'OtherWithholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateWagesTipsEtc"','54','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','54',NULL,'StateWagesTipsEtc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateIncomeTax"','55','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','55',NULL,'StateIncomeTax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocalWagesTipsEtc"','56','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','56',NULL,'LocalWagesTipsEtc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocalIncomeTax"','57','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','57',NULL,'LocalIncomeTax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cigna"','58','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','58',NULL,'MedicalCarrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicalEnrollmentType"','59','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','59',NULL,'MedicalEnrollmentType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','60','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','60',NULL,'IsOfferedMedical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','61','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','61',NULL,'IsEligibleMedical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsEnrolledMedical"','62','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','62',NULL,'IsEnrolledMedical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cigna"','63','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','63',NULL,'DentalCarrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalEnrollmentType"','64','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','64',NULL,'DentalEnrollmentType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','65','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','65',NULL,'IsOfferedDental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','66','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','66',NULL,'IsEligibleDental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsEnrolledDental"','67','(''UA''=''T,'')','EI2VRPAYEXZ0','50','D','10','67',NULL,'IsEnrolledDental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','68',NULL,'IsPaidSeverance',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','69',NULL,'SeveranceBeginDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''T,'')','EI2VRPAYEXZ0','50','D','10','70',NULL,'SeveranceEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''T'')','EI2VRPAYEXZ0','50','D','10','71',NULL,'SeveranceTotalAmountPaid',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EI2VRPAYEX_20201203.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202011169','EMPEXPORT','OEACTIVE','Nov 18 2020 12:27PM','EI2VRPAYEX',NULL,NULL,NULL,'202011169','Nov 16 2020 11:52AM','Nov 16 2020 11:52AM','202011051','3','','','202011051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202011169','EMPEXPORT','OEPASSIVE','Nov 18 2020 12:28PM','EI2VRPAYEX',NULL,NULL,NULL,'202011169','Nov 16 2020 11:52AM','Nov 16 2020 11:52AM','202011051','549','','','202011051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'i2Verify Payroll Earnings Exp','202011169','EMPEXPORT','ONDEM_XOE','Nov 18 2020 12:28PM','EI2VRPAYEX',NULL,NULL,NULL,'202011169','Nov 16 2020 11:52AM','Nov 16 2020 11:52AM','202011051','549','','','202011051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'i2Verify Payroll Earning-Sched','202011169','EMPEXPORT','SCH_EI2VRP','Nov 18 2020 12:29PM','EI2VRPAYEX',NULL,NULL,NULL,'202011169','Nov 16 2020 11:52AM','Nov 16 2020 11:52AM','202011051','549','','','202011051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'i2Verify Payroll Earning-Test','202011209','EMPEXPORT','TEST_XOE','Dec  2 2020  5:26PM','EI2VRPAYEX',NULL,NULL,NULL,'202011209','Nov 20 2020 12:00AM','Dec 30 1899 12:00AM','202011201','426','','','202011201',dbo.fn_GetTimedKey(),NULL,'us3lKiVEN1002',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EI2VRPAYEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EI2VRPAYEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EI2VRPAYEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EI2VRPAYEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EI2VRPAYEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EI2VRPAYEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EI2VRPAYEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EI2VRPAYEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EI2VRPAYEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EI2VRPAYEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EI2VRPAYEX','D10','dbo.U_EI2VRPAYEX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EI2VRPAYEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EI2VRPAYEX] (
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
IF OBJECT_ID('U_EI2VRPAYEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EI2VRPAYEX_Audit] (
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
    [audNewHire] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EI2VRPAYEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EI2VRPAYEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EI2VRPAYEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EI2VRPAYEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EI2VRPAYEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EI2VRPAYEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvFEIN] varchar(9) NULL,
    [drvSuiAccountNo] char(15) NULL,
    [drvWorkStreetAddress] varchar(255) NULL,
    [drvLocationCode] char(6) NULL,
    [drvWorkCity] varchar(255) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvWorkZip] varchar(50) NULL,
    [drvSSN] varchar(13) NULL,
    [drvEmployeeID] varchar(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvEmployeeStAddress] varchar(513) NULL,
    [drvEmployeeCity] varchar(257) NULL,
    [drvEmployeeState] varchar(255) NULL,
    [drvEmployeeZip] varchar(50) NULL,
    [drvDepartment] varchar(25) NULL,
    [drvJobTitle] varchar(27) NOT NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvMostRecentHireDate] datetime NULL,
    [drvOriginalTermDate] datetime NULL,
    [drvEmploymentStatus] varchar(1) NULL,
    [drvEmployementType] varchar(1) NOT NULL,
    [drvTermReason] char(6) NULL,
    [drvPayRate] nvarchar(4000) NULL,
    [drvPayRateFrequency] varchar(1) NOT NULL,
    [drvPayStartDate] datetime NULL,
    [drvPayEndDate] datetime NULL,
    [drvCheckDate] date NULL,
    [drvGrossPay] nvarchar(4000) NULL,
    [drvGrossHours] nvarchar(4000) NULL,
    [drvRegular] nvarchar(4000) NULL,
    [drvOvertime] nvarchar(4000) NULL,
    [drvBonus] nvarchar(4000) NULL,
    [drvCommission] nvarchar(4000) NULL,
    [drvIncentive] nvarchar(4000) NULL,
    [drvOther] nvarchar(4000) NULL,
    [drvShiftDifferential] nvarchar(4000) NULL,
    [drvCheckNumber] varchar(10) NULL,
    [drvSocialSecurityWages] nvarchar(4000) NULL,
    [drvMedicuareWagesAndTips] nvarchar(4000) NULL,
    [drvStateWithholding] nvarchar(4000) NULL,
    [drvFederalWithholding] nvarchar(4000) NULL,
    [drvSocialSecurityWithholding] nvarchar(4000) NULL,
    [drvMedicareWithholding] nvarchar(4000) NULL,
    [drvOtherWithholding] nvarchar(4000) NULL,
    [drvStateWagesTipsEtc] nvarchar(4000) NULL,
    [drvStateIncomeTax] nvarchar(4000) NULL,
    [drvLocalWagesTipsEtc] nvarchar(4000) NULL,
    [drvLocalIncomeTax] nvarchar(4000) NULL,
    [drvMedicalEnrollmentType] varchar(40) NULL,
    [drvIsEnrolledMedical] varchar(1) NOT NULL,
    [drvDentalEnrollmentType] varchar(40) NULL,
    [drvIsEnrolledDental] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EI2VRPAYEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EI2VRPAYEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EI2VRPAYEX_File') IS NULL
CREATE TABLE [dbo].[U_EI2VRPAYEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EI2VRPAYEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EI2VRPAYEX_PDedHist] (
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
IF OBJECT_ID('U_EI2VRPAYEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EI2VRPAYEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgDocNo] char(10) NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehRegularAmt] numeric NULL,
    [PehOvertimeAmt] numeric NULL,
    [PehBonusAmt] numeric NULL,
    [PehCommissionAmt] numeric NULL,
    [PehIncentiveAmt] numeric NULL,
    [PehOtherAmt] numeric NULL,
    [PehShiftDifferentialAmt] numeric NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_EI2VRPAYEX_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EI2VRPAYEX_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthCOID] char(5) NOT NULL,
    [PthCurTaxableWages] money NULL,
    [PthSSNWages] numeric NULL,
    [PthMedicareWages] numeric NULL,
    [PthStateWithholding] numeric NULL,
    [PthFederalWithholding] numeric NULL,
    [PthSSNWithholding] numeric NULL,
    [PthMedicareWithholding] numeric NULL,
    [PthOterholding] numeric NULL,
    [PthStateIncomeTax] numeric NULL,
    [PthLocalIncomeTax] numeric NULL,
    [PthStateWagesTipsEtc] numeric NULL,
    [PthLocalWagesTipsEtc] numeric NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EI2VRPAYEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Symplr

Created By: James Bender
Business Analyst: Lea King
Create Date: 11/16/2020
Service Request Number: TekP-2020-10-12-2020

Purpose: i2Verify Payroll Earnings Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EI2VRPAYEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EI2VRPAYEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EI2VRPAYEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EI2VRPAYEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EI2VRPAYEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EI2VRPAYEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EI2VRPAYEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EI2VRPAYEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EI2VRPAYEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EI2VRPAYEX', 'SCH_EI2VRP';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EI2VRPAYEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EI2VRPAYEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EI2VRPAYEX';

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
    DELETE FROM dbo.U_EI2VRPAYEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EI2VRPAYEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED,DEN';

    IF OBJECT_ID('U_EI2VRPAYEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EI2VRPAYEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EI2VRPAYEX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedTypes',@DedList);
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','MED,DEN,VIS');
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


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EI2VRPAYEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EI2VRPAYEX_AuditFields;
    CREATE TABLE dbo.U_EI2VRPAYEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EI2VRPAYEX_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    --INSERT INTO dbo.U_EI2VRPAYEX_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EI2VRPAYEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EI2VRPAYEX_Audit;
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
    INTO dbo.U_EI2VRPAYEX_Audit
    FROM dbo.U_EI2VRPAYEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EI2VRPAYEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE --audDateTime BETWEEN @StartDate AND @EndDate
    --AND 
    audAction <> 'DELETE'
    --AND ISNULL(audNewValue,'') <> '';
    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EI2VRPAYEX_Audit WHERE audRowNo > 1;



    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EI2VRPAYEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EI2VRPAYEX_PDedHist;
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
    INTO dbo.U_EI2VRPAYEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EI2VRPAYEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EI2VRPAYEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EI2VRPAYEX_PEarHist;
    SELECT DISTINCT
         PehEEID
         ,PrgDocNo = MAX(PrgDocNo)
        --,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)

        ,PehRegularAmt            = SUM(CASE WHEN ErnIsRegularPayCode = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehOvertimeAmt            = SUM(CASE WHEN ErnIsOvertime = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehBonusAmt            = SUM(CASE WHEN PehEarnCode IN ('BON2','BONUS','PESBO','REF','SOBO') AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCommissionAmt        = SUM(CASE WHEN PehEarnCode IN ('COMM') AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehIncentiveAmt        = SUM(CASE WHEN PehEarnCode IN ('INCEN') AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehOtherAmt            = SUM(CASE WHEN ErnIsRegularPayCode <> 'Y' AND ErnIsOvertime <> 'Y' AND ErnInclInShiftDiff <> 'Y' AND PehEarnCode NOT IN ('BON2','BONUS','PESBO','INCEN','REF','SOBO','COMM') AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehShiftDifferentialAmt = SUM(CASE WHEN ErnIsRegularPayCode <> 'Y' AND ErnIsOvertime <> 'Y' AND ErnInclInShiftDiff = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)

        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EI2VRPAYEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    IF OBJECT_ID('U_EI2VRPAYEX_PTaxHist','U') IS NOT NULL
        DROP TABLE dbo.U_EI2VRPAYEX_PTaxHist;
    SELECT DISTINCT
        PthEEID
        ,PthCOID
        ,PthCurTaxableWages                        = SUM(PthCurTaxableWages)
        ,PthSSNWages                            = SUM(CASE WHEN PthTaxCode IN ('USSOCEE') THEN PthCurTaxableWages ELSE 0.00 END)
        ,PthMedicareWages                        = SUM(CASE WHEN PthTaxCode IN ('USMEDEE') THEN PthCurTaxableWages ELSE 0.00 END)

        ,PthStateWithholding                    = SUM(CASE WHEN RTRIM(PthTaxCode) LIKE '%SIT' THEN PthCurTaxAmt ELSE 0.00 END)
        ,PthFederalWithholding                    = SUM(CASE WHEN PthTaxCode = 'USFIT' THEN PthCurDefComp + PthCurSec125 + PthCurD125 ELSE 0.00 END)
        ,PthSSNWithholding                        = SUM(CASE WHEN PthTaxCode = 'USSOCEE' THEN PthCurTaxAmt ELSE 0.00 END)
        ,PthMedicareWithholding                    = SUM(CASE WHEN PthTaxCode = 'USMEDEE' THEN PthCurTaxAmt ELSE 0.00 END)
        ,PthOterholding                            = SUM(CASE WHEN PthTaxCode NOT IN ('USMEDEE','USSOCEE','USFIT') AND PthTaxCode NOT LIKE '%LIT' AND PthTaxCode NOT LIKE '%SIT' THEN PthCurTaxAmt ELSE 0.00 END)
        ,PthStateIncomeTax                        = SUM(CASE WHEN PthTaxCode LIKE '%SIT' THEN PthCurTaxAmt ELSE 0.00 END)
        ,PthLocalIncomeTax                        = SUM(CASE WHEN PthTaxCode LIKE '%LIT' THEN PthCurTaxAmt ELSE 0.00 END)


        ,PthStateWagesTipsEtc                    = SUM(CASE WHEN PthTaxCode LIKE '%SIT' THEN PthCurTaxableWages ELSE 0.00 END)
        ,PthLocalWagesTipsEtc                    = SUM(CASE WHEN PthTaxCode LIKE '%LIT' THEN PthCurTaxableWages ELSE 0.00 END)

    INTO dbo.U_EI2VRPAYEX_PTaxHist
    FROM dbo.PTaxHist WITH (NOLOCK)
    WHERE --LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
        --AND PthPerControl <= @EndPerControl
        PthPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PthEEID, PthCOID

    --==========================================
    -- Build Driver Tables
    --==========================================

    DECLARE @FedTaxId VARCHAR(9);

    SELECT TOP 1 @FedTaxId = CmmFedTaxId FROM dbo.CompMast WITH (NOLOCK)

    ---------------------------------
    -- DETAIL RECORD - U_EI2VRPAYEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EI2VRPAYEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EI2VRPAYEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' -- FORMAT(PehCurAmt, '#0.00') -- EecPayGroup --CtcTaxCode
        -- standard fields above and additional driver fields below
        ,drvFEIN = @FedTaxId
        ,drvSuiAccountNo = CtcIdNumber
        ,drvWorkStreetAddress = CASE WHEN LocAddressCity = 'Remote' THEN EepAddressLine1 ELSE LocAddressLine1 END
        ,drvLocationCode = EecLocation
        ,drvWorkCity = CASE WHEN LocAddressCity = 'Remote' THEN EepAddressCity ELSE LocAddressCity END
        ,drvWorkState = CASE WHEN LocAddressCity = 'Remote' THEN EepAddressState ELSE LocAddressState END
        ,drvWorkZip = CASE WHEN LocAddressCity = 'Remote' THEN EepAddressZipCode ELSE LocAddressZipCode END
        ,drvSSN = '"' + RTRIM(eepSSN) + '"'
        ,drvEmployeeID = '"' + RTRIM(EecEmpNo) + '"'
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvNameMiddle = EepNameMiddle
        ,drvDateOfBirth = EepDateOfBirth
        ,drvEmployeeStAddress = '"' + RTRIM(EepAddressLine1) + ' ' + RTRIM(ISNULL(EepAddressLine2, '')) + '"'
        ,drvEmployeeCity = '"' + EepAddressCity + '"'
        ,drvEmployeeState = EepAddressState
        ,drvEmployeeZip = EepAddressZipCode
        ,drvDepartment = OrgLvl4Desc
        ,drvJobTitle = '"' + JbcDesc + '"'
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvMostRecentHireDate = EecDateOfLastHire
        ,drvOriginalTermDate =    CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination 
                                    WHEN EecEmplStatus <> 'T' AND EecDateOfOriginalHire <> EecDateOfLastHire THEN PrevTermDate
                                END
        ,drvEmploymentStatus =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'R'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason <> '202' THEN 'G'
                                    ELSE EecEmplStatus
                                END
        ,drvEmployementType = CASE WHEN EecFullTimeOrPartTime = 'PT' THEN 'P' ELSE 'F' END
        ,drvTermReason = EecTermReason
        ,drvPayRate = FORMAT(CASE WHEN EecSalaryOrHourly = 'H' THEN EecHourlyPayRate ELSE EecAnnSalary END, '#0.00')
        ,drvPayRateFrequency = CASE WHEN EecSalaryOrHourly = 'H' THEN '9' ELSE '1' END
        ,drvPayStartDate = PrgPeriodStart
        ,drvPayEndDate = PrgPeriodEnd
        ,drvCheckDate = PrgPayDate
        ,drvGrossPay = FORMAT(PehCurAmt, '#0.00')
        ,drvGrossHours = FORMAT(PehCurHrs, '#0.00')
        ,drvRegular = FORMAT(PehRegularAmt, '#0.00')
        ,drvOvertime = FORMAT(PehOvertimeAmt, '#0.00')
        ,drvBonus = FORMAT(PehBonusAmt, '#0.00')
        ,drvCommission = FORMAT(PehCommissionAmt, '#0.00')
        ,drvIncentive = FORMAT(PehIncentiveAmt, '#0.00')
        ,drvOther = FORMAT(PehOtherAmt, '#0.00')
        ,drvShiftDifferential = FORMAT(PehShiftDifferentialAmt, '#0.00')
        ,drvCheckNumber = RTRIM(LTRIM(PrgDocNo))
        ,drvSocialSecurityWages = FORMAT(PthSSNWages, '#0.00')  -- JCB
        ,drvMedicuareWagesAndTips = FORMAT(PthMedicareWages, '#0.00')
        ,drvStateWithholding = FORMAT(PthStateWithholding, '#0.00')
        ,drvFederalWithholding = FORMAT(PthFederalWithholding, '#0.00')
        ,drvSocialSecurityWithholding = FORMAT(PthSSNWithholding, '#0.00')
        ,drvMedicareWithholding = FORMAT(PthMedicareWithholding, '#0.00')
        ,drvOtherWithholding = FORMAT(PthOterholding, '#0.00')
        ,drvStateWagesTipsEtc = FORMAT(PthStateWagesTipsEtc, '#0.00')
        ,drvStateIncomeTax = FORMAT(PthStateIncomeTax, '#0.00')
        ,drvLocalWagesTipsEtc = FORMAT(PthLocalWagesTipsEtc, '#0.00')
        ,drvLocalIncomeTax = FORMAT(PthLocalIncomeTax, '#0.00')
        ,drvMedicalEnrollmentType = CASE WHEN MedDedType IS NOT NULL THEN MedCode.DedLongDesc END
        ,drvIsEnrolledMedical = CASE WHEN MedDedCode IS NOT NULL THEN '1' ELSE '2' END
        ,drvDentalEnrollmentType = CASE WHEN DenDedType IS NOT NULL THEN DenCode.DedLongDesc END
        ,drvIsEnrolledDental = CASE WHEN DenDedCode IS NOT NULL THEN '1' ELSE '2' END
    INTO dbo.U_EI2VRPAYEX_drvTbl
    FROM dbo.U_EI2VRPAYEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
--    JOIN dbo.Company WITH (NOLOCK)
--        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    /*LEFT JOIN dbo.U_dsi_BDM_EI2VRPAYEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID*/
    LEFT JOIN (
                SELECT BdmEEID
                    ,BdmCOID
                    ,MAX(CASE WHEN BdmDedType = 'MED' AND BdmBenStatus = 'A' THEN BdmDedType END) AS MedDedType
                    ,MAX(CASE WHEN BdmDedType = 'MED' AND BdmBenStatus = 'A' THEN BdmDedCode END) AS MedDedCode
                    ,MAX(CASE WHEN BdmDedType = 'DEN' AND BdmBenStatus = 'A' THEN BdmDedType END) AS DenDedType
                    ,MAX(CASE WHEN BdmDedType = 'DEN' AND BdmBenStatus = 'A' THEN BdmDedCode END) AS DenDedCode
                FROM dbo.U_dsi_BDM_EI2VRPAYEX WITH (NOLOCK)
                GROUP BY BdmEEID, BdmCOID) AS Bdm
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.DedCode MedCode WITH (NOLOCK)
        ON MedDedCode = MedCode.DedDedCode
    LEFT JOIN dbo.DedCode DenCode WITH (NOLOCK)
        ON DenDedCode = DenCode.DedDedCode
    JOIN dbo.EmpTax WITH (NOLOCK)
        ON EetEEID = xEEID
        AND EetCOID = xCOID
        AND RIGHT(RTRIM(EetTaxCode), 3) = 'SIT'
    --JOIN dbo.TaxCode WITH (NOLOCK)
      --  ON EetTaxCode = CtcTaxCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl4Code, OrgDesc AS OrgLvl4Desc
                FROM dbo.vw_int_OrgLevel WITH (NOLOCK)) AS Lvl4
        ON EecOrgLvl4 = OrgLvl4Code
    LEFT JOIN (                
                SELECT audEEID AS PrevTermEEID, audKey2 AS PrevTermCOID, audNewValue AS PrevTermDate
                FROM dbo.U_EI2VRPAYEX_Audit WITH (NOLOCK)
                WHERE audTableName = 'EmpComp'
                    AND audFieldName = 'EecDateOfTermination') AS PrevTerm
        ON PrevTermEEID = xEEID
        --AND PrevTermCOID = xCOID
    JOIN (SELECT PgpPayGroup, CAST(LEFT(MAX(PgpPeriodControl),8) AS DATE) AS PrgPayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup
        ) Prg
            ON EecPayGroup = PgpPayGroup
    JOIN dbo.U_EI2VRPAYEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN dbo.U_EI2VRPAYEX_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
        AND PthCoID = xCOID
    JOIN (
            SELECT DISTINCT A.PthEEID AS aPthEEID, A.PthCOID AS aPthCOID, A.PthTaxCode AS aPthTaxCode, CtcIdNumber
            FROM dbo.pTaxHist A WITH (NOLOCK)
            JOIN ( 
                    SELECT DISTINCT PehEEID, PehCOID,PehSITWorkInStateCode,  PehPerControl
                    FROM pEarHist WITH (NOLOCK)
                    WHERE PehPerControl BETWEEN @StartPerControl AND @EndPerControl) AS Peh
                ON PthEEID = PehEEID
                    AND PthCOID = PehCOID
                    AND PthTaxCode = PehSITWorkInStateCode
                    AND PthPerControl = PehPerControl
            JOIN dbo.TaxCode WITH (NOLOCK)
                ON CtcTaxCode = PthTaxCode
                AND CtcCOID = PthCOID
            WHERE PthTypeOfTax = 'SIT'
                AND A.PthCurTaxAmt > 0
                AND A.PthPerControl BETWEEN @StartPerControl AND @EndPerControl) AS TaxCodes
        ON aPthEEID = xEEID
        AND aPthCOID = xCOID
    WHERE EecEmplStatus <> 'T' AND PehCurAmt > 0
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
ALTER VIEW dbo.dsi_vwEI2VRPAYEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EI2VRPAYEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EI2VRPAYEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202011051'
       ,expStartPerControl     = '202011051'
       ,expLastEndPerControl   = '202011169'
       ,expEndPerControl       = '202011169'
WHERE expFormatCode = 'EI2VRPAYEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEI2VRPAYEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EI2VRPAYEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort