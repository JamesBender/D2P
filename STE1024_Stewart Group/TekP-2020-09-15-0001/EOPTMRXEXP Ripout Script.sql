SET NOCOUNT ON;
IF OBJECT_ID('U_EOPTMRXEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOPTMRXEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EOPTMRXEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EOPTMRXEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEOPTMRXEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEOPTMRXEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EOPTMRXEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTMRXEXP];
GO
IF OBJECT_ID('U_EOPTMRXEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EOPTMRXEXP_File];
GO
IF OBJECT_ID('U_EOPTMRXEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EOPTMRXEXP_EEList];
GO
IF OBJECT_ID('U_EOPTMRXEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EOPTMRXEXP_drvTbl];
GO
IF OBJECT_ID('U_EOPTMRXEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EOPTMRXEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EOPTMRXEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EOPTMRXEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EOPTMRXEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EOPTMRXEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EOPTMRXEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EOPTMRXEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EOPTMRXEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EOPTMRXEXP','Optum Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2700','S','N','EOPTMRXEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EOPTMRXEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"THESTEWCO"','1','(''DA''=''F'')','EOPTMRXEXPZ0','9','D','10','1',NULL,'CARRIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccount"','2','(''UA''=''F'')','EOPTMRXEXPZ0','15','D','10','10',NULL,'ACCOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroup"','3','(''UA''=''F'')','EOPTMRXEXPZ0','15','D','10','25',NULL,'GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberId"','4','(''UA''=''F'')','EOPTMRXEXPZ0','18','D','10','40',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonCode"','5','(''UA''=''F'')','EOPTMRXEXPZ0','3','D','10','58',NULL,'PERSON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','6','(''UA''=''F'')','EOPTMRXEXPZ0','1','D','10','61',NULL,'RELATIONSHIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''F'')','EOPTMRXEXPZ0','25','D','10','62',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','8','(''UA''=''F'')','EOPTMRXEXPZ0','15','D','10','87',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','9','(''UA''=''F'')','EOPTMRXEXPZ0','1','D','10','102',NULL,'MIDDLE INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','10','(''UA''=''F'')','EOPTMRXEXPZ0','1','D','10','103',NULL,'SEX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','11','(''UD112''=''F'')','EOPTMRXEXPZ0','8','D','10','104',NULL,'DATE OF BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','112',NULL,'MULTIPLE BIRTH CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','113',NULL,'MEMBER TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"100"','14','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','114',NULL,'LANGUAGE CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','117',NULL,'DUR FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EOPTMRXEXPZ0','18','D','10','118',NULL,'DUR KEY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','17','(''UA''=''F'')','EOPTMRXEXPZ0','9','D','10','136',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','18','(''UA''=''F'')','EOPTMRXEXPZ0','40','D','10','145',NULL,'ADDRESS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','19','(''UA''=''F'')','EOPTMRXEXPZ0','40','D','10','185',NULL,'ADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EOPTMRXEXPZ0','40','D','10','225',NULL,'ADDRESS3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','21','(''UA''=''F'')','EOPTMRXEXPZ0','20','D','10','265',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdressState"','22','(''UA''=''F'')','EOPTMRXEXPZ0','2','D','10','285',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','23','(''UA''=''F'')','EOPTMRXEXPZ0','5','D','10','287',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''F'')','EOPTMRXEXPZ0','4','D','10','292',NULL,'ZIP2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','296',NULL,'ZIP3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USA"','26','(''DA''=''F'')','EOPTMRXEXPZ0','4','D','10','298',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','27','(''UA''=''F'')','EOPTMRXEXPZ0','10','D','10','302',NULL,'PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyFlag"','28','(''UA''=''F'')','EOPTMRXEXPZ0','1','D','10','312',NULL,'FAMILY FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyType"','29','(''UA''=''F'')','EOPTMRXEXPZ0','1','D','10','313',NULL,'FAMILY TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EOPTMRXEXPZ0','18','D','10','314',NULL,'FAMILY ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','332',NULL,'ORIGINAL FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','339',NULL,'BENEFIT RESET DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberFromDate"','33','(''UA''=''F'')','EOPTMRXEXPZ0','7','D','10','346',NULL,'MEMBER FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberToDate"','34','(''UA''=''F'')','EOPTMRXEXPZ0','7','D','10','353',NULL,'MEMBER THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','360',NULL,'OVERRIDE PLAN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','370',NULL,'OVERRIDE PLAN EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''F'')','EOPTMRXEXPZ0','5','D','10','377',NULL,'BRAND',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EOPTMRXEXPZ0','5','D','10','382',NULL,'GENERIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EOPTMRXEXPZ0','5','D','10','387',NULL,'COPAY 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EOPTMRXEXPZ0','5','D','10','392',NULL,'COPAY 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','397',NULL,'CLIENT PRODUCT CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','403',NULL,'CLIENT RIDER CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','409',NULL,'CARE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','416',NULL,'CARE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','423',NULL,'CARE NETWORK',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','433',NULL,'CARE NETWORK PLAN OVERRIDE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','443',NULL,'CARE NETWORK PLAN FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','450',NULL,'CARE FACILITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','456',NULL,'CARE QUALIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EOPTMRXEXPZ0','15','D','10','466',NULL,'PCP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','481',NULL,'PCP ID QUALIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','483',NULL,'PCP ID STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','486',NULL,'ALTERNATE INSURANCE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','493',NULL,'ALTERNATE INSURANCE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','500',NULL,'ALTERNATE INSURANCE FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','501',NULL,'ALTERNATE INSURANCE CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''F'')','EOPTMRXEXPZ0','18','D','10','511',NULL,'ALTERNATE INSURANCE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','529',NULL,'CARD FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','530',NULL,'CARD QUANTITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''F'')','EOPTMRXEXPZ0','5','D','10','531',NULL,'MEDICARE PART-D CONTRACT NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','536',NULL,'MEDICARE HIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','556',NULL,'PBP NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','559',NULL,'SEGMENT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','562',NULL,'ENROLLMENT SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','563',NULL,'SUBSIDY LEVEL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','566',NULL,'CO-PAY CATEGORY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''F'')','EOPTMRXEXPZ0','8','D','10','567',NULL,'CO-PAY CATEGORY EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','575',NULL,'COVERAGE TYPE 1 (PRIMARY)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','576',NULL,'COVERAGE TYPE 1 CATEGORY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','577',NULL,'COVERAGE TYPE 1 FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','584',NULL,'COVERAGE TYPE 1 THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','591',NULL,'PRIMARY BIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','597',NULL,'PRIMARY PROCESSOR CONTROL NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''F'')','EOPTMRXEXPZ0','15','D','10','607',NULL,'PRIMARY SUBMITTED GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','622',NULL,'PRIMARY HELPDESK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','632',NULL,'PRIMARY MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','652',NULL,'PRIMARY PERSON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','655',NULL,'PRIMARY SUPPLEMENTAL TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','656',NULL,'PRIMARY COVERAGE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','666',NULL,'COVERAGE TYPE 2 (SECONDARY)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','667',NULL,'COVERAGE TYPE 2 CATEGORY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','668',NULL,'COVERAGE TYPE 2 FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','675',NULL,'COVERAGE TYPE 2 THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','682',NULL,'SECONDARY BIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','688',NULL,'SECONDARY PROCESSOR CONTROL NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''F'')','EOPTMRXEXPZ0','15','D','10','698',NULL,'SECONDARY SUBMITTED GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','713',NULL,'SECONDARY HELPDESK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','723',NULL,'SECONDARY MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','743',NULL,'SECONDARY PERSON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','746',NULL,'SECONDARY SUPPLEMENTAL TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','747',NULL,'SECONDARY COVERAGE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','757',NULL,'COVERAGE TYPE 3 (TERTIARY)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','758',NULL,'COVERAGE TYPE 3 CATEGORY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','759',NULL,'COVERAGE TYPE 3 FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','766',NULL,'COVERAGE TYPE 3 THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','773',NULL,'TERTIARY BIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','779',NULL,'TERTIARY PROCESSOR CONTROL NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''DA''=''F'')','EOPTMRXEXPZ0','15','D','10','789',NULL,'TERTIARY SUBMITTED GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','804',NULL,'TERTIARY HELPDESK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','814',NULL,'TERTIARY MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','834',NULL,'TERTIARY PERSON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','837',NULL,'TERTIARY SUPPLEMENTAL TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','838',NULL,'TERTIARY COVERAGE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','848',NULL,'COVERAGE TYPE 4 (QUATERNARY)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','849',NULL,'COVERAGE TYPE 4 CATEGORY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','850',NULL,'COVERAGE TYPE 4 FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','857',NULL,'COVERAGE TYPE 4 THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','864',NULL,'QUATERNARY BIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','870',NULL,'QUATERNARY PROCESSOR CONTROL NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''DA''=''F'')','EOPTMRXEXPZ0','15','D','10','880',NULL,'QUATERNARY SUBMITTED GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','895',NULL,'QUATERNARY HELPDESK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','905',NULL,'QUATERNARY MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','925',NULL,'QUATERNARY PERSON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','928',NULL,'QUATERNARY SUPPLEMENTAL TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','929',NULL,'QUATERNARY COVERAGE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','939',NULL,'COVERAGE TYPE 5 (FIFTH)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','940',NULL,'COVERAGE TYPE 5 CATEGORY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','118','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','941',NULL,'COVERAGE TYPE 5 FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','119','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','948',NULL,'COVERAGE TYPE 5 THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','120','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','955',NULL,'FIFTH BIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','121','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','961',NULL,'FIFTH PROCESSOR CONTROL NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','122','(''DA''=''F'')','EOPTMRXEXPZ0','15','D','10','971',NULL,'FIFTH SUBMITTED GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','123','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','986',NULL,'FIFTH HELPDESK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','124','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','996',NULL,'FIFTH MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','125','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1016',NULL,'FIFTH PERSON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','126','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1019',NULL,'FIFTH SUPPLEMENTAL TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','127','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1020',NULL,'FIFTH COVERAGE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','128','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1030',NULL,'COVERAGE TYPE 6 (SIXTH)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1031',NULL,'COVERAGE TYPE 6 CATEGORY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1032',NULL,'COVERAGE TYPE 6 FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1039',NULL,'COVERAGE TYPE 6 THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','1046',NULL,'SIXTH BIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1052',NULL,'SIXTH PROCESSOR CONTROL NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''DA''=''F'')','EOPTMRXEXPZ0','15','D','10','1062',NULL,'SIXTH SUBMITTED GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1077',NULL,'SIXTH HELPDESK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1087',NULL,'SIXTH MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1107',NULL,'SIXTH PERSON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1110',NULL,'SIXTH SUPPLEMENTAL TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1111',NULL,'SIXTH COVERAGE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1121',NULL,'COVERAGE TYPE 7 (SEVENTH)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1122',NULL,'COVERAGE TYPE 7 CATEGORY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1123',NULL,'COVERAGE TYPE 7 FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1130',NULL,'COVERAGE TYPE 7 THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','1137',NULL,'SEVENTH BIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1143',NULL,'SEVENTH PROCESSOR CONTROL NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''DA''=''F'')','EOPTMRXEXPZ0','15','D','10','1153',NULL,'SEVENTH SUBMITTED GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1168',NULL,'SEVENTH HELPDESK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1178',NULL,'SEVENTH MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1198',NULL,'SEVENTH PERSON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1201',NULL,'SEVENTH SUPPLEMENTAL TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1202',NULL,'SEVENTH COVERAGE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1212',NULL,'COVERAGE TYPE 8 (EIGHTH)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','153','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1213',NULL,'COVERAGE TYPE 8 CATEGORY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','154','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1214',NULL,'COVERAGE TYPE 8 FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1221',NULL,'COVERAGE TYPE 8 THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','156','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','1228',NULL,'EIGHTH BIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1234',NULL,'EIGHTH PROCESSOR CONTROL NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','158','(''DA''=''F'')','EOPTMRXEXPZ0','15','D','10','1244',NULL,'EIGHTH SUBMITTED GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','159','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1259',NULL,'EIGHTH HELPDESK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','160','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1269',NULL,'EIGHTH MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1289',NULL,'EIGHTH PERSON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','162','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1292',NULL,'EIGHTH SUPPLEMENTAL TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','163','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1293',NULL,'EIGHTH COVERAGE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','164','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1303',NULL,'COVERAGE TYPE 9 (NINTH)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','165','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1304',NULL,'COVERAGE TYPE 9 CATEGORY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','166','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1305',NULL,'COVERAGE TYPE 9 FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','167','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1312',NULL,'COVERAGE TYPE 9 THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','168','(''DA''=''F'')','EOPTMRXEXPZ0','6','D','10','1319',NULL,'NINTH BIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','169','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1325',NULL,'NINTH PROCESSOR CONTROL NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','170','(''DA''=''F'')','EOPTMRXEXPZ0','15','D','10','1335',NULL,'NINTH SUBMITTED GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','171','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1350',NULL,'NINTH HELPDESK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','172','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1360',NULL,'NINTH MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1380',NULL,'NINTH PERSON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','174','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1383',NULL,'NINTH SUPPLEMENTAL TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','175','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1384',NULL,'NINTH COVERAGE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','176','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','1394',NULL,'Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1396',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','178','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1397',NULL,'DIAGNOSIS CODE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1417',NULL,'DIAGNOSIS CODE 1 EFFECTIVE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1424',NULL,'DIAGNOSIS CODE 1 EFFECTIVE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','181','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','1431',NULL,'Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1433',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1434',NULL,'DIAGNOSIS CODE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1454',NULL,'DIAGNOSIS CODE 2 EFFECTIVE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1461',NULL,'DIAGNOSIS CODE 2 EFFECTIVE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','1468',NULL,'Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','187','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1470',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','188','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1471',NULL,'DIAGNOSIS CODE 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','189','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1491',NULL,'DIAGNOSIS CODE 3 EFFECTIVE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','190','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1498',NULL,'DIAGNOSIS CODE 3 EFFECTIVE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','191','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','1505',NULL,'Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','192','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1507',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','193','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1508',NULL,'DIAGNOSIS CODE 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','194','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1528',NULL,'DIAGNOSIS CODE 4 EFFECTIVE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','195','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1535',NULL,'DIAGNOSIS CODE 4 EFFECTIVE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','196','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','1542',NULL,'Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','197','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1544',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','198','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1545',NULL,'DIAGNOSIS CODE 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','199','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1565',NULL,'DIAGNOSIS CODE 5 EFFECTIVE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','200','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1572',NULL,'DIAGNOSIS CODE 5 EFFECTIVE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','201','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','1579',NULL,'Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','202','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1581',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','203','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1582',NULL,'DIAGNOSIS CODE 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','204','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1602',NULL,'DIAGNOSIS CODE 6 EFFECTIVE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','205','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1609',NULL,'DIAGNOSIS CODE 6 EFFECTIVE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','206','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','1616',NULL,'Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','207','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1618',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','208','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1619',NULL,'DIAGNOSIS CODE 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','209','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1639',NULL,'DIAGNOSIS CODE 7 EFFECTIVE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','210','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1646',NULL,'DIAGNOSIS CODE 7 EFFECTIVE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','211','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','1653',NULL,'Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','212','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1655',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','213','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1656',NULL,'DIAGNOSIS CODE 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','214','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1676',NULL,'DIAGNOSIS CODE 8 EFFECTIVE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','215','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1683',NULL,'DIAGNOSIS CODE 8 EFFECTIVE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','216','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','1690',NULL,'Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','217','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1692',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','218','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1693',NULL,'DIAGNOSIS CODE 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','219','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1713',NULL,'DIAGNOSIS CODE 9 EFFECTIVE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','220','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1720',NULL,'DIAGNOSIS CODE 9 EFFECTIVE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','221','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','1727',NULL,'Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','222','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1729',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','223','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','1730',NULL,'DIAGNOSIS CODE 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','224','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1750',NULL,'DIAGNOSIS CODE 10 EFFECTIVE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','225','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1757',NULL,'DIAGNOSIS CODE 10 EFFECTIVE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','226','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1764',NULL,'ALLERGY CODE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','227','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1767',NULL,'ALLERGY CODE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','228','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1770',NULL,'ALLERGY CODE 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','229','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1773',NULL,'ALLERGY CODE 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','230','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1776',NULL,'ALLERGY CODE 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','231','(''DA''=''F'')','EOPTMRXEXPZ0','3','D','10','1779',NULL,'ALLERGY CODE 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','232','(''DA''=''F'')','EOPTMRXEXPZ0','5','D','10','1782',NULL,'HEIGHT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','233','(''DA''=''F'')','EOPTMRXEXPZ0','5','D','10','1787',NULL,'WEIGHT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','234','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1792',NULL,'BLOOD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','235','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1793',NULL,'CONTACT LENS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','236','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1794',NULL,'SMOKING CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','237','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1795',NULL,'PREGNANCY CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','238','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1796',NULL,'ALCOHOL CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','239','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1797',NULL,'MISC CODE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','240','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','1798',NULL,'MISC CODE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','241','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1799',NULL,'MEMBER ID CARD DATA FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','242','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1806',NULL,'MEMBER ID CARD DATA THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','243','(''DA''=''F'')','EOPTMRXEXPZ0','5','D','10','1813',NULL,'MEMBER ID CARD LOGO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','244','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','1818',NULL,'MEMBER ID CARD DATA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','245','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1828',NULL,'MEMBER CLIENT DEFINED DATA EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','246','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','1835',NULL,'MEMBER CLIENT DEFINED DATA THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','247','(''DA''=''F'')','EOPTMRXEXPZ0','256','D','10','1842',NULL,'MEMBER CLIENT DEFINED DATA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','248','(''DA''=''F'')','EOPTMRXEXPZ0','30','D','10','2098',NULL,'MEMBER ID CARD TEXT1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','249','(''DA''=''F'')','EOPTMRXEXPZ0','30','D','10','2128',NULL,'MEMBER ID CARD TEXT2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','250','(''DA''=''F'')','EOPTMRXEXPZ0','30','D','10','2158',NULL,'MEMBER ID CARD TEXT3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','251','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2188',NULL,'MEMBER COPAY OVERRIDE FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','252','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2195',NULL,'MEMBER COPAY OVERRIDE THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','253','(''DA''=''F'')','EOPTMRXEXPZ0','10','D','10','2202',NULL,'MEMBER COPAY OVERRIDE COPAY SCHEDULE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','254','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','2212',NULL,'MEMBER COPAY OVERRIDE COPAY SCHEDULE SCHEDULE STEP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','255','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','2214',NULL,'MEDICARE TYPE (from Member)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','256','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2215',NULL,'MEDICARE FROM DATE (from Member)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','257','(''DA''=''F'')','EOPTMRXEXPZ0','11','D','10','2222',NULL,'MEMBER MEDICARE ID (from Member)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','258','(''DA''=''F'')','EOPTMRXEXPZ0','9','D','10','2233',NULL,'SPEND-DOWN AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','259','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','2242',NULL,'COB PRICING TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','260','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2244',NULL,'MEDICARE PART D FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','261','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2251',NULL,'MEDICARE PART D THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','262','(''DA''=''F'')','EOPTMRXEXPZ0','80','D','10','2258',NULL,'ELECTRONIC MAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','263','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2338',NULL,'SUPPLEMENTAL ID FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','264','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2345',NULL,'SUPPLEMENTAL ID THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','265','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','2352',NULL,'MTM TERMINATION REASON CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','266','(''DA''=''F'')','EOPTMRXEXPZ0','8','D','10','2354',NULL,'MTM TERMINATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','267','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','2362',NULL,'MTM TERMINATION STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','268','(''DA''=''F'')','EOPTMRXEXPZ0','20','D','10','2363',NULL,'MSI ALTERNATE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','269','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2383',NULL,'MSI FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','270','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2390',NULL,'MSI THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','271','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','2397',NULL,'ALTERNATE INSURANCE TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','272','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2398',NULL,'HIM FROM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','273','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2405',NULL,'HIM THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','274','(''DA''=''F'')','EOPTMRXEXPZ0','14','D','10','2412',NULL,'HIM PLAN ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','2426',NULL,'HIM CSR LEVEL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','2428',NULL,'HIM PLAN METAL INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''DA''=''F'')','EOPTMRXEXPZ0','2','D','10','2429',NULL,'MEMBER ETHNICITY INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','278','(''DA''=''F'')','EOPTMRXEXPZ0','1','D','10','2431',NULL,'MEMBER APTC INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2432',NULL,'HIM GRACE PERIOD EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','280','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2439',NULL,'HIM GRACE PERIOD TERMINATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','281','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2446',NULL,'Dual Medicare/Medicaid From Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','282','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2453',NULL,'Dual Medicare/Medicaid Thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','283','(''DA''=''F'')','EOPTMRXEXPZ0','7','D','10','2460',NULL,'Dual Medicare/Medicaid Medicaid COC End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','284','(''DA''=''F'')','EOPTMRXEXPZ0','234','D','10','2467',NULL,'Filler',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EOPTMRXEXP_20201204.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202101019','EMPEXPORT','OEACTIVE','Nov 23 2020 11:56AM','EOPTMRXEXP',NULL,NULL,NULL,'202101019','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202101011','398','','','202101011',dbo.fn_GetTimedKey(),NULL,'CPETITTI06',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202101111','EMPEXPORT','OEPASSIVE','Dec  4 2020  2:22PM','EOPTMRXEXP',NULL,NULL,NULL,'202101111','Jan 11 2021 12:00AM','Dec 30 1899 12:00AM','202012311','2061','','','202012311',dbo.fn_GetTimedKey(),NULL,'CPETITTI06',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Optum Enrollment Export','202010249','EMPEXPORT','ONDEM_XOE','Nov 10 2020 10:07AM','EOPTMRXEXP',NULL,NULL,NULL,'202010249','Oct 24 2020 12:00AM','Dec 30 1899 12:00AM','202010241','1999','','','202010241',dbo.fn_GetTimedKey(),NULL,'CPETITTI06',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'DWMFR,F5919,ES9NB,EXFO2,EXFPD,EXFRT,EXFMQ,F58ZG,3ZCHW,DBTOP,EXCRB,DWN3N,NZEOQ,EXCB1,F543S,0JPGG,F55CO,EXB7R,EXCDX,F58M4,F55FQ,F54AV,EXC9G,F547S,EXFUM,EXFTJ,EXCT7,F55HW,EXBD3,EF467,EXBFC,EXC7Y',NULL,NULL,NULL,'Optum Enrollment Export-Sched','202010249','EMPEXPORT','SCH_EOPTMR',NULL,'EOPTMRXEXP',NULL,NULL,NULL,'202010249','Oct 24 2020  2:12PM','Oct 24 2020  2:12PM','202010241',NULL,'','','202010241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',DWMFR,F5919,ES9NB,EXFO2,EXFPD,EXFRT,EXFMQ,F58ZG,3ZCHW,DBTOP,EXCRB,DWN3N,NZEOQ,EXCB1,F543S,0JPGG,F55CO,EXB7R,EXCDX,F58M4,F55FQ,F54AV,EXC9G,F547S,EXFUM,EXFTJ,EXCT7,F55HW,EXBD3,EF467,EXBFC,EXC7Y',NULL,NULL,NULL,'Optum Enrollment Export-Test','202011299','EMPEXPORT','TEST_XOE','Dec  1 2020  3:29PM','EOPTMRXEXP',NULL,NULL,NULL,'202011299','Nov 29 2020 12:00AM','Dec 30 1899 12:00AM','202011011','1982','','','202011011',dbo.fn_GetTimedKey(),NULL,'CPETITTI06',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTMRXEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTMRXEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTMRXEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTMRXEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTMRXEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EOPTMRXEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EOPTMRXEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EOPTMRXEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOPTMRXEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTMRXEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTMRXEXP','D10','dbo.U_EOPTMRXEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EOPTMRXEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EOPTMRXEXP] (
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
IF OBJECT_ID('U_EOPTMRXEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EOPTMRXEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EOPTMRXEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EOPTMRXEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvAccount] varchar(4) NULL,
    [drvGroup] varchar(8) NULL,
    [drvMemberId] varchar(1) NOT NULL,
    [drvPersonCode] nvarchar(4000) NULL,
    [drvRelationshipCode] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAdressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvFamilyFlag] varchar(1) NOT NULL,
    [drvFamilyType] varchar(1) NULL,
    [drvMemberFromDate] nvarchar(4000) NULL,
    [drvMemberToDate] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EOPTMRXEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EOPTMRXEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EOPTMRXEXP_File') IS NULL
CREATE TABLE [dbo].[U_EOPTMRXEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2700) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTMRXEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: The Stewart Group

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 10/24/2020
Service Request Number: TekP-2020-09-15-0001

Purpose: Optum Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOPTMRXEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOPTMRXEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOPTMRXEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOPTMRXEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOPTMRXEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTMRXEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTMRXEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTMRXEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTMRXEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTMRXEXP', 'SCH_EOPTMR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EOPTMRXEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EOPTMRXEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EOPTMRXEXP';

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
    DELETE FROM dbo.U_EOPTMRXEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOPTMRXEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EOPTMRXEXP_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'AMEDB,AMEDG,AMEDS,CMEDB,CMEDG,CMEDS,LMEDB,LMEDG,LMEDS,MEDB,MEDG,MEDS';

    IF OBJECT_ID('U_EOPTMRXEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTMRXEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EOPTMRXEXP_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOPTMRXEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EOPTMRXEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTMRXEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' --EedBenStatus + ' :: ' + EecPayGroup + ' :: ' + B.BdmDedCode -- xEEID + ' ' + CASE WHEN B.BdmRecType = 'EMP' THEN '00' ELSE FORMAT(Con_RN, '00') END
        -- standard fields above and additional driver fields below
        ,drvAccount =    CASE WHEN EecPayGroup = 'OFFCUR' AND B.BdmDedCode = 'MEDG' AND EecEmpNo = '1300039' THEN 'LLC7'
                            WHEN EecPayGroup = 'MASNRY' AND B.BdmDedCode = 'MEDG' THEN 'LLC7'
                            WHEN EecPayGroup = 'MASNRY' AND B.BdmDedCode = 'MEDB' THEN 'LLC7'
                            WHEN EecPayGroup = 'MASNRY' AND B.BdmDedCode = 'MEDS' THEN 'LLC7'
                            WHEN EecPayGroup = 'YBPSG' AND B.BdmDedCode = 'MEDG' THEN 'MDSG'
                            WHEN EecPayGroup = 'YBPSG' AND B.BdmDedCode = 'MEDS' THEN 'MDSG'
                            WHEN EecPayGroup = 'YBPSG' AND B.BdmDedCode = 'MEDB' THEN 'MDSG'
                            WHEN EecPayGroup = 'STONE' AND B.BdmDedCode = 'MEDG' THEN 'YBA'
                            WHEN EecPayGroup = 'STONE' AND B.BdmDedCode = 'MEDS' THEN 'YBA'
                            WHEN EecPayGroup = 'STONE' AND B.BdmDedCode = 'MEDB' THEN 'YBA'
                            WHEN EecPayGroup = 'YMG' AND B.BdmDedCode = 'MEDG' THEN 'YMG'
                            WHEN EecPayGroup = 'YMG' AND B.BdmDedCode = 'MEDS' THEN 'YMG'
                            WHEN EecPayGroup = 'YMG' AND B.BdmDedCode = 'MEDB    ' THEN 'YMG'
                            WHEN EecPayGroup IN ('OFFICE','OFFCUR') AND B.BdmDedCode = 'MEDG' THEN 'YBP6'
                            WHEN EecPayGroup IN ('OFFICE','OFFCUR') AND B.BdmDedCode = 'MEDS' THEN 'YBP6'
                            WHEN EecPayGroup IN ('OFFICE','OFFCUR') AND B.BdmDedCode = 'MEDB' THEN 'YBP6'
                            WHEN EecPayGroup = 'SPM' AND B.BdmDedCode = 'MEDG' THEN 'SLD'
                            WHEN EecPayGroup = 'SPM' AND B.BdmDedCode = 'MEDS' THEN 'SLD'
                            WHEN EecPayGroup = 'SPM' AND B.BdmDedCode = 'MEDB' THEN 'SLD'
                            WHEN EecPayGroup = 'ESSG' AND B.BdmDedCode = 'MEDG' THEN 'ESSG'
                            WHEN EecPayGroup = 'ESSG' AND B.BdmDedCode = 'MEDS' THEN 'ESSG'
                            WHEN EecPayGroup = 'ESSG' AND B.BdmDedCode = 'MEDB' THEN 'ESSG'
                            WHEN EecPayGroup = 'WSM' AND B.BdmDedCode = 'CMEDG' THEN 'WSM1'
                            WHEN EecPayGroup = 'WSM' AND B.BdmDedCode = 'CMEDS' THEN 'WSM1'
                            WHEN EecPayGroup = 'WSM' AND B.BdmDedCode = 'CMEDB' THEN 'WSM1'
                            WHEN EecPayGroup = 'WSC' AND B.BdmDedCode = 'CMEDG' THEN 'WSC3'
                            WHEN EecPayGroup = 'WSC' AND B.BdmDedCode = 'CMEDS' THEN 'WSC3'
                            WHEN EecPayGroup = 'WSC' AND B.BdmDedCode = 'CMEDB' THEN 'WSC3'
                            WHEN EecPayGroup = 'AVIAT' AND B.BdmDedCode = 'MEDG' THEN 'YAV5'
                            WHEN EecPayGroup = 'AVIAT' AND B.BdmDedCode = 'MEDS' THEN 'YAV5'
                            WHEN EecPayGroup = 'AVIAT' AND B.BdmDedCode = 'MEDB' THEN 'YAV5'
                            WHEN EecPayGroup IN ('LEWIS','LEWISF') AND B.BdmDedCode IN ('LMEDG','MEDG') THEN 'HHL1'
                            WHEN EecPayGroup IN ('LEWIS','LEWISF') AND B.BdmDedCode IN ('LMEDS','MEDS') THEN 'HHL1'
                            WHEN EecPayGroup IN ('LEWIS','LEWISF') AND B.BdmDedCode IN ('LMEDB','MEDB') THEN 'HHL1'
                            WHEN EecPayGroup = 'RILEY' AND B.BdmDedCode = 'MEDG' THEN 'RWF9'
                            WHEN EecPayGroup = 'RILEY' AND B.BdmDedCode = 'MEDS' THEN 'RWF9'
                            WHEN EecPayGroup = 'RILEY' AND B.BdmDedCode = 'MEDB' THEN 'RWF9'
                            WHEN EecPayGroup IN ('STCON','STCONF') AND B.BdmDedCode = 'MEDG' THEN 'STC3'
                            WHEN EecPayGroup IN ('STCON','STCONF') AND B.BdmDedCode = 'MEDS' THEN 'STC3'
                            WHEN EecPayGroup IN ('STCON','STCONF') AND B.BdmDedCode = 'MEDB' THEN 'STC3'
                            WHEN EecPayGroup = 'STINCF' AND B.BdmDedCode = 'MEDG' THEN 'STE4'
                            WHEN EecPayGroup = 'STINCF' AND B.BdmDedCode = 'MEDS' THEN 'STE4'
                            WHEN EecPayGroup = 'STINCF' AND B.BdmDedCode = 'MEDB' THEN 'STE4'
                            WHEN EecPayGroup = 'STINC' AND B.BdmDedCode = 'MEDG' THEN 'STE4'
                            WHEN EecPayGroup = 'STINC' AND B.BdmDedCode = 'MEDS' THEN 'STE4'
                            WHEN EecPayGroup = 'STINC' AND B.BdmDedCode = 'MEDB' THEN 'STE4'
                            WHEN EecPayGroup IN ('APPCOR','APPSUB','WSTCHV') AND B.BdmDedCode = 'AMEDG' THEN 'WGC7'
                            WHEN EecPayGroup IN ('APPCOR','APPSUB','WSTCHV') AND B.BdmDedCode = 'AMEDS' THEN 'WGC7'
                            WHEN EecPayGroup IN ('APPCOR','APPSUB','WSTCHV') AND B.BdmDedCode = 'AMEDB' THEN 'WGC7'
                            WHEN EecPayGroup = 'APPBMW' AND B.BdmDedCode = 'AMEDG' THEN 'ACB3'
                            WHEN EecPayGroup = 'APPBMW' AND B.BdmDedCode = 'AMEDS' THEN 'ACB3'
                            WHEN EecPayGroup = 'APPBMW' AND B.BdmDedCode = 'AMEDB' THEN 'ACB3'
                            WHEN EecPayGroup = 'APPFOR' AND B.BdmDedCode = 'AMEDG' THEN 'AAG1'
                            WHEN EecPayGroup = 'APPFOR' AND B.BdmDedCode = 'AMEDS' THEN 'AAG1'
                            WHEN EecPayGroup = 'APPFOR' AND B.BdmDedCode = 'AMEDB' THEN 'AAG1'
                            WHEN EecPayGroup = 'APPNIS' AND B.BdmDedCode = 'AMEDG' THEN 'ANI5'
                            WHEN EecPayGroup = 'APPNIS' AND B.BdmDedCode = 'AMEDS' THEN 'ANI5'
                            WHEN EecPayGroup = 'APPNIS' AND B.BdmDedCode = 'AMEDB' THEN 'ANI5'
                            WHEN EecPayGroup = 'APPHON' AND B.BdmDedCode = 'AMEDG' THEN 'AMI4'
                            WHEN EecPayGroup = 'APPHON' AND B.BdmDedCode = 'AMEDS' THEN 'AMI4'
                            WHEN EecPayGroup = 'APPHON' AND B.BdmDedCode = 'AMEDB' THEN 'AMI4'
                            WHEN EecPayGroup = 'RLCHEV' AND B.BdmDedCode = 'AMEDG' THEN 'RLC6'
                            WHEN EecPayGroup = 'RLCHEV' AND B.BdmDedCode = 'AMEDS' THEN 'RLC6'
                            WHEN EecPayGroup = 'RLCHEV' AND B.BdmDedCode = 'AMEDB' THEN 'RLC6'
                            WHEN EecPayGroup = 'CARWA' AND B.BdmDedCode = 'AMEDG' THEN 'ACE2'
                            WHEN EecPayGroup = 'CARWA' AND B.BdmDedCode = 'AMEDS' THEN 'ACE2'
                            WHEN EecPayGroup = 'CARWA' AND B.BdmDedCode = 'AMEDB' THEN 'ACE2'
                            WHEN EecPayGroup = 'BEASFO' AND B.BdmDedCode = 'AMEDG' THEN 'AFY'
                            WHEN EecPayGroup = 'BEASFO' AND B.BdmDedCode = 'AMEDS' THEN 'AFY'
                            WHEN EecPayGroup = 'BEASFO' AND B.BdmDedCode = 'AMEDB' THEN 'AFY'
                            WHEN EecPayGroup = 'PRTZ' AND B.BdmDedCode = 'AMEDG' THEN 'PAB'
                            WHEN EecPayGroup = 'PRTZ' AND B.BdmDedCode = 'AMEDS' THEN 'PAB'
                            WHEN EecPayGroup = 'PRTZ' AND B.BdmDedCode = 'AMEDB' THEN 'PAB'
                            WHEN EecPayGroup = 'HANDOD' AND B.BdmDedCode = 'AMEDG' THEN 'ACD'
                            WHEN EecPayGroup = 'HANDOD' AND B.BdmDedCode = 'AMEDS' THEN 'ACD'
                            WHEN EecPayGroup = 'HANDOD' AND B.BdmDedCode = 'AMEDB' THEN 'ACD'
                            WHEN EecPayGroup = 'RLCOL' AND B.BdmDedCode = 'AMEDG' THEN 'CC3'
                            WHEN EecPayGroup = 'RLCOL' AND B.BdmDedCode = 'AMEDB' THEN 'CC3'
                            WHEN EecPayGroup = 'RLCOL' AND B.BdmDedCode = 'AMEDS' THEN 'CC3'
                            WHEN EecPayGroup = 'EYC' AND B.BdmDedCode = 'AMEDG' THEN 'BCY'
                            WHEN EecPayGroup = 'EYC' AND B.BdmDedCode = 'AMEDS' THEN 'BCY'
                            WHEN EecPayGroup = 'EYC' AND B.BdmDedCode = 'AMEDB' THEN 'BCY'
                            WHEN EecPayGroup = 'YHCOL' AND B.BdmDedCode = 'AMEDG' THEN 'YCC2'
                            WHEN EecPayGroup = 'YHCOL' AND B.BdmDedCode = 'AMEDS' THEN 'YCC2'
                            WHEN EecPayGroup = 'YHCOL' AND B.BdmDedCode = 'AMEDB' THEN 'YCC2'
                            WHEN EecPayGroup = 'HAKES' AND B.BdmDedCode = 'AMEDG' THEN 'HBS'
                            WHEN EecPayGroup = 'HAKES' AND B.BdmDedCode = 'AMEDS' THEN 'HBS'
                            WHEN EecPayGroup = 'HAKES' AND B.BdmDedCode = 'AMEDB' THEN 'HBS'
                            WHEN EecPayGroup = 'EST' AND B.BdmDedCode = 'MEDG' THEN '625'
                            WHEN EecPayGroup = 'EST' AND B.BdmDedCode = 'MEDS' THEN '625'
                            WHEN EecPayGroup = 'EST' AND B.BdmDedCode = 'MEDB' THEN '625'
                            WHEN EecPayGroup = 'HMA' AND B.BdmDedCode = 'MEDG' THEN 'HMA'
                            WHEN EecPayGroup = 'HMA' AND B.BdmDedCode = 'MEDS' THEN 'HMA'
                            WHEN EecPayGroup = 'HMA' AND B.BdmDedCode = 'MEDB' THEN 'HMA'
                            WHEN EecPayGroup = 'HANHON' AND B.BdmDedCode = 'AMEDG' THEN 'AHI' 
                            WHEN EecPayGroup = 'HANHON' AND B.BdmDedCode = 'AMEDS' THEN 'AHI'
                            WHEN EecPayGroup = 'HANHON' AND B.BdmDedCode = 'AMEDB' THEN 'AHI' 

                            WHEN EecPayGroup = 'APPYAS' AND B.BdmDedCode = 'AMEDG' THEN 'YAS'
                            WHEN EecPayGroup = 'APPYAS' AND B.BdmDedCode = 'AMEDS' THEN 'YAS'
                            WHEN EecPayGroup = 'APPYAS' AND B.BdmDedCode = 'AMEDB' THEN 'YAS'
                            WHEN EecPayGroup = 'APPAOL' AND B.BdmDedCode = 'AMEDG' THEN 'AOL'
                            WHEN EecPayGroup = 'APPAOL' AND B.BdmDedCode = 'AMEDS' THEN 'AOL'
                            WHEN EecPayGroup = 'APPAOL' AND B.BdmDedCode = 'AMEDB' THEN 'AOL'                            
                        END
        ,drvGroup =    CASE WHEN EecPayGroup IN ('OFFCUR') AND B.BdmDedCode = 'MEDG' AND EecEmpNo = '1300039' THEN '2548864'
                        WHEN EecPayGroup IN ('MASNRY') AND B.BdmDedCode = 'MEDG' THEN '2548800'
                        WHEN EecPayGroup IN ('MASNRY') AND B.BdmDedCode = 'MEDS' THEN '2548900'
                        WHEN EecPayGroup IN ('MASNRY') AND B.BdmDedCode = 'MEDB' THEN '2563000'
                        WHEN EecPayGroup IN ('YBPSG') AND B.BdmDedCode = 'MEDG' THEN '2548802'
                        WHEN EecPayGroup IN ('YBPSG') AND B.BdmDedCode = 'MEDS' THEN '2548902'
                        WHEN EecPayGroup IN ('YBPSG') AND B.BdmDedCode = 'MEDB' THEN '2563002'
                        WHEN EecPayGroup IN ('STONE') AND B.BdmDedCode = 'MEDG' THEN '2548804'
                        WHEN EecPayGroup IN ('STONE') AND B.BdmDedCode = 'MEDS' THEN '2548904'
                        WHEN EecPayGroup IN ('STONE') AND B.BdmDedCode = 'MEDB' THEN '2563004'
                        WHEN EecPayGroup IN ('YMG') AND B.BdmDedCode = 'MEDG' THEN '2548806'
                        WHEN EecPayGroup IN ('YMG') AND B.BdmDedCode = 'MEDS' THEN '2548906'
                        WHEN EecPayGroup IN ('YMG') AND B.BdmDedCode = 'MEDB' THEN '2563006'
                        WHEN EecPayGroup IN ('OFFICE','OFFCUR') AND B.BdmDedCode = 'MEDG' THEN '2548808'
                        WHEN EecPayGroup IN ('OFFICE','OFFCUR') AND B.BdmDedCode = 'MEDS' THEN '2548908'
                        WHEN EecPayGroup IN ('OFFICE','OFFCUR') AND B.BdmDedCode = 'MEDB' THEN '2563008'
                        WHEN EecPayGroup IN ('SPM') AND B.BdmDedCode = 'MEDG' THEN '2548810'
                        WHEN EecPayGroup IN ('SPM') AND B.BdmDedCode = 'MEDS' THEN '2548910'
                        WHEN EecPayGroup IN ('SPM') AND B.BdmDedCode = 'MEDB' THEN '2563010'
                        WHEN EecPayGroup IN ('ESSG') AND B.BdmDedCode = 'MEDG' THEN '2548812'
                        WHEN EecPayGroup IN ('ESSG') AND B.BdmDedCode = 'MEDS' THEN '2548912'
                        WHEN EecPayGroup IN ('ESSG') AND B.BdmDedCode = 'MEDB' THEN '2563012'
                        WHEN EecPayGroup IN ('WSM') AND B.BdmDedCode = 'CMEDG' THEN '2548816'
                        WHEN EecPayGroup IN ('WSM') AND B.BdmDedCode = 'CMEDS' THEN '2548916'
                        WHEN EecPayGroup IN ('WSM') AND B.BdmDedCode = 'CMEDB' THEN '2563016'
                        WHEN EecPayGroup IN ('WSC') AND B.BdmDedCode = 'CMEDG' THEN '2548818'
                        WHEN EecPayGroup IN ('WSC') AND B.BdmDedCode = 'CMEDS' THEN '2548918'
                        WHEN EecPayGroup IN ('WSC') AND B.BdmDedCode = 'CMEDB' THEN '2563018'
                        WHEN EecPayGroup IN ('AVIAT') AND B.BdmDedCode = 'MEDG' THEN '2548820'
                        WHEN EecPayGroup IN ('AVIAT') AND B.BdmDedCode = 'MEDS' THEN '2548920'
                        WHEN EecPayGroup IN ('AVIAT') AND B.BdmDedCode = 'MEDB' THEN '2563020'
                        WHEN EecPayGroup IN ('LEWIS','LEWISF') AND B.BdmDedCode IN ('LMEDG','MEDG') THEN '2548822'
                        WHEN EecPayGroup IN ('LEWIS','LEWISF') AND B.BdmDedCode IN ('LMEDS','MEDS') THEN '2548922'
                        WHEN EecPayGroup IN ('LEWIS','LEWISF') AND B.BdmDedCode IN ('LMEDB','MEDB') THEN '2563022'
                        WHEN EecPayGroup IN ('RILEY') AND B.BdmDedCode = 'MEDG' THEN '2548824'
                        WHEN EecPayGroup IN ('RILEY') AND B.BdmDedCode = 'MEDS' THEN '2548924'
                        WHEN EecPayGroup IN ('RILEY') AND B.BdmDedCode = 'MEDB' THEN '2563024'
                        WHEN EecPayGroup IN ('STCON','STCONF') AND B.BdmDedCode = 'MEDG' THEN '2548826'
                        WHEN EecPayGroup IN ('STCON','STCONF') AND B.BdmDedCode = 'MEDS' THEN '2548926'
                        WHEN EecPayGroup IN ('STCON','STCONF') AND B.BdmDedCode = 'MEDB' THEN '2563026'
                        WHEN EecPayGroup IN ('STINCF') AND B.BdmDedCode = 'MEDG' THEN '2548828'
                        WHEN EecPayGroup IN ('STINCF') AND B.BdmDedCode = 'MEDS' THEN '2548928'
                        WHEN EecPayGroup IN ('STINCF') AND B.BdmDedCode = 'MEDB' THEN '2563028'
                        WHEN EecPayGroup IN ('STINC') AND B.BdmDedCode = 'MEDG' THEN '2548830'
                        WHEN EecPayGroup IN ('STINC') AND B.BdmDedCode = 'MEDS' THEN '2548930'
                        WHEN EecPayGroup IN ('STINC') AND B.BdmDedCode = 'MEDB' THEN '2563030'
                        WHEN EecPayGroup IN ('APPCOR','APPSUB','WSTCHV') AND B.BdmDedCode = 'AMEDG' THEN '2548832'
                        WHEN EecPayGroup IN ('APPCOR','APPSUB','WSTCHV') AND B.BdmDedCode = 'AMEDS' THEN '2548932'
                        WHEN EecPayGroup IN ('APPCOR','APPSUB','WSTCHV') AND B.BdmDedCode = 'AMEDB' THEN '2563032'
                        WHEN EecPayGroup IN ('APPBMW') AND B.BdmDedCode = 'AMEDG' THEN '2548834'
                        WHEN EecPayGroup IN ('APPBMW') AND B.BdmDedCode = 'AMEDS' THEN '2548934'
                        WHEN EecPayGroup IN ('APPBMW') AND B.BdmDedCode = 'AMEDB' THEN '2563034'
                        WHEN EecPayGroup IN ('APPFOR') AND B.BdmDedCode = 'AMEDG' THEN '2548836'
                        WHEN EecPayGroup IN ('APPFOR') AND B.BdmDedCode = 'AMEDS' THEN '2548936'
                        WHEN EecPayGroup IN ('APPFOR') AND B.BdmDedCode = 'AMEDB' THEN '2563036'
                        WHEN EecPayGroup IN ('APPNIS') AND B.BdmDedCode = 'AMEDG' THEN '2548838'
                        WHEN EecPayGroup IN ('APPNIS') AND B.BdmDedCode = 'AMEDS' THEN '2548938'
                        WHEN EecPayGroup IN ('APPNIS') AND B.BdmDedCode = 'AMEDB' THEN '2563038'
                        WHEN EecPayGroup IN ('APPHON') AND B.BdmDedCode = 'AMEDG' THEN '2548840'
                        WHEN EecPayGroup IN ('APPHON') AND B.BdmDedCode = 'AMEDS' THEN '2548940'
                        WHEN EecPayGroup IN ('APPHON') AND B.BdmDedCode = 'AMEDB' THEN '2563040'
                        WHEN EecPayGroup IN ('RLCHEV') AND B.BdmDedCode = 'AMEDG' THEN '2548842'
                        WHEN EecPayGroup IN ('RLCHEV') AND B.BdmDedCode = 'AMEDS' THEN '2548942'
                        WHEN EecPayGroup IN ('RLCHEV') AND B.BdmDedCode = 'AMEDB' THEN '2563042'
                        WHEN EecPayGroup IN ('CARWA') AND B.BdmDedCode = 'AMEDG' THEN '2548844'
                        WHEN EecPayGroup IN ('CARWA') AND B.BdmDedCode = 'AMEDS' THEN '2548944'
                        WHEN EecPayGroup IN ('CARWA') AND B.BdmDedCode = 'AMEDB' THEN '2563044'
                        WHEN EecPayGroup IN ('BEASFO') AND B.BdmDedCode = 'AMEDG' THEN '2548846'
                        WHEN EecPayGroup IN ('BEASFO') AND B.BdmDedCode = 'AMEDS' THEN '2548946'
                        WHEN EecPayGroup IN ('BEASFO') AND B.BdmDedCode = 'AMEDB' THEN '2563046'
                        WHEN EecPayGroup IN ('PRTZ') AND B.BdmDedCode = 'AMEDG' THEN '2548848'
                        WHEN EecPayGroup IN ('PRTZ') AND B.BdmDedCode = 'AMEDS' THEN '2548948'
                        WHEN EecPayGroup IN ('PRTZ') AND B.BdmDedCode = 'AMEDB' THEN '2563048'
                        WHEN EecPayGroup IN ('HANDOD') AND B.BdmDedCode = 'AMEDG' THEN '2548850'
                        WHEN EecPayGroup IN ('HANDOD') AND B.BdmDedCode = 'AMEDS' THEN '2548950'
                        WHEN EecPayGroup IN ('HANDOD') AND B.BdmDedCode = 'AMEDB' THEN '2563050'
                        WHEN EecPayGroup IN ('RLCOL') AND B.BdmDedCode = 'AMEDG' THEN '2548852'
                        WHEN EecPayGroup IN ('RLCOL') AND B.BdmDedCode = 'AMEDB' THEN '2563052'
                        WHEN EecPayGroup IN ('RLCOL') AND B.BdmDedCode = 'AMEDS' THEN '2548856'
                        WHEN EecPayGroup IN ('EYC') AND B.BdmDedCode = 'AMEDG' THEN '2548858'
                        WHEN EecPayGroup IN ('EYC') AND B.BdmDedCode = 'AMEDS' THEN '2548952'
                        WHEN EecPayGroup IN ('EYC') AND B.BdmDedCode = 'AMEDB' THEN '2563054'
                        WHEN EecPayGroup IN ('YHCOL') AND B.BdmDedCode = 'AMEDG' THEN '2549922'
                        WHEN EecPayGroup IN ('YHCOL') AND B.BdmDedCode = 'AMEDS' THEN '2549924'
                        WHEN EecPayGroup IN ('YHCOL') AND B.BdmDedCode = 'AMEDB' THEN '2563056'
                        WHEN EecPayGroup IN ('HAKES') AND B.BdmDedCode = 'AMEDG' THEN '2548860'
                        WHEN EecPayGroup IN ('HAKES') AND B.BdmDedCode = 'AMEDS' THEN '2548960'
                        WHEN EecPayGroup IN ('HAKES') AND B.BdmDedCode = 'AMEDB' THEN '2563058'
                        WHEN EecPayGroup IN ('EST') AND B.BdmDedCode = 'MEDG' THEN '2548862'
                        WHEN EecPayGroup IN ('EST') AND B.BdmDedCode = 'MEDS' THEN '2548962'
                        WHEN EecPayGroup IN ('EST') AND B.BdmDedCode = 'MEDB' THEN '2563060'
                        WHEN EecPayGroup IN ('HMA') AND B.BdmDedCode = 'MEDG' THEN '10502810'
                        WHEN EecPayGroup IN ('HMA') AND B.BdmDedCode = 'MEDS' THEN '10502812'
                        WHEN EecPayGroup IN ('HMA') AND B.BdmDedCode = 'MEDB' THEN '10502814'
                        WHEN EecPayGroup IN ('HANHON') AND B.BdmDedCode = 'AMEDG' THEN '10511072'
                        WHEN EecPayGroup IN ('HANHON') AND B.BdmDedCode = 'AMEDS' THEN '10511074'
                        WHEN EecPayGroup IN ('HANHON') AND B.BdmDedCode = 'AMEDB' THEN '10511076'

                        WHEN EecPayGroup IN ('APPYAS') AND B.BdmDedCode = 'AMEDG' THEN '10548470'
                        WHEN EecPayGroup IN ('APPYAS') AND B.BdmDedCode = 'AMEDS' THEN '10548472'
                        WHEN EecPayGroup IN ('APPYAS') AND B.BdmDedCode = 'AMEDB' THEN '10548474'
                        WHEN EecPayGroup IN ('APPAOL') AND B.BdmDedCode = 'AMEDG' THEN '10548476'
                        WHEN EecPayGroup IN ('APPAOL') AND B.BdmDedCode = 'AMEDS' THEN '10548478'
                        WHEN EecPayGroup IN ('APPAOL') AND B.BdmDedCode = 'AMEDB' THEN '10548480'
                        END
        ,drvMemberId = '' --EepSSN
        ,drvPersonCode =    CASE WHEN B.BdmRecType = 'EMP' THEN '00'
                                ELSE FORMAT(Con_RN, '00')
                            END
        ,drvRelationshipCode =    CASE WHEN B.BdmRecType = 'EMP' THEN '1'
                                    WHEN ConRelationship IN ('SPS') THEN '2'
                                    WHEN ConRelationship IN ('CHL','STC') THEN '3'
                                END
        ,drvNameLast = CASE WHEN B.BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN B.BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddle = CASE WHEN B.BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvGender = CASE WHEN B.BdmRecType = 'EMP' THEN CASE WHEN EepGender IN ('M','F','N') THEN EepGender ELSE 'U' END
                        ELSE CASE WHEN ConGender IN ('M','F','N') THEN ConGender ELSE 'U' END
                    END
        ,drvDateOfBirth = CASE WHEN B.BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvSSN = EepSSN -- CASE WHEN B.BdmRecType = 'DEP' THEN ConSSN END --EepSSN-- CASE WHEN B.BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvAddressLine1 = EepAddressLine1 --CASE WHEN B.BdmRecType = 'EMP' THEN EepAddressLine1 ELSE ConAddressLine1 END
        ,drvAddressLine2 = EepAddressLine2 --CASE WHEN B.BdmRecType = 'EMP' THEN EepAddressLine2 ELSE ConAddressLine2 END
        ,drvAddressCity = EepAddressCity --CASE WHEN B.BdmRecType = 'EMP' THEN EepAddressCity ELSE ConAddressCity END
        ,drvAdressState = EepAddressState --CASE WHEN B.BdmRecType = 'EMP' THEN EepAddressState ELSE ConAddressState END
        ,drvAddressZipCode = EepAddressZipCode --CASE WHEN B.BdmRecType = 'EMP' THEN EepAddressZipCode ELSE ConAddressZipCode END
        ,drvPhone = EepPhoneHomeNumber
        ,drvFamilyFlag = CASE WHEN B.BdmBenOption = 'EE' THEN 'N' ELSE 'Y' END
        ,drvFamilyType =    CASE WHEN B.BdmBenOption IN ('EE2','EEFAMW') THEN '1'
                                WHEN B.BdmBenOption    IN ('EE','EEWI') THEN '2'
                                WHEN B.BdmBenOption IN ('EESPOU','EESPWI') THEN '3'
                                WHEN B.BdmBenOption IN ('EECH','EECHW') THEN '4'
                            END
                            --CYYMMDD
        ,drvMemberFromDate = CASE WHEN B.BdmBenStatusDate > '1/1/2021' THEN '1' + RIGHT(FORMAT(DATEPART(YEAR, B.BdmBenStatusDate), '00'), 2) + FORMAT(DATEPART(MONTH, B.BdmBenStatusDate), '00') + FORMAT(DATEPART(DAY, B.BdmBenStatusDate), '00') ELSE '1210101' END
        ,drvMemberToDate =    CASE WHEN B.BdmBenStopDate IS NULL THEN '1391231'
                                ELSE '1' + RIGHT(FORMAT(DATEPART(YEAR, B.BdmBenStopDate), '00'), 2) + FORMAT(DATEPART(MONTH, B.BdmBenStopDate), '00') + FORMAT(DATEPART(DAY, B.BdmBenStopDate), '00')
                            END
        --B.BdmBenStopDate
    INTO dbo.U_EOPTMRXEXP_drvTbl
    FROM dbo.U_EOPTMRXEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EOPTMRXEXP B WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN (
            SELECT ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY ConEEID, /*ConSystemID*/ CASE WHEN ConRelationship IN ('SPS') THEN 1 ELSE 2 END) AS Con_RN, * 
            FROM dbo.Contacts WITH (NOLOCK)
            /*JOIN dbo.U_dsi_BDM_EOPTMRXEXP A WITH (NOLOCK)
                ON ConSystemID = A.BdmDepRecID*/
        ) AS Con
        ON ConEEID = xEEID
        AND ConSystemID = B.BdmDepRecID
    JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND B.BdmDedCode = EedDedCode 
        AND EedBenStatus = 'A'
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
ALTER VIEW dbo.dsi_vwEOPTMRXEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOPTMRXEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EOPTMRXEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202010171'
       ,expStartPerControl     = '202010171'
       ,expLastEndPerControl   = '202010249'
       ,expEndPerControl       = '202010249'
WHERE expFormatCode = 'EOPTMRXEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEOPTMRXEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EOPTMRXEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort