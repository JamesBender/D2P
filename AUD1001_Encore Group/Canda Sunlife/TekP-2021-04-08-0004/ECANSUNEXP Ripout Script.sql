SET NOCOUNT ON;
IF OBJECT_ID('U_ECANSUNEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECANSUNEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECANSUNEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECANSUNEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECANSUNEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECANSUNEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECANSUNEXP];
GO
IF OBJECT_ID('U_ECANSUNEXP_Loader') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_Loader];
GO
IF OBJECT_ID('U_ECANSUNEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_File];
GO
IF OBJECT_ID('U_ECANSUNEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_EEList];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Salary') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Salary];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_PersonLink') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_PersonLink];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Person') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Person];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Member') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Member];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Benefits') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Benefits];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Address') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Address];
GO
IF OBJECT_ID('U_ECANSUNEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECANSUNEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECANSUNEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECANSUNEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECANSUNEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECANSUNEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECANSUNEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECANSUNEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECANSUNEXP','Canada Sunlife XML Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECANSUNEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECANSUNEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<?xml version="','1','(''DA''=''T'')','ECANSUNEXPZ0','50','H','01','1',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.0"','2','(''DA''=''Q'')','ECANSUNEXPZ0','50','H','01','2',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" encoding="','3','(''DA''=''T'')','ECANSUNEXPZ0','50','H','01','3',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ISO-8859-1"','4','(''DA''=''Q'')','ECANSUNEXPZ0','50','H','01','4',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"?>"','5','(''DA''=''T'')','ECANSUNEXPZ0','50','H','01','5',NULL,'Envelope Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Loader PolicyNum="','1','(''DA''=''T'')','ECANSUNEXPZ0','50','H','02','1',NULL,'File Header - Load',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNum"','2','(''UA''=''Q'')','ECANSUNEXPZ0','50','H','02','2',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ClientName="','3','(''DA''=''T'')','ECANSUNEXPZ0','50','H','02','3',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','4','(''UA''=''Q'')','ECANSUNEXPZ0','50','H','02','4',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ReportLanguageCd="','5','(''DA''=''T'')','ECANSUNEXPZ0','50','H','02','5',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportLanguageCd"','6','(''UA''=''Q>'')','ECANSUNEXPZ0','50','H','02','6',NULL,'File Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Member PolicyNum="','1','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','1',NULL,'Parent Level: Member (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyNum"','2','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','2',NULL,'Employee - PolicyNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" LocationNum="','3','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','3',NULL,'Member - LocationNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationNum"','4','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','4',NULL,'Member - LocationNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ClassNum="','5','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','5',NULL,'Member - ClassNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassNum"','6','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','6',NULL,'Member - ClassNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" PlanNum="','7','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','7',NULL,'Member - PlanNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNm"','8','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','8',NULL,'Member - PlanNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" CertificateNum="','9','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','9',NULL,'Member - CertificateNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCertificateNum"','10','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','10',NULL,'Member - CertificateNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" PayrollNum="','11','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','11',NULL,'Member - PayrollNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollNum"','12','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','12',NULL,'Member - PayrollNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" EmploymentDt="','13','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','13',NULL,'Member - EmploymentDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentDt"','14','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','14',NULL,'Member - EmploymentDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" WorkResidenceCd="','15','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','15',NULL,'Member - WorkResidenceCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkResidenceCd"','16','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','16',NULL,'Member - WorkResidenceCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" Beneficiary="','17','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','17',NULL,'Member - Beneficiary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneficiary"','18','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','18',NULL,'Member - Beneficiary (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" StatusCd="','19','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','19',NULL,'Member - StatusCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCd"','20','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','20',NULL,'Member - StatusCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" TermDt="','21','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','21',NULL,'Member - TermDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDt"','22','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','22',NULL,'Member - TermDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasnonCdHeader"','23','(''UA''=''T'')','ECANSUNEXPZ0','50','D','10','23',NULL,'Member - TermReasonCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasonCd"','24','(''UA''=''T'')','ECANSUNEXPZ0','50','D','10','24',NULL,'Member - TermReasonCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" UpdateFlag="','25','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','25',NULL,'Member - UpdateFlag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUpdateFlag"','26','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','26',NULL,'Member - UpdateFlag (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ApplyDate="','27','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','27',NULL,'Member - ApplyDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApplyDate"','28','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','28',NULL,'Member - ApplyDate (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" TransferFlg="','29','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','29',NULL,'Member - TransferFlg',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransferFlg"','30','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','10','30',NULL,'Member - TransferFlg (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ReinstatementFlg="','31','(''DA''=''T'')','ECANSUNEXPZ0','50','D','10','31',NULL,'Member - ReinstatementFlg',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReinstatementFlg"','32','(''UA''=''Q>'')','ECANSUNEXPZ0','50','D','10','32',NULL,'Member - ReinstatementFlg (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Person FirstNm="','1','(''DA''=''T'')','ECANSUNEXPZ0','50','D','20','1',NULL,'Child Level: Person of Member (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstNm"','2','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','20','2',NULL,'Person - FirstNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" LastNm="','3','(''DA''=''T'')','ECANSUNEXPZ0','50','D','20','3',NULL,'Person - LastNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastNm"','4','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','20','4',NULL,'Person - LastNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" BirthDt="','5','(''DA''=''T'')','ECANSUNEXPZ0','50','D','20','5',NULL,'Person - BirthDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDt"','6','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','20','6',NULL,'Person - BirthDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" ResidenceCd="','7','(''DA''=''T'')','ECANSUNEXPZ0','50','D','20','7',NULL,'Person - ResidenceCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResidenceCd"','8','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','20','8',NULL,'Person - ResidenceCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" GenderCd="','9','(''DA''=''T'')','ECANSUNEXPZ0','50','D','20','9',NULL,'Person - GenderCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGenderCd"','10','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','20','10',NULL,'Person - GenderCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" SmokerFlg="','11','(''DA''=''T'')','ECANSUNEXPZ0','50','D','20','11',NULL,'Person - SmokerFlg',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSmokerFlg"','12','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','20','12',NULL,'Person - SmokerFlg (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" DepTypeCd="','13','(''DA''=''T'')','ECANSUNEXPZ0','50','D','20','13',NULL,'Person - DepTypeCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepTypeCd"','14','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','20','14',NULL,'Person - DepTypeCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" LanguageCd="','15','(''DA''=''T'')','ECANSUNEXPZ0','50','D','20','15',NULL,'Person - LanguageCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguageCd"','16','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','20','16',NULL,'Person - LanguageCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" />','17','(''DA''=''T'')','ECANSUNEXPZ0','50','D','20','17',NULL,'Person',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Salary SalaryDescCd="','1','(''DA''=''T'')','ECANSUNEXPZ0','50','D','30','1',NULL,'Child Level: Salary of Member (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryDescCd"','2','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','30','2',NULL,'Salary - SalaryDescCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" SalaryBasisCd="','3','(''DA''=''T'')','ECANSUNEXPZ0','50','D','30','3',NULL,'Salary - SalaryBasisCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryBasisCd"','4','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','30','4',NULL,'Salary - SalaryBasisCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" SalaryAmt="','5','(''DA''=''T'')','ECANSUNEXPZ0','50','D','30','5',NULL,'Salary - SalaryAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt"','6','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','30','6',NULL,'Salary - SalaryAmt (Value)',NULL,NULL);

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" HoursPerWeekAmt="','7','(''DA''=''T'')','ECANSUNEXPZ0','50','D','30','7',NULL,'Hours Per Week Amount - HoursPerWeekAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerWeekAmt"','8','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','30','8',NULL,'Hours Per Week Amount - HoursPerWeekAmt (Value)',NULL,NULL);


INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" EffectiveDt="','9','(''DA''=''T'')','ECANSUNEXPZ0','50','D','30','9',NULL,'Salary - EffectiveDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDt"','10','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','30','10',NULL,'Salary - EffectiveDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" />"','11','(''DA''=''T'')','ECANSUNEXPZ0','50','D','30','11',NULL,'Salary',NULL,NULL);



INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Address AddressTypeCd="','1','(''DA''=''T'')','ECANSUNEXPZ0','50','D','40','1',NULL,'Address - AddressTypeCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressTypeCd"','2','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','40','2',NULL,'Address - AddressTypeCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" AddressNm="','3','(''DA''=''T'')','ECANSUNEXPZ0','50','D','40','3',NULL,'Address - AddressNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressNm"','4','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','40','4',NULL,'Address - AddressNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" StreetAddressNm="','5','(''DA''=''T'')','ECANSUNEXPZ0','50','D','40','5',NULL,'Address - StreetAddressNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStreetAddressNm"','6','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','40','6',NULL,'Address - StreetAddressNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" SuiteNm="','7','(''DA''=''T'')','ECANSUNEXPZ0','50','D','40','7',NULL,'Address - SuiteNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuiteNm"','8','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','40','8',NULL,'Address - SuiteNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" CityNm="','9','(''DA''=''T'')','ECANSUNEXPZ0','50','D','40','9',NULL,'Address - CityNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCityNm"','10','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','40','10',NULL,'Address - CityNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" StateOrProvCd="','11','(''DA''=''T'')','ECANSUNEXPZ0','50','D','40','11',NULL,'Address - StateOrProvCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvCd"','12','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','40','12',NULL,'Address - StateOrProvCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" PostalNum="','13','(''DA''=''T'')','ECANSUNEXPZ0','50','D','40','13',NULL,'Address - PostalNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalNum"','14','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','40','14',NULL,'Address - PostalNum (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" CountryCd="','15','(''DA''=''T'')','ECANSUNEXPZ0','50','D','40','15',NULL,'Address - CountryCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCd"','16','(''UA''=''Q/>'')','ECANSUNEXPZ0','50','D','40','16',NULL,'Address - CountryCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"/>"','17','(''DA''=''T'')','ECANSUNEXPZ0','50','D','40','17',NULL,'Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<PersonLink PersonLinkTypeCd="','1','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','1',NULL,'Child Level: PersonLink of Member (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonLinkTypeCd"','2','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','2',NULL,'PersonLink - PersonLinkTypeCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstNm="','3','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','3',NULL,'PersonLink - FirstNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstNm"','4','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','4',NULL,'PersonLink- FirstNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" LastNm="','5','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','5',NULL,'PersonLink- LastNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastNm"','6','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','6',NULL,'PersonLink- LastNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" BirthDt="','7','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','7',NULL,'PersonLink- BirthDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDt"','8','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','8',NULL,'PersonLink- BirthDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" GenderCd="','9','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','9',NULL,'PersonLink- GenderCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGenderCd"','10','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','10',NULL,'PersonLink - GenderCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" SmokerFlg="','11','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','11',NULL,'PersonLink - SmokerFlg',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSmokerFlg"','12','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','12',NULL,'PersonLink - SmokerFlg (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" InSchoolFlg="','13','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','13',NULL,'PersonLink - InSchoolFlg',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInSchoolFlg"','14','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','14',NULL,'PersonLink - InSchoolFlg (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" EffectiveDt="','15','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','15',NULL,'PersonLink - EffectiveDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDt"','16','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','16',NULL,'PersonLink - EffectiveDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" TermDt="','17','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','17',NULL,'PersonLink - TermDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDt"','18','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','18',NULL,'PersonLink - TermDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasnonCdHeader"','19','(''UA''=''T'')','ECANSUNEXPZ0','50','D','50','19',NULL,'PersonLink - TermReasonCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasonCd"','20','(''UA''=''T'')','ECANSUNEXPZ0','50','D','50','20',NULL,'PersonLink - TermReasonCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" StatusCd="','21','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','21',NULL,'PersonLink - StatusCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCd"','22','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','22',NULL,'PersonLink - StatusCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" OldFirstNm="','23','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','23',NULL,'PersonLink - OldFirstNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOldFirstNm"','24','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','50','24',NULL,'PersonLink - OldFirstNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"/>"','25','(''DA''=''T'')','ECANSUNEXPZ0','50','D','50','25',NULL,'PersonLink',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"<Benefits BenefitType="','1','(''DA''=''T'')','ECANSUNEXPZ0','50','D','60','1',NULL,'Child Level: Benefits (Start Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitType"','2','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','60','2',NULL,'Benefits - BenefitType (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" FlexCodeNm="','3','(''DA''=''T'')','ECANSUNEXPZ0','50','D','60','3',NULL,'Benefits - FlexCodeNm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFlexCodeNm"','4','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','60','4',NULL,'Benefits - FlexCodeNm (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" DepTypeCd="','5','(''DA''=''T'')','ECANSUNEXPZ0','50','D','60','5',NULL,'Benefits - DepTypeCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepTypeCd"','6','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','60','6',NULL,'Benefits - DepTypeCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" EffectiveDt="','7','(''DA''=''T'')','ECANSUNEXPZ0','50','D','60','7',NULL,'Benefits - EffectiveDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDt"','8','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','60','8',NULL,'Benefits - EffectiveDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" StatusCd="','13','(''DA''=''T'')','ECANSUNEXPZ0','50','D','60','13',NULL,'Benefits - StatusCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCd"','14','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','60','14',NULL,'Benefits - StatusCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasnonCdHeader"','15','(''UA''=''T'')','ECANSUNEXPZ0','50','D','60','15',NULL,'Benefits - TermReasonCd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasonCd"','16','(''UA''=''T'')','ECANSUNEXPZ0','50','D','60','16',NULL,'Benefits - TermReasonCd (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" TermDt="','17','(''DA''=''T'')','ECANSUNEXPZ0','50','D','60','17',NULL,'Benefits - TermDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDt"','18','(''UA''=''Q'')','ECANSUNEXPZ0','50','D','60','18',NULL,'Benefits - TermDt (Value)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"/>"','19','(''DA''=''T'')','ECANSUNEXPZ0','50','D','60','19',NULL,'Benefits - TermDt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"</Member>"','1','(''DA''=''T'')','ECANSUNEXPZ0','50','D','70','1',NULL,'Parent Level: Member (End Loop)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"</Loader>"','1','(''DA''=''T'')','ECANSUNEXPZ0','50','T','90','1',NULL,'File Trailer',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECANSUNEXP_20211022.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202108059','EMPEXPORT','OEACTIVE',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202108059','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202108051',NULL,'','','202108051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202108059','EMPEXPORT','OEPASSIVE',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202108059','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202108051',NULL,'','','202108051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Canada Sunlife XML Export','202108059','EMPEXPORT','ONDEM_XOE',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202108059','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202108051',NULL,'','','202108051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Canada Sunlife XML Expor-Sched','202108059','EMPEXPORT','SCH_ECANSU',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202108059','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202108051',NULL,'','','202108051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Canada Sunlife XML Expor-Test','202110159','EMPEXPORT','TEST_XOE','Oct 15 2021  7:08PM','ECANSUNEXP',NULL,NULL,NULL,'202110159','Oct 15 2021 12:00AM','Dec 30 1899 12:00AM','202110011','9482','','','202110011',dbo.fn_GetTimedKey(),NULL,'us3lKiAUD1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECANSUNEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECANSUNEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECANSUNEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','H02','dbo.U_ECANSUNEXP_Loader',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D10','dbo.U_ECANSUNEXP_drvTbl_Member',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D20','dbo.U_ECANSUNEXP_drvTbl_Person',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D30','dbo.U_ECANSUNEXP_drvTbl_Salary',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D40','dbo.U_ECANSUNEXP_drvTbl_Address',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D50','dbo.U_ECANSUNEXP_drvTbl_PersonLink',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D60','dbo.U_ECANSUNEXP_drvTbl_Benefits',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D70','dbo.U_ECANSUNEXP_drvTbl_Member',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','T90','None',NULL);
IF OBJECT_ID('U_dsi_BDM_ECANSUNEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECANSUNEXP] (
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
IF OBJECT_ID('U_ECANSUNEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Address') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Address] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvAddressTypeCd] varchar(1) NOT NULL,
    [drvAddressNm] varchar(201) NULL,
    [drvStreetAddressNm] varchar(510) NULL,
    [drvSuiteNm] varchar(1) NOT NULL,
    [drvCityNm] varchar(255) NULL,
    [drvStateOrProvCd] varchar(2) NULL,
    [drvPostalNum] varchar(50) NULL,
    [drvCountryCd] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Benefits') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Benefits] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvBenefitType] varchar(3) NULL,
    [drvFlexCodeNm] varchar(1) NOT NULL,
    [drvDepTypeCd] varchar(1) NOT NULL,
    [drvEffectiveDt] varchar(10) NULL,
    [drvStatusCd] varchar(1) NOT NULL,
    [drvTermReasnonCdHeader] varchar(14) NULL,
    [drvTermReasonCd] varchar(3) NULL,
    [drvTermDt] varchar(10) NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Member') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Member] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvPolicyNum] varchar(6) NOT NULL,
    [drvLocationNum] varchar(3) NULL,
    [drvClassNum] varchar(3) NULL,
    [drvPlanNm] varchar(3) NULL,
    [drvCertificateNum] char(10) NULL,
    [drvPayrollNum] varchar(1) NOT NULL,
    [drvEmploymentDt] varchar(10) NULL,
    [drvWorkResidenceCd] varchar(2) NULL,
    [drvBeneficiary] varchar(1) NOT NULL,
    [drvStatusCd] varchar(1) NOT NULL,
    [drvTermDt] varchar(10) NULL,
    [drvTermReasnonCdHeader] varchar(14) NULL,
    [drvTermReasonCd] varchar(3) NULL,
    [drvUpdateFlag] varchar(5) NOT NULL,
    [drvApplyDate] varchar(10) NULL,
    [drvTransferFlg] varchar(8) NOT NULL,
    [drvReinstatementFlg] varchar(5) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Person') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Person] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvFirstNm] varchar(100) NULL,
    [drvLastNm] varchar(100) NULL,
    [drvBirthDt] varchar(10) NULL,
    [drvResidenceCd] varchar(2) NULL,
    [drvGenderCd] varchar(1) NOT NULL,
    [drvSmokerFlg] varchar(5) NOT NULL,
    [drvDepTypeCd] varchar(1) NOT NULL,
    [drvLanguageCd] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_PersonLink') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_PersonLink] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvPersonLinkTypeCd] varchar(1) NULL,
    [drvFirstNm] varchar(100) NULL,
    [drvLastNm] varchar(100) NULL,
    [drvBirthDt] varchar(10) NULL,
    [drvGenderCd] char(1) NULL,
    [drvSmokerFlg] varchar(5) NOT NULL,
    [drvInSchoolFlg] varchar(1) NOT NULL,
    [drvEffectiveDt] varchar(1) NOT NULL,
    [drvTermDt] varchar(1) NOT NULL,
    [drvTermReasnonCdHeader] varchar(14) NULL,
    [drvTermReasonCd] varchar(8) NULL,
    [drvStatusCd] varchar(1) NOT NULL,
    [drvOldFirstNm] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Salary') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Salary] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvSalaryDescCd] varchar(1) NOT NULL,
    [drvSalaryBasisCd] varchar(1) NOT NULL,
    [drvSalaryAmt] nvarchar(4000) NULL,
    [drvHoursPerWeekAmt] NVARCHAR(4000) NULL,
    [drvEffectiveDt] varchar(10) NULL
);
IF OBJECT_ID('U_ECANSUNEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECANSUNEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ECANSUNEXP_Loader') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_Loader] (
    [drvPolicyNum] varchar(6) NOT NULL,
    [drvClientName] varchar(36) NOT NULL,
    [drvReportLanguageCd] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECANSUNEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Encore Group

Created By: James Bender
Business Analyst: Lea King
Create Date: 08/05/2021
Service Request Number: TekP-2021-04-08-0004

Purpose: Canada Sunlife XML Export

\\us.saas\N2\N21\AUD1001\Exports

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECANSUNEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECANSUNEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECANSUNEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECANSUNEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECANSUNEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'SCH_ECANSU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECANSUNEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECANSUNEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECANSUNEXP';

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
    DELETE FROM dbo.U_ECANSUNEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECANSUNEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECANSUNEXP_EEList WHERE xCOID IN (
        SELECT DISTINCT CmpCOID FROM dbo.Company WITH (NOLOCK) WHERE CmpCompanyCode NOT IN ('PSCA','ENCA','FMAV')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CEXSL,CDPL,COPLF,CADD,CXADD,CXADP,CSTD,CLTD,CDENT,CMED';

    IF OBJECT_ID('U_ECANSUNEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECANSUNEXP_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Member
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Member','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Member;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvPolicyNum = '103932'
        ,drvLocationNum =    CASE WHEN CmpCompanyCode = 'PSCA' THEN '001'
                                WHEN CmpCompanyCode = 'ENCA' THEN '002'
                                WHEN CmpCompanyCode = 'FMAV' THEN '003'
                            END
        ,drvClassNum =    CASE WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ1'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'UCAN' AND EepAddressState = 'QC' THEN 'UQ2'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ3'
                        END
        ,drvPlanNm =    CASE WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND  EepAddressState = 'QC' THEN 'AQ1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ1'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'UCAN' AND EepAddressState = 'QC' THEN 'UQ2'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ3'
                        END
        ,drvCertificateNum = EecUdField01 -- 'TBD' -- select * from dbo.fn_MP_CustomFields_EmpComp_Export (NULL,NULL,NULL,NULL)
        ,drvPayrollNum = ''
        ,drvEmploymentDt =    CASE WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN CONVERT(VARCHAR(10),EecDateOfLastHire, 126) END
        ,drvWorkResidenceCd =    CASE LocAddressState
                                    WHEN 'NL' THEN '1'
                                    WHEN 'PE' THEN '2'
                                    WHEN 'NB' THEN '3'
                                    WHEN 'NS' THEN '4'
                                    WHEN 'ON' THEN '5'
                                    WHEN 'QC' THEN '6'
                                    WHEN 'MB' THEN '7'
                                    WHEN 'SK' THEN '8'
                                    WHEN 'AB' THEN '9'
                                    WHEN 'BC' THEN '10'
                                END
        ,drvBeneficiary = ''
        ,drvStatusCd = CASE WHEN EecEmplStatus = 'T' THEN '3' ELSE '1' END
        ,drvTermDt = CONVERT(VARCHAR(10),EecDateOfTermination, 126)
        ,drvTermReasnonCdHeader = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN ' TermReasonCd=' 
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '203' THEN ' TermReasonCd=' 
                            END
        ,drvTermReasonCd =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN '"6"' 
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '203' THEN '"2"'
                            END
        ,drvUpdateFlag = CASE WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN 'False' ELSE 'True' END
        ,drvApplyDate =    CONVERT(VARCHAR(10),
                                CASE WHEN EjhReason = 'TRI' THEN EjhJobEffDate
                                    WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN EecDateOfLastHire
                                    WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                    ELSE dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire)
                                END, 126)
        ,drvTransferFlg = 'Implicit'
        ,drvReinstatementFlg = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN 'True' ELSE 'False' END
    INTO dbo.U_ECANSUNEXP_drvTbl_Member
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Person
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Person','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Person;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort =  xEEID
        -- standard fields above and additional driver fields below
        ,drvFirstNm = EepNameFirst
        ,drvLastNm = EepNameLast
        ,drvBirthDt = CONVERT(VARCHAR(10),EepDateOfBirth, 126)
        ,drvResidenceCd = CASE LocAddressState
                            WHEN 'NL' THEN '1'
                            WHEN 'PE' THEN '2'
                            WHEN 'NB' THEN '3'
                            WHEN 'NS' THEN '4'
                            WHEN 'ON' THEN '5'
                            WHEN 'QC' THEN '6'
                            WHEN 'MB' THEN '7'
                            WHEN 'SK' THEN '8'
                            WHEN 'AB' THEN '9'
                            WHEN 'BC' THEN '10'
                        END
        ,drvGenderCd = CASE WHEN EepGender = 'M' THEN '1' ELSE '2' END
        ,drvSmokerFlg = CASE WHEN EepIsSmoker = 'Y' THEN 'True' ELSE 'False' END
        ,drvDepTypeCd =    CASE WHEN DepTypeEEID IS NOT NULL THEN '3' ELSE '2' END
                        --CASE WHEN BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('FAMILY','FAMON','FAMQC') THEN '3' ELSE '2' END
        ,drvLanguageCd =    CASE WHEN EecLanguageCode = 'FR' THEN '2' ELSE '1' END                                
    INTO dbo.U_ECANSUNEXP_drvTbl_Person
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID    
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
                SELECT DISTINCT BdmEEID AS DepTypeEEID, BdmCOID AS DepTypeCOID
                FROM dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
                WHERE BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('FAMILY','FAMON','FAMQC')) AS DepType
        ON DepTypeEEID = xEEID
        AND DepTypeCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Salary
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Salary','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Salary;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvSalaryDescCd = '1'
        ,drvSalaryBasisCd = CASE WHEN EecSalaryOrHourly = 'S' THEN '1' ELSE '5' END
        ,drvSalaryAmt = FORMAT(CASE WHEN EecSalaryOrHourly = 'S' THEN EecAnnSalary ELSE EecHourlyPayRate END, '#0.00')
        ,drvHoursPerWeekAmt = ''
        ,drvEffectiveDt = CONVERT(VARCHAR(10), dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, @EndDate, EecDateOfLastHire), 126)
    INTO dbo.U_ECANSUNEXP_drvTbl_Salary
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Address
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Address','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Address;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvAddressTypeCd = '1'
        ,drvAddressNm = EepNameFirst + ' ' + EepNameLast
        ,drvStreetAddressNm = EepAddressLine1 + CASE WHEN EepAddressLine2 IS NULL THEN EepAddressLine2 ELSE '' END
        ,drvSuiteNm = ''
        ,drvCityNm = EepAddressCity
        ,drvStateOrProvCd = CASE EepAddressState
                            WHEN 'NL' THEN '1'
                            WHEN 'PE' THEN '2'
                            WHEN 'NB' THEN '3'
                            WHEN 'NS' THEN '4'
                            WHEN 'ON' THEN '5'
                            WHEN 'QC' THEN '6'
                            WHEN 'MB' THEN '7'
                            WHEN 'SK' THEN '8'
                            WHEN 'AB' THEN '9'
                            WHEN 'BC' THEN '10'
                        END        
        ,drvPostalNum =    CASE WHEN EepAddressCountry = 'CAN' THEN LEFT(EepAddressZipCode, 3) + ' ' + RIGHT(RTRIM(EepAddressZipCode), 3)  ELSE EepAddressZipCode END
        ,drvCountryCd = '1'
    INTO dbo.U_ECANSUNEXP_drvTbl_Address
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_PersonLink
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_PersonLink','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_PersonLink;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvPersonLinkTypeCd =    CASE WHEN ConRelationship IN ('CVL','DOM','SPS') THEN '2'
                                    WHEN ConRelationship IN ('CHL','STC') THEN '3'
                                END
        ,drvFirstNm = ConNameFirst
        ,drvLastNm = ConNameLast
        ,drvBirthDt = CONVERT(VARCHAR(10), ConDateOfBirth, 126)
        ,drvGenderCd = ConGender
        ,drvSmokerFlg = CASE WHEN ConIsSmoker = 'Y' THEN 'True' ELSE 'False' END
        ,drvInSchoolFlg = ''
        ,drvEffectiveDt = ''
        ,drvTermDt = ''
        ,drvTermReasnonCdHeader = CASE WHEN EecEmplStatus = 'T' THEN ' TermReasonCd='  END
        ,drvTermReasonCd = CASE WHEN EecEmplStatus = 'T' THEN '"' + EecTermReason + '"' END
        ,drvStatusCd = ''
        ,drvOldFirstNm = ''
    INTO dbo.U_ECANSUNEXP_drvTbl_PersonLink
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Benefits
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Benefits','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Benefits;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvBenefitType =    CASE WHEN BdmDedCode = 'CEXSL' THEN '101'
                                WHEN BdmDedCode = 'CDPL' THEN '103'
                                WHEN BdmDedCode = 'COPLF' THEN '111'
                                WHEN BdmDedCode IN ('CADD','CXADD','CXADP') THEN '301'
                                WHEN BdmDedCode = 'CDENT' THEN '502'
                                WHEN BdmDedCode = 'CSTD' THEN '401'
                                WHEN BdmDedCode = 'CLTD' THEN '411'
                                WHEN BdmDedCode = 'CMED' THEN '512'
                            END
        ,drvFlexCodeNm = 'A'
        ,drvDepTypeCd =    CASE WHEN BdmDedCode = 'CDPL' THEN '3'
                            WHEN BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('FAMILY','FAMON','FAMQC') THEN '3'
                            WHEN BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('EEON','EEONLY','EEQC') THEN '2'
                            ELSE '1'
                        END
        ,drvEffectiveDt = CONVERT(VARCHAR(10), BdmBenStartDate, 126)
--        ,drvRequestedUnitsAmt = FORMAT(BdmEEAmt, '#0.00')
--        ,drvRequestedAmt = ''
        ,drvStatusCd = CASE WHEN BdmBenStatus <> 'A' THEN '3' ELSE '1' END
        ,drvTermReasnonCdHeader =    CASE WHEN EecEmplStatus = 'T' THEN 
                                        CASE WHEN BdmBenStatus <> 'A' THEN ' TermReasonCd='  END
                                    END
        ,drvTermReasonCd =  CASE WHEN EecEmplStatus = 'T' THEN 
                                CASE WHEN BdmBenStatus <> 'A' THEN '"1"' END
                            END
        ,drvTermDt = CONVERT(VARCHAR(10), BdmBenStopDate, 126)
    INTO dbo.U_ECANSUNEXP_drvTbl_Benefits
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_Loader','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_Loader;
    SELECT DISTINCT
         drvPolicyNum = '103932'
        ,drvClientName = 'Audio Visual Services (Canada) Corp.'
        ,drvReportLanguageCd = '1'
    INTO dbo.U_ECANSUNEXP_Loader
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwECANSUNEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECANSUNEXP_File (NOLOCK)
    ORDER BY CASE LEFT(RecordSet,1) WHEN 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECANSUNEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107291'
       ,expStartPerControl     = '202107291'
       ,expLastEndPerControl   = '202108059'
       ,expEndPerControl       = '202108059'
WHERE expFormatCode = 'ECANSUNEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECANSUNEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECANSUNEXP_File (NOLOCK)
    ORDER BY CASE LEFT(RecordSet,1) WHEN 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, RecordSet, SubSort;