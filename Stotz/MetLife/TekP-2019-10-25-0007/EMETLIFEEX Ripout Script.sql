SET NOCOUNT ON;
IF OBJECT_ID('U_EMETLIFEEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMETLIFEEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMETLIFEEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMETLIFEEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMETLIFEEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMETLIFEEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETLIFEEX];
GO
IF OBJECT_ID('U_EMETLIFEEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEEX_PEarHist];
GO
IF OBJECT_ID('U_EMETLIFEEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEEX_PDedHist];
GO
IF OBJECT_ID('U_EMETLIFEEX_File') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEEX_File];
GO
IF OBJECT_ID('U_EMETLIFEEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEEX_EEList];
GO
IF OBJECT_ID('U_EMETLIFEEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEEX_drvTbl];
GO
IF OBJECT_ID('U_EMETLIFEEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EMETLIFEEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMETLIFEEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMETLIFEEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMETLIFEEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMETLIFEEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMETLIFEEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMETLIFEEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMETLIFEEX','Met Life Vol CI ACC Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMETLIFEEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransactionCode"','1','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','1',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerNumber"','2','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','2',NULL,'Customer Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','3','(''UA''=''F'')','EMETLIFEEXZ0','11','D','10','9',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''F'')','EMETLIFEEXZ0','11','D','10','20',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''F'')','EMETLIFEEXZ0','9','D','10','31',NULL,'Member Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''F'')','EMETLIFEEXZ0','20','D','10','40',NULL,'Member Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''F'')','EMETLIFEEXZ0','12','D','10','60',NULL,'Member First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','8','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','72',NULL,'Member Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','9','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','73',NULL,'Member Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','81',NULL,'Member Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','11','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','82',NULL,'Member Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','12','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','83',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','13','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','85',NULL,'Employee''s Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonnelId"','14','(''UA''=''F'')','EMETLIFEEXZ0','11','D','10','93',NULL,'Personnel Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"U"','15','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','104',NULL,'Employee Smoker Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"U"','16','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','105',NULL,'Spouse Smoker Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EMETLIFEEXZ0','22','D','10','106',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','128',NULL,'Survivor Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EMETLIFEEXZ0','9','D','10','129',NULL,'Survivor SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EMETLIFEEXZ0','20','D','10','138',NULL,'Survivor Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EMETLIFEEXZ0','12','D','10','158',NULL,'Survivor First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D"','22','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','170',NULL,'Foreign Address Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','EMETLIFEEXZ0','32','D','10','171',NULL,'Care of Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressStreet"','24','(''UA''=''F'')','EMETLIFEEXZ0','32','D','10','203',NULL,'Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','25','(''UA''=''F'')','EMETLIFEEXZ0','21','D','10','235',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','26','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','256',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','27','(''UA''=''F'')','EMETLIFEEXZ0','9','D','10','258',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','267',NULL,'Coverage Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','269',NULL,'Coverage Start Date - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','277',NULL,'Coverage Stop Date - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','285',NULL,'Group Number - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','292',NULL,'Subcode - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','296',NULL,'Branch - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','300',NULL,'Plan Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','302',NULL,'Status Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','303',NULL,'Members Covered Code - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','304',NULL,'Cancel Reason - 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','306',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','307',NULL,'Facility ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EMETLIFEEXZ0','15','D','10','315',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','330',NULL,'Coverage Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','332',NULL,'Coverage Start Date - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','340',NULL,'Coverage Stop Date - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','348',NULL,'Group Number - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','355',NULL,'Subcode - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','359',NULL,'Branch - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','363',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','365',NULL,'Status Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','366',NULL,'Members Covered Code - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','367',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','377',NULL,'Annual Benefit Amount - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','385',NULL,'Salary Mode - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','386',NULL,'Salary Amount - 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','393',NULL,'Coverage Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','395',NULL,'Coverage Start Date - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','403',NULL,'Coverage Stop Date - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','411',NULL,'Group Number - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','418',NULL,'Subcode - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','422',NULL,'Branch - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','426',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','428',NULL,'Status Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','429',NULL,'Members Covered Code - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','430',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','440',NULL,'Annual Benefit Amount - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','448',NULL,'Salary Mode - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','449',NULL,'Salary Amount - 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','456',NULL,'Coverage Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','458',NULL,'Coverage Start Date - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','466',NULL,'Coverage Stop Date - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','474',NULL,'Group Number - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','481',NULL,'Subcode - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','485',NULL,'Branch - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','489',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','491',NULL,'Status Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','492',NULL,'Members Covered Code - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','493',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','503',NULL,'Monthly Benefit Amount - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','511',NULL,'Salary Mode - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','512',NULL,'Salary Amount - 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','519',NULL,'Coverage Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','521',NULL,'Coverage Start Date - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','529',NULL,'Coverage Stop Date - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','537',NULL,'Group Number - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','544',NULL,'Subcode - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','548',NULL,'Branch - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','552',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','554',NULL,'Status Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','555',NULL,'Members Covered Code - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','556',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','566',NULL,'Weekly Benefit Amount - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','574',NULL,'Salary Mode - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','575',NULL,'Salary Amount - 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','582',NULL,'Coverage Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','584',NULL,'Coverage Start Date - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','592',NULL,'Coverage Stop Date - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','600',NULL,'Group Number - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','607',NULL,'Subcode - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','98','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','611',NULL,'Branch - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','615',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','617',NULL,'Status Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','618',NULL,'Members Covered Code - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','619',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','629',NULL,'Annual Benefit Amount - 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','637',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode7"','105','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','645',NULL,'Coverage Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate7"','106','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','647',NULL,'Coverage Start Date - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate7"','107','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','655',NULL,'Coverage Stop Date - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo7"','108','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','663',NULL,'Group Number - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode7"','109','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','670',NULL,'Subcode - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch7"','110','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','674',NULL,'Branch - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','678',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode7"','112','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','680',NULL,'Status Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberCoverCode7"','113','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','681',NULL,'Members Covered Code - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','682',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBeneAmt7"','115','(''UA''=''F'')','EMETLIFEEXZ0','8','D','10','692',NULL,'Annual Benefit Amount - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','116','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','700',NULL,'Salary Mode - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmount7"','117','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','701',NULL,'Salary Amount - 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode8"','118','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','708',NULL,'Coverage Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate8"','119','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','710',NULL,'Coverage Start Date - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate8"','120','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','718',NULL,'Coverage Stop Date - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo8"','121','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','726',NULL,'Group Number - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode8"','122','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','733',NULL,'Subcode - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch8"','123','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','737',NULL,'Branch - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','124','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','741',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode8"','125','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','743',NULL,'Status Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberCoverCode8"','126','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','744',NULL,'Members Covered Code - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','127','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','745',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBeneAmt8"','128','(''UA''=''F'')','EMETLIFEEXZ0','8','D','10','755',NULL,'Annual Benefit Amount - 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','129','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','763',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode9"','130','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','771',NULL,'Coverage Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate9"','131','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','773',NULL,'Coverage Start Date - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate9"','132','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','781',NULL,'Coverage Stop Date - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo9"','133','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','789',NULL,'Group Number - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode9"','134','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','796',NULL,'Subcode - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch9"','135','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','800',NULL,'Branch - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','804',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode9"','137','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','806',NULL,'Status Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberCoverCode9"','138','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','807',NULL,'Members Covered Code - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','808',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBeneAmt9"','140','(''UA''=''F'')','EMETLIFEEXZ0','8','D','10','818',NULL,'Annual Benefit Amount - 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','826',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode10"','142','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','834',NULL,'Coverage Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate10"','143','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','836',NULL,'Coverage Start Date - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate10"','144','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','844',NULL,'Coverage Stop Date - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo10"','145','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','852',NULL,'Group Number - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode10"','146','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','859',NULL,'Subcode - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch10"','147','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','863',NULL,'Branch - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','867',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode10"','149','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','869',NULL,'Status Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberCoverCode10"','150','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','870',NULL,'Members Covered Code - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','871',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBeneAmt10"','152','(''UA''=''F'')','EMETLIFEEXZ0','8','D','10','881',NULL,'Annual Benefit Amount - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode10"','153','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','889',NULL,'Salary Mode - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmount10"','154','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','890',NULL,'Salary Amount - 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode11"','155','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','897',NULL,'Coverage Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate11"','156','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','899',NULL,'Coverage Start Date - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate11"','157','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','907',NULL,'Coverage Stop Date - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo11"','158','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','915',NULL,'Group Number - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode11"','159','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','922',NULL,'Subcode - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch11"','160','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','926',NULL,'Branch - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','930',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode11"','162','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','932',NULL,'Status Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberCoverCode11"','163','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','933',NULL,'Members Covered Code - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','164','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','934',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBeneAmt11"','165','(''UA''=''F'')','EMETLIFEEXZ0','8','D','10','944',NULL,'Annual Benefit Amount - 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','166','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','952',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode12"','167','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','960',NULL,'Coverage Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate12"','168','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','962',NULL,'Coverage Start Date - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate12"','169','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','970',NULL,'Coverage Stop Date - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo12"','170','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','978',NULL,'Group Number - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode12"','171','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','985',NULL,'Subcode - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch12"','172','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','989',NULL,'Branch - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','993',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode12"','174','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','995',NULL,'Status Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberCoverCode12"','175','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','996',NULL,'Members Covered Code - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','176','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','997',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualBeneAmt12"','177','(''UA''=''F'')','EMETLIFEEXZ0','8','D','10','1007',NULL,'Annual Benefit Amount - 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','178','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1015',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1023',NULL,'Coverage Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1025',NULL,'Coverage Start Date - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','181','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1033',NULL,'Coverage Stop Date - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1041',NULL,'Group Number - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1048',NULL,'Subcode - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1052',NULL,'Branch - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1056',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1058',NULL,'Status Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','187','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1059',NULL,'Members Covered Code - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','188','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','1060',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','189','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1070',NULL,'Annual Benefit Amount - 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','190','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1078',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','191','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1086',NULL,'Coverage Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','192','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1088',NULL,'Coverage Start Date - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','193','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1096',NULL,'Coverage Stop Date - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','194','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1104',NULL,'Group Number - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','195','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1111',NULL,'Subcode - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','196','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1115',NULL,'Branch - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','197','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1119',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','198','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1121',NULL,'Status Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','199','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1122',NULL,'Members Covered Code - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','200','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','1123',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','201','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1133',NULL,'Annual Benefit Amount - 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','202','(''DA''=''F'')','EMETLIFEEXZ0','12','D','10','1141',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','203','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1153',NULL,'Coverage Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','204','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1155',NULL,'Coverage Start Date - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','205','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1163',NULL,'Coverage Stop Date - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','206','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1171',NULL,'Group Number - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','207','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1178',NULL,'Subcode - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','208','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1182',NULL,'Branch - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','209','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1186',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','210','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1188',NULL,'Status Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','211','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1189',NULL,'Members Covered Code - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','212','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','1190',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','213','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1200',NULL,'Annual Benefit Amount - 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','214','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1208',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','215','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1216',NULL,'Coverage Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','216','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1218',NULL,'Coverage Start Date - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','217','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1226',NULL,'Coverage Stop Date - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','218','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1234',NULL,'Group Number - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','219','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1241',NULL,'Subcode - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','220','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1245',NULL,'Branch - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','221','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1249',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','222','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1251',NULL,'Status Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','223','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1252',NULL,'Members Covered Code - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','224','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','1253',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','225','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1263',NULL,'Annual Benefit Amount - 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','226','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1271',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','227','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1279',NULL,'Coverage Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','228','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1281',NULL,'Coverage Start Date - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','229','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1289',NULL,'Coverage Stop Date - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','230','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1297',NULL,'Group Number - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','231','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1304',NULL,'Subcode - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','232','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1308',NULL,'Branch - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','233','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1312',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','234','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1314',NULL,'Status Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','235','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1315',NULL,'Members Covered Code - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','236','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1316',NULL,'Cancel Reason - 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','237','(''DA''=''F'')','EMETLIFEEXZ0','23','D','10','1318',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatusCode"','238','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','1341',NULL,'Employee Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCodeEffDate"','239','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','1342',NULL,'Status Code Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','240','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','1350',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupId"','241','(''UA''=''F'')','EMETLIFEEXZ0','10','D','10','1360',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationId"','242','(''UA''=''F'')','EMETLIFEEXZ0','5','D','10','1370',NULL,'Location ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduleId"','243','(''UA''=''F'')','EMETLIFEEXZ0','10','D','10','1375',NULL,'Schedule ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','244','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','1385',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','245','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1387',NULL,'Coverage Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','246','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1389',NULL,'Coverage Start Date - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','247','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1397',NULL,'Coverage Stop Date - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','248','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1405',NULL,'Group Number - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','249','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1412',NULL,'Subcode - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','250','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1416',NULL,'Branch - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','251','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1420',NULL,'Status Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','252','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1421',NULL,'Members Covered Code - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','253','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1422',NULL,'Enrollment Status - 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode19"','254','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','1423',NULL,'Coverage Code - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate19"','255','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','1425',NULL,'Coverage Start Date - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate19"','256','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','1433',NULL,'Coverage Stop Date - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo19"','257','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','1441',NULL,'Group Number - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode19"','258','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','1448',NULL,'Subcode - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch19"','259','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','1452',NULL,'Branch - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberCoverCode19"','260','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','1456',NULL,'Members Covered Code - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus19"','261','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','1457',NULL,'Enrollment Status - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitAmount19"','262','(''UA''=''F'')','EMETLIFEEXZ0','8','D','10','1458',NULL,'Benefit Amount - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryCancelInd19"','263','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','1466',NULL,'Voluntary Cancellation Ind - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','264','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1468',NULL,'Taveover Indicator - 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','265','(''DA''=''F'')','EMETLIFEEXZ0','9','D','10','1469',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode20"','266','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','1478',NULL,'Coverage Code - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate20"','267','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','1480',NULL,'Coverage Start Date - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate20"','268','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','1488',NULL,'Coverage Stop Date - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo20"','269','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','1496',NULL,'Group Number - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode20"','270','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','1503',NULL,'Subcode - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch20"','271','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','1507',NULL,'Branch - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberCoverCode20"','272','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','1511',NULL,'Members Covered Code - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus20"','273','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','1512',NULL,'Enrollment Status - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitAmount20"','274','(''UA''=''F'')','EMETLIFEEXZ0','8','D','10','1513',NULL,'Benefit Amount - 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','1521',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1531',NULL,'Coverage Code - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1533',NULL,'Coverage Start Date - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','278','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1541',NULL,'Coverage Stop Date - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1549',NULL,'Group Number - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','280','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1556',NULL,'Subcode - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','281','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1560',NULL,'Branch - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','282','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1564',NULL,'Members Covered Code - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','283','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1565',NULL,'Enrollment Status - 21',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','284','(''DA''=''F'')','EMETLIFEEXZ0','3','D','10','1566',NULL,'GPC Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','285','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1569',NULL,'Paypoint',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','286','(''DA''=''F'')','EMETLIFEEXZ0','3','D','10','1571',NULL,'Payroll Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','287','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1574',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','288','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1576',NULL,'Coverage Code - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','289','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1578',NULL,'Coverage Start Date - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','290','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1586',NULL,'Coverage Stop Date - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','291','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1594',NULL,'Group Number - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','292','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1601',NULL,'Subcode - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','293','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1605',NULL,'Branch - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','294','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1609',NULL,'Members Covered Code - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','295','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1610',NULL,'Enrollment Status - 22',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','296','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1611',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode23"','297','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','1613',NULL,'Coverage Code - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate23"','298','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','1615',NULL,'Coverage Start Date - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate23"','299','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','1623',NULL,'Coverage Stop Date - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo23"','300','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','1631',NULL,'Group Number - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode23"','301','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','1638',NULL,'Subcode - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch23"','302','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','1642',NULL,'Branch - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberCoverCode23"','303','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','1646',NULL,'Members Covered Code - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus23"','304','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','1647',NULL,'Enrollment Status - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryCancelInd23"','305','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','1648',NULL,'Voluntary Cancellation Ind - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','306','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1650',NULL,'Takeover Indicator - 23',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','307','(''DA''=''F'')','EMETLIFEEXZ0','9','D','10','1651',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageCode24"','308','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','1660',NULL,'Coverage Code - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate24"','309','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','1662',NULL,'Coverage Start Date - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate24"','310','(''UDMDY''=''F'')','EMETLIFEEXZ0','8','D','10','1670',NULL,'Coverage Stop Date - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNo24"','311','(''UA''=''F'')','EMETLIFEEXZ0','7','D','10','1678',NULL,'Group Number - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubcode24"','312','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','1685',NULL,'Subcode - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBranch24"','313','(''UA''=''F'')','EMETLIFEEXZ0','4','D','10','1689',NULL,'Branch - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberCoverCode24"','314','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','1693',NULL,'Members Covered Code - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus24"','315','(''UA''=''F'')','EMETLIFEEXZ0','1','D','10','1694',NULL,'Enrollment Status - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryCancelInd24"','316','(''UA''=''F'')','EMETLIFEEXZ0','2','D','10','1695',NULL,'Voluntary Cancellation Ind - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','317','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1697',NULL,'Takeover Indicator - 24',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','318','(''DA''=''F'')','EMETLIFEEXZ0','9','D','10','1698',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','319','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1707',NULL,'Coverage Code - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','320','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1709',NULL,'Coverage Start Date - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','321','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1717',NULL,'Coverage Stop Date - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','322','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1725',NULL,'Group Number - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','323','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1732',NULL,'Subcode - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','324','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1736',NULL,'Branch - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','325','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1740',NULL,'Members Covered Code - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','326','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1741',NULL,'Enrollment Status - 25',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','327','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','1742',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','328','(''DA''=''F'')','EMETLIFEEXZ0','95','D','10','1752',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','329','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1847',NULL,'Coverage Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','330','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1849',NULL,'Coverage Start Date - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','331','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1857',NULL,'Coverage Stop Date - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','332','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1865',NULL,'Group Number - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','333','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1872',NULL,'Subcode - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','334','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1876',NULL,'Branch - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','335','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1880',NULL,'Status Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','336','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1881',NULL,'Members Covered Code - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','337','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1882',NULL,'Benefit Amount - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','338','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1890',NULL,'Takeover Indicator - 27',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','339','(''DA''=''F'')','EMETLIFEEXZ0','10','D','10','1891',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','340','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1901',NULL,'Coverage Code - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','341','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1903',NULL,'Coverage Start Date - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','342','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1911',NULL,'Coverage Stop Date - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','343','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1919',NULL,'Group Number - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','344','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1926',NULL,'Subcode - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','345','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1930',NULL,'Branch - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','346','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1934',NULL,'Members Covered Code - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','347','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1935',NULL,'Enrollment Status - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','348','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1936',NULL,'Benefit Amount - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','349','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1944',NULL,'Voluntary Cancellation Ind - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','350','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1946',NULL,'Takeover Indicator - 28',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','351','(''DA''=''F'')','EMETLIFEEXZ0','9','D','10','1947',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','352','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1956',NULL,'Coverage Code - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','353','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1958',NULL,'Coverage Start Date - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','354','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1966',NULL,'Coverage Stop Date - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','355','(''DA''=''F'')','EMETLIFEEXZ0','7','D','10','1974',NULL,'Group Number - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','356','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1981',NULL,'Subcode - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','357','(''DA''=''F'')','EMETLIFEEXZ0','4','D','10','1985',NULL,'Branch - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','358','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1989',NULL,'Members Covered Code - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','359','(''DA''=''F'')','EMETLIFEEXZ0','1','D','10','1990',NULL,'Enrollment Status - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','360','(''DA''=''F'')','EMETLIFEEXZ0','8','D','10','1991',NULL,'Benefit Amount - 29',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','361','(''DA''=''F'')','EMETLIFEEXZ0','2','D','10','1999',NULL,'Filler',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFEEX_20200501.txt',NULL,'','',',LQAD9,LQBFC,LQAII,NBYDV',NULL,NULL,NULL,'MetLife - Ondemand','202002059','EMPEXPORT','ONDEMAND',NULL,'EMETLIFEEX',NULL,NULL,NULL,'202002059','Feb  5 2020 10:11AM','Feb  5 2020 10:11AM','202002051',NULL,'','','202002051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFEEX_20200501.txt',NULL,'Null','N',',LQAD9,LQBFC,LQAII,NBYDV',NULL,NULL,NULL,'MetLife Vol CI ACC - Mon 8am','202002059','EMPEXPORT','SCHEDULED',NULL,'EMETLIFEEX',NULL,NULL,NULL,'202004279','Feb  5 2020 10:11AM','Feb  5 2020 10:11AM','202004201',NULL,'','','202002051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFEEX_20200501.txt',NULL,NULL,NULL,',LQAD9,LQBFC,LQAII,NBYDV',NULL,NULL,NULL,'MetLife Active OE','202002059','EMPEXPORT','OEACTIVE',NULL,'EMETLIFEEX',NULL,NULL,NULL,'202002059','Feb  5 2020 10:11AM','Feb  5 2020 10:11AM','202002051',NULL,'','','202002051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFEEX_20200501.txt',NULL,NULL,NULL,',LQAD9,LQBFC,LQAII,NBYDV',NULL,NULL,NULL,'MetLife Passive OE','202002059','EMPEXPORT','OEPASSIVE',NULL,'EMETLIFEEX',NULL,NULL,NULL,'202002059','Feb  5 2020 10:11AM','Feb  5 2020 10:11AM','202002051',NULL,'','','202002051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMETLIFEEX_20200501.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202004089','EMPEXPORT','TEST','Apr  8 2020 12:37PM','EMETLIFEEX',NULL,NULL,NULL,'202004089','Apr  8 2020 12:00AM','Dec 30 1899 12:00AM','202003251','774','','','202003251',dbo.fn_GetTimedKey(),NULL,'us3lKiSTO1007',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EMETLIFEEX_20200501.txt' END WHERE expFormatCode = 'EMETLIFEEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFEEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFEEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFEEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFEEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFEEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EMETLIFEEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMETLIFEEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EMETLIFEEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFEEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLIFEEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLIFEEX','D10','dbo.U_EMETLIFEEX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EMETLIFEEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMETLIFEEX] (
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
IF OBJECT_ID('U_EMETLIFEEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EMETLIFEEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(12) NULL,
    [drvTransactionCode] varchar(1) NOT NULL,
    [drvCustomerNumber] varchar(7) NOT NULL,
    [drvEmpSSN] char(11) NULL,
    [drvSSN] varchar(1) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvGender] char(1) NULL,
    [drvRelationshipCode] varchar(2) NULL,
    [drvDateOfHire] datetime NULL,
    [drvPersonnelId] char(9) NULL,
    [drvAddressStreet] varchar(6000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCoverageCode7] varchar(2) NULL,
    [drvStartDate7] datetime NULL,
    [drvStopDate7] datetime NULL,
    [drvGroupNo7] varchar(7) NULL,
    [drvSubcode7] varchar(4) NULL,
    [drvBranch7] varchar(4) NULL,
    [drvStatusCode7] varchar(1) NULL,
    [drvMemberCoverCode7] varchar(2) NULL,
    [drvAnnualBeneAmt7] nvarchar(4000) NULL,
    [drvSalaryMode7] varchar(1) NULL,
    [drvSalaryAmount7] nvarchar(4000) NULL,
    [drvCoverageCode8] varchar(2) NULL,
    [drvStartDate8] datetime NULL,
    [drvStopDate8] datetime NULL,
    [drvGroupNo8] varchar(7) NULL,
    [drvSubcode8] varchar(4) NULL,
    [drvBranch8] varchar(4) NULL,
    [drvStatusCode8] varchar(1) NULL,
    [drvMemberCoverCode8] varchar(1) NULL,
    [drvAnnualBeneAmt8] nvarchar(4000) NULL,
    [drvCoverageCode9] varchar(2) NULL,
    [drvStartDate9] datetime NULL,
    [drvStopDate9] datetime NULL,
    [drvGroupNo9] varchar(7) NULL,
    [drvSubcode9] varchar(4) NULL,
    [drvBranch9] varchar(4) NULL,
    [drvStatusCode9] varchar(1) NULL,
    [drvMemberCoverCode9] varchar(1) NULL,
    [drvAnnualBeneAmt9] varchar(8) NULL,
    [drvCoverageCode10] varchar(2) NULL,
    [drvStartDate10] datetime NULL,
    [drvStopDate10] datetime NULL,
    [drvGroupNo10] varchar(7) NULL,
    [drvSubcode10] varchar(4) NULL,
    [drvBranch10] varchar(4) NULL,
    [drvStatusCode10] varchar(1) NULL,
    [drvMemberCoverCode10] varchar(1) NULL,
    [drvAnnualBeneAmt10] nvarchar(4000) NULL,
    [drvSalaryMode10] varchar(1) NULL,
    [drvSalaryAmount10] nvarchar(4000) NULL,
    [drvCoverageCode11] varchar(2) NULL,
    [drvStartDate11] datetime NULL,
    [drvStopDate11] datetime NULL,
    [drvGroupNo11] varchar(7) NULL,
    [drvSubcode11] varchar(4) NULL,
    [drvBranch11] varchar(4) NULL,
    [drvStatusCode11] varchar(1) NULL,
    [drvMemberCoverCode11] varchar(1) NULL,
    [drvAnnualBeneAmt11] nvarchar(4000) NULL,
    [drvCoverageCode12] varchar(2) NULL,
    [drvStartDate12] datetime NULL,
    [drvStopDate12] datetime NULL,
    [drvGroupNo12] varchar(7) NULL,
    [drvSubcode12] varchar(4) NULL,
    [drvBranch12] varchar(4) NULL,
    [drvStatusCode12] varchar(1) NULL,
    [drvMemberCoverCode12] varchar(1) NULL,
    [drvAnnualBeneAmt12] varchar(8) NULL,
    [drvEmployeeStatusCode] varchar(1) NULL,
    [drvStatusCodeEffDate] datetime NULL,
    [drvGroupId] varchar(10) NULL,
    [drvLocationId] varchar(5) NULL,
    [drvScheduleId] varchar(10) NULL,
    [drvPayFrequency] varchar(2) NULL,
    [drvCoverageCode19] varchar(2) NULL,
    [drvStartDate19] datetime NULL,
    [drvStopDate19] datetime NULL,
    [drvGroupNo19] varchar(7) NULL,
    [drvSubcode19] varchar(4) NULL,
    [drvBranch19] varchar(4) NULL,
    [drvMemberCoverCode19] varchar(1) NULL,
    [drvEnrollmentStatus19] varchar(1) NULL,
    [drvBenefitAmount19] varchar(8) NULL,
    [drvVoluntaryCancelInd19] varchar(2) NULL,
    [drvCoverageCode20] varchar(2) NULL,
    [drvStartDate20] datetime NULL,
    [drvStopDate20] datetime NULL,
    [drvGroupNo20] varchar(7) NULL,
    [drvSubcode20] varchar(4) NULL,
    [drvBranch20] varchar(4) NULL,
    [drvMemberCoverCode20] varchar(1) NULL,
    [drvEnrollmentStatus20] varchar(1) NULL,
    [drvBenefitAmount20] varchar(8) NULL,
    [drvCoverageCode23] varchar(2) NULL,
    [drvStartDate23] datetime NULL,
    [drvStopDate23] datetime NULL,
    [drvGroupNo23] varchar(7) NULL,
    [drvSubcode23] varchar(4) NULL,
    [drvBranch23] varchar(4) NULL,
    [drvMemberCoverCode23] varchar(1) NULL,
    [drvEnrollmentStatus23] varchar(1) NULL,
    [drvVoluntaryCancelInd23] varchar(2) NULL,
    [drvCoverageCode24] varchar(2) NULL,
    [drvStartDate24] datetime NULL,
    [drvStopDate24] datetime NULL,
    [drvGroupNo24] varchar(7) NULL,
    [drvSubcode24] varchar(4) NULL,
    [drvBranch24] varchar(4) NULL,
    [drvMemberCoverCode24] varchar(1) NULL,
    [drvEnrollmentStatus24] varchar(1) NULL,
    [drvVoluntaryCancelInd24] varchar(2) NULL
);
IF OBJECT_ID('U_EMETLIFEEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMETLIFEEX_File') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);
IF OBJECT_ID('U_EMETLIFEEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [pdhDM100BenAmt] numeric NULL,
    [pdhDML10BenAmt] numeric NULL,
    [pdhDML20BenAmt] numeric NULL,
    [pdhDML40BenAmt] numeric NULL,
    [pdhDML50BenAmt] numeric NULL,
    [pdhDML5KBenAmt] numeric NULL,
    [pdhMETL1BenAmt] numeric NULL,
    [pdhMET20BenAmt] numeric NULL,
    [pdhMETL2BenAmt] numeric NULL,
    [pdhMET23BenAmt] numeric NULL,
    [pdhMET24BenAmt] numeric NULL,
    [pdhMET25BenAmt] numeric NULL,
    [pdhMET38BenAmt] numeric NULL,
    [pdhMETL4BenAmt] numeric NULL,
    [pdhMETL5BenAmt] numeric NULL,
    [pdhMETL6BenAmt] numeric NULL,
    [pdhMETL7BenAmt] numeric NULL,
    [pdhMETL8BenAmt] numeric NULL,
    [pdhMET30BenAmt] numeric NULL,
    [pdhMET35BenAmt] numeric NULL,
    [pdhMET40BenAmt] numeric NULL,
    [pdhMET45BenAmt] numeric NULL,
    [pdhMET50BenAmt] numeric NULL,
    [pdhDSL10BenAmt] numeric NULL,
    [pdhDSL20BenAmt] numeric NULL,
    [pdhDSL25BenAmt] numeric NULL,
    [pdhDSL50BenAmt] numeric NULL,
    [pdhSP100BenAmt] numeric NULL,
    [pdhSPL10BenAmt] numeric NULL,
    [pdhSPL20BenAmt] numeric NULL,
    [pdhSPL25BenAmt] numeric NULL,
    [pdhSPL30BenAmt] numeric NULL,
    [pdhSPL40BenAmt] numeric NULL,
    [pdhSPL50BenAmt] numeric NULL,
    [pdhSPL60BenAmt] numeric NULL,
    [pdhCI15CBenAmt] numeric NULL,
    [pdhCI30CBenAmt] numeric NULL,
    [pdhCI30EBenAmt] numeric NULL,
    [pdhCI15EBenAmt] numeric NULL,
    [pdhCI15FBenAmt] numeric NULL,
    [pdhCI30FBenAmt] numeric NULL,
    [pdhCI15SBenAmt] numeric NULL,
    [pdhCI30SBenAmt] numeric NULL
);
IF OBJECT_ID('U_EMETLIFEEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMETLIFEEX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETLIFEEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Stotz Equipment

Created By: James Bender
Business Analyst: Lea King
Create Date: 02/05/2020
Service Request Number: TekP-2019-10-25-0007

Purpose: Met Life Vol CI ACC Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMETLIFEEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMETLIFEEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMETLIFEEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMETLIFEEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMETLIFEEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFEEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFEEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFEEX', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMETLIFEEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMETLIFEEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMETLIFEEX';

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
    DELETE FROM dbo.U_EMETLIFEEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMETLIFEEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ACCHI,ACCLO,CI15C,CI15F,CI15E, CI15S,CI30C,CI30F,CI30E,CI30S,HOSH,HOSLO,ACCHI,ACCLO,DM100,DML10,DML20,DML40,DML50,DML5K,DMLCH,DSL10,DSL20,DSL25,DSL50,MET20,MET23,MET24,MET25,MET38,METL1,METL2,METL4,METL5,METL6,METL7,METL8,METLC,SP100,SPL10,SPL20,SPL25,SPL30,SPL40,SPL50,SPL60,MET30, MET35, MET40, MET45, MET50,METNB';
    
    IF OBJECT_ID('U_EMETLIFEEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFEEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMETLIFEEX_DedList
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
    IF OBJECT_ID('U_EMETLIFEEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFEEX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,pdhDM100BenAmt = MAX(CASE WHEN PdhDedCode IN ('DM100') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhDML10BenAmt = MAX(CASE WHEN PdhDedCode IN ('DML10') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhDML20BenAmt = MAX(CASE WHEN PdhDedCode IN ('DML20') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhDML40BenAmt = MAX(CASE WHEN PdhDedCode IN ('DML40') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhDML50BenAmt = MAX(CASE WHEN PdhDedCode IN ('DML50') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhDML5KBenAmt = MAX(CASE WHEN PdhDedCode IN ('DML5K') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMETL1BenAmt = MAX(CASE WHEN PdhDedCode IN ('METL1') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMET20BenAmt = MAX(CASE WHEN PdhDedCode IN ('MET20') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMETL2BenAmt = MAX(CASE WHEN PdhDedCode IN ('METL2') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMET23BenAmt = MAX(CASE WHEN PdhDedCode IN ('MET23') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMET24BenAmt = MAX(CASE WHEN PdhDedCode IN ('MET24') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMET25BenAmt = MAX(CASE WHEN PdhDedCode IN ('MET25') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMET38BenAmt = MAX(CASE WHEN PdhDedCode IN ('MET38') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMETL4BenAmt = MAX(CASE WHEN PdhDedCode IN ('METL4') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMETL5BenAmt = MAX(CASE WHEN PdhDedCode IN ('METL5') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMETL6BenAmt = MAX(CASE WHEN PdhDedCode IN ('METL6') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMETL7BenAmt = MAX(CASE WHEN PdhDedCode IN ('METL7') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMETL8BenAmt = MAX(CASE WHEN PdhDedCode IN ('METL8') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMET30BenAmt = MAX(CASE WHEN PdhDedCode IN ('MET30') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMET35BenAmt = MAX(CASE WHEN PdhDedCode IN ('MET35') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMET40BenAmt = MAX(CASE WHEN PdhDedCode IN ('MET40') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMET45BenAmt = MAX(CASE WHEN PdhDedCode IN ('MET45') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhMET50BenAmt = MAX(CASE WHEN PdhDedCode IN ('MET50') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhDSL10BenAmt = MAX(CASE WHEN PdhDedCode IN ('DSL10') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhDSL20BenAmt = MAX(CASE WHEN PdhDedCode IN ('DSL20') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhDSL25BenAmt = MAX(CASE WHEN PdhDedCode IN ('DSL25') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhDSL50BenAmt = MAX(CASE WHEN PdhDedCode IN ('DSL50') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhSP100BenAmt = MAX(CASE WHEN PdhDedCode IN ('SP100') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhSPL10BenAmt = MAX(CASE WHEN PdhDedCode IN ('SPL10') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhSPL20BenAmt = MAX(CASE WHEN PdhDedCode IN ('SPL20') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhSPL25BenAmt = MAX(CASE WHEN PdhDedCode IN ('SPL25') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhSPL30BenAmt = MAX(CASE WHEN PdhDedCode IN ('SPL30') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhSPL40BenAmt = MAX(CASE WHEN PdhDedCode IN ('SPL40') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhSPL50BenAmt = MAX(CASE WHEN PdhDedCode IN ('SPL50') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhSPL60BenAmt = MAX(CASE WHEN PdhDedCode IN ('SPL60') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhCI15CBenAmt = MAX(CASE WHEN PdhDedCode IN ('CI15C') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhCI30CBenAmt = MAX(CASE WHEN PdhDedCode IN ('CI30C') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhCI30EBenAmt = MAX(CASE WHEN PdhDedCode IN ('CI30E') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhCI15EBenAmt = MAX(CASE WHEN PdhDedCode IN ('CI15E') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhCI15FBenAmt = MAX(CASE WHEN PdhDedCode IN ('CI15F') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhCI30FBenAmt = MAX(CASE WHEN PdhDedCode IN ('CI30F') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhCI15SBenAmt = MAX(CASE WHEN PdhDedCode IN ('CI15S') THEN PdhBenAmt ELSE 0.00 END) 
        ,pdhCI30SBenAmt = MAX(CASE WHEN PdhDedCode IN ('CI30S') THEN PdhBenAmt ELSE 0.00 END) 
    INTO dbo.U_EMETLIFEEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMETLIFEEX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    --AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EMETLIFEEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFEEX_PEarHist;
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
    INTO dbo.U_EMETLIFEEX_PEarHist
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
    -- DETAIL RECORD - U_EMETLIFEEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMETLIFEEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFEEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepSSN + CASE WHEN BdmRecType = 'EMP' THEN '1' ELSE '2' END
        -- standard fields above and additional driver fields below
        ,drvTransactionCode = CASE WHEN BdmRecType = 'EMP' THEN 'E' ELSE 'D' END
        --ACCHI_Code
        ,drvCustomerNumber =    CASE WHEN ACCHI_Code IS NOT NULL
                                        --BdmDedCode IN ('CI15C','CI15F','CI15S','CI15E','CI30C','CI30F','CI30S','CI30E','ACCHI','ACCLO','HOSH','HOSLO') 
                                        THEN '9213661'
                                    ELSE '5948356'
                                END
        ,drvEmpSSN = eepSSN
        ,drvSSN = '' --eepSSN
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddleInit = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvMaritalStatus = eepMaritalStatus
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvRelationshipCode =    CASE WHEN BdmRecType = 'EMP' THEN '00'
                                    ELSE
                                        CASE WHEN ConRelationship IN ('DP', 'SPS') THEN '01'
                                            WHEN ConRelationship IN ('CHL', 'STC', 'DPC', 'DCH') THEN '02'
                                        END
                                END
        ,drvDateOfHire = EecDateOfLastHire
        ,drvPersonnelId = EecEmpNo
        ,drvAddressStreet = dbo.dsi_fnRemoveChars('.,/-', ISNULL(EepAddressLine1, '') + ' ' + ISNULL(EepAddressLine2, ''))
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvCoverageCode7 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                    CASE WHEN    DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL 
                                        OR DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL 
                                        OR DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL 
                                        OR METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL
                                        OR METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL 
                                        OR MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL 
                                        OR MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL 
                                        OR METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL 
                                        OR METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL 
                                        OR MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                        OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                        OR MET50_Code IS NOT NULL THEN 'OP'
                                    END
                                END
        ,drvStartDate7 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                CASE WHEN DM100_Code IS NOT NULL AND DM100_StartDate >= '7/18/2019' THEN DM100_StartDate
                                    WHEN DML10_Code IS NOT NULL AND DML10_StartDate >= '7/18/2019' THEN DML10_StartDate
                                    WHEN DML20_Code IS NOT NULL AND DML20_StartDate >= '7/18/2019' THEN DML20_StartDate
                                    WHEN DML40_Code IS NOT NULL AND DML40_StartDate >= '7/18/2019' THEN DML40_StartDate
                                    WHEN DML50_Code IS NOT NULL AND DML50_StartDate >= '7/18/2019' THEN DML50_StartDate
                                    WHEN DML5K_Code IS NOT NULL AND DML5K_StartDate >= '7/18/2019' THEN DML5K_StartDate
                                    WHEN METL1_Code IS NOT NULL AND METL1_StartDate >= '7/18/2019' THEN METL1_StartDate
                                    WHEN MET20_Code IS NOT NULL AND MET20_StartDate >= '7/18/2019' THEN MET20_StartDate
                                    WHEN METL2_Code IS NOT NULL AND METL2_StartDate >= '7/18/2019' THEN METL2_StartDate
                                    WHEN MET23_Code IS NOT NULL AND MET23_StartDate >= '7/18/2019' THEN MET23_StartDate
                                    WHEN MET24_Code IS NOT NULL AND MET24_StartDate >= '7/18/2019' THEN MET24_StartDate
                                    WHEN MET25_Code IS NOT NULL AND MET25_StartDate >= '7/18/2019' THEN MET25_StartDate
                                    WHEN MET38_Code IS NOT NULL AND MET38_StartDate >= '7/18/2019' THEN MET38_StartDate
                                    WHEN METL4_Code IS NOT NULL AND METL4_StartDate >= '7/18/2019' THEN METL4_StartDate
                                    WHEN METL5_Code IS NOT NULL AND METL5_StartDate >= '7/18/2019' THEN METL5_StartDate
                                    WHEN METL6_Code IS NOT NULL AND METL6_StartDate >= '7/18/2019' THEN METL6_StartDate
                                    WHEN METL7_Code IS NOT NULL AND METL7_StartDate >= '7/18/2019' THEN METL7_StartDate
                                    WHEN METL8_Code IS NOT NULL AND METL8_StartDate >= '7/18/2019' THEN METL8_StartDate 
                                    WHEN MET30_Code IS NOT NULL AND MET30_StartDate >= '7/18/2019' THEN MET30_StartDate 
                                    WHEN MET35_Code IS NOT NULL AND MET35_StartDate >= '7/18/2019' THEN MET35_StartDate 
                                    WHEN MET40_Code IS NOT NULL AND MET40_StartDate >= '7/18/2019' THEN MET40_StartDate 
                                    WHEN MET45_Code IS NOT NULL AND MET45_StartDate >= '7/18/2019' THEN MET45_StartDate 
                                    WHEN MET50_Code IS NOT NULL AND MET50_StartDate >= '7/18/2019' THEN MET50_StartDate 
                                    WHEN DM100_Code IS NOT NULL AND DM100_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN DML10_Code IS NOT NULL AND DML10_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN DML20_Code IS NOT NULL AND DML20_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN DML40_Code IS NOT NULL AND DML40_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN DML50_Code IS NOT NULL AND DML50_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN DML5K_Code IS NOT NULL AND DML5K_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL1_Code IS NOT NULL AND METL1_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET20_Code IS NOT NULL AND MET20_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL2_Code IS NOT NULL AND METL2_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET23_Code IS NOT NULL AND MET23_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET24_Code IS NOT NULL AND MET24_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET25_Code IS NOT NULL AND MET25_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET38_Code IS NOT NULL AND MET38_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL4_Code IS NOT NULL AND METL4_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL5_Code IS NOT NULL AND METL5_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL6_Code IS NOT NULL AND METL6_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL7_Code IS NOT NULL AND METL7_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL8_Code IS NOT NULL AND METL8_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET30_Code IS NOT NULL AND MET30_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET35_Code IS NOT NULL AND MET35_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET40_Code IS NOT NULL AND MET40_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET45_Code IS NOT NULL AND MET45_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET50_Code IS NOT NULL AND MET50_StartDate < '7/18/2019' THEN '7/18/2019'
                                END
                            END
        ,drvStopDate7 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                CASE WHEN DM100_Code IS NOT NULL THEN DM100_StopDate
                                    WHEN DML10_Code IS NOT NULL THEN DML10_StopDate
                                    WHEN DML20_Code IS NOT NULL THEN DML20_StopDate
                                    WHEN DML40_Code IS NOT NULL THEN DML40_StopDate
                                    WHEN DML50_Code IS NOT NULL THEN DML50_StopDate
                                    WHEN DML5K_Code IS NOT NULL THEN DML5K_StopDate
                                    WHEN METL1_Code IS NOT NULL THEN METL1_StopDate
                                    WHEN MET20_Code IS NOT NULL THEN MET20_StopDate
                                    WHEN METL2_Code IS NOT NULL THEN METL2_StopDate
                                    WHEN MET23_Code IS NOT NULL THEN MET23_StopDate
                                    WHEN MET24_Code IS NOT NULL THEN MET24_StopDate
                                    WHEN MET25_Code IS NOT NULL THEN MET25_StopDate
                                    WHEN MET38_Code IS NOT NULL THEN MET38_StopDate
                                    WHEN METL4_Code IS NOT NULL THEN METL4_StopDate
                                    WHEN METL5_Code IS NOT NULL THEN METL5_StopDate
                                    WHEN METL6_Code IS NOT NULL THEN METL6_StopDate
                                    WHEN METL7_Code IS NOT NULL THEN METL7_StopDate
                                    WHEN METL8_Code IS NOT NULL THEN METL8_StopDate 
                                    WHEN MET30_Code IS NOT NULL THEN MET30_StopDate
                                    WHEN MET35_Code IS NOT NULL THEN MET35_StopDate
                                    WHEN MET40_Code IS NOT NULL THEN MET40_StopDate
                                    WHEN MET45_Code IS NOT NULL THEN MET45_StopDate
                                    WHEN MET50_Code IS NOT NULL THEN MET50_StopDate
                                END
                            END
        ,drvGroupNo7 =    CASE WHEN BdmRecType = 'EMP' THEN 
                            CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL 
                                OR DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL 
                                OR DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL 
                                OR METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL
                                OR METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL 
                                OR MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL 
                                OR MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL 
                                OR METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL 
                                OR METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL 
                                OR MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                OR MET50_Code IS NOT NULL THEN '5948356'
                            END
                        END
        ,drvSubcode7 =  CASE WHEN BdmRecType = 'EMP' THEN   
                            CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL 
                                OR DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL 
                                OR DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL 
                                OR METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL
                                OR METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL 
                                OR MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL 
                                OR MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL 
                                OR METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL 
                                OR METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL
                                OR MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                OR MET50_Code IS NOT NULL THEN '0001'
                            END
                        END
        ,drvBranch7 =   CASE WHEN BdmRecType = 'EMP' THEN  
                            CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL 
                                    OR DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL 
                                    OR DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL 
                                    OR METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL
                                    OR METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL 
                                    OR MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL 
                                    OR MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL 
                                    OR METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL 
                                    OR METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL
                                    OR MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                    OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                    OR MET50_Code IS NOT NULL THEN '0001'
                            END
                        END
        ,drvStatusCode7 =   CASE WHEN BdmRecType = 'EMP' THEN  
                                CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL 
                                    OR DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL 
                                    OR DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL 
                                    OR METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL
                                    OR METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL 
                                    OR MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL 
                                    OR MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL 
                                    OR METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL 
                                    OR METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL
                                    OR MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                    OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                    OR MET50_Code IS NOT NULL THEN 'A'
                                END
                            END
        ,drvMemberCoverCode7 =  CASE WHEN BdmRecType = 'EMP' THEN   
                                    CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL 
                                        OR DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL 
                                        OR DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL 
                                        OR METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL
                                        OR METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL 
                                        OR MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL 
                                        OR MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL 
                                        OR METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL 
                                        OR METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL
                                        OR MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                        OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                        OR MET50_Code IS NOT NULL THEN '01'
                                    END
                                END
        ,drvAnnualBeneAmt7 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                    CASE WHEN DM100_Code IS NOT NULL THEN FORMAT(pdhDM100BenAmt, '00000000')
                                        WHEN DML10_Code IS NOT NULL THEN FORMAT(pdhDML10BenAmt, '00000000')
                                        WHEN DML20_Code IS NOT NULL THEN FORMAT(pdhDML20BenAmt, '00000000')
                                        WHEN DML40_Code IS NOT NULL THEN FORMAT(pdhDML40BenAmt, '00000000')
                                        WHEN DML50_Code IS NOT NULL THEN FORMAT(pdhDML50BenAmt, '00000000')
                                        WHEN DML5K_Code IS NOT NULL THEN FORMAT(pdhDML5KBenAmt, '00000000')
                                        WHEN METL1_Code IS NOT NULL THEN FORMAT(pdhMETL1BenAmt, '00000000')
                                        WHEN MET20_Code IS NOT NULL THEN FORMAT(pdhMET20BenAmt, '00000000')
                                        WHEN METL2_Code IS NOT NULL THEN FORMAT(pdhMETL2BenAmt, '00000000')
                                        WHEN MET23_Code IS NOT NULL THEN FORMAT(pdhMET23BenAmt, '00000000')
                                        WHEN MET24_Code IS NOT NULL THEN FORMAT(pdhMET24BenAmt, '00000000')
                                        WHEN MET25_Code IS NOT NULL THEN FORMAT(pdhMET25BenAmt, '00000000')
                                        WHEN MET38_Code IS NOT NULL THEN FORMAT(pdhMET38BenAmt, '00000000')
                                        WHEN METL4_Code IS NOT NULL THEN FORMAT(pdhMETL4BenAmt, '00000000')
                                        WHEN METL5_Code IS NOT NULL THEN FORMAT(pdhMETL5BenAmt, '00000000')
                                        WHEN METL6_Code IS NOT NULL THEN FORMAT(pdhMETL6BenAmt, '00000000')
                                        WHEN METL7_Code IS NOT NULL THEN FORMAT(pdhMETL7BenAmt, '00000000')
                                        WHEN METL8_Code IS NOT NULL THEN FORMAT(pdhMETL8BenAmt, '00000000')
                                        WHEN MET30_Code IS NOT NULL THEN FORMAT(pdhMET30BenAmt, '00000000')
                                        WHEN MET35_Code IS NOT NULL THEN FORMAT(pdhMET35BenAmt, '00000000')
                                        WHEN MET40_Code IS NOT NULL THEN FORMAT(pdhMET40BenAmt, '00000000')
                                        WHEN MET45_Code IS NOT NULL THEN FORMAT(pdhMET45BenAmt, '00000000')
                                        WHEN MET50_Code IS NOT NULL THEN FORMAT(pdhMET50BenAmt, '00000000')
                                    END
                                END
        ,drvSalaryMode7 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL 
                                    OR DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL 
                                    OR DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL 
                                    OR METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL
                                    OR METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL 
                                    OR MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL 
                                    OR MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL 
                                    OR METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL 
                                    OR METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL
                                    OR MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                    OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                    OR MET50_Code IS NOT NULL THEN 'A'
                                END
                            END
        ,drvSalaryAmount7 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                    CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL 
                                        OR DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL 
                                        OR DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL 
                                        OR METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL
                                        OR METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL 
                                        OR MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL 
                                        OR MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL 
                                        OR METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL 
                                        OR METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL
                                        OR MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                        OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                        OR MET50_Code IS NOT NULL THEN FORMAT(EecAnnSalary, '0000000')
                                    END
                                END
        ,drvCoverageCode8 = CASE WHEN BdmRecType = 'EMP' THEN                            
                                CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL 
                                        OR DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL 
                                        OR SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL 
                                        OR SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL 
                                        OR SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL 
                                        OR SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN 'LZ' 
                                END
                            ELSE
                                CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR
                                        Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR
                                        Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR
                                        Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR
                                        Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR
                                        Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN 'LZ'
                                END
                            END
        ,drvStartDate8 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DSL10_Code IS NOT NULL THEN DSL10_StartDate
                                    WHEN DSL20_Code IS NOT NULL THEN DSL20_StartDate
                                    WHEN DSL25_Code IS NOT NULL THEN DSL25_StartDate
                                    WHEN DSL50_Code IS NOT NULL THEN DSL50_StartDate
                                    WHEN SP100_Code IS NOT NULL THEN SP100_StartDate
                                    WHEN SPL10_Code IS NOT NULL THEN SPL10_StartDate
                                    WHEN SPL20_Code IS NOT NULL THEN SPL20_StartDate
                                    WHEN SPL25_Code IS NOT NULL THEN SPL25_StartDate
                                    WHEN SPL30_Code IS NOT NULL THEN SPL30_StartDate
                                    WHEN SPL40_Code IS NOT NULL THEN SPL40_StartDate
                                    WHEN SPL50_Code IS NOT NULL THEN SPL50_StartDate
                                    WHEN SPL60_Code IS NOT NULL THEN SPL60_StartDate
                                END
                            ELSE
                                CASE WHEN Con_DSL10_BenStatus IS NOT NULL THEN DSL10_StartDate
                                    WHEN Con_DSL20_BenStatus IS NOT NULL THEN DSL20_StartDate
                                    WHEN Con_DSL25_BenStatus IS NOT NULL THEN DSL25_StartDate
                                    WHEN Con_DSL50_BenStatus IS NOT NULL THEN DSL50_StartDate
                                    WHEN Con_SP100_BenStatus IS NOT NULL THEN SP100_StartDate
                                    WHEN Con_SPL10_BenStatus IS NOT NULL THEN SPL10_StartDate
                                    WHEN Con_SPL20_BenStatus IS NOT NULL THEN SPL20_StartDate
                                    WHEN Con_SPL25_BenStatus IS NOT NULL THEN SPL25_StartDate
                                    WHEN Con_SPL30_BenStatus IS NOT NULL THEN SPL30_StartDate
                                    WHEN Con_SPL40_BenStatus IS NOT NULL THEN SPL40_StartDate
                                    WHEN Con_SPL50_BenStatus IS NOT NULL THEN SPL50_StartDate
                                    WHEN Con_SPL60_BenStatus IS NOT NULL THEN SPL60_StartDate
                                END
                            END
        ,drvStopDate8 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DSL10_Code IS NOT NULL THEN DSL10_StopDate
                                    WHEN DSL20_Code IS NOT NULL THEN DSL20_StopDate
                                    WHEN DSL25_Code IS NOT NULL THEN DSL25_StopDate
                                    WHEN DSL50_Code IS NOT NULL THEN DSL50_StopDate
                                    WHEN SP100_Code IS NOT NULL THEN SP100_StopDate
                                    WHEN SPL10_Code IS NOT NULL THEN SPL10_StopDate
                                    WHEN SPL20_Code IS NOT NULL THEN SPL20_StopDate
                                    WHEN SPL25_Code IS NOT NULL THEN SPL25_StopDate
                                    WHEN SPL30_Code IS NOT NULL THEN SPL30_StopDate
                                    WHEN SPL40_Code IS NOT NULL THEN SPL40_StopDate
                                    WHEN SPL50_Code IS NOT NULL THEN SPL50_StopDate
                                    WHEN SPL60_Code IS NOT NULL THEN SPL60_StopDate
                                END
                            ELSE
                                CASE WHEN Con_DSL10_BenStatus IS NOT NULL THEN DSL10_StopDate
                                    WHEN Con_DSL20_BenStatus IS NOT NULL THEN DSL20_StopDate
                                    WHEN Con_DSL25_BenStatus IS NOT NULL THEN DSL25_StopDate
                                    WHEN Con_DSL50_BenStatus IS NOT NULL THEN DSL50_StopDate
                                    WHEN Con_SP100_BenStatus IS NOT NULL THEN SP100_StopDate
                                    WHEN Con_SPL10_BenStatus IS NOT NULL THEN SPL10_StopDate
                                    WHEN Con_SPL20_BenStatus IS NOT NULL THEN SPL20_StopDate
                                    WHEN Con_SPL25_BenStatus IS NOT NULL THEN SPL25_StopDate
                                    WHEN Con_SPL30_BenStatus IS NOT NULL THEN SPL30_StopDate
                                    WHEN Con_SPL40_BenStatus IS NOT NULL THEN SPL40_StopDate
                                    WHEN Con_SPL50_BenStatus IS NOT NULL THEN SPL50_StopDate
                                    WHEN Con_SPL60_BenStatus IS NOT NULL THEN SPL60_StopDate
                                END
                            END
        ,drvGroupNo8 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL 
                                OR DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL 
                                OR SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL 
                                OR SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL 
                                OR SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL 
                                OR SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN '5948356' 
                            END
                        ELSE
                            CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR
                                    Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR
                                    Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR
                                    Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR
                                    Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR
                                    Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN '5948356'
                            END
                        END
        ,drvSubcode8 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL 
                                OR DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL 
                                OR SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL 
                                OR SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL 
                                OR SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL 
                                OR SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN '0001' 
                            END
                        ELSE
                            CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR
                                Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR
                                Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR
                                Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR
                                Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR
                                Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN '0001'
                            END
                        END
        ,drvBranch8 =  CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL 
                                OR DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL 
                                OR SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL 
                                OR SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL 
                                OR SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL 
                                OR SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN '0001' 
                            END
                        ELSE
                            CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR
                                Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR
                                Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR
                                Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR
                                Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR
                                Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN '0001'
                            END
                        END
        ,drvStatusCode8 =   CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL 
                                OR DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL 
                                OR SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL 
                                OR SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL 
                                OR SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL 
                                OR SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN 'A' 
                            END
                        ELSE
                            CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR
                                Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR
                                Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR
                                Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR
                                Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR
                                Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN 'A'
                            END
                        END
        ,drvMemberCoverCode8 =    CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL 
                                            OR DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL 
                                            OR SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL 
                                            OR SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL 
                                            OR SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL 
                                            OR SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN 'A' 
                                        END
                                    ELSE
                                        CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR
                                            Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR
                                            Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR
                                            Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR
                                            Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR
                                            Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN 'A'
                                        END
                                    END
        ,drvAnnualBeneAmt8 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DSL10_Code IS NOT NULL THEN FORMAT(pdhDSL10BenAmt, '00000000')
                                        WHEN DSL20_Code IS NOT NULL THEN FORMAT(pdhDSL20BenAmt, '00000000')
                                        WHEN DSL25_Code IS NOT NULL THEN FORMAT(pdhDSL25BenAmt, '00000000')
                                        WHEN DSL50_Code IS NOT NULL THEN FORMAT(pdhDSL50BenAmt, '00000000')
                                        WHEN SP100_Code IS NOT NULL THEN FORMAT(pdhSP100BenAmt, '00000000')
                                        WHEN SPL10_Code IS NOT NULL THEN FORMAT(pdhSPL10BenAmt, '00000000')
                                        WHEN SPL20_Code IS NOT NULL THEN FORMAT(pdhSPL20BenAmt, '00000000')
                                        WHEN SPL25_Code IS NOT NULL THEN FORMAT(pdhSPL25BenAmt, '00000000')
                                        WHEN SPL30_Code IS NOT NULL THEN FORMAT(pdhSPL30BenAmt, '00000000')
                                        WHEN SPL40_Code IS NOT NULL THEN FORMAT(pdhSPL40BenAmt, '00000000')
                                        WHEN SPL50_Code IS NOT NULL THEN FORMAT(pdhSPL50BenAmt, '00000000')
                                        WHEN SPL60_Code IS NOT NULL THEN FORMAT(pdhSPL60BenAmt, '00000000')
                                    END
                                ELSE
                                    CASE WHEN Con_DSL10_BenStatus IS NOT NULL THEN FORMAT(pdhDSL10BenAmt, '00000000')
                                        WHEN Con_DSL20_BenStatus IS NOT NULL THEN FORMAT(pdhDSL20BenAmt, '00000000')
                                        WHEN Con_DSL25_BenStatus IS NOT NULL THEN FORMAT(pdhDSL25BenAmt, '00000000')
                                        WHEN Con_DSL50_BenStatus IS NOT NULL THEN FORMAT(pdhDSL50BenAmt, '00000000')
                                        WHEN Con_SP100_BenStatus IS NOT NULL THEN FORMAT(pdhSP100BenAmt, '00000000')
                                        WHEN Con_SPL10_BenStatus IS NOT NULL THEN FORMAT(pdhSPL10BenAmt, '00000000')
                                        WHEN Con_SPL20_BenStatus IS NOT NULL THEN FORMAT(pdhSPL20BenAmt, '00000000')
                                        WHEN Con_SPL25_BenStatus IS NOT NULL THEN FORMAT(pdhSPL25BenAmt, '00000000')
                                        WHEN Con_SPL30_BenStatus IS NOT NULL THEN FORMAT(pdhSPL30BenAmt, '00000000')
                                        WHEN Con_SPL40_BenStatus IS NOT NULL THEN FORMAT(pdhSPL40BenAmt, '00000000')
                                        WHEN Con_SPL50_BenStatus IS NOT NULL THEN FORMAT(pdhSPL50BenAmt, '00000000')
                                        WHEN Con_SPL60_BenStatus IS NOT NULL THEN FORMAT(pdhSPL60BenAmt, '00000000')
                                    END
                                END
        ,drvCoverageCode9 =    CASE WHEN BdmRecType = 'EMP' THEN -- JCB
                                CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL THEN 'LF' END
                            ELSE
                                CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL THEN 'LF' END
                            END
        ,drvStartDate9 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DMLCH_Code IS NOT NULL THEN DMLCH_StartDate
                                    WHEN METLC_Code IS NOT NULL THEN METLC_StartDate
                                    WHEN METNB_Code IS NOT NULL THEN METNB_StartDate
                                END
                            ELSE
                                CASE WHEN Con_DMLCH_BenStatus IS NOT NULL THEN DMLCH_StartDate
                                    WHEN Con_METLC_BenStatus IS NOT NULL THEN METLC_StartDate
                                    WHEN Con_METNB_BenStatus IS NOT NULL THEN METNB_StartDate
                                END
                            END
        ,drvStopDate9 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DMLCH_Code IS NOT NULL THEN DMLCH_StopDate
                                    WHEN METLC_Code IS NOT NULL THEN METLC_StopDate
                                    WHEN METNB_Code IS NOT NULL THEN METNB_StopDate
                                END
                            ELSE
                                CASE WHEN Con_DMLCH_BenStatus IS NOT NULL THEN DMLCH_StopDate
                                    WHEN Con_METLC_BenStatus IS NOT NULL THEN METLC_StopDate
                                    WHEN Con_METNB_BenStatus IS NOT NULL THEN METNB_StopDate
                                END
                            END
        ,drvGroupNo9 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN '5948356' END
                        ELSE
                            CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN '5948356' END
                        END
        ,drvSubcode9 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN '0001' END
                        ELSE
                            CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN '0001' END
                        END
        ,drvBranch9 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN '0001' END
                        ELSE
                            CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN '0001' END
                        END
        ,drvStatusCode9 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN 'A' END
                            ELSE
                                CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN 'A' END
                            END
        ,drvMemberCoverCode9 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN 'C' END
                                ELSE
                                    CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN 'C' END
                                END
        ,drvAnnualBeneAmt9 =    CASE WHEN BdmRecType = 'EMP' THEN   
                                    CASE WHEN DMLCH_Code IS NOT NULL AND DMLCH_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN DMLCH_Code IS NOT NULL AND DMLCH_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN DMLCH_Code IS NOT NULL AND DMLCH_BenOption = 'LIFECT' THEN '00010000'
                                        WHEN METLC_Code IS NOT NULL AND METLC_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN METLC_Code IS NOT NULL AND METLC_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN METLC_Code IS NOT NULL AND METLC_BenOption = 'LIFECT' THEN '00010000'
                                        WHEN METNB_Code IS NOT NULL AND METNB_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN METNB_Code IS NOT NULL AND METNB_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN METNB_Code IS NOT NULL AND METNB_BenOption = 'LIFECT' THEN '00010000'

                                    END  
                                ELSE
                                    CASE WHEN Con_DMLCH_BenStatus IS NOT NULL AND DMLCH_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN Con_DMLCH_BenStatus IS NOT NULL AND DMLCH_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN Con_DMLCH_BenStatus IS NOT NULL AND DMLCH_BenOption = 'LIFECT' THEN '00010000'
                                        WHEN Con_METLC_BenStatus IS NOT NULL AND METLC_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN Con_METLC_BenStatus IS NOT NULL AND METLC_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN Con_METLC_BenStatus IS NOT NULL AND METLC_BenOption = 'LIFECT' THEN '00010000'
                                        WHEN Con_METNB_BenStatus IS NOT NULL AND METNB_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN Con_METNB_BenStatus IS NOT NULL AND METNB_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN Con_METNB_BenStatus IS NOT NULL AND METNB_BenOption = 'LIFECT' THEN '00010000'

                                    END 
                                END                                  
        ,drvCoverageCode10 =    CASE WHEN BdmRecType = 'EMP' THEN -- JCB
                                    CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL OR 
                                        DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL OR 
                                        DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL OR 
                                        METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL OR 
                                        METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL OR 
                                        MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL OR 
                                        MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL OR 
                                        METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL OR 
                                        METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL OR 
                                        MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                        OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                        OR MET50_Code IS NOT NULL THEN 'OD'
                                    END 
                                END
        ,drvStartDate10 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                CASE WHEN DM100_Code IS NOT NULL AND DM100_StartDate >= '7/18/2019' THEN DM100_StartDate
                                    WHEN DML10_Code IS NOT NULL AND DML10_StartDate >= '7/18/2019' THEN DML10_StartDate 
                                    WHEN DML20_Code IS NOT NULL AND DML20_StartDate >= '7/18/2019' THEN DML20_StartDate 
                                    WHEN DML40_Code IS NOT NULL AND DML40_StartDate >= '7/18/2019' THEN DML40_StartDate 
                                    WHEN DML50_Code IS NOT NULL AND DML50_StartDate >= '7/18/2019' THEN DML50_StartDate 
                                    WHEN DML5K_Code IS NOT NULL AND DML5K_StartDate >= '7/18/2019' THEN DML5K_StartDate 
                                    WHEN METL1_Code IS NOT NULL AND METL1_StartDate >= '7/18/2019' THEN METL1_StartDate 
                                    WHEN MET20_Code IS NOT NULL AND MET20_StartDate >= '7/18/2019' THEN MET20_StartDate 
                                    WHEN METL2_Code IS NOT NULL AND METL2_StartDate >= '7/18/2019' THEN METL2_StartDate 
                                    WHEN MET23_Code IS NOT NULL AND MET23_StartDate >= '7/18/2019' THEN MET23_StartDate 
                                    WHEN MET24_Code IS NOT NULL AND MET24_StartDate >= '7/18/2019' THEN MET24_StartDate 
                                    WHEN MET25_Code IS NOT NULL AND MET25_StartDate >= '7/18/2019' THEN MET25_StartDate 
                                    WHEN MET38_Code IS NOT NULL AND MET38_StartDate >= '7/18/2019' THEN MET38_StartDate 
                                    WHEN METL4_Code IS NOT NULL AND METL4_StartDate >= '7/18/2019' THEN METL4_StartDate 
                                    WHEN METL5_Code IS NOT NULL AND METL5_StartDate >= '7/18/2019' THEN METL5_StartDate 
                                    WHEN METL6_Code IS NOT NULL AND METL6_StartDate >= '7/18/2019' THEN METL6_StartDate 
                                    WHEN METL7_Code IS NOT NULL AND METL7_StartDate >= '7/18/2019' THEN METL7_StartDate 
                                    WHEN METL8_Code IS NOT NULL AND METL8_StartDate >= '7/18/2019' THEN METL8_StartDate
                                    WHEN MET30_Code IS NOT NULL AND MET30_StartDate >= '7/18/2019' THEN MET30_StartDate
                                    WHEN MET35_Code IS NOT NULL AND MET35_StartDate >= '7/18/2019' THEN MET35_StartDate
                                    WHEN MET40_Code IS NOT NULL AND MET40_StartDate >= '7/18/2019' THEN MET40_StartDate
                                    WHEN MET45_Code IS NOT NULL AND MET45_StartDate >= '7/18/2019' THEN MET45_StartDate
                                    WHEN MET50_Code IS NOT NULL AND MET50_StartDate >= '7/18/2019' THEN MET50_StartDate
                                    WHEN DM100_Code IS NOT NULL AND DM100_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN DML10_Code IS NOT NULL AND DML10_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN DML20_Code IS NOT NULL AND DML20_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN DML40_Code IS NOT NULL AND DML40_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN DML50_Code IS NOT NULL AND DML50_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN DML5K_Code IS NOT NULL AND DML5K_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL1_Code IS NOT NULL AND METL1_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET20_Code IS NOT NULL AND MET20_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL2_Code IS NOT NULL AND METL2_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET23_Code IS NOT NULL AND MET23_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET24_Code IS NOT NULL AND MET24_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET25_Code IS NOT NULL AND MET25_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET38_Code IS NOT NULL AND MET38_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL4_Code IS NOT NULL AND METL4_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL5_Code IS NOT NULL AND METL5_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL6_Code IS NOT NULL AND METL6_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL7_Code IS NOT NULL AND METL7_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN METL8_Code IS NOT NULL AND METL8_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET30_Code IS NOT NULL AND MET30_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET35_Code IS NOT NULL AND MET35_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET40_Code IS NOT NULL AND MET40_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET45_Code IS NOT NULL AND MET45_StartDate < '7/18/2019' THEN '7/18/2019'
                                    WHEN MET50_Code IS NOT NULL AND MET50_StartDate < '7/18/2019' THEN '7/18/2019'
                                END
                            END
        ,drvStopDate10 =    CASE WHEN BdmRecType = 'EMP' THEN 
                                CASE WHEN DM100_Code IS NOT NULL THEN DM100_StopDate
                                    WHEN DML10_Code IS NOT NULL THEN DML10_StopDate 
                                    WHEN DML20_Code IS NOT NULL THEN DML20_StopDate 
                                    WHEN DML40_Code IS NOT NULL THEN DML40_StopDate 
                                    WHEN DML50_Code IS NOT NULL THEN DML50_StopDate 
                                    WHEN DML5K_Code IS NOT NULL THEN DML5K_StopDate 
                                    WHEN METL1_Code IS NOT NULL THEN METL1_StopDate 
                                    WHEN MET20_Code IS NOT NULL THEN MET20_StopDate 
                                    WHEN METL2_Code IS NOT NULL THEN METL2_StopDate 
                                    WHEN MET23_Code IS NOT NULL THEN MET23_StopDate 
                                    WHEN MET24_Code IS NOT NULL THEN MET24_StopDate 
                                    WHEN MET25_Code IS NOT NULL THEN MET25_StopDate 
                                    WHEN MET38_Code IS NOT NULL THEN MET38_StopDate 
                                    WHEN METL4_Code IS NOT NULL THEN METL4_StopDate 
                                    WHEN METL5_Code IS NOT NULL THEN METL5_StopDate 
                                    WHEN METL6_Code IS NOT NULL THEN METL6_StopDate 
                                    WHEN METL7_Code IS NOT NULL THEN METL7_StopDate 
                                    WHEN METL8_Code IS NOT NULL THEN METL8_StopDate
                                    WHEN MET30_Code IS NOT NULL THEN MET30_StopDate
                                    WHEN MET35_Code IS NOT NULL THEN MET35_StopDate
                                    WHEN MET40_Code IS NOT NULL THEN MET40_StopDate
                                    WHEN MET45_Code IS NOT NULL THEN MET45_StopDate
                                    WHEN MET50_Code IS NOT NULL THEN MET50_StopDate
                                END
                            END
        ,drvGroupNo10 =    CASE WHEN BdmRecType = 'EMP' THEN    
                            CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL OR 
                                DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL OR 
                                DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL OR 
                                METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL OR 
                                METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL OR 
                                MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL OR 
                                MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL OR 
                                METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL OR 
                                METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL OR 
                                MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                OR MET50_Code IS NOT NULL THEN '5948356'
                            END 
                        END
        ,drvSubcode10 =    CASE WHEN BdmRecType = 'EMP' THEN 
                            CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL OR 
                                DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL OR 
                                DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL OR 
                                METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL OR 
                                METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL OR 
                                MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL OR 
                                MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL OR 
                                METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL OR 
                                METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL OR 
                                MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                OR MET50_Code IS NOT NULL THEN '0001'
                            END
                        END
        ,drvBranch10 =    CASE WHEN BdmRecType = 'EMP' THEN    
                            CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL OR 
                                DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL OR 
                                DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL OR 
                                METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL OR 
                                METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL OR 
                                MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL OR 
                                MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL OR 
                                METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL OR 
                                METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL OR 
                                MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                OR MET50_Code IS NOT NULL THEN '0001'
                            END
                        END
        ,drvStatusCode10 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL OR 
                                    DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL OR 
                                    DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL OR 
                                    METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL OR 
                                    METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL OR 
                                    MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL OR 
                                    MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL OR 
                                    METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL OR 
                                    METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL OR 
                                    MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                    OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                    OR MET50_Code IS NOT NULL THEN 'A'
                                END
                            END
        ,drvMemberCoverCode10 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL OR 
                                        DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL OR 
                                        DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL OR 
                                        METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL OR 
                                        METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL OR 
                                        MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL OR 
                                        MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL OR 
                                        METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL OR 
                                        METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL OR 
                                        MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                        OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                        OR MET50_Code IS NOT NULL THEN '1'
                                    END
                                END
        ,drvAnnualBeneAmt10 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DM100_Code IS NOT NULL THEN FORMAT(pdhDM100BenAmt, '00000000')
                                        WHEN DML10_Code IS NOT NULL THEN FORMAT(pdhDML10BenAmt, '00000000')
                                        WHEN DML20_Code IS NOT NULL THEN FORMAT(pdhDML20BenAmt, '00000000')
                                        WHEN DML40_Code IS NOT NULL THEN FORMAT(pdhDML40BenAmt, '00000000')
                                        WHEN DML50_Code IS NOT NULL THEN FORMAT(pdhDML50BenAmt, '00000000')
                                        WHEN DML5K_Code IS NOT NULL THEN FORMAT(pdhDML5KBenAmt, '00000000')
                                        WHEN METL1_Code IS NOT NULL THEN FORMAT(pdhMETL1BenAmt, '00000000')
                                        WHEN MET20_Code IS NOT NULL THEN FORMAT(pdhMET20BenAmt, '00000000')
                                        WHEN METL2_Code IS NOT NULL THEN FORMAT(pdhMETL2BenAmt, '00000000')
                                        WHEN MET23_Code IS NOT NULL THEN FORMAT(pdhMET23BenAmt, '00000000')
                                        WHEN MET24_Code IS NOT NULL THEN FORMAT(pdhMET24BenAmt, '00000000')
                                        WHEN MET25_Code IS NOT NULL THEN FORMAT(pdhMET25BenAmt, '00000000')
                                        WHEN MET38_Code IS NOT NULL THEN FORMAT(pdhMET38BenAmt, '00000000')
                                        WHEN METL4_Code IS NOT NULL THEN FORMAT(pdhMETL4BenAmt, '00000000')
                                        WHEN METL5_Code IS NOT NULL THEN FORMAT(pdhMETL5BenAmt, '00000000')
                                        WHEN METL6_Code IS NOT NULL THEN FORMAT(pdhMETL6BenAmt, '00000000')
                                        WHEN METL7_Code IS NOT NULL THEN FORMAT(pdhMETL7BenAmt, '00000000')
                                        WHEN METL8_Code IS NOT NULL THEN FORMAT(pdhMETL8BenAmt, '00000000')

                                        WHEN MET30_Code IS NOT NULL THEN FORMAT(pdhMET30BenAmt, '00000000')
                                        WHEN MET35_Code IS NOT NULL THEN FORMAT(pdhMET35BenAmt, '00000000')
                                        WHEN MET40_Code IS NOT NULL THEN FORMAT(pdhMET40BenAmt, '00000000')
                                        WHEN MET45_Code IS NOT NULL THEN FORMAT(pdhMET45BenAmt, '00000000')
                                        WHEN MET50_Code IS NOT NULL THEN FORMAT(pdhMET50BenAmt, '00000000')
                                    END
                                END
        ,drvSalaryMode10 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL OR 
                                    DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL OR 
                                    DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL OR 
                                    METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL OR 
                                    METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL OR 
                                    MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL OR 
                                    MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL OR 
                                    METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL OR 
                                    METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL OR 
                                    MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                    OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                    OR MET50_Code IS NOT NULL THEN 'A'
                                END
                            END
        ,drvSalaryAmount10 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DM100_Code IS NOT NULL OR DML10_Code IS NOT NULL OR 
                                        DML20_Code IS NOT NULL OR DML40_Code IS NOT NULL OR 
                                        DML50_Code IS NOT NULL OR DML5K_Code IS NOT NULL OR 
                                        METL1_Code IS NOT NULL OR MET20_Code IS NOT NULL OR 
                                        METL2_Code IS NOT NULL OR MET23_Code IS NOT NULL OR 
                                        MET24_Code IS NOT NULL OR MET25_Code IS NOT NULL OR 
                                        MET38_Code IS NOT NULL OR METL4_Code IS NOT NULL OR 
                                        METL5_Code IS NOT NULL OR METL6_Code IS NOT NULL OR 
                                        METL7_Code IS NOT NULL OR METL8_Code IS NOT NULL OR
                                        MET30_Code IS NOT NULL OR MET35_Code IS NOT NULL 
                                        OR MET40_Code IS NOT NULL OR MET45_Code IS NOT NULL 
                                        OR MET50_Code IS NOT NULL THEN FORMAT(EecAnnSalary, '0000000')
                                    END
                                END
        ,drvCoverageCode11 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL OR 
                                        DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL OR 
                                        SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL OR 
                                        SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL OR 
                                        SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL OR 
                                        SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN 'AE' 
                                    END
                                ELSE
                                    CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR 
                                        Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR 
                                        Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR 
                                        Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR 
                                        Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR 
                                        Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN 'AE' 
                                    END
                                END
        ,drvStartDate11 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DSL10_Code IS NOT NULL THEN DSL10_StartDate
                                    WHEN DSL20_Code IS NOT NULL THEN DSL20_StartDate
                                    WHEN DSL25_Code IS NOT NULL THEN DSL25_StartDate
                                    WHEN DSL50_Code IS NOT NULL THEN DSL50_StartDate
                                    WHEN SP100_Code IS NOT NULL THEN SP100_StartDate
                                    WHEN SPL10_Code IS NOT NULL THEN SPL10_StartDate
                                    WHEN SPL20_Code IS NOT NULL THEN SPL20_StartDate
                                    WHEN SPL25_Code IS NOT NULL THEN SPL25_StartDate
                                    WHEN SPL30_Code IS NOT NULL THEN SPL30_StartDate
                                    WHEN SPL40_Code IS NOT NULL THEN SPL40_StartDate
                                    WHEN SPL50_Code IS NOT NULL THEN SPL50_StartDate
                                    WHEN SPL60_Code IS NOT NULL THEN SPL60_StartDate
                                END
                            ELSE
                                CASE WHEN Con_DSL10_BenStatus IS NOT NULL THEN DSL10_StartDate
                                    WHEN Con_DSL20_BenStatus IS NOT NULL THEN DSL20_StartDate
                                    WHEN Con_DSL25_BenStatus IS NOT NULL THEN DSL25_StartDate
                                    WHEN Con_DSL50_BenStatus IS NOT NULL THEN DSL50_StartDate
                                    WHEN Con_SP100_BenStatus IS NOT NULL THEN SP100_StartDate
                                    WHEN Con_SPL10_BenStatus IS NOT NULL THEN SPL10_StartDate
                                    WHEN Con_SPL20_BenStatus IS NOT NULL THEN SPL20_StartDate
                                    WHEN Con_SPL25_BenStatus IS NOT NULL THEN SPL25_StartDate
                                    WHEN Con_SPL30_BenStatus IS NOT NULL THEN SPL30_StartDate
                                    WHEN Con_SPL40_BenStatus IS NOT NULL THEN SPL40_StartDate
                                    WHEN Con_SPL50_BenStatus IS NOT NULL THEN SPL50_StartDate
                                    WHEN Con_SPL60_BenStatus IS NOT NULL THEN SPL60_StartDate
                                END
                            END
        ,drvStopDate11 = CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DSL10_Code IS NOT NULL THEN DSL10_StopDate
                                    WHEN DSL20_Code IS NOT NULL THEN DSL20_StopDate
                                    WHEN DSL25_Code IS NOT NULL THEN DSL25_StopDate
                                    WHEN DSL50_Code IS NOT NULL THEN DSL50_StopDate
                                    WHEN SP100_Code IS NOT NULL THEN SP100_StopDate
                                    WHEN SPL10_Code IS NOT NULL THEN SPL10_StopDate
                                    WHEN SPL20_Code IS NOT NULL THEN SPL20_StopDate
                                    WHEN SPL25_Code IS NOT NULL THEN SPL25_StopDate
                                    WHEN SPL30_Code IS NOT NULL THEN SPL30_StopDate
                                    WHEN SPL40_Code IS NOT NULL THEN SPL40_StopDate
                                    WHEN SPL50_Code IS NOT NULL THEN SPL50_StopDate
                                    WHEN SPL60_Code IS NOT NULL THEN SPL60_StopDate
                                END
                            ELSE
                                CASE WHEN Con_DSL10_BenStatus IS NOT NULL THEN DSL10_StopDate
                                    WHEN Con_DSL20_BenStatus IS NOT NULL THEN DSL20_StopDate
                                    WHEN Con_DSL25_BenStatus IS NOT NULL THEN DSL25_StopDate
                                    WHEN Con_DSL50_BenStatus IS NOT NULL THEN DSL50_StopDate
                                    WHEN Con_SP100_BenStatus IS NOT NULL THEN SP100_StopDate
                                    WHEN Con_SPL10_BenStatus IS NOT NULL THEN SPL10_StopDate
                                    WHEN Con_SPL20_BenStatus IS NOT NULL THEN SPL20_StopDate
                                    WHEN Con_SPL25_BenStatus IS NOT NULL THEN SPL25_StopDate
                                    WHEN Con_SPL30_BenStatus IS NOT NULL THEN SPL30_StopDate
                                    WHEN Con_SPL40_BenStatus IS NOT NULL THEN SPL40_StopDate
                                    WHEN Con_SPL50_BenStatus IS NOT NULL THEN SPL50_StopDate
                                    WHEN Con_SPL60_BenStatus IS NOT NULL THEN SPL60_StopDate
                                END
                            END
        ,drvGroupNo11 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL OR 
                                DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL OR 
                                SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL OR 
                                SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL OR 
                                SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL OR 
                                SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN '5948356' 
                            END
                        ELSE
                            CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR 
                                Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR 
                                Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR 
                                Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR 
                                Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR 
                                Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN '5948356' 
                            END
                        END
        ,drvSubcode11 = CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL OR 
                                DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL OR 
                                SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL OR 
                                SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL OR 
                                SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL OR 
                                SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN '0001' 
                            END
                        ELSE
                            CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR 
                                Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR 
                                Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR 
                                Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR 
                                Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR 
                                Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN '0001' 
                            END
                        END
        ,drvBranch11 = CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL OR 
                                DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL OR 
                                SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL OR 
                                SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL OR 
                                SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL OR 
                                SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN '0001' 
                            END
                        ELSE
                            CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR 
                                Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR 
                                Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR 
                                Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR 
                                Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR 
                                Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN '0001' 
                            END
                        END
        ,drvStatusCode11 = CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL OR 
                                DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL OR 
                                SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL OR 
                                SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL OR 
                                SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL OR 
                                SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN 'A' 
                            END
                        ELSE
                            CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR 
                                Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR 
                                Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR 
                                Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR 
                                Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR 
                                Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN 'A' 
                            END
                        END
        ,drvMemberCoverCode11 = CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DSL10_Code IS NOT NULL OR DSL20_Code IS NOT NULL OR 
                                        DSL25_Code IS NOT NULL OR DSL50_Code IS NOT NULL OR 
                                        SP100_Code IS NOT NULL OR SPL10_Code IS NOT NULL OR 
                                        SPL20_Code IS NOT NULL OR SPL25_Code IS NOT NULL OR 
                                        SPL30_Code IS NOT NULL OR SPL40_Code IS NOT NULL OR 
                                        SPL50_Code IS NOT NULL OR SPL60_Code IS NOT NULL THEN 'A' 
                                    END
                                ELSE
                                    CASE WHEN Con_DSL10_BenStatus IS NOT NULL OR Con_DSL20_BenStatus IS NOT NULL OR 
                                        Con_DSL25_BenStatus IS NOT NULL OR Con_DSL50_BenStatus IS NOT NULL OR 
                                        Con_SP100_BenStatus IS NOT NULL OR Con_SPL10_BenStatus IS NOT NULL OR 
                                        Con_SPL20_BenStatus IS NOT NULL OR Con_SPL25_BenStatus IS NOT NULL OR 
                                        Con_SPL30_BenStatus IS NOT NULL OR Con_SPL40_BenStatus IS NOT NULL OR 
                                        Con_SPL50_BenStatus IS NOT NULL OR Con_SPL60_BenStatus IS NOT NULL THEN 'A' 
                                    END
                                END
        ,drvAnnualBeneAmt11 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DSL10_Code IS NOT NULL THEN FORMAT(pdhDSL10BenAmt, '00000000')
                                        WHEN DSL20_Code IS NOT NULL THEN FORMAT(pdhDSL20BenAmt, '00000000')
                                        WHEN DSL25_Code IS NOT NULL THEN FORMAT(pdhDSL25BenAmt, '00000000')
                                        WHEN DSL50_Code IS NOT NULL THEN FORMAT(pdhDSL50BenAmt, '00000000')
                                        WHEN SP100_Code IS NOT NULL THEN FORMAT(pdhSP100BenAmt, '00000000')
                                        WHEN SPL10_Code IS NOT NULL THEN FORMAT(pdhSPL10BenAmt, '00000000')
                                        WHEN SPL20_Code IS NOT NULL THEN FORMAT(pdhSPL20BenAmt, '00000000')
                                        WHEN SPL25_Code IS NOT NULL THEN FORMAT(pdhSPL25BenAmt, '00000000')
                                        WHEN SPL30_Code IS NOT NULL THEN FORMAT(pdhSPL30BenAmt, '00000000')
                                        WHEN SPL40_Code IS NOT NULL THEN FORMAT(pdhSPL40BenAmt, '00000000')
                                        WHEN SPL50_Code IS NOT NULL THEN FORMAT(pdhSPL50BenAmt, '00000000')
                                        WHEN SPL60_Code IS NOT NULL THEN FORMAT(pdhSPL60BenAmt, '00000000')
                                    END
                                ELSE
                                    CASE WHEN Con_DSL10_BenStatus IS NOT NULL THEN FORMAT(pdhDSL10BenAmt, '00000000')
                                        WHEN Con_DSL20_BenStatus IS NOT NULL THEN FORMAT(pdhDSL20BenAmt, '00000000')
                                        WHEN Con_DSL25_BenStatus IS NOT NULL THEN FORMAT(pdhDSL25BenAmt, '00000000')
                                        WHEN Con_DSL50_BenStatus IS NOT NULL THEN FORMAT(pdhDSL50BenAmt, '00000000')
                                        WHEN Con_SP100_BenStatus IS NOT NULL THEN FORMAT(pdhSP100BenAmt, '00000000')
                                        WHEN Con_SPL10_BenStatus IS NOT NULL THEN FORMAT(pdhSPL10BenAmt, '00000000')
                                        WHEN Con_SPL20_BenStatus IS NOT NULL THEN FORMAT(pdhSPL20BenAmt, '00000000')
                                        WHEN Con_SPL25_BenStatus IS NOT NULL THEN FORMAT(pdhSPL25BenAmt, '00000000')
                                        WHEN Con_SPL30_BenStatus IS NOT NULL THEN FORMAT(pdhSPL30BenAmt, '00000000')
                                        WHEN Con_SPL40_BenStatus IS NOT NULL THEN FORMAT(pdhSPL40BenAmt, '00000000')
                                        WHEN Con_SPL50_BenStatus IS NOT NULL THEN FORMAT(pdhSPL50BenAmt, '00000000')
                                        WHEN Con_SPL60_BenStatus IS NOT NULL THEN FORMAT(pdhSPL60BenAmt, '00000000')
                                    END
                                END
        ,drvCoverageCode12 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN 'AT' END
                                ELSE
                                    CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN 'AT' END
                                END
        ,drvStartDate12 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DMLCH_Code IS NOT NULL THEN DMLCH_StartDate
                                    WHEN METLC_Code IS NOT NULL THEN METLC_StartDate
                                    WHEN METNB_Code IS NOT NULL THEN METNB_StartDate
                                END
                            ELSE
                                CASE WHEN Con_DMLCH_BenStatus IS NOT NULL THEN DMLCH_StartDate
                                    WHEN Con_METLC_BenStatus IS NOT NULL THEN METLC_StartDate
                                    WHEN Con_METNB_BenStatus IS NOT NULL THEN METNB_StartDate
                                END 
                            END
        ,drvStopDate12 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN DMLCH_Code IS NOT NULL THEN DMLCH_StopDate
                                    WHEN METLC_Code IS NOT NULL THEN METLC_StopDate
                                    WHEN METNB_Code IS NOT NULL THEN METNB_StopDate
                                END
                            ELSE
                                CASE WHEN Con_DMLCH_BenStatus IS NOT NULL THEN DMLCH_StopDate
                                    WHEN Con_METLC_BenStatus IS NOT NULL THEN METLC_StopDate
                                    WHEN Con_METNB_BenStatus IS NOT NULL THEN METNB_StopDate
                                END 
                            END
        ,drvGroupNo12 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN '5948356' END
                        ELSE
                            CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN '5948356' END
                        END
        ,drvSubcode12 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN '0001' END
                        ELSE
                            CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN '0001' END
                        END
        ,drvBranch12 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN '0001' END
                        ELSE
                            CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN '0001' END
                        END
        ,drvStatusCode12 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN 'A' END
                        ELSE
                            CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN 'A' END
                        END
        ,drvMemberCoverCode12 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DMLCH_Code IS NOT NULL OR METLC_Code IS NOT NULL OR METNB_Code IS NOT NULL THEN 'C' END
                                ELSE
                                    CASE WHEN Con_DMLCH_BenStatus IS NOT NULL OR Con_METLC_BenStatus IS NOT NULL OR Con_METNB_BenStatus IS NOT NULL THEN 'C' END
                                END
        ,drvAnnualBeneAmt12 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN DMLCH_Code IS NOT NULL AND DMLCH_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN DMLCH_Code IS NOT NULL AND DMLCH_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN DMLCH_Code IS NOT NULL AND DMLCH_BenOption = 'LIFECT' THEN '00010000'
                                        WHEN METLC_Code IS NOT NULL AND METLC_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN METLC_Code IS NOT NULL AND METLC_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN METLC_Code IS NOT NULL AND METLC_BenOption = 'LIFECT' THEN '00010000'
                                        WHEN METNB_Code IS NOT NULL AND METNB_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN METNB_Code IS NOT NULL AND METNB_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN METNB_Code IS NOT NULL AND METNB_BenOption = 'LIFECT' THEN '00010000'
                                    END
                                ELSE
                                    CASE WHEN Con_DMLCH_BenStatus IS NOT NULL AND DMLCH_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN Con_DMLCH_BenStatus IS NOT NULL AND DMLCH_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN Con_DMLCH_BenStatus IS NOT NULL AND DMLCH_BenOption = 'LIFECT' THEN '00010000'
                                        WHEN Con_METLC_BenStatus IS NOT NULL AND METLC_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN Con_METLC_BenStatus IS NOT NULL AND METLC_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN Con_METLC_BenStatus IS NOT NULL AND METLC_BenOption = 'LIFECT' THEN '00010000'
                                        WHEN Con_METNB_BenStatus IS NOT NULL AND METNB_BenOption = 'LIFEC2' THEN '00002000'
                                        WHEN Con_METNB_BenStatus IS NOT NULL AND METNB_BenOption = 'LIFEC5' THEN '00005000'
                                        WHEN Con_METNB_BenStatus IS NOT NULL AND METNB_BenOption = 'LIFECT' THEN '00010000'
                                    END
                                END
        ,drvEmployeeStatusCode =    CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'D' 
                                            WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'R'
                                            WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('203', '202') THEN 'T'
                                            ELSE 'A'
                                        END
                                    END
        ,drvStatusCodeEffDate =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE EecDateOfLastHire END
                                END
        ,drvGroupId = CASE WHEN BdmRecType = 'EMP' THEN '0007592444' END
        ,drvLocationId = CASE WHEN BdmRecType = 'EMP' THEN '00001' END
        ,drvScheduleId = CASE WHEN BdmRecType = 'EMP' THEN '0000023843' END
        ,drvPayFrequency = CASE WHEN BdmRecType = 'EMP' THEN '12' END
        ,drvCoverageCode19 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN  
                                    CI15E_Code IS NOT NULL OR CI30E_Code IS NOT NULL OR 
                                    CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                    CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                    CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN 'GE' END
                                END
        ,drvStartDate19 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN CI15E_Code IS NOT NULL THEN CI15E_StartDate
                                    WHEN CI30E_Code IS NOT NULL THEN CI30E_StartDate
                                    WHEN CI15C_Code IS NOT NULL THEN CI15C_StartDate
                                    WHEN CI30C_Code IS NOT NULL THEN CI30C_StartDate
                                    WHEN CI15F_Code IS NOT NULL THEN CI15F_StartDate
                                    WHEN CI30F_Code IS NOT NULL THEN CI30F_StartDate
                                    WHEN CI15S_Code IS NOT NULL THEN CI15S_StartDate
                                    WHEN CI30S_Code IS NOT NULL THEN CI30S_StartDate
                                END
                            END
        ,drvStopDate19 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN CI15E_Code IS NOT NULL THEN CI15E_StopDate
                                    WHEN CI30E_Code IS NOT NULL THEN CI30E_StopDate
                                    WHEN CI15C_Code IS NOT NULL THEN CI15C_StopDate
                                    WHEN CI30C_Code IS NOT NULL THEN CI30C_StopDate
                                    WHEN CI15F_Code IS NOT NULL THEN CI15F_StopDate
                                    WHEN CI30F_Code IS NOT NULL THEN CI30F_StopDate
                                    WHEN CI15S_Code IS NOT NULL THEN CI15S_StopDate
                                    WHEN CI30S_Code IS NOT NULL THEN CI30S_StopDate
                                END
                            END
        ,drvGroupNo19 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN 
                                CI15E_Code IS NOT NULL OR CI30E_Code IS NOT NULL OR 
                                    CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                    CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                    CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN '0213661' END
                        END
        ,drvSubcode19 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN CI15E_Code IS NOT NULL OR CI30E_Code IS NOT NULL OR 
                                    CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                    CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                    CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN '0001' END
                        END
        ,drvBranch19 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN CI15E_Code IS NOT NULL OR CI30E_Code IS NOT NULL OR 
                                    CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                    CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                    CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN '0001' END
                        END
        ,drvMemberCoverCode19 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN CI15E_Code IS NOT NULL OR CI30E_Code IS NOT NULL OR 
                                    CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                    CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                    CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN '1' END
                                END
        ,drvEnrollmentStatus19 =    CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN CI15E_Code IS NOT NULL OR CI30E_Code IS NOT NULL OR 
                                    CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                    CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                    CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN 'P' END
                                    END
        ,drvBenefitAmount19 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN CI15C_Code IS NOT NULL OR CI15E_Code IS NOT NULL OR
                                        CI15F_Code IS NOT NULL OR CI15S_Code IS NOT NULL THEN '00015000'
                                    WHEN CI30C_Code IS NOT NULL OR CI30E_Code IS NOT NULL OR
                                        CI30F_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN '00030000'
                                    END
                                END
        ,drvVoluntaryCancelInd19 =    CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN CI15C_Code IS NOT NULL AND EecEmplStatus = 'A' AND CI15C_BenStatus <> 'A' THEN 'CE'
                                            WHEN CI30C_Code IS NOT NULL AND EecEmplStatus = 'A' AND CI30C_BenStatus <> 'A' THEN 'CE'                                            
                                            WHEN CI15E_Code IS NOT NULL AND EecEmplStatus = 'A' AND CI15E_BenStatus <> 'A' THEN 'CE'
                                            WHEN CI30E_Code IS NOT NULL AND EecEmplStatus = 'A' AND CI30E_BenStatus <> 'A' THEN 'CE'
                                            WHEN CI15F_Code IS NOT NULL AND EecEmplStatus = 'A' AND CI15F_BenStatus <> 'A' THEN 'CE'
                                            WHEN CI30F_Code IS NOT NULL AND EecEmplStatus = 'A' AND CI30F_BenStatus <> 'A' THEN 'CE'
                                            WHEN CI15S_Code IS NOT NULL AND EecEmplStatus = 'A' AND CI15S_BenStatus <> 'A' THEN 'CE'
                                            WHEN CI30S_Code IS NOT NULL AND EecEmplStatus = 'A' AND CI30S_BenStatus <> 'A' THEN 'CE'
                                        END
                                    END
        ,drvCoverageCode20 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                        CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                        CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN 
                                        CASE WHEN (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EMETLIFEEX WHERE BdmEEID = xEEID AND BdmDedCode IN ('CI15C', 'CI30C', 'CI15F', 'CI30F', 'CI15S', 'CI30S')) > 1 THEN 'GD' ELSE 'GE' END
                                    END
                                ELSE
                                    CASE WHEN Con_CI15C_BenStatus IS NOT NULL OR Con_CI30C_BenStatus IS NOT NULL OR 
                                        Con_CI15F_BenStatus IS NOT NULL OR Con_CI30F_BenStatus IS NOT NULL OR 
                                        Con_CI15S_BenStatus IS NOT NULL OR Con_CI30S_BenStatus IS NOT NULL THEN 'GD' 
                                    END
                                END
        ,drvStartDate20 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN CI15C_Code IS NOT NULL THEN CI15C_StartDate
                                    WHEN CI30C_Code IS NOT NULL THEN CI30C_StartDate
                                    WHEN CI15F_Code IS NOT NULL THEN CI15F_StartDate
                                    WHEN CI30F_Code IS NOT NULL THEN CI30F_StartDate
                                    WHEN CI15S_Code IS NOT NULL THEN CI15S_StartDate
                                    WHEN CI30S_Code IS NOT NULL THEN CI30S_StartDate
                                END
                            ELSE
                                CASE WHEN Con_CI15C_BenStatus IS NOT NULL THEN CI15C_StartDate
                                    WHEN Con_CI30C_BenStatus IS NOT NULL THEN CI30C_StartDate
                                    WHEN Con_CI15F_BenStatus IS NOT NULL THEN CI15F_StartDate
                                    WHEN Con_CI30F_BenStatus IS NOT NULL THEN CI30F_StartDate
                                    WHEN Con_CI15S_BenStatus IS NOT NULL THEN CI15S_StartDate
                                    WHEN Con_CI30S_BenStatus IS NOT NULL THEN CI30S_StartDate
                                END
                            END
        ,drvStopDate20 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN CI15C_Code IS NOT NULL THEN CI15C_StopDate
                                    WHEN CI30C_Code IS NOT NULL THEN CI30C_StopDate
                                    WHEN CI15F_Code IS NOT NULL THEN CI15F_StopDate
                                    WHEN CI30F_Code IS NOT NULL THEN CI30F_StopDate
                                    WHEN CI15S_Code IS NOT NULL THEN CI15S_StopDate
                                    WHEN CI30S_Code IS NOT NULL THEN CI30S_StopDate
                                END
                            ELSE
                                CASE WHEN Con_CI15C_BenStatus IS NOT NULL THEN CI15C_StopDate
                                    WHEN Con_CI30C_BenStatus IS NOT NULL THEN CI30C_StopDate
                                    WHEN Con_CI15F_BenStatus IS NOT NULL THEN CI15F_StopDate
                                    WHEN Con_CI30F_BenStatus IS NOT NULL THEN CI30F_StopDate
                                    WHEN Con_CI15S_BenStatus IS NOT NULL THEN CI15S_StopDate
                                    WHEN Con_CI30S_BenStatus IS NOT NULL THEN CI30S_StopDate
                                END
                            END
        ,drvGroupNo20 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN '0213661' 
                            END
                        ELSE
                                CASE WHEN Con_CI15C_BenStatus IS NOT NULL OR Con_CI30C_BenStatus IS NOT NULL OR 
                                Con_CI15F_BenStatus IS NOT NULL OR Con_CI30F_BenStatus IS NOT NULL OR 
                                Con_CI15S_BenStatus IS NOT NULL OR Con_CI30S_BenStatus IS NOT NULL THEN '0213661' 
                            END
                        END
        ,drvSubcode20 = CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN '0001' 
                            END
                        ELSE
                                CASE WHEN Con_CI15C_BenStatus IS NOT NULL OR Con_CI30C_BenStatus IS NOT NULL OR 
                                Con_CI15F_BenStatus IS NOT NULL OR Con_CI30F_BenStatus IS NOT NULL OR 
                                Con_CI15S_BenStatus IS NOT NULL OR Con_CI30S_BenStatus IS NOT NULL THEN '0001' 
                            END
                        END
        ,drvBranch20 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN '0001' 
                            END
                        ELSE
                                CASE WHEN Con_CI15C_BenStatus IS NOT NULL OR Con_CI30C_BenStatus IS NOT NULL OR 
                                Con_CI15F_BenStatus IS NOT NULL OR Con_CI30F_BenStatus IS NOT NULL OR 
                                Con_CI15S_BenStatus IS NOT NULL OR Con_CI30S_BenStatus IS NOT NULL THEN '0001' 
                            END
                        END
        ,drvMemberCoverCode20 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                        CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                        CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN '4' 
                                    END
                                ELSE
                                        CASE WHEN Con_CI15C_BenStatus IS NOT NULL OR Con_CI30C_BenStatus IS NOT NULL OR 
                                        Con_CI15F_BenStatus IS NOT NULL OR Con_CI30F_BenStatus IS NOT NULL OR 
                                        Con_CI15S_BenStatus IS NOT NULL OR Con_CI30S_BenStatus IS NOT NULL THEN '4' 
                                    END
                                END
        ,drvEnrollmentStatus20 =    CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN CI15C_Code IS NOT NULL OR CI30C_Code IS NOT NULL OR 
                                            CI15F_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR 
                                            CI15S_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN 'P' 
                                        END
                                    ELSE
                                            CASE WHEN Con_CI15C_BenStatus IS NOT NULL OR Con_CI30C_BenStatus IS NOT NULL OR 
                                            Con_CI15F_BenStatus IS NOT NULL OR Con_CI30F_BenStatus IS NOT NULL OR 
                                            Con_CI15S_BenStatus IS NOT NULL OR Con_CI30S_BenStatus IS NOT NULL THEN 'P' 
                                        END
                                    END
        ,drvBenefitAmount20 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN CI15C_Code IS NOT NULL OR CI15F_Code IS NOT NULL OR CI15S_Code IS NOT NULL THEN '00007500' 
                                        WHEN CI30C_Code IS NOT NULL OR CI30F_Code IS NOT NULL OR CI30S_Code IS NOT NULL THEN '00015000' 
                                    END
                                ELSE
                                    CASE WHEN Con_CI15C_BenStatus IS NOT NULL OR Con_CI15F_BenStatus IS NOT NULL OR Con_CI15S_BenStatus IS NOT NULL THEN '00007500' 
                                        WHEN Con_CI30C_BenStatus IS NOT NULL OR Con_CI30F_BenStatus IS NOT NULL OR Con_CI30S_BenStatus IS NOT NULL THEN    '00015000' 
                                    END
                                END
        ,drvCoverageCode23 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN ACCHI_Code IS NOT NULL OR ACCLO_Code IS NOT NULL THEN 'AH' END
                                ELSE
                                    CASE WHEN Con_ACCHI_BenStatus IS NOT NULL OR Con_ACCLO_BenStatus IS NOT NULL THEN 'AH' END
                                END
        ,drvStartDate23 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN ACCHI_Code IS NOT NULL THEN ACCHI_StartDate
                                    WHEN ACCLO_Code IS NOT NULL THEN ACCLO_StartDate 
                                END
                            ELSE
                                CASE WHEN Con_ACCHI_BenStatus IS NOT NULL THEN ACCHI_StartDate
                                    WHEN Con_ACCLO_BenStatus IS NOT NULL THEN ACCLO_StartDate 
                                END
                            END
        ,drvStopDate23 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN ACCHI_Code IS NOT NULL THEN ACCHI_StopDate
                                    WHEN ACCLO_Code IS NOT NULL THEN ACCLO_StopDate 
                                END
                            ELSE
                                CASE WHEN Con_ACCHI_BenStatus IS NOT NULL THEN ACCHI_StopDate
                                    WHEN Con_ACCLO_BenStatus IS NOT NULL THEN ACCLO_StopDate 
                                END
                            END
        ,drvGroupNo23 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN ACCHI_Code IS NOT NULL OR ACCLO_Code IS NOT NULL THEN '0213662' END
                        ELSE
                            CASE WHEN Con_ACCHI_BenStatus IS NOT NULL OR Con_ACCLO_BenStatus IS NOT NULL THEN '0213662' END
                        END
        ,drvSubcode23 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN ACCHI_Code IS NOT NULL OR ACCLO_Code IS NOT NULL THEN '0001' END
                        ELSE
                            CASE WHEN Con_ACCHI_BenStatus IS NOT NULL OR Con_ACCLO_BenStatus IS NOT NULL THEN '0001' END
                        END
        ,drvBranch23 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN ACCHI_Code IS NOT NULL THEN '0001'
                                WHEN ACCLO_Code IS NOT NULL THEN '0003'
                            END
                        ELSE
                            CASE WHEN Con_ACCHI_BenStatus IS NOT NULL THEN '0001'
                                WHEN Con_ACCLO_BenStatus IS NOT NULL THEN '0003'
                            END
                        END
        ,drvMemberCoverCode23 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN ACCHI_Code IS NOT NULL OR ACCLO_Code IS NOT NULL THEN
                                        CASE WHEN ACCHI_BenOption = 'EE' OR ACCLO_BenOption = 'EE' THEN '1'
                                            WHEN ACCHI_BenOption = 'EEF' OR ACCLO_BenOption = 'EEF' THEN '4'
                                            WHEN ACCHI_BenOption = 'EEC' OR ACCLO_BenOption = 'EEC' THEN '2'
                                            WHEN ACCHI_BenOption = 'EES' OR ACCLO_BenOption = 'EES' THEN '3'
                                        END
                                    END
                                ELSE
                                        CASE WHEN Con_ACCHI_BenStatus IS NOT NULL OR Con_ACCLO_BenStatus IS NOT NULL THEN
                                        CASE WHEN ACCHI_BenOption = 'EE' OR ACCLO_BenOption = 'EE' THEN '1'
                                            WHEN ACCHI_BenOption = 'EEF' OR ACCLO_BenOption = 'EEF' THEN '4'
                                            WHEN ACCHI_BenOption = 'EEC' OR ACCLO_BenOption = 'EEC' THEN '2'
                                            WHEN ACCHI_BenOption = 'EES' OR ACCLO_BenOption = 'EES' THEN '3'
                                        END
                                    END
                                END
        ,drvEnrollmentStatus23 = CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN ACCHI_Code IS NOT NULL OR ACCLO_Code IS NOT NULL THEN 'P' END
                                ELSE
                                    CASE WHEN Con_ACCHI_BenStatus IS NOT NULL OR Con_ACCLO_BenStatus IS NOT NULL THEN 'P' END
                                END
        ,drvVoluntaryCancelInd23 =    CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN ACCHI_Code IS NOT NULL AND EecEmplStatus = 'A' AND ACCHI_BenStatus <> 'A' THEN 'CE'
                                            WHEN ACCLO_Code IS NOT NULL AND EecEmplStatus = 'A' AND ACCLO_BenStatus <> 'A' THEN 'CE'
                                        END
                                    END
        ,drvCoverageCode24 =    CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE WHEN HOSH_Code IS NOT NULL OR HOSLO_Code IS NOT NULL THEN 'HH' END
                                ELSE
                                    CASE WHEN Con_HOSH_BenStatus IS NOT NULL OR Con_HOSLO_BenStatus IS NOT NULL THEN 'HH' END
                                END
        ,drvStartDate24 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN HOSH_Code IS NOT NULL THEN HOSH_StartDate
                                    WHEN HOSLO_Code IS NOT NULL THEN HOSLO_StartDate
                                END
                            ELSE
                                CASE WHEN Con_HOSH_BenStatus IS NOT NULL THEN HOSH_StartDate
                                    WHEN Con_HOSLO_BenStatus IS NOT NULL THEN HOSLO_StartDate
                                END
                            END
        ,drvStopDate24 =    CASE WHEN BdmRecType = 'EMP' THEN
                                CASE WHEN HOSH_Code IS NOT NULL THEN HOSH_StopDate
                                    WHEN HOSLO_Code IS NOT NULL THEN HOSLO_StopDate
                                END
                            ELSE
                                CASE WHEN Con_HOSH_BenStatus IS NOT NULL THEN HOSH_StopDate
                                    WHEN Con_HOSLO_BenStatus IS NOT NULL THEN HOSLO_StopDate
                                END
                            END
        ,drvGroupNo24 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN HOSH_Code IS NOT NULL OR HOSLO_Code IS NOT NULL THEN '0213663' END
                        ELSE
                            CASE WHEN Con_HOSH_BenStatus IS NOT NULL OR Con_HOSLO_BenStatus IS NOT NULL THEN '0213663' END
                        END
        ,drvSubcode24 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN HOSH_Code IS NOT NULL OR HOSLO_Code IS NOT NULL THEN '0001' END
                        ELSE
                            CASE WHEN Con_HOSH_BenStatus IS NOT NULL OR Con_HOSLO_BenStatus IS NOT NULL THEN '0001' END
                        END
        ,drvBranch24 =    CASE WHEN BdmRecType = 'EMP' THEN
                            CASE WHEN HOSH_Code IS NOT NULL THEN '0001'
                                WHEN HOSLO_Code IS NOT NULL THEN '0003'
                            END
                        ELSE
                            CASE WHEN Con_HOSH_BenStatus IS NOT NULL THEN '0001'
                                WHEN Con_HOSLO_BenStatus IS NOT NULL THEN '0003'
                            END
                        END
        ,drvMemberCoverCode24 =    CASE WHEN HOSH_Code IS NOT NULL OR HOSLO_Code IS NOT NULL OR Con_HOSH_BenStatus IS NOT NULL OR Con_HOSLO_BenStatus IS NOT NULL THEN 
                                    CASE WHEN HOSH_BenOption = 'EE' OR HOSLO_BenOption = 'EE' THEN '1'
                                        WHEN HOSH_BenOption = 'EEF' OR HOSLO_BenOption = 'EEF' THEN '4'
                                        WHEN HOSH_BenOption = 'EEC' OR HOSLO_BenOption = 'EEC' THEN '2'
                                        WHEN HOSH_BenOption = 'EES' OR HOSLO_BenOption = 'EES' THEN '3'
                                    END
                                END
        ,drvEnrollmentStatus24 = CASE WHEN HOSH_Code IS NOT NULL OR HOSLO_Code IS NOT NULL OR Con_HOSH_BenStatus IS NOT NULL OR Con_HOSLO_BenStatus IS NOT NULL THEN 'P' END
        ,drvVoluntaryCancelInd24 =    CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN HOSH_Code IS NOT NULL AND EecEmplStatus = 'A' AND HOSH_BenStatus <> 'A' THEN 'CE'
                                            WHEN HOSLO_Code IS NOT NULL AND EecEmplStatus = 'A' AND HOSLO_BenStatus <> 'A' THEN 'CE'
                                        END                                    
                                    END
    INTO dbo.U_EMETLIFEEX_drvTbl
    FROM dbo.U_EMETLIFEEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN (SELECT DISTINCT BdmEEID, BdmCOID, BdmRecType, BdmDepRecID FROM dbo.U_dsi_BDM_EMETLIFEEX) AS BdmCon
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    JOIN (    SELECT BdmEEID AS BenEEID, BdmCOID AS BenCOID
                ,MAX(CASE WHEN BdmDedCode = 'ACCHI' THEN BdmDedCode END) AS ACCHI_Code
                ,MAX(CASE WHEN BdmDedCode = 'ACCLO' THEN BdmDedCode END) AS ACCLO_Code
                ,MAX(CASE WHEN BdmDedCode = 'CI15C' THEN BdmDedCode END) AS CI15C_Code 
                ,MAX(CASE WHEN BdmDedCode = 'CI15E' THEN BdmDedCode END) AS CI15E_Code 
                ,MAX(CASE WHEN BdmDedCode = 'CI15F' THEN BdmDedCode END) AS CI15F_Code
                ,MAX(CASE WHEN BdmDedCode = 'CI15S' THEN BdmDedCode END) AS CI15S_Code
                ,MAX(CASE WHEN BdmDedCode = 'CI30C' THEN BdmDedCode END) AS CI30C_Code
                ,MAX(CASE WHEN BdmDedCode = 'CI30F' THEN BdmDedCode END) AS CI30F_Code
                ,MAX(CASE WHEN BdmDedCode = 'CI30E' THEN BdmDedCode END) AS CI30E_Code
                ,MAX(CASE WHEN BdmDedCode = 'CI30S' THEN BdmDedCode END) AS CI30S_Code
                ,MAX(CASE WHEN BdmDedCode = 'HOSH' THEN BdmDedCode END) AS HOSH_Code
                ,MAX(CASE WHEN BdmDedCode = 'HOSLO' THEN BdmDedCode END) AS HOSLO_Code
                ,MAX(CASE WHEN BdmDedCode = 'DM100' THEN BdmDedCode END) AS DM100_Code
                ,MAX(CASE WHEN BdmDedCode = 'DML10' THEN BdmDedCode END) AS DML10_Code
                ,MAX(CASE WHEN BdmDedCode = 'DML20' THEN BdmDedCode END) AS DML20_Code
                ,MAX(CASE WHEN BdmDedCode = 'DML40' THEN BdmDedCode END) AS DML40_Code
                ,MAX(CASE WHEN BdmDedCode = 'DML50' THEN BdmDedCode END) AS DML50_Code
                ,MAX(CASE WHEN BdmDedCode = 'DML5K' THEN BdmDedCode END) AS DML5K_Code
                ,MAX(CASE WHEN BdmDedCode = 'DMLCH' THEN BdmDedCode END) AS DMLCH_Code
                ,MAX(CASE WHEN BdmDedCode = 'DSL10' THEN BdmDedCode END) AS DSL10_Code
                ,MAX(CASE WHEN BdmDedCode = 'DSL20' THEN BdmDedCode END) AS DSL20_Code
                ,MAX(CASE WHEN BdmDedCode = 'DSL25' THEN BdmDedCode END) AS DSL25_Code
                ,MAX(CASE WHEN BdmDedCode = 'DSL50' THEN BdmDedCode END) AS DSL50_Code
                ,MAX(CASE WHEN BdmDedCode = 'MET20' THEN BdmDedCode END) AS MET20_Code
                ,MAX(CASE WHEN BdmDedCode = 'MET23' THEN BdmDedCode END) AS MET23_Code
                ,MAX(CASE WHEN BdmDedCode = 'MET24' THEN BdmDedCode END) AS MET24_Code
                ,MAX(CASE WHEN BdmDedCode = 'MET25' THEN BdmDedCode END) AS MET25_Code
                ,MAX(CASE WHEN BdmDedCode = 'MET38' THEN BdmDedCode END) AS MET38_Code
                ,MAX(CASE WHEN BdmDedCode = 'METL1' THEN BdmDedCode END) AS METL1_Code
                ,MAX(CASE WHEN BdmDedCode = 'METL2' THEN BdmDedCode END) AS METL2_Code
                ,MAX(CASE WHEN BdmDedCode = 'METL4' THEN BdmDedCode END) AS METL4_Code
                ,MAX(CASE WHEN BdmDedCode = 'METL5' THEN BdmDedCode END) AS METL5_Code
                ,MAX(CASE WHEN BdmDedCode = 'METL6' THEN BdmDedCode END) AS METL6_Code
                ,MAX(CASE WHEN BdmDedCode = 'METL7' THEN BdmDedCode END) AS METL7_Code
                ,MAX(CASE WHEN BdmDedCode = 'METL8' THEN BdmDedCode END) AS METL8_Code
                ,MAX(CASE WHEN BdmDedCode = 'METLC' THEN BdmDedCode END) AS METLC_Code
                ,MAX(CASE WHEN BdmDedCode = 'SP100' THEN BdmDedCode END) AS SP100_Code
                ,MAX(CASE WHEN BdmDedCode = 'SPL10' THEN BdmDedCode END) AS SPL10_Code
                ,MAX(CASE WHEN BdmDedCode = 'SPL20' THEN BdmDedCode END) AS SPL20_Code
                ,MAX(CASE WHEN BdmDedCode = 'SPL25' THEN BdmDedCode END) AS SPL25_Code
                ,MAX(CASE WHEN BdmDedCode = 'SPL30' THEN BdmDedCode END) AS SPL30_Code
                ,MAX(CASE WHEN BdmDedCode = 'SPL40' THEN BdmDedCode END) AS SPL40_Code
                ,MAX(CASE WHEN BdmDedCode = 'SPL50' THEN BdmDedCode END) AS SPL50_Code
                ,MAX(CASE WHEN BdmDedCode = 'SPL60' THEN BdmDedCode END) AS SPL60_Code
                ,MAX(CASE WHEN BdmDedCode = 'MET30' THEN BdmDedCode END) AS MET30_Code
                ,MAX(CASE WHEN BdmDedCode = 'MET35' THEN BdmDedCode END) AS MET35_Code
                ,MAX(CASE WHEN BdmDedCode = 'MET40' THEN BdmDedCode END) AS MET40_Code
                ,MAX(CASE WHEN BdmDedCode = 'MET45' THEN BdmDedCode END) AS MET45_Code
                ,MAX(CASE WHEN BdmDedCode = 'MET50' THEN BdmDedCode END) AS MET50_Code    
                ,MAX(CASE WHEN BdmDedCode = 'METNB' THEN BdmDedCode END) AS METNB_Code            -- JCB     
                ,MAX(CASE WHEN BdmDedCode = 'ACCHI' THEN BdmBenStartDate END) AS ACCHI_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'ACCLO' THEN BdmBenStartDate END) AS ACCLO_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'CI15E' THEN BdmBenStartDate END) AS CI15E_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'CI15C' THEN BdmBenStartDate END) AS CI15C_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'CI15F' THEN BdmBenStartDate END) AS CI15F_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'CI15S' THEN BdmBenStartDate END) AS CI15S_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'CI30C' THEN BdmBenStartDate END) AS CI30C_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'CI30E' THEN BdmBenStartDate END) AS CI30E_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'CI30F' THEN BdmBenStartDate END) AS CI30F_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'CI30S' THEN BdmBenStartDate END) AS CI30S_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'HOSH' THEN BdmBenStartDate END) AS HOSH_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'HOSLO' THEN BdmBenStartDate END) AS HOSLO_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DM100' THEN BdmBenStartDate END) AS DM100_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DML10' THEN BdmBenStartDate END) AS DML10_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DML20' THEN BdmBenStartDate END) AS DML20_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DML40' THEN BdmBenStartDate END) AS DML40_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DML50' THEN BdmBenStartDate END) AS DML50_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DML5K' THEN BdmBenStartDate END) AS DML5K_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DMLCH' THEN BdmBenStartDate END) AS DMLCH_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'METNB' THEN BdmBenStartDate END) AS METNB_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DSL10' THEN BdmBenStartDate END) AS DSL10_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DSL20' THEN BdmBenStartDate END) AS DSL20_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DSL25' THEN BdmBenStartDate END) AS DSL25_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'DSL50' THEN BdmBenStartDate END) AS DSL50_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'MET20' THEN BdmBenStartDate END) AS MET20_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'MET23' THEN BdmBenStartDate END) AS MET23_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'MET24' THEN BdmBenStartDate END) AS MET24_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'MET25' THEN BdmBenStartDate END) AS MET25_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'MET38' THEN BdmBenStartDate END) AS MET38_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'METL1' THEN BdmBenStartDate END) AS METL1_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'METL2' THEN BdmBenStartDate END) AS METL2_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'METL4' THEN BdmBenStartDate END) AS METL4_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'METL5' THEN BdmBenStartDate END) AS METL5_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'METL6' THEN BdmBenStartDate END) AS METL6_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'METL7' THEN BdmBenStartDate END) AS METL7_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'METL8' THEN BdmBenStartDate END) AS METL8_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'METLC' THEN BdmBenStartDate END) AS METLC_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'SP100' THEN BdmBenStartDate END) AS SP100_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL10' THEN BdmBenStartDate END) AS SPL10_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL20' THEN BdmBenStartDate END) AS SPL20_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL25' THEN BdmBenStartDate END) AS SPL25_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL30' THEN BdmBenStartDate END) AS SPL30_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL40' THEN BdmBenStartDate END) AS SPL40_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL50' THEN BdmBenStartDate END) AS SPL50_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL60' THEN BdmBenStartDate END) AS SPL60_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'MET30' THEN BdmBenStartDate END) AS MET30_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'MET35' THEN BdmBenStartDate END) AS MET35_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'MET40' THEN BdmBenStartDate END) AS MET40_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'MET45' THEN BdmBenStartDate END) AS MET45_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'MET50' THEN BdmBenStartDate END) AS MET50_StartDate
                ,MAX(CASE WHEN BdmDedCode = 'ACCHI' THEN BdmBenStopDate END) AS ACCHI_StopDate 
                ,MAX(CASE WHEN BdmDedCode = 'ACCLO' THEN BdmBenStopDate END) AS ACCLO_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'CI15C' THEN BdmBenStopDate END) AS CI15C_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'CI15E' THEN BdmBenStopDate END) AS CI15E_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'CI15F' THEN BdmBenStopDate END) AS CI15F_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'CI15S' THEN BdmBenStopDate END) AS CI15S_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'CI30C' THEN BdmBenStopDate END) AS CI30C_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'CI30E' THEN BdmBenStopDate END) AS CI30E_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'CI30F' THEN BdmBenStopDate END) AS CI30F_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'CI30S' THEN BdmBenStopDate END) AS CI30S_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'HOSH' THEN BdmBenStopDate END) AS HOSH_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'HOSLO' THEN BdmBenStopDate END) AS HOSLO_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DM100' THEN BdmBenStopDate END) AS DM100_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DML10' THEN BdmBenStopDate END) AS DML10_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DML20' THEN BdmBenStopDate END) AS DML20_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DML40' THEN BdmBenStopDate END) AS DML40_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DML50' THEN BdmBenStopDate END) AS DML50_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DML5K' THEN BdmBenStopDate END) AS DML5K_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DMLCH' THEN BdmBenStopDate END) AS DMLCH_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'METNB' THEN BdmBenStopDate END) AS METNB_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DSL10' THEN BdmBenStopDate END) AS DSL10_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DSL20' THEN BdmBenStopDate END) AS DSL20_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DSL25' THEN BdmBenStopDate END) AS DSL25_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'DSL50' THEN BdmBenStopDate END) AS DSL50_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'MET20' THEN BdmBenStopDate END) AS MET20_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'MET23' THEN BdmBenStopDate END) AS MET23_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'MET24' THEN BdmBenStopDate END) AS MET24_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'MET25' THEN BdmBenStopDate END) AS MET25_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'MET38' THEN BdmBenStopDate END) AS MET38_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'METL1' THEN BdmBenStopDate END) AS METL1_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'METL2' THEN BdmBenStopDate END) AS METL2_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'METL4' THEN BdmBenStopDate END) AS METL4_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'METL5' THEN BdmBenStopDate END) AS METL5_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'METL6' THEN BdmBenStopDate END) AS METL6_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'METL7' THEN BdmBenStopDate END) AS METL7_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'METL8' THEN BdmBenStopDate END) AS METL8_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'METLC' THEN BdmBenStopDate END) AS METLC_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'SP100' THEN BdmBenStopDate END) AS SP100_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL10' THEN BdmBenStopDate END) AS SPL10_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL20' THEN BdmBenStopDate END) AS SPL20_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL25' THEN BdmBenStopDate END) AS SPL25_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL30' THEN BdmBenStopDate END) AS SPL30_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL40' THEN BdmBenStopDate END) AS SPL40_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL50' THEN BdmBenStopDate END) AS SPL50_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'SPL60' THEN BdmBenStopDate END) AS SPL60_StopDate 
                ,MAX(CASE WHEN BdmDedCode = 'MET30' THEN BdmBenStopDate END) AS MET30_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'MET35' THEN BdmBenStopDate END) AS MET35_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'MET40' THEN BdmBenStopDate END) AS MET40_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'MET45' THEN BdmBenStopDate END) AS MET45_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'MET50' THEN BdmBenStopDate END) AS MET50_StopDate
                ,MAX(CASE WHEN BdmDedCode = 'HOSH' THEN BdmEEAmt END) AS HOSH_BenAmt 
                ,MAX(CASE WHEN BdmDedCode = 'HOSLO' THEN BdmEEAmt END) AS HOSLO_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DM100' THEN BdmEEAmt END) AS DM100_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DML10' THEN BdmEEAmt END) AS DML10_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DML20' THEN BdmEEAmt END) AS DML20_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DML40' THEN BdmEEAmt END) AS DML40_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DML50' THEN BdmEEAmt END) AS DML50_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DML5K' THEN BdmEEAmt END) AS DML5K_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DMLCH' THEN BdmEEAmt END) AS DMLCH_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DSL10' THEN BdmEEAmt END) AS DSL10_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DSL20' THEN BdmEEAmt END) AS DSL20_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DSL25' THEN BdmEEAmt END) AS DSL25_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'DSL50' THEN BdmEEAmt END) AS DSL50_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'MET20' THEN BdmEEAmt END) AS MET20_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'MET23' THEN BdmEEAmt END) AS MET23_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'MET24' THEN BdmEEAmt END) AS MET24_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'MET25' THEN BdmEEAmt END) AS MET25_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'MET38' THEN BdmEEAmt END) AS MET38_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'METL1' THEN BdmEEAmt END) AS METL1_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'METL2' THEN BdmEEAmt END) AS METL2_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'METL4' THEN BdmEEAmt END) AS METL4_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'METL5' THEN BdmEEAmt END) AS METL5_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'METL6' THEN BdmEEAmt END) AS METL6_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'METL7' THEN BdmEEAmt END) AS METL7_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'METL8' THEN BdmEEAmt END) AS METL8_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'METLC' THEN BdmEEAmt END) AS METLC_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'SP100' THEN BdmEEAmt END) AS SP100_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'SPL10' THEN BdmEEAmt END) AS SPL10_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'SPL20' THEN BdmEEAmt END) AS SPL20_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'SPL25' THEN BdmEEAmt END) AS SPL25_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'SPL30' THEN BdmEEAmt END) AS SPL30_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'SPL40' THEN BdmEEAmt END) AS SPL40_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'SPL50' THEN BdmEEAmt END) AS SPL50_BenAmt
                ,MAX(CASE WHEN BdmDedCode = 'SPL60' THEN BdmEEAmt END) AS SPL60_BenAmt                
                ,MAX(CASE WHEN BdmDedCode = 'ACCHI' THEN BdmBenOption END) AS ACCHI_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'ACCLO' THEN BdmBenOption END) AS ACCLO_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'HOSH' THEN BdmBenOption END) AS HOSH_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'HOSLO' THEN BdmBenOption END) AS HOSLO_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DM100' THEN BdmBenOption END) AS DM100_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DML10' THEN BdmBenOption END) AS DML10_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DML20' THEN BdmBenOption END) AS DML20_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DML40' THEN BdmBenOption END) AS DML40_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DML50' THEN BdmBenOption END) AS DML50_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DML5K' THEN BdmBenOption END) AS DML5K_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DMLCH' THEN BdmBenOption END) AS DMLCH_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DSL10' THEN BdmBenOption END) AS DSL10_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DSL20' THEN BdmBenOption END) AS DSL20_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DSL25' THEN BdmBenOption END) AS DSL25_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'DSL50' THEN BdmBenOption END) AS DSL50_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'MET20' THEN BdmBenOption END) AS MET20_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'MET23' THEN BdmBenOption END) AS MET23_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'MET24' THEN BdmBenOption END) AS MET24_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'MET25' THEN BdmBenOption END) AS MET25_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'MET38' THEN BdmBenOption END) AS MET38_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'METL1' THEN BdmBenOption END) AS METL1_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'METL2' THEN BdmBenOption END) AS METL2_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'METL4' THEN BdmBenOption END) AS METL4_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'METL5' THEN BdmBenOption END) AS METL5_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'METL6' THEN BdmBenOption END) AS METL6_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'METL7' THEN BdmBenOption END) AS METL7_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'METL8' THEN BdmBenOption END) AS METL8_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'METLC' THEN BdmBenOption END) AS METLC_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'METNB' THEN BdmBenOption END) AS METNB_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'SP100' THEN BdmBenOption END) AS SP100_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'SPL10' THEN BdmBenOption END) AS SPL10_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'SPL20' THEN BdmBenOption END) AS SPL20_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'SPL25' THEN BdmBenOption END) AS SPL25_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'SPL30' THEN BdmBenOption END) AS SPL30_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'SPL40' THEN BdmBenOption END) AS SPL40_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'SPL50' THEN BdmBenOption END) AS SPL50_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'SPL60' THEN BdmBenOption END) AS SPL60_BenOption
                ,MAX(CASE WHEN BdmDedCode = 'ACCHI' THEN BdmBenStatus END) AS ACCHI_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'ACCLO' THEN BdmBenStatus END) AS ACCLO_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'HOSH' THEN BdmBenStatus END) AS HOSH_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'HOSLO' THEN BdmBenStatus END) AS HOSLO_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DM100' THEN BdmBenStatus END) AS DM100_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DML10' THEN BdmBenStatus END) AS DML10_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DML20' THEN BdmBenStatus END) AS DML20_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DML40' THEN BdmBenStatus END) AS DML40_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DML50' THEN BdmBenStatus END) AS DML50_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DML5K' THEN BdmBenStatus END) AS DML5K_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DMLCH' THEN BdmBenStatus END) AS DMLCH_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DSL10' THEN BdmBenStatus END) AS DSL10_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DSL20' THEN BdmBenStatus END) AS DSL20_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DSL25' THEN BdmBenStatus END) AS DSL25_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'DSL50' THEN BdmBenStatus END) AS DSL50_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'MET20' THEN BdmBenStatus END) AS MET20_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'MET23' THEN BdmBenStatus END) AS MET23_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'MET24' THEN BdmBenStatus END) AS MET24_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'MET25' THEN BdmBenStatus END) AS MET25_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'MET38' THEN BdmBenStatus END) AS MET38_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'METL1' THEN BdmBenStatus END) AS METL1_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'METL2' THEN BdmBenStatus END) AS METL2_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'METL4' THEN BdmBenStatus END) AS METL4_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'METL5' THEN BdmBenStatus END) AS METL5_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'METL6' THEN BdmBenStatus END) AS METL6_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'METL7' THEN BdmBenStatus END) AS METL7_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'METL8' THEN BdmBenStatus END) AS METL8_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'METLC' THEN BdmBenStatus END) AS METLC_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'SP100' THEN BdmBenStatus END) AS SP100_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'SPL10' THEN BdmBenStatus END) AS SPL10_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'SPL20' THEN BdmBenStatus END) AS SPL20_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'SPL25' THEN BdmBenStatus END) AS SPL25_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'SPL30' THEN BdmBenStatus END) AS SPL30_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'SPL40' THEN BdmBenStatus END) AS SPL40_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'SPL50' THEN BdmBenStatus END) AS SPL50_BenStatus
                ,MAX(CASE WHEN BdmDedCode = 'SPL60' THEN BdmBenStatus END) AS SPL60_BenStatus    
                ,MAX(CASE WHEN BdmDedCode = 'CI15C' THEN BdmBenStatus END) AS CI15C_BenStatus 
                ,MAX(CASE WHEN BdmDedCode = 'CI30C' THEN BdmBenStatus END) AS CI30C_BenStatus                 
                ,MAX(CASE WHEN BdmDedCode = 'CI15E' THEN BdmBenStatus END) AS CI15E_BenStatus 
                ,MAX(CASE WHEN BdmDedCode = 'CI30E' THEN BdmBenStatus END) AS CI30E_BenStatus                 
                ,MAX(CASE WHEN BdmDedCode = 'CI15F' THEN BdmBenStatus END) AS CI15F_BenStatus 
                ,MAX(CASE WHEN BdmDedCode = 'CI30F' THEN BdmBenStatus END) AS CI30F_BenStatus                 
                ,MAX(CASE WHEN BdmDedCode = 'CI15S' THEN BdmBenStatus END) AS CI15S_BenStatus 
                ,MAX(CASE WHEN BdmDedCode = 'CI30S' THEN BdmBenStatus END) AS CI30S_BenStatus            
            FROM dbo.U_dsi_BDM_EMETLIFEEX WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID) as Bdm_Consolidated
        ON BenEEID = xEEID
        AND BenCOID = xCOID
    --JOIN dbo.U_dsi_BDM_EMETLIFEEX WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    --LEFT JOIN dbo.Contacts WITH (NOLOCK)
    --    ON ConEEID = xEEID
    --    AND ConSystemId = BdmDepRecId
    LEFT JOIN ( select ConEEID, ConNameLast, ConNameFirst, ConNameMiddle, ConDateOfBirth, ConRelationShip, ConGender 
                    ,MAX(CASE WHEN BdmDedCode = 'DSL10' THEN BdmBenStatus END) AS Con_DSL10_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'DSL20' THEN BdmBenStatus END) AS Con_DSL20_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'DSL25' THEN BdmBenStatus END) AS Con_DSL25_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'DSL50' THEN BdmBenStatus END) AS Con_DSL50_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'SP100' THEN BdmBenStatus END) AS Con_SP100_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'SPL10' THEN BdmBenStatus END) AS Con_SPL10_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'SPL20' THEN BdmBenStatus END) AS Con_SPL20_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'SPL25' THEN BdmBenStatus END) AS Con_SPL25_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'SPL30' THEN BdmBenStatus END) AS Con_SPL30_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'SPL40' THEN BdmBenStatus END) AS Con_SPL40_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'SPL50' THEN BdmBenStatus END) AS Con_SPL50_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'SPL60' THEN BdmBenStatus END) AS Con_SPL60_BenStatus 
                    ,MAX(CASE WHEN BdmDedCode = 'METLC' THEN BdmBenStatus END) AS Con_METLC_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'DMLCH' THEN BdmBenStatus END) AS Con_DMLCH_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'CI15C' THEN BdmBenStatus END) AS Con_CI15C_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'CI30C' THEN BdmBenStatus END) AS Con_CI30C_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'CI15F' THEN BdmBenStatus END) AS Con_CI15F_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'CI30F' THEN BdmBenStatus END) AS Con_CI30F_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'CI15S' THEN BdmBenStatus END) AS Con_CI15S_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'CI30S' THEN BdmBenStatus END) AS Con_CI30S_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'ACCHI' THEN BdmBenStatus END) AS Con_ACCHI_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'ACCLO' THEN BdmBenStatus END) AS Con_ACCLO_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'HOSH' THEN BdmBenStatus END) AS Con_HOSH_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'HOSLO' THEN BdmBenStatus END) AS Con_HOSLO_BenStatus
                    ,MAX(CASE WHEN BdmDedCode = 'METNB' THEN BdmBenStatus END) AS Con_METNB_BenStatus -- JCB
                from dbo.Contacts WITH (NOLOCK)
                join dbo.U_dsi_BDM_EMETLIFEEX WITH (NOLOCK)
                    ON ConEEID = BdmEEID
                    AND ConSystemId = BdmDepRecId
                --Where BdmEEID = 'BNBWIG00W0K0'
                GROUP BY ConEEID, ConNameLast, ConNameFirst, ConNameMiddle, ConDateOfBirth, ConRelationShip, ConGender) AS Con_Deductions
        ON ConEEID = xEEID
    LEFT JOIN dbo.U_EMETLIFEEX_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    ;

    --'ACCHI,ACCLO,CI15C,CI15F,CI15S,CI30C,CI30F,CI30S,HOSH,HOSLO,ACCHI,ACCLO,DM100,DML10,DML20,DML40,DML50,DML5K,DMLCH,DSL10,DSL20,DSL25,DSL50,MET20,MET23,MET24,MET25,MET38,METL1,METL2,METL4,METL5,METL6,METL7,METL8,METLC,SP100,SPL10,SPL20,SPL25,SPL30,SPL40,SPL50,SPL60';

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
ALTER VIEW dbo.dsi_vwEMETLIFEEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMETLIFEEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMETLIFEEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001211'
       ,expStartPerControl     = '202001211'
       ,expLastEndPerControl   = '202001289'
       ,expEndPerControl       = '202001289'
WHERE expFormatCode = 'EMETLIFEEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMETLIFEEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMETLIFEEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort