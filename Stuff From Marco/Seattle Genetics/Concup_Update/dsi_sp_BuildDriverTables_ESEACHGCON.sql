SET NOCOUNT ON;
IF OBJECT_ID('U_ESEACHGC2N_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESEACHGC2N_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESEACHGC2N_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESEACHGC2N' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESEACHGC2N_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESEACHGC2N_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESEACHGC2N') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESEACHGC2N];
GO
IF OBJECT_ID('U_ESEACHGC2N_Supervisors') IS NOT NULL DROP TABLE [dbo].[U_ESEACHGC2N_Supervisors];
GO
IF OBJECT_ID('U_ESEACHGC2N_File') IS NOT NULL DROP TABLE [dbo].[U_ESEACHGC2N_File];
GO
IF OBJECT_ID('U_ESEACHGC2N_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESEACHGC2N_EEList];
GO
IF OBJECT_ID('U_ESEACHGC2N_AudFieldList') IS NOT NULL DROP TABLE [dbo].[U_ESEACHGC2N_AudFieldList];
GO
IF OBJECT_ID('U_dsi_ESEACHGC2N_drvTbl_700') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESEACHGC2N_drvTbl_700];
GO
IF OBJECT_ID('U_dsi_ESEACHGC2N_drvTbl_350') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESEACHGC2N_drvTbl_350];
GO
IF OBJECT_ID('U_dsi_ESEACHGC2N_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESEACHGC2N_drvTbl];
GO
IF OBJECT_ID('U_ds_ESEACHGC2N_auditChanges') IS NOT NULL DROP TABLE [dbo].[U_ds_ESEACHGC2N_auditChanges];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESEACHGC2N';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESEACHGC2N';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESEACHGC2N';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESEACHGC2N';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESEACHGC2N';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','ESEACHGC2N','CONCUR EMP 300 Changes Version 2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2360','S','N','ESEACHGC2NZ0','N',NULL,'C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESEACHGC2N' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"100"','1','(''DA''=''T,'')','ESEACHGC2NZ0','35','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','2','(''DA''=''T,'')','ESEACHGC2NZ0','35','H','01','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"welcome"','3','(''DA''=''T,'')','ESEACHGC2NZ0','35','H','01','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UPDATE"','4','(''DA''=''T,'')','ESEACHGC2NZ0','35','H','01','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','5','(''DA''=''T,'')','ESEACHGC2NZ0','35','H','01','5',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','6','(''DA''=''T,'')','ESEACHGC2NZ0','35','H','01','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','7','(''DA''=''T'')','ESEACHGC2NZ0','35','H','01','7',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransType"','1','(''UA''=''T,'')','ESEACHGC2NZ0','3','D','02','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','2','(''UA''=''T,'')','ESEACHGC2NZ0','32','D','02','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','3','(''UA''=''T,'')','ESEACHGC2NZ0','32','D','02','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','4','(''UA''=''T,'')','ESEACHGC2NZ0','32','D','02','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpID"','5','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','5',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoginID"','6','(''UA''=''T,'')','ESEACHGC2NZ0','64','D','02','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPassword"','7','(''UA''=''T,'')','ESEACHGC2NZ0','30','D','02','7',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','8','(''UA''=''T,'')','ESEACHGC2NZ0','255','D','02','8',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocaleCode"','9','(''UA''=''T,'')','ESEACHGC2NZ0','5','D','02','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCtryCode"','10','(''UA''=''T,'')','ESEACHGC2NZ0','2','D','02','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCtrySubCode"','11','(''UA''=''T,'')','ESEACHGC2NZ0','6','D','02','11',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLedgerCode"','12','(''UA''=''T,'')','ESEACHGC2NZ0','20','D','02','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReimbursementCRNCode"','13','(''UA''=''T,'')','ESEACHGC2NZ0','6','D','02','13',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCashAdvanceAccountCode"','14','(''UA''=''T,'')','ESEACHGC2NZ0','20','D','02','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActive"','15','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','15',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgUnit1"','16','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','16',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgUnit2"','17','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgUnit3"','18','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgUnit4"','19','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','19',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgUnit5"','20','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','20',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgUnit6"','21','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','21',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom1"','22','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','22',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom2"','23','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','23',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom3"','24','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','24',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom4"','25','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom5"','26','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','26',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom6"','27','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom7"','28','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','28',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom8"','29','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','29',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom9"','30','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','30',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom10ConcurInvoicegrouphierarchy"','31','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','31',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom11"','32','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','32',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom12"','33','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','33',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom13"','34','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom14"','35','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom15"','36','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom16"','37','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom17APVendorID"','38','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom18"','39','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','39',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom19"','40','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','40',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom20"','41','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','41',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom21ConcurExpensegrouphierarchy"','42','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','42',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCashAdvanceStatusChanges"','43','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','43',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCashAdvanceWaitingAprroval"','44','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','44',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportStatusChanges"','45','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','45',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportWaitingApproval"','46','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','46',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmittingReport"','47','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','47',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTravelRequestStatusChanges"','48','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','48',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTravelRequestWaitingAproval"','49','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','49',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPromptforapproversubmittingatravelrequest"','50','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','50',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvpaymentstatuschanges"','51','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','51',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvpaymentisawaitingapproval"','52','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','52',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPromptforapproversubmittingapayment"','53','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','53',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrompttoaddcompanycardtransactionstoreport"','54','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','54',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvnewcompanycardtransactionsarrive"','55','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','55',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvfaxedreceiptsreceived"','56','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','56',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisplayinstructionalhelponapplicationpages"','57','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','57',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisplayimagingintroductionpage"','58','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','58',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIDofexpensereportapprover"','59','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','59',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIDofcashadvanceapprover"','60','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','60',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIDofauthorizationrequestapprover"','61','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','61',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIDofpaymentapprover"','62','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','62',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExpenseUserTraveler"','63','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','63',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApprover"','64','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','64',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyCardAdmin"','65','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','65',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIntegrationAdmin"','66','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','66',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAuthorizationRequestApprover"','67','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','67',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIntegrationAdministror"','68','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','68',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReceiptProcessor"','69','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','69',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDesktopAdmin"','70','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','70',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfflineUser"','71','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','71',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingConfigAdmin"','72','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','72',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPMTUser"','73','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','73',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPMTApprover"','74','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','74',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPMTVendorApprover"','75','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','75',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExpenseAuditRequired"','76','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','76',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBIManagerEmployeeID"','77','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','02','77',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTravelRequestUser"','78','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','78',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTravelRequestManager"','79','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFutureUse4"','80','(''UA''=''T,'')','ESEACHGC2NZ0','50','D','02','80',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPaymentRequestAssigned"','81','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','81',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInvoiceUser"','82','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','82',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drTravelExpenseUser"','83','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','83',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxAdministrator"','84','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','84',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFBTAdministrator"','85','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','02','85',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCliqbookUser"','86','(''UA''=''T'')','ESEACHGC2NZ0','1','D','02','86',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransType"','1','(''UA''=''T,'')','ESEACHGC2NZ0','3','D','03','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpID"','2','(''UA''=''T,'')','ESEACHGC2NZ0','48','D','03','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamePrefix"','3','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','4','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNickName"','5','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','5',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRedressNum"','6','(''UA''=''T,'')','ESEACHGC2NZ0','13','D','03','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','7','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','7',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','8','(''UA''=''T,'')','ESEACHGC2NZ0','10','D','03','8',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerCmpyEmpID"','9','(''UA''=''T,'')','ESEACHGC2NZ0','128','D','03','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','10','(''UA''=''T,'')','ESEACHGC2NZ0','255','D','03','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','11','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','11',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','12','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkFax"','13','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','13',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','14','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCellPhone"','15','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','15',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPagerPhone"','16','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','16',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTravelNameRemark"','17','(''UA''=''T,'')','ESEACHGC2NZ0','30','D','03','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTravelClassName"','18','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGDSProfileName"','19','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','19',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgUnitDiv"','20','(''UA''=''T,'')','ESEACHGC2NZ0','60','D','03','20',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeStreetAddr"','21','(''UA''=''T,'')','ESEACHGC2NZ0','255','D','03','21',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCity"','22','(''UA''=''T,'')','ESEACHGC2NZ0','30','D','03','22',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeState"','23','(''UA''=''T,'')','ESEACHGC2NZ0','30','D','03','23',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePostalCode"','24','(''UA''=''T,'')','ESEACHGC2NZ0','20','D','03','24',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCountry"','25','(''UA''=''T,'')','ESEACHGC2NZ0','2','D','03','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStreetAddr"','26','(''UA''=''T,'')','ESEACHGC2NZ0','256','D','03','26',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCity"','27','(''UA''=''T,'')','ESEACHGC2NZ0','30','D','03','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','28','(''UA''=''T,'')','ESEACHGC2NZ0','30','D','03','28',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPostalCode"','29','(''UA''=''T,'')','ESEACHGC2NZ0','20','D','03','29',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCountry"','30','(''UA''=''T,'')','ESEACHGC2NZ0','2','D','03','30',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail2"','31','(''UA''=''T,'')','ESEACHGC2NZ0','200','D','03','31',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail3"','32','(''UA''=''T,'')','ESEACHGC2NZ0','200','D','03','32',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom1"','33','(''UA''=''T,'')','ESEACHGC2NZ0','30','D','03','33',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom2"','34','(''UA''=''T,'')','ESEACHGC2NZ0','30','D','03','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom3"','35','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom4"','36','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom5"','37','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom6"','38','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom7"','39','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','39',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom8"','40','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','40',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom9"','41','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','41',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom10"','42','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','42',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom11"','43','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','43',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom12"','44','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','44',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom13"','45','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','45',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom14"','46','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','46',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom15"','47','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','47',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom16"','48','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','48',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom17"','49','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','49',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom18"','50','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','50',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom19"','51','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','51',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom20"','52','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','52',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom21"','53','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','53',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom22"','54','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','54',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom23"','55','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','55',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom24"','56','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','56',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustom25"','57','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','57',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvXMLProfileSynchID"','58','(''UA''=''T,'')','ESEACHGC2NZ0','64','D','03','58',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProfileUser"','59','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','59',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmadeusUser"','60','(''UA''=''T,'')','ESEACHGC2NZ0','1','D','03','60',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFutureUse4"','61','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','61',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFutureUse5"','62','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','62',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFutureUse6"','63','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','63',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFutureUse7"','64','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','64',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFutureUse8"','65','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','65',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFutureUse9"','66','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','03','66',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFutureUse10"','67','(''UA''=''T'')','ESEACHGC2NZ0','25','D','03','67',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransType"','1','(''UA''=''T,'')','ESEACHGC2NZ0','3','D','04','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApprovalType"','2','(''UA''=''T,'')','ESEACHGC2NZ0','3','D','04','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpID"','3','(''UA''=''T,'')','ESEACHGC2NZ0','10','D','04','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','5',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','7',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','8',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','11',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','13',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''T,'')','ESEACHGC2NZ0','1','D','04','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApprovalLimit"','15','(''UA''=''T,'')','ESEACHGC2NZ0','25','D','04','15',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApprovalLimitCurrencyCode"','16','(''UA''=''T'')','ESEACHGC2NZ0','25','D','04','16',NULL,NULL,NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESEACHGC2N_20201013.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',T2Z78,Y0WM3,Y0XQQ,Y0Z1W,Y0ZZU,Y0RLX,IAGFG,8H18R,T2ZAN,FBBH5',NULL,NULL,NULL,'Concur Daily Changes Export','202006239','EMPEXPORT','ESEACHGC2N',NULL,'ESEACHGC2N',NULL,NULL,NULL,'202010129',NULL,NULL,'202010111',NULL,'','','202006231',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','T2Z78,Y0WM3,Y0XQQ,Y0Z1W,Y0ZZU,Y0RLX,IAGFG,8H18R,T2ZAN,FBBH5',NULL,NULL,NULL,'Concur Changes Test','202010101','EMPEXPORT','TEST','Oct 13 2020  6:14PM','ESEACHGC2N',NULL,NULL,NULL,'202010101','Oct 10 2020 12:00AM','Dec 30 1899 12:00AM','202010011','432','','','202010011',dbo.fn_GetTimedKey(),NULL,'us3cPeSEA1008',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'unlock Concur Changes','201406279','EMPEXPORT','ZAP','Jul 27 2014 12:00AM','ESEACHGC2N',NULL,NULL,NULL,'201406279','Jun 27 2014 12:00AM','Dec 30 1899 12:00AM','201406011','-99','','','201406011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPSEAG',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEACHGC2N','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEACHGC2N','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEACHGC2N','ExportDescription','C','CONCUR EMP 300 Changes');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEACHGC2N','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEACHGC2N','InitialSort','C','drvEmpID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEACHGC2N','MaxFileLength','C','2360');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEACHGC2N','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEACHGC2N','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEACHGC2N','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEACHGC2N','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESEACHGC2N' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESEACHGC2N' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESEACHGC2N_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESEACHGC2N_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEACHGC2N','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEACHGC2N','D02','dbo.U_dsi_ESEACHGC2N_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEACHGC2N','D03','dbo.U_dsi_ESEACHGC2N_drvTbl_350',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEACHGC2N','D04','dbo.U_dsi_ESEACHGC2N_drvTbl_700',NULL);
IF OBJECT_ID('U_ds_ESEACHGC2N_auditChanges') IS NULL
CREATE TABLE [dbo].[U_ds_ESEACHGC2N_auditChanges] (
    [eeid] varchar(255) NULL,
    [coid] varchar(255) NULL,
    [auditdate] datetime NULL,
    [audfieldname] varchar(128) NOT NULL,
    [newuser] varchar(1) NULL
);
IF OBJECT_ID('U_dsi_ESEACHGC2N_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ESEACHGC2N_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvTransType] varchar(3) NOT NULL,
    [drvFirstName] varchar(6000) NULL,
    [drvMiddleName] varchar(6000) NULL,
    [drvLastName] varchar(6000) NULL,
    [drvEmpID] char(9) NULL,
    [drvLoginID] varchar(50) NULL,
    [drvPassword] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvLocaleCode] varchar(5) NOT NULL,
    [drvCtryCode] char(2) NULL,
    [drvCtrySubCode] varchar(1) NOT NULL,
    [drvLedgerCode] varchar(12) NOT NULL,
    [drvReimbursementCRNCode] varchar(3) NULL,
    [drvCashAdvanceAccountCode] varchar(1) NOT NULL,
    [drvActive] varchar(1) NOT NULL,
    [drvOrgUnit1] char(6) NULL,
    [drvOrgUnit2] nvarchar(4000) NULL,
    [drvOrgUnit3] varchar(1) NOT NULL,
    [drvOrgUnit4] varchar(3) NULL,
    [drvOrgUnit5] varchar(1) NOT NULL,
    [drvOrgUnit6] varchar(1) NOT NULL,
    [drvCustom1] varchar(1) NOT NULL,
    [drvCustom2] varchar(1) NOT NULL,
    [drvCustom3] varchar(1) NOT NULL,
    [drvCustom4] varchar(1) NOT NULL,
    [drvCustom5] varchar(1) NOT NULL,
    [drvCustom6] varchar(1) NOT NULL,
    [drvCustom7] varchar(1) NOT NULL,
    [drvCustom8] varchar(1) NOT NULL,
    [drvCustom9] varchar(1) NOT NULL,
    [drvCustom10ConcurInvoicegrouphierarchy] varchar(1) NOT NULL,
    [drvCustom11] varchar(1) NOT NULL,
    [drvCustom12] varchar(1) NOT NULL,
    [drvCustom13] varchar(1) NOT NULL,
    [drvCustom14] varchar(1) NOT NULL,
    [drvCustom15] varchar(1) NOT NULL,
    [drvCustom16] varchar(1) NOT NULL,
    [drvCustom17APVendorID] varchar(1) NOT NULL,
    [drvCustom18] varchar(1) NOT NULL,
    [drvCustom19] varchar(1) NOT NULL,
    [drvCustom20] varchar(1) NOT NULL,
    [drvCustom21ConcurExpensegrouphierarchy] varchar(11) NOT NULL,
    [drvCashAdvanceStatusChanges] varchar(1) NOT NULL,
    [drvCashAdvanceWaitingAprroval] varchar(1) NOT NULL,
    [drvReportStatusChanges] varchar(1) NOT NULL,
    [drvReportWaitingApproval] varchar(1) NOT NULL,
    [drvSubmittingReport] varchar(1) NOT NULL,
    [drvTravelRequestStatusChanges] varchar(1) NOT NULL,
    [drvTravelRequestWaitingAproval] varchar(1) NOT NULL,
    [drvPromptforapproversubmittingatravelrequest] varchar(1) NOT NULL,
    [drvpaymentstatuschanges] varchar(1) NOT NULL,
    [drvpaymentisawaitingapproval] varchar(1) NOT NULL,
    [drvPromptforapproversubmittingapayment] varchar(1) NOT NULL,
    [drvPrompttoaddcompanycardtransactionstoreport] varchar(1) NOT NULL,
    [drvnewcompanycardtransactionsarrive] varchar(1) NOT NULL,
    [drvfaxedreceiptsreceived] varchar(1) NOT NULL,
    [drvDisplayinstructionalhelponapplicationpages] varchar(1) NOT NULL,
    [drvDisplayimagingintroductionpage] varchar(1) NOT NULL,
    [drvEmployeeIDofexpensereportapprover] char(9) NULL,
    [drvEmployeeIDofcashadvanceapprover] varchar(1) NOT NULL,
    [drvEmployeeIDofauthorizationrequestapprover] varchar(1) NOT NULL,
    [drvEmployeeIDofpaymentapprover] varchar(1) NOT NULL,
    [drvExpenseUserTraveler] varchar(1) NOT NULL,
    [drvApprover] varchar(1) NOT NULL,
    [drvCompanyCardAdmin] varchar(1) NOT NULL,
    [drvIntegrationAdmin] varchar(1) NOT NULL,
    [drvAuthorizationRequestApprover] varchar(1) NOT NULL,
    [drvIntegrationAdministror] varchar(1) NOT NULL,
    [drvReceiptProcessor] varchar(1) NOT NULL,
    [drvDesktopAdmin] varchar(1) NOT NULL,
    [drvOfflineUser] varchar(1) NOT NULL,
    [drvReportingConfigAdmin] varchar(1) NOT NULL,
    [drvPMTUser] varchar(1) NOT NULL,
    [drvPMTApprover] varchar(1) NOT NULL,
    [drvPMTVendorApprover] varchar(1) NOT NULL,
    [drvExpenseAuditRequired] varchar(1) NOT NULL,
    [drvBIManagerEmployeeID] char(9) NULL,
    [drvTravelRequestUser] varchar(1) NOT NULL,
    [drvTravelRequestManager] varchar(1) NOT NULL,
    [drvFutureUse4] varchar(1) NOT NULL,
    [drvPaymentRequestAssigned] varchar(1) NOT NULL,
    [drvInvoiceUser] varchar(1) NOT NULL,
    [drTravelExpenseUser] varchar(1) NOT NULL,
    [drvTaxAdministrator] varchar(1) NOT NULL,
    [drvFBTAdministrator] varchar(1) NOT NULL,
    [drvCliqbookUser] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_ESEACHGC2N_drvTbl_350') IS NULL
CREATE TABLE [dbo].[U_dsi_ESEACHGC2N_drvTbl_350] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvTransType] varchar(3) NOT NULL,
    [drvEmpID] char(9) NULL,
    [drvNamePrefix] varchar(1) NOT NULL,
    [drvNameSuffix] varchar(1) NOT NULL,
    [drvNickName] varchar(1) NOT NULL,
    [drvRedressNum] varchar(1) NOT NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvDateofBirth] varchar(1) NOT NULL,
    [drvManagerCmpyEmpID] char(9) NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkPhoneExt] varchar(1) NOT NULL,
    [drvWorkFax] varchar(1) NOT NULL,
    [drvHomePhone] varchar(1) NOT NULL,
    [drvCellPhone] varchar(1) NOT NULL,
    [drvPagerPhone] varchar(1) NOT NULL,
    [drvTravelNameRemark] varchar(1) NOT NULL,
    [drvTravelClassName] varchar(27) NULL,
    [drvGDSProfileName] varchar(1) NOT NULL,
    [drvOrgUnitDiv] varchar(1) NOT NULL,
    [drvHomeStreetAddr] varchar(1) NOT NULL,
    [drvHomeCity] varchar(1) NOT NULL,
    [drvHomeState] varchar(1) NOT NULL,
    [drvHomePostalCode] varchar(1) NOT NULL,
    [drvHomeCountry] varchar(1) NOT NULL,
    [drvWorkStreetAddr] varchar(1) NOT NULL,
    [drvWorkCity] varchar(1) NOT NULL,
    [drvWorkState] varchar(1) NOT NULL,
    [drvWorkPostalCode] varchar(1) NOT NULL,
    [drvWorkCountry] varchar(1) NOT NULL,
    [drvEmail2] varchar(1) NOT NULL,
    [drvEmail3] varchar(1) NOT NULL,
    [drvCustom1] varchar(28) NULL,
    [drvCustom2] varchar(27) NOT NULL,
    [drvCustom3] varchar(1) NOT NULL,
    [drvCustom4] varchar(1) NOT NULL,
    [drvCustom5] varchar(1) NOT NULL,
    [drvCustom6] varchar(1) NOT NULL,
    [drvCustom7] varchar(1) NOT NULL,
    [drvCustom8] varchar(1) NOT NULL,
    [drvCustom9] varchar(1) NOT NULL,
    [drvCustom10] varchar(1) NOT NULL,
    [drvCustom11] varchar(1) NOT NULL,
    [drvCustom12] varchar(1) NOT NULL,
    [drvCustom13] varchar(1) NOT NULL,
    [drvCustom14] varchar(1) NOT NULL,
    [drvCustom15] varchar(1) NOT NULL,
    [drvCustom16] varchar(1) NOT NULL,
    [drvCustom17] varchar(1) NOT NULL,
    [drvCustom18] varchar(1) NOT NULL,
    [drvCustom19] varchar(1) NOT NULL,
    [drvCustom20] varchar(1) NOT NULL,
    [drvCustom21] varchar(1) NOT NULL,
    [drvCustom22] varchar(1) NOT NULL,
    [drvCustom23] varchar(1) NOT NULL,
    [drvCustom24] varchar(1) NOT NULL,
    [drvCustom25] varchar(1) NOT NULL,
    [drvXMLProfileSynchID] varchar(1) NOT NULL,
    [drvProfileUser] varchar(1) NOT NULL,
    [drvAmadeusUser] varchar(1) NOT NULL,
    [drvFutureUse4] varchar(1) NOT NULL,
    [drvFutureUse5] varchar(1) NOT NULL,
    [drvFutureUse6] varchar(1) NOT NULL,
    [drvFutureUse7] varchar(1) NOT NULL,
    [drvFutureUse8] varchar(1) NOT NULL,
    [drvFutureUse9] varchar(1) NOT NULL,
    [drvFutureUse10] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_ESEACHGC2N_drvTbl_700') IS NULL
CREATE TABLE [dbo].[U_dsi_ESEACHGC2N_drvTbl_700] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvTransType] varchar(3) NOT NULL,
    [drvApprovalType] varchar(3) NOT NULL,
    [drvEmpID] char(9) NULL,
    [drvsegment1] varchar(1) NOT NULL,
    [drvsegment2] varchar(1) NOT NULL,
    [drvsegment3] varchar(1) NOT NULL,
    [drvsegment4] varchar(1) NOT NULL,
    [drvsegment5] varchar(1) NOT NULL,
    [drvsegment6] varchar(1) NOT NULL,
    [drvsegment7] varchar(1) NOT NULL,
    [drvsegment8] varchar(1) NOT NULL,
    [drvsegment9] varchar(1) NOT NULL,
    [drvsegment10] varchar(1) NOT NULL,
    [drvExceptionApproveAuthority] varchar(1) NOT NULL,
    [drvApprovalLimit] varchar(6) NULL,
    [drvApprovalLimitCurrencyCode] varchar(3) NOT NULL
);
IF OBJECT_ID('U_ESEACHGC2N_AudFieldList') IS NULL
CREATE TABLE [dbo].[U_ESEACHGC2N_AudFieldList] (
    [audfield] varchar(200) NOT NULL
);
IF OBJECT_ID('U_ESEACHGC2N_EEList') IS NULL
CREATE TABLE [dbo].[U_ESEACHGC2N_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESEACHGC2N_File') IS NULL
CREATE TABLE [dbo].[U_ESEACHGC2N_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2360) NULL
);
IF OBJECT_ID('U_ESEACHGC2N_Supervisors') IS NULL
CREATE TABLE [dbo].[U_ESEACHGC2N_Supervisors] (
    [EmpEEID] char(12) NOT NULL,
    [EmpCOID] char(5) NOT NULL,
    [EmpEmpNo] char(9) NULL,
    [EmpName] varchar(202) NULL,
    [EmpStatus] char(1) NULL,
    [Supervisor] varchar(1) NOT NULL,
    [Supervisor1EEID] char(12) NULL,
    [Supervisor1EmpNo] char(9) NULL,
    [Supervisor1Status] char(1) NULL,
    [Supervisor1Name] varchar(202) NULL,
    [Supervisor2EEID] char(12) NULL,
    [Supervisor2EmpNo] char(9) NULL,
    [Supervisor2Status] char(1) NULL,
    [Supervisor2Name] varchar(202) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_ESEACHGC2N'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_ESEACHGC2N',getdate(),'P','V1.RKM'
*/


CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESEACHGC2N]
 @systemid varchar(12) = ''
AS
Begin


/*************************************************************************************************
DRIVER TABLE SP FOR:  Employee Feed - 300 FILE 86 fields (Changes only)
BUILT FOR:Seattle Genetics, Inc. 
ORIGINAL BUILD (V-1.0): 6/27/2014 - Rachel Munnerlyn - SF 03745619
RDR

Update By           Date            Request Num            Desc
Tenille Williams    2/6/2020        16657814            Added customfield table to only pull current Job_EQGrade
DAgyei              11/05/2019      SR-2019-00252146    Modification.
Karen Worthington    03/11/2020        00266613            Change SeaGen Cost Center to SeaGen_B2_Cost Center
                                                        Change SeaGen Employee to SeaGen_B3_Employee

Based on Full file hyma built see export ESEA300CON
--SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESEACHGC2N' ORDER BY RunID DESC;

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
        @ExportCode = Exportcode,
        @Exportfile = ExportFile

    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID

        
-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 7    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'Y'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'N'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe


-- clean up EELIST if needed

-- remove test employees 10/7/14

        delete dbo.u_ESEACHGC2N_EELIST
        from dbo.u_ESEACHGC2N_EELIST
        where xeeid in ('A2U4IK0010K0','A2UPKB0010K0','A2UPQU0060K0','A2UPWT0010K0','A2VQJH0010K0','A2VQPC0010K0')


-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_ESEACHGC2N_EELIST
            from dbo.u_ESEACHGC2N_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end



--BDM
-- replace ESEA300COE with the OE session if applicable

--DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','')
----INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedTypes', 'MED,DEN,VIS,FSA')
--IF @ExportCode <> 'ESEA300COE' BEGIN
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)    --@EndDate - @daysstopped)
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
--END
--IF @ExportCode = 'ESEA300COE' BEGIN
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
--END

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

--IF @ExportCode = 'ESEA300COE' BEGIN
--   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')    --'Active')
--END


--EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode




--
---- Step20 Clean up eelist if needed to only include employees with deductions
--            delete dbo.u_ESEACHGC2N_eelist
--            from dbo.u_ESEACHGC2N_eelist a
--            where not exists(select 1 from U_dsi_bdm_EmpDeductions
--                            where a.xeeid = eedeeid
--                            and a.xcoid = eedcoid
--                            and eedformatcode = @formatcode
--                            and eedvalidforexport = 'Y')
--
--
---- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_ESEACHGC2N_EELIST
            from dbo.u_ESEACHGC2N_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T' and EecDateOfTermination < @EndDate +5 ---zrad
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_ESEACHGC2N_eelist
            from dbo.u_ESEACHGC2N_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ESEACHGC2N_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end
--
----Clean up Terms from Deductions and EEList
        --delete U_dsi_bdm_EmpDeductions
        --    from U_dsi_bdm_EmpDeductions left join empcomp on eedeeid = eeceeid and EedCoID = EecCoID
        --where eedFormatCode = @FormatCode
        --    and eedValidForExport = 'Y'
        --    and eecDateofTermination is not null and eecemplstatus <> 'A'
        --    and @daysstopped + eecDateofTermination < @EndDate

        --delete dbo.u_ESEACHGC2N_eelist --DA commented out per client(Tan) request
        --    from dbo.u_ESEACHGC2N_eelist left join empcomp on xeeid = eeceeid and xcoid = eeccoid
        --where eecDateofTermination is not null
        --    and @daysstopped + eecDateofTermination < @EndDate + 5 and eecemplstatus <> 'A'  --zRAD added +5



--Collect emps with changes

--Create Audit table to detect changes for employee fields being reported

DECLARE @FieldList varchar(6000)
    SELECT @FieldList = 'EepNameFirst,EepNameLast,EepNameMiddle,eecempno,EecSupervisorID,eecjobcode,EecOrgLvl2,eecemplstatus,eepaddresscountry,eepaddressemail,eecdateoftermination,eeccoid' --Da added eeccoid 11/5/19, added EecSupervisorID
        

    if object_id('U_ESEACHGC2N_AudFieldList') is not null
      drop table dbo.U_ESEACHGC2N_AudFieldList

    SELECT audfield = item    
    INTO dbo.U_ESEACHGC2N_AudFieldList
    from dbo.fn_listtotable(@fieldlist)

--SELECT * from dbo.U_ESEACHGC2N_AudFieldList


if object_id('u_ds_ESEACHGC2N_auditChanges') is not null
  drop table dbo.u_ds_ESEACHGC2N_auditChanges

 SELECT audkey1value as eeid,
    case when audtablename = 'Emppers' then eephomecoid
        else audkey2value end as coid,
    max (auddatetime) as auditdate,audfieldname
    ,
    max(case when audnewvalue is not null and audoldvalue is null then 'Y' else 'N' end) newuser 
    --max(case when audfieldname in('eecemplstatus') and audnewvalue = 'A' and audoldvalue is null then 'Y' else 'N' end) newuser --new user, new hire in Ultipro
    

   INTO dbo.u_ds_ESEACHGC2N_auditChanges
   FROM vw_AuditeeData
   inner join u_ESEACHGC2N_audfieldlist on audfield = audfieldname
   join emppers on eepeeid = audkey1value
    
  WHERE   (convert(char(10),AudDateTime,112) >= left(@startpercontrol,8) and convert(char(10),AudDateTime,112)<=left(@endpercontrol,8)) --zradmay need ot increase
and audtablename in ('EMPPERS','EMPCOMP') 

    group by audkey1value,    case when audtablename = 'Emppers' then eephomecoid
        else audkey2value end ,audfieldname

    CREATE CLUSTERED INDEX idx_ESEACHGC2N_auditChanges
    ON dbo.u_ds_ESEACHGC2N_auditChanges (eeid)


     

--select eepnamefirst,eepnamelast,* from dbo.u_ds_ESEACHGC2N_auditChanges 
--join emppers on eeid = eepeeid
-- order by newuser


--Remove emps with no changes
            delete dbo.u_ESEACHGC2N_eelist
            from dbo.u_ESEACHGC2N_eelist a
            where not exists(select 1 from dbo.u_ds_ESEACHGC2N_auditChanges
                            where a.xeeid = eeid
                            and a.xcoid = coid)

   

   ---------------------------------
-- WORKING TABLE - Supervisors with direct report -- DA 11/05/2019 
---------------------------------
IF OBJECT_ID('U_ESEACHGC2N_Supervisors','U') IS NOT NULL
    DROP TABLE dbo.U_ESEACHGC2N_Supervisors;

WITH CTE_Supervisor (EEID, COID, EmpNo, SupervisorID, EmplStatus, JobCode, Name, Supervisor)
AS ( -- Get All Active Employees with Level 1 and 2 Supervisor Information
    SELECT EecEEID, EecCOID, EecEmpNo, EecSupervisorID, EecEmplStatus, EecJobCode
        ,Name = RTRIM(EepNameLast) + ', '  + RTRIM(COALESCE(NULLIF(EepNamePreferred,''),EepNameFirst))
        ,Supervisor = CASE WHEN EecEEID IN (SELECT EecSupervisorID FROM dbo.EmpComp WITH (NOLOCK) /*WHERE EecEmplStatus <> 'T'8*/) THEN 'Y' ELSE 'N' END
    FROM dbo.EmpComp WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = EecEEID
        AND EecCOID = dbo.dsi_BDM_fn_GetCurrentCoID(EecEEID)
    --WHERE EecEmplStatus <> 'T'
)
    SELECT
        EmpEEID = E.EEID
    ,EmpCOID = E.COID
    ,EmpEmpNo = E.EmpNo
    ,EmpName = E.Name
    ,EmpStatus = E.EmplStatus
    ,Supervisor = E.Supervisor
    ,Supervisor1EEID = S1.EEID
    ,Supervisor1EmpNo = S1.EmpNo
    ,Supervisor1Status = S1.EmplStatus
    ,Supervisor1Name = S1.Name
    ,Supervisor2EEID = S2.EEID
    ,Supervisor2EmpNo = S2.EmpNo
    ,Supervisor2Status = S2.EmplStatus
    ,Supervisor2Name = S2.Name
INTO dbo.U_ESEACHGC2N_Supervisors
FROM dbo.U_ESEACHGC2N_EEList
JOIN CTE_Supervisor E
    ON E.EEID = xEEID
    AND E.COID = xCOID
LEFT JOIN CTE_Supervisor S1
    ON S1.EEID = E.SupervisorID
    AND S1.COID = dbo.dsi_BDM_fn_GetCurrentCoID(S1.EEID)
LEFT JOIN CTE_Supervisor S2
    ON S2.EEID = S1.SupervisorID
    AND S2.COID = dbo.dsi_BDM_fn_GetCurrentCoID(S2.EEID);



-- Populate Source for Employees 3000 --DA 11/05/2019 updated for new users

if object_id('U_dsi_ESEACHGC2N_drvTbl') is not null
  drop table dbo.U_dsi_ESEACHGC2N_drvTbl

-- EE Detail

  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-- standard fields above and additional driver fields below
        drvTransType = '300',
        drvFirstName = dbo.dsi_fnRemoveChars('.,/',eepnamefirst),--case when isnull(eeid,'') = '' then '' else dbo.dsi_fnRemoveChars('.,/',eepnamefirst) end,
        drvMiddleName = dbo.dsi_fnRemoveChars('.,/',eepnamemiddle),-- substring(eepnamemiddle,1,1),--case when isnull(eeid,'') = '' then '' else substring(eepnamemiddle,1,1) end,
        drvLastName = dbo.dsi_fnRemoveChars('.,/',eepnamelast),-- case when isnull(eeid,'') = '' then '' else dbo.dsi_fnRemoveChars('.,/',eepnamelast) end,
        drvEmpID = e.eecempno,
        drvLoginID = eepaddressemail,--?---dbo.dsi_fnRemoveChars('.,/', usethis),
        drvPassword = '',--case when isnull(eeid,'') = '' then '' else 'Welcome1' end,
        drvEmailAddress = eepaddressemail,
        drvLocaleCode = 'en_US',
        drvCtryCode = dbo.dsi_fnlib_CountryCode(EepAddressCountry), --DA
                      --case when e.eeccoid = 'T2ZAN' then 'CH' -- Switzerland-- DA added new translation 11/5/19 
             --              when e.eeccoid = 'T2Z78' then 'CAN' --Canada
                      --else 'US' end,
                     --'US', --substring(eepaddresscountry,1,2),
        drvCtrySubCode = '',
        drvLedgerCode = 'Great Plains',--?
        drvReimbursementCRNCode = case when einEEID is not null then einCurrencyCode else 'USD'end, --DA
                                  --case when e.eeccoid = 'T2ZAN' then 'CHF' -- Switzerland-- DA added new translation 11/5/19 
                                     --  when e.eeccoid = 'T2Z78' then 'CAD' --Canada
                                  --else 'USD'end,
                                --'USD',--substring(eepaddresscountry,1,2)+'D',
        drvCashAdvanceAccountCode = '',
        drvActive = case when e.eecemplstatus ='T' then 'N' else 'Y' end,--'Y' --DA 11/5/19 updated
        drvOrgUnit1 = e.EecOrgLvl2,
        drvOrgUnit2 = Job_EqGrade, --StringValue, --value from custom field EQ Grade TW 2/6/2020 replaced with Job_EqGrade
        drvOrgUnit3 = '',
        drvOrgUnit4 = CASE 
                         WHEN xcoid in ('IAGFG') THEN  '100'
                          WHEN xcoid in ('T2Z78') THEN  '110'
                          WHEN xcoid in ('T2ZAN') THEN  '201'
                          WHEN xcoid in ('FBBH5') THEN  '301'
                          WHEN xcoid in ('Y0RLX') THEN  '401'
                          WHEN xcoid in ('Y0Z1W') THEN  '411'
                          WHEN xcoid in ('Y0WM3') THEN  '421'
                          WHEN xcoid in ('Y0XQQ') THEN  '431'
                          WHEN xcoid in ('Y0ZZU') THEN  '441'
                          WHEN xcoid in ('8H18R') THEN  '451'
                      END,
        drvOrgUnit5 = '',
        drvOrgUnit6 = '',
        drvCustom1 ='',
        drvCustom2 = '',
        drvCustom3 = '',
        drvCustom4 = '',
        drvCustom5 = '',
        drvCustom6 = '',
        drvCustom7 = '',
        drvCustom8 = '',
        drvCustom9 = '',
        drvCustom10ConcurInvoicegrouphierarchy = '',
        drvCustom11 = '',
        drvCustom12 = '',
        drvCustom13 = '',
        drvCustom14 = '',
        drvCustom15 = '',
        drvCustom16 = '',
        drvCustom17APVendorID = '',
        drvCustom18 = '',
        drvCustom19 = '',
        drvCustom20 = '',
        drvCustom21ConcurExpensegrouphierarchy = CASE     WHEN EepAddressCountry = 'AUT' THEN 'SGAUT'
                                                         WHEN EepAddressCountry = 'BEL' THEN 'SGBEL'
                                                         WHEN EepAddressCountry = 'DNK' THEN 'SGDNK'
                                                         WHEN EepAddressCountry = 'FIN' THEN 'SGFIN'
                                                         WHEN EepAddressCountry = 'FRA' THEN 'SGFRA'
                                                         WHEN EepAddressCountry = 'DEU' THEN 'SGDEU'
                                                         WHEN EepAddressCountry = 'ITA' THEN 'SGITA'
                                                         WHEN EepAddressCountry = 'NLD' THEN 'SGNLD'
                                                         WHEN EepAddressCountry = 'NOR' THEN 'SGNOR'
                                                         WHEN EepAddressCountry = 'PRT' THEN 'SGPRT'
                                                         WHEN EepAddressCountry = 'ESP' THEN 'SGESP'
                                                         WHEN EepAddressCountry = 'SWE' THEN 'SGSWE'
                                                         WHEN EepAddressCountry = 'CHE' THEN 'SGCHE'
                                                         WHEN EepAddressCountry = 'GBR' THEN 'SGGBR'
                                                         WHEN EepAddressCountry = 'CAN' THEN 'SGICPCA'
                                                         WHEN EepAddressCountry = 'USA' THEN 'SGICP'
                                                    ELSE  'Seagen Intl'
                                                    END
        
        /*case when e.eeccoid = 'IAGFG' then 'SGICP' --DA
                                                  when e.eeccoid = 'T2Z78' then 'SGICPCA' 
                                                  
                                                  else 'Seagen Intl' end*/


                                                  ,
        --'SGICP',--case when eepaddresscountry ='USA' then 'US' when eepaddresscountry ='CAN' then 'CANADA' else '' end,--?
        drvCashAdvanceStatusChanges = '',
        drvCashAdvanceWaitingAprroval = '',
        drvReportStatusChanges = '',
        drvReportWaitingApproval = '',
        drvSubmittingReport = '',
        drvTravelRequestStatusChanges = '',
        drvTravelRequestWaitingAproval = '',
        drvPromptforapproversubmittingatravelrequest = '',
        drvpaymentstatuschanges = '',
        drvpaymentisawaitingapproval = '',
        drvPromptforapproversubmittingapayment = '',
        drvPrompttoaddcompanycardtransactionstoreport = '',
        drvnewcompanycardtransactionsarrive = '',
        drvfaxedreceiptsreceived = '',
        drvDisplayinstructionalhelponapplicationpages = '',
        drvDisplayimagingintroductionpage = '',
        drvEmployeeIDofexpensereportapprover = s.EecEmpNo,
        drvEmployeeIDofcashadvanceapprover = '',
        drvEmployeeIDofauthorizationrequestapprover = '',
        drvEmployeeIDofpaymentapprover = '',
        drvExpenseUserTraveler ='',
        drvApprover = 'Y',-- DA deefault back to Y --case when supervisor = 'Y' then 'Y' else 'N' end,--DA
        drvCompanyCardAdmin = '',
        drvIntegrationAdmin = '',
        drvAuthorizationRequestApprover = '',
        drvIntegrationAdministror = '',
        drvReceiptProcessor = '',
        drvDesktopAdmin = '',
        drvOfflineUser = '',
        drvReportingConfigAdmin = '',
        drvPMTUser = '',
        drvPMTApprover = '',
        drvPMTVendorApprover = '',
        drvExpenseAuditRequired = '',
        drvBIManagerEmployeeID = s.EecEmpNo,
        drvTravelRequestUser = '',
        drvTravelRequestManager = '',
        drvFutureUse4 = '',
        drvPaymentRequestAssigned = '',
        drvInvoiceUser = '',
        drTravelExpenseUser = 'Y',---requreied field UDF?
        drvTaxAdministrator = '',
        drvFBTAdministrator = '',
        drvCliqbookUser = 'Y'---requreied field UDF?

    

  into dbo.U_dsi_ESEACHGC2N_drvTbl
  from dbo.u_ESEACHGC2N_eelist with (nolock)
    JOIN EmpPers  on eepeeid = xeeid
    JOIN EmpComp e WITH (NOLOCK) ON EecEEID = xEEID AND EecCOID = xCOID
    join (select eeid, coid, audfieldname, newuser from dbo.u_ds_ESEACHGC2N_auditChanges where newuser = 'Y' and audfieldname = 'EecEmplStatus') newU on xeeid = newU.eeid and xcoid = newU.coid --DA 11/05/2019
    --left join (select eeid, coid from dbo.u_ds_ESEACHGC2N_auditChanges where newuser = 'Y') newU on xeeid = eeid and xcoid = coid --DA 11/05/2019
   left JOIN EmpComp s WITH (NOLOCK) ON e.Eecsupervisorid = s.eecEEID --and s.EecEmplStatus = 'A' --AND e.EecCOID = s.eecCOID -zRAD removed status = a
--left join MetaObject on StandardPrimaryKeyString1 = e.eecjobcode TW 2/6/2020 commented out
--left join MetaFieldValue on objectid = id and FieldUniqueId= '_BEqGrade' TW 2/6/2020 commented out
left join [dbo].[fn_MP_CustomFields_JobCode_Export](NULL,NULL,NULL,NULL) ON jbcjobcode = e.eecjobcode --TW 2/6/2020 added customfield table to only pull current Job_EQGrade
LEFT JOIN EmpIntl ON einEEID = xEEID --DA added
left join dbo.U_ESEACHGC2N_Supervisors on empeeid = xeeid and empcoid = xcoid--DA added
--left join jobcode on e.eecjobcode = jbcjobcode TW 2/6/2020 commented out
--left JOIN emppers spv with (nolock) on s.eeceeid = spv.eepeeid




    --Populate employees Source 350 Travel
    if object_id('U_dsi_ESEACHGC2N_drvTbl_350') is not null
      drop table dbo.U_dsi_ESEACHGC2N_drvTbl_350

    -- EE Detail

      select distinct
        drvEEID = xEEID, 
        drvcoid = xcoid,
        drvdepid = cast(null as varchar),
        drvrectype = 'E',
    -- standard fields above and additional driver fields below
    drvTransType = '350',
    drvEmpID = e.eecempno,
    drvNamePrefix = '',--dbo.dsi_fnRemoveChars('.,/',eepnameprefix),
    drvNameSuffix = '',--dbo.dsi_fnRemoveChars('.,/',eepnamesuffix),
    drvNickName = '',
    drvRedressNum = '',
    drvGender = '',--eepgender,
    drvDateofBirth = '',--eepdateofbirth,
    drvManagerCmpyEmpID = s.EecEmpNo,
    drvJobTitle = '',--jbcdesc,
    drvWorkPhone = '',
    drvWorkPhoneExt = '',
    drvWorkFax = '',
    drvHomePhone = '',--eephomephonenumber,
    drvCellPhone = '',
    drvPagerPhone = '',
    drvTravelNameRemark = '',
    drvTravelClassName = case --DA added
                                when e.eeccoid = 'T2Z78' then 'Canada Default Travel Class' --Canada
                                when e.eeccoid = 'IAGFG' then case when Job_EqGrade >= 15 then 'VP Travel Class' else 'Default Travel Class' end 
                                when e.eeccoid not in ('IAGFG','T2Z78') then case when Job_EqGrade >= 15 then 'CH VIP Travel Class' else 'CH Default Travel Class' end 
                         end,
                         --'Default Travel Class',
    drvGDSProfileName = '',
    drvOrgUnitDiv = '',
    drvHomeStreetAddr = '',
    drvHomeCity = '',
    drvHomeState = '',
    drvHomePostalCode = '',
    drvHomeCountry = '',
    drvWorkStreetAddr = '',
    drvWorkCity = '',
    drvWorkState = '',
    drvWorkPostalCode = '',
    drvWorkCountry = '',
    drvEmail2 = '',
    drvEmail3 = '',
    --drvCustom1 = 'SeaGen Cost Center='+e.EecOrgLvl2,
    --drvCustom2 = 'SeaGen Employee=Employee',
    drvCustom1 = 'SeaGen_B2_Cost Center='+e.EecOrgLvl2,        --klw 03/11/2020 SF00266613
    drvCustom2 = 'SeaGen_B3_Employee=Employee',                --klw 03/11/2020 SF00266613
    drvCustom3 = '',
    drvCustom4 = '',
    drvCustom5 = '',
    drvCustom6 = '',
    drvCustom7 = '',
    drvCustom8 = '',
    drvCustom9 = '',
    drvCustom10 = '',
    drvCustom11 = '',
    drvCustom12 = '',
    drvCustom13 = '',
    drvCustom14 = '',
    drvCustom15 = '',
    drvCustom16 = '',
    drvCustom17 = '',
    drvCustom18 = '',
    drvCustom19 = '',
    drvCustom20 = '',
    drvCustom21 = '',
    drvCustom22 = '',
    drvCustom23 = '',
    drvCustom24 = '',
    drvCustom25 = '',
    drvXMLProfileSynchID = '',
    drvProfileUser = '',
    drvAmadeusUser = '',
    drvFutureUse4 = '',
    drvFutureUse5 = '',
    drvFutureUse6 = '',
    drvFutureUse7 = '',
    drvFutureUse8 = '',
    drvFutureUse9 = '',
    drvFutureUse10 = ''


 into dbo.U_dsi_ESEACHGC2N_drvTbl_350
  from dbo.u_ESEACHGC2N_eelist with (nolock)
    JOIN EmpPers  on eepeeid = xeeid
    JOIN EmpComp e WITH (NOLOCK) ON EecEEID = xEEID AND EecCOID = xCOID
    left JOIN EmpComp s WITH (NOLOCK) ON e.Eecsupervisorid = s.eecEEID  --and s.EecEmplStatus = 'A' --AND e.EecCOID = s.eecCOID  --zRAD removed status = a
 join (select eeid, coid, audfieldname, newuser from dbo.u_ds_ESEACHGC2N_auditChanges where newuser = 'Y' and audfieldname = 'EecEmplStatus') newU on xeeid = newU.eeid and xcoid = newU.coid --DA 11/05/2019
 left join [dbo].[fn_MP_CustomFields_JobCode_Export](NULL,NULL,NULL,NULL) ON jbcjobcode = e.eecjobcode --TW 2/6/2020 added customfield table to only pull current Job_EQGrade
--where newU.audfieldname = 'EecEmplStatus' and newU.newuser = 'Y'

--left join (select eeid, coid from dbo.u_ds_ESEACHGC2N_auditChanges where newuser = 'Y') newU on xeeid = eeid and xcoid = coid
--left JOIN EmpComp s WITH (NOLOCK) ON e.Eecsupervisorid = s.eecEEID AND e.EecCOID = s.eecCOID
--join jobcode on eecjobcode = jbcjobcode
--left JOIN emppers spv with (nolock) on s.eeceeid = spv.eepeeid

 
    if object_id('U_dsi_ESEACHGC2N_drvTbl_700') is not null --DA 11/5/2019 created 700 rec for new records
      drop table dbo.U_dsi_ESEACHGC2N_drvTbl_700
    -- EE Detail
    select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-- standard fields above and additional driver fields below
    drvTransType = '700',
    drvApprovalType = 'EXP',
    drvEmpID = e.eecempno,
    drvsegment1 = '',
    drvsegment2 = '',
    drvsegment3 = '',
    drvsegment4 = '',
    drvsegment5 = '',
    drvsegment6 = '',
    drvsegment7 = '',
    drvsegment8 = '',
    drvsegment9 = '',
    drvsegment10 = '',
    drvExceptionApproveAuthority = '',
    drvApprovalLimit = case when Job_EqGrade <= 10 then '2500' --value from custom field EQ Grade
                                        when Job_EqGrade = 11 and j.jbcdesc like '%Division Manager%' then '5000'
                                        when Job_EqGrade between 11 and 13 then '10000'
                                        when Job_EqGrade in (14,15) then '15000'
                                        when Job_EqGrade in (16,17) then '25000'
                                        when Job_EqGrade > 17 then '100000' end,

    drvApprovalLimitCurrencyCode = 'USD'
into dbo.U_dsi_ESEACHGC2N_drvTbl_700
from dbo.u_ESEACHGC2N_eelist with (nolock)
    JOIN EmpPers  on eepeeid = xeeid
    JOIN EmpComp e WITH (NOLOCK) ON EecEEID = xEEID AND EecCOID = xCOID
    --JOIN dbo.U_ESEACHGC2N_Supervisors on empeeid = xeeid and empcoid = xcoid and Supervisor = 'Y' --DA Always send 700 record for all new employees
    JOIN dbo.u_ds_ESEACHGC2N_auditChanges newU WITH (NOLOCK) ON xeeid = newU.eeid and xcoid = newU.coid
    left join [dbo].[fn_MP_CustomFields_JobCode_Export](NULL,NULL,NULL,NULL) ON jbcjobcode = e.eecjobcode 
    LEFT JOIN dbo.JobCode j WITH (NOLOCK) ON j.jbcjobcode = e.eecjobcode --DA added
    where newU.audfieldname = 'EecEmplStatus' and newU.newuser = 'Y'
    
    
    
    -- Populate Source for Employees 300  --Update(old users) --DA 11/5/2019
    INSERT INTO dbo.U_dsi_ESEACHGC2N_drvTbl
-- EE Detail
   select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-- standard fields above and additional driver fields below
    drvTransType = '300',
    drvFirstName = case when e.eecemplstatus <> 'T' and newFN.audfieldname = 'EepNameFirst' then dbo.dsi_fnRemoveChars('.,/',eepnamefirst) end,
    drvMiddleName = case when e.eecemplstatus <> 'T' and  newMI.audfieldname = 'EepNameMiddle' then dbo.dsi_fnRemoveChars('.,/',eepnamemiddle)end,--substring(eepnamemiddle,1,1
    drvLastName = case when e.eecemplstatus <> 'T' and  newLN.audfieldname = 'EepNameLast' then dbo.dsi_fnRemoveChars('.,/',eepnamelast) end,
    drvEmpID = e.eecempno ,
    drvLoginID = eepaddressemail,
    drvPassword = '',--case when isnull(eeid,'') = '' then '' else 'Welcome1' end,
    drvEmailAddress = case when e.eecemplstatus <> 'T' and newEM.audfieldname = 'eepaddressemail' then eepaddressemail end,
    drvLocaleCode = 'en_US',
    drvCtryCode = case when e.eecemplstatus <> 'T' and newCountry.audfieldname = 'eepaddresscountry' then dbo.dsi_fnlib_CountryCode(EepAddressCountry) end,
                    --case when e.eecemplstatus <> 'T' and newCMP.audfieldname = 'eeccoid' then case
                    --  when e.eeccoid = 'T2ZAN' then 'CH' -- Switzerland-- DA added new translation 11/5/19 
           --           when e.eeccoid = 'T2Z78' then 'CAN' --Canada
                    --  else 'US'end else '' end,
                     --'US', --substring(eepaddresscountry,1,2),
    drvCtrySubCode = '',
    drvLedgerCode = 'Great Plains',--?
    drvReimbursementCRNCode = case when e.eecemplstatus <> 'T' then case when einEEID is not null then einCurrencyCode else 'USD'end end,
                                --case when e.eecemplstatus <> 'T' and newCMP.audfieldname = 'eeccoid' then case
                                --when e.eeccoid = 'T2ZAN' then 'CHF' -- Switzerland-- DA added new translation 11/5/19 
                                --when e.eeccoid = 'T2Z78' then 'CAD' --Canada
                                --else 'USD'end else '' end,
                            --'USD',--substring(eepaddresscountry,1,2)+'D',
    drvCashAdvanceAccountCode = '',
    drvActive = case when e.eecemplstatus ='A' then 'Y' else 'N' end,--'Y' --DA 11/5/19 updated
    drvOrgUnit1 = case when e.eecemplstatus <> 'T' and newORG2.audfieldname = 'EecOrgLvl2' then e.EecOrgLvl2 end,
    drvOrgUnit2 = case when e.eecemplstatus <> 'T' and newJcode.audfieldname = 'EecJobCode' then Job_EqGrade end, 
    drvOrgUnit3 = '',
    drvOrgUnit4 = CASE 
                         WHEN xcoid in ('IAGFG') THEN  '100'
                          WHEN xcoid in ('T2Z78') THEN  '110'
                          WHEN xcoid in ('T2ZAN') THEN  '201'
                          WHEN xcoid in ('FBBH5') THEN  '301'
                          WHEN xcoid in ('Y0RLX') THEN  '401'
                          WHEN xcoid in ('Y0Z1W') THEN  '411'
                          WHEN xcoid in ('Y0WM3') THEN  '421'
                          WHEN xcoid in ('Y0XQQ') THEN  '431'
                          WHEN xcoid in ('Y0ZZU') THEN  '441'
                          WHEN xcoid in ('8H18R') THEN  '451'
                      END,
    drvOrgUnit5 = '',
    drvOrgUnit6 = '',
    drvCustom1 ='',
    drvCustom2 = '',
    drvCustom3 = '',
    drvCustom4 = '',
    drvCustom5 = '',
    drvCustom6 = '',
    drvCustom7 = '',
    drvCustom8 = '',
    drvCustom9 = '',
    drvCustom10ConcurInvoicegrouphierarchy = '',
    drvCustom11 = '',
    drvCustom12 = '',
    drvCustom13 = '',
    drvCustom14 = '',
    drvCustom15 = '',
    drvCustom16 = '',
    drvCustom17APVendorID = '',
    drvCustom18 = '',
    drvCustom19 = '',
    drvCustom20 = '',
    drvCustom21ConcurExpensegrouphierarchy = /* case when e.eeccoid = 'IAGFG' then 'SGICP'
                                                  when e.eeccoid = 'T2Z78' then 'SGICPCA' else 'Seagen Intl' end,
                                                */
                                                CASE     WHEN EepAddressCountry = 'AUT' THEN 'SGAUT'
                                                         WHEN EepAddressCountry = 'BEL' THEN 'SGBEL'
                                                         WHEN EepAddressCountry = 'DNK' THEN 'SGDNK'
                                                         WHEN EepAddressCountry = 'FIN' THEN 'SGFIN'
                                                         WHEN EepAddressCountry = 'FRA' THEN 'SGFRA'
                                                         WHEN EepAddressCountry = 'DEU' THEN 'SGDEU'
                                                         WHEN EepAddressCountry = 'ITA' THEN 'SGITA'
                                                         WHEN EepAddressCountry = 'NLD' THEN 'SGNLD'
                                                         WHEN EepAddressCountry = 'NOR' THEN 'SGNOR'
                                                         WHEN EepAddressCountry = 'PRT' THEN 'SGPRT'
                                                         WHEN EepAddressCountry = 'ESP' THEN 'SGESP'
                                                         WHEN EepAddressCountry = 'SWE' THEN 'SGSWE'
                                                         WHEN EepAddressCountry = 'CHE' THEN 'SGCHE'
                                                         WHEN EepAddressCountry = 'GBR' THEN 'SGGBR'
                                                         WHEN EepAddressCountry = 'CAN' THEN 'SGICPCA'
                                                         WHEN EepAddressCountry = 'USA' THEN 'SGICP'
                                                          ELSE  'Seagen Intl'
                                                    END,
                                            --'SGICP',--case when eepaddresscountry ='USA' then 'US' when eepaddresscountry ='CAN' then 'CANADA' else '' end,--?
    drvCashAdvanceStatusChanges = '',
    drvCashAdvanceWaitingAprroval = '',
    drvReportStatusChanges = '',
    drvReportWaitingApproval = '',
    drvSubmittingReport = '',
    drvTravelRequestStatusChanges = '',
    drvTravelRequestWaitingAproval = '',
    drvPromptforapproversubmittingatravelrequest = '',
    drvpaymentstatuschanges = '',
    drvpaymentisawaitingapproval = '',
    drvPromptforapproversubmittingapayment = '',
    drvPrompttoaddcompanycardtransactionstoreport = '',
    drvnewcompanycardtransactionsarrive = '',
    drvfaxedreceiptsreceived = '',
    drvDisplayinstructionalhelponapplicationpages = '',
    drvDisplayimagingintroductionpage = '',
    drvEmployeeIDofexpensereportapprover =  case when newSUP.audfieldname = 'EecSupervisorID' then s.EecEmpNo end,
    drvEmployeeIDofcashadvanceapprover = '',
    drvEmployeeIDofauthorizationrequestapprover = '',
    drvEmployeeIDofpaymentapprover = '',
    drvExpenseUserTraveler ='',
    drvApprover ='Y',-- DA deefault back to Y -- case when supervisor = 'Y' then 'Y' else 'N' end,--DA
    drvCompanyCardAdmin = '',
    drvIntegrationAdmin = '',
    drvAuthorizationRequestApprover = '',
    drvIntegrationAdministror = '',
    drvReceiptProcessor = '',
    drvDesktopAdmin = '',
    drvOfflineUser = '',
    drvReportingConfigAdmin = '',
    drvPMTUser = '',
    drvPMTApprover = '',
    drvPMTVendorApprover = '',
    drvExpenseAuditRequired = '',
    drvBIManagerEmployeeID = case when newSUP.audfieldname = 'EecSupervisorID' then s.EecEmpNo end,
    drvTravelRequestUser = '',
    drvTravelRequestManager = '',
    drvFutureUse4 = '',
    drvPaymentRequestAssigned = '',
    drvInvoiceUser = '',
    drTravelExpenseUser = 'Y',---requreied field UDF?
    drvTaxAdministrator = '',
    drvFBTAdministrator = '',
    drvCliqbookUser = 'Y'---requreied field UDF?
  from dbo.u_ESEACHGC2N_eelist with (nolock)
    JOIN EmpPers  on eepeeid = xeeid
    JOIN EmpComp e WITH (NOLOCK) ON EecEEID = xEEID AND EecCOID = xCOID
    JOIN dbo.u_ds_ESEACHGC2N_auditChanges newU WITH (NOLOCK) ON xeeid = newU.eeid and xcoid = newU.coid
left JOIN EmpComp s WITH (NOLOCK) ON e.Eecsupervisorid = s.eecEEID
left join [dbo].[fn_MP_CustomFields_JobCode_Export](NULL,NULL,NULL,NULL) ON jbcjobcode = e.eecjobcode 
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'EepNameFirst') newFN on xeeid = newFN.eeid and xcoid = newFN.coid
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'EepNameMiddle') newMI on xeeid = newMI.eeid and xcoid = newMI.coid
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'EepNameLast') newLN on xeeid = newLN.eeid and xcoid = newLN.coid
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'eepaddressemail') newEM on xeeid = newEM.eeid and xcoid = newEM.coid
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'eepaddresscountry') newCountry on xeeid = newCountry.eeid and xcoid = newCountry.coid
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'eeccoid') newCMP on xeeid = newCMP.eeid and xcoid = newCMP.coid
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'eecorglvl2') newORG2 on xeeid = newORG2.eeid and xcoid = newORG2.coid
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'EecSupervisorID') newSUP on xeeid = newSUP.eeid and xcoid = newSUP.coid
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'eecjobcode') newJcode on xeeid = newJcode.eeid and xcoid = newJcode.coid
LEFT JOIN EmpIntl ON einEEID = xEEID
JOIN dbo.U_ESEACHGC2N_Supervisors on empeeid = xeeid and empcoid = xcoid
where (newU.audfieldname = 'EecEmplStatus' and newU.newuser = 'N')
or (newU.audfieldname <> 'EecEmplStatus' and newU.newuser = 'N')




--Populate employees Source 350 Travel -- Update Older user
        INSERT INTO dbo.U_dsi_ESEACHGC2N_drvTbl_350

    -- EE Detail

        select distinct
        drvEEID = xEEID, 
        drvcoid = xcoid,
        drvdepid = cast(null as varchar),
        drvrectype = 'E',
    -- standard fields above and additional driver fields below
    drvTransType = '350',
    drvEmpID = e.eecempno,
    drvNamePrefix = '',--dbo.dsi_fnRemoveChars('.,/',eepnameprefix),
    drvNameSuffix = '',--dbo.dsi_fnRemoveChars('.,/',eepnamesuffix),
    drvNickName = '',
    drvRedressNum = '',
    drvGender = '',--eepgender,
    drvDateofBirth = '',--eepdateofbirth,
    drvManagerCmpyEmpID =  case when newSUP.audfieldname = 'EecSupervisorID' then s.EecEmpNo end,
    drvJobTitle = '',--jbcdesc,
    drvWorkPhone = '',
    drvWorkPhoneExt = '',
    drvWorkFax = '',
    drvHomePhone = '',--eephomephonenumber,
    drvCellPhone = '',
    drvPagerPhone = '',
    drvTravelNameRemark = '',
    drvTravelClassName = case when newCMP.audfieldname = 'Eeccoid' then case 
                                when e.eeccoid = 'T2Z78' then 'Canada Default Travel Class' --Canada
                                when e.eeccoid = 'IAGFG' then case when Job_EqGrade >= 15 then 'VP Travel Class' else 'Default Travel Class' end 
                                when e.eeccoid not in ('IAGFG','T2Z78') then case when Job_EqGrade >= 15 then 'CH VIP Travel Class' else 'CH Default Travel Class' end 
                         end end,
                        --'Default Travel Class',
    drvGDSProfileName = '',
    drvOrgUnitDiv = '',
    drvHomeStreetAddr = '',
    drvHomeCity = '',
    drvHomeState = '',
    drvHomePostalCode = '',
    drvHomeCountry = '',
    drvWorkStreetAddr = '',
    drvWorkCity = '',
    drvWorkState = '',
    drvWorkPostalCode = '',
    drvWorkCountry = '',
    drvEmail2 = '',
    drvEmail3 = '',
    drvCustom1 = case when newORG2.audfieldname = 'EecOrgLvl2' then 'SeaGen_B2_Cost Center='+e.EecOrgLvl2 end,
    drvCustom2 = 'SeaGen_B3_Employee=Employee',
    drvCustom3 = '',
    drvCustom4 = '',
    drvCustom5 = '',
    drvCustom6 = '',
    drvCustom7 = '',
    drvCustom8 = '',
    drvCustom9 = '',
    drvCustom10 = '',
    drvCustom11 = '',
    drvCustom12 = '',
    drvCustom13 = '',
    drvCustom14 = '',
    drvCustom15 = '',
    drvCustom16 = '',
    drvCustom17 = '',
    drvCustom18 = '',
    drvCustom19 = '',
    drvCustom20 = '',
    drvCustom21 = '',
    drvCustom22 = '',
    drvCustom23 = '',
    drvCustom24 = '',
    drvCustom25 = '',
    drvXMLProfileSynchID = '',
    drvProfileUser = '',
    drvAmadeusUser = '',
    drvFutureUse4 = '',
    drvFutureUse5 = '',
    drvFutureUse6 = '',
    drvFutureUse7 = '',
    drvFutureUse8 = '',
    drvFutureUse9 = '',
    drvFutureUse10 = ''
from dbo.u_ESEACHGC2N_eelist with (nolock)
JOIN EmpPers  on eepeeid = xeeid
JOIN EmpComp e WITH (NOLOCK) ON EecEEID = xEEID AND EecCOID = xCOID
JOIN dbo.u_ds_ESEACHGC2N_auditChanges newU WITH (NOLOCK) ON xeeid = newU.eeid and xcoid = newU.coid
left JOIN EmpComp s WITH (NOLOCK) ON e.Eecsupervisorid = s.eecEEID --and s.EecEmplStatus = 'A' --AND e.EecCOID = s.eecCOID  --zRAD removed status = a
left join [dbo].[fn_MP_CustomFields_JobCode_Export](NULL,NULL,NULL,NULL) ON jbcjobcode = e.eecjobcode
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'eecorglvl2') newORG2 on xeeid = newORG2.eeid and xcoid = newORG2.coid
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'eeccoid') newCMP on xeeid = newCMP.eeid and xcoid = newCMP.coid
left join (select eeid, coid, audfieldname from dbo.u_ds_ESEACHGC2N_auditChanges where audfieldname = 'EecSupervisorID') newSUP on xeeid = newSUP.eeid and xcoid = newSUP.coid
where newU.audfieldname = 'EecEmplStatus' and newU.newuser = 'N'
or newU.audfieldname <> 'EecEmplStatus' and newU.newuser = 'N'



--left join (select eeid, coid from dbo.u_ds_ESEACHGC2N_auditChanges where newuser = 'Y') newU on xeeid = eeid and xcoid = coid
--left JOIN EmpComp s WITH (NOLOCK) ON e.Eecsupervisorid = s.eecEEID AND e.EecCOID = s.eecCOID
--join jobcode on eecjobcode = jbcjobcode
--left JOIN emppers spv with (nolock) on s.eeceeid = spv.eepeeid


     --11/5/2019 added 700 rec If the employee is a supervisor (with direct report) and Job_EqGrade < 18, create 700 if changes occurred
      INSERT INTO dbo.U_dsi_ESEACHGC2N_drvTbl_700
    -- EE Detail
    select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-- standard fields above and additional driver fields below
    drvTransType = '700',
    drvApprovalType = 'EXP',
    drvEmpID = e.eecempno,
    drvsegment1 = '',
    drvsegment2 = '',
    drvsegment3 = '',
    drvsegment4 = '',
    drvsegment5 = '',
    drvsegment6 = '',
    drvsegment7 = '',
    drvsegment8 = '',
    drvsegment9 = '',
    drvsegment10 = '',
    drvExceptionApproveAuthority = '',
    drvApprovalLimit = case when Job_EqGrade <= 10 then '2500' --value from custom field EQ Grade
                                        when Job_EqGrade = 11 and j.jbcdesc like '%Division Manager%' then '5000'
                                        when Job_EqGrade between 11 and 13 then '10000'
                                        when Job_EqGrade in (14,15) then '15000'
                                        when Job_EqGrade in (16,17) then '25000'
                                        when Job_EqGrade > 17 then '100000' end,
    drvApprovalLimitCurrencyCode = 'USD'
from dbo.u_ESEACHGC2N_eelist with (nolock)
    JOIN EmpPers  on eepeeid = xeeid
    JOIN EmpComp e WITH (NOLOCK) ON EecEEID = xEEID AND EecCOID = xCOID
    JOIN dbo.u_ds_ESEACHGC2N_auditChanges newU WITH (NOLOCK) ON xeeid = newU.eeid and xcoid = newU.coid and newU.newuser = 'N' and audfieldname = 'eecjobcode'
    --JOIN dbo.U_ESEACHGC2N_Supervisors on empeeid = xeeid and empcoid = xcoid and Supervisor = 'Y'
    left join [dbo].[fn_MP_CustomFields_JobCode_Export](NULL,NULL,NULL,NULL) ON jbcjobcode = e.eecjobcode 
    LEFT JOIN dbo.JobCode j WITH (NOLOCK) ON j.jbcjobcode = e.eecjobcode --DA added
    WHERE Job_EqGrade < '18' --and effective between @StartDate and @EndDate


        -- Set FileName  
        if (dbo.dsi_fnVariable('ESEACHGC2N','UseFileName') = 'N')
          update dbo.U_dsi_Parameters
            set ExportFile =  'SEATTLEGEN_CONCUR_300_' + convert(char(8),getdate(),112) + '.csv'
            where FormatCode = 'ESEACHGC2N'


-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwESEACHGC2N_Export as
       select top 2000000 rtrim(left(data,(len(data)))) as data from dbo.U_ESEACHGC2N_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)

select expformatcode, expexportcode, *
from ascexp where expformatcode = 'ESEACHGC2N'
*/



--Used for testing
--dbo.dsi_sp_TestSwitchbox 'ESEACHGC2N','ESEACHGC2N'
--dbo.dsi_sp_TestSwitchbox 'ESEACHGC2N','ESEA300COE'
--dbo.dsi_sp_TestSwitchbox 'ESEACHGC2N','zap'
--dbo.dsi_sp_TestSwitchbox 'ESEACHGC2N','TEST'

END
GO
 CREATE  View dbo.dsi_vwESEACHGC2N_Export as
       select top 2000000 rtrim(left(data,(len(data)))) as data from dbo.U_ESEACHGC2N_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)