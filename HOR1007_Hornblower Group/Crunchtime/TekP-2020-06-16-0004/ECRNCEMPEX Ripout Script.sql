SET NOCOUNT ON;
IF OBJECT_ID('U_ECRNCEMPEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECRNCEMPEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECRNCEMPEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECRNCEMPEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECRNCEMPEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECRNCEMPEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECRNCEMPEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNCEMPEX];
GO
IF OBJECT_ID('U_ECRNCEMPEX_Header') IS NOT NULL DROP TABLE [dbo].[U_ECRNCEMPEX_Header];
GO
IF OBJECT_ID('U_ECRNCEMPEX_File') IS NOT NULL DROP TABLE [dbo].[U_ECRNCEMPEX_File];
GO
IF OBJECT_ID('U_ECRNCEMPEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECRNCEMPEX_EEList];
GO
IF OBJECT_ID('U_ECRNCEMPEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECRNCEMPEX_drvTbl];
GO
IF OBJECT_ID('U_ECRNCEMPEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECRNCEMPEX_AuditFields];
GO
IF OBJECT_ID('U_ECRNCEMPEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECRNCEMPEX_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECRNCEMPEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECRNCEMPEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECRNCEMPEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECRNCEMPEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECRNCEMPEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECRNCEMPEX','Crunchtime Employee Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','6000','S','N','ECRNCEMPEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECRNCEMPEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserId"','1','(''UA''=''TT'')','ECRNCEMPEXZ0','50','H','01','1',NULL,'User ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCreateDate"','2','(''UD101''=''T'')','ECRNCEMPEXZ0','50','H','01','2',NULL,'Create Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','1','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','1',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','2',NULL,'Payroll ID Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','3',NULL,'POS ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimaryLocationCode"','4','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','4',NULL,'Primary Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','5','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','5',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateHired"','6','(''UD101''=''T'')','ECRNCEMPEXZ0','50','D','10','6',NULL,'Date Hired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateTerminated"','7','(''UD101''=''T'')','ECRNCEMPEXZ0','50','D','10','7',NULL,'Date Terminated',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','8',NULL,'Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','9',NULL,'Eligible for Rehire Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','10','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','10',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','11','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','11',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','12','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','12',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerFlag"','13','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','13',NULL,'Manager Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','14','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','14',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','15',NULL,'Ethnic Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','16','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','16',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','17',NULL,'Broadcast Schedule Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','18','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','18',NULL,'E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','19',NULL,'Emergency Contact Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','20',NULL,'Emergency Contact Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNickname"','21','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','21',NULL,'Nickname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','22',NULL,'Allergies',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','23',NULL,'Union Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','24',NULL,'Minor Labor Program Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','25','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','25',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','26','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','26',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','27','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','27',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','28','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','28',NULL,'State/Province Abbreviation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','29','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','29',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','30','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','30',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','31','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','31',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuiSdiTaxzJurCode"','32','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','32',NULL,'SUI/SDI Tax Jurisdiction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayType"','33','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','33',NULL,'Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','34',NULL,'State Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','35',NULL,'State Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','36',NULL,'State Additional Withholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','37',NULL,'Uniform Deduction Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','38','(''UD101''=''T'')','ECRNCEMPEXZ0','50','D','10','38',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmount"','39','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','39',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','40',NULL,'Federal Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','41',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','42',NULL,'Federal Additional Withholding',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','43',NULL,'Meal Program Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPositionCode1"','44','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','44',NULL,'Position Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','45',NULL,'Position Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','46',NULL,'Position Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','47',NULL,'Position Code 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','48',NULL,'Position Code 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','49',NULL,'Position Code 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','50',NULL,'Position Code 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','51',NULL,'Position Code 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','52',NULL,'Position Code 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','53',NULL,'Position Code 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayRate1"','54','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','54',NULL,'Pay Rate 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','55',NULL,'Pay Rate 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','56',NULL,'Pay Rate 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','57',NULL,'Pay Rate 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','58',NULL,'Pay Rate 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','59',NULL,'Pay Rate 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','60',NULL,'Pay Rate 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','61',NULL,'Pay Rate 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','62',NULL,'Pay Rate 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','63',NULL,'Pay Rate 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','64',NULL,'Skill Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','65',NULL,'Skill Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','66',NULL,'Skill Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','67',NULL,'Skill Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','68',NULL,'Skill Level 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','69',NULL,'Skill Level 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','70',NULL,'Skill Level 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','71',NULL,'Skill Level 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','72',NULL,'Skill Level 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','73',NULL,'Skill Level 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','74',NULL,'Employee Checklist Item 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','75',NULL,'Employee Checklist Item 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','76',NULL,'Employee Checklist Item 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','77',NULL,'Employee Checklist Item 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','78',NULL,'Employee Checklist Item 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','79',NULL,'Employee Checklist Item 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','80',NULL,'Employee Checklist Item 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','81',NULL,'Employee Checklist Item 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','82',NULL,'Employee Checklist Item 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','83',NULL,'Employee Checklist Item 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','84',NULL,'Wage Matrix Row 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','85',NULL,'Wage Matrix Row 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','86',NULL,'Wage Matrix Row 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','87',NULL,'Wage Matrix Row 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','88',NULL,'Wage Matrix Row 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','89',NULL,'Wage Matrix Row 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','90',NULL,'Wage Matrix Row 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','91',NULL,'Wage Matrix Row 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','92',NULL,'Wage Matrix Row 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','93',NULL,'Wage Matrix Row 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','94',NULL,'Flex Field 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','95',NULL,'Flex Field 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','96',NULL,'Flex Field 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','97',NULL,'Flex Field 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','98',NULL,'Flex Field 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','99',NULL,'Flex Field 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','100',NULL,'Flex Field 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','101',NULL,'Flex Field 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','102',NULL,'Flex Field 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','103',NULL,'Flex Field 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''DA''=''TT'')','ECRNCEMPEXZ0','50','D','10','104',NULL,'Break Wavier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartTimeFlag"','105','(''UA''=''TT'')','ECRNCEMPEXZ0','50','D','10','105',NULL,'Part Time flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSickLeaveHrsAvail"','106','(''UA''=''T'')','ECRNCEMPEXZ0','50','D','10','106',NULL,'Sick Leave Hours Available',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECRNCEMPEX_20201217.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Crunchtime Employee Export','202010229','EMPEXPORT','ONDEM_XOE',NULL,'ECRNCEMPEX',NULL,NULL,NULL,'202010229','Oct 22 2020  3:57PM','Oct 22 2020  3:57PM','202010151',NULL,'','','202010151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Crunchtime Employee Expo-Sched','202010229','EMPEXPORT','SCH_ECRNCE',NULL,'ECRNCEMPEX',NULL,NULL,NULL,'202010229','Oct 22 2020  3:57PM','Oct 22 2020  3:57PM','202010151',NULL,'','','202010151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Crunchtime Employee Expo-Test','202010229','EMPEXPORT','TEST_XOE',NULL,'ECRNCEMPEX',NULL,NULL,NULL,'202010229','Oct 22 2020  3:57PM','Oct 22 2020  3:57PM','202010151',NULL,'','','202010151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNCEMPEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNCEMPEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNCEMPEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNCEMPEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNCEMPEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECRNCEMPEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECRNCEMPEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECRNCEMPEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECRNCEMPEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECRNCEMPEX','H01','dbo.U_ECRNCEMPEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECRNCEMPEX','D10','dbo.U_ECRNCEMPEX_drvTbl',NULL);
IF OBJECT_ID('U_ECRNCEMPEX_Audit') IS NULL
CREATE TABLE [dbo].[U_ECRNCEMPEX_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ECRNCEMPEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECRNCEMPEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ECRNCEMPEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECRNCEMPEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvPrimaryLocationCode] varchar(1) NOT NULL,
    [drvStatus] varchar(10) NULL,
    [drvDateHired] datetime NULL,
    [drvDateTerminated] datetime NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvManagerFlag] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvNickname] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvSSN] char(11) NULL,
    [drvSuiSdiTaxzJurCode] char(8) NULL,
    [drvPayType] varchar(6) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSalaryAmount] nvarchar(4000) NULL,
    [drvPositionCode1] varchar(12) NULL,
    [drvPayRate1] nvarchar(4000) NULL,
    [drvPartTimeFlag] varchar(1) NOT NULL,
    [drvSickLeaveHrsAvail] nvarchar(4000) NULL
);
IF OBJECT_ID('U_ECRNCEMPEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ECRNCEMPEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECRNCEMPEX_File') IS NULL
CREATE TABLE [dbo].[U_ECRNCEMPEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ECRNCEMPEX_Header') IS NULL
CREATE TABLE [dbo].[U_ECRNCEMPEX_Header] (
    [drvUserId] char(12) NULL,
    [drvCreateDate] datetime NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNCEMPEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Hornblower Group

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 10/22/2020
Service Request Number: TekP-2020-06-16-0004

Purpose: Crunchtime Employee Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECRNCEMPEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECRNCEMPEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECRNCEMPEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECRNCEMPEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECRNCEMPEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNCEMPEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNCEMPEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNCEMPEX', 'SCH_ECRNCE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECRNCEMPEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECRNCEMPEX';

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
    DELETE FROM dbo.U_ECRNCEMPEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECRNCEMPEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECRNCEMPEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    );

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECRNCEMPEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNCEMPEX_AuditFields;
    CREATE TABLE dbo.U_ECRNCEMPEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ECRNCEMPEX_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECRNCEMPEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNCEMPEX_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_ECRNCEMPEX_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECRNCEMPEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
        AND audNewValue = 'T'
   -- AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECRNCEMPEX_Audit ON dbo.U_ECRNCEMPEX_Audit (audEEID,audCOID);



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECRNCEMPEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECRNCEMPEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNCEMPEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeNumber = EecEmpNo
        ,drvPrimaryLocationCode = ''
        ,drvStatus =    CASE WHEN EecEmplStatus = 'L' THEN 'Leave'
                            WHEN EecEmplStatus = 'T' THEN 'Terminated'
                            WHEN EecEmplStatus = 'A' THEN 'Active'
                        END
        ,drvDateHired = EecDateOfLastHire
        ,drvDateTerminated = EecDateOfTermination
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvManagerFlag = CASE WHEN EecSupervisorId = EecEEID THEN 'Y' ELSE 'N' END
        ,drvGender = EepGender
        ,drvPhoneNumber = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvNickname = EepNamePreferred
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = EepAddressCountry
        ,drvSSN = eepSSN
        ,drvSuiSdiTaxzJurCode = EecStateSUI
        ,drvPayType = CASE WHEN EecSalaryOrHourly = 'H' THEN 'Hourly' ELSE 'Salary' END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSalaryAmount = CASE WHEN EecSalaryOrHourly = 'S' THEN FORMAT(EecAnnSalary, '#0.00') END
        ,drvPositionCode1 =    CASE EecJobCode
                                WHEN 'FBADIRF' THEN 'FBADMN08' + '2008'
                                WHEN 'FBADMN01' THEN 'FBADMN01' + '2001'
                                WHEN 'FBADMN02' THEN 'FBADMN11' + '2011'
                                WHEN 'FBADMN03' THEN 'FBADMN03' + '2003'
                                WHEN 'FBADMN04' THEN 'FBADMN04' + '2004'
                                WHEN 'FBADMN05' THEN 'FBADMN05' + '2005'
                                WHEN 'FBADMN06' THEN 'FBFOH02' + '2081'
                                WHEN 'FBADMN07' THEN 'FBADMN07' + '2007'
                                WHEN 'FBADMN08' THEN 'FBADMN08' + '2008'
                                WHEN 'FBADMN09' THEN 'FBFOH02' + '2081'
                                WHEN 'FBADMN10' THEN 'FBADMN10' + '2010'
                                WHEN 'FBADMN11' THEN 'FBADMN11' + '2011'
                                WHEN 'FBADMN13' THEN 'FBFOH02' + '2081'
                                WHEN 'FBADMN14' THEN 'TECH13' + '1253'
                                WHEN 'FBADMN15' THEN 'FBADMN15' + '2014'
                                WHEN 'FBADMN16' THEN 'FBADMN16' + '2015'
                                WHEN 'FBADMN17' THEN 'FBADMN17' + '2016'
                                WHEN 'FBAMGRB' THEN 'FBFOH02' + '2081'
                                WHEN 'FBAMGRD' THEN 'FBFOH02' + '2081'
                                WHEN 'FBAMGRF' THEN 'FBFOH02' + '2081'
                                WHEN 'FBAMGRL' THEN 'FBFOH02' + '2081'
                                WHEN 'FBAMGRM' THEN 'FBFOH02' + '2081'
                                WHEN 'FBAMGRN' THEN 'FBFOH02' + '2081'
                                WHEN 'FBAMGRS' THEN 'FBFOH02' + '2081'
                                WHEN 'FBBARTB' THEN 'FBBART    '
                                WHEN 'FBBARTD' THEN 'FBBART    '
                                WHEN 'FBBARTF' THEN 'FBBART    '
                                WHEN 'FBBARTL' THEN 'FBBART    '
                                WHEN 'FBBARTM' THEN 'FBBART    '
                                WHEN 'FBBARTN' THEN 'FBBART    '
                                WHEN 'FBBARTS' THEN 'FBBART    '
                                WHEN 'FBBATB' THEN 'FBFOH18' + '2096'
                                WHEN 'FBBATD' THEN 'FBFOH18' + '2096'
                                WHEN 'FBBATF' THEN 'FBFOH18' + '2096'
                                WHEN 'FBBATL' THEN 'FBFOH18' + '2096'
                                WHEN 'FBBATM' THEN 'FBFOH18' + '2096'
                                WHEN 'FBBATN' THEN 'FBFOH18' + '2096'
                                WHEN 'FBBATS' THEN 'FBFOH18' + '2096'
                                WHEN 'FBBUSB' THEN 'FBFOH19' + '2097'
                                WHEN 'FBBUSD' THEN 'FBFOH19' + '2097'
                                WHEN 'FBBUSF' THEN 'FBFOH19' + '2097'
                                WHEN 'FBBUSL' THEN 'FBFOH19' + '2097'
                                WHEN 'FBBUSM' THEN 'FBFOH19' + '2097'
                                WHEN 'FBBUSN' THEN 'FBFOH19' + '2097'
                                WHEN 'FBBUSS' THEN 'FBFOH19' + '2097'
                                WHEN 'FBCRZDB' THEN 'FBCRZDB' + '2045'
                                WHEN 'FBCRZDD' THEN 'FBCRZDD' + '2046'
                                WHEN 'FBCRZDF' THEN 'FBCRZDF' + '2047'
                                WHEN 'FBCRZDL' THEN 'FBCRZDL' + '2048'
                                WHEN 'FBCRZDM' THEN 'FBCRZDM' + '2049'
                                WHEN 'FBCRZDN' THEN 'FBCRZDN' + '2050'
                                WHEN 'FBCRZDS' THEN 'FBCRZDS' + '2051'
                                WHEN 'FBDECKM' THEN 'FBDECKM' + '2052'
                                WHEN 'FBDECORB' THEN 'FBDECORB' + '2053'
                                WHEN 'FBDECORD' THEN 'FBDECORD' + '2054'
                                WHEN 'FBDECORF' THEN 'FBDECORF' + '2055'
                                WHEN 'FBDECORL' THEN 'FBDECORL' + '2056'
                                WHEN 'FBDECORM' THEN 'FBDECORM' + '2057'
                                WHEN 'FBDECORN' THEN 'FBDECORN' + '2058'
                                WHEN 'FBDECORS' THEN 'FBDECORS' + '2059'
                                WHEN 'FBDELB' THEN 'FBDELB' + '2060'
                                WHEN 'FBDELD' THEN 'FBDELD' + '2061'
                                WHEN 'FBDELF' THEN 'FBDELF' + '2062'
                                WHEN 'FBDELL' THEN 'FBDELL' + '2063'
                                WHEN 'FBDELM' THEN 'FBDELM' + '2064'
                                WHEN 'FBDELN' THEN 'FBDELN' + '2065'
                                WHEN 'FBDELS' THEN 'FBDELS' + '2066'
                                WHEN 'FBDIRB' THEN 'FBADMN07' + '2007'
                                WHEN 'FBDIRD' THEN 'FBADMN07' + '2007'
                                WHEN 'FBDIRF' THEN 'FBADMN07' + '2007'
                                WHEN 'FBDIRL' THEN 'FBADMN07' + '2007'
                                WHEN 'FBDIRM' THEN 'FBADMN07' + '2007'
                                WHEN 'FBDIRN' THEN 'FBADMN07' + '2007'
                                WHEN 'FBEVMB' THEN 'FBFOH02' + '2081'
                                WHEN 'FBEVMD' THEN 'FBFOH02' + '2081'
                                WHEN 'FBEVMF' THEN 'FBFOH02' + '2081'
                                WHEN 'FBEVML' THEN 'FBFOH02' + '2081'
                                WHEN 'FBEVMM' THEN 'FBFOH02' + '2081'
                                WHEN 'FBEVMN' THEN 'FBFOH02' + '2081'
                                WHEN 'FBEVMS' THEN 'FBFOH02' + '2081'
                                WHEN 'FBFOH01' THEN 'FBFOH02' + '2081'
                                WHEN 'FBFOH02' THEN 'FBFOH02' + '2081'
                                WHEN 'FBFOH04' THEN 'FBFOH02' + '2081'
                                WHEN 'FBFOH05' THEN 'FBFOH02' + '2081'
                                WHEN 'FBFOH06' THEN 'FBFOH06' + '2084'
                                WHEN 'FBFOH07' THEN 'FBFOH07' + '2085'
                                WHEN 'FBFOH08' THEN 'FBFOH08' + '2086'
                                WHEN 'FBFOH09' THEN 'FBFOH17' + '2095'
                                WHEN 'FBFOH10' THEN 'FBFOH18' + '2096'
                                WHEN 'FBFOH11' THEN 'FBFOH19' + '2097'
                                WHEN 'FBFOH12' THEN 'FBFOH21' + '2099'
                                WHEN 'FBFOH13' THEN 'FBFOH13' + '2091'
                                WHEN 'FBFOH14' THEN 'FBFOH14' + '2092'
                                WHEN 'FBFOH15' THEN 'FBFOH15' + '2093'
                                WHEN 'FBFOH16' THEN 'FBFOH16' + '2094'
                                WHEN 'FBFOH17' THEN 'FBFOH17' + '2095'
                                WHEN 'FBFOH18' THEN 'FBFOH18' + '2096'
                                WHEN 'FBFOH19' THEN 'FBFOH19' + '2097'
                                WHEN 'FBFOH20' THEN 'FBFOH20' + '2098'
                                WHEN 'FBFOH21' THEN 'FBFOH21' + '2099'
                                WHEN 'FBFOH22' THEN 'FBFOH22' + '2100'
                                WHEN 'FBFOH23' THEN 'FBFOH23' + '2101'
                                WHEN 'FBFOH24' THEN 'FBFOH24' + '2102'
                                WHEN 'FBFOH25' THEN 'FBFOH25' + '2103'
                                WHEN 'FBFOH26' THEN 'FBFOH26' + '2104'
                                WHEN 'FBFOH27' THEN 'FBFOH27' + '2105'
                                WHEN 'FBFOH30' THEN 'FBFOH30' + '2106'
                                WHEN 'FBFOH31' THEN 'FBFOH31' + '2107'
                                WHEN 'FBFOH32' THEN 'FBFOH32' + '2108'
                                WHEN 'FBFOH33' THEN 'FBFOH33' + '2109'
                                WHEN 'FBFOH34' THEN 'FBFOH34' + '2110'
                                WHEN 'FBFOH35' THEN 'FBFOH35' + '2111'
                                WHEN 'FBFOH36' THEN 'FBFOH36' + '2112'
                                WHEN 'FBFOH37' THEN 'FBFOH37' + '2113'
                                WHEN 'FBFOH38' THEN 'FBFOH38' + '2114'
                                WHEN 'FBFOH40' THEN 'FBFOH40' + '2115'
                                WHEN 'FBFOH41' THEN 'FBFOH41' + '2116'
                                WHEN 'FBFOH42' THEN 'FBFOH42' + '2117'
                                WHEN 'FBFOH43' THEN 'FBFOH43' + '2118'
                                WHEN 'FBFOH44' THEN 'FBFOH44' + '2119'
                                WHEN 'FBFOH45' THEN 'FBFOH45' + '2120'
                                WHEN 'FBFOH63' THEN 'FBFOH04' + '2082'
                                WHEN 'FBFOH65' THEN 'FBFOH65' + '2122'
                                WHEN 'FBFOH66' THEN 'FBFOH66' + '2123'
                                WHEN 'FBFOH67' THEN 'FBFOH67' + '2124'
                                WHEN 'FBFOH68' THEN 'FBFOH68' + '2125'
                                WHEN 'FBHSPB' THEN 'FBHSPB' + '2126'
                                WHEN 'FBHSPD' THEN 'FBHSPD' + '2127'
                                WHEN 'FBHSPF' THEN 'FBHSPF' + '2128'
                                WHEN 'FBHSPL' THEN 'FBHSPL' + '2129'
                                WHEN 'FBHSPM' THEN 'FBHSPM' + '2130'
                                WHEN 'FBHSPN' THEN 'FBHSPN' + '2131'
                                WHEN 'FBHSPS' THEN 'FBHSPS' + '2132'
                                WHEN 'FBHSUPB' THEN 'FBHSUPB' + '2133'
                                WHEN 'FBHSUPD' THEN 'FBHSUPD' + '2134'
                                WHEN 'FBHSUPF' THEN 'FBHSUPF' + '2135'
                                WHEN 'FBHSUPL' THEN 'FBHSUPL' + '2136'
                                WHEN 'FBHSUPM' THEN 'FBHSUPM' + '2137'
                                WHEN 'FBHSUPN' THEN 'FBHSUPN' + '2138'
                                WHEN 'FBHSUPS' THEN 'FBHSUPS' + '2139'
                                WHEN 'FBHTMD' THEN 'FBFOH65' + '2122'
                                WHEN 'FBINVB' THEN 'FBINVB' + '2141'
                                WHEN 'FBINVD' THEN 'FBINVD' + '2142'
                                WHEN 'FBINVF' THEN 'FBINVF' + '2143'
                                WHEN 'FBINVL' THEN 'FBINVL' + '2144'
                                WHEN 'FBINVM' THEN 'FBINVM' + '2145'
                                WHEN 'FBINVN' THEN 'FBINVN' + '2146'
                                WHEN 'FBINVS' THEN 'FBINVS' + '2147'
                                WHEN 'FBMGQB' THEN 'FBMGQB' + '2148'
                                WHEN 'FBMGQD' THEN 'FBMGQD' + '2149'
                                WHEN 'FBMGQF' THEN 'FBMGQF' + '2150'
                                WHEN 'FBMGQL' THEN 'FBMGQL' + '2151'
                                WHEN 'FBMGQM' THEN 'FBMGQM' + '2152'
                                WHEN 'FBMGQN' THEN 'FBMGQN' + '2153'
                                WHEN 'FBMGQS' THEN 'FBMGQS' + '2154'
                                WHEN 'FBMGRB' THEN 'FBFOH02' + '2081'
                                WHEN 'FBMGRD' THEN 'FBFOH02' + '2081'
                                WHEN 'FBMGRF' THEN 'FBFOH02' + '2081'
                                WHEN 'FBMGRL' THEN 'FBFOH02' + '2081'
                                WHEN 'FBMGRM' THEN 'FBFOH02' + '2081'
                                WHEN 'FBMGRN' THEN 'FBFOH02' + '2081'
                                WHEN 'FBMGRS' THEN 'FBFOH02' + '2081'
                                WHEN 'FBOFFB' THEN 'ADMIN10' + '1059'
                                WHEN 'FBOFFD' THEN 'ADMIN10' + '1059'
                                WHEN 'FBOFFF' THEN 'ADMIN10' + '1059'
                                WHEN 'FBOFFL' THEN 'ADMIN10' + '1059'
                                WHEN 'FBOFFM' THEN 'ADMIN10' + '1059'
                                WHEN 'FBOFFN' THEN 'ADMIN10' + '1059'
                                WHEN 'FBOFFS' THEN 'ADMIN10' + '1059'
                                WHEN 'FBSETB' THEN 'FBSETB' + '2169'
                                WHEN 'FBSETD' THEN 'FBSETD' + '2170'
                                WHEN 'FBSETF' THEN 'FBSETF' + '2171'
                                WHEN 'FBSETL' THEN 'FBSETL' + '2172'
                                WHEN 'FBSETM' THEN 'FBSETM' + '2173'
                                WHEN 'FBSETN' THEN 'FBSETN' + '2174'
                                WHEN 'FBSETS' THEN 'FBSETS' + '2175'
                                WHEN 'FBSNAKB' THEN 'FBFOH16' + '2094'
                                WHEN 'FBSNAKD' THEN 'FBFOH16' + '2094'
                                WHEN 'FBSNAKF' THEN 'FBFOH16' + '2094'
                                WHEN 'FBSNAKL' THEN 'FBFOH16' + '2094'
                                WHEN 'FBSNAKM' THEN 'FBFOH16' + '2094'
                                WHEN 'FBSNAKN' THEN 'FBFOH16' + '2094'
                                WHEN 'FBSNAKS' THEN 'FBFOH16' + '2094'
                                WHEN 'FBSTWB' THEN 'FBFOH17' + '2095'
                                WHEN 'FBSTWD' THEN 'FBFOH17' + '2095'
                                WHEN 'FBSTWF' THEN 'FBFOH17' + '2095'
                                WHEN 'FBSTWL' THEN 'FBFOH17' + '2095'
                                WHEN 'FBSTWM' THEN 'FBFOH17' + '2095'
                                WHEN 'FBSTWN' THEN 'FBFOH17' + '2095'
                                WHEN 'FBSTWS' THEN 'FBFOH17' + '2095'
                                WHEN 'FBSUPD' THEN 'FBFOH15' + '2093'
                                WHEN 'FBTRNB' THEN 'FBFOH30' + '2106'
                                WHEN 'FBTRND' THEN 'FBFOH30' + '2106'
                                WHEN 'FBTRNF' THEN 'FBFOH30' + '2106'
                                WHEN 'FBTRNL' THEN 'FBFOH30' + '2106'
                                WHEN 'FBTRNM' THEN 'FBFOH30' + '2106'
                                WHEN 'FBTRNN' THEN 'FBFOH30' + '2106'
                                WHEN 'FBTRNS' THEN 'FBFOH30' + '2106'
                                WHEN 'FBTRVLB' THEN 'FBTRVLB' + '2198'
                                WHEN 'FBTRVLD' THEN 'FBTRVLD' + '2199'
                                WHEN 'FBTRVLF' THEN 'FBTRVLF' + '2200'
                                WHEN 'FBTRVLL' THEN 'FBTRVLL' + '2201'
                                WHEN 'FBTRVLM' THEN 'FBTRVLM' + '2202'
                                WHEN 'FBTRVLN' THEN 'FBTRVLN' + '2203'
                                WHEN 'FBTRVLS' THEN 'FBTRVLS' + '2204'
                                WHEN 'FBWEDDB' THEN 'FBFOH02' + '2081'
                                WHEN 'FBWEDDD' THEN 'FBWEDDD' + '2206'
                                WHEN 'FBWEDDF' THEN 'FBFOH02' + '2081'
                                WHEN 'FBWEDDL' THEN 'FBWEDDL' + '2208'
                                WHEN 'FBWEDDM' THEN 'FBWEDDM' + '2209'
                                WHEN 'FBWEDDN' THEN 'FBWEDDN' + '2210'
                                WHEN 'FBWEDDS' THEN 'FBFOH02' + '2081'
                            END
        ,drvPayRate1 = CASE WHEN EecSalaryOrHourly = 'H' THEN FORMAT(EecHourlyPayRate, '#0.00') END
        ,drvPartTimeFlag = CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'Y' ELSE 'N' END
        ,drvSickLeaveHrsAvail = FORMAT(EacAccrAllowedCurBal, '#0.00')
    INTO dbo.U_ECRNCEMPEX_drvTbl
    FROM dbo.U_ECRNCEMPEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpAccr WITH (NOLOCK)
        ON xEEID = EacEEID
        AND EacAccrCode LIKE 'SICK%'
    LEFT JOIN dbo.U_ECRNCEMPEX_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audCOID = xCOID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND audDateTime BETWEEN @StartDate AND @EndDate)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECRNCEMPEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNCEMPEX_Header;
    SELECT DISTINCT
         drvUserId = (SELECT TOP 1 drvEEID FROM dbo.U_ECRNCEMPEX_drvTbl)
        ,drvCreateDate = GETDATE()
    INTO dbo.U_ECRNCEMPEX_Header
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
ALTER VIEW dbo.dsi_vwECRNCEMPEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECRNCEMPEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECRNCEMPEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202010151'
       ,expStartPerControl     = '202010151'
       ,expLastEndPerControl   = '202010229'
       ,expEndPerControl       = '202010229'
WHERE expFormatCode = 'ECRNCEMPEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECRNCEMPEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECRNCEMPEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort