SET NOCOUNT ON;
IF OBJECT_ID('U_EBENEXDEMO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBENEXDEMO_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBENEXDEMO' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEBENEXDEMO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBENEXDEMO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBENEXDEMO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENEXDEMO];
GO
IF OBJECT_ID('U_EBENEXDEMO_PEarHist12Mth') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_PEarHist12Mth];
GO
IF OBJECT_ID('U_EBENEXDEMO_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_PEarHist];
GO
IF OBJECT_ID('U_EBENEXDEMO_File') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_File];
GO
IF OBJECT_ID('U_EBENEXDEMO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_EEList];
GO
IF OBJECT_ID('U_EBENEXDEMO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_drvTbl];
GO
IF OBJECT_ID('U_EBENEXDEMO_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_AuditFields];
GO
IF OBJECT_ID('U_EBENEXDEMO_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBENEXDEMO';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBENEXDEMO';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBENEXDEMO';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBENEXDEMO';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBENEXDEMO';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBENEXDEMO','Benefit Express Census Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','EBENEXDEMOZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBENEXDEMO' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','1','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','1',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Key"','2','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','2',NULL,'Payroll Key',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','3','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','4','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','5','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','6','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','6',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Suffix"','7','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','7',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1"','8','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','8',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','9','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','9',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','10','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','11','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work State"','12','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','12',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Province"','13','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','13',NULL,'Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country Mailing Address"','14','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','14',NULL,'Country Mailing Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country of Citizenship"','15','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','15',NULL,'Country of Citizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country of Employment"','16','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','16',NULL,'Country of Employment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Zip Code"','17','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','17',NULL,'Home Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Zip Code"','18','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','18',NULL,'Work Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','19','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','19',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','20','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','20',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Email"','21','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','21',NULL,'Home Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Email"','22','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','22',NULL,'Work Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','23','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','23',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birth Date"','24','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','24',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','25','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','25',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Married to Another Employee"','26','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','26',NULL,'Married to Another Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse SSN"','27','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','27',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','28','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','28',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status Date"','29','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','29',NULL,'Employment Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status Change Reason"','30','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','30',NULL,'Employment Status Change Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Original Hire"','31','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','31',NULL,'Date of Original Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of ReHire"','32','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','32',NULL,'Date of ReHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Leave"','33','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','33',NULL,'Date of Leave',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Termination"','34','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','34',NULL,'Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Reason"','35','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','35',NULL,'Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Retirement"','36','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','36',NULL,'Date of Retirement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medicare Eligible Flag"','37','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','37',NULL,'Medicare Eligible Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medicare Eligible Date"','38','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','38',NULL,'Medicare Eligible Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Eligible Date"','39','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','39',NULL,'Benefit Eligible Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location ID Change Date"','40','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','40',NULL,'Location ID Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Change Date"','41','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','41',NULL,'Salary Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Date 4"','42','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','42',NULL,'User Date 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Date 5"','43','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','43',NULL,'User Date 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EIN"','44','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','44',NULL,'EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company Code"','45','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','45',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department Code"','46','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','46',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Branch Code"','47','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','47',NULL,'Branch Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division Code"','48','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','48',NULL,'Division Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Code"','49','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','49',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Position Code"','50','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','50',NULL,'Position Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','51','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','51',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 1"','52','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','52',NULL,'Org Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Direct Bill Flag"','53','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','53',NULL,'Direct Bill Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 3"','54','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','54',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 4"','55','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','55',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 5"','56','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','56',NULL,'Org Level 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Basis"','57','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','57',NULL,'Work Basis',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly Salaried"','58','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','58',NULL,'Hourly Salaried',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Exempt Flag"','59','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','59',NULL,'Exempt Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Flag"','60','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','60',NULL,'Union Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Local Number"','61','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','61',NULL,'Union Local Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Hours"','62','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','62',NULL,'Scheduled Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Periods Per Annum"','63','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','63',NULL,'Pay Periods Per Annum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Flex Pay Periods"','64','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','64',NULL,'Flex Pay Periods',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Schedule"','65','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','65',NULL,'Payroll Schedule',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Rate"','66','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','66',NULL,'Pay Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Rate Frequency"','67','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','67',NULL,'Pay Rate Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','68','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','68',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Frozen Salary"','69','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','69',NULL,'Frozen Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"January1Earnings"','70','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','70',NULL,'January1Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Money Field 1"','71','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','71',NULL,'Money Field 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Money Field 2"','72','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','72',NULL,'Money Field 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Money Field 3"','73','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','73',NULL,'Money Field 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Money Field 4"','74','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','74',NULL,'Money Field 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Money Field 5"','75','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','75',NULL,'Money Field 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Workers Compensation Group"','76','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','76',NULL,'Workers Compensation Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Numeric 1"','77','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','77',NULL,'Numeric 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Numeric 2"','78','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','78',NULL,'Numeric 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Numeric 3"','79','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','79',NULL,'Numeric 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Numeric 4"','80','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','80',NULL,'Numeric 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Numeric 5"','81','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','81',NULL,'Numeric 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NVarChar 1"','82','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','82',NULL,'NVarChar 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NVarChar 2"','83','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','83',NULL,'NVarChar 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NVarChar 3"','84','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','84',NULL,'NVarChar 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NVarChar 4"','85','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','85',NULL,'NVarChar 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NVarChar 5"','86','(''DA''=''T,'')','EBENEXDEMOZ0','50','H','01','86',NULL,'NVarChar 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Language Preference"','87','(''DA''=''T'')','EBENEXDEMOZ0','50','H','01','87',NULL,'Language Preference',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocialSecurityNumber"','1','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','1',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollKey"','2','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','2',NULL,'Payroll Key',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','4','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','6','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','6',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuffix"','7','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','7',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','8','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','8',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','9','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','9',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','10','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','12','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','12',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvince"','13','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','13',NULL,'Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryMailingAddress"','14','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','14',NULL,'Country Mailing Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryofCitizenship"','15','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','15',NULL,'Country of Citizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryofEmployment"','16','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','16',NULL,'Country of Employment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeZipCode"','17','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','17',NULL,'Home Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkZipCode"','18','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','18',NULL,'Work Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','19','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','19',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','20','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','20',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeEmail"','21','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','21',NULL,'Home Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmail"','22','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','22',NULL,'Work Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','23','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','23',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','24','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','24',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','25','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','25',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMarriedtoAnotherEmployee"','26','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','26',NULL,'Married to Another Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSSN"','27','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','27',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','28','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','28',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatusDate"','29','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','29',NULL,'Employment Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatusChangeReason"','30','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','30',NULL,'Employment Status Change Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofOriginalHire"','31','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','31',NULL,'Date of Original Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofReHire"','32','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','32',NULL,'Date of ReHire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofLeave"','33','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','33',NULL,'Date of Leave',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofTermination"','34','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','34',NULL,'Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReason"','35','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','35',NULL,'Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofRetirement"','36','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','36',NULL,'Date of Retirement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicareEligibleFlag"','37','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','37',NULL,'Medicare Eligible Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicareEligibleDate"','38','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','38',NULL,'Medicare Eligible Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitEligibleDate"','39','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','39',NULL,'Benefit Eligible Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationIDChangeDate"','40','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','40',NULL,'Location ID Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryChangeDate"','41','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','41',NULL,'Salary Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserDate4"','42','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','42',NULL,'User Date 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserDate5"','43','(''UD101''=''T,'')','EBENEXDEMOZ0','50','D','10','43',NULL,'User Date 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEIN"','44','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','44',NULL,'EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyCode1"','45','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','45',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentCode1"','46','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','46',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranchCode"','47','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','47',NULL,'Branch Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivisionCode"','48','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','48',NULL,'Division Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','49','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','49',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPositionCode"','50','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','50',NULL,'Position Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','51','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','51',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLevel1"','52','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','52',NULL,'Org Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDirectBillFlag"','53','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','53',NULL,'Direct Bill Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyCode2"','54','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','54',NULL,'Company Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentCode2"','55','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','55',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLevel5"','56','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','56',NULL,'Org Level 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkBasis"','57','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','57',NULL,'Work Basis',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlySalaried"','58','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','58',NULL,'Hourly Salaried',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptFlag"','59','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','59',NULL,'Exempt Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionFlag"','60','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','60',NULL,'Union Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionLocalNumber"','61','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','61',NULL,'Union Local Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledHours"','62','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','62',NULL,'Scheduled Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodsPerAnnum"','63','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','63',NULL,'Pay Periods Per Annum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFlexPayPeriods"','64','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','64',NULL,'Flex Pay Periods',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollSchedule"','65','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','65',NULL,'Payroll Schedule',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayRate"','66','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','66',NULL,'Pay Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayRateFrequency"','67','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','67',NULL,'Pay Rate Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','68','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','68',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFrozenSalary"','69','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','69',NULL,'Frozen Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJanuary1Earnings"','70','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','70',NULL,'January1Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMoneyField1"','71','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','71',NULL,'Money Field 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMoneyField2"','72','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','72',NULL,'Money Field 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMoneyField3"','73','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','73',NULL,'Money Field 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMoneyField4"','74','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','74',NULL,'Money Field 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMoneyField5"','75','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','75',NULL,'Money Field 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkersCompensationGroup"','76','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','76',NULL,'Workers Compensation Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumeric1"','77','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','77',NULL,'Numeric 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumeric2"','78','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','78',NULL,'Numeric 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumeric3"','79','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','79',NULL,'Numeric 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumeric4"','80','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','80',NULL,'Numeric 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumeric5"','81','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','81',NULL,'Numeric 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNVarChar1"','82','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','82',NULL,'NVarChar 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNVarChar2"','83','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','83',NULL,'NVarChar 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNVarChar3"','84','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','84',NULL,'NVarChar 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNVarChar4"','85','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','85',NULL,'NVarChar 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNVarChar5"','86','(''UA''=''T,'')','EBENEXDEMOZ0','50','D','10','86',NULL,'NVarChar 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguagePreference"','87','(''UA''=''T'')','EBENEXDEMOZ0','50','D','10','87',NULL,'Language Preference',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EBENEXDEMO_20210902.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'Benefit Express Census-Wed 6am','202108119','EMPEXPORT','ONDEM_XOE','Aug 12 2021  5:54AM','EBENEXDEMO',NULL,NULL,NULL,'202108119','Aug 11 2021 12:00AM','Dec 30 1899 12:00AM','202108041','4203','','','202108041',dbo.fn_GetTimedKey(),NULL,'JBENDER10',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'Benefit Express Census-Mon 6am','202103059','EMPEXPORT','SCH_EBENEX','Aug 12 2021  5:55AM','EBENEXDEMO',NULL,NULL,NULL,'202108099','Mar  5 2021  7:49AM','Mar  5 2021  7:49AM','202108021','4175','','','202103051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','DAJ4C,DCQJ1,DAJ8D,CIUJE,CITIX',NULL,NULL,NULL,'Benefit Express Census E-Test','202108199','EMPEXPORT','TEST_XOE','Aug 19 2021  3:32PM','EBENEXDEMO',NULL,NULL,NULL,'202108199','Aug 19 2021 12:00AM','Dec 30 1899 12:00AM','202108051','4210','','','202108051',dbo.fn_GetTimedKey(),NULL,'LKING16',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','IsUTF8','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','UseFileName','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBENEXDEMO','UTF8Path','V',NULL);
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EBENEXDEMO' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EBENEXDEMO' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EBENEXDEMO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBENEXDEMO_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENEXDEMO','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBENEXDEMO','D10','dbo.U_EBENEXDEMO_drvTbl',NULL);
IF OBJECT_ID('U_EBENEXDEMO_Audit') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_Audit] (
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
    [audEmpStatusStartChanged] varchar(1) NOT NULL,
    [audLocationChanged] varchar(1) NOT NULL,
    [audjobReason100] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBENEXDEMO_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EBENEXDEMO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSocialSecurityNumber] char(11) NULL,
    [drvPayrollKey] char(9) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvLastName] varchar(8000) NULL,
    [drvFirstName] varchar(8000) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvSuffix] varchar(30) NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(255) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvProvince] varchar(1) NOT NULL,
    [drvCountryMailingAddress] varchar(3) NOT NULL,
    [drvCountryofCitizenship] varchar(1) NOT NULL,
    [drvCountryofEmployment] varchar(1) NOT NULL,
    [drvHomeZipCode] varchar(50) NULL,
    [drvWorkZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvHomeEmail] varchar(50) NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvMarriedtoAnotherEmployee] varchar(1) NOT NULL,
    [drvSpouseSSN] varchar(1) NOT NULL,
    [drvEmploymentStatus] varchar(6) NOT NULL,
    [drvEmploymentStatusDate] datetime NULL,
    [drvEmpStatusChangeReason] char(6) NULL,
    [drvDateofOriginalHire] datetime NULL,
    [drvDateofReHire] datetime NULL,
    [drvDateofLeave] datetime NULL,
    [drvDateofTermination] datetime NULL,
    [drvTerminationReason] varchar(25) NULL,
    [drvDateofRetirement] datetime NULL,
    [drvMedicareEligibleFlag] varchar(1) NOT NULL,
    [drvMedicareEligibleDate] varchar(1) NOT NULL,
    [drvBenefitEligibleDate] varchar(1) NOT NULL,
    [drvLocationIDChangeDate] datetime NULL,
    [drvSalaryChangeDate] datetime NULL,
    [drvUserDate4] datetime NULL,
    [drvUserDate5] datetime NULL,
    [drvEIN] char(9) NULL,
    [drvCompanyCode1] varchar(1) NOT NULL,
    [drvDepartmentCode1] varchar(1) NOT NULL,
    [drvBranchCode] varchar(1) NOT NULL,
    [drvDivisionCode] varchar(1) NOT NULL,
    [drvLocationCode] varchar(6) NULL,
    [drvPositionCode] char(3) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvOrgLevel1] varchar(1) NOT NULL,
    [drvDirectBillFlag] varchar(1) NOT NULL,
    [drvCompanyCode2] char(5) NULL,
    [drvDepartmentCode2] varchar(8000) NULL,
    [drvOrgLevel5] varchar(50) NULL,
    [drvWorkBasis] char(1) NULL,
    [drvHourlySalaried] char(1) NULL,
    [drvExemptFlag] varchar(1) NOT NULL,
    [drvUnionFlag] varchar(1) NOT NULL,
    [drvUnionLocalNumber] varchar(12) NULL,
    [drvScheduledHours] varchar(30) NULL,
    [drvPayPeriodsPerAnnum] varchar(2) NULL,
    [drvFlexPayPeriods] varchar(2) NULL,
    [drvPayrollSchedule] char(6) NULL,
    [drvPayRate] varchar(30) NULL,
    [drvPayRateFrequency] char(1) NULL,
    [drvAnnualSalary] varchar(30) NULL,
    [drvFrozenSalary] varchar(1) NOT NULL,
    [drvJanuary1Earnings] varchar(1) NOT NULL,
    [drvMoneyField1] varchar(1) NOT NULL,
    [drvMoneyField2] varchar(1) NOT NULL,
    [drvMoneyField3] varchar(1) NOT NULL,
    [drvMoneyField4] varchar(1) NOT NULL,
    [drvMoneyField5] varchar(1) NOT NULL,
    [drvWorkersCompensationGroup] varchar(1) NOT NULL,
    [drvNumeric1] varchar(30) NULL,
    [drvNumeric2] varchar(1) NOT NULL,
    [drvNumeric3] varchar(1) NOT NULL,
    [drvNumeric4] varchar(1) NOT NULL,
    [drvNumeric5] varchar(1) NOT NULL,
    [drvNVarChar1] varchar(201) NULL,
    [drvNVarChar2] char(9) NULL,
    [drvNVarChar3] varchar(201) NULL,
    [drvNVarChar4] char(9) NULL,
    [drvNVarChar5] varchar(1) NOT NULL,
    [drvLanguagePreference] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBENEXDEMO_EEList') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EBENEXDEMO_File') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EBENEXDEMO_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_PEarHist] (
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
IF OBJECT_ID('U_EBENEXDEMO_PEarHist12Mth') IS NULL
CREATE TABLE [dbo].[U_EBENEXDEMO_PEarHist12Mth] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurHrsMiscErn] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBENEXDEMO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Refresco

Created By: Inshan Singh
Business Analyst: Lea King
Create Date: 03/05/2021
Service Request Number: TekP-2021-02-02-0001

Purpose: Benefit Express Census Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBENEXDEMO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBENEXDEMO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBENEXDEMO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBENEXDEMO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBENEXDEMO' ORDER BY RunID DESC;

\\us.saas\E4\Public\REF1001\Exports\Test\

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENEXDEMO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENEXDEMO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBENEXDEMO', 'SCH_EBENEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBENEXDEMO', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@StartYearPerControl VARCHAR(9) 
            ,@Last52WeekPerControl as VARCHAR(10) ;

    -- Set FormatCode
    SELECT @FormatCode = 'EBENEXDEMO';

    SELECT @StartYearPerControl = CONCAT(YEAR(GETDATE()), '01','011')

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'
    PRINT 'Last 52 Weeks ' + @Last52WeekPerControl

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBENEXDEMO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBENEXDEMO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    -- delete SSN that start with 999
    DELETE FROM dbo.U_EBENEXDEMO_EEList WHERE xEEID IN (SELECT Eepeeid FROM dbo.emppers WITH (NOLOCK) WHERE Eepssn like ('999%'))


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBENEXDEMO_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXDEMO_AuditFields;
    CREATE TABLE dbo.U_EBENEXDEMO_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EBENEXDEMO_AuditFields VALUES ('Empcomp','EecEmplstatus');
    INSERT INTO dbo.U_EBENEXDEMO_AuditFields VALUES ('Empcomp','EecLocation');
    INSERT INTO dbo.U_EBENEXDEMO_AuditFields VALUES ('Empcomp','EecEmplStatusStartDate')
    INSERT INTO dbo.U_EBENEXDEMO_AuditFields VALUES ('Empcomp','EecJobChangeReason')
    INSERT INTO dbo.U_EBENEXDEMO_AuditFields VALUES ('Empcomp','EecAnnSalary')

    ;

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBENEXDEMO_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXDEMO_Audit;
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
        ,audEmpStatusStartChanged = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatusStartDate' AND audNewValue is not null  THEN 'Y' ELSE 'N' END
        ,audLocationChanged = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecLocation' AND audNewValue is not null  THEN 'Y' ELSE 'N' END
        ,audjobReason100 = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecJobChangeReason' AND audNewValue ='100'  THEN 'Y' ELSE 'N' END
        --,audSalaryChange = max(CASE  WHEN  audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END)

    INTO dbo.U_EBENEXDEMO_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBENEXDEMO_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(D, -60, @EndDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBENEXDEMO_Audit ON dbo.U_EBENEXDEMO_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EBENEXDEMO_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBENEXDEMO_Audit WHERE audEEID = xEEID AND audRowNo = 1);


-----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EBENEXDEMO_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXDEMO_PEarHist;
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
    INTO dbo.U_EBENEXDEMO_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON PehEarnCode = ErnEarncode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl between @StartYearPerControl and  @EndPerControl 
    and PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    -----------------------------
    -- Working Table - PEarHist12Mth
    -----------------------------
    IF OBJECT_ID('U_EBENACAEXP_PEarHist_52_P','U') IS NOT NULL
        DROP TABLE dbo.U_EBENACAEXP_PEarHist_52_P;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PehCurHrsMiscErn        = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @EndPercontrol and PehInclInMiscEarn4 = 'Y' THEN PehCurHrs ELSE 0.00 END)  --SUM(CASE WHEN PehInclInMiscEarn4 = 'Y' THEN PehCurHrs ELSE 0.00 END)  
    INTO dbo.U_EBENACAEXP_PEarHist_52_P
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE  PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @EndPercontrol
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    
    -- IF OBJECT_ID('U_EBENEXDEMO_PEarHist12Mth','U') IS NOT NULL
 --       DROP TABLE dbo.U_EBENEXDEMO_PEarHist12Mth;
 --   SELECT DISTINCT
 --        PehEEID
 --       ,PrgPayDate             = MAX(PrgPayDate)
    --    ,PehCurHrsMiscErn        = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @EndPercontrol and PehInclInMiscEarn4 = 'Y' THEN PehCurHrs ELSE 0.00 END)  --SUM(CASE WHEN PehInclInMiscEarn4 = 'Y' THEN PehCurHrs ELSE 0.00 END)     
 --   INTO dbo.U_EBENEXDEMO_PEarHist12Mth
 --   FROM dbo.vw_int_PayReg WITH (NOLOCK)
 --   JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
 --       ON PehGenNumber = PrgGenNumber
    --JOIN dbo.EarnCode WITH (NOLOCK)
    --    ON PehEarnCode = ErnEarncode
 --   WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
 --   AND PehPerControl between CONCAT((CONVERT(VARCHAR, DATEADD(M, -12,@EndDate), 112)),'1') and  @EndPerControl 
 --   --AND PehPerControl between @StartYearPerControl and  @EndPerControl 
 --   and PehPerControl <= @EndPerControl
 --   GROUP BY PehEEID
 --   HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBENEXDEMO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBENEXDEMO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBENEXDEMO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSocialSecurityNumber = EMPP.EepSSN
        ,drvPayrollKey = EMPC.Eecempno
        ,drvEmployeeID = EMPC.EecEmpNo
        --,drvLastName = (SELECT CONVERT(nvarchar, EepNameLast) COLLATE SQL_Latin1_General_Cp1251_CS_AS  from Emppers where eepeeid = xEEID) --CONVERT(varchar, EMPP.EepNameLast) COLLATE SQL_Latin1_General_Cp1251_CS_AS 
        --,drvFirstName =  (SELECT CONVERT(nvarchar, EepNameFirst) COLLATE SQL_Latin1_General_Cp1251_CS_AS from Emppers where eepeeid = xEEID)--CONVERT(varchar, EMPP.EepNameFirst) COLLATE SQL_Latin1_General_Cp1251_CS_AS

        ,drvLastName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EMPP.EepNameLast, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u') --CONVERT(NVARCHAR,EMPP.EepNameLast)
        ,drvFirstName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EMPP.EepNameFirst, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u') --CONVERT(NVARCHAR,EMPP.EepNameFirst)

        --,drvLastName = CONVERT(nvarchar, EMPP.EepNameLast) COLLATE SQL_Latin1_General_Cp1_CS_AS 
        --,drvFirstName =  CONVERT(nvarchar, EMPP.EepNameFirst) COLLATE SQL_Latin1_General_Cp1_CS_AS


        ,drvMiddleName = EMPP.EepNameMiddle
        ,drvSuffix = EMPP.EepNameSuffix
        ,drvAddress1 = [dbo].[fn_AddDoubleQuotes](EMPP.EepAddressLine1)
        ,drvAddress2 = [dbo].[fn_AddDoubleQuotes](EMPP.EepAddressLine2)
        ,drvCity = [dbo].[fn_AddDoubleQuotes](EMPP.EepAddressCity) 
        ,drvState = EMPP.EepAddressState
        ,drvWorkState = LocAddressState
        ,drvProvince = '' -- leave blank
        ,drvCountryMailingAddress = 'USA'
        ,drvCountryofCitizenship = '' -- leave blank
        ,drvCountryofEmployment = '' -- leave blank
        ,drvHomeZipCode = EMPP.EepAddressZipCode
        ,drvWorkZipCode = LocAddresszipcode
        ,drvHomePhone = EMPP.EepPhoneHomeNumber
        ,drvWorkPhone = EMPC.EecPhoneBusinessNumber
        ,drvHomeEmail = EMPP.EepAddressEMailAlternate
        ,drvWorkEmail = CASE WHEN EMPP.EepAddressEMail = ''  or EMPP.EepAddressEmail is null THEN EMPP.EepAddressEMailAlternate ELSE EMPP.EepAddressEMail END
        ,drvGender = EMPP.EepGender
        ,drvBirthDate = EMPP.EepDateOfBirth
        ,drvMaritalStatus = CASE EMPP.EepMaritalStatus WHEN 'Z' THEN '' ELSE EMPP.EepMaritalStatus END
        ,drvMarriedtoAnotherEmployee = '' --leave blank
        ,drvSpouseSSN = '' --leave blank
        ,drvEmploymentStatus = CASE WHEN EMPC.EecEmplStatus = 'L' THEN 'LEAVE' 
                                    WHEN EMPC.EecEmplStatus = 'T' THEN 'TERM'
                                ELSE 'ACTIVE'
                               END
        ,drvEmploymentStatusDate = CASE 
                                        WHEN EMPC.Eecemplstatus = 'T' THEN EMPC.Eecdateoftermination
                                        WHEN EMPC.Eecemplstatus = 'L' THEN EMPC.EecEmplStatusStartDate
                                    ELSE
                                        CASE WHEN  audStat.audEmpStatusStartChanged = 'Y' THEN EMPC.EecEmplStatusStartDate ELSE NULL
                                        END
                                    END--CASE WHEN  audStat.audEmpStatusStartChanged = 'Y' THEN EMPC.EecEmplStatusStartDate ELSE NULL END -- TODO ecEmplStatusStartDate changed since last file, then send EecEmplStatusStartDate else leave blank
        ,drvEmpStatusChangeReason = CASE WHEN EMPC.EecEmplstatus = 'L' THEN EMPC.EecLeaveReason END
        ,drvDateofOriginalHire = EMPC.EecDateOfOriginalHire


        ,drvDateofReHire = CASE WHEN audJob.audjobReason100 = 'Y' AND Employee_DateOfAcquisition IS NOT NULL AND Employee_DateOfAcquisition BETWEEN @StartDate AND @EndDate THEN EecDateOfLastHire ELSE EMPC.EecDateOfBenefitSeniority END
        
        
        ,drvDateofLeave = CASE WHEN EMPC.Eecemplstatus = 'L' THEN EMPC.EecEmplStatusStartDate ELSE NULL END
        ,drvDateofTermination = CASE WHEN EMPC.EecEmplStatus = 'T' THEN EMPC.EecDateOfTermination ELSE NULL END
        ,drvTerminationReason = CASE WHEN EMPC.EecEmplStatus = 'T' THEN TchDesc END
        ,drvDateofRetirement = CASE WHEN  EMPC.Eecemplstatus = 'T' and EMPC.Eectermreason = '202' THEN EMPC.Eecdateoftermination ELSE NULL END
        ,drvMedicareEligibleFlag = '' -- leave blank
        ,drvMedicareEligibleDate = '' -- leave blank
        ,drvBenefitEligibleDate = '' -- leave blank
        ,drvLocationIDChangeDate = CASE WHEN audLoc.audLocationChanged = 'Y' THEN audLoc.audDateTime ELSE NULL END --Most recent audit date of eeclocation
        ,drvSalaryChangeDate =  dbo.dsi_fnGetMinMaxDates('MAX', dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EMPC.EecEEID, EMPC.EecCOID, GETDATE(),EecDateOfLastHire)     , CONVERT(DATETIME,CONCAT(YEAR(GETDATE()), '-01','-01')))  --CONVERT(DATETIME,CONCAT(YEAR(GETDATE()), '-01','-01')) --[dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate](xEEID, xCOID, @StartDate, EMPC.EecDateOfLastHire)
        ,drvUserDate4 = Employee_DateOfTempToHire
        ,drvUserDate5 = Employee_DateOfAcquisition
        ,drvEIN = CmpFedTaxID
        ,drvCompanyCode1 = '' -- leave blank --CmpCompanyName
        ,drvDepartmentCode1 = '' -- leave blank
        ,drvBranchCode = '' -- leave blank
        ,drvDivisionCode = '' -- leave blank
        ,drvLocationCode = CASE WHEN LEFT(EMPC.Eeclocation,2) = 'HB' THEN 'HB' else  EMPC.Eeclocation END
        ,drvPositionCode = EMPC.EecEEType
        ,drvJobTitle =  dbo.fn_AddDoubleQuotes(JbcDesc)
        ,drvOrgLevel1 = '' --leave blank
        ,drvDirectBillFlag = '' -- leave blank
        ,drvCompanyCode2 = CmpCompanyCode
        ,drvDepartmentCode2 =  dbo.fn_AddDoubleQuotes(OrgDesc)
        ,drvOrgLevel5 = NciEmailAddress 
                            --(SELECT top 1 EepAddressEmail from dbo.empcomp WITH (NOLOCK)
       --                         JOIN dbo.Emppers WITH (NOLOCK) on eeceeid = eepeeid
       --                         JOIN dbo.Codes WITH (NOLOCK)
       --                             ON EecLocation = CodCode
       --                             AND codtable = 'CO_HRMANAGERBYLOCATI'
       --                             AND CodDesc = EecEmpNo WHERE eecLocation = EMPC.EecLocation) 
                                    --SUPP.EepAddressEMail --dbo.dsi_fnlib_GetSupervisorField(EMPC.EecCoid, EMPC.EecEEID, 'AddressEMail')   --eepaddressemail from EecSupervisorID
        ,drvWorkBasis = EMPC.EecFullTimeOrPartTime
        ,drvHourlySalaried = EMPC.EecSalaryOrHourly
        ,drvExemptFlag = '' -- Leave blank
        ,drvUnionFlag = '' -- leave blank
        ,drvUnionLocalNumber = CASE WHEN EMPC.EecUnionLocal IN ('N','') THEN 'N' ELSE EMPC.EecUnionLocal END
        ,drvScheduledHours = CONVERT(VARCHAR,CONVERT(DECIMAL(10,2),EMPC.EecScheduledWorkHrs))
        ,drvPayPeriodsPerAnnum = CASE EMPC.EecPayPeriod WHEN 'W' THEN '52' WHEN 'B' THEN '26' END
        ,drvFlexPayPeriods = CASE EMPC.EecPayPeriod WHEN 'W' THEN '52' WHEN 'B' THEN '26' END
        ,drvPayrollSchedule = EMPC.EecPaygroup
        ,drvPayRate = CONVERT(VARCHAR,convert(money,EMPC.EecHourlyPayRate))
        ,drvPayRateFrequency = EMPC.EecPayPeriod
        ,drvAnnualSalary = CONVERT(VARCHAR, CONVERT(MONEY,EMPC.Eecannsalary))
        ,drvFrozenSalary = '' -- leave blank
        ,drvJanuary1Earnings = '' -- leave blank
        ,drvMoneyField1 = '' -- leave blank
        ,drvMoneyField2 = '' -- leave blank
        ,drvMoneyField3 = '' -- leave blank
        ,drvMoneyField4 = '' -- leave blank
        ,drvMoneyField5 = '' -- leave blank
        ,drvWorkersCompensationGroup = '' -- leave blank
        ,drvNumeric1 = CASE WHEN Employee_DateOfTempToHire is not NULL and DATEADD(M, -12, Employee_DateOfTempToHire) < DATEADD(M, -12, GETDATE()) 
                            OR  Employee_DateOfAcquisition  is not NULL and  DATEADD(M, -12, Employee_DateOfAcquisition) < DATEADD(M, -12, GETDATE()) THEN CONVERT(VARCHAR, CONVERT(MONEY, PehCurHrsMiscErn) + CONVERT(MONEY,Employment_DecemberHoursWorked))        
                            ELSE CONVERT(VARCHAR,(CONVERT(MONEY, PehCurHrsMiscErn))) 
                       END
                       --ISNULL(CAST(CONVERT(INT,PehCurHrsYTD) as VARCHAR(7)),'0') 
                       --(SELECT top 1 efoPhoneNumber from EmpMPhon where efoEEID =xEEID and efoPhoneType = 'CEL') --if efoPhoneType is CEL, send efoPhoneNumber from table EmpMPhon
        ,drvNumeric2 = '' -- leave blank
        ,drvNumeric3 = '' -- leave blank
        ,drvNumeric4 = '' -- leave blank
        ,drvNumeric5 = '' -- leave blank
        ,drvNVarChar1 =    NciNameFirst + ' ' + NciNameLast
        ,drvNVarChar2 = NciEmpNo  
        ,drvNVarChar3 = NcaNameFirst + ' ' + NcaNameLast 
        ,drvNVarChar4 = NcaEmpNo 
        ,drvNVarChar5 = '' /*(SELECT top 1 eepAddressEmail from dbo.empcomp WITH (NOLOCK)
                                JOIN dbo.Emppers WITH (NOLOCK) on eeceeid = eepeeid
                                JOIN dbo.Codes WITH (NOLOCK)
                                    ON EecLocation = CodCode
                                    AND codtable = 'CO_HRASSISTANTBYLOCA'
                                    AND CodDesc = EecEmpNo WHERE eecLocation = EMPC.EecLocation) --SUPP.EepAddressEMail --EepEmailAddress where EecSupervisorID = EecEEID where CodDesc FROM dbo.Codes = EecEmpNo AND codCode FROM dbo.Codes = EecLocation where codTable = 'CO_HRMANAGERBYLOCATI' see coding used in export EMSHEDEMXP*/
        ,drvLanguagePreference = '' -- leave blank
    INTO dbo.U_EBENEXDEMO_drvTbl
    FROM dbo.U_EBENEXDEMO_EEList WITH (NOLOCK)
    --JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
    --    ON EecEEID = xEEID 
    --    AND EecCoID = xCoID
    JOIN dbo.vw_int_EmpComp EMPC WITH (NOLOCK)
        ON EMPC.EecEEID = xEEID 
        AND EMPC.EecCoID = xCoID and EecEEtype <> 'TES'
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers EMPP WITH (NOLOCK)
        ON EMPP.EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EMPC.EecJobCode
    JOIN dbo.Location WITH (NOLOCK) 
        on LocCode = EecLocation and LocAddressCountry <> 'CAN' 
    LEFT JOIN dbo.TrmReasn with (nolock)
        on tchCode = EecTermReason
    --JOIN dbo.vw_int_EmpComp SUPC WITH (NOLOCK)
    --    ON SUPC.EecEEID = EMPC.EecSupervisorId
    --    AND SUPC.EecCOID = xCOID
    JOIN dbo.EmpPers SUPP WITH (NOLOCK)
        ON SUPP.EepEEID = EMPC.EecSupervisorId
    LEFT JOIN dbo.Codes WITH (NOLOCK)
        ON EMPC.EecLocation = CodCode
        AND codtable IN ('CO_HRMANAGERBYLOCATI', 'CO_HRASSISTANTBYLOCA')
    LEFT JOIN dbo.U_EBENEXDEMO_Audit audStat with (nolock)
        ON audeeid = xEEID and audKey2 = xCOID and  audEmpStatusStartChanged = 'Y' and audStat.audRowNo = 1
    LEFT JOIN dbo.U_EBENEXDEMO_Audit audLoc with (nolock)
        ON audLoc.audeeid = xEEID and audLoc.audKey2 = xCOID and  audLoc.audLocationChanged = 'Y' and audLoc.audRowNo = 1
    LEFT JOIN dbo.U_EBENEXDEMO_Audit audJob with (nolock)
        ON audJob.audeeid = xEEID and audJob.audKey2 = xCOID and  audJob.audjobReason100 = 'Y' and audJob.audRowNo = 1
    LEFT JOIN dbo.OrgLevel WITH (NOLOCK)
        ON OrgCode = EMPC.EecOrgLvl1 and OrgLvl = 1
    LEFT JOIN dbo.fn_MP_CustomFields_EmpPers_Export (NULL,NULL,NULL,NULL) pcfEmppers
        ON pcfEmppers.EEID = xEEID
    LEFT JOIN dbo.fn_MP_CustomFields_EmpComp_Export (NULL,NULL,NULL,NULL) pcfEmpComp
        ON pcfEmpComp.EecEEID = xEEID    and pcfEmpComp.EecCOID = xCOID
    LEFT JOIN dbo.U_EBENACAEXP_PEarHist_52_P WITH (NOLOCK)
        ON pehEEID = xEEID
    LEFT JOIN (
                SELECT EepNameLast AS NciNameLast, EepNameFirst AS NciNameFirst, EecEmpNo AS NciEmpNo, EepAddressEmail AS NciEmailAddress, CodCode AS NciLocationCode 
                FROM dbo.EmpComp WITH (NOLOCK)    
                    JOIN dbo.EmpPers WITH (NOLOCK)
                        ON EecEEID = EepEEID        
                    JOIN dbo.Codes WITH (NOLOCK)
                        ON CodDesc = EecEmpNo
                WHERE CodTable = 'CO_HRMANAGERBYLOCATI') AS HRI
                        ON NciLocationCode = EMPC.EecLocation

    LEFT JOIN (
                SELECT EepNameLast AS NcaNameLast, EepNameFirst AS NcaNameFirst, EecEmpNo AS NcaEmpNo, CodCode AS NcaLocationCode 
                FROM dbo.EmpComp WITH (NOLOCK)    
                    JOIN dbo.EmpPers WITH (NOLOCK)
                        ON EecEEID = EepEEID        
                    JOIN dbo.Codes WITH (NOLOCK)
                        ON CodDesc = EecEmpNo
                WHERE CodTable = 'CO_HRASSISTANTBYLOCA') AS HRA
                        ON NcaLocationCode = EMPC.EecLocation
    --AND CodCode = 'DPOC' -- replace with rows EecLoaction



     WHERE 
           EMPC.EecEmplStatus in ('A', 'L')  
           OR EMPC.EecEmplStatus in ('T') and EMPC.EecTermReason <> 'TRO' AND EMPC.EecDateOfTermination between (DATEADD( D,-60, @enddate)) and @enddate
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.REFRESCO.OG.CEN.csv '
                                  ELSE '' + CONVERT(VARCHAR(8),GETDATE(),112) + '.REFRESCO.OG.CEN.csv '
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEBENEXDEMO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBENEXDEMO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBENEXDEMO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202102261'
       ,expStartPerControl     = '202102261'
       ,expLastEndPerControl   = '202103059'
       ,expEndPerControl       = '202103059'
WHERE expFormatCode = 'EBENEXDEMO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBENEXDEMO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBENEXDEMO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort