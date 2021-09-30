SET NOCOUNT ON;
IF OBJECT_ID('U_EVOY401WDP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVOY401WDP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EVOY401WDP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EVOY401WDP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEVOY401WDP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVOY401WDP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVOY401WDP_G10_BKP_2020_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOY401WDP_G10_BKP_2020_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVOY401WDP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOY401WDP];
GO
IF OBJECT_ID('U_EVOY401WDP_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_EVOY401WDP_PTaxHist];
GO
IF OBJECT_ID('U_EVOY401WDP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EVOY401WDP_PEarHist];
GO
IF OBJECT_ID('U_EVOY401WDP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EVOY401WDP_PDedHist];
GO
IF OBJECT_ID('U_EVOY401WDP_File') IS NOT NULL DROP TABLE [dbo].[U_EVOY401WDP_File];
GO
IF OBJECT_ID('U_EVOY401WDP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVOY401WDP_EEList];
GO
IF OBJECT_ID('U_EVOY401WDP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVOY401WDP_drvTbl];
GO
IF OBJECT_ID('U_EVOY401WDP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EVOY401WDP_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EVOY401WDP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EVOY401WDP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EVOY401WDP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EVOY401WDP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EVOY401WDP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EVOY401WDP','Voya Deferred Comp Census and Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','8000','S','N','EVOY401WDPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EVOY401WDP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RECORD TYPE"','1','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','1',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYER ID"','2','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','2',NULL,'EMPLOYER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAYROLL CYCLE "','3','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','3',NULL,'PAYROLL CYCLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAY DATE "','4','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','4',NULL,'PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IRS CODE"','5','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','5',NULL,'IRS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','6','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','6',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE NUMBER"','7','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','7',NULL,'EMPLOYEE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEPARTMENT CODE"','8','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','8',NULL,'DEPARTMENT CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOCATION CODE"','9','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','9',NULL,'LOCATION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','10','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','10',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','11','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','11',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MI"','12','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','12',NULL,'MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS LINE 1"','13','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','13',NULL,'ADDRESS LINE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADDRESS LINE 2"','14','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','14',NULL,'ADDRESS LINE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY"','15','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','15',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATE"','16','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','16',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP CODE"','17','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','17',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP EXTENSION"','18','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','18',NULL,'ZIP EXTENSION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','19','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','19',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RESERVED"','20','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','20',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MARITAL STATUS"','21','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','21',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE STATUS CODE"','22','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','22',NULL,'EMPLOYEE STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE OF BIRTH"','23','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','23',NULL,'DATE OF BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE OF ORIGINAL HIRE"','24','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','24',NULL,'DATE OF ORIGINAL HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE OF TERMINATION"','25','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','25',NULL,'DATE OF TERMINATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DATE OF REHIRE"','26','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','26',NULL,'DATE OF REHIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LEAVE OF ABSENCE START DATE"','27','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','27',NULL,'LEAVE OF ABSENCE START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LEAVE OF ABSENCE END DATE"','28','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','28',NULL,'LEAVE OF ABSENCE END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN YTD HOURS"','29','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','29',NULL,'PLAN YTD HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CURRENT PERIOD HOURS"','30','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','30',NULL,'CURRENT PERIOD HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ANNIVERSARY HOURS"','31','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','31',NULL,'ANNIVERSARY HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SOURCE CODE 1"','32','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','32',NULL,'SOURCE CODE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTRIBUTION AMOUNT SOURCE #  1"','33','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','33',NULL,'CONTRIBUTION AMOUNT SOURCE #  1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SOURCE CODE 2"','34','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','34',NULL,'SOURCE CODE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTRIBUTION AMOUNT SOURCE # 2"','35','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','35',NULL,'CONTRIBUTION AMOUNT SOURCE # 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SOURCE CODE 3"','36','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','36',NULL,'SOURCE CODE 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTRIBUTION AMOUNT SOURCE # 3"','37','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','37',NULL,'CONTRIBUTION AMOUNT SOURCE # 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SOURCE CODE 4"','38','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','38',NULL,'SOURCE CODE 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTRIBUTION AMOUNT SOURCE # 4"','39','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','39',NULL,'CONTRIBUTION AMOUNT SOURCE # 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SOURCE CODE 5"','40','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','40',NULL,'SOURCE CODE 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTRIBUTION AMOUNT SOURCE # 5"','41','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','41',NULL,'CONTRIBUTION AMOUNT SOURCE # 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SOURCE CODE 6"','42','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','42',NULL,'SOURCE CODE 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CONTRIBUTION AMOUNT SOURCE # 6"','43','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','43',NULL,'CONTRIBUTION AMOUNT SOURCE # 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOAN NUMBER"','44','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','44',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE LOAN PAYMENT"','45','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','45',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOAN NUMBER"','46','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','46',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE LOAN PAYMENT"','47','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','47',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOAN NUMBER"','48','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','48',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE LOAN PAYMENT"','49','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','49',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOAN NUMBER"','50','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','50',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE LOAN PAYMENT"','51','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','51',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOAN NUMBER"','52','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','52',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE LOAN PAYMENT"','53','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','53',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOAN NUMBER"','54','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','54',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE LOAN PAYMENT"','55','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','55',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UNION MEMBER"','56','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','56',NULL,'UNION MEMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE ELIGIBILITY CODE"','57','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','57',NULL,'EMPLOYEE ELIGIBILITY CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RESERVED"','58','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','58',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD GROSS COMPENSATION"','59','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','59',NULL,'YTD GROSS COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RESERVED"','60','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','60',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD TEST (ADP/ACP) COMPENSATION"','61','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','61',NULL,'YTD TEST (ADP/ACP) COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD ALLOCATION/BENEFIT COMPENSATION"','62','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','62',NULL,'YTD ALLOCATION/BENEFIT COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RESERVED"','63','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','63',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ANNUAL SALARY"','64','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','64',NULL,'ANNUAL SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MISCELLANEOUS COMPENSATION "','65','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','65',NULL,'MISCELLANEOUS COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RESERVED"','66','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','66',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RESERVED"','67','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','67',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"KEY EMPLOYEE INDICATOR"','68','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','68',NULL,'KEY EMPLOYEE INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RESERVED"','69','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','69',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RESERVED"','70','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','70',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HIGHLY COMPENSATED EMPLOYEE"','71','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','71',NULL,'HIGHLY COMPENSATED EMPLOYEE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NON-RESIDENT ALIEN?"','72','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','72',NULL,'NON-RESIDENT ALIEN?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RESERVED"','73','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','73',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAIL ADDRESS"','74','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','74',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TIER GROUP"','75','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','75',NULL,'TIER GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLIENT DATA 1"','76','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','76',NULL,'CLIENT DATA 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLIENT DATE 1"','77','(''DA''=''T,'')','EVOY401WDPZ0','50','H','01','77',NULL,'CLIENT DATE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FILLER"','78','(''DA''=''T'')','EVOY401WDPZ0','50','H','01','78',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','1',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERID"','2','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','2',NULL,'EMPLOYER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollCycle"','3','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','3',NULL,'PAYROLL CYCLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','4','(''UD112''=''T,'')','EVOY401WDPZ0','50','D','10','4',NULL,'PAY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIRSCode"','5','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','5',NULL,'IRS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','6',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','7','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','7',NULL,'EMPLOYEE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentCode"','8','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','8',NULL,'DEPARTMENT CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocCode"','9','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','9',NULL,'LOCATION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','10','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','10',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','11','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','11',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','12','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','12',NULL,'MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','13',NULL,'ADDRESS LINE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','14',NULL,'ADDRESS LINE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','15','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','15',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','16','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','16',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','17','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','17',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipExtension"','18','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','18',NULL,'ZIP EXTENSION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','19',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''T,'')','EVOY401WDPZ0','50','D','10','20',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','21','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','21',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatusCode"','22','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','22',NULL,'EMPLOYEE STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','23','(''UD112''=''T,'')','EVOY401WDPZ0','50','D','10','23',NULL,'DATE OF BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','24','(''UD112''=''T,'')','EVOY401WDPZ0','50','D','10','24',NULL,'DATE OF ORIGINAL HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','25','(''UD112''=''T,'')','EVOY401WDPZ0','50','D','10','25',NULL,'DATE OF TERMINATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfRehire"','26','(''UD112''=''T,'')','EVOY401WDPZ0','50','D','10','26',NULL,'DATE OF REHIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAStartDate"','27','(''UD112''=''T,'')','EVOY401WDPZ0','50','D','10','27',NULL,'LEAVE OF ABSENCE START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAEndDate"','28','(''UD112''=''T,'')','EVOY401WDPZ0','50','D','10','28',NULL,'LEAVE OF ABSENCE END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYTDHours"','29','(''UNT2''=''T,'')','EVOY401WDPZ0','50','D','10','29',NULL,'PLAN YTD HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentPeriodHours"','30','(''UNT2''=''T,'')','EVOY401WDPZ0','50','D','10','30',NULL,'CURRENT PERIOD HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnniversaryHrs"','31','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','31',NULL,'ANNIVERSARY HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceCode1"','32','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','32',NULL,'SOURCE CODE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt1"','33','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','33',NULL,'CONTRIBUTION AMOUNT SOURCE #  1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceCode2"','34','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','34',NULL,'SOURCE CODE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt2"','35','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','35',NULL,'CONTRIBUTION AMOUNT SOURCE # 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceCode3"','36','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','36',NULL,'SOURCE CODE 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt3"','37','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','37',NULL,'CONTRIBUTION AMOUNT SOURCE # 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceCode4"','38','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','38',NULL,'SOURCE CODE 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt4"','39','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','39',NULL,'CONTRIBUTION AMOUNT SOURCE # 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceCode5"','40','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','40',NULL,'SOURCE CODE 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt5"','41','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','41',NULL,'CONTRIBUTION AMOUNT SOURCE # 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSourceCode6"','42','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','42',NULL,'SOURCE CODE 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt6"','43','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','43',NULL,'CONTRIBUTION AMOUNT SOURCE # 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNum1"','44','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','44',NULL,'LOAN NUMBER 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELoanPmt1"','45','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','45',NULL,'EMPLOYEE LOAN PAYMENT 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNum2"','46','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','46',NULL,'LOAN NUMBER 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELoanPmt2"','47','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','47',NULL,'EMPLOYEE LOAN PAYMENT 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNum3"','48','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','48',NULL,'LOAN NUMBER 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELoanPmt3"','49','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','49',NULL,'EMPLOYEE LOAN PAYMENT 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNum4"','50','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','50',NULL,'LOAN NUMBER 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELoanPmt4"','51','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','51',NULL,'EMPLOYEE LOAN PAYMENT 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNum5"','52','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','52',NULL,'LOAN NUMBER 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELoanPmt5"','53','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','53',NULL,'EMPLOYEE LOAN PAYMENT 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNum6"','54','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','54',NULL,'LOAN NUMBER 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEELoanPmt6"','55','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','55',NULL,'EMPLOYEE LOAN PAYMENT 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionMember"','56','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','56',NULL,'UNION MEMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEEligCode"','57','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','57',NULL,'EMPLOYEE ELIGIBILITY CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''SS''=''T,'')','EVOY401WDPZ0','50','D','10','58',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDGrossCompensation"','59','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','59',NULL,'YTD GROSS COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''SS''=''T,'')','EVOY401WDPZ0','50','D','10','60',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTestComp"','61','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','61',NULL,'YTD TEST (ADP/ACP) COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDBenComp"','62','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','62',NULL,'YTD ALLOCATION/BENEFIT COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''SS''=''T,'')','EVOY401WDPZ0','50','D','10','63',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','64','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','64',NULL,'ANNUAL SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiscComp"','65','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','65',NULL,'MISCELLANEOUS COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''SS''=''T,'')','EVOY401WDPZ0','50','D','10','66',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''SS''=''T,'')','EVOY401WDPZ0','50','D','10','67',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEEInd"','68','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','68',NULL,'KEY EMPLOYEE INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''SS''=''T,'')','EVOY401WDPZ0','50','D','10','69',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''SS''=''T,'')','EVOY401WDPZ0','50','D','10','70',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHighlyCompensatedEmployee"','71','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','71',NULL,'HIGHLY COMPENSATED EMPLOYEE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNonResAlien"','72','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','72',NULL,'NON-RESIDENT ALIEN?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''SS''=''T,'')','EVOY401WDPZ0','50','D','10','73',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','74','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','74',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTierGroup"','75','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','75',NULL,'TIER GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientData"','76','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','76',NULL,'CLIENT DATA 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDate"','77','(''UA''=''T,'')','EVOY401WDPZ0','50','D','10','77',NULL,'CLIENT DATE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''SS''=''T'')','EVOY401WDPZ0','50','D','10','78',NULL,'FILLER',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EVOY401WDP_20210930.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201902049','EMPEXPORT','OEACTIVE',NULL,'EVOY401WDP',NULL,NULL,NULL,'201902049','Feb  4 2019 12:27PM','Feb  4 2019 12:27PM','201902041',NULL,'','','201902041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201902049','EMPEXPORT','OEPASSIVE',NULL,'EVOY401WDP',NULL,NULL,NULL,'201902049','Feb  4 2019 12:27PM','Feb  4 2019 12:27PM','201902041',NULL,'','','201902041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','LMJ6T',NULL,NULL,NULL,'Voya Deferred Comp Census and','202102162','EMPEXPORT','ONDEMAND','Mar  3 2021 11:22AM','EVOY401WDP',NULL,NULL,NULL,'202102162','Feb 16 2021 12:00AM','Feb 10 2021 12:00AM','202102162','119','eecPayGroup','W','202102162',dbo.fn_GetTimedKey(),NULL,'ULTI_WPWDP',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202107279','EMPEXPORT','TEST','Jul 27 2021  1:26PM','EVOY401WDP',NULL,NULL,NULL,'202107279','Jul 27 2021 12:00AM','Dec 30 1899 12:00AM','202107131','308','eecPayGroup','W','202107131',dbo.fn_GetTimedKey(),NULL,'us3jReWAS1010',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOY401WDP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOY401WDP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOY401WDP','InitialSort','C','drvEmpNo');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOY401WDP','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOY401WDP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EVOY401WDP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EVOY401WDP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EVOY401WDP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVOY401WDP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOY401WDP','D10','dbo.U_EVOY401WDP_drvTbl',NULL);
IF OBJECT_ID('U_EVOY401WDP_DedList') IS NULL
CREATE TABLE [dbo].[U_EVOY401WDP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EVOY401WDP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVOY401WDP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvEmpNo] char(9) NULL,
    [drvRecordType] varchar(7) NOT NULL,
    [drvERID] varchar(6) NOT NULL,
    [drvPayrollCycle] varchar(1) NULL,
    [drvPayDate] datetime NULL,
    [drvIRSCode] varchar(4) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvDepartmentCode] varchar(10) NULL,
    [drvLocCode] varchar(4) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(5) NULL,
    [drvZipExtension] varchar(4) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvEmployeeStatusCode] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvDateOfRehire] datetime NULL,
    [drvLOAStartDate] datetime NULL,
    [drvLOAEndDate] datetime NULL,
    [drvPlanYTDHours] decimal NULL,
    [drvCurrentPeriodHours] decimal NULL,
    [drvAnniversaryHrs] varchar(1) NOT NULL,
    [drvSourceCode1] varchar(1) NULL,
    [drvContributionAmt1] nvarchar(4000) NULL,
    [drvSourceCode2] varchar(1) NULL,
    [drvContributionAmt2] nvarchar(4000) NULL,
    [drvSourceCode3] varchar(1) NOT NULL,
    [drvContributionAmt3] varchar(1) NOT NULL,
    [drvSourceCode4] varchar(1) NOT NULL,
    [drvContributionAmt4] varchar(1) NOT NULL,
    [drvSourceCode5] varchar(1) NOT NULL,
    [drvContributionAmt5] varchar(1) NOT NULL,
    [drvSourceCode6] varchar(1) NOT NULL,
    [drvContributionAmt6] varchar(1) NOT NULL,
    [drvLoanNum1] varchar(1) NOT NULL,
    [drvEELoanPmt1] nvarchar(4000) NULL,
    [drvLoanNum2] varchar(1) NOT NULL,
    [drvEELoanPmt2] varchar(1) NOT NULL,
    [drvLoanNum3] varchar(1) NOT NULL,
    [drvEELoanPmt3] varchar(1) NOT NULL,
    [drvLoanNum4] varchar(1) NOT NULL,
    [drvEELoanPmt4] varchar(1) NOT NULL,
    [drvLoanNum5] varchar(1) NOT NULL,
    [drvEELoanPmt5] varchar(1) NOT NULL,
    [drvLoanNum6] varchar(1) NOT NULL,
    [drvEELoanPmt6] varchar(1) NOT NULL,
    [drvUnionMember] varchar(1) NOT NULL,
    [drvEEEligCode] varchar(1) NOT NULL,
    [drvYTDGrossCompensation] money NULL,
    [drvYTDTestComp] varchar(1) NOT NULL,
    [drvYTDBenComp] varchar(1) NOT NULL,
    [drvAnnualSalary] nvarchar(4000) NULL,
    [drvMiscComp] varchar(1) NOT NULL,
    [drvKeyEEInd] varchar(1) NOT NULL,
    [drvHighlyCompensatedEmployee] varchar(1) NOT NULL,
    [drvNonResAlien] varchar(1) NOT NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvTierGroup] varchar(1) NOT NULL,
    [drvClientData] varchar(1) NOT NULL,
    [drvClientDate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EVOY401WDP_EEList') IS NULL
CREATE TABLE [dbo].[U_EVOY401WDP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EVOY401WDP_File') IS NULL
CREATE TABLE [dbo].[U_EVOY401WDP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EVOY401WDP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EVOY401WDP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhPayDate] datetime NULL,
    [PdhCode1] varchar(1) NULL,
    [PdhSource1] numeric NULL,
    [PdhCode2] varchar(1) NULL,
    [PdhSource2] numeric NULL,
    [PdhLoan1] numeric NULL
);
IF OBJECT_ID('U_EVOY401WDP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EVOY401WDP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurHrs] decimal NULL,
    [PehCurHrsYTD] decimal NULL
);
IF OBJECT_ID('U_EVOY401WDP_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_EVOY401WDP_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PthCurGrossWagesYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOY401WDP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Wash Depot Holdings, Inc.

Created By: Kevin Castañeda
Business Analyst: Daniel Lindblom
Create Date: 05/08/2019
Service Request Number: SR-2019-00231449

Purpose: Voya Deferred Comp Census and Payroll Export

Revision History
----------------
Update By           Date           Request Num      Desc
Michael Chollet        01/30/2020     SF 16363412        Updated DrvTbl to include EEs with valid ben or deduction in PDedHist so last contribution is reported after termination

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVOY401WDP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVOY401WDP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVOY401WDP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVOY401WDP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVOY401WDP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOY401WDP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOY401WDP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOY401WDP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOY401WDP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EVOY401WDP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EVOY401WDP', @AllObjects = 'Y', @IsWeb = 'Y'

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
            --,@MinCovDate        DATETIME
            ,@PlanYearStart        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EVOY401WDP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        --,@MinCovDate      = '20160416'
        ,@PlanYearStart   = CASE WHEN SUBSTRING(EndPerControl,5,2) < 7 THEN CONVERT(VARCHAR (4),(LEFT(EndPerControl,4) - 1)) + '0701' 
                                ELSE LEFT(EndPerControl,4) + '0701' 
                                END
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EVOY401WDP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EVOY401WDP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401KP,401CP,ROTHP,ROTCP,401KL';

    IF OBJECT_ID('U_EVOY401WDP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EVOY401WDP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EVOY401WDP_DedList
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
    -- vw_int_PEarHist Working Table
    --==========================================
    IF OBJECT_ID('dbo.U_EVOY401WDP_PEarHist') IS NOT NULL 
        DROP TABLE dbo.U_EVOY401WDP_PEarHist
    SELECT 
         PehEEID
        ,PehCurHrs    = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehPerControl <= @EndPerControl AND PehInclInDefComp = 'Y' THEN PehCurHrs ELSE 0.00 END)
        ,PehCurHrsYTD = SUM(PehCurHrs)

    INTO dbo.U_EVOY401WDP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    AND PehEarnCode NOT IN ('FHOL','SICK','SICKC','SICKM','VAC','VACC')
    GROUP BY PehEEID
    HAVING SUM(PehCurHrs) <> 0.00;
    ;

    -----------------------------
    -- PDedHist Working Table
    -----------------------------
    IF OBJECT_ID('U_EVOY401WDP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EVOY401WDP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhPayDate = PdhPayDate
        -- Categorize Payroll Amounts
        ,PdhCode1     = MAX(CASE WHEN PdhDedCode IN ('401KP','401CP') THEN 'A' END )
        ,PdhSource1   = SUM(CASE WHEN PdhDedCode IN ('401KP','401CP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhCode2     = MAX(CASE WHEN PdhDedCode IN ('ROTHP','ROTCP')THEN 'G' END )
        ,PdhSource2   = SUM(CASE WHEN PdhDedCode IN ('ROTHP','ROTCP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoan1      = SUM(CASE WHEN PdhDedCode IN ('401KL') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
     
    INTO dbo.U_EVOY401WDP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EVOY401WDP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID,PdhPayDate
    HAVING (SUM(PdhEECurAmt) <> 0.00
         OR SUM(PdhERCurAmt) <> 0.00)
    ;

    --==========================================
    -- PTaxHist Working Table
    --==========================================
    IF OBJECT_ID('dbo.U_EVOY401WDP_PTaxHist') IS NOT NULL 
        DROP TABLE dbo.U_EVOY401WDP_PTaxHist
    SELECT 
         PthEEID
        ,PthCurGrossWagesYTD = SUM(PthCurGrossWages)
        
    INTO dbo.U_EVOY401WDP_PTaxHist
    FROM dbo.U_EVOY401WDP_EEList
    JOIN dbo.PTaxHist WITH (NOLOCK) 
        ON PthEEID = xEEID
        AND PthCoID = xCoID
    WHERE LEFT(PthPerControl,8) BETWEEN @PlanYearStart AND @EndDate
    GROUP BY PthEEID
;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EVOY401WDP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EVOY401WDP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVOY401WDP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvEmpNo = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'INGWIN6'
        ,drvERID = '815027'
        ,drvPayrollCycle = CASE EecPayPeriod
                               WHEN 'W' THEN '7'
                               WHEN 'S' THEN '5'
                               WHEN 'B' THEN '6'
                               WHEN 'M' THEN '4'
                           END
        ,drvPayDate = PdhPayDate
        ,drvIRSCode = '401K'
        ,drvSSN = EepSSN
        ,drvEmployeeNumber = EecEmpNo
        ,drvDepartmentCode = EecOrgLvl1
        ,drvLocCode = '0001'
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = LEFT(EepAddressZipCode,5)
        ,drvZipExtension = RIGHT(EepAddressZipCode,4)
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'S' END
        ,drvEmployeeStatusCode = CASE EecEmplStatus
                                     WHEN 'A' THEN 'A' 
                                     WHEN 'S' THEN 'S'
                                     WHEN 'R' THEN 'O'
                                     WHEN 'T' THEN CASE EecTermReason
                                                    WHEN '202' THEN 'R'
                                                    WHEN '203' THEN 'X'
                                                    ELSE 'T'
                                                    END
                                     WHEN 'L' THEN CASE EecLeaveReason WHEN '300' THEN 'M'
                                                    ELSE 'L'
                                                    END                                                                                                                           
                                 END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfTermination = EecDateOfTermination
        ,drvDateOfRehire = CASE WHEN EecDateOfLastHire > EecDateOfOriginalHire AND EecJobChangeReason = '101' THEN EecDateOfLastHire
                               ELSE NULL
                           END
        ,drvLOAStartDate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                            END
        ,drvLOAEndDate = CASE
                             WHEN EecEmplStatus = 'L'
                                 THEN (SELECT DATEADD(DAY,1,EshStatusStopDate) FROM dbo.EmpHStat WITH (NOLOCK)
                                       WHERE EshEEID = xEEID AND EshCoID = xCoID AND EshStatusStopDate = DATEADD(DAY,-1,EecEmplStatusStartDate) AND EshEmplStatus = 'L')
                         END
        ,drvPlanYTDHours = PehCurHrsYTD
        ,drvCurrentPeriodHours = CASE WHEN EecSalaryOrHourly = 'S' THEN 40 ELSE PehCurHrs END
        ,drvAnniversaryHrs = ''
        ,drvSourceCode1 = CASE WHEN PdhSource1 > 0 THEN PdhCode1 END
        ,drvContributionAmt1 = FORMAT(PdhSource1 * 100,'000000000')
        ,drvSourceCode2 = CASE WHEN PdhSource2 > 0 THEN PdhCode2 END
        ,drvContributionAmt2 = FORMAT(PdhSource2 * 100,'000000000')
        ,drvSourceCode3 = '' 
        ,drvContributionAmt3 = ''
        ,drvSourceCode4 = ''
        ,drvContributionAmt4 = ''
        ,drvSourceCode5 = ''
        ,drvContributionAmt5 = ''
        ,drvSourceCode6 = ''
        ,drvContributionAmt6 = ''
        ,drvLoanNum1 = ''
        ,drvEELoanPmt1 = FORMAT(PdhLoan1 * 100,'000000000')
        ,drvLoanNum2 = ''
        ,drvEELoanPmt2 = ''
        ,drvLoanNum3 = ''
        ,drvEELoanPmt3 = ''
        ,drvLoanNum4 = ''
        ,drvEELoanPmt4 = ''
        ,drvLoanNum5 = ''
        ,drvEELoanPmt5 = ''
        ,drvLoanNum6 = ''
        ,drvEELoanPmt6 = ''
        ,drvUnionMember = ''
        ,drvEEEligCode = 'Y'-- Y: > 21 and > 1000 Hrs from date of Hire starts on first of next quarter after completing requirements
        ,drvYTDGrossCompensation = PthCurGrossWagesYTD
        ,drvYTDTestComp = ''
        ,drvYTDBenComp = ''
        ,drvAnnualSalary = FORMAT(EecAnnSalary * 100,'000000000')
        ,drvMiscComp = ''
        ,drvKeyEEInd = ''
        ,drvHighlyCompensatedEmployee = '' --EecIsHighlyComp
        ,drvNonResAlien = ''
        ,drvAddressEmail = EepAddressEmail
        ,drvTierGroup = ''
        ,drvClientData = ''
        ,drvClientDate = ''
        
    INTO dbo.U_EVOY401WDP_drvTbl
    FROM dbo.U_EVOY401WDP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecEEType <> 'CON'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) -- 16363412 1/30/2020 MC Added LEFT
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_EVOY401WDP_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EVOY401WDP_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EVOY401WDP_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    WHERE EedEEID is not NULL or PdhEEID is not NULL -- 16363412 1/30/2020 MC Added WHERE Clause

    ;

    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_815027_Voya_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.PAY' + '.csv'
    --                              WHEN @ExportCode LIKE '%TEST%' THEN 'TEST_815027_Voya_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.PAY' + '.csv'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
    --                              ELSE '815027_Voya_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.PAY' + '.csv'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEVOY401WDP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EVOY401WDP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EVOY401WDP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201901281'
       ,expStartPerControl     = '201901281'
       ,expLastEndPerControl   = '201902049'
       ,expEndPerControl       = '201902049'
WHERE expFormatCode = 'EVOY401WDP';

**********************************************************************************/
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOY401WDP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Wash Depot Holdings, Inc.

Created By: Kevin Castañeda
Business Analyst: Daniel Lindblom
Create Date: 05/08/2019
Service Request Number: SR-2019-00231449

Purpose: Voya Deferred Comp Census and Payroll Export

Revision History
----------------
Update By           Date           Request Num      Desc
Michael Chollet        01/30/2020     SF 16363412        Updated DrvTbl to include EEs with valid ben or deduction in PDedHist so last contribution is reported after termination

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVOY401WDP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVOY401WDP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVOY401WDP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVOY401WDP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVOY401WDP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOY401WDP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOY401WDP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOY401WDP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOY401WDP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EVOY401WDP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EVOY401WDP', @AllObjects = 'Y', @IsWeb = 'Y'

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
            --,@MinCovDate        DATETIME
            ,@PlanYearStart        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EVOY401WDP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        --,@MinCovDate      = '20160416'
        ,@PlanYearStart   = CASE WHEN SUBSTRING(EndPerControl,5,2) < 7 THEN CONVERT(VARCHAR (4),(LEFT(EndPerControl,4) - 1)) + '0701' 
                                ELSE LEFT(EndPerControl,4) + '0701' 
                                END
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EVOY401WDP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EVOY401WDP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401KP,401CP,ROTHP,ROTCP,401KL';

    IF OBJECT_ID('U_EVOY401WDP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EVOY401WDP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EVOY401WDP_DedList
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
    -- PEarHist Working Table
    --==========================================
    IF OBJECT_ID('dbo.U_EVOY401WDP_PEarHist') IS NOT NULL 
        DROP TABLE dbo.U_EVOY401WDP_PEarHist
    SELECT 
         PehEEID
        ,PehCurHrs    = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehPerControl <= @EndPerControl AND PehInclInDefComp = 'Y' THEN PehCurHrs ELSE 0.00 END)
        ,PehCurHrsYTD = SUM(PehCurHrs)

    INTO dbo.U_EVOY401WDP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    AND PehEarnCode NOT IN ('FHOL','SICK','SICKC','SICKM','VAC','VACC')
    GROUP BY PehEEID
    HAVING SUM(PehCurHrs) <> 0.00;
    ;

    -----------------------------
    -- PDedHist Working Table
    -----------------------------
    IF OBJECT_ID('U_EVOY401WDP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EVOY401WDP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhPayDate = PdhPayDate
        -- Categorize Payroll Amounts
        ,PdhCode1     = MAX(CASE WHEN PdhDedCode IN ('401KP','401CP') THEN 'A' END )
        ,PdhSource1   = SUM(CASE WHEN PdhDedCode IN ('401KP','401CP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhCode2     = MAX(CASE WHEN PdhDedCode IN ('ROTHP','ROTCP')THEN 'G' END )
        ,PdhSource2   = SUM(CASE WHEN PdhDedCode IN ('ROTHP','ROTCP') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLoan1      = SUM(CASE WHEN PdhDedCode IN ('401KL') AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
     
    INTO dbo.U_EVOY401WDP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EVOY401WDP_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID,PdhPayDate
    HAVING (SUM(PdhEECurAmt) <> 0.00
         OR SUM(PdhERCurAmt) <> 0.00)
    ;

    --==========================================
    -- PTaxHist Working Table
    --==========================================
    IF OBJECT_ID('dbo.U_EVOY401WDP_PTaxHist') IS NOT NULL 
        DROP TABLE dbo.U_EVOY401WDP_PTaxHist
    SELECT 
         PthEEID
        ,PthCurGrossWagesYTD = SUM(PthCurGrossWages)
        
    INTO dbo.U_EVOY401WDP_PTaxHist
    FROM dbo.U_EVOY401WDP_EEList
    JOIN dbo.PTaxHist WITH (NOLOCK) 
        ON PthEEID = xEEID
        AND PthCoID = xCoID
    WHERE LEFT(PthPerControl,8) BETWEEN @PlanYearStart AND @EndDate
    GROUP BY PthEEID
;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EVOY401WDP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EVOY401WDP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVOY401WDP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvEmpNo = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'INGWIN6'
        ,drvERID = '815027'
        ,drvPayrollCycle = CASE EecPayPeriod
                               WHEN 'W' THEN '7'
                               WHEN 'S' THEN '5'
                               WHEN 'B' THEN '6'
                               WHEN 'M' THEN '4'
                           END
        ,drvPayDate = PdhPayDate
        ,drvIRSCode = '401K'
        ,drvSSN = EepSSN
        ,drvEmployeeNumber = EecEmpNo
        ,drvDepartmentCode = EecOrgLvl1
        ,drvLocCode = '0001'
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = LEFT(EepAddressZipCode,5)
        ,drvZipExtension = RIGHT(EepAddressZipCode,4)
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'S' END
        ,drvEmployeeStatusCode = CASE EecEmplStatus
                                     WHEN 'A' THEN 'A' 
                                     WHEN 'S' THEN 'S'
                                     WHEN 'R' THEN 'O'
                                     WHEN 'T' THEN CASE EecTermReason
                                                    WHEN '202' THEN 'R'
                                                    WHEN '203' THEN 'X'
                                                    ELSE 'T'
                                                    END
                                     WHEN 'L' THEN CASE EecLeaveReason WHEN '300' THEN 'M'
                                                    ELSE 'L'
                                                    END                                                                                                                           
                                 END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfTermination = EecDateOfTermination
        ,drvDateOfRehire = CASE WHEN EecDateOfLastHire > EecDateOfOriginalHire AND EecJobChangeReason = '101' THEN EecDateOfLastHire
                               ELSE NULL
                           END
        ,drvLOAStartDate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                            END
        ,drvLOAEndDate = CASE
                             WHEN EecEmplStatus = 'L'
                                 THEN (SELECT DATEADD(DAY,1,EshStatusStopDate) FROM dbo.EmpHStat WITH (NOLOCK)
                                       WHERE EshEEID = xEEID AND EshCoID = xCoID AND EshStatusStopDate = DATEADD(DAY,-1,EecEmplStatusStartDate) AND EshEmplStatus = 'L')
                         END
        ,drvPlanYTDHours = PehCurHrsYTD
        ,drvCurrentPeriodHours = CASE WHEN EecSalaryOrHourly = 'S' THEN 40 ELSE PehCurHrs END
        ,drvAnniversaryHrs = ''
        ,drvSourceCode1 = CASE WHEN PdhSource1 > 0 THEN PdhCode1 END
        ,drvContributionAmt1 = FORMAT(PdhSource1 * 100,'000000000')
        ,drvSourceCode2 = CASE WHEN PdhSource2 > 0 THEN PdhCode2 END
        ,drvContributionAmt2 = FORMAT(PdhSource2 * 100,'000000000')
        ,drvSourceCode3 = '' 
        ,drvContributionAmt3 = ''
        ,drvSourceCode4 = ''
        ,drvContributionAmt4 = ''
        ,drvSourceCode5 = ''
        ,drvContributionAmt5 = ''
        ,drvSourceCode6 = ''
        ,drvContributionAmt6 = ''
        ,drvLoanNum1 = ''
        ,drvEELoanPmt1 = FORMAT(PdhLoan1 * 100,'000000000')
        ,drvLoanNum2 = ''
        ,drvEELoanPmt2 = ''
        ,drvLoanNum3 = ''
        ,drvEELoanPmt3 = ''
        ,drvLoanNum4 = ''
        ,drvEELoanPmt4 = ''
        ,drvLoanNum5 = ''
        ,drvEELoanPmt5 = ''
        ,drvLoanNum6 = ''
        ,drvEELoanPmt6 = ''
        ,drvUnionMember = ''
        ,drvEEEligCode = 'Y'-- Y: > 21 and > 1000 Hrs from date of Hire starts on first of next quarter after completing requirements
        ,drvYTDGrossCompensation = PthCurGrossWagesYTD
        ,drvYTDTestComp = ''
        ,drvYTDBenComp = ''
        ,drvAnnualSalary = FORMAT(EecAnnSalary * 100,'000000000')
        ,drvMiscComp = ''
        ,drvKeyEEInd = ''
        ,drvHighlyCompensatedEmployee = '' --EecIsHighlyComp
        ,drvNonResAlien = ''
        ,drvAddressEmail = EepAddressEmail
        ,drvTierGroup = ''
        ,drvClientData = ''
        ,drvClientDate = ''
        
    INTO dbo.U_EVOY401WDP_drvTbl
    FROM dbo.U_EVOY401WDP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecEEType <> 'CON'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) -- 16363412 1/30/2020 MC Added LEFT
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_EVOY401WDP_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    LEFT JOIN dbo.U_EVOY401WDP_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_EVOY401WDP_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    WHERE EedEEID is not NULL or PdhEEID is not NULL -- 16363412 1/30/2020 MC Added WHERE Clause

    ;

    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_815027_Voya_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.PAY' + '.csv'
    --                              WHEN @ExportCode LIKE '%TEST%' THEN 'TEST_815027_Voya_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.PAY' + '.csv'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
    --                              ELSE '815027_Voya_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.PAY' + '.csv'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEVOY401WDP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EVOY401WDP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EVOY401WDP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201901281'
       ,expStartPerControl     = '201901281'
       ,expLastEndPerControl   = '201902049'
       ,expEndPerControl       = '201902049'
WHERE expFormatCode = 'EVOY401WDP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEVOY401WDP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EVOY401WDP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort