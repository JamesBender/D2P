SET NOCOUNT ON;
IF OBJECT_ID('U_ECIG3KWD2N_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIG3KWD2N_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECIG3KWD2N_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECIG3KWD2N' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECIG3KWD2N_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECIG3KWD2N_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIG3KWD2N_G10_BKP_2020_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIG3KWD2N_G10_BKP_2020_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECIG3KWD2N') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIG3KWD2N];
GO
IF OBJECT_ID('U_ECIG3KWD2N_File') IS NOT NULL DROP TABLE [dbo].[U_ECIG3KWD2N_File];
GO
IF OBJECT_ID('U_ECIG3KWD2N_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECIG3KWD2N_EEList];
GO
IF OBJECT_ID('U_ECIG3KWD2N_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECIG3KWD2N_DedList];
GO
IF OBJECT_ID('U_dsi_ECIG3KWD2N_trlTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECIG3KWD2N_trlTbl];
GO
IF OBJECT_ID('U_dsi_ECIG3KWD2N_KeyEmps') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECIG3KWD2N_KeyEmps];
GO
IF OBJECT_ID('U_dsi_ECIG3KWD2N_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECIG3KWD2N_hdrTbl];
GO
IF OBJECT_ID('U_dsi_ECIG3KWD2N_EarnHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECIG3KWD2N_EarnHist];
GO
IF OBJECT_ID('U_dsi_ECIG3KWD2N_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECIG3KWD2N_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECIG3KWD2N';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECIG3KWD2N';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECIG3KWD2N';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECIG3KWD2N';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECIG3KWD2N';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','ECIG3KWD2N','Cigna LADE Layout V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ECIG3KWD2NZ0','N',NULL,'C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECIG3KWD2N' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecId"','1','(''UA''=''F'')','ECIG3KWD2NZ0','2','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDUNS"','2','(''UA''=''F'')','ECIG3KWD2NZ0','15','H','01','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdOrTest"','3','(''UA''=''F'')','ECIG3KWD2NZ0','1','H','01','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDate"','4','(''UD112''=''F'')','ECIG3KWD2NZ0','8','H','01','19',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoName"','5','(''UA''=''F'')','ECIG3KWD2NZ0','35','H','01','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileType"','6','(''UA''=''F'')','ECIG3KWD2NZ0','1','H','01','62',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeReason"','7','(''UA''=''F'')','ECIG3KWD2NZ0','2','H','01','63',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisReason"','8','(''UA''=''F'')','ECIG3KWD2NZ0','1','H','01','65',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','9','(''SS''=''F'')','ECIG3KWD2NZ0','2935','H','01','66',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','2','(''UA''=''F'')','ECIG3KWD2NZ0','11','D','02','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','3','(''SS''=''F'')','ECIG3KWD2NZ0','10','D','02','21',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingLoc"','4','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','31',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyNo"','5','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupID"','6','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','44',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCode"','7','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','53',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassChangeDate"','8','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','56',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','9','(''SS''=''F'')','ECIG3KWD2NZ0','10','D','02','64',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','10','(''UA''=''F'')','ECIG3KWD2NZ0','35','D','02','74',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','11','(''UA''=''F'')','ECIG3KWD2NZ0','25','D','02','109',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','12','(''UA''=''F'')','ECIG3KWD2NZ0','15','D','02','134',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamePrefix"','13','(''UA''=''F'')','ECIG3KWD2NZ0','10','D','02','149',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','14','(''UA''=''F'')','ECIG3KWD2NZ0','10','D','02','159',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','15','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','169',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','16','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','177',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStat"','17','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','178',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPinNo"','18','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','179',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSmoker"','19','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','183',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail0"','20','(''UA''=''F'')','ECIG3KWD2NZ0','34','D','02','184',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','21','(''SS''=''F'')','ECIG3KWD2NZ0','1','D','02','218',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail1"','22','(''UA''=''F'')','ECIG3KWD2NZ0','34','D','02','219',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail1Type"','23','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','253',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail2"','24','(''UA''=''F'')','ECIG3KWD2NZ0','34','D','02','254',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail2Type"','25','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','288',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd1"','26','(''UA''=''F'')','ECIG3KWD2NZ0','35','D','02','289',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd2"','27','(''UA''=''F'')','ECIG3KWD2NZ0','35','D','02','324',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','28','(''UA''=''F'')','ECIG3KWD2NZ0','30','D','02','359',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','29','(''UA''=''F'')','ECIG3KWD2NZ0','2','D','02','389',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIP"','30','(''UA''=''F'')','ECIG3KWD2NZ0','10','D','02','391',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','31','(''UA''=''F'')','ECIG3KWD2NZ0','30','D','02','401',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','32','(''UA''=''F'')','ECIG3KWD2NZ0','2','D','02','431',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResidenceState"','33','(''UA''=''F'')','ECIG3KWD2NZ0','2','D','02','433',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvince"','34','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','435',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTypeOfAddr"','35','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','438',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressDate"','36','(''UA''=''F'')','ECIG3KWD2NZ0','8','D','02','439',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','37','(''UA''=''F'')','ECIG3KWD2NZ0','20','D','02','447',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneType"','38','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','467',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','39','(''SS''=''F'')','ECIG3KWD2NZ0','45','D','02','468',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','40','(''SS''=''F'')','ECIG3KWD2NZ0','2','D','02','513',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatus"','41','(''UA''=''F'')','ECIG3KWD2NZ0','2','D','02','515',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusDate"','42','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','517',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpType"','43','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','525',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','44','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','526',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvServiceDate"','45','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','534',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkLoc"','46','(''UA''=''F'')','ECIG3KWD2NZ0','20','D','02','542',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnSalary"','47','(''UN00''=''F'')','ECIG3KWD2NZ0','9','D','02','562',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisEarningsMode"','48','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','571',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisEarnings"','49','(''UN00''=''F'')','ECIG3KWD2NZ0','9','D','02','572',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsChgDate"','50','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','581',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalryInd"','51','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','589',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFT"','52','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','590',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBonusInd"','53','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','591',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWFHInd"','54','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','592',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExempt"','55','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','593',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWeek"','56','(''UN00''=''F'')','ECIG3KWD2NZ0','5','D','02','594',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxState"','57','(''UA''=''F'')','ECIG3KWD2NZ0','2','D','02','599',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationCode"','58','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','601',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobDesc"','59','(''UA''=''F'')','ECIG3KWD2NZ0','65','D','02','610',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCode"','60','(''UA''=''F'')','ECIG3KWD2NZ0','12','D','02','675',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgName"','61','(''UA''=''F'')','ECIG3KWD2NZ0','30','D','02','687',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgCode"','62','(''UA''=''F'')','ECIG3KWD2NZ0','15','D','02','717',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocCode"','63','(''UA''=''F'')','ECIG3KWD2NZ0','12','D','02','732',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionNo"','64','(''UA''=''F'')','ECIG3KWD2NZ0','10','D','02','744',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionName"','65','(''UA''=''F'')','ECIG3KWD2NZ0','30','D','02','754',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionInd"','66','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','784',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthPlanType"','67','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','785',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthPlanDesc"','68','(''UA''=''F'')','ECIG3KWD2NZ0','30','D','02','786',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccruedSickTime"','69','(''UA''=''F'')','ECIG3KWD2NZ0','6','D','02','816',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmp"','70','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','822',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccrualAnnHrs"','71','(''UN00''=''F'')','ECIG3KWD2NZ0','4','D','02','823',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','72','(''UA''=''F'')','ECIG3KWD2NZ0','2','D','02','827',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','73','(''SS''=''F'')','ECIG3KWD2NZ0','50','D','02','829',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaintReason"','74','(''UA''=''F'')','ECIG3KWD2NZ0','2','D','02','879',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaintDate"','75','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','881',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSSN"','76','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','889',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSNameLast"','77','(''UA''=''F'')','ECIG3KWD2NZ0','35','D','02','898',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSNameFirst"','78','(''UA''=''F'')','ECIG3KWD2NZ0','25','D','02','933',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSNameMiddle"','79','(''UA''=''F'')','ECIG3KWD2NZ0','15','D','02','958',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPrefix"','80','(''UA''=''F'')','ECIG3KWD2NZ0','10','D','02','973',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSuffix"','81','(''UA''=''F'')','ECIG3KWD2NZ0','10','D','02','983',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSDOB"','82','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','993',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSGender"','83','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1001',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSmoker"','84','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1002',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','85','(''SS''=''F'')','ECIG3KWD2NZ0','20','D','02','1003',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofDisProducts"','86','(''UA''=''F'')','ECIG3KWD2NZ0','2','D','02','1023',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisCovCode1"','87','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1025',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','88','(''SS''=''F'')','ECIG3KWD2NZ0','9','D','02','1029',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol1"','89','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','1038',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber1"','90','(''UA''=''F'')','ECIG3KWD2NZ0','7','D','02','1041',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvEffDate1"','91','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','1048',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPct1"','92','(''UA''=''F'')','ECIG3KWD2NZ0','5','D','02','1056',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenAmt1"','93','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1061',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContrPct1"','94','(''UA''=''F'')','ECIG3KWD2NZ0','5','D','02','1070',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate1"','95','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','1075',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxInd1"','96','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1083',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenDesc1"','97','(''UA''=''F'')','ECIG3KWD2NZ0','30','D','02','1084',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','98','(''SS''=''F'')','ECIG3KWD2NZ0','30','D','02','1114',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisCovCode2"','99','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1144',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','100','(''SS''=''F'')','ECIG3KWD2NZ0','9','D','02','1148',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol2"','101','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','1157',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber2"','102','(''UA''=''F'')','ECIG3KWD2NZ0','7','D','02','1160',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvEffDate2"','103','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','1167',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPct2"','104','(''UA''=''F'')','ECIG3KWD2NZ0','5','D','02','1175',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenAmt2"','105','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1180',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContrPct2"','106','(''UA''=''F'')','ECIG3KWD2NZ0','5','D','02','1189',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate2"','107','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','1194',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxInd2"','108','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1202',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenDesc2"','109','(''UA''=''F'')','ECIG3KWD2NZ0','30','D','02','1203',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','110','(''SS''=''F'')','ECIG3KWD2NZ0','30','D','02','1233',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisCovCode3"','111','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1263',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','112','(''SS''=''F'')','ECIG3KWD2NZ0','9','D','02','1267',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol3"','113','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','1276',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber3"','114','(''UA''=''F'')','ECIG3KWD2NZ0','7','D','02','1279',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvEffDate3"','115','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','1286',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPct3"','116','(''UA''=''F'')','ECIG3KWD2NZ0','5','D','02','1294',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenAmt3"','117','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1299',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContrPct3"','118','(''UA''=''F'')','ECIG3KWD2NZ0','5','D','02','1308',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate3"','119','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','1313',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxInd3"','120','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1321',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenDesc3"','121','(''UA''=''F'')','ECIG3KWD2NZ0','30','D','02','1322',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','122','(''SS''=''F'')','ECIG3KWD2NZ0','30','D','02','1352',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisCovCode4"','123','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1382',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','124','(''SS''=''F'')','ECIG3KWD2NZ0','9','D','02','1386',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicySymbol4"','125','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','1395',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNumber4"','126','(''UA''=''F'')','ECIG3KWD2NZ0','7','D','02','1398',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvEffDate4"','127','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','1405',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPct4"','128','(''UA''=''F'')','ECIG3KWD2NZ0','5','D','02','1413',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenAmt4"','129','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1418',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContrPct4"','130','(''UA''=''F'')','ECIG3KWD2NZ0','5','D','02','1427',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate4"','131','(''UD112''=''F'')','ECIG3KWD2NZ0','8','D','02','1432',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxInd4"','132','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1440',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenDesc4"','133','(''UA''=''F'')','ECIG3KWD2NZ0','30','D','02','1441',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','134','(''SS''=''F'')','ECIG3KWD2NZ0','30','D','02','1471',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofLifeProds"','135','(''UA''=''F'')','ECIG3KWD2NZ0','2','D','02','1501',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLProdCode1"','136','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','1503',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPolicySymbol1"','137','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','1506',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPolicyNumber1"','138','(''UA''=''F'')','ECIG3KWD2NZ0','6','D','02','1509',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLAssignmentInd1"','139','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1515',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrevAmt1"','140','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1516',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrevSalMultiple1"','141','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1525',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePrevAmt1"','142','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1529',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPrevAmt1"','143','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1538',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmt1"','144','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1547',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedSalMult1"','145','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1556',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseIssuedAmt1"','146','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1560',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmt1"','147','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1569',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedAmt1"','148','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1578',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedSalMult1"','149','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1587',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAppliedAmt1"','150','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1591',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildAppliedAmt1"','151','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1600',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingAmt1"','152','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1609',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingSalMult1"','153','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1618',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePendingAmt1"','154','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1622',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPendingAmt1"','155','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1631',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMontlyCashAccumFundAmt1"','156','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1640',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseMoCashAccumFundAmt1"','157','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1649',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAIOInd1"','158','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1658',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpADDADBInd1"','159','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1659',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseADDADBInd1"','160','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1660',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAPBInd1"','161','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1661',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAPBInd1"','162','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1662',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPAIPlanOpt1"','163','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1663',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','164','(''SS''=''F'')','ECIG3KWD2NZ0','20','D','02','1664',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLProdCode2"','165','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','1684',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPolicySymbol2"','166','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','1687',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPolicyNumber2"','167','(''UA''=''F'')','ECIG3KWD2NZ0','6','D','02','1690',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLAssignmentInd2"','168','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1696',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrevAmt2"','169','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1697',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrevSalMultiple2"','170','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1706',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePrevAmt2"','171','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1710',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPrevAmt2"','172','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1719',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmt2"','173','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1728',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedSalMult2"','174','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1737',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseIssuedAmt2"','175','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1741',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmt2"','176','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1750',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedAmt2"','177','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1759',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedSalMult2"','178','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1768',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAppliedAmt2"','179','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1772',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildAppliedAmt2"','180','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1781',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingAmt2"','181','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1790',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingSalMult2"','182','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1799',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePendingAmt2"','183','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1803',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPendingAmt2"','184','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1812',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMontlyCashAccumFundAmt2"','185','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1821',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseMoCashAccumFundAmt2"','186','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1830',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAIOInd2"','187','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1839',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpADDADBInd2"','188','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1840',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseADDADBInd2"','189','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1841',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAPBInd2"','190','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1842',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAPBInd2"','191','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1843',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPAIPlanOpt2"','192','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1844',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','193','(''SS''=''F'')','ECIG3KWD2NZ0','20','D','02','1845',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLProdCode3"','194','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','1865',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPolicySymbol3"','195','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','1868',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPolicyNumber3"','196','(''UA''=''F'')','ECIG3KWD2NZ0','6','D','02','1871',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLAssignmentInd3"','197','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','1877',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrevAmt3"','198','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1878',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrevSalMultiple3"','199','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1887',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePrevAmt3"','200','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1891',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPrevAmt3"','201','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1900',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmt3"','202','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1909',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedSalMult3"','203','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1918',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseIssuedAmt3"','204','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1922',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmt3"','205','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1931',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedAmt3"','206','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1940',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedSalMult3"','207','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1949',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAppliedAmt3"','208','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1953',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildAppliedAmt3"','209','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1962',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingAmt3"','210','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1971',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingSalMult3"','211','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','1980',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePendingAmt3"','212','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1984',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPendingAmt3"','213','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','1993',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMontlyCashAccumFundAmt3"','214','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2002',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseMoCashAccumFundAmt3"','215','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2011',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAIOInd3"','216','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2020',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpADDADBInd3"','217','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2021',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseADDADBInd3"','218','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2022',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAPBInd3"','219','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2023',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAPBInd3"','220','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2024',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPAIPlanOpt3"','221','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2025',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','222','(''SS''=''F'')','ECIG3KWD2NZ0','20','D','02','2026',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLProdCode4"','223','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','2046',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPolicySymbol4"','224','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','2049',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPolicyNumber4"','225','(''UA''=''F'')','ECIG3KWD2NZ0','6','D','02','2052',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLAssignmentInd4"','226','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2058',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrevAmt4"','227','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2059',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrevSalMultiple4"','228','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','2068',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePrevAmt4"','229','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2072',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPrevAmt4"','230','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2081',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmt4"','231','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2090',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedSalMult4"','232','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','2099',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseIssuedAmt4"','233','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2103',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmt4"','234','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2112',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedAmt4"','235','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2121',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedSalMult4"','236','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','2130',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAppliedAmt14"','237','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2134',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildAppliedAmt4"','238','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2143',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingAmt4"','239','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2152',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingSalMult4"','240','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','2161',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePendingAmt4"','241','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2165',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPendingAmt4"','242','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2174',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMontlyCashAccumFundAmt4"','243','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2183',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseMoCashAccumFundAmt4"','244','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2192',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAIOInd4"','245','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2201',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpADDADBInd4"','246','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2202',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseADDADBInd4"','247','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2203',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAPBInd4"','248','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2204',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAPBInd4"','249','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2205',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPAIPlanOpt4"','250','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2206',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','251','(''SS''=''F'')','ECIG3KWD2NZ0','20','D','02','2207',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLProdCode5"','252','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','2227',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPolicySymbol5"','253','(''UA''=''F'')','ECIG3KWD2NZ0','3','D','02','2230',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLPolicyNumber5"','254','(''UA''=''F'')','ECIG3KWD2NZ0','6','D','02','2233',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLAssignmentInd5"','255','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2239',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrevAmt5"','256','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2240',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPrevSalMultiple5"','257','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','2249',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePrevAmt5"','258','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2253',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPrevAmt5"','259','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2262',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedAmt5"','260','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2271',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIssuedSalMult5"','261','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','2280',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseIssuedAmt5"','262','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2284',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildIssuedAmt5"','263','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2293',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedAmt5"','264','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2302',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAppliedSalMult5"','265','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','2311',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAppliedAmt5"','266','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2315',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildAppliedAmt5"','267','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2324',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingAmt5"','268','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2333',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPendingSalMult5"','269','(''UA''=''F'')','ECIG3KWD2NZ0','4','D','02','2342',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpousePendingAmt5"','270','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2346',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildPendingAmt5"','271','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2355',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMontlyCashAccumFundAmt5"','272','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2364',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseMoCashAccumFundAmt5"','273','(''UA''=''F'')','ECIG3KWD2NZ0','9','D','02','2373',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAIOInd5"','274','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2382',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpADDADBInd5"','275','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2383',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseADDADBInd5"','276','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2384',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAPBInd5"','277','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2385',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseAPBInd5"','278','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2386',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPAIPlanOpt5"','279','(''UA''=''F'')','ECIG3KWD2NZ0','1','D','02','2387',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','280','(''SS''=''F'')','ECIG3KWD2NZ0','20','D','02','2388',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','281','(''SS''=''F'')','ECIG3KWD2NZ0','443','D','02','2408',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExtendedEmail"','282','(''UA''=''F'')','ECIG3KWD2NZ0','50','D','02','2851',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExtendedEmail2"','283','(''UA''=''F'')','ECIG3KWD2NZ0','50','D','02','2901',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExtendedEmail1"','284','(''UA''=''F'')','ECIG3KWD2NZ0','50','D','02','2951',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrlInd"','1','(''UA''=''F'')','ECIG3KWD2NZ0','2','T','03','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDUNSNoTrl"','2','(''UA''=''F'')','ECIG3KWD2NZ0','15','T','03','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','3','(''SS''=''F'')','ECIG3KWD2NZ0','1','T','03','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecCount"','4','(''UN00''=''F'')','ECIG3KWD2NZ0','9','T','03','19',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','5','(''SS''=''F'')','ECIG3KWD2NZ0','2973','T','03','28',NULL,NULL,NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECIG3KWD2N_20210120.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','IAGFG,X3MS9',NULL,NULL,NULL,'CIGNA Disability Life ADD','201802099','EMPEXPORT','ECIG3KWD2N','Feb 16 2018 12:00AM','ECIG3KWD2N',NULL,NULL,NULL,'202101159','Feb  9 2018 12:00AM','Dec 30 1899 12:00AM','202101081','362','','','201802021',dbo.fn_GetTimedKey(),NULL,'ULTI_WPWADEN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'CIGNA OE','201204239','EMPEXPORT','EGICOE','Apr 23 2012 12:00AM','ECIG3KWD2N',NULL,NULL,NULL,'201204239','Apr 23 2012 12:00AM','Dec 30 1899 12:00AM','201204231','777','','','201204231',dbo.fn_GetTimedKey(),NULL,'ULTI_WPWADEN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'CIGNA test','202101091','EMPEXPORT','ETEST','Jan  9 2021  6:15PM','ECIG3KWD2N',NULL,NULL,NULL,'202101091','Jan  9 2021 12:00AM','Dec 30 1899 12:00AM','202101011','3','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3cPeWAS1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'unlock CIGNA','201204239','EMPEXPORT','ZAP','Apr 23 2012 12:00AM','ECIG3KWD2N',NULL,NULL,NULL,'201204239','Apr 23 2012 12:00AM','Dec 30 1899 12:00AM','201204231',NULL,'','','201204231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIG3KWD2N','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIG3KWD2N','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIG3KWD2N','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIG3KWD2N','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIG3KWD2N','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECIG3KWD2N','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECIG3KWD2N' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECIG3KWD2N' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECIG3KWD2N_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECIG3KWD2N_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIG3KWD2N','H01','dbo.U_dsi_ECIG3KWD2N_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIG3KWD2N','D02','dbo.U_dsi_ECIG3KWD2N_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECIG3KWD2N','T03','dbo.U_dsi_ECIG3KWD2N_trlTbl',NULL);
IF OBJECT_ID('U_dsi_ECIG3KWD2N_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ECIG3KWD2N_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvBillingLoc] varchar(4) NOT NULL,
    [drvCompanyNo] varchar(9) NOT NULL,
    [drvGroupID] varchar(9) NOT NULL,
    [drvClassCode] varchar(3) NOT NULL,
    [drvClassChangeDate] int NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNamePrefix] varchar(1) NOT NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvDOB] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStat] varchar(1) NULL,
    [drvPinNo] varchar(1) NOT NULL,
    [drvSmoker] varchar(1) NOT NULL,
    [drvEmail0] varchar(1) NOT NULL,
    [drvEmail1] varchar(1) NOT NULL,
    [drvEmail1Type] varchar(1) NOT NULL,
    [drvEmail2] varchar(1) NOT NULL,
    [drvEmail2Type] varchar(1) NOT NULL,
    [drvAdd1] varchar(255) NULL,
    [drvAdd2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZIP] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvResidenceState] varchar(255) NULL,
    [drvProvince] varchar(1) NOT NULL,
    [drvTypeOfAddr] varchar(1) NOT NULL,
    [drvAddressDate] varchar(1) NOT NULL,
    [drvPhone] varchar(1) NOT NULL,
    [drvPhoneType] varchar(1) NOT NULL,
    [drvEmpStatus] varchar(2) NOT NULL,
    [drvStatusDate] datetime NULL,
    [drvEmpType] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvServiceDate] datetime NULL,
    [drvWorkLoc] varchar(1) NOT NULL,
    [drvAnnSalary] money NULL,
    [drvDisEarningsMode] varchar(1) NOT NULL,
    [drvDisEarnings] money NULL,
    [drvEarningsChgDate] varchar(1) NOT NULL,
    [drvSalryInd] varchar(1) NOT NULL,
    [drvFT] varchar(1) NOT NULL,
    [drvBonusInd] varchar(1) NOT NULL,
    [drvWFHInd] varchar(1) NOT NULL,
    [drvExempt] varchar(1) NOT NULL,
    [drvHrsWeek] char(20) NULL,
    [drvTaxState] varchar(255) NULL,
    [drvOccupationCode] varchar(1) NOT NULL,
    [drvJobDesc] varchar(1) NOT NULL,
    [drvJobCode] varchar(1) NOT NULL,
    [drvOrgName] varchar(1) NOT NULL,
    [drvOrgCode] varchar(1) NOT NULL,
    [drvLocCode] varchar(1) NOT NULL,
    [drvUnionNo] varchar(1) NOT NULL,
    [drvUnionName] varchar(1) NOT NULL,
    [drvUnionInd] varchar(1) NOT NULL,
    [drvHealthPlanType] varchar(1) NOT NULL,
    [drvHealthPlanDesc] varchar(1) NOT NULL,
    [drvAccruedSickTime] varchar(1) NOT NULL,
    [drvKeyEmp] varchar(1) NOT NULL,
    [drvAccrualAnnHrs] decimal NULL,
    [drvWorkState] char(2) NULL,
    [drvMaintReason] varchar(1) NOT NULL,
    [drvMaintDate] varchar(1) NOT NULL,
    [drvSpouseSSN] varchar(1) NOT NULL,
    [drvSNameLast] varchar(1) NOT NULL,
    [drvSNameFirst] varchar(1) NOT NULL,
    [drvSNameMiddle] varchar(1) NOT NULL,
    [drvSPrefix] varchar(1) NOT NULL,
    [drvSSuffix] varchar(1) NOT NULL,
    [drvSDOB] varchar(1) NOT NULL,
    [drvSGender] varchar(1) NOT NULL,
    [drvSSmoker] varchar(1) NOT NULL,
    [drvNumberofDisProducts] varchar(2) NOT NULL,
    [drvDisCovCode1] varchar(3) NULL,
    [drvPolicySymbol1] varchar(2) NULL,
    [drvPolicyNumber1] varchar(7) NULL,
    [drvProvEffDate1] datetime NULL,
    [drvBenPct1] varchar(5) NULL,
    [drvBenAmt1] varchar(1) NULL,
    [drvEmpContrPct1] varchar(5) NULL,
    [drvEffDate1] varchar(1) NOT NULL,
    [drvPostTaxInd1] varchar(1) NULL,
    [drvBenDesc1] varchar(1) NOT NULL,
    [drvDisCovCode2] varchar(3) NOT NULL,
    [drvPolicySymbol2] varchar(2) NOT NULL,
    [drvPolicyNumber2] varchar(7) NOT NULL,
    [drvProvEffDate2] datetime NULL,
    [drvBenPct2] varchar(5) NOT NULL,
    [drvBenAmt2] varchar(1) NOT NULL,
    [drvEmpContrPct2] varchar(5) NOT NULL,
    [drvEffDate2] varchar(1) NOT NULL,
    [drvPostTaxInd2] varchar(1) NOT NULL,
    [drvBenDesc2] varchar(1) NOT NULL,
    [drvDisCovCode3] varchar(4) NULL,
    [drvPolicySymbol3] varchar(3) NULL,
    [drvPolicyNumber3] varchar(7) NULL,
    [drvProvEffDate3] int NULL,
    [drvBenPct3] varchar(5) NULL,
    [drvBenAmt3] varchar(1) NULL,
    [drvEmpContrPct3] varchar(5) NULL,
    [drvEffDate3] varchar(1) NOT NULL,
    [drvPostTaxInd3] varchar(1) NULL,
    [drvBenDesc3] varchar(1) NOT NULL,
    [drvDisCovCode4] varchar(1) NOT NULL,
    [drvPolicySymbol4] varchar(1) NOT NULL,
    [drvPolicyNumber4] varchar(1) NOT NULL,
    [drvProvEffDate4] varchar(1) NOT NULL,
    [drvBenPct4] varchar(1) NOT NULL,
    [drvBenAmt4] varchar(1) NOT NULL,
    [drvEmpContrPct4] varchar(1) NOT NULL,
    [drvEffDate4] varchar(1) NOT NULL,
    [drvPostTaxInd4] varchar(1) NOT NULL,
    [drvBenDesc4] varchar(1) NOT NULL,
    [drvNumberofLifeProds] varchar(1) NOT NULL,
    [drvLProdCode1] varchar(1) NOT NULL,
    [drvLPolicySymbol1] varchar(1) NOT NULL,
    [drvLPolicyNumber1] varchar(1) NOT NULL,
    [drvLAssignmentInd1] varchar(1) NOT NULL,
    [drvEmpPrevAmt1] varchar(1) NOT NULL,
    [drvEmpPrevSalMultiple1] varchar(1) NOT NULL,
    [drvSpousePrevAmt1] varchar(1) NOT NULL,
    [drvChildPrevAmt1] varchar(1) NOT NULL,
    [drvEmpIssuedAmt1] varchar(1) NOT NULL,
    [drvEmpIssuedSalMult1] varchar(1) NOT NULL,
    [drvSpouseIssuedAmt1] varchar(1) NOT NULL,
    [drvChildIssuedAmt1] varchar(1) NOT NULL,
    [drvEmpAppliedAmt1] varchar(1) NOT NULL,
    [drvEmpAppliedSalMult1] varchar(1) NOT NULL,
    [drvSpouseAppliedAmt1] varchar(1) NOT NULL,
    [drvChildAppliedAmt1] varchar(1) NOT NULL,
    [drvEmpPendingAmt1] varchar(1) NOT NULL,
    [drvEmpPendingSalMult1] varchar(1) NOT NULL,
    [drvSpousePendingAmt1] varchar(1) NOT NULL,
    [drvChildPendingAmt1] varchar(1) NOT NULL,
    [drvEmpMontlyCashAccumFundAmt1] varchar(1) NOT NULL,
    [drvSpouseMoCashAccumFundAmt1] varchar(1) NOT NULL,
    [drvEmpAIOInd1] varchar(1) NOT NULL,
    [drvEmpADDADBInd1] varchar(1) NOT NULL,
    [drvSpouseADDADBInd1] varchar(1) NOT NULL,
    [drvEmpAPBInd1] varchar(1) NOT NULL,
    [drvSpouseAPBInd1] varchar(1) NOT NULL,
    [drvPAIPlanOpt1] varchar(1) NOT NULL,
    [drvLProdCode2] varchar(1) NOT NULL,
    [drvLPolicySymbol2] varchar(1) NOT NULL,
    [drvLPolicyNumber2] varchar(1) NOT NULL,
    [drvLAssignmentInd2] varchar(1) NOT NULL,
    [drvEmpPrevAmt2] varchar(1) NOT NULL,
    [drvEmpPrevSalMultiple2] varchar(1) NOT NULL,
    [drvSpousePrevAmt2] varchar(1) NOT NULL,
    [drvChildPrevAmt2] varchar(1) NOT NULL,
    [drvEmpIssuedAmt2] varchar(1) NOT NULL,
    [drvEmpIssuedSalMult2] varchar(1) NOT NULL,
    [drvSpouseIssuedAmt2] varchar(1) NOT NULL,
    [drvChildIssuedAmt2] varchar(1) NOT NULL,
    [drvEmpAppliedAmt2] varchar(1) NOT NULL,
    [drvEmpAppliedSalMult2] varchar(1) NOT NULL,
    [drvSpouseAppliedAmt2] varchar(1) NOT NULL,
    [drvChildAppliedAmt2] varchar(1) NOT NULL,
    [drvEmpPendingAmt2] varchar(1) NOT NULL,
    [drvEmpPendingSalMult2] varchar(1) NOT NULL,
    [drvSpousePendingAmt2] varchar(1) NOT NULL,
    [drvChildPendingAmt2] varchar(1) NOT NULL,
    [drvEmpMontlyCashAccumFundAmt2] varchar(1) NOT NULL,
    [drvSpouseMoCashAccumFundAmt2] varchar(1) NOT NULL,
    [drvEmpAIOInd2] varchar(1) NOT NULL,
    [drvEmpADDADBInd2] varchar(1) NOT NULL,
    [drvSpouseADDADBInd2] varchar(1) NOT NULL,
    [drvEmpAPBInd2] varchar(1) NOT NULL,
    [drvSpouseAPBInd2] varchar(1) NOT NULL,
    [drvPAIPlanOpt2] varchar(1) NOT NULL,
    [drvLProdCode3] varchar(1) NOT NULL,
    [drvLPolicySymbol3] varchar(1) NOT NULL,
    [drvLPolicyNumber3] varchar(1) NOT NULL,
    [drvLAssignmentInd3] varchar(1) NOT NULL,
    [drvEmpPrevAmt3] varchar(1) NOT NULL,
    [drvEmpPrevSalMultiple3] varchar(1) NOT NULL,
    [drvSpousePrevAmt3] varchar(1) NOT NULL,
    [drvChildPrevAmt3] varchar(1) NOT NULL,
    [drvEmpIssuedAmt3] varchar(1) NOT NULL,
    [drvEmpIssuedSalMult3] varchar(1) NOT NULL,
    [drvSpouseIssuedAmt3] varchar(1) NOT NULL,
    [drvChildIssuedAmt3] varchar(1) NOT NULL,
    [drvEmpAppliedAmt3] varchar(1) NOT NULL,
    [drvEmpAppliedSalMult3] varchar(1) NOT NULL,
    [drvSpouseAppliedAmt3] varchar(1) NOT NULL,
    [drvChildAppliedAmt3] varchar(1) NOT NULL,
    [drvEmpPendingAmt3] varchar(1) NOT NULL,
    [drvEmpPendingSalMult3] varchar(1) NOT NULL,
    [drvSpousePendingAmt3] varchar(1) NOT NULL,
    [drvChildPendingAmt3] varchar(1) NOT NULL,
    [drvEmpMontlyCashAccumFundAmt3] varchar(1) NOT NULL,
    [drvSpouseMoCashAccumFundAmt3] varchar(1) NOT NULL,
    [drvEmpAIOInd3] varchar(1) NOT NULL,
    [drvEmpADDADBInd3] varchar(1) NOT NULL,
    [drvSpouseADDADBInd3] varchar(1) NOT NULL,
    [drvEmpAPBInd3] varchar(1) NOT NULL,
    [drvSpouseAPBInd3] varchar(1) NOT NULL,
    [drvPAIPlanOpt3] varchar(1) NOT NULL,
    [drvLProdCode4] varchar(1) NOT NULL,
    [drvLPolicySymbol4] varchar(1) NOT NULL,
    [drvLPolicyNumber4] varchar(1) NOT NULL,
    [drvLAssignmentInd4] varchar(1) NOT NULL,
    [drvEmpPrevAmt4] varchar(1) NOT NULL,
    [drvEmpPrevSalMultiple4] varchar(1) NOT NULL,
    [drvSpousePrevAmt4] varchar(1) NOT NULL,
    [drvChildPrevAmt4] varchar(1) NOT NULL,
    [drvEmpIssuedAmt4] varchar(1) NOT NULL,
    [drvEmpIssuedSalMult4] varchar(1) NOT NULL,
    [drvSpouseIssuedAmt4] varchar(1) NOT NULL,
    [drvChildIssuedAmt4] varchar(1) NOT NULL,
    [drvEmpAppliedAmt4] varchar(1) NOT NULL,
    [drvEmpAppliedSalMult4] varchar(1) NOT NULL,
    [drvSpouseAppliedAmt14] varchar(1) NOT NULL,
    [drvChildAppliedAmt4] varchar(1) NOT NULL,
    [drvEmpPendingAmt4] varchar(1) NOT NULL,
    [drvEmpPendingSalMult4] varchar(1) NOT NULL,
    [drvSpousePendingAmt4] varchar(1) NOT NULL,
    [drvChildPendingAmt4] varchar(1) NOT NULL,
    [drvEmpMontlyCashAccumFundAmt4] varchar(1) NOT NULL,
    [drvSpouseMoCashAccumFundAmt4] varchar(1) NOT NULL,
    [drvEmpAIOInd4] varchar(1) NOT NULL,
    [drvEmpADDADBInd4] varchar(1) NOT NULL,
    [drvSpouseADDADBInd4] varchar(1) NOT NULL,
    [drvEmpAPBInd4] varchar(1) NOT NULL,
    [drvSpouseAPBInd4] varchar(1) NOT NULL,
    [drvPAIPlanOpt4] varchar(1) NOT NULL,
    [drvLProdCode5] varchar(1) NOT NULL,
    [drvLPolicySymbol5] varchar(1) NOT NULL,
    [drvLPolicyNumber5] varchar(1) NOT NULL,
    [drvLAssignmentInd5] varchar(1) NOT NULL,
    [drvEmpPrevAmt5] varchar(1) NOT NULL,
    [drvEmpPrevSalMultiple5] varchar(1) NOT NULL,
    [drvSpousePrevAmt5] varchar(1) NOT NULL,
    [drvChildPrevAmt5] varchar(1) NOT NULL,
    [drvEmpIssuedAmt5] varchar(1) NOT NULL,
    [drvEmpIssuedSalMult5] varchar(1) NOT NULL,
    [drvSpouseIssuedAmt5] varchar(1) NOT NULL,
    [drvChildIssuedAmt5] varchar(1) NOT NULL,
    [drvEmpAppliedAmt5] varchar(1) NOT NULL,
    [drvEmpAppliedSalMult5] varchar(1) NOT NULL,
    [drvSpouseAppliedAmt5] varchar(1) NOT NULL,
    [drvChildAppliedAmt5] varchar(1) NOT NULL,
    [drvEmpPendingAmt5] varchar(1) NOT NULL,
    [drvEmpPendingSalMult5] varchar(1) NOT NULL,
    [drvSpousePendingAmt5] varchar(1) NOT NULL,
    [drvChildPendingAmt5] varchar(1) NOT NULL,
    [drvEmpMontlyCashAccumFundAmt5] varchar(1) NOT NULL,
    [drvSpouseMoCashAccumFundAmt5] varchar(1) NOT NULL,
    [drvEmpAIOInd5] varchar(1) NOT NULL,
    [drvEmpADDADBInd5] varchar(1) NOT NULL,
    [drvSpouseADDADBInd5] varchar(1) NOT NULL,
    [drvEmpAPBInd5] varchar(1) NOT NULL,
    [drvSpouseAPBInd5] varchar(1) NOT NULL,
    [drvPAIPlanOpt5] varchar(1) NOT NULL,
    [drvExtendedEmail] varchar(50) NULL,
    [drvExtendedEmail2] varchar(25) NOT NULL,
    [drvExtendedEmail1] varchar(50) NULL
);
IF OBJECT_ID('U_dsi_ECIG3KWD2N_EarnHist') IS NULL
CREATE TABLE [dbo].[U_dsi_ECIG3KWD2N_EarnHist] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL
);
IF OBJECT_ID('U_dsi_ECIG3KWD2N_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ECIG3KWD2N_hdrTbl] (
    [drvRecId] varchar(2) NOT NULL,
    [drvDUNS] varchar(9) NOT NULL,
    [drvProdOrTest] varchar(1) NOT NULL,
    [drvDate] datetime NOT NULL,
    [drvCoName] varchar(25) NOT NULL,
    [drvFileType] varchar(1) NOT NULL,
    [drvLifeReason] varchar(1) NOT NULL,
    [drvDisReason] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_ECIG3KWD2N_KeyEmps') IS NULL
CREATE TABLE [dbo].[U_dsi_ECIG3KWD2N_KeyEmps] (
    [keyeeid] char(12) NOT NULL,
    [keycoid] char(5) NOT NULL,
    [keysalary] money NULL
);
IF OBJECT_ID('U_dsi_ECIG3KWD2N_trlTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ECIG3KWD2N_trlTbl] (
    [drvTrlInd] varchar(2) NOT NULL,
    [drvDUNSNoTrl] varchar(9) NOT NULL,
    [drvRecCount] int NULL
);
IF OBJECT_ID('U_ECIG3KWD2N_DedList') IS NULL
CREATE TABLE [dbo].[U_ECIG3KWD2N_DedList] (
    [dccode] varchar(200) NOT NULL,
    [dctype] char(4) NOT NULL
);
IF OBJECT_ID('U_ECIG3KWD2N_EEList') IS NULL
CREATE TABLE [dbo].[U_ECIG3KWD2N_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECIG3KWD2N_File') IS NULL
CREATE TABLE [dbo].[U_ECIG3KWD2N_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_ECIG3KWD2N'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_ECIG3KWD2N','04/23/2012','P','V1.RKM'
*/

/*
--3 records
begin tran
insert into dbo.u_dsi_sqlclauses (formatcode,recordset,fromclause,whereclause)
select 'ECIG3KWD2N',recordset,replace(fromclause,'ECIGNA3KCI','ECIG3KWD2N'),whereclause
from dbo.u_dsi_sqlclauses
where formatcode = 'ECIGNA3KCI'
ROLLBACK
commit
*/



CREATE  PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIG3KWD2N]
 @systemid varchar(12) = ''
AS
Begin


/*************************************************************************************************
DRIVER TABLE SP FOR:  CIGNA LADE (add, std,ltd,life) 3K full file
BUILT FOR: Washington Dental Services
ORIGINAL BUILD (V-1.0):04/23/2012 - Rachel Munnerlyn   - 731371

Updated: Grisell Jaffe   4/1/15    SF 05075035   Updated annual hours drvAccrualAnnHrs which was previously set to null
Sean Hawkins    02/13/2018    SR-2017-00177913    Updated to correct term date logic and adding supervisor email addresses
                                                Updated to move employee email address for 50 characters to field 130
                                                Only for ETEST session at this time, will move to make permanent when ready
                02/20/2018                        Updates made permanent for SR-2017-177913    
Sean Hawkins    03/19/2018    SR-2017-00177913    Small update for item #25 and hardcode ulti email address for item #284 - ETEST only at this point
                03/19/2018                        Updates now permanent
*************************************************************************************************/

-- Collect the @Start and @End Percontrol/PayDates upfront

    /***************************
    COLLECT DATE PARAMETERS
    ****************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200)
        
    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = rtrim(Exportcode),
        @Exportfile = ExportFile
    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID


-- dedcodes
 
declare @DedList varchar(200) 
select @DedList = 'x'

    IF OBJECT_ID('U_ECIG3KWD2N_DedList') IS NOT NULL
     DROP TABLE dbo.U_ECIG3KWD2N_DedList

    select dccode = item, dctype = deddedtype
        into dbo.U_ECIG3KWD2N_DedList
    from dbo.fn_ListToTable(@DedList)
    join dedcode on deddedcode = item


        
-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 31    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'N'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe


-- clean up EELIST if needed

-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_ECIG3KWD2N_EELIST
            from dbo.u_ECIG3KWD2N_EELIST
            join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end



--  remove old terms
    
--            delete dbo.u_ECIG3KWD2N_EELIST
--            from dbo.u_ECIG3KWD2N_EELIST
--            join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
--            where t.eecemplstatus = 'T'
----            and eecdateoftermination + @daysstopped < getdate()




--BDM

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','LTD,ELTD,STD,GLIFE,GADD,LIFEE,LIFES,LIFEC')
IF @ExportCode <> 'EGICOE' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@EndDate - @daysstopped)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END
IF @ExportCode = 'EGICOE' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

IF @ExportCode = 'EGICOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')    --'Active')
END


EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode


--select * from dbo.U_dsi_bdm_EmpDeductions where eedformatcode = 'ECIG3KWD2N'





-- Clean up eelist if needed to only include employees with deductions

            delete dbo.u_ECIG3KWD2N_eelist
            from dbo.u_ECIG3KWD2N_eelist a
            where not exists(select 1 from U_dsi_bdm_EmpDeductions 
                where a.xeeid = eedeeid    and a.xcoid = eedcoid
                and EedFormatCode = @FormatCode
                and eedvalidforexport = 'Y')


-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_ECIG3KWD2N_EELIST
            from dbo.u_ECIG3KWD2N_EELIST
            join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_ECIG3KWD2N_eelist
            from dbo.u_ECIG3KWD2N_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ECIG3KWD2N_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

--last 12 month Earning History
if object_id('U_dsi_ECIG3KWD2N_EarnHist') is not null
  drop table dbo.U_dsi_ECIG3KWD2N_EarnHist

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    SUM(ISNULL(pehCurAmt,0.00))*100 AS eamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ehrs  

    INTO dbo.U_dsi_ECIG3KWD2N_EarnHist
        from dbo.u_ECIG3KWD2N_EELIST 
    JOIN vw_int_PEarHist (nolock) ON xeeid = pehEEID and xCOID = PehCOID
         and CONVERT(DATETIME, LEFT(pehPerControl , 8)  ) BETWEEN DATEADD(month, -12, @EndDate) and @EndDate
--        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
    where PehEarnCode='REG'
    GROUP BY xEEID,xCOID--,pehearncode


--select * from vw_int_PEarHist
--select * from U_dsi_ECIG3KWD2N_EarnHist

--List of key employees (top 10% by salary) client doesn't want to use Key employee field from Ultipro
if object_id('U_dsi_ECIG3KWD2N_KeyEmps') is not null
  drop table dbo.U_dsi_ECIG3KWD2N_KeyEmps

select TOP 10 percent with ties
eeceeid as keyeeid,
eeccoid as keycoid,
eecannsalary  as keysalary

INTO dbo.U_dsi_ECIG3KWD2N_KeyEmps
from dbo.u_ECIG3KWD2N_eelist
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
order by eecannsalary desc

-- Populate Source for Employees
if object_id('U_dsi_ECIG3KWD2N_drvTbl') is not null
  drop table dbo.U_dsi_ECIG3KWD2N_drvTbl

-- EE Detail

  select 
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
--    drvdedcode = dedcode,
-- standard fields above and additional driver fields below
    drvSSN = eepssn,
    drvEmpNo = eecempno,
    drvBillingLoc = '0000',
    drvCompanyNo = '000021603',
    drvGroupID = '000013449',
    drvClassCode = '001',
    drvClassChangeDate = null,
    drvNameLast = eepnamelast,
    drvNameFirst = eepnamefirst,
    drvNameMiddle = eepnamemiddle,
    drvNamePrefix = '',
    drvNameSuffix = eepnamesuffix,
    drvDOB = eepdateofbirth,
    drvGender = eepgender,
    drvMaritalStat = case when eepmaritalstatus = 'S' then 'I' 
                        when eepmaritalstatus = 'Z' then 'K'
                        when eepmaritalstatus is null then 'K'
                    else eepmaritalstatus end,
    drvPinNo = '',
    drvSmoker = case eepissmoker
                    when 'N' then 'N'
                    when 'Y' then 'T'
                    else 'U' end,
    drvEmail0 = '',--case when @exportcode = 'ETEST' then  '' else substring(eepaddressemail,1,34) end,--item 20
    drvEmail1 = '',        --'x@x.com',
    drvEmail1Type = case when supemail is not null then '1' else '' end,--case when @exportcode = 'ETEST' and supemail is not null then '1' else '' end,    --'2',--1 for supervisor if supervisor email is present
    drvEmail2 = '',        --'x@x.com',
    drvEmail2Type = '2',--case when @exportcode = 'ETEST' then '2' else '' end,--'',    --case when @exportcode = 'ETEST' then '2' else '' end,
    drvAdd1 = eepaddressline1,
    drvAdd2 = eepaddressline2,
    drvCity = eepaddresscity,
    drvState = eepaddressstate,
    drvZIP = eepaddresszipcode,
    drvCountry = '',
    drvCountryCode = 'US',
    drvResidenceState = eepaddressstate,
    drvProvince = '',
    drvTypeOfAddr = 'R',
    drvAddressDate = '',
    drvPhone = '',        --eepphonehomenumber,
    drvPhoneType = '',    --'R',
    drvEmpStatus = case eecemplstatus
                    when 'A' then 'AC'
                    when 'L' then 'L1'
                    when 'T' then 'TE'
                    else '' end,
    drvStatusDate = case when eecemplstatus = 'T' then eecdateoftermination else eecemplstatusstartdate end,--eecdateoftermination is status = 'T'
    drvEmpType = 'P',            --case when eeceetype = 'REG' then 'P' else '' end,
    drvHireDate = eecdateoflasthire,
    drvServiceDate = eecdateofseniority,
    drvWorkLoc = '',
    drvAnnSalary = eecannsalary * 100,
    drvDisEarningsMode = 'A',
    drvDisEarnings = eecannsalary * 100,
    drvEarningsChgDate = '',
    drvSalryInd = case when eecsalaryorhourly = 'S' then 'Y' else 'N' end,
    drvFT = case when eecfulltimeorparttime = 'F' then 'Y' else 'N' end,
    drvBonusInd = '',
    drvWFHInd = '',
    drvExempt = '',
    drvHrsWeek = convert(char(20),convert(numeric(12,2),eecScheduledAnnualHrs / 52) * 100),
    drvTaxState = eepaddressstate,    --'R',
    drvOccupationCode = '',
    drvJobDesc = '',    --jbcdesc,
    drvJobCode = '',    --eecjobcode,
    drvOrgName = '',    --'Washington Dental',
    drvOrgCode = '',
    drvLocCode = '',
    drvUnionNo = '',
    drvUnionName = '',
    drvUnionInd = '',    --'N',
    drvHealthPlanType = '',    --'U',
    drvHealthPlanDesc = '',
    drvAccruedSickTime = '',
    drvKeyEmp = case when isnull(keyeeid,'') = '' then 'N' else 'Y' end,--eeciskeyemployee,
    drvAccrualAnnHrs = ehrs,--ehrs,     --GJaffe 4/1/15  added the annual hours    --don't have 12 months of data
--    drvAccrualAnnHrs = SUM(isnull(PehCurHrs,0.00)) from
--where PehEEID='8YEY4U0011G0' and pehearncode='reg' and PehPayDate between '2014-04-01' and '2015-04-01' --pehcurhrs) BETWEEN DATEADD(month, -12, '2015-04-01') and '2015-04-01'
    
    drvWorkState = eecWCState,
    drvMaintReason = '',
    drvMaintDate = '',
    drvSpouseSSN = '',        --case when S.Slife = '1' then conssn else '' end,
    drvSNameLast = '',        --case when S.Slife = '1' then connamelast else '' end,
    drvSNameFirst = '',        --case when S.Slife = '1' then connamefirst else '' end,
    drvSNameMiddle = '',        --case when S.Slife = '1' then connamemiddle else '' end,
    drvSPrefix = '',
    drvSSuffix = '',
    drvSDOB = '',        --case when S.Slife = '1' then condateofbirth else null end,
    drvSGender = '',        --case when S.Slife = '1' then congender else '' end,
    drvSSmoker = '',        --case when S.Slife = '1' then
                    --case when conissmoker = 'Y' then 'T' else 'N' end
                --else '' end,
--disability loops
    drvNumberofDisProducts = '',
    drvDisCovCode1 = '',--ltd.code,
    drvPolicySymbol1 = '',--ltd.symbol,
    drvPolicyNumber1 = '',--ltd.policy,
    drvProvEffDate1 = '',--ltd.startd,
    drvBenPct1 = '',--ltd.benpct,
    drvBenAmt1 = '',--ltd.benamt,
    drvEmpContrPct1 = '',--ltd.eepct,
    drvEffDate1 = '',
    drvPostTaxInd1 = '',--ltd.post,
    drvBenDesc1 = '',
--
    drvDisCovCode2 = '',--std.code,
    drvPolicySymbol2 = '',--std.symbol,
    drvPolicyNumber2 = '',--std.policy,
    drvProvEffDate2 = '',--std.startd,
    drvBenPct2 = '',--std.benpct,
    drvBenAmt2 = '',--std.benamt,
    drvEmpContrPct2 = '',--std.eepct,
    drvEffDate2 = '',
    drvPostTaxInd2 = '',--std.post,
    drvBenDesc2 = '',
--
    drvDisCovCode3 = fmla.code,
    drvPolicySymbol3 = fmla.symbol,
    drvPolicyNumber3 = fmla.policy,
    drvProvEffDate3 = null,        --fmla.startd,
    drvBenPct3 = fmla.benpct,
    drvBenAmt3 = fmla.benamt,
    drvEmpContrPct3 = fmla.eepct,
    drvEffDate3 = '',
    drvPostTaxInd3 = fmla.post,
    drvBenDesc3 = '',
--
    drvDisCovCode4 = '',
    drvPolicySymbol4 = '',
    drvPolicyNumber4 = '',
    drvProvEffDate4 = '',
    drvBenPct4 = '',
    drvBenAmt4 = '',
    drvEmpContrPct4 = '',
    drvEffDate4 = '',
    drvPostTaxInd4 = '',
    drvBenDesc4 = '',
--life loops
    drvNumberofLifeProds = '',--case when isnull(coalesce(vlif.code,vlifs.code,vlifc.code),'') ='' then '' else '01' end,
    drvLProdCode1 = '',--coalesce(vlif.symbol,vlifs.symbol,vlifc.symbol),    --lif.code,
    drvLPolicySymbol1 = '',--coalesce(vlif.code,vlifs.code,vlifc.code),    --lif.symbol,
    drvLPolicyNumber1 = '',--coalesce(vlif.policy,vlifs.policy,vlifc.policy),    --lif.policy,
    drvLAssignmentInd1 = '',
    drvEmpPrevAmt1 = '',
    drvEmpPrevSalMultiple1 = '',
    drvSpousePrevAmt1 = '',
    drvChildPrevAmt1 = '',
    drvEmpIssuedAmt1 = '',--cast(vlif.benamt as varchar), 
    drvEmpIssuedSalMult1 = '',    --lif.mult,
    drvSpouseIssuedAmt1 = '',--cast(vlifs.benamt as varchar),
    drvChildIssuedAmt1 = '',--cast(vlifc.benamt as varchar),
    drvEmpAppliedAmt1 = '',
    drvEmpAppliedSalMult1 = '',
    drvSpouseAppliedAmt1 = '',
    drvChildAppliedAmt1 = '',
    drvEmpPendingAmt1 = '',
    drvEmpPendingSalMult1 = '',
    drvSpousePendingAmt1 = '',
    drvChildPendingAmt1 = '',
    drvEmpMontlyCashAccumFundAmt1 = '',
    drvSpouseMoCashAccumFundAmt1 = '',
    drvEmpAIOInd1 = '',
    drvEmpADDADBInd1 = '',
    drvSpouseADDADBInd1 = '',
    drvEmpAPBInd1 = '',
    drvSpouseAPBInd1 = '',
    drvPAIPlanOpt1 = '',
--
    drvLProdCode2 = '',--vlif.symbol,
    drvLPolicySymbol2 = '',--vlif.code,
    drvLPolicyNumber2 = '',--vlif.policy,
    drvLAssignmentInd2 = '',
    drvEmpPrevAmt2 = '',
    drvEmpPrevSalMultiple2 = '',
    drvSpousePrevAmt2 = '',
    drvChildPrevAmt2 = '',
    drvEmpIssuedAmt2 = '',
    drvEmpIssuedSalMult2 = '',--vlif.mult,
    drvSpouseIssuedAmt2 = '',
    drvChildIssuedAmt2 = '',
    drvEmpAppliedAmt2 = '',
    drvEmpAppliedSalMult2 = '',
    drvSpouseAppliedAmt2 = '',
    drvChildAppliedAmt2 = '',
    drvEmpPendingAmt2 = '',
    drvEmpPendingSalMult2 = '',
    drvSpousePendingAmt2 = '',
    drvChildPendingAmt2 = '',
    drvEmpMontlyCashAccumFundAmt2 = '',
    drvSpouseMoCashAccumFundAmt2 = '',
    drvEmpAIOInd2 = '',
    drvEmpADDADBInd2 = '',
    drvSpouseADDADBInd2 = '',
    drvEmpAPBInd2 = '',
    drvSpouseAPBInd2 = '',
    drvPAIPlanOpt2 = '',
--
    drvLProdCode3 = '',    --dd.code,
    drvLPolicySymbol3 = '',    --dd.symbol,
    drvLPolicyNumber3 = '',    --dd.policy,
    drvLAssignmentInd3 = '',
    drvEmpPrevAmt3 = '',
    drvEmpPrevSalMultiple3 = '',
    drvSpousePrevAmt3 = '',
    drvChildPrevAmt3 = '',
    drvEmpIssuedAmt3 = '',
    drvEmpIssuedSalMult3 = '',
    drvSpouseIssuedAmt3 = '',
    drvChildIssuedAmt3 = '',
    drvEmpAppliedAmt3 = '',
    drvEmpAppliedSalMult3 = '',
    drvSpouseAppliedAmt3 = '',
    drvChildAppliedAmt3 = '',
    drvEmpPendingAmt3 = '',
    drvEmpPendingSalMult3 = '',
    drvSpousePendingAmt3 = '',
    drvChildPendingAmt3 = '',
    drvEmpMontlyCashAccumFundAmt3 = '',
    drvSpouseMoCashAccumFundAmt3 = '',
    drvEmpAIOInd3 = '',
    drvEmpADDADBInd3 = '',
    drvSpouseADDADBInd3 = '',
    drvEmpAPBInd3 = '',
    drvSpouseAPBInd3 = '',
    drvPAIPlanOpt3 = '',
--
    drvLProdCode4 = '',    --vadd.code,
    drvLPolicySymbol4 = '',    --vadd.symbol,
    drvLPolicyNumber4 = '',    --vadd.policy,
    drvLAssignmentInd4 = '',
    drvEmpPrevAmt4 = '',
    drvEmpPrevSalMultiple4 = '',
    drvSpousePrevAmt4 = '',
    drvChildPrevAmt4 = '',
    drvEmpIssuedAmt4 = '',
    drvEmpIssuedSalMult4 = '',
    drvSpouseIssuedAmt4 = '',
    drvChildIssuedAmt4 = '',
    drvEmpAppliedAmt4 = '',
    drvEmpAppliedSalMult4 = '',
    drvSpouseAppliedAmt14 = '',
    drvChildAppliedAmt4 = '',
    drvEmpPendingAmt4 = '',
    drvEmpPendingSalMult4 = '',
    drvSpousePendingAmt4 = '',
    drvChildPendingAmt4 = '',
    drvEmpMontlyCashAccumFundAmt4 = '',
    drvSpouseMoCashAccumFundAmt4 = '',
    drvEmpAIOInd4 = '',
    drvEmpADDADBInd4 = '',
    drvSpouseADDADBInd4 = '',
    drvEmpAPBInd4 = '',
    drvSpouseAPBInd4 = '',
    drvPAIPlanOpt4 = '',
--
    drvLProdCode5 = '',
    drvLPolicySymbol5 = '',
    drvLPolicyNumber5 = '',
    drvLAssignmentInd5 = '',
    drvEmpPrevAmt5 = '',
    drvEmpPrevSalMultiple5 = '',
    drvSpousePrevAmt5 = '',
    drvChildPrevAmt5 = '',
    drvEmpIssuedAmt5 = '',
    drvEmpIssuedSalMult5 = '',
    drvSpouseIssuedAmt5 = '',
    drvChildIssuedAmt5 = '',
    drvEmpAppliedAmt5 = '',
    drvEmpAppliedSalMult5 = '',
    drvSpouseAppliedAmt5 = '',
    drvChildAppliedAmt5 = '',
    drvEmpPendingAmt5 = '',
    drvEmpPendingSalMult5 = '',
    drvSpousePendingAmt5 = '',
    drvChildPendingAmt5 = '',
    drvEmpMontlyCashAccumFundAmt5 = '',
    drvSpouseMoCashAccumFundAmt5 = '',
    drvEmpAIOInd5 = '',
    drvEmpADDADBInd5 = '',
    drvSpouseADDADBInd5 = '',
    drvEmpAPBInd5 = '',
    drvSpouseAPBInd5 = '',
    drvPAIPlanOpt5 = '',
    drvExtendedEmail = substring(eepaddressemail,1,50),--case when @exportcode = 'ETEST' then substring(eepaddressemail,1,50) else '' end,        --substring(eepaddressemail,35,50),substring(eepaddressemail,1,34),--move to 130, 50 characters
    drvExtendedEmail2 = 'Ultipro@deltadentalwa.com',--case when @exportcode = 'ETEST' then 'Ultipro@deltadentalwa.com' else '' end,
    drvExtendedEmail1 = case when supemail is not null then substring(supemail,1,50) else '' end--@exportcode = 'ETEST' and supemail is not null then substring(supemail,1,50) else '' end--''

  into dbo.U_dsi_ECIG3KWD2N_drvTbl
  from dbo.u_ECIG3KWD2N_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join company on eeccoid = cmpcoid
    left join contacts on coneeid = xeeid and conrelationship = 'SPS'
    left join jobcode on eecjobcode = jbcjobcode
    left join dbo.U_dsi_ECIG3KWD2N_EarnHist on eeeid = xeeid and xcoid = ecoid
    left join dbo.U_dsi_ECIG3KWD2N_KeyEmps on keyeeid = xeeid and xcoid = keycoid
--    left join (select eeceeid eeid, eeccoid coid, null depid, lchCode CovCode, lchCode PolicySymbol, '0750565' PolicyNo, '06667' BenPct,eecemplstatusstartdate StartDate,'000000000' BenAmt,'000000' EEAmt, 'N' PT
--        from vw_int_EmpComp
--        left join emphstat on esheeid = eeceeid and eshemplstatus = 'L'
--        join loareasn on lchcode = eshemplstatusreason and eshstatusstartdate = eecemplstatusstartdate    --and lchtype = 'MED'
--        where eecemplstatus = 'L') LOA on loa.eeid = xeeid and loa.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'LTD' code, 'LK' Symbol, '0963232' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '06667' benpct, '' benamt, '06667' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('LTD','ELTD') group by eedeeid,eedcoid) LTD on ltd.eeid = xeeid and ltd.coid = xcoid

--    left join (select eedeeid eeid, eedcoid coid, 'STD' code, 'LK' Symbol, '0751124' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '06667' benpct, '' benamt, '00000' eepct, 'N' post
--        from dbo.U_dsi_bdm_EmpDeductions
--        where EedFormatCode = @FormatCode
--        and EedValidForExport = 'Y'
--        and eeddedcode in ('STD')group by eedeeid,eedcoid) STD on std.eeid = xeeid and std.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'FMLA' code, 'FML' Symbol, '0751124' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('BLIFE','BADD')group by eedeeid,eedcoid) fmla on fmla.eeid = xeeid and fmla.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'xxxx' code, 'AF' Symbol, 'nnnnnn' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('GLIFE') group by eedeeid,eedcoid) lif on lif.eeid = xeeid and lif.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'FLX' code, 'AC' Symbol, '964596' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, eedbenamt benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('LIFEE')group by eedeeid,eedcoid,eedbenamt) vlif on vlif.eeid = xeeid and vlif.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'FLX' code, 'AC' Symbol, '964596' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, eedbenamt benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('LIFES')group by eedeeid,eedcoid,eedbenamt) vlifs on vlifs.eeid = xeeid and vlifs.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'FLX' code, 'AC' Symbol, '964596' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, eedbenamt benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('LIFEC')group by eedeeid,eedcoid,eedbenamt) vlifc on vlifc.eeid = xeeid and vlifc.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, '' code, 'BAD' Symbol, 'nnnnnn' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in  ('GADD')group by eedeeid,eedcoid ) dd on dd.eeid = xeeid and dd.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, '' code, 'ADD' Symbol, 'nnnnnn' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in  ('VADD')group by eedeeid,eedcoid) vadd on vadd.eeid = xeeid and vadd.coid = xcoid

    left join (select eeceeid supeeid,  eeccoid supcoid, eepnamelast supnamelast, eepnamefirst supnamefirst, eecemplstatus supstatus, 
        eepaddressemail supemail
        from vw_int_EmpComp
        join emppers on eepeeid = eecsupervisorid
        and eecemplstatus <> 'T'
        ) sup on supeeid = eeceeid



--  where deddepid is null







-- delete deductions from employee when not used such in domestic partner codes

--delete from U_dsi_ECIG3KWD2N_drvTbl 
--where drvdepid is null and drvdedcode = 'YYYY'

    


      
-- Create Headers

if object_id('U_dsi_ECIG3KWD2N_hdrTbl') is not null
  drop table dbo.U_dsi_ECIG3KWD2N_hdrTbl

SELECT
    drvRecId = 'HD',
    drvDUNS = '075732446',
    drvProdOrTest = case when @exportcode like '%TEST%' then 'T' else 'P' end,
    drvDate = getdate(),
    drvCoName = 'Washington Dental Service',
    drvFileType = '2',
    drvLifeReason = '',
    drvDisReason = '2'

into dbo.U_dsi_ECIG3KWD2N_hdrTbl



-- Create Trailers

if object_id('U_dsi_ECIG3KWD2N_trlTbl') is not null
  drop table dbo.U_dsi_ECIG3KWD2N_trlTbl

SELECT
    drvTrlInd = 'TR',
    drvDUNSNoTrl = '075732446',
    drvRecCount = cnt.dtlcount        --+ 2    -- no header and trailer

into dbo.U_dsi_ECIG3KWD2N_trlTbl
from (select count(*) dtlcount from dbo.U_dsi_ECIG3KWD2N_drvTbl) cnt




-- Set FileName  
if (dbo.dsi_fnVariable('ECIG3KWD2N','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'WashingtonDen_CIGNA_' + convert(char(8),getdate(),112) + '.txt'
    where FormatCode = 'ECIG3KWD2N'


-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwECIG3KWD2N_Export as
        select top 2000000 Data from dbo.U_ECIG3KWD2N_File with (nolock)
         order by substring(Recordset,2,2), initialsort, subsort
*/



--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'ECIG3KWD2N','ECIG3KWD2N'
--dbo.dsi_sp_TestSwitchbox_v2 'ECIG3KWD2N','ETEST'
--select * from U_dsi_parameters where formatcode =  'ECIG3KWD2N'
--dbo.dsi_sp_TestSwitchbox 'ECIG3KWD2N','zap'

END
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_ECIG3KWD2N'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_ECIG3KWD2N','04/23/2012','P','V1.RKM'
*/

/*
--3 records
begin tran
insert into dbo.u_dsi_sqlclauses (formatcode,recordset,fromclause,whereclause)
select 'ECIG3KWD2N',recordset,replace(fromclause,'ECIGNA3KCI','ECIG3KWD2N'),whereclause
from dbo.u_dsi_sqlclauses
where formatcode = 'ECIGNA3KCI'
ROLLBACK
commit
*/



CREATE  PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECIG3KWD2N]
 @systemid varchar(12) = ''
AS
Begin


/*************************************************************************************************
DRIVER TABLE SP FOR:  CIGNA LADE (add, std,ltd,life) 3K full file
BUILT FOR: Washington Dental Services
ORIGINAL BUILD (V-1.0):04/23/2012 - Rachel Munnerlyn   - 731371

Updated: Grisell Jaffe   4/1/15    SF 05075035   Updated annual hours drvAccrualAnnHrs which was previously set to null
Sean Hawkins    02/13/2018    SR-2017-00177913    Updated to correct term date logic and adding supervisor email addresses
                                                Updated to move employee email address for 50 characters to field 130
                                                Only for ETEST session at this time, will move to make permanent when ready
                02/20/2018                        Updates made permanent for SR-2017-177913    
Sean Hawkins    03/19/2018    SR-2017-00177913    Small update for item #25 and hardcode ulti email address for item #284 - ETEST only at this point
                03/19/2018                        Updates now permanent
*************************************************************************************************/

-- Collect the @Start and @End Percontrol/PayDates upfront

    /***************************
    COLLECT DATE PARAMETERS
    ****************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200)
        
    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = rtrim(Exportcode),
        @Exportfile = ExportFile
    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID


-- dedcodes
 
declare @DedList varchar(200) 
select @DedList = 'x'

    IF OBJECT_ID('U_ECIG3KWD2N_DedList') IS NOT NULL
     DROP TABLE dbo.U_ECIG3KWD2N_DedList

    select dccode = item, dctype = deddedtype
        into dbo.U_ECIG3KWD2N_DedList
    from dbo.fn_ListToTable(@DedList)
    join dedcode on deddedcode = item


        
-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 31    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'N'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe


-- clean up EELIST if needed

-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_ECIG3KWD2N_EELIST
            from dbo.u_ECIG3KWD2N_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end



--  remove old terms
    
--            delete dbo.u_ECIG3KWD2N_EELIST
--            from dbo.u_ECIG3KWD2N_EELIST
--            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
--            where t.eecemplstatus = 'T'
----            and eecdateoftermination + @daysstopped < getdate()




--BDM

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','LTD,ELTD,STD,GLIFE,GADD,LIFEE,LIFES,LIFEC')
IF @ExportCode <> 'EGICOE' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@EndDate - @daysstopped)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END
IF @ExportCode = 'EGICOE' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

IF @ExportCode = 'EGICOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')    --'Active')
END


EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode


--select * from dbo.U_dsi_bdm_EmpDeductions where eedformatcode = 'ECIG3KWD2N'





-- Clean up eelist if needed to only include employees with deductions

            delete dbo.u_ECIG3KWD2N_eelist
            from dbo.u_ECIG3KWD2N_eelist a
            where not exists(select 1 from U_dsi_bdm_EmpDeductions 
                where a.xeeid = eedeeid    and a.xcoid = eedcoid
                and EedFormatCode = @FormatCode
                and eedvalidforexport = 'Y')


-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_ECIG3KWD2N_EELIST
            from dbo.u_ECIG3KWD2N_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_ECIG3KWD2N_eelist
            from dbo.u_ECIG3KWD2N_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ECIG3KWD2N_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

--last 12 month Earning History
if object_id('U_dsi_ECIG3KWD2N_EarnHist') is not null
  drop table dbo.U_dsi_ECIG3KWD2N_EarnHist

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    SUM(ISNULL(pehCurAmt,0.00))*100 AS eamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ehrs  

    INTO dbo.U_dsi_ECIG3KWD2N_EarnHist
        from dbo.u_ECIG3KWD2N_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
         and CONVERT(DATETIME, LEFT(pehPerControl , 8)  ) BETWEEN DATEADD(month, -12, @EndDate) and @EndDate
--        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
    where PehEarnCode='REG'
    GROUP BY xEEID,xCOID--,pehearncode


--select * from pearhist
--select * from U_dsi_ECIG3KWD2N_EarnHist

--List of key employees (top 10% by salary) client doesn't want to use Key employee field from Ultipro
if object_id('U_dsi_ECIG3KWD2N_KeyEmps') is not null
  drop table dbo.U_dsi_ECIG3KWD2N_KeyEmps

select TOP 10 percent with ties
eeceeid as keyeeid,
eeccoid as keycoid,
eecannsalary  as keysalary

INTO dbo.U_dsi_ECIG3KWD2N_KeyEmps
from dbo.u_ECIG3KWD2N_eelist
join empcomp on xeeid = eeceeid and xcoid = eeccoid
order by eecannsalary desc

-- Populate Source for Employees
if object_id('U_dsi_ECIG3KWD2N_drvTbl') is not null
  drop table dbo.U_dsi_ECIG3KWD2N_drvTbl

-- EE Detail

  select 
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
--    drvdedcode = dedcode,
-- standard fields above and additional driver fields below
    drvSSN = eepssn,
    drvEmpNo = eecempno,
    drvBillingLoc = '0000',
    drvCompanyNo = '000021603',
    drvGroupID = '000013449',
    drvClassCode = '001',
    drvClassChangeDate = null,
    drvNameLast = eepnamelast,
    drvNameFirst = eepnamefirst,
    drvNameMiddle = eepnamemiddle,
    drvNamePrefix = '',
    drvNameSuffix = eepnamesuffix,
    drvDOB = eepdateofbirth,
    drvGender = eepgender,
    drvMaritalStat = case when eepmaritalstatus = 'S' then 'I' 
                        when eepmaritalstatus = 'Z' then 'K'
                        when eepmaritalstatus is null then 'K'
                    else eepmaritalstatus end,
    drvPinNo = '',
    drvSmoker = case eepissmoker
                    when 'N' then 'N'
                    when 'Y' then 'T'
                    else 'U' end,
    drvEmail0 = '',--case when @exportcode = 'ETEST' then  '' else substring(eepaddressemail,1,34) end,--item 20
    drvEmail1 = '',        --'x@x.com',
    drvEmail1Type = case when supemail is not null then '1' else '' end,--case when @exportcode = 'ETEST' and supemail is not null then '1' else '' end,    --'2',--1 for supervisor if supervisor email is present
    drvEmail2 = '',        --'x@x.com',
    drvEmail2Type = '2',--case when @exportcode = 'ETEST' then '2' else '' end,--'',    --case when @exportcode = 'ETEST' then '2' else '' end,
    drvAdd1 = eepaddressline1,
    drvAdd2 = eepaddressline2,
    drvCity = eepaddresscity,
    drvState = eepaddressstate,
    drvZIP = eepaddresszipcode,
    drvCountry = '',
    drvCountryCode = 'US',
    drvResidenceState = eepaddressstate,
    drvProvince = '',
    drvTypeOfAddr = 'R',
    drvAddressDate = '',
    drvPhone = '',        --eepphonehomenumber,
    drvPhoneType = '',    --'R',
    drvEmpStatus = case eecemplstatus
                    when 'A' then 'AC'
                    when 'L' then 'L1'
                    when 'T' then 'TE'
                    else '' end,
    drvStatusDate = case when eecemplstatus = 'T' then eecdateoftermination else eecemplstatusstartdate end,--eecdateoftermination is status = 'T'
    drvEmpType = 'P',            --case when eeceetype = 'REG' then 'P' else '' end,
    drvHireDate = eecdateoflasthire,
    drvServiceDate = eecdateofseniority,
    drvWorkLoc = '',
    drvAnnSalary = eecannsalary * 100,
    drvDisEarningsMode = 'A',
    drvDisEarnings = eecannsalary * 100,
    drvEarningsChgDate = '',
    drvSalryInd = case when eecsalaryorhourly = 'S' then 'Y' else 'N' end,
    drvFT = case when eecfulltimeorparttime = 'F' then 'Y' else 'N' end,
    drvBonusInd = '',
    drvWFHInd = '',
    drvExempt = '',
    drvHrsWeek = convert(char(20),convert(numeric(12,2),eecScheduledAnnualHrs / 52) * 100),
    drvTaxState = eepaddressstate,    --'R',
    drvOccupationCode = '',
    drvJobDesc = '',    --jbcdesc,
    drvJobCode = '',    --eecjobcode,
    drvOrgName = '',    --'Washington Dental',
    drvOrgCode = '',
    drvLocCode = '',
    drvUnionNo = '',
    drvUnionName = '',
    drvUnionInd = '',    --'N',
    drvHealthPlanType = '',    --'U',
    drvHealthPlanDesc = '',
    drvAccruedSickTime = '',
    drvKeyEmp = case when isnull(keyeeid,'') = '' then 'N' else 'Y' end,--eeciskeyemployee,
    drvAccrualAnnHrs = ehrs,--ehrs,     --GJaffe 4/1/15  added the annual hours    --don't have 12 months of data
--    drvAccrualAnnHrs = SUM(isnull(PehCurHrs,0.00)) from
--where PehEEID='8YEY4U0011G0' and pehearncode='reg' and PehPayDate between '2014-04-01' and '2015-04-01' --pehcurhrs) BETWEEN DATEADD(month, -12, '2015-04-01') and '2015-04-01'
    
    drvWorkState = eecWCState,
    drvMaintReason = '',
    drvMaintDate = '',
    drvSpouseSSN = '',        --case when S.Slife = '1' then conssn else '' end,
    drvSNameLast = '',        --case when S.Slife = '1' then connamelast else '' end,
    drvSNameFirst = '',        --case when S.Slife = '1' then connamefirst else '' end,
    drvSNameMiddle = '',        --case when S.Slife = '1' then connamemiddle else '' end,
    drvSPrefix = '',
    drvSSuffix = '',
    drvSDOB = '',        --case when S.Slife = '1' then condateofbirth else null end,
    drvSGender = '',        --case when S.Slife = '1' then congender else '' end,
    drvSSmoker = '',        --case when S.Slife = '1' then
                    --case when conissmoker = 'Y' then 'T' else 'N' end
                --else '' end,
--disability loops
    drvNumberofDisProducts = '03',
    drvDisCovCode1 = ltd.code,
    drvPolicySymbol1 = ltd.symbol,
    drvPolicyNumber1 = ltd.policy,
    drvProvEffDate1 = ltd.startd,
    drvBenPct1 = ltd.benpct,
    drvBenAmt1 = ltd.benamt,
    drvEmpContrPct1 = ltd.eepct,
    drvEffDate1 = '',
    drvPostTaxInd1 = ltd.post,
    drvBenDesc1 = '',
--
    drvDisCovCode2 = 'STD',--std.code,
    drvPolicySymbol2 = 'LK',--std.symbol,
    drvPolicyNumber2 = '0751124',--std.policy,
    drvProvEffDate2 = eecdateofbenefitseniority,--std.startd,
    drvBenPct2 = '06667',--std.benpct,
    drvBenAmt2 = '',--std.benamt,
    drvEmpContrPct2 = '00000',--std.eepct,
    drvEffDate2 = '',
    drvPostTaxInd2 = 'N',--std.post,
    drvBenDesc2 = '',
--
    drvDisCovCode3 = fmla.code,
    drvPolicySymbol3 = fmla.symbol,
    drvPolicyNumber3 = fmla.policy,
    drvProvEffDate3 = null,        --fmla.startd,
    drvBenPct3 = fmla.benpct,
    drvBenAmt3 = fmla.benamt,
    drvEmpContrPct3 = fmla.eepct,
    drvEffDate3 = '',
    drvPostTaxInd3 = fmla.post,
    drvBenDesc3 = '',
--
    drvDisCovCode4 = '',
    drvPolicySymbol4 = '',
    drvPolicyNumber4 = '',
    drvProvEffDate4 = '',
    drvBenPct4 = '',
    drvBenAmt4 = '',
    drvEmpContrPct4 = '',
    drvEffDate4 = '',
    drvPostTaxInd4 = '',
    drvBenDesc4 = '',
--life loops
    drvNumberofLifeProds = '',--case when isnull(coalesce(vlif.code,vlifs.code,vlifc.code),'') ='' then '' else '01' end,
    drvLProdCode1 = '',--coalesce(vlif.symbol,vlifs.symbol,vlifc.symbol),    --lif.code,
    drvLPolicySymbol1 = '',--coalesce(vlif.code,vlifs.code,vlifc.code),    --lif.symbol,
    drvLPolicyNumber1 = '',--coalesce(vlif.policy,vlifs.policy,vlifc.policy),    --lif.policy,
    drvLAssignmentInd1 = '',
    drvEmpPrevAmt1 = '',
    drvEmpPrevSalMultiple1 = '',
    drvSpousePrevAmt1 = '',
    drvChildPrevAmt1 = '',
    drvEmpIssuedAmt1 = '',--cast(vlif.benamt as varchar), 
    drvEmpIssuedSalMult1 = '',    --lif.mult,
    drvSpouseIssuedAmt1 = '',--cast(vlifs.benamt as varchar),
    drvChildIssuedAmt1 = '',--cast(vlifc.benamt as varchar),
    drvEmpAppliedAmt1 = '',
    drvEmpAppliedSalMult1 = '',
    drvSpouseAppliedAmt1 = '',
    drvChildAppliedAmt1 = '',
    drvEmpPendingAmt1 = '',
    drvEmpPendingSalMult1 = '',
    drvSpousePendingAmt1 = '',
    drvChildPendingAmt1 = '',
    drvEmpMontlyCashAccumFundAmt1 = '',
    drvSpouseMoCashAccumFundAmt1 = '',
    drvEmpAIOInd1 = '',
    drvEmpADDADBInd1 = '',
    drvSpouseADDADBInd1 = '',
    drvEmpAPBInd1 = '',
    drvSpouseAPBInd1 = '',
    drvPAIPlanOpt1 = '',
--
    drvLProdCode2 = '',--vlif.symbol,
    drvLPolicySymbol2 = '',--vlif.code,
    drvLPolicyNumber2 = '',--vlif.policy,
    drvLAssignmentInd2 = '',
    drvEmpPrevAmt2 = '',
    drvEmpPrevSalMultiple2 = '',
    drvSpousePrevAmt2 = '',
    drvChildPrevAmt2 = '',
    drvEmpIssuedAmt2 = '',
    drvEmpIssuedSalMult2 = '',--vlif.mult,
    drvSpouseIssuedAmt2 = '',
    drvChildIssuedAmt2 = '',
    drvEmpAppliedAmt2 = '',
    drvEmpAppliedSalMult2 = '',
    drvSpouseAppliedAmt2 = '',
    drvChildAppliedAmt2 = '',
    drvEmpPendingAmt2 = '',
    drvEmpPendingSalMult2 = '',
    drvSpousePendingAmt2 = '',
    drvChildPendingAmt2 = '',
    drvEmpMontlyCashAccumFundAmt2 = '',
    drvSpouseMoCashAccumFundAmt2 = '',
    drvEmpAIOInd2 = '',
    drvEmpADDADBInd2 = '',
    drvSpouseADDADBInd2 = '',
    drvEmpAPBInd2 = '',
    drvSpouseAPBInd2 = '',
    drvPAIPlanOpt2 = '',
--
    drvLProdCode3 = '',    --dd.code,
    drvLPolicySymbol3 = '',    --dd.symbol,
    drvLPolicyNumber3 = '',    --dd.policy,
    drvLAssignmentInd3 = '',
    drvEmpPrevAmt3 = '',
    drvEmpPrevSalMultiple3 = '',
    drvSpousePrevAmt3 = '',
    drvChildPrevAmt3 = '',
    drvEmpIssuedAmt3 = '',
    drvEmpIssuedSalMult3 = '',
    drvSpouseIssuedAmt3 = '',
    drvChildIssuedAmt3 = '',
    drvEmpAppliedAmt3 = '',
    drvEmpAppliedSalMult3 = '',
    drvSpouseAppliedAmt3 = '',
    drvChildAppliedAmt3 = '',
    drvEmpPendingAmt3 = '',
    drvEmpPendingSalMult3 = '',
    drvSpousePendingAmt3 = '',
    drvChildPendingAmt3 = '',
    drvEmpMontlyCashAccumFundAmt3 = '',
    drvSpouseMoCashAccumFundAmt3 = '',
    drvEmpAIOInd3 = '',
    drvEmpADDADBInd3 = '',
    drvSpouseADDADBInd3 = '',
    drvEmpAPBInd3 = '',
    drvSpouseAPBInd3 = '',
    drvPAIPlanOpt3 = '',
--
    drvLProdCode4 = '',    --vadd.code,
    drvLPolicySymbol4 = '',    --vadd.symbol,
    drvLPolicyNumber4 = '',    --vadd.policy,
    drvLAssignmentInd4 = '',
    drvEmpPrevAmt4 = '',
    drvEmpPrevSalMultiple4 = '',
    drvSpousePrevAmt4 = '',
    drvChildPrevAmt4 = '',
    drvEmpIssuedAmt4 = '',
    drvEmpIssuedSalMult4 = '',
    drvSpouseIssuedAmt4 = '',
    drvChildIssuedAmt4 = '',
    drvEmpAppliedAmt4 = '',
    drvEmpAppliedSalMult4 = '',
    drvSpouseAppliedAmt14 = '',
    drvChildAppliedAmt4 = '',
    drvEmpPendingAmt4 = '',
    drvEmpPendingSalMult4 = '',
    drvSpousePendingAmt4 = '',
    drvChildPendingAmt4 = '',
    drvEmpMontlyCashAccumFundAmt4 = '',
    drvSpouseMoCashAccumFundAmt4 = '',
    drvEmpAIOInd4 = '',
    drvEmpADDADBInd4 = '',
    drvSpouseADDADBInd4 = '',
    drvEmpAPBInd4 = '',
    drvSpouseAPBInd4 = '',
    drvPAIPlanOpt4 = '',
--
    drvLProdCode5 = '',
    drvLPolicySymbol5 = '',
    drvLPolicyNumber5 = '',
    drvLAssignmentInd5 = '',
    drvEmpPrevAmt5 = '',
    drvEmpPrevSalMultiple5 = '',
    drvSpousePrevAmt5 = '',
    drvChildPrevAmt5 = '',
    drvEmpIssuedAmt5 = '',
    drvEmpIssuedSalMult5 = '',
    drvSpouseIssuedAmt5 = '',
    drvChildIssuedAmt5 = '',
    drvEmpAppliedAmt5 = '',
    drvEmpAppliedSalMult5 = '',
    drvSpouseAppliedAmt5 = '',
    drvChildAppliedAmt5 = '',
    drvEmpPendingAmt5 = '',
    drvEmpPendingSalMult5 = '',
    drvSpousePendingAmt5 = '',
    drvChildPendingAmt5 = '',
    drvEmpMontlyCashAccumFundAmt5 = '',
    drvSpouseMoCashAccumFundAmt5 = '',
    drvEmpAIOInd5 = '',
    drvEmpADDADBInd5 = '',
    drvSpouseADDADBInd5 = '',
    drvEmpAPBInd5 = '',
    drvSpouseAPBInd5 = '',
    drvPAIPlanOpt5 = '',
    drvExtendedEmail = substring(eepaddressemail,1,50),--case when @exportcode = 'ETEST' then substring(eepaddressemail,1,50) else '' end,        --substring(eepaddressemail,35,50),substring(eepaddressemail,1,34),--move to 130, 50 characters
    drvExtendedEmail2 = 'Ultipro@deltadentalwa.com',--case when @exportcode = 'ETEST' then 'Ultipro@deltadentalwa.com' else '' end,
    drvExtendedEmail1 = case when supemail is not null then substring(supemail,1,50) else '' end--@exportcode = 'ETEST' and supemail is not null then substring(supemail,1,50) else '' end--''

  into dbo.U_dsi_ECIG3KWD2N_drvTbl
  from dbo.u_ECIG3KWD2N_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join company on eeccoid = cmpcoid
    left join contacts on coneeid = xeeid and conrelationship = 'SPS'
    left join jobcode on eecjobcode = jbcjobcode
    left join dbo.U_dsi_ECIG3KWD2N_EarnHist on eeeid = xeeid and xcoid = ecoid
    left join dbo.U_dsi_ECIG3KWD2N_KeyEmps on keyeeid = xeeid and xcoid = keycoid
--    left join (select eeceeid eeid, eeccoid coid, null depid, lchCode CovCode, lchCode PolicySymbol, '0750565' PolicyNo, '06667' BenPct,eecemplstatusstartdate StartDate,'000000000' BenAmt,'000000' EEAmt, 'N' PT
--        from empcomp
--        left join emphstat on esheeid = eeceeid and eshemplstatus = 'L'
--        join loareasn on lchcode = eshemplstatusreason and eshstatusstartdate = eecemplstatusstartdate    --and lchtype = 'MED'
--        where eecemplstatus = 'L') LOA on loa.eeid = xeeid and loa.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'LTD' code, 'LK' Symbol, '0963232' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '06667' benpct, '' benamt, '06667' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('LTD','ELTD') group by eedeeid,eedcoid) LTD on ltd.eeid = xeeid and ltd.coid = xcoid

--    left join (select eedeeid eeid, eedcoid coid, 'STD' code, 'LK' Symbol, '0751124' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '06667' benpct, '' benamt, '00000' eepct, 'N' post
--        from dbo.U_dsi_bdm_EmpDeductions
--        where EedFormatCode = @FormatCode
--        and EedValidForExport = 'Y'
--        and eeddedcode in ('STD')group by eedeeid,eedcoid) STD on std.eeid = xeeid and std.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'FMLA' code, 'FML' Symbol, '0751124' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('LTD','ELTD','STD')group by eedeeid,eedcoid) fmla on fmla.eeid = xeeid and fmla.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'xxxx' code, 'AF' Symbol, 'nnnnnn' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('GLIFE') group by eedeeid,eedcoid) lif on lif.eeid = xeeid and lif.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'FLX' code, 'AC' Symbol, '964596' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, eedbenamt benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('LIFEE')group by eedeeid,eedcoid,eedbenamt) vlif on vlif.eeid = xeeid and vlif.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'FLX' code, 'AC' Symbol, '964596' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, eedbenamt benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('LIFES')group by eedeeid,eedcoid,eedbenamt) vlifs on vlifs.eeid = xeeid and vlifs.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, 'FLX' code, 'AC' Symbol, '964596' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, eedbenamt benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in ('LIFEC')group by eedeeid,eedcoid,eedbenamt) vlifc on vlifc.eeid = xeeid and vlifc.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, '' code, 'BAD' Symbol, 'nnnnnn' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in  ('GADD')group by eedeeid,eedcoid ) dd on dd.eeid = xeeid and dd.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, '' code, 'ADD' Symbol, 'nnnnnn' Policy, min(eedBenStartDate) StartD,min(eedBenStopDate) StopD, '00000' benpct, '' benamt, '00000' eepct, 'N' post
        from dbo.U_dsi_bdm_EmpDeductions
        where EedFormatCode = @FormatCode
        and EedValidForExport = 'Y'
        and eeddedcode in  ('VADD')group by eedeeid,eedcoid) vadd on vadd.eeid = xeeid and vadd.coid = xcoid

    left join (select eeceeid supeeid,  eeccoid supcoid, eepnamelast supnamelast, eepnamefirst supnamefirst, eecemplstatus supstatus, 
        eepaddressemail supemail
        from empcomp
        join emppers on eepeeid = eecsupervisorid
        and eecemplstatus <> 'T'
        ) sup on supeeid = eeceeid



--  where deddepid is null







-- delete deductions from employee when not used such in domestic partner codes

--delete from U_dsi_ECIG3KWD2N_drvTbl 
--where drvdepid is null and drvdedcode = 'YYYY'

    


      
-- Create Headers

if object_id('U_dsi_ECIG3KWD2N_hdrTbl') is not null
  drop table dbo.U_dsi_ECIG3KWD2N_hdrTbl

SELECT
    drvRecId = 'HD',
    drvDUNS = '075732446',
    drvProdOrTest = case when @exportcode like '%TEST%' then 'T' else 'P' end,
    drvDate = getdate(),
    drvCoName = 'Washington Dental Service',
    drvFileType = '2',
    drvLifeReason = '',
    drvDisReason = '2'

into dbo.U_dsi_ECIG3KWD2N_hdrTbl



-- Create Trailers

if object_id('U_dsi_ECIG3KWD2N_trlTbl') is not null
  drop table dbo.U_dsi_ECIG3KWD2N_trlTbl

SELECT
    drvTrlInd = 'TR',
    drvDUNSNoTrl = '075732446',
    drvRecCount = cnt.dtlcount        --+ 2    -- no header and trailer

into dbo.U_dsi_ECIG3KWD2N_trlTbl
from (select count(*) dtlcount from dbo.U_dsi_ECIG3KWD2N_drvTbl) cnt




-- Set FileName  
if (dbo.dsi_fnVariable('ECIG3KWD2N','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'WashingtonDen_CIGNA_' + convert(char(8),getdate(),112) + '.txt'
    where FormatCode = 'ECIG3KWD2N'


-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwECIG3KWD2N_Export as
        select top 2000000 Data from dbo.U_ECIG3KWD2N_File with (nolock)
         order by substring(Recordset,2,2), initialsort, subsort
*/



--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'ECIG3KWD2N','ECIG3KWD2N'
--dbo.dsi_sp_TestSwitchbox_v2 'ECIG3KWD2N','ETEST'
--select * from U_dsi_parameters where formatcode =  'ECIG3KWD2N'
--dbo.dsi_sp_TestSwitchbox 'ECIG3KWD2N','zap'

END
GO
 CREATE  View dbo.dsi_vwECIG3KWD2N_Export as
        select top 2000000 Data from dbo.U_ECIG3KWD2N_File with (nolock)
         order by substring(Recordset,2,2), initialsort, subsort