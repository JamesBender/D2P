SET NOCOUNT ON;
IF OBJECT_ID('U_EUNUMDREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMDREXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNUMDREXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNUMDREXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNUMDREXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMDREXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMDREXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMDREXP];
GO
IF OBJECT_ID('U_EUNUMDREXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMDREXP_PEarHist];
GO
IF OBJECT_ID('U_EUNUMDREXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMDREXP_PDedHist];
GO
IF OBJECT_ID('U_EUNUMDREXP_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMDREXP_File];
GO
IF OBJECT_ID('U_EUNUMDREXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMDREXP_EEList];
GO
IF OBJECT_ID('U_EUNUMDREXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMDREXP_drvTbl];
GO
IF OBJECT_ID('U_EUNUMDREXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMDREXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMDREXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMDREXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNUMDREXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNUMDREXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNUMDREXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNUMDREXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNUMDREXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMDREXP','UNUM LTD STD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','EUNUMDREXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNUMDREXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PARTNERCASE_ID"','1','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','1',NULL,'Partner Case ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SERVICE_INDICATOR"','2','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','2',NULL,'Service Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SSN"','3','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','3',NULL,'EE Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID"','4','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID_TYPE"','5','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','5',NULL,'Employee ID Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_FIRST_NAME"','6','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','6',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_MIDDLE_INITIAL"','7','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','7',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LAST_NAME"','8','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','8',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_1"','9','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','9',NULL,'EE Street Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_2"','10','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','10',NULL,'EE Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CITY"','11','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','11',NULL,'EE City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_RDC_ST_PVC"','12','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','12',NULL,'EE Residence State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTAL_CD"','13','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','13',NULL,'EE Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CNTRY_CD"','14','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','14',NULL,'EE Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_ST_PVC"','15','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','15',NULL,'EE Work State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_DOB"','16','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','16',NULL,'EE Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_GENDER"','17','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','17',NULL,'EE Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MARITAL_STATUS"','18','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','18',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_JOB_TLE"','19','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','19',NULL,'Employee Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MOST_RCNT_HIRE_DATE"','20','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','20',NULL,'Most Recent Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ORG_HIRE_DATE"','21','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','21',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TERM_DATE"','22','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','22',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_STATUS"','23','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','23',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WKLY_SCH_WRK_HRS"','24','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','24',NULL,'Weekly Scheduled Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SICK_PAY_HRS"','25','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','25',NULL,'Sick Pay Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE_OF_LST_SLY_CHG"','26','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','26',NULL,'Date of Last Salary Change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HOME_PHONE"','27','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','27',NULL,'Employee Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_FIRST_NAME"','28','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','28',NULL,'Manager First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_LAST_NAME"','29','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','29',NULL,'Manager Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_EMAIL"','30','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','30',NULL,'Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR_WRKED_IN_PST_12_MNTHS"','31','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','31',NULL,'Hours Worked In the Past 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_SUN"','32','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','32',NULL,'Work On Sunday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_MON"','33','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','33',NULL,'Work On Monday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_TUES"','34','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','34',NULL,'Work On Tuesday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_WEDS"','35','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','35',NULL,'Work On Wednesday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_THURS"','36','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','36',NULL,'Work On Thursday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_FRI"','37','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','37',NULL,'Work On Friday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_SAT"','38','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','38',NULL,'Work On Saturday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OFFCE_NAME"','39','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','39',NULL,'Office Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_1"','40','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','40',NULL,'Employee Work Mail Street Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_2"','41','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','41',NULL,'Employee Work Mail Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_3"','42','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','42',NULL,'Employee Work Mail Street Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_CITY"','43','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','43',NULL,'Employee Work City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_POSTAL_CD"','44','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','44',NULL,'Employee Work Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FMLA_RPTING_GRP"','45','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','45',NULL,'FMLA Reporting Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SAL_MD"','46','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','46',NULL,'EE Salary Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','47','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','47',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','48','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','48',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','49','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','49',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','50','(''DA''=''T,'')','EUNUMDREXPZ0','50','H','01','50',NULL,'Policy Eligibility Group (Class)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','51','(''DA''=''T,'')','EUNUMDREXPZ0','51','H','01','51',NULL,'Choice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','52','(''DA''=''T,'')','EUNUMDREXPZ0','52','H','01','52',NULL,'Employee Post-Tax Contribution %',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','53','(''DA''=''T,'')','EUNUMDREXPZ0','53','H','01','53',NULL,'Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','54','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','54',NULL,'Earnings Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','55','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','55',NULL,'Effective Date of Employee Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','56','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','56',NULL,'Employee Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','57','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','57',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','58','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','58',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','59','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','59',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','60','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','60',NULL,'Policy Eligibility Group (Class)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','61','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','61',NULL,'Choice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','62','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','62',NULL,'Employee Post-Tax Contribution %',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','63','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','63',NULL,'Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','64','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','64',NULL,'Earnings Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','65','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','65',NULL,'Effective Date of Employee Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','66','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','66',NULL,'Employee Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','67','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','67',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','68','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','68',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','69','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','69',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','70','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','70',NULL,'Policy Eligibility Group (Class)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','71','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','71',NULL,'Choice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','72','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','72',NULL,'Employee Post-Tax Contribution %',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','73','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','73',NULL,'Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','74','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','74',NULL,'Earnings Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','75','(''DA''=''T,'')','EUNUMDREXPZ0','54','H','01','75',NULL,'Effective Date of Employee Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','76','(''DA''=''T'')','EUNUMDREXPZ0','54','H','01','76',NULL,'Employee Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCaseId"','1','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','1',NULL,'Partner Case ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvServServiceIndicator"','2','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','2',NULL,'Service Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','3',NULL,'EE Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','4','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIdType"','5','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','5',NULL,'Employee ID Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFName"','6','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','6',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleIni"','7','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','7',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLName"','8','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','8',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStreet1"','9','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','9',NULL,'EE Street Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStreet2"','10','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','10',NULL,'EE Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','11','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','11',NULL,'EE City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResidence"','12','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','12',NULL,'EE Residence State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostCode"','13','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','13',NULL,'EE Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','14','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','14',NULL,'EE Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','15','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','15',NULL,'EE Work State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','16','(''UD101''=''T,'')','EUNUMDREXPZ0','54','D','10','16',NULL,'EE Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','17',NULL,'EE Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStat"','18','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','18',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','19','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','19',NULL,'Employee Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecentHireDt"','20','(''UD101''=''T,'')','EUNUMDREXPZ0','54','D','10','20',NULL,'Most Recent Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrigHireDt"','21','(''UD101''=''T,'')','EUNUMDREXPZ0','54','D','10','21',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDt"','22','(''UD101''=''T,'')','EUNUMDREXPZ0','54','D','10','22',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStat"','23','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','23',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeeklySchWorkHrs"','24','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','24',NULL,'Weekly Scheduled Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSickPayHrs"','25','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','25',NULL,'Sick Pay Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtLastSalChg"','26','(''UD101''=''T,'')','EUNUMDREXPZ0','54','D','10','26',NULL,'Date of Last Salary Change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHPhone"','27','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','27',NULL,'Employee Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManFName"','28','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','28',NULL,'Manager First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManLName"','29','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','29',NULL,'Manager Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManEmail"','30','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','30',NULL,'Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWorkedPast12Mo"','31','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','31',NULL,'Hours Worked In the Past 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWrkSun"','32','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','32',NULL,'Work On Sunday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWrkMon"','33','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','33',NULL,'Work On Monday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWrkTues"','34','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','34',NULL,'Work On Tuesday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWrkWed"','35','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','35',NULL,'Work On Wednesday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWrkThrs"','36','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','36',NULL,'Work On Thursday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWrkFri"','37','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','37',NULL,'Work On Friday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWrkSat"','38','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','38',NULL,'Work On Saturday?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfficeNm"','39','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','39',NULL,'Office Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkMailStreetAdd1"','40','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','40',NULL,'Employee Work Mail Street Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkMailStreetAdd2"','41','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','41',NULL,'Employee Work Mail Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkMailStreetAdd3"','42','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','42',NULL,'Employee Work Mail Street Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkCity"','43','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','43',NULL,'Employee Work City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkPostCode"','44','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','44',NULL,'Employee Work Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFMLAReportGrp"','45','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','45',NULL,'FMLA Reporting Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESalMod"','46','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','46',NULL,'EE Salary Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProd1"','47','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','47',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolNum1"','48','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','48',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDiv1"','49','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','49',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolEligGrp1"','50','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','50',NULL,'Policy Eligibility Group (Class)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice1"','51','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','51',NULL,'Choice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPostTaxContr1"','52','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','52',NULL,'Employee Post-Tax Contribution %',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarnings1"','53','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','53',NULL,'Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPrd1"','54','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','54',NULL,'Earnings Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDtOfEmpCov1"','55','(''UD101''=''T,'')','EUNUMDREXPZ0','54','D','10','55',NULL,'Effective Date of Employee Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCovTermDt1"','56','(''UD101''=''T,'')','EUNUMDREXPZ0','54','D','10','56',NULL,'Employee Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProd2"','57','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','57',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolNum2"','58','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','58',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDiv2"','59','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','59',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolEligGrp2"','60','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','60',NULL,'Policy Eligibility Group (Class)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice2"','61','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','61',NULL,'Choice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPostTaxContr2"','62','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','62',NULL,'Employee Post-Tax Contribution %',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarnings2"','63','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','63',NULL,'Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPrd2"','64','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','64',NULL,'Earnings Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDtOfEmpCov2"','65','(''UD101''=''T,'')','EUNUMDREXPZ0','54','D','10','65',NULL,'Effective Date of Employee Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCovTermDt2"','66','(''UD101''=''T,'')','EUNUMDREXPZ0','54','D','10','66',NULL,'Employee Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProd3"','67','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','67',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolNum3"','68','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','68',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDiv3"','69','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','69',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolEligGrp3"','70','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','70',NULL,'Policy Eligibility Group (Class)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice3"','71','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','71',NULL,'Choice',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPostTaxContr3"','72','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','72',NULL,'Employee Post-Tax Contribution %',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarnings3"','73','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','73',NULL,'Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPrd3"','74','(''UA''=''T,'')','EUNUMDREXPZ0','54','D','10','74',NULL,'Earnings Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDtOfEmpCov3"','75','(''UD101''=''T,'')','EUNUMDREXPZ0','54','D','10','75',NULL,'Effective Date of Employee Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCovTermDt3"','76','(''UD101''=''T'')','EUNUMDREXPZ0','54','D','10','76',NULL,'Employee Coverage Termination Date',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUNUMDREXP_20210812.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202107269','EMPEXPORT','OEACTIVE',NULL,'EUNUMDREXP',NULL,NULL,NULL,'202107269','Jul 26 2021  4:24PM','Jul 26 2021  4:24PM','202107261',NULL,'','','202107261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202107269','EMPEXPORT','OEPASSIVE',NULL,'EUNUMDREXP',NULL,NULL,NULL,'202107269','Jul 26 2021  4:24PM','Jul 26 2021  4:24PM','202107261',NULL,'','','202107261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM LTD STD Export','202107269','EMPEXPORT','ONDEM_XOE',NULL,'EUNUMDREXP',NULL,NULL,NULL,'202107269','Jul 26 2021  4:24PM','Jul 26 2021  4:24PM','202107261',NULL,'','','202107261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM LTD STD Export-Sched','202107269','EMPEXPORT','SCH_EUNUMD',NULL,'EUNUMDREXP',NULL,NULL,NULL,'202107269','Jul 26 2021  4:24PM','Jul 26 2021  4:24PM','202107261',NULL,'','','202107261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM LTD STD Export-Test','202107299','EMPEXPORT','TEST_XOE','Jul 28 2021  6:10PM','EUNUMDREXP',NULL,NULL,NULL,'202107299','Jul 29 2021 12:00AM','Dec 30 1899 12:00AM','202107131','490','','','202107131',dbo.fn_GetTimedKey(),NULL,'us3lKiDRI1007',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMDREXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMDREXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMDREXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMDREXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUNUMDREXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUNUMDREXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUNUMDREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMDREXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMDREXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMDREXP','D10','dbo.U_EUNUMDREXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EUNUMDREXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMDREXP] (
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
IF OBJECT_ID('U_EUNUMDREXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMDREXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUNUMDREXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMDREXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvPartCaseId] varchar(10) NOT NULL,
    [drvServServiceIndicator] varchar(3) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpId] char(9) NULL,
    [drvEmpIdType] varchar(4) NOT NULL,
    [drvFName] varchar(100) NULL,
    [drvMiddleIni] varchar(1) NULL,
    [drvLName] varchar(100) NULL,
    [drvStreet1] varchar(6000) NULL,
    [drvStreet2] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvResidence] varchar(255) NULL,
    [drvPostCode] varchar(6000) NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvWorkState] varchar(255) NULL,
    [drvDOB] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvMaritalStat] varchar(7) NOT NULL,
    [drvJobTitle] varchar(6000) NULL,
    [drvRecentHireDt] datetime NULL,
    [drvOrigHireDt] datetime NULL,
    [drvTermDt] varchar(30) NOT NULL,
    [drvEmpStat] varchar(3) NOT NULL,
    [drvWeeklySchWorkHrs] varchar(12) NULL,
    [drvSickPayHrs] varchar(1) NOT NULL,
    [drvDtLastSalChg] datetime NULL,
    [drvHPhone] varchar(50) NULL,
    [drvManFName] varchar(1) NOT NULL,
    [drvManLName] varchar(1) NOT NULL,
    [drvManEmail] varchar(12) NOT NULL,
    [drvHrsWorkedPast12Mo] varchar(4) NOT NULL,
    [drvWrkSun] varchar(1) NOT NULL,
    [drvWrkMon] varchar(1) NOT NULL,
    [drvWrkTues] varchar(1) NOT NULL,
    [drvWrkWed] varchar(1) NOT NULL,
    [drvWrkThrs] varchar(1) NOT NULL,
    [drvWrkFri] varchar(1) NOT NULL,
    [drvWrkSat] varchar(1) NOT NULL,
    [drvOfficeNm] varchar(5) NOT NULL,
    [drvEmpWorkMailStreetAdd1] varchar(255) NULL,
    [drvEmpWorkMailStreetAdd2] varchar(255) NULL,
    [drvEmpWorkMailStreetAdd3] varchar(1) NOT NULL,
    [drvEmpWorkCity] varchar(255) NULL,
    [drvEmpWorkPostCode] varchar(50) NULL,
    [drvFMLAReportGrp] varchar(6) NOT NULL,
    [drvEESalMod] char(1) NULL,
    [drvProd1] varchar(2) NULL,
    [drvPolNum1] varchar(6) NULL,
    [drvDiv1] varchar(1) NULL,
    [drvPolEligGrp1] varchar(1) NULL,
    [drvChoice1] varchar(1) NULL,
    [drvEmpPostTaxContr1] varchar(1) NULL,
    [drvEarnings1] varchar(30) NULL,
    [drvEarningsPrd1] varchar(2) NULL,
    [drvEffDtOfEmpCov1] datetime NULL,
    [drvEmpCovTermDt1] datetime NULL,
    [drvProd2] varchar(3) NULL,
    [drvPolNum2] varchar(6) NULL,
    [drvDiv2] varchar(1) NULL,
    [drvPolEligGrp2] varchar(1) NULL,
    [drvChoice2] varchar(1) NULL,
    [drvEmpPostTaxContr2] varchar(1) NULL,
    [drvEarnings2] varchar(30) NULL,
    [drvEarningsPrd2] varchar(2) NULL,
    [drvEffDtOfEmpCov2] datetime NULL,
    [drvEmpCovTermDt2] datetime NULL,
    [drvProd3] varchar(2) NULL,
    [drvPolNum3] varchar(6) NULL,
    [drvDiv3] varchar(1) NULL,
    [drvPolEligGrp3] varchar(1) NULL,
    [drvChoice3] varchar(1) NULL,
    [drvEmpPostTaxContr3] varchar(1) NULL,
    [drvEarnings3] varchar(30) NULL,
    [drvEarningsPrd3] varchar(2) NULL,
    [drvEffDtOfEmpCov3] datetime NULL,
    [drvEmpCovTermDt3] datetime NULL
);
IF OBJECT_ID('U_EUNUMDREXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMDREXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNUMDREXP_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMDREXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EUNUMDREXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMDREXP_PDedHist] (
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
IF OBJECT_ID('U_EUNUMDREXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMDREXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehEarnCode] char(5) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PayEarnCode] char(5) NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMDREXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Drift.com

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 07/26/2021
Service Request Number: TekP-2021-06-21-0004

Purpose: UNUM LTD STD Export

Revision History
----------------
07/28/2021 by AP:
        - Updated Gender.
        - Updated Addressline1 and Addressline2.
        - Cleaned up logic for earnings1, earnings2, and earnings3.

08/12/2021 by AP:
		- Updated logic for salary effective date field.
		- Updated effective date minimum date to 07/01/21.
		- Fixed logic for missing employees earnings amounts ISNULL(x, 0) used.


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMDREXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMDREXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMDREXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMDREXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMDREXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMDREXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMDREXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMDREXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMDREXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMDREXP', 'SCH_EUNUMD';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMDREXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNUMDREXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
		    ,@FileMinCovDate datetime = CAST('07/01/2021' as DATETIME);

    -- Set FormatCode
    SELECT @FormatCode = 'EUNUMDREXP';

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
    DELETE FROM dbo.U_EUNUMDREXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMDREXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD,LTD';

    IF OBJECT_ID('U_EUNUMDREXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMDREXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMDREXP_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');

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

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EUNUMDREXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMDREXP_PDedHist;
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
    INTO dbo.U_EUNUMDREXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EUNUMDREXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EUNUMDREXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMDREXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehEarnCode
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PayEarnCode            = MAX(PehEarnCode)
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
    INTO dbo.U_EUNUMDREXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl, 4) = YEAR(GETDATE()) - 1
    --LEFT(PehPerControl,4) - 1 = LEFT(@EndPerControl,4) - 1
    --PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehEarnCode
    HAVING SUM(PehCurAmt) <> 0.00;
    

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMDREXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMDREXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMDREXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvPartCaseId = 'DRI-012497'
        ,drvServServiceIndicator = 'ELG'
        ,drvSSN = eepSSN
        ,drvEmpId = EecEmpNo
        ,drvEmpIdType = 'EEID'
        ,drvFName = EepNameFirst
        ,drvMiddleIni = LEFT(ISNULL(EepNameMiddle, ''), 1)
        ,drvLName = EepNameLast
        ,drvStreet1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvStreet2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvResidence = EepAddressState
        ,drvPostCode = dbo.dsi_fnRemoveChars('-',EepAddressZipCode)
        ,drvCountryCode = 'US'
        ,drvWorkState = (SELECT TOP 1 LocAddressState FROM dbo.Location WITH(NOLOCK) WHERE LocCode = EecLocation)
        ,drvDOB = EepDateOfBirth
        ,drvGender = CASE WHEN EepGender NOT IN ('M', 'F') THEN '' ELSE EepGender END
        --EepGender
        ,drvMaritalStat = CASE WHEN EepMaritalStatus = 'M' THEN 'Married'
                                WHEN EepMaritalStatus = 'S' THEN 'Single' ELSE 'UNK' END
        ,drvJobTitle = dbo.dsi_fnRemoveChars('.,/-', (SELECT TOP 1 JbcDesc FROM dbo.JobCode WITH(NOLOCK) WHERE JbcJobCode = EecJobCode))
        ,drvRecentHireDt = EecDateOfLastHire
        ,drvOrigHireDt = EecDateOfOriginalHire
        ,drvTermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END), 101), '')
        ,drvEmpStat = CASE WHEN EecEmplStatus = 'L' THEN 'LOA' ELSE 'ACT' END
        ,drvWeeklySchWorkHrs = CAST(CONVERT(DECIMAL(10,2), EecScheduledWorkHrs / 2) AS VARCHAR(12))
        ,drvSickPayHrs = '0'
        ,drvDtLastSalChg =  dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, CAST(GETDATE() AS DATE),EecDateOfLastHire) 
        --dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire) 
        ,drvHPhone = EepPhoneHomeNumber
        ,drvManFName = ''
        ,drvManLName = ''
        ,drvManEmail = 'HR@drift.com'
        ,drvHrsWorkedPast12Mo = '1250'
        ,drvWrkSun = 'N'
        ,drvWrkMon = 'Y'
        ,drvWrkTues = 'Y'
        ,drvWrkWed = 'Y'
        ,drvWrkThrs = 'Y'
        ,drvWrkFri = 'Y'
        ,drvWrkSat = 'N'
        ,drvOfficeNm = 'Drift'
        ,drvEmpWorkMailStreetAdd1 = (SELECT TOP 1 LocAddressline1 FROM dbo.Location WITH(NOLOCK) WHERE LocCode = EecLocation)
        ,drvEmpWorkMailStreetAdd2 = (SELECT TOP 1 LocAddressline2 FROM dbo.Location WITH(NOLOCK) WHERE LocCode = EecLocation)
        ,drvEmpWorkMailStreetAdd3 = ''
        ,drvEmpWorkCity = (SELECT TOP 1 LocAddressCity FROM dbo.Location WITH(NOLOCK) WHERE LocCode = EecLocation)
        ,drvEmpWorkPostCode = (SELECT TOP 1 LocAddressZipCode FROM dbo.Location WITH(NOLOCK) WHERE LocCode = EecLocation)
        ,drvFMLAReportGrp = '000001'
        ,drvEESalMod = EecSalaryOrHourly
        ,drvProd1 = CASE WHEN STD IS NOT NULL THEN '31' END
        ,drvPolNum1 = CASE WHEN STD IS NOT NULL THEN '449511' END
        ,drvDiv1 = CASE WHEN STD IS NOT NULL THEN '1' END
        ,drvPolEligGrp1 = CASE WHEN STD IS NOT NULL THEN '1' END
        ,drvChoice1 = CASE WHEN STD IS NOT NULL THEN '1' END
        ,drvEmpPostTaxContr1 = CASE WHEN STD IS NOT NULL THEN '0' END
        ,drvEarnings1 = CASE WHEN YEAR(EecDateOfLastHire) < YEAR(GETDATE()) THEN  
                                CASE WHEN STD IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2), Peh.PehCurAmtYTD / 52) AS VARCHAR) END 
                            WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN
                                CASE WHEN STD IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2), ((ISNULL(EecAnnSalary, 0) + ISNULL(EecUDField09, 0) + ISNULL(EecUDField10, 0)) / 52)) AS VARCHAR) END
                            END
        ,drvEarningsPrd1 = CASE WHEN STD IS NOT NULL THEN 'WK' END
        ,drvEffDtOfEmpCov1 = CASE WHEN STD IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', STD_BenStartDate, @FileMinCovDate) END
        ,drvEmpCovTermDt1 = CASE WHEN STD IS NOT NULL THEN STD_BenStopDate END
        ,drvProd2 = CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN '826' END
        ,drvPolNum2 = CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN '449512' END
        ,drvDiv2 = CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN '1' END
        ,drvPolEligGrp2 = CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN '1' END
        ,drvChoice2 = CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN '1' END
        ,drvEmpPostTaxContr2 = CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN '0' END
        ,drvEarnings2 = CASE WHEN YEAR(EecDateOfLastHire) < YEAR(GETDATE()) THEN  
                                CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN CAST(CONVERT(DECIMAL(10,2), Peh.PehCurAmtYTD / 52) AS VARCHAR) END 
                            WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN
                                CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN CAST(CONVERT(DECIMAL(10,2), ((ISNULL(EecAnnSalary, 0) + ISNULL(EecUDField09, 0) + ISNULL(EecUDField10, 0)) / 52)) AS VARCHAR) END
                            END
        ,drvEarningsPrd2 = CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN 'WK' END
        ,drvEffDtOfEmpCov2 = CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN dbo.dsi_fnGetMinMaxDates('MAX', STD_BenStartDate, @FileMinCovDate) END
        ,drvEmpCovTermDt2 = CASE WHEN STD IS NOT NULL AND EepAddressState = 'MA' THEN STD_BenStopDate END
        ,drvProd3 = CASE WHEN LTD IS NOT NULL THEN '38' END
        ,drvPolNum3 = CASE WHEN LTD IS NOT NULL THEN '449511' END
        ,drvDiv3 = CASE WHEN LTD IS NOT NULL THEN '1' END
        ,drvPolEligGrp3 = CASE WHEN LTD IS NOT NULL THEN '1' END
        ,drvChoice3 = CASE WHEN LTD IS NOT NULL THEN '1' END
        ,drvEmpPostTaxContr3 = CASE WHEN LTD IS NOT NULL THEN '0' END
        ,drvEarnings3 = CASE WHEN YEAR(EecDateOfLastHire) < YEAR(GETDATE()) THEN  
                                CASE WHEN LTD IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2), Peh.PehCurAmtYTD / 12) AS VARCHAR) END 
                            WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN
                                CASE WHEN LTD IS NOT NULL THEN CAST(CONVERT(DECIMAL(10,2), ((ISNULL(EecAnnSalary, 0) + ISNULL(EecUDField09, 0) + ISNULL(EecUDField10, 0)) / 52)) AS VARCHAR) END
                            END
        ,drvEarningsPrd3 = CASE WHEN LTD IS NOT NULL THEN 'MO' END
        ,drvEffDtOfEmpCov3 = CASE WHEN LTD IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', LTD_BenStartDate, @FileMinCovDate) END
        ,drvEmpCovTermDt3 = CASE WHEN LTD IS NOT NULL THEN LTD_BenStopDate END
    INTO dbo.U_EUNUMDREXP_drvTbl
    FROM dbo.U_EUNUMDREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    -- JOIN dbo.JobCode WITH (NOLOCK)
    --     ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_EUNUMDREXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN (SELECT EedEEID, EedCOID, MAX(CASE WHEN EedDedCode = 'LTD' THEN 'LTD' END) AS LTD,
                    MAX(CASE WHEN EedDedCode = 'STD' THEN 'STD' END) AS STD,
                    MAX(CASE WHEN EedDedCode = 'LTD' THEN EedBenStartDate END) AS LTD_BenStartDate,
                    MAX(CASE WHEN EedDedCode = 'LTD' THEN EedBenStopDate END) AS LTD_BenStopDate,
                    MAX(CASE WHEN EedDedCode = 'STD' THEN EedBenStartDate END) AS STD_BenStartDate,
                    MAX(CASE WHEN EedDedCode = 'STD' THEN EedBenStopDate END) AS STD_BenStopDate
            FROM dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
            WHERE EedFormatCode = @FormatCode
            AND EedValidForExport = 'Y'
            GROUP BY EedEEID, EedCOID
            ) D ON D.EedEEID = xEEID AND D.EedCOID = xCOID
    LEFT JOIN (SELECT PehEEID, SUM(PehCurAmt) AS PehCurAmt, SUM(PehCurAmtYTD) AS PehCurAmtYTD
                FROM dbo.U_EUNUMDREXP_PEarHist WITH(NOLOCK)
                WHERE PehEarnCode IN ('BONUS', 'BONSP', 'BONSR', 'COMM', 'HOL', 'BONSL', 'OT', 'PTO', 'REG',
                                        'REGE', 'RETRO', 'SICK', 'COV19')
                                        GROUP BY PehEEID) Peh ON Peh.PehEEID = xEEID
    --LEFT JOIN (SELECT PehEEID, PehEarnCode, PehCurAmt
    --            FROM dbo.U_EUNUMDREXP_PEarHist WITH(NOLOCK)
    --            WHERE PehEarnCode = 'BONUS') PehB ON PehB.PehEEID = xEEID
    
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
ALTER VIEW dbo.dsi_vwEUNUMDREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMDREXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMDREXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107191'
       ,expStartPerControl     = '202107191'
       ,expLastEndPerControl   = '202107269'
       ,expEndPerControl       = '202107269'
WHERE expFormatCode = 'EUNUMDREXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMDREXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMDREXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort