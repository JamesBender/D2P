SET NOCOUNT ON;
IF OBJECT_ID('U_ETRUSTKWPM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ETRUSTKWPM_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ETRUSTKWPM' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwETRUSTKWPM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwETRUSTKWPM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ETRUSTKWPM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRUSTKWPM];
GO
IF OBJECT_ID('U_ETRUSTKWPM_Tier') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_Tier];
GO
IF OBJECT_ID('U_ETRUSTKWPM_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_PEarHist];
GO
IF OBJECT_ID('U_ETRUSTKWPM_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_PDedHist];
GO
IF OBJECT_ID('U_ETRUSTKWPM_File') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_File];
GO
IF OBJECT_ID('U_ETRUSTKWPM_EEList') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_EEList];
GO
IF OBJECT_ID('U_ETRUSTKWPM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_drvTbl];
GO
IF OBJECT_ID('U_ETRUSTKWPM_DepLoop') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_DepLoop];
GO
IF OBJECT_ID('U_ETRUSTKWPM_DedList') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_DedList];
GO
IF OBJECT_ID('U_ETRUSTKWPM_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_AuditFields];
GO
IF OBJECT_ID('U_ETRUSTKWPM_Audit') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ETRUSTKWPM') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ETRUSTKWPM];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ETRUSTKWPM';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ETRUSTKWPM';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ETRUSTKWPM';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ETRUSTKWPM';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ETRUSTKWPM';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ETRUSTKWPM','Trustmark Critical Illness Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','22000','S','N','ETRUSTKWPMZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ETRUSTKWPM' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATA_SET_INSTANCE_ID"','1','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','1',NULL,'DATA_SET_INSTANCE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GROUP_ID"','2','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','2',NULL,'GROUP_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"APPLICATION_IGO"','3','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','3',NULL,'APPLICATION_IGO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRANS_TYPE"','4','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','4',NULL,'TRANS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_FIRST_NAME"','5','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','5',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_MIDDLE_NAME"','6','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','6',NULL,'EE_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LAST_NAME"','7','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','7',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SSN"','8','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','8',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SUBSCRIBER_ID"','9','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','9',NULL,'EE_SUBSCRIBER_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_DOB"','10','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','10',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_DOD"','11','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','11',NULL,'EE_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_PREFIX"','12','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','12',NULL,'EE_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SUFFIX"','13','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','13',NULL,'EE_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_GENDER"','14','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','14',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LANGUAGE_PREFERENCE"','15','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','15',NULL,'EE_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_MARITAL_STATUS"','16','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','16',NULL,'EE_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_STATUS"','17','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','17',NULL,'EE_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HOME_PHONE"','18','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','18',NULL,'EE_HOME_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CELL_PHONE"','19','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','19',NULL,'EE_CELL_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WORK_PHONE"','20','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','20',NULL,'EE_WORK_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WORK_EXT"','21','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','21',NULL,'EE_WORK_EXT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_EMAIL"','22','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','22',NULL,'EE_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WORK_EMAIL"','23','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','23',NULL,'EE_WORK_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_TYPE"','24','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','24',NULL,'EE_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_LINE_1"','25','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','25',NULL,'EE_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_LINE_2"','26','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','26',NULL,'EE_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_LINE_3"','27','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','27',NULL,'EE_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CITY"','28','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','28',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_STATE"','29','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','29',NULL,'EE_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ZIP"','30','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','30',NULL,'EE_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_COUNTRY"','31','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','31',NULL,'EE_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_EFF_DATE"','32','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','32',NULL,'EE_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_SOURCE"','33','(''DA''=''T,'')','ETRUSTKWPMZ0','50','H','01','33',NULL,'EE_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ACCOUNT_ID"','34','(''DA''=''T,'')','ETRUSTKWPMZ0','51','H','01','34',NULL,'EE_ACCOUNT_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LOCATION_ID"','35','(''DA''=''T,'')','ETRUSTKWPMZ0','52','H','01','35',NULL,'EE_LOCATION_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_EMPLOYEE_ID"','36','(''DA''=''T,'')','ETRUSTKWPMZ0','53','H','01','36',NULL,'EE_EMPLOYEE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HIRE_DATE"','37','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','37',NULL,'EE_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TERM_DATE"','38','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','38',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TERM_REASON"','39','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','39',NULL,'EE_TERM_REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_PAYROLL_CYCLE"','40','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','40',NULL,'EE_PAYROLL_CYCLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HOURS_PER_WEEK"','41','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','41',NULL,'EE_HOURS_PER_WEEK',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SORT_GROUP"','42','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','42',NULL,'EE_SORT_GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_01_CLASS_CODE"','43','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','43',NULL,'EE_CLASS_01_CLASS_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_01_PRODUCT"','44','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','44',NULL,'EE_CLASS_01_PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_01_START_DATE"','45','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','45',NULL,'EE_CLASS_01_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_01_STOP_DATE"','46','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','46',NULL,'EE_CLASS_01_STOP_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_02_CLASS_CODE"','47','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','47',NULL,'EE_CLASS_02_CLASS_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_02_PRODUCT"','48','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','48',NULL,'EE_CLASS_01_PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_02_START_DATE"','49','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','49',NULL,'EE_CLASS_02_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_02_STOP_DATE"','50','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','50',NULL,'EE_CLASS_02_STOP_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_03_CLASS_CODE"','51','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','51',NULL,'EE_CLASS_03_CLASS_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_03_PRODUCT"','52','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','52',NULL,'EE_CLASS_01_PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_03_START_DATE"','53','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','53',NULL,'EE_CLASS_03_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_03_STOP_DATE"','54','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','54',NULL,'EE_CLASS_03_STOP_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CERT_NUM"','55','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','55',NULL,'CERT_NUM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_CODE"','56','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','56',NULL,'PLAN_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BILLING_GROUP"','57','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','57',NULL,'BILLING_GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TIER"','58','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','58',NULL,'TIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EVENT_DATE"','59','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','59',NULL,'EVENT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"APPLICATION_SIGN_DATE"','60','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','60',NULL,'APPLICATION_SIGN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFFECTIVE_DATE"','61','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','61',NULL,'EFFECTIVE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ISSUED_AGE"','62','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','62',NULL,'ISSUED_AGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_BENEFIT_AMT"','63','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','63',NULL,'PRIMARY_BENEFIT_AMT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_BENEFIT_AMT"','64','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','64',NULL,'SPOUSE_BENEFIT_AMT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHILD_BENEFIT_AMT"','65','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','65',NULL,'CHILD_BENEFIT_AMT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_SMOKER_STATUS"','66','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','66',NULL,'PRIMARY_SMOKER_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_SMOKER_STATUS"','67','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','67',NULL,'SPOUSE_SMOKER_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EOI_BYPASS"','68','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','68',NULL,'EOI_BYPASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_HEIGHT_FT"','69','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','69',NULL,'PRIMARY_HEIGHT_FT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_HEIGHT_IN"','70','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','70',NULL,'PRIMARY_HEIGHT_IN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_WEIGHT"','71','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','71',NULL,'PRIMARY_WEIGHT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO1"','72','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','72',NULL,'PRIMARY_KO1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO2"','73','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','73',NULL,'PRIMARY_KO2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO3"','74','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','74',NULL,'PRIMARY_KO3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO4"','75','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','75',NULL,'PRIMARY_KO4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO5"','76','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','76',NULL,'PRIMARY_KO5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO6"','77','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','77',NULL,'PRIMARY_KO6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_HEIGHT_FT"','78','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','78',NULL,'SPOUSE_HEIGHT_FT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_HEIGHT_IN"','79','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','79',NULL,'SPOUSE_HEIGHT_IN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_WEIGHT"','80','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','80',NULL,'SPOUSE_WEIGHT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO1"','81','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','81',NULL,'SPOUSE_KO1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO2"','82','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','82',NULL,'SPOUSE_KO2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO3"','83','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','83',NULL,'SPOUSE_KO3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO4"','84','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','84',NULL,'SPOUSE_KO4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO5"','85','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','85',NULL,'SPOUSE_KO5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO6"','86','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','86',NULL,'SPOUSE_KO6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TOTAL_NUM_DEPENDENTS"','87','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','87',NULL,'TOTAL_NUM_DEPENDENTS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_FIRST_NAME"','88','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','88',NULL,'DEP1_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_MIDDLE_NAME"','89','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','89',NULL,'DEP1_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_LAST_NAME"','90','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','90',NULL,'DEP1_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_UNIQUE_ID"','91','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','91',NULL,'DEP1_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_SSN"','92','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','92',NULL,'DEP1_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DOB"','93','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','93',NULL,'DEP1_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DOD"','94','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','94',NULL,'DEP1_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_PREFIX"','95','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','95',NULL,'DEP1_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_SUFFIX"','96','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','96',NULL,'DEP1_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_GENDER"','97','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','97',NULL,'DEP1_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_LANGUAGE_PREFERENCE"','98','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','98',NULL,'DEP1_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_MARITAL_STATUS"','99','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','99',NULL,'DEP1_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_MARRIAGE_DATE"','100','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','100',NULL,'DEP1_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DIVORCE_DATE"','101','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','101',NULL,'DEP1_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_RELATION"','102','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','102',NULL,'DEP1_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DISABLED_INDIC"','103','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','103',NULL,'DEP1_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DISABLED_DATE"','104','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','104',NULL,'DEP1_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_STUDENT_INDIC"','105','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','105',NULL,'DEP1_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_TYPE"','106','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','106',NULL,'DEP1_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_LINE_1"','107','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','107',NULL,'DEP1_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_LINE_2"','108','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','108',NULL,'DEP1_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_LINE_3"','109','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','109',NULL,'DEP1_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_CITY"','110','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','110',NULL,'DEP1_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_STATE"','111','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','111',NULL,'DEP1_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ZIP"','112','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','112',NULL,'DEP1_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_COUNTRY"','113','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','113',NULL,'DEP1_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_EFF_DATE"','114','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','114',NULL,'DEP1_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_SOURCE"','115','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','115',NULL,'DEP1_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_FIRST_NAME"','116','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','116',NULL,'DEP2_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_MIDDLE_NAME"','117','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','117',NULL,'DEP2_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_LAST_NAME"','118','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','118',NULL,'DEP2_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_UNIQUE_ID"','119','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','119',NULL,'DEP2_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_SSN"','120','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','120',NULL,'DEP2_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DOB"','121','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','121',NULL,'DEP2_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DOD"','122','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','122',NULL,'DEP2_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_SUFFIX"','123','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','123',NULL,'DEP2_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_GENDER"','124','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','124',NULL,'DEP2_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_LANGUAGE_PREFERENCE"','125','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','125',NULL,'DEP2_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_MARITAL_STATUS"','126','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','126',NULL,'DEP2_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_MARRIAGE_DATE"','127','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','127',NULL,'DEP2_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DIVORCE_DATE"','128','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','128',NULL,'DEP2_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_RELATION"','129','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','129',NULL,'DEP2_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DISABLED_INDIC"','130','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','130',NULL,'DEP2_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DISABLED_DATE"','131','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','131',NULL,'DEP2_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_STUDENT_INDIC"','132','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','132',NULL,'DEP2_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_TYPE"','133','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','133',NULL,'DEP2_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_LINE_1"','134','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','134',NULL,'DEP2_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_LINE_2"','135','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','135',NULL,'DEP2_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_LINE_3"','136','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','136',NULL,'DEP2_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_CITY"','137','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','137',NULL,'DEP2_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_STATE"','138','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','138',NULL,'DEP2_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ZIP"','139','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','139',NULL,'DEP2_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_COUNTRY"','140','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','140',NULL,'DEP2_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_EFF_DATE"','141','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','141',NULL,'DEP2_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_SOURCE"','142','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','142',NULL,'DEP2_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_FIRST_NAME"','143','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','143',NULL,'DEP3_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_MIDDLE_NAME"','144','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','144',NULL,'DEP3_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_LAST_NAME"','145','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','145',NULL,'DEP3_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_UNIQUE_ID"','146','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','146',NULL,'DEP3_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_SSN"','147','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','147',NULL,'DEP3_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DOB"','148','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','148',NULL,'DEP3_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DOD"','149','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','149',NULL,'DEP3_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_PREFIX"','150','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','150',NULL,'DEP3_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_SUFFIX"','151','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','151',NULL,'DEP3_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_GENDER"','152','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','152',NULL,'DEP3_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_LANGUAGE_PREFERENCE"','153','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','153',NULL,'DEP3_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_MARITAL_STATUS"','154','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','154',NULL,'DEP3_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_MARRIAGE_DATE"','155','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','155',NULL,'DEP3_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DIVORCE_DATE"','156','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','156',NULL,'DEP3_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_RELATION"','157','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','157',NULL,'DEP3_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DISABLED_INDIC"','158','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','158',NULL,'DEP3_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DISABLED_DATE"','159','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','159',NULL,'DEP3_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_STUDENT_INDIC"','160','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','160',NULL,'DEP3_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_TYPE"','161','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','161',NULL,'DEP3_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_LINE_1"','162','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','162',NULL,'DEP3_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_LINE_2"','163','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','163',NULL,'DEP3_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_LINE_3"','164','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','164',NULL,'DEP3_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_CITY"','165','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','165',NULL,'DEP3_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_STATE"','166','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','166',NULL,'DEP3_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ZIP"','167','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','167',NULL,'DEP3_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_COUNTRY"','168','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','168',NULL,'DEP3_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_EFF_DATE"','169','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','169',NULL,'DEP3_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_SOURCE"','170','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','170',NULL,'DEP3_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_FIRST_NAME"','171','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','171',NULL,'DEP4_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_MIDDLE_NAME"','172','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','172',NULL,'DEP4_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_LAST_NAME"','173','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','173',NULL,'DEP4_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_UNIQUE_ID"','174','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','174',NULL,'DEP4_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_SSN"','175','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','175',NULL,'DEP4_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DOB"','176','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','176',NULL,'DEP4_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DOD"','177','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','177',NULL,'DEP4_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_PREFIX"','178','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','178',NULL,'DEP4_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_SUFFIX"','179','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','179',NULL,'DEP4_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_GENDER"','180','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','180',NULL,'DEP4_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_LANGUAGE_PREFERENCE"','181','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','181',NULL,'DEP4_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_MARITAL_STATUS"','182','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','182',NULL,'DEP4_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_MARRIAGE_DATE"','183','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','183',NULL,'DEP4_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DIVORCE_DATE"','184','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','184',NULL,'DEP4_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_RELATION"','185','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','185',NULL,'DEP4_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DISABLED_INDIC"','186','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','186',NULL,'DEP4_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DISABLED_DATE"','187','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','187',NULL,'DEP4_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_STUDENT_INDIC"','188','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','188',NULL,'DEP4_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_TYPE"','189','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','189',NULL,'DEP4_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_LINE_1"','190','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','190',NULL,'DEP4_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_LINE_2"','191','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','191',NULL,'DEP4_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_LINE_3"','192','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','192',NULL,'DEP4_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_CITY"','193','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','193',NULL,'DEP4_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_STATE"','194','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','194',NULL,'DEP4_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ZIP"','195','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','195',NULL,'DEP4_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_COUNTRY"','196','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','196',NULL,'DEP4_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_EFF_DATE"','197','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','197',NULL,'DEP4_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_SOURCE"','198','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','198',NULL,'DEP4_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_FIRST_NAME"','199','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','199',NULL,'DEP5_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_MIDDLE_NAME"','200','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','200',NULL,'DEP5_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_LAST_NAME"','201','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','201',NULL,'DEP5_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_UNIQUE_ID"','202','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','202',NULL,'DEP5_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_SSN"','203','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','203',NULL,'DEP5_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DOB"','204','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','204',NULL,'DEP5_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DOD"','205','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','205',NULL,'DEP5_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_PREFIX"','206','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','206',NULL,'DEP5_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_SUFFIX"','207','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','207',NULL,'DEP5_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_GENDER"','208','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','208',NULL,'DEP5_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_LANGUAGE_PREFERENCE"','209','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','209',NULL,'DEP5_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_MARITAL_STATUS"','210','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','210',NULL,'DEP5_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_MARRIAGE_DATE"','211','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','211',NULL,'DEP5_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DIVORCE_DATE"','212','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','212',NULL,'DEP5_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_RELATION"','213','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','213',NULL,'DEP5_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DISABLED_INDIC"','214','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','214',NULL,'DEP5_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DISABLED_DATE"','215','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','215',NULL,'DEP5_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_STUDENT_INDIC"','216','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','216',NULL,'DEP5_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_TYPE"','217','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','217',NULL,'DEP5_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_LINE_1"','218','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','218',NULL,'DEP5_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_LINE_2"','219','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','219',NULL,'DEP5_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_LINE_3"','220','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','220',NULL,'DEP5_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_CITY"','221','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','221',NULL,'DEP5_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_STATE"','222','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','222',NULL,'DEP5_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ZIP"','223','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','223',NULL,'DEP5_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_COUNTRY"','224','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','224',NULL,'DEP5_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_EFF_DATE"','225','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','225',NULL,'DEP5_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_SOURCE"','226','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','226',NULL,'DEP5_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_FIRST_NAME"','227','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','227',NULL,'DEP6_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_MIDDLE_NAME"','228','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','228',NULL,'DEP6_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_LAST_NAME"','229','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','229',NULL,'DEP6_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_UNIQUE_ID"','230','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','230',NULL,'DEP6_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_SSN"','231','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','231',NULL,'DEP6_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DOB"','232','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','232',NULL,'DEP6_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DOD"','233','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','233',NULL,'DEP6_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_PREFIX"','234','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','234',NULL,'DEP6_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_SUFFIX"','235','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','235',NULL,'DEP6_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_GENDER"','236','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','236',NULL,'DEP6_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_LANGUAGE_PREFERENCE"','237','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','237',NULL,'DEP6_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_MARITAL_STATUS"','238','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','238',NULL,'DEP6_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_MARRIAGE_DATE"','239','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','239',NULL,'DEP6_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DIVORCE_DATE"','240','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','240',NULL,'DEP6_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_RELATION"','241','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','241',NULL,'DEP6_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DISABLED_INDIC"','242','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','242',NULL,'DEP6_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DISABLED_DATE"','243','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','243',NULL,'DEP6_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_STUDENT_INDIC"','244','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','244',NULL,'DEP6_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_TYPE"','245','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','245',NULL,'DEP6_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_LINE_1"','246','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','246',NULL,'DEP6_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_LINE_2"','247','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','247',NULL,'DEP6_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_LINE_3"','248','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','248',NULL,'DEP6_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_CITY"','249','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','249',NULL,'DEP6_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_STATE"','250','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','250',NULL,'DEP6_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ZIP"','251','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','251',NULL,'DEP6_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_COUNTRY"','252','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','252',NULL,'DEP6_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_EFF_DATE"','253','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','253',NULL,'DEP6_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_SOURCE"','254','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','254',NULL,'DEP6_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_FIRST_NAME"','255','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','255',NULL,'DEP7_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_MIDDLE_NAME"','256','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','256',NULL,'DEP7_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_LAST_NAME"','257','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','257',NULL,'DEP7_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_UNIQUE_ID"','258','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','258',NULL,'DEP7_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_SSN"','259','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','259',NULL,'DEP7_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DOB"','260','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','260',NULL,'DEP7_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DOD"','261','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','261',NULL,'DEP7_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_PREFIX"','262','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','262',NULL,'DEP7_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_SUFFIX"','263','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','263',NULL,'DEP7_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_GENDER"','264','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','264',NULL,'DEP7_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_LANGUAGE_PREFERENCE"','265','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','265',NULL,'DEP7_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_MARITAL_STATUS"','266','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','266',NULL,'DEP7_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_MARRIAGE_DATE"','267','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','267',NULL,'DEP7_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DIVORCE_DATE"','268','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','268',NULL,'DEP7_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_RELATION"','269','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','269',NULL,'DEP7_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DISABLED_INDIC"','270','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','270',NULL,'DEP7_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DISABLED_DATE"','271','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','271',NULL,'DEP7_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_STUDENT_INDIC"','272','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','272',NULL,'DEP7_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_TYPE"','273','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','273',NULL,'DEP7_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_LINE_1"','274','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','274',NULL,'DEP7_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_LINE_2"','275','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','275',NULL,'DEP7_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_LINE_3"','276','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','276',NULL,'DEP7_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_CITY"','277','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','277',NULL,'DEP7_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_STATE"','278','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','278',NULL,'DEP7_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ZIP"','279','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','279',NULL,'DEP7_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_COUNTRY"','280','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','280',NULL,'DEP7_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_EFF_DATE"','281','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','281',NULL,'DEP7_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_SOURCE"','282','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','282',NULL,'DEP7_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_FIRST_NAME"','283','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','283',NULL,'DEP7_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_MIDDLE_NAME"','284','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','284',NULL,'DEP7_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_LAST_NAME"','285','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','285',NULL,'DEP7_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_UNIQUE_ID"','286','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','286',NULL,'DEP7_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_SSN"','287','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','287',NULL,'DEP7_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DOB"','288','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','288',NULL,'DEP7_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DOD"','289','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','289',NULL,'DEP7_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_PREFIX"','290','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','290',NULL,'DEP7_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_SUFFIX"','291','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','291',NULL,'DEP7_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_GENDER"','292','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','292',NULL,'DEP7_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_LANGUAGE_PREFERENCE"','293','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','293',NULL,'DEP7_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_MARITAL_STATUS"','294','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','294',NULL,'DEP7_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_MARRIAGE_DATE"','295','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','295',NULL,'DEP7_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DIVORCE_DATE"','296','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','296',NULL,'DEP7_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_RELATION"','297','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','297',NULL,'DEP7_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DISABLED_INDIC"','298','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','298',NULL,'DEP7_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DISABLED_DATE"','299','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','299',NULL,'DEP7_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_STUDENT_INDIC"','300','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','300',NULL,'DEP7_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_TYPE"','301','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','301',NULL,'DEP7_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_LINE_1"','302','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','302',NULL,'DEP7_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_LINE_2"','303','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','303',NULL,'DEP7_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_LINE_3"','304','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','304',NULL,'DEP7_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_CITY"','305','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','305',NULL,'DEP7_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_STATE"','306','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','306',NULL,'DEP7_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ZIP"','307','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','307',NULL,'DEP7_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_COUNTRY"','308','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','308',NULL,'DEP7_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_EFF_DATE"','309','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','309',NULL,'DEP7_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_SOURCE"','310','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','310',NULL,'DEP7_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_FIRST_NAME"','311','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','311',NULL,'DEP8_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_MIDDLE_NAME"','312','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','312',NULL,'DEP8_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_LAST_NAME"','313','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','313',NULL,'DEP8_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_UNIQUE_ID"','314','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','314',NULL,'DEP8_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_SSN"','315','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','315',NULL,'DEP8_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DOB"','316','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','316',NULL,'DEP8_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DOD"','317','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','317',NULL,'DEP8_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_PREFIX"','318','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','318',NULL,'DEP8_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_SUFFIX"','319','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','319',NULL,'DEP8_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_GENDER"','320','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','320',NULL,'DEP8_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_LANGUAGE_PREFERENCE"','321','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','321',NULL,'DEP8_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_MARITAL_STATUS"','322','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','322',NULL,'DEP8_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_MARRIAGE_DATE"','323','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','323',NULL,'DEP8_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DIVORCE_DATE"','324','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','324',NULL,'DEP8_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_RELATION"','325','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','325',NULL,'DEP8_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DISABLED_INDIC"','326','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','326',NULL,'DEP8_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DISABLED_DATE"','327','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','327',NULL,'DEP8_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_STUDENT_INDIC"','328','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','328',NULL,'DEP8_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_TYPE"','329','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','329',NULL,'DEP8_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_LINE_1"','330','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','330',NULL,'DEP8_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_LINE_2"','331','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','331',NULL,'DEP8_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_LINE_3"','332','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','332',NULL,'DEP8_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_CITY"','333','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','333',NULL,'DEP8_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_STATE"','334','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','334',NULL,'DEP8_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ZIP"','335','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','335',NULL,'DEP8_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_COUNTRY"','336','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','336',NULL,'DEP8_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_EFF_DATE"','337','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','337',NULL,'DEP8_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_SOURCE"','338','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','338',NULL,'DEP8_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_FIRST_NAME"','339','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','339',NULL,'DEP9_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_MIDDLE_NAME"','340','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','340',NULL,'DEP9_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_LAST_NAME"','341','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','341',NULL,'DEP9_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_UNIQUE_ID"','342','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','342',NULL,'DEP9_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_SSN"','343','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','343',NULL,'DEP9_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_DOB"','344','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','344',NULL,'DEP9_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_DOD"','345','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','345',NULL,'DEP9_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_PREFIX"','346','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','346',NULL,'DEP9_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_SUFFIX"','347','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','347',NULL,'DEP9_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_GENDER"','348','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','348',NULL,'DEP9_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_LANGUAGE_PREFERENCE"','349','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','349',NULL,'DEP9_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_MARITAL_STATUS"','350','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','350',NULL,'DEP9_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_MARRIAGE_DATE"','351','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','351',NULL,'DEP9_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_DIVORCE_DATE"','352','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','352',NULL,'DEP9_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_RELATION"','353','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','353',NULL,'DEP9_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_DISABLED_INDIC"','354','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','354',NULL,'DEP9_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_DISABLED_DATE"','355','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','355',NULL,'DEP9_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_STUDENT_INDIC"','356','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','356',NULL,'DEP9_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_TYPE"','357','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','357',NULL,'DEP9_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_LINE_1"','358','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','358',NULL,'DEP9_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_LINE_2"','359','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','359',NULL,'DEP9_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_LINE_3"','360','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','360',NULL,'DEP9_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_CITY"','361','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','361',NULL,'DEP9_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_STATE"','362','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','362',NULL,'DEP9_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ZIP"','363','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','363',NULL,'DEP9_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_COUNTRY"','364','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','364',NULL,'DEP9_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_EFF_DATE"','365','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','365',NULL,'DEP9_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_SOURCE"','366','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','366',NULL,'DEP9_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_FIRST_NAME"','367','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','367',NULL,'DEP10_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_MIDDLE_NAME"','368','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','368',NULL,'DEP10_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_LAST_NAME"','369','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','369',NULL,'DEP10_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_UNIQUE_ID"','370','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','370',NULL,'DEP10_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_SSN"','371','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','371',NULL,'DEP10_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_DOB"','372','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','372',NULL,'DEP10_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_DOD"','373','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','373',NULL,'DEP10_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_PREFIX"','374','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','374',NULL,'DEP10_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_SUFFIX"','375','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','375',NULL,'DEP10_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_GENDER"','376','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','376',NULL,'DEP10_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_LANGUAGE_PREFERENCE"','377','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','377',NULL,'DEP10_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_MARITAL_STATUS"','378','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','378',NULL,'DEP10_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_MARRIAGE_DATE"','379','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','379',NULL,'DEP10_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_DIVORCE_DATE"','380','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','380',NULL,'DEP10_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_RELATION"','381','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','381',NULL,'DEP10_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_DISABLED_INDIC"','382','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','382',NULL,'DEP10_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_DISABLED_DATE"','383','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','383',NULL,'DEP10_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_STUDENT_INDIC"','384','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','384',NULL,'DEP10_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_TYPE"','385','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','385',NULL,'DEP10_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_LINE_1"','386','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','386',NULL,'DEP10_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_LINE_2"','387','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','387',NULL,'DEP10_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_LINE_3"','388','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','388',NULL,'DEP10_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_CITY"','389','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','389',NULL,'DEP10_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_STATE"','390','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','390',NULL,'DEP10_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ZIP"','391','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','391',NULL,'DEP10_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_COUNTRY"','392','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','392',NULL,'DEP10_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_EFF_DATE"','393','(''DA''=''T,'')','ETRUSTKWPMZ0','54','H','01','393',NULL,'DEP10_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_SOURCE"','394','(''DA''=''T'')','ETRUSTKWPMZ0','54','H','01','394',NULL,'DEP10_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATA_SET_INSTANCE_ID"','1','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','1',NULL,'DATA_SET_INSTANCE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GROUP_ID"','2','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','2',NULL,'GROUP_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"APPLICATION_IGO"','3','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','3',NULL,'APPLICATION_IGO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRANS_TYPE"','4','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','4',NULL,'TRANS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_FIRST_NAME"','5','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','5',NULL,'EE_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_MIDDLE_NAME"','6','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','6',NULL,'EE_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LAST_NAME"','7','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','7',NULL,'EE_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SSN"','8','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','8',NULL,'EE_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SUBSCRIBER_ID"','9','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','9',NULL,'EE_SUBSCRIBER_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_DOB"','10','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','10',NULL,'EE_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_DOD"','11','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','11',NULL,'EE_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_PREFIX"','12','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','12',NULL,'EE_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SUFFIX"','13','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','13',NULL,'EE_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_GENDER"','14','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','14',NULL,'EE_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LANGUAGE_PREFERENCE"','15','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','15',NULL,'EE_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_MARITAL_STATUS"','16','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','16',NULL,'EE_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_STATUS"','17','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','17',NULL,'EE_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HOME_PHONE"','18','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','18',NULL,'EE_HOME_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CELL_PHONE"','19','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','19',NULL,'EE_CELL_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WORK_PHONE"','20','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','20',NULL,'EE_WORK_PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WORK_EXT"','21','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','21',NULL,'EE_WORK_EXT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_EMAIL"','22','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','22',NULL,'EE_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_WORK_EMAIL"','23','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','23',NULL,'EE_WORK_EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_TYPE"','24','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','24',NULL,'EE_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_LINE_1"','25','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','25',NULL,'EE_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_LINE_2"','26','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','26',NULL,'EE_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_LINE_3"','27','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','27',NULL,'EE_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CITY"','28','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','28',NULL,'EE_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_STATE"','29','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','29',NULL,'EE_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ZIP"','30','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','30',NULL,'EE_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_COUNTRY"','31','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','31',NULL,'EE_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_EFF_DATE"','32','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','32',NULL,'EE_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ADDRESS_SOURCE"','33','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','33',NULL,'EE_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_ACCOUNT_ID"','34','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','34',NULL,'EE_ACCOUNT_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_LOCATION_ID"','35','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','35',NULL,'EE_LOCATION_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_EMPLOYEE_ID"','36','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','36',NULL,'EE_EMPLOYEE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HIRE_DATE"','37','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','37',NULL,'EE_HIRE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TERM_DATE"','38','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','38',NULL,'EE_TERM_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_TERM_REASON"','39','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','39',NULL,'EE_TERM_REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_PAYROLL_CYCLE"','40','(''UA''=''Q,'')','ETRUSTKWPMZ0','54','D','10','40',NULL,'EE_PAYROLL_CYCLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_HOURS_PER_WEEK"','41','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','41',NULL,'EE_HOURS_PER_WEEK',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_SORT_GROUP"','42','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','42',NULL,'EE_SORT_GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_01_CLASS_CODE"','43','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','43',NULL,'EE_CLASS_01_CLASS_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_01_PRODUCT"','44','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','44',NULL,'EE_CLASS_01_PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_01_START_DATE"','45','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','45',NULL,'EE_CLASS_01_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_01_STOP_DATE"','46','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','46',NULL,'EE_CLASS_01_STOP_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_02_CLASS_CODE"','47','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','47',NULL,'EE_CLASS_02_CLASS_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_02_PRODUCT"','48','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','48',NULL,'EE_CLASS_01_PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_02_START_DATE"','49','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','49',NULL,'EE_CLASS_02_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_02_STOP_DATE"','50','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','50',NULL,'EE_CLASS_02_STOP_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_03_CLASS_CODE"','51','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','51',NULL,'EE_CLASS_03_CLASS_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_02_PRODUCT"','52','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','52',NULL,'EE_CLASS_01_PRODUCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_03_START_DATE"','53','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','53',NULL,'EE_CLASS_03_START_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE_CLASS_03_STOP_DATE"','54','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','54',NULL,'EE_CLASS_03_STOP_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CERT_NUM"','55','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','55',NULL,'CERT_NUM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_CODE"','56','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','56',NULL,'PLAN_CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BILLING_GROUP"','57','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','57',NULL,'BILLING_GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TIER"','58','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','58',NULL,'TIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EVENT_DATE"','59','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','59',NULL,'EVENT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"APPLICATION_SIGN_DATE"','60','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','60',NULL,'APPLICATION_SIGN_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFFECTIVE_DATE"','61','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','61',NULL,'EFFECTIVE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ISSUED_AGE"','62','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','62',NULL,'ISSUED_AGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_BENEFIT_AMT"','63','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','63',NULL,'PRIMARY_BENEFIT_AMT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_BENEFIT_AMT"','64','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','64',NULL,'SPOUSE_BENEFIT_AMT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHILD_BENEFIT_AMT"','65','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','65',NULL,'CHILD_BENEFIT_AMT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_SMOKER_STATUS"','66','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','66',NULL,'PRIMARY_SMOKER_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_SMOKER_STATUS"','67','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','67',NULL,'SPOUSE_SMOKER_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EOI_BYPASS"','68','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','68',NULL,'EOI_BYPASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_HEIGHT_FT"','69','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','69',NULL,'PRIMARY_HEIGHT_FT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_HEIGHT_IN"','70','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','70',NULL,'PRIMARY_HEIGHT_IN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_WEIGHT"','71','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','71',NULL,'PRIMARY_WEIGHT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO1"','72','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','72',NULL,'PRIMARY_KO1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO2"','73','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','73',NULL,'PRIMARY_KO2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO3"','74','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','74',NULL,'PRIMARY_KO3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO4"','75','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','75',NULL,'PRIMARY_KO4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO5"','76','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','76',NULL,'PRIMARY_KO5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARY_KO6"','77','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','77',NULL,'PRIMARY_KO6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_HEIGHT_FT"','78','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','78',NULL,'SPOUSE_HEIGHT_FT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_HEIGHT_IN"','79','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','79',NULL,'SPOUSE_HEIGHT_IN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_WEIGHT"','80','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','80',NULL,'SPOUSE_WEIGHT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO1"','81','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','81',NULL,'SPOUSE_KO1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO2"','82','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','82',NULL,'SPOUSE_KO2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO3"','83','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','83',NULL,'SPOUSE_KO3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO4"','84','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','84',NULL,'SPOUSE_KO4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO5"','85','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','85',NULL,'SPOUSE_KO5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE_KO6"','86','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','86',NULL,'SPOUSE_KO6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TOTAL_NUM_DEPENDENTS"','87','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','87',NULL,'TOTAL_NUM_DEPENDENTS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_FIRST_NAME"','88','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','88',NULL,'DEP1_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_MIDDLE_NAME"','89','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','89',NULL,'DEP1_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_LAST_NAME"','90','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','90',NULL,'DEP1_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_UNIQUE_ID"','91','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','91',NULL,'DEP1_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_SSN"','92','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','92',NULL,'DEP1_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DOB"','93','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','93',NULL,'DEP1_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DOD"','94','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','94',NULL,'DEP1_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_PREFIX"','95','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','95',NULL,'DEP1_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_SUFFIX"','96','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','96',NULL,'DEP1_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_GENDER"','97','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','97',NULL,'DEP1_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_LANGUAGE_PREFERENCE"','98','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','98',NULL,'DEP1_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_MARITAL_STATUS"','99','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','99',NULL,'DEP1_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_MARRIAGE_DATE"','100','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','100',NULL,'DEP1_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DIVORCE_DATE"','101','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','101',NULL,'DEP1_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_RELATION"','102','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','102',NULL,'DEP1_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DISABLED_INDIC"','103','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','103',NULL,'DEP1_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DISABLED_DATE"','104','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','104',NULL,'DEP1_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_STUDENT_INDIC"','105','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','105',NULL,'DEP1_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_TYPE"','106','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','106',NULL,'DEP1_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_LINE_1"','107','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','107',NULL,'DEP1_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_LINE_2"','108','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','108',NULL,'DEP1_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_LINE_3"','109','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','109',NULL,'DEP1_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_CITY"','110','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','110',NULL,'DEP1_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_STATE"','111','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','111',NULL,'DEP1_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ZIP"','112','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','112',NULL,'DEP1_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_COUNTRY"','113','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','113',NULL,'DEP1_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_EFF_DATE"','114','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','114',NULL,'DEP1_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_ADDRESS_SOURCE"','115','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','115',NULL,'DEP1_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_FIRST_NAME"','116','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','116',NULL,'DEP2_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_MIDDLE_NAME"','117','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','117',NULL,'DEP2_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_LAST_NAME"','118','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','118',NULL,'DEP2_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_UNIQUE_ID"','119','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','119',NULL,'DEP2_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_SSN"','120','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','120',NULL,'DEP2_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DOB"','121','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','121',NULL,'DEP2_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DOD"','122','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','122',NULL,'DEP2_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_SUFFIX"','123','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','123',NULL,'DEP2_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_GENDER"','124','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','124',NULL,'DEP2_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_LANGUAGE_PREFERENCE"','125','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','125',NULL,'DEP2_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_MARITAL_STATUS"','126','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','126',NULL,'DEP2_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_MARRIAGE_DATE"','127','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','127',NULL,'DEP2_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DIVORCE_DATE"','128','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','128',NULL,'DEP2_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_RELATION"','129','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','129',NULL,'DEP2_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DISABLED_INDIC"','130','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','130',NULL,'DEP2_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DISABLED_DATE"','131','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','131',NULL,'DEP2_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_STUDENT_INDIC"','132','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','132',NULL,'DEP2_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_TYPE"','133','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','133',NULL,'DEP2_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_LINE_1"','134','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','134',NULL,'DEP2_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_LINE_2"','135','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','135',NULL,'DEP2_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_LINE_3"','136','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','136',NULL,'DEP2_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_CITY"','137','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','137',NULL,'DEP2_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_STATE"','138','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','138',NULL,'DEP2_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ZIP"','139','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','139',NULL,'DEP2_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_COUNTRY"','140','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','140',NULL,'DEP2_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_EFF_DATE"','141','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','141',NULL,'DEP2_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_ADDRESS_SOURCE"','142','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','142',NULL,'DEP2_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_FIRST_NAME"','143','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','143',NULL,'DEP3_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_MIDDLE_NAME"','144','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','144',NULL,'DEP3_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_LAST_NAME"','145','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','145',NULL,'DEP3_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_UNIQUE_ID"','146','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','146',NULL,'DEP3_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_SSN"','147','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','147',NULL,'DEP3_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DOB"','148','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','148',NULL,'DEP3_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DOD"','149','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','149',NULL,'DEP3_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_PREFIX"','150','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','150',NULL,'DEP3_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_SUFFIX"','151','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','151',NULL,'DEP3_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_GENDER"','152','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','152',NULL,'DEP3_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_LANGUAGE_PREFERENCE"','153','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','153',NULL,'DEP3_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_MARITAL_STATUS"','154','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','154',NULL,'DEP3_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_MARRIAGE_DATE"','155','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','155',NULL,'DEP3_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DIVORCE_DATE"','156','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','156',NULL,'DEP3_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_RELATION"','157','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','157',NULL,'DEP3_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DISABLED_INDIC"','158','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','158',NULL,'DEP3_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DISABLED_DATE"','159','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','159',NULL,'DEP3_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_STUDENT_INDIC"','160','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','160',NULL,'DEP3_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_TYPE"','161','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','161',NULL,'DEP3_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_LINE_1"','162','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','162',NULL,'DEP3_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_LINE_2"','163','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','163',NULL,'DEP3_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_LINE_3"','164','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','164',NULL,'DEP3_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_CITY"','165','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','165',NULL,'DEP3_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_STATE"','166','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','166',NULL,'DEP3_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ZIP"','167','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','167',NULL,'DEP3_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_COUNTRY"','168','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','168',NULL,'DEP3_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_EFF_DATE"','169','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','169',NULL,'DEP3_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_ADDRESS_SOURCE"','170','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','170',NULL,'DEP3_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_FIRST_NAME"','171','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','171',NULL,'DEP4_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_MIDDLE_NAME"','172','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','172',NULL,'DEP4_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_LAST_NAME"','173','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','173',NULL,'DEP4_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_UNIQUE_ID"','174','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','174',NULL,'DEP4_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_SSN"','175','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','175',NULL,'DEP4_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DOB"','176','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','176',NULL,'DEP4_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DOD"','177','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','177',NULL,'DEP4_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_PREFIX"','178','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','178',NULL,'DEP4_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_SUFFIX"','179','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','179',NULL,'DEP4_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_GENDER"','180','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','180',NULL,'DEP4_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_LANGUAGE_PREFERENCE"','181','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','181',NULL,'DEP4_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_MARITAL_STATUS"','182','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','182',NULL,'DEP4_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_MARRIAGE_DATE"','183','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','183',NULL,'DEP4_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DIVORCE_DATE"','184','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','184',NULL,'DEP4_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_RELATION"','185','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','185',NULL,'DEP4_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DISABLED_INDIC"','186','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','186',NULL,'DEP4_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DISABLED_DATE"','187','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','187',NULL,'DEP4_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_STUDENT_INDIC"','188','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','188',NULL,'DEP4_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_TYPE"','189','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','189',NULL,'DEP4_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_LINE_1"','190','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','190',NULL,'DEP4_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_LINE_2"','191','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','191',NULL,'DEP4_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_LINE_3"','192','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','192',NULL,'DEP4_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_CITY"','193','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','193',NULL,'DEP4_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_STATE"','194','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','194',NULL,'DEP4_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ZIP"','195','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','195',NULL,'DEP4_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_COUNTRY"','196','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','196',NULL,'DEP4_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_EFF_DATE"','197','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','197',NULL,'DEP4_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_ADDRESS_SOURCE"','198','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','198',NULL,'DEP4_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_FIRST_NAME"','199','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','199',NULL,'DEP5_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_MIDDLE_NAME"','200','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','200',NULL,'DEP5_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_LAST_NAME"','201','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','201',NULL,'DEP5_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_UNIQUE_ID"','202','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','202',NULL,'DEP5_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_SSN"','203','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','203',NULL,'DEP5_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DOB"','204','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','204',NULL,'DEP5_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DOD"','205','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','205',NULL,'DEP5_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_PREFIX"','206','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','206',NULL,'DEP5_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_SUFFIX"','207','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','207',NULL,'DEP5_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_GENDER"','208','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','208',NULL,'DEP5_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_LANGUAGE_PREFERENCE"','209','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','209',NULL,'DEP5_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_MARITAL_STATUS"','210','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','210',NULL,'DEP5_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_MARRIAGE_DATE"','211','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','211',NULL,'DEP5_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DIVORCE_DATE"','212','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','212',NULL,'DEP5_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_RELATION"','213','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','213',NULL,'DEP5_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DISABLED_INDIC"','214','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','214',NULL,'DEP5_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DISABLED_DATE"','215','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','215',NULL,'DEP5_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_STUDENT_INDIC"','216','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','216',NULL,'DEP5_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_TYPE"','217','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','217',NULL,'DEP5_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_LINE_1"','218','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','218',NULL,'DEP5_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_LINE_2"','219','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','219',NULL,'DEP5_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_LINE_3"','220','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','220',NULL,'DEP5_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_CITY"','221','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','221',NULL,'DEP5_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_STATE"','222','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','222',NULL,'DEP5_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ZIP"','223','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','223',NULL,'DEP5_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_COUNTRY"','224','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','224',NULL,'DEP5_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_EFF_DATE"','225','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','225',NULL,'DEP5_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_ADDRESS_SOURCE"','226','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','226',NULL,'DEP5_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_FIRST_NAME"','227','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','227',NULL,'DEP6_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_MIDDLE_NAME"','228','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','228',NULL,'DEP6_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_LAST_NAME"','229','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','229',NULL,'DEP6_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_UNIQUE_ID"','230','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','230',NULL,'DEP6_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_SSN"','231','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','231',NULL,'DEP6_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DOB"','232','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','232',NULL,'DEP6_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DOD"','233','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','233',NULL,'DEP6_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_PREFIX"','234','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','234',NULL,'DEP6_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_SUFFIX"','235','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','235',NULL,'DEP6_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_GENDER"','236','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','236',NULL,'DEP6_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_LANGUAGE_PREFERENCE"','237','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','237',NULL,'DEP6_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_MARITAL_STATUS"','238','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','238',NULL,'DEP6_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_MARRIAGE_DATE"','239','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','239',NULL,'DEP6_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DIVORCE_DATE"','240','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','240',NULL,'DEP6_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_RELATION"','241','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','241',NULL,'DEP6_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DISABLED_INDIC"','242','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','242',NULL,'DEP6_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DISABLED_DATE"','243','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','243',NULL,'DEP6_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_STUDENT_INDIC"','244','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','244',NULL,'DEP6_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_TYPE"','245','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','245',NULL,'DEP6_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_LINE_1"','246','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','246',NULL,'DEP6_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_LINE_2"','247','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','247',NULL,'DEP6_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_LINE_3"','248','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','248',NULL,'DEP6_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_CITY"','249','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','249',NULL,'DEP6_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_STATE"','250','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','250',NULL,'DEP6_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ZIP"','251','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','251',NULL,'DEP6_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_COUNTRY"','252','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','252',NULL,'DEP6_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_EFF_DATE"','253','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','253',NULL,'DEP6_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_ADDRESS_SOURCE"','254','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','254',NULL,'DEP6_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_FIRST_NAME"','255','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','255',NULL,'DEP7_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_MIDDLE_NAME"','256','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','256',NULL,'DEP7_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_LAST_NAME"','257','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','257',NULL,'DEP7_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_UNIQUE_ID"','258','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','258',NULL,'DEP7_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_SSN"','259','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','259',NULL,'DEP7_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DOB"','260','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','260',NULL,'DEP7_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DOD"','261','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','261',NULL,'DEP7_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_PREFIX"','262','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','262',NULL,'DEP7_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_SUFFIX"','263','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','263',NULL,'DEP7_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_GENDER"','264','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','264',NULL,'DEP7_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_LANGUAGE_PREFERENCE"','265','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','265',NULL,'DEP7_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_MARITAL_STATUS"','266','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','266',NULL,'DEP7_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_MARRIAGE_DATE"','267','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','267',NULL,'DEP7_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DIVORCE_DATE"','268','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','268',NULL,'DEP7_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_RELATION"','269','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','269',NULL,'DEP7_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DISABLED_INDIC"','270','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','270',NULL,'DEP7_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DISABLED_DATE"','271','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','271',NULL,'DEP7_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_STUDENT_INDIC"','272','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','272',NULL,'DEP7_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_TYPE"','273','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','273',NULL,'DEP7_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_LINE_1"','274','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','274',NULL,'DEP7_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_LINE_2"','275','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','275',NULL,'DEP7_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_LINE_3"','276','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','276',NULL,'DEP7_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_CITY"','277','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','277',NULL,'DEP7_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_STATE"','278','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','278',NULL,'DEP7_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ZIP"','279','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','279',NULL,'DEP7_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_COUNTRY"','280','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','280',NULL,'DEP7_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_EFF_DATE"','281','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','281',NULL,'DEP7_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_ADDRESS_SOURCE"','282','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','282',NULL,'DEP7_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_FIRST_NAME"','283','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','283',NULL,'DEP8_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_MIDDLE_NAME"','284','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','284',NULL,'DEP8_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_LAST_NAME"','285','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','285',NULL,'DEP8_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_UNIQUE_ID"','286','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','286',NULL,'DEP8_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_SSN"','287','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','287',NULL,'DEP8_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DOB"','288','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','288',NULL,'DEP8_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DOD"','289','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','289',NULL,'DEP8_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_PREFIX"','290','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','290',NULL,'DEP8_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_SUFFIX"','291','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','291',NULL,'DEP8_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_GENDER"','292','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','292',NULL,'DEP8_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_LANGUAGE_PREFERENCE"','293','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','293',NULL,'DEP8_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_MARITAL_STATUS"','294','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','294',NULL,'DEP8_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_MARRIAGE_DATE"','295','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','295',NULL,'DEP8_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DIVORCE_DATE"','296','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','296',NULL,'DEP8_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_RELATION"','297','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','297',NULL,'DEP8_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DISABLED_INDIC"','298','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','298',NULL,'DEP8_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DISABLED_DATE"','299','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','299',NULL,'DEP8_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_STUDENT_INDIC"','300','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','300',NULL,'DEP8_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_TYPE"','301','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','301',NULL,'DEP8_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_LINE_1"','302','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','302',NULL,'DEP8_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_LINE_2"','303','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','303',NULL,'DEP8_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_LINE_3"','304','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','304',NULL,'DEP8_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_CITY"','305','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','305',NULL,'DEP8_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_STATE"','306','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','306',NULL,'DEP8_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ZIP"','307','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','307',NULL,'DEP8_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_COUNTRY"','308','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','308',NULL,'DEP8_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_EFF_DATE"','309','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','309',NULL,'DEP8_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_ADDRESS_SOURCE"','310','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','310',NULL,'DEP8_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_FIRST_NAME"','311','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','311',NULL,'DEP9_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_MIDDLE_NAME"','312','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','312',NULL,'DEP9_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_LAST_NAME"','313','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','313',NULL,'DEP9_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_UNIQUE_ID"','314','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','314',NULL,'DEP9_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_SSN"','315','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','315',NULL,'DEP9_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_DOB"','316','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','316',NULL,'DEP9_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_DOD"','317','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','317',NULL,'DEP9_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_PREFIX"','318','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','318',NULL,'DEP9_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_SUFFIX"','319','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','319',NULL,'DEP9_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_GENDER"','320','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','320',NULL,'DEP9_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_LANGUAGE_PREFERENCE"','321','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','321',NULL,'DEP9_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_MARITAL_STATUS"','322','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','322',NULL,'DEP9_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_MARRIAGE_DATE"','323','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','323',NULL,'DEP9_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_DIVORCE_DATE"','324','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','324',NULL,'DEP9_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_RELATION"','325','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','325',NULL,'DEP9_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_DISABLED_INDIC"','326','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','326',NULL,'DEP9_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_DISABLED_DATE"','327','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','327',NULL,'DEP9_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_STUDENT_INDIC"','328','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','328',NULL,'DEP9_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_TYPE"','329','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','329',NULL,'DEP9_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_LINE_1"','330','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','330',NULL,'DEP9_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_LINE_2"','331','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','331',NULL,'DEP9_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_LINE_3"','332','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','332',NULL,'DEP9_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_CITY"','333','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','333',NULL,'DEP9_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_STATE"','334','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','334',NULL,'DEP9_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ZIP"','335','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','335',NULL,'DEP9_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_COUNTRY"','336','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','336',NULL,'DEP9_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_EFF_DATE"','337','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','337',NULL,'DEP9_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP9_ADDRESS_SOURCE"','338','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','338',NULL,'DEP9_ADDRESS_SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_FIRST_NAME"','339','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','339',NULL,'DEP10_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_MIDDLE_NAME"','340','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','340',NULL,'DEP10_MIDDLE_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_LAST_NAME"','341','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','341',NULL,'DEP10_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_UNIQUE_ID"','342','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','342',NULL,'DEP10_UNIQUE_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_SSN"','343','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','343',NULL,'DEP10_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_DOB"','344','(''UD101''=''T,'')','ETRUSTKWPMZ0','54','D','10','344',NULL,'DEP10_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_DOD"','345','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','345',NULL,'DEP10_DOD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_PREFIX"','346','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','346',NULL,'DEP10_PREFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_SUFFIX"','347','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','347',NULL,'DEP10_SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_GENDER"','348','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','348',NULL,'DEP10_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_LANGUAGE_PREFERENCE"','349','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','349',NULL,'DEP10_LANGUAGE_PREFERENCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_MARITAL_STATUS"','350','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','350',NULL,'DEP10_MARITAL_STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_MARRIAGE_DATE"','351','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','351',NULL,'DEP10_MARRIAGE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_DIVORCE_DATE"','352','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','352',NULL,'DEP10_DIVORCE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_RELATION"','353','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','353',NULL,'DEP10_RELATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_DISABLED_INDIC"','354','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','354',NULL,'DEP10_DISABLED_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_DISABLED_DATE"','355','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','355',NULL,'DEP10_DISABLED_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_STUDENT_INDIC"','356','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','356',NULL,'DEP10_STUDENT_INDIC',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_TYPE"','357','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','357',NULL,'DEP10_ADDRESS_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_LINE_1"','358','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','358',NULL,'DEP10_ADDRESS_LINE_1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_LINE_2"','359','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','359',NULL,'DEP10_ADDRESS_LINE_2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_LINE_3"','360','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','360',NULL,'DEP10_ADDRESS_LINE_3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_CITY"','361','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','361',NULL,'DEP10_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_STATE"','362','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','362',NULL,'DEP10_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ZIP"','363','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','363',NULL,'DEP10_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_COUNTRY"','364','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','364',NULL,'DEP10_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_EFF_DATE"','365','(''UA''=''T,'')','ETRUSTKWPMZ0','54','D','10','365',NULL,'DEP10_ADDRESS_EFF_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP10_ADDRESS_SOURCE"','366','(''UA''=''T'')','ETRUSTKWPMZ0','54','D','10','366',NULL,'DEP10_ADDRESS_SOURCE',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ETRUSTKWPM_20210721.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Trustmark Critical Changes','202107079','EMPEXPORT','CHANGES',NULL,'ETRUSTKWPM',NULL,NULL,NULL,'202107079','Jul  7 2021  1:01PM','Jul  7 2021  1:01PM','202107071',NULL,'','','202107071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Trustmark Critical Fullfile','202107079','EMPEXPORT','FULLFILE',NULL,'ETRUSTKWPM',NULL,NULL,NULL,'202107079','Jul  7 2021  1:01PM','Jul  7 2021  1:01PM','202107071',NULL,'','','202107071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Trustmark Critical On Demand','202107079','EMPEXPORT','ONDEM_XOE',NULL,'ETRUSTKWPM',NULL,NULL,NULL,'202107079','Jul  7 2021  1:01PM','Jul  7 2021  1:01PM','202107071',NULL,'','','202107071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Trustmark Critical Illne-Sched','202107079','EMPEXPORT','SCH_ETRUST',NULL,'ETRUSTKWPM',NULL,NULL,NULL,'202107079','Jul  7 2021  1:01PM','Jul  7 2021  1:01PM','202107071',NULL,'','','202107071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Trustmark Critical Illne-Test','202107199','EMPEXPORT','TEST_XOE','Jul 19 2021  3:47PM','ETRUSTKWPM',NULL,NULL,NULL,'202107199','Jul 19 2021 12:00AM','Dec 30 1899 12:00AM','202107051','68','','','202107051',dbo.fn_GetTimedKey(),NULL,'us3lKiKWP1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRUSTKWPM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRUSTKWPM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRUSTKWPM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ETRUSTKWPM','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ETRUSTKWPM' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ETRUSTKWPM' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ETRUSTKWPM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ETRUSTKWPM_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRUSTKWPM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ETRUSTKWPM','D10','dbo.U_ETRUSTKWPM_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ETRUSTKWPM') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ETRUSTKWPM] (
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
IF OBJECT_ID('U_ETRUSTKWPM_Audit') IS NULL
CREATE TABLE [dbo].[U_ETRUSTKWPM_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audConSystemID] varchar(255) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL,
    [audDedChange] varchar(1) NOT NULL,
    [audBenOptionChange] varchar(1) NOT NULL,
    [audSSNChange] varchar(1) NOT NULL,
    [audNameChange] varchar(1) NOT NULL,
    [audDemoChange] varchar(1) NOT NULL,
    [audAddrChange] varchar(1) NOT NULL,
    [audNewlyEnroll] varchar(1) NOT NULL,
    [audReEnroll] varchar(1) NOT NULL,
    [audTermPlan] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ETRUSTKWPM_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ETRUSTKWPM_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ETRUSTKWPM_DedList') IS NULL
CREATE TABLE [dbo].[U_ETRUSTKWPM_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ETRUSTKWPM_DepLoop') IS NULL
CREATE TABLE [dbo].[U_ETRUSTKWPM_DepLoop] (
    [DepId] char(12) NOT NULL,
    [DepTotal] bigint NULL,
    [DepLastName1] varchar(100) NULL,
    [DepFirstName1] varchar(100) NULL,
    [DepMiddleName1] varchar(50) NULL,
    [DepNameSuffix1] varchar(30) NULL,
    [DepSsn1] char(11) NULL,
    [DepDateOfBirth1] datetime NULL,
    [DepGender1] char(1) NULL,
    [DepRelationship1] varchar(17) NULL,
    [DepDisabled1] char(1) NULL,
    [DepLastName2] varchar(100) NULL,
    [DepFirstName2] varchar(100) NULL,
    [DepMiddleName2] varchar(50) NULL,
    [DepNameSuffix2] varchar(30) NULL,
    [DepSsn2] char(11) NULL,
    [DepDateOfBirth2] datetime NULL,
    [DepGender2] char(1) NULL,
    [DepRelationship2] varchar(17) NULL,
    [DepDisabled2] char(1) NULL,
    [DepLastName3] varchar(100) NULL,
    [DepFirstName3] varchar(100) NULL,
    [DepMiddleName3] varchar(50) NULL,
    [DepNameSuffix3] varchar(30) NULL,
    [DepSsn3] char(11) NULL,
    [DepDateOfBirth3] datetime NULL,
    [DepGender3] char(1) NULL,
    [DepRelationship3] varchar(17) NULL,
    [DepDisabled3] char(1) NULL,
    [DepLastName4] varchar(100) NULL,
    [DepFirstName4] varchar(100) NULL,
    [DepMiddleName4] varchar(50) NULL,
    [DepNameSuffix4] varchar(30) NULL,
    [DepSsn4] char(11) NULL,
    [DepDateOfBirth4] datetime NULL,
    [DepGender4] char(1) NULL,
    [DepRelationship4] varchar(17) NULL,
    [DepDisabled4] char(1) NULL,
    [DepLastName5] varchar(100) NULL,
    [DepFirstName5] varchar(100) NULL,
    [DepMiddleName5] varchar(50) NULL,
    [DepNameSuffix5] varchar(30) NULL,
    [DepSsn5] char(11) NULL,
    [DepDateOfBirth5] datetime NULL,
    [DepGender5] char(1) NULL,
    [DepRelationship5] varchar(17) NULL,
    [DepDisabled5] char(1) NULL,
    [DepLastName6] varchar(100) NULL,
    [DepFirstName6] varchar(100) NULL,
    [DepMiddleName6] varchar(50) NULL,
    [DepNameSuffix6] varchar(30) NULL,
    [DepSsn6] char(11) NULL,
    [DepDateOfBirth6] datetime NULL,
    [DepGender6] char(1) NULL,
    [DepRelationship6] varchar(17) NULL,
    [DepDisabled6] char(1) NULL,
    [DepLastName7] varchar(100) NULL,
    [DepFirstName7] varchar(100) NULL,
    [DepMiddleName7] varchar(50) NULL,
    [DepNameSuffix7] varchar(30) NULL,
    [DepSsn7] char(11) NULL,
    [DepDateOfBirth7] datetime NULL,
    [DepGender7] char(1) NULL,
    [DepRelationship7] varchar(17) NULL,
    [DepDisabled7] char(1) NULL,
    [DepLastName8] varchar(100) NULL,
    [DepFirstName8] varchar(100) NULL,
    [DepMiddleName8] varchar(50) NULL,
    [DepNameSuffix8] varchar(30) NULL,
    [DepSsn8] char(11) NULL,
    [DepDateOfBirth8] datetime NULL,
    [DepGender8] char(1) NULL,
    [DepRelationship8] varchar(17) NULL,
    [DepDisabled8] char(1) NULL,
    [DepLastName9] varchar(100) NULL,
    [DepFirstName9] varchar(100) NULL,
    [DepMiddleName9] varchar(50) NULL,
    [DepNameSuffix9] varchar(30) NULL,
    [DepSsn9] char(11) NULL,
    [DepDateOfBirth9] datetime NULL,
    [DepGender9] char(1) NULL,
    [DepRelationship9] varchar(17) NULL,
    [DepDisabled9] char(1) NULL,
    [DepLastName10] varchar(100) NULL,
    [DepFirstName10] varchar(100) NULL,
    [DepMiddleName10] varchar(50) NULL,
    [DepNameSuffix10] varchar(30) NULL,
    [DepSsn10] char(11) NULL,
    [DepDateOfBirth10] datetime NULL,
    [DepGender10] char(1) NULL,
    [DepRelationship10] varchar(17) NULL,
    [DepDisabled10] char(1) NULL
);
IF OBJECT_ID('U_ETRUSTKWPM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ETRUSTKWPM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [DATA_SET_INSTANCE_ID] char(9) NULL,
    [GROUP_ID] varchar(10) NOT NULL,
    [APPLICATION_IGO] char(9) NULL,
    [TRANS_TYPE] varchar(1) NOT NULL,
    [EE_FIRST_NAME] varchar(100) NULL,
    [EE_MIDDLE_NAME] varchar(50) NULL,
    [EE_LAST_NAME] varchar(100) NULL,
    [EE_SSN] char(11) NULL,
    [EE_SUBSCRIBER_ID] char(9) NULL,
    [EE_DOB] datetime NULL,
    [EE_DOD] varchar(30) NOT NULL,
    [EE_PREFIX] varchar(1) NOT NULL,
    [EE_SUFFIX] varchar(30) NULL,
    [EE_GENDER] char(1) NULL,
    [EE_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [EE_MARITAL_STATUS] varchar(1) NOT NULL,
    [EE_STATUS] varchar(1) NOT NULL,
    [EE_HOME_PHONE] varchar(50) NULL,
    [EE_CELL_PHONE] varchar(1) NOT NULL,
    [EE_WORK_PHONE] varchar(1) NOT NULL,
    [EE_WORK_EXT] varchar(1) NOT NULL,
    [EE_EMAIL] varchar(50) NULL,
    [EE_WORK_EMAIL] varchar(50) NULL,
    [EE_ADDRESS_TYPE] varchar(1) NOT NULL,
    [EE_ADDRESS_LINE_1] varchar(8000) NULL,
    [EE_ADDRESS_LINE_2] varchar(8000) NULL,
    [EE_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [EE_CITY] varchar(255) NULL,
    [EE_STATE] varchar(255) NULL,
    [EE_ZIP] varchar(50) NULL,
    [EE_COUNTRY] varchar(2) NOT NULL,
    [EE_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [EE_ADDRESS_SOURCE] varchar(1) NOT NULL,
    [EE_ACCOUNT_ID] varchar(10) NOT NULL,
    [EE_LOCATION_ID] varchar(1) NOT NULL,
    [EE_EMPLOYEE_ID] char(9) NULL,
    [EE_HIRE_DATE] datetime NULL,
    [EE_TERM_DATE] varchar(30) NOT NULL,
    [EE_TERM_REASON] varchar(2) NULL,
    [EE_PAYROLL_CYCLE] varchar(29) NOT NULL,
    [EE_HOURS_PER_WEEK] varchar(30) NULL,
    [EE_SORT_GROUP] varchar(1) NOT NULL,
    [EE_CLASS_01_CLASS_CODE] varchar(1) NOT NULL,
    [EE_CLASS_01_PRODUCT] varchar(3) NOT NULL,
    [EE_CLASS_01_START_DATE] datetime NULL,
    [EE_CLASS_01_STOP_DATE] datetime NULL,
    [EE_CLASS_02_CLASS_CODE] varchar(1) NOT NULL,
    [EE_CLASS_02_PRODUCT] varchar(1) NOT NULL,
    [EE_CLASS_02_START_DATE] varchar(1) NOT NULL,
    [EE_CLASS_02_STOP_DATE] varchar(1) NOT NULL,
    [EE_CLASS_03_CLASS_CODE] varchar(1) NOT NULL,
    [EE_CLASS_03_PRODUCT] varchar(1) NOT NULL,
    [EE_CLASS_03_START_DATE] varchar(1) NOT NULL,
    [EE_CLASS_03_STOP_DATE] varchar(1) NOT NULL,
    [CERT_NUM] varchar(1) NOT NULL,
    [PLAN_CODE] varchar(4) NOT NULL,
    [BILLING_GROUP] varchar(22) NOT NULL,
    [TIER] varchar(21) NULL,
    [EVENT_DATE] datetime NULL,
    [APPLICATION_SIGN_DATE] datetime NULL,
    [EFFECTIVE_DATE] datetime NULL,
    [ISSUED_AGE] varchar(1) NOT NULL,
    [PRIMARY_BENEFIT_AMT] varchar(1) NOT NULL,
    [SPOUSE_BENEFIT_AMT] varchar(1) NOT NULL,
    [CHILD_BENEFIT_AMT] varchar(1) NOT NULL,
    [PRIMARY_SMOKER_STATUS] varchar(1) NOT NULL,
    [SPOUSE_SMOKER_STATUS] varchar(1) NOT NULL,
    [EOI_BYPASS] varchar(1) NOT NULL,
    [PRIMARY_HEIGHT_FT] varchar(1) NOT NULL,
    [PRIMARY_HEIGHT_IN] varchar(1) NOT NULL,
    [PRIMARY_WEIGHT] varchar(1) NOT NULL,
    [PRIMARY_KO1] varchar(1) NOT NULL,
    [PRIMARY_KO2] varchar(1) NOT NULL,
    [PRIMARY_KO3] varchar(1) NOT NULL,
    [PRIMARY_KO4] varchar(1) NOT NULL,
    [PRIMARY_KO5] varchar(1) NOT NULL,
    [PRIMARY_KO6] varchar(1) NOT NULL,
    [SPOUSE_HEIGHT_FT] varchar(1) NOT NULL,
    [SPOUSE_HEIGHT_IN] varchar(1) NOT NULL,
    [SPOUSE_WEIGHT] varchar(1) NOT NULL,
    [SPOUSE_KO1] varchar(1) NOT NULL,
    [SPOUSE_KO2] varchar(1) NOT NULL,
    [SPOUSE_KO3] varchar(1) NOT NULL,
    [SPOUSE_KO4] varchar(1) NOT NULL,
    [SPOUSE_KO5] varchar(1) NOT NULL,
    [SPOUSE_KO6] varchar(1) NOT NULL,
    [TOTAL_NUM_DEPENDENTS] bigint NULL,
    [DEP1_FIRST_NAME] varchar(100) NULL,
    [DEP1_MIDDLE_NAME] varchar(50) NULL,
    [DEP1_LAST_NAME] varchar(100) NULL,
    [DEP1_UNIQUE_ID] varchar(1) NOT NULL,
    [DEP1_SSN] char(11) NULL,
    [DEP1_DOB] datetime NULL,
    [DEP1_DOD] varchar(1) NOT NULL,
    [DEP1_PREFIX] varchar(1) NOT NULL,
    [DEP1_SUFFIX] varchar(30) NULL,
    [DEP1_GENDER] char(1) NULL,
    [DEP1_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [DEP1_MARITAL_STATUS] varchar(1) NOT NULL,
    [DEP1_MARRIAGE_DATE] varchar(1) NOT NULL,
    [DEP1_DIVORCE_DATE] varchar(1) NOT NULL,
    [DEP1_RELATION] varchar(17) NULL,
    [DEP1_DISABLED_INDIC] char(1) NULL,
    [DEP1_DISABLED_DATE] varchar(1) NOT NULL,
    [DEP1_STUDENT_INDIC] varchar(1) NOT NULL,
    [DEP1_ADDRESS_TYPE] varchar(1) NOT NULL,
    [DEP1_ADDRESS_LINE_1] varchar(1) NOT NULL,
    [DEP1_ADDRESS_LINE_2] varchar(1) NOT NULL,
    [DEP1_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [DEP1_CITY] varchar(1) NOT NULL,
    [DEP1_STATE] varchar(1) NOT NULL,
    [DEP1_ZIP] varchar(1) NOT NULL,
    [DEP1_COUNTRY] varchar(1) NOT NULL,
    [DEP1_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [DEP1_ADDRESS_SOURCE] varchar(1) NOT NULL,
    [DEP2_FIRST_NAME] varchar(100) NULL,
    [DEP2_MIDDLE_NAME] varchar(50) NULL,
    [DEP2_LAST_NAME] varchar(100) NULL,
    [DEP2_UNIQUE_ID] varchar(1) NOT NULL,
    [DEP2_SSN] char(11) NULL,
    [DEP2_DOB] datetime NULL,
    [DEP2_DOD] varchar(1) NOT NULL,
    [DEP2_PREFIX] varchar(1) NOT NULL,
    [DEP2_SUFFIX] varchar(30) NULL,
    [DEP2_GENDER] char(1) NULL,
    [DEP2_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [DEP2_MARITAL_STATUS] varchar(1) NOT NULL,
    [DEP2_MARRIAGE_DATE] varchar(1) NOT NULL,
    [DEP2_DIVORCE_DATE] varchar(1) NOT NULL,
    [DEP2_RELATION] varchar(17) NULL,
    [DEP2_DISABLED_INDIC] char(1) NULL,
    [DEP2_DISABLED_DATE] varchar(1) NOT NULL,
    [DEP2_STUDENT_INDIC] varchar(1) NOT NULL,
    [DEP2_ADDRESS_TYPE] varchar(1) NOT NULL,
    [DEP2_ADDRESS_LINE_1] varchar(1) NOT NULL,
    [DEP2_ADDRESS_LINE_2] varchar(1) NOT NULL,
    [DEP2_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [DEP2_CITY] varchar(1) NOT NULL,
    [DEP2_STATE] varchar(1) NOT NULL,
    [DEP2_ZIP] varchar(1) NOT NULL,
    [DEP2_COUNTRY] varchar(1) NOT NULL,
    [DEP2_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [DEP2_ADDRESS_SOURCE] varchar(1) NOT NULL,
    [DEP3_FIRST_NAME] varchar(100) NULL,
    [DEP3_MIDDLE_NAME] varchar(50) NULL,
    [DEP3_LAST_NAME] varchar(100) NULL,
    [DEP3_UNIQUE_ID] varchar(1) NOT NULL,
    [DEP3_SSN] char(11) NULL,
    [DEP3_DOB] datetime NULL,
    [DEP3_DOD] varchar(1) NOT NULL,
    [DEP3_PREFIX] varchar(1) NOT NULL,
    [DEP3_SUFFIX] varchar(30) NULL,
    [DEP3_GENDER] char(1) NULL,
    [DEP3_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [DEP3_MARITAL_STATUS] varchar(1) NOT NULL,
    [DEP3_MARRIAGE_DATE] varchar(1) NOT NULL,
    [DEP3_DIVORCE_DATE] varchar(1) NOT NULL,
    [DEP3_RELATION] varchar(17) NULL,
    [DEP3_DISABLED_INDIC] char(1) NULL,
    [DEP3_DISABLED_DATE] varchar(1) NOT NULL,
    [DEP3_STUDENT_INDIC] varchar(1) NOT NULL,
    [DEP3_ADDRESS_TYPE] varchar(1) NOT NULL,
    [DEP3_ADDRESS_LINE_1] varchar(1) NOT NULL,
    [DEP3_ADDRESS_LINE_2] varchar(1) NOT NULL,
    [DEP3_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [DEP3_CITY] varchar(1) NOT NULL,
    [DEP3_STATE] varchar(1) NOT NULL,
    [DEP3_ZIP] varchar(1) NOT NULL,
    [DEP3_COUNTRY] varchar(1) NOT NULL,
    [DEP3_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [DEP3_ADDRESS_SOURCE] varchar(1) NOT NULL,
    [DEP4_FIRST_NAME] varchar(100) NULL,
    [DEP4_MIDDLE_NAME] varchar(50) NULL,
    [DEP4_LAST_NAME] varchar(100) NULL,
    [DEP4_UNIQUE_ID] varchar(1) NOT NULL,
    [DEP4_SSN] char(11) NULL,
    [DEP4_DOB] datetime NULL,
    [DEP4_DOD] varchar(1) NOT NULL,
    [DEP4_PREFIX] varchar(1) NOT NULL,
    [DEP4_SUFFIX] varchar(30) NULL,
    [DEP4_GENDER] char(1) NULL,
    [DEP4_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [DEP4_MARITAL_STATUS] varchar(1) NOT NULL,
    [DEP4_MARRIAGE_DATE] varchar(1) NOT NULL,
    [DEP4_DIVORCE_DATE] varchar(1) NOT NULL,
    [DEP4_RELATION] varchar(17) NULL,
    [DEP4_DISABLED_INDIC] char(1) NULL,
    [DEP4_DISABLED_DATE] varchar(1) NOT NULL,
    [DEP4_STUDENT_INDIC] varchar(1) NOT NULL,
    [DEP4_ADDRESS_TYPE] varchar(1) NOT NULL,
    [DEP4_ADDRESS_LINE_1] varchar(1) NOT NULL,
    [DEP4_ADDRESS_LINE_2] varchar(1) NOT NULL,
    [DEP4_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [DEP4_CITY] varchar(1) NOT NULL,
    [DEP4_STATE] varchar(1) NOT NULL,
    [DEP4_ZIP] varchar(1) NOT NULL,
    [DEP4_COUNTRY] varchar(1) NOT NULL,
    [DEP4_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [DEP4_ADDRESS_SOURCE] varchar(1) NOT NULL,
    [DEP5_FIRST_NAME] varchar(100) NULL,
    [DEP5_MIDDLE_NAME] varchar(50) NULL,
    [DEP5_LAST_NAME] varchar(100) NULL,
    [DEP5_UNIQUE_ID] varchar(1) NOT NULL,
    [DEP5_SSN] char(11) NULL,
    [DEP5_DOB] datetime NULL,
    [DEP5_DOD] varchar(1) NOT NULL,
    [DEP5_PREFIX] varchar(1) NOT NULL,
    [DEP5_SUFFIX] varchar(30) NULL,
    [DEP5_GENDER] char(1) NULL,
    [DEP5_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [DEP5_MARITAL_STATUS] varchar(1) NOT NULL,
    [DEP5_MARRIAGE_DATE] varchar(1) NOT NULL,
    [DEP5_DIVORCE_DATE] varchar(1) NOT NULL,
    [DEP5_RELATION] varchar(17) NULL,
    [DEP5_DISABLED_INDIC] char(1) NULL,
    [DEP5_DISABLED_DATE] varchar(1) NOT NULL,
    [DEP5_STUDENT_INDIC] varchar(1) NOT NULL,
    [DEP5_ADDRESS_TYPE] varchar(1) NOT NULL,
    [DEP5_ADDRESS_LINE_1] varchar(1) NOT NULL,
    [DEP5_ADDRESS_LINE_2] varchar(1) NOT NULL,
    [DEP5_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [DEP5_CITY] varchar(1) NOT NULL,
    [DEP5_STATE] varchar(1) NOT NULL,
    [DEP5_ZIP] varchar(1) NOT NULL,
    [DEP5_COUNTRY] varchar(1) NOT NULL,
    [DEP5_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [DEP5_ADDRESS_SOURCE] varchar(1) NOT NULL,
    [DEP6_FIRST_NAME] varchar(100) NULL,
    [DEP6_MIDDLE_NAME] varchar(50) NULL,
    [DEP6_LAST_NAME] varchar(100) NULL,
    [DEP6_UNIQUE_ID] varchar(1) NOT NULL,
    [DEP6_SSN] char(11) NULL,
    [DEP6_DOB] datetime NULL,
    [DEP6_DOD] varchar(1) NOT NULL,
    [DEP6_PREFIX] varchar(1) NOT NULL,
    [DEP6_SUFFIX] varchar(30) NULL,
    [DEP6_GENDER] char(1) NULL,
    [DEP6_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [DEP6_MARITAL_STATUS] varchar(1) NOT NULL,
    [DEP6_MARRIAGE_DATE] varchar(1) NOT NULL,
    [DEP6_DIVORCE_DATE] varchar(1) NOT NULL,
    [DEP6_RELATION] varchar(17) NULL,
    [DEP6_DISABLED_INDIC] char(1) NULL,
    [DEP6_DISABLED_DATE] varchar(1) NOT NULL,
    [DEP6_STUDENT_INDIC] varchar(1) NOT NULL,
    [DEP6_ADDRESS_TYPE] varchar(1) NOT NULL,
    [DEP6_ADDRESS_LINE_1] varchar(1) NOT NULL,
    [DEP6_ADDRESS_LINE_2] varchar(1) NOT NULL,
    [DEP6_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [DEP6_CITY] varchar(1) NOT NULL,
    [DEP6_STATE] varchar(1) NOT NULL,
    [DEP6_ZIP] varchar(1) NOT NULL,
    [DEP6_COUNTRY] varchar(1) NOT NULL,
    [DEP6_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [DEP6_ADDRESS_SOURCE] varchar(1) NOT NULL,
    [DEP7_FIRST_NAME] varchar(100) NULL,
    [DEP7_MIDDLE_NAME] varchar(50) NULL,
    [DEP7_LAST_NAME] varchar(100) NULL,
    [DEP7_UNIQUE_ID] varchar(1) NOT NULL,
    [DEP7_SSN] char(11) NULL,
    [DEP7_DOB] datetime NULL,
    [DEP7_DOD] varchar(1) NOT NULL,
    [DEP7_PREFIX] varchar(1) NOT NULL,
    [DEP7_SUFFIX] varchar(30) NULL,
    [DEP7_GENDER] char(1) NULL,
    [DEP7_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [DEP7_MARITAL_STATUS] varchar(1) NOT NULL,
    [DEP7_MARRIAGE_DATE] varchar(1) NOT NULL,
    [DEP7_DIVORCE_DATE] varchar(1) NOT NULL,
    [DEP7_RELATION] varchar(17) NULL,
    [DEP7_DISABLED_INDIC] char(1) NULL,
    [DEP7_DISABLED_DATE] varchar(1) NOT NULL,
    [DEP7_STUDENT_INDIC] varchar(1) NOT NULL,
    [DEP7_ADDRESS_TYPE] varchar(1) NOT NULL,
    [DEP7_ADDRESS_LINE_1] varchar(1) NOT NULL,
    [DEP7_ADDRESS_LINE_2] varchar(1) NOT NULL,
    [DEP7_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [DEP7_CITY] varchar(1) NOT NULL,
    [DEP7_STATE] varchar(1) NOT NULL,
    [DEP7_ZIP] varchar(1) NOT NULL,
    [DEP7_COUNTRY] varchar(1) NOT NULL,
    [DEP7_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [DEP7_ADDRESS_SOURCE] varchar(1) NOT NULL,
    [DEP8_FIRST_NAME] varchar(100) NULL,
    [DEP8_MIDDLE_NAME] varchar(50) NULL,
    [DEP8_LAST_NAME] varchar(100) NULL,
    [DEP8_UNIQUE_ID] varchar(1) NOT NULL,
    [DEP8_SSN] char(11) NULL,
    [DEP8_DOB] datetime NULL,
    [DEP8_DOD] varchar(1) NOT NULL,
    [DEP8_PREFIX] varchar(1) NOT NULL,
    [DEP8_SUFFIX] varchar(30) NULL,
    [DEP8_GENDER] char(1) NULL,
    [DEP8_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [DEP8_MARITAL_STATUS] varchar(1) NOT NULL,
    [DEP8_MARRIAGE_DATE] varchar(1) NOT NULL,
    [DEP8_DIVORCE_DATE] varchar(1) NOT NULL,
    [DEP8_RELATION] varchar(17) NULL,
    [DEP8_DISABLED_INDIC] char(1) NULL,
    [DEP8_DISABLED_DATE] varchar(1) NOT NULL,
    [DEP8_STUDENT_INDIC] varchar(1) NOT NULL,
    [DEP8_ADDRESS_TYPE] varchar(1) NOT NULL,
    [DEP8_ADDRESS_LINE_1] varchar(1) NOT NULL,
    [DEP8_ADDRESS_LINE_2] varchar(1) NOT NULL,
    [DEP8_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [DEP8_CITY] varchar(1) NOT NULL,
    [DEP8_STATE] varchar(1) NOT NULL,
    [DEP8_ZIP] varchar(1) NOT NULL,
    [DEP8_COUNTRY] varchar(1) NOT NULL,
    [DEP8_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [DEP8_ADDRESS_SOURCE] varchar(1) NOT NULL,
    [DEP9_FIRST_NAME] varchar(100) NULL,
    [DEP9_MIDDLE_NAME] varchar(50) NULL,
    [DEP9_LAST_NAME] varchar(100) NULL,
    [DEP9_UNIQUE_ID] varchar(1) NOT NULL,
    [DEP9_SSN] char(11) NULL,
    [DEP9_DOB] datetime NULL,
    [DEP9_DOD] varchar(1) NOT NULL,
    [DEP9_PREFIX] varchar(1) NOT NULL,
    [DEP9_SUFFIX] varchar(30) NULL,
    [DEP9_GENDER] char(1) NULL,
    [DEP9_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [DEP9_MARITAL_STATUS] varchar(1) NOT NULL,
    [DEP9_MARRIAGE_DATE] varchar(1) NOT NULL,
    [DEP9_DIVORCE_DATE] varchar(1) NOT NULL,
    [DEP9_RELATION] varchar(17) NULL,
    [DEP9_DISABLED_INDIC] char(1) NULL,
    [DEP9_DISABLED_DATE] varchar(1) NOT NULL,
    [DEP9_STUDENT_INDIC] varchar(1) NOT NULL,
    [DEP9_ADDRESS_TYPE] varchar(1) NOT NULL,
    [DEP9_ADDRESS_LINE_1] varchar(1) NOT NULL,
    [DEP9_ADDRESS_LINE_2] varchar(1) NOT NULL,
    [DEP9_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [DEP9_CITY] varchar(1) NOT NULL,
    [DEP9_STATE] varchar(1) NOT NULL,
    [DEP9_ZIP] varchar(1) NOT NULL,
    [DEP9_COUNTRY] varchar(1) NOT NULL,
    [DEP9_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [DEP9_ADDRESS_SOURCE] varchar(1) NOT NULL,
    [DEP10_FIRST_NAME] varchar(100) NULL,
    [DEP10_MIDDLE_NAME] varchar(50) NULL,
    [DEP10_LAST_NAME] varchar(100) NULL,
    [DEP10_UNIQUE_ID] varchar(1) NOT NULL,
    [DEP10_SSN] char(11) NULL,
    [DEP10_DOB] datetime NULL,
    [DEP10_DOD] varchar(1) NOT NULL,
    [DEP10_PREFIX] varchar(1) NOT NULL,
    [DEP10_SUFFIX] varchar(30) NULL,
    [DEP10_GENDER] char(1) NULL,
    [DEP10_LANGUAGE_PREFERENCE] varchar(1) NOT NULL,
    [DEP10_MARITAL_STATUS] varchar(1) NOT NULL,
    [DEP10_MARRIAGE_DATE] varchar(1) NOT NULL,
    [DEP10_DIVORCE_DATE] varchar(1) NOT NULL,
    [DEP10_RELATION] varchar(17) NULL,
    [DEP10_DISABLED_INDIC] char(1) NULL,
    [DEP10_DISABLED_DATE] varchar(1) NOT NULL,
    [DEP10_STUDENT_INDIC] varchar(1) NOT NULL,
    [DEP10_ADDRESS_TYPE] varchar(1) NOT NULL,
    [DEP10_ADDRESS_LINE_1] varchar(1) NOT NULL,
    [DEP10_ADDRESS_LINE_2] varchar(1) NOT NULL,
    [DEP10_ADDRESS_LINE_3] varchar(1) NOT NULL,
    [DEP10_CITY] varchar(1) NOT NULL,
    [DEP10_STATE] varchar(1) NOT NULL,
    [DEP10_ZIP] varchar(1) NOT NULL,
    [DEP10_COUNTRY] varchar(1) NOT NULL,
    [DEP10_ADDRESS_EFF_DATE] varchar(1) NOT NULL,
    [DEP10_ADDRESS_SOURCE] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ETRUSTKWPM_EEList') IS NULL
CREATE TABLE [dbo].[U_ETRUSTKWPM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ETRUSTKWPM_File') IS NULL
CREATE TABLE [dbo].[U_ETRUSTKWPM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ETRUSTKWPM_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ETRUSTKWPM_PDedHist] (
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
IF OBJECT_ID('U_ETRUSTKWPM_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ETRUSTKWPM_PEarHist] (
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
IF OBJECT_ID('U_ETRUSTKWPM_Tier') IS NULL
CREATE TABLE [dbo].[U_ETRUSTKWPM_Tier] (
    [teeid] char(12) NOT NULL,
    [tcoid] char(5) NOT NULL,
    [is_crile] varchar(1) NOT NULL,
    [is_crill] varchar(1) NULL,
    [is_crils] varchar(1) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ETRUSTKWPM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: KW Property Management

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 07/07/2021
Service Request Number: SR-2021-00315544

Purpose: Trustmark Critical Illness Export

Revision History
----------------
07/19/2021 by AP:
        - Change ded codes to CRIH.
        - Set amounts to blank.
        - Updated tier logic.
        - Removed ',' from address fields.
        - Added Q, to "EE_PAYROLL_CYCLE" field.

07/21/2021 by AP:
		- Fixed issue with duplicate EE_CLASS_01_PRODUCT fields in the file output.
		- Fixed duplicate employees due to erroneous CASE STATEMENT in SpouseSmoker field.
		- Fixed tier field to show "Family" instead of "Employee" for EEF, EEDPF, EEFNW, FAM ben options.
		- Fixed issues where dependent field as showing wrong count based on benoption chosen by employee.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ETRUSTKWPM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ETRUSTKWPM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ETRUSTKWPM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ETRUSTKWPM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ETRUSTKWPM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRUSTKWPM', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRUSTKWPM', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRUSTKWPM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRUSTKWPM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ETRUSTKWPM', 'SCH_ETRUST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ETRUSTKWPM';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ETRUSTKWPM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ETRUSTKWPM';

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
    DELETE FROM dbo.U_ETRUSTKWPM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ETRUSTKWPM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CRIH'
    --'CRILE, CRILL, CRILS';

    IF OBJECT_ID('U_ETRUSTKWPM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ETRUSTKWPM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ETRUSTKWPM_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_ETRUSTKWPM_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ETRUSTKWPM_AuditFields;
    CREATE TABLE dbo.U_ETRUSTKWPM_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Dependent Information
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('Contacts','ConAddressCountry');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('EmpDed','EedBenStopDate');
    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('DepBPlan','DbnBenStopDate');
    -- Deduction/Benefit Information
    --INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('DedCode','DedBenAmt');
    --INSERT INTO dbo.U_ETRUSTKWPM_AuditFields VALUES ('DedCode','DedBenAmtRateOrPct');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ETRUSTKWPM_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ETRUSTKWPM_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audConSystemID =  CASE WHEN audTableName = 'Contacts' THEN audKey3Value
                                WHEN audTableName = 'DepBPlan' THEN DbnDepRecID
                           END
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audDedChange = CASE WHEN audTableName IN ('EmpDed','DepBPlan','DedCode') THEN 'Y'
                             ELSE 'N'
                        END
        ,audBenOptionChange = CASE WHEN audFieldName IN ('EedBenOption') THEN 'Y'
                                   ELSE 'N'
                              END
        ,audSSNChange = CASE WHEN audFieldName IN ('EepSSN','ConSSN') THEN 'Y'
                              ELSE 'N'
                        END
        ,audNameChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Name%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers') AND audFieldName LIKE '%Prefix%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Suffix%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audDemoChange = CASE WHEN audFieldName IN ('EepGender','EepDateOfBirth','EepMaritalStatus','ConGender','ConDateOfBirth','ConRelationship') THEN 'Y'
                              ELSE 'N'
                         END
        ,audAddrChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Address%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audNewlyEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') = '' AND audNewValue = 'A' THEN 'Y'
                               ELSE 'N'
                          END
        ,audReEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') NOT IN ('A','') AND audNewValue = 'A' THEN 'Y'
                            WHEN audFieldName IN ('EedBenStartDate','DbnBenStartDate') AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audTermPlan = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND audOldValue = 'A' AND ISNULL(audNewValue,'') NOT IN ('A','') THEN 'Y'
                            WHEN audFieldName IN ('EedBenStopDate','DbnBenStopDate') AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
    INTO dbo.U_ETRUSTKWPM_Audit
    FROM dbo.U_ETRUSTKWPM_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_ETRUSTKWPM_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    --AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
    --    OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_ETRUSTKWPM_DedList))
    --    OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_ETRUSTKWPM_DedList))
;
    --================
    -- Changes Only
    --================
    IF (@Exportcode NOT IN ('FULLFILE','TEST_XOE','ONDEM_XOE', 'SCH_ETRUST'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_ETRUSTKWPM_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ETRUSTKWPM_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;


    --==========================================
    -- Build Working Tables
    --==========================================

    -- Table for tier field
         IF OBJECT_ID('U_ETRUSTKWPM_Tier','U') IS NOT NULL
        DROP TABLE dbo.U_ETRUSTKWPM_Tier; 
        select distinct a.eedeeid as teeid, a.eedcoid as tcoid, '1' as is_crile, case when c.eeddedcode is not null then '1' end as is_crill, case when d.eeddedcode is not null then '1'  end as is_crils
        into dbo.U_ETRUSTKWPM_Tier
        from u_dsi_bdm_empdeductions a left join u_dsi_bdm_empdeductions b
        on a.eedeeid = b.eedeeid and a.eedcoid = b.eedcoid and a.eeddedcode = 'crile'
        left join u_dsi_bdm_empdeductions c
        on a.eedeeid = c.eedeeid and a.eedcoid = c.eedcoid and c.eeddedcode = 'crill'
        left join u_dsi_bdm_empdeductions d
        on a.eedeeid = d.eedeeid and a.eedcoid = d.eedcoid and d.eeddedcode = 'crils' 
        where a.eedformatcode = @formatcode

    -- Build multiple dependents columns
        IF OBJECT_ID('U_ETRUSTKWPM_DepLoop','U') IS NOT NULL
        DROP TABLE dbo.U_ETRUSTKWPM_DepLoop; 

        Select ConEEID AS DepId
            ,MAX(Dep_Number) AS DepTotal
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS DepLastName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS DepFirstName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameMiddle END) AS DepMiddleName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameSuffix END) AS DepNameSuffix1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS DepSsn1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS DepDateOfBirth1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConGender END) AS DepGender1
            ,MAX(CASE WHEN Dep_Number = 1 THEN 
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partners'
                                        ELSE 'Child' END
                                    END) AS DepRelationship1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConIsDisabled END) AS DepDisabled1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) AS DepLastName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) AS DepFirstName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameMiddle END) AS DepMiddleName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameSuffix END) AS DepNameSuffix2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConSSN END) AS DepSsn2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) AS DepDateOfBirth2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConGender END) AS DepGender2
            ,MAX(CASE WHEN Dep_Number = 2 THEN 
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partners'
                                        ELSE 'Child' END
                                    END) AS DepRelationship2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConIsDisabled END) AS DepDisabled2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) AS DepLastName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) AS DepFirstName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameMiddle END) AS DepMiddleName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameSuffix END) AS DepNameSuffix3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConSSN END) AS DepSsn3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) AS DepDateOfBirth3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConGender END) AS DepGender3
            ,MAX(CASE WHEN Dep_Number = 3 THEN 
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partners'
                                        ELSE 'Child' END
                                    END) AS DepRelationship3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConIsDisabled END) AS DepDisabled3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) AS DepLastName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) AS DepFirstName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameMiddle END) AS DepMiddleName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameSuffix END) AS DepNameSuffix4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConSSN END) AS DepSsn4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) AS DepDateOfBirth4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConGender END) AS DepGender4
            ,MAX(CASE WHEN Dep_Number = 4 THEN 
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partners'
                                        ELSE 'Child' END
                                    END) AS DepRelationship4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConIsDisabled END) AS DepDisabled4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameLast END) AS DepLastName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameFirst END) AS DepFirstName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameMiddle END) AS DepMiddleName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameSuffix END) AS DepNameSuffix5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConSSN END) AS DepSsn5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConDateOfBirth END) AS DepDateOfBirth5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConGender END) AS DepGender5
            ,MAX(CASE WHEN Dep_Number = 5 THEN 
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partners'
                                        ELSE 'Child' END
                                    END) AS DepRelationship5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConIsDisabled END) AS DepDisabled5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameLast END) AS DepLastName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameFirst END) AS DepFirstName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameMiddle END) AS DepMiddleName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameSuffix END) AS DepNameSuffix6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConSSN END) AS DepSsn6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConDateOfBirth END) AS DepDateOfBirth6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConGender END) AS DepGender6
            ,MAX(CASE WHEN Dep_Number = 6 THEN 
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partners'
                                        ELSE 'Child' END
                                    END) AS DepRelationship6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConIsDisabled END) AS DepDisabled6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameLast END) AS DepLastName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameFirst END) AS DepFirstName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameMiddle END) AS DepMiddleName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameSuffix END) AS DepNameSuffix7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConSSN END) AS DepSsn7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConDateOfBirth END) AS DepDateOfBirth7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConGender END) AS DepGender7
            ,MAX(CASE WHEN Dep_Number = 7 THEN 
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partners'
                                        ELSE 'Child' END
                                    END) AS DepRelationship7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConIsDisabled END) AS DepDisabled7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameLast END) AS DepLastName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameFirst END) AS DepFirstName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameMiddle END) AS DepMiddleName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameSuffix END) AS DepNameSuffix8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConSSN END) AS DepSsn8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConDateOfBirth END) AS DepDateOfBirth8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConGender END) AS DepGender8
            ,MAX(CASE WHEN Dep_Number = 8 THEN 
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partners'
                                        ELSE 'Child' END
                                    END) AS DepRelationship8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConIsDisabled END) AS DepDisabled8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameLast END) AS DepLastName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameFirst END) AS DepFirstName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameMiddle END) AS DepMiddleName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameSuffix END) AS DepNameSuffix9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConSSN END) AS DepSsn9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConDateOfBirth END) AS DepDateOfBirth9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConGender END) AS DepGender9
            ,MAX(CASE WHEN Dep_Number = 9 THEN 
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partners'
                                        ELSE 'Child' END
                                    END) AS DepRelationship9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConIsDisabled END) AS DepDisabled9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameLast END) AS DepLastName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameFirst END) AS DepFirstName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameMiddle END) AS DepMiddleName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameSuffix END) AS DepNameSuffix10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConSSN END) AS DepSsn10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConDateOfBirth END) AS DepDateOfBirth10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConGender END) AS DepGender10
            ,MAX(CASE WHEN Dep_Number = 10 THEN 
                                CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partners'
                                        ELSE 'Child' END
                                    END) AS DepRelationship10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConIsDisabled END) AS DepDisabled10
        INTO dbo.U_ETRUSTKWPM_DepLoop
        From (
                select ConEEID, 
                       ConNameLast, 
                       ConNameFirst, 
                       ConNameMiddle,
                       ConNameSuffix,
                       ConGender,
                       ConSSN, 
                       ConDateOfBirth, 
                       ConRelationship,
                       ConIsDisabled,
            
                       ROW_NUMBER() OVER
                        (PARTITION BY ConEEID ORDER BY ConImportID) AS 'Dep_Number'
                from Contacts
                JOIN dbo.U_ETRUSTKWPM_EEList WITH(NOLOCK)
                    ON xEEID = ConEEID
				JOIN dbo.U_dsi_bdm_DepDeductions WITH(NOLOCK)
					ON xEEID = dbnEEID
					AND xCOID = dbnCOID
					AND dbnValidForExport = 'Y'
					AND dbnFormatCode = @FormatCode
		            AND ConSystemID = dbnDepRecID
                where ConRelationship IN ('CHL', 'DCH', 'DPC', 'STC', 'SPS', 'DP')
                ) AS Source 
        Group By ConEEID

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    --IF OBJECT_ID('U_ETRUSTKWPM_PDedHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_ETRUSTKWPM_PDedHist;
    --SELECT DISTINCT
    --     PdhEEID
    --    -- Current Payroll Amounts
    --    ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
    --    -- YTD Payroll Amounts
    --    ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
    --    ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
    --    -- Categorize Payroll Amounts
    --    ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
    --    ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
    --    ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --    ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    --INTO dbo.U_ETRUSTKWPM_PDedHist
    --FROM dbo.PDedHist WITH (NOLOCK)
    --JOIN dbo.U_ETRUSTKWPM_DedList WITH (NOLOCK)
    --    ON DedCode = PdhDedCode
    --WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    --AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    --GROUP BY PdhEEID
    --HAVING (SUM(PdhEECurAmt) <> 0.00
    --    OR SUM(PdhERCurAmt) <> 0.00
    --);


    -------------------------------
    ---- Working Table - PEarHist
    -------------------------------
    --IF OBJECT_ID('U_ETRUSTKWPM_PEarHist','U') IS NOT NULL
    --    DROP TABLE dbo.U_ETRUSTKWPM_PEarHist;
    --SELECT DISTINCT
    --     PehEEID
    --    ,PrgPayDate             = MAX(PrgPayDate)
    --    -- Current Payroll Amount/Hours
    --    ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
    --    ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
    --    -- YTD Payroll Amount/Hours
    --    ,PehCurAmtYTD           = SUM(PehCurAmt)
    --    ,PehCurHrsYTD           = SUM(PehCurHrs)
    --    -- Current Include Deferred Comp Amount/Hours
    --    ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
    --    ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
    --    -- YTD Include Deferred Comp Amount/Hours
    --    ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    --    ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    --INTO dbo.U_ETRUSTKWPM_PEarHist
    --FROM dbo.vw_int_PayReg WITH (NOLOCK)
    --JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
    --    ON PehGenNumber = PrgGenNumber
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    --GROUP BY PehEEID
    --HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ETRUSTKWPM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ETRUSTKWPM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ETRUSTKWPM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,DATA_SET_INSTANCE_ID = EecEmpNo
        ,GROUP_ID = '2000000956'
        ,APPLICATION_IGO = EecEmpNo
        ,TRANS_TYPE = ''
        ,EE_FIRST_NAME = EepNameFirst
        ,EE_MIDDLE_NAME = EepNameMiddle
        ,EE_LAST_NAME = EepNameLast
        ,EE_SSN = EepSSN
        ,EE_SUBSCRIBER_ID = EecEmpNo
        ,EE_DOB = EepDateOfBirth
        ,EE_DOD = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN EecDateOfTermination END), 101), '')
        ,EE_PREFIX = ''
        ,EE_SUFFIX = EepNameSuffix
        ,EE_GENDER = EepGender
        ,EE_LANGUAGE_PREFERENCE = ''
        ,EE_MARITAL_STATUS = ''
        ,EE_STATUS = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'D' ELSE 'A' END
        ,EE_HOME_PHONE = EepPhoneHomeNumber
        ,EE_CELL_PHONE = ''
        ,EE_WORK_PHONE = ''
        ,EE_WORK_EXT = ''
        ,EE_EMAIL = EepAddressEmailAlternate
        --EepAddressEMail
        ,EE_WORK_EMAIL = EepAddressEMail  -- Check work email field and see mapping logic.
        ,EE_ADDRESS_TYPE = 'C'
        ,EE_ADDRESS_LINE_1 = REPLACE(EepAddressLine1, ',', '')
        ,EE_ADDRESS_LINE_2 = REPLACE(EepAddressLine2, ',', '')
        ,EE_ADDRESS_LINE_3 = ''
        ,EE_CITY = EepAddressCity
        ,EE_STATE = EepAddressState
        ,EE_ZIP = EepAddressZipCode
        ,EE_COUNTRY = 'US'
        ,EE_ADDRESS_EFF_DATE = ''
        ,EE_ADDRESS_SOURCE = ''
        ,EE_ACCOUNT_ID = '2000000956'
        ,EE_LOCATION_ID = ''
        ,EE_EMPLOYEE_ID = EecEmpNo
        ,EE_HIRE_DATE = EecDateOfLastHire
        ,EE_TERM_DATE = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END), 101), '')
        ,EE_TERM_REASON = CASE WHEN EecEmplStatus = 'T' THEN
                                CASE WHEN EecTermReason = '203' THEN 'DE'
                                        WHEN EecTermType = 'V' THEN 'Q'
                                        WHEN EecTermType <> 'V' AND EecTermReason <> '203' THEN 'DS'
                                        ELSE ''
                                    END
                                END
        ,EE_PAYROLL_CYCLE = 'Bi-Weekly, Second Friday (26)'
        ,EE_HOURS_PER_WEEK = CAST(CAST(EecScheduledWorkHrs / 2 AS DECIMAL(18,4)) AS VARCHAR)
        ,EE_SORT_GROUP = ''
        ,EE_CLASS_01_CLASS_CODE = ''
        ,EE_CLASS_01_PRODUCT = 'GCI'
        ,EE_CLASS_01_START_DATE = (SELECT MAX(EedBenStartDate) FROM dbo.u_dsi_bdm_EmpDeductions a WITH(NOLOCK) WHERE a.EedEEID = xEEID AND a.EedCOID = xCOID AND a.EedFormatCode = @FormatCode)
        ,EE_CLASS_01_STOP_DATE = (SELECT MAX(EedBenStopDate) FROM dbo.u_dsi_bdm_EmpDeductions a WITH(NOLOCK) WHERE a.EedEEID = xEEID AND a.EedCOID = xCOID AND a.EedFormatCode = @FormatCode)
        ,EE_CLASS_02_CLASS_CODE = ''
        ,EE_CLASS_02_PRODUCT = ''
        ,EE_CLASS_02_START_DATE = ''
        ,EE_CLASS_02_STOP_DATE = ''
        ,EE_CLASS_03_CLASS_CODE = ''
        ,EE_CLASS_03_PRODUCT = ''
        ,EE_CLASS_03_START_DATE = ''
        ,EE_CLASS_03_STOP_DATE = ''
        ,CERT_NUM = ''
        ,PLAN_CODE = '3962'
        ,BILLING_GROUP = 'KW Property Management'
        ,TIER = CASE WHEN EedBenOption IN ('EE', 'EENW', 'EEO') THEN 'Employee'
                        WHEN EedBenOption IN ('EEC', 'EECH', 'EECNW') THEN 'Employee & Child(ren)'
                        WHEN EedBenOption IN ('EEDP', 'EES', 'EESNW', 'EESP') THEN 'Employee & Spouse'
                        WHEN EedBenOption IN ('EEF', 'EEDPF', 'EEFNW', 'FAM') THEN 'Family' END
        --CASE WHEN t.is_crile = '1' and t.is_crill = '1' and t.is_crils = '1' then 'Family'
  --                  WHEN t.is_crile = '1' and t.is_crill = '1' and t.is_crils is null then 'Employee & Child(ren)'
  --                  WHEN t.is_crile = '1' and t.is_crils = '1' and t.is_crill is null then 'Employee & Spouse'
  --                  WHEN t.is_crile = '1' and t.is_crill is null and t.is_crils is null then 'Employee' END
        /*CASE WHEN EedDedCode IN ('CRILE', 'CRILL', 'CRILS') THEN 'Family'
                        WHEN EedDedCode = 'CRILE' THEN 'Employee'
                        WHEN EedDedCode IN ('CRILE', 'CRILL') THEN 'Employee & Child(ren)'
                        WHEN EedDedCode IN ('CRILE', 'CRILS') THEN 'Employee & Spouse' END*/
        ,EVENT_DATE = (SELECT MAX(EedBenStartDate) FROM dbo.u_dsi_bdm_EmpDeductions a WITH(NOLOCK) WHERE a.EedEEID = xEEID AND a.EedCOID = xCOID AND a.EedFormatCode = @FormatCode)
        ,APPLICATION_SIGN_DATE = (SELECT MAX(EedBenStartDate) FROM dbo.u_dsi_bdm_EmpDeductions a WITH(NOLOCK) WHERE a.EedEEID = xEEID AND a.EedCOID = xCOID AND a.EedFormatCode = @FormatCode)
        ,EFFECTIVE_DATE = (SELECT MAX(EedBenStartDate) FROM dbo.u_dsi_bdm_EmpDeductions a WITH(NOLOCK) WHERE a.EedEEID = xEEID AND a.EedCOID = xCOID AND a.EedFormatCode = @FormatCode)
        ,ISSUED_AGE = ''
        ,PRIMARY_BENEFIT_AMT = ''--CAST(CAST(crile.EedBenAmt AS DECIMAL(18,4)) AS VARCHAR)
        --CASE WHEN EedDedCode = 'CRILE' THEN CAST(CAST(EedBenAmt AS DECIMAL(18,4)) AS VARCHAR) END
        ,SPOUSE_BENEFIT_AMT = ''--CAST(CAST(crils.EedBenAmt AS DECIMAL(18,4)) AS VARCHAR)
        --CASE WHEN EedDedCode = 'CRILS' THEN CAST(CAST(EedBenAmt AS DECIMAL(18,4)) AS VARCHAR) END
        ,CHILD_BENEFIT_AMT = ''--CAST(CAST(crill.EedBenAmt AS DECIMAL(18,4)) AS VARCHAR)
        --CASE WHEN EedDedCode = 'CRILL' THEN CAST(CAST(EedBenAmt AS DECIMAL(18,4)) AS VARCHAR) END
        ,PRIMARY_SMOKER_STATUS = CASE WHEN EepIsSmoker = 'Y' THEN 'Y' ELSE 'N' END
        ,SPOUSE_SMOKER_STATUS = CASE WHEN ConRelationship = 'SPS' AND ConIsSmoker = 'Y' THEN 'Y'  
										WHEN ConRelationship = 'DP' AND ConIsSmoker = 'Y' THEN 'Y' ELSE 'N' END
        ,EOI_BYPASS = 'Y'
        ,PRIMARY_HEIGHT_FT = ''
        ,PRIMARY_HEIGHT_IN = ''
        ,PRIMARY_WEIGHT = ''
        ,PRIMARY_KO1 = ''
        ,PRIMARY_KO2 = ''
        ,PRIMARY_KO3 = ''
        ,PRIMARY_KO4 = ''
        ,PRIMARY_KO5 = ''
        ,PRIMARY_KO6 = ''
        ,SPOUSE_HEIGHT_FT = ''
        ,SPOUSE_HEIGHT_IN = ''
        ,SPOUSE_WEIGHT = ''
        ,SPOUSE_KO1 = ''
        ,SPOUSE_KO2 = ''
        ,SPOUSE_KO3 = ''
        ,SPOUSE_KO4 = ''
        ,SPOUSE_KO5 = ''
        ,SPOUSE_KO6 = ''
        ,TOTAL_NUM_DEPENDENTS = DepTotal --(SELECT COUNT(1) FROM dbo.u_dsi_bdm_DepDeductions a WITH(NOLOCK) WHERE a.DbnEEID = xEEID AND a.dbnCOID = xCOID AND a.DbnFormatCode = @FormatCode AND DbnDedCode IN ('CRILL', 'CRILS'))
        ,DEP1_FIRST_NAME = DepFirstName1
        ,DEP1_MIDDLE_NAME = DepMiddleName1
        ,DEP1_LAST_NAME = DepLastName1
        ,DEP1_UNIQUE_ID = ''
        ,DEP1_SSN = DepSSN1
        ,DEP1_DOB = DepDateOfBirth1
        ,DEP1_DOD = ''
        ,DEP1_PREFIX = ''
        ,DEP1_SUFFIX = DepNameSuffix1
        ,DEP1_GENDER = DepGender1
        ,DEP1_LANGUAGE_PREFERENCE = ''
        ,DEP1_MARITAL_STATUS = ''
        ,DEP1_MARRIAGE_DATE = ''
        ,DEP1_DIVORCE_DATE = ''
        ,DEP1_RELATION = DepRelationship1
        ,DEP1_DISABLED_INDIC = DepDisabled1
        ,DEP1_DISABLED_DATE = ''
        ,DEP1_STUDENT_INDIC = ''
        ,DEP1_ADDRESS_TYPE = ''
        ,DEP1_ADDRESS_LINE_1 = ''
        ,DEP1_ADDRESS_LINE_2 = ''
        ,DEP1_ADDRESS_LINE_3 = ''
        ,DEP1_CITY = ''
        ,DEP1_STATE = ''
        ,DEP1_ZIP = ''
        ,DEP1_COUNTRY = ''
        ,DEP1_ADDRESS_EFF_DATE = ''
        ,DEP1_ADDRESS_SOURCE = ''
        ,DEP2_FIRST_NAME = DepFirstName2
        ,DEP2_MIDDLE_NAME = DepMiddleName2
        ,DEP2_LAST_NAME = DepLastName2
        ,DEP2_UNIQUE_ID = ''
        ,DEP2_SSN = DepSSN2
        ,DEP2_DOB = DepDateOfBirth2
        ,DEP2_DOD = ''
        ,DEP2_PREFIX = ''
        ,DEP2_SUFFIX = DepNameSuffix2
        ,DEP2_GENDER = DepGender2
        ,DEP2_LANGUAGE_PREFERENCE = ''
        ,DEP2_MARITAL_STATUS = ''
        ,DEP2_MARRIAGE_DATE = ''
        ,DEP2_DIVORCE_DATE = ''
        ,DEP2_RELATION = DepRelationship2
        ,DEP2_DISABLED_INDIC = DepDisabled2
        ,DEP2_DISABLED_DATE = ''
        ,DEP2_STUDENT_INDIC = ''
        ,DEP2_ADDRESS_TYPE = ''
        ,DEP2_ADDRESS_LINE_1 = ''
        ,DEP2_ADDRESS_LINE_2 = ''
        ,DEP2_ADDRESS_LINE_3 = ''
        ,DEP2_CITY = ''
        ,DEP2_STATE = ''
        ,DEP2_ZIP = ''
        ,DEP2_COUNTRY = ''
        ,DEP2_ADDRESS_EFF_DATE = ''
        ,DEP2_ADDRESS_SOURCE = ''
        ,DEP3_FIRST_NAME = DepFirstName3
        ,DEP3_MIDDLE_NAME = DepMiddleName3
        ,DEP3_LAST_NAME = DepLastName3
        ,DEP3_UNIQUE_ID = ''
        ,DEP3_SSN = DepSSN3
        ,DEP3_DOB = DepDateOfBirth3
        ,DEP3_DOD = ''
        ,DEP3_PREFIX = ''
        ,DEP3_SUFFIX = DepNameSuffix3
        ,DEP3_GENDER = DepGender3
        ,DEP3_LANGUAGE_PREFERENCE = ''
        ,DEP3_MARITAL_STATUS = ''
        ,DEP3_MARRIAGE_DATE = ''
        ,DEP3_DIVORCE_DATE = ''
        ,DEP3_RELATION = DepRelationship3
        ,DEP3_DISABLED_INDIC = DepDisabled3
        ,DEP3_DISABLED_DATE = ''
        ,DEP3_STUDENT_INDIC = ''
        ,DEP3_ADDRESS_TYPE = ''
        ,DEP3_ADDRESS_LINE_1 = ''
        ,DEP3_ADDRESS_LINE_2 = ''
        ,DEP3_ADDRESS_LINE_3 = ''
        ,DEP3_CITY = ''
        ,DEP3_STATE = ''
        ,DEP3_ZIP = ''
        ,DEP3_COUNTRY = ''
        ,DEP3_ADDRESS_EFF_DATE = ''
        ,DEP3_ADDRESS_SOURCE = ''
        ,DEP4_FIRST_NAME = DepFirstName4
        ,DEP4_MIDDLE_NAME = DepMiddleName4
        ,DEP4_LAST_NAME = DepLastName4
        ,DEP4_UNIQUE_ID = ''
        ,DEP4_SSN = DepSSN4
        ,DEP4_DOB = DepDateOfBirth4
        ,DEP4_DOD = ''
        ,DEP4_PREFIX = ''
        ,DEP4_SUFFIX = DepNameSuffix4
        ,DEP4_GENDER = DepGender4
        ,DEP4_LANGUAGE_PREFERENCE = ''
        ,DEP4_MARITAL_STATUS = ''
        ,DEP4_MARRIAGE_DATE = ''
        ,DEP4_DIVORCE_DATE = ''
        ,DEP4_RELATION = DepRelationship4
        ,DEP4_DISABLED_INDIC = DepDisabled4
        ,DEP4_DISABLED_DATE = ''
        ,DEP4_STUDENT_INDIC = ''
        ,DEP4_ADDRESS_TYPE = ''
        ,DEP4_ADDRESS_LINE_1 = ''
        ,DEP4_ADDRESS_LINE_2 = ''
        ,DEP4_ADDRESS_LINE_3 = ''
        ,DEP4_CITY = ''
        ,DEP4_STATE = ''
        ,DEP4_ZIP = ''
        ,DEP4_COUNTRY = ''
        ,DEP4_ADDRESS_EFF_DATE = ''
        ,DEP4_ADDRESS_SOURCE = ''
        ,DEP5_FIRST_NAME = DepFirstName5
        ,DEP5_MIDDLE_NAME = DepMiddleName5
        ,DEP5_LAST_NAME = DepLastName5
        ,DEP5_UNIQUE_ID = ''
        ,DEP5_SSN = DepSSN5
        ,DEP5_DOB = DepDateOfBirth5
        ,DEP5_DOD = ''
        ,DEP5_PREFIX = ''
        ,DEP5_SUFFIX = DepNameSuffix5
        ,DEP5_GENDER = DepGender5
        ,DEP5_LANGUAGE_PREFERENCE = ''
        ,DEP5_MARITAL_STATUS = ''
        ,DEP5_MARRIAGE_DATE = ''
        ,DEP5_DIVORCE_DATE = ''
        ,DEP5_RELATION = DepRelationship5
        ,DEP5_DISABLED_INDIC = DepDisabled5
        ,DEP5_DISABLED_DATE = ''
        ,DEP5_STUDENT_INDIC = ''
        ,DEP5_ADDRESS_TYPE = ''
        ,DEP5_ADDRESS_LINE_1 = ''
        ,DEP5_ADDRESS_LINE_2 = ''
        ,DEP5_ADDRESS_LINE_3 = ''
        ,DEP5_CITY = ''
        ,DEP5_STATE = ''
        ,DEP5_ZIP = ''
        ,DEP5_COUNTRY = ''
        ,DEP5_ADDRESS_EFF_DATE = ''
        ,DEP5_ADDRESS_SOURCE = ''
        ,DEP6_FIRST_NAME = DepFirstName6
        ,DEP6_MIDDLE_NAME = DepMiddleName6
        ,DEP6_LAST_NAME = DepLastName6
        ,DEP6_UNIQUE_ID = ''
        ,DEP6_SSN = DepSSN6
        ,DEP6_DOB = DepDateOfBirth6
        ,DEP6_DOD = ''
        ,DEP6_PREFIX = ''
        ,DEP6_SUFFIX = DepNameSuffix6
        ,DEP6_GENDER = DepGender6
        ,DEP6_LANGUAGE_PREFERENCE = ''
        ,DEP6_MARITAL_STATUS = ''
        ,DEP6_MARRIAGE_DATE = ''
        ,DEP6_DIVORCE_DATE = ''
        ,DEP6_RELATION = DepRelationship6
        ,DEP6_DISABLED_INDIC = DepDisabled6
        ,DEP6_DISABLED_DATE = ''
        ,DEP6_STUDENT_INDIC = ''
        ,DEP6_ADDRESS_TYPE = ''
        ,DEP6_ADDRESS_LINE_1 = ''
        ,DEP6_ADDRESS_LINE_2 = ''
        ,DEP6_ADDRESS_LINE_3 = ''
        ,DEP6_CITY = ''
        ,DEP6_STATE = ''
        ,DEP6_ZIP = ''
        ,DEP6_COUNTRY = ''
        ,DEP6_ADDRESS_EFF_DATE = ''
        ,DEP6_ADDRESS_SOURCE = ''
        ,DEP7_FIRST_NAME = DepFirstName7
        ,DEP7_MIDDLE_NAME = DepMiddleName7
        ,DEP7_LAST_NAME = DepLastName7
        ,DEP7_UNIQUE_ID = ''
        ,DEP7_SSN = DepSSN7
        ,DEP7_DOB = DepDateOfBirth7
        ,DEP7_DOD = ''
        ,DEP7_PREFIX = ''
        ,DEP7_SUFFIX = DepNameSuffix7
        ,DEP7_GENDER = DepGender7
        ,DEP7_LANGUAGE_PREFERENCE = ''
        ,DEP7_MARITAL_STATUS = ''
        ,DEP7_MARRIAGE_DATE = ''
        ,DEP7_DIVORCE_DATE = ''
        ,DEP7_RELATION = DepRelationship7
        ,DEP7_DISABLED_INDIC = DepDisabled7
        ,DEP7_DISABLED_DATE = ''
        ,DEP7_STUDENT_INDIC = ''
        ,DEP7_ADDRESS_TYPE = ''
        ,DEP7_ADDRESS_LINE_1 = ''
        ,DEP7_ADDRESS_LINE_2 = ''
        ,DEP7_ADDRESS_LINE_3 = ''
        ,DEP7_CITY = ''
        ,DEP7_STATE = ''
        ,DEP7_ZIP = ''
        ,DEP7_COUNTRY = ''
        ,DEP7_ADDRESS_EFF_DATE = ''
        ,DEP7_ADDRESS_SOURCE = ''
        ,DEP8_FIRST_NAME = DepFirstName8
        ,DEP8_MIDDLE_NAME = DepMiddleName8
        ,DEP8_LAST_NAME = DepLastName8
        ,DEP8_UNIQUE_ID = ''
        ,DEP8_SSN = DepSSN8
        ,DEP8_DOB = DepDateOfBirth8
        ,DEP8_DOD = ''
        ,DEP8_PREFIX = ''
        ,DEP8_SUFFIX = DepNameSuffix8
        ,DEP8_GENDER = DepGender8
        ,DEP8_LANGUAGE_PREFERENCE = ''
        ,DEP8_MARITAL_STATUS = ''
        ,DEP8_MARRIAGE_DATE = ''
        ,DEP8_DIVORCE_DATE = ''
        ,DEP8_RELATION = DepRelationship8
        ,DEP8_DISABLED_INDIC = DepDisabled8
        ,DEP8_DISABLED_DATE = ''
        ,DEP8_STUDENT_INDIC = ''
        ,DEP8_ADDRESS_TYPE = ''
        ,DEP8_ADDRESS_LINE_1 = ''
        ,DEP8_ADDRESS_LINE_2 = ''
        ,DEP8_ADDRESS_LINE_3 = ''
        ,DEP8_CITY = ''
        ,DEP8_STATE = ''
        ,DEP8_ZIP = ''
        ,DEP8_COUNTRY = ''
        ,DEP8_ADDRESS_EFF_DATE = ''
        ,DEP8_ADDRESS_SOURCE = ''
        ,DEP9_FIRST_NAME = DepFirstName9
        ,DEP9_MIDDLE_NAME = DepMiddleName9
        ,DEP9_LAST_NAME = DepLastName9
        ,DEP9_UNIQUE_ID = ''
        ,DEP9_SSN = DepSSN9
        ,DEP9_DOB = DepDateOfBirth9
        ,DEP9_DOD = ''
        ,DEP9_PREFIX = ''
        ,DEP9_SUFFIX = DepNameSuffix9
        ,DEP9_GENDER = DepGender9
        ,DEP9_LANGUAGE_PREFERENCE = ''
        ,DEP9_MARITAL_STATUS = ''
        ,DEP9_MARRIAGE_DATE = ''
        ,DEP9_DIVORCE_DATE = ''
        ,DEP9_RELATION = DepRelationship9
        ,DEP9_DISABLED_INDIC = DepDisabled9
        ,DEP9_DISABLED_DATE = ''
        ,DEP9_STUDENT_INDIC = ''
        ,DEP9_ADDRESS_TYPE = ''
        ,DEP9_ADDRESS_LINE_1 = ''
        ,DEP9_ADDRESS_LINE_2 = ''
        ,DEP9_ADDRESS_LINE_3 = ''
        ,DEP9_CITY = ''
        ,DEP9_STATE = ''
        ,DEP9_ZIP = ''
        ,DEP9_COUNTRY = ''
        ,DEP9_ADDRESS_EFF_DATE = ''
        ,DEP9_ADDRESS_SOURCE = ''
        ,DEP10_FIRST_NAME = DepFirstName10
        ,DEP10_MIDDLE_NAME = DepMiddleName10
        ,DEP10_LAST_NAME = DepLastName10
        ,DEP10_UNIQUE_ID = ''
        ,DEP10_SSN = DepSSN10
        ,DEP10_DOB = DepDateOfBirth10
        ,DEP10_DOD = ''
        ,DEP10_PREFIX = ''
        ,DEP10_SUFFIX = DepNameSuffix10
        ,DEP10_GENDER = DepGender10
        ,DEP10_LANGUAGE_PREFERENCE = ''
        ,DEP10_MARITAL_STATUS = ''
        ,DEP10_MARRIAGE_DATE = ''
        ,DEP10_DIVORCE_DATE = ''
        ,DEP10_RELATION = DepRelationship10
        ,DEP10_DISABLED_INDIC = DepDisabled10
        ,DEP10_DISABLED_DATE = ''
        ,DEP10_STUDENT_INDIC = ''
        ,DEP10_ADDRESS_TYPE = ''
        ,DEP10_ADDRESS_LINE_1 = ''
        ,DEP10_ADDRESS_LINE_2 = ''
        ,DEP10_ADDRESS_LINE_3 = ''
        ,DEP10_CITY = ''
        ,DEP10_STATE = ''
        ,DEP10_ZIP = ''
        ,DEP10_COUNTRY = ''
        ,DEP10_ADDRESS_EFF_DATE = ''
        ,DEP10_ADDRESS_SOURCE = ''
        INTO dbo.U_ETRUSTKWPM_drvTbl
        FROM dbo.U_ETRUSTKWPM_EEList WITH(NOLOCK)
        JOIN dbo.EmpPers WITH(NOLOCK) 
        ON EepEEID = xEEID
        JOIN dbo.EmpComp WITH(NOLOCK) 
        ON xEEID = EecEEID AND xCOID = EecCOID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        AND EXISTS(select 1 from dbo.U_ETRUSTKWPM_Audit where  audEEID = xEEID AND audCOID = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
        --JOIN dbo.U_ETRUSTKWPM_Tier t WITH(NOLOCK)
        --ON t.teeid = xeeid and t.tcoid = xcoid
        JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID AND EedCOID = xCOID AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y' --AND EedFormatCode = @FormatCode*/
        --LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
        --            FROM dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
        --            WHERE EedDedcode = 'CRILE'
        --            GROUP BY EedEEID, EedCOID) crile on crile.eedeeid = xeeid and crile.eedcoid = xcoid
        --LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
        --            FROM dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
        --            WHERE EedDedcode = 'CRILS'
        --            GROUP BY EedEEID, EedCOID) crils on crils.eedeeid = xeeid and crils.eedcoid = xcoid
        --LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
        --            FROM dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
        --            WHERE EedDedcode = 'CRILL'
        --            GROUP BY EedEEID, EedCOID) crill on crill.eedeeid = xeeid and crill.eedcoid = xcoid
        LEFT JOIN dbo.U_dsi_bdm_DepDeductions WITH(NOLOCK)
        ON DbnEEID = xEEID AND DbnCOID = xCOID AND dbnFormatCode = @FormatCode AND dbnValidForExport = 'Y'
        LEFT JOIN dbo.Contacts WITH(NOLOCK)
        ON ConEEID = dbnEEID
        AND ConSystemID = dbnDepRecId
        LEFT JOIN dbo.U_ETRUSTKWPM_DepLoop 
        ON DepId = ConEEID
        LEFT JOIN dbo.U_ETRUSTKWPM_Audit 
        ON audEEID = xEEID AND audCOID = xCOID
        WHERE EecEEType <> 'TES'

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
ALTER VIEW dbo.dsi_vwETRUSTKWPM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ETRUSTKWPM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ETRUSTKWPM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202106301'
       ,expStartPerControl     = '202106301'
       ,expLastEndPerControl   = '202107079'
       ,expEndPerControl       = '202107079'
WHERE expFormatCode = 'ETRUSTKWPM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwETRUSTKWPM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ETRUSTKWPM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort