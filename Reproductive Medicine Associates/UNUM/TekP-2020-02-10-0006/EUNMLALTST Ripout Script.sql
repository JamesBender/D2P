SET NOCOUNT ON;
IF OBJECT_ID('U_EUNMLALTST_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNMLALTST_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNMLALTST_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNMLALTST' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNMLALTST_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNMLALTST_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNMLALTST') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNMLALTST];
GO
IF OBJECT_ID('U_EUNMLALTST_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUNMLALTST_PEarHist];
GO
IF OBJECT_ID('U_EUNMLALTST_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUNMLALTST_PDedHist];
GO
IF OBJECT_ID('U_EUNMLALTST_File') IS NOT NULL DROP TABLE [dbo].[U_EUNMLALTST_File];
GO
IF OBJECT_ID('U_EUNMLALTST_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNMLALTST_EEList];
GO
IF OBJECT_ID('U_EUNMLALTST_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNMLALTST_drvTbl];
GO
IF OBJECT_ID('U_EUNMLALTST_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNMLALTST_DedList];
GO
IF OBJECT_ID('U_EUNMLALTST_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUNMLALTST_AuditFields];
GO
IF OBJECT_ID('U_EUNMLALTST_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUNMLALTST_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EUNMLALTST') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNMLALTST];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNMLALTST';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNMLALTST';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNMLALTST';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNMLALTST';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNMLALTST';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNMLALTST','Unum FMLA LTD STD Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EUNMLALTSTZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PARTNERCASE_ID"','1','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SERVICE_INDICATOR"','2','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SSN"','3','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','3',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID"','4','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','4',NULL,'EE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID_TYPE"','5','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_FIRST_NAME"','6','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_MIDDLE_INITIAL"','7','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LAST_NAME"','8','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_1"','9','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_2"','10','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CITY"','11','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','11',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_RDC_ST_PVC"','12','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTAL_CD"','13','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CNTRY_CD"','14','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WRK_ST_PVC"','15','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','15',NULL,'EE_WRK_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_DOB"','16','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','16',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_GENDER"','17','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','17',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MARITAL_STATUS"','18','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','18',NULL,'MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_JOB_TLE"','19','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','19',NULL,'EE_JOB_TLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MOST_RCNT_HIRE_DATE"','20','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ORG_HIRE_DATE"','21','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','21',NULL,'ORG_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TERM_DATE"','22','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','22',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_STATUS"','23','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','23',NULL,'EE_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WKLY_SCH_WRK_HRS"','24','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACCOM_RSTCT"','25','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','25',NULL,'ACCOM_RSTCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SICK_PAY_HRS"','26','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','26',NULL,'SICK_PAY_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HOME_PHONE"','27','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','27',NULL,'EE_HOME_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_FIRST_NAME"','28','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','28',NULL,'MGR_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_LAST_NAME"','29','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','29',NULL,'MGR_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MGR_EMAIL"','30','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','30',NULL,'MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SCND_MGR_EMAIL"','31','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','31',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_THRD_MGR_EMAIL"','32','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','32',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR_WRKED_IN_PST_12_MNTHS"','33','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','33',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_SUN"','34','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','34',NULL,'WRK_ON_SUN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_MON"','35','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','35',NULL,'WRK_ON_MON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_TUES"','36','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','36',NULL,'WRK_ON_TUES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_WEDS"','37','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','37',NULL,'WRK_ON_WEDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_THURS"','38','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','38',NULL,'WRK_ON_THURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_FRI"','39','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','39',NULL,'WRK_ON_FRI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRK_ON_SAT"','40','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','40',NULL,'WRK_ON_SAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FMLA_RPTING_GRP"','41','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','41',NULL,'FMLA_RPTING_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"KEY_EE"','42','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','42',NULL,'KEY_EE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE_OF_LST_SLY_CHG"','43','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','43',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SAL_MD"','44','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','44',NULL,'EE_SAL_MD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','45','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','45',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','46','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','46',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','47','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','47',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','48','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','48',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','49','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','49',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','50','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','50',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','51','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','51',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','52','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','52',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','53','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','53',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','54','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','54',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','55','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','55',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','56','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','56',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','57','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','57',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','58','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','58',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','59','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','59',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS"','60','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','60',NULL,'EARNINGS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EARNINGS_PRD"','61','(''DA''=''T,'')','EUNMLALTSTZ0','50','H','01','61',NULL,'EARNINGS_PRD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTTAX_CNTRB_PCT"','62','(''DA''=''T'')','EUNMLALTSTZ0','50','H','01','62',NULL,'EE_POSTTAX_CNTRB_PCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IVI-014181"','1','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','1',NULL,'PARTNERCASE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ELG"','2','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','2',NULL,'SERVICE_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','3',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','4','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','4',NULL,'EE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecEEID"','5','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','5',NULL,'EE_ID_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','6',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','8',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','9',NULL,'EE_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','10',NULL,'EE_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','11','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','11',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvddressState"','12','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','12',NULL,'EE_RDC_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','13','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','13',NULL,'EE_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"US"','14','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','14',NULL,'EE_CNTRY_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','15','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','15',NULL,'EE_WRK_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','16','(''UD101''=''T,'')','EUNMLALTSTZ0','50','D','10','16',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','17',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','18','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','18',NULL,'MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','19','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','19',NULL,'EE_JOB_TLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMostRecentHire"','20','(''UD101''=''T,'')','EUNMLALTSTZ0','50','D','10','20',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','21','(''UD101''=''T,'')','EUNMLALTSTZ0','50','D','10','21',NULL,'ORG_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','22','(''UD101''=''T,'')','EUNMLALTSTZ0','50','D','10','22',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','23','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','23',NULL,'EE_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeeklySchedHours"','24','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','24',NULL,'WKLY_SCH_WRK_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','25','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','25',NULL,'ACCOM_RSTCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','26',NULL,'SICK_PAY_HRS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHomeNumber"','27','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','27',NULL,'EE_HOME_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','28',NULL,'MGR_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','29',NULL,'MGR_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','30',NULL,'MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','31',NULL,'EE_SCND_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','32',NULL,'EE_THRD_MGR_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkedLst12Mo"','33','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','33',NULL,'HR_WRKED_IN_PST_12_MNTHS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','34',NULL,'WRK_ON_SUN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','35',NULL,'WRK_ON_MON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','36',NULL,'WRK_ON_TUES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','37',NULL,'WRK_ON_WEDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','38',NULL,'WRK_ON_THURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','39',NULL,'WRK_ON_FRI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','40',NULL,'WRK_ON_SAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000001"','41','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','41',NULL,'FMLA_RPTING_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T,'')','EUNMLALTSTZ0','50','D','10','42',NULL,'KEY_EE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLstSalChng"','43','(''UD101''=''T,'')','EUNMLALTSTZ0','50','D','10','43',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode"','44','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','44',NULL,'EE_SAL_MD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct1"','45','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','45',NULL,'PRODUCT 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber1"','46','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','46',NULL,'POLICY_NBR 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision1"','47','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','47',NULL,'DIVISION 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyEligGroup1"','48','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','48',NULL,'POLICY_ELG_GRP 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDteEmplCvg1"','49','(''UD101''=''T,'')','EUNMLALTSTZ0','50','D','10','49',NULL,'EFF_DATE_OF_EE_COVG 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTerminationDate1"','50','(''UD101''=''T,'')','EUNMLALTSTZ0','50','D','10','50',NULL,'COVG_TERM_DATE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarnings1"','51','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','51',NULL,'EARNINGS 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPeriod1"','52','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','52',NULL,'EARNINGS_PRD 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplPostTaxContrib1"','53','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','53',NULL,'EE_POSTTAX_CNTRB_PCT 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct2"','54','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','54',NULL,'PRODUCT 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber2"','55','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','55',NULL,'POLICY_NBR 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision2"','56','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','56',NULL,'DIVISION 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyEligGroup2"','57','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','57',NULL,'POLICY_ELG_GRP 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDteEmplCvg2"','58','(''UD101''=''T,'')','EUNMLALTSTZ0','50','D','10','58',NULL,'EFF_DATE_OF_EE_COVG 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTerminationDate2"','59','(''UD101''=''T,'')','EUNMLALTSTZ0','50','D','10','59',NULL,'COVG_TERM_DATE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarnings2"','60','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','60',NULL,'EARNINGS 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPeriod2"','61','(''UA''=''T,'')','EUNMLALTSTZ0','50','D','10','61',NULL,'EARNINGS_PRD 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplPostTaxContrib2"','62','(''UA''=''T'')','EUNMLALTSTZ0','50','D','10','62',NULL,'EE_POSTTAX_CNTRB_PCT 2',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNMLALTST_20200417.txt',NULL,'','','',NULL,NULL,NULL,'Unum FMLA LTD STD Export','202004029','EMPEXPORT','ONDEMAND','Apr  3 2020  5:42AM','EUNMLALTST',NULL,NULL,NULL,'202004029','Apr  2 2020  9:55AM','Apr  2 2020  9:55AM','202004021','783','','','202004021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNMLALTST_20200417.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202004029','EMPEXPORT','SCHEDULED','Apr  3 2020  5:42AM','EUNMLALTST',NULL,NULL,NULL,'202004029','Apr  2 2020  9:55AM','Apr  2 2020  9:55AM','202004021','783','','','202004021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNMLALTST_20200417.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202004029','EMPEXPORT','OEACTIVE','Apr  3 2020  5:42AM','EUNMLALTST',NULL,NULL,NULL,'202004029','Apr  2 2020  9:55AM','Apr  2 2020  9:55AM','202004021','638','','','202004021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNMLALTST_20200417.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202004029','EMPEXPORT','OEPASSIVE','Apr  3 2020  5:42AM','EUNMLALTST',NULL,NULL,NULL,'202004029','Apr  2 2020  9:55AM','Apr  2 2020  9:55AM','202004021','783','','','202004021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUNMLALTST_20200417.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202004179','EMPEXPORT','TEST','Apr 17 2020 12:29PM','EUNMLALTST',NULL,NULL,NULL,'202004179','Apr 17 2020 12:00AM','Dec 30 1899 12:00AM','202004031','638','','','202004031',dbo.fn_GetTimedKey(),NULL,'us3lKiREP1005',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EUNMLALTST_20200417.txt' END WHERE expFormatCode = 'EUNMLALTST';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMLALTST','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMLALTST','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMLALTST','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMLALTST','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMLALTST','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EUNMLALTST' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNMLALTST' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EUNMLALTST_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNMLALTST_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNMLALTST','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNMLALTST','D10','dbo.U_EUNMLALTST_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EUNMLALTST') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNMLALTST] (
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
IF OBJECT_ID('U_EUNMLALTST_Audit') IS NULL
CREATE TABLE [dbo].[U_EUNMLALTST_Audit] (
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
IF OBJECT_ID('U_EUNMLALTST_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUNMLALTST_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EUNMLALTST_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNMLALTST_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUNMLALTST_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNMLALTST_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvRecEEID] varchar(4) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(3) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvMostRecentHire] datetime NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvEmploymentStatus] varchar(3) NOT NULL,
    [drvWeeklySchedHours] nvarchar(4000) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvHoursWorkedLst12Mo] nvarchar(4000) NULL,
    [drvDateOfLstSalChng] datetime NULL,
    [drvSalaryMode] char(1) NULL,
    [drvProduct1] varchar(3) NULL,
    [drvPolicyNumber1] varchar(6) NULL,
    [drvDivision1] varchar(1) NULL,
    [drvPolicyEligGroup1] varchar(1) NULL,
    [drvEffectiveDteEmplCvg1] datetime NULL,
    [drvCoverageTerminationDate1] datetime NULL,
    [drvEarnings1] money NULL,
    [drvEarningsPeriod1] varchar(2) NULL,
    [drvEmplPostTaxContrib1] varchar(2) NULL,
    [drvProduct2] varchar(2) NULL,
    [drvPolicyNumber2] varchar(6) NULL,
    [drvDivision2] varchar(1) NULL,
    [drvPolicyEligGroup2] varchar(1) NULL,
    [drvEffectiveDteEmplCvg2] datetime NULL,
    [drvCoverageTerminationDate2] datetime NULL,
    [drvEarnings2] money NULL,
    [drvEarningsPeriod2] varchar(2) NULL,
    [drvEmplPostTaxContrib2] varchar(1) NULL
);
IF OBJECT_ID('U_EUNMLALTST_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNMLALTST_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNMLALTST_File') IS NULL
CREATE TABLE [dbo].[U_EUNMLALTST_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EUNMLALTST_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUNMLALTST_PDedHist] (
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
IF OBJECT_ID('U_EUNMLALTST_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUNMLALTST_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNMLALTST]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Reproductive Medicine Associates

Created By: James Bender
Business Analyst: Lea King
Create Date: 04/02/2020
Service Request Number: TekP-2020-02-10-0006

Purpose: Unum FMLA LTD STD Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNMLALTST';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNMLALTST';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNMLALTST';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNMLALTST';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNMLALTST' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNMLALTST', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNMLALTST', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNMLALTST', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNMLALTST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUNMLALTST', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNMLALTST';

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
    DELETE FROM dbo.U_EUNMLALTST_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNMLALTST_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EUNMLALTST_EEList 
    WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WHERE EecEEType IN('TES')
    );


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EUNMLALTST_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUNMLALTST_AuditFields;
    CREATE TABLE dbo.U_EUNMLALTST_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EUNMLALTST_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUNMLALTST_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUNMLALTST_Audit;
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
    INTO dbo.U_EUNMLALTST_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EUNMLALTST_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(DAY, -60, GETDATE()) AND GETDATE()
        --AND AudRowNo = 1
        AND audNewValue = 'T'
   -- AND audOldValue = 'L'
   -- AND audNewValue = 'A'
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EUNMLALTST_Audit ON dbo.U_EUNMLALTST_Audit (audEEID,audCOID);



    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STDS,LTD1';

    IF OBJECT_ID('U_EUNMLALTST_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNMLALTST_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNMLALTST_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EUNMLALTST_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNMLALTST_PDedHist;
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
    INTO dbo.U_EUNMLALTST_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EUNMLALTST_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EUNMLALTST_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUNMLALTST_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehEarnCode NOT IN ('FSICK','FVACA','NPTO','PTO','PTOC','PTODR','PTOS','SICK','UNEX','UPTO','UPTS','VACA') THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EUNMLALTST_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl BETWEEN FORMAT(DATEADD(YEAR, -1, @EndDate), 'yyyyMMdd') + '1' AND @EndPerControl
    --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNMLALTST_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNMLALTST_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNMLALTST_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvRecEEID = 'EEID' 
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvWorkState = LocAddressState
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN ISNULL(eepMaritalStatus, '') = '' OR EepMaritalStatus = 'Z' THEN 'UNK' ELSE EepMaritalStatus END
        ,drvJobTitle = JbcDesc
        ,drvMostRecentHire = EecDateOfLastHire
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'L' THEN 'LOA' ELSE 'ACT' END
        ,drvWeeklySchedHours = FORMAT(EecScheduledWorkHrs*26/52, '0.00')
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvHoursWorkedLst12Mo = FORMAT(PehCurHrsYTD, '#0.00')
        ,drvDateOfLstSalChng = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire) 
        ,drvSalaryMode = EecSalaryOrHourly
        ,drvProduct1 =    CASE WHEN STDS_DedCode IS NOT NULL THEN '469'
                            WHEN LTD1_DedCode IS NOT NULL AND STDS_DedCode IS NULL THEN '38'
                        END
        ,drvPolicyNumber1 =    CASE WHEN STDS_DedCode IS NOT NULL THEN '474495'
                                WHEN LTD1_DedCode IS NOT NULL AND STDS_DedCode IS NULL  THEN '911528'
                            END
        ,drvDivision1 = CASE WHEN STDS_DedCode IS NOT NULL OR LTD1_DedCode IS NOT NULL THEN '1' END
        ,drvPolicyEligGroup1 = CASE WHEN (STDS_DedCode IS NOT NULL OR LTD1_DedCode IS NOT NULL)  AND EecDedGroupCode <> 'DSM' THEN '2' END
        ,drvEffectiveDteEmplCvg1 = CASE WHEN STDS_DedCode IS NOT NULL THEN STDS_BenStartDate
                            WHEN LTD1_DedCode IS NOT NULL AND STDS_DedCode IS NULL  THEN LTD1_BenStartDate
                        END   
        ,drvCoverageTerminationDate1 = CASE WHEN STDS_DedCode IS NOT NULL THEN STDS_BenStopDate
                            WHEN LTD1_DedCode IS NOT NULL AND STDS_DedCode IS NULL  THEN LTD1_BenStopDate
                        END
        ,drvEarnings1 =    CASE WHEN STDS_DedCode IS NOT NULL THEN EecAnnSalary/52
                            WHEN LTD1_DedCode IS NOT NULL AND STDS_DedCode IS NULL  THEN EecAnnSalary/12
                        END        
        ,drvEarningsPeriod1 =   CASE WHEN STDS_DedCode IS NOT NULL THEN 'WK'
                            WHEN LTD1_DedCode IS NOT NULL AND STDS_DedCode IS NULL  THEN 'MO'
                        END        
        ,drvEmplPostTaxContrib1 =    CASE WHEN STDS_DedCode IS NOT NULL THEN '10'
                            WHEN LTD1_DedCode IS NOT NULL AND STDS_DedCode IS NULL  THEN '0'
                        END        
        ,drvProduct2 =    CASE WHEN STDS_DedCode IS NOT NULL AND LTD1_DedCode IS NOT NULL THEN '38' END
        ,drvPolicyNumber2 = CASE WHEN STDS_DedCode IS NOT NULL AND LTD1_DedCode IS NOT NULL THEN '911528' END 
        ,drvDivision2 = CASE WHEN STDS_DedCode IS NOT NULL AND LTD1_DedCode IS NOT NULL THEN '1' END 
        ,drvPolicyEligGroup2 =    CASE WHEN (STDS_DedCode IS NOT NULL AND LTD1_DedCode IS NOT NULL) AND EecDedGroupCode = 'DSM' THEN '1'
                                    WHEN (STDS_DedCode IS NOT NULL AND LTD1_DedCode IS NOT NULL) AND EecDedGroupCode <> 'DSM' THEN '2'
                                END
        ,drvEffectiveDteEmplCvg2 = CASE WHEN STDS_DedCode IS NOT NULL AND LTD1_DedCode IS NOT NULL THEN LTD1_BenStartDate END
        ,drvCoverageTerminationDate2 = CASE WHEN STDS_DedCode IS NOT NULL AND LTD1_DedCode IS NOT NULL THEN LTD1_BenStopDate END
        ,drvEarnings2 = CASE WHEN STDS_DedCode IS NOT NULL AND LTD1_DedCode IS NOT NULL THEN EecAnnSalary/12 END
        ,drvEarningsPeriod2 = CASE WHEN STDS_DedCode IS NOT NULL AND LTD1_DedCode IS NOT NULL THEN 'MO' END 
        ,drvEmplPostTaxContrib2 = CASE WHEN STDS_DedCode IS NOT NULL AND LTD1_DedCode IS NOT NULL THEN '0' END
    INTO dbo.U_EUNMLALTST_drvTbl
    FROM dbo.U_EUNMLALTST_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (
                SELECT BdmEEID, BdmCOID
                    ,MAX(CASE WHEN BdmDedCode = 'STDS' THEN BdmDedCode END) AS STDS_DedCode
                    ,MAX(CASE WHEN BdmDedCode = 'LTD1' THEN BdmDedCode END) AS LTD1_DedCode
                    ,MAX(CASE WHEN BdmDedCode = 'STDS' THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '1/1/2020')  END) AS STDS_BenStartDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTD1' THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '1/1/2020')  END) AS LTD1_BenStartDate 
                    ,MAX(CASE WHEN BdmDedCode = 'STDS' THEN BdmBenStopDate END) AS STDS_BenStopDate
                    ,MAX(CASE WHEN BdmDedCode = 'LTD1' THEN BdmBenStopDate END) AS LTD1_BenStopDate
                FROM dbo.U_dsi_BDM_EUNMLALTST WITH (NOLOCK)
                GROUP BY BdmEEID, BdmCOID
            ) AS Bdm_Flattened
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    JOIN dbo.U_EUNMLALTST_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    WHERE EecEmplStatus <> 'T'
        --OR (EecEmplStatus = 'T' AND EXISTS(SELECT TOP 1 * FROM dbo.U_EUNMLALTST_Audit WITH (NOLOCK) where AudEEID = xEEID AND AudCOID = xCOID))
        OR (EecEmplStatus = 'T' AND EecDateOfTErmination > DATEADD(DAY, -60, GETDATE()))
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
ALTER VIEW dbo.dsi_vwEUNMLALTST_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNMLALTST_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUNMLALTST%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202003261'
       ,expStartPerControl     = '202003261'
       ,expLastEndPerControl   = '202004029'
       ,expEndPerControl       = '202004029'
WHERE expFormatCode = 'EUNMLALTST';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNMLALTST_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNMLALTST_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort