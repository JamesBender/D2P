SET NOCOUNT ON;
IF OBJECT_ID('U_ELINCTT2LC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINCTT2LC_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELINCTT2LC_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELINCTT2LC' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELINCTT2LC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELINCTT2LC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELINCTT2LC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINCTT2LC];
GO
IF OBJECT_ID('U_ELINCTT2LC_File') IS NOT NULL DROP TABLE [dbo].[U_ELINCTT2LC_File];
GO
IF OBJECT_ID('U_ELINCTT2LC_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELINCTT2LC_EEList];
GO
IF OBJECT_ID('U_ELINCTT2LC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELINCTT2LC_drvTbl];
GO
IF OBJECT_ID('U_ELINCTT2LC_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELINCTT2LC_AuditFields];
GO
IF OBJECT_ID('U_ELINCTT2LC_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELINCTT2LC_Audit];
GO
IF OBJECT_ID('U_ds_ELINCTT2LC_EarnsYTD') IS NOT NULL DROP TABLE [dbo].[U_ds_ELINCTT2LC_EarnsYTD];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELINCTT2LC';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELINCTT2LC';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELINCTT2LC';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELINCTT2LC';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELINCTT2LC';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELINCTT2LC','Lincoln LFG Claims Elig (V2)','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','ELINCTT2LCZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','1','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. First Name"','2','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Last Name"','3','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Middle Initial"','4','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. SSN"','5','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','5',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Gender"','6','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. DOB"','7','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','7',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation"','8','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','8',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Per Week"','9','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Amt"','10','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Code"','11','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','11',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sal Eff Date"','12','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Addr 1"','13','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','13',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. City"','14','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. State"','15','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','15',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Zip Code"','16','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','16',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Zip Plus 4"','17','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','18','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','19','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','19',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Ext"','20','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','20',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire"','21','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','21',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp Work State"','22','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','22',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','23','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','23',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','24','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','24',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','25','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Flag"','26','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','26',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Exempt Flag"','27','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health Plan Date"','28','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','28',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLife Eff Date"','29','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','29',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLife Plan Code"','30','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','30',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Class Code"','31','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','31',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Cvg Amount"','32','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','32',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Name"','33','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','33',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Type"','34','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Percent"','35','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Relationship"','36','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Date of Birth"','37','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary SSN','38','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Address"','39','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','39',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Name"','40','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','40',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Type"','41','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','41',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Percent"','42','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','42',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Relationship"','43','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','43',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Date of Birth"','44','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','44',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary SSN','45','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','45',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Address"','46','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','46',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Name"','47','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','47',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Type"','48','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','48',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Percent"','49','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','49',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Relationship"','50','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','50',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Date of Birth"','51','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','51',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary SSN','52','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','52',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Address"','53','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','53',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Name"','54','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','54',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Type"','55','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','55',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Percent"','56','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','56',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Relationship"','57','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','57',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Date of Birth"','58','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','58',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary SSN','59','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','59',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BLIFE Beneficiary Address"','60','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','60',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Eff Date"','61','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','61',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Plan Code"','62','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','62',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Class Code"','63','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','63',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Cvg Amount"','64','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','64',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Name"','65','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','65',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Type"','66','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','66',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Percent"','67','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','67',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Relationship"','68','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','68',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Date of Birth"','69','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','69',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary SSN','70','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','70',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Address"','71','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','71',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Name"','72','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','72',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Type"','73','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','73',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Percent"','74','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','74',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Relationship"','75','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','75',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Date of Birth"','76','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','76',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary SSN','77','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','77',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Address"','78','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','78',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Name"','79','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Type"','80','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','80',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Percent"','81','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','81',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Relationship"','82','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','82',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Date of Birth"','83','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','83',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary SSN','84','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','84',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Address"','85','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','85',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Name"','86','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','86',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Type"','87','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','87',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Percent"','88','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','88',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Relationship"','89','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','89',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Date of Birth"','90','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','90',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary SSN','91','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','91',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD Beneficiary Address"','92','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','92',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eff Date"','93','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','93',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Plan Code"','94','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','94',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Class Code"','95','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','95',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Cvg Amount"','96','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','96',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Eff Date"','97','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','97',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Plan Code"','98','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','98',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Class Code"','99','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','99',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Cvg Amount"','100','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','100',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Option"','101','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Name"','102','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','102',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Type"','103','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','103',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Percent"','104','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','104',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Relationship"','105','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','105',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Date of Birth"','106','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','106',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary SSN','107','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','107',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Address"','108','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','108',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Name"','109','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','109',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Type"','110','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','110',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Percent"','111','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','112',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Relationship"','112','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','113',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Date of Birth"','113','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','114',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary SSN','114','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','114',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Address"','115','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','115',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Name"','116','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','116',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Type"','117','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','117',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Percent"','118','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','118',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Relationship"','119','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','119',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Date of Birth"','120','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','120',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary SSN','121','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','121',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Address"','122','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','122',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Name"','123','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','124',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Type"','124','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','124',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Percent"','125','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','125',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Relationship"','126','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','126',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Date of Birth"','127','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','127',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary SSN','128','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','128',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VELIF Beneficiary Address"','129','(''DA''=''T,'')','ELINCTT2LCZ0','118','H','01','129',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLIF Eff Date"','130','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','130',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLIF Plan Code"','131','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','131',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLIF Class Code"','132','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','132',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSLIF Cvg Amount"','133','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','133',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLIF Eff Date"','134','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','134',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLIF Plan Code"','135','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','135',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLIF Class Code"','136','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','136',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VCLIF Cvg Amount"','137','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','137',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSTD Eff Date"','138','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','138',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSTD Plan Code"','139','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','139',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSTD Class Code"','140','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','140',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSTD Cvg Amount"','141','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','141',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSTD Elim Period"','142','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','142',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASO Indicator Y/N"','143','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','143',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*Claim Location Number"','144','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','144',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*Claim Location Name"','145','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','145',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*Billing Location Number"','146','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','146',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*Billing Location Name"','147','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','147',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse First Name"','148','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','148',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Last Name"','149','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','149',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Middle Initial"','150','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','1450',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse DOB"','151','(''DA''=''T,'')','ELINCTT2LCZ0','50','H','01','151',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Life coverage"','152','(''DA''=''T'')','ELINCTT2LCZ0','50','H','01','152',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','1','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','1',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','2',NULL,'Emp. First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','3',NULL,'Emp. Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','4','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','4',NULL,'Emp. Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','5',NULL,'Emp. SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','6','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','6',NULL,'Emp. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','7','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','7',NULL,'Emp. DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupation"','8','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','8',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsPerWeek"','9','(''UNT2''=''T,'')','ELINCTT2LCZ0','50','D','10','9',NULL,'Hrs Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt"','10','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','10',NULL,'Salary Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryCode"','11','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','11',NULL,'Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryEffDate"','12','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','12',NULL,'Sal Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine"','13','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','13',NULL,'Emp. Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','14',NULL,'Emp. City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','15',NULL,'Emp. State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip5"','16','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','16',NULL,'Emp. Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip4"','17','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','17',NULL,'Emp. Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','18','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','18',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','19','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','19',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','20','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','20',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','21','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','21',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','22','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','22',NULL,'Emp Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','23','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','23',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','24','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','24',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','25','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','25',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionFlag"','26','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptFlag"','27','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthPlanDate"','28','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeEffDate"','29','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','26',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlanCode"','30','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeClassCode"','31','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','28',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeCvgAmount"','32','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','29',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeName1"','33','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','33',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeType1"','34','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifePercent1"','35','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeRel1"','36','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeDob1"','37','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeSSN1','38','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeAddress1"','39','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','39',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeName2"','40','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','40',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeType2"','41','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','41',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifePercent2"','42','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','42',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeRel2"','43','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','43',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeDob2"','44','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','44',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeSSN2','45','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','45',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeAddress2"','46','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','46',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeName3"','47','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','47',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeType3"','48','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','48',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifePercent3"','49','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','49',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeRel3"','50','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','50',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeDob3"','51','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','51',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeSSN3','52','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','52',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeAddress3"','53','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','53',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeName4"','54','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','54',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeType4"','55','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','55',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifePercent4"','56','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','56',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeRel4"','57','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','57',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeDob4"','58','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','58',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeSSN4','59','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','59',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenLifeAddress4"','60','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','60',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddEffDate"','61','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','61',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddPlanCode"','62','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','62',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDClassCode"','63','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','63',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDCvgAmount"','64','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','64',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenName1"','65','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','65',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenType1"','66','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','66',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenPercent1"','67','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','67',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenRel1"','68','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','68',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenDob1"','69','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','69',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenSSN1','70','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','70',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenAddress1"','71','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','71',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenName2"','72','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','72',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenType2"','73','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','73',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenPercent2"','74','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','74',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenRel2"','75','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','75',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenDob2"','76','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','76',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenSSN2','77','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','77',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenAddress2"','78','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','78',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenName3"','79','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenType3"','80','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','80',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenPercent3"','81','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','81',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenRel3"','82','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','82',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenDob3"','83','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','83',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenSSN3','84','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','84',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenAddress3"','85','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','85',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenName4"','86','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','86',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenType4"','87','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','87',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenPercent4"','88','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','88',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenRel4"','89','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','89',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenDob4"','90','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','90',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenSSN4','91','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','91',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddBenAddress4"','92','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','92',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEffDate"','93','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDPlanCode"','94','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDClassCode"','95','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDCvgAmount"','96','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFEffDate"','97','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFPlanCode"','98','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFClassCode"','99','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFCvgAmount"','100','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFVADDOption"','101','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeName1"','102','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','102',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeType1"','103','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','103',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifePercent1"','104','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','104',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeRel1"','105','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','105',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeDob1"','106','(''UD101''=''T,'')','ELINCTT2LCZ0','119','D','10','106',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeSSN1','107','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','107',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeAddress1"','108','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','108',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeName2"','109','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','109',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeType2"','110','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','110',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifePercent2"','111','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','111',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeRel2"','112','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','112',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeDob2"','113','(''UD101''=''T,'')','ELINCTT2LCZ0','119','D','10','113',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeSSN2','114','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','114',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeAddress2"','115','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','115',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeName3"','116','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','116',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeType3"','117','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','117',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifePercent3"','118','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','118',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeRel3"','119','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','119',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeDob3"','120','(''UD101''=''T,'')','ELINCTT2LCZ0','119','D','10','120',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeSSN3','121','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','121',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeAddress3"','122','(''UA''=''Q,'')','ELINCTT2LCZ0','100','D','10','122',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeName4"','123','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','123',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeType4"','124','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','124',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifePercent4"','125','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','125',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeRel4"','126','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','126',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeDob4"','127','(''UD101''=''T,'')','ELINCTT2LCZ0','119','D','10','127',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeSSN4','128','(''UA''=''T,'')','ELINCTT2LCZ0','119','D','10','128',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVELIFLifeAddress4"','129','(''UA''=''T,'')','ELINCTT2LCZ0','100','D','10','129',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSLIFEffDate"','130','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','130',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSLIFPlanCode"','131','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','131',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSLIFClassCode"','132','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','132',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSLIFCvgAmount"','133','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','133',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVCLIFEffDate"','134','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','134',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVCLIFPlanCode"','135','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','135',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVCLIFClassCode"','136','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','136',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVCLIFCvgAmount"','137','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','137',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSTDEffDate"','138','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','138',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSTDPlanCode"','139','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','139',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSTDClassCode"','140','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','140',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSTDCvgAmount"','141','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','141',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSTDElimPeriod"','142','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','142',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASOIndicator"','143','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','143',NULL,'ASO Indicator Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClaimLocNum"','144','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','144',NULL,'*Claim Location Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClaimLocName"','145','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','145',NULL,'*Claim Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingLocNum"','146','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','146',NULL,'*Billing Location Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingLocName"','147','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','147',NULL,'*Billing Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseFName"','148','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','148',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLName"','149','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','149',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseMI"','150','(''UA''=''T,'')','ELINCTT2LCZ0','50','D','10','150',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDOB"','151','(''UD101''=''T,'')','ELINCTT2LCZ0','50','D','10','151',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifeCov"','152','(''UA''=''T'')','ELINCTT2LCZ0','50','D','10','152',NULL,NULL,NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINCTT2LC_20200529.txt',NULL,'','',',UEVML',NULL,NULL,NULL,'Lincoln LFG Claims Elig','201808159','EMPEXPORT','ONDEMAND',NULL,'ELINCTT2LC',NULL,NULL,NULL,'202003039','Mar 14 2018 11:29AM','Mar 14 2018 11:29AM','202002181',NULL,'','','201808021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINCTT2LC_20200529.txt',NULL,NULL,NULL,',DRVFS',NULL,NULL,NULL,'Scheduled Session','201805189','EMPEXPORT','SCHED_TTLC',NULL,'ELINCTT2LC',NULL,NULL,NULL,'201805189','Mar 14 2018 11:29AM','Mar 14 2018 11:29AM','201805041',NULL,'','','201805041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINCTT2LC_20200529.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201803149','EMPEXPORT','OEACTIVE',NULL,'ELINCTT2LC',NULL,NULL,NULL,'201803149','Mar 14 2018 11:29AM','Mar 14 2018 11:29AM','201803141',NULL,'','','201803141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINCTT2LC_20200529.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201803149','EMPEXPORT','OEPASSIVE',NULL,'ELINCTT2LC',NULL,NULL,NULL,'201803149','Mar 14 2018 11:29AM','Mar 14 2018 11:29AM','201803141',NULL,'','','201803141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINCTT2LC_20200529.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202003101','EMPEXPORT','TEST','Mar 11 2020  9:58AM','ELINCTT2LC',NULL,NULL,NULL,'202003101','Mar 10 2020 12:00AM','Dec 30 1899 12:00AM','202001011','1526','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3mLaTIL1001',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELINCTT2LC_20200529.txt' END WHERE expFormatCode = 'ELINCTT2LC';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCTT2LC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCTT2LC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCTT2LC','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCTT2LC','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELINCTT2LC' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELINCTT2LC' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELINCTT2LC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINCTT2LC_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINCTT2LC','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINCTT2LC','D10','dbo.U_ELINCTT2LC_drvTbl',NULL);
IF OBJECT_ID('U_ds_ELINCTT2LC_EarnsYTD') IS NULL
CREATE TABLE [dbo].[U_ds_ELINCTT2LC_EarnsYTD] (
    [eeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [Box1] money NULL
);
IF OBJECT_ID('U_ELINCTT2LC_Audit') IS NULL
CREATE TABLE [dbo].[U_ELINCTT2LC_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ELINCTT2LC_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELINCTT2LC_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ELINCTT2LC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELINCTT2LC_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvTermDate] datetime NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvSSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvOccupation] varchar(8000) NULL,
    [drvHrsPerWeek] varchar(30) NULL,
    [drvSalaryAmt] money NULL,
    [drvSalaryCode] varchar(1) NOT NULL,
    [drvSalaryEffDate] varchar(1) NOT NULL,
    [drvAddressLine] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip5] varchar(5) NULL,
    [drvAddressZip4] varchar(1) NOT NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvWorkPhoneExt] varchar(1) NOT NULL,
    [drvDateOfHire] datetime NULL,
    [drvWorkState] varchar(1) NOT NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvRehireDate] datetime NULL,
    [drvEmail] varchar(50) NULL,
    [drvUnionFlag] varchar(1) NOT NULL,
    [drvExemptFlag] varchar(1) NOT NULL,
    [drvHealthPlanDate] varchar(1) NOT NULL,
    [drvLifeEffDate] datetime NULL,
    [drvLifePlanCode] varchar(1) NOT NULL,
    [drvLifeClassCode] varchar(1) NULL,
    [drvLifeCvgAmount] varchar(30) NULL,
    [drvBenLifeName1] varchar(201) NULL,
    [drvBenLifeType1] char(1) NULL,
    [drvBenLifePercent1] varchar(12) NULL,
    [drvBenLifeRel1] char(3) NULL,
    [drvBenLifeDob1] datetime NULL,
    [drvBenLifeSSN1] char(11) NULL,
    [drvBenLifeAddress1] varchar(6000) NULL,
    [drvBenLifeName2] varchar(201) NULL,
    [drvBenLifeType2] char(1) NULL,
    [drvBenLifePercent2] varchar(12) NULL,
    [drvBenLifeRel2] char(3) NULL,
    [drvBenLifeDob2] datetime NULL,
    [drvBenLifeSSN2] char(11) NULL,
    [drvBenLifeAddress2] varchar(6000) NULL,
    [drvBenLifeName3] varchar(201) NULL,
    [drvBenLifeType3] char(1) NULL,
    [drvBenLifePercent3] varchar(12) NULL,
    [drvBenLifeRel3] char(3) NULL,
    [drvBenLifeDob3] datetime NULL,
    [drvBenLifeSSN3] char(11) NULL,
    [drvBenLifeAddress3] varchar(6000) NULL,
    [drvBenLifeName4] varchar(201) NULL,
    [drvBenLifeType4] char(1) NULL,
    [drvBenLifePercent4] varchar(12) NULL,
    [drvBenLifeRel4] char(3) NULL,
    [drvBenLifeDob4] datetime NULL,
    [drvBenLifeSSN4] char(11) NULL,
    [drvBenLifeAddress4] varchar(6000) NULL,
    [drvAddEffDate] datetime NULL,
    [drvAddPlanCode] varchar(1) NOT NULL,
    [drvADDClassCode] varchar(1) NULL,
    [drvADDCvgAmount] varchar(30) NULL,
    [drvAddBenName1] varchar(201) NULL,
    [drvAddBenType1] char(1) NULL,
    [drvAddBenPercent1] varchar(12) NULL,
    [drvAddBenRel1] char(3) NULL,
    [drvAddBenDob1] datetime NULL,
    [drvAddBenSSN1] char(11) NULL,
    [drvAddBenAddress1] varchar(6000) NULL,
    [drvAddBenName2] varchar(201) NULL,
    [drvAddBenType2] char(1) NULL,
    [drvAddBenPercent2] varchar(12) NULL,
    [drvAddBenRel2] char(3) NULL,
    [drvAddBenDob2] datetime NULL,
    [drvAddBenSSN2] char(11) NULL,
    [drvAddBenAddress2] varchar(6000) NULL,
    [drvAddBenName3] varchar(201) NULL,
    [drvAddBenType3] char(1) NULL,
    [drvAddBenPercent3] varchar(12) NULL,
    [drvAddBenRel3] char(3) NULL,
    [drvAddBenDob3] datetime NULL,
    [drvAddBenSSN3] char(11) NULL,
    [drvAddBenAddress3] varchar(6000) NULL,
    [drvAddBenName4] varchar(201) NULL,
    [drvAddBenType4] char(1) NULL,
    [drvAddBenPercent4] varchar(12) NULL,
    [drvAddBenRel4] char(3) NULL,
    [drvAddBenDob4] datetime NULL,
    [drvAddBenSSN4] char(11) NULL,
    [drvAddBenAddress4] varchar(6000) NULL,
    [drvLTDEffDate] datetime NULL,
    [drvLTDPlanCode] varchar(1) NOT NULL,
    [drvLTDClassCode] varchar(1) NULL,
    [drvLTDCvgAmount] varchar(30) NULL,
    [drvVLIFEffDate] datetime NULL,
    [drvVLIFPlanCode] varchar(1) NOT NULL,
    [drvVLIFClassCode] varchar(1) NULL,
    [drvVLIFCvgAmount] varchar(30) NULL,
    [drvVLIFVADDOption] varchar(30) NULL,
    [drvVELIFLifeName1] varchar(201) NULL,
    [drvVELIFLifeType1] char(1) NULL,
    [drvVELIFLifePercent1] varchar(12) NULL,
    [drvVELIFLifeRel1] char(3) NULL,
    [drvVELIFLifeDob1] datetime NULL,
    [drvVELIFLifeSSN1] char(11) NULL,
    [drvVELIFLifeAddress1] varchar(6000) NULL,
    [drvVELIFLifeName2] varchar(201) NULL,
    [drvVELIFLifeType2] char(1) NULL,
    [drvVELIFLifePercent2] varchar(22) NULL,
    [drvVELIFLifeRel2] char(3) NULL,
    [drvVELIFLifeDob2] datetime NULL,
    [drvVELIFLifeSSN2] char(11) NULL,
    [drvVELIFLifeAddress2] varchar(6000) NULL,
    [drvVELIFLifeName3] varchar(201) NULL,
    [drvVELIFLifeType3] char(1) NULL,
    [drvVELIFLifePercent3] varchar(33) NULL,
    [drvVELIFLifeRel3] char(3) NULL,
    [drvVELIFLifeDob3] datetime NULL,
    [drvVELIFLifeSSN3] char(11) NULL,
    [drvVELIFLifeAddress3] varchar(6000) NULL,
    [drvVELIFLifeName4] varchar(201) NULL,
    [drvVELIFLifeType4] char(1) NULL,
    [drvVELIFLifePercent4] varchar(44) NULL,
    [drvVELIFLifeRel4] char(3) NULL,
    [drvVELIFLifeDob4] datetime NULL,
    [drvVELIFLifeSSN4] char(11) NULL,
    [drvVELIFLifeAddress4] varchar(6000) NULL,
    [drvVSLIFEffDate] datetime NULL,
    [drvVSLIFPlanCode] varchar(1) NOT NULL,
    [drvVSLIFClassCode] varchar(1) NULL,
    [drvVSLIFCvgAmount] varchar(30) NULL,
    [drvVCLIFEffDate] datetime NULL,
    [drvVCLIFPlanCode] varchar(1) NOT NULL,
    [drvVCLIFClassCode] varchar(1) NULL,
    [drvVCLIFCvgAmount] varchar(30) NULL,
    [drvVSTDEffDate] datetime NULL,
    [drvVSTDPlanCode] varchar(1) NOT NULL,
    [drvVSTDClassCode] varchar(1) NULL,
    [drvVSTDCvgAmount] varchar(30) NULL,
    [drvVSTDElimPeriod] varchar(1) NOT NULL,
    [drvASOIndicator] varchar(1) NOT NULL,
    [drvClaimLocNum] varchar(7) NOT NULL,
    [drvClaimLocName] varchar(3) NOT NULL,
    [drvBillingLocNum] varchar(7) NOT NULL,
    [drvBillingLocName] varchar(3) NOT NULL,
    [drvSpouseFName] varchar(100) NULL,
    [drvSpouseLName] varchar(100) NULL,
    [drvSpouseMI] varchar(50) NULL,
    [drvSpouseDOB] varchar(40) NULL,
    [drvSpouseLifeCov] varchar(12) NULL
);
IF OBJECT_ID('U_ELINCTT2LC_EEList') IS NULL
CREATE TABLE [dbo].[U_ELINCTT2LC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELINCTT2LC_File') IS NULL
CREATE TABLE [dbo].[U_ELINCTT2LC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINCTT2LC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: The Tile Shop, LLC

Created By: Joseph Pham
Business Analyst: Jherilee Williams
Create Date: 5/23/2018
Service Request Number: SR-2017-00170574

Purpose: Lincoln LFG Claims Elig - This is either a general demographic file, or a portability file so that termed EEs who were covered
         can continue their LFG coverage without their employer's sponsorship.

Revision History
----------------
Update By           Date            Request Num            Desc
Sean Hawkins        04/19/2019        SR-2019-00235178    Updated for logic on ded groups and eecudfield09 for salary field
Sean Hawkins        04/29/2019                            New updates for LIFE/LTD amounts, calculcating instead of pulling
Sean Hawkins        06/06/2019                            Update for life, sal eff dates, STD fields, class codes
Sean Hawkins        06/12/2019                            Updates for amounts per testing
Sean Hawkins        06/13/2019                            Updates for part timers installed
Sean Hawkins        06/14/2019                            More updates per testing
Sean Hawkins        06/20/2019                            More updates to amounts per testing
Marco Lagrosa        03/10/2020                              More updated and sections to add

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELINCTT2LC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELINCTT2LC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELINCTT2LC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELINCTT2LC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELINCTT2LC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCTT2LC', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCTT2LC', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCTT2LC', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCTT2LC', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELINCTT2LC';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELINCTT2LC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELINCTT2LC';

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
    DELETE FROM dbo.U_ELINCTT2LC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELINCTT2LC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --Clean EE list for part-timers per request, 6/13/19:
    DELETE dbo.U_ELINCTT2LC_EEList 
    FROM dbo.U_ELINCTT2LC_EEList
    JOIN dbo.EmpComp WITH (NOLOCK) on eeceeid = xeeid and eeccoid = xcoid
    WHERE  eecfulltimeorparttime = 'P';
    


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ELINCTT2LC_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCTT2LC_AuditFields;
    CREATE TABLE dbo.U_ELINCTT2LC_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ELINCTT2LC_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCTT2LC_Audit;
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
    INTO dbo.U_ELINCTT2LC_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ELINCTT2LC_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELINCTT2LC_Audit ON dbo.U_ELINCTT2LC_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_ELINCTT2LC_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ELINCTT2LC_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','BLIFE,VLE,VLS,VLC,ADD,STD,LTDA,LTDE,LTDO,LTDP,ADD');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'ExclFutureDatedStartDates', 'Y')

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

    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --  Limit EEList to BDM only
    DELETE FROM dbo.U_ELINCTT2LC_EEList WHERE xEEID NOT IN (SELECT EedEEID FROM dbo.U_dsi_BDM_EmpDeductions WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y'); 

    --Remove Test employees
    DELETE  dbo.U_ELINCTT2LC_EEList 
    from dbo.U_ELINCTT2LC_EEList join emppers on eepeeid=xeeid where eepnamelast ='test'

    --Remove Termed employees
    DELETE  dbo.U_ELINCTT2LC_EEList 
    from dbo.U_ELINCTT2LC_EEList join empcomp on eeceeid=xeeid and eeccoid=xcoid where eecemplstatus='T'

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELINCTT2LC_drvTbl
    --select drvsalaryamt,drvlifecvgamount,drvltdcvgamount,drvVLIFCvgAmount,drvVSTDCvgAmount,drvSTADCvgs  from U_ELINCTT2LC_drvTbl where drveeid in ('BW9LCO02Q0K0','BW9LTO00O0K0','BW9M730000K0') 
    --sp_geteeid '206448'
    /*
    select eeceeid
    , eecdedgroupcode
    ,eecannsalary
    ,eecudfield09
    ,case when eecdedgroupcode in ('SLS','EXEC','OPS') then isnull(NULLIF(eecudfield09,0.00), eecannsalary)
    end
    ,CAST(CEILING(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/1000.0)*1000 as money)
    from empcomp 
    where eeceeid = 'BW9LCO02Q0K0'
    select floor((ceiling (42150) + 99) / 100) * 100
    select floor(42150), ceiling(42150)
    SELECT CEILING(33281.28/1000.0) * 1000
    CAST(CEILING(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/1000.0)*1000 as money)
    */

    ---------------------------------
    IF OBJECT_ID('U_ELINCTT2LC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCTT2LC_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvSSN = eepSSN
        ,drvGender = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvOccupation = REPLACE(JbcLongDesc,',','')
        ,drvHrsPerWeek = CONVERT(VARCHAR,CASE
                            WHEN EmpComp.EecPayPeriod = 'W' THEN EmpComp.EecScheduledWorkHrs
                            WHEN EmpComp.EecPayPeriod = 'B' THEN EmpComp.EecScheduledWorkHrs/2
                            WHEN EmpComp.EecPayPeriod = 'S' THEN EmpComp.EecScheduledWorkHrs*24/52
                            WHEN EmpComp.EecPayPeriod = 'M' THEN EmpComp.EecSCheduledWorkHrs*12/52
                        END)
/*
in the following three deduction groups, send the benefits salary value (eecudfield09). If the benefits salary is blank or 0, then send the annual salary. 
- Sales 
- Executives and Officers 
- Operations 

If in the following two deduction groups, send the annual salary value. 
- All Others Full Time 
- Senior Professionals 
*/
        ,drvSalaryAmt = case when @ExportCode = 'TEST' and eecdedgroupcode in ('SLS','EXEC','OPS') 
                                then(case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)-- isnull(NULLIF(eecudfield09,0.00), eecannsalary)
                                when @ExportCode = 'TEST' and eecdedgroupcode in ('FT','SRP') then eecannsalary 
                                    ELSE case 
                                        when eecAnnSalary = 0 then EECUDFIELD09 
                                        else eecAnnSalary 
                                        end        --10/29/18 ISNULL(EecAnnSalary,0)
                                end
        ,drvSalaryCode = 'A'
        ,drvSalaryEffDate = ''--ISNULL((SELECT MAX(EjhJobEffDate) FROM EmpHJob WHERE EjhEEID = xEEID AND EjhCOID = XCOID AND EjhIsRateChange = 'Y'),EecDateOfLastHire)
        ,drvAddressLine = REPLACE(RTRIM(EepAddressLine1) + ' ' + RTRIM(ISNULL(EepAddressLine2,'')),',','')
        ,drvAddressCity = REPLACE(EepAddressCity,',','')
        ,drvAddressState = EepAddressState
        ,drvAddressZip5 = LEFT(EepAddressZipCode,5)
        ,drvAddressZip4 = ''
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkPhoneExt = ''
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvWorkState = '' --EecWCState
        ,drvMaritalStatus = eepMaritalStatus
        ,drvRehireDate = EecDateOfLastHire
        ,drvEmail = EepAddressEMail
        ,drvUnionFlag = ''
        ,drvExemptFlag = ''
        ,drvHealthPlanDate = ''

        ,drvLifeEffDate = IIF(Life.EedEEID IS NOT NULL, Life.EedBenStartDate, NULL)
        ,drvLifePlanCode = IIF(Life.EedEEID IS NOT NULL,'1','')
        --select distinct eecdedgroupcode from empcomp
        --select * from bengrp
        ,drvLifeClassCode = CASE WHEN Life.EedEEID IS NOT NULL 
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            --ELSE '5'--all others
                            END--IIF(Life.EedEEID IS NOT NULL,'1','')
        ,drvLifeCvgAmount = case when @ExportCode = 'TEST' --set to 280000.00 max amount
                    and CAST(CEILING((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/1000.0)*1000 as money) >= 280000.00
                    then '280000.00'
                    
                    when @ExportCode = 'TEST' 
                    and CAST(CEILING((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/1000.0)*1000 as money) < 280000.00
                    then CAST(CAST(CEILING((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/1000.0)*1000 as money) as varchar)
                    
                    else NULL
                end
        /* Add new Section*/ 

        ,drvBenLifeName1 =  CASE WHEN BLIFEBEN.DepFirstName1 is not null then BLIFEBEN.DepFirstName1 + ' ' + BLIFEBEN.DepLastName1 END
        ,drvBenLifeType1 = BLIFEBEN.BfpBeneficiaryType1
        ,drvBenLifePercent1 =  CAST(BLIFEBEN.BfpPctToAlloc1 as Varchar(12))
        ,drvBenLifeRel1 =  BLIFEBEN.DepRelationship1
        ,drvBenLifeDob1 =   BLIFEBEN.DepDateOfBirth1
        ,drvBenLifeSSN1 =   BLIFEBEN.DepSSN1
        ,drvBenLifeAddress1 =  dbo.dsi_fnRemoveChars('.,/-',BLIFEBEN.FullAddress1)
        ,drvBenLifeName2 =  CASE WHEN BLIFEBEN.DepFirstName2 is not null then BLIFEBEN.DepFirstName2 + ' ' + BLIFEBEN.DepLastName2 END
        ,drvBenLifeType2 =  BLIFEBEN.BfpBeneficiaryType2
        ,drvBenLifePercent2 =  CAST(BLIFEBEN.BfpPctToAlloc2 as Varchar(12))
        ,drvBenLifeRel2 =  BLIFEBEN.DepRelationship2
        ,drvBenLifeDob2 =  BLIFEBEN.DepDateOfBirth2
        ,drvBenLifeSSN2 =  BLIFEBEN.DepSSN2
        ,drvBenLifeAddress2 =  dbo.dsi_fnRemoveChars('.,/-',BLIFEBEN.FullAddress2)
        ,drvBenLifeName3 =  CASE WHEN BLIFEBEN.DepFirstName3 is not null then BLIFEBEN.DepFirstName3 + ' ' + BLIFEBEN.DepLastName3 END
        ,drvBenLifeType3 =  BLIFEBEN.BfpBeneficiaryType3
        ,drvBenLifePercent3 =  CAST(BLIFEBEN.BfpPctToAlloc3 as Varchar(12))
        ,drvBenLifeRel3 =   BLIFEBEN.DepRelationship3
        ,drvBenLifeDob3 =  BLIFEBEN.DepDateOfBirth3
        ,drvBenLifeSSN3 =  BLIFEBEN.DepSsn3
        ,drvBenLifeAddress3 =  dbo.dsi_fnRemoveChars('.,/-',BLIFEBEN.FullAddress3)
        ,drvBenLifeName4 =  CASE WHEN BLIFEBEN.DepFirstName4 is not null then BLIFEBEN.DepFirstName4 + ' ' + BLIFEBEN.DepLastName4 END
        ,drvBenLifeType4 = BLIFEBEN.BfpBeneficiaryType4
        ,drvBenLifePercent4 = CAST(BLIFEBEN.BfpPctToAlloc4 as Varchar(12))
        ,drvBenLifeRel4 =  BLIFEBEN.DepRelationship4
        ,drvBenLifeDob4 = BLIFEBEN.DepDateOfBirth4
        ,drvBenLifeSSN4 = BLIFEBEN.DepSSN4
        ,drvBenLifeAddress4 = dbo.dsi_fnRemoveChars('.,/-',BLIFEBEN.FullAddress4)
        ,drvAddEffDate = IIF(ADDCode.EedEEID IS NOT NULL, ADDCode.EedBenStartDate, NULL)
        ,drvAddPlanCode = IIF(ADDCode.EedEEID IS NOT NULL,'1','')
        ,drvADDClassCode = CASE WHEN ADDCode.EedEEID IS NOT NULL 
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            --ELSE '5'--all others
                            END--IIF(Life.EedEEID IS NOT NULL,'1','')
        ,drvADDCvgAmount = case when @ExportCode = 'TEST' --set to 280000.00 max amount
                    and CAST(CEILING((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/1000.0)*1000 as money) >= 280000.00
                    then '280000.00'
                    
                    when @ExportCode = 'TEST' 
                    and CAST(CEILING((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/1000.0)*1000 as money) < 280000.00
                    then CAST(CAST(CEILING((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/1000.0)*1000 as money) as varchar)
                    
                    else NULL
                end
        ,drvAddBenName1 = CASE WHEN ADDBEN.DepFirstName1 is not null then ADDBEN.DepFirstName1 + ' ' + ADDBEN.DepLastName1 END
        ,drvAddBenType1 = ADDBEN.BfpBeneficiaryType1
        ,drvAddBenPercent1 = CAST(ADDBEN.BfpPctToAlloc1 as Varchar(12))
        ,drvAddBenRel1 = ADDBEN.DepRelationship1
        ,drvAddBenDob1 = ADDBEN.DepDateOfBirth1
        ,drvAddBenSSN1 =  ADDBEN.DepSSN1
        ,drvAddBenAddress1 =  dbo.dsi_fnRemoveChars('.,/-',ADDBEN.FullAddress1)
        ,drvAddBenName2 = CASE WHEN ADDBEN.DepFirstName2 is not null then ADDBEN.DepFirstName2 + ' ' + ADDBEN.DepLastName2 END
        ,drvAddBenType2 =  ADDBEN.BfpBeneficiaryType2
        ,drvAddBenPercent2 = CAST(ADDBEN.BfpPctToAlloc2 as Varchar(12))
        ,drvAddBenRel2 = ADDBEN.DepRelationship2
        ,drvAddBenDob2 = ADDBEN.DepDateOfBirth2
        ,drvAddBenSSN2 = ADDBEN.DepSsn2
        ,drvAddBenAddress2 =   dbo.dsi_fnRemoveChars('.,/-',ADDBEN.FullAddress2)
        ,drvAddBenName3 = CASE WHEN ADDBEN.DepFirstName3 is not null then ADDBEN.DepFirstName3 + ' ' + ADDBEN.DepLastName3 END
        ,drvAddBenType3 =  ADDBEN.BfpBeneficiaryType3
        ,drvAddBenPercent3 = CAST(ADDBEN.BfpPctToAlloc3 as Varchar(12))
        ,drvAddBenRel3 = ADDBEN.DepRelationship3
        ,drvAddBenDob3 = ADDBEN.DepDateOfBirth3
        ,drvAddBenSSN3 = ADDBEN.DepSsn3
        ,drvAddBenAddress3 =  dbo.dsi_fnRemoveChars('.,/-',ADDBEN.FullAddress3)
        ,drvAddBenName4 = CASE WHEN ADDBEN.DepFirstName4 is not null then ADDBEN.DepFirstName4 + ' ' + ADDBEN.DepLastName4 END
        ,drvAddBenType4 =  ADDBEN.BfpBeneficiaryType4
        ,drvAddBenPercent4 = CAST(ADDBEN.BfpPctToAlloc4 as Varchar(12))
        ,drvAddBenRel4 = ADDBEN.DepRelationship4
        ,drvAddBenDob4 = ADDBEN.DepDateOfBirth4
        ,drvAddBenSSN4 = ADDBEN.DepSSN4
        ,drvAddBenAddress4 =  dbo.dsi_fnRemoveChars('.,/-',ADDBEN.FullAddress4)

        ,drvLTDEffDate = IIF(LTD.EedEEID IS NOT NULL, LTD.EedBenStartDate, NULL)
        ,drvLTDPlanCode = IIF(LTD.EedEEID IS NOT NULL, '1', '')
        ,drvLTDClassCode =  CASE WHEN LTD.EedEEID IS NOT NULL --IIF(LTD.EedEEID IS NOT NULL, '1', '')
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            
                            END
         /*,drvLTDCvgAmount =case when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and (eecannsalary)/12 *.60 < 1500.00 then 
                CAST(CAST(eecannsalary/12 *.60 as money) as varchar)-- isnull(eecudfield09, eecannsalary)/12 *.60 -- CONVERT(VARCHAR,CAST(ISNULL(isnull(eecudfield09, eecannsalary)/12 *.60,0)as money),NULL)
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and (eecannsalary)/12 *.60 >= 1500.00 then '1500.00'
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and (eecannsalary)/12 *.60 < 6000.00 then 
                CAST(CAST(eecannsalary/12 *.60 as money) as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and (eecannsalary)/12 *.60 >= 6000.00 then '6000.00'
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and (eecannsalary)/12 *.60 < 4500.00 then 
                CAST(CAST(eecannsalary/12 *.60 as money) as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and (eecannsalary)/12 *.60 >= 4500.00 then '4500.00'
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and (eecannsalary)/12 *.60 < 1500.00 then 
                CAST(CAST(eecannsalary/12 *.60 as money) as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and (eecannsalary)/12 *.60 >= 1500.00 then '1500.00'
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and (eecannsalary)/12 *.60 < 3000.00 then 
                CAST(CAST(eecannsalary/12 *.60 as money) as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and (eecannsalary)/12 *.60 >= 3000.00 then '3000.00'
                else '0.00'
                END
                --removed 6/14/19:
                */
        ,drvLTDCvgAmount = case when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 < 1500.00 
                    THEN CAST(CONVERT(VARCHAR,CAST(ISNULL((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60,0) as MONEY))as varchar)

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 >= 1500.00 then '1500.00'

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 < 6000.00  
                    THEN CAST(CONVERT(VARCHAR,CAST(ISNULL((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60,0) as MONEY))as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 >= 6000.00 then '6000.00'

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 < 4500.00 
                    THEN CAST(CONVERT(VARCHAR,CAST(ISNULL((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60,0) as MONEY))as varchar)

                
                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 >= 4500.00 then '4500.00'

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 < 1500.00  
                    THEN CAST(CONVERT(VARCHAR,CAST(ISNULL((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60,0) as MONEY))as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 >= 1500.00 then '1500.00'

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 < 3000.00  
                    THEN CAST(CONVERT(VARCHAR,CAST(ISNULL((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60,0) as MONEY))as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 
                
                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 >= 3000.00 then '3000.00'
                                    
            else '0.00'
        END
                --IIF(LTD.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(LTD.BcaBenAmtCalc,0) as MONEY)), NULL)
        /*case when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 < 1500.00 then CONVERT(VARCHAR,CAST(ISNULL(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60,0) as MONEY))-- isnull(eecudfield09, eecannsalary)/12 *.60 -- CONVERT(VARCHAR,CAST(ISNULL(isnull(eecudfield09, eecannsalary)/12 *.60,0)as money),NULL)
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 >= 1500.00 then 1500.00
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 < 6000.00 then CONVERT(VARCHAR,CAST(ISNULL(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60,0) as MONEY))--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 >= 6000.00 then 6000.00
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 < 4500.00 then CONVERT(VARCHAR,CAST(ISNULL(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60,0) as MONEY))--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 >= 4500.00 then 4500.00
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 < 1500.00 then CONVERT(VARCHAR,CAST(ISNULL(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60,0) as MONEY))--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 >= 1500.00 then 1500.00
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 < 3000.00 then CONVERT(VARCHAR,CAST(ISNULL(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60,0) as MONEY))--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 >= 3000.00 then 3000.00
                else 0.00
                END*/
                --IIF(LTD.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(LTD.BcaBenAmtCalc,0) as MONEY)), NULL)
        ,drvVLIFEffDate = IIF(VLIFEE.EedEEID IS NOT NULL, VLIFEE.EedBenStartDate, NULL)
        ,drvVLIFPlanCode = IIF(VLIFEE.EedEEID IS NOT NULL, '1', '')
        ,drvVLIFClassCode = CASE WHEN VLIFEE.EedEEID IS NOT NULL 
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            
                            END--IIF(VLIFEE.EedEEID IS NOT NULL, '1', '')
        ,drvVLIFCvgAmount = IIF(VLIFEE.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(VLIFEE.BcaBenAmtCalc,0) as MONEY)), NULL)
        ,drvVLIFVADDOption = IIF(VLIFEE.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(ADnD.BcaBenAmtCalc,0) as MONEY)), NULL)
        ,drvVELIFLifeName1 = CASE WHEN VLEBEN.DepFirstName1 is not null then VLEBEN.DepFirstName1 + ' ' + VLEBEN.DepLastName1 END
        ,drvVELIFLifeType1 = VLEBEN.BfpBeneficiaryType1
        ,drvVELIFLifePercent1 = CAST(VLEBEN.BfpPctToAlloc1 as Varchar(12))
        ,drvVELIFLifeRel1 = VLEBEN.DepRelationship1
        ,drvVELIFLifeDob1 = VLEBEN.DepDateOfBirth1
        ,drvVELIFLifeSSN1 = VLEBEN.DepSSN1
        ,drvVELIFLifeAddress1 =  dbo.dsi_fnRemoveChars('.,/-',VLEBEN.FullAddress1)
        ,drvVELIFLifeName2 = CASE WHEN VLEBEN.DepFirstName2 is not null then VLEBEN.DepFirstName2 + ' ' + VLEBEN.DepLastName2 END
        ,drvVELIFLifeType2 = VLEBEN.BfpBeneficiaryType2
        ,drvVELIFLifePercent2 = CAST(VLEBEN.BfpPctToAlloc2 as Varchar(22))
        ,drvVELIFLifeRel2 = VLEBEN.DepRelationship2
        ,drvVELIFLifeDob2 = VLEBEN.DepDateOfBirth2
        ,drvVELIFLifeSSN2 = VLEBEN.DepSSN2
        ,drvVELIFLifeAddress2 =  dbo.dsi_fnRemoveChars('.,/-',VLEBEN.FullAddress2)
        ,drvVELIFLifeName3 = CASE WHEN VLEBEN.DepFirstName3 is not null then VLEBEN.DepFirstName3 + ' ' + VLEBEN.DepLastName3 END
        ,drvVELIFLifeType3 = VLEBEN.BfpBeneficiaryType3
        ,drvVELIFLifePercent3 = CAST(VLEBEN.BfpPctToAlloc3 as Varchar(33))
        ,drvVELIFLifeRel3 = VLEBEN.DepRelationship3
        ,drvVELIFLifeDob3 = VLEBEN.DepDateOfBirth3
        ,drvVELIFLifeSSN3 = VLEBEN.DepSSN3
        ,drvVELIFLifeAddress3 =  dbo.dsi_fnRemoveChars('.,/-',VLEBEN.FullAddress3)
        ,drvVELIFLifeName4 = CASE WHEN VLEBEN.DepFirstName4 is not null then VLEBEN.DepFirstName4 + ' ' + VLEBEN.DepLastName4 END
        ,drvVELIFLifeType4 = VLEBEN.BfpBeneficiaryType4
        ,drvVELIFLifePercent4 = CAST(VLEBEN.BfpPctToAlloc4 as Varchar(44))
        ,drvVELIFLifeRel4 = VLEBEN.DepRelationship4
        ,drvVELIFLifeDob4 = VLEBEN.DepDateOfBirth4
        ,drvVELIFLifeSSN4 = VLEBEN.DepSSN4
        ,drvVELIFLifeAddress4 =  dbo.dsi_fnRemoveChars('.,/-',VLEBEN.FullAddress4)
        ,drvVSLIFEffDate = IIF(VLSCODE.EedEEID IS NOT NULL and VLSCODE.eedBenStatus = 'A', VLSCode.EedBenStartDate, NULL)
        ,drvVSLIFPlanCode = IIF(VLSCODE.EedEEID IS NOT NULL and VLSCODE.eedBenStatus = 'A' ,'1','')--''
        ,drvVSLIFClassCode = CASE WHEN VLSCODE.EedEEID IS NOT NULL and VLSCODE.eedBenStatus = 'A' --IIF(LTD.EedEEID IS NOT NULL, '1', '')
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            
                            END--IIF(VLIFEE.EedEEID IS NOT NULL, '1', '')--IIF(STD.EedEEID IS NOT NULL,'1','')--''
        ,drvVSLIFCvgAmount = IIF(VLSCODE.EedEEID IS NOT NULL  and VLSCODE.eedBenStatus = 'A', CONVERT(VARCHAR,CAST(ISNULL(VLSCODE.DedEEBenAmt,0) as MONEY)), NULL)--''
        ,drvVCLIFEffDate =  IIF(VLCCODE.EedEEID IS NOT NULL , VLCCode.EedBenStartDate, NULL)
        ,drvVCLIFPlanCode = IIF(VLCCODE.EedEEID IS NOT NULL,'1','')--''
        ,drvVCLIFClassCode = CASE WHEN VLCCODE.EedEEID IS NOT NULL --IIF(LTD.EedEEID IS NOT NULL, '1', '')
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            
                            END--IIF(VLIFEE.EedEEID IS NOT NULL, '1', '')--IIF(STD.EedEEID IS NOT NULL,'1','')--''
        ,drvVCLIFCvgAmount = IIF(VLCCODE.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(VLCCODE.BcaBenAmtCalc,0) as MONEY)), NULL)--''
        ,drvVSTDEffDate = IIF(STD.EedEEID IS NOT NULL, STD.EedBenStartDate, NULL)--''
        ,drvVSTDPlanCode = IIF(STD.EedEEID IS NOT NULL,'1','')--''
        ,drvVSTDClassCode = CASE WHEN STD.EedEEID IS NOT NULL --IIF(LTD.EedEEID IS NOT NULL, '1', '')
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            
                            END--IIF(VLIFEE.EedEEID IS NOT NULL, '1', '')--IIF(STD.EedEEID IS NOT NULL,'1','')--''
        ,drvVSTDCvgAmount = IIF(STD.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(STD.BcaBenAmtCalc,0) as MONEY)), NULL)--''
        ,drvVSTDElimPeriod = ''
        ,drvASOIndicator = 'N'
        ,drvClaimLocNum = '2788674'
        ,drvClaimLocName = 'N/A'
        ,drvBillingLocNum = '1570606'
        ,drvBillingLocName = 'N/A'
        ,drvSpouseFName = RTRIM(IIF(VLSCODE.EedEEID IS NOT NULL and VLSCODE.eedBenStatus = 'A' ,VLSCODE.ConNameFirst,'') )
        ,drvSpouseLName = RTRIM(IIF(VLSCODE.EedEEID IS NOT NULL and VLSCODE.eedBenStatus = 'A' ,VLSCODE.connamelast,'') ) 
        ,drvSpouseMI = RTRIM(IIF(VLSCODE.EedEEID IS NOT NULL and VLSCODE.eedBenStatus = 'A' ,VLSCODE.connamemiddle,'') )
        ,drvSpouseDOB = RTRIM(IIF(VLSCODE.EedEEID IS NOT NULL and VLSCODE.eedBenStatus = 'A' ,VLSCODE.ConDateOfBirth,NULL)  )
        ,drvSpouseLifeCov = IIF(VLSCODE.EedEEID IS NOT NULL and VLSCODE.eedBenStatus = 'A' ,CAST(VLSCode.DedEEBenAmt as varchar(12)),'') 

    INTO dbo.U_ELINCTT2LC_drvTbl
    
    FROM dbo.U_ELINCTT2LC_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecPayGroup = 'SEMIMO'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('BLIFE')) Life
        ON Life.EedEEID = xEEID 
        AND Life.EedCoID = xCoID
        
    LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('VLE')) VLIFEE
        ON VLIFEE.EedEEID = xEEID 
        AND VLIFEE.EedCoID = xCoID
    LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('STD')) STD
        ON STD.EedEEID = xEEID 
        AND STD.EedCoID = xCoID
    LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('LTDA','LTDE','LTDO','LTDP')) LTD
        ON LTD.EedEEID = xEEID 
        AND LTD.EedCoID = xCoID
   
    LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('ADD')) ADnD
        ON ADnD.EedEEID = xEEID 
        AND ADnD.EedCoID = xCoID
    
    LEFT JOIN dbo.U_ds_ELINCTT2LC_EarnsYTD
        ON eeid = xEEID
        AND ecoid = xCOID

    LEFT JOIN (Select ConEEID AS KidEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS DepLastName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS DepFirstName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS DepSsn1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS DepDateOfBirth1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS DepRelationship1
            ,MAX(CASE WHEN Dep_Number = 1 THEN BfpPctToAlloc END) AS BfpPctToAlloc1
            ,MAX(CASE WHEN Dep_Number = 1 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType1 
            ,MAX(CASE WHEN Dep_Number = 1 THEN FullAddress END) AS FullAddress1  
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) AS DepLastName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) AS DepFirstName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConSSN END) AS DepSsn2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) AS DepDateOfBirth2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConRelationship END) AS DepRelationship2
            ,MAX(CASE WHEN Dep_Number = 2 THEN BfpPctToAlloc END) AS BfpPctToAlloc2
            ,MAX(CASE WHEN Dep_Number = 2 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType2
            ,MAX(CASE WHEN Dep_Number = 2 THEN FullAddress END) AS FullAddress2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) AS DepLastName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) AS DepFirstName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConSSN END) AS DepSsn3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) AS DepDateOfBirth3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConRelationship END) AS DepRelationship3
            ,MAX(CASE WHEN Dep_Number = 3 THEN BfpPctToAlloc END) AS BfpPctToAlloc3
            ,MAX(CASE WHEN Dep_Number = 3 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType3
            ,MAX(CASE WHEN Dep_Number = 2 THEN FullAddress END) AS FullAddress3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) AS DepLastName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) AS DepFirstName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConSSN END) AS DepSsn4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) AS DepDateOfBirth4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConRelationship END) AS DepRelationship4
            ,MAX(CASE WHEN Dep_Number = 4 THEN BfpPctToAlloc END) AS BfpPctToAlloc4
            ,MAX(CASE WHEN Dep_Number = 4 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType4
            ,MAX(CASE WHEN Dep_Number = 2 THEN FullAddress END) AS FullAddress4
        From (
                select ConEEID, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship,ConIsBeneficiary,BfpPctToAlloc,BfpBeneficiaryType, Isnull(Rtrim(ConAddressline1),' ')  + ' ' + Isnull(Rtrim(ConAddressLine2), '')   
 +  ' ' + isnull(Rtrim(conaddresscity),'')  + ' ' +  isnull(rtrim(conaddressstate),'') + ' '  + isnull(rtrim(ConAddressZipCode),'') as FullAddress, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY ConImportID) AS 'Dep_Number'
                from Contacts
                JOIN dbo.BnfBPlan
                ON coneeid =  BfpEEID
                and bfpLESystemId  =  consystemid
                and BFPDedCode in ('BLIFE') and ConIsBeneficiary = 'Y'
                JOIN dbo.U_dsi_BDM_EmpDeductions
                    on eedeeid = coneeid
                    and eedDedCode = 'BLIFE'and  eedFormatCode = 'ELINCTT2LC' AND EedValidForExport = 'Y' 
              
        ) AS Source Group By ConEEID ) as BLIFEBEN
            ON BLIFEBEN.KidEEID = xEEID 


        LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('ADD')) as ADDCode
        ON ADDCode.EedEEID = xEEID 
        AND ADDCode.EedCoID = xCoID


LEFT JOIN (Select ConEEID AS KidEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS DepLastName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS DepFirstName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS DepSsn1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS DepDateOfBirth1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS DepRelationship1
            ,MAX(CASE WHEN Dep_Number = 1 THEN BfpPctToAlloc END) AS BfpPctToAlloc1
            ,MAX(CASE WHEN Dep_Number = 1 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType1 
            ,MAX(CASE WHEN Dep_Number = 1 THEN FullAddress END) AS FullAddress1  
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) AS DepLastName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) AS DepFirstName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConSSN END) AS DepSsn2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) AS DepDateOfBirth2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConRelationship END) AS DepRelationship2
            ,MAX(CASE WHEN Dep_Number = 2 THEN BfpPctToAlloc END) AS BfpPctToAlloc2
            ,MAX(CASE WHEN Dep_Number = 2 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType2
            ,MAX(CASE WHEN Dep_Number = 2 THEN FullAddress END) AS FullAddress2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) AS DepLastName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) AS DepFirstName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConSSN END) AS DepSsn3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) AS DepDateOfBirth3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConRelationship END) AS DepRelationship3
            ,MAX(CASE WHEN Dep_Number = 3 THEN BfpPctToAlloc END) AS BfpPctToAlloc3
            ,MAX(CASE WHEN Dep_Number = 3 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType3
            ,MAX(CASE WHEN Dep_Number = 2 THEN FullAddress END) AS FullAddress3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) AS DepLastName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) AS DepFirstName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConSSN END) AS DepSsn4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) AS DepDateOfBirth4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConRelationship END) AS DepRelationship4
            ,MAX(CASE WHEN Dep_Number = 4 THEN BfpPctToAlloc END) AS BfpPctToAlloc4
            ,MAX(CASE WHEN Dep_Number = 4 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType4
            ,MAX(CASE WHEN Dep_Number = 2 THEN FullAddress END) AS FullAddress4
        From (
                select ConEEID, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship,ConIsBeneficiary,BfpPctToAlloc,BfpBeneficiaryType, Isnull(Rtrim(ConAddressline1),' ')  + ' ' + Isnull(Rtrim(ConAddressLine2), '')   
 +  ' ' + isnull(Rtrim(conaddresscity),'')  + ' ' +  isnull(rtrim(conaddressstate),'') + ' '  + isnull(rtrim(ConAddressZipCode),'') as FullAddress, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY ConImportID) AS 'Dep_Number'
                from Contacts
                JOIN dbo.BnfBPlan
                ON coneeid =  BfpEEID
                and bfpLESystemId  =  consystemid
                and BFPDedCode in ('ADD') and ConIsBeneficiary = 'Y'
                JOIN dbo.U_dsi_BDM_EmpDeductions
                    on eedeeid = coneeid
                    and eedDedCode = 'ADD'and  eedFormatCode = @FormatCode AND EedValidForExport = 'Y' 
              
        ) AS Source Group By ConEEID ) as ADDBEN
            ON ADDBEN.KidEEID = xEEID 

    LEFT JOIN (Select ConEEID AS KidEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS DepLastName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS DepFirstName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS DepSsn1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS DepDateOfBirth1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS DepRelationship1
            ,MAX(CASE WHEN Dep_Number = 1 THEN BfpPctToAlloc END) AS BfpPctToAlloc1
            ,MAX(CASE WHEN Dep_Number = 1 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType1 
            ,MAX(CASE WHEN Dep_Number = 1 THEN FullAddress END) AS FullAddress1  
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) AS DepLastName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) AS DepFirstName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConSSN END) AS DepSsn2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) AS DepDateOfBirth2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConRelationship END) AS DepRelationship2
            ,MAX(CASE WHEN Dep_Number = 2 THEN BfpPctToAlloc END) AS BfpPctToAlloc2
            ,MAX(CASE WHEN Dep_Number = 2 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType2
            ,MAX(CASE WHEN Dep_Number = 2 THEN FullAddress END) AS FullAddress2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) AS DepLastName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) AS DepFirstName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConSSN END) AS DepSsn3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) AS DepDateOfBirth3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConRelationship END) AS DepRelationship3
            ,MAX(CASE WHEN Dep_Number = 3 THEN BfpPctToAlloc END) AS BfpPctToAlloc3
            ,MAX(CASE WHEN Dep_Number = 3 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType3
            ,MAX(CASE WHEN Dep_Number = 2 THEN FullAddress END) AS FullAddress3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) AS DepLastName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) AS DepFirstName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConSSN END) AS DepSsn4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) AS DepDateOfBirth4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConRelationship END) AS DepRelationship4
            ,MAX(CASE WHEN Dep_Number = 4 THEN BfpPctToAlloc END) AS BfpPctToAlloc4
            ,MAX(CASE WHEN Dep_Number = 4 THEN BfpBeneficiaryType END) AS BfpBeneficiaryType4
            ,MAX(CASE WHEN Dep_Number = 2 THEN FullAddress END) AS FullAddress4
        From (
                select ConEEID, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship,ConIsBeneficiary,BfpPctToAlloc,BfpBeneficiaryType, Isnull(Rtrim(ConAddressline1),' ')  + ' ' + Isnull(Rtrim(ConAddressLine2), '')   
 +  ' ' + isnull(Rtrim(conaddresscity),'')  + ' ' +  isnull(rtrim(conaddressstate),'') + ' '  + isnull(rtrim(ConAddressZipCode),'') as FullAddress, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY ConImportID) AS 'Dep_Number'
                from Contacts
                JOIN dbo.BnfBPlan
                ON coneeid =  BfpEEID
                and bfpLESystemId  =  consystemid
                and BFPDedCode in ('VLE') and ConIsBeneficiary = 'Y'
                JOIN dbo.U_dsi_BDM_EmpDeductions
                    on eedeeid = coneeid
                    and eedDedCode = 'VLE'and  eedFormatCode = @FormatCode AND EedValidForExport = 'Y' 
              
        ) AS Source Group By ConEEID ) as VLEBEN
            ON VLEBEN.KidEEID = xEEID 

    /*LEFT JOIN (Select  distinct coneeid,connamefirst,connamelast,connamemiddle,condateofbirth,ConRelationship from dbo.Contacts
where  ConRelationship in ('SPS','DP') and  ConIsDependent = 'Y') as VLSpouse
         ON VLSpouse.coneeid = xEEID */

        LEFT JOIN (SELECT * FROM dbo.Contacts 
                            LEFT JOIN dbo.U_dsi_BDM_EmpDeductions on coneeid = eedeeid
                and EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('VLS')
                LEFT JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                    on eedeeid = bcaeeid
                    and eedcoid = bcacoid
                    and eedFormatCode = bcaFormatCode
                    and eeddedcode = bcadedcode
                    
                WHERE  ConRelationship in ('SPS','DP') and  ConIsDependent = 'Y'  ) as VLSCode
        ON VLSCode.EedEEID = xEEID 
        AND VLSCode.EedCoID = xCoID

        LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                    on eedeeid = bcaeeid
                    and eedcoid = bcacoid
                    and eedFormatCode = bcaFormatCode
                    and eeddedcode = bcadedcode
                WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('VLC')) as VLCCode
        ON VLCCode.EedEEID = xEEID 
        AND VLCCode.EedCoID = xCoID
    ;
    
    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_ELINCTT2LC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_ELINCTT2LC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              ELSE 'ELINCTT2LC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwELINCTT2LC_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ELINCTT2LC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELINCTT2LC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201803071'
       ,expStartPerControl     = '201803071'
       ,expLastEndPerControl   = '201803149'
       ,expEndPerControl       = '201803149'
WHERE expFormatCode = 'ELINCTT2LC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELINCTT2LC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELINCTT2LC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort