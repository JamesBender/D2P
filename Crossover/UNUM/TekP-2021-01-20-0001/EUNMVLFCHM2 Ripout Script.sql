SET NOCOUNT ON;
IF OBJECT_ID('U_EUNMVLFCH2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNMVLFCH2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNMVLFCH2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNMVLFCH2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNMVLFCH2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNMVLFCH2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNMVLFCH2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNMVLFCH2];
GO
IF OBJECT_ID('U_EUNMVLFCH2_File') IS NOT NULL DROP TABLE [dbo].[U_EUNMVLFCH2_File];
GO
IF OBJECT_ID('U_EUNMVLFCH2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNMVLFCH2_EEList];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EUNMVLFCH2_Master') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EUNMVLFCH2_Master];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EUNMVLFCH2_Audit') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EUNMVLFCH2_Audit];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EUNMVLFCH2') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EUNMVLFCH2];
GO
IF OBJECT_ID('U_dsi_BDM_EUNMVLFCH2') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNMVLFCH2];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNMVLFCH2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNMVLFCH2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNMVLFCH2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNMVLFCH2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNMVLFCH2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','EUNMVLFCH2','UNUM - Voluntary Life UPD','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EUNMVLFCH2Z0','N','Mar 29 2019  9:02AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNMVLFCH2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"eEnroll2"','1','(''DA''=''T,'')','EUNMVLFCH2Z0','8','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLICY"','2','(''DA''=''T,'')','EUNMVLFCH2Z0','6','H','01','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIVISION"','3','(''DA''=''T,'')','EUNMVLFCH2Z0','8','H','01','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MEMBER ID"','4','(''DA''=''T,'')','EUNMVLFCH2Z0','9','H','01','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOH"','5','(''DA''=''T,'')','EUNMVLFCH2Z0','3','H','01','5',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SALARY"','6','(''DA''=''T,'')','EUNMVLFCH2Z0','6','H','01','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SALARY MODE"','7','(''DA''=''T,'')','EUNMVLFCH2Z0','11','H','01','7',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURS"','8','(''DA''=''T,'')','EUNMVLFCH2Z0','5','H','01','8',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM DATE"','9','(''DA''=''T,'')','EUNMVLFCH2Z0','9','H','01','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERM REASON"','10','(''DA''=''T,'')','EUNMVLFCH2Z0','11','H','01','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NEW MEMBER ID"','11','(''DA''=''T,'')','EUNMVLFCH2Z0','13','H','01','11',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','12','(''DA''=''T,'')','EUNMVLFCH2Z0','10','H','01','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE NAME"','13','(''DA''=''T,'')','EUNMVLFCH2Z0','11','H','01','13',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','14','(''DA''=''T,'')','EUNMVLFCH2Z0','9','H','01','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SUFFIX"','15','(''DA''=''T,'')','EUNMVLFCH2Z0','6','H','01','15',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','16','(''DA''=''T,'')','EUNMVLFCH2Z0','6','H','01','16',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','17','(''DA''=''T,'')','EUNMVLFCH2Z0','3','H','01','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE FIRST NAME"','18','(''DA''=''T,'')','EUNMVLFCH2Z0','17','H','01','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE GDR"','19','(''DA''=''T,'')','EUNMVLFCH2Z0','10','H','01','19',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SPOUSE DOB"','20','(''DA''=''T,'')','EUNMVLFCH2Z0','10','H','01','20',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLASS"','21','(''DA''=''T,'')','EUNMVLFCH2Z0','5','H','01','21',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SIGNATURE DATE"','22','(''DA''=''T,'')','EUNMVLFCH2Z0','14','H','01','22',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EFFECTIVE DATE"','23','(''DA''=''T,'')','EUNMVLFCH2Z0','14','H','01','23',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD TYPE"','24','(''DA''=''T,'')','EUNMVLFCH2Z0','8','H','01','24',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','25','(''DA''=''T,'')','EUNMVLFCH2Z0','10','H','01','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','26','(''DA''=''T,'')','EUNMVLFCH2Z0','9','H','01','26',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE "','27','(''DA''=''T,'')','EUNMVLFCH2Z0','24','H','01','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE "','28','(''DA''=''T,'')','EUNMVLFCH2Z0','18','H','01','28',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT "','29','(''DA''=''T,'')','EUNMVLFCH2Z0','25','H','01','29',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION "','30','(''DA''=''T,'')','EUNMVLFCH2Z0','18','H','01','30',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','31','(''DA''=''T,'')','EUNMVLFCH2Z0','10','H','01','31',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','32','(''DA''=''T,'')','EUNMVLFCH2Z0','9','H','01','32',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE "','33','(''DA''=''T,'')','EUNMVLFCH2Z0','24','H','01','33',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE "','34','(''DA''=''T,'')','EUNMVLFCH2Z0','18','H','01','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT "','35','(''DA''=''T,'')','EUNMVLFCH2Z0','25','H','01','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION "','36','(''DA''=''T,'')','EUNMVLFCH2Z0','18','H','01','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT ID"','37','(''DA''=''T,'')','EUNMVLFCH2Z0','10','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN CODE"','38','(''DA''=''T,'')','EUNMVLFCH2Z0','9','H','01','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT QUALIFYING DATE "','39','(''DA''=''T,'')','EUNMVLFCH2Z0','24','H','01','39',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT TERM DATE "','40','(''DA''=''T,'')','EUNMVLFCH2Z0','18','H','01','40',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION AMOUNT "','41','(''DA''=''T,'')','EUNMVLFCH2Z0','25','H','01','41',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BENEFIT SELECTION "','42','(''DA''=''T'')','EUNMVLFCH2Z0','18','H','01','42',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnroll2"','1','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','1',NULL,'eEnroll2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy"','2','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','2',NULL,'POLICY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDiv"','3','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','3',NULL,'DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberID"','4','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','4',NULL,'MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','5','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','5',NULL,'DOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','6','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','6',NULL,'SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode"','7','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','7',NULL,'SALARY MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrs"','8','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','8',NULL,'HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','9','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','9',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReason"','10','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','10',NULL,'TERM REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNewMemberID"','11','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','11',NULL,'NEW MEMBER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','12','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','12',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','13','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','13',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','14','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','14',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','15','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','15',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','16','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','16',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','17','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','17',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsFName"','18','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','18',NULL,'SPOUSE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsGender"','19','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','19',NULL,'SPOUSE GDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsDOB"','20','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','20',NULL,'SPOUSE DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClass"','21','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','21',NULL,'CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSigDate"','22','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','22',NULL,'SIGNATURE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate"','23','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','23',NULL,'EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddType"','24','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','24',NULL,'ADD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenID1"','25','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','25',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode1"','26','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','26',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenQualDate1"','27','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','27',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenTermDate1"','28','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','28',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenSelAmt1"','29','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','29',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenSel1"','30','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','30',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenID2"','31','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','31',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode2"','32','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','32',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenQualDate2"','33','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','33',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenTermDate2"','34','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','34',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenSelAmt2"','35','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','35',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenSel2"','36','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','36',NULL,'BENEFIT SELECTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenID3"','37','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','37',NULL,'BENEFIT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode3"','38','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','38',NULL,'PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenQualDate3"','39','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','39',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenTermDate3"','40','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','40',NULL,'BENEFIT TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenSelAmt3"','41','(''UA''=''T,'')','EUNMVLFCH2Z0','50','D','02','41',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenSel3"','42','(''UA''=''T'')','EUNMVLFCH2Z0','50','D','02','42',NULL,'BENEFIT SELECTION',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUNMVLFCH2_20210218.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','SPXF3,SPXML,SPXBO,SPXK9',NULL,NULL,NULL,'UNUM Voluntary Life','201903299','EMPEXPORT','EUNMVLFCH2','Apr  4 2019 12:10PM','EUNMVLFCH2',NULL,NULL,NULL,'202101149','Mar 29 2019 12:00AM','Dec 30 1899 12:00AM','202101071','11','','','201903151',dbo.fn_GetTimedKey(),NULL,'ULTI_WPCHMS',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM Voluntary Life - OEACT','201903299','EMPEXPORT','OEACTIVE',NULL,'EUNMVLFCH2',NULL,NULL,NULL,'201903299',NULL,NULL,'201903151',NULL,NULL,NULL,'201903151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM Voluntary Life - OEPAS','201903299','EMPEXPORT','OEPASSIVE',NULL,'EUNMVLFCH2',NULL,NULL,NULL,'201903299',NULL,NULL,'201903151',NULL,NULL,NULL,'201903151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UNUM Voluntary Life - TEST','202102091','EMPEXPORT','TEST','Feb  9 2021  5:21PM','EUNMVLFCH2',NULL,NULL,NULL,'202102091','Feb  9 2021 12:00AM','Dec 30 1899 12:00AM','202101011','70','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3rVaCRO1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','ExportDescription','C','UNUM - Voluntary Life');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','FileType','C','csv');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','InitialSort','C','drvMemberID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','MaxFileLength','C','2143');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','SystemID','V','46592E5A442D');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMVLFCH2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUNMVLFCH2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUNMVLFCH2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUNMVLFCH2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNMVLFCH2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNMVLFCH2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNMVLFCH2','D02','dbo.U_dsi_drvTbl_EUNMVLFCH2',NULL);
IF OBJECT_ID('U_dsi_BDM_EUNMVLFCH2') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNMVLFCH2] (
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
IF OBJECT_ID('U_Dsi_DrvTbl_EUNMVLFCH2') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EUNMVLFCH2] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [drvEnroll2] varchar(6) NOT NULL,
    [drvPolicy] varchar(6) NOT NULL,
    [drvDiv] varchar(4) NOT NULL,
    [drvMemberID] char(11) NULL,
    [drvDateOfHire] varchar(10) NULL,
    [drvSalary] money NULL,
    [drvSalaryMode] varchar(1) NOT NULL,
    [drvHrs] varchar(1) NOT NULL,
    [drvTermDate] varchar(10) NULL,
    [drvTermReason] varchar(2) NOT NULL,
    [drvNewMemberID] varchar(1) NOT NULL,
    [drvNameFirst] varchar(8000) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvNameSuffix] varchar(8000) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] varchar(10) NULL,
    [drvSpsFName] varchar(100) NULL,
    [drvSpsGender] varchar(1) NULL,
    [drvSpsDOB] varchar(10) NULL,
    [drvClass] varchar(4) NOT NULL,
    [drvSigDate] varchar(10) NULL,
    [drvEffDate] varchar(10) NULL,
    [drvAddType] varchar(1) NULL,
    [drvBenID1] varchar(2) NULL,
    [drvPlanCode1] varchar(6) NULL,
    [drvBenQualDate1] varchar(1) NOT NULL,
    [drvBenTermDate1] varchar(10) NULL,
    [drvBenSelAmt1] varchar(20) NULL,
    [drvBenSel1] varchar(1) NOT NULL,
    [drvBenID2] varchar(2) NULL,
    [drvPlanCode2] varchar(6) NULL,
    [drvBenQualDate2] varchar(1) NOT NULL,
    [drvBenTermDate2] varchar(10) NULL,
    [drvBenSelAmt2] varchar(20) NULL,
    [drvBenSel2] varchar(1) NOT NULL,
    [drvBenID3] varchar(2) NULL,
    [drvPlanCode3] varchar(6) NULL,
    [drvBenQualDate3] varchar(1) NOT NULL,
    [drvBenTermDate3] varchar(10) NULL,
    [drvBenSelAmt3] varchar(20) NULL,
    [drvBenSel3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EUNMVLFCH2_Audit') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EUNMVLFCH2_Audit] (
    [AudKey1Value] varchar(255) NULL,
    [AudKey2Value] varchar(255) NOT NULL,
    [AudKey3Value] varchar(255) NOT NULL,
    [AudTableName] varchar(128) NOT NULL,
    [AudFieldName] varchar(128) NOT NULL,
    [AudOldValue] varchar(256) NULL,
    [AudNewValue] varchar(256) NULL,
    [AudDateTime] datetime NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EUNMVLFCH2_Master') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EUNMVLFCH2_Master] (
    [MstCOID] char(5) NULL,
    [MstEEID] char(12) NULL,
    [MstAddType] varchar(1) NOT NULL,
    [MstMaxBenefitDate] datetime NULL,
    [MstMaxAuditDate] datetime NULL,
    [MstSalEffDate] datetime NULL
);
IF OBJECT_ID('U_EUNMVLFCH2_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNMVLFCH2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNMVLFCH2_File') IS NULL
CREATE TABLE [dbo].[U_EUNMVLFCH2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNMVLFCH2]
 @systemid varchar(12) = ''
AS
BEGIN

/**********************************************************************
Client Name: Crossover Health Management Services
Vendor: UNUM - Voluntary Life (Policy #879961)
Created By: Tony DiMaio
Business Analyst: Nick Watkins
Create Date: 03/29/2019
Service Request Number: SF 00226674

Changes:
MM/DD/YYYY    NAME HERE     SF 09999999              Comments Here

_dsi_usp_ExportRipout 'EUNMVLFCH2','Y' 

select * from dbo.U_dsi_Configuration where FormatCode = 'EUNMVLFCH2' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'EUNMVLFCH2'
select * from dbo.U_dsi_Parameters where FormatCode = 'EUNMVLFCH2'

select * from AscDefH where AdhFormatCode = 'EUNMVLFCH2'
select * from AscExp where expFormatCode = 'EUNMVLFCH2'
select * from ascdeff where AdfHeaderSystemID = 'EUNMVLFCH2Z0' order by adfrectype, AdfSetNumber, AdfFieldNumber 

DSI_SP_TESTSWITCHBOX_V2 'EUNMVLFCH2', 'EUNMVLFCH2'
DSI_SP_TESTSWITCHBOX_V2 'EUNMVLFCH2', 'TEST'
DSI_SP_TESTSWITCHBOX_V2 'EUNMVLFCH2', 'OEACTIVE'
DSI_SP_TESTSWITCHBOX_V2 'EUNMVLFCH2', 'OEPASSIVE'

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'EUNMVLFCH2' AND CfgName = 'TESTING'

**************************/

-----------
-- Collect Date Parameters
-----------

DECLARE

@StartDate       DATETIME,
@EndDate         DATETIME,
@StartPerControl CHAR(9),
@EndPerControl   CHAR(9),
@FormatCode      CHAR(10),
@ExportCode      CHAR(10),
@ExportFile      CHAR(200)

SELECT

@StartDate       = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
@EndDate         = DATEADD(SS, -1, DATEADD(DD, 1, LEFT(EndPerControl, 8))), -- 11:59:59
@StartPerControl = StartPerControl,
@EndPerControl   = EndPerControl,
@FormatCode      = RTRIM(FormatCode),
@ExportCode      = ExportCode,
@Exportfile      = ExportFile

FROM dbo.U_Dsi_Parameters
WHERE FormatCode = 'EUNMVLFCH2'

-----------
-- Drop Tables
-----------

IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EUNMVLFCH2')        IS NOT NULL DROP TABLE dbo.U_Dsi_DrvTbl_EUNMVLFCH2
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Audit')  IS NOT NULL DROP TABLE dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Audit
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Master') IS NOT NULL DROP TABLE dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Master

-----------
-- Run BDM
-----------

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','UNVOL,VOLCH,VOLSP')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'BuildConsolidatedTable', 'Standard')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TableType', 'EMP')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime', @StartDate)
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime', @EndDate)

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode
EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode

-----------
-- Update BDM consolidated table (both employees and dependents) with benefit amount from employee
-----------

UPDATE dbo.u_dsi_Bdm_EUNMVLFCH2
   SET BdmEEAmt = BcaBenAmtCalc
  FROM dbo.u_dsi_Bdm_EUNMVLFCH2
  JOIN dbo.u_dsi_Bdm_BenCalculationAmounts ON BcaFormatCode = @FormatCode AND BcaEEID = BdmEEID AND BcaDedCode = BdmDedCode AND BcaDepRecID IS NULL

-----------
-- Update BDM consolidated table with stop date
-----------

-- If the employee is terming, Unum does NOT want their individual plans to term.
-- Plan stops are only sent if the employee is waiving coverage.
-- To keep the original stop date intact, we use BdmUSGDate1.

UPDATE dbo.u_dsi_Bdm_EUNMVLFCH2
   SET BdmUSGDate1 = CASE WHEN EecEmplStatus = 'T' THEN NULL ELSE BdmBenStopDate END
  FROM dbo.u_dsi_Bdm_EUNMVLFCH2
JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = BdmEEID AND EecCoID = BdmCOID

-----------
-- Reduce EEList to employees with benefits
-----------

DELETE FROM dbo.U_EUNMVLFCH2_EEList

INSERT INTO U_EUNMVLFCH2_EEList
SELECT DISTINCT BdmCOID, BDmEEID FROM U_dsi_bdm_EUNMVLFCH2

-----------
-- Gather audit data
-----------

-- Create audit table

CREATE TABLE [dbo].[U_Dsi_DrvTbl_EUNMVLFCH2_Audit](
  [AudKey1Value] [VARCHAR](255)  NULL,
  [AudKey2Value] [VARCHAR](255)  NOT NULL,
  [AudKey3Value] [VARCHAR](255)  NOT NULL,
  [AudTableName] [VARCHAR](128)  NOT NULL,
  [AudFieldName] [VARCHAR](128)  NOT NULL,
  [AudOldValue]  [VARCHAR](256)  NULL,
  [AudNewValue]  [VARCHAR](256)  NULL,
  [AudDateTime]  [DATETIME]      NOT NULL
) ON [PRIMARY]

-- Insert demographic changes

INSERT INTO dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Audit
SELECT DISTINCT

AudKey1Value,
AudKey2Value,
AudKey3Value,
AudTableName,
AudFieldName,
AudOldValue,
AudNewValue,
AudDateTime

FROM dbo.U_EUNMVLFCH2_EEList
JOIN vw_AuditEEdata ON xEEID = AudKey1Value
WHERE AudDateTime BETWEEN @StartDate AND @EndDate
  AND AudTableName IN ('EmpComp', 'EmpPers')
  AND AudFieldName IN ('EecAnnSalary', 'EecCoID', 'EecDateOfLastHire', 'EecDateOfTermination', 'EecEEType', 'EecEmplStatus', 'EecScheduledAnnualHrs', 'EepDateOfBirth', 'EepGender', 'EepNameFirst', 'EepNameLast', 'EepNameMiddle', 'EepNameSuffix', 'EepSSN',
 'EecFullTimeOrPartTime', 'EecDedGroupCode', 'EecJobCode') --JobCode added for Job CLASS (pcf) changes
ORDER BY AudFieldName

-- Insert benefits changes

INSERT INTO dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Audit
SELECT DISTINCT

AudKey1Value,
AudKey2Value,
AudKey3Value,
AudTableName,
AudFieldName,
AudOldValue,
AudNewValue,
AudDateTime

FROM dbo.U_EUNMVLFCH2_EEList
JOIN vw_AuditEEdata ON xEEID = AudKey1Value
WHERE AudDateTime BETWEEN @StartDate AND @EndDate
  AND AudTableName = 'EmpDed'
  AND AudFieldName IN ('EedBenAmt', 'EedBenOption', 'EedBenStartDate', 'EedBenStopDate')
  AND AudKey3Value IN ('UNVOL', 'VOLCH', 'VOLSP')
ORDER BY AudFieldName

-----------
-- Remove AUDIT 'eecJobCode' records where Job CLASS (Platform Config Field not changed)
-----------

DELETE FROM dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Audit
WHERE AudFieldName = 'EecJobCode'
AND AudNewValue NOT IN (SELECT cfgAudKey1Value
                        FROM vw_dsi_CfgAuditData
                        WHERE cfgAudClass = 'SJob'
                        AND cfgAudFieldname = '_BDisabilityClass'
                        AND cfgAudDateTime BETWEEN @StartDate AND @EndDate)

-----------
-- Reduce EEList to employees with audit changes
-----------

IF @ExportCode NOT IN ('OEACTIVE','OEPASSIVE')
BEGIN

    DELETE FROM dbo.U_EUNMVLFCH2_EEList

    INSERT INTO U_EUNMVLFCH2_EEList
    SELECT DISTINCT dbo.dsi_fn_GetCurrentCOID(AudKey1Value), AudKey1Value FROM U_Dsi_DrvTbl_EUNMVLFCH2_Audit

END

-----------------------
-- Create master table for employees
-----------------------

SELECT DISTINCT

MstCOID           = xCOID,
MstEEID           = xEEID,
MstAddType        = ' ',
MstMaxBenefitDate = CONVERT(DATETIME, NULL),
MstMaxAuditDate   = CONVERT(DATETIME, NULL),
MstSalEffDate     = CONVERT(DATETIME, NULL)

INTO dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Master
FROM U_EUNMVLFCH2_EEList

-- Update max benefit start date

UPDATE dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Master SET MstMaxBenefitDate = (SELECT MAX(BdmBenStartDate) FROM U_dsi_bdm_EUNMVLFCH2 WHERE BdmEEID = MstEEID)

-- Update max audit date

UPDATE dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Master SET MstMaxAuditDate = (SELECT MAX(AudDateTime) FROM U_Dsi_DrvTbl_EUNMVLFCH2_Audit WHERE AudKey1Value = MstEEID);

-- Update salary effective date

WITH TempSelectTable AS (

   SELECT

   EjhEEID            TmpEEID,
   MAX(EjhJobEffDate) TmpSalEffDate

   FROM EmpHJob
   JOIN U_EUNMVLFCH2_EEList WITH (NOLOCK) ON xCOID = EjhCOID AND xEEID = EjhEEID
   WHERE EjhIsRateChange = 'Y'
   GROUP BY EjhEEID
)
UPDATE U_Dsi_DrvTbl_EUNMVLFCH2_Master
   SET MstSalEffDate = TmpSalEffDate
  FROM TempSelectTable
 WHERE MstEEID = TmpEEID
   AND TmpSalEffDate IS NOT NULL;

-- Update add type

WITH TempSelectTable AS (

   SELECT DISTINCT

   AudKey1Value TmpEEID

   FROM U_Dsi_DrvTbl_EUNMVLFCH2_Audit
   WHERE (AudFieldName = 'EecEmplStatus' AND AudOldValue = 'T' AND AudNewValue = 'A')
      OR (AudFieldName = 'EecEEType' AND AudOldValue IS NOT NULL AND AudNewValue = 'REG')
      OR (AudFieldName = 'EecDedGroupCode' AND AudOldValue = 'NONE' AND AudNewValue <> 'NONE')
)
UPDATE U_Dsi_DrvTbl_EUNMVLFCH2_Master
   SET MstAddType = 'O'
  FROM TempSelectTable
 WHERE MstEEID = TmpEEID;

-----------
-- Build driver table
-----------

SELECT DISTINCT

DrvCOID         = MstCOID,
DrvEEID         = MstEEID,
drvEnroll2      = '      ',
drvPolicy       = '879961',
drvDiv          = '0001',
drvMemberID     = EepSSN,
drvDateOfHire   = CONVERT(VARCHAR(10), EecDateOfLastHire, 101),
drvSalary       = case when isnumeric(isnull(eecUDField03,0)) = 0 then EecAnnSalary
                  else cast(isnull(eecAnnSalary,0.00) as money)*cast(ISNULL(eecUDField03,0) as int)/100 + cast(isnull(eecAnnSalary,0.00) as money)
                  end,
drvSalaryMode   = 'A',
drvHrs          = '',
drvTermDate     = CONVERT(VARCHAR(10), EecDateOfTermination, 101),
drvTermReason   = CASE
                    WHEN EecEmplStatus = 'T' THEN
                    CASE WHEN EecTermReason = '202' THEN 'RT'
                         WHEN EecTermReason = '203'    THEN 'DT'
                    ELSE 'TE'
                    END
                    ELSE ''
                  END,
drvNewMemberID  = '',
drvNameFirst    = REPLACE(EepNameFirst,',',''),
drvNameMiddle   = UPPER(LEFT(EepNameMiddle, 1)),
drvNameLast     = REPLACE(EepNameLast,',',''),
drvNameSuffix   = UPPER(REPLACE(EepNameSuffix,',.','')),
drvGender       = EepGender,
drvDateofBirth  = CONVERT(VARCHAR(10), EepDateOfBirth, 101),
drvSpsFName     = CASE WHEN splife.BdmEEID IS NOT NULL THEN COALESCE(ConNameFirst, '') ELSE CONVERT(VARCHAR(30), '') END,
drvSpsGender    = CASE WHEN splife.BdmEEID IS NOT NULL THEN COALESCE(ConGender, '') ELSE CONVERT(VARCHAR(1), '') END,
drvSpsDOB       = CASE WHEN splife.BdmEEID IS NOT NULL THEN CONVERT(VARCHAR(10), COALESCE(ConDateOfBirth, ''), 101) ELSE NULL END, --CONVERT(VARCHAR(10), '')
drvClass        = '1000',--TD 4/3/19
drvSigDate      = CONVERT(VARCHAR(10),MstMaxAuditDate,101),
--drvEffDate      = CONVERT(VARCHAR(10),MstMaxAuditDate,101),
drvEffDate      = CONVERT(VARCHAR(10),
                        CASE
                            WHEN eecDateOfLastHire < eecDateOfOriginalHire THEN eecDateOfLastHire
                            WHEN eecEmplStatus = 'T' and ISNULL(eecDateOfTermination,'') <> '' then eecDateOfTermination
                            WHEN isnull(mstSalEffDate,'') <> '' then mstSalEffDate
                        ELSE GetDate()
                        END
                  ,101),
drvAddType      = CONVERT(VARCHAR(1), MstAddType), 

drvBenID1       = CASE WHEN eelife.BdmEEID IS NOT NULL THEN 'LM'     ELSE CONVERT(VARCHAR(2), '') END,
drvPlanCode1    = CASE WHEN eelife.BdmEEID IS NOT NULL THEN '5.0N22' ELSE CONVERT(VARCHAR(2), '') END,
drvBenQualDate1 = '',
drvBenTermDate1 = CASE WHEN eelife.BdmBenStopDate IS NOT NULL THEN CONVERT(VARCHAR(10), eelife.BdmBenStopDate, 101) ELSE '' END,
drvBenSelAmt1   = CASE WHEN eelife.BdmEEID IS NOT NULL THEN CONVERT(CHAR(20), CONVERT(NUMERIC(12,0), ceiling(eelife.BdmEEAmt/10000.0) * 10000)) ELSE '' END,
drvBenSel1      = '',

drvBenID2       = CASE WHEN splife.BdmEEID IS NOT NULL THEN 'LS'     ELSE CONVERT(VARCHAR(2), '') END,
drvPlanCode2    = CASE WHEN splife.BdmEEID IS NOT NULL THEN '5.AN47' ELSE CONVERT(VARCHAR(2), '') END,
drvBenQualDate2 = '',
drvBenTermDate2 = CASE WHEN splife.BdmBenStopDate IS NOT NULL THEN CONVERT(VARCHAR(10), splife.BdmBenStopDate, 101) ELSE '' END,
drvBenSelAmt2   = CASE WHEN splife.BdmEEID IS NOT NULL THEN CONVERT(CHAR(20), CONVERT(NUMERIC(12,0), ceiling(splife.BdmEEAmt/5000.0) * 5000)) ELSE '' END,
drvBenSel2      = '',

drvBenID3       = CASE WHEN chlife.BdmEEID IS NOT NULL THEN 'LC'     ELSE CONVERT(VARCHAR(2), '') END,
drvPlanCode3    = CASE WHEN chlife.BdmEEID IS NOT NULL THEN '5.0M04' ELSE CONVERT(VARCHAR(2), '') END,
drvBenQualDate3 = '',
drvBenTermDate3 = CASE WHEN chlife.BdmBenStopDate IS NOT NULL THEN CONVERT(VARCHAR(10), chlife.BdmBenStopDate, 101) ELSE '' END,
drvBenSelAmt3   = CASE WHEN chlife.BdmEEID IS NOT NULL THEN CONVERT(CHAR(20), CONVERT(NUMERIC(12,0), ceiling(chlife.BdmEEAmt/2000.0) * 2000)) ELSE '' END,
drvBenSel3      = ''

-- drvBenID4       = CASE WHEN eeadd.BdmEEID IS NOT NULL THEN 'AM'     ELSE CONVERT(VARCHAR(2), '') END,
-- drvPlanCode4    = CASE WHEN eeadd.BdmEEID IS NOT NULL THEN '5.0S17' ELSE CONVERT(VARCHAR(2), '') END,
-- drvBenQualDate4 = '',
-- drvBenTermDate4 = CASE WHEN eeadd.BdmBenStopDate IS NOT NULL THEN CONVERT(VARCHAR(10), eeadd.BdmBenStopDate, 101) ELSE '' END,
-- drvBenSelAmt4   = CASE WHEN eeadd.BdmEEID IS NOT NULL THEN CONVERT(CHAR(20), CONVERT(NUMERIC(12,0), eeadd.BdmEEAmt)) ELSE '' END,
-- drvBenSel4      = '',

-- drvBenID5       = CASE WHEN spadd.BdmEEID IS NOT NULL THEN 'AS'     ELSE CONVERT(VARCHAR(2), '') END,
-- drvPlanCode5    = CASE WHEN spadd.BdmEEID IS NOT NULL THEN '5.0L02' ELSE CONVERT(VARCHAR(2), '') END,
-- drvBenQualDate5 = '',
-- drvBenTermDate5 = CASE WHEN spadd.BdmBenStopDate IS NOT NULL THEN CONVERT(VARCHAR(10), spadd.BdmBenStopDate, 101) ELSE '' END,
-- drvBenSelAmt5   = CASE WHEN spadd.BdmEEID IS NOT NULL THEN CONVERT(CHAR(20), CONVERT(NUMERIC(12,0), spadd.BdmEEAmt)) ELSE '' END,
-- drvBenSel5      = '',

-- drvBenID6       = CASE WHEN chadd.BdmEEID IS NOT NULL THEN 'AC'     ELSE CONVERT(VARCHAR(2), '') END,
-- drvPlanCode6    = CASE WHEN chadd.BdmEEID IS NOT NULL THEN '5.0L23' ELSE CONVERT(VARCHAR(2), '') END,
-- drvBenQualDate6 = '',
-- drvBenTermDate6 = CASE WHEN chadd.BdmBenStopDate IS NOT NULL THEN CONVERT(VARCHAR(10), chadd.BdmBenStopDate, 101) ELSE '' END,
-- drvBenSelAmt6   = CASE WHEN chadd.BdmEEID IS NOT NULL THEN CONVERT(CHAR(20), CONVERT(NUMERIC(12,0), chadd.BdmEEAmt)) ELSE '' END,
-- drvBenSel6      = ''

INTO dbo.U_Dsi_DrvTbl_EUNMVLFCH2
FROM dbo.U_Dsi_DrvTbl_EUNMVLFCH2_Master with (NOLOCK)
JOIN EmpPers with (NOLOCK) ON MstEEID = EepEEID
JOIN EmpComp with (NOLOCK) ON MstEEID = EecEEID AND MstCOID = EecCoID
LEFT JOIN dbo.fn_mp_customFields_Jobcode_Export(null,null,null,null) jcPCF on jcPCF.jbcJobCode = EecJobCode

LEFT JOIN U_dsi_bdm_EUNMVLFCH2 eelife WITH (NOLOCK) ON eelife.BdmEEID = MstEEID AND eelife.BdmDedCode = 'UNVOL'
LEFT JOIN U_dsi_bdm_EUNMVLFCH2 splife WITH (NOLOCK) ON splife.BdmEEID = MstEEID AND splife.BdmDedCode = 'VOLSP'
LEFT JOIN U_dsi_bdm_EUNMVLFCH2 chlife WITH (NOLOCK) ON chlife.BdmEEID = MstEEID AND chlife.BdmDedCode = 'VOLCH'

-- LEFT JOIN U_dsi_bdm_EUNMVLFCH2 eeadd WITH (NOLOCK) ON eeadd.BdmEEID = MstEEID AND eeadd.BdmDedCode = 'ADD'
-- LEFT JOIN U_dsi_bdm_EUNMVLFCH2 spadd WITH (NOLOCK) ON spadd.BdmEEID = MstEEID AND spadd.BdmDedCode = 'ADDS'
-- LEFT JOIN U_dsi_bdm_EUNMVLFCH2 chadd WITH (NOLOCK) ON chadd.BdmEEID = MstEEID AND chadd.BdmDedCode = 'ADDC'

LEFT JOIN Contacts spouse WITH (NOLOCK) ON spouse.ConEEID = MstEEID AND spouse.ConRelationship = 'SPS'

-----------
-- Create Header
----------

UPDATE TOP (1) dbo.U_Dsi_DrvTbl_EUNMVLFCH2
   SET drvEnroll2 = (SELECT CONVERT(CHAR(6), COUNT(1)) FROM dbo.U_Dsi_DrvTbl_EUNMVLFCH2)
  FROM dbo.U_Dsi_DrvTbl_EUNMVLFCH2
 WHERE drvMemberID = (SELECT TOP (1) drvMemberID FROM dbo.U_Dsi_DrvTbl_EUNMVLFCH2 ORDER BY drvMemberID)

-----------
--Set filename
-----------

IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N') BEGIN
   UPDATE dbo.U_dsi_Parameters
      SET ExportFile =  @FormatCode + '_' + CONVERT(CHAR(8) ,GETDATE(), 112) + '.txt'
    WHERE FormatCode = @FormatCode
END

END

--DSI_SP_TESTSWITCHBOX_V2 'EUNMVLFCH2', 'TEST'
GO
CREATE VIEW dbo.dsi_vwEUNMVLFCH2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUNMVLFCH2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort