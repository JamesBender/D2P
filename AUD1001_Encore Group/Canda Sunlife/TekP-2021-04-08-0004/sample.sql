SET NOCOUNT ON;
IF OBJECT_ID('U_EXMLSUNLFC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EXMLSUNLFC_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EXMLSUNLFC' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_fn_EXMLSUNLFC_Benefciaries') IS NOT NULL DROP FUNCTION [dbo].[dsi_fn_EXMLSUNLFC_Benefciaries];
GO
IF OBJECT_ID('dsi_vwEXMLSUNLFC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEXMLSUNLFC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EXMLSUNLFC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EXMLSUNLFC];
GO
IF OBJECT_ID('U_EXMLSUNLFC_Provinces') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_Provinces];
GO
IF OBJECT_ID('U_EXMLSUNLFC_HdrTbl_Loader') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_HdrTbl_Loader];
GO
IF OBJECT_ID('U_EXMLSUNLFC_File') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_File];
GO
IF OBJECT_ID('U_EXMLSUNLFC_EEList') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_EEList];
GO
IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Salary') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_drvTbl_Salary];
GO
IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Person') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_drvTbl_Person];
GO
IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Member') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_drvTbl_Member];
GO
IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Address') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_drvTbl_Address];
GO
IF OBJECT_ID('U_EXMLSUNLFC_DedList') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_DedList];
GO
IF OBJECT_ID('U_EXMLSUNLFC_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_AuditFields];
GO
IF OBJECT_ID('U_EXMLSUNLFC_Audit') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EXMLSUNLFC';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EXMLSUNLFC';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EXMLSUNLFC';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EXMLSUNLFC';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EXMLSUNLFC';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EXMLSUNLFC','SunLife Demographic Benefits XML Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','EXMLSUNLFCZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EXMLSUNLFC' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<?xml version="','1','(''DA''=''T'')','EXMLSUNLFCZ0','50','H','01','1',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.0"','2','(''DA''=''Q'')','EXMLSUNLFCZ0','50','H','01','2',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" encoding="','3','(''DA''=''T'')','EXMLSUNLFCZ0','50','H','01','3',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ISO-8859-1"','4','(''DA''=''Q'')','EXMLSUNLFCZ0','50','H','01','4',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"?>"','5','(''DA''=''T'')','EXMLSUNLFCZ0','50','H','01','5',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Loader PolicyNum="','1','(''DA''=''T'')','EXMLSUNLFCZ0','50','H','02','1',NULL,'File Header - Load',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNum"','2','(''UA''=''Q'')','EXMLSUNLFCZ0','50','H','02','2',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ClientName="','3','(''DA''=''T'')','EXMLSUNLFCZ0','50','H','02','3',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','4','(''UA''=''Q'')','EXMLSUNLFCZ0','50','H','02','4',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ReportLanguageCd="','5','(''DA''=''T'')','EXMLSUNLFCZ0','50','H','02','5',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportLanguageCd"','6','(''UA''=''Q>'')','EXMLSUNLFCZ0','50','H','02','6',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Member PolicyNum="','1','(''DA''=''T'')','EXMLSUNLFCZ0','50','D','10','1',NULL,'Parent Level: Member (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNum"','2','(''UA''=''Q'')','EXMLSUNLFCZ0','50','D','10','2',NULL,'Employee - PolicyNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" LocationNum="','3','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','3',NULL,'Member - LocationNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationNum"','4','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','10','4',NULL,'Member - LocationNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ClassNum="','5','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','5',NULL,'Member - ClassNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassNum"','6','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','10','6',NULL,'Member - ClassNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" PlanNum="','7','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','7',NULL,'Member - PlanNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNum"','8','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','10','8',NULL,'Member - PlanNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" CertificateNum="','9','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','9',NULL,'Member - CertificateNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCertificateNum"','10','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','10','10',NULL,'Member - CertificateNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" PayrollNum="','11','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','11',NULL,'Member - PayrollNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollNum"','12','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','10','12',NULL,'Member - PayrollNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN ISNULL(drvEmploymentDt,'''') <>'''' THEN '' EmploymentDt='' END"','13','(''UA''=''T'')','EXMLSUNLFCZ0','100','D','10','13',NULL,'Member - EmploymentDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentDt"','14','(''UA''=''T'')','EXMLSUNLFCZ0','100','D','10','14',NULL,'Member - EmploymentDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN ISNULL(drvMemberEffDt,'''') <>'''' THEN '' MemberEffDt='' END"','15','(''UA''=''T'')','EXMLSUNLFCZ0','100','D','10','15',NULL,'Member - MemberEffDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberEffDt"','16','(''UA''=''T'')','EXMLSUNLFCZ0','100','D','10','16',NULL,'Member - MemberEffDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" WorkResidenceCd="','17','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','17',NULL,'Member - WorkResidenceCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkResidenceCd"','18','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','10','18',NULL,'Member - WorkResidenceCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" StatusCd="','19','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','19',NULL,'Member - StatusCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCd"','20','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','10','20',NULL,'Member - StatusCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CASE WHEN ISNULL(drvTermDt,'''') <>'''' THEN '' TermDt='' END"','21','(''UA''=''T'')','EXMLSUNLFCZ0','100','D','10','21',NULL,'Member - TermDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDt"','22','(''UA''=''T'')','EXMLSUNLFCZ0','100','D','10','22',NULL,'Member - TermDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" TermReasonCd="','23','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','23',NULL,'Member - TermReasonCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasonCd"','24','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','10','24',NULL,'Member - TermReasonCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" UpdateFlag="','25','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','25',NULL,'Member - UpdateFlag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUpdateFlag"','26','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','10','26',NULL,'Member - UpdateFlag (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ApplyDate="','27','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','27',NULL,'Member - ApplyDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApplyDate"','28','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','10','28',NULL,'Member - ApplyDate (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" TransferFlg="','29','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','10','29',NULL,'Member - TransferFlg',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransferFlg"','30','(''UA''=''Q>'')','EXMLSUNLFCZ0','100','D','10','30',NULL,'Member - TransferFlg (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Person FirstNm="','1','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','20','1',NULL,'Child Level: Person of Member (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstNm"','2','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','20','2',NULL,'Person - FirstNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" LastNm="','3','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','20','3',NULL,'Person - LastNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastNm"','4','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','20','4',NULL,'Person - LastNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" BirthDt="','5','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','20','5',NULL,'Person - BirthDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDt"','6','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','20','6',NULL,'Person - BirthDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ResidenceCd="','7','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','20','7',NULL,'Person - ResidenceCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResidenceCd"','8','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','20','8',NULL,'Person - ResidenceCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" GenderCd="','9','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','20','9',NULL,'Person - GenderCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGenderCd"','10','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','20','10',NULL,'Person - GenderCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" LanguageCd="','11','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','20','11',NULL,'Person - LanguageCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguageCd"','12','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','20','12',NULL,'Person - LanguageCd (Value) (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"/>"','13','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','20','13',NULL,'Child Level: Person of Member (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Salary SalaryDescCd="','1','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','30','1',NULL,'Child Level: Salary of Member (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryDescCd"','2','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','30','2',NULL,'Salary - SalaryDescCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" SalaryBasisCd="','3','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','30','3',NULL,'Salary - SalaryBasisCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryBasisCd"','4','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','30','4',NULL,'Salary - SalaryBasisCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" SalaryAmt="','5','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','30','5',NULL,'Salary - SalaryAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt"','6','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','30','6',NULL,'Salary - SalaryAmt (Value) (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"/>"','7','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','30','7',NULL,'Child Level: Salary of Member (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Address AddressTypeCd="','1','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','40','1',NULL,'Child Level: Address of Member (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressTypeCd"','2','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','40','2',NULL,'Address - AddressTypeCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" AddressNm="','3','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','40','3',NULL,'Address - AddressNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressNm"','4','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','40','4',NULL,'Address - AddressNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" StreetAddressNm="','5','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','40','5',NULL,'Address - StreetAddressNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStreetAddressNm"','6','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','40','6',NULL,'Address - StreetAddressNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" SuiteNm="','7','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','40','7',NULL,'Address - SuiteNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuiteNm"','8','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','40','8',NULL,'Address - SuiteNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" CityNm="','9','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','40','9',NULL,'Address - CityNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCityNm"','10','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','40','10',NULL,'Address - CityNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" StateOrProvCd="','11','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','40','11',NULL,'Address - StateOrProvCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvCd"','12','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','40','12',NULL,'Address - StateOrProvCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" PostalNum="','13','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','40','13',NULL,'Address - PostalNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalNum"','14','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','40','14',NULL,'Address - PostalNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" CountryCd="','15','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','40','15',NULL,'Address - CountryCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCd"','16','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','40','16',NULL,'Address - CountryCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" EmailAddressNm="','17','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','40','17',NULL,'Address - EmailAddressNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddressNm"','18','(''UA''=''Q'')','EXMLSUNLFCZ0','100','D','40','18',NULL,'Address - EmailAddressNm (Value) (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"/>"','19','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','40','19',NULL,'Child Level: Address of Member (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"</Member>"','1','(''DA''=''T'')','EXMLSUNLFCZ0','100','D','50','1',NULL,'Parent Level: Member (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"</Loader>"','1','(''DA''=''T'')','EXMLSUNLFCZ0','100','T','91','1',NULL,'File Trailer',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EXMLSUNLFC_20191224.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'On-Demand Manual Session','201912139','EMPEXPORT','ONDEM_XOE',NULL,'EXMLSUNLFC',NULL,NULL,NULL,'201912139','Aug 20 2019 12:09PM','Aug 20 2019 12:09PM','201912061',NULL,'','','201912061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',5JY88,ZIOI5,5JYIC,5JYXP',NULL,NULL,NULL,'Scheduled Session','201912139','EMPEXPORT','SCHEDULED',NULL,'EXMLSUNLFC',NULL,NULL,NULL,'201912139','Aug 20 2019 12:09PM','Aug 20 2019 12:09PM','201912061',NULL,'','','201912061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201912139','EMPEXPORT','TEST_XOE',NULL,'EXMLSUNLFC',NULL,NULL,NULL,'201912139','Aug 20 2019 12:09PM','Aug 20 2019 12:09PM','201912061',NULL,'','','201912061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLSUNLFC','ArchiveFile','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLSUNLFC','ArchivePath','V','\\ca.saas\t1\Public\TOL5000\Exports\SunLife\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLSUNLFC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLSUNLFC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLSUNLFC','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLSUNLFC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EXMLSUNLFC','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EXMLSUNLFC' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EXMLSUNLFC' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EXMLSUNLFC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EXMLSUNLFC_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EXMLSUNLFC','H02','dbo.U_EXMLSUNLFC_HdrTbl_Loader',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EXMLSUNLFC','D10','dbo.U_EXMLSUNLFC_drvTbl_Member',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EXMLSUNLFC','D20','dbo.U_EXMLSUNLFC_drvTbl_Person',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EXMLSUNLFC','D30','dbo.U_EXMLSUNLFC_drvTbl_Salary',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EXMLSUNLFC','D40','dbo.U_EXMLSUNLFC_drvTbl_Address',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EXMLSUNLFC','D50','dbo.U_EXMLSUNLFC_drvTbl_Member',NULL);
IF OBJECT_ID('U_EXMLSUNLFC_Audit') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audChangeType] varchar(12) NOT NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EXMLSUNLFC_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EXMLSUNLFC_DedList') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_DedList] (
    [BenGroupCode] char(5) NOT NULL,
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Address') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_drvTbl_Address] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(9) NULL,
    [drvAddressTypeCd] varchar(1) NOT NULL,
    [drvAddressNm] varchar(8000) NULL,
    [drvStreetAddressNm] varchar(6000) NULL,
    [drvSuiteNm] varchar(6000) NULL,
    [drvCityNm] varchar(6000) NULL,
    [drvStateOrProvCd] varchar(2) NULL,
    [drvPostalNum] varchar(51) NULL,
    [drvCountryCd] varchar(1) NULL,
    [drvEmailAddressNm] varchar(6000) NULL
);
IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Member') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_drvTbl_Member] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(9) NULL,
    [drvPolicyNum] varchar(6) NOT NULL,
    [drvLocationNum] varchar(3) NULL,
    [drvClassNum] varchar(5) NULL,
    [drvPlanNum] varchar(5) NULL,
    [drvCertificateNum] varchar(10) NULL,
    [drvPayrollNum] varchar(9) NULL,
    [drvEmploymentDt] nvarchar(258) NULL,
    [drvMemberEffDt] nvarchar(258) NULL,
    [drvWorkResidenceCd] varchar(2) NULL,
    [drvStatusCd] varchar(1) NOT NULL,
    [drvTermDt] nvarchar(258) NULL,
    [drvTermReasonCd] varchar(1) NULL,
    [drvUpdateFlag] varchar(5) NOT NULL,
    [drvApplyDate] varchar(10) NULL,
    [drvTransferFlg] varchar(8) NOT NULL
);
IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Person') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_drvTbl_Person] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(9) NULL,
    [drvFirstNm] varchar(6000) NULL,
    [drvLastNm] varchar(6000) NULL,
    [drvBirthDt] varchar(10) NULL,
    [drvResidenceCd] varchar(2) NULL,
    [drvGenderCd] varchar(1) NULL,
    [drvLanguageCd] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Salary') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_drvTbl_Salary] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(9) NULL,
    [drvSalaryDescCd] varchar(1) NOT NULL,
    [drvSalaryBasisCd] varchar(1) NOT NULL,
    [drvSalaryAmt] money NULL
);
IF OBJECT_ID('U_EXMLSUNLFC_EEList') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EXMLSUNLFC_File') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EXMLSUNLFC_HdrTbl_Loader') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_HdrTbl_Loader] (
    [drvPolicyNum] varchar(6) NOT NULL,
    [drvClientName] varchar(17) NOT NULL,
    [drvReportLanguageCd] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EXMLSUNLFC_Provinces') IS NULL
CREATE TABLE [dbo].[U_EXMLSUNLFC_Provinces] (
    [PrvCode] varchar(2) NULL,
    [PrvAbbr] varchar(2) NULL,
    [PrvDesc] varchar(255) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EXMLSUNLFC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Canada Brokerlink Inc.

Created By: Tanya Leonce
Business Analyst: Dian Turner
Create Date: 08/19/2019
Service Request Number: SR-2019-00238407

Purpose: SunLife Demographic Benefits XML Export - Combined

NOTE TO SUPPORT: This is setup as a Web Interface

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EXMLSUNLFC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EXMLSUNLFC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EXMLSUNLFC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EXMLSUNLFC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EXMLSUNLFC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EXMLSUNLFC', 'ONDEM_XOE'; --Manual On-Demand Session
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EXMLSUNLFC', 'TEST_XOE';  --Testing Purposes
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EXMLSUNLFC', 'SCHEDULED'; --Automated Web Schedule

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EXMLSUNLFC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EXMLSUNLFC';

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
    -- Create Deduction List
    --==========================================
    IF OBJECT_ID('U_EXMLSUNLFC_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLSUNLFC_DedList;
    SELECT DISTINCT
         BenGroupCode = CbpBenGroupCode
        ,DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EXMLSUNLFC_DedList
    FROM dbo.BenProg WITH (NOLOCK)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = CbpDedCode
    WHERE CbpBenGroupCode NOT IN ('NOBEN','NONE','RETIR','BEN70');

    DECLARE @DedList VARCHAR(MAX);
    SELECT @DedList = COALESCE(@DedList + ',', '') + LTRIM(RTRIM(DedCode)) FROM dbo.U_EXMLSUNLFC_DedList;

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EXMLSUNLFC_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLSUNLFC_AuditFields;
    CREATE TABLE dbo.U_EXMLSUNLFC_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EXMLSUNLFC_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EXMLSUNLFC_AuditFields VALUES ('EmpComp','EecDedGroupCode');
    INSERT INTO dbo.U_EXMLSUNLFC_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EXMLSUNLFC_AuditFields VALUES ('EmpComp','EecAnnSalary');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EXMLSUNLFC_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLSUNLFC_Audit;
    SELECT DISTINCT
         audEEID  = audKey1Value
        ,audCOID = CASE WHEN audTableName IN ('EmpComp') THEN audKey2Value
                        ELSE [dbo].[dsi_BDM_fn_GetCurrentCOID] (audKey1Value)
                   END
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audChangeType = CASE WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'NewHire'
                              WHEN audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Rehire'
                              WHEN audFieldName = 'EecDateOfTermination' AND ISNULL(audNewValue,'') <> '' THEN 'Term'
                              WHEN audFieldName = 'EecDedGroupCode' AND ISNULL(audOldValue,'NOBEN') IN ('NOBEN','NONE','RETIR','BEN70') AND ISNULL(audNewValue,'NOBEN') NOT IN ('NOBEN','NONE','RETIR','BEN70') THEN 'DedGroup'
                              WHEN audFieldName = 'EecDedGroupCode' AND ISNULL(audNewValue,'') IN ('NOBEN','NONE','RETIR','BEN70') THEN 'Term'
                              WHEN audFieldName = 'EecAnnSalary' AND ISNULL(audOldValue,'') <> ISNULL(audNewValue,'') THEN 'SalaryChange'
                              ELSE ''
                        END
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EXMLSUNLFC_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EXMLSUNLFC_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EXMLSUNLFC_Audit ON dbo.U_EXMLSUNLFC_Audit (audEEID,audKey2);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EXMLSUNLFC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EXMLSUNLFC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Terminated Employees NOT Found in Audit as a Termination
    DELETE FROM dbo.U_EXMLSUNLFC_EEList
    FROM dbo.U_EXMLSUNLFC_EEList
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecEmplStatus = 'T'
    AND NOT EXISTS (SELECT 1 FROM dbo.U_EXMLSUNLFC_Audit WHERE audEEID = xEEID AND audChangeType = 'Term');

    -- Remove Terminated Employees with Involuntary Term Reasons
    DELETE FROM dbo.U_EXMLSUNLFC_EEList
    FROM dbo.U_EXMLSUNLFC_EEList
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    WHERE EecEmplStatus = 'T'
    AND TchType = 'I';

    -- Exclude Employee's in Deduction/Benefit Group: 'NOBEN'
    DELETE FROM dbo.U_EXMLSUNLFC_EEList
    WHERE EXISTS (SELECT 1 FROM dbo.EmpComp WHERE EecEEID = xEEID AND EecCOID = xCOID ANd EecDedGroupCode IN ('NOBEN','NONE','RETIR','BEN70'))
    AND NOT EXISTS (SELECT 1 FROM dbo.U_EXMLSUNLFC_Audit WHERE audEEID = xEEID AND audFieldName = 'EecDedGroupCode' AND ISNULL(audNewValue,'') IN ('NOBEN','NONE','RETIR','BEN70'));

    -- Include employees only with Company Address Country: CAN
    DELETE FROM dbo.U_EXMLSUNLFC_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Company WHERE CmpCOID = xCOID AND CmpAddressCountry = 'CAN');

    -- Benefits Seniority Date has passed (Do Not Send Future Transactions)
    DELETE FROM dbo.U_EXMLSUNLFC_EEList
    WHERE EXISTS (SELECT 1 FROM dbo.EmpComp WHERE EecEEID = xEEID AND EecCOID = xCOID AND EecDateOfBenefitSeniority > @EndDate);

    --==========================================
    -- Build Driver Tables
    --==========================================

    ---------------------------------
    -- Header Records: <Loader>
    ---------------------------------
    IF OBJECT_ID('U_EXMLSUNLFC_HdrTbl_Loader','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLSUNLFC_HdrTbl_Loader;
    SELECT DISTINCT
         drvPolicyNum = '103902'
        ,drvClientName = 'Canada Brokerlink'
        ,drvReportLanguageCd = '1'
    INTO dbo.U_EXMLSUNLFC_HdrTbl_Loader;

    ---------------------------------
    -- Detail Records: <Member>
    ---------------------------------
    IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Member','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLSUNLFC_drvTbl_Member;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = LTRIM(RTRIM(EecEmpNo))
        -- standard fields above and additional driver fields below
        ,drvPolicyNum = '103902'
        ,drvLocationNum = SUBSTRING(EecUDField14,1,3)
        ,drvClassNum = COALESCE(SUBSTRING(EecUDField14,4,4),SUBSTRING(EecUDField14,4,5))
        ,drvPlanNum = COALESCE(SUBSTRING(EecUDField14,4,4),SUBSTRING(EecUDField14,4,5))
        ,drvCertificateNum = CONVERT(VARCHAR(10),CONVERT(INT,EecEmpNo))
        ,drvPayrollNum = LTRIM(RTRIM(EecEmpNo))
        ,drvEmploymentDt = CASE WHEN audNewHire = 'Y' AND EecDateOfBenefitSeniority BETWEEN @StartDate AND @EndDate THEN QUOTENAME(CONVERT(VARCHAR(10),EecDateOfOriginalHire,120),'"')
                                WHEN audDedGroup = 'Y' THEN QUOTENAME(CONVERT(VARCHAR(10),EecDateOfOriginalHire,120),'"')
                           END
        ,drvMemberEffDt = CASE WHEN audNewHire = 'Y' AND EecDateOfBenefitSeniority BETWEEN @StartDate AND @EndDate THEN QUOTENAME(CONVERT(VARCHAR(10),EecDateOfBenefitSeniority,120),'"')
                               WHEN audDedGroup = 'Y' THEN QUOTENAME(CONVERT(VARCHAR(10),EecDateOfBenefitSeniority,120),'"')
                          END
        ,drvWorkResidenceCd = WorkResidenceCd.PrvCode
        ,drvStatusCd = CASE WHEN EecEmplStatus = 'T' AND TchType = 'V' THEN '3'
                            WHEN audTerm = 'Y' THEN '3'
                            WHEN (EecEmplStatus = 'T' OR audTerm = 'Y') AND EXISTS (SELECT 1 FROM dbo.EmpDed WHERE EedEEID = xEEID AND EedCOID = xCOID AND EedStopDate IS NULL) THEN '1' --Termed but Benefits still Active
                            ELSE '1'
                       END
        ,drvTermDt = CASE WHEN EecEmplStatus = 'T' AND TchType = 'V' THEN QUOTENAME(CONVERT(VARCHAR(10),EecDateOfTermination,120),'"')
                          WHEN audTerm = 'Y' THEN QUOTENAME(CONVERT(VARCHAR(10),audDateTime_NOBEN,120),'"')
                     END
        ,drvTermReasonCd = CASE WHEN EecEmplStatus = 'T' AND TchType = 'V' THEN
                                    CASE WHEN EecTermReason = '203' THEN '6'
                                         ELSE '2'
                                    END
                                WHEN audTerm = 'Y' THEN '2'
                                WHEN EecEmplStatus <> 'T' AND EXISTS (SELECT 1 FROM dbo.EmpDed WHERE EedEEID = xEEID AND EedCOID = xCOID AND EedStopDate IS NULL) THEN '1' --Active and Benefits still Active
                           END
        ,drvUpdateFlag = CASE WHEN audNewHire = 'Y' AND EecDateOfBenefitSeniority BETWEEN @StartDate AND @EndDate THEN 'False'
                              WHEN audDedGroup = 'Y' THEN 'False'
                              ELSE 'True'
                         END
        ,drvApplyDate = CASE WHEN (audNewHire = 'Y' OR audRehire = 'Y') THEN CONVERT(VARCHAR(10),COALESCE(EecDateOfBenefitSeniority,GETDATE()),120)
                             WHEN TransferEffDate IS NOT NULL AND TransferEffDate BETWEEN @StartDate AND @EndDate THEN CONVERT(VARCHAR(10),COALESCE(TransferEffDate,GETDATE()),120)
                             WHEN SalaryEffDate IS NOT NULL AND SalaryEffDate BETWEEN @StartDate AND @EndDate THEN CONVERT(VARCHAR(10),SalaryEffDate,120)
                             WHEN audTerm = 'Y' THEN CONVERT(VARCHAR(10),COALESCE(EecDateOfTermination,audDateTime_NOBEN,GETDATE()),120)
                             ELSE CONVERT(VARCHAR(10),GETDATE(),120)
                        END
        ,drvTransferFlg = 'Implicit'
    INTO dbo.U_EXMLSUNLFC_drvTbl_Member
    FROM dbo.U_EXMLSUNLFC_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EXMLSUNLFC_Provinces WorkResidenceCd
        ON WorkResidenceCd.PrvAbbr = LEFT(EecStateSUI,2)
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN ( -- Salary Rate Change Date / Transfer Change Date
        SELECT DISTINCT EjhEEID
            ,SalaryEffDate = MAX(CASE WHEN EjhIsRateChange = 'Y' THEN EjhJobEffDate END)
            ,TransferEffDate = MAX(CASE WHEN EjhIsTransfer = 'Y' THEN EjhJobEffDate END)
        FROM dbo.EmpHJob
        WHERE (EjhIsRateChange = 'Y' OR EjhIsTransfer = 'Y')
        GROUP BY EjhEEID
    ) EmpHJob
        ON EjhEEID = xEEID
    LEFT JOIN (-- Get Audit Change Type and Benefit Start Date
        SELECT DISTINCT audEEID
            ,audCOID
            ,audNewHire = MAX(CASE WHEN audChangeType = 'NewHire' THEN 'Y' ELSE 'N' END)
            ,audRehire = MAX(CASE WHEN audChangeType = 'Rehire' THEN 'Y' ELSE 'N' END)
            ,audTerm = MAX(CASE WHEN audChangeType = 'Term' THEN 'Y' ELSE 'N' END)
            ,audDedGroup = MAX(CASE WHEN audChangeType = 'DedGroup' THEN 'Y' ELSE 'N' END)
            ,audDateTime_NOBEN = MAX(CASE WHEN audChangeType = 'Term' AND audNewValue IN ('NOBEN','NONE','RETIR','BEN70') THEN audDateTime END)
        FROM dbo.U_EXMLSUNLFC_Audit
        WHERE audRowNo = 1
        GROUP BY audEEID, audCOID
    ) AuditData
        ON audEEID = xEEID
        AND audCOID = xCOID;

    ---------------------------------
    -- Detail Records: <Person>
    ---------------------------------
    IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Person','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLSUNLFC_drvTbl_Person;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = LTRIM(RTRIM(EecEmpNo))
        -- standard fields above and additional driver fields below
        ,drvFirstNm = dbo.dsi_fnRemoveChars('=&;:<>+()_1234567890',LTRIM(RTRIM(EepNameFirst)))
        ,drvLastNm = dbo.dsi_fnRemoveChars('=&;:<>+()_1234567890',LTRIM(RTRIM(EepNameLast)))
        ,drvBirthDt = CONVERT(VARCHAR(10),EepDateOfBirth,120)
        ,drvResidenceCd = ResidenceCd.PrvCode
        ,drvGenderCd = CASE EepGender
                            WHEN 'M' THEN '1'
                            WHEN 'F' THEN '2'
                       END
        ,drvLanguageCd = CASE WHEN EecLanguageCode = 'FR' THEN '2'
                              ELSE '1'
                         END
    INTO dbo.U_EXMLSUNLFC_drvTbl_Person
    FROM dbo.U_EXMLSUNLFC_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EXMLSUNLFC_Provinces ResidenceCd
        ON ResidenceCd.PrvAbbr = EepAddressState;

    ---------------------------------
    -- Detail Records: <Salary>
    ---------------------------------
    IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Salary','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLSUNLFC_drvTbl_Salary;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = LTRIM(RTRIM(EecEmpNo))
        -- standard fields above and additional driver fields below
        ,drvSalaryDescCd = '1'
        ,drvSalaryBasisCd = '1'
        ,drvSalaryAmt = COALESCE(NULLIF(EecUDField09,0.00),CONVERT(MONEY,EecAnnSalary))
    INTO dbo.U_EXMLSUNLFC_drvTbl_Salary
    FROM dbo.U_EXMLSUNLFC_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecEmplStatus <> 'T' --Do Not Send for Terminated Employees
    AND CONVERT(MONEY,COALESCE(NULLIF(EecUDField09,0.00),CONVERT(MONEY,EecAnnSalary))) <> CONVERT(MONEY,0.00);

    ---------------------------------
    -- Detail Records: <Address>
    ---------------------------------
    IF OBJECT_ID('U_EXMLSUNLFC_drvTbl_Address','U') IS NOT NULL
        DROP TABLE dbo.U_EXMLSUNLFC_drvTbl_Address;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = LTRIM(RTRIM(EecEmpNo))
        -- standard fields above and additional driver fields below
        ,drvAddressTypeCd = '1'
        ,drvAddressNm = ISNULL(dbo.dsi_fnRemoveChars('=&;:<>+()_1234567890',LTRIM(RTRIM(EepNameFirst))),'') + SPACE(1) + ISNULL(dbo.dsi_fnRemoveChars('=&;:<>+()_1234567890',LTRIM(RTRIM(EepNameLast))),'')
        ,drvStreetAddressNm = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EepAddressLine1)))
        ,drvSuiteNm = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EepAddressLine2)))
        ,drvCityNm = dbo.dsi_fnRemoveChars('=&;:<>+#',LTRIM(RTRIM(EepAddressCity)))
        ,drvStateOrProvCd = PrvCode
        ,drvPostalNum = CASE WHEN EepAddressCountry = 'CAN' THEN STUFF(LTRIM(RTRIM(EepAddressZipCode)),4,0,SPACE(1))
                             ELSE LEFT(LTRIM(RTRIM(EepAddressZipCode)),5)
                        END
        ,drvCountryCd = CASE EepAddressCountry
                             WHEN 'CAN' THEN '1'
                        END
        ,drvEmailAddressNm = dbo.dsi_fnRemoveChars('=&;:<>+',LTRIM(RTRIM(EepAddressEMail)))
    INTO dbo.U_EXMLSUNLFC_drvTbl_Address
    FROM dbo.U_EXMLSUNLFC_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EXMLSUNLFC_Provinces WITH (NOLOCK)
        ON PrvAbbr = LTRIM(RTRIM(EepAddressState));

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'EXMLSUNLFC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.xml'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEXMLSUNLFC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EXMLSUNLFC_File (NOLOCK)
    ORDER BY CASE LEFT(RecordSet,1) WHEN 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort, RIGHT(RecordSet,2);

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EXMLSUNLFC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912061'
       ,expStartPerControl     = '201912061'
       ,expLastEndPerControl   = '201912139'
       ,expEndPerControl       = '201912139'
WHERE expFormatCode = 'EXMLSUNLFC';

-- Create State/Province Code Translation Table

IF OBJECT_ID('dbo.U_EXMLSUNLFC_Provinces') IS NOT NULL DROP TABLE dbo.U_EXMLSUNLFC_Provinces

CREATE TABLE [dbo].[U_EXMLSUNLFC_Provinces](
  [PrvCode] [VARCHAR](2)   NULL,
  [PrvAbbr] [VARCHAR](2)   NULL,
  [PrvDesc] [VARCHAR](255) NULL
) ON [PRIMARY]

INSERT INTO dbo.U_EXMLSUNLFC_Provinces VALUES
     ('1', 'NL', 'Newfoundland')
    ,('2', 'PE', 'Prince Edward Island')
    ,('3', 'NB', 'New Brunswick')
    ,('4', 'NS', 'Nova Scotia')
    ,('5', 'ON', 'Ontario')
    ,('6', 'QC', 'Quebec')
    ,('7', 'MB', 'Manitoba')
    ,('8', 'SK', 'Saskatchewan')
    ,('9', 'AB', 'Alberta')
    ,('10', 'BC', 'British Columbia')
    ,('11', 'NT', 'Northwest Territories')
    ,('12', 'YT', 'Yukon')
    ,('13', 'NU', 'Nunavut')
    ,('14', 'AL', 'Alabama')
    ,('15', 'AK', 'Alaska')
    ,('16', 'AZ', 'Arizona')
    ,('17', 'AR', 'Arkansas')
    ,('18', 'CA', 'California')
    ,('19', 'CO', 'Colorado')
    ,('20', 'CT', 'Connecticut')
    ,('21', 'DE', 'Delaware')
    ,('22', 'DC', 'District of Columbia')
    ,('23', 'FL', 'Florida')
    ,('24', 'GA', 'Georgia')
    ,('25', 'HI', 'Hawaii')
    ,('26', 'ID', 'Idaho')
    ,('27', 'IL', 'Illinois')
    ,('28', 'IN', 'Indiana')
    ,('29', 'IA', 'Iowa')
    ,('30', 'KS', 'Kansas')
    ,('31', 'KY', 'Kentucky')
    ,('32', 'LA', 'Louisianna')
    ,('33', 'ME', 'Maine')
    ,('34', 'MD', 'Maryland')
    ,('35', 'MA', 'Massachusetts')
    ,('36', 'MI', 'Michigan')
    ,('37', 'MN', 'Minnesota')
    ,('38', 'MS', 'Mississippi')
    ,('39', 'MO', 'Missouri')
    ,('40', 'MT', 'Montana')
    ,('41', 'NE', 'Nebraska')
    ,('42', 'NV', 'Nevada')
    ,('43', 'NH', 'New Hampshire')
    ,('44', 'NJ', 'New Jersey')
    ,('45', 'NM', 'New Mexico')
    ,('46', 'NY', 'New York')
    ,('47', 'NC', 'North Carolina')
    ,('48', 'ND', 'North Dakota')
    ,('49', 'OH', 'Ohio')
    ,('50', 'OK', 'Oklahoma')
    ,('51', 'OR', 'Oregon')
    ,('52', 'PA', 'Pennsylvania')
    ,('53', 'RI', 'Rhode Island')
    ,('54', 'SC', 'South Carolina')
    ,('55', 'SD', 'South Dakota')
    ,('56', 'TN', 'Tennessee')
    ,('57', 'TX', 'Texas')
    ,('58', 'UT', 'Utah')
    ,('59', 'VT', 'Vermont')
    ,('60', 'VA', 'Virginia')
    ,('61', 'WA', 'Washington')
    ,('62', 'WV', 'West Virginia')
    ,('63', 'WI', 'Wisconsin')
    ,('64', 'WY', 'Wyoming')
    ,('65', 'OT', 'Other')

SELECT * FROM dbo.U_EXMLSUNLFC_Provinces

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEXMLSUNLFC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EXMLSUNLFC_File (NOLOCK)
    ORDER BY CASE LEFT(RecordSet,1) WHEN 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort, RIGHT(RecordSet,2);
GO
CREATE FUNCTION [dbo].[dsi_fn_EXMLSUNLFC_Benefciaries] (
    @EEID CHAR(12)
)
RETURNS VARCHAR(MAX)
AS
/************************************************************

Created By: Tanya Leonce
Create Date: 08/20/2019

Purpose: Returns the Beneficiary Data in Comma-Delimited Format for Sunlife XML File

Command: PRINT dbo.dsi_fn_EXMLSUNLFC_Benefciaries (xEEID)

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

************************************************************/
BEGIN

    -- Declare Variables 
    DECLARE @Beneficiaries VARCHAR(MAX)

    -- Create Comma Delimited List of Beneficiaries
    SELECT @Beneficiaries = COALESCE(@Beneficiaries+',','')
                            + LTRIM(RTRIM(ConNameFirst)) + SPACE(1) + LTRIM(RTRIM(ConNameLast)) + ','
                            + ISNULL(RELATION.CodDesc,'') + ','
                            + CONVERT(VARCHAR(10),CONVERT(MONEY,BfpPctToAlloc)) + '%'
    FROM dbo.BnfBPlan
    JOIN dbo.Contacts
        ON ConEEID = BfpEEID
        AND ConSystemID = BfpConRecID
    LEFT JOIN dbo.DedCode
        ON DedDedCode = BfpDedCode
    LEFT JOIN dbo.Codes RELATION
        ON RELATION.CodCode = ConRelationship
        AND RELATION.CodTable = 'RELATION'
    WHERE DedDedType IN ('OPT','OPC','OPS')
    AND BfpPctToAlloc > 0.00
    AND BfpEEID = @EEID;

    -- Return Beneficiaries
    RETURN @Beneficiaries;

END