SET NOCOUNT ON;
IF OBJECT_ID('U_EUNUMSLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMSLEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNUMSLEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNUMSLEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNUMSLEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMSLEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMSLEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMSLEXP];
GO
IF OBJECT_ID('U_EUNUMSLEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMSLEXP_PEarHist];
GO
IF OBJECT_ID('U_EUNUMSLEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMSLEXP_PDedHist];
GO
IF OBJECT_ID('U_EUNUMSLEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMSLEXP_File];
GO
IF OBJECT_ID('U_EUNUMSLEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMSLEXP_EEList];
GO
IF OBJECT_ID('U_EUNUMSLEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMSLEXP_drvTbl];
GO
IF OBJECT_ID('U_EUNUMSLEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMSLEXP_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNUMSLEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNUMSLEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNUMSLEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNUMSLEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNUMSLEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMSLEXP','UNUM STD LTD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','EUNUMSLEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PARTNERCASE_ID"','1','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SERVICE_INDICATOR"','2','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SSN"','3','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','3',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID"','4','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','4',NULL,'EE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID_TYPE"','5','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_FIRST_NAME"','6','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_MIDDLE_INITIAL"','7','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LAST_NAME"','8','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_1"','9','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_2"','10','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CITY"','11','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','11',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_RDC_ST_PVC"','12','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTAL_CD"','13','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CNTRY_CD"','14','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_ST_PVC"','15','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','15',NULL,'EE_WRK_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_DOB"','16','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','16',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_GENDER"','17','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','17',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MARITAL_STATUS"','18','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','18',NULL,'MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_JOB_TLE"','19','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','19',NULL,'EE_JOB_TLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MOST_RCNT_HIRE_DATE"','20','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ORG_HIRE_DATE"','21','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','21',NULL,'ORG_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TERM_DATE"','22','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','22',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_STATUS"','23','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','23',NULL,'EE_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WKLY_SCH_WRK_HRS"','24','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACCOM_RSTCT"','25','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','25',NULL,'ACCOM_RSTCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SICK_PAY_HRS"','26','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','26',NULL,'SICK_PAY_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HOME_PHONE"','27','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','27',NULL,'EE_HOME_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_FIRST_NAME"','28','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','28',NULL,'MGR_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_LAST_NAME"','29','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','29',NULL,'MGR_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_EMAIL"','30','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','30',NULL,'MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SCND_MGR_EMAIL"','31','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','31',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_THRD_MGR_EMAIL"','32','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','32',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR_WRKED_IN_PST_12_MNTHS"','33','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','33',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_SUN"','34','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','34',NULL,'WRK_ON_SUN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_MON"','35','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','35',NULL,'WRK_ON_MON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_TUES"','36','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','36',NULL,'WRK_ON_TUES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_WEDS"','37','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','37',NULL,'WRK_ON_WEDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_THURS"','38','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','38',NULL,'WRK_ON_THURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_FRI"','39','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','39',NULL,'WRK_ON_FRI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_SAT"','40','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','40',NULL,'WRK_ON_SAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OFFCE_NAME"','41','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','41',NULL,'OFFCE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_1"','42','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','42',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_2"','43','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','43',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_3"','44','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','44',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_CITY"','45','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','45',NULL,'EE_WRK_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_POSTAL_CD"','46','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','46',NULL,'EE_WRK_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FMLA_RPTING_GRP"','47','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','47',NULL,'FMLA_RPTING_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"KEY_EE"','48','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','48',NULL,'KEY_EE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE_OF_LST_SLY_CHG"','49','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','49',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SAL_MD"','50','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','50',NULL,'EE_SAL_MD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','51','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','51',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','52','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','52',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','53','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','53',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','54','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','54',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','55','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','55',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','56','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','56',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','57','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','57',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','58','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','58',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','59','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','59',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','60','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','60',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','61','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','61',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','62','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','62',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','63','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','63',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','64','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','64',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','65','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','65',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','66','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','66',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','67','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','67',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','68','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','68',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','69','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','69',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','70','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','70',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','71','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','71',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','72','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','72',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','73','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','73',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','74','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','74',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','75','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','75',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','76','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','76',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','77','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','77',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','78','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','78',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','79','(''DA''=''T,'')','EUNUMSLEXPZ0','50','H','01','79',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','80','(''DA''=''T'')','EUNUMSLEXPZ0','50','H','01','80',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartnerCaseId"','1','(''UA''=''T,'')','EUNUMSLEXPZ0','10','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvServiceInd"','2','(''UA''=''T,'')','EUNUMSLEXPZ0','10','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEeSsn"','3','(''UA''=''T,'')','EUNUMSLEXPZ0','11','D','10','3',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','4','(''UA''=''T,'')','EUNUMSLEXPZ0','20','D','10','4',NULL,'EE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETYpe"','5','(''UA''=''T,'')','EUNUMSLEXPZ0','5','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EUNUMSLEXPZ0','15','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','EUNUMSLEXPZ0','25','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','EUNUMSLEXPZ0','40','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EUNUMSLEXPZ0','40','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','11','(''UA''=''T,'')','EUNUMSLEXPZ0','30','D','10','11',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','12','(''UA''=''T,'')','EUNUMSLEXPZ0','2','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','13','(''UA''=''T,'')','EUNUMSLEXPZ0','11','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','14','(''UA''=''T,'')','EUNUMSLEXPZ0','2','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStatePVC"','15','(''UA''=''T,'')','EUNUMSLEXPZ0','2','D','10','15',NULL,'EE_WRK_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','16','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','16',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''T,'')','EUNUMSLEXPZ0','3','D','10','17',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','18','(''UA''=''T,'')','EUNUMSLEXPZ0','3','D','10','18',NULL,'MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','19','(''UA''=''T,'')','EUNUMSLEXPZ0','40','D','10','19',NULL,'EE_JOB_TLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecentHireDate"','20','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrigHireDate"','21','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','21',NULL,'ORG_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','22','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','22',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEStatus"','23','(''UA''=''T,'')','EUNUMSLEXPZ0','3','D','10','23',NULL,'EE_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWklySchedHrs"','24','(''UA''=''T,'')','EUNUMSLEXPZ0','5','D','10','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccomRestrict"','25','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','25',NULL,'ACCOM_RSTCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSickPayHrs"','26','(''UA''=''T,'')','EUNUMSLEXPZ0','6','D','10','26',NULL,'SICK_PAY_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','27','(''UA''=''T,'')','EUNUMSLEXPZ0','10','D','10','27',NULL,'EE_HOME_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerFirstName"','28','(''UA''=''T,'')','EUNUMSLEXPZ0','15','D','10','28',NULL,'MGR_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerLastName"','29','(''UA''=''T,'')','EUNUMSLEXPZ0','25','D','10','29',NULL,'MGR_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerEmail"','30','(''UA''=''T,'')','EUNUMSLEXPZ0','110','D','10','30',NULL,'MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScndMgrEmail"','31','(''UA''=''T,'')','EUNUMSLEXPZ0','110','D','10','31',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvThirdMgrEmail"','32','(''UA''=''T,'')','EUNUMSLEXPZ0','110','D','10','32',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWorkedPst12Months"','33','(''UA''=''T,'')','EUNUMSLEXPZ0','10','D','10','33',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkSun"','34','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','34',NULL,'WRK_ON_SUN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkMon"','35','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','35',NULL,'WRK_ON_MON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkTue"','36','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','36',NULL,'WRK_ON_TUES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkWed"','37','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','37',NULL,'WRK_ON_WEDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkThu"','38','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','38',NULL,'WRK_ON_THURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkFri"','39','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','39',NULL,'WRK_ON_FRI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drWorkSat"','40','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','40',NULL,'WRK_ON_SAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfficeName"','41','(''UA''=''T,'')','EUNUMSLEXPZ0','30','D','10','41',NULL,'OFFCE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStAddressLine1"','42','(''UA''=''T,'')','EUNUMSLEXPZ0','40','D','10','42',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStAddressLine2"','43','(''UA''=''T,'')','EUNUMSLEXPZ0','40','D','10','43',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStAddressLine3"','44','(''UA''=''T,'')','EUNUMSLEXPZ0','40','D','10','44',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCity"','45','(''UA''=''T,'')','EUNUMSLEXPZ0','30','D','10','45',NULL,'EE_WRK_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPostalCode"','46','(''UA''=''T,'')','EUNUMSLEXPZ0','11','D','10','46',NULL,'EE_WRK_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFMLAReportinGrp"','47','(''UA''=''T,'')','EUNUMSLEXPZ0','6','D','10','47',NULL,'FMLA_RPTING_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEE"','48','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','48',NULL,'KEY_EE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastSalaryChange"','49','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','49',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESalMD"','50','(''UA''=''T,'')','EUNUMSLEXPZ0','1','D','10','50',NULL,'EE_SAL_MD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct1"','51','(''UA''=''T,'')','EUNUMSLEXPZ0','4','D','10','51',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber1"','52','(''UA''=''T,'')','EUNUMSLEXPZ0','6','D','10','52',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision1"','53','(''UA''=''T,'')','EUNUMSLEXPZ0','3','D','10','53',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyElgGrp1"','54','(''UA''=''T,'')','EUNUMSLEXPZ0','3','D','10','54',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice1"','55','(''UA''=''T,'')','EUNUMSLEXPZ0','2','D','10','55',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate1"','56','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','56',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate1"','57','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','57',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarning1"','58','(''UA''=''T,'')','EUNUMSLEXPZ0','12','D','10','58',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningPrd1"','59','(''UA''=''T,'')','EUNUMSLEXPZ0','2','D','10','59',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPostTaxCntrbPct1"','60','(''UA''=''T,'')','EUNUMSLEXPZ0','6','D','10','60',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct2"','61','(''UA''=''T,'')','EUNUMSLEXPZ0','4','D','10','61',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber2"','62','(''UA''=''T,'')','EUNUMSLEXPZ0','6','D','10','62',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision2"','63','(''UA''=''T,'')','EUNUMSLEXPZ0','3','D','10','63',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyElgGrp2"','64','(''UA''=''T,'')','EUNUMSLEXPZ0','3','D','10','64',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice2"','65','(''UA''=''T,'')','EUNUMSLEXPZ0','2','D','10','65',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate2"','66','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','66',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate2"','67','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','67',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarning2"','68','(''UA''=''T,'')','EUNUMSLEXPZ0','12','D','10','68',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningPrd2"','69','(''UA''=''T,'')','EUNUMSLEXPZ0','2','D','10','69',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPostTaxCntrbPct2"','70','(''UA''=''T,'')','EUNUMSLEXPZ0','6','D','10','70',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct3"','71','(''UA''=''T,'')','EUNUMSLEXPZ0','4','D','10','71',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber3"','72','(''UA''=''T,'')','EUNUMSLEXPZ0','6','D','10','72',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision3"','73','(''UA''=''T,'')','EUNUMSLEXPZ0','3','D','10','73',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyElgGrp3"','74','(''UA''=''T,'')','EUNUMSLEXPZ0','3','D','10','74',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice3"','75','(''UA''=''T,'')','EUNUMSLEXPZ0','2','D','10','75',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate3"','76','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','76',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate3"','77','(''UD101''=''T,'')','EUNUMSLEXPZ0','10','D','10','77',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarning3"','78','(''UA''=''T,'')','EUNUMSLEXPZ0','12','D','10','78',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningPrd3"','79','(''UA''=''T,'')','EUNUMSLEXPZ0','2','D','10','79',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPostTaxCntrbPct3"','80','(''UA''=''T'')','EUNUMSLEXPZ0','6','D','10','80',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMSLEXP_20191223.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM STD LTD Export','201912039','EMPEXPORT','ONDEMAND',NULL,'EUNUMSLEXP',NULL,NULL,NULL,'201912039','Dec  3 2019  2:19PM','Dec  3 2019  2:19PM','201912031',NULL,'','','201912031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMSLEXP_20191223.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201912039','EMPEXPORT','SCHEDULED',NULL,'EUNUMSLEXP',NULL,NULL,NULL,'201912039','Dec  3 2019  2:19PM','Dec  3 2019  2:19PM','201912031',NULL,'','','201912031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMSLEXP_20191223.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201912039','EMPEXPORT','OEACTIVE',NULL,'EUNUMSLEXP',NULL,NULL,NULL,'201912039','Dec  3 2019  2:19PM','Dec  3 2019  2:19PM','201912031',NULL,'','','201912031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMSLEXP_20191223.txt',NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201912039','EMPEXPORT','OEPASSIVE',NULL,'EUNUMSLEXP',NULL,NULL,NULL,'201912039','Dec  3 2019  2:19PM','Dec  3 2019  2:19PM','201912031',NULL,'','','201912031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNUMSLEXP_20191223.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201912199','EMPEXPORT','TEST','Dec 19 2019  6:11PM','EUNUMSLEXP',NULL,NULL,NULL,'201912199','Dec 19 2019 12:00AM','Dec 30 1899 12:00AM','201912191','470','','','201912191',dbo.fn_GetTimedKey(),NULL,'US3LKINET1004',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EUNUMSLEXP_20191223.txt' END WHERE expFormatCode = 'EUNUMSLEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMSLEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMSLEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMSLEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMSLEXP','SubSort','C','drSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMSLEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMSLEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EUNUMSLEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNUMSLEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EUNUMSLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMSLEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMSLEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMSLEXP','D10','dbo.U_EUNUMSLEXP_drvTbl',NULL);
IF OBJECT_ID('U_EUNUMSLEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMSLEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUNUMSLEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMSLEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drSubSort] varchar(1) NOT NULL,
    [drvPartnerCaseId] varchar(10) NOT NULL,
    [drvServiceInd] varchar(3) NOT NULL,
    [drvEeSsn] char(11) NULL,
    [drvEmpId] char(9) NULL,
    [drvEETYpe] varchar(4) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvWorkStatePVC] varchar(255) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(3) NOT NULL,
    [drvJobTitle] varchar(6000) NULL,
    [drvRecentHireDate] datetime NULL,
    [drvOrigHireDate] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvEEStatus] varchar(6) NOT NULL,
    [drvWklySchedHrs] varchar(12) NULL,
    [drvAccomRestrict] varchar(1) NOT NULL,
    [drvSickPayHrs] varchar(1) NOT NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvManagerFirstName] varchar(256) NULL,
    [drvManagerLastName] varchar(256) NULL,
    [drvManagerEmail] varchar(256) NULL,
    [drvScndMgrEmail] varchar(1) NOT NULL,
    [drvThirdMgrEmail] varchar(1) NOT NULL,
    [drvHrsWorkedPst12Months] nvarchar(4000) NULL,
    [drvWorkSun] varchar(1) NOT NULL,
    [drvWorkMon] varchar(1) NOT NULL,
    [drvWorkTue] varchar(1) NOT NULL,
    [drvWorkWed] varchar(1) NOT NULL,
    [drvWorkThu] varchar(1) NOT NULL,
    [drvWorkFri] varchar(1) NOT NULL,
    [drWorkSat] varchar(1) NOT NULL,
    [drvOfficeName] varchar(21) NOT NULL,
    [drvWorkStAddressLine1] varchar(1) NOT NULL,
    [drvWorkStAddressLine2] varchar(1) NOT NULL,
    [drvWorkStAddressLine3] varchar(1) NOT NULL,
    [drvWorkCity] varchar(1) NOT NULL,
    [drvWorkPostalCode] varchar(1) NOT NULL,
    [drvFMLAReportinGrp] varchar(1) NOT NULL,
    [drvKeyEE] varchar(1) NOT NULL,
    [drvLastSalaryChange] datetime NULL,
    [drvEESalMD] char(1) NULL,
    [drvProduct1] varchar(2) NULL,
    [drvPolicyNumber1] varchar(6) NULL,
    [drvDivision1] varchar(1) NULL,
    [drvPolicyElgGrp1] varchar(1) NULL,
    [drvChoice1] varchar(1) NULL,
    [drvEffDate1] datetime NULL,
    [drvTermDate1] datetime NULL,
    [drvEarning1] varchar(12) NULL,
    [drvEarningPrd1] varchar(2) NULL,
    [drvEEPostTaxCntrbPct1] varchar(1) NULL,
    [drvProduct2] varchar(2) NULL,
    [drvPolicyNumber2] varchar(6) NULL,
    [drvDivision2] varchar(1) NULL,
    [drvPolicyElgGrp2] varchar(1) NULL,
    [drvChoice2] varchar(1) NULL,
    [drvEffDate2] datetime NULL,
    [drvTermDate2] datetime NULL,
    [drvEarning2] varchar(12) NULL,
    [drvEarningPrd2] varchar(2) NULL,
    [drvEEPostTaxCntrbPct2] varchar(1) NULL,
    [drvProduct3] varchar(2) NULL,
    [drvPolicyNumber3] varchar(6) NULL,
    [drvDivision3] varchar(1) NULL,
    [drvPolicyElgGrp3] varchar(1) NULL,
    [drvChoice3] varchar(1) NULL,
    [drvEffDate3] datetime NULL,
    [drvTermDate3] datetime NULL,
    [drvEarning3] varchar(12) NULL,
    [drvEarningPrd3] varchar(2) NULL,
    [drvEEPostTaxCntrbPct3] varchar(1) NULL
);
IF OBJECT_ID('U_EUNUMSLEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMSLEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNUMSLEXP_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMSLEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EUNUMSLEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMSLEXP_PDedHist] (
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
IF OBJECT_ID('U_EUNUMSLEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMSLEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMSLEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Network Health, Inc.

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 12/03/2019
Service Request Number: SR-2019-00250437 

Purpose: UNUM STD LTD Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMSLEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMSLEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMSLEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMSLEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMSLEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMSLEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMSLEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMSLEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMSLEXP', 'TEST'
EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMSLEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNUMSLEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@Last12MonthsPerControl VARCHAR(9)
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EUNUMSLEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('01/01/2020' as DateTime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    SELECT @Last12MonthsPerControl =  CONVERT(VARCHAR(12),DATEADD(month,-12, @StartDate),112) + '1'

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUNUMSLEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMSLEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTD,LTDE,STDER';

    IF OBJECT_ID('U_EUNUMSLEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMSLEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMSLEXP_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate - 60);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

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
    IF OBJECT_ID('U_EUNUMSLEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMSLEXP_PDedHist;
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
    INTO dbo.U_EUNUMSLEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EUNUMSLEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EUNUMSLEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMSLEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        --,PehCurHrsYTD           = SUM(CASE WHEN (PehPerControl >=  @Last12MonthsPerControl and PehPerControl <= @StartPerControl) and PehEarnCode IN ('CALLI', 'CIPHN', 'HOLW', 'ONCAL', 'OT', 'REG', 'VOL') THEN PehCurHrs ELSE 0.00 END)
        ,PehCurHrsYTD           = SUM(CASE WHEN (PehPerControl >=  @Last12MonthsPerControl) and PehEarnCode IN ('CALLI', 'CIPHN', 'HOLW', 'ONCAL', 'OT', 'REG', 'VOL') THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EUNUMSLEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMSLEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMSLEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMSLEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvPartnerCaseId = 'NET-013075'
        ,drvServiceInd = 'ELG'
        ,drvEeSsn = eepSSN
        ,drvEmpId = eecEmpNo
        ,drvEETYpe = 'EEID'
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvState = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountryCode = 'US'
        ,drvWorkStatePVC = (select top 1 LocAddressState from Location where LocCode =  EecLocation)
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE  eepMaritalStatus
                                WHEN 'D' THEN 'DIV'         
                                WHEN 'M' THEN 'MAR'              
                                WHEN 'S' THEN 'SGL'              
                                WHEN 'W' THEN 'WID'              
                                WHEN 'Z' THEN 'UNK'  
                                ELSE 'UNK'
                            END
        ,drvJobTitle = dbo.dsi_fnRemoveChars(',',(Select top 1 JbcDesc from JobCode where JbcJobCode = EecJobCode))
        ,drvRecentHireDate = eecdateoflasthire
        ,drvOrigHireDate = CASE WHEN EepUDField05 IS NOT NULL THEN EepUDField05 ELSE eecdateoforiginalhire END
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEEStatus = CASE WHEN eecemplstatus = 'L' THEN 'Leave' ELSE 'Active' END
        ,drvWklySchedHrs = CAST(CONVERT(DECIMAL(10,2),EecScheduledWorkHrs / 2) as varchar(12))
        ,drvAccomRestrict = 'N'
        ,drvSickPayHrs = '0'
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvManagerFirstName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameFirst') 
        ,drvManagerLastName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast') 
        ,drvManagerEmail = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail') 
        ,drvScndMgrEmail = ''
        ,drvThirdMgrEmail = ''
        -- CALLI, CIPHN, HOLW, ONCAL, OT, REG, VOL
        ,drvHrsWorkedPst12Months =   CASE WHEN EepUDField05  IS NULL THEN FORMAT(PehCurHrsYTD, '#.00') -- ABC
                                        WHEN EepUDField05 is not null and EepUDField05 > DATEADD(MM, - 12, @EndDate) THEN 
                                            CASE WHEN EepUDField09 IS NULL THEN FORMAT(PehCurHrsYTD, '#.00')                                        
                                                ELSE FORMAT(CAST(REPLACE(EepUDField09, ',', '') AS decimal(10,2)) + PehCurHrsYTD, '#.00') 
                                            END                                
                                        WHEN EepUDField05 is not null and EepUDField05 < DATEADD(MM, - 12, @EndDate) THEN  FORMAT(PehCurHrsYTD, '#.00')
                                    END
                                        
        ,drvWorkSun = 'N'
        ,drvWorkMon = 'N'
        ,drvWorkTue = 'N'
        ,drvWorkWed = 'N'
        ,drvWorkThu = 'N'
        ,drvWorkFri = 'N'
        ,drWorkSat = 'N'
        ,drvOfficeName = '"Network Health, Inc"'
        ,drvWorkStAddressLine1 = '' --EepUDField05 -- ''
        ,drvWorkStAddressLine2 = '' --EepUDField09 -- ''
        ,drvWorkStAddressLine3 = '' --DATEADD(MM, - 12, @EndDate) -- ''
        ,drvWorkCity = '' --CASE WHEN EepUDField05 < DATEADD(MM, - 12, @EndDate) THEN '05 is less' ELSE '05 is more' END  -- ''
        ,drvWorkPostalCode = ''
        ,drvFMLAReportinGrp = '1'
        ,drvKeyEE = ''
        ,drvLastSalaryChange = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire) 
        ,drvEESalMD = EecSalaryOrHourly
        ,drvProduct1 = CASE WHEN STDER IS NOT NULL THEN '31' END 
        ,drvPolicyNumber1 =  CASE WHEN STDER IS NOT NULL THEN '837106' END 
        ,drvDivision1 = CASE WHEN STDER IS NOT NULL THEN '1' END 
        ,drvPolicyElgGrp1 = CASE WHEN STDER IS NOT NULL THEN '1' END 
        ,drvChoice1 = CASE WHEN STDER IS NOT NULL THEN '1' END 
        ,drvEffDate1 = CASE WHEN STDER IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',STDER_BenefitStartDate, @FileMinCovDate) END  
        ,drvTermDate1 = CASE WHEN STDER IS NOT NULL THEN STDER_BenefitStopDate END  
        ,drvEarning1 = CASE WHEN STDER IS NOT NULL THEN CAST((CASE WHEN EecWeeklyPayRate > 999999.99 THEN 999999.99 ELSE CONVERT(DECIMAL(10,2),eecWeeklyPayRate)  END) as VARCHAR(12)) END 
        ,drvEarningPrd1 = CASE WHEN STDER IS NOT NULL THEN 'WK' END 
        ,drvEEPostTaxCntrbPct1 =  CASE WHEN STDER IS NOT NULL THEN '0' END 
        ,drvProduct2 = CASE WHEN LTDER IS NOT NULL THEN '38' END 
        ,drvPolicyNumber2 =  CASE WHEN LTDER IS NOT NULL THEN '837106' END 
        ,drvDivision2 = CASE WHEN LTDER IS NOT NULL THEN '1' END 
        ,drvPolicyElgGrp2 = CASE WHEN LTDER IS NOT NULL THEN '1' END 
        ,drvChoice2 = CASE WHEN LTDER IS NOT NULL THEN '1' END 
        ,drvEffDate2 = CASE WHEN LTDER IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',LTDER_BenefitStartDate, @FileMinCovDate) END  
        ,drvTermDate2 = CASE WHEN LTDER IS NOT NULL THEN LTDER_BenefitStopDate END  
        ,drvEarning2 = CASE WHEN LTDER IS NOT NULL THEN CAST ( (CASE WHEN (eecannsalary / 12) > 999999.99 THEN '999999.99' ELSE CONVERT(DECIMAL(10,2),eecannsalary / 12) END)  as VARCHAR(12)) END 
        ,drvEarningPrd2 = CASE WHEN LTDER IS NOT NULL THEN 'MO' END 
        ,drvEEPostTaxCntrbPct2 =  CASE WHEN LTDER IS NOT NULL THEN '0' END 
        ,drvProduct3 = CASE WHEN LTD IS NOT NULL THEN '38' END 
        ,drvPolicyNumber3 =  CASE WHEN LTD IS NOT NULL THEN '837106' END 
        ,drvDivision3 = CASE WHEN LTD IS NOT NULL THEN '1' END 
        ,drvPolicyElgGrp3 = CASE WHEN LTD IS NOT NULL THEN '2' END 
        ,drvChoice3 = CASE WHEN LTD IS NOT NULL THEN '1' END 
        ,drvEffDate3 = CASE WHEN LTD IS NOT NULL THEN dbo.dsi_fnGetMinMaxDates('MAX',LTD_BenefitStartDate, @FileMinCovDate) END  
        ,drvTermDate3 = CASE WHEN LTD IS NOT NULL THEN LTD_BenefitStopDate END  
        ,drvEarning3 = CASE WHEN LTD IS NOT NULL THEN  CAST ( (CASE WHEN (eecannsalary / 12) > 999999.99 THEN 999999.99 ELSE CONVERT(DECIMAL(10,2),eecannsalary / 12) END)  as VARCHAR(12)) END  
        ,drvEarningPrd3 = CASE WHEN LTD IS NOT NULL THEN 'MO' END 
        ,drvEEPostTaxCntrbPct3 =  CASE WHEN LTD IS NOT NULL THEN '0' END 
    INTO dbo.U_EUNUMSLEXP_drvTbl
    FROM dbo.U_EUNUMSLEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN (Select  eedEEID,eedcoid
            ,LTDER = MAX((CASE WHEN eedDedCode = 'LTDE' then 'LTDE' END))
            ,STDER = MAX((CASE WHEN eedDedCode = 'STDER' then 'STDER' END))
            ,LTD = MAX((CASE WHEN eedDedCode = 'LTD' then 'LTD' END))
            ,LTDER_BenefitStartDate = MAX((CASE WHEN eedDedCode = 'LTDE' then  eedBenStartDate END))
            ,STDER_BenefitStartDate = MAX((CASE WHEN eedDedCode = 'STDER' then  eedBenStartDate END))
            ,LTD_BenefitStartDate = MAX((CASE WHEN eedDedCode = 'LTD' then  eedBenStartDate END))
            ,LTDER_BenefitStopDate = MAX((CASE WHEN eedDedCode = 'LTDE' then  eedBenStopDate END))
            ,STDER_BenefitStopDate = MAX((CASE WHEN eedDedCode = 'STDER' then  eedBenStopDate END))
            ,LTD_BenefitStopDate = MAX((CASE WHEN eedDedCode = 'LTD' then  eedBenStopDate END))
            from U_dsi_BDM_EmpDeductions  WITH (NOLOCK) where   EedFormatCode = 'EUNUMSLEXP' 
        AND EedValidForExport = 'Y' group by eedEEID,eedcoid) as BdmConsolidated
        ON xEEID =  EEDEEID 
        AND XCOID = EEDCOID
     JOIN dbo.U_EUNUMSLEXP_PEarHist  WITH (NOLOCK)
        on PehEEID =  XEEID
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
ALTER VIEW dbo.dsi_vwEUNUMSLEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMSLEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMSLEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911261'
       ,expStartPerControl     = '201911261'
       ,expLastEndPerControl   = '201912039'
       ,expEndPerControl       = '201912039'
WHERE expFormatCode = 'EUNUMSLEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMSLEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMSLEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort