SET NOCOUNT ON;
IF OBJECT_ID('U_ESEQDEMEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESEQDEMEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESEQDEMEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESEQDEMEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESEQDEMEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESEQDEMEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESEQDEMEXP];
GO
IF OBJECT_ID('U_ESEQDEMEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMEXP_File];
GO
IF OBJECT_ID('U_ESEQDEMEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMEXP_EEList];
GO
IF OBJECT_ID('U_ESEQDEMEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMEXP_drvTbl];
GO
IF OBJECT_ID('U_ESEQDEMEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMEXP_DedList];
GO
IF OBJECT_ID('U_ESEQDEMEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMEXP_AuditFields];
GO
IF OBJECT_ID('U_ESEQDEMEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESEQDEMEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESEQDEMEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESEQDEMEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESEQDEMEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESEQDEMEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESEQDEMEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESEQDEMEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESEQDEMEXP','Sequoia Demographic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ESEQDEMEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESEQDEMEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COMPANY NAME"','1','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','1',NULL,'COMPANY NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE ID"','2','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','2',NULL,'EMPLOYEE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE SSN"','3','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','3',NULL,'EMPLOYEE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MEMBER SSN"','4','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','4',NULL,'MEMBER SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NEW MEMBER SSN"','5','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','5',NULL,'NEW MEMBER SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN CHANGE TYPE"','6','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','6',NULL,'SSN CHANGE TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','7','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','7',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','8','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','8',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE NAME"','9','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','9',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','10','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','10',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RELATIONSHIP"','11','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','11',NULL,'RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','12','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','12',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MARITAL STATUS"','13','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','13',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE STATUS"','14','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','14',NULL,'EMPLOYEE STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE STATUS DATE"','15','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','15',NULL,'EMPLOYEE STATUS DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HIRE DATE"','16','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','16',NULL,'HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STREET ADDRESS1"','17','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','17',NULL,'STREET ADDRESS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STREET ADDRESS2"','18','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','18',NULL,'STREET ADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY"','19','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','19',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATE"','20','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','20',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP"','21','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','21',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOME PHONE"','22','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','22',NULL,'HOME PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CELL PHONE"','23','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','23',NULL,'CELL PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WORK PHONE"','24','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','24',NULL,'WORK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WORK EMAIL"','25','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','25',NULL,'WORK EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"JOB TITLE"','26','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','26',NULL,'JOB TITLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE LOCATION"','27','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','27',NULL,'EMPLOYEE LOCATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE LOCATION EFFECTIVE DATE"','28','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','28',NULL,'EMPLOYEE LOCATION EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE CLASS"','29','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','29',NULL,'EMPLOYEE CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE CLASS EFFECTIVE DATE"','30','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','30',NULL,'EMPLOYEE CLASS EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE DEPARTMENT"','31','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','31',NULL,'EMPLOYEE DEPARTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE DEPARTMENT EFFECTIVE DATE"','32','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','32',NULL,'EMPLOYEE DEPARTMENT EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE DIVISION"','33','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','33',NULL,'EMPLOYEE DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE DIVISION EFFECTIVE DATE"','34','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','34',NULL,'EMPLOYEE DIVISION EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAY FREQUENCY"','35','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','35',NULL,'PAY FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURS PER WEEK"','36','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','36',NULL,'HOURS PER WEEK',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ANNUAL WAGES"','37','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','37',NULL,'ANNUAL WAGES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WAGES EFFECTIVE DATE"','38','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','38',NULL,'WAGES EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"APPLICATION PERSON ID"','39','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','39',NULL,'APPLICATION PERSON ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN YEAR"','40','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','40',NULL,'PLAN YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN TYPE"','41','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','41',NULL,'PLAN TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN GROUP NUMBER"','42','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','42',NULL,'PLAN GROUP NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLASS CODE"','43','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','43',NULL,'CLASS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT STATUS"','44','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','44',NULL,'ENROLLMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT START DATE"','45','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','45',NULL,'ENROLLMENT START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT END DATE"','46','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','46',NULL,'ENROLLMENT END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ORIGINAL ENROLLMENT START DATE"','47','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','47',NULL,'ORIGINAL ENROLLMENT START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"APPROVED AMOUNT"','48','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','48',NULL,'APPROVED AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REQUESTED AMOUNT"','49','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','49',NULL,'REQUESTED AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT TYPE"','50','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','50',NULL,'ENROLLMENT TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVERAGE DESCRIPTION"','51','(''DA''=''T,'')','ESEQDEMEXPZ0','50','H','01','51',NULL,'COVERAGE DESCRIPTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVERAGE TIER"','52','(''DA''=''T'')','ESEQDEMEXPZ0','50','H','01','52',NULL,'COVERAGE TIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Crossover"','1','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','1',NULL,'COMPANY NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','2','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','2',NULL,'EMPLOYEE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','3','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','3',NULL,'EMPLOYEE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberSSN"','4','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','4',NULL,'MEMBER SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','5',NULL,'NEW MEMBER SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','6',NULL,'SSN CHANGE TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','7',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','8',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','9',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','10','(''UD101''=''T,'')','ESEQDEMEXPZ0','50','D','10','10',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','11','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','11',NULL,'RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','12',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','13',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','14','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','14',NULL,'EMPLOYEE STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatusDate"','15','(''UD101''=''T,'')','ESEQDEMEXPZ0','50','D','10','15',NULL,'EMPLOYEE STATUS DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','16','(''UD101''=''T,'')','ESEQDEMEXPZ0','50','D','10','16',NULL,'HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','17','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','17',NULL,'STREET ADDRESS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','18','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','18',NULL,'STREET ADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','19','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','19',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','20','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','20',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip"','21','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','21',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','22','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','22',NULL,'HOME PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','23',NULL,'CELL PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','24',NULL,'WORK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmail"','25','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','25',NULL,'WORK EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','26','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','26',NULL,'JOB TITLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLocation"','27','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','27',NULL,'EMPLOYEE LOCATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLocEffictiveDate"','28','(''UD101''=''T,'')','ESEQDEMEXPZ0','50','D','10','28',NULL,'EMPLOYEE LOCATION EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeClass"','29','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','29',NULL,'EMPLOYEE CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','30',NULL,'EMPLOYEE CLASS EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDepartment"','31','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','31',NULL,'EMPLOYEE DEPARTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDeptEffectiveDate"','32','(''UD101''=''T,'')','ESEQDEMEXPZ0','50','D','10','32',NULL,'EMPLOYEE DEPARTMENT EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','33',NULL,'EMPLOYEE DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','34',NULL,'EMPLOYEE DIVISION EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','35','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','35',NULL,'PAY FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerWeek"','36','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','36',NULL,'HOURS PER WEEK',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualWages"','37','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','37',NULL,'ANNUAL WAGES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWagesEffectiveDate"','38','(''UD101''=''T,'')','ESEQDEMEXPZ0','50','D','10','38',NULL,'WAGES EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','39',NULL,'APPLICATION PERSON ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYear"','40','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','40',NULL,'PLAN YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanType"','41','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','41',NULL,'PLAN TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanGroupNumber"','42','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','42',NULL,'PLAN GROUP NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','43',NULL,'CLASS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus"','44','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','44',NULL,'ENROLLMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStartDate"','45','(''UD101''=''T,'')','ESEQDEMEXPZ0','50','D','10','45',NULL,'ENROLLMENT START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStopDate"','46','(''UD101''=''T,'')','ESEQDEMEXPZ0','50','D','10','46',NULL,'ENROLLMENT END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T,'')','ESEQDEMEXPZ0','50','D','10','47',NULL,'ORIGINAL ENROLLMENT START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApprovedAmount"','48','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','48',NULL,'APPROVED AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRequestedAmount"','49','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','49',NULL,'REQUESTED AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentType"','50','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','50',NULL,'ENROLLMENT TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageDescription"','51','(''UA''=''T,'')','ESEQDEMEXPZ0','50','D','10','51',NULL,'COVERAGE DESCRIPTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTier"','52','(''UA''=''T'')','ESEQDEMEXPZ0','50','D','10','52',NULL,'COVERAGE TIER',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESEQDEMEXP_20201016.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202009169','EMPEXPORT','OEACTIVE','Sep 18 2020  4:08PM','ESEQDEMEXP',NULL,NULL,NULL,'202009169','Aug 25 2020  5:33PM','Aug 25 2020  5:33PM','202001011','4326','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202009169','EMPEXPORT','OEPASSIVE','Sep 18 2020  4:08PM','ESEQDEMEXP',NULL,NULL,NULL,'202009169','Aug 25 2020  5:33PM','Aug 25 2020  5:33PM','202001011','5590','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Sequoia Demographic Export','202009169','EMPEXPORT','ONDEM_XOE','Sep 18 2020  4:09PM','ESEQDEMEXP',NULL,NULL,NULL,'202009169','Aug 25 2020  5:33PM','Aug 25 2020  5:33PM','202001011','5645','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Sequoia Demographic Expo-Sched','202009169','EMPEXPORT','SCH_ESEQDE','Sep 18 2020  4:09PM','ESEQDEMEXP',NULL,NULL,NULL,'202009169','Aug 25 2020  5:33PM','Aug 25 2020  5:33PM','202001011','5645','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Sequoia Demographic Expo-Test','202010149','EMPEXPORT','TEST_XOE','Oct 15 2020  1:53PM','ESEQDEMEXP',NULL,NULL,NULL,'202010149','Oct 14 2020 12:00AM','Dec 30 1899 12:00AM','202009301','4490','','','202009301',dbo.fn_GetTimedKey(),NULL,'us3rVaCRO1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESEQDEMEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESEQDEMEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESEQDEMEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEQDEMEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEQDEMEXP','D10','dbo.U_ESEQDEMEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ESEQDEMEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESEQDEMEXP] (
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
IF OBJECT_ID('U_ESEQDEMEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMEXP_Audit] (
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
IF OBJECT_ID('U_ESEQDEMEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ESEQDEMEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESEQDEMEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvEmployeeID] varchar(8000) NULL,
    [drvEmployeeSSN] varchar(8000) NULL,
    [drvMemberSSN] varchar(8000) NULL,
    [drvNameFirst] varchar(102) NULL,
    [drvNameLast] varchar(102) NULL,
    [drvDateOfBirth] varchar(32) NULL,
    [drvRelationship] varchar(24) NULL,
    [drvGender] varchar(3) NULL,
    [drvEmployeeStatus] varchar(12) NULL,
    [drvEmployeeStatusDate] varchar(32) NULL,
    [drvHireDate] varchar(32) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(257) NULL,
    [drvAddressState] varchar(257) NULL,
    [drvAddressZip] varchar(52) NULL,
    [drvPhoneHomeNumber] varchar(8000) NOT NULL,
    [drvWorkEmail] varchar(52) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvEmployeeLocation] varchar(27) NULL,
    [drvEmpLocEffictiveDate] varchar(32) NULL,
    [drvEmployeeClass] varchar(18) NULL,
    [drvEmployeeDepartment] varchar(8000) NULL,
    [drvEmpDeptEffectiveDate] varchar(32) NULL,
    [drvPayFrequency] varchar(3) NULL,
    [drvHoursPerWeek] nvarchar(4000) NULL,
    [drvAnnualWages] varchar(32) NULL,
    [drvWagesEffectiveDate] varchar(32) NULL,
    [drvPlanYear] varchar(32) NULL,
    [drvPlanType] varchar(5) NULL,
    [drvPlanGroupNumber] varchar(9) NULL,
    [drvEnrollmentStatus] varchar(12) NOT NULL,
    [drvEnrollmentStartDate] varchar(32) NULL,
    [drvEnrollmentStopDate] varchar(32) NULL,
    [drvApprovedAmount] nvarchar(4000) NULL,
    [drvRequestedAmount] nvarchar(4000) NULL,
    [drvEnrollmentType] varchar(3) NULL,
    [drvCoverageDescription] varchar(1) NOT NULL,
    [drvCoverageTier] varchar(5) NULL
);
IF OBJECT_ID('U_ESEQDEMEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESEQDEMEXP_File') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESEQDEMEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Crossover

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 08/25/2020
Service Request Number: TekP-2020-08-05-0001

Purpose: Sequoia Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESEQDEMEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESEQDEMEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESEQDEMEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESEQDEMEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESEQDEMEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMEXP', 'SCH_ESEQDE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESEQDEMEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESEQDEMEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESEQDEMEXP';

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
    DELETE FROM dbo.U_ESEQDEMEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESEQDEMEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ESEQDEMEXP_EEList WHERE xEEID IN (
        SELECT distinct EecEEID from dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MEDFT, MEDPT,GLIFE,UNVOL,VOLSP,VOLCH,LTD,STD,DENFT, DENPT, VISFT, VISPT';
    --SET @DedList = 'MEDFT, MEDPT,GTL,UNVOL,VOLSP,VOLCH,LTD,STD,DENFT, DENPT, VISFT, VISPT';

    IF OBJECT_ID('U_ESEQDEMEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESEQDEMEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

 --==========================================
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_ESEQDEMEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMEXP_AuditFields;
    CREATE TABLE dbo.U_ESEQDEMEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ESEQDEMEXP_AuditFields VALUES ('empcomp','EecLocation');    
    -- Create audit table
    IF OBJECT_ID('U_ESEQDEMEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMEXP_Audit;
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
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY AudDateTime DESC)
    INTO dbo.U_ESEQDEMEXP_Audit
    FROM dbo.U_ESEQDEMEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ESEQDEMEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
      ;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESEQDEMEXP_Audit ON dbo.U_ESEQDEMEXP_Audit (audEEID, audKey2);

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
    -- DETAIL RECORD - U_ESEQDEMEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESEQDEMEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort =  xEEID + ' ' + CASE WHEN  BdmRecType = 'EMP' THEN '1' ELSE '2' END
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = '"' + REPLACE(EecEmpNo, ' ','') + '"'
        ,drvEmployeeSSN = '"' + REPLACE(eepSSN, ' ', '') + '"'
        ,drvMemberSSN = '"' + REPLACE(CASE WHEN BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END, ' ', '') + '"'
        ,drvNameFirst = '"' + CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END + '"'
        ,drvNameLast = '"' + CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END + '"'
        ,drvDateOfBirth = '"' + CONVERT(VARCHAR, CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END, 101) + '"'
        ,drvRelationship =    '"' + CASE WHEN BdmRecType = 'EMP' THEN 'Employee'
                                ELSE
                                    CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partner'
                                        WHEN ConRelationship IN ('CHL', 'DDP') THEN 'Child'
                                        WHEN ConRelationship = 'DPC' THEN 'Domestic Partner Child'
                                        --ELSE ConRelationship
                                    END
                            END + '"'
        ,drvGender = '"' + CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END + '"'
        ,drvEmployeeStatus =    CASE WHEN BdmRecType = 'EMP' THEN
                                    '"' + CASE WHEN EecEmplStatus = 'T' THEN 'Terminated'
                                        WHEN EecEmplStatus = 'L' THEN 'L1'
                                        WHEN EecFullTimeOrPartTime = 'P' THEN 'PT'
                                        WHEN EecFullTimeOrPartTime = 'F' THEN 'FT'
                                    END + '"'
                                END
        ,drvEmployeeStatusDate =    CASE WHEN BdmRecType = 'EMP' THEN
                                        '"' + CONVERT(VARCHAR, EecEmplStatusStartDate, 101) + '"'
                                    END
        ,drvHireDate =    CASE WHEN BdmRecType = 'EMP' THEN
                            '"' + CONVERT(VARCHAR, EecDateOfLastHire , 101) + '"'
                        END
        ,drvAddressLine1 = '"' + REPLACE(EepAddressLine1, ',', '') + '"'
        ,drvAddressLine2 = '"' + REPLACE(REPLACE(ISNULL(EepAddressLine2, ''), ',', ''), '  ', '') + '"'
        ,drvAddressCity = '"' + EepAddressCity + '"'
        ,drvAddressState = '"' + EepAddressState + '"'
        ,drvAddressZip = '"' + EepAddressZipCode + '"'
        ,drvPhoneHomeNumber = '"' + ISNULL(REPLACE(EepPhoneHomeNumber, '  ', ''), '') + '"'
        ,drvWorkEmail =    CASE WHEN BdmRecType = 'EMP' THEN
                            '"' + ISNULL(EepAddressEMail, '') + '"'
                        END
        ,drvJobTitle =    CASE WHEN BdmRecType = 'EMP' THEN
                            '"' + REPLACE(JbcDesc, ',', '') + '"'
                        END
        ,drvEmployeeLocation =    CASE WHEN BdmRecType = 'EMP' THEN
                                    '"' + LocDesc + '"'
                                END
        ,drvEmpLocEffictiveDate =    CASE WHEN BdmRecType = 'EMP' THEN
                                        '"' + CONVERT(VARCHAR, audDateTime, 101) + '"'
                                    END
        ,drvEmployeeClass =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN CbgBenGroupCode = 'FTEE' THEN 'Full Time Employee' 
                                    WHEN CbgBenGroupCode = 'PTEE' THEN 'Part Time Employee'
                                    WHEN CbgBenGroupCode = 'TEMPE' THEN 'Temporary Employee'
                                END
                            END
        ,drvEmployeeDepartment =    CASE WHEN BdmRecType = 'EMP' THEN
                                        '"' + REPLACE(EecOrgLvl1, ' ', '') + '"'
                                    END
        ,drvEmpDeptEffectiveDate =    CASE WHEN BdmRecType = 'EMP' THEN
                                        '"' + CONVERT(VARCHAR, EjhJobEffDate, 101) + '"'
                                    END
        ,drvPayFrequency =    CASE WHEN BdmRecType = 'EMP' THEN
                                '"' + PgrPayFrequency + '"'
                            END
        ,drvHoursPerWeek =    CASE WHEN BdmRecType = 'EMP' THEN
                                '"' + FORMAT(EecScheduledWorkHrs, '#0.00') + '"'
                            END
        ,drvAnnualWages =    CASE WHEN BdmRecType = 'EMP' THEN
                                '"' + CAST(EecAnnSalary AS VARCHAR) + '"'
                            END
        ,drvWagesEffectiveDate =    CASE WHEN BdmRecType = 'EMP' THEN
                                        '"' + CONVERT(VARCHAR, dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, '1/1/2019', eecDateOfLastHire), 101) + '"'        
                                    END
        ,drvPlanYear =  '"' + CAST(CASE WHEN EedBenStartDate IS NOT NULL AND DATEPART(YEAR, EedBenStartDate) >= 2020 THEN DATEPART(YEAR, EedBenStartDate) ELSE 2020 END AS VARCHAR) + '"'         
        ,drvPlanType =    '"' + CASE WHEN BdmDedCode = /*'GTL'*/ 'GLIFE' THEN 'LIF'
                            WHEN BdmDedCode = 'UNVOL' THEN 'LM'
                            WHEN BdmDedCode IN ('MEDFT','MEDPT') THEN 'HSA'
                            WHEN BdmDedCode = 'STD' THEN 'STD'
                            WHEN BdmDedCode = 'LTD' THEN 'LTD'
                            WHEN BdmDedCode IN ('DENFT','DENPT','DEN') THEN 'DEN'
                            WHEN BdmDedCode IN ('VISFT','VISPT') THEN 'VIS'
                            WHEN BdmDedCode IN ('VOLSP') THEN 'LS'
                            WHEN BdmDedCode IN ('VOLCH') THEN 'LC'
                            --ELSE '* ' + BdmDedCode
                        END + '"'
        ,drvPlanGroupNumber =   '"' +  CASE BdmDedCode
                                    WHEN 'MEDFT' THEN '143903'
                                    WHEN 'MEDPT' THEN '143903'
                                    WHEN /*'GTL'*/ 'GLIFE' THEN '879960'
                                    WHEN 'UNVOL' THEN '879961'
                                    WHEN 'VOLSP' THEN '879961'
                                    WHEN 'VOLCH' THEN '879961'
                                    WHEN 'LTD' THEN '879960'
                                    WHEN 'STD' THEN '879960'
                                    WHEN 'DENFT' THEN '5664710'
                                    WHEN 'DENPT' THEN '5664710'
                                    WHEN 'VISFT' THEN '5664710'
                                    WHEN 'VISPT' THEN '5664710'
                                END + '"'
        ,drvEnrollmentStatus =    '"' + CASE WHEN BdmBenStatus = 'A' THEN 'enrolled'
                                    WHEN BdmBenStatus = 'W' THEN 'Waived'
                                    ELSE 'Terminated'
                                END + '"'
        ,drvEnrollmentStartDate =  '"' + CONVERT(VARCHAR, dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, '1/1/2020'), 101) + '"'
                                    --'"' + CONVERT(VARCHAR, CASE WHEN BdmDedCode IN ('STD','LTD') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, '1/1/2020') ELSE BdmBenStartDate END, 101) + '"'
        ,drvEnrollmentStopDate = '"' + CONVERT(VARCHAR, BdmBenStopDate, 101) + '"'
        ,drvApprovedAmount = '"' + CASE WHEN BdmDedCode IN ('UNVOL','VOLCH','VOLSP') THEN FORMAT(EedBenAmt,  '#0.00') END + '"'
        ,drvRequestedAmount = '"' + CASE WHEN BdmDedCode IN ('UNVOL','VOLCH','VOLSP') THEN FORMAT(amtDesiredAmt, '#0.00') END + '"'
        ,drvEnrollmentType = '"' + CASE WHEN BdmBenStatus IN ('A','T') THEN 'A' END + '"'
        ,drvCoverageDescription = '' -- '"' + CASE WHEN BdmDedCode IN ('DENFT','DENPT') THEN '5664710' END + '"'
        ,drvCoverageTier = '"' + 
                                CASE BdmBenOption
                                    WHEN 'EE' THEN 'EMP'
                                    WHEN 'EES' THEN 'ESP'
                                    WHEN 'EEC' THEN 'ECH'
                                    WHEN 'EEF' THEN 'FAM'
                                    WHEN 'EEDP' THEN 'ESP'
                                    WHEN 'EEDPF' THEN 'FAM'
                                END
                                + '"'
    INTO dbo.U_ESEQDEMEXP_drvTbl
    FROM dbo.U_ESEQDEMEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_ESEQDEMEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.BenGrp WITH (NOLOCK)
        ON EecDedGroupCode = CbgBenGroupCode
    --JOIN dbo.BenProg WITH (NOLOCK)
--        ON BdmDedCode = CbpDedCode
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        --AND EedDedCode IN ('MEDFT','MEDPT','GTL','UNVOL','VOLSP','VOLCH','LTD','STD','DENFT','DENPT','VISFT','VISPT')
        AND EedDedCode = BdmDedCode
    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhOrgLvl1, EjhJobEffDate
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhOrgLvl1, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID, EjhOrgLvl1 ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS T
            WHERE RN = 1 ) AS Y
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhOrgLvl1 = EecOrgLvl1
    LEFT JOIN (
                SELECT audEEID, audKey2 AS audCOID, audDateTime
                FROM dbo.U_ESEQDEMEXP_Audit WITH (NOLOCK)
                WHERE audRowNo = 1) AS Loc_Change_Date
        ON xEEID = audEEID
            AND xCOID = audCOID
    LEFT JOIN (
                    SELECT EedEEID AS amtEEID, EedCOID AS amtCOID, EedDedCode AS amtDedCode, EedEOIDesiredAmt AS amtDesiredAmt, EedBenAmt AS amtBenAmt
                    FROM (
                            SELECT EedEEID, EedCOID, EedDedCode, EedEOIDesiredAmt, EedBenAmt, EedStartDate, ROW_NUMBER() OVER (PARTITION BY EedEEID, EedCOID, EedDedCode ORDER BY EedStartDate DESC) AS RN
                            FROM dbo.EmpDedFull WITH (NOLOCK)
                            WHERE eedDedCode IN ('UNVOL')) AS A
                    WHERE RN = 1 ) AS Amt
        ON amtEEID = xEEID
        AND amtCOID = xCOID
    WHERE CbgBenGroupCode IN ('FTEE','PTEE','TEMPE')
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
ALTER VIEW dbo.dsi_vwESEQDEMEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESEQDEMEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESEQDEMEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202008181'
       ,expStartPerControl     = '202008181'
       ,expLastEndPerControl   = '202008259'
       ,expEndPerControl       = '202008259'
WHERE expFormatCode = 'ESEQDEMEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESEQDEMEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESEQDEMEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort