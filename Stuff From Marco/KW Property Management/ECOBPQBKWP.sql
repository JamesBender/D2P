SET NOCOUNT ON;
IF OBJECT_ID('U_ECOBPQBKWP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOBPQBKWP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECOBPQBKWP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECOBPQBKWP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECOBPQBKWP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECOBPQBKWP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECOBPQBKWP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBPQBKWP];
GO
IF OBJECT_ID('U_ECOBPQBKWP_File') IS NOT NULL DROP TABLE [dbo].[U_ECOBPQBKWP_File];
GO
IF OBJECT_ID('U_ECOBPQBKWP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECOBPQBKWP_EEList];
GO
IF OBJECT_ID('U_ECOBPQBKWP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECOBPQBKWP_drvTbl];
GO
IF OBJECT_ID('U_ECOBPQBKWP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECOBPQBKWP_AuditFields];
GO
IF OBJECT_ID('U_ECOBPQBKWP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECOBPQBKWP_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECOBPQBKWP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECOBPQBKWP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECOBPQBKWP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECOBPQBKWP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECOBPQBKWP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECOBPQBKWP','WageWorks Cobra QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECOBPQBKWPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECOBPQBKWP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYER_EIN"','1','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','1',NULL,'EMPLOYER_EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACTION_CODE"','2','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','2',NULL,'ACTION_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST_NAME"','3','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','3',NULL,'LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST_NAME"','4','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','4',NULL,'FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE_INITIAL"','5','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','5',NULL,'MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE_SSN"','6','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','6',NULL,'EMPLOYEE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEPENDENT_SSN"','7','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','7',NULL,'DEPENDENT_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE_NUMBER"','8','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','8',NULL,'EMPLOYEE_NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','9','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','9',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE_CLASS"','10','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','10',NULL,'EMPLOYEE_CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RELATIONSHIP"','11','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','11',NULL,'RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','12','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','12',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HIRE_DATE"','13','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','13',NULL,'HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BIRTH_DATE"','14','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','14',NULL,'BIRTH_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS_1"','15','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','15',NULL,'ADDRESS_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS_2"','16','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','16',NULL,'ADDRESS_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY"','17','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','17',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATE"','18','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','18',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP"','19','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','19',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUNTRY"','20','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','20',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER_1"','21','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','21',NULL,'FILLER_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COBRA_ELIGIBLE"','22','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','22',NULL,'COBRA_ELIGIBLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PREFERRED_LANGUAGE"','23','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','23',NULL,'PREFERRED_LANGUAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PHONE_NUMBER"','24','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','24',NULL,'PHONE_NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E_MAIL_ADDRESS"','25','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','25',NULL,'E_MAIL_ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INITIAL_NOTIFICATION_COBRA"','26','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','26',NULL,'INITIAL_NOTIFICATION_COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INITIAL_NOTIFICATION_HIPAA"','27','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','27',NULL,'INITIAL_NOTIFICATION_HIPAA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WAITING_START_DATE"','28','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','28',NULL,'WAITING_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVERAGE_BEGIN_DATE"','29','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','29',NULL,'COVERAGE_BEGIN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER_2"','30','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','30',NULL,'FILLER_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QUALIFYING EVENT_DATE"','31','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','31',NULL,'QUALIFYING EVENT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST_PRECOBRA_COVERED"','32','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','32',NULL,'LAST_PRECOBRA_COVERED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QUALIFYING_EVENT_TYPE"','33','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','33',NULL,'QUALIFYING_EVENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELIGIBILITY_END_DATE"','34','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','34',NULL,'ELIGIBILITY_END_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEVERANCE_THROUGH"','35','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','35',NULL,'SEVERANCE_THROUGH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEVERANCE_PERCENT"','36','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','36',NULL,'SEVERANCE_PERCENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEVERANCE_MONTHLY"','37','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','37',NULL,'SEVERANCE_MONTHLY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEVERANCE_CREDIT"','38','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','38',NULL,'SEVERANCE_CREDIT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BILLING_START_DATE"','39','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','39',NULL,'BILLING_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELECTION_NOTE_MAILED"','40','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','40',NULL,'ELECTION_NOTE_MAILED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HIPAA_CERTIFICATE_MAILED"','41','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','41',NULL,'HIPAA_CERTIFICATE_MAILED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELECTION_DATE"','42','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','42',NULL,'ELECTION_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER_3"','43','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','43',NULL,'FILLER_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_NAME1"','44','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','44',NULL,'PLAN_NAME1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_CODE1"','45','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','45',NULL,'PLAN_COV_CODE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_START1"','46','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','46',NULL,'PLAN_COV_START1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_END1"','47','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','47',NULL,'PLAN_COV_END1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_RATE1"','48','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','48',NULL,'PLAN_RATE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER"','49','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','49',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CARRIER_EMPLOYEE_ID1"','50','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','50',NULL,'CARRIER_EMPLOYEE_ID1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_FILLER1"','51','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','51',NULL,'PLAN_FILLER1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_NAME2"','52','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','52',NULL,'PLAN_NAME2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_CODE2"','53','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','53',NULL,'PLAN_COV_CODE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_START2"','54','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','54',NULL,'PLAN_COV_START2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_END2"','55','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','55',NULL,'PLAN_COV_END2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_RATE2"','56','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','56',NULL,'PLAN_RATE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER"','57','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','57',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CARRIER_EMPLOYEE_ID2"','58','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','58',NULL,'CARRIER_EMPLOYEE_ID2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_FILLER2"','59','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','59',NULL,'PLAN_FILLER2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_NAME3"','60','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','60',NULL,'PLAN_NAME3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_CODE3"','61','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','61',NULL,'PLAN_COV_CODE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_START3"','62','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','62',NULL,'PLAN_COV_START3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_END3"','63','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','63',NULL,'PLAN_COV_END3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_RATE3"','64','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','64',NULL,'PLAN_RATE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER"','65','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','65',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CARRIER_EMPLOYEE_ID3"','66','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','66',NULL,'CARRIER_EMPLOYEE_ID3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_FILLER3"','67','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','67',NULL,'PLAN_FILLER3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_NAME4"','68','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','68',NULL,'PLAN_NAME4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_CODE4"','69','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','69',NULL,'PLAN_COV_CODE4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_START4"','70','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','70',NULL,'PLAN_COV_START4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_END4"','71','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','71',NULL,'PLAN_COV_END4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_RATE4"','72','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','72',NULL,'PLAN_RATE4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER"','73','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','73',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CARRIER_EMPLOYEE_ID4"','74','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','74',NULL,'CARRIER_EMPLOYEE_ID4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_FILLER4"','75','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','75',NULL,'PLAN_FILLER4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_NAME5"','76','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','76',NULL,'PLAN_NAME5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_CODE5"','77','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','77',NULL,'PLAN_COV_CODE5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_START5"','78','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','78',NULL,'PLAN_COV_START5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_END5"','79','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','79',NULL,'PLAN_COV_END5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_RATE5"','80','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','80',NULL,'PLAN_RATE5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER"','81','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','81',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CARRIER_EMPLOYEE_ID5"','82','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','82',NULL,'CARRIER_EMPLOYEE_ID5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_FILLER5"','83','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','83',NULL,'PLAN_FILLER5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_YEAR_START"','84','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','84',NULL,'PLAN_YEAR_START',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT_DATE"','85','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','85',NULL,'ENROLLMENT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAY_RUN_DATE"','86','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','86',NULL,'PAY_RUN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAY_SCHEDULE"','87','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','87',NULL,'PAY_SCHEDULE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYMENT_TYPE"','88','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','88',NULL,'PAYMENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT_TYPE"','89','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','89',NULL,'ENROLLMENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FSA_FILLER1"','90','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','90',NULL,'FSA_FILLER1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COMMUTER_ELIGIBLE"','91','(''DA''=''T,'')','ECOBPQBKWPZ0','50','H','01','91',NULL,'COMMUTER_ELIGIBLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OPT_IN_OPT_OUT"','92','(''DA''=''T'')','ECOBPQBKWPZ0','50','H','01','92',NULL,'OPT_IN_OPT_OUT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerEIN"','1','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','1',NULL,'EMPLOYER_EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActionCode"','2','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','2',NULL,'ACTION_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','3',NULL,'LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','4',NULL,'FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','5','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','5',NULL,'MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','6','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','6',NULL,'EMPLOYEE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepSSN"','7','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','7',NULL,'DEPENDENT_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','8','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','8',NULL,'EMPLOYEE_NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','9','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','9',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpClass"','10','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','10',NULL,'EMPLOYEE_CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','11','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','11',NULL,'RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','12',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','13','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','13',NULL,'HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','14','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','14',NULL,'BIRTH_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','15','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','15',NULL,'ADDRESS_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','16','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','16',NULL,'ADDRESS_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','17',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','18',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','19','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','19',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','20','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','20',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','21',NULL,'FILLER_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCobraElig"','22','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','22',NULL,'COBRA_ELIGIBLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrefLanguage"','23','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','23',NULL,'PREFERRED_LANGUAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','24','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','24',NULL,'PHONE_NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','25','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','25',NULL,'E_MAIL_ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCobraIN"','26','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','26',NULL,'INITIAL_NOTIFICATION_COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHippaIN"','27','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','27',NULL,'INITIAL_NOTIFICATION_HIPAA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWaitStartDate"','28','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','28',NULL,'WAITING_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovStartDate"','29','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','29',NULL,'COVERAGE_BEGIN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','30',NULL,'FILLER_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQEDate"','31','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','31',NULL,'QUALIFYING EVENT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastPreCobraCov"','32','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','32',NULL,'LAST_PRECOBRA_COVERED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQEType"','33','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','33',NULL,'QUALIFYING_EVENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEndDate"','34','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','34',NULL,'ELIGIBILITY_END_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSevThrough"','35','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','35',NULL,'SEVERANCE_THROUGH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSevPercent"','36','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','36',NULL,'SEVERANCE_PERCENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSevMonthly"','37','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','37',NULL,'SEVERANCE_MONTHLY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSevCredit"','38','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','38',NULL,'SEVERANCE_CREDIT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillStartDate"','39','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','39',NULL,'BILLING_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectNoteMailed"','40','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','40',NULL,'ELECTION_NOTE_MAILED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHippaCertMailed"','41','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','41',NULL,'HIPAA_CERTIFICATE_MAILED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectDate"','42','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','42',NULL,'ELECTION_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','43',NULL,'FILLER_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan1Name"','44','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','44',NULL,'PLAN_NAME1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan1CovCode"','45','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','45',NULL,'PLAN_COV_CODE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan1CovStartDate"','46','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','46',NULL,'PLAN_COV_START1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan1CovEndDate"','47','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','47',NULL,'PLAN_COV_END1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan1Rate"','48','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','48',NULL,'PLAN_RATE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','49',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierEmpID1"','50','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','50',NULL,'CARRIER_EMPLOYEE_ID1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','51',NULL,'PLAN_FILLER1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan2Name"','52','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','52',NULL,'PLAN_NAME2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan2CovCode"','53','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','53',NULL,'PLAN_COV_CODE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan2CovStartDate"','54','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','54',NULL,'PLAN_COV_START2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan2CovEndDate"','55','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','55',NULL,'PLAN_COV_END2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan2Rate"','56','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','56',NULL,'PLAN_RATE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','57',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierEmpID2"','58','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','58',NULL,'CARRIER_EMPLOYEE_ID2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','59',NULL,'PLAN_FILLER2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan3Name"','60','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','60',NULL,'PLAN_NAME3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan3CovCode"','61','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','61',NULL,'PLAN_COV_CODE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan3CovStartDate"','62','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','62',NULL,'PLAN_COV_START3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan3CovEndDate"','63','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','63',NULL,'PLAN_COV_END3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan3Rate"','64','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','64',NULL,'PLAN_RATE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','65',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierEmpID3"','66','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','66',NULL,'CARRIER_EMPLOYEE_ID3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','67',NULL,'PLAN_FILLER3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan4Name"','68','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','68',NULL,'PLAN_NAME4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan4CovCode"','69','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','69',NULL,'PLAN_COV_CODE4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan4CovStartDate"','70','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','70',NULL,'PLAN_COV_START4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan4CovEndDate"','71','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','71',NULL,'PLAN_COV_END4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan4Rate"','72','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','72',NULL,'PLAN_RATE4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','73',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierEmpID4"','74','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','74',NULL,'CARRIER_EMPLOYEE_ID4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','75',NULL,'PLAN_FILLER4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan5Name"','76','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','76',NULL,'PLAN_NAME5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan5CovCode"','77','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','77',NULL,'PLAN_COV_CODE5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan5CovStartDate"','78','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','78',NULL,'PLAN_COV_START5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan5CovEndDate"','79','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','79',NULL,'PLAN_COV_END5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan5Rate"','80','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','80',NULL,'PLAN_RATE5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','81',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierEmpID5"','82','(''UA''=''T,'')','ECOBPQBKWPZ0','50','D','10','82',NULL,'CARRIER_EMPLOYEE_ID5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','83',NULL,'PLAN_FILLER5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','84',NULL,'PLAN_YEAR_START',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','85',NULL,'ENROLLMENT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','86',NULL,'PAY_RUN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','87',NULL,'PAY_SCHEDULE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','88',NULL,'PAYMENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','89',NULL,'ENROLLMENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','90',NULL,'FSA_FILLER1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''SS''=''T,'')','ECOBPQBKWPZ0','50','D','10','91',NULL,'COMMUTER_ELIGIBLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''SS''=''T'')','ECOBPQBKWPZ0','50','D','10','92',NULL,'OPT_IN_OPT_OUT',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECOBPQBKWP_20210608.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WageWorks Cobra QB Export','202001079','EMPEXPORT','ONDEMAND','Jan  7 2020 12:00AM','ECOBPQBKWP',NULL,NULL,NULL,'202001079','Jan  7 2020 12:00AM','Dec 30 1899 12:00AM','202001071',NULL,'','','202001071',dbo.fn_GetTimedKey(),NULL,'ULTI_WPKWP',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','YFGCX',NULL,NULL,NULL,'Scheduled Session','202010099','EMPEXPORT','SCHWGWKQB','Jan  7 2020 12:00AM','ECOBPQBKWP',NULL,NULL,NULL,'202105189','Jan  7 2020 12:00AM','Dec 30 1899 12:00AM','202105111',NULL,'','','202010091',dbo.fn_GetTimedKey(),NULL,'ULTI_WPKWP',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202105199','EMPEXPORT','TEST','May 19 2021  7:18PM','ECOBPQBKWP',NULL,NULL,NULL,'202105199','May 19 2021 12:00AM','Dec 30 1899 12:00AM','202104011','15','','','202104011',dbo.fn_GetTimedKey(),NULL,'us3lKiKWP1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBPQBKWP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBPQBKWP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBPQBKWP','InitialSort','C','drvInitalSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBPQBKWP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBPQBKWP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBPQBKWP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECOBPQBKWP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECOBPQBKWP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECOBPQBKWP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOBPQBKWP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBPQBKWP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBPQBKWP','D10','dbo.U_ECOBPQBKWP_drvTbl',NULL);
IF OBJECT_ID('U_ECOBPQBKWP_Audit') IS NULL
CREATE TABLE [dbo].[U_ECOBPQBKWP_Audit] (
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
IF OBJECT_ID('U_ECOBPQBKWP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECOBPQBKWP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ECOBPQBKWP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECOBPQBKWP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitalSort] char(11) NULL,
    [drvSubSort] varchar(12) NOT NULL,
    [drvEmployerEIN] varchar(10) NOT NULL,
    [drvActionCode] varchar(2) NOT NULL,
    [drvNameLast] varchar(50) NULL,
    [drvNameFirst] varchar(50) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvEmpSSN] char(11) NULL,
    [drvDepSSN] varchar(50) NULL,
    [drvEmpNo] char(9) NULL,
    [drvDivision] char(5) NULL,
    [drvEmpClass] varchar(1) NOT NULL,
    [drvRelationship] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvDateOfHire] varchar(10) NULL,
    [drvDateOfBirth] varchar(10) NULL,
    [drvAddressLine1] varchar(50) NULL,
    [drvAddressLine2] varchar(50) NULL,
    [drvAddressCity] varchar(50) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(5) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvCobraElig] varchar(1) NOT NULL,
    [drvPrefLanguage] varchar(2) NOT NULL,
    [drvPhoneNumber] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(1) NOT NULL,
    [drvCobraIN] varchar(1) NOT NULL,
    [drvHippaIN] varchar(1) NOT NULL,
    [drvWaitStartDate] varchar(10) NULL,
    [drvCovStartDate] varchar(10) NULL,
    [drvQEDate] varchar(10) NULL,
    [drvLastPreCobraCov] varchar(10) NULL,
    [drvQEType] varchar(2) NOT NULL,
    [drvEligEndDate] varchar(1) NOT NULL,
    [drvSevThrough] varchar(1) NOT NULL,
    [drvSevPercent] varchar(1) NOT NULL,
    [drvSevMonthly] varchar(1) NOT NULL,
    [drvSevCredit] varchar(1) NOT NULL,
    [drvBillStartDate] varchar(1) NOT NULL,
    [drvElectNoteMailed] varchar(1) NOT NULL,
    [drvHippaCertMailed] varchar(1) NOT NULL,
    [drvElectDate] varchar(1) NOT NULL,
    [drvPlan1Name] varchar(50) NULL,
    [drvPlan1CovCode] varchar(50) NULL,
    [drvPlan1CovStartDate] varchar(10) NULL,
    [drvPlan1CovEndDate] varchar(1) NOT NULL,
    [drvPlan1Rate] varchar(1) NOT NULL,
    [drvCarrierEmpID1] varchar(1) NOT NULL,
    [drvPlan2Name] varchar(50) NULL,
    [drvPlan2CovCode] varchar(50) NULL,
    [drvPlan2CovStartDate] varchar(10) NULL,
    [drvPlan2CovEndDate] varchar(1) NOT NULL,
    [drvPlan2Rate] varchar(1) NOT NULL,
    [drvCarrierEmpID2] varchar(1) NOT NULL,
    [drvPlan3Name] varchar(50) NULL,
    [drvPlan3CovCode] varchar(50) NULL,
    [drvPlan3CovStartDate] varchar(10) NULL,
    [drvPlan3CovEndDate] varchar(1) NOT NULL,
    [drvPlan3Rate] varchar(1) NOT NULL,
    [drvCarrierEmpID3] varchar(1) NOT NULL,
    [drvPlan4Name] varchar(1) NOT NULL,
    [drvPlan4CovCode] varchar(1) NOT NULL,
    [drvPlan4CovStartDate] varchar(1) NOT NULL,
    [drvPlan4CovEndDate] varchar(1) NOT NULL,
    [drvPlan4Rate] varchar(1) NOT NULL,
    [drvCarrierEmpID4] varchar(1) NOT NULL,
    [drvPlan5Name] varchar(1) NOT NULL,
    [drvPlan5CovCode] varchar(1) NOT NULL,
    [drvPlan5CovStartDate] varchar(1) NOT NULL,
    [drvPlan5CovEndDate] varchar(1) NOT NULL,
    [drvPlan5Rate] varchar(1) NOT NULL,
    [drvCarrierEmpID5] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECOBPQBKWP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECOBPQBKWP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECOBPQBKWP_File') IS NULL
CREATE TABLE [dbo].[U_ECOBPQBKWP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBPQBKWP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: KW Property Management

Created By: Ashley Schaeffer
Business Analyst: Michael Christopher
Create Date: 06/12/2020
Service Request Number: KWP1000-2020-00268543

Purpose: WageWorks Cobra QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECOBPQBKWP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECOBPQBKWP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECOBPQBKWP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECOBPQBKWP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECOBPQBKWP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBPQBKWP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBPQBKWP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECOBPQBKWP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECOBPQBKWP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECOBPQBKWP';

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
    DELETE FROM dbo.U_ECOBPQBKWP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECOBPQBKWP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);



    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','A');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','DEN,DENPP,VISO,VIS,HMHR,HMHRT,HMO,HMOT,PPO,PPOT');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); 
        
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBMulti','1');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,LEVNT3,LEVNT4');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,LEVNT3,LEVNT4');
   
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,GRC,STC');

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    /****************************
--NOTES:
--Add BEFORE BuildConsolidatedTable exec
--This logic works with CobraPQBType = 1
--1> All children without employee or spouse dropping are flagged as PQBs, not just the oldest child. 
****************************/
--Validate dependent records that are invalid where EE cobra reason is death
        UPDATE dbo.U_dsi_BDM_DepDeductions
        SET  DbnValidForExport = 'Y'
            ,DbnDedRowStatus   = 'Manually Revalidate Dependent for Employee Death Benefit Change Reason'
            ,DbnIsPQB          = CASE WHEN sps.depID IS NOT NULL THEN
                                        CASE
                                        WHEN dbnRelationship IN ('SPS','DP') THEN 'Y'
                                        ELSE 'N'
                                        END
                                    ELSE 'Y'
                                    END
            ,DbnCobraReason    = '210'
        FROM dbo.U_dsi_BDM_DepDeductions
        LEFT JOIN (SELECT DbnEEID eeid, dbnDepRecID depID, dbnDedCode DedCode
                    FROM dbo.U_dsi_BDM_DepDeductions
                    WHERE DbnValidForExport = 'N' 
                    AND DbnDedRowStatus = 'Benefit change reason is blank'
                    AND DbnRelationship IN ('SPS','DP')) SPS ON sps.eeid = dbnEEID and sps.dedCode = dbnDedCode
        WHERE DbnValidForExport = 'N'
        AND DbnDedRowStatus = 'Benefit change reason is blank'
        AND EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
                         WHERE EedEEID = DbnEEID
                           AND EedCoID = DbnCoID
                           AND EedDedCode = DbnDedCode
                           AND EedFormatCode = @FormatCode
                           AND EedValidForExport = 'N'
                           and EedDedRowStatus   = 'Benefit change reason not valid for Cobra'
                           and eedcobrareason = '210'
                           AND EedRunID = 'QB');
    --Validate dependent records that are invalid where EE term reason is death
        UPDATE dbo.U_dsi_BDM_DepDeductions
        SET  DbnValidForExport = 'Y'
            ,DbnDedRowStatus   = 'Manually Revalidate Dependent for Employee Death Term Reason'
            ,DbnIsPQB          = CASE WHEN sps.depID IS NOT NULL THEN
                                        CASE
                                        WHEN dbnRelationship IN ('SPS','DP') THEN 'Y'
                                        ELSE 'N'
                                        END
                                    ELSE 'Y'
                                    END
            ,DbnCobraReason    = '210'
        FROM dbo.U_dsi_BDM_DepDeductions
        LEFT JOIN (SELECT DbnEEID eeid, dbnDepRecID depID, dbnDedCode DedCode
                    FROM dbo.U_dsi_BDM_DepDeductions
                    WHERE DbnValidForExport = 'N' 
                    AND DbnDedRowStatus = 'Benefit change reason is blank'
                    AND DbnRelationship IN ('SPS','DP')) SPS ON sps.eeid = dbnEEID and sps.dedCode = dbnDedCode
        WHERE DbnValidForExport = 'N'
        AND DbnDedRowStatus = 'Benefit change reason is blank'
        AND EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
                        JOIN dbo.EmpComp WITH (NOLOCK)
                            ON eecEEID = eedEEID AND eecCOID = eedCOID
                         WHERE EedEEID = DbnEEID
                           AND EedCoID = DbnCoID
                           AND EedDedCode = DbnDedCode
                           AND EedFormatCode = @FormatCode
                           AND EedValidForExport = 'N'
                           and EedDedRowStatus   = 'Employment Term Reason not valid for Cobra'
                           and eedcobrareason = '200'
                           and eecTermReason = '203'
                           AND EedRunID = 'QB');



      --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECOBPQBKWP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBPQBKWP_AuditFields;
    CREATE TABLE dbo.U_ECOBPQBKWP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ECOBPQBKWP_AuditFields VALUES ('empComp','eecDateOfTermination');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECOBPQBKWP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBPQBKWP_Audit;
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
    INTO dbo.U_ECOBPQBKWP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECOBPQBKWP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECOBPQBKWP_Audit ON dbo.U_ECOBPQBKWP_Audit (audEEID,audKey2); 

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECOBPQBKWP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECOBPQBKWP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBPQBKWP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitalSort = eepSSN
        ,drvSubSort = CONCAT('1',eepSSN)
        -- standard fields above and additional driver fields below
        ,drvEmployerEIN = '77-0632154'
        ,drvActionCode = '03'
        ,drvNameLast = convert(varchar(50), EepNameLast)
        ,drvNameFirst = convert(varchar(50), EepNameFirst)
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvEmpSSN = eepSSN
        ,drvDepSSN = convert(varchar(50), '')
        ,drvEmpNo = eecEmpNo
        ,drvDivision = CmpCompanyCode
        ,drvEmpClass = ''
        ,drvRelationship = 'E'
        ,drvGender = EepGender
        ,drvDateOfHire = convert(varchar(10), eecDateOfLastHire, 101)
        ,drvDateOfBirth = convert(varchar(10), EepDateOfBirth, 101)
        ,drvAddressLine1 = convert(varchar(50), replace(EepAddressLine1,',',''))
        ,drvAddressLine2 = convert(varchar(50), replace(EepAddressLine2,',',''))
        ,drvAddressCity = convert(varchar(50), replace(EepAddressCity,',',''))
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode,5)
        ,drvAddressCountry = CASE WHEN EepAddressCountry <> 'USA' THEN EepAddressCountry END
        ,drvCobraElig = ''
        ,drvPrefLanguage = 'EN'
        ,drvPhoneNumber = ''    --eepPhoneHomeNumber
        ,drvEmailAddress = ''    --EepAddressEMail
        ,drvCobraIN = ''    --'C'
        ,drvHippaIN = ''    --'C'
        ,drvWaitStartDate = convert(varchar(10), eecDateOfLastHire, 101)
        ,drvCovStartDate = convert(varchar(10), minStart, 101)
        --QE Info
        ,drvQEDate = convert(varchar(10), QE.QEDate, 101) --BDM.eedDateOfCobraEvent
        ,drvLastPreCobraCov = convert(varchar(10), QE.QEDate, 101)--same as above
        ,drvQEType = CASE 
                        WHEN EecTermReason = '202' THEN '01'                    --'RETIREMENT'
                        WHEN EecTermReason = '203' THEN '21'                    --'DEATH'
                        WHEN BDM.eedCobraReason IN ('201','LEVNT3') THEN '12'    --'INELIGIBLEDEPENDENT'
                        WHEN BDM.eedCobraReason IN ('204','LEVNT4') THEN '11'    --'DIVORCELEGALSEPARATION'
                        WHEN BDM.eedCobraReason = '210' THEN '21'                --'DEATH'
                        WHEN BDM.eedCobraReason IN ('202','CHGRP') THEN '04'    --'LOSSOFELIGIBILITY'
                        WHEN BDM.eedCobraReason = '203' THEN '04'                --'REDUCTIONINHOURS-STATUSCHANGE'
                        --WHEN BDM.eedCobraReason = '205' THEN 'MEDICARE'
                        --WHEN BDM.eedCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                        WHEN BDM.eedCobraReason = '207' THEN '07'                --'USERRA-REDUCTIONINHOURS'
                        WHEN BDM.eedCobraReason = '208' THEN '01'                --'RETIREMENT'
                        --WHEN BDM.eedCobraReason = '209' THEN 'WORKSTOPPAGE'
                        ELSE '03'    --'TERMINATION'
                    END
        ,drvEligEndDate = ''
        ,drvSevThrough = ''
        ,drvSevPercent = ''
        ,drvSevMonthly = ''
        ,drvSevCredit = ''
        ,drvBillStartDate = ''
        ,drvElectNoteMailed = ''
        ,drvHippaCertMailed = ''
        ,drvElectDate = ''
        --Plan 1 MED
        ,drvPlan1Name = convert(varchar(50), case when MED.eedEEID IS NOT NULL then
                            case
                            when MED.eedDedCode in ('HMHR','HMHRT') then 'UNITED HMO + HRA MEDICAL PLAN'
                            when MED.eedDedCode in ('HMO','HMOT') then 'UNITED HMO MEDICAL PLAN'
                            when MED.eedDedCode in ('PPO','PPOT') then 'UNITED PPO MEDICAL PLAN'
                            end
                        end)
        ,drvPlan1CovCode = convert(varchar(50), case when MED.eedEEID IS NOT NULL then
                                case 
                                when MED.eedBenOption IN ('EE','EENW') then '01'
                                when MED.eedBenOption IN ('EES','EEDP','EESNW') then '06'
                                when MED.eedBenOption IN ('EEC','EECNW') then '08'
                                when MED.eedBenOption IN ('EEF','EEDPF','EEFNW') then '04'
                                end
                            end)
        ,drvPlan1CovStartDate = convert(varchar(10), MED.eedBenStartDate, 101)
        ,drvPlan1CovEndDate = ''    --convert(varchar(10), MED.eedBenStopDate, 101)
        ,drvPlan1Rate = ''
        ,drvCarrierEmpID1 = ''
        --Plan 2 DEN
        ,drvPlan2Name = convert(varchar(50), case when DEN.eedEEID IS NOT NULL then
                            case
                            when DEN.eedDedCode = 'DEN' then 'SOLSTICE DMO DENTAL PLAN'
                            when DEN.eedDedCode = 'DENPP' then 'SOLSTICE DPPO DENTAL PLAN'
                            end
                        end)
        ,drvPlan2CovCode = convert(varchar(50), case when DEN.eedEEID IS NOT NULL then
                                case 
                                when DEN.eedBenOption IN ('EE','EENW') then '31'
                                when DEN.eedBenOption IN ('EES','EEDP','EESNW') then '49'
                                when DEN.eedBenOption IN ('EEC','EECNW') then '48'
                                when DEN.eedBenOption IN ('EEF','EEDPF','EEFNW') then '32'
                                end
                            end)
        ,drvPlan2CovStartDate = convert(varchar(10), DEN.eedBenStartDate, 101)
        ,drvPlan2CovEndDate = ''    --convert(varchar(10), DEN.eedBenStopDate, 101)
        ,drvPlan2Rate = ''
        ,drvCarrierEmpID2 = ''
        --Plan 3 VIS 
        ,drvPlan3Name = convert(varchar(50), case when VIS.eedEEID IS NOT NULL then
                            case
                            when VIS.eedDedCode = 'VIS' then 'SOLSTICE VISION PLAN'
                            when VIS.eedDedCode = 'VISO' then 'SOLSTICE VISION OUT OF STATE'
                            end
                            end)
        ,drvPlan3CovCode = convert(varchar(50), case when VIS.eedEEID IS NOT NULL then
                            CASE
                            WHEN vis.eedDedCode = 'VISO' THEN
                                case 
                                when VIS.eedBenOption IN ('EE','EENW') then '01'
                                when VIS.eedBenOption IN ('EES','EEDP','EESNW') then '06'
                                when VIS.eedBenOption IN ('EEC','EECNW') then '08'
                                when VIS.eedBenOption IN ('EEF','EEDPF','EEFNW') then '04'
                                end
                            WHEN vis.eedDedCode = 'VIS' THEN
                                case 
                                when VIS.eedBenOption IN ('EE','EENW') then '31'
                                when VIS.eedBenOption IN ('EES','EEDP','EESNW') then '49'
                                when VIS.eedBenOption IN ('EEC','EECNW') then
                                    CASE
                                    WHEN VIS.EedNumChildren = 1 THEN '46'    --EE+Child
                                    ELSE '32'    --EE+2 or more
                                    END
                                when VIS.eedBenOption IN ('EEF','EEDPF','EEFNW') then '32'
                                end
                            END
                            end)
        ,drvPlan3CovStartDate = convert(varchar(10), VIS.eedBenStartDate, 101)
        ,drvPlan3CovEndDate = ''    --convert(varchar(10), VIS.eedBenStopDate, 101)
        ,drvPlan3Rate = ''
        ,drvCarrierEmpID3 = ''
        --Plan 4 FSA
        ,drvPlan4Name = ''    --convert(varchar(50), case when FSA.eedEEID IS NOT NULL then 'FSA 2019' end)
        ,drvPlan4CovCode = ''    --convert(varchar(50), case when FSA.eedEEID IS NOT NULL then '98' end)
        ,drvPlan4CovStartDate = ''    --convert(varchar(10), FSA.eedBenStartDate, 101)
        ,drvPlan4CovEndDate = ''    --convert(varchar(10), FSA.eedBenStopDate, 101)
        ,drvPlan4Rate = ''
        ,drvCarrierEmpID4 = ''
        --Plan 5
        ,drvPlan5Name = ''
        ,drvPlan5CovCode = ''
        ,drvPlan5CovStartDate = ''
        ,drvPlan5CovEndDate = ''
        ,drvPlan5Rate = ''
        ,drvCarrierEmpID5 = ''

    INTO dbo.U_ECOBPQBKWP_drvTbl
    FROM dbo.U_ECOBPQBKWP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK)
        ON cmpCOID = eecCOID
    JOIN dbo.U_dsi_BDM_EmpDeductions BDM WITH (NOLOCK)
        ON BDM.EedEEID = xEEID 
        AND BDM.EedCoID = xCoID
        AND BDM.EedFormatCode = @FormatCode 
        AND BDM.EedValidForExport = 'Y'
    LEFT JOIN (select eedEEID, MIN(eedDateOfCobraEvent) 'QEDate'
                FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
                WHERE eedFormatCode = @FormatCode
                and eedValidForExport = 'Y'
                GROUP BY eedEEID
                ) QE ON QE.eedEEID = BDM.eedEEID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions MED WITH (NOLOCK)
        ON MED.EedEEID = xEEID 
        AND MED.EedCoID = xCoID
        AND MED.EedFormatCode = @FormatCode 
        AND MED.EedValidForExport = 'Y'
        AND MED.DedDedType = 'MED'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions DEN WITH (NOLOCK)
        ON DEN.EedEEID = xEEID 
        AND DEN.EedCoID = xCoID
        AND DEN.EedFormatCode = @FormatCode 
        AND DEN.EedValidForExport = 'Y'
        AND DEN.DedDedType = 'DEN'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions VIS WITH (NOLOCK)
        ON VIS.EedEEID = xEEID 
        AND VIS.EedCoID = xCoID
        AND VIS.EedFormatCode = @FormatCode 
        AND VIS.EedValidForExport = 'Y'
        AND VIS.DedDedType = 'VIS'
    /*LEFT JOIN dbo.U_dsi_BDM_EmpDeductions FSA WITH (NOLOCK)
        ON FSA.EedEEID = xEEID 
        AND FSA.EedCoID = xCoID
        AND FSA.EedFormatCode = @FormatCode 
        AND FSA.EedValidForExport = 'Y'
        AND FSA.DedDedType = 'FSA'*/
     LEFT JOIN (select eedEEID eeid,eedCOID coid,MIN(eedBenStartDate) minStart
            FROM dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
            WHERE eedFormatCode = @FormatCode
            and eedValidForExport = 'Y'
            group by eedEEID, eedCOID
            ) CovStart ON eeid = xEEID and coid = xCOID
    
    ;


    --Terminate non-covered employee
    
    INSERT INTO dbo.U_ECOBPQBKWP_drvTbl
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitalSort = eepSSN
        ,drvSubSort = CONCAT('1',eepSSN)
        -- standard fields above and additional driver fields below
        ,drvEmployerEIN = '77-0632154'
        ,drvActionCode = '04'
        ,drvNameLast = convert(varchar(50), EepNameLast)
        ,drvNameFirst = convert(varchar(50), EepNameFirst)
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvEmpSSN = eepSSN
        ,drvDepSSN = convert(varchar(50), '')
        ,drvEmpNo = eecEmpNo
        ,drvDivision = CmpCompanyCode
        ,drvEmpClass = ''
        ,drvRelationship = 'E'
        ,drvGender = EepGender
        ,drvDateOfHire = convert(varchar(10), eecDateOfLastHire, 101)
        ,drvDateOfBirth = convert(varchar(10), EepDateOfBirth, 101)
        ,drvAddressLine1 = convert(varchar(50), replace(EepAddressLine1,',',''))
        ,drvAddressLine2 = convert(varchar(50), replace(EepAddressLine2,',',''))
        ,drvAddressCity = convert(varchar(50), replace(EepAddressCity,',',''))
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = LEFT(EepAddressZipCode,5)
        ,drvAddressCountry = CASE WHEN EepAddressCountry <> 'USA' THEN EepAddressCountry END
        ,drvCobraElig = ''
        ,drvPrefLanguage = 'EN'
        ,drvPhoneNumber = ''    --eepPhoneHomeNumber
        ,drvEmailAddress = ''    --EepAddressEMail
        ,drvCobraIN = ''    --'C'
        ,drvHippaIN = ''    --'C'
        ,drvWaitStartDate = convert(varchar(10), eecDateOfLastHire, 101)
        ,drvCovStartDate = ''
        --QE Info
        ,drvQEDate = convert(varchar(10), eecDateOfTermination, 101)
        ,drvLastPreCobraCov = ''
        ,drvQEType = CASE 
                        WHEN EecTermReason = '202' THEN '01'                    --'RETIREMENT'
                        WHEN EecTermReason = '203' THEN '21'                    --'DEATH'
                        ELSE '03'    --'TERMINATION'
                    END
        ,drvEligEndDate = ''
        ,drvSevThrough = ''
        ,drvSevPercent = ''
        ,drvSevMonthly = ''
        ,drvSevCredit = ''
        ,drvBillStartDate = ''
        ,drvElectNoteMailed = ''
        ,drvHippaCertMailed = ''
        ,drvElectDate = ''
        --Plan 1 MED
        ,drvPlan1Name = ''
        ,drvPlan1CovCode = ''
        ,drvPlan1CovStartDate = ''
        ,drvPlan1CovEndDate = ''
        ,drvPlan1Rate = ''
        ,drvCarrierEmpID1 = ''
        --Plan 2 DEN
        ,drvPlan2Name = ''
        ,drvPlan2CovCode = ''
        ,drvPlan2CovStartDate = ''
        ,drvPlan2CovEndDate = '' 
        ,drvPlan2Rate = ''
        ,drvCarrierEmpID2 = ''
        --Plan 3 VIS 
        ,drvPlan3Name = ''
        ,drvPlan3CovCode = ''
        ,drvPlan3CovStartDate = ''
        ,drvPlan3CovEndDate = ''
        ,drvPlan3Rate = ''
        ,drvCarrierEmpID3 = ''
        --Plan 4 FSA
        ,drvPlan4Name = ''
        ,drvPlan4CovCode = ''
        ,drvPlan4CovStartDate = ''
        ,drvPlan4CovEndDate = ''
        ,drvPlan4Rate = ''
        ,drvCarrierEmpID4 = ''
        --Plan 5
        ,drvPlan5Name = ''
        ,drvPlan5CovCode = ''
        ,drvPlan5CovStartDate = ''
        ,drvPlan5CovEndDate = ''
        ,drvPlan5Rate = ''
        ,drvCarrierEmpID5 = ''

    FROM dbo.U_ECOBPQBKWP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK)
        ON cmpCOID = eecCOID
    WHERE eecEmplStatus = 'T' 
    AND EecTermReason = '203' --only send this record for employee death
    AND EXISTS(SELECT 1 FROM U_ECOBPQBKWP_Audit WITH (NOLOCK)
                                         WHERE audEEID = xEEID AND audFieldName = 'EecDateofTermination')
    AND NOT EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_EmpDeductions BDM WITH (NOLOCK)
                    WHERE BDM.EedEEID = xEEID 
                    AND BDM.EedCoID = xCoID
                    AND BDM.EedFormatCode = @FormatCode 
                    AND BDM.EedValidForExport = 'Y')
    ;
    
    

    --Dependent records
    INSERT INTO dbo.U_ECOBPQBKWP_drvTbl
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),BDM.dbnDepRecID) --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitalSort = eepSSN
        ,drvSubSort = CONCAT('2',conSSN)
        -- standard fields above and additional driver fields below
        ,drvEmployerEIN = '77-0632154'
        ,drvActionCode = '06'
        ,drvNameLast = conNameLast
        ,drvNameFirst = conNameFirst
        ,drvNameMiddle = LEFT(conNameMiddle,1)
        ,drvEmpSSN = eepSSN
        ,drvDepSSN = conSSN
        ,drvEmpNo = ''
        ,drvDivision = ''
        ,drvEmpClass = ''
        ,drvRelationship = case
                            when conRelationship IN ('SPS','DP') then 'S'
                            else 'C'
                            end
        ,drvGender = conGender
        ,drvDateOfHire = convert(varchar, eecDateOfLastHire, 101)
        ,drvDateOfBirth = convert(varchar, conDateOfBirth, 101)
        ,drvAddressLine1 = replace(conAddressLine1,',','')
        ,drvAddressLine2 = replace(conAddressLine2,',','')
        ,drvAddressCity = replace(conAddressCity,',','')
        ,drvAddressState = conAddressState
        ,drvAddressZipCode = LEFT(conAddressZipCode,5)
        ,drvAddressCountry = conAddressCountry
        ,drvCobraElig = ''
        ,drvPrefLanguage = 'EN'
        ,drvPhoneNumber = ''    --conPhoneHomeNumber
        ,drvEmailAddress = ''
        ,drvCobraIN = ''
        ,drvHippaIN = ''
        ,drvWaitStartDate = convert(varchar, eecDateOfLastHire, 101)
        ,drvCovStartDate = convert(varchar, minStart, 101)    --update to min
        ,drvQEDate = convert(varchar(10), QE.QEDate, 101) --BDM.dbnDateOfCobraEvent
        ,drvLastPreCobraCov = convert(varchar(10), QE.QEDate, 101)--same as above
        ,drvQEType = CASE 
                        WHEN EecTermReason = '202' THEN '01'                    --'RETIREMENT'
                        WHEN EecTermReason = '203' THEN '14'                    --'DEATH'
                        WHEN BDM.dbnCobraReason IN ('201','LEVNT3') THEN '12'    --'INELIGIBLEDEPENDENT'
                        WHEN BDM.dbnCobraReason IN ('204','LEVNT4') THEN '11'    --'DIVORCELEGALSEPARATION'
                        WHEN BDM.dbnCobraReason = '210' THEN '14'                --'DEATH'
                        WHEN BDM.dbnCobraReason IN ('202','CHGRP') THEN '04'    --'LOSSOFELIGIBILITY'
                        WHEN BDM.dbnCobraReason = '203' THEN '04'                --'REDUCTIONINHOURS-STATUSCHANGE'
                        --WHEN BDM.dbnCobraReason = '205' THEN 'MEDICARE'
                        --WHEN BDM.dbnCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                        WHEN BDM.dbnCobraReason = '207' THEN '07'                --'USERRA-REDUCTIONINHOURS'
                        WHEN BDM.dbnCobraReason = '208' THEN '01'                --'RETIREMENT'
                        --WHEN BDM.dbnCobraReason = '209' THEN 'WORKSTOPPAGE'
                        ELSE '03'    --'TERMINATION'
                    END
        ,drvEligEndDate = ''
        ,drvSevThrough = ''
        ,drvSevPercent = ''
        ,drvSevMonthly = ''
        ,drvSevCredit = ''
        ,drvBillStartDate = ''
        ,drvElectNoteMailed = ''
        ,drvHippaCertMailed = ''
        ,drvElectDate = ''
        --Plan 1 MED
        ,drvPlan1Name = case when MED.dbnDepRecID IS NOT NULL then
                            case
                            when MED.dbnDedCode in ('HMHR','HMHRT') then 'UNITED HMO + HRA MEDICAL PLAN'
                            when MED.dbnDedCode in ('HMO','HMOT') then 'UNITED HMO MEDICAL PLAN'
                            when MED.dbnDedCode in ('PPO','PPOT') then 'UNITED PPO MEDICAL PLAN'
                            end
                        end
        ,drvPlan1CovCode = case when MED.dbnDepRecID IS NOT NULL then
                                case 
                                when MED.dbnBenOption IN ('EE','EENW') then '01'
                                when MED.dbnBenOption IN ('EES','EEDP','EESNW') then '06'
                                when MED.dbnBenOption IN ('EEC','EECNW') then '08'
                                when MED.dbnBenOption IN ('EEF','EEDPF','EEFNW') then '04'
                                end
                            end
        ,drvPlan1CovStartDate = convert(varchar, MED.dbnBenStartDate, 101)
        ,drvPlan1CovEndDate = ''    --convert(varchar, MED.dbnBenStopDate, 101)
        ,drvPlan1Rate = ''
        ,drvCarrierEmpID1 = ''
        --Plan 2 DEN
        ,drvPlan2Name = case when DEN.dbnDepRecID IS NOT NULL then
                            case
                            when DEN.dbnDedCode = 'DEN' then 'SOLSTICE DMO DENTAL PLAN'
                            when DEN.dbnDedCode = 'DENPP' then 'SOLSTICE DPPO DENTAL PLAN'
                            end
                        end
        ,drvPlan2CovCode = case when DEN.dbnDepRecID IS NOT NULL then
                                case 
                                when DEN.dbnBenOption IN ('EE','EENW') then '31'
                                when DEN.dbnBenOption IN ('EES','EEDP','EESNW') then '49'
                                when DEN.dbnBenOption IN ('EEC','EECNW') then '48'
                                when DEN.dbnBenOption IN ('EEF','EEDPF','EEFNW') then '32'
                                end
                            end
        ,drvPlan2CovStartDate = convert(varchar, DEN.dbnBenStartDate, 101)
        ,drvPlan2CovEndDate = ''    --convert(varchar, DEN.dbnBenStopDate, 101)
        ,drvPlan2Rate = ''
        ,drvCarrierEmpID2 = ''
        --Plan 3 VIS 
        ,drvPlan3Name = case when VIS.dbnDepRecID IS NOT NULL then
                            case
                            when VIS.dbnDedCode = 'VIS' then 'SOLSTICE VISION PLAN'
                            when VIS.dbnDedCode = 'VISO' then 'SOLSTICE VISION OUT OF STATE'
                            end
                            end
        ,drvPlan3CovCode = case when VIS.dbnDepRecID IS NOT NULL then
                            CASE
                            WHEN VIS.dbnDedCode = 'VISO' THEN
                                case 
                                when VIS.dbnBenOption IN ('EE','EENW') then '01'
                                when VIS.dbnBenOption IN ('EES','EEDP','EESNW') then '06'
                                when VIS.dbnBenOption IN ('EEC','EECNW') then '08'
                                when VIS.dbnBenOption IN ('EEF','EEDPF','EEFNW') then '04'
                                end
                            WHEN VIS.dbnDedCode = 'VIS' THEN
                                case 
                                when VIS.dbnBenOption IN ('EE','EENW') then '31'
                                when VIS.dbnBenOption IN ('EES','EEDP','EESNW') then '49'
                                when VIS.dbnBenOption IN ('EEC','EECNW') then
                                    CASE
                                    WHEN EEVIS.EedNumChildren = 1 THEN '46' --EE+Child
                                    ELSE '32' --EE+2 or more
                                    END
                                when VIS.dbnBenOption IN ('EEF','EEDPF','EEFNW') then '32'
                                end
                            END
                            end
        ,drvPlan3CovStartDate = convert(varchar, VIS.dbnBenStartDate, 101)
        ,drvPlan3CovEndDate = ''    --convert(varchar, VIS.dbnBenStopDate, 101)
        ,drvPlan3Rate = ''
        ,drvCarrierEmpID3 = ''
        --Plan 4 FSA
        ,drvPlan4Name = ''    --case when FSA.dbnDepRecID IS NOT NULL then 'FSA 2019' end
        ,drvPlan4CovCode = ''    --case when FSA.dbnDepRecID IS NOT NULL then '98' end
        ,drvPlan4CovStartDate = ''    --convert(varchar, FSA.dbnBenStartDate, 101)
        ,drvPlan4CovEndDate = ''    --convert(varchar, FSA.dbnBenStopDate, 101)
        ,drvPlan4Rate = ''
        ,drvCarrierEmpID4 = ''
        --Plan 5
        ,drvPlan5Name = ''
        ,drvPlan5CovCode = ''
        ,drvPlan5CovStartDate = ''
        ,drvPlan5CovEndDate = ''
        ,drvPlan5Rate = ''
        ,drvCarrierEmpID5 = ''

    FROM dbo.U_ECOBPQBKWP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON eepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK)
        ON cmpCOID = eecCOID
    JOIN dbo.U_dsi_BDM_DepDeductions BDM WITH (NOLOCK)
        ON BDM.dbnEEID = xEEID 
        AND BDM.dbnCoID = xCoID
        AND BDM.dbnFormatCode = @FormatCode 
        AND BDM.dbnValidForExport = 'Y'
        AND BDM.dbnIsPQB = 'Y'    --only send '06' records for dependent QBs
    JOIN dbo.Contacts WITH (NOLOCK)
        ON conSystemID = dbnDepRecID
    LEFT JOIN (select dbnDepRecID, MIN(dbnDateOfCObraEvent) 'QEDate'
                FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
                WHERE dbnFormatCode = @FormatCode 
                and dbnValidForExport = 'Y'
                GROUP BY dbnDepRecID 
                ) QE ON QE.DbnDepRecID = BDM.DbnDepRecID
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions MED WITH (NOLOCK)
        ON MED.dbnEEID = xEEID 
        AND MED.dbnCoID = xCoID
        AND MED.dbnFormatCode = @FormatCode 
        AND MED.dbnValidForExport = 'Y'
        AND MED.DedDedType = 'MED'
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions DEN WITH (NOLOCK)
        ON DEN.dbnEEID = xEEID 
        AND DEN.dbnCoID = xCoID
        AND DEN.dbnFormatCode = @FormatCode 
        AND DEN.dbnValidForExport = 'Y'
        AND DEN.DedDedType = 'DEN'
    LEFT JOIN dbo.U_dsi_BDM_DepDeductions VIS WITH (NOLOCK)
        ON VIS.dbnEEID = xEEID 
        AND VIS.dbnCoID = xCoID
        AND VIS.dbnFormatCode = @FormatCode 
        AND VIS.dbnValidForExport = 'Y'
        AND VIS.DedDedType = 'VIS'
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions EEVIS WITH (NOLOCK)
        ON EEVIS.EedEEID = xEEID 
        AND EEVIS.EedCoID = xCoID
        AND EEVIS.EedFormatCode = @FormatCode 
        AND EEVIS.EedValidForExport = 'Y'
        AND EEVIS.DedDedType = 'VIS'
        AND EEVIS.EedDedCode = VIS.DbnDedCode
    /*LEFT JOIN dbo.U_dsi_BDM_DepDeductions FSA WITH (NOLOCK)
        ON FSA.dbnEEID = xEEID 
        AND FSA.dbnCoID = xCoID
        AND FSA.dbnFormatCode = @FormatCode 
        AND FSA.dbnValidForExport = 'Y'
        AND FSA.DedDedType = 'FSA'*/
     LEFT JOIN (select dbnEEID eeid,dbnDepReciD depID,MIN(dbnBenStartDate) minStart
            FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
            WHERE dbnFormatCode = @FormatCode
            and dbnValidForExport = 'Y'
            group by dbnEEID, dbnDepRecID
            ) CovStart ON eeid = xEEID and depID = conSystemID
    
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
ALTER VIEW dbo.dsi_vwECOBPQBKWP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECOBPQBKWP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECOBPQBKWP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912311'
       ,expStartPerControl     = '201912311'
       ,expLastEndPerControl   = '202001079'
       ,expEndPerControl       = '202001079'
WHERE expFormatCode = 'ECOBPQBKWP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECOBPQBKWP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECOBPQBKWP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort