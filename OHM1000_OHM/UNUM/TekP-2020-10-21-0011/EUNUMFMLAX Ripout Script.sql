SET NOCOUNT ON;
IF OBJECT_ID('U_EUNUMFMLAX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFMLAX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNUMFMLAX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNUMFMLAX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNUMFMLAX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMFMLAX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMFMLAX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMFMLAX];
GO
IF OBJECT_ID('U_EUNUMFMLAX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFMLAX_PEarHist];
GO
IF OBJECT_ID('U_EUNUMFMLAX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFMLAX_PDedHist];
GO
IF OBJECT_ID('U_EUNUMFMLAX_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFMLAX_File];
GO
IF OBJECT_ID('U_EUNUMFMLAX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFMLAX_EEList];
GO
IF OBJECT_ID('U_EUNUMFMLAX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFMLAX_drvTbl];
GO
IF OBJECT_ID('U_EUNUMFMLAX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFMLAX_DedList];
GO
IF OBJECT_ID('U_EUNUMFMLAX_12mo_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFMLAX_12mo_PEarHist];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMFMLAX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMFMLAX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNUMFMLAX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNUMFMLAX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNUMFMLAX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNUMFMLAX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNUMFMLAX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMFMLAX','UNUM FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EUNUMFMLAXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNUMFMLAX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PARTNERCASE_ID"','1','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SERVICE_INDICATOR"','2','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SSN"','3','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','3',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID"','4','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','4',NULL,'EE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID_TYPE"','5','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_FIRST_NAME"','6','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_MIDDLE_INITIAL"','7','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LAST_NAME"','8','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_1"','9','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_2"','10','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CITY"','11','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','11',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_RDC_ST_PVC"','12','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTAL_CD"','13','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CNTRY_CD"','14','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_ST_PVC"','15','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','15',NULL,'EE_WRK_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_DOB"','16','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','16',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_GENDER"','17','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','17',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MARITAL_STATUS"','18','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','18',NULL,'MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_JOB_TLE"','19','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','19',NULL,'EE_JOB_TLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MOST_RCNT_HIRE_DATE"','20','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ORG_HIRE_DATE"','21','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','21',NULL,'ORG_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TERM_DATE"','22','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','22',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_STATUS"','23','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','23',NULL,'EE_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WKLY_SCH_WRK_HRS"','24','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACCOM_RSTCT"','25','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','25',NULL,'ACCOM_RSTCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SICK_PAY"','26','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','26',NULL,'SICK_PAY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE_OF_LST_SLY_CHG"','27','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','27',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HOME_PHONE"','28','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','28',NULL,'EE_HOME_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_FIRST_NAME"','29','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','29',NULL,'MGR_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_LAST_NAME"','30','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','30',NULL,'MGR_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_EMAIL"','31','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','31',NULL,'MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SCND_MGR_EMAIL"','32','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','32',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_THRD_MGR_EMAIL"','33','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','33',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR_WRKED_IN_PST_12_MNTHS"','34','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','34',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_SUN"','35','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','35',NULL,'WRK_ON_SUN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_MON"','36','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','36',NULL,'WRK_ON_MON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_TUES"','37','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','37',NULL,'WRK_ON_TUES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_WEDS"','38','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','38',NULL,'WRK_ON_WEDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_THURS"','39','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','39',NULL,'WRK_ON_THURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_FRI"','40','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','40',NULL,'WRK_ON_FRI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_SAT"','41','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','41',NULL,'WRK_ON_SAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OFFCE_NAME"','42','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','42',NULL,'OFFCE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_1"','43','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','43',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_2"','44','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','44',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_3"','45','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','45',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_CITY"','46','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','46',NULL,'EE_WRK_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_POSTAL_CD"','47','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','47',NULL,'EE_WRK_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FMLA_RPTING_GRP"','48','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','48',NULL,'FMLA_RPTING_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"KEY_EE"','49','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','49',NULL,'KEY_EE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SAL_MD"','50','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','50',NULL,'EE_SAL_MD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','51','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','51',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','52','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','52',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','53','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','53',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','54','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','54',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','55','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','55',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','56','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','56',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','57','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','57',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','58','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','58',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','59','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','59',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','60','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','60',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','61','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','61',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','62','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','62',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','63','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','63',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','64','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','64',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','65','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','65',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','66','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','66',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','67','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','67',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','68','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','68',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','69','(''DA''=''T,'')','EUNUMFMLAXZ0','50','H','01','69',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','70','(''DA''=''T'')','EUNUMFMLAXZ0','50','H','01','70',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ORC-022191"','1','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELG"','2','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','3',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE_ID"','4','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','4',NULL,'EE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EEID"','5','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdressLine1"','9','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','11','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','11',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','12','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','13','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdressCounty"','14','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','15','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','15',NULL,'EE_WRK_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','16','(''UD101''=''T,'')','EUNUMFMLAXZ0','50','D','10','16',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','17',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','18','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','18',NULL,'MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','19','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','19',NULL,'EE_JOB_TLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMostRecentHireDate"','20','(''UD101''=''T,'')','EUNUMFMLAXZ0','50','D','10','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','21','(''UD101''=''T,'')','EUNUMFMLAXZ0','50','D','10','21',NULL,'ORG_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','22','(''UD101''=''T,'')','EUNUMFMLAXZ0','50','D','10','22',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','23','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','23',NULL,'EE_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeeklyScheduledHours"','24','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','25','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','25',NULL,'ACCOM_RSTCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','26','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','26',NULL,'SICK_PAY_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateLastSalChg"','27','(''UD101''=''T,'')','EUNUMFMLAXZ0','50','D','10','27',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhoneNumber"','28','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','28',NULL,'EE_HOME_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerNameFirst"','29','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','29',NULL,'MGR_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerNameLast"','30','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','30',NULL,'MGR_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerEmail"','31','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','31',NULL,'MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','32',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','33',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedInPast12Months"','34','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','34',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','35','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','35',NULL,'WRK_ON_SUN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','36','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','36',NULL,'WRK_ON_MON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','37','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','37',NULL,'WRK_ON_TUES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','38','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','38',NULL,'WRK_ON_WEDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','39','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','39',NULL,'WRK_ON_THURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','40','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','40',NULL,'WRK_ON_FRI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','41','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','41',NULL,'WRK_ON_SAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Orchard Hiltz and McCliment Incorporated"','42','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','42',NULL,'OFFCE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','43',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','43',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','45',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','46',NULL,'EE_WRK_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','47',NULL,'EE_WRK_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','48','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','48',NULL,'FMLA_RPTING_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T,'')','EUNUMFMLAXZ0','50','D','10','49',NULL,'KEY_EE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryOrHourly"','50','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','50',NULL,'EE_SAL_MD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct"','51','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','51',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNbr"','52','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','52',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','53','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','53',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyElgGrp"','54','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','54',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice"','55','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','55',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPstTaxCntPct"','56','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','56',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarnings"','57','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','57',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPrd"','58','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','58',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOFEECoverage"','59','(''UD101''=''T,'')','EUNUMFMLAXZ0','50','D','10','59',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovgTermDate"','60','(''UD101''=''T,'')','EUNUMFMLAXZ0','50','D','10','60',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct2"','61','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','61',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNbr2"','62','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','62',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision2"','63','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','63',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyElgGrp2"','64','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','64',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice2"','65','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','65',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPstTaxCntPct2"','66','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','66',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarnings2"','67','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','67',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPrd2"','68','(''UA''=''T,'')','EUNUMFMLAXZ0','50','D','10','68',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOFEECoverage2"','69','(''UD101''=''T,'')','EUNUMFMLAXZ0','50','D','10','69',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovgTermDate2"','70','(''UD101''=''T'')','EUNUMFMLAXZ0','50','D','10','70',NULL,'COVG_TERM_DATE',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUNUMFMLAX_20210615.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202101119','EMPEXPORT','OEACTIVE','Dec 22 2020  1:19PM','EUNUMFMLAX',NULL,NULL,NULL,'202101119','Dec 22 2020 12:18PM','Dec 22 2020 12:18PM','202101011','529','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202101119','EMPEXPORT','OEPASSIVE','Dec 22 2020  1:19PM','EUNUMFMLAX',NULL,NULL,NULL,'202101119','Dec 22 2020 12:18PM','Dec 22 2020 12:18PM','202101011','529','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM FMLA Export','202101119','EMPEXPORT','ONDEM_XOE','Dec 22 2020  1:20PM','EUNUMFMLAX',NULL,NULL,NULL,'202101119','Dec 22 2020 12:18PM','Dec 22 2020 12:18PM','202101011','529','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',5Q675',NULL,NULL,NULL,'UNUM FMLA Disa - Fridays 7am','202101119','EMPEXPORT','SCH_EUNUMF','Dec 22 2020  1:20PM','EUNUMFMLAX',NULL,NULL,NULL,'202106119','Dec 22 2020 12:18PM','Dec 22 2020 12:18PM','202106041','529','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM FMLA Export-Test','202106159','EMPEXPORT','TEST_XOE','Jun 15 2021  5:27PM','EUNUMFMLAX',NULL,NULL,NULL,'202106159','Jun 15 2021 12:00AM','Dec 30 1899 12:00AM','202106011','573','','','202106011',dbo.fn_GetTimedKey(),NULL,'us3lKiOHM1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMFMLAX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMFMLAX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMFMLAX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMFMLAX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMFMLAX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUNUMFMLAX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUNUMFMLAX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUNUMFMLAX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFMLAX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMFMLAX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMFMLAX','D10','dbo.U_EUNUMFMLAX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EUNUMFMLAX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMFMLAX] (
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
IF OBJECT_ID('U_EUNUMFMLAX_12mo_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMFMLAX_12mo_PEarHist] (
    [Peh12MoEEID] char(12) NOT NULL,
    [PehBonusCurrentYear] numeric NULL,
    [PehBonusPreviousYear] numeric NULL
);
IF OBJECT_ID('U_EUNUMFMLAX_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMFMLAX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUNUMFMLAX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMFMLAX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEE_ID] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAdressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAdressCounty] char(3) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(7) NOT NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvMostRecentHireDate] datetime NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvEmploymentStatus] varchar(3) NOT NULL,
    [drvWeeklyScheduledHours] nvarchar(4000) NULL,
    [drvDateLastSalChg] datetime NULL,
    [drvHomePhoneNumber] varchar(50) NULL,
    [drvManagerNameFirst] varchar(100) NULL,
    [drvManagerNameLast] varchar(100) NULL,
    [drvManagerEmail] varchar(50) NULL,
    [drvHoursWorkedInPast12Months] nvarchar(4000) NULL,
    [drvSalaryOrHourly] char(1) NULL,
    [drvProduct] varchar(3) NULL,
    [drvPolicyNbr] varchar(6) NULL,
    [drvDivision] varchar(1) NULL,
    [drvPolicyElgGrp] varchar(1) NULL,
    [drvChoice] varchar(1) NULL,
    [drvPstTaxCntPct] varchar(3) NULL,
    [drvEarnings] nvarchar(4000) NULL,
    [drvEarningsPrd] varchar(2) NULL,
    [drvDateOFEECoverage] datetime NULL,
    [drvCovgTermDate] datetime NULL,
    [drvProduct2] varchar(3) NULL,
    [drvPolicyNbr2] varchar(6) NULL,
    [drvDivision2] varchar(1) NULL,
    [drvPolicyElgGrp2] varchar(1) NULL,
    [drvChoice2] varchar(1) NULL,
    [drvPstTaxCntPct2] varchar(3) NULL,
    [drvEarnings2] nvarchar(4000) NULL,
    [drvEarningsPrd2] varchar(2) NULL,
    [drvDateOFEECoverage2] datetime NULL,
    [drvCovgTermDate2] datetime NULL
);
IF OBJECT_ID('U_EUNUMFMLAX_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMFMLAX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNUMFMLAX_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMFMLAX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EUNUMFMLAX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMFMLAX_PDedHist] (
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
IF OBJECT_ID('U_EUNUMFMLAX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMFMLAX_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMFMLAX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: OHM Advisors

Created By: James Bender
Business Analyst: Lea King
Create Date: 12/22/2020
Service Request Number: TekP-2020-10-21-0011

Purpose: UNUM FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMFMLAX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMFMLAX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMFMLAX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMFMLAX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMFMLAX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMFMLAX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMFMLAX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMFMLAX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMFMLAX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMFMLAX', 'SCH_EUNUMF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMFMLAX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNUMFMLAX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUMFMLAX';

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
    DELETE FROM dbo.U_EUNUMFMLAX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMFMLAX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EUNUMFMLAX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD,LTD,LTDB';

    IF OBJECT_ID('U_EUNUMFMLAX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMFMLAX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMFMLAX_DedList
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
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EUNUMFMLAX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMFMLAX_PDedHist;
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
    INTO dbo.U_EUNUMFMLAX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EUNUMFMLAX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EUNUMFMLAX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMFMLAX_PEarHist;
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
    INTO dbo.U_EUNUMFMLAX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    IF OBJECT_ID('U_EUNUMFMLAX_12mo_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMFMLAX_12mo_PEarHist;
    SELECT DISTINCT
         Peh12MoEEID = PehEEID                            --6/1/2021
         ,PehBonusCurrentYear           = SUM(CASE WHEN PehEarnCode = 'BONUS' AND CAST(LEFT(PehPerControl,8) AS DATE) BETWEEN '1/1/' + CAST(DATEPART(YEAR,  @EndDate) AS VARCHAR) AND @EndDate THEN PehCurAmt ELSE 0.00 END) --6/1/2020 and 6/1/2021
         ,PehBonusPreviousYear           = SUM(CASE WHEN PehEarnCode = 'BONUS' AND CAST(LEFT(PehPerControl,8) AS DATE) BETWEEN '1/1/' + CAST(DATEPART(YEAR, DATEADD(YEAR, -1, @EndDate)) AS VARCHAR) AND '12/31/' + CAST(DATEPART(YEAR, DATEADD(YEAR, -1, @EndDate)) AS VARCHAR) THEN PehCurAmt ELSE 0.00 END) -- 6/1/2019 and 6/1/2020
         /*,x = @EndDate
         ,y = '1/1/' + CAST(DATEPART(YEAR,  @EndDate) AS VARCHAR)
         ,z = '1/1/' + CAST(DATEPART(YEAR, DATEADD(YEAR, -1, @EndDate)) AS VARCHAR) 
         ,zz = '12/31/' + CAST(DATEPART(YEAR, DATEADD(YEAR, -1, @EndDate)) AS VARCHAR)*/
         --DATEADD(YEAR, -2, @EndDate) AND DATEADD(YEAR, -1, @EndDate) THEN PehCurAmt ELSE 0.00 END) -- 6/1/2019 and 6/1/2020
    INTO dbo.U_EUNUMFMLAX_12mo_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist A WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    --WHERE CAST(LEFT(PehPerControl,8) AS DATE) BETWEEN DATEADD(YEAR, -1, @EndDate) AND @EndDate
    GROUP BY PehEEID



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMFMLAX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMFMLAX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMFMLAX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = EMP.EepSSN
        ,drvEE_ID = EecEmpNo
        ,drvNameFirst = EMP.EepNameFirst
        ,drvNameMiddle = EMP.EepNameMiddle
        ,drvNameLast = EMP.EepNameLast
        ,drvAdressLine1 = EMP.EepAddressLine1
        ,drvAddressLine2 = EMP.EepAddressLine2
        ,drvAddressCity = EMP.EepAddressCity
        ,drvAddressState = EMP.EepAddressState
        ,drvAddressZipCode = EMP.EepAddressZipCode
        ,drvAdressCounty = EMP.EepAddressCountry
        ,drvWorkState = LocAddressState --EepAddressState
        ,drvDateOfBirth = EMP.EepDateOfBirth
        ,drvGender = EMP.EepGender
        ,drvMaritalStatus =    CASE WHEN EMP.EepMaritalStatus = 'M' THEN 'Married'
                                WHEN EMP.EepMaritalStatus = 'S' THEN 'Single'
                                ELSE 'UNK'
                            END
        ,drvJobTitle = JbcDesc
        ,drvMostRecentHireDate = EecDateOfLastHire
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'L' THEN 'LOA' ELSE 'ACT' END
        ,drvWeeklyScheduledHours = FORMAT(EecScheduledWorkHrs/2, '#0.00')
        ,drvDateLastSalChg = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, '1/1/2021', EecDateOfLastHire)
        ,drvHomePhoneNumber = EMP.EepPhoneHomeNumber
        ,drvManagerNameFirst = SUP.EepNameFirst
        ,drvManagerNameLast = SUP.EepNameLast
        ,drvManagerEmail = SUP.EepAddressEMail
        ,drvHoursWorkedInPast12Months = FORMAT(PehCurHrs, '#0.00')
        ,drvSalaryOrHourly = EecSalaryOrHourly
        ,drvProduct =    CASE WHEN Std_DedCode IS NOT NULL THEN '192'
                            WHEN Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN '195'
                        END
        ,drvPolicyNbr = CASE WHEN Std_DedCode IS NOT NULL OR Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN '431165' END
        ,drvDivision = CASE WHEN Std_DedCode IS NOT NULL OR Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN '1' END
        ,drvPolicyElgGrp =    CASE WHEN Std_DedCode IS NOT NULL THEN '1'
                                WHEN Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN 
                                CASE WHEN EecDedGroupCode = 'BOARD' THEN '1'
                                  ELSE '2' END
                                 END
                            
        ,drvChoice = CASE WHEN Std_DedCode IS NOT NULL OR Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN '1' END
        ,drvPstTaxCntPct = CASE WHEN Std_DedCode IS NOT NULL OR Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN '100' END
        
        ,drvEarnings =    FORMAT(
                            CASE WHEN DATEPART(YEAR, EecDateOfLastHire) < DATEPART(YEAR, GETDATE()) THEN
                                CASE WHEN Std_DedCode IS NOT NULL THEN (EecAnnSalary + PehBonusPreviousYear)/52
                                    WHEN Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN (EecAnnSalary + PehBonusPreviousYear)/12
                                END
                            WHEN DATEPART(YEAR, EecDateOfLastHire) = DATEPART(YEAR, GETDATE()) THEN
                                CASE WHEN Std_DedCode IS NOT NULL THEN (EecAnnSalary + PehBonusCurrentYear)/52
                                    WHEN Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN (EecAnnSalary + PehBonusCurrentYear)/12
                                END
                            END



                            /*CASE WHEN Std_DedCode IS NOT NULL AND EMP.EepUDField10 <> 0 THEN EMP.EepUDField10/52
                                WHEN Std_DedCode IS NOT NULL AND EMP.EepUDField10 = 0 THEN EecAnnSalary/52
                                WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN '' 
                                WHEN Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL AND EMP.EepUDField10 <> 0 THEN EMP.EepUDField10/12
                                WHEN Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL AND EMP.EepUDField10 = 0 THEN EecAnnSalary/12
                            END*/
                        , '#0.00')
        
                        /*CASE WHEN Std_DedCode IS NOT NULL THEN FORMAT(Std_Amount, '#0.00') 
                            WHEN Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN FORMAT(Ltd_Amount, '#0.00') 
                        END */
        
        ,drvEarningsPrd =    CASE WHEN Std_DedCode IS NOT NULL  THEN 'WK'
                                WHEN Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL  THEN 'MO'
                            END        
        ,drvDateOFEECoverage =    CASE WHEN Std_DedCode IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX', Std_StartDate, '1/1/2021') 
                                    WHEN Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN  dbo.dsi_fnGetMinMaxDates('MAX', Ltd_StartDate, '1/1/2021') 
                                END 
        ,drvCovgTermDate =    CASE WHEN Std_DedCode IS NOT NULL THEN Std_StopDate 
                                WHEN Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL THEN Ltd_StopDate
                            END 
        ,drvProduct2 =    CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN '195' END  
        ,drvPolicyNbr2 =  CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN '431165' END
        ,drvDivision2 = CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN '1' END
        ,drvPolicyElgGrp2 =    CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN 
                                CASE WHEN EecDedGroupCode = 'BOARD' THEN '1' ELSE '2' END
                            END
        ,drvChoice2 = CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN '1' END
        ,drvPstTaxCntPct2 = CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN '100' END
        ,drvEarnings2 = FORMAT(CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) AND EMP.EepUDField10 <> 0 THEN EMP.EepUDField10/12
                            WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) AND EMP.EepUDField10 = 0 THEN EecAnnSalary/12
                        END, '#0.00')
                        --CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN FORMAT(Ltd_Amount, '#0.00') END
        ,drvEarningsPrd2 = CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN 'MO' END 
        ,drvDateOFEECoverage2 = CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN dbo.dsi_fnGetMinMaxDates('MAX', Ltd_StartDate, '1/1/2021') END 
        ,drvCovgTermDate2 = CASE WHEN Std_DedCode IS NOT NULL AND (Ltd_DedCode IS NOT NULL OR Ltdb_DedCode IS NOT NULL) THEN Ltd_StopDate END 
    INTO dbo.U_EUNUMFMLAX_drvTbl
    FROM dbo.U_EUNUMFMLAX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers EMP WITH (NOLOCK)
        ON EMP.EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.EmpPers SUP WITH (NOLOCK)
        ON EecSupervisorID = SUP.EepEEID
    JOIN (
            SELECT PehEEID, SUM(PehCurHrs) AS PehCurHrs
            FROM dbo.vw_int_PEarHist WITH (NOLOCK)
            WHERE PehPerControl BETWEEN FORMAT(DATEADD(YEAR, -1, @StartDate), 'yyyyMMdd') + '1' AND FORMAT(@EndDate, 'yyyyMMdd') + '9'    
            GROUP BY PehEEID) AS CurHrs
        ON PehEEID = xEEID 
--    JOIN dbo.U_EUNUMFMLAX_PEarHist
--        ON PehEEID = xEEID
    --LEFT JOIN dbo.U_dsi_BDM_EUNUMFMLAX WITH (NOLOCK)
    LEFT JOIN (
                SELECT BdmEEID, BdmCOID
                    ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) AS Std_DedCode
                    ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmDedCode END) AS Ltd_DedCode
                    ,MAX(CASE WHEN BdmDedCode = 'LTDB' THEN BdmDedCode END) AS Ltdb_DedCode

                    ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS Std_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStartDate END) AS Ltd_StartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTDB' THEN BdmBenStartDate END) AS Ltdb_StartDate


                    ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS Std_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTD' THEN BdmBenStopDate END) AS Ltd_StopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTDB' THEN BdmBenStopDate END) AS Ltdb_StopDate


                FROM dbo.U_dsi_BDM_EUNUMFMLAX WITH (NOLOCK)
                GROUP BY BdmEEID, BdmCOID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    --LEFT JOIN dbo.U_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
    LEFT JOIN (
                SELECT BcaEEID, BcaCOID
                    ,MAX(CASE WHEN BcaDedCode = 'STD' THEN BcaBenAmtMax END) AS Std_Amount
                    ,MAX(CASE WHEN BcaDedCode IN ('LTD', 'LTDB') THEN BcaBenAmtMax END) AS Ltd_Amount
                FROM dbo.U_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
                WHERE BcaFormatCode = @FormatCode
                GROUP BY BcaEEID, BcaCOID) AS BenAmt
        ON BcaEEID = xEEID
        AND BcaCoID = xCoID
--        AND BcaFormatCode = @FormatCode
 --       AND BcaDedCode = BdmDedCode                **************************** FIX THIS!!! *****************************
    LEFT JOIN dbo.U_EUNUMFMLAX_12mo_PEarHist
        ON Peh12MoEEID = xEEID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)
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
ALTER VIEW dbo.dsi_vwEUNUMFMLAX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMFMLAX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMFMLAX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101011'
       ,expStartPerControl     = '202101011'
       ,expLastEndPerControl   = '202101159'
       ,expEndPerControl       = '202101159'
WHERE expFormatCode = 'EUNUMFMLAX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMFMLAX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMFMLAX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort