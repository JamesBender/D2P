SET NOCOUNT ON;
IF OBJECT_ID('U_ENORUNUACC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENORUNUACC_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ENORUNUACC_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ENORUNUACC' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwENORUNUACC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENORUNUACC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENORUNUACC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENORUNUACC];
GO
IF OBJECT_ID('U_ENORUNUACC_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ENORUNUACC_PEarHist];
GO
IF OBJECT_ID('U_ENORUNUACC_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ENORUNUACC_PDedHist];
GO
IF OBJECT_ID('U_ENORUNUACC_File') IS NOT NULL DROP TABLE [dbo].[U_ENORUNUACC_File];
GO
IF OBJECT_ID('U_ENORUNUACC_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENORUNUACC_EEList];
GO
IF OBJECT_ID('U_ENORUNUACC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENORUNUACC_drvTbl];
GO
IF OBJECT_ID('U_ENORUNUACC_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENORUNUACC_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ENORUNUACC') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENORUNUACC];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ENORUNUACC';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ENORUNUACC';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ENORUNUACC';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ENORUNUACC';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ENORUNUACC';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ENORUNUACC','Accident and Critical Illness','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ENORUNUACCZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ENORUNUACC' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PARTNERCASE_ID"','1','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','1',NULL,'PARTNERCASE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SERVICE_INDICATOR"','2','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','2',NULL,'SERVICE_INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SSN"','3','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','3',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID"','4','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','4',NULL,'EE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ID_TYPE"','5','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','5',NULL,'EE_ID_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_FIRST_NAME"','6','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','6',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_MIDDLE_INITIAL"','7','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','7',NULL,'EE_MIDDLE_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LAST_NAME"','8','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','8',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_1"','9','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','9',NULL,'EE_ST_ADDR_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ST_ADDR_2"','10','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','10',NULL,'EE_ST_ADDR_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CITY"','11','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','11',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_RDC_ST_PVC"','12','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','12',NULL,'EE_RDC_ST_PVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_POSTAL_CD"','13','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','13',NULL,'EE_POSTAL_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CNTRY_CD"','14','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','14',NULL,'EE_CNTRY_CD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_DOB"','15','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','15',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP_DOB"','16','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','16',NULL,'SP_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_GENDER"','17','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','17',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TOBACCO_USE"','18','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','18',NULL,'EE_TOBACCO_USE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MOST_RCNT_HIRE_DATE"','19','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','19',NULL,'MOST_RCNT_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TERM_DATE"','20','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','20',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE_OF_LST_SLY_CHG"','21','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','21',NULL,'DATE_OF_LST_SLY_CHG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','22','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','22',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','23','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','23',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','24','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','24',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','25','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','25',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','26','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','26',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','27','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','27',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','28','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','28',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_BEN_AMT"','29','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','29',NULL,'EE_BEN_AMT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI_SP_IND"','30','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','30',NULL,'CI_SP_IND',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_SP_COVG"','31','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','31',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP_COVG_TERM_DATE"','32','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','32',NULL,'SP_COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_CH_COVG"','33','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','33',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH_COVG_TERM_DATE"','34','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','34',NULL,'CH_COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRODUCT"','35','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','35',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_NBR"','36','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'POLICY_NBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','37','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY_ELG_GRP"','38','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'POLICY_ELG_GRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHOICE"','39','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_EE_COVG"','40','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'EFF_DATE_OF_EE_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVG_TERM_DATE"','41','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_BEN_AMT"','42','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'EE_BEN_AMT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI_SP_IND"','43','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'CI_SP_IND',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_SP_COVG"','44','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'EFF_DATE_OF_SP_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP_COVG_TERM_DATE"','45','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'SP_COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFF_DATE_OF_CH_COVG"','46','(''DA''=''T,'')','ENORUNUACCZ0','50','H','01','36',NULL,'EFF_DATE_OF_CH_COVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH_COVG_TERM_DATE"','47','(''DA''=''T'')','ENORUNUACCZ0','50','H','01','36',NULL,'CH_COVG_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVPARTNERCASEID"','1','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','1',NULL,'PARTNERCASEID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVSERVICEINDICATOR"','2','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','2',NULL,'SERVICEINDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEESSN"','3','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','3',NULL,'EESSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEMPNO"','4','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','4',NULL,'EEID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEEIDTYPE"','5','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','5',NULL,'EEIDTYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEEFIRSTNAME"','6','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','6',NULL,'EEFIRSTNAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEEMIDDLEINITIAL"','7','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','7',NULL,'EEMIDDLEINITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEELASTNAME"','8','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','8',NULL,'EELASTNAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEESTADDR1"','9','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','9',NULL,'EESTADDR1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEESTADDR2"','10','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','10',NULL,'EESTADDR2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEECITY"','11','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','11',NULL,'EECITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEERDCSTPVC"','12','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','12',NULL,'EERDCSTPVC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEEPOSTALCD"','13','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','13',NULL,'EEPOSTALCD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEECNTRYCD"','14','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','14',NULL,'EECNTRYCD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEEDOB"','15','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','15',NULL,'EEDOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVSPDOB"','16','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','16',NULL,'SPDOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEEGENDER"','17','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','17',NULL,'EEGENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEETOBACCOUSE"','18','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','18',NULL,'EETOBACCOUSE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVMOSTRCNTHIREDATE"','19','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','19',NULL,'MOSTRCNTHIREDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEETERMDATE"','20','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','20',NULL,'EETERMDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVDATEOFLSTSLYCHG"','21','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','21',NULL,'DATEOFLSTSLYCHG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVPRODUCT"','22','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','22',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVPOLICYNBR"','23','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','23',NULL,'POLICYNBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVDIVISION"','24','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','24',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVPOLICYELGGRP"','25','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','25',NULL,'POLICYELGGRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVCHOICE"','26','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','26',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEFFDATEOFEECOVG"','27','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','27',NULL,'EFFDATEOFEECOVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVCOVGTERMDATE"','28','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','28',NULL,'COVGTERMDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEEBENAMT"','29','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','29',NULL,'EEBENAMT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVCISPIND"','30','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','30',NULL,'CISPIND',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEFFDATEOFSPCOVG"','31','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','31',NULL,'EFFDATEOFSPCOVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVSPCOVGTERMDATE"','32','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','32',NULL,'SPCOVGTERMDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEFFDATEOFCHCOVG"','33','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','33',NULL,'EFFDATEOFCHCOVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVCHCOVGTERMDATE"','34','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','34',NULL,'CHCOVGTERMDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVPRODUCT2"','35','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','35',NULL,'PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVPOLICYNBR2"','36','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'POLICYNBR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVDIVISION2"','37','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVPOLICYELGGRP2"','38','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'POLICYELGGRP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVCHOICE2"','39','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'CHOICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEFFDATEOFEECOVG2"','40','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'EFFDATEOFEECOVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVCOVGTERMDATE2"','41','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'COVGTERMDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEEBENAMT2"','42','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'EEBENAMT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVCISPIND2"','43','(''UA''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'CISPIND',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEFFDATEOFSPCOVG2"','44','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'EFFDATEOFSPCOVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVSPCOVGTERMDATE2"','45','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'SPCOVGTERMDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVEFFDATEOFCHCOVG2"','46','(''UD101''=''T,'')','ENORUNUACCZ0','50','D','10','36',NULL,'EFFDATEOFCHCOVG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DRVCHCOVGTERMDATE2"','47','(''UD101''=''T'')','ENORUNUACCZ0','50','D','10','36',NULL,'CHCOVGTERMDATE',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ENORUNUACC_20210717.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ADP 401K Ondemand','202106239','EMPEXPORT','ONDEM_XOE',NULL,'ENORUNUACC',NULL,NULL,NULL,'202106239','Jun 23 2021  3:02PM','Jun 23 2021  3:02PM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ADP 401K Scheduled','202106239','EMPEXPORT','SCH_CRIEX',NULL,'ENORUNUACC',NULL,NULL,NULL,'202106239','Jun 23 2021  3:02PM','Jun 23 2021  3:02PM','202106231',NULL,'','','202106231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','5OW77,5OWIV,UXFZ7,5OWM2',NULL,NULL,NULL,'Accident and Critical Export','202107169','EMPEXPORT','TEST_XOE','Jul 17 2021  1:42PM','ENORUNUACC',NULL,NULL,NULL,'202107169','Jul 16 2021 12:00AM','Dec 30 1899 12:00AM','202107021','63','','','202107021',dbo.fn_GetTimedKey(),NULL,'us3mLaNOR1009',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENORUNUACC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENORUNUACC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENORUNUACC','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENORUNUACC','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENORUNUACC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENORUNUACC','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ENORUNUACC' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ENORUNUACC' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ENORUNUACC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENORUNUACC_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENORUNUACC','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENORUNUACC','D10','dbo.U_ENORUNUACC_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ENORUNUACC') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ENORUNUACC] (
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
IF OBJECT_ID('U_ENORUNUACC_DedList') IS NULL
CREATE TABLE [dbo].[U_ENORUNUACC_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ENORUNUACC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ENORUNUACC_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [DRVPARTNERCASEID] varchar(10) NOT NULL,
    [DRVSERVICEINDICATOR] varchar(3) NOT NULL,
    [DRVEESSN] char(11) NULL,
    [DRVEMPNO] char(9) NULL,
    [DRVEEIDTYPE] varchar(4) NOT NULL,
    [DRVEEFIRSTNAME] varchar(100) NULL,
    [DRVEEMIDDLEINITIAL] varchar(1) NULL,
    [DRVEELASTNAME] varchar(100) NULL,
    [DRVEESTADDR1] varchar(255) NULL,
    [DRVEESTADDR2] varchar(255) NULL,
    [DRVEECITY] varchar(255) NULL,
    [DRVEERDCSTPVC] varchar(255) NULL,
    [DRVEEPOSTALCD] varchar(50) NULL,
    [DRVEECNTRYCD] varchar(2) NOT NULL,
    [DRVEEDOB] datetime NULL,
    [DRVSPDOB] datetime NULL,
    [DRVEEGENDER] char(1) NULL,
    [DRVEETOBACCOUSE] varchar(1) NOT NULL,
    [DRVMOSTRCNTHIREDATE] datetime NULL,
    [DRVEETERMDATE] datetime NULL,
    [DRVDATEOFLSTSLYCHG] datetime NULL,
    [DRVPRODUCT] varchar(3) NULL,
    [DRVPOLICYNBR] varchar(6) NULL,
    [DRVDIVISION] varchar(1) NULL,
    [DRVPOLICYELGGRP] varchar(1) NULL,
    [DRVCHOICE] varchar(1) NULL,
    [DRVEFFDATEOFEECOVG] datetime NULL,
    [DRVCOVGTERMDATE] datetime NULL,
    [DRVEEBENAMT] varchar(256) NULL,
    [DRVCISPIND] varchar(1) NULL,
    [DRVEFFDATEOFSPCOVG] datetime NULL,
    [DRVSPCOVGTERMDATE] datetime NULL,
    [DRVEFFDATEOFCHCOVG] varchar(1) NOT NULL,
    [DRVCHCOVGTERMDATE] varchar(1) NOT NULL,
    [DRVPRODUCT2] varchar(3) NULL,
    [DRVPOLICYNBR2] varchar(6) NULL,
    [DRVDIVISION2] varchar(1) NULL,
    [DRVPOLICYELGGRP2] varchar(1) NULL,
    [DRVCHOICE2] varchar(1) NULL,
    [DRVEFFDATEOFEECOVG2] datetime NULL,
    [DRVCOVGTERMDATE2] datetime NULL,
    [DRVEEBENAMT2] varchar(1) NOT NULL,
    [DRVCISPIND2] varchar(1) NOT NULL,
    [DRVEFFDATEOFSPCOVG2] datetime NULL,
    [DRVSPCOVGTERMDATE2] datetime NULL,
    [DRVEFFDATEOFCHCOVG2] datetime NULL,
    [DRVCHCOVGTERMDATE2] datetime NULL
);
IF OBJECT_ID('U_ENORUNUACC_EEList') IS NULL
CREATE TABLE [dbo].[U_ENORUNUACC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ENORUNUACC_File') IS NULL
CREATE TABLE [dbo].[U_ENORUNUACC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_ENORUNUACC_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ENORUNUACC_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhPreTax] numeric NULL,
    [Pdh401M] numeric NULL,
    [PdhRoth] numeric NULL,
    [PdhLoan1] numeric NULL,
    [PdhLoan2] numeric NULL,
    [PdhPlanComp] numeric NULL,
    [PdhPlanCompYTD] numeric NULL
);
IF OBJECT_ID('U_ENORUNUACC_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ENORUNUACC_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENORUNUACC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: North Ottawa Community Hospital

Created By: Marco Lagrosa
Business Analyst: Cheryl Petiti
Create Date: 07/15/2021
Service Request Number: TekP-2021-05-17-0001

Purpose: Accident and Critical Illness Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENORUNUACC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENORUNUACC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENORUNUACC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ENORUNUACC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENORUNUACC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENORUNUACC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENORUNUACC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENORUNUACC', 'SCH_ADPEX';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENORUNUACC';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ENORUNUACC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ENORUNUACC';

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
    DELETE FROM dbo.U_ENORUNUACC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENORUNUACC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ENORUNUACC_EEList
    WHERE xEEID IN (SELECT Eepeeid from dbo.EmpPers WITH (NOLOCK) where eepssn in ('999999902','123541234') ) ;
    --==========================================
    
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CIE10,CIE15,CIE20,CIS5K,CIS10,CIS75,UACC'; 

    IF OBJECT_ID('U_ENORUNUACC_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENORUNUACC_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ENORUNUACC_DedList
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
    
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS, DP');

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','DPC, DCH, CHL, STC');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    --=========================================

    -- Update BdmChangeReason For Dependents

    --=========================================

    UPDATE D

        SET D.BdmChangeReason = E.BdmChangeReason

    FROM dbo.U_dsi_bdm_ENORUNUACC D

    JOIN dbo.U_dsi_bdm_ENORUNUACC E

        ON E.BdmEEID = D.BdmEEID

        AND E.BdmCOID = D.BdmCOID

        AND E.BdmDedCode = D.BdmDedCode

    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';



    --=====================================================

    -- Update BdmUSGField2 with EmpDedTVID for Employees

    --=====================================================

    UPDATE dbo.U_dsi_bdm_ENORUNUACC

        SET BdmUSGField2 = EedEmpDedTVID
         ,BdmUSGField1 = DedEEBenAmt

    FROM dbo.U_dsi_bdm_ENORUNUACC

    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)

        ON EedEEID = BdmEEID

        AND EedCOID = BdmCOID

        AND EedDedCode = BdmDedCode

    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';



    --=======================================================

    -- Update BdmUSGField2 with DepBPlanTVID for Dependents

    --=======================================================

    UPDATE dbo.U_dsi_bdm_ENORUNUACC

        SET BdmUSGField2 = DbnDepBPlanTVID

    FROM dbo.U_dsi_bdm_ENORUNUACC

    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)

        ON DbnEEID = BdmEEID

        AND DbnCOID = BdmCOID

        AND DbnDedCode = BdmDedCode

    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';



    --======================================================

    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)

    --======================================================



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ENORUNUACC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ENORUNUACC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENORUNUACC_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,DRVPARTNERCASEID = 'NOR-025362'
        ,DRVSERVICEINDICATOR = 'ELG'
        ,DRVEESSN = eepSSN
        ,DRVEMPNO = EecEmpNo
        ,DRVEEIDTYPE = 'EEID'
        ,DRVEEFIRSTNAME  = eepNameFirst
        ,DRVEEMIDDLEINITIAL = LEFT(eepNameMiddle,1)
        ,DRVEELASTNAME = eepNameLast 
        ,DRVEESTADDR1 =  EepAddressLine1
        ,DRVEESTADDR2 =  EepAddressLine2
        ,DRVEECITY = EepAddressCity
        ,DRVEERDCSTPVC = EepAddressState 
        ,DRVEEPOSTALCD = EepAddressZipCode 
        ,DRVEECNTRYCD = 'US'
        ,DRVEEDOB = EepDateofBirth
        ,DRVSPDOB = CASE WHEN SPOUSE_DOB is not null then (Select top 1 ConDateofBirth from dbo.Contacts WITH (NOLOCK) where consystemid = SPOUSE_DOB) END
        ,DRVEEGENDER = EepGender
        ,DRVEETOBACCOUSE = ''
        ,DRVMOSTRCNTHIREDATE = eecdateoflasthire
        ,DRVEETERMDATE = CASE WHEN eecEmplStatus = 'T' THEN EecDateofTermination END
        ,DRVDATEOFLSTSLYCHG =  dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, GETDATE(),EecDateOfLastHire)
        ,DRVPRODUCT = CASE WHEN PRODUCT1 is not null then '822' END
        ,DRVPOLICYNBR = CASE WHEN PRODUCT1 is not null then '446710' END
        ,DRVDIVISION = CASE WHEN PRODUCT1 is not null then '1' END
        ,DRVPOLICYELGGRP = CASE WHEN PRODUCT1 is not null then 
                                    CASE WHEN eecDedGroupCode in ('CONFT', 'CONPT', 'HCEFT', 'HCEPT') THEN '1' ELSE '2' END
                           END
        ,DRVCHOICE = CASE WHEN PRODUCT1 IN ('CIE10') THEN '1'
                          WHEN PRODUCT1 IN ('CIE15') THEN '2'
                          WHEN PRODUCT1 IN ('CIE20') THEN '3'
                     END
        ,DRVEFFDATEOFEECOVG = CASE WHEN PRODUCT1 is not null then PRODUCT1_STARTDATE END
        ,DRVCOVGTERMDATE = CASE WHEN PRODUCT1 is not null then PRODUCT1_STOPDATE END
        ,DRVEEBENAMT = CASE WHEN PRODUCT1 is not null then PRODUCT1_Amt END 
        ,DRVCISPIND = CASE WHEN SPOUSE_DOB is not null then 'Y' END
        ,DRVEFFDATEOFSPCOVG = CASE WHEN SPOUSE_DOB is not null then SPOUSE_STARTDATE END 
        ,DRVSPCOVGTERMDATE =  CASE WHEN SPOUSE_DOB is not null then SPOUSE_STOPDATE END 
        ,DRVEFFDATEOFCHCOVG = '' 
        ,DRVCHCOVGTERMDATE = '' 
        ,DRVPRODUCT2 =  CASE WHEN PRODUCT2 is not null then '824' END
        ,DRVPOLICYNBR2 =  CASE WHEN PRODUCT2 is not null then '446709' END
        ,DRVDIVISION2 =  CASE WHEN PRODUCT2 is not null then '1' END
        ,DRVPOLICYELGGRP2 = CASE WHEN PRODUCT2 is not null then 
                                    CASE WHEN eecDedGroupCode in ('CONFT', 'CONPT', 'HCEFT', 'HCEPT') THEN '1' ELSE '2' END
                           END
        ,DRVCHOICE2 = CASE WHEN PRODUCT2 is not null then '1' END
        ,DRVEFFDATEOFEECOVG2 = CASE WHEN PRODUCT2 is not null then PRODUCT2_STARTDATE END
        ,DRVCOVGTERMDATE2 = CASE WHEN PRODUCT2 is not null then PRODUCT2_STOPDATE END
        ,DRVEEBENAMT2 = '' 
        ,DRVCISPIND2 = '' 
        ,DRVEFFDATEOFSPCOVG2 = PRODUCT3_STARTDATE 
        ,DRVSPCOVGTERMDATE2 = PRODUCT3_STOPDATE
        ,DRVEFFDATEOFCHCOVG2 = PRODUCT4_STARTDATE
        ,DRVCHCOVGTERMDATE2 = PRODUCT4_STOPDATE
    INTO dbo.U_ENORUNUACC_drvTbl
    FROM dbo.U_ENORUNUACC_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select  bdmEEID,bdmcoid
            ,PRODUCT1 = MAX((CASE WHEN bdmDedCode IN('CIE10', 'CIE15', 'CIE20') then bdmDedCode END))
            ,PRODUCT2 = MAX((CASE WHEN bdmDedCode IN('UACC')  and bdmrectype = 'EMP' then 'PRODUCT2' END))
            ,PRODUCT3_STARTDATE = MAX((CASE WHEN bdmDedCode IN('UACC')  and bdmrelationship = 'SPS' then BdmBenStartDate END))
            ,PRODUCT4_STARTDATE = MAX((CASE WHEN bdmDedCode IN('UACC')  and bdmrelationship = 'CHD' then BdmBenStartDate END))
            ,PRODUCT3_STOPDATE = MAX((CASE WHEN bdmDedCode IN('UACC')  and bdmrelationship = 'SPS' then BdmBenStopDate END))
            ,PRODUCT4_STOPDATE = MAX((CASE WHEN bdmDedCode IN('UACC')  and bdmrelationship = 'CHD' then BdmBenStopDate END))

            ,SPOUSE_DOB = MAX((CASE WHEN bdmDedCode IN ('CIS5K', 'CIS10', 'CIS75') then BdmDepRecID END))
            ,PRODUCT1_STARTDATE = MAX((CASE WHEN bdmDedCode IN('CIE10', 'CIE15', 'CIE20') then BdmBenStartDate END))
            ,PRODUCT2_STARTDATE = MAX((CASE WHEN bdmDedCode IN('UACC') then BdmBenStartDate END))
            ,SPOUSE_STARTDATE = MAX((CASE WHEN bdmDedCode IN('CIS5K', 'CIS10', 'CIS75') then BdmBenStartDate END))

            ,PRODUCT1_STOPDATE = MAX((CASE WHEN bdmDedCode IN('CIE10', 'CIE15', 'CIE20') then BdmBenStopDate END))
            ,PRODUCT2_STOPDATE = MAX((CASE WHEN bdmDedCode IN('UACC') then BdmBenStopDate END))
            ,SPOUSE_STOPDATE = MAX((CASE WHEN bdmDedCode IN('CIS5K', 'CIS10', 'CIS75') then BdmBenStopDate END))

            ,PRODUCT1_Amt = MAX((CASE WHEN bdmDedCode IN('CIE10', 'CIE15', 'CIE20') then bdmusgfield1 END))
            ,PRODUCT2_AMT = MAX((CASE WHEN bdmDedCode IN('UACC') then bdmusgfield1 END))

            from U_dsi_BDM_ENORUNUACC  WITH (NOLOCK) 
            group by bdmEEID,bdmcoid) as BdmConsolidated
        ON xEEID =  bdmEEID 
        AND XCOID = bdmCOID
    
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
ALTER VIEW dbo.dsi_vwENORUNUACC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ENORUNUACC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ENORUNUACC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106161'
       ,expStartPerControl     = '202106161'
       ,expLastEndPerControl   = '202106239'
       ,expEndPerControl       = '202106239'
WHERE expFormatCode = 'ENORUNUACC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENORUNUACC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ENORUNUACC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort