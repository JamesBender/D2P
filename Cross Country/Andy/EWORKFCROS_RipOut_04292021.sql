SET NOCOUNT ON;
IF OBJECT_ID('U_EWORKFCROS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EWORKFCROS_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EWORKFCROS_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EWORKFCROS' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWORKFCROS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWORKFCROS];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EWORKFCROS';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EWORKFCROS';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EWORKFCROS';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EWORKFCROS';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EWORKFCROS';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) VALUES ('N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','EWORKFCROS','General Interface Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','N','S','N','EWORKFCROSZ0','N','Jan  1 1900 12:00AM','C','N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EWORKFCROS' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EXTERNAL_HR_ID"','1','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','1',NULL,'EXTERNAL_HR_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MANAGER_MATCH_FIELD"','2','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','2',NULL,'MANAGER_MATCH_FIELD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DT"','3','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','3',NULL,'EFF_DT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST_NAME"','4','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','4',NULL,'FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE_NAME"','5','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','5',NULL,'MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST_NAME"','6','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','6',NULL,'LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_GROUP_CREATION"','7','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','7',NULL,'ASSIGNMENT_GROUP_CREATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_ACCRUAL_BEGIN_DATE"','8','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','8',NULL,'ASSIGNMENT_ACCRUAL_BEGIN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_END_DATE"','9','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','9',NULL,'ASSIGNMENT_END_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LATEST_ASSIGNMENT_BEGIN_DATE"','10','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','10',NULL,'LATEST_ASSIGNMENT_BEGIN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR_STATUS_CODE"','11','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','11',NULL,'HR_STATUS_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MANAGER_ID"','12','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','12',NULL,'MANAGER_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAIL"','13','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','13',NULL,'EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IMPORTED_BADGE_ID"','14','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','14',NULL,'IMPORTED_BADGE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AUTHENTICATION_MATCH_ID"','15','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','15',NULL,'AUTHENTICATION_MATCH_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MANAGER_INDICATOR"','16','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','16',NULL,'MANAGER_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_FTE_PCT"','17','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','17',NULL,'ASSIGNMENT_FTE_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SCHEDULE_TEMPLATE"','18','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','18',NULL,'SCHEDULE_TEMPLATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BUSINESS_ADDRESS_COUNTRY"','19','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','19',NULL,'BUSINESS_ADDRESS_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SHIFT_INDICATOR"','20','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','20',NULL,'SHIFT_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BUSINESS_ADDRESS_STATE_PROV"','21','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','21',NULL,'BUSINESS_ADDRESS_STATE_PROV',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYROLL_EMP_ID"','22','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','22',NULL,'PAYROLL_EMP_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYROLL_SYSTEM_ID"','23','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','23',NULL,'PAYROLL_SYSTEM_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAY_TYPE"','24','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','24',NULL,'PAY_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FULLTIME_PARTTIME"','25','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','25',NULL,'FULLTIME_PARTTIME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYMENT_TYPE"','26','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','26',NULL,'EMPLOYMENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TIME_ZONE"','27','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','27',NULL,'TIME_ZONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_STD_WEEKLY_HOURS"','28','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','28',NULL,'ASSIGNMENT_STD_WEEKLY_HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_STD_DAILY_HOURS"','29','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','29',NULL,'ASSIGNMENT_STD_DAILY_HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AGGREGATE_STD_WEEKLY_HOURS"','30','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','30',NULL,'AGGREGATE_STD_WEEKLY_HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_PROFILE_MAPPING_KEY"','31','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','31',NULL,'POLICY_PROFILE_MAPPING_KEY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOLIDAY_CALENDAR_MAPPING_KEY"','32','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','32',NULL,'HOLIDAY_CALENDAR_MAPPING_KEY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USER_ONLY"','33','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','33',NULL,'USER_ONLY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_LD_DEPENDENCY"','34','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','34',NULL,'ASSIGNMENT_LD_DEPENDENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACT_COMPANY"','35','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','35',NULL,'ACT_COMPANY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACT_EMPLOYEE_GROUP"','36','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','36',NULL,'ACT_EMPLOYEE_GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACT_HIRE_DATE"','37','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','37',NULL,'ACT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACT_LOCATION_CODE"','38','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','38',NULL,'ACT_LOCATION_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACT_CASE_APPROVER_MATCH_ID"','39','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','39',NULL,'ACT_CASE_APPROVER_MATCH_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AGGREGATE_STD_DAILY_HOURS"','40','(''DA''=''T,'')','EWORKFCROSZ0','50','H','01','40',NULL,'AGGREGATE_STD_DAILY_HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AGGREGATE_FTE_PCT"','41','(''DA''=''T'')','EWORKFCROSZ0','50','H','01','41',NULL,'AGGREGATE_FTE_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EXTERNAL_HR_ID"','1','(''UA''=''T,'')','EWORKFCROSZ0','50','D','10','1',NULL,'EXTERNAL_HR_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MANAGER_MATCH_FIELD"','2','(''UA''=''T,'')','EWORKFCROSZ0','50','D','10','2',NULL,'MANAGER_MATCH_FIELD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DT"','3','(''UD101''=''T,'')','EWORKFCROSZ0','50','D','10','3',NULL,'EFF_DT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST_NAME"','4','(''UA''=''T,'')','EWORKFCROSZ0','50','D','10','4',NULL,'FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE_NAME"','5','(''UA''=''T,'')','EWORKFCROSZ0','50','D','10','5',NULL,'MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST_NAME"','6','(''UA''=''T,'')','EWORKFCROSZ0','50','D','10','6',NULL,'LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_GROUP_CREATION"','7','(''UA''=''T,'')','EWORKFCROSZ0','50','D','10','7',NULL,'ASSIGNMENT_GROUP_CREATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_ACCRUAL_BEGIN_DATE"','8','(''UD101''=''T,'')','EWORKFCROSZ0','50','D','10','8',NULL,'ASSIGNMENT_ACCRUAL_BEGIN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_END_DATE"','9','(''UD101''=''T,'')','EWORKFCROSZ0','50','D','10','9',NULL,'ASSIGNMENT_END_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LATEST_ASSIGNMENT_BEGIN_DATE"','10','(''UD101''=''T,'')','EWORKFCROSZ0','51','D','10','10',NULL,'LATEST_ASSIGNMENT_BEGIN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR_STATUS_CODE"','11','(''UA''=''T,'')','EWORKFCROSZ0','52','D','10','11',NULL,'HR_STATUS_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MANAGER_ID"','12','(''UA''=''T,'')','EWORKFCROSZ0','53','D','10','12',NULL,'MANAGER_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAIL"','13','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','13',NULL,'EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IMPORTED_BADGE_ID"','14','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','14',NULL,'IMPORTED_BADGE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AUTHENTICATION_MATCH_ID"','15','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','15',NULL,'AUTHENTICATION_MATCH_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MANAGER_INDICATOR"','16','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','16',NULL,'MANAGER_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_FTE_PCT"','17','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','17',NULL,'ASSIGNMENT_FTE_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SCHEDULE_TEMPLATE"','18','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','18',NULL,'SCHEDULE_TEMPLATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BUSINESS_ADDRESS_COUNTRY"','19','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','19',NULL,'BUSINESS_ADDRESS_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SHIFT_INDICATOR"','20','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','20',NULL,'SHIFT_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BUSINESS_ADDRESS_STATE_PROV"','21','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','21',NULL,'BUSINESS_ADDRESS_STATE_PROV',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYROLL_EMP_ID"','22','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','22',NULL,'PAYROLL_EMP_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYROLL_SYSTEM_ID"','23','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','23',NULL,'PAYROLL_SYSTEM_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAY_TYPE"','24','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','24',NULL,'PAY_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FULLTIME_PARTTIME"','25','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','25',NULL,'FULLTIME_PARTTIME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYMENT_TYPE"','26','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','26',NULL,'EMPLOYMENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TIME_ZONE"','27','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','27',NULL,'TIME_ZONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_STD_WEEKLY_HOURS"','28','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','28',NULL,'ASSIGNMENT_STD_WEEKLY_HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_STD_DAILY_HOURS"','29','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','29',NULL,'ASSIGNMENT_STD_DAILY_HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AGGREGATE_STD_WEEKLY_HOURS"','30','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','30',NULL,'AGGREGATE_STD_WEEKLY_HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_PROFILE_MAPPING_KEY"','31','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','31',NULL,'POLICY_PROFILE_MAPPING_KEY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOLIDAY_CALENDAR_MAPPING_KEY"','32','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','32',NULL,'HOLIDAY_CALENDAR_MAPPING_KEY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USER_ONLY"','33','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','33',NULL,'USER_ONLY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASSIGNMENT_LD_DEPENDENCY"','34','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','34',NULL,'ASSIGNMENT_LD_DEPENDENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACT_COMPANY"','35','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','35',NULL,'ACT_COMPANY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACT_EMPLOYEE_GROUP"','36','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','36',NULL,'ACT_EMPLOYEE_GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACT_HIRE_DATE"','37','(''UD101''=''T,'')','EWORKFCROSZ0','54','D','10','37',NULL,'ACT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACT_LOCATION_CODE"','38','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','38',NULL,'ACT_LOCATION_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACT_CASE_APPROVER_MATCH_ID"','39','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','39',NULL,'ACT_CASE_APPROVER_MATCH_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AGGREGATE_STD_DAILY_HOURS"','40','(''UA''=''T,'')','EWORKFCROSZ0','54','D','10','40',NULL,'AGGREGATE_STD_DAILY_HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AGGREGATE_FTE_PCT"','41','(''UA''=''T'')','EWORKFCROSZ0','54','D','10','41',NULL,'AGGREGATE_FTE_PCT',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EWORKFCROS_20210429.csv';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'General Interface Export','202104299','EMPEXPORT','ONDEM_XOE',NULL,'EWORKFCROS',NULL,NULL,NULL,'202104299','Apr 29 2021 11:43AM','Apr 29 2021 11:43AM','202104291',NULL,'','','202104291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'General Interface Export-Sched','202104299','EMPEXPORT','SCH_EWORKF',NULL,'EWORKFCROS',NULL,NULL,NULL,'202104299','Apr 29 2021 11:43AM','Apr 29 2021 11:43AM','202104291',NULL,'','','202104291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'General Interface Export-Test','202104299','EMPEXPORT','TEST_XOE',NULL,'EWORKFCROS',NULL,NULL,NULL,'202104299','Apr 29 2021 11:43AM','Apr 29 2021 11:43AM','202104291',NULL,'','','202104291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKFCROS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKFCROS','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKFCROS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWORKFCROS','UseFileName','V','N');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EWORKFCROS' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EWORKFCROS' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EWORKFCROS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EWORKFCROS_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWORKFCROS','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWORKFCROS','D10','dbo.U_EWORKFCROS_drvTbl',NULL);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWORKFCROS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: CrossCountry Freight Solutions

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 04/29/2021
Service Request Number: TekP-2021-03-29-0004

Purpose: General Interface Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWORKFCROS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWORKFCROS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWORKFCROS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWORKFCROS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWORKFCROS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKFCROS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKFCROS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWORKFCROS', 'SCH_EWORKF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWORKFCROS';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EWORKFCROS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWORKFCROS';

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
    DELETE FROM dbo.U_EWORKFCROS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWORKFCROS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

	--Audit Table
    IF OBJECT_ID('U_EWORKFCROS_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EWORKFCROS_AuditFields;
    CREATE TABLE dbo.U_EWORKFCROS_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EWORKFCROS_AuditFields VALUES ('Empcomp','EecEmplStatus');    
    -- Create audit table
    IF OBJECT_ID('U_EWORKFCROS_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EWORKFCROS_Audit;
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
    INTO dbo.U_EWORKFCROS_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EWORKFCROS_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EWORKFCROS_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EWORKFCROS_Audit ON dbo.U_EWORKFCROS_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EWORKFCROS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EWORKFCROS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWORKFCROS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,EXTERNAL_HR_ID = EC.EecEmpNo
        ,MANAGER_MATCH_FIELD = ''
        ,EFF_DT = EC.EecDateOfOriginalHire
        ,FIRST_NAME = EepNameFirst
        ,MIDDLE_NAME = LEFT(EepNameMiddle, 1)
        ,LAST_NAME = EepNameLast
        ,ASSIGNMENT_GROUP_CREATION = ''
        ,ASSIGNMENT_ACCRUAL_BEGIN_DATE = EC.EecDateOfOriginalHire
        ,ASSIGNMENT_END_DATE = ISNULL(CONVERT(VARCHAR, EC.EecDateOfTermination, 101), '')
        ,LATEST_ASSIGNMENT_BEGIN_DATE = EC.EecDateOfOriginalHire
        ,HR_STATUS_CODE = CASE WHEN EC.EecEmplStatus = 'A' THEN 'A'
								WHEN EC.EecEmplStatus = 'L' THEN 'L'
								WHEN EC.EecEmplStatus = 'T' THEN 'T' END
        ,MANAGER_ID = EC2.EecEmpNo --supervisor
        ,EMAIL = EepAddressEMail
        ,IMPORTED_BADGE_ID = ''
        ,AUTHENTICATION_MATCH_ID = ''
        ,MANAGER_INDICATOR = ''
        ,ASSIGNMENT_FTE_PCT = ''
        ,SCHEDULE_TEMPLATE = ''
        ,BUSINESS_ADDRESS_COUNTRY = 'USA'
        ,SHIFT_INDICATOR = ''
        ,BUSINESS_ADDRESS_STATE_PROV = EepAddressState
        ,PAYROLL_EMP_ID = ''
        ,PAYROLL_SYSTEM_ID = ''
        ,PAY_TYPE = ''
        ,FULLTIME_PARTTIME = CASE WHEN EC.EecFullTimeOrPartTime = 'F' THEN 'F' ELSE 'P' END
        ,EMPLOYMENT_TYPE = ''
        ,TIME_ZONE = ''
        ,ASSIGNMENT_STD_WEEKLY_HOURS = ''
        ,ASSIGNMENT_STD_DAILY_HOURS = ''
        ,AGGREGATE_STD_WEEKLY_HOURS = ''
        ,POLICY_PROFILE_MAPPING_KEY = 'NAS_EL_PPM'
        ,HOLIDAY_CALENDAR_MAPPING_KEY = 'ALL_HOLIDAY'
        ,USER_ONLY = ''
        ,ASSIGNMENT_LD_DEPENDENCY = ''
        ,ACT_COMPANY = 'NORTH_AMERICAN_SERVICES_INC'
        ,ACT_EMPLOYEE_GROUP = 'USA'
        ,ACT_HIRE_DATE = EC.EecDateOfOriginalHire
        ,ACT_LOCATION_CODE = CASE WHEN EepAddressState = 'CA' AND EepAddressCity = 'San Francisco' THEN 'USA_CA_SFO'
									WHEN EepAddressState = 'FL' AND EepAddressCounty = 'Miami Dade' THEN 'USA_FL_MIAMI_DADE'
									WHEN EepAddressState = 'NY' AND EepAddressCity = 'New York City' THEN 'USA_NY_NYC'
									WHEN EepAddressState = 'NY' AND EepAddressCounty = 'Westchester' THEN 'USA_NY_WESTCHESTER'
									WHEN EepAddressState = 'PA' AND EepAddressCity = 'Philadelphia' THEN 'USA_PA_PHL'
									WHEN EepAddressState = 'RI' AND EepAddressCity = 'Central Falls' THEN 'USA_RI_CENTRAL_FALLS'
									WHEN EepAddressState = 'RI' AND EepAddressCity = 'Providence' THEN 'USA_RI_PROVIDENCE'
									ELSE 'USA_' + EepAddressState END
        ,ACT_CASE_APPROVER_MATCH_ID = ''
        ,AGGREGATE_STD_DAILY_HOURS = ''
        ,AGGREGATE_FTE_PCT = ''
    INTO dbo.U_EWORKFCROS_drvTbl
    FROM dbo.U_EWORKFCROS_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
	JOIN dbo.EmpComp EC WITH(NOLOCK)
		ON EC.EecEEID = xEEID
		AND EC.EecCOID = xCOID 
		AND (EC.eecemplstatus <> 'T' OR (EC.eecemplstatus= 'T' and EC.eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EWORKFCROS_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
	LEFT JOIN dbo.EmpComp EC2 WITH (NOLOCK) -- supervisor  
    ON EC2.EecEEID = EC.EecSupervisorID  
    AND EC2.EecCOID = EC.EecCOID  
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
ALTER VIEW dbo.dsi_vwEWORKFCROS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWORKFCROS_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EWORKFCROS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202104221'
       ,expStartPerControl     = '202104221'
       ,expLastEndPerControl   = '202104299'
       ,expEndPerControl       = '202104299'
WHERE expFormatCode = 'EWORKFCROS';

**********************************************************************************/