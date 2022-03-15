SET NOCOUNT ON;
IF OBJECT_ID('U_EUNUMFSLXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFSLXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNUMFSLXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNUMFSLXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNUMFSLXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMFSLXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMFSLXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMFSLXP];
GO
IF OBJECT_ID('U_EUNUMFSLXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFSLXP_PEarHist];
GO
IF OBJECT_ID('U_EUNUMFSLXP_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFSLXP_File];
GO
IF OBJECT_ID('U_EUNUMFSLXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFSLXP_EEList];
GO
IF OBJECT_ID('U_EUNUMFSLXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFSLXP_drvTbl];
GO
IF OBJECT_ID('U_EUNUMFSLXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFSLXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMFSLXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMFSLXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNUMFSLXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNUMFSLXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNUMFSLXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNUMFSLXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNUMFSLXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMFSLXP','UNUM FLMA, STD, LTD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EUNUMFSLXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNUMFSLXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PARTNERCASE_ID"','1','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SERVICE_INDICATOR"','2','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SSN"','3','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','3',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID"','4','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','4',NULL,'EE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID_TYPE"','5','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_FIRST_NAME"','6','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_MIDDLE_INITIAL"','7','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LAST_NAME"','8','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_1"','9','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_2"','10','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CITY"','11','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','11',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_RDC_ST_PVC"','12','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTAL_CD"','13','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CNTRY_CD"','14','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_ST_PVC"','15','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','15',NULL,'EE_WRK_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_DOB"','16','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','16',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_GENDER"','17','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','17',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MARITAL_STATUS"','18','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','18',NULL,'MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_JOB_TLE"','19','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','19',NULL,'EE_JOB_TLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MOST_RCNT_HIRE_DATE"','20','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ORG_HIRE_DATE"','21','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','21',NULL,'ORG_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TERM_DATE"','22','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','22',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_STATUS"','23','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','23',NULL,'EE_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WKLY_SCH_WRK_HRS"','24','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE_OF_LST_SLY_CHG"','25','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','25',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HOME_PHONE"','26','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','26',NULL,'EE_HOME_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_FIRST_NAME"','27','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','27',NULL,'MGR_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_LAST_NAME"','28','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','28',NULL,'MGR_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_EMAIL"','29','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','29',NULL,'MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SCND_MGR_EMAIL"','30','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','30',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_THRD_MGR_EMAIL"','31','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','31',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR_WRKED_IN_PST_12_MNTHS"','32','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','32',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OFFCE_NAME"','33','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','33',NULL,'OFFCE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_1"','34','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','34',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_2"','35','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','35',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_MAIL_ST_ADDR_3"','36','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','36',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_CITY"','37','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','37',NULL,'EE_WRK_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_POSTAL_CD"','38','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','38',NULL,'EE_WRK_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FMLA_RPTING_GRP"','39','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','39',NULL,'FMLA_RPTING_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"KEY_EE"','40','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','40',NULL,'KEY_EE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SAL_MD"','41','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','41',NULL,'EE_SAL_MD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','42','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','42',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','43','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','43',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','44','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','44',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','45','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','45',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','46','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','46',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','47','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','47',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','48','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','48',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','49','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','49',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','50','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','50',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','51','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','51',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','52','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','52',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','53','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','53',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','54','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','54',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','55','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','55',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','56','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','56',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','57','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','57',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','58','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','58',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','59','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','59',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','60','(''DA''=''T,'')','EUNUMFSLXPZ0','50','H','01','60',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','61','(''DA''=''T'')','EUNUMFSLXPZ0','50','H','01','61',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIR-021961"','1','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELG"','2','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','3',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeID"','4','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','4',NULL,'EE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EEID"','5','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','11','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','11',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','12','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','13','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"US"','14','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','15','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','15',NULL,'EE_WRK_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','16','(''UD112''=''T,'')','EUNUMFSLXPZ0','50','D','10','16',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','17',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','18','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','18',NULL,'MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','19','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','19',NULL,'EE_JOB_TLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMostRecentHireDate"','20','(''UD112''=''T,'')','EUNUMFSLXPZ0','50','D','10','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','21','(''UD112''=''T,'')','EUNUMFSLXPZ0','50','D','10','21',NULL,'ORG_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentTermDate"','22','(''UD112''=''T,'')','EUNUMFSLXPZ0','50','D','10','22',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','23','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','23',NULL,'EE_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeeklySchedWorkHours"','24','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastSalaryChange"','25','(''UD112''=''T,'')','EUNUMFSLXPZ0','50','D','10','25',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeHomePhone"','26','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','26',NULL,'EE_HOME_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerFirstName"','27','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','27',NULL,'MGR_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerLastName"','28','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','28',NULL,'MGR_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerEmail"','29','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','29',NULL,'MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"lmartinez@ffin.com"','30','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','30',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','31','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','31',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedPast12Months"','32','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','32',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Financial Banshares"','33','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','33',NULL,'OFFCE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','34',NULL,'EE_WRK_MAIL_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','35',NULL,'EE_WRK_MAIL_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','36',NULL,'EE_WRK_MAIL_ST_ADDR_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','37',NULL,'EE_WRK_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','38',NULL,'EE_WRK_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','39','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','39',NULL,'FMLA_RPTING_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T,'')','EUNUMFSLXPZ0','50','D','10','40',NULL,'KEY_EE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESalaryMode"','41','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','41',NULL,'EE_SAL_MD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct1"','42','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','42',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber1"','43','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','43',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision1"','44','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','44',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyEligibilityGroup1"','45','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','45',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice1"','46','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','46',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePostTaxContrib1"','47','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','47',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarnings1"','48','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','48',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPeriod1"','49','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','49',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectDteEmployeeCoverage1"','50','(''UD112''=''T,'')','EUNUMFSLXPZ0','50','D','10','50',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeCoverageTermDate1"','51','(''UD112''=''T,'')','EUNUMFSLXPZ0','50','D','10','51',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct2"','52','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','52',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber2"','53','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','53',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision2"','54','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','54',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyEligibilityGroup2"','55','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','55',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice2"','56','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','56',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePostTaxContrib2"','57','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','57',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarnings2"','58','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','58',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPeriod2"','59','(''UA''=''T,'')','EUNUMFSLXPZ0','50','D','10','59',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectDteEmployeeCoverage2"','60','(''UD112''=''T,'')','EUNUMFSLXPZ0','50','D','10','60',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeCoverageTermDate2"','61','(''UD112''=''T'')','EUNUMFSLXPZ0','50','D','10','61',NULL,'COVG_TERM_DATE',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUNUMFSLXP_20201204.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202011249','EMPEXPORT','OEACTIVE',NULL,'EUNUMFSLXP',NULL,NULL,NULL,'202011249','Nov 24 2020 10:57AM','Nov 24 2020 10:57AM','202011241',NULL,'','','202011241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202011249','EMPEXPORT','OEPASSIVE',NULL,'EUNUMFSLXP',NULL,NULL,NULL,'202011249','Nov 24 2020 10:57AM','Nov 24 2020 10:57AM','202011241',NULL,'','','202011241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM FLMA, STD, LTD Export','202011249','EMPEXPORT','ONDEM_XOE',NULL,'EUNUMFSLXP',NULL,NULL,NULL,'202011249','Nov 24 2020 10:57AM','Nov 24 2020 10:57AM','202011241',NULL,'','','202011241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM FLMA, STD, LTD Expo-Sched','202011249','EMPEXPORT','SCH_EUNUMF',NULL,'EUNUMFSLXP',NULL,NULL,NULL,'202011249','Nov 24 2020 10:57AM','Nov 24 2020 10:57AM','202011241',NULL,'','','202011241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM FLMA, STD, LTD Expo-Test','202011249','EMPEXPORT','TEST_XOE','Dec  2 2020 12:00AM','EUNUMFSLXP',NULL,NULL,NULL,'202011249','Nov 24 2020 12:00AM','Dec 30 1899 12:00AM','202011241',NULL,'','','202011241',dbo.fn_GetTimedKey(),NULL,'CPETITTI11',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMFSLXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMFSLXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMFSLXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMFSLXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMFSLXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUNUMFSLXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUNUMFSLXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUNUMFSLXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNUMFSLXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMFSLXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMFSLXP','D10','dbo.U_EUNUMFSLXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EUNUMFSLXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMFSLXP] (
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
IF OBJECT_ID('U_EUNUMFSLXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMFSLXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUNUMFSLXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMFSLXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeID] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(257) NULL,
    [drvAddressLine2] varchar(257) NOT NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(3) NOT NULL,
    [drvJobTitle] varchar(27) NOT NULL,
    [drvMostRecentHireDate] datetime NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvEmploymentTermDate] datetime NULL,
    [drvEmploymentStatus] varchar(3) NULL,
    [drvWeeklySchedWorkHours] nvarchar(4000) NULL,
    [drvDateOfLastSalaryChange] datetime NULL,
    [drvEmployeeHomePhone] varchar(50) NULL,
    [drvManagerFirstName] varchar(100) NULL,
    [drvManagerLastName] varchar(100) NULL,
    [drvManagerEmail] varchar(50) NULL,
    [drvHoursWorkedPast12Months] nvarchar(4000) NULL,
    [drvEESalaryMode] varchar(1) NOT NULL,
    [drvProduct1] varchar(2) NULL,
    [drvPolicyNumber1] varchar(6) NULL,
    [drvDivision1] varchar(1) NULL,
    [drvPolicyEligibilityGroup1] varchar(1) NULL,
    [drvChoice1] varchar(1) NULL,
    [drvEmployeePostTaxContrib1] varchar(3) NULL,
    [drvEarnings1] nvarchar(4000) NULL,
    [drvEarningsPeriod1] varchar(2) NULL,
    [drvEffectDteEmployeeCoverage1] datetime NULL,
    [drvEmployeeCoverageTermDate1] datetime NULL,
    [drvProduct2] varchar(2) NULL,
    [drvPolicyNumber2] varchar(6) NULL,
    [drvDivision2] varchar(1) NULL,
    [drvPolicyEligibilityGroup2] varchar(1) NULL,
    [drvChoice2] varchar(1) NULL,
    [drvEmployeePostTaxContrib2] varchar(3) NULL,
    [drvEarnings2] nvarchar(4000) NULL,
    [drvEarningsPeriod2] varchar(2) NULL,
    [drvEffectDteEmployeeCoverage2] datetime NULL,
    [drvEmployeeCoverageTermDate2] datetime NULL
);
IF OBJECT_ID('U_EUNUMFSLXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMFSLXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNUMFSLXP_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMFSLXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EUNUMFSLXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUNUMFSLXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] numeric NULL,
    [PehHrsPast12Mo] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMFSLXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: First Fincancial Bankshares

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 11/24/2020
Service Request Number: TekP-2020-10-09-0002

Purpose: UNUM FLMA, STD, LTD Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMFSLXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMFSLXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMFSLXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMFSLXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMFSLXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMFSLXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMFSLXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMFSLXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMFSLXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMFSLXP', 'SCH_EUNUMF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMFSLXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNUMFSLXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUMFSLXP';

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
    DELETE FROM dbo.U_EUNUMFSLXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMFSLXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EUNUMFSLXP_EEList where xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'VSTD,LTD,LTDEX,LTDIM';

    IF OBJECT_ID('U_EUNUMFSLXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMFSLXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMFSLXP_DedList
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
    
    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EUNUMFSLXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMFSLXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(CASE WHEN LEFT(PehPerControl,4) = LEFT(@EndPerControl,4) AND PehPerControl <= @EndPerControl AND PehEarnCode IN ('REG','COMM','COMMI') THEN PehCurAmt ELSE 0.00 END)
        ,PehHrsPast12Mo           = SUM(CASE WHEN PehEarnCode IN ('REG','COMM','COMMI') THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        /*,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)*/
    INTO dbo.U_EUNUMFSLXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
        PehPerControl <= @EndPerControl
    AND PehPerControl > FORMAT(DATEADD(year, -1, GETDATE()), 'yyyyMMdd') + '1'
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMFSLXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMFSLXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMFSLXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = LTD_DedCode --EecDateOfLastHire
        -- standard fields above and additional driver fields below
        ,drvSSN = Emp.EepSSN
        ,drvEmployeID = EecEmpNo
        ,drvNameFirst = Emp.EepNameFirst
        ,drvNameMiddle = LEFT(Emp.EepNameMiddle,1)
        ,drvNameLast = Emp.EepNameLast
        ,drvAddressLine1 = '"' + Emp.EepAddressLine1 + '"'
        ,drvAddressLine2 = '"' + ISNULL(RTRIM(Emp.EepAddressLine2), '')  + '"'
        ,drvAddressCity = Emp.EepAddressCity
        ,drvAddressState = Emp.EepAddressState
        ,drvAddressZipCode = Emp.EepAddressZipCode
        ,drvWorkState = LocAddressState
        ,drvDateOfBirth = Emp.EepDateOfBirth
        ,drvGender = CASE WHEN Emp.EepGender IN ('M','F') THEN Emp.EepGender END
        ,drvMaritalStatus =    CASE WHEN Emp.EepMaritalStatus = 'S' THEN 'SGL'
                                WHEN Emp.EepMaritalStatus = 'M' THEN 'MAR'
                                WHEN Emp.EepMaritalStatus  = 'D' THEN 'DIV'
                                WHEN Emp.EepMaritalStatus  = 'W' THEN 'WID'
                                ELSE 'UNK'
                            END
        ,drvJobTitle = '"' + ISNULL(JbcDesc, '') + '"'
        ,drvMostRecentHireDate = EecDateOfLastHire
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvEmploymentTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmploymentStatus =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason IN ('200','207','208','209','210') THEN 'LAY' 
                                    WHEN EecEmplStatus IN ('A','T') THEN 'ACT'
                                    WHEN EecEmplStatus = 'L' THEN 'LOA'
                                END
        ,drvWeeklySchedWorkHours =    FORMAT(
                                            CASE WHEN EecPayPeriod = 'W' THEN EecScheduledWorkHrs
                                                WHEN EecPayPeriod = 'B' THEN EecScheduledWorkHrs/2
                                                WHEN EecPayPeriod = 'S' THEN (EecScheduledWorkHrs*24)/52
                                                WHEN EecPayPeriod = 'M' THEN (EecScheduledWorkHrs*12)/52
                                            END, '#0.00')
        ,drvDateOfLastSalaryChange = dbo.dsi_fnlib_GetAnnSalary_EffDate(xEEID,xCOID, EecDateOfLastHire)
        ,drvEmployeeHomePhone = Emp.EepPhoneHomeNumber
        ,drvManagerFirstName = Sup.EepNameFirst
        ,drvManagerLastName = Sup.EepNameLast
        ,drvManagerEmail = Sup.EepAddressEMail
        ,drvHoursWorkedPast12Months =    CASE WHEN EjhFLSACategory = 'E' THEN '1250'
                                            ELSE FORMAT(PehHrsPast12Mo, '#0.00')
                                        END
        ,drvEESalaryMode = CASE WHEN EecSalaryOrHourly = 'S' THEN 'S' ELSE 'H' END
        ,drvProduct1 =    CASE WHEN VSTD_DedCode IS NOT NULL THEN '31'
                            WHEN LTD_DedCode IS NOT NULL THEN '38'
                        END
        ,drvPolicyNumber1 =    CASE WHEN VSTD_DedCode IS NOT NULL THEN '571709'
                                WHEN LTD_DedCode IS NOT NULL THEN '571708'
                            END
        ,drvDivision1 = CASE WHEN VSTD_DedCode IS NOT NULL THEN '1'
                                WHEN LTD_DedCode IS NOT NULL THEN '1'
                            END
        ,drvPolicyEligibilityGroup1 =    CASE WHEN VSTD_DedCode IS NOT NULL THEN '1'
                                            ELSE 
                                                CASE WHEN LTD_DedCode IN ('LTDEX','LTDIM') THEN '1'
                                                    WHEN LTD_DedCode = 'LTD' THEN '2'
                                                END
                                        END
        ,drvChoice1 =    CASE WHEN VSTD_DedCode IS NOT NULL THEN '1'
                            WHEN LTD_DedCode IS NOT NULL THEN '1'
                        END
        ,drvEmployeePostTaxContrib1 = CASE WHEN VSTD_DedCode IS NOT NULL THEN '100'
                                            ELSE 
                                                CASE WHEN LTD_DedCode IN ('LTDEX','LTDIM') THEN '100'
                                                    WHEN LTD_DedCode = 'LTD' THEN '0'
                                                END
                                        END
        ,drvEarnings1 =    CASE WHEN VSTD_DedCode IS NOT NULL THEN
                                CASE WHEN EecDateOfLastHire NOT BETWEEN @StartDate AND @EndDate THEN FORMAT(PehCurAmtYTD/52 , '#0.00') 
                                    ELSE 
                                        CASE WHEN PehCurAmtYTD > 0 THEN FORMAT(PehCurAmtYTD/52 , '#0.00') ELSE FORMAT(EecAnnSalary/52,  '#0.00') END
                                    
                                END
                            WHEN LTD_DedCode IS NOT NULL THEN
                                CASE WHEN EecDateOfLastHire NOT BETWEEN @StartDate AND @EndDate THEN FORMAT(PehCurAmtYTD/12 , '#0.00') 
                                    ELSE CASE WHEN PehCurAmtYTD > 0 THEN FORMAT(PehCurAmtYTD/12 , '#0.00') ELSE FORMAT(EecAnnSalary/12,  '#0.00') END                                    
                                END
                        END
        ,drvEarningsPeriod1 =    CASE WHEN VSTD_DedCode IS NOT NULL THEN 'WK'
                                    WHEN LTD_DedCode IS NOT NULL THEN 'MO'
                                END
        ,drvEffectDteEmployeeCoverage1 =    CASE WHEN VSTD_DedCode IS NOT NULL THEN VSTD_BenStartDate
                                                WHEN LTD_DedCode IS NOT NULL THEN LTD_BenStartDate
                                            END
        ,drvEmployeeCoverageTermDate1 = CASE WHEN VSTD_DedCode IS NOT NULL THEN VSTD_BenStopDate
                                            WHEN LTD_DedCode IS NOT NULL THEN LTD_BenStopDate
                                        END
        ,drvProduct2 = CASE WHEN VSTD_DedCode IS NOT NULL AND LTD_DedCode IS NOT NULL THEN '38' END
        ,drvPolicyNumber2 = CASE WHEN VSTD_DedCode IS NOT NULL AND LTD_DedCode IS NOT NULL THEN '571708' END
        ,drvDivision2 = CASE WHEN VSTD_DedCode IS NOT NULL AND LTD_DedCode IS NOT NULL THEN '1' END
        ,drvPolicyEligibilityGroup2 =    CASE WHEN VSTD_DedCode IS NOT NULL AND LTD_DedCode IS NOT NULL THEN
                                            CASE WHEN LTD_DedCode IN ('LTDEX','LTDIM') THEN '1'
                                                WHEN LTD_DedCode = 'LTD' THEN '2'
                                            END
                                        END
        ,drvChoice2 = CASE WHEN VSTD_DedCode IS NOT NULL AND LTD_DedCode IS NOT NULL THEN '1' END
        ,drvEmployeePostTaxContrib2 = CASE WHEN VSTD_DedCode IS NOT NULL AND LTD_DedCode IS NOT NULL THEN
                                            CASE WHEN LTD_DedCode IN ('LTDEX','LTDIM') THEN '100'
                                                WHEN LTD_DedCode = 'LTD' THEN '0'
                                            END
                                        END
        ,drvEarnings2 = CASE WHEN VSTD_DedCode IS NOT NULL AND LTD_DedCode IS NOT NULL THEN
                            CASE WHEN EecDateOfLastHire NOT BETWEEN @StartDate AND @EndDate THEN FORMAT(PehCurAmtYTD/12 , '#0.00') 
                                ELSE CASE WHEN PehCurAmtYTD > 0 THEN FORMAT(PehCurAmtYTD/12 , '#0.00') ELSE FORMAT(EecAnnSalary/12,  '#0.00') END                                    
                            END
                        END
        ,drvEarningsPeriod2 = CASE WHEN VSTD_DedCode IS NOT NULL AND LTD_DedCode IS NOT NULL THEN 'MO' END
        ,drvEffectDteEmployeeCoverage2 = CASE WHEN VSTD_DedCode IS NOT NULL AND LTD_DedCode IS NOT NULL THEN VSTD_BenStartDate END
        ,drvEmployeeCoverageTermDate2 = CASE WHEN VSTD_DedCode IS NOT NULL AND LTD_DedCode IS NOT NULL THEN VSTD_BenStopDate END
    INTO dbo.U_EUNUMFSLXP_drvTbl
    FROM dbo.U_EUNUMFSLXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers Emp WITH (NOLOCK)
        ON Emp.EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (
                SELECT BdmEEID
                    ,BdmCOID
                    ,MAX(CASE WHEN BdmDedCode IN ('VSTD') THEN BdmDedCode END) AS VSTD_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('VSTD') THEN BdmBenStartDate END) AS VSTD_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('VSTD') THEN BdmBenStopDate END) AS VSTD_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('LTD','LTDEX') THEN BdmDedCode END) AS LTD_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('LTD','LTDEX') THEN BdmBenStartDate END) AS LTD_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('LTD','LTDEX') THEN BdmBenStopDate END) AS LTD_BenStopDate

                    /*
                    ,MAX(CASE WHEN BdmDedCode IN ('LTD','LTDEX','LTDIM') THEN BdmDedCode END) AS LTD_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('LTD','LTDEX','LTDIM') THEN BdmBenStartDate END) AS LTD_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('LTD','LTDEX','LTDIM') THEN BdmBenStopDate END) AS LTD_BenStopDate*/
                FROM dbo.U_dsi_BDM_EUNUMFSLXP WITH (NOLOCK)
                GROUP BY BdmEEID, BdmCOID) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.EmpPers Sup WITH (NOLOCK)
        ON EecSupervisorID = Sup.eepEEID
    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhJobCode = EecJobCode 
    JOIN dbo.U_EUNUMFSLXP_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
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
ALTER VIEW dbo.dsi_vwEUNUMFSLXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMFSLXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMFSLXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202011171'
       ,expStartPerControl     = '202011171'
       ,expLastEndPerControl   = '202011249'
       ,expEndPerControl       = '202011249'
WHERE expFormatCode = 'EUNUMFSLXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMFSLXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNUMFSLXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort