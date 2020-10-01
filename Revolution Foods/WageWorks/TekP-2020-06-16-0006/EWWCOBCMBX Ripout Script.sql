SET NOCOUNT ON;
IF OBJECT_ID('U_EWWCOBCMBX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBCMBX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EWWCOBCMBX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EWWCOBCMBX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEWWCOBCMBX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWWCOBCMBX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWWCOBCMBX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWWCOBCMBX];
GO
IF OBJECT_ID('U_EWWCOBCMBX_File') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBCMBX_File];
GO
IF OBJECT_ID('U_EWWCOBCMBX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBCMBX_EEList];
GO
IF OBJECT_ID('U_EWWCOBCMBX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBCMBX_drvTbl];
GO
IF OBJECT_ID('U_EWWCOBCMBX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBCMBX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EWWCOBCMBX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EWWCOBCMBX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EWWCOBCMBX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EWWCOBCMBX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EWWCOBCMBX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EWWCOBCMBX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EWWCOBCMBX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EWWCOBCMBX','WageWorks Combind COBRA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EWWCOBCMBXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYER_EIN"','1','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','1',NULL,'EMPLOYER_EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACTION_CODE"','2','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','2',NULL,'ACTION_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST_NAME"','3','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','3',NULL,'LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST_NAME"','4','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','4',NULL,'FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE_INITIAL"','5','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','5',NULL,'MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE_SSN"','6','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','6',NULL,'EMPLOYEE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEPENDENT_SSN"','7','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','7',NULL,'DEPENDENT_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE_NUMBER"','8','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','8',NULL,'EMPLOYEE_NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','9','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','9',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE_CLASS"','10','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','10',NULL,'EMPLOYEE_CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RELATIONSHIP"','11','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','11',NULL,'RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','12','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','12',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HIRE_DATE"','13','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','13',NULL,'HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BIRTH_DATE"','14','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','14',NULL,'BIRTH_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS_1"','15','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','15',NULL,'ADDRESS_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS_2"','16','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','16',NULL,'ADDRESS_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY"','17','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','17',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATE"','18','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','18',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP"','19','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','19',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUNTRY"','20','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','20',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER_1"','21','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','21',NULL,'FILLER_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COBRA_ELIGIBLE"','22','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','22',NULL,'COBRA_ELIGIBLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PREFERRED_LANGUAGE"','23','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','23',NULL,'PREFERRED_LANGUAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PHONE_NUMBER"','24','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','24',NULL,'PHONE_NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E_MAIL_ADDRESS"','25','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','25',NULL,'E_MAIL_ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INITIAL_NOTIFICATION_COBRA"','26','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','26',NULL,'INITIAL_NOTIFICATION_COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INITIAL_NOTIFICATION_HIPAA"','27','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','27',NULL,'INITIAL_NOTIFICATION_HIPAA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WAITING_START_DATE"','28','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','28',NULL,'WAITING_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVERAGE_BEGIN_DATE"','29','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','29',NULL,'COVERAGE_BEGIN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER_2"','30','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','30',NULL,'FILLER_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QUALIFYING EVENT_DATE"','31','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','31',NULL,'QUALIFYING EVENT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST_PRECOBRA_COVERED"','32','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','32',NULL,'LAST_PRECOBRA_COVERED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QUALIFYING_EVENT_TYPE"','33','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','33',NULL,'QUALIFYING_EVENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELIGIBILITY_END_DATE"','34','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','34',NULL,'ELIGIBILITY_END_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEVERANCE_THROUGH"','35','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','35',NULL,'SEVERANCE_THROUGH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEVERANCE_PERCENT"','36','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','36',NULL,'SEVERANCE_PERCENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEVERANCE_MONTHLY"','37','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','37',NULL,'SEVERANCE_MONTHLY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SEVERANCE_CREDIT"','38','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','38',NULL,'SEVERANCE_CREDIT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BILLING_START_DATE"','39','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','39',NULL,'BILLING_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELECTION_NOTE_MAILED"','40','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','40',NULL,'ELECTION_NOTE_MAILED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HIPAA_CERTIFICATE_MAILED"','41','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','41',NULL,'HIPAA_CERTIFICATE_MAILED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELECTION_DATE"','42','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','42',NULL,'ELECTION_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER_3"','43','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','43',NULL,'FILLER_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_NAME1"','44','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','44',NULL,'PLAN_NAME1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_CODE1"','45','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','45',NULL,'PLAN_COV_CODE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_START1"','46','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','46',NULL,'PLAN_COV_START1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_END1"','47','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','47',NULL,'PLAN_COV_END1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_RATE1"','48','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','48',NULL,'PLAN_RATE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER"','49','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','49',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CARRIER_EMPLOYEE_ID1"','50','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','50',NULL,'CARRIER_EMPLOYEE_ID1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_FILLER1"','51','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','51',NULL,'PLAN_FILLER1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_NAME2"','52','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','52',NULL,'PLAN_NAME2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_CODE2"','53','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','53',NULL,'PLAN_COV_CODE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_START2"','54','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','54',NULL,'PLAN_COV_START2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_END2"','55','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','55',NULL,'PLAN_COV_END2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_RATE2"','56','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','56',NULL,'PLAN_RATE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER"','57','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','57',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CARRIER_EMPLOYEE_ID2"','58','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','58',NULL,'CARRIER_EMPLOYEE_ID2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_FILLER2"','59','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','59',NULL,'PLAN_FILLER2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_NAME3"','60','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','60',NULL,'PLAN_NAME3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_CODE3"','61','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','61',NULL,'PLAN_COV_CODE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_START3"','62','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','62',NULL,'PLAN_COV_START3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_COV_END3"','63','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','63',NULL,'PLAN_COV_END3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_RATE3"','64','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','64',NULL,'PLAN_RATE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER"','65','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','65',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CARRIER_EMPLOYEE_ID3"','66','(''DA''=''T,'')','EWWCOBCMBXZ0','50','H','01','66',NULL,'CARRIER_EMPLOYEE_ID3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_FILLER3"','67','(''DA''=''T'')','EWWCOBCMBXZ0','50','H','01','67',NULL,'PLAN_FILLER3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"14-1955846"','1','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','1',NULL,'EMPLOYER_EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActionCode"','2','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','2',NULL,'ACTION_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','3',NULL,'LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','4',NULL,'FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','5','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','5',NULL,'MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','6','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','6',NULL,'EMPLOYEE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentSSN"','7','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','7',NULL,'DEPENDENT_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','8','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','8',NULL,'EMPLOYEE_NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','9',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','10',NULL,'EMPLOYEE_CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','11','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','11',NULL,'RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','12',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','13','(''UD101''=''T,'')','EWWCOBCMBXZ0','50','D','10','13',NULL,'HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','14','(''UD101''=''T,'')','EWWCOBCMBXZ0','50','D','10','14',NULL,'BIRTH_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','15','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','15',NULL,'ADDRESS_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','16','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','16',NULL,'ADDRESS_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','17',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','18',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','19','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','19',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','20',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','21',NULL,'FILLER_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCobraEligible"','22','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','22',NULL,'COBRA_ELIGIBLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','23','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','23',NULL,'PREFERRED_LANGUAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','24','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','24',NULL,'PHONE_NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','25','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','25',NULL,'E_MAIL_ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInitialNotificationCobra"','26','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','26',NULL,'INITIAL_NOTIFICATION_COBRA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','27',NULL,'INITIAL_NOTIFICATION_HIPAA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWaitingStartDate"','28','(''UD101''=''T,'')','EWWCOBCMBXZ0','50','D','10','28',NULL,'WAITING_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageBeginDate"','29','(''UD101''=''T,'')','EWWCOBCMBXZ0','50','D','10','29',NULL,'COVERAGE_BEGIN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','30',NULL,'FILLER_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQuallifingEventDate"','31','(''UD101''=''T,'')','EWWCOBCMBXZ0','50','D','10','31',NULL,'QUALIFYING EVENT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastPreCobraCovered"','32','(''UD101''=''T,'')','EWWCOBCMBXZ0','50','D','10','32',NULL,'LAST_PRECOBRA_COVERED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQuallifingEventType"','33','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','33',NULL,'QUALIFYING_EVENT_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','34',NULL,'ELIGIBILITY_END_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','35',NULL,'SEVERANCE_THROUGH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','36',NULL,'SEVERANCE_PERCENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','37',NULL,'SEVERANCE_MONTHLY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','38',NULL,'SEVERANCE_CREDIT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','39',NULL,'BILLING_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','40',NULL,'ELECTION_NOTE_MAILED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','41',NULL,'HIPAA_CERTIFICATE_MAILED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','42',NULL,'ELECTION_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','43',NULL,'FILLER_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName1"','44','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','44',NULL,'PLAN_NAME1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovCode1"','45','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','45',NULL,'PLAN_COV_CODE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovStart1"','46','(''UD101''=''T,'')','EWWCOBCMBXZ0','50','D','10','46',NULL,'PLAN_COV_START1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','47','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','47',NULL,'PLAN_COV_END1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','48',NULL,'PLAN_RATE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','49',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','50',NULL,'CARRIER_EMPLOYEE_ID1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','51',NULL,'PLAN_FILLER1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName2"','52','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','52',NULL,'PLAN_NAME2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovCode2"','53','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','53',NULL,'PLAN_COV_CODE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovStart2"','54','(''UD101''=''T,'')','EWWCOBCMBXZ0','50','D','10','54',NULL,'PLAN_COV_START2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','55',NULL,'PLAN_COV_END2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','56',NULL,'PLAN_RATE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','57',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','58',NULL,'CARRIER_EMPLOYEE_ID2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','59',NULL,'PLAN_FILLER2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName3"','60','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','60',NULL,'PLAN_NAME3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovCode3"','61','(''UA''=''T,'')','EWWCOBCMBXZ0','50','D','10','61',NULL,'PLAN_COV_CODE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCovStart3"','62','(''UD101''=''T,'')','EWWCOBCMBXZ0','50','D','10','62',NULL,'PLAN_COV_START3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','63',NULL,'PLAN_COV_END3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','64',NULL,'PLAN_RATE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','65',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''T,'')','EWWCOBCMBXZ0','50','D','10','66',NULL,'CARRIER_EMPLOYEE_ID3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''T'')','EWWCOBCMBXZ0','50','D','10','67',NULL,'PLAN_FILLER3',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWWCOBCMBX_20200928.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WageWorks Combind COBRA Export','202009219','EMPEXPORT','ONDEM_XOE',NULL,'EWWCOBCMBX',NULL,NULL,NULL,'202009219','Sep 23 2020  4:25PM','Sep 23 2020  4:25PM','202008011',NULL,'','','202008011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWWCOBCMBX_20200928.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'WageWorks Combind COBRA -Sched','202009219','EMPEXPORT','SCH_EWWCOB',NULL,'EWWCOBCMBX',NULL,NULL,NULL,'202009219','Sep 23 2020  4:25PM','Sep 23 2020  4:25PM','202008011',NULL,'','','202008011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWWCOBCMBX_20200928.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202009219','EMPEXPORT','OEACTIVE',NULL,'EWWCOBCMBX',NULL,NULL,NULL,'202009219','Sep 23 2020  4:25PM','Sep 23 2020  4:25PM','202008011',NULL,'','','202008011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWWCOBCMBX_20200928.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202009219','EMPEXPORT','OEPASSIVE',NULL,'EWWCOBCMBX',NULL,NULL,NULL,'202009219','Sep 23 2020  4:25PM','Sep 23 2020  4:25PM','202008011',NULL,'','','202008011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EWWCOBCMBX_20200928.txt',NULL,'','','',NULL,NULL,NULL,'WageWorks Combind COBRA -Test','202009281','EMPEXPORT','TEST_XOE','Sep 28 2020 10:54AM','EWWCOBCMBX',NULL,NULL,NULL,'202009281','Sep 28 2020 12:00AM','Dec 30 1899 12:00AM','202009141','54','','','202009141',dbo.fn_GetTimedKey(),NULL,'us3cPeREV1004',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EWWCOBCMBX_20200928.txt' END WHERE expFormatCode = 'EWWCOBCMBX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBCMBX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBCMBX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBCMBX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBCMBX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBCMBX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EWWCOBCMBX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EWWCOBCMBX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EWWCOBCMBX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBCMBX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWWCOBCMBX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWWCOBCMBX','D10','dbo.U_EWWCOBCMBX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EWWCOBCMBX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EWWCOBCMBX] (
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
IF OBJECT_ID('U_EWWCOBCMBX_DedList') IS NULL
CREATE TABLE [dbo].[U_EWWCOBCMBX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EWWCOBCMBX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBCMBX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(5) NULL,
    [drvActionCode] varchar(2) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvEmployeeSSN] varchar(11) NULL,
    [drvDependentSSN] varchar(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvRelationship] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvHireDate] datetime NULL,
    [drvBirthDate] datetime NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCobraEligible] varchar(1) NULL,
    [drvPhoneNumber] varchar(12) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvInitialNotificationCobra] varchar(1) NULL,
    [drvWaitingStartDate] datetime NULL,
    [drvCoverageBeginDate] datetime NULL,
    [drvQuallifingEventDate] datetime NULL,
    [drvLastPreCobraCovered] datetime NULL,
    [drvQuallifingEventType] varchar(2) NULL,
    [drvPlanName1] varchar(24) NULL,
    [drvPlanCovCode1] varchar(2) NULL,
    [drvPlanCovStart1] datetime NULL,
    [drvPlanName2] varchar(26) NULL,
    [drvPlanCovCode2] varchar(2) NULL,
    [drvPlanCovStart2] datetime NULL,
    [drvPlanName3] varchar(15) NULL,
    [drvPlanCovCode3] varchar(2) NULL,
    [drvPlanCovStart3] datetime NULL
);
IF OBJECT_ID('U_EWWCOBCMBX_EEList') IS NULL
CREATE TABLE [dbo].[U_EWWCOBCMBX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EWWCOBCMBX_File') IS NULL
CREATE TABLE [dbo].[U_EWWCOBCMBX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWWCOBCMBX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Revolution Foods

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 09/23/2020
Service Request Number: TekP-2020-06-16-0006

Purpose: WageWorks Combind COBRA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWWCOBCMBX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWWCOBCMBX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWWCOBCMBX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWWCOBCMBX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWWCOBCMBX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBCMBX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBCMBX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBCMBX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBCMBX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBCMBX', 'SCH_EWWCOB';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWWCOBCMBX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EWWCOBCMBX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EWWCOBCMBX';

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
    DELETE FROM dbo.U_EWWCOBCMBX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EWWCOBCMBX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MEDCI, MEDCO, MEDM1, MEDM2, MEDH3, MEDM3, MEDB1, MEDB2, MDK2C, MDK1C, DHPPT, DHPPD, DHPPC, DHPPR, DHPPT, DLPPT, DLPPC, DLPPR, DLPPD, DHMOT, DHMOC, VSP';

    IF OBJECT_ID('U_EWWCOBCMBX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EWWCOBCMBX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EWWCOBCMBX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section - NPM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- Include deds where DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','2'); -- 2 -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeIncludeEmps','Y'); -- Include employees when dependent is eligible

    /*-- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;*/

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section - QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,203,204,205,208,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons

    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsEmpPQB','201,204,210,LEVNT3,LEVNT4');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDep','201,204,210,LEVNT3,LEVNT4');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsEmp','201,204,210,LEVNT3,LEVNT4');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDep','201,204,210,LEVNT3,LEVNT4');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsEmp','200,201,202,203,204,205,206,207,208,209,210,999,LEVNT1,LEVNT2,LEVNT3,LEVNT4,LEVNT5');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDep','200,201,202,203,204,205,206,207,208,209,210,999,LEVNT1,LEVNT2,LEVNT3,LEVNT4,LEVNT5');




    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,203,204,208,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DAU,SON,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================

    DELETE dbo.U_dsi_BDM_EWWCOBCMBX WHERE BdmBenStatus = 'C';
    DELETE dbo.U_dsi_BDM_EWWCOBCMBX WHERE BdmRunID = 'NPM' AND BdmBenStatus = 'T';
    --(SELECT DISTINCT EecEmplStatus FROM dbo.EmpComp WITH (NOLOCK) JOIN dbo.U_EWWCOBCMBX_EEList WITH (NOLOCK) ON xEEID = EecEEID AND xCOID = EecCOID WHERE EecEmplStatus = 'T');

    ---------------------------------
    -- DETAIL RECORD - U_EWWCOBCMBX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EWWCOBCMBX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EWWCOBCMBX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        --,drvSort = '' -- 'BdmRunID: ' + BdmRunID + ' | BdmCobraReason: ' + BdmCobraReason + ' | BdmIsPQB: ' + BdmIsPQB + ' | BdmDepRecId: ' + ISNULL(BdmDepRecID, '')    
        ,drvSort = DedCode_MDK1C -- BdmRecType + ' :: EecEmplStatus - ' + EecEmplStatus + ' :: BdmBenStatus - ' + BdmBenStatus + ' :: BdmRunId - ' + BdmRunId --'BdmRecType: ' + BdmRecType + ' | EecEmplStatus: ' + EecEmplStatus + ' | BdmRunId: '+ BdmRunId + ' | BdmBenStatus: ' + BdmBenStatus
        -- standard fields above and additional driver fields below
        ,drvActionCode =    CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmRunID = 'NPM' THEN '01'
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'A' AND BdmRunID = 'NPM'  THEN '02'
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus IN ('T', 'L') AND BdmRunID = 'QB' THEN '03'
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN '03'
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus IN ('T', 'L') AND BdmRunId = 'QB' THEN '06'
--                                WHEN EecEmplStatus = 'L' THEN '90'
                                ELSE '99'
                            END
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddle = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvEmployeeSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(eepSSN, 5), 2) + '-' + RIGHT(LEFT(eepSSN, 9), 4)
        ,drvDependentSSN = CASE WHEN BdmRecType = 'DEP' THEN LEFT(ConSSN, 3) + '-' + RIGHT(LEFT(ConSSN, 5), 2) + '-' + RIGHT(LEFT(ConSSN, 9), 4) END
        ,drvEmployeeNumber = EecEmpNo
        ,drvRelationship =    CASE WHEN BdmRecType = 'EMP' THEN 'E'
                                ELSE
                                    CASE WHEN ConRelationship IN ('CHL','DAU','SON') THEN 'C'
                                        WHEN ConRelationship IN ('STC') THEN 'Q'
                                        WHEN ConRelationship IN ('SPS') THEN 'S'
                                        WHEN ConRelationship IN ('SP') THEN 'W'
                                    END
                            END
        ,drvGender =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN EepGender = 'M' THEN 'M'
                                WHEN EepGender = 'F' THEN 'F'
                                ELSE 'U'
                            END
                        WHEN BdmRecType = 'DEP' THEN
                            CASE WHEN ConGender = 'M' THEN 'M'
                                WHEN ConGender = 'F' THEN 'F'
                                ELSE 'U'
                            END
                        END
        ,drvHireDate = EecDateOfLastHire
        ,drvBirthDate =    CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmRunID = 'NPM' THEN EepDateOfBirth
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'A' AND BdmRunID = 'NPM'  THEN ConDateOfBirth
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' AND BdmRunID = 'QB' THEN EepDateOfBirth
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN EepDateOfBirth
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN ConDateOfBirth
                                WHEN EecEmplStatus = 'L' THEN '1/1/1900'
                                ELSE '12/31/1900'
                            END
        ,drvAddressLine1 =    '"' +CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmRunID = 'NPM' THEN EepAddressLine1
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'A' AND BdmRunID = 'NPM'  THEN ConAddressLine1
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' AND BdmRunID = 'QB' THEN EepAddressLine1
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN EepAddressLine1
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN ConAddressLine1
                            END + '"'
        ,drvAddressLine2 = '"' + REPLACE(ISNULL(CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmRunID = 'NPM' THEN EepAddressLine2
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'A' AND BdmRunID = 'NPM'  THEN ConAddressLine2
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' AND BdmRunID = 'QB' THEN EepAddressLine2
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN EepAddressLine2
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN ConAddressLine2
                            END, ''), '  ', '') + '"'
        ,drvAddressCity = CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmRunID = 'NPM' THEN EepAddressCity
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'A' AND BdmRunID = 'NPM'  THEN ConAddressCity
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' AND BdmRunID = 'QB' THEN EepAddressCity
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN EepAddressCity
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN ConAddressCity
                            END
        ,drvAddressState = CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmRunID = 'NPM' THEN EepAddressState
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'A' AND BdmRunID = 'NPM'  THEN ConAddressState
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' AND BdmRunID = 'QB' THEN EepAddressState
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN EepAddressState
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN ConAddressState
                            END
        ,drvAddressZipCode =    CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmRunID = 'NPM' THEN EepAddressZipCode
                                    WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'A' AND BdmRunID = 'NPM'  THEN ConAddressZipCode
                                    WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' AND BdmRunID = 'QB' THEN EepAddressZipCode
                                    WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN EepAddressZipCode
                                    WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN ConAddressZipCode
                                END
        ,drvCobraEligible = CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmRunID = 'NPM' THEN 'Y' END
        ,drvPhoneNumber =    CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmRunID = 'NPM' THEN LEFT(EepPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4)
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'A' AND BdmRunID = 'NPM'  THEN LEFT(ConPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(ConPhoneHomeNumber, 6), 3) + '-' + RIGHT(ConPhoneHomeNumber, 4)
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' AND BdmRunID = 'QB' THEN LEFT(EepPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4)
                                WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN LEFT(EepPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(EepPhoneHomeNumber, 6), 3) + '-' + RIGHT(EepPhoneHomeNumber, 4)
                                WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN LEFT(ConPhoneHomeNumber, 3) + '-' + RIGHT(LEFT(ConPhoneHomeNumber, 6), 3) + '-' + RIGHT(ConPhoneHomeNumber, 4)
                                WHEN EecEmplStatus = 'L' THEN '90'
                                ELSE '99'
                            END
        ,drvEmailAddress = EepAddressEMailAlternate
        ,drvInitialNotificationCobra = CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmRunID = 'NPM' THEN 'C' END
        ,drvWaitingStartDate = EecDateOfLastHire
        ,drvCoverageBeginDate = BdmBenStartDate
        ,drvQuallifingEventDate =    CASE WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DAU','DP','SON','SPS','STC') AND BdmBenStatus = 'T' THEN EecDateOfTermination
                                        WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DAU','DP','SON','SPS','STC') AND BdmBenStatus <> 'T' THEN ConCobraStatusDate
                                        WHEN BdmRecType = 'EMP' AND BdmBenStatus = 'T' THEN EecDateOfTermination
                                    END
                                    --CASE WHEN /*ConRelationship IN ('CHL','DAU','DP','SON','SPS','STC') and*/ BdmBenStatus IN ('A','T') THEN BdmBenStartDate END
                                    /*CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' AND BdmRunID = 'QB' THEN EepDateOfCOBRAEvent -- JCB
                                        WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN EepDateOfCOBRAEvent
                                        WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN ConCOBRAStatusDate
                                    END*/
        ,drvLastPreCobraCovered =    CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' AND BdmRunID = 'QB' THEN BdmBenStopDate
                                        WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'A' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN BdmBenStopDate
                                        WHEN BdmRecType = 'DEP' AND BdmBenStatus = 'T' AND BdmRunId = 'QB' THEN BdmBenStopDate
                                    END
        ,drvQuallifingEventType =    CASE WHEN ConRelationship IN ('SPS','DP') AND BdmBenStatus = 'T' AND BdmCobraReason IN ('204', 'LEVNT4') THEN '11'
                                        WHEN ConRelationship IN ('CHL','DAU','DP','SON','SPS','STC') AND EecEmplStatus = 'T' and EecTermReason = '203' THEN '14'
                                        WHEN ConRelationship IN ('CHL','DAU','SON','STC') and BdmBenStatus = 'T' and BdmCobraReason IN ('201','LEVNT3') THEN '12'
                                        WHEN EecEmplStatus = 'T' and EecTermReason NOT IN ('202','203','208') THEN '03'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '208' THEN '05'
                                        WHEN BdmCobraReason = '208' OR (EecTermReason = 'T' AND EecTermReason = '202') THEN '01'
                                        WHEN BdmCobraReason IN ('203','202') THEN '04'
                                    END
        ,drvPlanName1 =    CASE WHEN DedCode_MEDCI IS NOT NULL OR DedCode_MEDCO IS NOT NULL THEN 'Aetna Bronze (HDHP OAMC)'
                            WHEN DedCode_MEDM2 IS NOT NULL OR DedCode_MEDM1 IS NOT NULL THEN 'Aetna Gold (OAMC 5)'
                            WHEN DedCode_MEDH3 IS NOT NULL THEN 'Aetna NJ Gold HMO'
                            WHEN DedCode_MEDM3 IS NOT NULL THEN 'Aetna NJ Silver DHMO'
                            WHEN DedCode_MEDB2 IS NOT NULL OR DedCode_MEDB1 IS NOT NULL THEN 'Aetna Silver (OAMC 3)'
                            WHEN DedCode_MDK2C IS NOT NULL THEN 'Kaiser CA Gold HMO'
                            WHEN DedCode_MDK1C IS NOT NULL THEN 'Kaiser CA Silver DHMO'
                        END
        ,drvPlanCovCode1 =    CASE BenOption_MED
                                WHEN 'EE' THEN '01'
                                WHEN 'FAM' THEN '04'
                                WHEN 'EES' THEN '06'
                                WHEN 'EEC' THEN '07'
                            END
        ,drvPlanCovStart1 = BenStartDate_MED
        ,drvPlanName2 =    CASE WHEN DedCode_DHPPT IS NOT NULL THEN 'Guardian Dental NAP TX'
                            WHEN DedCode_DHPPD IS NOT NULL OR DedCode_DHPPC IS NOT NULL OR DedCode_DHPPR IS NOT NULL OR DedCode_DHPPT IS NOT NULL THEN 'Guardian Dental PPO Gold'
                            WHEN DedCode_DLPPT IS NOT NULL OR DedCode_DLPPC IS NOT NULL OR DedCode_DLPPR IS NOT NULL OR DedCode_DLPPD IS NOT NULL THEN 'Guardian Dental PPO Silver'
                            WHEN DedCode_DHMOT IS NOT NULL OR DedCode_DHMOC IS NOT NULL THEN 'Guardian DHMO Bronze'
                        END
        ,drvPlanCovCode2 = CASE BenOption_DEN
                                WHEN 'EE' THEN '01'
                                WHEN 'FAM' THEN '04'
                                WHEN 'EES' THEN '06'
                                WHEN 'EEC' THEN '07'
                            END
        ,drvPlanCovStart2 = BenStartDate_DEN
        ,drvPlanName3 = CASE WHEN DedCode_VSP IS NOT NULL THEN 'VSP Vision Plan' END
        ,drvPlanCovCode3 = CASE BenOption_VIS
                                WHEN 'EE' THEN '01'
                                WHEN 'FAM' THEN '04'
                                WHEN 'EES' THEN '06'
                                WHEN 'EEC' THEN '07'
                            END
        ,drvPlanCovStart3 = BenStartDate_VIS
    INTO dbo.U_EWWCOBCMBX_drvTbl
    FROM dbo.U_EWWCOBCMBX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    /*JOIN dbo.U_dsi_BDM_EWWCOBCMBX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID*/
    JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
                ,MAX(BdmBenStartDate) AS BdmBenStartDate
                ,MAX(BdmBenStopDate) AS BdmBenStopDate
                ,MAX(BdmCobraReason) AS BdmCobraReason
                ,MAX(BdmIsPQB) AS BdmIsPQB
                ,MAX(CASE WHEN BdmDedCode = 'MEDCI' THEN BdmDedCode END) AS DedCode_MEDCI
                ,MAX(CASE WHEN BdmDedCode = 'MEDCO' THEN BdmDedCode END) AS DedCode_MEDCO
                ,MAX(CASE WHEN BdmDedCode = 'MEDM2' THEN BdmDedCode END) AS DedCode_MEDM2
                ,MAX(CASE WHEN BdmDedCode = 'MEDM1' THEN BdmDedCode END) AS DedCode_MEDM1
                ,MAX(CASE WHEN BdmDedCode = 'MEDH3' THEN BdmDedCode END) AS DedCode_MEDH3
                ,MAX(CASE WHEN BdmDedCode = 'MEDB2' THEN BdmDedCode END) AS DedCode_MEDB2
                ,MAX(CASE WHEN BdmDedCode = 'MEDB1' THEN BdmDedCode END) AS DedCode_MEDB1
                ,MAX(CASE WHEN BdmDedCode = 'MEDM3' THEN BdmDedCode END) AS DedCode_MEDM3
                ,MAX(CASE WHEN BdmDedCode = 'MDK2C' THEN BdmDedCode END) AS DedCode_MDK2C
                ,MAX(CASE WHEN BdmDedCode = 'MDK2R' THEN BdmDedCode END) AS DedCode_MDK2R
                ,MAX(CASE WHEN BdmDedCode = 'MDK2D' THEN BdmDedCode END) AS DedCode_MDK2D
                ,MAX(CASE WHEN BdmDedCode = 'MDK1D' THEN BdmDedCode END) AS DedCode_MDK1D
                ,MAX(CASE WHEN BdmDedCode = 'MDK1C' THEN BdmDedCode END) AS DedCode_MDK1C
                ,MAX(CASE WHEN BdmDedCode = 'MDK3R' THEN BdmDedCode END) AS DedCode_MDK3R
                ,MAX(CASE WHEN BdmDedCode = 'MDK3D' THEN BdmDedCode END) AS DedCode_MDK3D
                ,MAX(CASE WHEN BdmDedCode = 'DHMOT' THEN BdmDedCode END) AS DedCode_DHMOT
                ,MAX(CASE WHEN BdmDedCode = 'DHMOC' THEN BdmDedCode END) AS DedCode_DHMOC
                ,MAX(CASE WHEN BdmDedCode = 'DHPPD' THEN BdmDedCode END) AS DedCode_DHPPD
                ,MAX(CASE WHEN BdmDedCode = 'DHPPC' THEN BdmDedCode END) AS DedCode_DHPPC
                ,MAX(CASE WHEN BdmDedCode = 'DHPPR' THEN BdmDedCode END) AS DedCode_DHPPR
                ,MAX(CASE WHEN BdmDedCode = 'DHPPT' THEN BdmDedCode END) AS DedCode_DHPPT
                ,MAX(CASE WHEN BdmDedCode = 'DLPPT' THEN BdmDedCode END) AS DedCode_DLPPT
                ,MAX(CASE WHEN BdmDedCode = 'DLPPC' THEN BdmDedCode END) AS DedCode_DLPPC
                ,MAX(CASE WHEN BdmDedCode = 'DLPPR' THEN BdmDedCode END) AS DedCode_DLPPR
                ,MAX(CASE WHEN BdmDedCode = 'DLPPD' THEN BdmDedCode END) AS DedCode_DLPPD
                ,MAX(CASE WHEN BdmDedCode = 'VSP' THEN BdmDedCode END) AS DedCode_VSP
                ,MAX(CASE WHEN BdmDedType = 'MED' THEN BdmBenOption END) AS BenOption_MED
                ,MAX(CASE WHEN BdmDedType = 'DEN' THEN BdmBenOption END) AS BenOption_DEN
                ,MAX(CASE WHEN BdmDedType = 'VIS' THEN BdmBenOption END) AS BenOption_VIS
                ,MAX(CASE WHEN BdmDedCode IN ('MEDCI','MEDCO','MEDM1','MEDM2','MEDH3','MEDM3','MEDB1','MEDB2','MDK2C','MDK1C') THEN BdmBenStartDate END) AS BenStartDate_MED
                ,MAX(CASE WHEN BdmDedCode IN ('DHPPT','DHPPD','DHPPC','DHPPR','DHPPT','DLPPT','DLPPC','DLPPR','DLPPD','DHMOT','DHMOC') THEN BdmBenStartDate END) AS BenStartDate_DEN
                ,MAX(CASE WHEN BdmDedCode IN ('VSP') THEN BdmBenStartDate END) AS BenStartDate_VIS
/*                ,MAX(CASE WHEN BdmDedCode = 'MEDCI' THEN BdmBenOption END) AS BenOption_MEDCI
                ,MAX(CASE WHEN BdmDedCode = 'MEDCO' THEN BdmBenOption END) AS BenOption_MEDCO
                ,MAX(CASE WHEN BdmDedCode = 'MEDM2' THEN BdmBenOption END) AS BenOption_MEDM2
                ,MAX(CASE WHEN BdmDedCode = 'MEDM1' THEN BdmBenOption END) AS BenOption_MEDM1
                ,MAX(CASE WHEN BdmDedCode = 'MEDH3' THEN BdmBenOption END) AS BenOption_MEDH3
                ,MAX(CASE WHEN BdmDedCode = 'MEDB2' THEN BdmBenOption END) AS BenOption_MEDB2
                ,MAX(CASE WHEN BdmDedCode = 'MEDB1' THEN BdmBenOption END) AS BenOption_MEDB1
                ,MAX(CASE WHEN BdmDedCode = 'MEDM3' THEN BdmBenOption END) AS BenOption_MEDM3
                ,MAX(CASE WHEN BdmDedCode = 'MDK2C' THEN BdmBenOption END) AS BenOption_MDK2C
                ,MAX(CASE WHEN BdmDedCode = 'MDK2R' THEN BdmBenOption END) AS BenOption_MDK2R
                ,MAX(CASE WHEN BdmDedCode = 'MDK2D' THEN BdmBenOption END) AS BenOption_MDK2D
                ,MAX(CASE WHEN BdmDedCode = 'MDK1D' THEN BdmBenOption END) AS BenOption_MDK1D
                ,MAX(CASE WHEN BdmDedCode = 'MDK1C' THEN BdmBenOption END) AS BenOption_MDK1C
                ,MAX(CASE WHEN BdmDedCode = 'MDK3R' THEN BdmBenOption END) AS BenOption_MDK3R
                ,MAX(CASE WHEN BdmDedCode = 'MDK3D' THEN BdmBenOption END) AS BenOption_MDK3D
                ,MAX(CASE WHEN BdmDedCode = 'DHMOT' THEN BdmBenOption END) AS BenOption_DHMOT
                ,MAX(CASE WHEN BdmDedCode = 'DHMOC' THEN BdmBenOption END) AS BenOption_DHMOC
                ,MAX(CASE WHEN BdmDedCode = 'DHPPD' THEN BdmBenOption END) AS BenOption_DHPPD
                ,MAX(CASE WHEN BdmDedCode = 'DHPPC' THEN BdmBenOption END) AS BenOption_DHPPC
                ,MAX(CASE WHEN BdmDedCode = 'DHPPR' THEN BdmBenOption END) AS BenOption_DHPPR
                ,MAX(CASE WHEN BdmDedCode = 'DHPPT' THEN BdmBenOption END) AS BenOption_DHPPT
                ,MAX(CASE WHEN BdmDedCode = 'DLPPT' THEN BdmBenOption END) AS BenOption_DLPPT
                ,MAX(CASE WHEN BdmDedCode = 'DLPPC' THEN BdmBenOption END) AS BenOption_DLPPC
                ,MAX(CASE WHEN BdmDedCode = 'DLPPR' THEN BdmBenOption END) AS BenOption_DLPPR
                ,MAX(CASE WHEN BdmDedCode = 'DLPPD' THEN BdmBenOption END) AS BenOption_DLPPD
                ,MAX(CASE WHEN BdmDedCode = 'VSP' THEN BdmBenOption END) AS BenOption_VSP
                */
                /*,MAX(CASE WHEN BdmDedCode = 'MEDCI' THEN BdmBenStatus END) AS BenStatus_MEDCI
                ,MAX(CASE WHEN BdmDedCode = 'MEDCO' THEN BdmBenStatus END) AS BenStatus_MEDCO
                ,MAX(CASE WHEN BdmDedCode = 'MEDM2' THEN BdmBenStatus END) AS BenStatus_MEDM2
                ,MAX(CASE WHEN BdmDedCode = 'MEDM1' THEN BdmBenStatus END) AS BenStatus_MEDM1
                ,MAX(CASE WHEN BdmDedCode = 'MEDH3' THEN BdmBenStatus END) AS BenStatus_MEDH3
                ,MAX(CASE WHEN BdmDedCode = 'MEDB2' THEN BdmBenStatus END) AS BenStatus_MEDB2
                ,MAX(CASE WHEN BdmDedCode = 'MEDB1' THEN BdmBenStatus END) AS BenStatus_MEDB1
                ,MAX(CASE WHEN BdmDedCode = 'MEDM3' THEN BdmBenStatus END) AS BenStatus_MEDM3
                ,MAX(CASE WHEN BdmDedCode = 'MDK2C' THEN BdmBenStatus END) AS BenStatus_MDK2C
                ,MAX(CASE WHEN BdmDedCode = 'MDK2R' THEN BdmBenStatus END) AS BenStatus_MDK2R
                ,MAX(CASE WHEN BdmDedCode = 'MDK2D' THEN BdmBenStatus END) AS BenStatus_MDK2D
                ,MAX(CASE WHEN BdmDedCode = 'MDK1D' THEN BdmBenStatus END) AS BenStatus_MDK1D
                ,MAX(CASE WHEN BdmDedCode = 'MDK1C' THEN BdmBenStatus END) AS BenStatus_MDK1C
                ,MAX(CASE WHEN BdmDedCode = 'MDK3R' THEN BdmBenStatus END) AS BenStatus_MDK3R
                ,MAX(CASE WHEN BdmDedCode = 'MDK3D' THEN BdmBenStatus END) AS BenStatus_MDK3D
                ,MAX(CASE WHEN BdmDedCode = 'DHMOT' THEN BdmBenStatus END) AS BenStatus_DHMOT
                ,MAX(CASE WHEN BdmDedCode = 'DHMOC' THEN BdmBenStatus END) AS BenStatus_DHMOC
                ,MAX(CASE WHEN BdmDedCode = 'DHPPD' THEN BdmBenStatus END) AS BenStatus_DHPPD
                ,MAX(CASE WHEN BdmDedCode = 'DHPPC' THEN BdmBenStatus END) AS BenStatus_DHPPC
                ,MAX(CASE WHEN BdmDedCode = 'DHPPR' THEN BdmBenStatus END) AS BenStatus_DHPPR
                ,MAX(CASE WHEN BdmDedCode = 'DHPPT' THEN BdmBenStatus END) AS BenStatus_DHPPT
                ,MAX(CASE WHEN BdmDedCode = 'DLPPT' THEN BdmBenStatus END) AS BenStatus_DLPPT
                ,MAX(CASE WHEN BdmDedCode = 'DLPPC' THEN BdmBenStatus END) AS BenStatus_DLPPC
                ,MAX(CASE WHEN BdmDedCode = 'DLPPR' THEN BdmBenStatus END) AS BenStatus_DLPPR
                ,MAX(CASE WHEN BdmDedCode = 'DLPPD' THEN BdmBenStatus END) AS BenStatus_DLPPD
                ,MAX(CASE WHEN BdmDedCode = 'VSP' THEN BdmBenStatus END) AS BenStatus_VSP*/
            FROM dbo.U_dsi_BDM_EWWCOBCMBX WITH (NOLOCK)
            GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
        ) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE (BdmRunID = 'QB') OR (BdmRunID = 'NPM' AND EecDateOfLastHire BETWEEN @StartDate AND @EndDate)
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
ALTER VIEW dbo.dsi_vwEWWCOBCMBX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EWWCOBCMBX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EWWCOBCMBX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202008011'
       ,expStartPerControl     = '202008011'
       ,expLastEndPerControl   = '202009219'
       ,expEndPerControl       = '202009219'
WHERE expFormatCode = 'EWWCOBCMBX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEWWCOBCMBX_Export AS  
    SELECT TOP 200000000 Data FROM dbo.U_EWWCOBCMBX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort 