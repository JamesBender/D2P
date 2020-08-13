SET NOCOUNT ON;
IF OBJECT_ID('U_EMETLIFEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMETLIFEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMETLIFEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMETLIFEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMETLIFEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMETLIFEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETLIFEXP];
GO
IF OBJECT_ID('U_EMETLIFEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEXP_PEarHist];
GO
IF OBJECT_ID('U_EMETLIFEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEXP_PDedHist];
GO
IF OBJECT_ID('U_EMETLIFEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEXP_File];
GO
IF OBJECT_ID('U_EMETLIFEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEXP_EEList];
GO
IF OBJECT_ID('U_EMETLIFEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEXP_drvTbl];
GO
IF OBJECT_ID('U_EMETLIFEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EMETLIFEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMETLIFEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMETLIFEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMETLIFEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMETLIFEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMETLIFEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMETLIFEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMETLIFEXP','MetLife LTD/BL/AD&D/Dep/Vol','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMETLIFEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransactionCode"','1','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','1',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"5911460"','2','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','2',NULL,'Customer Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','3','(''UA''=''F'')','EMETLIFEXPZ0','11','D','10','9',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''F'')','EMETLIFEXPZ0','11','D','10','20',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EMETLIFEXPZ0','9','D','10','31',NULL,'Member Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''F'')','EMETLIFEXPZ0','20','D','10','40',NULL,'Member Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''F'')','EMETLIFEXPZ0','12','D','10','60',NULL,'Member First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','8','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','72',NULL,'Member Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','9','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','73',NULL,'Member Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','81',NULL,'Member Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','11','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','82',NULL,'Member Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','12','(''UA''=''F'')','EMETLIFEXPZ0','2','D','10','83',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeDateOfHire"','13','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','85',NULL,'Employee''s Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonalIdentification"','14','(''UA''=''F'')','EMETLIFEXPZ0','11','D','10','93',NULL,'Personnel Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','104',NULL,'Employee Smoker Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','105',NULL,'Spouse Smoker Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EMETLIFEXPZ0','22','D','10','106',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','128',NULL,'Survivor Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EMETLIFEXPZ0','9','D','10','129',NULL,'Survivor SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EMETLIFEXPZ0','20','D','10','138',NULL,'Survivor Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EMETLIFEXPZ0','12','D','10','158',NULL,'Survivor First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D"','22','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','170',NULL,'Foreign Address Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','EMETLIFEXPZ0','32','D','10','171',NULL,'Care of Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressStreet"','24','(''UA''=''F'')','EMETLIFEXPZ0','32','D','10','203',NULL,'Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','25','(''UA''=''F'')','EMETLIFEXPZ0','21','D','10','235',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','26','(''UA''=''F'')','EMETLIFEXPZ0','2','D','10','256',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','27','(''UA''=''F'')','EMETLIFEXPZ0','9','D','10','258',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','267',NULL,'Coverage Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','269',NULL,'Coverage Start Date - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','277',NULL,'Coverage Stop Date - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','285',NULL,'Group Number - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','292',NULL,'Subcode - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','296',NULL,'Branch - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','300',NULL,'Plan Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','302',NULL,'Status Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','303',NULL,'Members Covered Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','304',NULL,'Cancel Reason - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','306',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','307',NULL,'Facility ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EMETLIFEXPZ0','15','D','10','315',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode2"','41','(''UA''=''F'')','EMETLIFEXPZ0','2','D','10','330',NULL,'Coverage Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate2"','42','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','332',NULL,'Coverage Start Date - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate2"','43','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','340',NULL,'Coverage Stop Date - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber2"','44','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','348',NULL,'Group Number - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode2"','45','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','355',NULL,'Subcode - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch2"','46','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','359',NULL,'Branch - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','363',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode2"','48','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','365',NULL,'Status Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode2"','49','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','366',NULL,'Members Covered Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','367',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBenefitAmt2"','51','(''UA''=''F'')','EMETLIFEXPZ0','8','D','10','377',NULL,'Annual Benefit Amount - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode2"','52','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','385',NULL,'Salary Mode - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt2"','53','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','386',NULL,'Salary Amount - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode3"','54','(''UA''=''F'')','EMETLIFEXPZ0','2','D','10','393',NULL,'Coverage Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate3"','55','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','395',NULL,'Coverage Start Date - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate3"','56','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','403',NULL,'Coverage Stop Date - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber3"','57','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','411',NULL,'Group Number - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode3"','58','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','418',NULL,'Subcode - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch3"','59','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','422',NULL,'Branch - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','426',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode3"','61','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','428',NULL,'Status Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode3"','62','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','429',NULL,'Members Covered Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','430',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBenefitAmt3"','64','(''UA''=''F'')','EMETLIFEXPZ0','8','D','10','440',NULL,'Annual Benefit Amount - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode3"','65','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','448',NULL,'Salary Mode - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt3"','66','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','449',NULL,'Salary Amount - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode4"','67','(''UA''=''F'')','EMETLIFEXPZ0','2','D','10','456',NULL,'Coverage Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate4"','68','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','458',NULL,'Coverage Start Date - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate4"','69','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','466',NULL,'Coverage Stop Date - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber4"','70','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','474',NULL,'Group Number - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode4"','71','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','481',NULL,'Subcode - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch4"','72','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','485',NULL,'Branch - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','489',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode4"','74','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','491',NULL,'Status Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode4"','75','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','492',NULL,'Members Covered Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','493',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMonthlyBenefitAmt4"','77','(''UA''=''F'')','EMETLIFEXPZ0','8','D','10','503',NULL,'Monthly Benefit Amount - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode4"','78','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','511',NULL,'Salary Mode - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt4"','79','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','512',NULL,'Salary Amount - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','519',NULL,'Coverage Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','521',NULL,'Coverage Start Date - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','529',NULL,'Coverage Stop Date - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','537',NULL,'Group Number - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','544',NULL,'Subcode - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','548',NULL,'Branch - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','552',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','554',NULL,'Status Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','555',NULL,'Members Covered Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','556',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','566',NULL,'Weekly Benefit Amount - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','574',NULL,'Salary Mode - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','575',NULL,'Salary Amount - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode6"','93','(''UA''=''F'')','EMETLIFEXPZ0','2','D','10','582',NULL,'Coverage Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate6"','94','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','584',NULL,'Coverage Start Date - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate6"','95','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','592',NULL,'Coverage Stop Date - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber6"','96','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','600',NULL,'Group Number - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode6"','97','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','607',NULL,'Subcode - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch6"','98','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','611',NULL,'Branch - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','615',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode6"','100','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','617',NULL,'Status Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode6"','101','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','618',NULL,'Members Covered Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','619',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBenefitAmt6"','103','(''UA''=''F'')','EMETLIFEXPZ0','8','D','10','629',NULL,'Annual Benefit Amount - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','637',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode7"','105','(''UA''=''F'')','EMETLIFEXPZ0','2','D','10','645',NULL,'Coverage Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate7"','106','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','647',NULL,'Coverage Start Date - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate7"','107','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','655',NULL,'Coverage Stop Date - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber7"','108','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','663',NULL,'Group Number - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode7"','109','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','670',NULL,'Subcode - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch7"','110','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','674',NULL,'Branch - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','678',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode7"','112','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','680',NULL,'Status Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode7"','113','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','681',NULL,'Members Covered Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','682',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBenefitAmt7"','115','(''UA''=''F'')','EMETLIFEXPZ0','8','D','10','692',NULL,'Annual Benefit Amount - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode7"','116','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','700',NULL,'Salary Mode - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt7"','117','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','701',NULL,'Salary Amount - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','118','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','708',NULL,'Coverage Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','119','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','710',NULL,'Coverage Start Date - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','120','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','718',NULL,'Coverage Stop Date - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','121','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','726',NULL,'Group Number - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','122','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','733',NULL,'Subcode - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','123','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','737',NULL,'Branch - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','124','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','741',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','125','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','743',NULL,'Status Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','126','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','744',NULL,'Members Covered Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','127','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','745',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','128','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','755',NULL,'Annual Benefit Amount - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','763',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','771',NULL,'Coverage Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','773',NULL,'Coverage Start Date - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','781',NULL,'Coverage Stop Date - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','789',NULL,'Group Number - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','796',NULL,'Subcode - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','800',NULL,'Branch - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','804',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','806',NULL,'Status Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','807',NULL,'Members Covered Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','808',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','818',NULL,'Annual Benefit Amount - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','826',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode10"','142','(''UA''=''F'')','EMETLIFEXPZ0','2','D','10','834',NULL,'Coverage Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStartDate10"','143','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','836',NULL,'Coverage Start Date - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStopDate11"','144','(''UDMDY''=''F'')','EMETLIFEXPZ0','8','D','10','844',NULL,'Coverage Stop Date - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber10"','145','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','852',NULL,'Group Number - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubCode10"','146','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','859',NULL,'Subcode - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch10"','147','(''UA''=''F'')','EMETLIFEXPZ0','4','D','10','863',NULL,'Branch - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','867',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode10"','149','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','869',NULL,'Status Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMembersCoveredCode10"','150','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','870',NULL,'Members Covered Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','871',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBenefitAmt10"','152','(''UA''=''F'')','EMETLIFEXPZ0','8','D','10','881',NULL,'Annual Benefit Amount - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode10"','153','(''UA''=''F'')','EMETLIFEXPZ0','1','D','10','889',NULL,'Salary Mode - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt10"','154','(''UA''=''F'')','EMETLIFEXPZ0','7','D','10','890',NULL,'Salary Amount - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','897',NULL,'Coverage Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','156','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','899',NULL,'Coverage Start Date - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','907',NULL,'Coverage Stop Date - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','158','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','915',NULL,'Group Number - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','159','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','922',NULL,'Subcode - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','160','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','926',NULL,'Branch - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','930',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','162','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','932',NULL,'Status Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','163','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','933',NULL,'Members Covered Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','164','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','934',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','165','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','944',NULL,'Annual Benefit Amount - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','166','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','952',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','167','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','960',NULL,'Coverage Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','168','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','962',NULL,'Coverage Start Date - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','169','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','970',NULL,'Coverage Stop Date - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','170','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','978',NULL,'Group Number - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','171','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','985',NULL,'Subcode - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','172','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','989',NULL,'Branch - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','993',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','174','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','995',NULL,'Status Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','175','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','996',NULL,'Members Covered Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','176','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','997',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1007',NULL,'Annual Benefit Amount - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','178','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1015',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1023',NULL,'Coverage Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1025',NULL,'Coverage Start Date - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','181','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1033',NULL,'Coverage Stop Date - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1041',NULL,'Group Number - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1048',NULL,'Subcode - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1052',NULL,'Branch - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1056',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1058',NULL,'Status Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','187','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1059',NULL,'Members Covered Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','188','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','1060',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','189','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1070',NULL,'Annual Benefit Amount - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','190','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1078',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','191','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1086',NULL,'Coverage Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','192','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1088',NULL,'Coverage Start Date - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','193','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1096',NULL,'Coverage Stop Date - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','194','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1104',NULL,'Group Number - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','195','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1111',NULL,'Subcode - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','196','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1115',NULL,'Branch - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','197','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1119',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','198','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1121',NULL,'Status Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','199','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1122',NULL,'Members Covered Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','200','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','1123',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','201','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1133',NULL,'Annual Benefit Amount - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','202','(''DA''=''F'')','EMETLIFEXPZ0','12','D','10','1141',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','203','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1153',NULL,'Coverage Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','204','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1155',NULL,'Coverage Start Date - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','205','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1163',NULL,'Coverage Stop Date - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','206','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1171',NULL,'Group Number - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','207','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1178',NULL,'Subcode - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','208','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1182',NULL,'Branch - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','209','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1186',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','210','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1188',NULL,'Status Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','211','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1189',NULL,'Members Covered Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','212','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','1190',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','213','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1200',NULL,'Annual Benefit Amount - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','214','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1208',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','215','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1216',NULL,'Coverage Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','216','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1218',NULL,'Coverage Start Date - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','217','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1226',NULL,'Coverage Stop Date - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','218','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1234',NULL,'Group Number - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','219','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1241',NULL,'Subcode - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','220','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1245',NULL,'Branch - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','221','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1249',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','222','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1251',NULL,'Status Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','223','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1252',NULL,'Members Covered Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','224','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','1253',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','225','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1263',NULL,'Annual Benefit Amount - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','226','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1271',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','227','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1279',NULL,'Coverage Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','228','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1281',NULL,'Coverage Start Date - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','229','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1289',NULL,'Coverage Stop Date - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','230','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1297',NULL,'Group Number - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','231','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1304',NULL,'Subcode - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','232','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1308',NULL,'Branch - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','233','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1312',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','234','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1314',NULL,'Status Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','235','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1315',NULL,'Members Covered Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','236','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1316',NULL,'Cancel Reason - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','237','(''DA''=''F'')','EMETLIFEXPZ0','23','D','10','1318',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','238','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1341',NULL,'Employee Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','239','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1342',NULL,'Status Code Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentCode"','240','(''UA''=''F'')','EMETLIFEXPZ0','10','D','10','1350',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','241','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','1360',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','242','(''DA''=''F'')','EMETLIFEXPZ0','5','D','10','1370',NULL,'Location ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','243','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','1375',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','244','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1385',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','245','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1387',NULL,'Coverage Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','246','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1389',NULL,'Coverage Start Date - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','247','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1397',NULL,'Coverage Stop Date - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','248','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1405',NULL,'Group Number - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','249','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1412',NULL,'Subcode - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','250','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1416',NULL,'Branch - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','251','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1420',NULL,'Status Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','252','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1421',NULL,'Members Covered Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','253','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1422',NULL,'Enrollment Status - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','254','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1423',NULL,'Coverage Code - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','255','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1425',NULL,'Coverage Start Date - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','256','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1433',NULL,'Coverage Stop Date - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','257','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1441',NULL,'Group Number - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','258','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1448',NULL,'Subcode - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','259','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1452',NULL,'Branch - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','260','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1456',NULL,'Members Covered Code - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','261','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1457',NULL,'Enrollment Status - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','262','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1458',NULL,'Benefit Amount - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','263','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1466',NULL,'Voluntary Cancellation Ind - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','264','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1468',NULL,'Taveover Indicator - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','265','(''DA''=''F'')','EMETLIFEXPZ0','9','D','10','1469',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','266','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1478',NULL,'Coverage Code - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','267','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1480',NULL,'Coverage Start Date - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','268','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1488',NULL,'Coverage Stop Date - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','269','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1496',NULL,'Group Number - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','270','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1503',NULL,'Subcode - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','271','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1507',NULL,'Branch - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','272','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1511',NULL,'Members Covered Code - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','273','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1512',NULL,'Enrollment Status - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','274','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1513',NULL,'Benefit Amount - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','1521',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1531',NULL,'Coverage Code - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1533',NULL,'Coverage Start Date - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','278','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1541',NULL,'Coverage Stop Date - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1549',NULL,'Group Number - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','280','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1556',NULL,'Subcode - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','281','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1560',NULL,'Branch - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','282','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1564',NULL,'Members Covered Code - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','283','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1565',NULL,'Enrollment Status - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','284','(''DA''=''F'')','EMETLIFEXPZ0','3','D','10','1566',NULL,'GPC Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','285','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1569',NULL,'Paypoint',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','286','(''DA''=''F'')','EMETLIFEXPZ0','3','D','10','1571',NULL,'Payroll Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','287','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1574',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','288','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1576',NULL,'Coverage Code - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','289','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1578',NULL,'Coverage Start Date - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','290','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1586',NULL,'Coverage Stop Date - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','291','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1594',NULL,'Group Number - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','292','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1601',NULL,'Subcode - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','293','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1605',NULL,'Branch - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','294','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1609',NULL,'Members Covered Code - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','295','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1610',NULL,'Enrollment Status - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','296','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1611',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','297','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1613',NULL,'Coverage Code - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','298','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1615',NULL,'Coverage Start Date - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','299','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1623',NULL,'Coverage Stop Date - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','300','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1631',NULL,'Group Number - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','301','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1638',NULL,'Subcode - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','302','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1642',NULL,'Branch - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','303','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1646',NULL,'Members Covered Code - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','304','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1647',NULL,'Enrollment Status - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','305','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1648',NULL,'Voluntary Cancellation Ind - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','306','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1650',NULL,'Takeover Indicator - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','307','(''DA''=''F'')','EMETLIFEXPZ0','9','D','10','1651',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','308','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1660',NULL,'Coverage Code - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','309','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1662',NULL,'Coverage Start Date - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','310','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1670',NULL,'Coverage Stop Date - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','311','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1678',NULL,'Group Number - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','312','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1685',NULL,'Subcode - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','313','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1689',NULL,'Branch - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','314','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1693',NULL,'Members Covered Code - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','315','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1694',NULL,'Enrollment Status - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','316','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1695',NULL,'Voluntary Cancellation Ind - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','317','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1697',NULL,'Takeover Indicator - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','318','(''DA''=''F'')','EMETLIFEXPZ0','9','D','10','1698',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','319','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1707',NULL,'Coverage Code - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','320','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1709',NULL,'Coverage Start Date - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','321','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1717',NULL,'Coverage Stop Date - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','322','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1725',NULL,'Group Number - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','323','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1732',NULL,'Subcode - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','324','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1736',NULL,'Branch - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','325','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1740',NULL,'Members Covered Code - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','326','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1741',NULL,'Enrollment Status - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','327','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','1742',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','328','(''DA''=''F'')','EMETLIFEXPZ0','95','D','10','1752',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','329','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1847',NULL,'Coverage Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','330','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1849',NULL,'Coverage Start Date - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','331','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1857',NULL,'Coverage Stop Date - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','332','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1865',NULL,'Group Number - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','333','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1872',NULL,'Subcode - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','334','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1876',NULL,'Branch - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','335','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1880',NULL,'Status Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','336','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1881',NULL,'Members Covered Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','337','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1882',NULL,'Benefit Amount - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','338','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1890',NULL,'Takeover Indicator - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','339','(''DA''=''F'')','EMETLIFEXPZ0','10','D','10','1891',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','340','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1901',NULL,'Coverage Code - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','341','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1903',NULL,'Coverage Start Date - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','342','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1911',NULL,'Coverage Stop Date - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','343','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1919',NULL,'Group Number - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','344','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1926',NULL,'Subcode - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','345','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1930',NULL,'Branch - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','346','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1934',NULL,'Members Covered Code - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','347','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1935',NULL,'Enrollment Status - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','348','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1936',NULL,'Benefit Amount - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','349','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1944',NULL,'Voluntary Cancellation Ind - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','350','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1946',NULL,'Takeover Indicator - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','351','(''DA''=''F'')','EMETLIFEXPZ0','9','D','10','1947',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','352','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1956',NULL,'Coverage Code - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','353','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1958',NULL,'Coverage Start Date - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','354','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1966',NULL,'Coverage Stop Date - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','355','(''DA''=''F'')','EMETLIFEXPZ0','7','D','10','1974',NULL,'Group Number - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','356','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1981',NULL,'Subcode - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','357','(''DA''=''F'')','EMETLIFEXPZ0','4','D','10','1985',NULL,'Branch - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','358','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1989',NULL,'Members Covered Code - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','359','(''DA''=''F'')','EMETLIFEXPZ0','1','D','10','1990',NULL,'Enrollment Status - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','360','(''DA''=''F'')','EMETLIFEXPZ0','8','D','10','1991',NULL,'Benefit Amount - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','361','(''DA''=''F'')','EMETLIFEXPZ0','2','D','10','1999',NULL,'Filler',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFEXP_20200810.txt',NULL,'','','',NULL,NULL,NULL,'MetLife LTD/BL/AD&D/Dep/Vol','202007319','EMPEXPORT','ONDEMAND','Jun 10 2020  9:23AM','EMETLIFEXP',NULL,NULL,NULL,'202007319','Jun  4 2020 11:39AM','Jun  4 2020 11:39AM','202005281','342','','','202005281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFEXP_20200810.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202007319','EMPEXPORT','SCHEDULED','Jun 10 2020  9:23AM','EMETLIFEXP',NULL,NULL,NULL,'202007319','Jun  4 2020 11:39AM','Jun  4 2020 11:39AM','202005281','342','','','202005281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFEXP_20200810.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202007319','EMPEXPORT','OEACTIVE','Jun 10 2020  9:22AM','EMETLIFEXP',NULL,NULL,NULL,'202007319','Jun  4 2020 11:39AM','Jun  4 2020 11:39AM','202005281','0','','','202005281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFEXP_20200810.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202007319','EMPEXPORT','OEPASSIVE','Jun 10 2020  9:23AM','EMETLIFEXP',NULL,NULL,NULL,'202007319','Jun  4 2020 11:39AM','Jun  4 2020 11:39AM','202005281','342','','','202005281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFEXP_20200810.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202007319','EMPEXPORT','TEST','Jul 30 2020  2:51PM','EMETLIFEXP',NULL,NULL,NULL,'202007319','Jul 30 2020 12:00AM','Dec 30 1899 12:00AM','202005281','340','','','202005281',dbo.fn_GetTimedKey(),NULL,'us3lKiUNI1088',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EMETLIFEXP_20200810.txt' END WHERE expFormatCode = 'EMETLIFEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EMETLIFEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMETLIFEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EMETLIFEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLIFEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLIFEXP','D10','dbo.U_EMETLIFEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EMETLIFEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMETLIFEXP] (
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
IF OBJECT_ID('U_EMETLIFEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EMETLIFEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvTransactionCode] varchar(1) NOT NULL,
    [drvEmployeeNumber] varchar(8000) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvGender] char(1) NULL,
    [drvRelationshipCode] varchar(2) NOT NULL,
    [drvEmployeDateOfHire] datetime NULL,
    [drvPersonalIdentification] varchar(1) NOT NULL,
    [drvAddressStreet] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCoverageCode2] varchar(2) NULL,
    [drvCoverageStartDate2] datetime NULL,
    [drvCoverageStopDate2] datetime NULL,
    [drvGroupNumber2] varchar(7) NULL,
    [drvSubcode2] varchar(4) NULL,
    [drvBranch2] varchar(4) NULL,
    [drvStatusCode2] varchar(1) NULL,
    [drvMembersCoveredCode2] varchar(1) NULL,
    [drvAnnualBenefitAmt2] nvarchar(8) NULL,
    [drvSalaryMode2] varchar(1) NULL,
    [drvSalaryAmt2] nvarchar(7) NULL,
    [drvCoverageCode3] varchar(2) NULL,
    [drvCoverageStartDate3] datetime NULL,
    [drvCoverageStopDate3] datetime NULL,
    [drvGroupNumber3] varchar(7) NULL,
    [drvSubcode3] varchar(4) NULL,
    [drvBranch3] varchar(4) NULL,
    [drvStatusCode3] varchar(1) NULL,
    [drvMembersCoveredCode3] varchar(1) NULL,
    [drvAnnualBenefitAmt3] nvarchar(8) NULL,
    [drvSalaryMode3] varchar(1) NULL,
    [drvSalaryAmt3] nvarchar(7) NULL,
    [drvCoverageCode4] varchar(2) NULL,
    [drvCoverageStartDate4] datetime NULL,
    [drvCoverageStopDate4] datetime NULL,
    [drvGroupNumber4] varchar(7) NULL,
    [drvSubcode4] varchar(4) NULL,
    [drvBranch4] varchar(4) NULL,
    [drvStatusCode4] varchar(1) NULL,
    [drvMembersCoveredCode4] varchar(1) NULL,
    [drvMonthlyBenefitAmt4] nvarchar(8) NULL,
    [drvSalaryMode4] varchar(1) NULL,
    [drvSalaryAmt4] nvarchar(7) NULL,
    [drvCoverageCode6] varchar(2) NULL,
    [drvCoverageStartDate6] datetime NULL,
    [drvCoverageStopDate6] datetime NULL,
    [drvGroupNumber6] varchar(7) NULL,
    [drvSubcode6] varchar(4) NULL,
    [drvBranch6] varchar(4) NULL,
    [drvStatusCode6] varchar(1) NULL,
    [drvMembersCoveredCode6] varchar(1) NULL,
    [drvAnnualBenefitAmt6] nvarchar(8) NULL,
    [drvCoverageCode7] varchar(2) NULL,
    [drvCoverageStartDate7] datetime NULL,
    [drvCoverageStopDate7] datetime NULL,
    [drvGroupNumber7] varchar(7) NULL,
    [drvSubcode7] varchar(4) NULL,
    [drvBranch7] varchar(4) NULL,
    [drvStatusCode7] varchar(1) NULL,
    [drvMembersCoveredCode7] varchar(1) NULL,
    [drvAnnualBenefitAmt7] nvarchar(8) NULL,
    [drvSalaryMode7] varchar(1) NULL,
    [drvSalaryAmt7] nvarchar(7) NULL,
    [drvCoverageCode10] varchar(2) NULL,
    [drvCoverageStartDate10] datetime NULL,
    [drvCoverageStopDate11] datetime NULL,
    [drvGroupNumber10] varchar(7) NULL,
    [drvSubCode10] varchar(4) NULL,
    [drvBranch10] varchar(4) NULL,
    [drvStatusCode10] varchar(1) NULL,
    [drvMembersCoveredCode10] varchar(1) NULL,
    [drvAnnualBenefitAmt10] nvarchar(8) NULL,
    [drvSalaryMode10] varchar(1) NULL,
    [drvSalaryAmt10] nvarchar(7) NULL,
    [drvDepartmentCode] varchar(8) NULL
);
IF OBJECT_ID('U_EMETLIFEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMETLIFEXP_File') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);
IF OBJECT_ID('U_EMETLIFEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEXP_PDedHist] (
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
IF OBJECT_ID('U_EMETLIFEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETLIFEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: United Prairie Bank

Created By: James Bender
Business Analyst: Lea King
Create Date: 06/04/2020f
Service Request Number: TekP-2020-03-10-0007

Purpose: MetLife LTD/BL/AD&D/Dep/Vol

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMETLIFEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMETLIFEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMETLIFEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMETLIFEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMETLIFEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFEXP', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMETLIFEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMETLIFEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMETLIFEXP';

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
    DELETE FROM dbo.U_EMETLIFEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMETLIFEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EMETLIFEXP_EEList where xEEID IN (
        SELECT DISTINCT EecEEID FROM  dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN('TES')
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '295,417,418,419,420,421,422,561,562';

    IF OBJECT_ID('U_EMETLIFEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMETLIFEXP_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EmployeeElectedRateorPct',@DedList);

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
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMETLIFEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFEXP_PDedHist;
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
    INTO dbo.U_EMETLIFEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMETLIFEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EMETLIFEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EMETLIFEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMETLIFEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMETLIFEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvTransactionCode = CASE WHEN BdmRecType = 'EMP' THEN 'E' ELSE 'D' END
        ,drvEmployeeNumber = '00' + REPLACE(EepSSN, ' ','')
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddle = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvMaritalStatus = eepMaritalStatus
        ,drvGender = EepGender
        ,drvRelationshipCode =    CASE WHEN ConRelationship IN ('DP', 'SPS') THEN '01'
                                    WHEN ConRelationship IN ('CHL', 'STC', 'DPC', 'DCH') THEN '02'
                                    ELSE '00'
                                END
        ,drvEmployeDateOfHire = EecDateOfLastHire
        ,drvPersonalIdentification = '' -- EecEmpNo
        ,drvAddressStreet = REPLACE(ISNULL(EepAddressLine1, '') + ' ' + ISNULL(EepAddressLine2, ''), ',', '')
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvCoverageCode2 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN 'CP' END
        ,drvCoverageStartDate2 =    CASE WHEN DedCode_417 IS NOT NULL THEN DedStartDate_417
                                        WHEN DedCode_418 IS NOT NULL THEN DedStartDate_418 
                                    END
        ,drvCoverageStopDate2 =    CASE WHEN DedCode_417 IS NOT NULL THEN DedStopDate_417
                                    WHEN DedCode_418 IS NOT NULL THEN DedStopDate_418 
                                END
        ,drvGroupNumber2 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN '5911460' END
        ,drvSubcode2 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN '0001' END
        ,drvBranch2 =    CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN
                            CASE WHEN EecUDField05 = 'Officer' THEN '0001'
                                WHEN EecUDField05 = 'Non-Officer' THEN '0002'
                                WHEN EecUDField05 = 'Executive Officer' THEN '0003'
                                WHEN EecUDField05 = 'Grandfathered Officer' THEN '0004'
                            END
                        END
        ,drvStatusCode2 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode2 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN '1' END
        ,drvAnnualBenefitAmt2 =    CASE WHEN DedCode_417 IS NOT NULL THEN RIGHT('00000000' + FORMAT(PdhBenAmt_417, '#0'), 8)
                                    WHEN DedCode_418 IS NOT NULL THEN RIGHT('00000000' + FORMAT(BcaBenAmtRateOrPct*EecAnnSalary, '#0') , 8)
                                END
        ,drvSalaryMode2 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN 'A' END
        ,drvSalaryAmt2 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN RIGHT('0000000' + FORMAT(EecAnnSalary, '#0'), 7) END


        ,drvCoverageCode3 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN 'AD' END
        ,drvCoverageStartDate3 = CASE WHEN DedCode_417 IS NOT NULL THEN DedStartDate_417
                                        WHEN DedCode_418 IS NOT NULL THEN DedStartDate_418 
                                    END
        ,drvCoverageStopDate3 =    CASE WHEN DedCode_417 IS NOT NULL THEN DedStopDate_417
                                    WHEN DedCode_418 IS NOT NULL THEN DedStopDate_418 
                                END
        ,drvGroupNumber3 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN '5911460' END
        ,drvSubcode3 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN '0001' END
        ,drvBranch3 =    CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN
                            CASE WHEN EecUDField05 = 'Officer' THEN '0001'
                                WHEN EecUDField05 = 'Non-Officer' THEN '0002'
                                WHEN EecUDField05 = 'Executive Officer' THEN '0003'
                                WHEN EecUDField05 = 'Grandfathered Officer' THEN '0004'
                            END
                        END
        ,drvStatusCode3 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode3 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN '1' END
        ,drvAnnualBenefitAmt3 = CASE WHEN DedCode_417 IS NOT NULL THEN RIGHT('00000000' + FORMAT(PdhBenAmt_417, '#0'), 8)
                                    WHEN DedCode_418 IS NOT NULL THEN RIGHT('00000000' + FORMAT(BcaBenAmtRateOrPct*EecAnnSalary, '#0'), 8)
                                END
        ,drvSalaryMode3 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN 'A' END
        ,drvSalaryAmt3 = CASE WHEN DedCode_417 IS NOT NULL OR DedCode_418 IS NOT NULL THEN RIGHT('0000000' + FORMAT(EecAnnSalary, '#0'), 7) END


        ,drvCoverageCode4 = CASE WHEN DedCode_295 IS NOT NULL OR DedCode_561 IS NOT NULL OR DedCode_562 IS NOT NULL THEN 'LT' END
        ,drvCoverageStartDate4 =    CASE WHEN DedCode_295 IS NOT NULL THEN DedStartDate_295 
                                        WHEN DedCode_561 IS NOT NULL THEN DedStartDate_561 
                                        WHEN DedCode_562 IS NOT NULL THEN DedStartDate_562
                                    END
        ,drvCoverageStopDate4 =    CASE WHEN DedCode_295 IS NOT NULL THEN DedStopDate_295 
                                    WHEN DedCode_561 IS NOT NULL THEN DedStopDate_561
                                    WHEN DedCode_562 IS NOT NULL THEN DedStopDate_562
                                END
        ,drvGroupNumber4 = CASE WHEN DedCode_295 IS NOT NULL OR DedCode_561 IS NOT NULL OR DedCode_562 IS NOT NULL THEN '5911460' END
        ,drvSubcode4 = CASE WHEN DedCode_295 IS NOT NULL OR DedCode_561 IS NOT NULL OR DedCode_562 IS NOT NULL THEN '0001' END
        ,drvBranch4 =    CASE WHEN DedCode_295 IS NOT NULL OR DedCode_561 IS NOT NULL OR DedCode_562 IS NOT NULL THEN
                            CASE WHEN EecUDField05 = 'Officer' THEN '0001'
                                WHEN EecUDField05 = 'Non-Officer' THEN '0002'
                                WHEN EecUDField05 = 'Executive Officer' THEN '0003'
                            END
                        END
        ,drvStatusCode4 = CASE WHEN DedCode_295 IS NOT NULL OR DedCode_561 IS NOT NULL OR DedCode_562 IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode4 = CASE WHEN DedCode_295 IS NOT NULL OR DedCode_561 IS NOT NULL OR DedCode_562 IS NOT NULL THEN '1' END
        ,drvMonthlyBenefitAmt4 = CASE WHEN DedCode_295 IS NOT NULL OR DedCode_561 IS NOT NULL OR DedCode_562 IS NOT NULL THEN RIGHT('00000000' + FORMAT(ROUND(EecAnnSalary/12, 0, 1), '#0'),8) END
        ,drvSalaryMode4 = CASE WHEN DedCode_295 IS NOT NULL OR DedCode_561 IS NOT NULL OR DedCode_562 IS NOT NULL THEN 'A' END
        ,drvSalaryAmt4 = CASE WHEN DedCode_295 IS NOT NULL OR DedCode_561 IS NOT NULL OR DedCode_562 IS NOT NULL THEN RIGHT('0000000' + FORMAT(EecAnnSalary, '#0'), 7) END


        ,drvCoverageCode6 = CASE WHEN DedCode_421 IS NOT NULL OR DedCode_422 IS NOT NULL THEN 'DL' END
        ,drvCoverageStartDate6 =    CASE WHEN DedCode_421 IS NOT NULL THEN DedStartDate_421
                                        WHEN DedCode_422 IS NOT NULL THEN DedStartDate_422
                                    END
        ,drvCoverageStopDate6 = CASE WHEN DedCode_421 IS NOT NULL THEN DedStopDate_421
                                    WHEN DedCode_422 IS NOT NULL THEN DedStopDate_422
                                END
        ,drvGroupNumber6 = CASE WHEN DedCode_421 IS NOT NULL OR DedCode_422 IS NOT NULL THEN '5911460' END
        ,drvSubcode6 = CASE WHEN DedCode_421 IS NOT NULL OR DedCode_422 IS NOT NULL THEN '0001' END
        ,drvBranch6 =    CASE WHEN DedCode_421 IS NOT NULL OR DedCode_422 IS NOT NULL THEN
                            CASE WHEN EecUDField05 = 'Officer' THEN '0001'
                                WHEN EecUDField05 = 'Non-Officer' THEN '0002'
                                WHEN EecUDField05 = 'Executive Officer' THEN '0003'
                                WHEN EecUDField05 = 'Grandfathered Officer' THEN '0004'
                            END
                        END
        ,drvStatusCode6 = CASE WHEN DedCode_421 IS NOT NULL OR DedCode_422 IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode6 =    CASE WHEN DedCode_421 IS NOT NULL AND DedCode_422 IS NULL THEN 'A'
                                        WHEN DedCode_421 IS NOT NULL AND DedCode_422 IS NOT NULL THEN '6'
                                        WHEN DedCode_421 IS NULL AND DedCode_422 IS NOT NULL THEN 'C'
                                    END
        ,drvAnnualBenefitAmt6 =    CASE WHEN DedCode_421 IS NOT NULL AND ConRelationship IN ('DP', 'SPS') THEN RIGHT('00000000' + FORMAT(ROUND(BenAmt_421, 0, 1), '#0'), 8)
                                    WHEN DedCode_422 IS NOT NULL AND ConRelationship IN ('CHL', 'STC', 'DPC', 'DCH') THEN RIGHT('00000000' + FORMAT(ROUND(BenAmt_422, 0, 1), '#0'), 8)
                                END


        ,drvCoverageCode7 = CASE WHEN DedCode_420 IS NOT NULL THEN 'OP' END
        ,drvCoverageStartDate7 = CASE WHEN DedCode_420 IS NOT NULL THEN DedStartDate_420 END
        ,drvCoverageStopDate7 = CASE WHEN DedCode_420 IS NOT NULL THEN DedStopDate_420 END
        ,drvGroupNumber7 = CASE WHEN DedCode_420 IS NOT NULL THEN '5911460' END
        ,drvSubcode7 = CASE WHEN DedCode_420 IS NOT NULL THEN '0001' END
        ,drvBranch7 =    CASE WHEN DedCode_420 IS NOT NULL THEN
                            CASE WHEN EecUDField05 = 'Officer' THEN '0001'
                                WHEN EecUDField05 = 'Non-Officer' THEN '0002'
                                WHEN EecUDField05 = 'Executive Officer' THEN '0003'
                                WHEN EecUDField05 = 'Grandfathered Officer' THEN '0004'
                            END
                        END
        ,drvStatusCode7 = CASE WHEN DedCode_420 IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode7 = CASE WHEN DedCode_420 IS NOT NULL THEN '1' END
        ,drvAnnualBenefitAmt7 = CASE WHEN DedCode_420 IS NOT NULL THEN RIGHT('00000000' + FORMAT(ROUND(BenAmt_420, 0, 1), '#0'), 8) END
        ,drvSalaryMode7 = CASE WHEN DedCode_420 IS NOT NULL THEN 'A' END
        ,drvSalaryAmt7 = CASE WHEN DedCode_420 IS NOT NULL THEN RIGHT('0000000' + FORMAT(EecAnnSalary, '#0'), 7) END


        ,drvCoverageCode10 = CASE WHEN DedCode_420 IS NOT NULL THEN 'OD' END
        ,drvCoverageStartDate10 = CASE WHEN DedCode_420 IS NOT NULL THEN DedStartDate_420 END
        ,drvCoverageStopDate11 = CASE WHEN DedCode_420 IS NOT NULL THEN DedStopDate_420 END
        ,drvGroupNumber10 = CASE WHEN DedCode_420 IS NOT NULL THEN '5911460' END
        ,drvSubCode10 = CASE WHEN DedCode_420 IS NOT NULL THEN '0001' END
        ,drvBranch10 =    CASE WHEN DedCode_420 IS NOT NULL THEN
                            CASE WHEN EecUDField05 = 'Officer' THEN '0001'
                                WHEN EecUDField05 = 'Non-Officer' THEN '0002'
                                WHEN EecUDField05 = 'Executive Officer' THEN '0003'
                            END
                        END
        ,drvStatusCode10 = CASE WHEN DedCode_420 IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCode10 = CASE WHEN DedCode_420 IS NOT NULL THEN '1' END
        ,drvAnnualBenefitAmt10 = CASE WHEN DedCode_420 IS NOT NULL THEN RIGHT('00000000' + FORMAT(BenAmt_420, '#0'), 8) END
        ,drvSalaryMode10 = CASE WHEN DedCode_420 IS NOT NULL THEN 'A' END
        ,drvSalaryAmt10 = CASE WHEN DedCode_420 IS NOT NULL THEN RIGHT('0000000' + FORMAT(EecAnnSalary, '#0'), 7) END


        ,drvDepartmentCode =    CASE WHEN EecLocation IN ('01') THEN 'MtLake'
                                    WHEN EecLocation IN ('05') THEN 'Wilmont'
                                    WHEN EecLocation IN ('08') THEN 'Jackson'
                                    WHEN EecLocation IN ('09') THEN 'Spicer'
                                    WHEN EecLocation IN ('10') THEN 'Madison'
                                    WHEN EecLocation IN ('11') THEN 'NewUlm'
                                    WHEN EecLocation IN ('12') THEN 'Owatonna'
                                    WHEN EecLocation IN ('13') THEN 'Waseca'
                                    WHEN EecLocation IN ('14') THEN 'Hilltop'
                                    WHEN EecLocation IN ('50', '51','52','53','55','56','58','59','60','61','62','64','65','66') THEN  'Insuranc'
                                    WHEN EecLocation IN ('71') THEN 'Fi/OP/IT'
                                    WHEN EecLocation IN ('72') THEN 'HR'
                                    WHEN EecLocation IN ('73') THEN 'LoanAdmi'
                                    WHEN EecLocation IN ('74') THEN 'Marketin'
                                    WHEN EecLocation IN ('83') THEN 'Administ'
                                    WHEN EecLocation IN ('84') THEN 'Investme'
                                END
    INTO dbo.U_EMETLIFEXP_drvTbl
    FROM dbo.U_EMETLIFEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmRecType, BdmDepRecID
            ,MAX(CASE WHEN BdmDedCode = '295' THEN BdmDedCode END) AS DedCode_295
            ,MAX(CASE WHEN BdmDedCode = '417' THEN BdmDedCode END) AS DedCode_417
            ,MAX(CASE WHEN BdmDedCode = '418' THEN BdmDedCode END) AS DedCode_418
            ,MAX(CASE WHEN BdmDedCode = '419' THEN BdmDedCode END) AS DedCode_419
            ,MAX(CASE WHEN BdmDedCode = '420' THEN BdmDedCode END) AS DedCode_420
            ,MAX(CASE WHEN BdmDedCode = '421' THEN BdmDedCode END) AS DedCode_421
            ,MAX(CASE WHEN BdmDedCode = '422' THEN BdmDedCode END) AS DedCode_422

            ,MAX(CASE WHEN BdmDedCode = '561' THEN BdmDedCode END) AS DedCode_561
            ,MAX(CASE WHEN BdmDedCode = '562' THEN BdmDedCode END) AS DedCode_562

            ,MAX(CASE WHEN BdmDedCode = '295' THEN BdmBenStartDate END) AS DedStartDate_295
            ,MAX(CASE WHEN BdmDedCode = '417' THEN BdmBenStartDate END) AS DedStartDate_417
            ,MAX(CASE WHEN BdmDedCode = '418' THEN BdmBenStartDate END) AS DedStartDate_418
            ,MAX(CASE WHEN BdmDedCode = '419' THEN BdmBenStartDate END) AS DedStartDate_419
            ,MAX(CASE WHEN BdmDedCode = '420' THEN BdmBenStartDate END) AS DedStartDate_420
            ,MAX(CASE WHEN BdmDedCode = '421' THEN BdmBenStartDate END) AS DedStartDate_421
            ,MAX(CASE WHEN BdmDedCode = '422' THEN BdmBenStartDate END) AS DedStartDate_422

            ,MAX(CASE WHEN BdmDedCode = '561' THEN BdmBenStartDate END) AS DedStartDate_561
            ,MAX(CASE WHEN BdmDedCode = '562' THEN BdmBenStartDate END) AS DedStartDate_562
    
            ,MAX(CASE WHEN BdmDedCode = '295' THEN BdmBenStopDate END) AS DedStopDate_295
            ,MAX(CASE WHEN BdmDedCode = '417' THEN BdmBenStopDate END) AS DedStopDate_417
            ,MAX(CASE WHEN BdmDedCode = '418' THEN BdmBenStopDate END) AS DedStopDate_418
            ,MAX(CASE WHEN BdmDedCode = '419' THEN BdmBenStopDate END) AS DedStopDate_419
            ,MAX(CASE WHEN BdmDedCode = '420' THEN BdmBenStopDate END) AS DedStopDate_420
            ,MAX(CASE WHEN BdmDedCode = '421' THEN BdmBenStopDate END) AS DedStopDate_421
            ,MAX(CASE WHEN BdmDedCode = '422' THEN BdmBenStopDate END) AS DedStopDate_422
            
            ,MAX(CASE WHEN BdmDedCode = '561' THEN BdmBenStopDate END) AS DedStopDate_561
            ,MAX(CASE WHEN BdmDedCode = '562' THEN BdmBenStopDate END) AS DedStopDate_562

            FROM dbo.U_dsi_BDM_EMETLIFEXP WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecID ) AS BDM
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN (
                    SELECT PdhEEID, PdhCOID,  PdhBenAmt AS PdhBenAmt_417
                    FROM (
                    SELECT PdhEEID, PdhCOID,  PdhBenAmt, PdhPayDate, ROW_NUMBER() OVER (PARTITION BY PdhEEID, PdhCOID ORDER BY PdhPayDate DESC) AS RN
                    FROM dbo.pDedHist WITH (NOLOCK)
                    WHERE PdhDedCode = '417') AS T
                    WHERE RN = 1
        ) AS BenAmt417
        ON PdhEEID = xEEID
        AND PdhCOID = xCOID
    LEFT JOIN (
                SELECT EedEEID, EedCOID 
                ,MAX(CASE WHEN EedDedCode = '420' THEN EedBenAmt END) AS BenAmt_420
                ,MAX(CASE WHEN EedDedCode = '421' THEN EedBenAmt END) AS BenAmt_421
                ,MAX(CASE WHEN EedDedCode = '422' THEN EedBenAmt END) AS BenAmt_422
                FROM (
                        SELECT EedEEID, EedCOID, EedDedCode, EedBenAmt, EedDatetimeChanged, ROW_NUMBER() OVER (PARTITION BY EedEEID, EedCOID, EedDedCode ORDER By EedDatetimeChanged DESC) AS RN
                        FROM dbo.EmpDedFull WITH (NOLOCK)
                        WHERE EedDedCode IN ('420','421', '422')
                    ) AS T
                WHERE RN = 1
                GROUP BY EedEEID, EedCOID
        ) AS BenAmt421_422
        ON EedEEID = xEEID
        AND EedCoID = xCOID
    LEFT JOIN dbo.u_dsi_bdm_BenCalculationAmounts 
        ON BcaEEID = xEEID
        AND BcaCOID = xCOID
        AND BcaFormatCode = @FormatCode 
        AND BcaDedCode = '418'
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
ALTER VIEW dbo.dsi_vwEMETLIFEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMETLIFEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMETLIFEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005281'
       ,expStartPerControl     = '202005281'
       ,expLastEndPerControl   = '202006049'
       ,expEndPerControl       = '202006049'
WHERE expFormatCode = 'EMETLIFEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMETLIFEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMETLIFEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;